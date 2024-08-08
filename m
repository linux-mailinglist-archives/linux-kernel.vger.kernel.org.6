Return-Path: <linux-kernel+bounces-279673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D2D94C052
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E84F1F21A85
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12A718F2E8;
	Thu,  8 Aug 2024 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QORgjksq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E15B674
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128911; cv=none; b=eUOI0eJYzELJceWqafUfpLr0ZuDd8rRjQ5aXCTcChqo9WFtu8KnkSd4zp5oqsVxo6RjgtFflbMtik9KKd/4lgNv/4tqhMWQZJ/4tpP23rnkNVOMxP0secNsTD4oEayxQKDKoOVHASBW8hcSPiKXR7h9mvNoIkwT+WPTro5RvAmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128911; c=relaxed/simple;
	bh=TsogT1nKP/83EnWPuPLaXmbpG8nOXEoDdsAOP4WkhbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pTzwtIBeUJDHdat1un3Z4JHAXjpn+kVKkfdsp/RwRypZHiRJAnxMDIZWyfzeP3Sv2DedJjr1kvTw8xTG8+khN3gG0kg/7oJmRkbbE9lC3wAF8zaaiaYx/KXjLCFOI992owCK3l8iaBSPbTW8li6hLFPk+Ahk1OQbxrthKVj5+fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QORgjksq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A39C32786;
	Thu,  8 Aug 2024 14:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723128910;
	bh=TsogT1nKP/83EnWPuPLaXmbpG8nOXEoDdsAOP4WkhbE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QORgjksqprKA2Lr5I9YhO6mJLI/cgt5XAU5lvdBvbnB/P+uTs7l4wPNNCGBCSzkKy
	 zm36MFlkoXwB8zu9ZlrduHScHMI0o35kPL252UJgdNNAK5+dLekSuibOGMorsht49i
	 tUSaxGgl/bmOOdVhBJG0McsVvWV5qEGS4h8qW/6pP9StXG/6ZeHAxz8tqwdw4lOZH8
	 F7iG8A/cD56v2gak5SRqph41hBQ8D2QfgN6RdoZm/qJfNFsQQnamK6L9HOuBm/1EbF
	 xUroQMxMlrVMn0c81RSC5t+HFUon84IsThWjobaQaOmOcXwW1fMNBmmp+tJiZiOM9F
	 UJzj4XzIkknDA==
Message-ID: <82b802e0-94fd-4cca-ad8f-ea2d85bcae64@kernel.org>
Date: Thu, 8 Aug 2024 16:55:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] mm: abstract vma_merge_new_vma() to use
 vma_merge_struct
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <f4f4b5d441379b22f92d7cd188c2095198cdbc86.1722849859.git.lorenzo.stoakes@oracle.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <f4f4b5d441379b22f92d7cd188c2095198cdbc86.1722849859.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/24 14:13, Lorenzo Stoakes wrote:
> Abstract this function to so we can write tests which use the newly
> abstracted interface and maintain a stable interface for tests before/after
> refactoring.
> 
> We introduce a temporary wrapper vma_merge_new_vma_wrapper() to minimise
> the code changes, in a subsequent commit we will entirely refactor this
> function.
> 
> We also introduce a temporary implementation of vma_merge_modified() for
> the same reason - maintaining a common interface to the tests, this will be
> removed when vma_merge_modified() is correctly implemented in a subsequent
> commit.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

<snip>

> +struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
>  {
> -	struct vma_merge_struct vmg = {
> -		.vmi = vmi,
> -		.prev = prev,
> -		.vma = vma,

This line not being addded in the wrapper felt like a mistake. I see in the
other subthread that it's not so I'll just support your decision to tackle
it so the code is less surprising.

> -		.start = start,
> -		.end = end,
> -		.flags = vma->vm_flags,
> -		.file = vma->vm_file,
> -		.anon_vma = vma->anon_vma,
> -		.pgoff = pgoff,
> -		.policy = vma_policy(vma),
> -		.uffd_ctx = vma->vm_userfaultfd_ctx,
> -		.anon_name = anon_vma_name(vma),
> -	};
> +	if (!vmg->prev) {
> +		vmg->prev = vma_prev(vmg->vmi);
> +		vma_iter_set(vmg->vmi, vmg->start);
> +	}

Admit this is another surprise. The old code didn't do it anywhere AFAICS so
I don't see why it's now done. Maybe it's necessary for futher changes.
Could you add a comment or explain it in the changelog, please?

> -	return vma_merge(&vmg);
> +	return vma_merge(vmg);
>  }
> 
>  /*


