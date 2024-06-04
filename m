Return-Path: <linux-kernel+bounces-199918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F9C8FA7CC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 03:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 953D7285FA4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EF713D8B3;
	Tue,  4 Jun 2024 01:54:04 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595A713D516
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 01:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466043; cv=none; b=IooL3t/M62pWA1q6f8spDYRgJRE5Q3OSAgyWAzKaFiIAreklcYo0/iBkP+0HsV86mJjGFVh+/zhH0a2Ek7PbSwfwEpiEGz/jEHMFLyk3pt1z8IlDy/hAjb2bo10uyc2Qz5yXCBSFiqX7LUXXq7pJhfQgumhKqW75BZTTaooHOBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466043; c=relaxed/simple;
	bh=RuiQ5txz7H8Nvbx41vaQR5IL8AYZnkkH5lo5zZ57mmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYLu0KnRYnsdNA5Oa12Xa1AvC2gfMm2L6pCheqPYJV2Sy/HInIfoUoaf6SoZHlAI3jiniq0SO9HKPueZn5eWjc1g9XJbOfFaQpFKN1iJWzjcbeD8IgFjnRte0UmvWtOx63QGlbxUzGSMG3je6JAhG8x8TFyjzRQhxcIO+YbvOOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-6d-665e73b234f8
Date: Tue, 4 Jun 2024 10:53:48 +0900
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
Message-ID: <20240604015348.GB26609@system.software.com>
References: <20240531092001.30428-1-byungchul@sk.com>
 <20240531092001.30428-10-byungchul@sk.com>
 <fab1dd64-c652-4160-93b4-7b483a8874da@intel.com>
 <CAHyrMpxETdVewTH3MCS4qPyD6Xf1zRUfWZf-8SCdpCFj2Pj_Wg@mail.gmail.com>
 <f17f33e8-1c1f-460f-8c5a-713476f524a3@intel.com>
 <26dc4594-430b-483c-a26c-7e68bade74b0@redhat.com>
 <20240603093505.GA12549@system.software.com>
 <d650c29b-129f-4fac-9a9d-ea1fbdae2c3a@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d650c29b-129f-4fac-9a9d-ea1fbdae2c3a@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsXC9ZZnoe6m4rg0g42NohZz1q9hs/i84R+b
	xaeXDxgtXmxoZ7T4uv4Xs8XTT30sFpd3zWGzuLfmP6vF0c5NzBbnd61ltdixdB+TxaUDC5gs
	jvceYLKYf+8zm8XmTVOZLY5Pmcpo8fsHUMfJWZNZHIQ8vrf2sXjsnHWX3WPBplKPzSu0PBbv
	ecnksWlVJ5vHpk+T2D3enTvH7nFixm8Wj3knAz3e77vK5rH1l51H49RrbB6fN8kF8EVx2aSk
	5mSWpRbp2yVwZcz/u5+54JRExa+p05gbGP8KdTFyckgImEjsfLiDGcY+dnwvO4jNIqAisXnW
	UlYQm01AXeLGjZ9gNSJA9qmVy4FquDiYBY4zS3z4uIgRJCEsUCDxasIksGZeAQuJO+/7WECK
	hASWMkssfD2bFSIhKHFy5hMWEJtZQEvixr+XTF2MHEC2tMTyfxwgYU4BW4ljfbfBlokKKEsc
	2HacCWSOhMA+domnH3tZIS6VlDi44gbLBEaBWUjGzkIydhbC2AWMzKsYhTLzynITM3NM9DIq
	8zIr9JLzczcxAuNzWe2f6B2Mny4EH2IU4GBU4uE1WBSbJsSaWFZcmXuIUYKDWUmEt68uOk2I
	NyWxsiq1KD++qDQntfgQozQHi5I4r9G38hQhgfTEktTs1NSC1CKYLBMHp1QD4yTfzCPPN94J
	WOZwa1pizu3KRZKqxhJ3X0w76+m++ssczYPvGP9l7nx9aI1M8uF3dyNPGWemC/ubW7+f0SQZ
	ssYo5czxBfy7rkwpP6+t8ufkf06XY2XfmC8+mNh8buUVzquWEh2cNz3+Xp5lKNKiqyigszX/
	WvxK59VHuUSzqkKUS+ZL9U83mqLEUpyRaKjFXFScCAC+mXiYywIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsXC5WfdrLupOC7N4Ph5Jos569ewWXze8I/N
	4tPLB4wWLza0M1p8Xf+L2eLppz4Wi8NzT7JaXN41h83i3pr/rBZHOzcxW5zftZbVYsfSfUwW
	lw4sYLI43nuAyWL+vc9sFps3TWW2OD5lKqPF7x9AHSdnTWZxEPb43trH4rFz1l12jwWbSj02
	r9DyWLznJZPHplWdbB6bPk1i93h37hy7x4kZv1k85p0M9Hi/7yqbx+IXH5g8tv6y82iceo3N
	4/MmuQD+KC6blNSczLLUIn27BK6M+X/3Mxeckqj4NXUacwPjX6EuRk4OCQETiWPH97KD2CwC
	KhKbZy1lBbHZBNQlbtz4yQxiiwDZp1YuB6rh4mAWOM4s8eHjIkaQhLBAgcSrCZPAmnkFLCTu
	vO9jASkSEljKLLHw9WxWiISgxMmZT1hAbGYBLYkb/14ydTFyANnSEsv/cYCEOQVsJY713QZb
	JiqgLHFg23GmCYy8s5B0z0LSPQuhewEj8ypGkcy8stzEzBxTveLsjMq8zAq95PzcTYzAaFtW
	+2fiDsYvl90PMQpwMCrx8FqsjE0TYk0sK67MPcQowcGsJMLbVxedJsSbklhZlVqUH19UmpNa
	fIhRmoNFSZzXKzw1QUggPbEkNTs1tSC1CCbLxMEp1cAoISpaW/JqTZfK5SMc813WmAXsNtq3
	wNpzztQORq4puR+Nz1+yXHFHZs7rSb4NKZU6+R8m7lS1u5Kbd8birQTb/t07zD7OPsd4WPhh
	Serfp50/r11pqko7u69g/7EzSm7yuqWbTpxZrKzL+qrCZSXnzgXae56Xiqbt78kXP/8s4GDA
	YmsxE0EWJZbijERDLeai4kQAW72aJLICAAA=
X-CFilter-Loop: Reflected

On Mon, Jun 03, 2024 at 06:23:46AM -0700, Dave Hansen wrote:
> On 6/3/24 02:35, Byungchul Park wrote:
> ...> In luf's point of view, the points where the deferred flush should be
> > performed are simply:
> > 
> > 	1. when changing the vma maps, that might be luf'ed.
> > 	2. when updating data of the pages, that might be luf'ed.
> 
> It's simple, but the devil is in the details as always.

Agree with that.

> > All we need to do is to indentify the points:
> > 
> > 	1. when changing the vma maps, that might be luf'ed.
> > 
> > 	   a) mmap and munmap e.i. fault handler or unmap_region().
> > 	   b) permission to writable e.i. mprotect or fault handler.
> > 	   c) what I'm missing.
> 
> I'd say it even more generally: anything that installs a PTE which is
> inconsistent with the original PTE.  That, of course, includes writes.
> But it also includes crazy things that we do like uprobes.  Take a look
> at __replace_page().
> 
> I think the page_vma_mapped_walk() checks plus the ptl keep LUF at bay
> there.  But it needs some really thorough review.
> 
> But the bigger concern is that, if there was a problem, I can't think of
> a systematic way to find it.
> 
> > 	2. when updating data of the pages, that might be luf'ed.
> > 
> > 	   a) updating files through vfs e.g. file_end_write().
> > 	   b) updating files through writable maps e.i. 1-a) or 1-b).
> > 	   c) what I'm missing.
> 
> Filesystems or block devices that change content without a "write" from
> the local system.  Network filesystems and block devices come to mind.

AFAIK, every network filesystem eventully "updates" its connected local
filesystem.  It could be still handled at the point where updating the
local file system.

> I honestly don't know what all the rules are around these, but they
> could certainly be troublesome.
> 
> There appear to be some interactions for NFS between file locking and
> page cache flushing.
> 
> But, stepping back ...
> 
> I'd honestly be a lot more comfortable if there was even a debugging LUF

I'd better provide a method for better debugging.  Lemme know whatever
it is we need.

> mode that enforced a rule that said:

Why "debugging mode"?  The following rules should be enforced always.

>   1. A LUF'd PTE can't be rewritten until after a luf_flush() occurs

"luf_flush() should be followed when.." is more correct because
"luf_flush() -> another luf -> the pte gets rewritten" can happen.  So
it should be "the pte gets rewritten -> another luf by any chance ->
luf_flush()", that is still safe.

>   2. A LUF'd page's position in the page cache can't be replaced until
>      after a luf_flush()

"luf_flush() should be followed when.." is more correct too.

These two rules are exactly same as what I described but more specific.
I like your way to describe the rules.

	Byungchul

> or *some* other independent set of rules that can tell us when something
> goes wrong.  That uprobes code, for instance, seems like it will work.
> But I can also imagine writing it ten other ways where it would break
> when combined with LUF.

