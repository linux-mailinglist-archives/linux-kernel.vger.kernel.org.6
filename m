Return-Path: <linux-kernel+bounces-194675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C988D3FCB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03327B232CF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435BC1C68B0;
	Wed, 29 May 2024 20:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LP60j8up"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6246D1B960
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717015786; cv=none; b=pdCl441uEP4SvzOqj5qzvrulZx/YTa4M+lWz3IlsIDOdsyfXKguHzG+XEkrMpbl+9Mfzu22WwyYHWzumEzlrfT+Fl8PVnDf+dJhON6LG/+lQ/Jn+pCQ/6y5WtSTQuO4s0CbXcakZRQqcJt/pnY750Iv/bNx/hR31mF2twCe1kFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717015786; c=relaxed/simple;
	bh=PWfciXvWJuTky+rNWL6zp6znQrKggTYGsT8VOPb4WsM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i14Geh7DDyxxT++0bOeOnd3doDxkyBXjzn/Tni06Z6JudPVZAGVX+E0zIqY+/r1dtz4ddOBJkQmQ/5cStqlMWMBhsQAJHy8jetWZsRLv62P+Y8k1NCSB/2OiCj1I0mg/T6kqZJnKr3XSXcI5sw4fkI7JTfPDlzP1HzpKnKC+Opc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LP60j8up; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-35bf77ba8fbso169605f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 13:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717015783; x=1717620583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jn8GixokyynrojPzWlSDYGpdxGemGL68O+dT+8a9CnA=;
        b=LP60j8upiYH7Zc/Yz8WsBKiM7CBqIhVrWvFI/k+0nKlEI0mYu0/0xYN7OpqdJ7WJYR
         +jJFlJYYLw4BMNnfe54toLLWAVIRHKpzUBiEciC3fNqMLwG8DBwxEqoMdAZfLVjuUvy3
         iyrhASGsqWld826ASbdF/fkBCPgSeSTib1msZ2tBONFAWLpHF0U4RNdQ6ijqSv7cAHpj
         KrcOdTugJwpXVWQDB35ZzczUIKF/VA2E1Pd5zdBdO1US+/NsclL7xw/FbyY2WX0+ekXY
         L4Q8YX4o3ZTS4g8thBkAqd17yzpiShWfgrz+50285hfCIWWkXxRXe8labm2oH4Y2H7sG
         /LIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717015783; x=1717620583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jn8GixokyynrojPzWlSDYGpdxGemGL68O+dT+8a9CnA=;
        b=wHSdo8B1E3k1ds/TqhogY5noZbNVt4J++e80+ZfZKerzkSjSsyOpbORiRlwlPFeNJt
         DhlG/FlbZoYW44NSWNLrm3E6/j90fSpV1tKyxnPINiTsEzTCUgopzlZ7lNj+ld2492Wi
         adfgZC0O79q72XcwOJt0A0CVq/EmLH2ettytcWmpV0A6WkC59JIfzatBZTjQYaiakp4i
         tTFjUAv/3BHwAOzkSBtrT5TjN1Q0eHbt0PpYRKfgG1lOdO7UIvKtsDkK3AYRLOjW9U5M
         MkAvHkBfboobKC12KWXjsdBimGVMrgV08yuz2pO7hxB3N+jRASIQbZuyxzxPSPn+Jb7N
         j7HQ==
X-Forwarded-Encrypted: i=1; AJvYcCW979vGepNQ7Ke1p96DIv7cLJdZJ1ELL4HVskA8URV6imsLBMLMuyYxIFleD0YRfckFxzDhTqTyCeElaubnUOqr2y1ToJMzlNq4OcXO
X-Gm-Message-State: AOJu0YzFhHayX2EuoWDZ3EYCskx6ObvZU2mHo2MDf9l1WCO+N5aaRTgq
	iRIXH1M0cUvvw4OgfH3IjkCVWurBvdzz9p0SYiy7xBUwOJNeQeAxXpP5kpt+9rY=
X-Google-Smtp-Source: AGHT+IENMwv9QoM9UqE02MAyheYmszVS5H9UUthK4Eu3nO+XUYm5m3RAvFfJ037Ub0kS/amMiPZnTw==
X-Received: by 2002:a05:6000:1f8f:b0:358:149c:eeca with SMTP id ffacd0b85a97d-35dc00c69c2mr261576f8f.67.1717015782708;
        Wed, 29 May 2024 13:49:42 -0700 (PDT)
Received: from localhost.localdomain (62.83.84.125.dyn.user.ono.com. [62.83.84.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a090805sm15479283f8f.48.2024.05.29.13.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 13:49:42 -0700 (PDT)
From: Oscar Salvador <osalvador@suse.com>
X-Google-Original-From: Oscar Salvador <osalvador@suse.de>
Date: Wed, 29 May 2024 22:49:40 +0200
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v4 16/16] mm: Remove CONFIG_ARCH_HAS_HUGEPD
Message-ID: <ZleU5I6iJq5VmPWI@localhost.localdomain>
References: <cover.1716815901.git.christophe.leroy@csgroup.eu>
 <98d6ff5bc9395785e268b9f8eff08fb742c045c6.1716815901.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98d6ff5bc9395785e268b9f8eff08fb742c045c6.1716815901.git.christophe.leroy@csgroup.eu>

On Mon, May 27, 2024 at 03:30:14PM +0200, Christophe Leroy wrote:
> powerpc was the only user of CONFIG_ARCH_HAS_HUGEPD and doesn't
> use it anymore, so remove all related code.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v4: Rebased on v6.10-rc1
> ---
>  arch/powerpc/mm/hugetlbpage.c |   1 -
>  include/linux/hugetlb.h       |   6 --
>  mm/Kconfig                    |  10 --
>  mm/gup.c                      | 183 +---------------------------------
>  mm/pagewalk.c                 |  57 +----------
>  5 files changed, 9 insertions(+), 248 deletions(-)
> 
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index 76846c6014e4..6b043180220a 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -78,7 +78,6 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>  
>  	return pte_alloc_huge(mm, pmd, addr);
>  }
> -#endif

Did not notice this before.
This belongs to the previous patch.


-- 
Oscar Salvador
SUSE Labs

