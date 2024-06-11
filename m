Return-Path: <linux-kernel+bounces-209148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA90902DE4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 03:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A736B211F8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 01:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE6511720;
	Tue, 11 Jun 2024 01:10:44 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816B710A1C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 01:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718068243; cv=none; b=fZLnliqwJH/qMYujuTlewvjXFpMF84HHN1FB0A9QLRYDEk0wwfGgWtDwoAdL4pR/KGMChZfboZjKRLQmFJ9V5KQDunWOOCld3jrq07DHfMMXWpDsYkr1UNDtH4GQzNEAtjMhvbjqqnGv0mSlffiyKGTKcy9tSSVt/TPsUeI4pLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718068243; c=relaxed/simple;
	bh=jRaCH5nIF7gKU8dxlxss/0Oj+TUSsI7RXOAmfrxgvuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUUfipeQzdjYnPJCOlb3L/8wbBGcOlyiWE1w9jXk2p2YZpYyK1KKuVi2y6JGV70iYiDCu4EQbSzDGIzSg4YfpBDBYCQXnQVawRyaNT/CjVv4K3SEH0kjNAqS5LSLhm3TM+7Y/6cklMWde5S+vIxvHIcg+RSYE6bMVVa1LEfDey8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-3f-6667a0816763
Date: Tue, 11 Jun 2024 09:55:23 +0900
From: Byungchul Park <byungchul@sk.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Dave Hansen <dave.hansen@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Byungchul Park <lkml.byungchul.park@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	ying.huang@intel.com, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, peterz@infradead.org,
	luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [PATCH v11 09/12] mm: implement LUF(Lazy Unmap Flush) defering
 tlb flush when folios get unmapped
Message-ID: <20240611005523.GA4384@system.software.com>
References: <CAHyrMpxETdVewTH3MCS4qPyD6Xf1zRUfWZf-8SCdpCFj2Pj_Wg@mail.gmail.com>
 <f17f33e8-1c1f-460f-8c5a-713476f524a3@intel.com>
 <26dc4594-430b-483c-a26c-7e68bade74b0@redhat.com>
 <20240603093505.GA12549@system.software.com>
 <d650c29b-129f-4fac-9a9d-ea1fbdae2c3a@intel.com>
 <35866f91-7d96-462a-aa0a-ac8a6b8cbcf8@redhat.com>
 <196481bb-b86d-4959-b69b-21fda4daae77@intel.com>
 <Zl320dWODSYw-PgV@casper.infradead.org>
 <20240604003448.GA26609@system.software.com>
 <Zmb-ZZHbeNNjcs68@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zmb-ZZHbeNNjcs68@tiehlicka>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsXC9ZZnkW7jgvQ0gytrRS3mrF/DZvF5wz82
	i08vHzBavNjQzmjxdf0vZounn/pYLC7vmsNmcW/Nf1aLo52bmC3O71rLarFj6T4mi/t9DhaX
	Dixgsjjee4DJYv69z2wWmzdNZbY4PmUqo8XvH0BdJ2dNZnEQ9vje2sfisXPWXXaPBZtKPTav
	0PJYvOclk8emVZ1sHps+TWL3eHfuHLvHiRm/WTzmnQz0eL/vKpvH+i1XWTy2/rLzaJx6jc3j
	8ya5AP4oLpuU1JzMstQifbsErow1P9cxFhwRrNjU3MLawHiQt4uRk0NCwETiz/7HTDD2j8Nn
	gGwODhYBVYkr7eIgYTYBdYkbN34yg9giAkoSXZt3snUxcnEwC/xnlvgx7xgbSEJYoEDi1YRJ
	7CA2r4C5xMwNT9lBioQEfjBL/DlzhxEiIShxcuYTFhCbWUBL4sa/l2DLmAWkJZb/4wAxOQU0
	Jbqe1INUiAooSxzYdpwJZIyEwDl2iYa3q6DulJQ4uOIGywRGgVlIps5CMnUWwtQFjMyrGIUy
	88pyEzNzTPQyKvMyK/SS83M3MQKjdVntn+gdjJ8uBB9iFOBgVOLhPfExLU2INbGsuDL3EKME
	B7OSCO+ZmPQ0Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxS
	DYwOOyZz7//i8jvcxmgK/wyfs8nS/bvlz6//MlvLyeSqFUPyCQNpdr9bemU6913Xt4rfVDl4
	7NC+67t51M4u3nn4UvxEq3AZvzMxdZn+bO1b5p2O2rjh0KveDN51nr+YNPuLDy37vqNW6oWJ
	bH9AXg2LCEeucNPvto2Ksronlr+ODY7eZcCz01yJpTgj0VCLuag4EQDau6sG0gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsXC5WfdrNu4ID3N4NwVVos569ewWXze8I/N
	4tPLB4wWLza0M1p8Xf+L2eLppz4Wi8NzT7JaXN41h83i3pr/rBZHOzcxW5zftZbVYsfSfUwW
	9/scLC4dWMBkcbz3AJPF/Huf2Sw2b5rKbHF8ylRGi98/gLpOzprM4iDi8b21j8Vj56y77B4L
	NpV6bF6h5bF4z0smj02rOtk8Nn2axO7x7tw5do8TM36zeMw7Gejxft9VNo/FLz4weazfcpXF
	Y+svO4/GqdfYPD5vkgsQiOKySUnNySxLLdK3S+DKWPNzHWPBEcGKTc0trA2MB3m7GDk5JARM
	JH4cPsPUxcjBwSKgKnGlXRwkzCagLnHjxk9mEFtEQEmia/NOti5GLg5mgf/MEj/mHWMDSQgL
	FEi8mjCJHcTmFTCXmLnhKTtIkZDAD2aJP2fuMEIkBCVOznzCAmIzC2hJ3Pj3EmwZs4C0xPJ/
	HCAmp4CmRNeTepAKUQFliQPbjjNNYOSdhaR5FpLmWQjNCxiZVzGKZOaV5SZm5pjqFWdnVOZl
	Vugl5+duYgTG3rLaPxN3MH657H6IUYCDUYmH98THtDQh1sSy4srcQ4wSHMxKIrxnYtLThHhT
	EiurUovy44tKc1KLDzFKc7AoifN6hacmCAmkJ5akZqemFqQWwWSZODilGhg7KlXuf3J6L5x2
	TVVA9YHfacl3xg7GKf76T0TzzdOW2feydeyRPZpT91xH2Znz+yMlkc3z/XzXxT/00fn2+irH
	4ftrlr7+eXIlS++7wG3X93K4Pj9/wPJuyfzgun+TkmNN/m1uYjq//eMfY4+jh82m3BaPMjX5
	dLrNi+X8E86k7yy+TyPmy8xXYinOSDTUYi4qTgQAvvh5wrkCAAA=
X-CFilter-Loop: Reflected

On Mon, Jun 10, 2024 at 03:23:49PM +0200, Michal Hocko wrote:
> On Tue 04-06-24 09:34:48, Byungchul Park wrote:
> > On Mon, Jun 03, 2024 at 06:01:05PM +0100, Matthew Wilcox wrote:
> > > On Mon, Jun 03, 2024 at 09:37:46AM -0700, Dave Hansen wrote:
> > > > Yeah, we'd need some equivalent of a PTE marker, but for the page cache.
> > > >  Presumably some xa_value() that means a reader has to go do a
> > > > luf_flush() before going any farther.
> > > 
> > > I can allocate one for that.  We've got something like 1000 currently
> > > unused values which can't be mistaken for anything else.
> > > 
> > > > That would actually have a chance at fixing two issues:  One where a new
> > > > page cache insertion is attempted.  The other where someone goes to look
> > > > in the page cache and takes some action _because_ it is empty (I think
> > > > NFS is doing some of this for file locks).
> > > > 
> > > > LUF is also pretty fundamentally built on the idea that files can't
> > > > change without LUF being aware.  That model seems to work decently for
> > > > normal old filesystems on normal old local block devices.  I'm worried
> > > > about NFS, and I don't know how seriously folks take FUSE, but it
> > > > obviously can't work well for FUSE.
> > > 
> > > I'm more concerned with:
> > > 
> > >  - page goes back to buddy
> > >  - page is allocated to slab
> > 
> > At this point, tlb flush needed will be performed in prep_new_page().
> 
> But that does mean that an unaware caller would get an additional
> overhead of the flushing, right? I think it would be just a matter of

pcp for locality is already a better source of side channel attack.  FYI,
tlb flush gets barely performed only if pending tlb flush exists.

> time before somebody can turn that into a side channel attack, not to
> mention unexpected latencies introduced.

Nope.  The pending tlb flush performed in prep_new_page() is the one
that would've done already with the vanilla kernel.  It's not additional
tlb flushes but it's subset of all the skipped ones.

It's worth noting all the existing mm reclaim mechaisms have already
introduced worse unexpected latencies.

	Byungchul

> -- 
> Michal Hocko
> SUSE Labs

