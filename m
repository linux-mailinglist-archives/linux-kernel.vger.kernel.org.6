Return-Path: <linux-kernel+bounces-227788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0580D915692
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37B0F1C215A8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787D91A00C4;
	Mon, 24 Jun 2024 18:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kG8dvW9A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SSc1J9uW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B271E4AE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 18:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719254446; cv=none; b=rZtXI25keqgWcTApYqmjlaHEgpllFB78sy/ZRaL14lcxevnKEOdZUn69wEORX+SGJowUXFgEvP4fd3rGY39PiPz65ywyVKTOVeQNK00mmhvX+InTflKfBXVo2Wbo1gpsTiJXHHWGtJMqJrpVoSuTNLFwW72fwHT6FXg81bAXo38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719254446; c=relaxed/simple;
	bh=gk+hY5OqfcaIIcyWhxht66co2jq0wlNHNBgjOogUAWc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iF3GW4p5ALKYBfLECM7z5o2zI/adAKGJQDIFzwhNHNh4t2EmE1gZvw2QYFQox/u04WVBZSnx4K+sOGLac/DNhNFrCLPyePBQnhLCx7kU95LsoByBiRqST1qwOr6wWckQDWpKfgHDeY7OXINShA6XOPxoxt3lmMbCw3Y3kGUOS8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kG8dvW9A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SSc1J9uW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719254443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rnytfP2cF43fqYk+8R6v/Wpnxp1EY/xiAD2/t96VtFY=;
	b=kG8dvW9AmemhEBOvhZ+8wi0Qny5HooXwlmsgKHGX7XkBj/zTpUhiHNn/lnejjlbacYqDcf
	yUmZgWsoVEc1B47HQghoEn6sJ7d8qcwge8+0XiTe3GjNnHjRgz5fB2HmKNmZAKAzZSUChP
	U6oQ8pLT/rtPzNkV50QJmMm03pgNwcIjnH/HHhAXuNcA7OTH8M1cTQF6NZ8S0twdsrthrg
	X6Xj+wpC19RLdqWk4pT1EV53SQ+sVSySQY18W/wnWonHJDPD9H8RzvPbTcy2FFgSWTtjmF
	trcVKZSivVsMJoTXLD+Ba+zJ2ZkCLBtGmogz6qL+n2RoEsB72m3vSAdW/v1iSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719254443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rnytfP2cF43fqYk+8R6v/Wpnxp1EY/xiAD2/t96VtFY=;
	b=SSc1J9uWLDdQ0nBzTnDDqhSsbiZ+cnx+Cak8DhdjKedth8q+xpqVCIDdlu7Xwkp+lDmHvF
	QUrM2ok5dmecuYCQ==
To: kernel test robot <lkp@intel.com>, Jisheng Zhang <jszhang@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [tip:irq/core 41/49] drivers/irqchip/irq-dw-apb-ictl.c:33:25:
 error: expected '=', ',', ';', 'asm' or '__attribute__' before
 'dw_apb_ictl_handle_irq'
In-Reply-To: <202406250214.WZEjWnnU-lkp@intel.com>
References: <202406250214.WZEjWnnU-lkp@intel.com>
Date: Mon, 24 Jun 2024 20:40:42 +0200
Message-ID: <87v81y6v6d.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 25 2024 at 02:06, kernel test robot wrote:
> Hi Jisheng,
>
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
> head:   f2605e1715dd28e8943b557453fed3a40421d3b5
> commit: 7cc4f309c933ec5d64eea31066fe86bbf9e48819 [41/49] irqchip/dw-apb-ictl: Support building as module
> config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240625/202406250214.WZEjWnnU-lkp@intel.com/config)
> compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240625/202406250214.WZEjWnnU-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406250214.WZEjWnnU-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>>> drivers/irqchip/irq-dw-apb-ictl.c:33:25: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'dw_apb_ictl_handle_irq'
>       33 | static void __irq_entry dw_apb_ictl_handle_irq(struct pt_regs *regs)
>          |                         ^~~~~~~~~~~~~~~~~~~~~~

That's because the drivers is now selectable via Kconfig, so
allmodconfig sets it to M and builds it which does not work on a x86
build unsurprisingly.

Jisheng, please send a delta fix ASAP. Otherwise I have to revert it.

Thanks,

        tglx

