Return-Path: <linux-kernel+bounces-210624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F57904655
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 23:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E855F285DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 21:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B97153835;
	Tue, 11 Jun 2024 21:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xy5AzKOw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090242CCB7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 21:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718142232; cv=none; b=GnL0EB0HAOiTRblB1+Lr1pZgJqic6/L/8wjEu4hrhpaZyuUYIgK5yUSgJDv5qaqz0Gnj6lSEn6kQrLAsP6gvBMIpXUBpcCZpDa6L90f3BpDeXfyruGEl2+unpzt30ELQBQX7wI1hTguMLhQvvDSUP3jASgQDgAPCT9DgRaxR5wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718142232; c=relaxed/simple;
	bh=4bEauCXpT8+5T6IdGZVJG5R/Lvn0TYgN6qLg45590a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upU0zF6yHmIN5SmEZaQt4nTd/GBNpCOk6h6C6Qhhs0LDQWUzpRbxGj47AC2aLY+k5R7eRabxcZxyDsLfioiHUp2B4r3ID4EGNjDmEnaOfDs61lMflUjT6jXL5xUTgq5A4fpn/6YCjUi6CVpMztVqJoz7p43/+T+/bRBT8JlfEQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xy5AzKOw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718142229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hTou1qm81TgVNA2Djt+o16mxlwm2tQTw5dfTSjdkG/I=;
	b=Xy5AzKOwcRto83bhZi11MuyEqv2a6xuWF5UhzhobZSQUhl3HC8XzSeHN9PMIupzH2GXEUn
	N7zGAWicqg35VdOXeAJn7sKu6+2rosWYxctx2tVNSgAZSI7VH07vyAjr1oCcEa6zlcnf3x
	IEU7hApo+I3NP9EeTvggsb+osdarkYM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-AzYQR6lyPua1fLtCHXFBRg-1; Tue, 11 Jun 2024 17:43:48 -0400
X-MC-Unique: AzYQR6lyPua1fLtCHXFBRg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-79560b25fc4so26429385a.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718142227; x=1718747027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTou1qm81TgVNA2Djt+o16mxlwm2tQTw5dfTSjdkG/I=;
        b=V3exidOTLKcAJHoXTYPHzE68EfKJDri/bL3AJ86bV9mmEol+GUVM12yDV0ECdKbJfD
         WidbObbgtOBmPxff9hH2xgAoRqOilBiQhbMzQTpz/QgzNeN7o1pJmnKJMilvv5dNhyYr
         Xrsu+yF8vnLcu4P4nthEfPCtM00BZNsXffbkMhjAGH7YegpXmsGOfLl+onSmRKazPWNw
         kt0XqkyVkbv0wY8sysLKLDNO5NYuK2gmfCCXMkbbUR/XhgHWpoyPKg/XrBHc606geG6r
         frIbL4VahQAgC1Lq3AJ7YD3fDx9dmTK4SeZuyRqxgVTZo1Ahbh6Ks9I/cYRwrydmR+9Z
         auIA==
X-Forwarded-Encrypted: i=1; AJvYcCULwISNP1HLELLuK9ZJg59psBqDrdLaUm/f5/NhkdbsNzshNR+efv5BkO+tk0/5XK8BQ+nrpqeN/PmGFcWNfs1FH74ObUIXJ2++mzm4
X-Gm-Message-State: AOJu0YxiA8sUf3H1utcTx2rLM46851iAT8/bxjv0gKerZIPjC6ezQz7X
	HcwdEY+jU0UDQoxEpE4AE9x15PSO7Ne19M5N2fZ27COIGKyQzrthyb2kluzRe9KjI7xcjPar0WI
	QXSM0k2hy3JGCATfa9mgTrkt2OWC8a+xiFmucijI2eC9aoGG+YB0DszAfZQ+r7Gxzqah4BQ==
X-Received: by 2002:a05:6214:1c84:b0:6af:f955:3a92 with SMTP id 6a1803df08f44-6b05985d61dmr145506606d6.0.1718142227182;
        Tue, 11 Jun 2024 14:43:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOa0/b65UqaWampbYi2ciS5tODEVjHDgAJKDJEJxgPSIVwH0ULUwrYdhk3hQqSpzGqunDNJA==
X-Received: by 2002:a05:6214:1c84:b0:6af:f955:3a92 with SMTP id 6a1803df08f44-6b05985d61dmr145506356d6.0.1718142226586;
        Tue, 11 Jun 2024 14:43:46 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f984940sm61002196d6.89.2024.06.11.14.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 14:43:46 -0700 (PDT)
Date: Tue, 11 Jun 2024 17:43:43 -0400
From: Peter Xu <peterx@redhat.com>
To: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Cc: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v5 02/18] mm: Define __pte_leaf_size() to also take a PMD
 entry
Message-ID: <ZmjFD8jRt4JkKbxN@x1n>
References: <cover.1717955558.git.christophe.leroy@csgroup.eu>
 <172b11c93e0de7a84937af2da9f80bd17c56b8c9.1717955558.git.christophe.leroy@csgroup.eu>
 <ZmgaHyS0izhtKbx6@localhost.localdomain>
 <ZmhcepJrkDpJ7mSC@x1n>
 <ZmhofWIiMC3I0aMF@localhost.localdomain>
 <ZmhrIdh3PLzvZU07@x1n>
 <Zmh282yJjxc7zqbL@localhost.localdomain>
 <e9583aa5-4ad7-4bcf-b3ff-f42b983231f5@cs-soprasteria.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e9583aa5-4ad7-4bcf-b3ff-f42b983231f5@cs-soprasteria.com>

On Tue, Jun 11, 2024 at 07:00:14PM +0000, LEROY Christophe wrote:
> But what about something like
> 
> static inline pte_t pmd_pte(pmd_t pmd)
> {
> 	return *(pte_t *)pmd_page_vaddr(pmd);
> }
> 
> Would it do the trick ?
> 
> Of course it would require to carefully make sure all accesses are done 
> through pmd_pte().
> 
> Would that work ?

Looks possible to me. It's just that we may miss some spots, and it can
hide in the details.

I'm looking at Power's pmd_access_permitted() right below pmd_write(),
which indeed uses pmd_pte() already. However before that there's also the
other call to pmd_is_serializing(), which doesn't look alright to work on
pgtable pages..  In this case maybe it's easy, as I assume pgtable page is
stable.  Didn't further look, though.

Said that, this doesn't look like a blocker. So maybe worth trying if we're
careful and with some good testing coverages.

Thanks,

-- 
Peter Xu


