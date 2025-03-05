Return-Path: <linux-kernel+bounces-547510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE745A50A4A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4FED3AC54D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CA42512ED;
	Wed,  5 Mar 2025 18:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g1sIXQ0J"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6F118A6B5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200712; cv=none; b=CV8JL2Cup97bSF1ZLKG8luaUfrggs7pEcYElsDAZjl37Nho3gnJVWxWHk2AEFevq+drCY5XDzOp5SPMbRnylQQJ90PMnmdMFvmuZRHXdT+c7Tuy1QfrMY3aM+8aG9GKHhQnh5qelj2ZYtbhuLoFU6KDuyNuXWzrvS0OjqcAa5ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200712; c=relaxed/simple;
	bh=RfmfL0IS+LyFgRufp3oTF1BFRsEV9ReRdkYc7pkwIBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeqMgqpxf7Xv1OVH7T3VfyeL08Ee0Ox9MC3nONAHDmCzrkPEX0LjsjXk0jLfrVC9IKyq8t1BZ8H4RI5Me3A4ntOWfExDZf8LK2nVQ6p2mUFTVq54gjiXagKGC2SrG3nVQ0HMFFYKeV5Wb7zs1drLP2Ma72NqzUf/8AD4kWD9WD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g1sIXQ0J; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ezOs1RA2PMdRaE8a2I0woDGQvoaxmyX96aKleIL4//s=; b=g1sIXQ0Jf8DI6ZYbvF038gQjrB
	cp/c8KUBs+7VxZDugWYDbTZIOpUTwfRzDyUrlOP2RnM4tkHkVmCHNksqwmn78NQ4fKU8ynMUftOG0
	IJQd+474/XV5udfbijLYOw5Z41frOj6cyNMg2TctzvIgSRqMdcbRd3weXyUE2UjbSidapyhF+zMFc
	pO4n/PTwDIR5R1wR58wOn8BhP9g62+Fvtzov+oGQsG14A5tk0S236A6Wujk4S6mst55ecpZ7Q1Pug
	ldsCdMEg8xzIafE8LA2rSxAmITBMfeBsL7mw39+fEhxKjOQS/+X+wp8mg7wyLJgg3Qom39xAPIH75
	fN5tRq+A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tptqG-000000062MY-3Hw2;
	Wed, 05 Mar 2025 18:51:41 +0000
Date: Wed, 5 Mar 2025 18:51:40 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Liu Shixin <liushixin2@huawei.com>, linux-mm@kvack.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Lance Yang <ioworker0@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Softlockup when test shmem swapout-swapin and compaction
Message-ID: <Z8idPCkaJW1IChjT@casper.infradead.org>
References: <28546fb4-5210-bf75-16d6-43e1f8646080@huawei.com>
 <c4a07dd6-fffa-41f4-b6ff-3e333d1b5fc2@linux.alibaba.com>
 <376D50C9-6DC8-4F58-9C43-173EDCD412DD@nvidia.com>
 <3812C3CC-DC05-46D2-9A87-920797227105@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3812C3CC-DC05-46D2-9A87-920797227105@nvidia.com>

On Wed, Mar 05, 2025 at 01:44:29PM -0500, Zi Yan wrote:
> OK, it is probably still caused by the __folio_migrate_mapping() bug, since
> writing to sibling entries of a multi-index entry breaks the multi-index entry.
> Thank Matthew for doing the experiments.

Here's what I did:

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 0e865bab4a10..4f38db416ff6 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -645,6 +645,26 @@ static noinline void check_multi_store_3(struct xarray *xa, unsigned long index,

        xa_destroy(xa);
 }
+
+static noinline void check_multi_store_4(struct xarray *xa, unsigned long index,
+               unsigned int order)
+{
+       XA_STATE(xas, xa, index);
+       int i;
+
+       xa_store_order(xa, index, order, xa_mk_value(0), GFP_KERNEL);
+       xa_dump(xa);
+
+       xas_lock(&xas);
+       for (i = 0; i < (1 << order); i++) {
+               xas_store(&xas, xa_mk_value(index));
+               xas_next(&xas);
+       }
+       xas_unlock(&xas);
+       xa_dump(xa);
+
+       xa_destroy(xa);
+}
 #endif

 static noinline void check_multi_store(struct xarray *xa)
@@ -724,6 +744,7 @@ static noinline void check_multi_store(struct xarray *xa)
                check_multi_store_3(xa, 0, i);
                check_multi_store_3(xa, 1UL << i, i);
        }
+       check_multi_store_4(xa, 16, 4);
 #endif
 }


The xa_dump before shows sibling entries:

$ ./tools/testing/radix-tree/xarray
xarray: 0x55b2335be180x head 0x516004c75b82x flags 0 marks 0 0 0
0-63: node 0x516004c75b80x max 0 parent (nil)x shift 0 count 16 values 16 array 0x55b2335be180x list 0x516004c75b98x 0x516004c75b98x marks 0 0 0
16: value 0 (0x0) [0x1x]
17: sibling (slot 16)
18: sibling (slot 16)
19: sibling (slot 16)
[...]

And then after shows them turned into normal entries:

xarray: 0x55b2335be180x head 0x516004c75b82x flags 0 marks 0 0 0
0-63: node 0x516004c75b80x max 0 parent (nil)x shift 0 count 16 values 31 array 0x55b2335be180x list 0x516004c75b98x 0x516004c75b98x marks 0 0 0
16: value 16 (0x10) [0x21x]
17: value 16 (0x10) [0x21x]
18: value 16 (0x10) [0x21x]
19: value 16 (0x10) [0x21x]

so I understand why this took a long time to show up.  For most uses,
you can't tell the difference between these situations.

