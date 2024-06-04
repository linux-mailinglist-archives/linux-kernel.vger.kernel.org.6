Return-Path: <linux-kernel+bounces-200339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C618FAE93
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9076B1F241F3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60753143872;
	Tue,  4 Jun 2024 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DPoG7fvS"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D907B14374B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492689; cv=none; b=ZSsDrUU8gSuUkUTNJoIpVhM+7Wgw11eITISonCdUgyYfiOareTPztFerq9L1vZ/FOeN03X2itjGE83cC1knGzlnthDzcwyrbZT2EUPpoiWMOsU9ibYLS/ibgluVwrcy4826v3lPa5qNXv3kTsEHxXIYf2mOhzuJN4fkC0+90dVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492689; c=relaxed/simple;
	bh=coll5pd39ElrkIZGCeZy/pf/qfLIkxiTf6UAfa/GybI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XrQXelf5CqrsZGtNCHpDr+/sgHw76Q6aqAa7XkpRzqykUbMDDX18fQIsS4yYunOgx9zISmQMKT+oXQPLeujU9Yb5Jvv2eD0L/qZFKZNeMYOIP2eBQMQ3pzCnIXoFjRCOUCoEG8ABlSJDPymz5vHJ59rOtlW+1WtpLkENSk3V4/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DPoG7fvS; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-578517c7ae9so885829a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 02:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717492686; x=1718097486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z/B9hwk8gme+G1CpVjbJqCaQW7S8fDB15IbyupvMh58=;
        b=DPoG7fvS01RxHsjyaxOzlwm5JUlKYy1fJMHmRySbupYzhg6QBaJ7s1XPTWc4xZA37A
         UgJZ5WSuacUAbZNj5frWFDsjMK+3XV6a3P5BSYxNRcXyAzOipHJ+uG6R54W4FvVlcO33
         j3elHhyRLQva6hMdjJ4W+gzcBX2ZQ+uHzLdMBguP99+dCrXj01ElXq0/Pn1hryHtTJiG
         UTqbBN395m7cDRTfh8wW7alysS3pJtHNd0o+FzAL9oCj1MpJTsrAEn0qX7SXLMwY+MO3
         6ncGjq0iorJeUbzTKfr8TmcqtgLOGwFW5wNb2W42amaRjJ9f3kHe0s4YV7jtA+LTNOmr
         b19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717492686; x=1718097486;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/B9hwk8gme+G1CpVjbJqCaQW7S8fDB15IbyupvMh58=;
        b=oYP4NowDdcOehaf8AzCR9BzWBwB7ZtYUujiJ13F93eaEzFy0ME7Vt0iEs7Hh3+iFq3
         mRS0986aH+Jt7GDpAGHgVlkdhBgwm0FPllYeq4oi65PznQwZ+uuEUys/SkzujYryqX5G
         o7mS5D/X/RPS9iy+7n9DE9KZdeqsD3wxLD1xufDRg0KQBK/bVkTb+ocoj8ck2OkQ/2eB
         i4ZDvDpGJ88Da2MkorTB/oAPMa6chn3VwrzjaIojQzZns0UUMai4uFA2K18TJrWeOvdq
         HqG2d5Pyv/VaTCZO3Dc7aOd1TxkWme7Xp7pJZJHJ0LavwFxdXOoahgKULFhoAVu4WTL0
         Ocog==
X-Forwarded-Encrypted: i=1; AJvYcCWM0hu3Im0z27xPFs54ZVEEokmYbuvU3u8FjglJcyzR2W/l+F0qSM9yW94A3KetoQR66j/VUh5JgkVPhWs0ceUXngSaSIAo5Qo9rCD0
X-Gm-Message-State: AOJu0Yy6NciVSTyzNnsexYqiZYfN4Nmj/BWf6ZDFnuKbMPP3AOzP7UxV
	Gi1qNfRItghX1Pa/nBlvfwEZAnlPkyKI4Ol/FoNVeSDAlFHKu4vCwjFZMw0H8Ak=
X-Google-Smtp-Source: AGHT+IHEb5DiOO5gXZ9H1Ufkt1t62HwrfDA2yw2cSAn0vW+aBPYLP1aSIIvZX9eNb33mn7HSALAQ9g==
X-Received: by 2002:a50:c191:0:b0:57a:588:747c with SMTP id 4fb4d7f45d1cf-57a36540a89mr7537984a12.32.1717492686096;
        Tue, 04 Jun 2024 02:18:06 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31b991b1sm6951182a12.5.2024.06.04.02.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 02:18:05 -0700 (PDT)
Date: Tue, 4 Jun 2024 12:18:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Witold Sadowski <wsadowski@marvell.com>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, broonie@kernel.org,
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, pthombar@cadence.com,
	Witold Sadowski <wsadowski@marvell.com>
Subject: Re: [PATCH v7 2/4] spi: cadence: Add Marvell xSPI IP overlay changes
Message-ID: <8428babf-5504-4710-9138-a2b6e5fc2a84@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529220026.1644986-3-wsadowski@marvell.com>

Hi Witold,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Witold-Sadowski/spi-dt-bindings-cadence-Add-Marvell-overlay-bindings-documentation-for-Cadence-XSPI/20240530-060250
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20240529220026.1644986-3-wsadowski%40marvell.com
patch subject: [PATCH v7 2/4] spi: cadence: Add Marvell xSPI IP overlay changes
config: powerpc64-randconfig-r071-20240531 (https://download.01.org/0day-ci/archive/20240601/202406012002.gdwS19Yi-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project bafda89a0944d947fc4b3b5663185e07a397ac30)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202406012002.gdwS19Yi-lkp@intel.com/

smatch warnings:
drivers/spi/spi-cadence-xspi.c:314 cdns_xspi_reset_dll() warn: signedness bug returning '(-110)'

vim +314 drivers/spi/spi-cadence-xspi.c

5828a861b01b62 Witold Sadowski 2024-05-29  302  static bool cdns_xspi_reset_dll(struct cdns_xspi_dev *cdns_xspi)
5828a861b01b62 Witold Sadowski 2024-05-29  303  {
5828a861b01b62 Witold Sadowski 2024-05-29  304  	u32 dll_cntrl = readl(cdns_xspi->iobase +
5828a861b01b62 Witold Sadowski 2024-05-29  305  			      CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL);
5828a861b01b62 Witold Sadowski 2024-05-29  306  	u32 dll_lock;
5828a861b01b62 Witold Sadowski 2024-05-29  307  
5828a861b01b62 Witold Sadowski 2024-05-29  308  	/* Reset DLL */
5828a861b01b62 Witold Sadowski 2024-05-29  309  	dll_cntrl |= CDNS_XSPI_DLL_RST_N;
5828a861b01b62 Witold Sadowski 2024-05-29  310  	writel(dll_cntrl, cdns_xspi->iobase +
5828a861b01b62 Witold Sadowski 2024-05-29  311  			  CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL);
5828a861b01b62 Witold Sadowski 2024-05-29  312  
5828a861b01b62 Witold Sadowski 2024-05-29  313  	/* Wait for DLL lock */
5828a861b01b62 Witold Sadowski 2024-05-29 @314  	return readl_relaxed_poll_timeout(cdns_xspi->iobase +
5828a861b01b62 Witold Sadowski 2024-05-29  315  		CDNS_XSPI_INTR_STATUS_REG,
5828a861b01b62 Witold Sadowski 2024-05-29  316  		dll_lock, ((dll_lock & CDNS_XSPI_DLL_LOCK) == 1), 10, 10000);

Functions which return true/false should have names which say what the
return means.  Like access_ok() or is_something().  Returning true for
failure and false for success is a backwards anti-pattern.  This error
return value gets propagated back until it is eventually ignored so it
doesn't affect runtime.

5828a861b01b62 Witold Sadowski 2024-05-29  317  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


