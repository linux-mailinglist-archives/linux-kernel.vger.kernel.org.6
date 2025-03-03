Return-Path: <linux-kernel+bounces-541292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A05A4BB07
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8BA164709
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21DC1F0E5F;
	Mon,  3 Mar 2025 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YgabHr7/"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96402E630;
	Mon,  3 Mar 2025 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995042; cv=none; b=lX8UV8vKQNG7+3djQT8atIjwuF9zhB3Q6FysJHWmlw1XZs7ZgzWm4SruxelCTROgt9zJb2g5y49hazLDKz/udtPLNFRFLt5xza6AaxX/kDqgaHHd+qjbyXWRfnqq4uz/BaEdfqCZ8H6ju9pDVhmFxHWlRI/PKnz57sDMIUcxu1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995042; c=relaxed/simple;
	bh=1hCSFxQz82ukf4pKy8zODFP4fsvaa4QP7NWW1sjEYv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t27Djto6bOXD8s3CmKcAhLUhi1KfTgOMMj96EUICQtenpIL0gWg2q130QbkM5PrGRWlUAqO710vsEi1xNermVoNekxJSfmB3cSBfNt6/vsvSME5k8YKgUnIhvqPy/ts70n4lrRaAzAVIijkztQC32A84nRKcC4dzEBzJFkBx+P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YgabHr7/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BCxbXGJuOatYE31YJyZ7ETjf1diwgG9cuKGYi97GPs0=; b=YgabHr7/zzhdzSMKkpAUuVfOuS
	9Y/teNhFo5DfjuTTY3yqaflkemntAFad+DOVuw/INUoLQ8Ud6aI33QLq1OJhxwoH0Q7jkZ9PhKqF3
	OhE1R77QkusPkd2Wm7PG3CEejBEt70QecUicyW2Z7Lpfz79E6urqRtpBDVgdCBq2F5APGLQX6ZJpU
	KNMFwA6H2FIpFnJBt9HQgr29XM4sV5GPJWcmS5RkdvnoYYv2OfOOFi2TPZfY1cKK+myuTieZm2idY
	+v6BXxd+gxy97V014M0vq5BPK1xbRjossyTOZVGX1FO4JxUX5EAUwqy6YeWD7qPoy53xyQe7f5tZ8
	SuqH3k/Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tp2L8-0000000BQ8x-2eEC;
	Mon, 03 Mar 2025 09:43:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3B6EC30049D; Mon,  3 Mar 2025 10:43:58 +0100 (CET)
Date: Mon, 3 Mar 2025 10:43:58 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>
Subject: Re: [tip:x86/core 16/17] vmlinux.o: warning: objtool: do_jit+0x276:
 relocation to !ENDBR: .noinstr.text+0x6a60
Message-ID: <20250303094358.GK5880@noisy.programming.kicks-ass.net>
References: <202503030704.H9KFysNS-lkp@intel.com>
 <20250303092459.GI5880@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303092459.GI5880@noisy.programming.kicks-ass.net>

On Mon, Mar 03, 2025 at 10:24:59AM +0100, Peter Zijlstra wrote:
> On Mon, Mar 03, 2025 at 07:47:57AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
> > head:   dfebe7362f6f461d771cdb9ac2c5172a4721f064
> > commit: 0c92385dc05ee9637c04372ea95a11bbf6e010ff [16/17] x86/ibt: Implement FineIBT-BHI mitigation
> > config: x86_64-randconfig-071-20250303 (https://download.01.org/0day-ci/archive/20250303/202503030704.H9KFysNS-lkp@intel.com/config)
> > compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250303/202503030704.H9KFysNS-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202503030704.H9KFysNS-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> vmlinux.o: warning: objtool: do_jit+0x276: relocation to !ENDBR: .noinstr.text+0x6a60
> 
> Thanks, below seems to cure it for me.
> 
> ---
> Subject: x86/ibt: Make cfi_bhi a constant for FINEIBT_BHI=n
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon Mar 3 10:21:47 CET 2025
> 
> Robot yielded a .config that tripped:
> 
>   vmlinux.o: warning: objtool: do_jit+0x276: relocation to !ENDBR: .noinstr.text+0x6a60
> 
> This is the result of using __bhi_args[1] in unreachable code; make
> sure the compiler is able to determine this is unreachable and trigger
> DCE.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202503030704.H9KFysNS-lkp@intel.com/
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Durr, doesn't build with FINEIBT && FINEIBT_BHI=n, let me cure that.

