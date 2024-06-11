Return-Path: <linux-kernel+bounces-210141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B9D903FD9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364C61F2479F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89728208AF;
	Tue, 11 Jun 2024 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVkJdpBQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691A614A96
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718119216; cv=none; b=VutV0PZQZvcdM9wRZhyWA2UNNv/PdA9Ph/grFtCnn3a6OZIDnnYCzUQ3RoHDONE3/V2+k8xHwOfx3Ub7FmLuZeHvYYrEayKQgOZNZxYHioiPwqhQsmcaDJolmCm6eJQjv+hDtayBE5gxJ9wU72Lmj5qIV80sFjfDxem4nwrouAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718119216; c=relaxed/simple;
	bh=ygpd/NUM0MXtrTTCxV9OZ1XYVALSgdgXlPbB77lA7QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvqiWkcue5uLUeOcZSOOxLvn+bP9j3Bv9FoECsLjR5tg6MS1U7xsL6VOJEoTMDAvFb/+FUvsp6rUi6+fbnMaKe+3zj53e1b6BECRfxiYOAIVIKRvXMoCr9q6Ts4pxII8A1puCEnTLoaX3rScb9DzQy/7YNJm9cb7FNVw371jmvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TVkJdpBQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718119214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T5mvQKuhxaeQQofAs6C4gb9DRnHzKICw8L5tE3p1+hQ=;
	b=TVkJdpBQxc4zrzyL7aanp31I68opJrtFrApUz9b+UvKY9KEDkUTLN9F3KA2hI1EZMlU8cV
	+BEh7APWZ5X/tbgvxoQtrkiraXlvgRNds0P0BAYShahtLocmFZM075CjDEaehuOGJ9Obex
	2qmD+qudl87fnRiuzLJOjSGKl/4H0K8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-x-tXif45M-2lVpOzXvGoKA-1; Tue, 11 Jun 2024 11:20:11 -0400
X-MC-Unique: x-tXif45M-2lVpOzXvGoKA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b07a472e83so5729326d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718119211; x=1718724011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5mvQKuhxaeQQofAs6C4gb9DRnHzKICw8L5tE3p1+hQ=;
        b=cnl2qWd2Kz3d3J6XTvBg35bC2niEnL2ZQ61JKdVrJWEMM6MEBcPy7FNW5oQdD87OEm
         8CaCIJDb1j8xVfw6NM36+N+33E0ccph+MOmGu8CW28nGpYroP0rV6R41Kcj1IQxLZY5w
         TbRl5Uoj1NViUvSZHT6TOuUSsxnyR+R1oebGKaSKN0Exkmis2OsKH3IfAvMYvKdGHu1Y
         z/n/MyR/srsNThLtlOhn3vvqkkzuEVwXdSYG7NaOpSPca+VqpMbp1ygWqru00ABkWeo8
         vkcQ8TyOmQOKGaSPQIQTWgWdTrS6hQy6eDSPb+4fwPd6yGK2TB1nhSKXUCZTIy/SnBDS
         nKww==
X-Forwarded-Encrypted: i=1; AJvYcCVCbcsDXRdIolkgpLheT/nHq3zVdqmiIWodsT/P5RpLSuUjqVspxQlAPtRQjifNyF4SFkRC6RHczm32v67cb+lnZwOjz+jzOMfJhZej
X-Gm-Message-State: AOJu0YxYgKXv1oVPOevIZotNwqXDzHLp86JPs5z25RHlKdsbkszKB34j
	+cfjHJBNhTaz1+IT4NJZ8JB8qY/IeU6q0kWZ7ikNBlX/4Rpc5ShLlnV5qTUnHb6HZ4KQRkynRo2
	1E5v4420YlP6E4D8VQMwtHxTjWD2YdjT8NpMvMmyCmZVNOqGcUGzhUJEXLqHX9g==
X-Received: by 2002:a0c:f2c4:0:b0:6b0:6a38:e01d with SMTP id 6a1803df08f44-6b06a38e41dmr101257536d6.0.1718119211077;
        Tue, 11 Jun 2024 08:20:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGp29M2m3Z9CcVJeoqe5Y30dylVGZ7dKwW4YVbu6zPqN2ZAsi/IG1oHRYe8ljnYJ2xhhs21CQ==
X-Received: by 2002:a0c:f2c4:0:b0:6b0:6a38:e01d with SMTP id 6a1803df08f44-6b06a38e41dmr101257016d6.0.1718119210384;
        Tue, 11 Jun 2024 08:20:10 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4406203775bsm25557621cf.72.2024.06.11.08.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 08:20:09 -0700 (PDT)
Date: Tue, 11 Jun 2024 11:20:01 -0400
From: Peter Xu <peterx@redhat.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 02/18] mm: Define __pte_leaf_size() to also take a PMD
 entry
Message-ID: <ZmhrIdh3PLzvZU07@x1n>
References: <cover.1717955558.git.christophe.leroy@csgroup.eu>
 <172b11c93e0de7a84937af2da9f80bd17c56b8c9.1717955558.git.christophe.leroy@csgroup.eu>
 <ZmgaHyS0izhtKbx6@localhost.localdomain>
 <ZmhcepJrkDpJ7mSC@x1n>
 <ZmhofWIiMC3I0aMF@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZmhofWIiMC3I0aMF@localhost.localdomain>

On Tue, Jun 11, 2024 at 05:08:45PM +0200, Oscar Salvador wrote:
> The problem is that we do not have spare bits for 8xx to mark these ptes
> as cont-ptes or mark them pte as 8MB, so I do not see a clear path on how
> we could remove huge_ptep_get for 8xx.

Right, I remember I thought about this too when I initially looked at one
previous version of the series, I didn't come up yet with a good solution,
but I guess we probably need to get rid of hugepd first anyway.  We may
somehow still need to identify this is a 8M large leaf, and I guess this is
again the only special case where contpte can go over >1 pmds.

> 
> I am really curious though how we handle that for THP? Or THP on 8xx
> does not support that size?

I'll leave this to Christophe, but IIUC thp is only PMD_ORDER sized, so
shouldn't apply to the 8MB pages.

Thanks,

-- 
Peter Xu


