Return-Path: <linux-kernel+bounces-193952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9CA8D347E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2876228499B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474D217A934;
	Wed, 29 May 2024 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FZLzfpK1"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD8A15B138
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716978210; cv=none; b=sizM9sZXpIWox4mrt1rw4Je0gaB9EyWSxKnhP6Xle5r55P91pOtW9fLCu7spcgaPY1vtxFKwS1Y8fOYt8pyKFRqlqAEJbQVS0eamwHQkQrlvcAOdE02xBgp/CanJMYUC0F760uK/x0q7J41We7HbOKr77cS2m8W4yXKAkcbXd2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716978210; c=relaxed/simple;
	bh=5YJU7VHKiuNJ7ark+3vWKP0u1a/SkdNFV15QMtctkjI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=On6RqMJzMlkNZdyaKU0aNLde398aSNB8CLvzDvXGf0K7v5TMvHjaM5gQO4jZLMEMAfSHfLuCURqNW6VapCT+4B0b3sw8v0IDDF1ZbGL9GsaAA/wnI1/iwN2KI2tTIwRFDB0PHwvFCMd2YYQPZ21aAlSBXf3zaCdLicXDNUmN/sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FZLzfpK1; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5238b5c07efso2152636e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 03:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716978205; x=1717583005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cv/PfQ3ipIos9jd7Od+Go1+GxK7Z1oC1HCEzh3CcJkw=;
        b=FZLzfpK1QNe4vw+3H6g66RzSpMek8IvoF45LfWM29jxESKr+b2NpklPPoZLH+qOvh1
         reb0zZ5iOMRAudmA5Q9d7UpgTjV0Z/Xu7W6UjDBV1VkwFjLuR+mkNcA+5OoqwGLAEaZr
         TDAZjOIVg5GcCo6uTjGuGB7+aRYiTzE/cG0vRhdZ8Zwqfd9Zq9VbYOSnlFJ4hiSoREAd
         1H43e/BtJ3uP4nhZdWu+T3ZMFmqnMpduhFit2S3hthwDFLnyF+N+S8G+YblXIJPPmQKe
         mv5zvuyJtZLBtbYhByL2eRpbBImdUjOLgx+lUbVBMEooAFISzdcX9zWRWUqzmF6UKFdP
         1+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716978205; x=1717583005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cv/PfQ3ipIos9jd7Od+Go1+GxK7Z1oC1HCEzh3CcJkw=;
        b=kgbW+iAk2/wQf37Y+fFJW7cCXeW6A3IeeDcMUSoddNoRQcxW1MngDalTwPJ9zVZjYl
         SYAHukqNtiAs3PpMkww1O9zjycD//xaMUYSnGa7gzg8UTj8U5b95EFrWpu2rXZrEiAVM
         OOTQxwvI5oo7iDyU6wmSB0wVxCcTJEczn2pomTFykloe2Fz71Ow5/wZy5NW4Kn1gPum8
         snA6LDTNO8+dpdSMfpr7BZI7lH9MuNSxqHBBzI7T1Mx88A3O1zRj040Xfz6Y3Uq6BJ1K
         lfvslqOyio5BjXswKLN9YlOtMBVY5zP2IwDux32QjXhpjlDR34MsmMt29Xj7ORzo1A4g
         5ZMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVDZcQIrXty1g0tvH81C43EjbBFnjLs2nZHBsGjbwHp0LFTrP+kx1JuVWAuxgTeoCZai4dZAo4God1qiGZNV3+nod8NGqpEnbqEOuX
X-Gm-Message-State: AOJu0Yw3qGnlBfxGc2mUjjWXwWcoxS7FDlrPk3KJk0Opl1XG3Er7o3lD
	gbfOa53woL+LfED5eoBLG2poufuxEH9byJNLbf8F3YfmlqlYrSNTIAJGqr+9HEI=
X-Google-Smtp-Source: AGHT+IF7IgN4nPJ8uxsJPr2FPONLdRAirmEdNuIVjpikXZwr3Zpn2fZcBlzyhSXu1nTASxB+UaNCCw==
X-Received: by 2002:a19:7717:0:b0:51d:8ff3:d156 with SMTP id 2adb3069b0e04-529645e3335mr8922884e87.19.1716978205294;
        Wed, 29 May 2024 03:23:25 -0700 (PDT)
Received: from localhost.localdomain (62.83.84.125.dyn.user.ono.com. [62.83.84.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f759f0sm201856835e9.28.2024.05.29.03.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 03:23:25 -0700 (PDT)
From: Oscar Salvador <osalvador@suse.com>
X-Google-Original-From: Oscar Salvador <osalvador@suse.de>
Date: Wed, 29 May 2024 12:23:23 +0200
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v4 00/16] Reimplement huge pages without hugepd on
 powerpc (8xx, e500, book3s/64)
Message-ID: <ZlcCG8DZk6CnMPzQ@localhost.localdomain>
References: <cover.1716815901.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1716815901.git.christophe.leroy@csgroup.eu>

On Mon, May 27, 2024 at 03:29:58PM +0200, Christophe Leroy wrote:
> This is the continuation of the RFC v1 series "Reimplement huge pages
> without hugepd on powerpc 8xx". It now get rid of hugepd completely
> after handling also e500 and book3s/64
> 
> Also see https://github.com/linuxppc/issues/issues/483
> 
> Unlike most architectures, powerpc 8xx HW requires a two-level
> pagetable topology for all page sizes. So a leaf PMD-contig approach
> is not feasible as such.
> 
> Possible sizes on 8xx are 4k, 16k, 512k and 8M.
> 
> First level (PGD/PMD) covers 4M per entry. For 8M pages, two PMD entries
> must point to a single entry level-2 page table. Until now that was
> done using hugepd. This series changes it to use standard page tables
> where the entry is replicated 1024 times on each of the two pagetables
> refered by the two associated PMD entries for that 8M page.
> 
> For e500 and book3s/64 there are less constraints because it is not
> tied to the HW assisted tablewalk like on 8xx, so it is easier to use
> leaf PMDs (and PUDs).
> 
> On e500 the supported page sizes are 4M, 16M, 64M, 256M and 1G. All at
> PMD level on e500/32 (mpc85xx) and mix of PMD and PUD for e500/64. We
> encode page size with 4 available bits in PTE entries. On e300/32 PGD
> entries size is increases to 64 bits in order to allow leaf-PMD entries
> because PTE are 64 bits on e500.
> 
> On book3s/64 only the hash-4k mode is concerned. It supports 16M pages
> as cont-PMD and 16G pages as cont-PUD. In other modes (radix-4k, radix-6k
> and hash-64k) the sizes match with PMD and PUD sizes so that's just leaf
> entries. The hash processing make things a bit more complex. To ease
> things, __hash_page_huge() is modified to bail out when DIRTY or ACCESSED
> bits are missing, leaving it to mm core to fix it.

Ok, I managed to go through the series and provide some feedback.
Sorry you had to bear some dumb questions but I am used to x86 realm where
things are farily easier wrt. hugepage sizes.

I will over v5 when you send it, but I think this would benefit from another
pair of eyes (with more powerpc knowledge than me) having a look.

Anyway, I think this is a great step in the right direction, and definitely
a big help for the upcoming tasks.

I plan to start working on the walk_page API to get rid of hugetlb
specific hooks basing it on this patchset.

Thanks a lot for this work Christophe


-- 
Oscar Salvador
SUSE Labs

