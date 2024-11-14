Return-Path: <linux-kernel+bounces-409467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F19209C8D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B74E9282AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0262578C60;
	Thu, 14 Nov 2024 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X7/3xCCC"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B083128E0F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731595221; cv=none; b=Mr5Ol5wiovv2O1tQSVNXZk9VInL0ZsxVUWpgip0BR52SFQZPkPGUEUcIU3tUhd61qFmzEcEb18+BxlG95mqlC1YzyEhu84CQ/a9ZBriPDzhi8OrBr4WRRBsCtW6Cqupp1cowmuA/vFkOsGNqzp73W4sd9pz9E4Zm+BxCxYp0dEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731595221; c=relaxed/simple;
	bh=e7edyJtnJ4Cn5zeZha2hQbLwSsLKfWIP22qLw3+yZv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhUGzQQU/2U9TBxjI4ljUiaiWi6mKNsfzmQvKpflOEJLEd18GSLjV4lLishDZeCq0M4a53QSS3n44gE3WtrRM+3J8LN0R/aGo1j58ZYE0uaQFMtAtL3eRAiHJ8S5wFurLrxNd1ukbvn/Migb8kjW9A7tAUDU7ICAMT4yCm5hSgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X7/3xCCC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ON+yQ55DHGOGajBMdwOK6Cb6Pg8Z9gjV2I6XePDBKcU=; b=X7/3xCCCXcpOrDlQBRgudFnFwE
	pWXgLPGoSGmBUdsduvaokBeJ0NB+DOuQ8QvFb34eImhD8fxMjKJLXfpBnaJmKPs4uGAwY5tSlL7A/
	5JHj1KnbVjBRL3+ZWUaR3F83fhUOphzdC0os4KdeW3YNpwu+Bg/zb64N5BNALVsL/ChMf9hdwKkFZ
	su5lcwOC9XoJB7stA3hQa1LDgCKv9/tgMChZP2KR67I3m5oxL65ARj/Tg1h0owati+So53KCU7TTt
	ENo13Ev+5ERwpYdsculOmKL4hd9+Dc4yLBlEAaiIlMYKfLA7qRGCvlxK6GQhOC5SszA7Rg2HHJq/m
	6gMqU9Tg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBb0y-00000000vsp-3VXU;
	Thu, 14 Nov 2024 14:40:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0FD3A300446; Thu, 14 Nov 2024 15:40:08 +0100 (CET)
Date: Thu, 14 Nov 2024 15:40:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Rik van Riel <riel@surriel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
	linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
	luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	x86@kernel.org, kernel-team@meta.com, hpa@zytor.com,
	bigeasy@linutronix.de
Subject: Re: [PATCh 0/3] x86,tlb: context switch optimizations
Message-ID: <20241114144007.GB39245@noisy.programming.kicks-ass.net>
References: <20241109003727.3958374-1-riel@surriel.com>
 <20241113095550.GBZzR3pg-RhJKPDazS@fat_crate.local>
 <20241113095557.2d60a073@imladris.surriel.com>
 <ZzXIcAi4R5yH8ZtN@gmail.com>
 <cdba614a4522307fb06615fcc3909f2f2d03f333.camel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdba614a4522307fb06615fcc3909f2f2d03f333.camel@surriel.com>

On Thu, Nov 14, 2024 at 09:27:25AM -0500, Rik van Riel wrote:

> 1) Move the interrupt re-enabling up (probably not this one?)

Correct, that one is wrong for it results in IPIs that we don't want or
need.

> 2) Explicitly clear the mm_cpumask bit in unuse_temporary_mm()
> 
> 3) Have unuse_temporary_mm increment the mm's tlb_gen, since that
>    is the only thing flush_tlb_mm_range really does for an MM
>    without any bits set in the mm_cpumask.

So flush_tlb_mm_range() has an 'mm == loaded_mm' case, which does a
local flush. I *think* we're not hitting that because switch_mm() does a
write to loaded_mm() just before this.

But I don't think we want to proliferate the logic contained in
flush_tlb_mm_range() further than we have to.

So my preference goes to 2, as that seems to be the safest option.
Notably text_poke() it not concerned with performance much.

