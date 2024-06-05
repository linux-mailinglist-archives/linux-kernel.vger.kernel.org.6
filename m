Return-Path: <linux-kernel+bounces-202150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C658FC861
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B671C2131C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EA918FDB0;
	Wed,  5 Jun 2024 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DxZzDfW3"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E80E163
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717581309; cv=none; b=Y2843zFEco8HU6PZKiR50oMj4ii8Bbm3pavTwaw1J5yu+EnLk/2kiIL4z2qeBHovrJ6py/NxwdM+Z4qpaFGFH2WOgjZ1I9ymUkbmtdTRnvlsxAiHLHA/ZOCG+4ddi0O+r39ohH9TTWtIscRNs7DKrbcl7eXWw4g1dzvqDPVeb2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717581309; c=relaxed/simple;
	bh=QXeiEtnyemZNpJWeY5akh3tqj/FK6IvnOXT8E5iE5ZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uct7Z41NVE1h/ibUQw6qSUmpjPqXfkDa4ITsOoeZjM9AAlAIz25RhQk3oWpIJVeboQPCOLnG4b2X9GLJTSBq4WEVfPIyo32NuDg5d2KjUiT5c+XMH/CbrUMndGCpBMMtblLloGy83DAXXkAFARg3DyqkW2FJ0a1vbp8R5wvOkQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DxZzDfW3; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/oakU
	ifhniV84QMFd9hK/xRSzvvRjN1nHsDWsGL/yU8=; b=DxZzDfW3K5loicecZdNMP
	pS8zyO7P3zNo7c1R02FRNTabdIi82Cqt9N62M3VdzY8fAhT/5SX2iBZ5XFmXIOn5
	qyTbKLwb5OJRKIzr9Zo5loSd9NdKKHrv4Rt68j4YUlG2vPUFZ+2uX97wyDpOPuuv
	3ncJQNb5WXq0U8JLDu11fs=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wDn932+NWBmjnx1HA--.48089S4;
	Wed, 05 Jun 2024 17:54:08 +0800 (CST)
From: ran xiaokai <ranxiaokai627@163.com>
To: 21cnbao@gmail.com
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@kernel.org,
	v-songbaohua@oppo.com,
	xu.xin16@zte.com.cn,
	yang.yang29@zte.com.cn,
	ziy@nvidia.com
Subject: Re: [PATCH linux-next] mm: huge_memory: fix misused mapping_large_folio_support() for anon folios
Date: Wed,  5 Jun 2024 09:54:06 +0000
Message-Id: <20240605095406.891512-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAGsJ_4wFyFBTDDfsBpi0sKs1WOH2jaKKoYWWj9Ln_PsNjP2uuA@mail.gmail.com>
References: <CAGsJ_4wFyFBTDDfsBpi0sKs1WOH2jaKKoYWWj9Ln_PsNjP2uuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn932+NWBmjnx1HA--.48089S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr43KFy3XF15Jr15Cr4kJFb_yoW5uFWrpF
	W2grn3ta95XFZIkr12qr40kr15XrWkXa4kAay3ZwnxA3ZxJrnF9Fy7J3W8uay7uryfJrWI
	qa1UXFy3W3WDtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRoKZZUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/1tbiMwT0TGXAlpWHBAAAsq

> On Tue, Jun 4, 2024 at 5:47?PM <xu.xin16@zte.com.cn> wrote:
> >
> > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >
> > When I did a large folios split test, a WARNING
> > "[ 5059.122759][  T166] Cannot split file folio to non-0 order"
> > was triggered. But my test cases are only for anonmous folios.
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
> > Using /sys/kernel/debug/split_huge_pages to verify this, with this
> > patch, large anon THP is successfully split and the warning is ceased.
> >
> > Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > Cc: xu xin <xu.xin16@zte.com.cn>
> > Cc: Yang Yang <yang.yang29@zte.com.cn>
> > ---
> >  mm/huge_memory.c | 38 ++++++++++++++++++++------------------
> >  1 file changed, 20 insertions(+), 18 deletions(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 317de2afd371..4c9c7e5ea20c 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -3009,31 +3009,33 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
> >         if (new_order >= folio_order(folio))
> >                 return -EINVAL;
> >
> > -       /* Cannot split anonymous THP to order-1 */
> > -       if (new_order == 1 && folio_test_anon(folio)) {
> > -               VM_WARN_ONCE(1, "Cannot split to order-1 folio");
> > -               return -EINVAL;
> > -       }
> > -
> >         if (new_order) {
> >                 /* Only swapping a whole PMD-mapped folio is supported */
> >                 if (folio_test_swapcache(folio))
> >                         return -EINVAL;
> > -               /* Split shmem folio to non-zero order not supported */
> > -               if (shmem_mapping(folio->mapping)) {
> > -                       VM_WARN_ONCE(1,
> > -                               "Cannot split shmem folio to non-0 order");
> > -                       return -EINVAL;
> > -               }
> > -               /* No split if the file system does not support large folio */
> > -               if (!mapping_large_folio_support(folio->mapping)) {
> > -                       VM_WARN_ONCE(1,
> > -                               "Cannot split file folio to non-0 order");
> > -                       return -EINVAL;
> > +
> > +               if (folio_test_anon(folio)) {
> > +                       /* Cannot split anonymous THP to order-1 */
> > +                       if (new_order == 1) {
> > +                               VM_WARN_ONCE(1, "Cannot split to order-1 folio");
> > +                               return -EINVAL;
> > +                       }
> > +               } else {
> > +                       /* Split shmem folio to non-zero order not supported */
> > +                       if (shmem_mapping(folio->mapping)) {
> > +                               VM_WARN_ONCE(1,
> > +                                       "Cannot split shmem folio to non-0 order");
> > +                               return -EINVAL;
> > +                       }
> > +                       /* No split if the file system does not support large folio */
> > +                       if (!mapping_large_folio_support(folio->mapping)) {
> > +                               VM_WARN_ONCE(1,
> > +                                       "Cannot split file folio to non-0 order");
> > +                               return -EINVAL;
> > +                       }
> 
> Am I missing something? if file system doesn't support large folio,
> how could the large folio start to exist from the first place while its
> mapping points to a file which doesn't support large folio?

I think it is the CONFIG_READ_ONLY_THP_FOR_FS case.
khugepaged will try to collapse read-only file-backed pages to 2M THP.


