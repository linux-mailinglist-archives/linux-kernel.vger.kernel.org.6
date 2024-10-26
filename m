Return-Path: <linux-kernel+bounces-383196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BA49B185A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 14:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A958B22A15
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 12:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD451D8DFE;
	Sat, 26 Oct 2024 12:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lfW3rCgW"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0646B1D7982
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729947525; cv=none; b=TjeanXkKcneShGhIIuTjpbw2sF4DYhdrOTGaz9EdrsRN4LIwRoGWE+nuAEqTub58vb/6sD+hoNOyxJR09saIk/xwbP7B1wPEILxeG5B6KTXJbKw93HrAe/BxlpmGEaGj1YLSEaSRhlZFsSJ2OcZp1wq07CGQjSYkv71mlRMPpHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729947525; c=relaxed/simple;
	bh=Huooi3brujfQJQF1saq9mAR4WMheDyMLjGG+ih0fZh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H3lKVBEBeT9mc7/bBYw9I/XjtGPv0KFe1MB5fjdAhnMFVWBG3PNa488Cp4WiQzcibXfAhL+QzM454aFqJUZXjIx8bxGxvjDBouSCFLNP3YvhaD/b5edGDOCNJ0Up/sdvfbsWmHi9JLYTWPegl4OMRpGLtGVolroGtdVmwR7JY80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lfW3rCgW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315abed18aso27709815e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 05:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729947521; x=1730552321; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B1pUqif3iHFDI7SYbTlPmHg/+dCSXY6PKzLmSZVOhC8=;
        b=lfW3rCgW2sgMqUHiRmUaN9Cw/ldPJjnC5fUiEEjzXeBE6HBAgeh1ri80PUBweQnmx6
         clKLtRKwpXh20HPKCSC3OsmqO3CGSP0FaRcPy1D5LRLLsCXBqiKQ/eMaxpF6VED1glPT
         8xSzc3uY0WS1g66Ng00X6ORgKygUMA3HOD4/r4kxV107ENGboYOqW7dxKH64EtCKjez5
         mVFbqIkQdN3f7byOOzq0BntWArbV1gBuw8HooTXXGlbJNDB+RG3+/rmKLkcUK4tqNuGj
         pbQDOdH20p9Efquqkg262ZNiK0Wdxim+233ii+W5bWOLACD4p8bLTVigDQDgMIJLOyaU
         vDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729947521; x=1730552321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1pUqif3iHFDI7SYbTlPmHg/+dCSXY6PKzLmSZVOhC8=;
        b=o7UoQjxQp9BiUai6lifC8O5qK5jsphwoXnBczD/9VaxtZS8baK0uR9CRck8tvKe+q1
         PCHDWiE9UAn+sHDaBPejqH1Sz7OJM6MEDD6dFhoTfl74uGpIdiY/afsLrDPsA/v4fPYG
         HPeFxVHDgEP9l4Deo9mfWr7BTa4pP8i1JO61/BpCAetW6NKUK4HFhHaaWU9z5OXsLOwk
         so01G76IwcwW5sxnOs4ePQCDGLIdx320E1O1wKqn7Wao6OZJo8NGVqkc2MksXvSgEbS1
         I7CrqzIpZ7HgJ8J1iuxMaeJgc23O47eVQ4cNVgXHExMFs8eqENWUnqMng5TTat7FNWQg
         JFUA==
X-Forwarded-Encrypted: i=1; AJvYcCXijkxB6A/j4MHxb/iJvmhy3Y53ZFQzWDKLWB9ixvMzW+qd3lQQofkjbksDuny7eCA6NpdKIC9J3KJNZK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0vcTBipO2951aKyePV3nDU7UciKv6IQ4ifTfdeLjoJRoFHHFm
	UZ3FVyr1Kv5f7vbUJBMN8VnxB598EmKyb4x4Zc06Fx8IT7Bycvjc6TGjPrvHPDaClv0XZT8FCWy
	N
X-Google-Smtp-Source: AGHT+IGTg+6KGx1FGlziTjPyikATbdiJCvM2qDMv7s40zqrzR3XQ4ZchoHkb64EQomaYjcPpRt3wPg==
X-Received: by 2002:adf:a59a:0:b0:37d:4436:4505 with SMTP id ffacd0b85a97d-38061163da4mr1740072f8f.32.1729947521202;
        Sat, 26 Oct 2024 05:58:41 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:617b:5770:df34:27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935a3edasm47498535e9.22.2024.10.26.05.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 05:58:40 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 26 Oct 2024 14:58:32 +0200
Subject: [PATCH v3 4/5] gpio: sysfs: emit chardev line-state events on
 active-low changes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241026-gpio-notify-sysfs-v3-4-ad8f127d12f5@linaro.org>
References: <20241026-gpio-notify-sysfs-v3-0-ad8f127d12f5@linaro.org>
In-Reply-To: <20241026-gpio-notify-sysfs-v3-0-ad8f127d12f5@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=781;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=DB7XHM1bWYi93YBxo/DVbMZI+iq6kFH/JuWh0KaY6aM=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnHOd6q3I7GmHt2DE30sZZjoAichBXV5wssKUG1
 xMsJpkczr+JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZxznegAKCRARpy6gFHHX
 cmm3EACyV1KrnkTCo/Oe+9N+xF5qh8UzddSijYG9+/eSIZebmoxYqDRSIJCdPjrnYa73tc8lRMb
 6Pfejwzl2s/unY+4ozzgl96yVrpg+lA7zeO2IphpqfU086XCG7x8W3Oj20ajYTKSFXYhjseqVdS
 m61zwOUePZ21kPZBrk7EoOjgF2GGaPI6it0EEkOj0bseoiBLDWxeQrxLqRjw7TZqdp2h2sI/IVe
 Qc9qhYp84Cqdn79jNdIyOz3RqDyVZQCGBBihqvLIU9EP82ZF/7f/zGhdbjHdUjoBTFMwZrfLony
 PodtMRKVcT1G8NyabIN+alVm+Q0L1oZ0a7k7MnJ5V0wwNGNkeOHgItEhYUUw7tHNXktJnx0uPLx
 hmW7+Xg4895cwBRo0Vst38dCwoU5TMavNB0JHAYT4rQq9bC5ZG71vSxWYbtChPwmHdhsv12M4E2
 lsmhsdxs+psfC6lciEo+L8iekBK3H7KqjYdCTo/QDVqX+G5+zytOwWNUZs1bO5mDUN61I/eOkNU
 ymh5/lcMP8MjOQtDFJP2qYc03lKJNqyoApRE0dS32Gn2/zao63iHrNGa/t5ifk3/UqCELw4NzOo
 /lZL7B5uEVnGoeGxQ0HdZhtnAgivnfFc1nlHdwBNKaDHQEXkaHhxNuvfcYHczxQjH3M8zxYax9h
 tBuOwcmlopcl8aw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The sysfs active_low attribute doesn't go through the usual paths so it
doesn't emit the line-state event. Add the missing call to
gpiod_line_state_notify() to gpio_sysfs_set_active_low().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index e1144d3c7645..c0b7f42a0860 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -307,6 +307,8 @@ static int gpio_sysfs_set_active_low(struct device *dev, int value)
 		status = gpio_sysfs_request_irq(dev, flags);
 	}
 
+	gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
+
 	return status;
 }
 

-- 
2.45.2


