Return-Path: <linux-kernel+bounces-379060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7F09AD920
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB94F1F22E84
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C091CAB8;
	Thu, 24 Oct 2024 01:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="M6Tl+lgz"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44901A29
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 01:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729732614; cv=none; b=FuCXwJSFVRH1j9nNWAcZx98njune4rD71Y1NAd44Q2zTnZ0Pu487t6kMQuvvIq4ClTRTcZMZgqwTFmhGaz9s9XyhEIhUBNOs/knlQ5abOSfeaL/bF13GMy3smFc2wNxawvGlbX4ozBAxtInqmw3kA0qTrQj8QsoJvBJ2BPKl94E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729732614; c=relaxed/simple;
	bh=DyEh4eXM8tXOPJ53NQf9jP/H/0DUETWrhjywp+v5Fco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DItsFF1Jx22utHB1yVYhqs5fo6KAzy3cNnpldvtKUJw7epJl2DNcU4THuw6DVHJ5v/pClinduHFI65oxSmGjwGsMhK6C45/eDSYu4X+4uwZCLPXVNj+BEXwgDrvd1suyAbCeOwMWV7Aq+Jb06YtRgSulccSGuWBQeHwUZhINTQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=M6Tl+lgz; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729732603; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Qnk096CiX7Pk/CSCQimh/EKFgiLGtot63MiBL2wFm/o=;
	b=M6Tl+lgzFySgrsEtZAX4C0kgqG3RH1RgMQmNedDjcrBoOyZXkk6j+RqE0sLkCSFs48m8hLgs/tnDB9bXMUtrmPKnXQexMAt+ViqdRb/d1QWufpf83vG8fRyXwoo6h0ghWV6BAXP2wWCwcUHz2zKReU7slY9OJ2sYpW2+vTOr66Q=
Received: from 30.74.144.130(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WHnBHUk_1729732601 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Oct 2024 09:16:42 +0800
Message-ID: <51c227da-eea8-411a-983e-23bcd85ef5ae@linux.alibaba.com>
Date: Thu, 24 Oct 2024 09:16:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fix PSWPIN counter for large folios swap-in
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Chris Li <chrisl@kernel.org>, Yosry Ahmed <yosryahmed@google.com>,
 David Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>,
 Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
 Usama Arif <usamaarif642@gmail.com>
References: <20241023210201.2798-1-21cnbao@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20241023210201.2798-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/24 05:02, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Similar to PSWPOUT, we should count the number of base pages
> instead of large folios.
> 
> Fixes: 242d12c98174 ("mm: support large folios swap-in for sync io devices")
> Cc: Chris Li <chrisl@kernel.org>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> Cc: Usama Arif <usamaarif642@gmail.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/page_io.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_io.c b/mm/page_io.c
> index a28d28b6b3ce..c69fab5060a1 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -574,7 +574,7 @@ static void swap_read_folio_bdev_sync(struct folio *folio,
>   	 */
>   	get_task_struct(current);
>   	count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
> -	count_vm_event(PSWPIN);
> +	count_vm_events(PSWPIN, folio_nr_pages(folio));
>   	submit_bio_wait(&bio);
>   	__end_swap_bio_read(&bio);
>   	put_task_struct(current);
> @@ -590,7 +590,7 @@ static void swap_read_folio_bdev_async(struct folio *folio,
>   	bio->bi_end_io = end_swap_bio_read;
>   	bio_add_folio_nofail(bio, folio, folio_size(folio), 0);
>   	count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
> -	count_vm_event(PSWPIN);
> +	count_vm_events(PSWPIN, folio_nr_pages(folio));
>   	submit_bio(bio);
>   }
>   

