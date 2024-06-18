Return-Path: <linux-kernel+bounces-218688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBEA90C3C6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 08:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790111F2294F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 06:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B83F4F20C;
	Tue, 18 Jun 2024 06:40:41 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4B8288BD
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718692841; cv=none; b=IysYUMs1yB3qYZSTh5qH1h7llNDYI/b40iJuZHH2ytWQnZXDy7VDLUZlK1xESLi9txAms+VtULWSca6WbPON1mquxd6NtgG4KLzo75Csjr1/6pXxJXJCS88RsRgfLiMJukmtkgLyzINs7fXPoHDY2K8QBUDxtYmc5j8jg/JTq1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718692841; c=relaxed/simple;
	bh=62MUPhAN97fTptGdFIxSforz/slrHwceN6Mk+l2lnbU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RlGAoYP1l7Zh6+6KMQZ6WXySu+ab+ZFH6yMoADSME2YS5hueeWsPEqLdeFYDp/M5dG33oSjw4tfajW1JLNd56z0qUOJWfWnbyqZrdWgp6hVzQn/Wy6SSQFcy2LuSTKSVCcYF/vo17H3gI9aZ2nQl44S0FIZVmp33ZYQWNaxJNfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4W3HBw2GjPz1HDW6;
	Tue, 18 Jun 2024 14:38:32 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id BD7A2140123;
	Tue, 18 Jun 2024 14:40:33 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemd200001.china.huawei.com (7.185.36.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 18 Jun 2024 14:40:33 +0800
From: Wupeng Ma <mawupeng1@huawei.com>
To: <akpm@linux-foundation.org>, <ryabinin.a.a@gmail.com>,
	<glider@google.com>, <andreyknvl@gmail.com>, <dvyukov@google.com>,
	<vincenzo.frascino@arm.com>
CC: <mawupeng1@huawei.com>, <kasan-dev@googlegroups.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [Question] race during kasan_populate_vmalloc_pte
Date: Tue, 18 Jun 2024 14:40:22 +0800
Message-ID: <20240618064022.1990814-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemd200001.china.huawei.com (7.185.36.224)

Hi maintainers,

During our testing, we discovered that kasan vmalloc may trigger a false
vmalloc-out-of-bounds warning due to a race between kasan_populate_vmalloc_pte
and kasan_depopulate_vmalloc_pte.

cpu0				cpu1				cpu2
  kasan_populate_vmalloc_pte	kasan_populate_vmalloc_pte	kasan_depopulate_vmalloc_pte
								spin_unlock(&init_mm.page_table_lock);
  pte_none(ptep_get(ptep))
  // pte is valid here, return here
								pte_clear(&init_mm, addr, ptep);
				pte_none(ptep_get(ptep))
				// pte is none here try alloc new pages
								spin_lock(&init_mm.page_table_lock);
kasan_poison
// memset kasan shadow region to 0
				page = __get_free_page(GFP_KERNEL);
				__memset((void *)page, KASAN_VMALLOC_INVALID, PAGE_SIZE);
				pte = pfn_pte(PFN_DOWN(__pa(page)), PAGE_KERNEL);
				spin_lock(&init_mm.page_table_lock);
				set_pte_at(&init_mm, addr, ptep, pte);
				spin_unlock(&init_mm.page_table_lock);


Since kasan shadow memory in cpu0 is set to 0xf0 which means it is not
initialized after the race in cpu1. Consequently, a false vmalloc-out-of-bounds
warning is triggered when a user attempts to access this memory region.

The root cause of this problem is the pte valid check at the start of
kasan_populate_vmalloc_pte should be removed since it is not protected by
page_table_lock. However, this may result in severe performance degradation
since pages will be frequently allocated and freed.

Is there have any thoughts on how to solve this issue?

Thank you.

