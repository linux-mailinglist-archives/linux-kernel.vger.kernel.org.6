Return-Path: <linux-kernel+bounces-355617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE399954CE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 605CC1C25D95
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD691E0E08;
	Tue,  8 Oct 2024 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L59ZEzJw"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397DD1DF98F;
	Tue,  8 Oct 2024 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728406033; cv=none; b=d8zvPUZzSHVSwCRPJzqFQMFMOd+vjVL3SYo9KXSMddLCI2rIGdfqO7TjUDGmsLT4Eit9Urm+NYpCB8jULveMBOc5IabaaJR8AgKUMicqa2Jyf45NYfMEv22XZjqC1ts9Agna5haFPAHjRZK5gcd4v3nOoytB5wsokUMD6zV09R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728406033; c=relaxed/simple;
	bh=7NpC9Z9fSFmu/ab7qLKOm3zCtcWbKx6S274Oh3JiwRA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HKncbgOqNUTVLqZTuomwt41hjtuxCQAZWoPrmYDx5mdPfxW+Ig0L7ITLTZrhWHDZoZur5eyQYT1/aB4Yv2qA3ZYfced/ivHPsVIQPeXJEQ1eNpvVAc529WMjVV+dpEddYeiW2jPqY59E3bTFR1PvVSwL52zhFSWFvfDwwihkFAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L59ZEzJw; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9968114422so146828166b.2;
        Tue, 08 Oct 2024 09:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728406030; x=1729010830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2870U45LetmQ5voKNhtmgAXoj6GNIRWVFzGUh+2Lh68=;
        b=L59ZEzJwkRtt/Z3C+Kv7psQb+Y4JIhazbxWkSpFJ6kJ7QXPHGe+o0Pdoj9GScjIOPW
         86cLmINNx1m3q9k+6VNooWfY7fHFLyef97Rnm422m2bqjErlSTsSE9DlQ8ItYZA8ZP++
         KzUt5psTHyFCtRj1BVDBKKy0F/ptdVzOTK7Eh8ORFZim3SJAiC1JJ0+N9n94+LMEUXL+
         QFt5QExBDauIDvYnftxnUZWhJ9NtJczP5x9Jpy5WO90siAmumd7l2f82ZPl52h2hznuF
         T49ZMDy6uKLGGmErS1+RYJ5MFmn2BA3cqe/MTcV9lyphyGaZngeo9HB8m0MAaMXOsZfm
         q/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728406030; x=1729010830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2870U45LetmQ5voKNhtmgAXoj6GNIRWVFzGUh+2Lh68=;
        b=BIv5M7CI/J3lthTAPzy1g2PDs3HE8S5WxNEmE/P98ZuA1Hy0vrnMGM+YLrEU+Y0UBu
         YLx4jNZ211X9ZwrlEeOQQNcWl3x29RHWS6lWG3XoGUCjOPwkaPmEZ6zfpG2X3mINkYsa
         5KKmbxdPH5etVzvg887dvjbJLugJ03HF+VraUZbrkQrJRxqPMxWoPbhIBV172+MbeAuU
         2Ar9LycGLJg6GSvsaZJT5TUh6vtL4abci7e+1vnp//LTDgqdDdMeTuO+LajSj+Ud69fq
         vUERLvYRGZxbNgVqgwSwoCg4h+o77ulIx1SuVg5K7XEJ7qP5YYVwrQrrrwKs5zpLVCGK
         NByw==
X-Forwarded-Encrypted: i=1; AJvYcCU/+WqEegbBmTj6jTmmEOLzJPNR+3q+YXUAvCfPbZmRwWTeTG2QIZIEYclMN8dgiQmnjm46rb0SHbWP8jY=@vger.kernel.org, AJvYcCX3QEUJRnwIAntl6VdL1szK20YWI3E4Sr0jFFfV5OK7kuTN0vWMZbkKj/4ja4oKMW+0sGWh4Y5q12CigOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3MmPp0ctavaZ0zcPnERyAGBcO1mvQ0xemafDjB0oo5tpEX44r
	TKwugBgDd6879XCsfXPcmjqeNQSYhTX/XGkPvGoCcnvp0Yo0BlRw
X-Google-Smtp-Source: AGHT+IF+XZHN0TT5GTel1+0328M9dhDXstpCb+Q7drWou1Rx1UqVJsoDXSnf886iLFXfzfs6mXSzsA==
X-Received: by 2002:a17:907:7248:b0:a99:5110:7a4d with SMTP id a640c23a62f3a-a99511081f3mr895919666b.61.1728406030247;
        Tue, 08 Oct 2024 09:47:10 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994f3806cdsm332075466b.118.2024.10.08.09.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 09:47:08 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jack Yu <jack.yu@realtek.com>,
	linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: rt-sdw-common: Fix bit-wise or'ing of values into uninitialized variable ret
Date: Tue,  8 Oct 2024 17:47:07 +0100
Message-Id: <20241008164707.203792-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are a handful of bit-wise or'ing of values into the uninitialized
variable ret resulting in garbage results. Fix this by ininitializing
ret to zero.

Fixes: bbca8e7050e0 ("ASoC: rt-sdw-common: Common functions for Realtek soundwire driver")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/codecs/rt-sdw-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt-sdw-common.c b/sound/soc/codecs/rt-sdw-common.c
index 9ed0e9855699..a422da6cf702 100644
--- a/sound/soc/codecs/rt-sdw-common.c
+++ b/sound/soc/codecs/rt-sdw-common.c
@@ -101,21 +101,21 @@ EXPORT_SYMBOL_GPL(rt_sdca_index_update_bits);
  * rt_sdca_btn_type - Decision of button type.
  *
  * @buffer: UMP message buffer.
  *
  * A button type will be returned regarding to buffer,
  * it returns zero if buffer cannot be recognized.
  */
 int rt_sdca_btn_type(unsigned char *buffer)
 {
 	u8 btn_type = 0;
-	int ret;
+	int ret = 0;
 
 	btn_type |= buffer[0] & 0xf;
 	btn_type |= (buffer[0] >> 4) & 0xf;
 	btn_type |= buffer[1] & 0xf;
 	btn_type |= (buffer[1] >> 4) & 0xf;
 
 	if (btn_type & BIT(0))
 		ret |= SND_JACK_BTN_2;
 	if (btn_type & BIT(1))
 		ret |= SND_JACK_BTN_3;
-- 
2.39.5


