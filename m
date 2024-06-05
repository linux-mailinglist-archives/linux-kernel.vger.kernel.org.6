Return-Path: <linux-kernel+bounces-201684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D9E8FC1BE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA481F25E54
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8081B61FEF;
	Wed,  5 Jun 2024 02:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JOz8422U"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14C124B34
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 02:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717554110; cv=none; b=Nca8F3J2dy/iVtpp41QonUweMoN+8i0SfyLI/O/IT4j5MoN3FZyN8hCG7/vIWy0g9o3nuCXpE403xheCM4EG8+7ilbCLOGG/Z3bmArw7iOaYcZ1sQoUU6oJAJlapdA2dU4IfeA2wplB6G3dOJr3cOs+BSJBgA0fOStwgAQ3x72w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717554110; c=relaxed/simple;
	bh=JTnSNyXJb9/n4zWhEsZEgrjDjA6qKcjZ618TEtxWRng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hrjIZOjJPBqMn0LUmL/UWDip765JwMD8a6p+Pc7sTY0KKf63vn1yGwQrHAIlknGa/wOl0hbzJbpH21J4xl3rylQM4b1msctypLA3ES9Wh2QwShIGiEXGBkF1X+TAPOSaCO0AlVdATTyUKVU95SIYp6hAYCRzL2ZZ5hMv6QsRydo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JOz8422U; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=99UK3
	SS0coifAlgek0C0Ovd66JCCH+0Fhwar14jUuug=; b=JOz8422UqF4y12MhdI7Et
	lvvWapEK9ZQJU2hQfpblOuw+sH+e3/67SrafWczT5optIR+7BvaVIb26Asy9u0Xa
	PXq4z4nF3zy7gb+Ir5osyFz0KQQGRHuzisRvq75yrO/uwCmXPSuINVvKr5FZFokE
	e+bqCVP03/fHLMG+GZva+k=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g1-1 (Coremail) with SMTP id _____wDXr06Dy19m1Y57HA--.24429S4;
	Wed, 05 Jun 2024 10:20:53 +0800 (CST)
From: ran xiaokai <ranxiaokai627@163.com>
To: david@redhat.com
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@kernel.org,
	v-songbaohua@oppo.com,
	ran.xiaokai@zte.com.cn,
	xu.xin16@zte.com.cn,
	yang.yang29@zte.com.cn,
	ziy@nvidia.com
Subject: Re: [PATCH linux-next] mm: huge_memory: fix misused mapping_large_folio_support() for anon folios
Date: Wed,  5 Jun 2024 02:20:51 +0000
Message-Id: <20240605022051.888955-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <fe35d494-b54e-4302-8c75-24abc9094ea1@redhat.com>
References: <fe35d494-b54e-4302-8c75-24abc9094ea1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXr06Dy19m1Y57HA--.24429S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr45tryUCr1UZr4rWr4kZwb_yoWrWw47pF
	W2grn3tFWkXrZI9r12qF4jkrn5ZrW8Xa4kAay3XwnxA3ZxGF429FW7J3Wruay7uryfJr4x
	Xa1UXFy3W3Z8tFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRrb15UUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbB0gn0TGWXyKdRAQAAsu

> On 04.06.24 07:47, xu.xin16@zte.com.cn wrote:
> > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > 
> > When I did a large folios split test, a WARNING
> > "[ 5059.122759][  T166] Cannot split file folio to non-0 order"
> > was triggered. But my test cases are only for anonmous folios.
> > while mapping_large_folio_support() is only reasonable for page
> > cache folios.
> 
> Agreed.
> 
> I wonder if mapping_large_folio_support() should either
> 
> a) Complain if used for anon folios, so we can detect the wrong use more 
> easily. (VM_WARN_ON_ONCE())

> b) Return "true" for anonymous mappings, although that's more debatable.
> 

Hi, David,
Thanks for the review.
I think a) is better. 
But we have to add a new parameter "folio" to mapping_large_folio_support(), right ?
something like mapping_large_folio_support(struct address_space *mapping, struct folio *folio) ?
But in the __filemap_get_folio() path, 

__filemap_get_folio()
  no_page:
    ....
    if (!mapping_large_folio_support(mapping))

the folio is not allocated yet, yes ?
Or do you mean there is some other way to do this ? 

> > 
> > In split_huge_page_to_list_to_order(), the folio passed to
> > mapping_large_folio_support() maybe anonmous folio. The
> > folio_test_anon() check is missing. So the split of the anonmous THP
> > is failed. This is also the same for shmem_mapping(). We'd better add
> > a check for both. But the shmem_mapping() in __split_huge_page() is
> > not involved, as for anonmous folios, the end parameter is set to -1, so
> > (head[i].index >= end) is always false. shmem_mapping() is not called.
> > 
> > Using /sys/kernel/debug/split_huge_pages to verify this, with this
> > patch, large anon THP is successfully split and the warning is ceased.
> > 
> > Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > Cc: xu xin <xu.xin16@zte.com.cn>
> > Cc: Yang Yang <yang.yang29@zte.com.cn>
> > ---
> >   mm/huge_memory.c | 38 ++++++++++++++++++++------------------
> >   1 file changed, 20 insertions(+), 18 deletions(-)
> > 
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 317de2afd371..4c9c7e5ea20c 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -3009,31 +3009,33 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
> >   	if (new_order >= folio_order(folio))
> >   		return -EINVAL;
> > 
> > -	/* Cannot split anonymous THP to order-1 */
> > -	if (new_order == 1 && folio_test_anon(folio)) {
> > -		VM_WARN_ONCE(1, "Cannot split to order-1 folio");
> > -		return -EINVAL;
> > -	}
> > -
> >   	if (new_order) {
> >   		/* Only swapping a whole PMD-mapped folio is supported */
> >   		if (folio_test_swapcache(folio))
> >   			return -EINVAL;
> > -		/* Split shmem folio to non-zero order not supported */
> > -		if (shmem_mapping(folio->mapping)) {
> > -			VM_WARN_ONCE(1,
> > -				"Cannot split shmem folio to non-0 order");
> > -			return -EINVAL;
> > -		}
> > -		/* No split if the file system does not support large folio */
> > -		if (!mapping_large_folio_support(folio->mapping)) {
> > -			VM_WARN_ONCE(1,
> > -				"Cannot split file folio to non-0 order");
> > -			return -EINVAL;
> > +
> > +		if (folio_test_anon(folio)) {
> > +			/* Cannot split anonymous THP to order-1 */
> > +			if (new_order == 1) {
> > +				VM_WARN_ONCE(1, "Cannot split to order-1 folio");
> > +				return -EINVAL;
> > +			}
> > +		} else {
> > +			/* Split shmem folio to non-zero order not supported */
> > +			if (shmem_mapping(folio->mapping)) {
> > +				VM_WARN_ONCE(1,
> > +					"Cannot split shmem folio to non-0 order");
> > +				return -EINVAL;
> > +			}
> > +			/* No split if the file system does not support large folio */
> > +			if (!mapping_large_folio_support(folio->mapping)) {
> > +				VM_WARN_ONCE(1,
> > +					"Cannot split file folio to non-0 order");
> > +				return -EINVAL;
> > +			}
> >   		}
> >   	}
> 
> What about the following sequence:
> 
> if (folio_test_anon(folio)) {
> 	if (new_order == 1)
> 		...
> } else if (new_order) {
> 	if (shmem_mapping(...))
> 		...
> 	...
> }
> 
> if (folio_test_swapcache(folio) && new_order)
> 	return -EINVAL;
> 
> Should result in less churn and reduce indentation level.
>

Thanks.
The code is cleaner in this way.
 
> -- 
> Cheers,
> 
> David / dhildenb


