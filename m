Return-Path: <linux-kernel+bounces-199476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 363298D878E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD32D1F21E14
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807AA13777B;
	Mon,  3 Jun 2024 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kyo71aHP"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43933136E2B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 17:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434084; cv=none; b=GvfzGmAEK2c3zYSQ0o0sukTaB3SDRnVjoovCBm1Tt/sxf9Iw//4gnozEsYh+ULwvWhJ9+AOw3m0pFg6JDFwwhth+M9fVJn8wdP0Yg23SEuyE/+rd630kV5kzV6hjFiTeMw1nq7kFkMWPA2fPSr3REChyUdSXaIxS746qDN8ETUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434084; c=relaxed/simple;
	bh=dtegb95Yoog4s+bRLFOy72NiUIfsUaciwClLxjmqRgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dubTIrEZzXvEeUjndpHSOmMtEXZYCa1QOxo9+9sycj3CGDcrkqUesJMUZExBt+l7FrHk7sXwXR0YHYJ3ZWkYm1Aw4XuHsE49u2Hl099p3DhpAaT9V5mvNlGd3nGNcYXfU0jhyGN5ANngv/sDMRlLxabLLFb69MfmfO+PiFvNQeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kyo71aHP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rDTYr+MFhpo5KNC+O8/PJeMg4wx4hxlcpkT6/y8CQQs=; b=kyo71aHPY610RKZP6dlylIxAYy
	jrp8EIUgFOmXADj0oF/je4gZUA4b8TganmG9mGr0KaGPP+E6jTig1vSXaqtm/iYHHqLpILrft7YqF
	zwbkXfdwGiHBvmMv7teqhb5rAhx3l8rNWdkJq4yLrD1zQbwg30VP9J2fK1nazgWWSLx24xECykJ4C
	k6JWCYjdOW8GPinarGRA9775xRpQmSH8jNIHpT7ZkMxZdIQMgrVuWPbZ0WzrMCWyuUi/bs/U0zUFh
	+O40txmnK2SISB89RL9PdeTD0oIfCk1Wne4LzrD45nhaE4O2CMVikk+VC5V7BNI4FbqvkRQJwJ/w2
	nAJVHkBw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEB3R-0000000EEkG-1cMp;
	Mon, 03 Jun 2024 17:01:05 +0000
Date: Mon, 3 Jun 2024 18:01:05 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: David Hildenbrand <david@redhat.com>, Byungchul Park <byungchul@sk.com>,
	Byungchul Park <lkml.byungchul.park@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	ying.huang@intel.com, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, peterz@infradead.org,
	luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [PATCH v11 09/12] mm: implement LUF(Lazy Unmap Flush) defering
 tlb flush when folios get unmapped
Message-ID: <Zl320dWODSYw-PgV@casper.infradead.org>
References: <20240531092001.30428-1-byungchul@sk.com>
 <20240531092001.30428-10-byungchul@sk.com>
 <fab1dd64-c652-4160-93b4-7b483a8874da@intel.com>
 <CAHyrMpxETdVewTH3MCS4qPyD6Xf1zRUfWZf-8SCdpCFj2Pj_Wg@mail.gmail.com>
 <f17f33e8-1c1f-460f-8c5a-713476f524a3@intel.com>
 <26dc4594-430b-483c-a26c-7e68bade74b0@redhat.com>
 <20240603093505.GA12549@system.software.com>
 <d650c29b-129f-4fac-9a9d-ea1fbdae2c3a@intel.com>
 <35866f91-7d96-462a-aa0a-ac8a6b8cbcf8@redhat.com>
 <196481bb-b86d-4959-b69b-21fda4daae77@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <196481bb-b86d-4959-b69b-21fda4daae77@intel.com>

On Mon, Jun 03, 2024 at 09:37:46AM -0700, Dave Hansen wrote:
> Yeah, we'd need some equivalent of a PTE marker, but for the page cache.
>  Presumably some xa_value() that means a reader has to go do a
> luf_flush() before going any farther.

I can allocate one for that.  We've got something like 1000 currently
unused values which can't be mistaken for anything else.

> That would actually have a chance at fixing two issues:  One where a new
> page cache insertion is attempted.  The other where someone goes to look
> in the page cache and takes some action _because_ it is empty (I think
> NFS is doing some of this for file locks).
> 
> LUF is also pretty fundamentally built on the idea that files can't
> change without LUF being aware.  That model seems to work decently for
> normal old filesystems on normal old local block devices.  I'm worried
> about NFS, and I don't know how seriously folks take FUSE, but it
> obviously can't work well for FUSE.

I'm more concerned with:

 - page goes back to buddy
 - page is allocated to slab
 - application reads through stale TLB entry and sees kernel memory

Or did that scenario get resolved?

