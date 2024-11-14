Return-Path: <linux-kernel+bounces-409218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4D59C8915
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22B131F2584F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096F81F8F17;
	Thu, 14 Nov 2024 11:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NDXD5U8h"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B181F9413
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731584202; cv=none; b=R2z5ieHC0v7GnjRRB36ZwoMpKqmRuDmGQpU9CTUkmrbQfXKoF+YTFSxM0isckYEDV5uPc+lR5v730DwKskG9QSZNVSkjX3tkBwG9ClPlfNP3BDYb/eVg0jt9WZ/BTV+kopWvOZwGXTdw4T8bp8T4SyVRdVcdiTabMed7Fkw3ABs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731584202; c=relaxed/simple;
	bh=RjEqXZW7G6PgskxRuCPoqRiyYTFHvTbuuqQ0EXQxJ0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4rXBsd44U72UoAjGclFi21BUaYDTW+ae082jks7geBH2SmGqmEeLn6GCI30A+oc8pplEb6KzaKtY/W7l9+fDr7lAJhKK8Tz0kRlaDi/UF6zCSzfCMNPXYykG/p4t9hHJq6vQzQjfv7QA7iQr9zF6pPCTxxE+tanVa1XOC9Zy8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NDXD5U8h; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LnEN4mKfGvtLuqC+FK9EHA3E78X1W7MaLS/jIl6uOjc=; b=NDXD5U8hwfydEilOPoF06Ux5yw
	Lm4CDjSA12PIUIxFKofKvBp2o9wIYvruosISLDUFbLPlxMKPLRUqdOBW3L3cwj+9PIfIiiX1MGxnP
	yPCwFFHHarERm8AbzFIM2ACFKvpKZm48GemBYIRSqAqUz0T12BWvLxa/mluBWmTaxWFMooAnbsWom
	GD2o5i+o6Gb9idqDD1fHWc/aspj/v8uh5BT2KRIPhoSK8hEZTAgeUyb1D5tZ1dCMXZLUiEIMsq7pS
	roLPteGgCEGjIvW4g90h+FjABfCOlNhAPgzGaJERUKYV60NV/dJyLFf66v396lrONe1+R81wPyEc4
	JxhEHXTw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBY9H-000000000jS-09iT;
	Thu, 14 Nov 2024 11:36:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B0C8E300472; Thu, 14 Nov 2024 12:36:30 +0100 (CET)
Date: Thu, 14 Nov 2024 12:36:30 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Rik van Riel <riel@surriel.com>, Borislav Petkov <bp@alien8.de>,
	linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
	luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	x86@kernel.org, kernel-team@meta.com, hpa@zytor.com,
	bigeasy@linutronix.de
Subject: Re: [PATCh 0/3] x86,tlb: context switch optimizations
Message-ID: <20241114113630.GP6497@noisy.programming.kicks-ass.net>
References: <20241109003727.3958374-1-riel@surriel.com>
 <20241113095550.GBZzR3pg-RhJKPDazS@fat_crate.local>
 <20241113095557.2d60a073@imladris.surriel.com>
 <ZzXIcAi4R5yH8ZtN@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzXIcAi4R5yH8ZtN@gmail.com>

On Thu, Nov 14, 2024 at 10:52:48AM +0100, Ingo Molnar wrote:
> 
> * Rik van Riel <riel@surriel.com> wrote:
> 
> > On Wed, 13 Nov 2024 10:55:50 +0100
> > Borislav Petkov <bp@alien8.de> wrote:
> > 
> > > On Fri, Nov 08, 2024 at 07:27:47PM -0500, Rik van Riel wrote:
> > > > While profiling switch_mm_irqs_off with several workloads,
> > > > it appears there are two hot spots that probably don't need
> > > > to be there.  
> > > 
> > > One of those three is causing the below here, zapping them from tip.
> > > 
> > 
> > TL;DR: __text_poke ends up sending IPIs with interrupts disabled.
> > 
> > > [    3.186469]  on_each_cpu_cond_mask+0x50/0x90
> > > [    3.186469]  flush_tlb_mm_range+0x1a8/0x1f0
> > > [    3.186469]  ? cpu_bugs_smt_update+0x14/0x1f0
> > > [    3.186469]  __text_poke+0x366/0x5d0
> > 
> > Here is an alternative to avoid __text_poke() from calling
> > on_each_cpu_cond_mask() with IRQs disabled:
> > 
> > ---8<---
> > From e872edeaad14c793036f290afc28000281e1b76a Mon Sep 17 00:00:00 2001
> > From: Rik van Riel <riel@surriel.com>
> > Date: Wed, 13 Nov 2024 09:51:16 -0500
> > Subject: [PATCH] x86/alternatives: defer poking_mm TLB flush to next use
> 
> I'd argue *both* of your patches improve the code, right?

No, please don't.

