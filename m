Return-Path: <linux-kernel+bounces-396561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F869BCEE2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2085B1F24D30
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCD91D8DEA;
	Tue,  5 Nov 2024 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q7ua8um/"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23C3188587;
	Tue,  5 Nov 2024 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816134; cv=none; b=Ev6Ywvyiru4uH+cQh+sIitt3PR2sSB6ARMSohx77XnJSNKkW6Li0uzy2SS2tXqHTvLrCF0/Xe7SccEwkuvsb5Bfg+8gdF8Ds2DlLn/CZZi8grT/A9VSfW2WOyxHf8gmmiSXihnGEC0YfJW0bZqmBuWGmKdmuLHfP8V9awrNwavY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816134; c=relaxed/simple;
	bh=pTSbyLYkpTK/8VNQ3QhBooEkckeVvJmQ87AQwsvW+fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKNNzWU3p4gVAejLD5URA+A667i8s50r+5mFy2pA9O9E19OHTRUlvHYE5jlcorCSS6us6rhcBqz6jPjnbQofWm+/VJ3IJ1eFgQ2ro2woXkCAe5GGP6TGRoegdTFmeCSaBQx7jtEdSDHfg0Bi641QUBL3v7kHND1zy2HfGICcrIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q7ua8um/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=okWmNu424pi7gYRy8R4VOIWrWNmkwx8HLi4zthfNDM8=; b=q7ua8um/xGpNy+9TyhON/Zamk/
	+1b8ov2AASmHRC3LKaCagJKfThejxKhzFauBPfwrhlBvPVZ4i+zdEb6MO8rCa6BV12BmnOq71t7AD
	Y0FuwVB+xuSYbjd+ML6j1kQYJCvk2CZrEvXbW4mEWG2yHfxerEZqCc6oZeRK2IXPkqimymVVSgZ5E
	LX6eD1Od1iuaTVobYBnIZMQVW4/1c0z3SHaDQCn4DCU1Zh1zBMg7CClVKnpHkuj496xWNZ7GnKC1s
	OsGh7pJfjpbAaV3Or2nsWdA/tCOs3xbN5oqKloG+CKpfPsUZMkO+tzhYzZo4T4sa1S6L9vZGoJimy
	MUiebf9Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8KLC-0000000Bldf-3A0w;
	Tue, 05 Nov 2024 14:15:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 10C2D30042E; Tue,  5 Nov 2024 15:15:30 +0100 (CET)
Date: Tue, 5 Nov 2024 15:15:30 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] LoongArch: Enable jump table with GCC for objtool
Message-ID: <20241105141530.GE10375@noisy.programming.kicks-ass.net>
References: <20241105123906.26072-1-yangtiezhu@loongson.cn>
 <20241105123906.26072-6-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105123906.26072-6-yangtiezhu@loongson.cn>

On Tue, Nov 05, 2024 at 08:39:06PM +0800, Tiezhu Yang wrote:
> For now, it is time to remove the compiler option -fno-jump-tables
> to enable jump table for objtool if the compiler is GCC and it has
> the compiler option -mannotate-tablejump, otherwise still keep the
> compiler option -fno-jump-tables to maintain compatibility with the
> older compilers.
> 
> By the way, the compiler behaviors are different for various archs,
> there are some corner issues after removing -fno-jump-tables if the
> compiler is Clang, so just keep the compiler option -fno-jump-tables
> for Clang at present.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/Kconfig  | 3 +++
>  arch/loongarch/Makefile | 9 +++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index bb35c34f86d2..500ee9b2cd88 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -284,6 +284,9 @@ config AS_HAS_LBT_EXTENSION
>  config AS_HAS_LVZ_EXTENSION
>  	def_bool $(as-instr,hvcl 0)
>  
> +config CC_HAS_ANNOTATE_TABLEJUMP
> +	def_bool $(cc-option,-mannotate-tablejump)
> +
>  menu "Kernel type and options"
>  
>  source "kernel/Kconfig.hz"
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index ae3f80622f4c..61484df4eccc 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -101,8 +101,17 @@ KBUILD_AFLAGS			+= $(call cc-option,-mthin-add-sub) $(call cc-option,-Wa$(comma)
>  KBUILD_CFLAGS			+= $(call cc-option,-mthin-add-sub) $(call cc-option,-Wa$(comma)-mthin-add-sub)
>  
>  ifdef CONFIG_OBJTOOL
> +ifdef CONFIG_CC_IS_GCC
> +ifdef CONFIG_CC_HAS_ANNOTATE_TABLEJUMP
> +KBUILD_CFLAGS			+= $(call cc-option,-mannotate-tablejump)
> +else
>  KBUILD_CFLAGS			+= -fno-jump-tables
>  endif
> +endif
> +ifdef CONFIG_CC_IS_CLANG
> +KBUILD_CFLAGS			+= -fno-jump-tables
> +endif
> +endif

This seems excessive. Why split between GCC and Clang, isn't
CC_HAS_ANNOTATE_JUMPTABLE sufficient?

