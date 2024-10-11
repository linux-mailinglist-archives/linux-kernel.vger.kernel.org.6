Return-Path: <linux-kernel+bounces-361779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D7F99ACE8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 969EEB23057
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C271D0DE1;
	Fri, 11 Oct 2024 19:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dxXQKG8H"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C071D0DD4
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675757; cv=none; b=EznXP8QRtirrY8vAilN0N8K0/MhGYJwIoPoYsjwNsFTQJhs1KFX8xTWd+ku4vcV6TvVKwB6qvRczqRJX2jbn40ctAmG6/txdHbi31Dtab7Ta7wCfnxRNHf6TXqG2fE2JzrEuP/sRQdl6xNXCg6CVvb+fMTbeF2MTjrVbxAy+2UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675757; c=relaxed/simple;
	bh=B7kyYckFT/0DJHm3tDLiNH9WM3QNDHo1rocCSnEz2WI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tAmL1R4Bev62o5mXwm5JSFIPXSJOnqfMs4QaCKrnyT8rYZy+DDfMJ8f5shYRsO9J00LUvxQLgokErej0af7q2ysNz1rOMK6RwrU4vtSgOlL7SjVCkCHg3xFTl9GZ8/39lvFvHXm0z71UzO6JaXdEfuIRQjDvTqGYCTVjDb0fPdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dxXQKG8H; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37cea34cb57so1446897f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728675754; x=1729280554; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9H6rXUaUQHjyd2VSgKGDs+alotbQnC2p5Cn69HNYv04=;
        b=dxXQKG8HU1bwH2NhuFz0fSNyTBshOiaztF4OgaX2/Q00YcMPR1PzeWdw/JS8p9FXhH
         d0YgEDWluhg6g5YzuKRbyEW+eD4aAyy66GAllToPKCU1CKgJ8eiYjeavghxRXjZGYsM3
         xPJVsAzUQAW3RT+HRZh3tUCTor9VZ++Y5w77Jw07DMJNjimB1TkZ+DzvXNQNOwJMkbAC
         3npLKYuQgPU41l9HO2s3/Fe+Q+EzKTOAjtl/NRLRgzBHCDjsLABCnEq/WOIFEDGWkFqp
         A9FL+A4Vm18YYaSHazL6/su5MovelE7fWctiFGdAk1K7G+rQYmGX4vJW1I1E2k/EkcrP
         /MAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728675754; x=1729280554;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9H6rXUaUQHjyd2VSgKGDs+alotbQnC2p5Cn69HNYv04=;
        b=Xkxkc2GzzMBLn6B3Qi+TgqSb+2LNuXzROMMeQ0JPY3BaT4kbz/vxGtHdS4iyHlqd9X
         XLfb1e8oj25vwzcx9CML7NcZVSvdG9aH2wlKfneEpm/XcuVdfwvM6j5KesJDmVqOcYXT
         qqLfJBjc8wAG8EKns9HswQ0tc3SyZyvGsPBUIQlcohotyBqYUASDlGUg3oEfd9QbrhYB
         6Xh1j0ezITbZeoZ2ilFEZh1zenxb4jjvdYWMdGIInZEzY2543xPNZBb2kGXzaFwfaTGF
         h2s894105RJEo8N2QYDrBIZf8GWhoG5O3v8pxYQ4GuJErkzEcXHDtaNnLCxgKx57IiLI
         KsGg==
X-Forwarded-Encrypted: i=1; AJvYcCXEVwyUGmEmmSPPyrUygcvLR5sN1RpD3rJW56bev73cmq5W65YwAAMzdhGzeLLAM48nS2KnAtP0/MCe1z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA2Ob/BTA5YpOxBYx1UuKHejEbdPj7+0zFtyEXSqmQh7HBw2qG
	P6JqaTWa5Vw6b3xyhEiHkIzERSp+Ni4kK4klDiX9AaRWltDyTo7QaSzrKimdy5Y=
X-Google-Smtp-Source: AGHT+IFPVVvRgJhwZiV6j4xkCfdUzrR6DGnGMYo8fZws+use+5kUvfYFQjYHJ8OsNnHP8FEbLNe+OA==
X-Received: by 2002:a5d:4d4a:0:b0:37d:4527:ba1c with SMTP id ffacd0b85a97d-37d5531a0a2mr2327244f8f.49.1728675753903;
        Fri, 11 Oct 2024 12:42:33 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79fa79sm4686059f8f.72.2024.10.11.12.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 12:42:33 -0700 (PDT)
Date: Fri, 11 Oct 2024 22:42:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Helge Deller <deller@gmx.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sekhar Nori <nsekhar@ti.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] fbdev/da8xx-fb: unlock on error paths in suspend/resume
Message-ID: <37842441-e372-40e9-b0f5-cf69defc2db5@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Add a missing console_unlock() in the suspend and resume functions on
the error paths.

Fixes: 611097d5daea ("fbdev: da8xx: add support for a regulator")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/video/fbdev/da8xx-fb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-fb.c
index fad1e13c6332..66ff8456b231 100644
--- a/drivers/video/fbdev/da8xx-fb.c
+++ b/drivers/video/fbdev/da8xx-fb.c
@@ -1610,8 +1610,10 @@ static int fb_suspend(struct device *dev)
 	console_lock();
 	if (par->lcd_supply) {
 		ret = regulator_disable(par->lcd_supply);
-		if (ret)
+		if (ret) {
+			console_unlock();
 			return ret;
+		}
 	}
 
 	fb_set_suspend(info, 1);
@@ -1636,8 +1638,10 @@ static int fb_resume(struct device *dev)
 
 		if (par->lcd_supply) {
 			ret = regulator_enable(par->lcd_supply);
-			if (ret)
+			if (ret) {
+				console_unlock();
 				return ret;
+			}
 		}
 	}
 
-- 
2.45.2


