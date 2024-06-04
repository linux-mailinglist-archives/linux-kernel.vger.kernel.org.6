Return-Path: <linux-kernel+bounces-199873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F01E8FA710
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 02:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D767A1F245DA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 00:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1549D4A0F;
	Tue,  4 Jun 2024 00:35:01 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E76C7FD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 00:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717461300; cv=none; b=ej4v85y2JPnPBdw0HaWJKnC7Nfaf2Hmnk8F+5NQkx/TR4zxVzc+RjlpNaP6+JiL9wLv9q9ucd8wQ/ddwGW5UEfa3tUhA0WnTxhD5QFgteoJDT6KmvC1JoCcASx7W6nLWkodIPHTFybYhAQ8v0i1C6VyLzQZPPEmAtSLvIdgVnjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717461300; c=relaxed/simple;
	bh=9eESyfqJ/yGAFl06BInHcQIvHy8hfok4asczlxc7ycA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjOn7mh1UK1NA4uqTG4DnVCJkv2sXp/fPtftFhHY3Ggj0cv8iAlhqncAu5ZQYowUrc+uUp1aeM+ezuimAfgcP9H9aYzeWhsAb0Npg4D1S+MkDGhwTEc619Speype/vbYpFJabJoNDrQ2yKfasPYQUqmY7FUE9GOGr7fJ58v2Cb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-ca-665e612dbd5d
Date: Tue, 4 Jun 2024 09:34:48 +0900
From: Byungchul Park <byungchul@sk.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>,
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
Message-ID: <20240604003448.GA26609@system.software.com>
References: <20240531092001.30428-10-byungchul@sk.com>
 <fab1dd64-c652-4160-93b4-7b483a8874da@intel.com>
 <CAHyrMpxETdVewTH3MCS4qPyD6Xf1zRUfWZf-8SCdpCFj2Pj_Wg@mail.gmail.com>
 <f17f33e8-1c1f-460f-8c5a-713476f524a3@intel.com>
 <26dc4594-430b-483c-a26c-7e68bade74b0@redhat.com>
 <20240603093505.GA12549@system.software.com>
 <d650c29b-129f-4fac-9a9d-ea1fbdae2c3a@intel.com>
 <35866f91-7d96-462a-aa0a-ac8a6b8cbcf8@redhat.com>
 <196481bb-b86d-4959-b69b-21fda4daae77@intel.com>
 <Zl320dWODSYw-PgV@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl320dWODSYw-PgV@casper.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsXC9ZZnka5uYlyawZunShZz1q9hs/i84R+b
	xaeXDxgtXmxoZ7T4uv4Xs8XTT30sFpd3zWGzuLfmP6vF0c5NzBbnd61ltdixdB+TxaUDC5gs
	jvceYLKYf+8zm8XmTVOZLY5Pmcpo8fsHUMfJWZNZHIQ8vrf2sXjsnHWX3WPBplKPzSu0PBbv
	ecnksWlVJ5vHpk+T2D3enTvH7nFixm8Wj3knAz3e77vK5rH1l51H49RrbB6fN8kF8EVx2aSk
	5mSWpRbp2yVwZZyb3c5c0Mhd8fDtJ6YGxoMcXYycHBICJhIf181ghrH7f+xnArFZBFQklq99
	yAhiswmoS9y48ROohoNDREBD4s0WI5Aws8B1ZolfD+VAbGGBAolXEyaxg9i8AhYSp+Y/Yeti
	5OIQEuhikZj/ZD0bREJQ4uTMJywQzVoSN/69ZAKZySwgLbH8H9g5nEAnbJ89A+wEUQFliQPb
	jjOBzJEQ2MUusf7AVKg7JSUOrrjBMoFRYBaSsbOQjJ2FMHYBI/MqRqHMvLLcxMwcE72MyrzM
	Cr3k/NxNjMDYXFb7J3oH46cLwYcYBTgYlXh4DRbFpgmxJpYVV+YeYpTgYFYS4e2ri04T4k1J
	rKxKLcqPLyrNSS0+xCjNwaIkzmv0rTxFSCA9sSQ1OzW1ILUIJsvEwSnVwDin5Wxw0OIvGg/d
	tk9737zItjQ2Slb8dV/3lfrvosp/Pq/xW7HGPGl52Hyuo0lFHu25S94E7mU5sO7hneXZF+fP
	dI7JMfkpemoDRzqX9T87Ab/ygvc1O9+/K9uz+0hd0wS91Ta9HgePVfYZnmOX+cEtKlplna+j
	xzaH+U6tVPLf/QKaG4P/LlNiKc5INNRiLipOBADYhGilyQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsXC5WfdrKubGJdm8GiaiMWc9WvYLD5v+Mdm
	8enlA0aLFxvaGS2+rv/FbPH0Ux+LxeG5J1ktLu+aw2Zxb81/VoujnZuYLc7vWstqsWPpPiaL
	SwcWMFkc7z3AZDH/3mc2i82bpjJbHJ8yldHi9w+gjpOzJrM4CHt8b+1j8dg56y67x4JNpR6b
	V2h5LN7zkslj06pONo9Nnyaxe7w7d47d48SM3ywe804Gerzfd5XNY/GLD0weW3/ZeTROvcbm
	8XmTXAB/FJdNSmpOZllqkb5dAlfGudntzAWN3BUP335iamA8yNHFyMkhIWAi0f9jPxOIzSKg
	IrF87UNGEJtNQF3ixo2fzF2MHBwiAhoSb7YYgYSZBa4zS/x6KAdiCwsUSLyaMIkdxOYVsJA4
	Nf8JWxcjF4eQQBeLxPwn69kgEoISJ2c+YYFo1pK48e8lE8hMZgFpieX/wE7gBDph++wZYCeI
	CihLHNh2nGkCI+8sJN2zkHTPQuhewMi8ilEkM68sNzEzx1SvODujMi+zQi85P3cTIzDSltX+
	mbiD8ctl90OMAhyMSjy8Fitj04RYE8uKK3MPMUpwMCuJ8PbVRacJ8aYkVlalFuXHF5XmpBYf
	YpTmYFES5/UKT00QEkhPLEnNTk0tSC2CyTJxcEo1MO6dpnV7YmW8o/KaM+tWvvZWPBQY5zJF
	UXTdr4Rrd8+xzw021AhcYnWv6F2t2DXTQFfla0veMZpeVbDVcb4xOX2v3tcTwh65tas/JB+R
	FKuqyxVxErddYlLc2vVxwuLC2TMSYv/J2vrp2YRnCax5J6rRa/K84b2eWdDtaX8+v4iK/rbj
	b8TDViWW4oxEQy3mouJEABoY+eiwAgAA
X-CFilter-Loop: Reflected

On Mon, Jun 03, 2024 at 06:01:05PM +0100, Matthew Wilcox wrote:
> On Mon, Jun 03, 2024 at 09:37:46AM -0700, Dave Hansen wrote:
> > Yeah, we'd need some equivalent of a PTE marker, but for the page cache.
> >  Presumably some xa_value() that means a reader has to go do a
> > luf_flush() before going any farther.
> 
> I can allocate one for that.  We've got something like 1000 currently
> unused values which can't be mistaken for anything else.
> 
> > That would actually have a chance at fixing two issues:  One where a new
> > page cache insertion is attempted.  The other where someone goes to look
> > in the page cache and takes some action _because_ it is empty (I think
> > NFS is doing some of this for file locks).
> > 
> > LUF is also pretty fundamentally built on the idea that files can't
> > change without LUF being aware.  That model seems to work decently for
> > normal old filesystems on normal old local block devices.  I'm worried
> > about NFS, and I don't know how seriously folks take FUSE, but it
> > obviously can't work well for FUSE.
> 
> I'm more concerned with:
> 
>  - page goes back to buddy
>  - page is allocated to slab

At this point, tlb flush needed will be performed in prep_new_page().

>  - application reads through stale TLB entry and sees kernel memory

No worry for this case.

	Byungchul
> 
> Or did that scenario get resolved?

