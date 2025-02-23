Return-Path: <linux-kernel+bounces-527544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19272A40C7E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 02:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFB277AC926
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 01:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A91BA42;
	Sun, 23 Feb 2025 01:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cQt8zzWA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD3AB644;
	Sun, 23 Feb 2025 01:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740273996; cv=none; b=M1dpkvqFoLxRyYYdTdoLD+fmE8jPOmErj1K5IILk0gM79A91/0PVmsxmEBTO18uq5Cgv79Nc1kBTPbtLvxmvSnSJMAgmJNhwc/6v2UKmQ5fX3AOBaUT06CfwjWkqwEUSTz6nQMhB0pefddKsbmQgoryFGme+OA76qGFGM0e5wt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740273996; c=relaxed/simple;
	bh=cA0Qzsx3di7qLvvFW3YLM+oEEslWRoQzhG7oZuIN6p0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=U0931fv4DgEYawuF6TEeeLmOew7VRjC/JB3F2E7w0GrWKrwE25pbewd1SJjGgf/8BCi9OPrSgQWK0Dxh68gHQUCFaJ7mrj3TCSG74UDSnVPgb7HJ++7/hXQjx1UKd/sLhPKVoRmtr66Zzczwh+2hM/XS3AOqWPWLjbg9/gvLZgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cQt8zzWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC80C4CED1;
	Sun, 23 Feb 2025 01:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1740273995;
	bh=cA0Qzsx3di7qLvvFW3YLM+oEEslWRoQzhG7oZuIN6p0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cQt8zzWAIXhKqpy07ZyA5D+L91WCKexl+QPeRvVlTZzWEFm3Jpdilq108XOP4NrI3
	 HYMSit7ZTNfSt+iRmJbmYR6L2hy1HQzU5hTb+b9LWs35TpXXbQ7N0two6GjOvjGs3h
	 wlyufZkOnQUJmqpYhRp7fjoXEffp12JDiRrcOP8I=
Date: Sat, 22 Feb 2025 17:26:34 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Brad Spengler
 <brad.spengler@opensrcsec.com>
Subject: Re: [PATCH] mm: abort vma_modify() on merge out of memory failure
Message-Id: <20250222172634.fecb3b5e5f74e310f4a94772@linux-foundation.org>
In-Reply-To: <20250222161952.41957-1-lorenzo.stoakes@oracle.com>
References: <20250222161952.41957-1-lorenzo.stoakes@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Feb 2025 16:19:52 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> The remainder of vma_modify() relies upon the vmg state remaining pristine
> after a merge attempt.
> 

This patch is against your "mm: simplify vma merge structure and expand
comments", presently in mm-unstable.  I tweaked things (simple) so it
applies to mainline:


--- a/mm/vma.c~mm-abort-vma_modify-on-merge-out-of-memory-failure
+++ a/mm/vma.c
@@ -1509,24 +1509,28 @@ int do_vmi_munmap(struct vma_iterator *v
 static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
 {
 	struct vm_area_struct *vma = vmg->vma;
+	unsigned long start = vmg->start;
+	unsigned long end = vmg->end;
 	struct vm_area_struct *merged;
 
 	/* First, try to merge. */
 	merged = vma_merge_existing_range(vmg);
 	if (merged)
 		return merged;
+	if (vmg_nomem(vmg))
+		return ERR_PTR(-ENOMEM);
 
 	/* Split any preceding portion of the VMA. */
-	if (vma->vm_start < vmg->start) {
-		int err = split_vma(vmg->vmi, vma, vmg->start, 1);
+	if (vma->vm_start < start) {
+		int err = split_vma(vmg->vmi, vma, start, 1);
 
 		if (err)
 			return ERR_PTR(err);
 	}
 
 	/* Split any trailing portion of the VMA. */
-	if (vma->vm_end > vmg->end) {
-		int err = split_vma(vmg->vmi, vma, vmg->end, 0);
+	if (vma->vm_end > end) {
+		int err = split_vma(vmg->vmi, vma, end, 0);
 
 		if (err)
 			return ERR_PTR(err);
_


