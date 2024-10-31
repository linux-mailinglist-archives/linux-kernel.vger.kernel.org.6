Return-Path: <linux-kernel+bounces-391272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3489B84A2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDEE61C221B0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5911CDFC1;
	Thu, 31 Oct 2024 20:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QrHWF7ZC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008A51CDFAE
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730407697; cv=none; b=CDwECie5tjtsrG096cwfaWqG0kstJcQKwsBkyBjTk+da3XcsRFUlKYZSpFSBMEEN87kD7AYFlJRJwjn3PhFCNLuPHO/wY9bU0/bnON7/WIVm6oPj+4Z44ChkxuS2Re5GDw8R5SoAaTXS1I69VwTuCkrY0OCuSnRLkiQHj/kJXP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730407697; c=relaxed/simple;
	bh=9Rlt00csn4oRCGDp3EcDh3UdakjPlx4n+2L1g7gkZ30=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YU2rVuAPKBE9u5HRuxihBuA79ks5v1Xlo3cc7QBirCiTN6DmdLlMdxshR8xAxlLB+XRtq6fAWD1mVYt+WWcEHERdewBXhGiaQeWM7d4EBatVb28wFNQFJCAfxjg/6Tr0/NPGQaKaSjJ8iNFxuo3GaND78uzOE0TcUD9PmeLeXDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QrHWF7ZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43751C4CEC3;
	Thu, 31 Oct 2024 20:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730407696;
	bh=9Rlt00csn4oRCGDp3EcDh3UdakjPlx4n+2L1g7gkZ30=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QrHWF7ZCs3rd87P+eRFI3e3vN1RKhsTc7/MLt72fQCopoduSiXG+GdcpV+//okSAq
	 svOC6Eq2KKwe0pGKjVnC1NPWVdlOHGnRnLTTTYNjHnDZKdQj6RtmTDm1qJbv5BVpq7
	 lVV6umUQanly6VpsAZF5mNxYlK1YrxWv23utLzI8=
Date: Thu, 31 Oct 2024 13:48:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Liam R. Howlett"
 <Liam.Howlett@Oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2] vma: Detect infinite loop in vma tree
Message-Id: <20241031134815.81766b263e87f74a3e31471e@linux-foundation.org>
In-Reply-To: <20241031193608.1965366-1-Liam.Howlett@oracle.com>
References: <20241031193608.1965366-1-Liam.Howlett@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 15:36:08 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:

> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> There have been no reported infinite loops in the tree, but checking the
> detection of an infinite loop during validation is simple enough.  Add
> the detection to the validate_mm() function so that error reports are
> clear and don't just report stalls.
> 
> This does not protect against internal maple tree issues, but it does
> detect too many vmas being returned from the tree.
> 
> The variance of +10 is to allow for the debugging output to be more useful for
> nearly correct counts.  In the event of more than 10 over the map_count, the
> count will be set to -1 for easier identification of a potential infinite loop.
> 
> Note that the mmap lock is held to ensure a consistent tree state during the
> validation process.
> 
> ...
>
> +++ b/mm/vma.c
> @@ -615,7 +615,10 @@ void validate_mm(struct mm_struct *mm)
>  			anon_vma_unlock_read(anon_vma);
>  		}
>  #endif
> -		i++;
> +		if (++i > mm->map_count + 10) {
> +			i = -1;
> +			break;
> +		}
>  	}
>  	if (i != mm->map_count) {
>  		pr_emerg("map_count %d vma iterator %d\n", mm->map_count, i);

It might be helpful to tell readers what's going on here?

--- a/mm/vma.c~vma-detect-infinite-loop-in-vma-tree-fix
+++ a/mm/vma.c
@@ -615,6 +615,7 @@ void validate_mm(struct mm_struct *mm)
 			anon_vma_unlock_read(anon_vma);
 		}
 #endif
+		/* Check for a infinite loop */
 		if (++i > mm->map_count + 10) {
 			i = -1;
 			break;
_


