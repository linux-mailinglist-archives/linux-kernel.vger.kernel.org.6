Return-Path: <linux-kernel+bounces-567358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98116A6850D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3750F3B9221
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532EE20DD74;
	Wed, 19 Mar 2025 06:27:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C69E36B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 06:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742365677; cv=none; b=Foe8xCVaQ89MUdvLLuRZ7cqds0ohyflM3mHKnlW2g8HbqsgrKqpOzj2tizgvbTCkaj3SN+hIYHbHt6TzwOSntxBfnT05vx2gDPv3pHKip4R+62rqgzfbvkoQ1haFRbkTMf/s7lJS7IXBPgS12cA3eS6emeC4KhJtdT6iS/zRMH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742365677; c=relaxed/simple;
	bh=avf/IX3i5L8U0g+X4WRzA+uxluVOlAwrtJea6tofAB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLwfeIrgcOhLoZOJ5OS1a2wMRxkFKHl+R0oNgKn1qM8kw3uFluVaBmi8cViS0iyxoTH08OvfgF2ErytES2fSwFEDyBNbu2iG97ClmDSBKlHCUGFlVmegOEu40Ill9PEWkmEj00JTv6UM2N36mnzauhVyzfPzz5u8crssotowhbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B499712FC;
	Tue, 18 Mar 2025 23:28:02 -0700 (PDT)
Received: from [10.162.16.153] (a077893.blr.arm.com [10.162.16.153])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC4133F694;
	Tue, 18 Mar 2025 23:27:52 -0700 (PDT)
Message-ID: <c03fbda6-4465-4ada-a9eb-d02893f509d4@arm.com>
Date: Wed, 19 Mar 2025 11:57:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: move hugetlb_sysctl_init() to the __init
 section
To: marc.herbert@linux.intel.com
Cc: Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250319060041.2737320-1-marc.herbert@linux.intel.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250319060041.2737320-1-marc.herbert@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/19/25 11:30, marc.herbert@linux.intel.com wrote:
> From: Marc Herbert <Marc.Herbert@linux.intel.com>
> 
> hugetlb_sysctl_init() is only invoked once by an __init function and is
> merely a wrapper around another __init function so there is not reason
> to keep it.
> 
> Fixes the following warning when toning down some GCC inline options:
> 
>  WARNING: modpost: vmlinux: section mismatch in reference:
>    hugetlb_sysctl_init+0x1b (section: .text) ->
>      __register_sysctl_init (section: .init.text)
> 
> Signed-off-by: Marc Herbert <Marc.Herbert@linux.intel.com>
> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 65068671e460..a2850b26aed9 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4900,7 +4900,7 @@ static const struct ctl_table hugetlb_table[] = {
>  	},
>  };
>  
> -static void hugetlb_sysctl_init(void)
> +static void __init hugetlb_sysctl_init(void)
>  {
>  	register_sysctl_init("vm", hugetlb_table);
>  }

LGTM

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

