Return-Path: <linux-kernel+bounces-396778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9528C9BD1D4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5995D2842E5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742B0170A1B;
	Tue,  5 Nov 2024 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NuxcjcWx"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F381172BD0
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730823070; cv=none; b=oH3TGBHQ+stC0hptu101JWhaVXvkvbQQgN7a6kwX6RL1LDEmKvSFco3PA7Ha0gyGw9KZsfS0urqRk21SkqEQtGcGtez3weWALLDjALfN+2Hl+5DnPXZ4y4NFJ4Df6rIuPxPtSPZ+AM9lBrWfriEqNMWi1asoi91pGP93if7ULyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730823070; c=relaxed/simple;
	bh=vaXaAysTRVD61jj3ukyb6Ay0rkgusoJQCJ6pnYnRVos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYbsrAaKKBT3Ckc6mP6g8fYugfHzRAVr0tsEmTcdcqVmNcyVgRwlrjdLIjUwEIcJBA19aYt9LApe26/tri1TqEVgL+X0+vsbq3ZG/KHVVL6J0RmYdBxhkUIS9qdlVk0J7VHYRvPnS32CLHbD/mrS5ybHRDfRPiajhj+tBPpHfQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NuxcjcWx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hfeZon3DfsDojIxOuuhlaDkntp0Fa5yyHrg6RvTtp1Y=; b=NuxcjcWxjUCGkgUROW1FYJK8Fw
	jj7+2PuLhtX1M20PzTY2e2rQ5eCgTkXq5frZJcxp71+bhSCmtyAPJivGQfoHlYr0wIBIGDwxym2NA
	64EQN2soeBUYKNvGubp45JrTIbDMR3gXv1oU1tGYre0lrPGteHrAD+gWVDFccvj91zvjnBUDNsJCv
	YS6vfdnxFgcFO+IOGugoIU7T8FI7775EtBIDCFT3xH9QPVyokQqa9isrz5jbPaNQe+IaeGET9ymCl
	GAd2zWZtlsOovvIGB/SZ5hQemrZgECNJljynx8KoGQLt58bNw7VQs9Vgr+E9WMOoRkK6eEUSX3hMD
	PzLjtAQA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8M92-00000003ICr-1Tpn;
	Tue, 05 Nov 2024 16:11:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 97BBF30042E; Tue,  5 Nov 2024 17:11:04 +0100 (CET)
Date: Tue, 5 Nov 2024 17:11:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	alexei.starovoitov@gmail.com, ebiggers@kernel.org,
	samitolvanen@google.com, kees@kernel.org
Subject: Re: [PATCH 1/8] x86,kcfi: Fix EXPORT_SYMBOL vs kCFI
Message-ID: <20241105161104.GK10375@noisy.programming.kicks-ass.net>
References: <20241105113901.348320374@infradead.org>
 <20241105114521.852053765@infradead.org>
 <Zyoood0ooSbpultV@infradead.org>
 <20241105142720.GG10375@noisy.programming.kicks-ass.net>
 <ZyosbEMNzMU6fOe_@infradead.org>
 <20241105145842.GH10375@noisy.programming.kicks-ass.net>
 <Zyo8mdoQOXa9kiBv@infradead.org>
 <20241105154740.GJ10375@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105154740.GJ10375@noisy.programming.kicks-ass.net>

On Tue, Nov 05, 2024 at 04:47:40PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 05, 2024 at 07:41:13AM -0800, Christoph Hellwig wrote:
> > On Tue, Nov 05, 2024 at 03:58:42PM +0100, Peter Zijlstra wrote:
> > > > bounded number of functions that are used as either default methods
> > > > or as ready made callbacks.  Everything else has no business being
> > > > called indirectly.  While disallowing this might be a bit of work,
> > > > I think it would be a great security improvement.
> > > 
> > > Well, we don't disagree. But since most of the EXPORT'ed functions are
> > > done in C, we need something that works there too.
> > 
> > Yes, absolutely.  In fact I doubt there are more than a handful of
> > assembly exports that are valid targets for indirect calls.
> 
> Yeah, I went overboard here. Let me tone it down a little.

OK, I removed a ton of them and fixed the build fallout. I've pushed it
out to the git tree mentioned somewhere, and will re-post in a few days.



