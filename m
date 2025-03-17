Return-Path: <linux-kernel+bounces-564827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20900A65B66
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E703BE5FB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D98A1AF0BF;
	Mon, 17 Mar 2025 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ak2UAg+p"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0E21A3168;
	Mon, 17 Mar 2025 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233733; cv=none; b=aE3ASHt5FbYpSu2oK7zGi640sgz4Jki25H3dPiofo8oQ+a+7YpKfRVwuzIhEP4lqCR4g0dDsjb6bUhkelbd6EZ2htf+873a1TU1O4JFC99Ixh8sI8MU/FDYjChEki5n60VQP3KJcp0kyEgIGivJDVNbgVhCuumkifXtCcjVcr4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233733; c=relaxed/simple;
	bh=gW5WrWEsRgzGYeA2WB5QR5OP8afZ6CKKTcYhrgeRDC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fADDa6XGm2GbVFieD+eBlPuOYQdqjvZqcBBC8ve8h5AWQU25zqcTTQ76WiE3jmcjokiZZPmb4b+HImkor5t5hQ0+KP3tzTJdM1/bFhP0VJniIOuGbgx/LcxwMcZn6wsWRnk6H76SxVYHRaQHlHGLD9gJ18mLtftpoD+gT6SSyng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ak2UAg+p; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3b0Uj79RdTQCZqfGxFLsxs3VkCOnmsKOMf9Ox34+5LQ=; b=Ak2UAg+pk2NqHPX/5EdoCo0swG
	SvUtVy3/95AiPFC6NJJnOVBL6Gzn8QvpZQ7SRxp+UZYGxMBia4jROI3kGBbR83d09iwuWNaB8bqcU
	YvgW3/VTG1qREOLJ1ga4coScnXLmHPQYrJejOBPKgBUKIx84V/0k7SWOxVfdRd6wG27bZ99RvtfTI
	OEha3nZCf0jPRDopdcH2VQWHULshgYuR5KCGP9h2C/0YQLf6m+mji2b+jRwX+FN6OAMuUc+Jb/s5o
	P0Jr4mQczwN7pj4lhejtL5sgwcXOdTkP5MpiKjVyQtyq79XJjGVrVBcPdeMhJ8i92tdxC3hFaIe/K
	RXbX1PtQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tuEa1-00000003XHM-1Bvd;
	Mon, 17 Mar 2025 17:48:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C9389300783; Mon, 17 Mar 2025 18:48:48 +0100 (CET)
Date: Mon, 17 Mar 2025 18:48:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/29] x86: treewide: Introduce
 x86_vendor_amd_or_hygon()
Message-ID: <20250317174848.GJ6888@noisy.programming.kicks-ass.net>
References: <20250317164745.4754-1-darwi@linutronix.de>
 <20250317164745.4754-2-darwi@linutronix.de>
 <20250317173216.GGZ9hcoDICYl1fBtBG@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317173216.GGZ9hcoDICYl1fBtBG@fat_crate.local>

On Mon, Mar 17, 2025 at 06:32:16PM +0100, Borislav Petkov wrote:
> On Mon, Mar 17, 2025 at 05:47:17PM +0100, Ahmed S. Darwish wrote:
> > The pattern to check if an x86 vendor is AMD or HYGON (or not both) is
> > pretty common.  Introduce x86_vendor_amd_or_hygon() at <asm/processor.h>
> 
> So if we need to check "intel too", we do
> 
> x86_vendor_amd_or_hygon_or_intel?
> 
> Nah, this is silly.

Would it make more sense to have a Zen1 feature and check that instead?

Because, IIRC Hygon is simply a Zen1 copy.

