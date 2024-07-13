Return-Path: <linux-kernel+bounces-251327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96DD930396
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 05:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 148B0B22621
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 03:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553121773A;
	Sat, 13 Jul 2024 03:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsB3kQ/Y"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4C1175B1
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 03:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720841696; cv=none; b=MK3fjAsavmTmCp4kQNB7CjrF3rP4exAoqPB236ziLdSK2CF4ktZktlxDhMI1J83XrmTnpccJwIGJizx0zAJrkaNRFaqs+HrrHIJDdOhHSIPqrGV5k01miWcw6dbrvai9FaaBubRtqUzV/HPc1AtpN/ibDjyOx8BmsR/OOQyHqLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720841696; c=relaxed/simple;
	bh=owNlq2Y9PrDO1va5GSFXzi3oRkFi+EBsPRw6UNQjrgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t6pcwocWc6VAnkRUHSQWZNDyn/FomWLHP5aO2dKWMgSXkEqDpVqVaxliVfRj7+fNs+s+G4CsLBTDZPZuk5hXzjGHh80hsgTNlGVSpOXG37GQujWKY1O0EGt91uymMEJjn8+e4xt+41rlakMWM0XheMRCcVP17oSt+8NL5L0Etb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsB3kQ/Y; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d9da46ca13so1335259b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 20:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720841694; x=1721446494; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qtpF82pGCu7wb84OrfErGjGTloI1qsDbavb4Ik1U9k4=;
        b=MsB3kQ/YXlwP0YVSrI6zsSTijyDTcg0mezf8vLFyA7PMLj/7T2rQn0cv0BsEFDS5CB
         jcz5DArLuPnkDDC1e9K2m/nRLokllxgkm8urXlzSwhWpqZWqAfIsyPLVYtob2RqmS4Og
         mVDLhpGFjcKtGTUiGisvDltlL7JNgNARlh3gql4UAHtvWYcxOT/Ezad9jKcsgackRKl/
         XeLw5yMbJwxAUxdg9+vynKsvTtMjJsCN155gcWP+Tu6r6xmmfGirK+lF6BEK91ZSfvRw
         oTg6m5pEuP+N7QbJpKXljzNrMWVc45qQyx2zt2NVtO3viF8oj6FTXY7htJt3MXWUyytv
         NlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720841694; x=1721446494;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtpF82pGCu7wb84OrfErGjGTloI1qsDbavb4Ik1U9k4=;
        b=uFqiEdPUEd78odktr7835oAgJIGyDEUJUdass2YfhRTKR4FjPBA3jlA3iVze5nI11H
         RMZLfxcbDWxLfZ/dOQi6BdMTYAUhkK3vrdCFHNZhjKM9Sz3b8ZUEqeETPyfcJHoSmE8F
         IV2aMjcC36es0W71Lh6obRexhZhQDqwgEIQ+6xikUxZPBFEGKrHrLSGExVlkTCbmQ4hX
         iXUbBdpG3e6G/2ZP28OvWTrLgv20uezWcgY60gIiD7PWdp685Bjf/2WjWA8UHi0wKrsV
         WpzvVCHmlX4UIQp3C7yjk8jdNy7umTCN5R3jwDCGVFnLxmaI7/YPXSm24OgOZAHYLAVO
         zv7g==
X-Forwarded-Encrypted: i=1; AJvYcCWnPQqK7aoeSYZwHAX+6FJyho1Q6tz6up6oe+GRW4tnNWHtIwMcRqZu5maxlCoUyJY/2tloo0Oamda8yTsw1wc9f25rlxJjfYlOfkVT
X-Gm-Message-State: AOJu0YytHux+tW94Quy7kiizrhqZAc14wx34+KrygUie7ggqkUa1AoR9
	FlRGIN7qKmMYZQCmyle4UPFNOsKLNtU7yiRJ3aa7N2A7Df/ykf/M
X-Google-Smtp-Source: AGHT+IEAQRPKj9vObpjqjTMQ1SxXWHqcDPT6yiLFS2pxj6JuUGMdA2t1ndhQuVrWxaZWwgd/m0HWVw==
X-Received: by 2002:a05:6808:191d:b0:3d9:b33e:d3e2 with SMTP id 5614622812f47-3d9b33ed905mr14745793b6e.19.1720841694100;
        Fri, 12 Jul 2024 20:34:54 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:669e:eb9d:e30c:18b4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eba4540sm298199b3a.43.2024.07.12.20.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 20:34:53 -0700 (PDT)
Date: Fri, 12 Jul 2024 20:34:51 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, soc@kernel.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: pxa: fix build breakage on PXA3xx
Message-ID: <ZpH12w9vyZZDdzDb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit 917195d6f829 ("ARM: pxa: consolidate GPIO chip platform data")
tried to reuse the same instance of platform data for PXA25x and PXA27x
GPIO controllers by moving it into arch/arm/mach-pxa/devices.c
Unfortunately this file is built for other PXA variants which resulted
in the following error:

>> arm-linux-gnueabi-ld: arch/arm/mach-pxa/devices.o:(.data+0x167c): undefined reference to `gpio_set_wake'

Fix this by using #ifdef around PXA25x and PXA27x GPIO controller device
structures and associated data.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407112039.cyyIQ3Js-lkp@intel.com/
Fixes: 917195d6f829 ("ARM: pxa: consolidate GPIO chip platform data")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/mach-pxa/devices.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index d050a4c78f97..7695cfce01a1 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -633,6 +633,7 @@ struct platform_device pxa27x_device_pwm1 = {
 };
 #endif /* CONFIG_PXA27x || CONFIG_PXA3xx */
 
+#if defined(CONFIG_PXA25x) || defined(CONFIG_PXA27x)
 const struct software_node pxa2xx_gpiochip_node = {
 	.name	= "gpio-pxa",
 };
@@ -684,6 +685,7 @@ struct platform_device pxa27x_device_gpio = {
 		.platform_data	= &pxa2xx_gpio_info,
 	},
 };
+#endif /* CONFIG_PXA25x || CONFIG_PXA27x */
 
 static struct resource pxa_dma_resource[] = {
 	[0] = {
-- 
2.45.2.993.g49e7a77208-goog


-- 
Dmitry

