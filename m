Return-Path: <linux-kernel+bounces-381652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFE39B020B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32E4280A85
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B21204952;
	Fri, 25 Oct 2024 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0nuryJVo"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD311D54E1
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 12:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858757; cv=none; b=Lcuv4JwwuTwJNN47TsLr89OY+RF+G09uEpnEgv+YR42H3DEjiiRtWZMokVAl/cEUlcFLfXQTmFUOuvlrNsUqa/7V8uEofZe46irCGwZ7gSvgoHf6ZkrkMJQlO1/MmdPFX4GhEjBZvSmmaXL/gkvFy73ruM5FGthQLYUtg/Xcox4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858757; c=relaxed/simple;
	bh=b54FbCHja7CBqwDRsM0h/GxRFDyS7LVaymO+q0/8ldo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HHwq6UWIfxPwlzLaHLHrpoIrYwG1kHsWDuY7yoi+x5sd8kyLP7l4h7zqLpIiQ/xXdiToObbLxec88XL8VVDfKGl94eT8KXMZrCqDakpbsQmm9yvGoNDbUdDV943lz7mTjfbx/LCV0DzKAWlinD7mcbedeGNQwFmxa9LnXi5sOi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0nuryJVo; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539fe76e802so2518964e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 05:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729858753; x=1730463553; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X20tHHMbnUqEu6sXRZylXWkGDJY1IMTWV0MqB4dYN7k=;
        b=0nuryJVoa0VSgwnquX2moH6Hb/Ym78QF3uCw9A9CeHjWpIBJVFIMgRLCv7culrEvyi
         uGegS1PekZspdGs3yaOi+i4PspIfTYI8mmXS+wHi3v1O2tA7WdEwS0QqyxZsj76xBoch
         BTozPSpM1AGExGdsZitrmBcroYYjh8DLPnYjRVZ2pmfWGbZas2+LgnI7g5dasz6h6hQp
         2NWJuUZkXsF0Q6gPYhcN4Ul3yqPte8DMyfp08UfR+P1aEtu75nHEq1vZsefzgNKXkcMT
         HMn3X3CFRzflgb9WMd/dNCZ6HS69J1ZIXUBIvZA7pUEFWc0vLSCmp6gwkrJftHRdC1mj
         cLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729858753; x=1730463553;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X20tHHMbnUqEu6sXRZylXWkGDJY1IMTWV0MqB4dYN7k=;
        b=AK5qA476eVGvMTLF6nGGLJGNh5Wsp2QuTEIY94LOQ48Ru8qKopGzJOY1aNUM0+fBqZ
         PtHRzi4Gd9ML3NgPVa/04Pqrg7aL692AVxjaC3wL9f0VOKl6ZrYKIqgKDQmobtCg8R9l
         GuhtqEosRu2KQDbs10J/vbunQ9Yr0Ub9sTQtj6+PCOkg81QN24mXA44Fsaz0G6qB4/SX
         G+9pT3oXs8nU8rcDjJK+P+tTiWXQ7+i0LRTey4uwPDeogg5M0+vpVf+Tv0SxN+/1gFY1
         3oX4eWd4sY00pPx5OFAqYAwZ7DI8nt4DacqpAmMM9Ub3ZXmh0ncfogpuv9IlPDxy+upi
         wITg==
X-Forwarded-Encrypted: i=1; AJvYcCVFFk+ED3U6su/xr/wMTOdU2WO8e97xLxRawHMqu5qKPe25+NiAnSStIC58fR/3ip2oFseeygkhwneF4fg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu0xPdZ95FW1fowsuj8hGicqUgfOQsADTLWKXL/I5Wd3/zSTXS
	orHNpNW3W9K5s+E4jkYXdQekdORNhskNB3R5tS8TKDj72K8coauvxCknFLtKX5k=
X-Google-Smtp-Source: AGHT+IEf0CJ7AFbjtUuLkSaxzxtDIxu0L9xxw1QnSt4U2kEM15dW177OkeDMaY9ld5gTG2GN+YZwOw==
X-Received: by 2002:a05:6512:2813:b0:532:c197:393e with SMTP id 2adb3069b0e04-53b1a2f4e1emr5160147e87.11.1729858752440;
        Fri, 25 Oct 2024 05:19:12 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:a207:5d17:c81:613b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b132ecsm1388966f8f.5.2024.10.25.05.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 05:19:11 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 25 Oct 2024 14:18:53 +0200
Subject: [PATCH v2 3/5] gpio: sysfs: emit chardev line-state events on GPIO
 export
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-gpio-notify-sysfs-v2-3-5bd1b1b0b3e6@linaro.org>
References: <20241025-gpio-notify-sysfs-v2-0-5bd1b1b0b3e6@linaro.org>
In-Reply-To: <20241025-gpio-notify-sysfs-v2-0-5bd1b1b0b3e6@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1117;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=ohn36PAaOtThoEaiMJhLHyeKcMLTYsApF7P9FlFAZko=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnG4y8Y/Fx9tT6sXbJSo718keO1nGX7qysfsyT0
 GAjAZ1nj6CJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZxuMvAAKCRARpy6gFHHX
 cp6ED/9iFL6wrmLovcDshjlQRLLf7ePciRMILB9z5G9LLAA2LZhG/4xAndo6VZBXF739EVPmPmQ
 hCOcpRjI6Gyhs1kIjZPO63c3SwNXhtd3kmUq9lhbiHnZCbKo0T9Uu/T9wKJnKK2CJp4G9c6ue+l
 uHP9Vbq9l2F7VGenRaBGMjQPykd2VQok1JbCKepdMjM7cM9U9AiBxIfe7xh8UNOLl6Bc43wEWiV
 eBuyoBFc6/fSyujQ+FGEylqmdUBun4rdg4akLXlYICt4BxxfJ+RCDHQyK+7ob4xP3kZTepRQnBO
 cBFvXEirrKLhXdKrRb/9cvOo+4H3v1/pMkLtcxOQf3spO9L4j5RfQ0OnNNeZI5VcaWZHBx7KGlj
 Zk9k3+vL2r1SL9NLcfYeFYOoz1rWiSa9viAEbyXOPYITjl3G/c6NIBSnonn53nJ+HRxbHdeC71n
 zlBewTC3qNpTVah9lWk9CgbxvXvBAvbC6LHz8SW+UGeWIU9X5xk+xHdTeBpINJ8DAOkbhqcEZQX
 tKovxMJglnNI9ceqJk1bRByCaIBN5Qb40uKmR2a9lgDAwxtuUmblHxJXsvUwKqLmgb3rw0Eydio
 J2jibNjK0Lh5HTk9EADFVrDab0pne/uARETJMULWDy51Y3Iz7wRKl0jsFjo8oa3ll5nSUWnyQwv
 Vxk9Yl/4rCo+96A==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We already emit a CONFIG_RELEASED event when a line is unexported over
sysfs (this is handled by gpiod_free()) but we don't do the opposite
when it's exported. This adds the missing call to
gpiod_line_state_notify().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-sysfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index a7a97458909f..de3ed75b097e 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -21,6 +21,8 @@
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
 
+#include <uapi/linux/gpio.h>
+
 #include "gpiolib.h"
 #include "gpiolib-sysfs.h"
 
@@ -470,10 +472,12 @@ static ssize_t export_store(const struct class *class,
 	}
 
 	status = gpiod_export(desc, true);
-	if (status < 0)
+	if (status < 0) {
 		gpiod_free(desc);
-	else
+	} else {
 		set_bit(FLAG_SYSFS, &desc->flags);
+		gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_REQUESTED);
+	}
 
 done:
 	if (status)

-- 
2.45.2


