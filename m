Return-Path: <linux-kernel+bounces-367495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807379A0305
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B6A286A8E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536541C7B79;
	Wed, 16 Oct 2024 07:49:39 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE9E1C4A12
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064979; cv=none; b=pSv4idkOO6iSsU9TR3zZ4mPJ0YQxsDwYQR8OIxBBH6sxa5ALvyj7PfhQn5vVc2QVi5iKygBen7z4PUgsulrpn4JYNMrm4HviKC/qRYCWGZ+CHUtEbivEYqhNYh6KYOFLryBTrhdnd2Dcm/kHAs1tLcDwtWUSXqr4W4o0OtFbuNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064979; c=relaxed/simple;
	bh=UvLR8V/RBnabgl1BDFGO2W61d72bWrNLaDGaPOb11ZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QDsnUauDzXEQAuNlsEkB3GQFEa4yRJdKZMdnyRtTcB/yHRrBUufYYbO5svH9jTBwWhaWcVlRuTUgsEaZYlAxgWluhrlmcIdXvtNh+qgkb+LS7ZOr7nREC8zqcs885LLA7XF4RF7xL3bdiJa1fkGO6QMnxWP/hYrKrXz9iyLKZXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XT3430dfqz1j9xG;
	Wed, 16 Oct 2024 15:48:19 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id EF283180042;
	Wed, 16 Oct 2024 15:49:32 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 16 Oct 2024 15:49:32 +0800
Message-ID: <007880ac-d73f-4eef-9978-a4f844338522@huawei.com>
Date: Wed, 16 Oct 2024 15:49:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/4] Support large folios for tmpfs
To: Baolin Wang <baolin.wang@linux.alibaba.com>, <akpm@linux-foundation.org>,
	<hughd@google.com>
CC: <willy@infradead.org>, <david@redhat.com>, <21cnbao@gmail.com>,
	<ryan.roberts@arm.com>, <ioworker0@gmail.com>, <da.gomez@samsung.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/10/10 17:58, Baolin Wang wrote:
> Hi,
> 
> This RFC patch series attempts to support large folios for tmpfs.
> 
> Considering that tmpfs already has the 'huge=' option to control the THP
> allocation, it is necessary to maintain compatibility with the 'huge='
> option, as well as considering the 'deny' and 'force' option controlled
> by '/sys/kernel/mm/transparent_hugepage/shmem_enabled'.
> 
> Add a new huge option 'write_size' to support large folio allocation based
> on the write size for tmpfs write and fallocate paths. So the huge pages
> allocation strategy for tmpfs is that, if the 'huge=' option
> (huge=always/within_size/advise) is enabled or the 'shmem_enabled' option
> is 'force', it need just allow PMD sized THP to keep backward compatibility
> for tmpfs. While 'huge=' option is disabled (huge=never) or the 'shmem_enabled'
> option is 'deny', it will still disable any large folio allocations. Only
> when the 'huge=' option is 'write_size', it will allow allocating large
> folios based on the write size.
> 
> And I think the 'huge=write_size' option should be the default behavior
> for tmpfs in future.

Could we avoid new huge= option for tmpfs, maybe support other orders
for both read/write/fallocate if mount with huge?

> 
> Any comments and suggestions are appreciated. Thanks.
> 
> Changes from RFC v2:
>   - Drop mTHP interfaces to control huge page allocation, per Matthew.
>   - Add a new helper to calculate the order, suggested by Matthew.
>   - Add a new huge=write_size option to allocate large folios based on
>     the write size.
>   - Add a new patch to update the documentation.
> 
> Changes from RFC v1:
>   - Drop patch 1.
>   - Use 'write_end' to calculate the length in shmem_allowable_huge_orders().
>   - Update shmem_mapping_size_order() per Daniel.
> 
> Baolin Wang (4):
>    mm: factor out the order calculation into a new helper
>    mm: shmem: change shmem_huge_global_enabled() to return huge order
>      bitmap
>    mm: shmem: add large folio support to the write and fallocate paths
>      for tmpfs
>    docs: tmpfs: add documention for 'write_size' huge option
> 
>   Documentation/filesystems/tmpfs.rst |   7 +-
>   include/linux/pagemap.h             |  16 ++++-
>   mm/shmem.c                          | 105 ++++++++++++++++++++--------
>   3 files changed, 94 insertions(+), 34 deletions(-)
> 


