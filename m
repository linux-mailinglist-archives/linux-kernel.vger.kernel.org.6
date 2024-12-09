Return-Path: <linux-kernel+bounces-438475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFFB9EA1C4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B981886920
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 22:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BD319D091;
	Mon,  9 Dec 2024 22:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="viWkUyv/"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F75219D8A7
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 22:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733782874; cv=none; b=s1WIbT3/60kdAIFGKiI/3SE48QH2uDDtpCkXwnWQsA8U8HG/IbVWgP6tRlqLE/F/ZmJ0OZOc++kpUcZf1qulZ7BD0Uh7DqLkfz+pjZkbHDdpxN69twyMJEi9UOHEYqSnVY9XjXfNOWhBMgw51kc6uh2imDKGVAfldujODJq7NFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733782874; c=relaxed/simple;
	bh=F9Bdy6zluvt9rq6CQoTBjqZJa08lGtWgwuDDw1q+Chw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7/cw3D6xHzd7xhSnYap7OaNNrEFVdnN7rtEH/3TEUX1/LeWIi/XTx/TQEVmdJIKq1Wd/h9zMjie4EGanoL0ap5JimpCn2PQw55QQ7AwoGo/3ocxdrkLJEqwPzjjpiXhEAvUpKu6J5X4v3yvcmZP4ZP2tmfxLSUxgygvfGbl3Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=viWkUyv/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2163affd184so23455ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 14:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733782872; x=1734387672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UQ0c4ML2FptDBwiBhUUUxjDY/ghZvOgo20xW04jmY1g=;
        b=viWkUyv/RDpWB88iKQ9w4ylIT/aHQbt177o2/us/S4yVsuvt4CklEOMfJI6jvC5RMP
         xI/vizroM0n7X/9i5mvGVAcaq8PcTgGTznLwYiIxciUVjBX4o7qmOhvIz11y9T9aP0e2
         ocD8lUSrVD8X+oW10M+a1dIVSIfOcbdXHXV+yQPWkIRGhNeAzkHgD2fxV+nMfWFWRztX
         c5Yj4ENqFjek4l2MIIvuqu751kPdCdSUXiIGm/7dJqS1t1KWNEbz0dKHfIXbO3uxF6wH
         uQuDc7uO7t8ggx9SHLOf7bL0jsCzBpRhSACF1XNfBUWEDu1FB820qfPi3LWeVRUEl+6e
         h2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733782872; x=1734387672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQ0c4ML2FptDBwiBhUUUxjDY/ghZvOgo20xW04jmY1g=;
        b=LvXLE47kAvSQnMWqcdaBa+sLEBw6hdoBSwv+4lExfp+h/fvnyDnTaF/N3Vdz5F1mrd
         ENsXoI9x45LsiXl9L+EfviEKaMoYK2CLCJQKcdaF1Je7qpLYcqGcw2quTFr0GUQZAxiV
         UXwVJH5+vfZiZnVJZXEIBbo2NnfYyYLAKBIarKDnSAN5PMvFSZ/bxoJPzoI1E1AWLUUC
         JrDQU28jchTINhZ+/7roDZQf1gqr0QLxdJxZvZ9B7APJsScq2Eu7apeket0mljFizBii
         yLktNWlRDWc59ltykEtmDlIO15sypGcxw5k8HsqPWhKwklDSJAyHxEIywyr+kancCMIO
         Bomw==
X-Forwarded-Encrypted: i=1; AJvYcCWeg1n3kdqS2+tdDdYRr4wjSG7YlikTplLdx8unBnIiSqXdc7YpQsDXJEjQ6mcYs/ZAApUWZ8ccfS5Kzws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ISiGyNwEE1Wn52DHSytElZwGZerLjj/4mGWdy4y9xRkisCk5
	pGPXPGN+TlPsQpNHZ1N2YU7O5Kzbw41nUEvLRhsIThJ2Q/zyESisTlVsVwLphA==
X-Gm-Gg: ASbGncuz1XxAs/J1JfR1pL5ocepMNfEWB73Vv4Z0y53ftIxHH0KCEMiNaT/iiTF+6md
	oqYExZ+esaBJqj2/Wn0zeIqGgmx7CJPrAjHYr4qjCn7CtcQidR9+XW245d1PVeN1TsLJBjQ4FDD
	Snsz+eABXeQEdTrkmiG4wpaj3L34hDJfDiG7jtdSk966nPI+6GbQUN2DcHBgJ48Mf7X5sxk8prz
	RMzb8VfEMp90Fvk8hyAYl9IWwXjk1fB3lvG+K2XZxAgKsaB2fSeCw==
X-Google-Smtp-Source: AGHT+IGk+N2pyB4iTzK+9jBz8LLAHJvjli7QNO9KTLd4YcGLC+ooS6UqWfBpPBphl6cTEpCdV8UIFg==
X-Received: by 2002:a17:903:2ca:b0:216:6ecd:8950 with SMTP id d9443c01a7336-21674d77ed3mr164555ad.19.1733782872098;
        Mon, 09 Dec 2024 14:21:12 -0800 (PST)
Received: from google.com ([2620:15c:2d:3:ca13:4616:5dfd:8e7a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2166fc21dcbsm3026395ad.117.2024.12.09.14.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 14:21:11 -0800 (PST)
Date: Mon, 9 Dec 2024 14:21:07 -0800
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH] mm: perform all memfd seal checks in a single place
Message-ID: <Z1dtU3oxvkwQlHHo@google.com>
References: <20241206212846.210835-1-lorenzo.stoakes@oracle.com>
 <7dee6c5d-480b-4c24-b98e-6fa47dbd8a23@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dee6c5d-480b-4c24-b98e-6fa47dbd8a23@lucifer.local>

On Mon, Dec 09, 2024 at 11:13:14AM +0000, Lorenzo Stoakes wrote:
> On Fri, Dec 06, 2024 at 09:28:46PM +0000, Lorenzo Stoakes wrote:
> > We no longer actually need to perform these checks in the f_op->mmap() hook
> > any longer.
> >
> > We already moved the operation which clears VM_MAYWRITE on a read-only
> > mapping of a write-sealed memfd in order to work around the restrictions
> > imposed by commit 5de195060b2e ("mm: resolve faulty mmap_region() error
> > path behaviour").
> >
> > There is no reason for us not to simply go ahead and additionally check to
> > see if any pre-existing seals are in place here rather than defer this to
> > the f_op->mmap() hook.
> >
> > By doing this we remove more logic from shmem_mmap() which doesn't belong
> > there, as well as doing the same for hugetlbfs_file_mmap(). We also remove
> > dubious shared logic in mm.h which simply does not belong there either.
> >
> > It makes sense to do these checks at the earliest opportunity, we know
> > these are shmem (or hugetlbfs) mappings whose relevant VMA flags will not
> > change from the invoking do_mmap() so there is simply no need to wait.
> >
> > This also means the implementation of further memfd seal flags can be done
> > within mm/memfd.c and also have the opportunity to modify VMA flags as
> > necessary early in the mapping logic.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ----8<----
> From 6cfef80e2ea5154302ba9b1925acd8e77ea6cd18 Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Mon, 9 Dec 2024 11:04:08 +0000
> Subject: [PATCH] mm: fix typos in !memfd inline stub
> 
> I typo'd the declaration of memfd_check_seals_mmap() in the case where
> CONFIG_MEMFD_CREATE is not defined, resulting in build failures.
> 
> Fix this, and correct the misspelling of vm_flags which should be
> vm_flags_ptr at the same time.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/memfd.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/memfd.h b/include/linux/memfd.h
> index d53408b0bd31..246daadbfde8 100644
> --- a/include/linux/memfd.h
> +++ b/include/linux/memfd.h
> @@ -24,7 +24,8 @@ static inline struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
>  {
>  	return ERR_PTR(-EINVAL);
>  }
> -int memfd_check_seals_mmap(struct file *file, unsigned long *vm_flags)
> +static inline int memfd_check_seals_mmap(struct file *file,
> +					 unsigned long *vm_flags_ptr)
>  {
>  	return 0;
>  }
> --
> 2.47.1

Thanks for sending this out so quickly! I think this came out nicely,
and makes the memfd sealing code easier to comprehend :).

I applied both the patch that moves the memfd seal checks to one place and
the fix up patch, and tested it out on my Pixel 6 device. The device
boots, and I do not see any errors related to memfd. Please feel free
to add my tested-by tag to the patch:

Tested-by: Isaac J. Manjarres <isaacmanjarres@google.com>

Thanks,
Isaac

