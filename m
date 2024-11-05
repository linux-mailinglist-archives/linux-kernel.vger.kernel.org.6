Return-Path: <linux-kernel+bounces-396707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDF39BD0F9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 034BC283832
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082AA14F119;
	Tue,  5 Nov 2024 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BGjBd9Ld"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D1114E2D6
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730821671; cv=none; b=iC4Z9oMrtBMrOOpiMmg1n0cJENQhfQjYLqXLP1cxqlALgLroHOdWnplNXocBm4tunbG0M9eAzkWCfnpH2/iCREfFiliPtLNjCvxxR7lHl2dZact7AFP27uxgvjAXe0PVcIT4hn3agdFTkxDQTZvdNzWlbYu5+PZxMo//8qjhCjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730821671; c=relaxed/simple;
	bh=b4JxhKk+qzVWyzHBA6rmzXPBYUmIQjqMN2u9dreJhYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONEqDIW4hOemf72JYiRb0j6yRxYepx12Qy3evrw4hljBW0MCcRZQjUAYfqJqN8oqFfDDGCbN+0FLepJWZ6UJhcPNpPbVXciBwUcQQl20YnCRXQyufJbbZAAeEFokPxueZ3zYnXU3oY67PUqkr2SVPLF12p7f6q6GRFpgQ3IPDSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BGjBd9Ld; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pHw5hsM7tIl2gWEhPjw+S55y1XlrBZRQWV05erCwC3g=; b=BGjBd9LdD1Fi33G+5QkOpIKhj3
	G+K3ofCUSSu8QjfohnPa97ddIsguCXPoEYWr62IB7CNres8EkOg3iH4pUgsrZAp2veZNHEzGLOVRG
	p5/qfrsKGpdSqDdmLvkm6qYZYlGS/aCYX3O+tVa1twOeLxDKmqWpoA1R0X62xKlqz9tzowOFSbbud
	VfujHdDOEQTV4D2357WZhaINPNFRWYyDI9Q7MTxFRccgYsRgbk2JzDL19XAwp53g1fSgIPo0RhwGc
	vTfFAGwosT096HFUTLlpkHUEetJlFnPM/SYbabR0Ju9UG6BIurK6f62Nwp5IoT+nWtBKOUz2Wd4x1
	DhyUDXRw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8LmO-00000003GTU-3psB;
	Tue, 05 Nov 2024 15:47:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8F36330042E; Tue,  5 Nov 2024 16:47:40 +0100 (CET)
Date: Tue, 5 Nov 2024 16:47:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	alexei.starovoitov@gmail.com, ebiggers@kernel.org,
	samitolvanen@google.com, kees@kernel.org
Subject: Re: [PATCH 1/8] x86,kcfi: Fix EXPORT_SYMBOL vs kCFI
Message-ID: <20241105154740.GJ10375@noisy.programming.kicks-ass.net>
References: <20241105113901.348320374@infradead.org>
 <20241105114521.852053765@infradead.org>
 <Zyoood0ooSbpultV@infradead.org>
 <20241105142720.GG10375@noisy.programming.kicks-ass.net>
 <ZyosbEMNzMU6fOe_@infradead.org>
 <20241105145842.GH10375@noisy.programming.kicks-ass.net>
 <Zyo8mdoQOXa9kiBv@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zyo8mdoQOXa9kiBv@infradead.org>

On Tue, Nov 05, 2024 at 07:41:13AM -0800, Christoph Hellwig wrote:
> On Tue, Nov 05, 2024 at 03:58:42PM +0100, Peter Zijlstra wrote:
> > > bounded number of functions that are used as either default methods
> > > or as ready made callbacks.  Everything else has no business being
> > > called indirectly.  While disallowing this might be a bit of work,
> > > I think it would be a great security improvement.
> > 
> > Well, we don't disagree. But since most of the EXPORT'ed functions are
> > done in C, we need something that works there too.
> 
> Yes, absolutely.  In fact I doubt there are more than a handful of
> assembly exports that are valid targets for indirect calls.

Yeah, I went overboard here. Let me tone it down a little.

