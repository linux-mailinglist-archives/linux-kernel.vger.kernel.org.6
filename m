Return-Path: <linux-kernel+bounces-236724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E93D191E650
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638C81F23D84
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCDB16E878;
	Mon,  1 Jul 2024 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0QMxRpN"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F77516DEDB
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719854046; cv=none; b=eabjwt5FVev8gpjsHCfSahhf6hAeIAmyzP41I7OHwLEh2Y/qK9PknqTuqaKrqaERdTs74VKnB2Cgquz/4jdNKj+GgHgCHjVmIDtL88LoIoDC/KXe9SXLtDiq82rB1iINIU9ajbXsJJL4dHJOpMZWAdi8bhdZ6U3IdQXt6HxUs+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719854046; c=relaxed/simple;
	bh=soNFMTXqvnJ/skLf4fDt+FvRIDE9YVypE1A1VixjJLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A29XynAYxrLqLqIGGjmC/UoaWeSlLTONkUidqiOOEFnijZV1o3SU8zmbAO+Pet6nIi9/rKpfgo1oDAUK4EHUBrx4AnFqO+mXtgImb25245GRaaw4RaR3L1WhDg4Nc7RwnB5+d9uLUx3NSoj8j83b9eh0XR7ld9PffokwtbaEyHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0QMxRpN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f6a837e9a3so12827705ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 10:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719854044; x=1720458844; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9y9HtobYTsL9lsUARztMYt+IEviuG8O5D8y/lX2WyK0=;
        b=R0QMxRpN8L2D9YYUYjXVNfMtGN7i/0+ErHgOWe0Aw4XLce7Ej+0StAc2t8i0m5YIXf
         lN353OL4lK7BTkpsJjUZce508cEr0w6pORByB0YxZXDeV96vd/Yqj3qUqnkKJAnG1IR7
         Bsf9T3Uzp0jzC2g6n4fde3oYjLQu9tr7gsNuQpRrejExnhtcZpHQMUJmuGFWWIznQwzz
         85fb+s0zkvE3uEER+CbGlawloql722t5UvBD1KjX1knoQI3IJQrIZ9F4bRftVlgl/7y/
         SQr/5BO/kpElNqb+RPKXyzt+0XPBtw1EesvHqK1hMkc+rjV9zCgf8j8wyUv90djMZKip
         BWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719854044; x=1720458844;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9y9HtobYTsL9lsUARztMYt+IEviuG8O5D8y/lX2WyK0=;
        b=L6huhFwgMVpzv6Y545LNMHH3ifbzXgaUtuhGLuyExRhAi94Lxa9nVC6x5/qNp5yEys
         +wduEp0RuVL4nO8hB2NoLx8YTKZvFOuYyG03v6wSFvPUdpsris6pi7zwZOkqagw5qfQ6
         b28eoD0LIPU4XpFRFf8PtuGeoY7TJSvntdBuX8jK2z2c1/NecXOQ90gd2d0ru1m7yWca
         /Tymp9idZSP4s4zKkiaHrtKX/3xC+X6PAabIbx05vx3mjsmFhhsW/LtkM91XPJXwF+Tw
         xP7P0Ajypa31r/WYQs6FsfRYOIZO2TRv22ix+nrKQw3TGRygtNySE2wMo8VxyT/L8HxE
         N+CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoIv3A8SzzptSPgmSfWI6nEfhA2GfOH5D+XAB03cbK/iLrBtkG6cIeLEaANt9iDWN3UuDDN3JchqgX5gMWUF5A3jkeVpxiNg0G/xiw
X-Gm-Message-State: AOJu0YwnsRn6ZESLAf8/5CBcIN3hljOTsSvKU+dYXXdINj7VscgYqSNn
	UdBxjvhUak6PbEa2/gWJuMkmHP4KGr6AeX1Zb7AKLet+LNpvPhio
X-Google-Smtp-Source: AGHT+IFCXZh7IojJbcFrrRy6loF6IABawUbnmNcbJQxAKGFxrA/osfAYya6mGAyr6FZiC0gkQ7xT2w==
X-Received: by 2002:a17:902:a3ce:b0:1fa:221e:aaad with SMTP id d9443c01a7336-1fadbc8ebb7mr34095015ad.29.1719854043753;
        Mon, 01 Jul 2024 10:14:03 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:7783:69e6:8487:f6ab])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1538dc2sm67613675ad.170.2024.07.01.10.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 10:14:03 -0700 (PDT)
Date: Mon, 1 Jul 2024 10:14:00 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev,
	Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>,
	lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: drivers/input/keyboard/applespi.c:1833 applespi_drain_writes()
 warn: mixing irqsave and irq
Message-ID: <ZoLj2LL0NzdS1gZL@google.com>
References: <3e789ab9-ebfc-40a2-b90d-b8b55e0cfaac@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e789ab9-ebfc-40a2-b90d-b8b55e0cfaac@suswa.mountain>

Hi Dan,

On Mon, Jul 01, 2024 at 06:30:38PM +0200, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   6d6444ba82053c716fb5ac83346202659023044e
> commit: 038b1a05eae6666b731920e46f47d8e2332e07ff Input: add Apple SPI keyboard and trackpad driver
> config: x86_64-randconfig-161-20240628 (https://download.01.org/0day-ci/archive/20240628/202406280337.1Av9qm8V-lkp@intel.com/config)
> compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202406280337.1Av9qm8V-lkp@intel.com/
> 
> smatch warnings:
> drivers/input/keyboard/applespi.c:1833 applespi_drain_writes() warn: mixing irqsave and irq
> drivers/input/keyboard/applespi.c:1845 applespi_drain_reads() warn: mixing irqsave and irq
> 
> vim +1833 drivers/input/keyboard/applespi.c
> 
> 038b1a05eae666 Ronald Tschalär 2019-07-15  1826  static void applespi_drain_writes(struct applespi_data *applespi)
> 038b1a05eae666 Ronald Tschalär 2019-07-15  1827  {
> 038b1a05eae666 Ronald Tschalär 2019-07-15  1828  	unsigned long flags;
> 038b1a05eae666 Ronald Tschalär 2019-07-15  1829  
> 038b1a05eae666 Ronald Tschalär 2019-07-15  1830  	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
> 
> _irqsave() sort of implies that potentially the caller has disabled IRQs,
> otherwise we would use spin_lock_irq() if we knew they hadn't disabled
> IRQs.
> 
> 038b1a05eae666 Ronald Tschalär 2019-07-15  1831  
> 038b1a05eae666 Ronald Tschalär 2019-07-15  1832  	applespi->drain = true;
> 038b1a05eae666 Ronald Tschalär 2019-07-15 @1833  	wait_event_lock_irq(applespi->drain_complete, !applespi->write_active,
> 038b1a05eae666 Ronald Tschalär 2019-07-15  1834  			    applespi->cmd_msg_lock);
> 
> This will renable IRQs briefly and then disable them again.
> 
> 038b1a05eae666 Ronald Tschalär 2019-07-15  1835  
> 038b1a05eae666 Ronald Tschalär 2019-07-15  1836  	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
> 
> This will set them back to how they were at the start of the function.
> 
> The issue is that if the caller really wanted IRQs disabled, then it's
> not necessarilly a good idea to enable them at all in the
> wait_event_lock_irq() macro.  I suspect that in real life no callers
> disable IRQs so it's not an issue.  But anyway, that's what the warning
> is about.

applespi_drain_writes() and applespi_drain_reads() are only called from
the process context with interrupts enabled, so it looks like we should
simply change spin_lock_irqsave() to spin_lock_irq().

I am taking patches ;)

Thanks.

-- 
Dmitry

