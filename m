Return-Path: <linux-kernel+bounces-524880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D14ACA3E853
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B416719C0307
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C36266F1D;
	Thu, 20 Feb 2025 23:23:42 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6141D5CDD
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093822; cv=none; b=TPqiejyc6TJ7suCVNjJlvH+AVpUIzWtjQcv2pp2bD5nZkxCgAbZq0lCm20mwnyUYKc+nhjD6togqRZBQLrwgqbeddgElA55OrOnfJJuWcsz6MVMBZ4pwBEV0FVSq/Gx40zVOqVtlwld6uPXj/Jtc8Uqp4lrQCu+tyqMLd+OMNCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093822; c=relaxed/simple;
	bh=Hr+P/lUTONRuYGjGw07pt5nCppUo+OK5T7GMh7oyyKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLaVXwDX1f+DzOE5Km5+oouf7jOXxtifvvJPTTSs6ik2zTo7RG0xivCauYHCkKZV4juBw0SCvg8kxrdFyrgvsv5fJG9px7lqQgU/jd643CPSRxerwMRWCeDQjV3sOT/vvfyFLCTEx2x1DMWu2PivXHk2XlAZrd0WfC++AdPhjK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-17-67b7b976c54b
Date: Fri, 21 Feb 2025 08:23:29 +0900
From: Byungchul Park <byungchul@sk.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	ying.huang@intel.com, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
	david@redhat.com, peterz@infradead.org, luto@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [RFC PATCH v12 00/26] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
Message-ID: <20250220232329.GA39373@system.software.com>
References: <20250220052027.58847-1-byungchul@sk.com>
 <8accbd91-ca59-43f8-b190-7e1ac3df5e11@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8accbd91-ca59-43f8-b190-7e1ac3df5e11@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsXC9ZZnkW7Zzu3pBguPKlrMWb+GzeLzhn9s
	Fp9ePmC0eLGhndHi6/pfzBZPP/WxWFzeNYfN4t6a/6wW53etZbXYsXQfk8WlAwuYLI73HmCy
	mH/vM5vF5k1TmS2OT5nKaPH7B1DxyVmTWRwEPb639rF47Jx1l91jwaZSj80rtDwW73nJ5LFp
	VSebx6ZPk9g93p07x+5xYsZvFo95JwM93u+7yuax9ZedR+PUa2wenzfJBfBFcdmkpOZklqUW
	6dslcGVMfrWCveARd8W2lj+sDYwLOLsYOTkkBEwkWnbfY+5i5ACzn/Skg4RZBFQllj7pZQax
	2QTUJW7c+AlmiwDZp1YuZ+9i5OJgFvjPJHH/YStYQlggQuLJoRNMIDavgIXE74lLGUFsIYEM
	iWkbHrNAxAUlTs58AmYzC2hJ3Pj3kglkL7OAtMTyfxwgYU4BW4k77Z/BxogKKEsc2HacCeLM
	bewSyz9wQdiSEgdX3GCZwCgwC8nUWUimzkKYuoCReRWjUGZeWW5iZo6JXkZlXmaFXnJ+7iZG
	YDwuq/0TvYPx04XgQ4wCHIxKPLwJptvThVgTy4orcw8xSnAwK4nwttVvSRfiTUmsrEotyo8v
	Ks1JLT7EKM3BoiTOa/StPEVIID2xJDU7NbUgtQgmy8TBKdXAmG0Rxv+pv9xomd0fK64bSX6b
	b7x+2NLLXPXJLF+nQ0L9/PNVfQn8L98IVLpa22lVMKRvbnuQVxkntLTldaY0r1CJ9qYtKXG9
	ZlMe/TT+35n5rNSo6svkwG5/c9bC+3Ne3OyvlP0Zdn+57Alz3u21fj+Lj0idSE+M1P+20PKL
	efT+OyViCsuUWIozEg21mIuKEwFFwUxXwwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsXC5WfdrFu2c3u6wYfn4hZz1q9hs/i84R+b
	xaeXDxgtXmxoZ7T4uv4Xs8XTT30sFofnnmS1uLxrDpvFvTX/WS3O71rLarFj6T4mi0sHFjBZ
	HO89wGQx/95nNovNm6YyWxyfMpXR4vcPoOKTsyazOAh5fG/tY/HYOesuu8eCTaUem1doeSze
	85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHvNOBnq833eVzWPxiw9MHlt/2Xk0Tr3G5vF5k1wA
	fxSXTUpqTmZZapG+XQJXxuRXK9gLHnFXbGv5w9rAuICzi5GDQ0LAROJJT3oXIycHi4CqxNIn
	vcwgNpuAusSNGz/BbBEg+9TK5exdjFwczAL/mSTuP2wFSwgLREg8OXSCCcTmFbCQ+D1xKSOI
	LSSQITFtw2MWiLigxMmZT8BsZgEtiRv/XjKB7GUWkJZY/o8DJMwpYCtxp/0z2BhRAWWJA9uO
	M01g5J2FpHsWku5ZCN0LGJlXMYpk5pXlJmbmmOoVZ2dU5mVW6CXn525iBMbXsto/E3cwfrns
	fohRgINRiYc3wXR7uhBrYllxZe4hRgkOZiUR3rb6LelCvCmJlVWpRfnxRaU5qcWHGKU5WJTE
	eb3CUxOEBNITS1KzU1MLUotgskwcnFINjNKbX24SE1x3fcu1I8/nshUfv2nX8FZ5gdUb6Q28
	d8oU9qc35zpu8H3X22R27c2MBUXy5Q199bfWhwp0pUr/698z8Upor9T7z5LJX/ecmcGzaYPy
	7FN/rBlOzd/gZZ+zNZphWb37jerETsGfX6Ywi6zT8Co3n3th6sq33LEpPqsnXzaeWzhVx1+J
	pTgj0VCLuag4EQDIkqvyqwIAAA==
X-CFilter-Loop: Reflected

On Thu, Feb 20, 2025 at 07:15:44AM -0800, Dave Hansen wrote:
> On 2/19/25 21:20, Byungchul Park wrote:
> > I'm posting the latest version so that anyone can try luf mechanism if
> > wanted by any chance.  However, I tagged RFC again because there are
> > still issues that should be resolved to merge to mainline:
> 
> I don't see anything fundamentally different here from the last 11
> versions. I think the entire approach is dangerous and basically makes
> things impossible to debug. It's not clear that some of the failure
> scenarios that I've brought up in the past have actually been fixed.

Respect your opinion.

> What I've said here still stands:
> 
> > https://lore.kernel.org/all/fab1dd64-c652-4160-93b4-7b483a8874da@intel.com/
> 
> > I think tglx would call all of this "tinkering".  The approach to this
> > series is to "fix" narrow, specific cases that reviewers point out, make
> > it compile, then send it out again, hoping someone will apply it.
> > 
> > So, for me, until the approach to this series changes: NAK, for x86.
> > Andrew, please don't take this series.  Or, if you do, please drop the
> > patch enabling it on x86.
> 
> I think I'd also like to stop being cc'd on this. If LUF is merged into

I will un-cc you from the next spin.

	Byungchul

> mainline and proven to work on arm64 or riscv for a year, I'd be happy
> to take another look at enabling it on x86. I think that's just about
> the only thing that would make me reconsider.

