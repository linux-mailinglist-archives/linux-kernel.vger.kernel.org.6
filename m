Return-Path: <linux-kernel+bounces-274659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E040E947B38
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E72F1C21002
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9993D158DD1;
	Mon,  5 Aug 2024 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jns5Bsv+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5121803A;
	Mon,  5 Aug 2024 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862157; cv=none; b=buqRq7LPdTVYqZLa0DXTFIqr8gVqRIAyZsh923nwkcIszIcdpkFK4TUuvWDxm1wQbIJQyLnjJG+tn6HjeyXvthw0tvtw27pYlnvk1eXN+3NjIxHWQpydhUi2XtUh3d/vXpFyC+sLxoKIl/t1z+FYkHPOU6Vy5nYwJyz2Hqlf8s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862157; c=relaxed/simple;
	bh=oN7yTkA6xDQEBuG5GHtsavQUXvE6qMEyPms4UKJujZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXveR7xKw7koDxZtQk4QwjP3dCLxTWrja0MRnjqkPSZJffzzROCDznnqBouucor8qBHwsGXgpoalZcXeaBdfs1fIg/sLhYF/KgBXTeJRcto4aVuf153Amt/eclnZMAJeN1+90YeInCr7JEV5uoZ3maGKPDhsuBDb8hRu06OcfAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jns5Bsv+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEBCC32782;
	Mon,  5 Aug 2024 12:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722862156;
	bh=oN7yTkA6xDQEBuG5GHtsavQUXvE6qMEyPms4UKJujZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jns5Bsv+cmAHvFdiZg6V+2Bp8tNXE1xLIBOw/iUkm8Pepos3gc0Phl+oJBkRssHec
	 w+tjZcbDqguSojELJ2WdbH6ag5V8gnIkfJU12sv9fgwXbCGtapnQx5DpU+tbc+BAI6
	 iq7RdwJQLIon4JnpV4dxohnPFOwzSrjBI8ws74meyM2ZZpfl03y5Lh/WgrRjIFlzoo
	 GF3MMzv+NPh4zkyJdwh1AnlLvmqC3ahncXvpnFFoDqsdMyFSbP5CPYXpk3QPNoQJWe
	 nnpLsqbrUaf2EhwYjARw10M3nVR1oatdmQHcDTEeKb31e3ZNKrF4ccduisJC7qRqyc
	 zqbp5Q8BiM4Zg==
Date: Mon, 5 Aug 2024 14:48:59 +0200
From: Alexey Gladkov <legion@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yuan Yao <yuan.yao@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yuntao Wang <ytcoode@gmail.com>, Kai Huang <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
	cho@microsoft.com, decui@microsoft.com, John.Starks@microsoft.com
Subject: Re: [PATCH v1 1/4] x86/tdx: Split MMIO read and write operations
Message-ID: <ZrDKO7WBqAhmA-7J@example.org>
References: <cover.1722356794.git.legion@kernel.org>
 <ff7cc8b32ae3829892d0dd5dcd3245d1db2684c0.1722356794.git.legion@kernel.org>
 <87a5hy7mvg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5hy7mvg.ffs@tglx>

On Tue, Jul 30, 2024 at 08:31:15PM +0200, Thomas Gleixner wrote:
> On Tue, Jul 30 2024 at 19:35, Alexey Gladkov wrote:
> > To implement MMIO in userspace, additional memory checks need to be
> > implemented. To avoid overly complicating the handle_mmio() function
> > and to separate checks from actions, it will be split into two separate
> > functions for handling read and write operations.
> 
> It will be split? The patch splits it, no?

Yes. Sorry for my english. I will reword it.

> >  
> > +static int handle_mmio_write(struct insn *insn, enum insn_mmio_type mmio, int size,
> > +		struct pt_regs *regs, struct ve_info *ve)
> 
> Please align the second line argument with the first argument in the
> first line.
> 
> > +static int handle_mmio_read(struct insn *insn, enum insn_mmio_type mmio, int size,
> > +		struct pt_regs *regs, struct ve_info *ve)
> > +{
> > +	unsigned long *reg, val;
> > +	int extend_size;
> > +	u8 extend_val = 0;
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations

Ok. I will fix the coding style here and in other patches.

> >  static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> >  {
> > -	unsigned long *reg, val, vaddr;
> > +	unsigned long vaddr;
> >  	char buffer[MAX_INSN_SIZE];
> >  	enum insn_mmio_type mmio;
> >  	struct insn insn = {};
> > -	int size, extend_size;
> > -	u8 extend_val = 0;
> > +	int size;
> 
> Ditto
>   
> >  	/* Only in-kernel MMIO is supported */
> >  	if (WARN_ON_ONCE(user_mode(regs)))
> > @@ -428,12 +504,6 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> >  	if (WARN_ON_ONCE(mmio == INSN_MMIO_DECODE_FAILED))
> >  		return -EINVAL;
> 
> Thanks,
> 
>         tglx
> 

-- 
Rgrds, legion


