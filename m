Return-Path: <linux-kernel+bounces-236650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7117891E55E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1BA31C21450
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9D416D9C9;
	Mon,  1 Jul 2024 16:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sgvA1voj"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8DB4696
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 16:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719851445; cv=none; b=l+0lJE7lGYmoiztz+W1EgtPhUmvejkyTaeyV9Q8UyV6PN00YGIms52Ih/vWdQ6BCB/fywDmdQgdTAtPAcw3MlM9dRbPHsX0Li0FCzEIdHx8Zx7tMqKzfAfNSk5HiuYdVy/txmwHoenUVQ3mHVYd1A5+zdN2HWpsAq58gi2rL6ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719851445; c=relaxed/simple;
	bh=cyBZIZOlVW0uFuDers68bdrFwZZWvwcsCmsyVCP3NT0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qdHTEnVK39p9gDbK9t97t/4zt/V6xkfbUsG+TjGBgIt4106akBXcbgC2ea+92E9nqnQStD0MYJSBbDOwYYYZ4XXGP36zE62PKf3BFnYvK0fulTj2fiOnEgh1O85Hfrf7aRYLeI9cjr2h8ggAdP27usTfn4IDahQI1esB3N7K0OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sgvA1voj; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d55db7863bso2176511b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 09:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719851442; x=1720456242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xG/yczWNA3S6agDnft2zlqDhiY2xh8cwDya0vX2WWTc=;
        b=sgvA1voj2jNw7u/rqLSpGPhk6F4Ve0CDbLXDcIYPDSGFXR2ZICFVeuREQgYKE01ADi
         vDzG2WXAkwf5VJhyTcQBVvsoicetQQX7rTalHkuDE6+ECoQpu+0f5L9s36QpAzXb2Ls8
         8hJ9NuM8+FvNOC58PtvH88giqezWH/LAWfcrrY/CQBOzt19JGFj9GDXpvRiO77busi5h
         ztKV5gC8gEJ/cmUjOnpD8iPso/cXfGoscegs+Cr7lUiOtq5sauPjNMsYwNUrmBbYbjmt
         Obq/AKewgJhiAkMYG84jiDZc6BdPyDWIbTvwb2PF+Q0HUmj8gkvC0T73Xsekby2+jlJt
         HLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719851442; x=1720456242;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xG/yczWNA3S6agDnft2zlqDhiY2xh8cwDya0vX2WWTc=;
        b=FpTPNvE8/phQJ/6uqQP/d5hZf7z3xrJzLJ0xUV0vaUuNhZ7H7G3vZO5/KF5we3lQom
         IdOVVEuQXUr345f5gIKzqKc11rKuKXjzuQ5o4AgxTBusYjf/cnfTLalwNa5tlDgazlq0
         594qYZQvnRc0ZxDS2nl1H8/fR+wvoVOnKHTkQ7mTaiCjzZy0I18lsowKXNp8JLN5qNPn
         Q2dpZZJuY074VxpnWOKFucSkqM/zoEstbHAKDnMrWbpoGuDizkGmc5UH+wVE7uM3DcNV
         HupwHNP4HUbO298jxdaHWDxz4lMDLmTwuHMBI1oR0kmh9IWCMcKcjjteo/zB6ak8YZoh
         7WLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7mgwVQ6c5cJtfXSbQNgk0Ao7/5i9o0igJU+WfglYTimzExOOT/tGfE3M6HiEMMgstCEivv6rv9vJQBf/EBfqzHbeZddEwDTWECwpI
X-Gm-Message-State: AOJu0YzaBzxLSyaz2IlWefY2l8YeICMcMduT4ZneuOG7Kap8OPZiH9kV
	iw1iKyw7WGrBMHsph65IAJitRwoji3ha4Mul50eCBShuHTP/zSM/C42TAKOz9hc=
X-Google-Smtp-Source: AGHT+IGtjpg0CTkGUOVUT8tVr1x56kkLv8fO3EHB0uCgBbInRDqjQByQEmG74LyP6w9zbLghuwHLtQ==
X-Received: by 2002:a05:6808:2288:b0:3d5:63f0:ee9e with SMTP id 5614622812f47-3d6b32e3fd9mr8133239b6e.20.1719851442481;
        Mon, 01 Jul 2024 09:30:42 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:e8c6:2364:637f:c70e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d62fa39edfsm1420328b6e.37.2024.07.01.09.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 09:30:41 -0700 (PDT)
Date: Mon, 1 Jul 2024 18:30:38 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: drivers/input/keyboard/applespi.c:1833 applespi_drain_writes() warn:
 mixing irqsave and irq
Message-ID: <3e789ab9-ebfc-40a2-b90d-b8b55e0cfaac@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6d6444ba82053c716fb5ac83346202659023044e
commit: 038b1a05eae6666b731920e46f47d8e2332e07ff Input: add Apple SPI keyboard and trackpad driver
config: x86_64-randconfig-161-20240628 (https://download.01.org/0day-ci/archive/20240628/202406280337.1Av9qm8V-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202406280337.1Av9qm8V-lkp@intel.com/

smatch warnings:
drivers/input/keyboard/applespi.c:1833 applespi_drain_writes() warn: mixing irqsave and irq
drivers/input/keyboard/applespi.c:1845 applespi_drain_reads() warn: mixing irqsave and irq

vim +1833 drivers/input/keyboard/applespi.c

038b1a05eae666 Ronald Tschalär 2019-07-15  1826  static void applespi_drain_writes(struct applespi_data *applespi)
038b1a05eae666 Ronald Tschalär 2019-07-15  1827  {
038b1a05eae666 Ronald Tschalär 2019-07-15  1828  	unsigned long flags;
038b1a05eae666 Ronald Tschalär 2019-07-15  1829  
038b1a05eae666 Ronald Tschalär 2019-07-15  1830  	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);

_irqsave() sort of implies that potentially the caller has disabled IRQs,
otherwise we would use spin_lock_irq() if we knew they hadn't disabled
IRQs.

038b1a05eae666 Ronald Tschalär 2019-07-15  1831  
038b1a05eae666 Ronald Tschalär 2019-07-15  1832  	applespi->drain = true;
038b1a05eae666 Ronald Tschalär 2019-07-15 @1833  	wait_event_lock_irq(applespi->drain_complete, !applespi->write_active,
038b1a05eae666 Ronald Tschalär 2019-07-15  1834  			    applespi->cmd_msg_lock);

This will renable IRQs briefly and then disable them again.

038b1a05eae666 Ronald Tschalär 2019-07-15  1835  
038b1a05eae666 Ronald Tschalär 2019-07-15  1836  	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);

This will set them back to how they were at the start of the function.

The issue is that if the caller really wanted IRQs disabled, then it's
not necessarilly a good idea to enable them at all in the
wait_event_lock_irq() macro.  I suspect that in real life no callers
disable IRQs so it's not an issue.  But anyway, that's what the warning
is about.

I suspect that kbuild-bot has a 5 year cut off for warnings and if this
had been a month older then kbuild-bot would have ignored it.  :P

038b1a05eae666 Ronald Tschalär 2019-07-15  1837  }
038b1a05eae666 Ronald Tschalär 2019-07-15  1838  
038b1a05eae666 Ronald Tschalär 2019-07-15  1839  static void applespi_drain_reads(struct applespi_data *applespi)
038b1a05eae666 Ronald Tschalär 2019-07-15  1840  {
038b1a05eae666 Ronald Tschalär 2019-07-15  1841  	unsigned long flags;
038b1a05eae666 Ronald Tschalär 2019-07-15  1842  
038b1a05eae666 Ronald Tschalär 2019-07-15  1843  	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
038b1a05eae666 Ronald Tschalär 2019-07-15  1844  
038b1a05eae666 Ronald Tschalär 2019-07-15 @1845  	wait_event_lock_irq(applespi->drain_complete, !applespi->read_active,
038b1a05eae666 Ronald Tschalär 2019-07-15  1846  			    applespi->cmd_msg_lock);
038b1a05eae666 Ronald Tschalär 2019-07-15  1847  
038b1a05eae666 Ronald Tschalär 2019-07-15  1848  	applespi->suspended = true;
038b1a05eae666 Ronald Tschalär 2019-07-15  1849  
038b1a05eae666 Ronald Tschalär 2019-07-15  1850  	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
038b1a05eae666 Ronald Tschalär 2019-07-15  1851  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


