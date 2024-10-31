Return-Path: <linux-kernel+bounces-391219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F169B83F1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E7341C20B82
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8241A3BC3;
	Thu, 31 Oct 2024 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="XPNgh9c7"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51281CC142
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730404928; cv=none; b=jlJKyQMrGOJyzwrMVoEu+IE/EAMFSG9Dh/fuXTHI/9fSHo2kTC7nvvOs/s+4Ldu0kh1iKJgwAlnumM7refqTK4ZZviFQSw8TqJUzNOppDUsLnrU24xxnXKJUEF1dfXIofjLVIc4dBaRk79I480APV0oAstLn0r+jOpDDdxDDRJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730404928; c=relaxed/simple;
	bh=32n8hNRrxZfRWXJHlXEUvVQAOaKpzejZ0VhlHU1F83o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pBs5l7V9lzYlLnpl7rWwsk/WXoMLMi5aWL68w56WBvoANoE7bIuOBDi7tp7Mj09dpo4q5Uf6XCfPzy1MhprtLDSNxN2bvyh1KIZt3A+lPhIiXUh77wSWWywmnD1dDrzWu6NIBLGFvNIzGlGN46lxyZ5YYyQzT2BkbYWwqaD2scM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=XPNgh9c7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so11723445e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730404925; x=1731009725; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1gPEduXI+XMe6Dm5bWiV+D66hZVETOkYyz3aI9yIIqU=;
        b=XPNgh9c7MtaX1g3kZDeksVVYRM8FpqFLJiLZYh++w/ClY/h4JkTdK+66VUzZATypez
         vLel5IHtuDM4pZKzYsITbHGhLHqASsI/FfRqkb3+hDzPpVUjuclYvdPYmcZOFWlmENS/
         4aJ3E4VB42QJi1sFCNmztHwFoYFGFUNeXL9d/1PkpAjHTJHsJYmJgUmVBxFSv4SnmQc7
         XW13jNTZ3dGHbzns1IPzX0bUXK14N8VAafrfauOFuGDEr8SXirYusaugjTrbPkauHFN+
         ltv9Qi7GJmvuVB77OzzyvywT3Xzi0UTE8J3P1hxfKylPBBdSvQKHhnL9FrUlBQfz4spF
         hXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730404925; x=1731009725;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gPEduXI+XMe6Dm5bWiV+D66hZVETOkYyz3aI9yIIqU=;
        b=CuD5KCEmYS1atlcASR9v2J6oiJeikeJ6n/9QXC8Y1xConvhMgxqJuTGJfj7E2Uomcn
         6YrHNpLD7MbsSSI2E5/w1xsYBvg8C/+6KRWD/B+UbQE7hEyKu0DeevppASPxE76oAKab
         th3AYzmz2l3YYBs2ntWydopkPLxFeampXCYVWRzz1ZEr3rymtmSp8ikYXK2G1MoWKYQP
         obCVVOjB83Gom08eK+0wYX63/yyB5XLPV/5s4MvPe7WEy2+eje29+qOtzuIGl3EcYyqa
         RsF5qnwdG+KI3gU1NmFIfcQMIpFWEbJ7qAw7PB3Nvc4JaxrVSLKD/ogQSMGGC0sJhb9f
         7hgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn2pPLV4PXTp0szSNKI5StjUqgfD7/XbDneeEBs1DprcfCPyPeKcjSdfSNO9yqyZ1qAzhv2s3XU8W7rns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaGJaM9vh80JcE1/fdEONSxXIvsku/L1cElSYQhuwczph7ruC4
	Ap5NvFifEgiHI6NtePBloNy9YOSv0ETGA+nClyGJB+/BiWFbhFkQ9QktMII3BDq09rPiqndok53
	b
X-Google-Smtp-Source: AGHT+IGBYSgTZbJrlfDKZLP7kcrkgkxX/vih99iJkm8GYhF8BuKcQzph7Yrmgl8WnNkSLt5YSmea7g==
X-Received: by 2002:a5d:6d05:0:b0:37d:4cd5:fff2 with SMTP id ffacd0b85a97d-381be764d8fmr3245266f8f.6.1730404924872;
        Thu, 31 Oct 2024 13:02:04 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:f39e:5519:d578:740])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c1189123sm3003993f8f.115.2024.10.31.13.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 13:02:04 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 31 Oct 2024 21:01:53 +0100
Subject: [PATCH v4 3/5] gpio: sysfs: emit chardev line-state events on GPIO
 export
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-gpio-notify-sysfs-v4-3-142021c2195c@linaro.org>
References: <20241031-gpio-notify-sysfs-v4-0-142021c2195c@linaro.org>
In-Reply-To: <20241031-gpio-notify-sysfs-v4-0-142021c2195c@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1117;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=MW68g60TEyuTeEqNXNwM1N7WdnOvX+cyTXG9bH58n2A=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnI+I3m8f03GVVwHU8kH4TDVsfKfCXZsPvSgUIR
 qUK4XATNYyJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZyPiNwAKCRARpy6gFHHX
 ctjGD/4uCWXLERvN+D9onG6oz17et5OWI9Qcnc255pX6RAb1J7TPgAeTUDIO/BYJ9tVvuTChhq/
 Y3qyL7lerbZGw38TFPZufpRrinZvYhM2KOfgaMcuEf7PEMTMSVJCXIrZSwamMROCPhh56Ci67Kl
 DjKloeKVrPXJbx5OZ9dFME+JTsoGQx03uImflSuS+LQi/CcOw/wYBSnBMIBNrN9YPXfmfBYX+zJ
 3+4ALAHwOLIHLsanzSJUAA3/xYkWxjtkWym+zhOjpkVeJwB2aWDubirBbKJpJm+uyIaJZ/lkrXN
 S6OEK7xonnipE29S+2MznQPRld2nME6bR+ZkcSI54usUybTMdUiMro1OnVOqSqRbfO1sYTOMepf
 Evz8ZcJ2LY8jVpBEY2bnCgavoSljHhTx815mhZuAFDfwKAy4SX2V3ct2INqXLOk1eQOPpPGuW4f
 N4hKoD8r7g3Dqi/uvyC60c/vCZXb8evhaqfiSyQAHJdNQGsA4OlJZKhEHFzAIMd3sGPvr6FCc5Z
 ipAt8LOqEkewZwWjb0XJI5acG2HPRtXS8+PepjXTkNl9HO9MGO0/IjTYMrK0gGYkYmDbXiPzSzp
 5ONHqGgglXJtBLFRxnBl20eFkTAA1ypuxqC2PepBQ3c6wwrJezYLJ/Rp2Af4DBUgRcgg2zd5zre
 JcDzYtimkq2LtNA==
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
index e6c1e26f302d..dd5e850c9517 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -21,6 +21,8 @@
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
 
+#include <uapi/linux/gpio.h>
+
 #include "gpiolib.h"
 #include "gpiolib-sysfs.h"
 
@@ -471,10 +473,12 @@ static ssize_t export_store(const struct class *class,
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


