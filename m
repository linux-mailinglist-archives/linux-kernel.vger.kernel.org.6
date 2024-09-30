Return-Path: <linux-kernel+bounces-343573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A75989CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA712282F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7DC17C9B8;
	Mon, 30 Sep 2024 08:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SvLfh/GK"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C60317B50B
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727685038; cv=none; b=sx/jSqwjXS6zppDGuNvdNotHBhJa15mbqeJCdAEwpzlp7pmLpACaZCC96aG5PVh0m79Y/wltCmD7NHuQu20+EykDS818NDhFUJ4p/pRo8q7y1zcdRTKRyuqCEFu7digXMRCgMxqKClP3MxpsWE3thKJMLIe92nksvS036OY75wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727685038; c=relaxed/simple;
	bh=/KEjwmicYEseB+9Ufb7oHJBOnlwge12HH2hlDkNfFxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwqKtKtdSwTLz/fPwlwym0aKhudFlYNdD/qIKSXdcY1Oa1WHDKseEGSnJOtWgOeDgFFH7j6wwPIfNxpPruPt1kaMLc7KlSiNhq7vfPMl1inOg4Ig66pCt0uWWiYEWzCaNgP8K5NAfEmM58QaJDgzuKdjF/ejTyaH3f2414oPF68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SvLfh/GK; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=UBeP/VZfiMjgo80/ejdMyjyLO0vhRurMaJ3eVCsQheM=; b=SvLfh/GK37H+SgAIwIi7Jo1TXu
	ijpqQ3Z4hfWmHGSy29RSAw2BQ462IjGjxMUo3pxGj9xfNKo+t9PonTO5/ozB7PsOuVeVHmyL7bZox
	mRwEf3IRofM35kaJOH6XiYeEfYntFDbMMCjj2FvBHuq1f0KBwoeKYLSOf6s76oTtNKPZWIRT5zOYc
	JBAh3XDy/KFh3aAQ5jhfWezQj7a7CNZUES0gZvjdiNAVN44KjddBS2jv8L2FlruGe0V1elL7XFSG2
	33ou1jnQLy9n9FLiH4hbgIOZN/SlQbS77iudAGwpBkVpxixgFmyaMfhJwWf1LCf6vlHcOBdJiIvyN
	MjKJK2PQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1svBnW-00000002mRB-3ydO;
	Mon, 30 Sep 2024 08:30:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 913E6300754; Mon, 30 Sep 2024 10:30:26 +0200 (CEST)
Date: Mon, 30 Sep 2024 10:30:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	alyssa.milburn@intel.com, scott.d.constable@intel.com,
	Joao Moreira <joao@overdrivepizza.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Nathan Chancellor <nathan@kernel.org>, ojeda@kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH 07/14] x86/ibt: Clean up is_endbr()
Message-ID: <20240930083026.GG5594@noisy.programming.kicks-ass.net>
References: <20240927194856.096003183@infradead.org>
 <20240927194925.069013308@infradead.org>
 <CAADnVQ+BASJ7kcW4Kz_NsXM0U1+GrMHNVBOro8aO0-OyEry4Ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+BASJ7kcW4Kz_NsXM0U1+GrMHNVBOro8aO0-OyEry4Ww@mail.gmail.com>

On Sun, Sep 29, 2024 at 10:32:38AM -0700, Alexei Starovoitov wrote:
> On Fri, Sep 27, 2024 at 12:50 PM Peter Zijlstra <peterz@infradead.org> wrote:

> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -1027,19 +1027,9 @@ static const struct bpf_func_proto bpf_g
> >  #ifdef CONFIG_X86_KERNEL_IBT
> >  static unsigned long get_entry_ip(unsigned long fentry_ip)
> >  {
> > -       u32 instr;
> > +       if (is_endbr((void *)(fentry_ip - ENDBR_INSN_SIZE)))
> > +               return fentry_ip - ENDBR_INSN_SIZE;
> >
> > -       /* We want to be extra safe in case entry ip is on the page edge,
> > -        * but otherwise we need to avoid get_kernel_nofault()'s overhead.
> > -        */
> > -       if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
> > -               if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_INSN_SIZE)))
> > -                       return fentry_ip;
> > -       } else {
> > -               instr = *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
> > -       }
> > -       if (is_endbr(instr))
> > -               fentry_ip -= ENDBR_INSN_SIZE;
> >         return fentry_ip;
> 
> Pls don't.
> 
> This re-introduces the overhead that we want to avoid.
> 
> Just call __is_endbr() here and keep the optimization.

Well, I could do that ofcourse, but as I wrote elsewhere, the right
thing to do is to optimize get_kernel_nofault(), its current
implementation is needlessly expensive. All we really need is a load
with an exception entry, the STAC/CLAC and speculation nonsense should
not be needed.

Fixing get_kernel_nofault() benefits all users.

