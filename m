Return-Path: <linux-kernel+bounces-572452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00750A6CA6E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BDF91B61D5C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A9D22836C;
	Sat, 22 Mar 2025 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6iKclAQ"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658261FBEBE
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742651820; cv=none; b=ic/LSbHSBBWoZkfG76Ge5BOZ1xTBLFjstVN3LeMRcSlPGxENnhaOrLShAVIsxW18qifCDdiM95bjvyc4NcIuVpO+znpjmnRg/Cx+L1s1hEm4v+rr59aIwKdzjg/Z2KB9Nc6jIsvnmAaHHJ+29hikW176RBX4I6Q5O5Mfw3/9w7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742651820; c=relaxed/simple;
	bh=HC5SXTLXqFRyIjOWdF51T9PS7pYFW9s1HxRd3bt8qOc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CxBCutk2Fw3X5aAOMeuZfsvGOnT/fqjoYO3q9dXSYebW/BcWvay2SOZAnUm1c7NxstHwZTBQWbBUwh1816AC+EM28AzrEaZwyJawa2hMIagCWKtDqWVaEj/g6LpfJz2D+PWcbWJrgs6FqdM6+wkAa7M0PG3fXoSzCH48qfKfpv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6iKclAQ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e66407963fso5233147a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 06:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742651816; x=1743256616; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nwJQ+DNaXcBNm+hFjnYMaifHycz52RS1oOBrKBk6QeQ=;
        b=T6iKclAQ/8ykSlqAhho0lS/Pui8PwiDMgnYG8zAIldjMQ/p6+MRuksptlPbyLZbqRI
         0prdUEn6Cquo50hAc9wBnIc3Gt3x0FlFXXAVkR2NlltnkNM9ixMnf9jDoVtZuWnjwIqB
         cinkOaIbLrydFLmRHn2jobcYVu0I69L63HPzURDmx0+xa1wto/D+QqyMIyQVK5P8eQ6X
         DrP2v74zAXr5acuxoWjWqw3P/8xDNWIqFdKTf+PbrQhRRfdunSViBswv4oMjaxrVKXv+
         qcuDToiIIOuejKDVYqBVtdXvvHFyWQvzzlD1JgK9Wd10Jhjp11P+0eT5sv3+uyi1TtB8
         z+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742651816; x=1743256616;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nwJQ+DNaXcBNm+hFjnYMaifHycz52RS1oOBrKBk6QeQ=;
        b=YpCc3U4EFKqwSmzbm2fEIqXIVDdxrS1X7FGWA73UkfzQRavBK7uVnfdfB6aI6mVKIg
         mizUhO4quXfbFbGfWe8NeaEUyvfY6FeTg+snncd9ebmfX8dH6Ghs31VJhNFR0+8AV7PB
         L05HKHeZj/o93spqPeCAYfZSjRHcw4fIsYitzKxQmM8JRD5505gcMI74r/bJ1ESYCCq9
         7M3vqm0F4iUjfxjuy9Ssu+HAqwMAjPPuLSteCbnr7kHZRTlD+m7rXWfzcNLh6fsBKH2e
         88fv7V0LTndqQJFVx4kZ6lQkcxp6AO4t4kyGCoILzs9nzGnFQARmywpyZRBoG2uDQwOc
         fNMg==
X-Forwarded-Encrypted: i=1; AJvYcCVBZnH9EX7WN2w8oUQihzTWonxT+81q5zvF4QB0yeXHUApHMx6URayucyUw1uSIrq0+dTfXpgGqMlWlFJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxnp1y9wiL1O/sefJtBN6KN8uJZho2ljqIXojBj1tmF1W25Ttv
	WJKLDFwIxM7D+75D7qXM/ufiGEe+WDO4DyELIyc1kzqh+QE46r5RALCCunvq
X-Gm-Gg: ASbGncsfaK9dusAruZOUC4atHwf6ANaDQ3TGFpumosl9NFUTcD52ZR+uzAsGY0SLr9W
	2g47gths0PnfahsSG3xe2zg2ibVepLG2M/yvnuOTF5b/j0N7vcLwnGh49lm8atZW6BMwum1QirR
	6ZIyvxM1GeMJF6FZnS0HiVKgADj+RYXPJdqqN66UQtnFxPZduIf4A5T4E+HlZpp+tHzcDMMTGew
	qRC3PKKupec6tTDZ5VL1v+UKM9Vqf4hocrFnC1CorZthJLwMHkGdtumPAzqsT4bF0BTXSiVTBO8
	iRgjBYxdROlUHUFJtBCXPpdkzWinAMJ2QZiGeXevLGxKqjzkbA==
X-Google-Smtp-Source: AGHT+IHeUSR4IRAOBL64PNtQnwHsKu+y5XZcQEY1c53MZvjTaUb6Z4dobWK5HSz6Vpm04MO7+l2K1g==
X-Received: by 2002:a05:6402:1e94:b0:5dc:94ce:42a6 with SMTP id 4fb4d7f45d1cf-5ebcd4f3234mr5903696a12.22.1742651816068;
        Sat, 22 Mar 2025 06:56:56 -0700 (PDT)
Received: from HP-650 ([105.112.226.109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccf85890sm3207084a12.24.2025.03.22.06.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 06:56:55 -0700 (PDT)
Date: Sat, 22 Mar 2025 14:56:39 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: outreachy@lists.linux.dev, julia.lawall@inria.fr
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: bcm2835-camera: Modify function call formatting
Message-ID: <Z97Bl9RyFRGZUXNM@HP-650>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The line is a function call which ends with an opening parenthesis
thereby not adhering to the Linux kernel coding style.

Modify the function call to include parameters on the same line as
the opening parenthesis to improve readability and consistency while
adhering to Linux coding styles.

Reported by checkpatch:

CHECK: Lines should not end with '('

Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
---
 .../vc04_services/bcm2835-camera/controls.c        | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
index 6bce45925bf1..e670226f1edf 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
@@ -533,17 +533,15 @@ static int ctrl_set_image_effect(struct bcm2835_mmal_dev *dev,
 
 		control = &dev->component[COMP_CAMERA]->control;
 
-		ret = vchiq_mmal_port_parameter_set(
-				dev->instance, control,
-				MMAL_PARAMETER_IMAGE_EFFECT_PARAMETERS,
-				&imagefx, sizeof(imagefx));
+		ret = vchiq_mmal_port_parameter_set(dev->instance, control,
+						    MMAL_PARAMETER_IMAGE_EFFECT_PARAMETERS,
+						    &imagefx, sizeof(imagefx));
 		if (ret)
 			goto exit;
 
-		ret = vchiq_mmal_port_parameter_set(
-				dev->instance, control,
-				MMAL_PARAMETER_COLOUR_EFFECT,
-				&dev->colourfx, sizeof(dev->colourfx));
+		ret = vchiq_mmal_port_parameter_set(dev->instance, control,
+						    MMAL_PARAMETER_COLOUR_EFFECT,
+						    &dev->colourfx, sizeof(dev->colourfx));
 	}
 
 exit:
-- 
2.34.1


