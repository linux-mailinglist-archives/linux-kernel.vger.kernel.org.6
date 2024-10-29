Return-Path: <linux-kernel+bounces-387167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9105F9B4CE8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32EF1C22A1E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF53C192D93;
	Tue, 29 Oct 2024 15:04:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED00D18DF60
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214288; cv=none; b=n1KxJhXonJOW5vyjQonUq8rHOyRc+hYfu7rmzpn0tVpjd5kXCJP/pC5thPXRlFfuUKeCiDAhgcIeLP98Cg3a4cIbryIFSyebgos5CkLrbrAbUpKzWmjU2Jy+FoXegU/XyGa75WZRMR18VErQ8kQ3Zy1pjimgRVvz6u1gEg8qqxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214288; c=relaxed/simple;
	bh=PiCC98wQz+sah/0aMbBmINdsCKBZTwBtbR5kaHpLE9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvNagexQfFB+bjWGtOd+r04lXd/V/qAYHk76oUcEFDpDpAbH6TBmagJoT3+/sCI/nBboipcBVkJcTmA4HzV+q4livmUqIpJ7jTHwHJ7q2A+BMIGDEdjunYpI79GH682c2W+UWqWkFPNm2iZR7XXiKqYnkOltvTx6Vt0JoMbBRn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDC51113E;
	Tue, 29 Oct 2024 08:05:14 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 754203F73B;
	Tue, 29 Oct 2024 08:04:43 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:04:41 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Brown <broonie@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
	linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
	Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: [PATCH hotfix 6.12 v2 4/8] mm: resolve faulty mmap_region()
 error path behaviour
Message-ID: <ZyD5iXikMzotl9mU@arm.com>
References: <CAHk-=whD9MrPwPMBgVG16T_u+my8xYtZg2tUGz932HeodVX7Bg@mail.gmail.com>
 <438f50c5-8b8c-444f-ae85-10e5151f3f24@lucifer.local>
 <57mgmdx7wgfwci3yo3ggkmcnm3ujamgkwcccm77ypvmer5tegn@opiq3ceh2uvy>
 <ykzmur56ms7fm4midi6tbncjvcvf7ue4lp7e4orblrmwnefw3e@oa3enlpdrcrr>
 <bea02efe-a695-49e0-b15c-2270a82cadbf@lucifer.local>
 <CAHk-=whpXVBNvd0NJpw9=FGcuTuThwtfcKeM3Ug=Uk6kpChCPA@mail.gmail.com>
 <0b64edb9-491e-4dcd-8dc1-d3c8a336a49b@suse.cz>
 <CAHk-=wgE8410gu3EabjNEHhOYh1dyYwt23J62S4a9SYcwZUFhw@mail.gmail.com>
 <1608957a-d138-4401-98ef-7fbe5fb7c387@suse.cz>
 <cf1deb9b-c5c4-4e85-891d-62ecf9a04e0f@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf1deb9b-c5c4-4e85-891d-62ecf9a04e0f@lucifer.local>

Hi Lorenzo,

Thanks for trying to fix this.

On Mon, Oct 28, 2024 at 10:14:50PM +0000, Lorenzo Stoakes wrote:
> From 247003cd2a4b5f4fc2dac97f5ef7e473a47f4324 Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Mon, 28 Oct 2024 22:05:44 +0000
> Subject: [PATCH] mm: perform MTE check within arm64 hook entirely
> 
> It doesn't make sense to have shmem explicitly check this one arch-specific
> case, it is arch-specific, so the arch should handle it. We know shmem is a
> case in which we want to permit MTE, so simply check for this directly.
> 
> This also fixes the issue with checking arch_validate_flags() early, which
> would otherwise break mmap_region().
> 
> In order to implement this we must pass a file pointer, and additionally
> update the sparc code to accept this parameter too.
> 
> We'd ideally like to have eliminated the arch_calc_vm_flag_bits() case, but
> we risk inadvertently changing behaviour as we do not have mmap() flags
> available at the point of the arch_validate_flags() check and a MAP_ANON |
> MAP_HUGETLB case would be accepted for MTE currently, but a MAP_SHARED |
> MAP_HUGETLB would not.
> 
> This is likely an oversight but we want to try to keep behaviour identical
> to before in this patch.

MAP_HUGETLB support for MTE is only in -next currently, so there
wouldn't be any ABI change if we also allowed MAP_SHARED | MAP_HUGETLB.
In 6.12, MAP_HUGETLB is not allowed to have PROT_MTE.

> So continue to check VM_MTE_ALLOWED which arch_calc_vm_flag_bits() sets if
> MAP_ANON.
[...]
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 4ba1d00fabda..e87f5d6799a7 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2733,9 +2733,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
>  	if (ret)
>  		return ret;
> 
> -	/* arm64 - allow memory tagging on RAM-based files */
> -	vm_flags_set(vma, VM_MTE_ALLOWED);

This breaks arm64 KVM if the VMM uses shared mappings for the memory
slots (which is possible). We have kvm_vma_mte_allowed() that checks for
the VM_MTE_ALLOWED flag as the VMM may not use PROT_MTE/VM_MTE directly.

I need to read this thread properly but why not pass the file argument
to arch_calc_vm_flag_bits() and set VM_MTE_ALLOWED in there?

-- 
Catalin

