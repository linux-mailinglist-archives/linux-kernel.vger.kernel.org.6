Return-Path: <linux-kernel+bounces-369399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A0A9A1CD4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367451C2724F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371F21D2F78;
	Thu, 17 Oct 2024 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="TxxGpTwx"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4F61CF7C7
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152872; cv=none; b=l2IGGn2JXxENko5SEGu6JUvrNT0UN9nJ2/WdFCrcuorPeGj4MukQuzjbORj+9I5JuX+uhywGsQZtXysAmm9jCQHsz7kvxo9y14I6QhlPdgzbZBEVTcU+PuynO08DHrAOHIajKCspP8xXw9bs7fYQFzPRO7QM8Grq1qNY16myarg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152872; c=relaxed/simple;
	bh=POHh8g+2CvyZoU0L+E1KmaYOw5grZB9aKoaGo7YEz6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ipOLH5U3VqrELyWFLOoyiWTwcilZWF70eLyCLX4BaH28jr2uJ8+OlCwXqmVwKjj7K2Tz9lWAXo+xJfNYzFTy8pWZMAjEkpPzK3McvGvZ8NwzM+Fl1zc8flu2nk6RHIcVx7bQ70gDSR0Wgs6dkOOBzgUHFgrvnl9czFkio3P5JrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=TxxGpTwx; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f84907caso824964e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 01:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729152864; x=1729757664; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OB/wBkvSEUCyn6Pce3Sw/d9S+YTAmxmeVBF6YPbGUIs=;
        b=TxxGpTwxES3o/RKFvyDwnAMwVyIgnpZSed7J8NEJ/2+KBPx3rxk78RFPvly6bPPPe1
         sqIk15Tq8ARXGtSEqR2RiKHUYrrF2SeP1XfPdw8lIan3oVEKTbD7VqjrlV/mVv9G7aCb
         fugp19M8vdz27uQGm+YHSDHGTVekkqonePHdQJJ6qBPGVwlWHRDSUZT5r0MQKNxfUASe
         EcJPBezCjjUIMm5b9QgmEXWW7EXxydKIzFzL3yhT7r4QBOFv7gpe+S6cW+Zo4AzJgmVW
         fBozIrlhvdtIk4s0Jw0BOxyDpQgQ7Mdco0j37KYeWGR3XXV0RzVjDWelpy0KMlK0yk2c
         U/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729152864; x=1729757664;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OB/wBkvSEUCyn6Pce3Sw/d9S+YTAmxmeVBF6YPbGUIs=;
        b=F/PvxS+t8+ivmiMZOZcRH0uHVvlEUc8ZwUrxwZyLmPctjzMBYJ79YQsSHdY0EEnCur
         PBMRlt9Sp3maPKdmi+RavHpzFlhD30yAtxs+cq4ZQDsBc4KnOCUDVmL5KqBHY2vNvDd1
         h50GmXWtMdxwsLexI+oCck1DHiQi7gCokq091mcpG7Z4Qgz8xtLDMoFQiQvEljUzNP5i
         YIHhf7dARGFKkMQSSzmeYCgE8jAgjt5mQ0rMVPPVKvuak20L57BAZb3hHqNmnft/NqVd
         1bpSgPlGJ58kS/tOkFzDHZi2VVpMatHuroMP6gvc8OSlBNz/0RrhyVV8Nkmp9AyyE7hp
         dMMA==
X-Forwarded-Encrypted: i=1; AJvYcCWMXR3EwIf7f+3R9yxm29jMOJVn6GyleulKMtDT3unV1YuKlnIHi0Fa8pKgzDgrrP1Caj7DNtZNsJSHFEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ+eRKwkkMSMhwqpuOEnGbsZFVHgy1mQLaW9WQx4uIsMRAXvyq
	zgSNIxBhGHYxHVAA4VXPO5IC0awAoo0Vq1MnAOX/s9pVY6opYbRJXQEsQqIxIEs=
X-Google-Smtp-Source: AGHT+IFRnHFVacQn63nVwfrSGciFYzsNocWAWHtg4UziLMgw64RaHnmxTESwoE68vQdpohDATLOkvw==
X-Received: by 2002:a05:6512:ea0:b0:539:f471:bcfa with SMTP id 2adb3069b0e04-53a03f18296mr4890823e87.14.1729152864395;
        Thu, 17 Oct 2024 01:14:24 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:3831:fc61:16eb:d0df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c61ae2sm17855695e9.46.2024.10.17.01.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 01:14:24 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 17 Oct 2024 10:14:09 +0200
Subject: [PATCH v4 1/8] gpiolib: notify user-space when a driver requests
 its own desc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-gpio-notify-in-kernel-events-v4-1-64bc05f3be0c@linaro.org>
References: <20241017-gpio-notify-in-kernel-events-v4-0-64bc05f3be0c@linaro.org>
In-Reply-To: <20241017-gpio-notify-in-kernel-events-v4-0-64bc05f3be0c@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=782;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=zMsMSJX1Nl0+caHE+JZSEzX7KhbE4YG1tQGrQmi8r44=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnEMdcHXhTx0y5m8JPij1Ef1Zc5QZ1ycidlcQUc
 uaji8i8gw+JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZxDHXAAKCRARpy6gFHHX
 cjAaD/9yKJH6txh1M0Oi2hTCivfnX3YO/dSu5lRS6NPhWUNYQ4V5h76Ns8k1wDh1FvKOHTlJsNA
 xrBqiIiFSfXdIf97ceyyAVcRKPR8vCF8O0chLadgqDA5cSo+A8JN8GfxLFQn+dUnBJYdYBE8Ehg
 dZ+Kf+lFAAGRutsrDWQrMrWbU7Ww1VYsAHL/K90Mbu/KCwMfQeJ8Gg9hvWX/vjaIAG6kaAUkM6c
 trHoGhz6X5GvoxIHKaH6tjJMvljez3/1cKVBu52Me2yGGirgYKG+wDKZVmRawRjMxwAMBht+MD7
 gyRZBKZOacWI2hyO6h4ExRkPEMeSuV1Krbjh5w7AFnnMV0z4LraN/eIoXFIUUceTlTaYibi9cDn
 vxJ80ysO79/jbXUYYzdcUkYTZPyV32+zt0kP70m4jxf9PxAj/8rTN3tyH989qXNLBSELjGosILQ
 67bZsa/y2oNE5hxbLDAjp/ig+9hETn1gFZiNa5bLn+pjgFjrcW+hEAhT8WuNbjkAxOqmUvKJkwA
 gk5jorR6IWr9hoQhE1iGDQ7+cpTKAZ/xu4ZTnpVsKG7AhYcOIC/8W459XD7PoP9EH+1KAqzNQkX
 Poy39h3m3noDJFx5GwjYBg92KuD8hYpnT7UbODhVPNg+s5GFcTQzvUrsJpwf0oYcM4AswcYdRCa
 TGMw9nDmyscoFfA==
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
index 97346b746ef5..c09464f70f73 100644
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


