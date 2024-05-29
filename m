Return-Path: <linux-kernel+bounces-193932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3DF8D3436
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF6B51F204E1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A3617DE17;
	Wed, 29 May 2024 10:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H74JXIVV"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984B317A937
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 10:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977507; cv=none; b=jtWq2bVufOa7ig2nxjyoq8qLVjAhJ1F3HgEEyP+QyPhes93wszze3cwSIcVIW6zE4kWPIOrGaNgH4FhLszhleyry10n60uqbXbrmA6vDDkxxDlWpVECCKk5n2/IYPkDxvfYm8BfElEx/3O8ILVHcLdMn0ilHYisi2kQJIbohDZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977507; c=relaxed/simple;
	bh=5KXB7xCoblil3ITcZRfMYkXXTmPu4JaI/K8pLRSHIRQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kp2mqEz/0f9jCOgbC1vLvNXTeuh1wMK+fedX2XQZFTyTp/dRqCi/e3sxVXDV5NiYUnoCOa1QaWNI0vqF1cTcVXvLVGi5Tu6gthOWkmbNQAqcJjV2G0wDz/rn1rqHw1vjnZkobYqsc3H7CZnwuDb37MQHDmDxTTlqEcGhK24Zncs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H74JXIVV; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ae38957e8so553990e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 03:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716977504; x=1717582304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k0oPejzF1w45d4ohzjxE+rStMmo86jxOO0aZ2z51+qs=;
        b=H74JXIVVmLh54BRdzCHeU/v4SjfXNzEuvKU+TdHP0Kq3Ucosl/h7ECXpB9ntqYffV2
         9Gshca5Wros/Q2PGRM3gzePynnBewhZ1P2CPdoMv7D8WcNDPdW8vk11z7UKo9RBYqPlC
         8SzIXF5FVheA40Id4vHf52CB9w4t6OHmR6+OYOlriIREkSwbzNBSZibfMg39E6qAsIcE
         5oeRikfhpkzJed9bllUe1XtuwwZ6heVjDJHQq/31hd1jFSVF9ukkvu4NM7+BSyAj0NsP
         KzBDVpRvaWsXjJMlrs/o5dEBsusUYsQgn4n8O64ud+TZ29tiYtWfa8CE5Hr56F/G3hk8
         5vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716977504; x=1717582304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0oPejzF1w45d4ohzjxE+rStMmo86jxOO0aZ2z51+qs=;
        b=Jwqr5ZG6kpXUsg8c/i4epcbNy8kc+ecj7FtOvkrGqcRWxfV3qNnYKijOh3+ZkRydwS
         toayUgsUvGQC5yTFa4SU7r7GOXvtavq57UBjCVhjbW7Er3ZT1h27pNLpXwyti8xPGMcJ
         SCL8eixZY6SEhVXDJCOjcMJdaKZ8jOcIG1xDG/rN6EfXwaDb8KjnWSuitOSvkLIaKY64
         a22WWuYlTc8kad+uoZDLWAuMjlbLlh70HyjRyvsSor038AWE6Yqfj5HLJLhPY72oFYe+
         E2LqqIj1Ibc+T+t8QO+ZmAbLFgXPW4WBdGOkmiuFL2ED83HswLA9vVj0AXhNRE+GZROM
         fQ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuTQU1fGaaJWFIVqkAwMzfzwbz4DeEfVz3B5wlr1r9ldukwD7rAptX5nNgrGbD4xUAsdgo3S08TJc0bK/ShGqDhSjWh15OsGY6OzIv
X-Gm-Message-State: AOJu0Yy8FsKgLF3A5HGRMTBKC2Jb30FRf48OcTsq1fUlw42ZBiO2H7Dp
	Iz/owAu4TMl4UMJlD+tYQgwnfxEZkbRG3nkpmXpO8g2SzuRgdq+ZGu8DOwk5KmQ=
X-Google-Smtp-Source: AGHT+IFgYrZo5ta4E3uoE7uAwXaw0QkKXO8VSmlKA6YJb4kJBFmoM8GRlbMlJbE7XEdqt2jjmDPZMw==
X-Received: by 2002:a19:8c5e:0:b0:51d:bbb:7a4e with SMTP id 2adb3069b0e04-529645e344bmr9036378e87.24.1716977503662;
        Wed, 29 May 2024 03:11:43 -0700 (PDT)
Received: from localhost.localdomain (62.83.84.125.dyn.user.ono.com. [62.83.84.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089cd6f7sm174662585e9.46.2024.05.29.03.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 03:11:43 -0700 (PDT)
From: Oscar Salvador <osalvador@suse.com>
X-Google-Original-From: Oscar Salvador <osalvador@suse.de>
Date: Wed, 29 May 2024 12:11:41 +0200
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Oscar Salvador <osalvador@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH v4 14/16] powerpc/64s: Use contiguous PMD/PUD instead
 of HUGEPD
Message-ID: <Zlb_XT12arHu9vu3@localhost.localdomain>
References: <cover.1716815901.git.christophe.leroy@csgroup.eu>
 <610be6003a6d215e9e9ca87d7f5402042da1e355.1716815901.git.christophe.leroy@csgroup.eu>
 <Zlb0BugOwko4PrLm@localhost.localdomain>
 <315d1dc7-9eda-45cd-863d-803bfae4c29b@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <315d1dc7-9eda-45cd-863d-803bfae4c29b@csgroup.eu>

On Wed, May 29, 2024 at 10:07:55AM +0000, Christophe Leroy wrote:
> We can't but I didn't want to leave nb undefined or with a value that 
> might lead to writing in the weed. Value 1 seems a safe default.

Might be worth to throw a WARN_ON?

> >> diff --git a/arch/powerpc/mm/book3s64/hugetlbpage.c b/arch/powerpc/mm/book3s64/hugetlbpage.c
> >> index 5a2e512e96db..83c3361b358b 100644
> >> --- a/arch/powerpc/mm/book3s64/hugetlbpage.c
> >> +++ b/arch/powerpc/mm/book3s64/hugetlbpage.c
> >> @@ -53,6 +53,16 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
> >>   		/* If PTE permissions don't match, take page fault */
> >>   		if (unlikely(!check_pte_access(access, old_pte)))
> >>   			return 1;
> >> +		/*
> >> +		 * If hash-4k, hugepages use seeral contiguous PxD entries
> > 'several'
> >> +		 * so bail out and let mm make the page young or dirty
> >> +		 */
> >> +		if (IS_ENABLED(CONFIG_PPC_4K_PAGES)) {
> >> +			if (!(old_pte & _PAGE_ACCESSED))
> >> +				return 1;
> >> +			if ((access & _PAGE_WRITE) && !(old_pte & _PAGE_DIRTY))
> >> +				return 1;
> > 
> > I have 0 clue about this code. What would happen if we do not bail out?
> > 
> 
> In that case the pte_xchg() in the while () will only set ACCESS or 
> DIRTY bit on the first PxD entry, not on all cont-PxD entries.

I see, thanks for explaining.


-- 
Oscar Salvador
SUSE Labs

