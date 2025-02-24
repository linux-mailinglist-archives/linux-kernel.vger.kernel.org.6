Return-Path: <linux-kernel+bounces-529562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF385A427E2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACDFE3AD4AC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2662627F8;
	Mon, 24 Feb 2025 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="etkeSBDc"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938E01A3176;
	Mon, 24 Feb 2025 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414349; cv=none; b=YrLoLZQWzPLODXmOVzbigYtbq5uKqndtJNanXhy48SzBakAqAvwj1L46j0mi+NR5UjkbKjSK0sC3HbiRmfgmNs+Trgcw/IDlDOHAD9MpZdhN97EbLtxVbG5QeNrblYPAV8/9T+vz1gPFj3bFxvP1OIEyYqMccJwl8/PJLQWIkYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414349; c=relaxed/simple;
	bh=qvbnNSdRruQhRk4mgbgR8vrRl+sp/5MPa5t6Nig7i1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaQ0mpy0ngFFw28uZdewyR7ujInFDWDY3xjdaP2ocrbXNWPLuKTLt+cjypfwv1sayyBaRGGJydnrR169Q1Ozim9t0Emc8m7AwsazZ9sxSuQ2NwF0etH4epR8/hjIrCp1IprnnQtZfBOiXXAX8IuynSm9iKV/dlqXjQFdYA6McZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=etkeSBDc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RiG7Os1LzRvtBRc9A9ciPH//03aOnU7y29MQw49YdE4=; b=etkeSBDcLsAiIlNT9AxClEHsb1
	BTAPC/kqapVVSvZKca4nASw7bU982HGQiIXBIzt10WGg+i7oyKO343cw7mCt68ptxsfUUc8JsBDxL
	KzYrt5bvEdqkuK9DL8G1NM52w43XpyOGviFBfTbbBoCtvOLNINxTMcc35QEcRRWR4tt7jQrLw7STi
	uy/7tA+d3s6X0sEJ4SJlWsuzgBD+mbBYRxCCBDkJqGwgIlYaQe3iM9DdubIE0EgDz+KhVbj4g0Fy4
	SzVJTEE0pdCA+qqRI1h7YgqH0soeBJn+pI/Fa9dsNEd+IcL66cABvhAiJuwmMj1o2AGaDFyigL5Cq
	iLXkDAJA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmbH5-00000003DyP-0qcN;
	Mon, 24 Feb 2025 16:25:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6DD5530001B; Mon, 24 Feb 2025 17:25:42 +0100 (CET)
Date: Mon, 24 Feb 2025 17:25:42 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sathvika Vasireddy <sv@linux.ibm.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, christophe.leroy@csgroup.eu,
	npiggin@gmail.com, maddy@linux.ibm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	llvm@lists.linux.dev
Subject: Re: [RFC PATCH] objtool: Skip unannotated intra-function call
 warning for bl+mflr pattern
Message-ID: <20250224162542.GE11590@noisy.programming.kicks-ass.net>
References: <20250219162014.10334-1-sv@linux.ibm.com>
 <20250220195940.ely2l2fpsozd2tuv@jpoimboe>
 <4bea75bc-d3f6-4972-b644-f9b5a4e8bb77@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bea75bc-d3f6-4972-b644-f9b5a4e8bb77@linux.ibm.com>

On Fri, Feb 21, 2025 at 02:20:41PM +0530, Sathvika Vasireddy wrote:

> > > @@ -1625,6 +1626,11 @@ static int add_call_destinations(struct objtool_file *file)
> > >   		reloc = insn_reloc(file, insn);
> > >   		if (!reloc) {
> > >   			dest_off = arch_jump_destination(insn);
> > > +
> > > +			next_insn = next_insn_same_func(file, insn);
> > > +			if (next_insn && dest_off == next_insn->offset)
> > > +				continue;
> > > +
> > This won't work on x86, where an intra-function call is converted to a
> > stack-modifying JUMP.  So this should probably be checked in an
> > arch-specific function.
> 
> Thanks for letting me know, I'll introduce arch_skip_call_warning() to
> handle architecture specific cases in the next patch I send.

Can't you detect this pattern in decode and simpy not emit the call
instruction?

