Return-Path: <linux-kernel+bounces-436149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351759E81CE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 20:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC0C281720
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 19:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122F515383C;
	Sat,  7 Dec 2024 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPYS1xaf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703E41E529
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 19:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733599375; cv=none; b=kzmqxfpIBbRsQha5j71CaIpSJcGtrcx9gh4cGqOfxTyRy3cpL7dWpm15cBUmK/gYoHrPjhPu1iH9N+ZbCcKXEJriRRUc0GleN6G2qiXc+olB2RqcYb1sUqVuuYX7xLGDZIZ52o3XJAkRt4XD8KdSAtzPwU0MZRupKiSaieuV7Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733599375; c=relaxed/simple;
	bh=PgqB4r1QP9LHy8XRk/NMlDcLiT/kOPHlGNLDtInk86U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CK6KwAngrHtzljJOo7uB3wzEU0XgrcKUQLLuZf6mrNxtwUKw7RJ1/QkBQxdz314OoWHNwsCLHQ5LfBE45lATdJ0emE+TqBfirLZDhC+gqCeRhaB3meNlcBXxKRBxRknexqfJnFx3ZMpwDm7lOWuWpvbWoA/W/IcS6qx4XNZpMqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPYS1xaf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4072C4CECD;
	Sat,  7 Dec 2024 19:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733599374;
	bh=PgqB4r1QP9LHy8XRk/NMlDcLiT/kOPHlGNLDtInk86U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mPYS1xafs8YRN9tYC6W9AslH3uRQ8wA0Aa8ZoNriap2xhTJVCSslEPTM8YrcQNDOi
	 f1timoUSz3aMTubTBsvW1daQeium6DzRabh1xhoYltZAoQodPAba933mBwhMKYfsDv
	 p0LXnQOX888c+9sdGkhrO4vzdlzLnK25A/4PaPMWfVV+Yjd8mNk9zMUSP7dDYLmR7X
	 DHRNeuuE9mHCKHy0vb+NqA4rfohX9wOJr+9q0s1ns4d5TWFR6eEF46GVXpdEoWQPfj
	 R7CxjDgVWHoTwS47APd4BzSFoS8C4Y1WTL7ZX6ax1uClk0VUTsHw2G/yPIJ2ypuuvi
	 RtM1uCkmYRYbg==
From: SeongJae Park <sj@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Hugh Dickins <hughd@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Isaac Manjarres <isaacmanjarres@google.com>,
	Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH] mm: perform all memfd seal checks in a single place
Date: Sat,  7 Dec 2024 11:22:51 -0800
Message-Id: <20241207192251.204814-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241206212846.210835-1-lorenzo.stoakes@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Lorenzo,

On Fri, 6 Dec 2024 21:28:46 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> We no longer actually need to perform these checks in the f_op->mmap() hook
> any longer.
> 
> We already moved the operation which clears VM_MAYWRITE on a read-only
> mapping of a write-sealed memfd in order to work around the restrictions
> imposed by commit 5de195060b2e ("mm: resolve faulty mmap_region() error
> path behaviour").
> 
> There is no reason for us not to simply go ahead and additionally check to
> see if any pre-existing seals are in place here rather than defer this to
> the f_op->mmap() hook.
> 
> By doing this we remove more logic from shmem_mmap() which doesn't belong
> there, as well as doing the same for hugetlbfs_file_mmap(). We also remove
> dubious shared logic in mm.h which simply does not belong there either.
> 
> It makes sense to do these checks at the earliest opportunity, we know
> these are shmem (or hugetlbfs) mappings whose relevant VMA flags will not
> change from the invoking do_mmap() so there is simply no need to wait.
> 
> This also means the implementation of further memfd seal flags can be done
> within mm/memfd.c and also have the opportunity to modify VMA flags as
> necessary early in the mapping logic.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  fs/hugetlbfs/inode.c  |  5 ----
>  include/linux/memfd.h | 22 ++++++++---------
>  include/linux/mm.h    | 55 -------------------------------------------
>  mm/memfd.c            | 44 +++++++++++++++++++++++++++++++++-
>  mm/mmap.c             | 12 +++++++---
>  mm/shmem.c            |  6 -----
>  6 files changed, 62 insertions(+), 82 deletions(-)
> 
[...]
> diff --git a/include/linux/memfd.h b/include/linux/memfd.h
> index d437e3070850..d53408b0bd31 100644
> --- a/include/linux/memfd.h
> +++ b/include/linux/memfd.h
> @@ -7,7 +7,14 @@
>  #ifdef CONFIG_MEMFD_CREATE
>  extern long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg);
>  struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx);
> -unsigned int *memfd_file_seals_ptr(struct file *file);
> +/*
> + * Check for any existing seals on mmap, return an error if access is denied due
> + * to sealing, or 0 otherwise.
> + *
> + * We also update VMA flags if appropriate by manipulating the VMA flags pointed
> + * to by vm_flags_ptr.
> + */
> +int memfd_check_seals_mmap(struct file *file, unsigned long *vm_flags_ptr);
>  #else
>  static inline long memfd_fcntl(struct file *f, unsigned int c, unsigned int a)
>  {
> @@ -17,19 +24,10 @@ static inline struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
>  {
>  	return ERR_PTR(-EINVAL);
>  }
> -
> -static inline unsigned int *memfd_file_seals_ptr(struct file *file)
> +int memfd_check_seals_mmap(struct file *file, unsigned long *vm_flags)

Shouldn't we set this function as 'static inline'?  Otherwise, build fails when
CONFIG_MEMFD_CREATE is not defined, like below.

    ld: mm/mmap.o: in function `memfd_check_seals_mmap':
    mmap.c:(.text+0x...): multiple definition of `memfd_check_seals_mmap'; mm/gup.o:gup.c:(.text+0x...): first defined here
    ld: mm/secretmem.o: in function `memfd_check_seals_mmap':
    secretmem.c:(.text+0x...): multiple definition of `memfd_check_seals_mmap'; mm/gup.o:gup.c:(.text+0x...): first defined here

Also a trivial nit.  The second argument's name (vm_flags) is different from
that for CONFIG_MEMFD_CREATE=y (vm_flags_ptr).

>  {
> -	return NULL;
> +	return 0;
>  }
>  #endif
>  
> -/* Retrieve memfd seals associated with the file, if any. */
> -static inline unsigned int memfd_file_seals(struct file *file)
> -{
> -	unsigned int *sealsp = memfd_file_seals_ptr(file);
> -
> -	return sealsp ? *sealsp : 0;
> -}
> -
>  #endif /* __LINUX_MEMFD_H */


Thanks,
SJ

[...]

