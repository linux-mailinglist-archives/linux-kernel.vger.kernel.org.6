Return-Path: <linux-kernel+bounces-547650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA86A50BFE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0297016FF04
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695432566CB;
	Wed,  5 Mar 2025 19:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QASbOe78"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C10254B09
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204540; cv=none; b=V45GQRBcekyZBJPmGcXTMWT3+OkuW5QOYG18IS8o5C874pNxcMyXm/eNsOXYvsSEGpWWKDoix9xsjdLc6Ag2sroLvXpo/4y6cx72iILuIUMbkMYKmmFf0DR/8iwZNTGRNSZhfEaVFToLO+pJIjH+bqmqe7k+oU6pbDIzdTQucZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204540; c=relaxed/simple;
	bh=GLQ2hhASLmjtNMDIBmNt+vg3kC2QMbCrfNgPLvED20M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDfRslDedUIMtN/7RmrkIGcdNvFwWFAz5ywLmpwlJGIme3yxbCKJTq1mvA+tLXVcvO0dyQTObN5+nr5NY/O8HNM+nuyY1NqOeyDoD4FkoslL2RBI/YAyNfets5NbO4mpjmlI20txTNtx0/jQ5lghLR3Zy5/CS76yOy5axH+ghbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QASbOe78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5F3C4CEE8;
	Wed,  5 Mar 2025 19:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741204540;
	bh=GLQ2hhASLmjtNMDIBmNt+vg3kC2QMbCrfNgPLvED20M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QASbOe786OGzi7rq+l7DNTX3uRjP9hgILvR/Zr2YYBO0QM89OxJRwvll3VyLKiPIR
	 zb2Om90MyskJuM8QtbpdKitZwJIThEkTOYTynEazrKGMAFRiYbo3/gIGY8yadNiseS
	 bU7yL/BBhPJskVSgYsFYTAdPnDiWKMN6ZOToOjpqk9KqRJpO3wNDU8Yuy3KGa/U45J
	 PhQY8CbQSum+OTqNOe+ZWYltebVFljwEkr6kFS+gNljbD2rNgiUH0+sBhn0VAhze+p
	 wB3zC00XBFoL1fvX2HEvwc5CGKlTkYgc34Zc9iCly1MiB/BNrET0nxiS/t0nuxP2dy
	 tTX06z6rHSJlQ==
Date: Wed, 5 Mar 2025 20:55:35 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
Message-ID: <Z8isNxBxC9pcG4KL@gmail.com>
References: <20250228123825.2729925-1-ubizjak@gmail.com>
 <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
 <CAFULd4bpHGE83qc37sbh=rpGj+SFqQrsNDLzL_-NQpo6pQH3jw@mail.gmail.com>
 <c4aca08a-95c1-48ee-b4da-55a69b74101c@intel.com>
 <CAFULd4YVOEtT+bsp9H7ijaoJn2e2108tWhiFarRv=QxoUMZaiw@mail.gmail.com>
 <20250301123802.GCZ8L_qsv7-WwUwqt5@fat_crate.local>
 <CAFULd4b=4rHcVAVSg_3yMb8=3ReiSriw_rM4vJL9_HvheXE92w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4b=4rHcVAVSg_3yMb8=3ReiSriw_rM4vJL9_HvheXE92w@mail.gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> On Sat, Mar 1, 2025 at 1:38 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Sat, Mar 01, 2025 at 10:05:56AM +0100, Uros Bizjak wrote:
> > > OTOH, -Os, where different code size/performance heuristics are used, now
> > > performs better w.r.t code size.
> >
> > Did anything change since:
> >
> > 281dc5c5ec0f ("Give up on pushing CC_OPTIMIZE_FOR_SIZE")
> > 3a55fb0d9fe8 ("Tell the world we gave up on pushing CC_OPTIMIZE_FOR_SIZE")
> >
> > wrt -Os?
> >
> > Because if not, we still don't love -Os and you can drop the -Os argument.
> 
> The -Os argument was to show the effect of the patch when the compiler
> is instructed to take care of the overall size. Giving the compiler
> -O2 and then looking at the overall size of the produced binary is
> just wrong.
> 
> > And without any perf data showing any improvement, this patch does nothing but
> > enlarge -O2 size...
> 
> Even to my surprise, the patch has some noticeable effects on the
> performance, please see the attachment in [1] for LMBench data or [2]
> for some excerpts from the data. So, I think the patch has potential
> to improve the performance.
> 
> [1] https://lore.kernel.org/lkml/CAFULd4YBcG45bigHBox2pu+To+Y5BzbRxG+pUr42AVOWSnfKsg@mail.gmail.com/
> [2] https://lore.kernel.org/lkml/CAFULd4ZsSKwJ4Dz3cCAgaVsa4ypbb0e2savO-3_Ltbs=1wzgKQ@mail.gmail.com/

If you are measuring micro-costs, please make sure you pin the workload 
to a single CPU (via 'taskset' for example) and run 'perf stat --null 
--repeat 5' or so to measure the run-over-run noise of the benchmark.

Thanks,

	Ingo

