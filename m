Return-Path: <linux-kernel+bounces-409022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FA19C867D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5257BB238CF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8641F7074;
	Thu, 14 Nov 2024 09:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NH3ss3A8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF31E1F470B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731577974; cv=none; b=XlgIE0ZNgc5fLKZNgaMfx671oJ9aZ//gE6w65QXuUKzWyROMhZ/TSn3ko7ZLZkpyHMbhPtAZVcI2/hexsfrvSE7mRUZo7ewJi/grwrPhZnonWQK2GstAC9bRd4o93o2d6+beHYTxm6Ok4Yw1arWfmhjrKlHw0dxbGYdz0H4vGeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731577974; c=relaxed/simple;
	bh=lszfiZ3qgnonwEy+12pGSuqz+8BIeXPqRJLACSMhzDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rV1TtZBY1krTyTXqw7KQ8pAa7eeIX9BPmsc0yymjr9uCdwEzrN5qX3OjJZ4mwHBrzh7MyPJijaOxwYQ6se1enc2E282JPUllqe1JxqLoCD31YOVKJ/8E5qqz0/G4v961RBvmdgyOR2Q9itgkrjwrQeKqh794mEtpEEVnsDj5PDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NH3ss3A8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92666C4CECD;
	Thu, 14 Nov 2024 09:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731577974;
	bh=lszfiZ3qgnonwEy+12pGSuqz+8BIeXPqRJLACSMhzDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NH3ss3A8akbPxOO9hDGxnkFKdxQH1Nbivs23I4bhYVqVdb7tvHugUTYr990UTVRlg
	 sBv5eqyzEjdKIeHsra1BeohrzAqrkocm49sSOl3CJM3D6z9MWe9KdT/yyejspdalUQ
	 0cEhwoe9a+ZnmmYgn3n4NpkJXBVOn/tInwDoX+YiLLwvVbEF3nn/NLweBdg0YW/AN/
	 vGXmaCrdhQ7V5cuiGpGqJ12ZWqqK1kPkyFbRNEJ1TXL4ig/vnIFWX4iD8A3wa19B6w
	 UlI7yvx8KiGKfTw6XRbiu+/gCJtr9yfRPyx0X4mpnJx3BV0zXWd018+Dfn5EtI7g+B
	 p0yEgMTLT1vzw==
Date: Thu, 14 Nov 2024 10:52:48 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Rik van Riel <riel@surriel.com>
Cc: Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
	kernel-team@meta.com, hpa@zytor.com, bigeasy@linutronix.de
Subject: Re: [PATCh 0/3] x86,tlb: context switch optimizations
Message-ID: <ZzXIcAi4R5yH8ZtN@gmail.com>
References: <20241109003727.3958374-1-riel@surriel.com>
 <20241113095550.GBZzR3pg-RhJKPDazS@fat_crate.local>
 <20241113095557.2d60a073@imladris.surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113095557.2d60a073@imladris.surriel.com>


* Rik van Riel <riel@surriel.com> wrote:

> On Wed, 13 Nov 2024 10:55:50 +0100
> Borislav Petkov <bp@alien8.de> wrote:
> 
> > On Fri, Nov 08, 2024 at 07:27:47PM -0500, Rik van Riel wrote:
> > > While profiling switch_mm_irqs_off with several workloads,
> > > it appears there are two hot spots that probably don't need
> > > to be there.  
> > 
> > One of those three is causing the below here, zapping them from tip.
> > 
> 
> TL;DR: __text_poke ends up sending IPIs with interrupts disabled.
> 
> > [    3.186469]  on_each_cpu_cond_mask+0x50/0x90
> > [    3.186469]  flush_tlb_mm_range+0x1a8/0x1f0
> > [    3.186469]  ? cpu_bugs_smt_update+0x14/0x1f0
> > [    3.186469]  __text_poke+0x366/0x5d0
> 
> Here is an alternative to avoid __text_poke() from calling
> on_each_cpu_cond_mask() with IRQs disabled:
> 
> ---8<---
> From e872edeaad14c793036f290afc28000281e1b76a Mon Sep 17 00:00:00 2001
> From: Rik van Riel <riel@surriel.com>
> Date: Wed, 13 Nov 2024 09:51:16 -0500
> Subject: [PATCH] x86/alternatives: defer poking_mm TLB flush to next use

I'd argue *both* of your patches improve the code, right?

Mind sending an updated series? It might not make it into the merge window,
but these look like good changes to me.

Thanks,

	Ingo

