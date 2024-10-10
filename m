Return-Path: <linux-kernel+bounces-358620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E91229981D8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAE19B27E43
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16F11BC097;
	Thu, 10 Oct 2024 09:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WoWZUyUd"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC8F1A072A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551439; cv=none; b=AjOaMrnf/q/chofauob8ltKl49mUM5Bh2M2PK9KSXl4I9FUjt8bLgI1msgUs+Fr/+v/9uFBePArKyA9yStiAg7iT/kU6vuJNySsc+PY4OFn91v7GLSKsXwdmWL6dlPpSwhEjwrtTHwdz/TULiQFASmrtHNDlBCNPUFeSsd+aOAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551439; c=relaxed/simple;
	bh=HOsD1l6BWkiOE3cTTGyktI+iRLFXrUG9jIksamM5M7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kC0bkA2ucC7BHfdRtnPnX4XtDfVZjR2lw9JpoyqVni3g8iYH1BzuCCS8qqeWixsexiV++KDFcyX96ulKZ4OGq0JT6Z33BN9CZGrOxn4CsdJFCAA0MsJ5I5HLlPXHDoXD/4Z3/NPQOul4w/ufKAHDTz7nqDgSi4RnfabJNfQ5DZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WoWZUyUd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so7600595e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728551434; x=1729156234; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cBqp7nH7FRGHJQzUMuYpdjXDVKUs1/NZNMC262ksw1A=;
        b=WoWZUyUdNegPF+SMDH9OH/u0gE2tl1KZBppR2UDGAZUdI+sSPTQS1Uvyschd7Wxwwm
         mmgjjgkCBB/f61ktA0W8QFyW7alrE9gsOk2KRLZA1B/1KszneodccT2vAhU9c7wDNVpT
         0MCdldPGXGuoB7+Sc9XyKv+qTZT0Ua5lVHEUP3TH/W2TjynR/uqIok91lzZZ5dY7EBlF
         8D9vxXcdk8UXfHICsGzY2I2RLc4KGsgsxsDQzdPS5XPt2TY+CHMod7tQ7zOm1fn8mLlv
         D3kIEs1WR0r4bcvjqf31/7pDFQmVnE5FUo6h/BsNkA9ECoR/ZhqGYdUJwX/bnzfS5W2p
         9/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728551434; x=1729156234;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBqp7nH7FRGHJQzUMuYpdjXDVKUs1/NZNMC262ksw1A=;
        b=D4ReJbl6TBuqi0EZTBOSGf3tTWwN4CPLK5gafuN4LDdvtng2JaiJBrIhnJjypLsr/u
         CzdrFgejgTYH/ZBei+czZENyLcrOnWAHDePZq3HKf5a86DJum1aw7+KVLDxJSHydrNBo
         njcrGk3yL8hHnkhndks4vKOrfhweRhOpyP6ZYFSLcvCardlw6vRo+7xq/EjBfG/fSctd
         J5NK924Y7oQAuMHQB9B4AaHFE1qGECqINOlTYXquQ6e7uQeY23UrdTUKbKGt7IThL9gK
         RBYKWbyFC2qi700Rvy/XRy9nEU38bXtsbLJkOyD9dIsU0Ik0xRgyQJ/nnaPJ0YQsJc9j
         VcBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/QjjnxJWGaUOjpkYyHhPyviFooj8VMUdSqf6bDC0M/5ypo8r05M98kZOvmCVJudHggjzlNNzH/JcMdMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW1NDy01924NFIHeOfPdcKTWLEPNoksHXma1qE/QlBARUdlfXB
	Dq0JzQJh/J93FGaccX54zJIYWF2bHRBwHG4pad+7EwpP07FS/2AbI1wFmS+so+c=
X-Google-Smtp-Source: AGHT+IG0ctsdanhgvXysGVwcpiJpoOdfhXfTc6wITqmuAD30mTyVbRhP1kONzsTctAZyusfu5354Jw==
X-Received: by 2002:a05:600c:444c:b0:42c:ba83:3f00 with SMTP id 5b1f17b1804b1-430ccf04348mr61698305e9.1.1728551433797;
        Thu, 10 Oct 2024 02:10:33 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:5e5d:bfca:20cc:60ae])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ff785sm9913305e9.13.2024.10.10.02.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 02:10:32 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 10 Oct 2024 11:10:22 +0200
Subject: [PATCH v2 1/6] gpiolib: notify user-space when a driver requests
 its own desc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-gpio-notify-in-kernel-events-v2-1-b560411f7c59@linaro.org>
References: <20241010-gpio-notify-in-kernel-events-v2-0-b560411f7c59@linaro.org>
In-Reply-To: <20241010-gpio-notify-in-kernel-events-v2-0-b560411f7c59@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=782;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=6tmLH+37mKaXiUj7ddtJmg9R7u1Uj5EdOPkbC/L1bkA=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnB5oGX9HZAw7QZx6h9L/RjkHntjdlLxeoIu7Gj
 JtOceg0XtWJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZweaBgAKCRARpy6gFHHX
 ctPuD/4iNfOhDJ+p4xU8aHQz5tf3wn/TtiBL9etxDYXIEz/fLXTTu+1jBBdOOrhmMML4p8oNA4A
 fWYrsY7WAsz6zUvAddLaRYLn/ULagpQFCL5UFdMPTw3zU0Px71mGNQmDHsVOm4n6pOzQetZ0zEx
 qRGGdrdM6qpi4PmGyUsWMtxBAED7rzu9UJ1BMqlDTiXWSk+fncn2yXrxJ8617ZY+D7rrghV5uE+
 H5ftFS77ZCML0ysVralby3kYyHVy0H9lhJYrOn4cgaCRF7AEBAvXA6ZRgltgrfvE1GP6JRpwdfp
 s4B4faLLjOTDHNGWoN42U7RJOZs5zR5QiZcNWh+JkCW7VO7LxuGF4jJb2lnRJ4eZdLUSC0Qe+M0
 zrgUaOUiTpnL4Ehy5MN0tfIMKZ3NZ7pyoHmlPYgAf3UqzCa+ychG8fIiiXq96HjebQ4EXbD1HBH
 CTzng9IgiBlJOVV5zgLIlyjs0oFWopf4d0Wbro+dO2j+MzipTX4qqRgEcl7v4b7OzW9O9LlFkoW
 hZHh9y3EPFoZ0zXxHAtl4z4CSgGP7CGf+oLF57dTqubLX3dZe9N45nB1b5PdInskRglWrdDVx6Z
 Au20pjm5kCOcirEKQvLWha9WGNjsPUn2N2wi295CzwqkMLnbepxgn9GH+TYfqre2UaHM8RdJ00p
 bb5Z6JIyW7MiuSA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We notify user-space about lines being requested from user-space or by
drivers calling gpiod_get() but not when drivers request their own lines
so add the missing call to gpiod_line_state_notify().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 0d1e10654d4c..839036b116a2 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2532,6 +2532,8 @@ struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
 		return ERR_PTR(ret);
 	}
 
+	gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_REQUESTED);
+
 	return desc;
 }
 EXPORT_SYMBOL_GPL(gpiochip_request_own_desc);

-- 
2.43.0


