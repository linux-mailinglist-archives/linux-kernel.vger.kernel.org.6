Return-Path: <linux-kernel+bounces-227162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D03B491493A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63DF5B226A5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8600C13B2B8;
	Mon, 24 Jun 2024 11:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nddFDd10"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0722C132120
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719230334; cv=none; b=fs6u6n1NOhRI9hZD/0u1DZvXLPgBDnAGSEEFfxM9Q7+dsoe8vtZZd5+AGZUU2lCpzQA7Xq1uuEDhwBRnTRSULmOmQeUnKYwvVWwdUuulLBNcuWq7vmUkBf+1XkmOCzqXdsmHuJ+QVNx3zF0R7rbNGi9njB9ADKyurH1srnN3JSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719230334; c=relaxed/simple;
	bh=ET5PzTiR8CY5wEXgR04qOswY/PTwSdgvSu+f3g6W0dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGrXitz75DScTxgf8UARIDCSI3EZo8A+UoT2gDtc7Fsnb94UxG3uOeOw6L8ctySUTMHUzGifwQL1ZxvO8Kla2VTZBTiRg8dH0NDfY1NEzv2PZZMnoCF3+K3JpsmEPQc2VyOY51DWFO71vOx2iUBl0ayNbOZeE8Rs/XAVjfJbzLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nddFDd10; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4218008c613so35190265e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719230331; x=1719835131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZ+EYada3M+DhI5bO4cal9W3HfNJ6HHzkYenkSYv3p4=;
        b=nddFDd10egwhr1HnPDQJbdPmc/6lydulfzH38sFpw7XNWMXnBoiBi7geYu8gWXGs0s
         yo92WDY9mKcJz8E3FYHWmrZ18ULrLpnUKipAmST/cAAzqW/EfSRdwQzvCQMJgyd0E2vm
         Iumt9BaMPaXm2eUmSKNLVB8kgKzAP9mJDn21GExUcKM/6ucuhsFxZBnuCryff2n0TNMF
         sqOQQQASpdtKpPnU1hAFTbbejzSVuTlK96N8CQPQiY89N6eSlJ2Hr1GcH5z94Li6HqQ7
         AwCb2CiRekHCkAvW0k5YitBtZ0XuWIjKOFE1VZ+QrkDu1PVyeUv/ijn4Aza2gTEyGwEQ
         +0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719230331; x=1719835131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZ+EYada3M+DhI5bO4cal9W3HfNJ6HHzkYenkSYv3p4=;
        b=wymDxMXlDvaQ/Xd33eYadWcdePo8DNK3Y70DKxd8TtLwDJ4oN5xMsblXXAm4erEdaq
         vkPLocYekG9eOg/jnwftueK1lPbUaDLmDz47K/PoY4GeAFhAJTnwseMmdTmGW7BNvnKK
         0sgPbsRjJzm63Shi9IYIbANI7SNSYhlgxvQxfNAQ6otQca97U8dV01lQyP5iMmGL4l/G
         A2b86CrOmPdWaDBDcbSe+hMZ8HGdGNsySk+UZC0Fz5TX/MgQ00NY3vNiuftnQHmqrf6c
         4gKCQQmsgDoFa5NvPITi+lI+s46oZY4a0oC1QLpQHuokwBbnVfBTwV+MZ3jr2FNFkH3x
         zfmg==
X-Forwarded-Encrypted: i=1; AJvYcCVYo919yOQTbSxlF219LsBSB4BxEMGkuqiJlBmF+/ITrmPJ97pxpyNUAkcpRFLTajmNXPW6amA0OLLhbgyBDJhIgXOA5ByEwo/OR2ji
X-Gm-Message-State: AOJu0YxfGcYCvyBL44OswCqposDGvTiMV3e1hAafs9oxDYuMQ0gU8tb/
	I0TXsjp5Lqyac58t7pb6LaJiVfoPJPXm4Br6yK1yVGNxaRpI2j26csYvmka1TXU=
X-Google-Smtp-Source: AGHT+IFQOBs9Q9kpMeeHwkTkEiiPNuh/i80msIiQi2SNMcPI3xuZe6BNwdB4fNnKSvKyF9UVAU+u4A==
X-Received: by 2002:a7b:ce99:0:b0:424:7d6a:dd2e with SMTP id 5b1f17b1804b1-4248cc34efamr29712005e9.19.1719230331193;
        Mon, 24 Jun 2024 04:58:51 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b80e:a46a:7fb3:4e3a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247cf5272esm174612045e9.0.2024.06.24.04.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:58:50 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Keerthy <j-keerthy@ti.com>,
	Aleksandr Mishin <amishin@t-argos.ru>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] gpio: davinci: Validate the obtained number of IRQs
Date: Mon, 24 Jun 2024 13:58:49 +0200
Message-ID: <171923031937.22973.12976812748644513949.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618144344.16943-1-amishin@t-argos.ru>
References: <20240618144344.16943-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 18 Jun 2024 17:43:44 +0300, Aleksandr Mishin wrote:
> Value of pdata->gpio_unbanked is taken from Device Tree. In case of broken
> DT due to any error this value can be any. Without this value validation
> there can be out of chips->irqs array boundaries access in
> davinci_gpio_probe().
> 
> Validate the obtained nirq value so that it won't exceed the maximum
> number of IRQs per bank.
> 
> [...]

Applied, thanks!

[1/1] gpio: davinci: Validate the obtained number of IRQs
      commit: 7aa9b96e9a73e4ec1771492d0527bd5fc5ef9164

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

