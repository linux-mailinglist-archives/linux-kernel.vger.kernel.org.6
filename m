Return-Path: <linux-kernel+bounces-391829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CB29B8C21
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 08:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B865B1C21FA1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 07:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768E81547DC;
	Fri,  1 Nov 2024 07:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e4dXFMS3"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A90153BF8
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 07:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730446678; cv=none; b=lLRMonOPu9kiZhm9SdE961xqG7cpUzRXsjmYRIMmPWjOeQAavCRcEi/UwPCRkcjoIEs1GuObNlTWuOgizRGpYrtQ3mWY+saXuYMBz6iC/WD1QhTtGQwZ+HN6NwMmgcYRBe/rl6w1p9UL0/lwRY8RWrgLqLfnEwEqqqzBdJHwQ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730446678; c=relaxed/simple;
	bh=qs0U2eBKO7J24LC/l1ublukecruizsLb5qGIMHieWeo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ll4msN7Ad/zuFEdNT36bQdstX7R141VIYuv4wTJ55mbD5CfufBAdA+mmfWmD1BrkcB/4ybBCENoBG1QC9hOc0z0/taHgtq/T64TgrRMlKvf1zsBx81ydT7VVwdr3UEGtiz0LJPxQdFPuq2UlAFgNqDOEC6Bsq4HT/lVBjx5V6Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e4dXFMS3; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7187e0041d5so990086a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 00:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730446676; x=1731051476; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bnzJeel+BwB3jSttSAy7Q3R1q9VR8g71yrTqyLZrN/o=;
        b=e4dXFMS3ddVi8p+fM2BtpHoLhd+2L4yg3ZUB4+e+ew9HEPLiMxeeQLiLk2o37zahKS
         vupnJTnSf4w1pJ5Y9zQbJtwNoPn2Sr4Z5ckYNVbZ2R0EDN6yJDyvmX7n8r515JLiJtCA
         aaHWkiniZoywttl8eIvFKmZZ7HTv//P4A8S1gFgZIrx7IxDyun6DYbU1GbUJel7PwbVS
         jaocMCmUsKidMU/HzTwzX6kOeCreTDYxSVF3Vebe6NeoiufI+clYKxmuMVjKnVgGU00i
         AIib6A9hfeXLDffP8cUO9t6YvLrWE0IXnY14e1PbcLJaCDx8lYS1xB1bmGkovSzpFkdp
         wPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730446676; x=1731051476;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bnzJeel+BwB3jSttSAy7Q3R1q9VR8g71yrTqyLZrN/o=;
        b=mi2QLe2H4dKINT1Xb0U7DAXQ0Tr/j5QYzgwz5GjWXJFNQuxSM3Rm0a8rlqOP3f1MG5
         XDyqf/nmGuQr9iac0P4uiK1r5CCNf765Ml3JmOwR84JsdJlwRfItT1K7fScjmigobVZu
         x/gv77qV1pwGi0ZfTDay1YMzoibxUP75ti5xf95uWqCTs+i5UEjwn85ApT6+4sUViNY3
         +K3gubYE8GkBIdnUd/gk4TeT6zPkPubBT8Bpu/CD/1TZrJjS9O3mRykt3SN/9jcv57zs
         nwmky1KE9v6mXX7G2u/rdrN5oUJgo0AMAPs8ivKLeLwEZLZwZFsMyncrxN53JaqQdqZf
         f/9g==
X-Forwarded-Encrypted: i=1; AJvYcCWXw+tYrdHwjsBHcpOU9HKzCmK7B0NGQ52Ea/Kyu1v3Yy1WVvkcRp3vuwxtP359z110IHi7Za2lIKy9Akk=@vger.kernel.org
X-Gm-Message-State: AOJu0YztetSPmqRRlIMTxzTfYo4g8heeb04G4QF9OzuMdq2cFAAdxbfJ
	NIJzg7X0y/tgknDuS30R46fi769UH5T2KzY4rIZxg2X/99sb2SsiFJwjtvrkYBJa+grm/f0H8hv
	M6w==
X-Google-Smtp-Source: AGHT+IHTxgosQLtMnoC48u/AiElStEQhbPJvPftBxAqrfsbetyIQ0/6qIEuIYWZ3yoCI1o1KMj1DcA==
X-Received: by 2002:a54:4e95:0:b0:3e0:7d53:251 with SMTP id 5614622812f47-3e6608c6c52mr4407213b6e.15.1730446675714;
        Fri, 01 Nov 2024 00:37:55 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee452979e4sm1990326a12.9.2024.11.01.00.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 00:37:54 -0700 (PDT)
Date: Fri, 1 Nov 2024 00:37:45 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Shivank Garg <shivankg@amd.com>
cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: Re: [PATCH] mm: use vma_policy() to get vm_policy
In-Reply-To: <20241101071350.402878-1-shivankg@amd.com>
Message-ID: <8169912f-82dc-e210-862c-f6eb092db78d@google.com>
References: <20241101071350.402878-1-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 1 Nov 2024, Shivank Garg wrote:

> Instead of accessing vma->vm_policy directly, use vma_policy() like
> other places for consistency.
> 
> Signed-off-by: Shivank Garg <shivankg@amd.com>

NAK.  The vma_policy(vma) wrapper exists to avoid #ifdef CONFIG_NUMAs
all over the place; there is no point to it inside CONFIG_NUMA source.

Hugh

> ---
>  ipc/shm.c      |  2 +-
>  mm/mempolicy.c | 16 ++++++++--------
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/ipc/shm.c b/ipc/shm.c
> index 99564c870084..ebd45e48b0d4 100644
> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -577,7 +577,7 @@ static struct mempolicy *shm_get_policy(struct vm_area_struct *vma,
>  					unsigned long addr, pgoff_t *ilx)
>  {
>  	struct shm_file_data *sfd = shm_file_data(vma->vm_file);
> -	struct mempolicy *mpol = vma->vm_policy;
> +	struct mempolicy *mpol = vma_policy(vma);
>  
>  	if (sfd->vm_ops->get_policy)
>  		mpol = sfd->vm_ops->get_policy(vma, addr, ilx);
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index b646fab3e45e..7ccbeb9966f0 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -420,7 +420,7 @@ void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
>  	mmap_write_lock(mm);
>  	for_each_vma(vmi, vma) {
>  		vma_start_write(vma);
> -		mpol_rebind_policy(vma->vm_policy, new);
> +		mpol_rebind_policy(vma_policy(vma), new);
>  	}
>  	mmap_write_unlock(mm);
>  }
> @@ -805,8 +805,8 @@ static int vma_replace_policy(struct vm_area_struct *vma,
>  			goto err_out;
>  	}
>  
> -	old = vma->vm_policy;
> -	vma->vm_policy = new; /* protected by mmap_lock */
> +	old = vma_policy(vma);
> +	vma_policy(vma) = new; /* protected by mmap_lock */
>  	mpol_put(old);
>  
>  	return 0;
> @@ -830,7 +830,7 @@ static int mbind_range(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		vmstart = vma->vm_start;
>  	}
>  
> -	if (mpol_equal(vma->vm_policy, new_pol)) {
> +	if (mpol_equal(vma_policy(vma), new_pol)) {
>  		*prev = vma;
>  		return 0;
>  	}
> @@ -1797,7 +1797,7 @@ struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
>  {
>  	*ilx = 0;
>  	return (vma->vm_ops && vma->vm_ops->get_policy) ?
> -		vma->vm_ops->get_policy(vma, addr, ilx) : vma->vm_policy;
> +		vma->vm_ops->get_policy(vma, addr, ilx) : vma_policy(vma);
>  }
>  
>  /*
> @@ -1847,7 +1847,7 @@ bool vma_policy_mof(struct vm_area_struct *vma)
>  		return ret;
>  	}
>  
> -	pol = vma->vm_policy;
> +	pol = vma_policy(vma);
>  	if (!pol)
>  		pol = get_task_policy(current);
>  
> @@ -2559,11 +2559,11 @@ unsigned long alloc_pages_bulk_array_mempolicy_noprof(gfp_t gfp,
>  
>  int vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst)
>  {
> -	struct mempolicy *pol = mpol_dup(src->vm_policy);
> +	struct mempolicy *pol = mpol_dup(vma_policy(src));
>  
>  	if (IS_ERR(pol))
>  		return PTR_ERR(pol);
> -	dst->vm_policy = pol;
> +	vma_policy(dst) = pol;
>  	return 0;
>  }
>  
> -- 
> 2.34.1

