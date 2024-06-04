Return-Path: <linux-kernel+bounces-200023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5DF8FA963
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 06:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505211C237D7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 04:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F79E13D897;
	Tue,  4 Jun 2024 04:44:02 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B0413D612
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 04:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717476242; cv=none; b=fmDhc2eTayoyPesUUnxO70LjmuS2Xd2/NTjmFwJxCEnd8YILFFfbODvuWhhseqjX1MSWdRCDiEr/UmYsJFaPujj07Gp0ac5rtto5uAQ7w93gUCDV7JOS0Ocn5FWT2CHYlK18RaW78YKMyeqE3sQ7N6Va2X9Oe7QbIfrhaYNiUGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717476242; c=relaxed/simple;
	bh=7LI5ux4GJv/h8UlHrP4MxDT10Nhtoln9W3s2YzHqyuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgFtjKnvG1B6HgRDTdQbgqPvu42z5E97lgDP8rDLyz1Lc1JhO8cnSfj2YLMpUzWxlLDiurUK9TlJ45EhUhZSjavSMlU8PGVHP+OPo6hwa7KKajC9wQ9ENaCTc9hGWo386ijKFlhtaYdVRqFCBqPb6XjpbxjDmBQVfrPWCjQwDTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-68-665e9b8ac73f
Date: Tue, 4 Jun 2024 13:43:48 +0900
From: Byungchul Park <byungchul@sk.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: David Hildenbrand <david@redhat.com>,
	Byungchul Park <lkml.byungchul.park@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	ying.huang@intel.com, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
	peterz@infradead.org, luto@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: Re: [PATCH v11 09/12] mm: implement LUF(Lazy Unmap Flush) defering
 tlb flush when folios get unmapped
Message-ID: <20240604044348.GA40889@system.software.com>
References: <20240531092001.30428-1-byungchul@sk.com>
 <20240531092001.30428-10-byungchul@sk.com>
 <fab1dd64-c652-4160-93b4-7b483a8874da@intel.com>
 <CAHyrMpxETdVewTH3MCS4qPyD6Xf1zRUfWZf-8SCdpCFj2Pj_Wg@mail.gmail.com>
 <f17f33e8-1c1f-460f-8c5a-713476f524a3@intel.com>
 <26dc4594-430b-483c-a26c-7e68bade74b0@redhat.com>
 <20240603093505.GA12549@system.software.com>
 <d650c29b-129f-4fac-9a9d-ea1fbdae2c3a@intel.com>
 <20240604015348.GB26609@system.software.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604015348.GB26609@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsXC9ZZnkW7X7Lg0gweXRCzmrF/DZvF5wz82
	i08vHzBavNjQzmjxdf0vZounn/pYLC7vmsNmcW/Nf1aLo52bmC3O71rLarFj6T4mi0sHFjBZ
	HO89wGQx/95nNovNm6YyWxyfMpXR4vcPoI6TsyazOAh5fG/tY/HYOesuu8eCTaUem1doeSze
	85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHvNOBnq833eVzWPrLzuPxqnX2Dw+b5IL4IvisklJ
	zcksSy3St0vgypg+qYOp4IF0xcED1xgbGLtEuxg5OSQETCT62yeydzFygNmTZpWDmCwCKhJN
	nVEgFWwC6hI3bvxkBrFFgOxTK5cDVXNxMAscZ5b48HERI0hCWKBA4tWESWBjeAUsJA4eUAap
	ERK4wixxdPJXsGZeAUGJkzOfsIDYzAJaEjf+vWQCqWcWkJZY/o8DJMwpYCnxsuELG4gtKqAs
	cWDbcSaQORICh9glrjz9ywJxsqTEwRU3WCYwCsxCMnYWkrGzEMYuYGRexSiUmVeWm5iZY6KX
	UZmXWaGXnJ+7iREYmctq/0TvYPx0IfgQowAHoxIPr8Gi2DQh1sSy4srcQ4wSHMxKIrx9ddFp
	QrwpiZVVqUX58UWlOanFhxilOViUxHmNvpWnCAmkJ5akZqemFqQWwWSZODilGhhjCzfWapQo
	TK1RNmnZlbP25tn234+t82bN3bCWx0FrA8+X3m22z0pP63MuXtJWNqvlKuPmmuWL0i/4X+V8
	XLRQM13rhsTr9VqHC+bdj/QyObvx/6o2nXemy10fBzVdS9t+MlM3w/SBR/8Xo1mnHmh6nZz/
	g1/D+lZFTO1ynVvKrUomPWa1vZ+UWIozEg21mIuKEwHap/ENyAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsXC5WfdrNs1Oy7N4PE2Jos569ewWXze8I/N
	4tPLB4wWLza0M1p8Xf+L2eLppz4Wi8NzT7JaXN41h83i3pr/rBZHOzcxW5zftZbVYsfSfUwW
	lw4sYLI43nuAyWL+vc9sFps3TWW2OD5lKqPF7x9AHSdnTWZxEPb43trH4rFz1l12jwWbSj02
	r9DyWLznJZPHplWdbB6bPk1i93h37hy7x4kZv1k85p0M9Hi/7yqbx+IXH5g8tv6y82iceo3N
	4/MmuQD+KC6blNSczLLUIn27BK6M6ZM6mAoeSFccPHCNsYGxS7SLkYNDQsBEYtKschCTRUBF
	oqkzqouRk4NNQF3ixo2fzCC2CJB9auVy9i5GLg5mgePMEh8+LmIESQgLFEi8mjCJHaSXV8BC
	4uABZZAaIYErzBJHJ38Fa+YVEJQ4OfMJC4jNLKAlcePfSyaQemYBaYnl/zhAwpwClhIvG76w
	gdiiAsoSB7YdZ5rAyDsLSfcsJN2zELoXMDKvYhTJzCvLTczMMdUrzs6ozMus0EvOz93ECIyz
	ZbV/Ju5g/HLZ/RCjAAejEg+vxcrYNCHWxLLiytxDjBIczEoivH110WlCvCmJlVWpRfnxRaU5
	qcWHGKU5WJTEeb3CUxOEBNITS1KzU1MLUotgskwcnFINjNcbgl4GrJoVvGG5zM3l9m7tU0Jv
	W7qv7s/aq6fPKRYfdiL6XcKuhfYntrRE7pi83GVP7IOS5ceEDkd5R59vPXxRLj8oIStoxkwN
	j9MRsS2GSxdrVS9Mbb2upbiE9+IB7cfMu/u2f5hQc95xe9Gl0/ZL2e4vW6udmvI4vN/la2j+
	KseziyPYPiixFGckGmoxFxUnAgDVlhqirwIAAA==
X-CFilter-Loop: Reflected

On Tue, Jun 04, 2024 at 10:53:48AM +0900, Byungchul Park wrote:
> On Mon, Jun 03, 2024 at 06:23:46AM -0700, Dave Hansen wrote:
> > On 6/3/24 02:35, Byungchul Park wrote:
> > ...> In luf's point of view, the points where the deferred flush should be
> > > performed are simply:
> > > 
> > > 	1. when changing the vma maps, that might be luf'ed.
> > > 	2. when updating data of the pages, that might be luf'ed.
> > 
> > It's simple, but the devil is in the details as always.
> 
> Agree with that.
> 
> > > All we need to do is to indentify the points:
> > > 
> > > 	1. when changing the vma maps, that might be luf'ed.
> > > 
> > > 	   a) mmap and munmap e.i. fault handler or unmap_region().
> > > 	   b) permission to writable e.i. mprotect or fault handler.
> > > 	   c) what I'm missing.
> > 
> > I'd say it even more generally: anything that installs a PTE which is
> > inconsistent with the original PTE.  That, of course, includes writes.
> > But it also includes crazy things that we do like uprobes.  Take a look
> > at __replace_page().
> > 
> > I think the page_vma_mapped_walk() checks plus the ptl keep LUF at bay
> > there.  But it needs some really thorough review.
> > 
> > But the bigger concern is that, if there was a problem, I can't think of
> > a systematic way to find it.
> > 
> > > 	2. when updating data of the pages, that might be luf'ed.
> > > 
> > > 	   a) updating files through vfs e.g. file_end_write().
> > > 	   b) updating files through writable maps e.i. 1-a) or 1-b).
> > > 	   c) what I'm missing.
> > 
> > Filesystems or block devices that change content without a "write" from
> > the local system.  Network filesystems and block devices come to mind.
> 
> AFAIK, every network filesystem eventully "updates" its connected local
> filesystem.  It could be still handled at the point where updating the
> local file system.
> 
> > I honestly don't know what all the rules are around these, but they
> > could certainly be troublesome.
> > 
> > There appear to be some interactions for NFS between file locking and
> > page cache flushing.
> > 
> > But, stepping back ...
> > 
> > I'd honestly be a lot more comfortable if there was even a debugging LUF
> 
> I'd better provide a method for better debugging.  Lemme know whatever
> it is we need.
> 
> > mode that enforced a rule that said:

Do you means a debugging mode that can WARN or inform the situation that
we don't want?  If yes, sure.  Now that I get this, I will re-read all
you guys' talk.

	Byungchul

> Why "debugging mode"?  The following rules should be enforced always.
> 
> >   1. A LUF'd PTE can't be rewritten until after a luf_flush() occurs
> 
> "luf_flush() should be followed when.." is more correct because
> "luf_flush() -> another luf -> the pte gets rewritten" can happen.  So
> it should be "the pte gets rewritten -> another luf by any chance ->
> luf_flush()", that is still safe.
> 
> >   2. A LUF'd page's position in the page cache can't be replaced until
> >      after a luf_flush()
> 
> "luf_flush() should be followed when.." is more correct too.
> 
> These two rules are exactly same as what I described but more specific.
> I like your way to describe the rules.
> 
> 	Byungchul
> 
> > or *some* other independent set of rules that can tell us when something
> > goes wrong.  That uprobes code, for instance, seems like it will work.
> > But I can also imagine writing it ten other ways where it would break
> > when combined with LUF.

