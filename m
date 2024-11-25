Return-Path: <linux-kernel+bounces-420696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23779D823D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A511635B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6F21917D4;
	Mon, 25 Nov 2024 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QP/GEmsD"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855AD190696;
	Mon, 25 Nov 2024 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526940; cv=none; b=Ywvw5zNricDkwjlh9INcECLv/jI00dziTgvrdKYzuIitIsBkOsiR/49yVSX4NLEcWiyNWTIzV6Sr0bwYWLBK6X/WpAmKK9l0KdIIaCesctyAO/eDBYdcJJ0y44ogCm/j3ODD/kMdtn9FqjWKJiyn375iGYG/KugMC2DSFHXlo18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526940; c=relaxed/simple;
	bh=Gy/c40HnFX5lfiJDX3MOa3xqCqS/HefmnZXSHoaVp4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnRHVWrHUtnoVfetWhpol6KzDE3ueHQbBc9L2L3FravcDE9cxwGwaGznrorN+mHy7xDVpE3ki2WT+2vbxDbKuZEdCbwVd6Wnt8iy2PDzSQ0WirpmZa+4jiWgXG2TLFxBsGHiVE6bZBaEQ5lYQtgIV5OQdbdfgFM/qJaW9Sr9MHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QP/GEmsD; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tof/qubOSp2l2+fEKOwuosAzk3Cq2zkdUc2ew5U+ClY=; b=QP/GEmsDW9dwpTcMSXBtlWSDQa
	BtKxUYI2UBHxhyox+GAvlHSLQsmeIjY9mHEevSS4LnRuvQalQaQwBVB6/IQdsE8Qvqq5+p8SKx4kK
	a1/QMBDIMdDnnfYt8h7Wt7kf7ZfnZ65DdAT87j4cwMgVJDGHR6vQawzBhqfDjx4TEJx6YwzIq1Zs0
	ceeFPmqfF5I+e9f8lL6kH2iHarw68UYj9FKtHEd/rMQTWzq0zthEXon2GIb2IA/rD70s77MXVX7NF
	KVTP/zjTMDI4vda1vuPo2QhzonjEjOWXLKkZm/WfBdyYoQj4h/stwq9GhX45idUl/SI8N/zX/7De9
	E5Kw1Kyw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFVOp-000000014OY-2RGD;
	Mon, 25 Nov 2024 09:28:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A783730026A; Mon, 25 Nov 2024 10:28:54 +0100 (CET)
Date: Mon, 25 Nov 2024 10:28:54 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
	Fangrui Song <i@maskray.me>, llvm@lists.linux.dev
Subject: Re: [PATCH 1/9] objtool: Generic annotation infrastructure
Message-ID: <20241125092854.GG24774@noisy.programming.kicks-ass.net>
References: <20241122121016.372005127@infradead.org>
 <20241122121555.621070802@infradead.org>
 <20241124031640.GA3646332@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124031640.GA3646332@thelio-3990X>

On Sat, Nov 23, 2024 at 08:16:40PM -0700, Nathan Chancellor wrote:
> On Fri, Nov 22, 2024 at 01:10:17PM +0100, Peter Zijlstra wrote:
> > Avoid endless .discard.foo sections for each annotation, create a
> > single .discard.annotate section that takes an annotation type along
> > with the instruction.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ...
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -2373,6 +2373,49 @@ static int read_unwind_hints(struct objt
> >  	return 0;
> >  }
> >  
> > +static int read_annotate(struct objtool_file *file, void (*func)(int type, struct instruction *insn))
> > +{
> > +	struct section *sec;
> > +	struct instruction *insn;
> > +	struct reloc *reloc;
> > +	int type;
> > +
> > +	sec = find_section_by_name(file->elf, ".discard.annotate");
> > +	if (!sec)
> > +		return 0;
> > +
> > +	if (!sec->rsec)
> > +		return 0;
> > +
> > +	if (sec->sh.sh_entsize != 8) {
> > +		static bool warned = false;
> > +		if (!warned) {
> > +			WARN("%s: dodgy linker, sh_entsize != 8", sec->name);
> 
> Thanks to Fangrui, this has been resolved in LLVM main:
> 
> https://github.com/llvm/llvm-project/commit/d4bed617f4378873d7ddf4b53c041e7b39d1a9ca
> https://github.com/ClangBuiltLinux/linux/issues/2057#issuecomment-2495675374
> 
> I have built a version of LLVM from main and verified that this warning
> does not trigger with that version, while it does with LLVM 19.1.4.

Excellent, thanks for getting this sorted.

Since there's a fair number of llvm releases between the minimally
supported version to build a kernel with and this fix, I'll leave the
warning as non fatal.

One question; is there any other means of setting entsize aside from
(ab)using SHF_MERGE ? The (GNU) as documetation for .section only
mentions entsize in combination with SHF_MERGE.


