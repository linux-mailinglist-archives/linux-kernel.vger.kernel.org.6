Return-Path: <linux-kernel+bounces-262986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EE893CF6F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB1E1C21B74
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE6A176AA9;
	Fri, 26 Jul 2024 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yas2g6wg"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B455176246
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721981935; cv=none; b=Nmg9U1EMTiMcsLFxWuMq2pt2rqAseMa6uLGtGhqp9xhJYbdRlmef69kDXUfoxpto+2XgOkGoIWi/hW07Sa9cG5Bbv8L1r6mq6keGXtLBU1X+8qBpzesJxZrPhGpVRpiUy2GPbF56yne1XCXpnfHXZ1CeNGg7kgUH8xJG9L1/G5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721981935; c=relaxed/simple;
	bh=gZawXqEBSOKq3l+x6lvnCzwSP/j4q0qgw21LwxEow6w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=r8WiT027erRDmBs8vP96eED/JGnzYSur/jyqXRl8FoVAJwDWHig9cq2+NGOgkCq0jZsxvf8h3qoMa30tZq/p5EhWHy7YBOZZl2mxFdJ65fcFfwx1bllNQm22G2N0ev02OXuTMAS37nNKWvrJ4/I+YwjE3/vpsLJfj0LK51CHLV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yas2g6wg; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721981930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gZawXqEBSOKq3l+x6lvnCzwSP/j4q0qgw21LwxEow6w=;
	b=Yas2g6wg3Wuakf0TbRE0f6Ed8D4npM9i6I0tlobXpVQtXYaNXSUJVldh1h0kP0+xedybnU
	c03DY50+fI7KoUYlpAcQDC47BZTNJLAkKPYWmXK5KpJp+OOPwy0zkK5a5gVyfv22C98Auy
	e5sNYHvLqIpdWCEHCFZn1u/IllksfZI=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v1 2/2] mm/hugetlb: fix hugetlb vs. core-mm PT locking
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240725183955.2268884-3-david@redhat.com>
Date: Fri, 26 Jul 2024 16:18:06 +0800
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Xu <peterx@redhat.com>,
 Oscar Salvador <osalvador@suse.de>,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F678B4FD-A806-4BF9-8D8A-8679354A1068@linux.dev>
References: <20240725183955.2268884-1-david@redhat.com>
 <20240725183955.2268884-3-david@redhat.com>
To: David Hildenbrand <david@redhat.com>
X-Migadu-Flow: FLOW_OUT



> On Jul 26, 2024, at 02:39, David Hildenbrand <david@redhat.com> wrote:
>=20
> We recently made GUP's common page table walking code to also walk
> hugetlb VMAs without most hugetlb special-casing, preparing for the
> future of having less hugetlb-specific page table walking code in the
> codebase. Turns out that we missed one page table locking detail: page
> table locking for hugetlb folios that are not mapped using a single
> PMD/PUD.
>=20
> Assume we have hugetlb folio that spans multiple PTEs (e.g., 64 KiB
> hugetlb folios on arm64 with 4 KiB base page size). GUP, as it walks =
the
> page tables, will perform a pte_offset_map_lock() to grab the PTE =
table
> lock.
>=20
> However, hugetlb that concurrently modifies these page tables would
> actually grab the mm->page_table_lock: with USE_SPLIT_PTE_PTLOCKS, the
> locks would differ. Something similar can happen right now with =
hugetlb
> folios that span multiple PMDs when USE_SPLIT_PMD_PTLOCKS.
>=20
> Let's make huge_pte_lockptr() effectively uses the same PT locks as =
any
> core-mm page table walker would.
>=20
> There is one ugly case: powerpc 8xx, whereby we have an 8 MiB hugetlb
> folio being mapped using two PTE page tables. While hugetlb wants to =
take
> the PMD table lock, core-mm would grab the PTE table lock of one of =
both
> PTE page tables. In such corner cases, we have to make sure that both
> locks match, which is (fortunately!) currently guaranteed for 8xx as =
it
> does not support SMP.
>=20
> Fixes: 9cb28da54643 ("mm/gup: handle hugetlb in the generic =
follow_page_mask code")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.


