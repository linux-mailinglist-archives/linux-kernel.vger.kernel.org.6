Return-Path: <linux-kernel+bounces-255317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EDF933EE4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B0EAB20BC2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED95618133B;
	Wed, 17 Jul 2024 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OqXRuaVQ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB759181328
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721228130; cv=none; b=TKIr1Jt3pk/lTcs27m7t6tZ+qHQw9Wl8jjAf1w/sfNz5rbVsKy6n47j6Kq5bWfaEWzR9TFs+C+IZDiiC+w2LIIuku/L2v3fNu52wDd0fsBlx5XjoU5CdyH6wVWGdNrjpxCucgDzs3lqxOmjaSmVxS1Dv2iNbBxSZGEULlbOdULA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721228130; c=relaxed/simple;
	bh=YOJ4uZAB0sAAC6T3kt0sNWyzioS/CfFJ+QDlNZ4zYbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKsGcc33UX8hJulw1zjo5UOOJzG2gRtI66WDqn3+9IlSre3zo8px6MDCRx/6dPbRwDYdmC0wX3WBNzNv6EqEw1Tmm6EvyLqvvj/Bqtci2P7Qf3sIJ0rTILuoEAe/61siNHELvK6WPEEe7IuHSlYO/wAxaQ5B9nSK1JmWGcZq8Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OqXRuaVQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3B+4D6g/cI0IkxVVHLAuVdIDzczjDpPmDtucTRBCNeg=; b=OqXRuaVQeMZlfBQow0apkh/XxW
	gds0KMcouoGh/WuezZRmot4ydRvIIqecxRuKv9IIF48rkIIkOayipPuCli7S+A5YTiFgzGxI/f0xN
	86xxXtxg871Rfe7/swetflLrpmU29GRJr0U/o1STMUoK7bDZ01OAlnTitBvicgQx/RsmNnsnOC0nZ
	M6ZWt2OtXcUEEQLFqEfMeF5B6cI97daXe7T5yVelZZkQRhjC054erjuaE2VL50G9KE+WLPCSPn2vy
	VNRQQzhjN6mKek4sL2BzCZFT3W1Iw8POidWNwecoFjBvB0fx2O8kAB5RgAmdZWvcF/bj5tLAfhlpm
	UY9QSSTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU63r-00000000xAm-1hh4;
	Wed, 17 Jul 2024 14:55:19 +0000
Date: Wed, 17 Jul 2024 15:55:19 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Zhu Hengbo <zhuhengbo@iscas.ac.cn>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: add tracepoints for page fault
Message-ID: <ZpfbVzwT5flLqatZ@casper.infradead.org>
References: <20240715101400.39103-1-zhuhengbo@iscas.ac.cn>
 <20240717082728.84401-1-zhuhengbo@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717082728.84401-1-zhuhengbo@iscas.ac.cn>

On Wed, Jul 17, 2024 at 08:27:19AM +0000, Zhu Hengbo wrote:
> +	TP_STRUCT__entry(
> +		__field(unsigned long, address)
> +		__field(unsigned long, epc)
> +		__field(unsigned long, cause)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->address	= regs->badaddr;
> +		__entry->epc		= regs->epc;
> +		__entry->cause		= regs->cause;
> +	),
> +
> +	TP_printk("user page fault, address=%ps epc=%ps cause=0x%lx",
> +			(void *)__entry->address, (void *)__entry->epc,
> +			__entry->cause)

What is "epc"?  You've made this gratuitously different from x86.
Never do that.  Always copy what somebody else has done unless you have
a good reason to be different.

