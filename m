Return-Path: <linux-kernel+bounces-204323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFD08FE739
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23AB01C24693
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD03195F0A;
	Thu,  6 Jun 2024 13:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fDx1Lh6r"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2713E153821
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679432; cv=none; b=Iq0Afzsl8tKSblzhrf9qYqXSWwkJupHi0IEnXgS+6yz0hdjbMKs/OA7vBgNHCt0h867k2cBOfWQ01RLKKyCCsl79uRGGHw0MpDAUgwEDm1PK0X/+llqSqFSlSX0x0KIEywkhTPD/178B8S/oKSb5ll9clglJtTeACzChQqvlOGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679432; c=relaxed/simple;
	bh=zT88eZfNNd+RiyI4o59iAJCPJIAf8oivhPTjWxX35MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nCmJLJbSAxoTTTvNJlRbfsAwHATq0xHFeNQfI9SAXkjiaWz+pOz1YNzAwlOCkSPc8wvgUX94haRdDRaxzqWRrUGB7utWxI5dgnzSQLmdZssS0fNLf8mTBQ0FHpBsYVlBRQntDuFTiSWkM0HN6+CV76+rpzQOkhOh+8u2kR3c9gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fDx1Lh6r; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a68fc86acfaso144701466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717679428; x=1718284228; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LLTo6IN//CUfT633Q+EgtwxBk4Zhgr8yvAaTHaRrJKc=;
        b=fDx1Lh6rX1LDP8w/JsHdvLHz6V6cyvu0Vc8B/sXq4YtcwW1DmqkH+afCojavFduOcZ
         W/iz5jps5OsEzdRzyqWum3X1ZH2mcBRUS8rhCi2WXEb3qhKOvY2hcu3JIXz0pEEJ8Wpa
         IFT3ASthAA3NgddTEw5N+hLmRycL/jwcPCoKTzD2JjR9HdXMEmBywKEV2WC2kNrMeMUJ
         kqCUS3sxhg0mG+dkjghTfr51mJdZuN8a5YmSxnqkyZnTSYfIy7Ybs6XQWmSmTQ3be1Dl
         Iz/l2+dm/W2xjGTI/gWFY9djaSSlciEJ2JGHp0rCK5mDJfJwAeqSoOPGOPePQKsx7330
         yAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717679428; x=1718284228;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LLTo6IN//CUfT633Q+EgtwxBk4Zhgr8yvAaTHaRrJKc=;
        b=xU0pRhVW31x1h2Ip1KKKQUaote7I0/Bx18eK7fHdXJuhAWD99LA8aYg/Gtt9JPkQDq
         fYWuOSV6R2hjruWKxh0pa8dk4ZtpLPU7GKBlFhfm7flHatS5v4eBLdvQbPNr6vQw0+Ce
         vvOHYJkOajSVh1v1h+GlKMzOzsBjMbCUJWFzVy4eIZfPB7LUIWcXOd/GHe6lJhQI/ROq
         JQfUOvm0bBPWn375hp83daVpsOLif+/Inb1MKD77UIMXRPWgbmaeOqx9FyxeGTCuWrUF
         Ajidvp7U++ZJb4J6J6P2oPzqCbr+8/2SgaJOskh7gAcm1zqaTSv+cSqvNGF8bq5rYVYi
         sPoA==
X-Forwarded-Encrypted: i=1; AJvYcCXyXyMGLBehesHJbWZ6uNk5WwZOAtYnou4uBCfSoxcnp8Okd5IEScxo1E9KdIF+sZfpcWJ3/8ygU859MHYkVozBOizyTQdGp8Wh6wI4
X-Gm-Message-State: AOJu0YzXP494CaoSA0bbqUm43bhHOFqJu6DYf3jAd8uwJ2kw1ZjDu+YI
	sTrgmhJPviw8lFhCea5OvAY5oZSSFB/UVhgzQFhAiajJPfXbflWeOS6Tw78uP9k=
X-Google-Smtp-Source: AGHT+IE/O3Z7xTXrhanwtiiAy00RvXG9RUOoWD1wIob6c3DU4S0+HjI1sOf6DL7JHERx+RQuhoT5dg==
X-Received: by 2002:a17:906:e218:b0:a68:a476:6957 with SMTP id a640c23a62f3a-a6c7650a2ffmr216652566b.24.1717679428406;
        Thu, 06 Jun 2024 06:10:28 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8070e82esm94963466b.161.2024.06.06.06.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 06:10:27 -0700 (PDT)
Date: Thu, 6 Jun 2024 16:10:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Patrick Gansterer <paroga@paroga.com>
Cc: Lee Jones <lee@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] backlight: lm3509_bl: Fix NULL vs IS_ERR() check in
 register() function
Message-ID: <187b5bc5-a010-46c2-8ead-980df9efae79@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_backlight_device_register() doesn't return NULL, it returns
error pointers.  Update the error checking to match.

Fixes: b72755f5b577 ("backlight: Add new lm3509 backlight driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/video/backlight/lm3509_bl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/lm3509_bl.c b/drivers/video/backlight/lm3509_bl.c
index ab57f79ffe23..c93cdedff5ad 100644
--- a/drivers/video/backlight/lm3509_bl.c
+++ b/drivers/video/backlight/lm3509_bl.c
@@ -114,9 +114,10 @@ lm3509_backlight_register(struct device *dev, const char *name_suffix,
 	}
 
 	bd = devm_backlight_device_register(dev, label, dev, data, ops, &props);
-	if (bd)
-		backlight_update_status(bd);
+	if (IS_ERR(bd))
+		return bd;
 
+	backlight_update_status(bd);
 	return bd;
 }
 
-- 
2.43.0


