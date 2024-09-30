Return-Path: <linux-kernel+bounces-343564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FD2989CAC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990DB1F21848
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4587178378;
	Mon, 30 Sep 2024 08:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="AjVDaqN5"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7A4165F1E
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727684561; cv=none; b=XkSTuwHVCm0okxgjkPeHjcHv43wD10ToLo1pSEoswPqC0TizvIwHzJcaIxhQXN7ol5tJUyd+efSs778pHbaRlli5/mtDocwqqSlZ9BEytxmhGbbfbxGYNi6ZgeMpc7PR2Z/HQOr5m4gA9OSazUk+7G8aALfCVyzGaV8TcQNaAYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727684561; c=relaxed/simple;
	bh=jAyQ5z//ge6upJRh90LG5/4z5YzQKZ1YE/rxqgzzDCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h5XlwVEIsPXtmtmij/wCRb6dE8xqlwdYicWMqgj6dETBVsucs/+ztz4wOFvoQ5TudP/I02NphExKn6KZJCitb8OWhuxKBOrd37bLFJzdjvVezGyhC0nhLKHPYTLBp7DBItF6rN6OVWRXGhq0xxOfO+il9/cOnQvY+5vb33He6kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=AjVDaqN5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so39306915e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 01:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727684558; x=1728289358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHqObhGRdeHLD7sYS0ZFtby+4VazJd0VGtHv0LVcrpI=;
        b=AjVDaqN5JmXXAGVjx0bwm31Rcssd1XAxVDvdSkfPLnlj1+egK6KGkbWWTdbFuPrNZj
         j6pAlLJYLctze4XUS6HhIIld4zHDnCyVup9gXgIPmCcdMKvyrcU18V/rCD8qFUKQlCvb
         F/BpDNC/WKyXX8mjiap8btcP0npsXDHtxXqwptSuYtSkxvDW5JuZieA+cW5GFtGmuwER
         VOR+TsWVvxD4vhhNmRGoxt+kaloglbKVex1+DWUAhE6fDRsyT35q7M0zWIOuJ18xPM2u
         /fP7Li15TCRejQo5u1wdaI62Lw6HBnUV+fA7xvTHHiMcSk9QHDeZWs38suZ5/Ltue/9p
         NUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727684558; x=1728289358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHqObhGRdeHLD7sYS0ZFtby+4VazJd0VGtHv0LVcrpI=;
        b=SNuhPvfcpXwqDzxEC7etPJ6Cf46l3NaoPy0tfatT8GkTSNv2VgcjvG8ZAHyvUjIQGy
         08HohRh3xUoeshVcjXP3mjxt2PwYnTLK5JffII24DiTgy3mhfUTxbtgkO10Vj6qN5xP4
         TsX3qDhLB7i/K8xmIh8QLcVgZB1/JK7/1NH9i4nAFLEaaYDZ3GgCTpg+2TsGW/DqrybE
         Ev39Ho8M0m10qGn7JU4C7nCFvYHGQQWdd4TfOZCCO6htosDVLQOeXPmdd94pS757vuU1
         jTYexCtfw9HID9QWjz5F0wVQPpUO0547iyVMSgAAeI8GjmE1B8YINW8WRWnxWlLPkrSs
         m/Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXxL0LNPNxio8caO0SIoVfQUrQ3t5YGTOQB7/WlqgvcaJDe6Oq5J4IGWpC7aQaAE0RtmZ68VH/m6qkFmnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc1Gq1+dEggI8beoDXNfIoCUBwWOBKS99/rTZVQNdhSf7JBr/x
	1LiV9EmsmiREvPBapAF4yllSd7SFynShJ3i/JMk00q6m3m3gnOSFTAzsL8qHSz8=
X-Google-Smtp-Source: AGHT+IFJwgIALLLvKWxIbWeECxXnZbaa1REzw6yfyuDfHJ8ofYfzg4yn2gJPrTUiDYT3hwPmIIO69Q==
X-Received: by 2002:a5d:58cf:0:b0:374:c69c:2273 with SMTP id ffacd0b85a97d-37cd5b1bb77mr6296782f8f.37.1727684557630;
        Mon, 30 Sep 2024 01:22:37 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:8791:e3e5:a9ca:31a6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd564d01esm8522655f8f.3.2024.09.30.01.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 01:22:37 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Herve Codina <herve.codina@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] gpio: free irqs that are still requested when the chip is being removed
Date: Mon, 30 Sep 2024 10:22:30 +0200
Message-ID: <172768450502.13259.2790852008542028745.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240919135104.3583-1-brgl@bgdev.pl>
References: <20240919135104.3583-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 19 Sep 2024 15:51:04 +0200, Bartosz Golaszewski wrote:
> If we remove a GPIO chip that is also an interrupt controller with users
> not having freed some interrupts, we'll end up leaking resources as
> indicated by the following warning:
> 
>   remove_proc_entry: removing non-empty directory 'irq/30', leaking at least 'gpio'
> 
> As there's no way of notifying interrupt users about the irqchip going
> away and the interrupt subsystem is not plugged into the driver model and
> so not all cases can be handled by devlinks, we need to make sure to free
> all interrupts before the complete the removal of the provider.
> 
> [...]

Applied, thanks!

[1/1] gpio: free irqs that are still requested when the chip is being removed
      commit: ec8b6f55b98146c41dcf15e8189eb43291e35e89

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

