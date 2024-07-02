Return-Path: <linux-kernel+bounces-237773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C5B923DF2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4668F287962
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A1915CD7A;
	Tue,  2 Jul 2024 12:34:36 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FAC1534E1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923676; cv=none; b=VJp4C6urEoZAytV56DqlNQthcgqLTouBk1A2xnhd1m6zI1YbtSmaqY6MwZP08IJ6AiVpca/xpsVdwoTQmV53AEhp3HQCmnS/cvL4dfqPyfQWMz8ojeN8sGma/7+4yYYw0Xy8dLckr50ix6imHjMxmL5wa/f74yXjmRHFtbtO2aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923676; c=relaxed/simple;
	bh=OH6oYUoymhgjC/JuHvWia2C/kOgOQMzd/Pdohajox5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2OijNCKvodBYaLlPxcl6nORWon9NNFCd4WHmFAI1RC6qDcA9C7TJm7Ts7zo5+T+PDK0QlA6wyHyV3qO1O36xwY/a86TyCKOVJljd7q5AaWipP3/B3hz2RkqT3mKz4Oyv3s3qd8q5o6128+eUZBy9uzoFQg0lW6/6rjRps5MEIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218CCC116B1;
	Tue,  2 Jul 2024 12:34:33 +0000 (UTC)
Date: Tue, 2 Jul 2024 13:34:31 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: muchun.song@linux.dev, will@kernel.org, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hugetlbfs: add MTE support
Message-ID: <ZoPz14fYSqVyvRTw@arm.com>
References: <20240625233717.2769975-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625233717.2769975-1-yang@os.amperecomputing.com>

On Tue, Jun 25, 2024 at 04:37:17PM -0700, Yang Shi wrote:
> MTE can be supported on ram based filesystem. It is supported on tmpfs.
> There is use case to use MTE on hugetlbfs as well, adding MTE support.
> 
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
>  fs/hugetlbfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index ecad73a4f713..c34faef62daf 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -110,7 +110,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
>  	 * way when do_mmap unwinds (may be important on powerpc
>  	 * and ia64).
>  	 */
> -	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND);
> +	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND | VM_MTE_ALLOWED);
>  	vma->vm_ops = &hugetlb_vm_ops;

Last time I checked, about a year ago, this was not sufficient. One
issue is that there's no arch_clear_hugetlb_flags() implemented by your
patch, leaving PG_arch_{2,3} set on a page. The other issue was that I
initially tried to do this only on the head page but this did not go
well with the folio_copy() -> copy_highpage() which expects the
PG_arch_* flags on each individual page. The alternative was for
arch_clear_hugetlb_flags() to iterate over all the pages in a folio.

I'd also like to see some tests added to
tools/testing/selftest/arm64/mte to exercise MAP_HUGETLB with PROT_MTE:
write/read tags, a series of mman+munmap (mostly to check if old page
flags are still around), force some copy on write. I don't think we
should merge the patch without proper tests.

An untested hunk on top of your changes:

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 3954cbd2ff56..5357b00b9087 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -20,7 +20,19 @@ extern bool arch_hugetlb_migration_supported(struct hstate *h);
 
 static inline void arch_clear_hugetlb_flags(struct folio *folio)
 {
-	clear_bit(PG_dcache_clean, &folio->flags);
+	unsigned long i, nr_pages = folio_nr_pages(folio);
+	const unsigned long clear_flags = BIT(PG_dcache_clean) |
+		BIT(PG_arch_2) | BIT(PG_arch_3);
+
+	if (!system_supports_mte()) {
+		clear_bit(PG_dcache_clean, &folio->flags);
+		return;
+	}
+
+	for (i = 0; i < nr_pages; i++) {
+		struct page *page = folio_page(folio, i);
+		page->flags &= ~clear_flags;
+	}
 }
 #define arch_clear_hugetlb_flags arch_clear_hugetlb_flags
 
diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index 5966ee4a6154..304dfc499e68 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -28,7 +28,8 @@ static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
 	 * backed by tags-capable memory. The vm_flags may be overridden by a
 	 * filesystem supporting MTE (RAM-based).
 	 */
-	if (system_supports_mte() && (flags & MAP_ANONYMOUS))
+	if (system_supports_mte() &&
+	    (flags & (MAP_ANONYMOUS | MAP_HUGETLB)))
 		return VM_MTE_ALLOWED;
 
 	return 0;

-- 
Catalin

