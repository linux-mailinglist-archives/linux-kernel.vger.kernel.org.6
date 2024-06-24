Return-Path: <linux-kernel+bounces-227303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E272914EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17CB2821CD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0326213D882;
	Mon, 24 Jun 2024 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zWLO/s9K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FGBtjy/T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1BD1E534
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719236749; cv=none; b=MczRKj3/R6lq8g+rX+fcrPI5eH77KCCv2HgxPBGp2LTla7Yy9J6dATPca0tVnYxgFJo+I6qnx3+SIt6xuK1zg9lsZFFqKg78z5pyxbURxLsb5P+PmL/VTeTu4k275xPCTCEVWuw3ZtlJZ5zP0LxCEk3+pjDk3GJbsA1Ge3fpwA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719236749; c=relaxed/simple;
	bh=RqeuvMz0cRSx1ZUaiURn+zvKLMXsN6xdTYTDIkNr6Io=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DTnpaaW4G9xbqZTFE7lxnOMFuN2FjdzhCO5ThLqU0B/uorTR66FCQ4PgZUzpC+dPTrlDkDy9dL97whaMjPyXS+CFiw9LqMGcC9V1JFjJwtRQq31IvWkfw776ArkZI+ZDs/MRXeZDAVWvgKABT5pQm/2+8C0LWJlu6nuXozkvzJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zWLO/s9K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FGBtjy/T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719236744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GboIg5eVGHDPZ9dHMp+OprFYxnXj5dxDMNcULCsadHc=;
	b=zWLO/s9KLalwIYKdFRK1CChvsksfGjPSSuY4q1nfKLracltPA+LwJL/PFALBxbXHW2WJPs
	GSa+StBJBeUCkGxoKegr11yqWP7Y73QF7er/UpehEri8F4XejtMPwRiMuPTYNOnsZSNYgF
	KxhY2sz7kPyF8r4RzeROD7kOO+OVDwNdtt8PLMuGs8sM10M78U6BVAFS6nhoRso9FvyO+r
	bjxSNvyFaloyz5InhM3icfPZ7+EdTebH+7Vtq4XYYV5oecfoaiuOgFk21EH4vWSAKBWns8
	AG/66DYKssND59/YVEWNeK5Tau8YuQuRm+DudV3kZ5teqza70DQ1M+Fli42elg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719236744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GboIg5eVGHDPZ9dHMp+OprFYxnXj5dxDMNcULCsadHc=;
	b=FGBtjy/TwRE/uHMqDgyipx7UFEpUjQmXrf4kBf8fE1Q4esR2Mk0vube5ZaI+ILex74ZHfn
	2lSN8V2FSINMmxAg==
To: kernel test robot <lkp@intel.com>, Tianyang Zhang
 <zhangtianyang@loongson.cn>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 x86@kernel.org, Jianmin Lv <lvjianmin@loongson.cn>, Liupu Wang
 <wangliupu@loongson.cn>
Subject: Re: [tip:irq/core 39/46]
 drivers/irqchip/irq-loongarch-avec.c:82:17: error: implicit declaration of
 function 'loongson_send_ipi_single'
In-Reply-To: <202406240451.ygBFNyJ3-lkp@intel.com>
References: <202406240451.ygBFNyJ3-lkp@intel.com>
Date: Mon, 24 Jun 2024 15:45:44 +0200
Message-ID: <87sex28nef.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 24 2024 at 05:06, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
> head:   c9d269469d2b9a06559cdc84d12dd3fb4d552581
> commit: 760d7e719499d64beea62bfcf53938fb233bb6e7 [39/46] Loongarch: Support loongarch avec
> config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20240624/202406240451.ygBFNyJ3-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240624/202406240451.ygBFNyJ3-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406240451.ygBFNyJ3-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    drivers/irqchip/irq-loongarch-avec.c: In function 'loongarch_avec_sync':
>>> drivers/irqchip/irq-loongarch-avec.c:82:17: error: implicit declaration of function 'loongson_send_ipi_single' [-Werror=implicit-function-declaration]
>       82 |                 loongson_send_ipi_single(adata->prev_cpu, SMP_CLEAR_VECT);
>          |                 ^~~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/irqchip/irq-loongarch-avec.c:82:59: error: 'SMP_CLEAR_VECT' undeclared (first use in this function)
>       82 |                 loongson_send_ipi_single(adata->prev_cpu, SMP_CLEAR_VECT);
>          |                                                           ^~~~~~~~~~~~~~
>    drivers/irqchip/irq-loongarch-avec.c:82:59: note: each undeclared identifier is reported only once for each function it appears in
>    drivers/irqchip/irq-loongarch-avec.c: In function 'complete_irq_moving':
>    drivers/irqchip/irq-loongarch-avec.c:173:55: error: 'SMP_CLEAR_VECT' undeclared (first use in this function)
>      173 |                         loongson_send_ipi_single(cpu, SMP_CLEAR_VECT);
>          |                                                       ^~~~~~~~~~~~~~

So this code was never built with CONFIG_SMP=n.

Can the loongson folks please send me a delta patch ASAP, otherwise I'm
going to revert it.

Thanks,

        tglx

