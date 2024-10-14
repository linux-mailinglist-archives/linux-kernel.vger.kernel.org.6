Return-Path: <linux-kernel+bounces-363301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCA699C035
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86EA8B22A23
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595EA140E34;
	Mon, 14 Oct 2024 06:44:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3E722339
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728888295; cv=none; b=DtkTGjdmI+QWlt9BoO+iTvuj+KPybECVeJ1XFeD5xi4zojCt1LjElJA1rDff434uYLp4Xm+0bPOyt5WihC4xJYitUPKye8CsfJoV1XWwrH++XvGdBGidSIcDWIFt6HurUc+NuP69p6K5a7uW5n70RwIh5MY4pzg9Fa4XoE2Ht08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728888295; c=relaxed/simple;
	bh=mRnwpYJ6FzQnnt/AaDMcQ5itYkFTmZ1i5DzsO7Z/15g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iqyWLPnwG9UHvXnZ15V7qwnaooW+ftIcqXXyLehdInBbQkFJc4W6+VPnpze1I326oxh8Euxw7fn+JEdH8C6U+D+Wgzl8qX4qbTUB/A8+tgQBvD81MeOhYpgYnyv6FsXvlzfmvgeAni7dXOsXG/F7XPPKX1RBLvASXFX9IapYzJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B76C71007;
	Sun, 13 Oct 2024 23:45:20 -0700 (PDT)
Received: from [10.163.38.184] (unknown [10.163.38.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E6053F51B;
	Sun, 13 Oct 2024 23:44:46 -0700 (PDT)
Message-ID: <62410f7d-2642-4218-8e8e-a384dbe86954@arm.com>
Date: Mon, 14 Oct 2024 12:14:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 -next] cma: Enforce non-zero pageblock_order during
 cma_init_reserved_mem()
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-mm@kvack.org
Cc: linuxppc-dev@lists.ozlabs.org, Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
 David Hildenbrand <david@redhat.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Donet Tom <donettom@linux.vnet.ibm.com>, LKML
 <linux-kernel@vger.kernel.org>, Sachin P Bappalige <sachinpb@linux.ibm.com>
References: <054b416302486c2d3fdd5924b624477929100bf6.1728656994.git.ritesh.list@gmail.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <054b416302486c2d3fdd5924b624477929100bf6.1728656994.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/11/24 20:26, Ritesh Harjani (IBM) wrote:
> cma_init_reserved_mem() checks base and size alignment with
> CMA_MIN_ALIGNMENT_BYTES. However, some users might call this during
> early boot when pageblock_order is 0. That means if base and size does
> not have pageblock_order alignment, it can cause functional failures
> during cma activate area.
> 
> So let's enforce pageblock_order to be non-zero during
> cma_init_reserved_mem().
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
> v2 -> v3: Separated the series into 2 as discussed in v2.
> [v2]: https://lore.kernel.org/linuxppc-dev/cover.1728585512.git.ritesh.list@gmail.com/
> 
>  mm/cma.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 3e9724716bad..36d753e7a0bf 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -182,6 +182,15 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>  	if (!size || !memblock_is_region_reserved(base, size))
>  		return -EINVAL;
> 
> +	/*
> +	 * CMA uses CMA_MIN_ALIGNMENT_BYTES as alignment requirement which
> +	 * needs pageblock_order to be initialized. Let's enforce it.
> +	 */
> +	if (!pageblock_order) {
> +		pr_err("pageblock_order not yet initialized. Called during early boot?\n");
> +		return -EINVAL;
> +	}
> +
>  	/* ensure minimal alignment required by mm core */
>  	if (!IS_ALIGNED(base | size, CMA_MIN_ALIGNMENT_BYTES))
>  		return -EINVAL;
> --
> 2.46.0
> 
> 

LGTM, hopefully this comment regarding CMA_MIN_ALIGNMENT_BYTES alignment
requirement will also probably remind us, to drop this new check in case
CMA_MIN_ALIGNMENT_BYTES no longer depends on pageblock_order later.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

