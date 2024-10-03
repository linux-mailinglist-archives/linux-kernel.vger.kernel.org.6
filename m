Return-Path: <linux-kernel+bounces-348561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C91998E90D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 06:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F5D1F242D2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 04:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AC12E419;
	Thu,  3 Oct 2024 04:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=c4.cz header.i=@c4.cz header.b="DGsVUMGD"
Received: from smtp-5.skok.cz (smtp-5.skok.cz [77.78.76.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220C015C0;
	Thu,  3 Oct 2024 04:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.78.76.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727928668; cv=none; b=ksezCelu3oklOUH5FyvYgHJYqiqaLOqILTehc2AfrLmevlakVcWI8vLo3ChzM6Kc9lnsLp7RlFh5CUdD4ncx0FbWehh5l5GWWUjdrX5k4Y6itVZjem4fwlSKPKQ5FJ1YxpSO6bFDCM3xVxMOLAfkzjk/uQWo75weTj27PGTjMeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727928668; c=relaxed/simple;
	bh=8ku+Dn5ie5RWjcmfnePjA9MnxzUnlG9sZPxB3fzs/+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lw5qDOGegK4riUIOg0x68cG/DxehZ1S3Q9O5OgnA3mtHlucgCFZ4oY9hhpzR7tDEjJaOSdxG/0XFNQudKoiAecXHAFpui2KBW9yvDfMgIpjZrH4/kWneqeRMSmb+VPUZZhH7Sl6ZZW0scuWCTd0p//EZck+bBxxWgZos984Z9iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c4.cz; spf=pass smtp.mailfrom=c4.cz; dkim=pass (1024-bit key) header.d=c4.cz header.i=@c4.cz header.b=DGsVUMGD; arc=none smtp.client-ip=77.78.76.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c4.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c4.cz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=c4.cz; s=ceskywebhosting;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From; bh=zmc7fJ5mxzNpbTEgG5wzzh60Xr2pYRcLMTcvZY+EgkY=;
	b=DGsVUMGDjqucGROTYM6plDniWX/01WwsGb4QTgZW7nZAo4DmRWV4vwol8bXWO/jowmjN3/wxCo0tXeg75qzolNq2CjyXhjLexJoK8J0oZjXMf6Kx0E4mH9q9sfNorejgbyKaCTxBW3dtL6CYW4Y3KFmQlYtsmt/RIFMEsWto9EM=;
Received: from pm1.skok.cz ([2001:1528:181::223:72] helo=localhost.localdomain)
	by smtp.skok.cz with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.84_2)
	(envelope-from <lalinsky@c4.cz>)
	id 1swCCL-00086T-MA; Thu, 03 Oct 2024 05:08:15 +0200
From: Jan Lalinsky <lalinsky@c4.cz>
To: perex@perex.cz
Cc: tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Lalinsky <lalinsky@c4.cz>
Subject: [PATCH] ALSA: usb-audio: Add native DSD support for Luxman D-08u
Date: Thu,  3 Oct 2024 05:08:11 +0200
Message-ID: <20241003030811.2655735-1-lalinsky@c4.cz>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add native DSD support for Luxman D-08u DAC, by adding the PID/VID 1852:5062.
This makes DSD playback work, and also sound quality when playing PCM files
is improved, crackling sounds are gone.

Signed-off-by: Jan Lalinsky <lalinsky@c4.cz>
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index c7a9c50a65bb..e6278a245795 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2221,6 +2221,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_DISABLE_AUTOSUSPEND),
 	DEVICE_FLG(0x17aa, 0x104d, /* Lenovo ThinkStation P620 Internal Speaker + Front Headset */
 		   QUIRK_FLAG_DISABLE_AUTOSUSPEND),
+	DEVICE_FLG(0x1852, 0x5062, /* Luxman D-08u */
+		   QUIRK_FLAG_ITF_USB_DSD_DAC | QUIRK_FLAG_CTL_MSG_DELAY),
 	DEVICE_FLG(0x1852, 0x5065, /* Luxman DA-06 */
 		   QUIRK_FLAG_ITF_USB_DSD_DAC | QUIRK_FLAG_CTL_MSG_DELAY),
 	DEVICE_FLG(0x1901, 0x0191, /* GE B850V3 CP2114 audio interface */
-- 
2.43.5


