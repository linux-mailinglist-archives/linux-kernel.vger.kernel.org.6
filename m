Return-Path: <linux-kernel+bounces-367939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364FF9A089F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0FAB28207D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9A02076D8;
	Wed, 16 Oct 2024 11:47:20 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7E22076AB
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 11:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079240; cv=none; b=m/GEedMH8iJP/YA9d7oOUpv9C003bBMCNbDy7pgwlxNkMtWU96LpX8Dmd7YdDIlHTAyPrtrQHJM4zELmdHghUvWStWQCXro9plEA4k2V1WnrrkOWkP3cvuYDaSmXNV2iW3g/5IgGJKLc+pXGW3mW95XMgeJUZ272R/IJSeDPwYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079240; c=relaxed/simple;
	bh=vKGx+xoOwR6783lNjtQOSOznLbqCpdugez0Dktrxcm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HNGcPE07cVlVqeqbZof/Pv0Vds9GmWB9Qk2PL0iKSyBDRtxcg6nQ4/wsEu8TmefUTuF/t5G+sEAdVYGrKU7cneZNHZ58yZ2f82XjCNTk1NZb3dqeyW6eZPSJ7qHOJAFLMAqze1c6nxi67RPNvFLv/d7BA3OlfHIU8hDb7mfXDJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XT8L71qHTzyTK6;
	Wed, 16 Oct 2024 19:45:51 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 381F41401E0;
	Wed, 16 Oct 2024 19:47:15 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 16 Oct 2024 19:47:14 +0800
Message-ID: <c4e4480d-bed3-4a4a-b07f-496006c5785f@huawei.com>
Date: Wed, 16 Oct 2024 19:47:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Improve the tmpfs large folio read performance
To: Baolin Wang <baolin.wang@linux.alibaba.com>, <akpm@linux-foundation.org>,
	<hughd@google.com>
CC: <willy@infradead.org>, <david@redhat.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <cover.1729072803.git.baolin.wang@linux.alibaba.com>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <cover.1729072803.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/10/16 18:09, Baolin Wang wrote:
> The tmpfs has already supported the PMD-sized large folios, but the tmpfs
> read operation still performs copying at the PAGE SIZE granularity, which
> is not perfect. This patch changes to copy data at the folio granularity,
> which can improve the read performance.
> 
> Use 'fio bs=64k' to read a 1G tmpfs file populated with 2M THPs, and I can
> see about 20% performance improvement, and no regression with bs=4k. I
> also did some functional test with the xfstests suite, and I did not find
> any regressions with the following xfstests config.
>    FSTYP=tmpfs
>    export TEST_DIR=/mnt/tempfs_mnt
>    export TEST_DEV=/mnt/tempfs_mnt
>    export SCRATCH_MNT=/mnt/scratchdir
>    export SCRATCH_DEV=/mnt/scratchdir
> 

Oh，we make same changes, my bonnie test(./bonnie -d /tmp -s 1024) see
similar improvement(19.2% with huge=always) with out inner changes :)

> Baolin Wang (2):
>    mm: shmem: update iocb->ki_pos directly to simplify tmpfs read logic
>    mm: shmem: improve the tmpfs large folio read performance
> 
>   mm/shmem.c | 54 ++++++++++++++++++++++--------------------------------
>   1 file changed, 22 insertions(+), 32 deletions(-)
> 


