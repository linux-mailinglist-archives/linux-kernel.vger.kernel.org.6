Return-Path: <linux-kernel+bounces-371306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0038E9A3981
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FF791C2399C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C19118FDBC;
	Fri, 18 Oct 2024 09:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="cmc6gHlW"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0CD18FC9D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242625; cv=none; b=TJ8gjgHURaydK2+LWTWrVKFBgWKC1HAxJ9s5sdnfgPRnf9Eeij0w2XS7rtQRIprIPMAZU7qx5IMhL/4XIj5ojn4Xal4qpB/Vo2Gb0pvjxN2EPzw+NRXjgvkJ9/z7N/wmDocFszABtY4bTt/NY+XwfahuRnp22NOsmG9G6oNJjcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242625; c=relaxed/simple;
	bh=POHh8g+2CvyZoU0L+E1KmaYOw5grZB9aKoaGo7YEz6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aw1nNcLTd1x5FGRQBgrYY/0CkCB1Q97OXljolN5U5H6Cxvt/4GNZ48oq7cykSiExym4UMjid1uDTDbud0r4TF8xSItLeJUjo1XYLo9IfLolyaJSyEyc9JSA3HG7mamWi0p9qDgzTYMe5kHoVTQdirA4YvK2YJrLkp1KKqXkUuYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=cmc6gHlW; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so13979985e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 02:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729242622; x=1729847422; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OB/wBkvSEUCyn6Pce3Sw/d9S+YTAmxmeVBF6YPbGUIs=;
        b=cmc6gHlWIwopCwS5AKMP/V9VXtEuVuzDAepr8P3rRc8ZSL3liQUVbja3tHNHKVl9w1
         dIjcMNr4Ll2jGa+p80EA1Q1YE0JINAeCqV7ved5sKmaGQLXb8aAR5CqabHgHFnaiafQ3
         MFcjx/l6aEMinUSfAXRcc70DmJ5K2jbF97Q79xPE4c2xGuVv7b2olLVYPyoTpl1Ldo8H
         XIiOWTGAvgI2LmpHwH5I3DofzWjU/WeGQYHgOMr9p2s3BS2JsfSYfmK1tRMmaCJNuolL
         8wIUqEUnfVXcL+QK427z5BUobmTL6w192nehJZMXlQeF3jeWc1pccvGka55T319wFDwD
         JOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729242622; x=1729847422;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OB/wBkvSEUCyn6Pce3Sw/d9S+YTAmxmeVBF6YPbGUIs=;
        b=BgmuNw5JbUAlCB2RTdbdQYanXfi0jkiUF9eqxfnJlmi0QA3UrMV8ta5g2Sws9VH+Bf
         fmFfRyQvoUERR5pSglAVKQBrJqmn8lnmBexgbgqxclNIn03dfugCNVCnGe4ZCS3aCAJq
         lSR5vY7FSHCgb5p2eJcSunWviK5kB4DIcl+Ci5MGXtlGJLXaadG+WoER9biwS5Llu1ZC
         y0VeuddixU8GL3kYHQYF32EFGeQpIdEkkIy+ELQUIA1VsWoIPXzFHGlZTLjnZQ8LJEwa
         QpbBRgUa5Gw4l7Ui4+bvgx3U0iKZoluYKubiw2RrR3WPE7AsYNLt+JPqfnN1jXfz3P2u
         zSHA==
X-Forwarded-Encrypted: i=1; AJvYcCUi4+YRzeXsUzrDEZH/1iM16c832tlN44gOpF7MdeXwVKAm7m9qH8wqISGYyrbE8e5Yg0h/QFBlewHD0CU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr9IkopUch/ZyB5v1cyFGWNnuxf4AyI1wWSJM5HngBKGkQI25E
	0HWQxAGxKRHw2aay/gpIyhsNmBQi6kOpG2EzO3X3s2pdjzxdO6pikw2po1/pLhnHgedGMPZRKkZ
	U
X-Google-Smtp-Source: AGHT+IEVba/x2vfrV7MnhVpSziwVemnsNgRs635JXjcpaYVImGwzKfYkyV2Nszc2wVRKjFRC0DN47g==
X-Received: by 2002:a05:600c:34d4:b0:42c:bae0:f05f with SMTP id 5b1f17b1804b1-4316163664emr15360435e9.13.1729242621898;
        Fri, 18 Oct 2024 02:10:21 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:45a3:93e:5196:d8ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160dbe76bsm18700455e9.10.2024.10.18.02.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 02:10:20 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 18 Oct 2024 11:10:09 +0200
Subject: [PATCH v5 1/8] gpiolib: notify user-space when a driver requests
 its own desc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-gpio-notify-in-kernel-events-v5-1-c79135e58a1c@linaro.org>
References: <20241018-gpio-notify-in-kernel-events-v5-0-c79135e58a1c@linaro.org>
In-Reply-To: <20241018-gpio-notify-in-kernel-events-v5-0-c79135e58a1c@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=782;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=zMsMSJX1Nl0+caHE+JZSEzX7KhbE4YG1tQGrQmi8r44=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnEiX5N1KXBf9WUY2Laz9GAVO5bnVkySdSQ0wcp
 xnhXgiresGJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZxIl+QAKCRARpy6gFHHX
 cuhFD/4sdt+m349SvCqaLbgaJzhOalvyDBQBKP2uSU7rBKAUl7KbPkaSEm3cbHfiflIEGGSd10c
 Rm1KJP0+D8sztYsthxt8cScGxvroiwGs9FrMI/yNNirMviUpHP4z6LvEJ72Gxy1bZE0GABTvHAW
 wIHegWJmVM9VrPbJMnq5a22rOHdjGgnnApN18HDpK+Hr0fqVNLaPHYs82i8pLFLr+AFHr1lcbQj
 fyZ7P/eTQoIo9+JlCWDtSRggkCeKKToWsdspsR846GeX9BLZWVecfxIBBLlMKugugc/ctlGhWRr
 3vbM/xOjLoo2szCNwFqbFm+ig68Jzh2V2O8vww1LZnBbI03MQIcQ7lTwMDbElv5z1YgjR9xB11V
 ssmQPQ1KBZVeaTMgI8UgbJQwIdph6U0Ox1Xso+C8cqsCr5mqxzg6Fd83GVyG6MOL4um5xFMeXz0
 jRgV1sr5rJCi0YMB05eq8spzYSIkGrqjo0DCwQZCqTU4EZAei4kmAaL5s27xrH3NdF/5zC0Fjzy
 weCgbtc+BMGmMlBMwbiyyxaLrI+fhK08+M5QUIRN4J/khV4/9JydKA/iKGmLyEmnXfiN+51tlTy
 6w7Vt6QfuXEbUxDfKaJDPqxeywj4c7Oosb9hq1e62dd+Lt6azJZDe1YSZ/VUICBAL2YgeQkdwf4
 1c5VFIvaP5fSC8w==
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


