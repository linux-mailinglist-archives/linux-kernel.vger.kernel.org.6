Return-Path: <linux-kernel+bounces-195601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B054C8D4F1E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E29551C24B2D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C178817F50C;
	Thu, 30 May 2024 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="eAjtpJHp"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A68917F504
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717083043; cv=none; b=FPf1wNqnVXCgc7Wd6DXNP57XUQ2UhvknZF1WY6pjvjPt2t28UoshtS2BEe90P8QDuobz+2AkM9JpGAOtr6dxkmHHwx90AmvjE0ZkTL5yX8sWEUAzJpClED8YqbECONSVt8pcaiyH0aewlth6QhPVaKADbbDlwphb9r2gOPcLLm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717083043; c=relaxed/simple;
	bh=PhD8vfWQu0fzYUGcN9chnT6h1Jccukmikqwpa2qBXcI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tTgZ6fJgjQ/fHvI6lATEPfMBUh+s61aIISDxgxQuI/yNWscM/xmlDdBaRqZXnRm3ouqoKgxKZUWU6zsfDJKjmioxb2nEpvvdBkkgonmA/gMY8qC+EbgbcHPJSWpz+/0xW+zi+HuRJeM3Agnma3s/rmMA+lgDX2uaxsMH5F1JEWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=eAjtpJHp; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1717082428;
	bh=PhD8vfWQu0fzYUGcN9chnT6h1Jccukmikqwpa2qBXcI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=eAjtpJHpJYbnCqofA59amrPyn/YQpj9C/4aetzSjTKpYPvskNwTir9HyzdZeaQx1B
	 i21UfQmlqJ19Z4Bc4L0++cvGtJ2ZZ7Q3OiLvuuMUp0tz3KZ7IHkpu6KlrlE53OfD+Q
	 b0YjszmZ3lxw6gKLDrGPev9L7nCmauH82W3TH4bM=
Received: by gentwo.org (Postfix, from userid 1003)
	id 41E0E40A77; Thu, 30 May 2024 08:20:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 41008401D5;
	Thu, 30 May 2024 08:20:28 -0700 (PDT)
Date: Thu, 30 May 2024 08:20:28 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
cc: Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
    Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Vlastimil Babka <vbabka@suse.cz>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, Feng Tang <feng.tang@intel.com>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    zhouchengming@bytedance.com
Subject: Re: [PATCH 1/3] slab: check the return value of
 check_bytes_and_report()
In-Reply-To: <20240528-b4-slab-debug-v1-1-8694ef4802df@linux.dev>
Message-ID: <4e4d45b5-c684-2d93-49d2-b179a088c2d5@gentwo.org>
References: <20240528-b4-slab-debug-v1-0-8694ef4802df@linux.dev> <20240528-b4-slab-debug-v1-1-8694ef4802df@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 28 May 2024, Chengming Zhou wrote:

> diff --git a/mm/slub.c b/mm/slub.c
> index 0809760cf789..de57512734ac 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1324,9 +1324,10 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
> 		}
> 	} else {
> 		if ((s->flags & SLAB_POISON) && s->object_size < s->inuse) {
> -			check_bytes_and_report(s, slab, p, "Alignment padding",
> +			if (!check_bytes_and_report(s, slab, p, "Alignment padding",
> 				endobject, POISON_INUSE,
> -				s->inuse - s->object_size);
> +				s->inuse - s->object_size))
> +				return 0;
> 		}
> 	}

This change means we will then skip the rest of the checks in 
check_object() such as the poison check.

