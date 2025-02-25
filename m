Return-Path: <linux-kernel+bounces-530784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9641EA4384B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC0A8164164
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F0626159E;
	Tue, 25 Feb 2025 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mJDf8EUn"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71138261586
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473658; cv=none; b=jwcIH26/KzD8HkKyh9YA1LveoiPqSP8/d64mR0q7E70ZRyHRsL/ZZwYAIlzgpuMF5X22T3W4CmdQFx2MdyIaiyC4m6zj7663eqZX7LFOIqj+++6aHaFlaabp3HACyU0PVOedjGmC1ww4wDCZSREJdSvYjZm4mNH5Ino19cqm0i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473658; c=relaxed/simple;
	bh=H6eBJlZ0MjZo3PEfUNW+LYpR7w4IejSuVblrFazHj7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcFBkbkMWENhDLJQTFI8d6urTkClR2jJBU+MNRNX74q1AjaxpnykbnAbO6e+1z0b7ltAD2j9xK5MH6CTWRP5z/uLqcPP8feC7Sur6JLSLfITcw9PNGiMaK7S8hejFi4nr8bpvizqkjWAjF0DuYzbjh5Ci3KUEa0ZFxgpkoleL4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mJDf8EUn; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ol5dy1S8jF5La50bagO80NpvW4GDvP3HgM9TsCiAWHk=; b=mJDf8EUnXe/Uy4f8/k6tSPQrIc
	7c21ZUAVu8Gy958C+S1QZcQwhxxxFDF8HWa1taJzrUmkjbsh/xGGdlYbjL+xNpoqukO6ll167JHtT
	qXd2UKgOD7Q0Ynp8cnLcGlJPGgh7iKZB2Of+turn9G/nDXHwh4qxxEfsq/BFtCIYk+/qwMhCetSmH
	HpZdkzU1nwZnR03aatzc8Jqt5DMxBURQhqZ/lfpCyftO6CGIttxptm4oyuQy0Sl4zW8f/EqVqoq38
	QTcSzvpfaQy6ZxTjehdL7SP55pQ1zdqwYum8wPeDBSFFVEQS244c7EsFKD+mT7XZ2XUuBRigIt3LL
	QKmnTZUQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmqhc-00000003K8G-1Eic;
	Tue, 25 Feb 2025 08:54:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CEA51300472; Tue, 25 Feb 2025 09:54:07 +0100 (CET)
Date: Tue, 25 Feb 2025 09:54:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
	jmill@asu.edu
Subject: Re: [PATCH v4 04/10] x86/traps: Allow custom fixups in handle_bug()
Message-ID: <20250225085407.GH11590@noisy.programming.kicks-ass.net>
References: <20250224123703.843199044@infradead.org>
 <20250224124200.275223080@infradead.org>
 <202502241058.BF06AF37C@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202502241058.BF06AF37C@keescook>

On Mon, Feb 24, 2025 at 10:59:21AM -0800, Kees Cook wrote:
> On Mon, Feb 24, 2025 at 01:37:07PM +0100, Peter Zijlstra wrote:
> > The normal fixup in handle_bug() is simply continuing at the next
> > instruction. However upcomming patches make this the wrong thing, so
> > allow handlers (specifically handle_cfi_failure()) to over-ride
> > regs->ip.
> > 
> > The callchain is such that the fixup needs to be done before it is
> > determined if the exception is fatal, as such, revert any changes in
> > that case.
> > 
> > Additinoally, have handle_cfi_failure() remember the regs->ip value it
> 
> typo above, if you want to tweak that in your tree.

Typing is forever hard :-)

> > starts with for reporting.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Thanks for the added comment, my future brain will appreciate it. :)
> 
> Reviewed-by: Kees Cook <kees@kernel.org>

Thanks!

