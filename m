Return-Path: <linux-kernel+bounces-542941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A4EA4CFA7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F75A1896240
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3786FC5;
	Tue,  4 Mar 2025 00:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eYBENq6w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB0E136E;
	Tue,  4 Mar 2025 00:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741046756; cv=none; b=scdhx8sOerTMXKnfaZvuChsg7Ieg06ToXBpFEObn5a5QQn4lJLdolQHhZ9QcZQ/N1JldVxmRqvApzbk34n+4bZhmJYK7cv16frGlVZh63f2uDPveVFfTA+cGbiLXE3AxizqQKwcKIZTL4/UPIHP/IULiwi0BcImqmNNF5klj9Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741046756; c=relaxed/simple;
	bh=OKLHZEt3eHUwBoGMiacWEMefYtqpxu27zLQs3lqzYZY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=H16eNlLl/Vr+UKObxUgZeZYsuKVdPhP4chWsXLbnodRj4knhShxYB1v8iEQVBoSSloB3Le5tMPLzNJZQTvkPtaM+6JRaNeWUaBNi67CrPM08II2FtpmA7tWhlZLMK0+L9aXKJpLrjmrpBg2LJQUAYApoAhEOa59C9QsIY53l+LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eYBENq6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10272C4CEE4;
	Tue,  4 Mar 2025 00:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741046756;
	bh=OKLHZEt3eHUwBoGMiacWEMefYtqpxu27zLQs3lqzYZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eYBENq6wQJ4D1Gl7ZOuGlz34xKYFIi9P0pJTuSgFLgVS2Gkpe6jKWYqs88QPIw9cV
	 l2iPOUraDFfBlbhnJ4E5D7WeU4zIZVlHesxnzA/weT/59WeD5MrpeqFbpq8ELbUdhk
	 Al8NZmjXfFiFtznmtUFaMCAfBChWFcvorcjmM3k8=
Date: Mon, 3 Mar 2025 16:05:55 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: kernel test robot <lkp@intel.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 oe-kbuild-all@lists.linux.dev, Linux Memory Management List
 <linux-mm@kvack.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] mm/mremap: thread state through move page table
 operation
Message-Id: <20250303160555.46915fd9f69ca13e1fe2c5f9@linux-foundation.org>
In-Reply-To: <202503040759.5zpJdC2i-lkp@intel.com>
References: <4cc18ebfc0cb32e9e42d86503cef3265108343e4.1740911247.git.lorenzo.stoakes@oracle.com>
	<202503040759.5zpJdC2i-lkp@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Mar 2025 07:30:16 +0800 kernel test robot <lkp@intel.com> wrote:

> Hi Lorenzo,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on akpm-mm/mm-everything]
> [also build test WARNING on linus/master v6.14-rc5 next-20250303]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/mm-mremap-correctly-handle-partial-mremap-of-VMA-starting-at-0/20250303-192101
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/4cc18ebfc0cb32e9e42d86503cef3265108343e4.1740911247.git.lorenzo.stoakes%40oracle.com
> patch subject: [PATCH 7/7] mm/mremap: thread state through move page table operation
> config: x86_64-buildonly-randconfig-005-20250304 (https://download.01.org/0day-ci/archive/20250304/202503040759.5zpJdC2i-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250304/202503040759.5zpJdC2i-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202503040759.5zpJdC2i-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    mm/mremap.c: In function 'move_pgt_entry':
>    mm/mremap.c:581:39: error: passing argument 1 of 'move_huge_pud' from incompatible pointer type [-Werror=incompatible-pointer-types]

Thanks.

--- a/mm/mremap.c~mm-mremap-thread-state-through-move-page-table-operation-fix
+++ a/mm/mremap.c
@@ -475,8 +475,9 @@ static bool move_huge_pud(struct pagetab
 	return true;
 }
 #else
-static bool move_huge_pud(struct vm_area_struct *vma, unsigned long old_addr,
-			  unsigned long new_addr, pud_t *old_pud, pud_t *new_pud)
+static bool move_huge_pud(struct pagetable_move_control *pmc,
+			  unsigned long old_addr, unsigned long new_addr,
+			  pud_t *old_pud, pud_t *new_pud)
 {
 	WARN_ON_ONCE(1);
 	return false;
_


