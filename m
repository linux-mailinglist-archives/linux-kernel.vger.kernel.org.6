Return-Path: <linux-kernel+bounces-210918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB84904A24
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 06:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD4C283A5B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 04:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61C0282ED;
	Wed, 12 Jun 2024 04:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eUD4HTR7"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D705728DC1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 04:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718167447; cv=none; b=MUiC5GOmvVo3WxeH6Dv7pFtUWDhQtE5sycoR93h6v5BsfE8VNx4DBvxaGYC6neYTWkPBC13+6JPD8BCw50Z2vWsTHCF/Cd3DQ3kAiFLyoepcrcE3oYI+Iwdb4xhVWFPLeEF+JizGWYWlaw7rCULHRnUefVUJeYJZflkMHCMnods=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718167447; c=relaxed/simple;
	bh=6WAbp/YTWBBBHytqI9A3XftZ0v8U7in0FWEcO+BDimQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O6FeWaLuk1YHNmiWVVeJjw+Z3TCmXnUe/iUBgDbc5oikl+7wM/BYKaIMDZa7HHzffcddHqDMk2O30iYkE+Ufee48DfB6e+CrxRIRt0dQpGAow4FIjmwBMTBwK8gNVIbPz5XWMfMiJ6hc7ruHYf221sXHC5VhrlflDih4Txf1cYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eUD4HTR7; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=08nvx
	UJoWiC4KViLG7ofKg87VtDw88I4g5s84vmog6I=; b=eUD4HTR7jSWyzGgp+4Vkq
	1yNFi8BuQeX0G1BAspf3Zmz5byWEAuartENn1emiU8/+xw+wFUCCcSmYaw3OiVuq
	P5FmrJGom63yFXwcsm/5Qqm7+EBbfz2JcGjdgVgwSmS5z431oK3uuXHFsbwPhRqF
	1FjPjIMrKm6rcCXKwrw6wU=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g0-2 (Coremail) with SMTP id _____wDH7w92J2lmhVCKAQ--.3449S4;
	Wed, 12 Jun 2024 12:43:35 +0800 (CST)
From: ran xiaokai <ranxiaokai627@163.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@kernel.org,
	ran.xiaokai@zte.com.cn,
	si.hao@zte.com.cn,
	v-songbaohua@oppo.com,
	xu.xin16@zte.com.cn,
	yang.yang29@zte.com.cn,
	ziy@nvidia.com
Subject: Re: [PATCH linux-next v3] mm: huge_memory: fix misused mapping_large_folio_support()  for anon folios
Date: Wed, 12 Jun 2024 04:43:33 +0000
Message-Id: <20240612044333.979885-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240607142153.5cc922f1f2c96989dc809cd3@linux-foundation.org>
References: <20240607142153.5cc922f1f2c96989dc809cd3@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDH7w92J2lmhVCKAQ--.3449S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF47Ar4fXFy5Jw48CrWfKrg_yoW8Zr1rpF
	15Wrs5t3ykJFZYkrnFv3WvkFnYy3yrWay8Aa4fGwnFyas8uF4F9FyIk3WjvayUWr95urWx
	AF4UWF9xu3Z8JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRoKZZUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/1tbiMxn7TGXAlx6BsAAAsA

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
> 
> Can we pleae identify a Fixes: target for this?  Is it c010d47f107f
> ("mm: thp: split huge page to any lower order pages")?

yes, this fixes c010d47f107f ("mm: thp: split huge page to any lower order pages").

> It would be good to add a selftest which would have caught this.

I have updated the code in selftests/mm/split_huge_page_test.c.
For now, only order-0 is tested for the anonymous THP split case,
I am adding more mTHP-suitable-orders test cases.
I will send that in a separate patch when it is done.


