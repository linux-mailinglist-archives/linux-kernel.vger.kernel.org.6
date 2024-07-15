Return-Path: <linux-kernel+bounces-252169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18564930F6E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4106C1C2127E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C23172BA6;
	Mon, 15 Jul 2024 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="hn6wI4sx"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF7FFC11
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721031461; cv=none; b=LOgN2DJC/y58g4JYAiKv8JW8wThTqIwPa3SWlRlr9h1f5FtRS3c/JQIFmeenEV2g62Gvpn+2f8k5ClsAPj+5PBkq5yy1sH0pYp/+sNxqVCTUPdJ72hKAePpZZQbyAjU9DMfRfOfnjKggRhPf4G1naKjT6J7RPdQ0RfPCg7NbTyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721031461; c=relaxed/simple;
	bh=Cfq1a/pPdczYnqv79VEDZBBGdhyPxQa10KLacgwgvUY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NPSqt+FfbS/vM8awYInogZxpEKQY2NHbOd4392FGtNXJEa3nTabi2cvHGjmTO1cO3Gq91kVb6AV7j3+bl+19ptso1TfWO67evQ7fPaGYhYm99QVOX6tP5Oei4njmd0x0uh371j+sR2garFTqpj5w0FM+autFz762Ig9+S/TvVG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=hn6wI4sx; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id A7B4024002A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:17:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1721031450; bh=Cfq1a/pPdczYnqv79VEDZBBGdhyPxQa10KLacgwgvUY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:From;
	b=hn6wI4sxtXG7WdmKRudSkPnqJOiqYRPNV4oObhA9ULqpMOyhoC8L4b3Q+k0BLEjfD
	 2yhgLeZ7mpdayoD0ZrSKSe+dlaFouxunT4xE/ArMoi+9GE7GjVohTDEZR/VwcQk0UE
	 gZkW38knp1QyMWV6yZFH9nfcm5U/ewSbL/uptoaV3eaDLLTpVhmZAkzQ3ZP6rXeS3O
	 5tOh8zzef9AsEQmhvmaTCUzxN1qeLjOPEae85mHF0hdk2YChaK5bwY2Y+4JzpOXJM2
	 3TqnLfjw7FhsdUCixnvMcSWEK547hJRsifdEw+p/sBSS+QXLownbK6njsvGQNijoBI
	 YkKTETwOhyfng==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4WMw6f0qdcz6tvZ;
	Mon, 15 Jul 2024 10:17:29 +0200 (CEST)
Date: Mon, 15 Jul 2024 08:17:28 +0000
From: Wilken Gottwalt <wilken.gottwalt@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH] mfd: ds1wm: remove remaining header
Message-ID: <ZpTbGHb6EX2Oe7ok@monster.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The driver was removed after kernel 6.2, keeping the header around
doesn't make much sense.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
---
 include/linux/mfd/ds1wm.h | 29 -----------------------------
 1 file changed, 29 deletions(-)
 delete mode 100644 include/linux/mfd/ds1wm.h

diff --git a/include/linux/mfd/ds1wm.h b/include/linux/mfd/ds1wm.h
deleted file mode 100644
index 43dfca1c9702..000000000000
--- a/include/linux/mfd/ds1wm.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* MFD cell driver data for the DS1WM driver
- *
- * to be defined in the MFD device that is
- * using this driver for one of his sub devices
- */
-
-struct ds1wm_driver_data {
-	int active_high;
-	int clock_rate;
-	/* in milliseconds, the amount of time to
-	 * sleep following a reset pulse. Zero
-	 * should work if your bus devices recover
-	 * time respects the 1-wire spec since the
-	 * ds1wm implements the precise timings of
-	 * a reset pulse/presence detect sequence.
-	 */
-	unsigned int reset_recover_delay;
-
-	/* Say 1 here for big endian Hardware
-	 * (only relevant with bus-shift > 0
-	 */
-	bool is_hw_big_endian;
-
-	/* left shift of register number to get register address offsett.
-	 * Only 0,1,2 allowed for 8,16 or 32 bit bus width respectively
-	 */
-	unsigned int bus_shift;
-};
-- 
2.45.2


