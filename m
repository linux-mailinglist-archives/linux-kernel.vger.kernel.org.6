Return-Path: <linux-kernel+bounces-288713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A43E953DE6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14373B23E14
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 23:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DA0155C8D;
	Thu, 15 Aug 2024 23:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rtq95sLe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB2A1494C7;
	Thu, 15 Aug 2024 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723764615; cv=none; b=ScSTGjiVbEhchjeCxzFhl/4TfOFkPATuAmkKawZvWOJ6HQh5QlOfG3SMU7l5ae+VozlXBOnc5Wq6WpKX5BsFiDUaGi1GaksC2hLY9n2v35SQg3RYHtmduLFOY0xiOO9MmZFrrceSRBcqgq8t8EZ8aBvGpfnSiYpOVvmHUzWaZWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723764615; c=relaxed/simple;
	bh=9ybmCfblB8Ey7gn8Q0u+C7HuoH1fJL2UaVC7mbCadHM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=D1+gQTT/Qru6CTsn93N8z67ElhMqjXhyRT97R3RnUzim0XAWSDH8+k+VHrUqZ6W7fAQ460dzby/kUOFDzLIG80TjeBlzMzSi1Wbq2aHWiXnMhbDN9/G6XTO0TDwbSPJn8Kx/yGBRzwr7Lu+yHofa0HZquNtkxvJG2eYRomTUn7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Rtq95sLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F94BC32786;
	Thu, 15 Aug 2024 23:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723764615;
	bh=9ybmCfblB8Ey7gn8Q0u+C7HuoH1fJL2UaVC7mbCadHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rtq95sLeC/zJdIJ6AbOUVJFGQJQLik8GjegYp9ZEL9ezhrfIAxA0vIIgkgA4X7bs9
	 PI1dImoavQo2D1OEqQ+zjaSEoe30VipY7+v73eD+h7BVLhAQZo4k3FzSlEfw/G3qgo
	 mmp43J4W6XM1bGyPIfZlSaimw+af0qiOYlDE4FaE=
Date: Thu, 15 Aug 2024 16:30:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, baohua@kernel.org,
 cerasuolodomenico@gmail.com, corbet@lwn.net, david@redhat.com,
 hannes@cmpxchg.org, kernel-team@meta.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@surriel.com,
 roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com,
 shakeel.butt@linux.dev, willy@infradead.org, yuzhao@google.com
Subject: Re: [PATCH v3 4/6] mm: Introduce a pageflag for partially mapped
 folios
Message-Id: <20240815163013.2522e3dd83acffe70af9cba6@linux-foundation.org>
In-Reply-To: <4acdf2b7-ed65-4087-9806-8f4a187b4eb5@gmail.com>
References: <88d411c5-6d66-4d41-ae86-e0f943e5fb91@gmail.com>
	<20240814230533.54938-1-21cnbao@gmail.com>
	<4acdf2b7-ed65-4087-9806-8f4a187b4eb5@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 16:25:09 +0100 Usama Arif <usamaarif642@gmail.com> wrote:

> 
> 
> commit c627655548fa09b59849e942da4decc84fa0b0f2
> Author: Usama Arif <usamaarif642@gmail.com>
> Date:   Thu Aug 15 16:07:20 2024 +0100
> 
>     mm: Introduce a pageflag for partially mapped folios fix
>     
>     Fixes the original commit by not clearing partially mapped bit
>     in hugeTLB folios and fixing deferred split THP stats.
>
> ...
>

Life is getting complicated.

> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1758,7 +1758,6 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
>                 free_gigantic_folio(folio, huge_page_order(h));
>         } else {
>                 INIT_LIST_HEAD(&folio->_deferred_list);
> -               folio_clear_partially_mapped(folio);
>                 folio_put(folio);
>         }
>  }

Yu Zhao's "mm/hugetlb: use __GFP_COMP for gigantic folios" was
expecting that folio_clear_partially_mapped() to be there.

I resolved this within
mm-hugetlb-use-__gfp_comp-for-gigantic-folios.patch thusly:

@@ -1748,18 +1704,8 @@ static void __update_and_free_hugetlb_fo
 
 	folio_ref_unfreeze(folio, 1);
 
-	/*
-	 * Non-gigantic pages demoted from CMA allocated gigantic pages
-	 * need to be given back to CMA in free_gigantic_folio.
-	 */
-	if (hstate_is_gigantic(h) ||
-	    hugetlb_cma_folio(folio, huge_page_order(h))) {
-		destroy_compound_gigantic_folio(folio, huge_page_order(h));
-		free_gigantic_folio(folio, huge_page_order(h));
-	} else {
-		INIT_LIST_HEAD(&folio->_deferred_list);
-		folio_put(folio);
-	}
+	INIT_LIST_HEAD(&folio->_deferred_list);
+	hugetlb_free_folio(folio);
 }
 
 /*

Please check.


