Return-Path: <linux-kernel+bounces-409214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D609E9C8902
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFF7281402
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC581F8EEA;
	Thu, 14 Nov 2024 11:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c8xuPsnS"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F90318C331
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731583996; cv=none; b=OQAIfgQbLxawfX+35SE9uX5iX2+UnGqSm30RYhOgA1FbKwzVN4bL2BTI4Jt9XDdn4FPiPoroNOQ/3lPFddsG4hiyIkdTz9LEA6Y7RV1VcMTT26ua0fq5EeyVWSGcmmnvGOzhvioiBBStYv8Su98RInWKLOGzOWtgyde115rkyP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731583996; c=relaxed/simple;
	bh=ZNz1y1sfVBYaiMS/GHalfVQxscgaBlP9m3BB6cJoWmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m75w7qCnY/2mt/FB3ztzvb6w1YHmPI2DyU88bnbCKJiKjtyzbKEVPEu1MWgFhwNc3MAXBfXqg4MV7r39L431gKcCaMP1Rx+B96AU8wXex1W6W1qgNsj1oeoULqLF90l/WXi8w70U6byuJ7VDj2MZfYaXJ1J5zbzvrgM5d6brnSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c8xuPsnS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IaFWr+J+yg6nORfJz6H72knpkpnqDKGV/7um2ZwZNgo=; b=c8xuPsnSDUE9cvUsY51ejAPMB/
	IgkqT4ckiy+i0HfTxNRV6Ut17WbEC+0WoH3fTJuhwhtdk7f65f9Fv5poaOgfiktTZoYezOVwnC+8X
	WyoBMyuf/21hYaN01npluFwBeKic1UrcHRidCc+LjF0G7mmxdHBRrr+W/l5xqJ0mBNQ22f8LO9p8C
	kY0vnpMZ688u8QACulqtajAcCqAsx7k5V8Lor+CSlMDwpLD8bHxQN8hGSl8NHJqQadQmZBlePVsPi
	huVrkY3oZurvd2r8bgb8LTTXObnj7n56VxcujzLx9GL4gWR6s/iPrwhHMLC966MTwvgNij2ordErE
	Mm2Iu5Nw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBY5w-00000000eem-0clM;
	Thu, 14 Nov 2024 11:33:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 24F53300472; Thu, 14 Nov 2024 12:33:03 +0100 (CET)
Date: Thu, 14 Nov 2024 12:33:03 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Rik van Riel <riel@surriel.com>
Cc: Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com, luto@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, x86@kernel.org, kernel-team@meta.com,
	hpa@zytor.com, bigeasy@linutronix.de
Subject: Re: [PATCh 0/3] x86,tlb: context switch optimizations
Message-ID: <20241114113303.GN6497@noisy.programming.kicks-ass.net>
References: <20241109003727.3958374-1-riel@surriel.com>
 <20241113095550.GBZzR3pg-RhJKPDazS@fat_crate.local>
 <20241113093826.667c4918@imladris.surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113093826.667c4918@imladris.surriel.com>

On Wed, Nov 13, 2024 at 09:38:26AM -0500, Rik van Riel wrote:
> On Wed, 13 Nov 2024 10:55:50 +0100
> Borislav Petkov <bp@alien8.de> wrote:
> On Fri, Nov 08, 2024 at 07:27:47PM -0500, Rik van Riel wrote:
> > > While profiling switch_mm_irqs_off with several workloads,
> > > it appears there are two hot spots that probably don't need
> > > to be there.
> > 
> > One of those three is causing the below here, zapping them from tip.
> > 
> 
> This is interesting, and unexpected.
> 
> > [    3.186469] ------------[ cut here ]------------
> > [    3.186469] WARNING: CPU: 16 PID: 97 at kernel/smp.c:807
> > smp_call_function_many_cond+0x188/0x720
> 
> This is the lockdep_assert_irqs_enabled() from this branch:
> 
>         if (cpu_online(this_cpu) && !oops_in_progress &&
>             !early_boot_irqs_disabled)
>                 lockdep_assert_irqs_enabled();
> 
> > [    3.186469] Call Trace:
> > [    3.186469]  <TASK>
> > [    3.186469]  on_each_cpu_cond_mask+0x50/0x90
> > [    3.186469]  flush_tlb_mm_range+0x1a8/0x1f0
> > [    3.186469]  __text_poke+0x366/0x5d0
> 
> ... and sure enough, it looks like __text_poke() calls
> flush_tlb_mm_range() with IRQs disabled!
> 
> > [    3.186469]  text_poke_bp_batch+0xa1/0x3d0
> > [    3.186469]  text_poke_finish+0x1b/0x30
> > [    3.186469]  arch_jump_label_transform_apply+0x18/0x30
> > [    3.186469]  static_key_slow_inc_cpuslocked+0x55/0xa0
> ...
> 
> I have no good explanation for why that lockdep_assert_irqs_enabled()
> would not be firing without my patches applied.
> 
> We obviously should not be sending out any IPIs with IRQs disabled.
> 
> However, __text_poke has been sending IPIs with interrupts disabled
> for 4 years now! No wonder we see deadlocks involving __text_poke
> on a semi-regular basis.

I don't think we have. Isn't the problem with patch 1, where we
unuse_temporary_mm() now fails to clear the bit, with the direct result
being that flush_tlb_mm_range() now thinks it should be doing IPIs,
where previously it was a strict CPU local affair.

