Return-Path: <linux-kernel+bounces-201711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A67D8FC20E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3921C228C9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EB761FEA;
	Wed,  5 Jun 2024 02:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nq0cdJiG"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36619433A9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 02:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717556263; cv=none; b=TuDU3DaUp6d78gaNbYbRQLS2kE6DbJJzEnWJ6DLa6pXJPw7zeBEdMhvFVV1OntuljAbTXOSr/96gqoPZLyhuXxE/jKPvuIOWpgRLMFZD0VNE6Yv5IOATi9+PHU9jgq2EpC8PchwjP0bW7ZgVUTPvMyN6/cEcttpMFs1K0TnXeUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717556263; c=relaxed/simple;
	bh=l6By8LpyD3miiFUsybtcj4X3LoL8UJCC6OQkTbDqPss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AI1ra3sE/mwu1W1uMwQ0C1sfWX7b6zlxTxY/uEVLJR8lpOEmMKyhu12RqORyr3xKJculfGZm+dx+8wvzRHvjxCJc7+qhLtuOmf7dFryEXWi8FpJjtpB1fgZDdZNQ+SaC1N18dTTSmhIhBGB2splJrckJ4QRGMjCPL2SZ7Q7xcaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nq0cdJiG; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Rleg+
	P2oOGADZV9ADR3po7+nIwArg90kr4FeqXQZGrU=; b=nq0cdJiGJ84burWXE93Cl
	emmoQhno1X/SWzUaEumYKMOcYlwlRdW5Fa5VCDJRyINU/2yC05y3cqzJ+DSvE2ud
	Fr95QBNYuxz+VmMFGBSz07gjjftq3ZyE9sOT9S9S4DoPj36prJzeqfxH4h6tlhNp
	n64BuJn2VEd4HduRwSUtb8=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wC3LwT5019my8syAg--.63924S4;
	Wed, 05 Jun 2024 10:56:58 +0800 (CST)
From: ran xiaokai <ranxiaokai627@163.com>
To: ziy@nvidia.com
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@kernel.org,
	ran.xiaokai@zte.com.cn,
	v-songbaohua@oppo.com,
	xu.xin16@zte.com.cn,
	yang.yang29@zte.com.cn
Subject: Re: [PATCH linux-next] mm: huge_memory: fix misused mapping_large_folio_support() for anon folios
Date: Wed,  5 Jun 2024 02:56:56 +0000
Message-Id: <20240605025656.889177-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <E30FDAA1-B4D4-41C9-993C-0AD5044F30C0@nvidia.com>
References: <E30FDAA1-B4D4-41C9-993C-0AD5044F30C0@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3LwT5019my8syAg--.63924S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxZry5Jr4xJF4xKw1fZr17Awb_yoWrXw43pF
	y2gFnayFWkXrZIkr12qF4kKr1YvrW8Xa4kZay3XwnxAasIgF12kFWUJ3W8uay8uryxJr4I
	va1UXFyagF98taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRoKZZUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/1tbiMx70TGXAloslvQAAs1

> On 4 Jun 2024, at 0:57, David Hildenbrand wrote:
> 
> > On 04.06.24 07:47, xu.xin16@zte.com.cn wrote:
> >> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >>
> >> When I did a large folios split test, a WARNING
> >> "[ 5059.122759][  T166] Cannot split file folio to non-0 order"
> >> was triggered. But my test cases are only for anonmous folios.
> >> while mapping_large_folio_support() is only reasonable for page
> >> cache folios.
> >
> > Agreed.
> >
> > I wonder if mapping_large_folio_support() should either
> >
> > a) Complain if used for anon folios, so we can detect the wrong use more easily. (VM_WARN_ON_ONCE())
> 
> This is much better.
> 
> >
> > b) Return "true" for anonymous mappings, although that's more debatable.
> 
> This might fix the warning here, but the function might get wrong uses easily.

yes, maybe we should rename mapping_large_folio_support() if we choose b).
 
> >
> >>
> >> In split_huge_page_to_list_to_order(), the folio passed to
> >> mapping_large_folio_support() maybe anonmous folio. The
> >> folio_test_anon() check is missing. So the split of the anonmous THP
> >> is failed. This is also the same for shmem_mapping(). We'd better add
> >> a check for both. But the shmem_mapping() in __split_huge_page() is
> >> not involved, as for anonmous folios, the end parameter is set to -1, so
> >> (head[i].index >= end) is always false. shmem_mapping() is not called.
> >>
> >> Using /sys/kernel/debug/split_huge_pages to verify this, with this
> >> patch, large anon THP is successfully split and the warning is ceased.
> >>
> >> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >> Cc: xu xin <xu.xin16@zte.com.cn>
> >> Cc: Yang Yang <yang.yang29@zte.com.cn>
> >> ---
> >>   mm/huge_memory.c | 38 ++++++++++++++++++++------------------
> >>   1 file changed, 20 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index 317de2afd371..4c9c7e5ea20c 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -3009,31 +3009,33 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
> >>   	if (new_order >= folio_order(folio))
> >>   		return -EINVAL;
> >>
> >> -	/* Cannot split anonymous THP to order-1 */
> >> -	if (new_order == 1 && folio_test_anon(folio)) {
> >> -		VM_WARN_ONCE(1, "Cannot split to order-1 folio");
> >> -		return -EINVAL;
> >> -	}
> >> -
> >>   	if (new_order) {
> >>   		/* Only swapping a whole PMD-mapped folio is supported */
> >>   		if (folio_test_swapcache(folio))
> >>   			return -EINVAL;
> >> -		/* Split shmem folio to non-zero order not supported */
> >> -		if (shmem_mapping(folio->mapping)) {
> >> -			VM_WARN_ONCE(1,
> >> -				"Cannot split shmem folio to non-0 order");
> >> -			return -EINVAL;
> >> -		}
> >> -		/* No split if the file system does not support large folio */
> >> -		if (!mapping_large_folio_support(folio->mapping)) {
> >> -			VM_WARN_ONCE(1,
> >> -				"Cannot split file folio to non-0 order");
> >> -			return -EINVAL;
> >> +
> >> +		if (folio_test_anon(folio)) {
> >> +			/* Cannot split anonymous THP to order-1 */
> >> +			if (new_order == 1) {
> >> +				VM_WARN_ONCE(1, "Cannot split to order-1 folio");
> >> +				return -EINVAL;
> >> +			}
> >> +		} else {
> >> +			/* Split shmem folio to non-zero order not supported */
> >> +			if (shmem_mapping(folio->mapping)) {
> >> +				VM_WARN_ONCE(1,
> >> +					"Cannot split shmem folio to non-0 order");
> >> +				return -EINVAL;
> >> +			}
> >> +			/* No split if the file system does not support large folio */
> >> +			if (!mapping_large_folio_support(folio->mapping)) {
> >> +				VM_WARN_ONCE(1,
> >> +					"Cannot split file folio to non-0 order");
> >> +				return -EINVAL;
> >> +			}
> >>   		}
> >>   	}
> >
> > What about the following sequence:
> >
> > if (folio_test_anon(folio)) {
> > 	if (new_order == 1)
> > 		...
> > } else if (new_order) {
> > 	if (shmem_mapping(...))
> > 		...
> > 	...
> > }
> >
> > if (folio_test_swapcache(folio) && new_order)
> > 	return -EINVAL;
> >
> > Should result in less churn and reduce indentation level.
> 
> Yeah, this looks better to me.
> 
> Best Regards,
> Yan, Zi


