Return-Path: <linux-kernel+bounces-576863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 342E4A71550
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A053A71A2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131021D7E52;
	Wed, 26 Mar 2025 11:07:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626DE19DF7D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742987247; cv=none; b=L5iBBMNCVgIVlKqHyKwcbGr2yJC8Sggodl3erg6oKT1EglK/Cg1JdNckuXUQ3cPl9aSpGVaI1H1D6YYT30HEAAXkUyPOAEsoYiPrcIaQMV+IPJnASHvgJMtCqfzJQpXMdJ0o3yFbcOi/6/yUbZDpL2kD6VKcqtZYU5zb2tHXm+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742987247; c=relaxed/simple;
	bh=J01mBxtL3sFxwoFq0mtKRSfNylaOw9SC5ZGoRgHTW84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fi5kWLPtwYFl+W63/4AkvnnNv6V3oXE7HgHorYF9pGuFX0g0i1V1eOqg3h67VJnnX/Y2PVL/OxU5xgllAL4qvTQUu23eg2aTuE7HzBG6z/7VKFEyzl94BK+/+3ghyWWPJTmRs9hthhnU+RqYsERLPYetv57rHyf14xU+ngI6WrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1txObO-0005Mb-O6; Wed, 26 Mar 2025 12:07:18 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1txObN-001joQ-2q;
	Wed, 26 Mar 2025 12:07:18 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1txObO-0005Vs-0Y;
	Wed, 26 Mar 2025 12:07:18 +0100
Date: Wed, 26 Mar 2025 12:07:18 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: jens.wiklander@linaro.org, sumit.garg@kernel.org, vbabka@suse.cz,
	akpm@linux-foundation.org, kernel@pengutronix.de,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tee: shm: fix slab page refcounting
Message-ID: <20250326110718.qzbwpmaf6xlcb4xf@pengutronix.de>
References: <20250325200740.3645331-1-m.felsch@pengutronix.de>
 <Z-Pc6C1YUqLyej3Z@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-Pc6C1YUqLyej3Z@casper.infradead.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 25-03-26, Matthew Wilcox wrote:
> On Tue, Mar 25, 2025 at 09:07:39PM +0100, Marco Felsch wrote:
> > Skip manipulating the refcount in case of slab pages according commit
> > b9c0e49abfca ("mm: decline to manipulate the refcount on a slab page").
> 
> This almost certainly isn't right.  I know nothing about TEE, but that
> you are doing this indicates a problem.  The hack that we put into
> networking should not be blindly replicated.
> 
> Why are you taking a reference on the pages to begin with?  Is it copy
> and pasted from somewhere else, or was there actual thought put into it?

Not sure, this belongs to the TEE maintainers.

> If it's "prevent the caller from freeing the allocation", well, it never
> accomplished that with slab allocations.  So for callers that do kmalloc
> (eg setup_mm_hdr()  in drivers/firmware/efi/stmm/tee_stmm_efi.c), you
> have to rely on them not freeing the allocation while the TEE driver
> has it.
> 
> And if that's your API contract, then there's no point in taking
> refcounts on other kinds of pages either; it's just unnecessary atomic
> instructions.  So the right patch might be something like this:
> 
> +++ b/drivers/tee/tee_shm.c
> @@ -15,29 +15,11 @@
>  #include <linux/highmem.h>
>  #include "tee_private.h"

I had the same diff but didn't went this way since we can't be sure that
iov's are always slab backed. As far as I understood IOVs. In
'worst-case' scenario an iov can be backed by different page types too.

Regards,
  Marco

> -static void shm_put_kernel_pages(struct page **pages, size_t page_count)
> -{
> -       size_t n;
> -
> -       for (n = 0; n < page_count; n++)
> -               put_page(pages[n]);
> -}
> -
> -static void shm_get_kernel_pages(struct page **pages, size_t page_count)
> -{
> -       size_t n;
> -
> -       for (n = 0; n < page_count; n++)
> -               get_page(pages[n]);
> -}
> -
>  static void release_registered_pages(struct tee_shm *shm)
>  {
>         if (shm->pages) {
>                 if (shm->flags & TEE_SHM_USER_MAPPED)
>                         unpin_user_pages(shm->pages, shm->num_pages);
> -               else
> -                       shm_put_kernel_pages(shm->pages, shm->num_pages);
> 
>                 kfree(shm->pages);
>         }
> @@ -321,13 +303,6 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
>                 goto err_free_shm_pages;
>         }
> 
> -       /*
> -        * iov_iter_extract_kvec_pages does not get reference on the pages,
> -        * get a reference on them.
> -        */
> -       if (iov_iter_is_kvec(iter))
> -               shm_get_kernel_pages(shm->pages, num_pages);
> -
>         shm->offset = off;
>         shm->size = len;
>         shm->num_pages = num_pages;
> @@ -341,10 +316,8 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
> 
>         return shm;
>  err_put_shm_pages:
> -       if (!iov_iter_is_kvec(iter))
> +       if (iter_is_uvec(iter))
>                 unpin_user_pages(shm->pages, shm->num_pages);
> -       else
> -               shm_put_kernel_pages(shm->pages, shm->num_pages);
>  err_free_shm_pages:
>         kfree(shm->pages);
>  err_free_shm:
> 
> 

