Return-Path: <linux-kernel+bounces-205224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BE18FF9A0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 03:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6722284638
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4B0101E6;
	Fri,  7 Jun 2024 01:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HaIlV1/7"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FA4846F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 01:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717724239; cv=none; b=SXQtX8Xoogop29IHx5U8tYlyPCFJeyFZYbOCxb5pxIg5SGERcn8sHJ5/BJWjEofixz1/rJTeOSVly71sYnLd0xL0v1tBBeJYJpO98Em/20uRELYScSMfQgWrOQnK12SEAn7VakxokE4S90rkBPW8BxG8al2/eN8gXQi+BFxWmMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717724239; c=relaxed/simple;
	bh=A1WfXqByJ4xuJ/wejRCVBPrP0DTQANQn81SgBjIMhvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BoWnGvqiHahAk79Ivwx0R6pSvtKhMDDmzrIAImb81M+r7Vmw3Yv0Xbct99wwtxBgg50m1bljtZXKRlpXn5fL4ozb91TnzwBWGDt1aC7bx+jspCvLPqLJnnm4VeNI2RmtyqamPb93FodQcmmh4y3k60adk1PUoLVXUTWdOB3QQ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HaIlV1/7; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Qfl0U
	CymRtBzUyGemEPimXVzpDc6BxR0DGTzZciDn+0=; b=HaIlV1/7yap04VYWcMSY8
	T2joXeTLv8LxpIfPbSRMa5SmszWsUmmlmBVk+bSvSXfFkDOiJF+HmGOniGLoe2aD
	N4kHYRqeAV9Yll9bu2QwzY37s/JRAAtb34dNA6Ua7ANv2tas/CsfTF3NUTmYfgwm
	6UUDG75SXU3a+K6ZYSoOg8=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g2-5 (Coremail) with SMTP id _____wD3v+ASZGJmDPvEDg--.14050S4;
	Fri, 07 Jun 2024 09:36:19 +0800 (CST)
From: ran xiaokai <ranxiaokai627@163.com>
To: 21cnbao@gmail.com
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@kernel.org,
	ran.xiaokai@zte.com.cn,
	v-songbaohua@oppo.com,
	si.hao@zte.com.cn,
	xu.xin16@zte.com.cn,
	yang.yang29@zte.com.cn,
	ziy@nvidia.com
Subject: Re: [PATCH linux-next v2] mm: huge_memory: fix misused mapping_large_folio_support() for anon folios
Date: Fri,  7 Jun 2024 01:36:17 +0000
Message-Id: <20240607013617.913054-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAGsJ_4x=v0fDN_QVjdHSGVykH2+o_f81NnN_0-SUL+iwe+v84g@mail.gmail.com>
References: <CAGsJ_4x=v0fDN_QVjdHSGVykH2+o_f81NnN_0-SUL+iwe+v84g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v+ASZGJmDPvEDg--.14050S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFyUGFW5Jr45Aw4xurWruFg_yoW5tF43pF
	97G3Z3GFWkZF9I9rnFqr1qyF1FqrWvgayUAa47G3s8A3Z8Ja1v9FZrA3Z8Z34UZrW3AF4x
	XF4UXFy5WFn8tFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRoKZZUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/1tbiqRj2TGVOAtAJyAAAsz

> > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >
> > When I did a large folios split test, a WARNING
> > "[ 5059.122759][  T166] Cannot split file folio to non-0 order"
> > was triggered. But the test cases are only for anonmous folios.
> > while mapping_large_folio_support() is only reasonable for page
> > cache folios.
> >
> > In split_huge_page_to_list_to_order(), the folio passed to
> > mapping_large_folio_support() maybe anonmous folio. The
> > folio_test_anon() check is missing. So the split of the anonmous THP
> > is failed. This is also the same for shmem_mapping(). We'd better add
> > a check for both. But the shmem_mapping() in __split_huge_page() is
> > not involved, as for anonmous folios, the end parameter is set to -1, so
> > (head[i].index >= end) is always false. shmem_mapping() is not called.
> >
> > Also add a VM_WARN_ON_ONCE() in mapping_large_folio_support()
> > for anon mapping, So we can detect the wrong use more easily.
> >
> > THP folios maybe exist in the pagecache even the file system doesn't
> > support large folio, it is because when CONFIG_TRANSPARENT_HUGEPAGE
> > is enabled, khugepaged will try to collapse read-only file-backed pages
> > to THP. But the mapping does not actually support multi order
> > large folios properly.
> >
> > Using /sys/kernel/debug/split_huge_pages to verify this, with this
> > patch, large anon THP is successfully split and the warning is ceased.
> >
> > Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > ---
> >  include/linux/pagemap.h |  4 ++++
> >  mm/huge_memory.c        | 27 ++++++++++++++++-----------
> >  2 files changed, 20 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index ee633712bba0..59f1df0cde5a 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -381,6 +381,10 @@ static inline void mapping_set_large_folios(struct address_space *mapping)
> >   */
> >  static inline bool mapping_large_folio_support(struct address_space *mapping)
> >  {
> > +       /* AS_LARGE_FOLIO_SUPPORT is only reasonable for pagecache folios */
> > +       VM_WARN_ONCE((unsigned long)mapping & PAGE_MAPPING_ANON,
> > +                       "Anonymous mapping always supports large folio");
> > +
> >         return IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> >                 test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
> >  }
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 317de2afd371..62d57270b08e 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -3009,30 +3009,35 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
> >         if (new_order >= folio_order(folio))
> >                 return -EINVAL;
> >
> > -       /* Cannot split anonymous THP to order-1 */
> > -       if (new_order == 1 && folio_test_anon(folio)) {
> > -               VM_WARN_ONCE(1, "Cannot split to order-1 folio");
> > -               return -EINVAL;
> > -       }
> > -
> > -       if (new_order) {
> > -               /* Only swapping a whole PMD-mapped folio is supported */
> > -               if (folio_test_swapcache(folio))
> > +       if (folio_test_anon(folio)) {
> > +               /* Cannot split anonymous THP to order-1 */
> 
> This is simply what the code is indicating. Shouldn't we phrase
> it differently to explain "why" but not "how"? for example, anon
> order-1 mTHP is not supported?

Hi, Barry,
Good comments, thanks.
Is "order-1 is not a anonymouns mTHP suitable order." better?
 
> Otherwise, it looks good to me.
> 
> Reviewed-by: Barry Song <baohua@kernel.org>


