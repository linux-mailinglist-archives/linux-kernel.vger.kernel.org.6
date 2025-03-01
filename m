Return-Path: <linux-kernel+bounces-539720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFE9A4A7C1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0BDA3B8F5C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8C11531E3;
	Sat,  1 Mar 2025 01:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nnPmujHF"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E0C22066
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 01:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740794376; cv=none; b=G0QiAb5ZFQTUnC3zfjoBoBNPxYsGdCOcsccjUrBqW21QE9lce+oE1/K2ENifojxBNj/nL1ceQMAvHZkeD7v4VaT3syTHiHVQXL3/yR/P4ZcR40Z6fTV+mZJ6bQ5BS+j0dLfFbokDTs3gvxTNfmbAT0As51asztELpN5Xnpd5qGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740794376; c=relaxed/simple;
	bh=w9gPJT5YURTxDIEGbaviN6oiudgU1lR1YYZfqhd4JSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGuuN1I+cxzET0MLZShVqiveAEdrgQdmbhxdvM4BvODhqkFZFXjNh1v8ohMaL3MkarM/7+2rjxRUnAxfcGIM23NV4H/z0h/J9sU4aY8y7TOMbzLnv0xz/7ZKyAFdeeqJnh8S4OkiINzAHqc3ZvqYZgPK31906XsR2gzapH1a4RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nnPmujHF; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740794369; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=s0Posdlm++2aKVjTh5x1P7gjEtgWw+d64yCkeYGYeBk=;
	b=nnPmujHFMWrIbS/TB+sIb0V7MH1uQ7Jc6tv2kDMOIh75Zks5obREDraBIHcuHGLROXicj3QDjzSaBH3DuT007e70fk71vu1TN20/HT8cCQq91VmcExykfFx+XuIw82GJdH1W2pObNsoMR5edy5NME44ER9YDWBK8LS7MHt1YBe4=
Received: from 30.221.80.112(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WQR7zet_1740794367 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 01 Mar 2025 09:59:27 +0800
Message-ID: <e63c88f9-a9b5-4bdc-aa4c-2036082c0ab0@linux.alibaba.com>
Date: Sat, 1 Mar 2025 09:59:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/migrate: fix shmem xarray update during migration
To: Zi Yan <ziy@nvidia.com>, Liu Shixin <liushixin2@huawei.com>,
 linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Barry Song
 <baohua@kernel.org>, David Hildenbrand <david@redhat.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Lance Yang <ioworker0@gmail.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Hugh Dickins <hughd@google.com>,
 Charan Teja Kalla <quic_charante@quicinc.com>, linux-kernel@vger.kernel.org,
 Shivank Garg <shivankg@amd.com>
References: <20250228174953.2222831-1-ziy@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250228174953.2222831-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/3/1 01:49, Zi Yan wrote:
> Pagecache uses multi-index entries for large folio, so does shmem. Only
> swap cache still stores multiple entries for a single large folio.
> Commit fc346d0a70a1 ("mm: migrate high-order folios in swap cache correctly")
> fixed swap cache but got shmem wrong by storing multiple entries for
> a large shmem folio. Fix it by storing a single entry for a shmem
> folio.
> 
> Fixes: fc346d0a70a1 ("mm: migrate high-order folios in swap cache correctly")
> Reported-by: Liu Shixin <liushixin2@huawei.com>
> Closes: https://lore.kernel.org/all/28546fb4-5210-bf75-16d6-43e1f8646080@huawei.com/
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Shivank Garg <shivankg@amd.com>

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/migrate.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 365c6daa8d1b..2c9669135a38 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -524,7 +524,11 @@ static int __folio_migrate_mapping(struct address_space *mapping,
>   			folio_set_swapcache(newfolio);
>   			newfolio->private = folio_get_private(folio);
>   		}
> -		entries = nr;
> +		/* shmem uses high-order entry */
> +		if (!folio_test_anon(folio))
> +			entries = 1;
> +		else
> +			entries = nr;
>   	} else {
>   		VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
>   		entries = 1;

