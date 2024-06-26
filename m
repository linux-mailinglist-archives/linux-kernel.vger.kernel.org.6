Return-Path: <linux-kernel+bounces-231507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C91BD919953
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CBE81F211B5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F531946C5;
	Wed, 26 Jun 2024 20:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="tTjdpp+S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9AA1940AA
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434442; cv=none; b=jVMuY89RrnYZxDW3vrT9Fgt2TScGTipKkvNQ1uj1W1uhbQd4xtT5rGIG1189tj1KR+SDYL3SSYbnLlfH7nl8IDpZB5m1nz0Ds5lwDEv9obG6DaRfXCieSIf019c6yIrEmcnCro+YmlMoNz+xcdbDg2qxHfBirrA7mYWE+6dofWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434442; c=relaxed/simple;
	bh=+MTghs/ruEyPO8KiBbZQEvIF3zJkuIad4OGKhCyeqQM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LJGb6IRGwEeCl++qkgBCbQp3MagZxOA0quLQFhLVIahvdYPYqX5W9u8sOdmnQfzPbLNTNY2qbaXRfWm9fH5jeLGp68E4jb+FEDzpOYl1FHc1D266GTXoNiRNu1c6scNEht8TIHgAys6AgXP9Z7I68i9cdut/YkCjICfVufOX8oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=tTjdpp+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39183C32786;
	Wed, 26 Jun 2024 20:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719434441;
	bh=+MTghs/ruEyPO8KiBbZQEvIF3zJkuIad4OGKhCyeqQM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tTjdpp+SHVjyWZT2LNBDjQ2ODFKazV5WkhurSz+62l0adrGbOZ2/7f1Lw8BJZenPg
	 ZD7IFjHX6We+P8Cr8nf5WcaWGgPMtujDZmEooldFSnqPCcS8+7MlrGF+AChOXFCr4K
	 7FtiMf+tISYzPYPRAL2H9dA/RptZ4PEhWBGwcROo=
Date: Wed, 26 Jun 2024 13:40:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: muchun.song@linux.dev, catalin.marinas@arm.com, will@kernel.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hugetlbfs: add MTE support
Message-Id: <20240626134040.63fe621bff6a5fe1c0503999@linux-foundation.org>
In-Reply-To: <20240625233717.2769975-1-yang@os.amperecomputing.com>
References: <20240625233717.2769975-1-yang@os.amperecomputing.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 16:37:17 -0700 Yang Shi <yang@os.amperecomputing.com> wrote:

> MTE can be supported on ram based filesystem. It is supported on tmpfs.
> There is use case to use MTE on hugetlbfs as well, adding MTE support.
> 
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -110,7 +110,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
>  	 * way when do_mmap unwinds (may be important on powerpc
>  	 * and ia64).
>  	 */
> -	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND);
> +	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND | VM_MTE_ALLOWED);
>  	vma->vm_ops = &hugetlb_vm_ops;
>  
>  	ret = seal_check_write(info->seals, vma);

How thoroughly has this been tested?

Can we expect normal linux-next testing to exercise this, or must
testers make special arangements to get the coverage?

