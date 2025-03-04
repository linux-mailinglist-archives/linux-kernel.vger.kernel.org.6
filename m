Return-Path: <linux-kernel+bounces-542947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F723A4CFBD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0101895B66
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4422E3C17;
	Tue,  4 Mar 2025 00:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="1bhucTTg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A58A28F4;
	Tue,  4 Mar 2025 00:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741047179; cv=none; b=H7gRNvGFNPoI6LAV2kcUCR3cIbBtbcLw4VggD1sh2h0Hm6wrYKkMNlDqc1iXK7z1ZUgleYizqTopWadx0Ufws9XsGieCr9dAiu8gsyS2W6uOZDOpx4V8gnTv+zaKBNs7T4F867L60/10ISlUqE71WDPsYwVpxGYkSKczHXfcogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741047179; c=relaxed/simple;
	bh=+A2vHnPtDGgHYWfp6Vrd79SQ/a3Q5kR6CC2TqhmwZH0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kKUL48EIPOrt2PmG2y55M6iToWNgfDnQ8qtz7gu8I1i/xrX21cKXICbXrQ7QH8J8XRzxWjNT8gpqeKSfhVbRxj52tTbEf8p9kd5MpooYiBbeCRHEC75dElIRjn7fXOKXEpj0MEIoTKqLewKQDHM+/EGH170edGz/9xv+d5goww8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=1bhucTTg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7EDC4CEE4;
	Tue,  4 Mar 2025 00:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741047178;
	bh=+A2vHnPtDGgHYWfp6Vrd79SQ/a3Q5kR6CC2TqhmwZH0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=1bhucTTgI9r5/CUvJVKJDXNqto5VgtoBD7h6knps8SqLHWdDMfm2CRuiuCoqwxFpE
	 VLr594BI1UkWlMwXJqMyUv1t6XqovD8j1x/dVydnGDOMFmIKtWIYRa4qT4EfMNEItv
	 I+077K1Kip/GG/+XNc4UycHU7+VuzEx6DhKu1VIw=
Date: Mon, 3 Mar 2025 16:12:56 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kernel test robot <lkp@intel.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, oe-kbuild-all@lists.linux.dev, Linux Memory
 Management List <linux-mm@kvack.org>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn
 <jannh@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] mm/mremap: thread state through move page table
 operation
Message-Id: <20250303161256.1c3d497ee525023d239d1c38@linux-foundation.org>
In-Reply-To: <20250303160555.46915fd9f69ca13e1fe2c5f9@linux-foundation.org>
References: <4cc18ebfc0cb32e9e42d86503cef3265108343e4.1740911247.git.lorenzo.stoakes@oracle.com>
	<202503040759.5zpJdC2i-lkp@intel.com>
	<20250303160555.46915fd9f69ca13e1fe2c5f9@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Mar 2025 16:05:55 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> --- a/mm/mremap.c~mm-mremap-thread-state-through-move-page-table-operation-fix
> +++ a/mm/mremap.c
> @@ -475,8 +475,9 @@ static bool move_huge_pud(struct pagetab
>  	return true;
>  }
>  #else
> -static bool move_huge_pud(struct vm_area_struct *vma, unsigned long old_addr,
> -			  unsigned long new_addr, pud_t *old_pud, pud_t *new_pud)
> +static bool move_huge_pud(struct pagetable_move_control *pmc,
> +			  unsigned long old_addr, unsigned long new_addr,
> +			  pud_t *old_pud, pud_t *new_pud)
>  {
>  	WARN_ON_ONCE(1);
>  	return false;

err,

--- a/mm/mremap.c~mm-mremap-thread-state-through-move-page-table-operation-fix
+++ a/mm/mremap.c
@@ -475,8 +475,8 @@ static bool move_huge_pud(struct pagetab
 	return true;
 }
 #else
-static bool move_huge_pud(struct vm_area_struct *vma, unsigned long old_addr,
-			  unsigned long new_addr, pud_t *old_pud, pud_t *new_pud)
+static bool move_huge_pud(struct pagetable_move_control *pmc,
+			  pud_t *old_pud, pud_t *new_pud)
 {
 	WARN_ON_ONCE(1);
 	return false;
_


