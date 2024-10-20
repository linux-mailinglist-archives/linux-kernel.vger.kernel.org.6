Return-Path: <linux-kernel+bounces-373148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A680D9A52FA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 09:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524421F2206A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 07:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D7E25771;
	Sun, 20 Oct 2024 07:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyUqYdJ3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3DFDDBE
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 07:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729408525; cv=none; b=OOML2Zh+jnePv4+EQ2AxKMNeL05RnfAqhlrpFMStZVJRzh0cdf+6sIY2Gzt9cj+mG3u+1k1kABwGBTjXE3Nn19ijnveRc/EuBPJiBnPxw6hQlhzVTs7JsjVI7YZbYBH/OcmQqdEmuSGml2ZVltSIaAUmVtCrjuEMOUB2mF1z7+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729408525; c=relaxed/simple;
	bh=yeNo6luy1/4z52AiDhi7fFi1PCeauLclbjN9yAVUCOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stxXH/+18h9wzhx06WoMZH6nYZjEDfvLw5hyBz7vqHR9gofguoDqxxbIBvQ0HRkZR6iQ2h33jyV+AWKNCotMFzpDMtvABZfkEiDPzSTA3NcMZsW27OxthoR9Cn2JBIo2KHwmXieOhPVsQGLux+7rx6iNpT6HxOtboDgIQGNpJe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyUqYdJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F18AC4CEC6;
	Sun, 20 Oct 2024 07:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729408524;
	bh=yeNo6luy1/4z52AiDhi7fFi1PCeauLclbjN9yAVUCOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HyUqYdJ31Vf7pF8us/AsUILyQRvw6YB8oGqiGXqNND0GPVWIjtHO9/4xQRjJ8EYqm
	 95MbjoVIq1jR729Ye+UwW9kjI6MviJHCH/seoV0N3SxBootuOeSG2MFDEHTLw6AllU
	 K/j1F2kaVAp1Q89vhSGHHUzwd09xi97ai7MN0R+nDZO7dQQY+x+dqS/P5rIbaQrNw1
	 5b2iOEsukQL2LJ2n4GC3xcRz5+eO/HcENl6TLWwEmQhbdOIdgZBELu7v6L6OA+7h2I
	 P/X1ZxP2A2GHRV55xGC6FEpk4AkUY5KkkPUXhHFaMLJZPYnylhvwWzwzn/6JZc0fPJ
	 5hbpGfV/S6u0Q==
Date: Sun, 20 Oct 2024 10:11:38 +0300
From: Mike Rapoport <rppt@kernel.org>
To: suhua <suhua.tanke@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, suhua <suhua1@kingsoft.com>
Subject: Re: [PATCH] memblock: Uniform initialization all reserved pages to
 MIGRATE_MOVABLE
Message-ID: <ZxStKvw6HwminDub@kernel.org>
References: <20241017064449.5235-1-suhua1@kingsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017064449.5235-1-suhua1@kingsoft.com>

On Thu, Oct 17, 2024 at 02:44:49PM +0800, suhua wrote:
> Subject: memblock: Uniform initialization all reserved pages to MIGRATE_MOVABLE

I'd suggest:

memblock: uniformly initialize all reserved pages to MIGRATE_MOVABLE

> Currently when CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set, the reserved
> pages are initialized to MIGRATE_MOVABLE by default in memmap_init.
> 
> Reserved memory mainly stores the metadata of struct page. When
> HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON=Y and hugepages are allocated,
> the memory occupied by the struct page metadata will be freed.

The struct page metadata is not freed with HVO, it is rather pages used for
vmemmap.
 
> Before this patch:
> when CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set, the freed memory was
> placed on the Movable list;
> When CONFIG_DEFERRED_STRUCT_PAGE_INIT=Y, the freed memory was placed on
> the Unmovable list.
> 
> After this patch, the freed memory is placed on the Movable list
> regardless of whether CONFIG_DEFERRED_STRUCT_PAGE_INIT is set.
> 
> Eg:

Please add back the description of the hardware used for this test and how
much huge pages were allocated at boot.

> echo 500000 > /proc/sys/vm/nr_hugepages
> cat /proc/pagetypeinfo
> 
> before：
> Free pages count per migrate type at order       0      1      2      3      4      5      6      7      8      9     10
> …
> Node    0, zone   Normal, type    Unmovable     51      2      1     28     53     35     35     43     40     69   3852
> Node    0, zone   Normal, type      Movable   6485   4610    666    202    200    185    208     87     54      2    240
> Node    0, zone   Normal, type  Reclaimable      2      2      1     23     13      1      2      1      0      1      0
> Node    0, zone   Normal, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
> Node    0, zone   Normal, type      Isolate      0      0      0      0      0      0      0      0      0      0      0
> Unmovable ≈ 15GB
> 
> after：
> Free pages count per migrate type at order       0      1      2      3      4      5      6      7      8      9     10
> …
> Node    0, zone   Normal, type    Unmovable      0      1      1      0      0      0      0      1      1      1      0
> Node    0, zone   Normal, type      Movable   1563   4107   1119    189    256    368    286    132    109      4   3841
> Node    0, zone   Normal, type  Reclaimable      2      2      1     23     13      1      2      1      0      1      0
> Node    0, zone   Normal, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
> Node    0, zone   Normal, type      Isolate      0      0      0      0      0      0      0      0      0      0      0
> 
> Signed-off-by: suhua <suhua1@kingsoft.com>

checkpatch.pl gives this warning:

WARNING: From:/Signed-off-by: email address mismatch: 'From: suhua <suhua.tanke@gmail.com>' != 'Signed-off-by: suhua <suhua1@kingsoft.com>'
Please update the commit authorship or signed-off to match.

Also, Signed-off-by should use a known identity, i.e. Name Lastname.

> ---
>  mm/mm_init.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 4ba5607aaf19..6dbf2df23eee 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -722,6 +722,10 @@ static void __meminit init_reserved_page(unsigned long pfn, int nid)
>  		if (zone_spans_pfn(zone, pfn))
>  			break;
>  	}
> +
> +	if (pageblock_aligned(pfn))
> +		set_pageblock_migratetype(pfn_to_page(pfn), MIGRATE_MOVABLE);
> +
>  	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
>  }
>  #else
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.

