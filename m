Return-Path: <linux-kernel+bounces-237184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E1B91ED27
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 04:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF451C22286
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 02:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9AF1758E;
	Tue,  2 Jul 2024 02:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b="D0JldWqW"
Received: from mail.kaechele.ca (mail.kaechele.ca [54.39.219.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E9A8C07;
	Tue,  2 Jul 2024 02:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.39.219.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719888996; cv=none; b=U85izVIdcoRglRpP7B3Eg9XQQWjL7SqIYASoFHWWvwc+873tUVMGNf4NZOSgJ43HtYMGST7sI3tFOso6/oxpnjzuyVLrliajDrkcIG8b6NBibs1TB7BNSfDFZUUWXoN5hASYFSO5wTaSZP5wmeuDg9ADDJQCOWw66veNC3mhwVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719888996; c=relaxed/simple;
	bh=g77ovSQ6miv4V8Y2/KK0rlQf539EJlRxT4BkAGWRZ3Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WYNzfyccO92qdqzuosngXk1YYPZ3EGWvZRaPmi6x7X3bAAD+DUlNPToUvDig/hp9ieBMqjZBlLmGSvsA3A1D0jE+jLb8yGNALdkoAz0xchXXIDec9kJvbQHjm2wtO8+EoIpyzh2VDdB8x8mrsRgSN6OKPWcO1FYXOC24AkFNFYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca; spf=pass smtp.mailfrom=kaechele.ca; dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b=D0JldWqW; arc=none smtp.client-ip=54.39.219.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaechele.ca
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 84207C005F;
	Mon,  1 Jul 2024 22:49:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaechele.ca; s=201907;
	t=1719888560; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding; bh=luv03lpnws4T7wkh4T7ewdycKUTmRCEz59nTd46EVRI=;
	b=D0JldWqWJh68EQ5jMmZSdriteHRCmoABj65ZDptpX933WkfmYnswH4ZioQCFjYKr0dQnPl
	0833ponbKUYzCUJtwGrCt3Pape/3AMCTmlK+7X0wBRT7ddRPaNHYIldBxdAV/hvvzi9TiW
	heOvfA3QMeNKxR/PMADgirnCJGZspys=
From: Felix Kaechele <felix@kaechele.ca>
To: Daniel Beer <daniel.beer@igorinstitute.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: tas5805m: demystify DSP volume control coefficients
Date: Mon,  1 Jul 2024 22:46:54 -0400
Message-ID: <20240702024709.626009-1-felix@kaechele.ca>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The original manufacturer sample driver code uses direct DSP register
writes to control digital volume on this amplifier without further
context as to why it's not using the documented DIG_VOL_CTRL register.
A thread in the manufacturer's forums [1] suggests this might have been
done to work around volume ramping being used when controlling the volume
through the DIG_VOL_CTRL register. When volume is controlled through
this register, reading and/or writing any register is blocked until the
volume ramping has concluded and the setpoint is reached.

Additionally, the sample code uses a lookup table to map decibel values
to 9.23 formatted coefficients. For posterity, add references to where
this is documented and why a lookup table may be used.

Signed-off-by: Felix Kaechele <felix@kaechele.ca>

[1]: https://e2e.ti.com/support/audio-group/audio/f/audio-forum/1165952/tas5805m-linux-driver-for-tas58xx-family
---
 sound/soc/codecs/tas5805m.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tas5805m.c b/sound/soc/codecs/tas5805m.c
index 3b53eba38a0b..59536c8b8e38 100644
--- a/sound/soc/codecs/tas5805m.c
+++ b/sound/soc/codecs/tas5805m.c
@@ -67,6 +67,14 @@ static const uint8_t dsp_cfg_preboot[] = {
 	0x00, 0x00, 0x7f, 0x00, 0x03, 0x02,
 };
 
+/*
+ * Lookup table for DSP volume coefficients.
+ * The formula uses floating point math, so a lookup table is used
+ * instead of computing values on the fly.
+ * Formula: round(10^(volume in dB/20)*2^23)
+ * The 9.23 format used here is documented in
+ *   SLAA894 - "General Tuning Guide for TAS58xx Family"
+ */
 static const uint32_t tas5805m_volume[] = {
 	0x0000001B, /*   0, -110dB */ 0x0000001E, /*   1, -109dB */
 	0x00000021, /*   2, -108dB */ 0x00000025, /*   3, -107dB */
@@ -196,9 +204,13 @@ static void tas5805m_refresh(struct tas5805m_priv *tas5805m)
 	regmap_write(rm, REG_BOOK, 0x8c);
 	regmap_write(rm, REG_PAGE, 0x2a);
 
-	/* Refresh volume. The actual volume control documented in the
-	 * datasheet doesn't seem to work correctly. This is a pair of
-	 * DSP registers which are *not* documented in the datasheet.
+	/* Refresh volume. This writes the volume coefficients from
+	 * the lookup table directly into the DSP registers.
+	 * Digital volume control on this chip involves ramping which
+	 * blocks register reads and writes until the desired setpoint
+	 * is reached.
+	 * The DSP memory maps are documented in
+	 *   SLOA263A - "TAS5805M, TAS5806M and TAS5806MD Process Flows"
 	 */
 	set_dsp_scale(rm, 0x24, tas5805m->vol[0]);
 	set_dsp_scale(rm, 0x28, tas5805m->vol[1]);

base-commit: 9fa5527b19b21848dfb09928ee66af1aac4a5700
-- 
2.45.2


