Return-Path: <linux-kernel+bounces-576850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39120A71524
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADEEB1890C69
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B827B1C8635;
	Wed, 26 Mar 2025 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WVonhhUL"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D981C84C9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742986478; cv=none; b=nAcBz01OERW5ZCSd5sgbCsqTt+n5vi3ocWoDJ885AUAE5S7W5fqfGLplqCxzNqCFTggcjjwH6+HG+Lblmt4AiB6InE+X7DXZBWRIWVgiL0F2oxopo208hdT2XsGmyFbK5jL+9VQDlQMV9utAk03xgoE2Q+wjlJMEDY6+UyEFzzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742986478; c=relaxed/simple;
	bh=kqvc9gqaZFqz4zk2Z1WI6mBz6fpdOjwBd3T92JdtEOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JX14YKPVmq5TLhBwZJ5pemUjJ+PhfPUivTIBVoCxoVvMkUXAfqhQt8ywzR/ilt3jx2LPIqpYWoDXK+A8kfnlpKbQdLSGwXJY0VlR+J7mKexu9zvXEugg8GK/xnTbR6Kgyyn6O+Zq+74qqA/7FdEuBS7qIeKSMzXTdIw038sORtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WVonhhUL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nbnBL06pB45fzWAHqKwSaMaHJhZWmXAUhJuqN+ACJZI=; b=WVonhhULebs82is9MN1i1h5rEy
	sOwlwgC1wimWJ6Udx5JFUb7htc15dJoA0ePi+33p6uqbf4aLT7YxGpfe6TpUfngCZ2VL9GmH0UL4s
	BXnTn9Iw91yX8zkC8Pd4ZKhMMVglQEVBR46FsWAUr/afS/dfPV9ydOasLFqeipvIO4n6L0WNPXwB1
	JWgsGZySqx7VKnlxLeptGJ72nynJam7V8a2XVHm72kA1VxKpTBh2KckEAW5DT5QqNGQSDnDPKmyTS
	0niBJBgo7srUPhqR7mz+8z0+Ixz5CFeTiwyoi6b+xzHr0NT+v+fsuEBuUl6gVfuy7mcScE/AXQrCg
	iMQbtlew==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txOP2-0000000HPuG-1AbF;
	Wed, 26 Mar 2025 10:54:32 +0000
Date: Wed, 26 Mar 2025 10:54:32 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: jens.wiklander@linaro.org, sumit.garg@kernel.org, vbabka@suse.cz,
	akpm@linux-foundation.org, kernel@pengutronix.de,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tee: shm: fix slab page refcounting
Message-ID: <Z-Pc6C1YUqLyej3Z@casper.infradead.org>
References: <20250325200740.3645331-1-m.felsch@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325200740.3645331-1-m.felsch@pengutronix.de>

On Tue, Mar 25, 2025 at 09:07:39PM +0100, Marco Felsch wrote:
> Skip manipulating the refcount in case of slab pages according commit
> b9c0e49abfca ("mm: decline to manipulate the refcount on a slab page").

This almost certainly isn't right.  I know nothing about TEE, but that
you are doing this indicates a problem.  The hack that we put into
networking should not be blindly replicated.

Why are you taking a reference on the pages to begin with?  Is it copy
and pasted from somewhere else, or was there actual thought put into it?

If it's "prevent the caller from freeing the allocation", well, it never
accomplished that with slab allocations.  So for callers that do kmalloc
(eg setup_mm_hdr()  in drivers/firmware/efi/stmm/tee_stmm_efi.c), you
have to rely on them not freeing the allocation while the TEE driver
has it.

And if that's your API contract, then there's no point in taking
refcounts on other kinds of pages either; it's just unnecessary atomic
instructions.  So the right patch might be something like this:

+++ b/drivers/tee/tee_shm.c
@@ -15,29 +15,11 @@
 #include <linux/highmem.h>
 #include "tee_private.h"

-static void shm_put_kernel_pages(struct page **pages, size_t page_count)
-{
-       size_t n;
-
-       for (n = 0; n < page_count; n++)
-               put_page(pages[n]);
-}
-
-static void shm_get_kernel_pages(struct page **pages, size_t page_count)
-{
-       size_t n;
-
-       for (n = 0; n < page_count; n++)
-               get_page(pages[n]);
-}
-
 static void release_registered_pages(struct tee_shm *shm)
 {
        if (shm->pages) {
                if (shm->flags & TEE_SHM_USER_MAPPED)
                        unpin_user_pages(shm->pages, shm->num_pages);
-               else
-                       shm_put_kernel_pages(shm->pages, shm->num_pages);

                kfree(shm->pages);
        }
@@ -321,13 +303,6 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
                goto err_free_shm_pages;
        }

-       /*
-        * iov_iter_extract_kvec_pages does not get reference on the pages,
-        * get a reference on them.
-        */
-       if (iov_iter_is_kvec(iter))
-               shm_get_kernel_pages(shm->pages, num_pages);
-
        shm->offset = off;
        shm->size = len;
        shm->num_pages = num_pages;
@@ -341,10 +316,8 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,

        return shm;
 err_put_shm_pages:
-       if (!iov_iter_is_kvec(iter))
+       if (iter_is_uvec(iter))
                unpin_user_pages(shm->pages, shm->num_pages);
-       else
-               shm_put_kernel_pages(shm->pages, shm->num_pages);
 err_free_shm_pages:
        kfree(shm->pages);
 err_free_shm:


