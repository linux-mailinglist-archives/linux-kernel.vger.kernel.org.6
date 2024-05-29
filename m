Return-Path: <linux-kernel+bounces-193687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 646428D3082
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4B61C248AA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F29178370;
	Wed, 29 May 2024 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AWxjrAvN"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD8D168C3A
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716969962; cv=none; b=kCXZ/g06MpgiENjrPizRemN3TEQ2v7ZQf8LkFaZiQ99HfaiG+kDa/G0rTmqbdXWLtx8vfK97VStWBZPIVzxHLvMYhggdQE1rtCmc0urWamCKOdbHXDa9+dnoQIRPW/xKYK4GLvPi3B8bcGo0fM8dhkEFpK+eLhEMIpzgONARZGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716969962; c=relaxed/simple;
	bh=e7seYhpXUI67eJGOAuOpL9ZC55dxEPiWops66jBMc6I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7YOjQOx74jMu8AgXVqVCa+AkNojMAAYoMNSMI0B1BTNrTWkxLJowipaK8D/hkuwXTepbGMPQ2km70cjmYciZQKk4pp4YfMSxCeX0NSNkL3N/C1jDGa0vi+RBadkCtMtjeG3GgVzPms3nzNKimnpAtkGoycIWZDTRtcLemRlC4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AWxjrAvN; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-354c5b7fafaso1466314f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 01:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716969958; x=1717574758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N5XpAlzs8/5dy/UfJxZhXqs4EkV35bosYx2T12GiUv4=;
        b=AWxjrAvN/aF+FHqn6/PygoTmC/we3guRzLHEfggqkJ2ohI7w4pXnGf1zmrsDykifuh
         s/OhW8HBrENpfjSSviqW6CLCzU/HHjBSwTQlDeAV9AuEm+KFH+AauC+0QYqfhdMlT2QH
         YC7VqeWiy3JCJN9URaVjNs+mkW7wR/7OGh77S5PU9c5oQ1g8efEwhwP/Ibw4wzgV47e9
         hHJplN7kk6yx3jZH7mCv9CrRMf1f/UQE38ZE8+IuMGjPipmqSE1Hbmigz+HLsv2otACp
         YwgMxrOJJXkFgujHTPrq/Gd0DFRWCmGrOhhJB+7N3npGUNUT0e6w2AWUQOH4WvW94Ksr
         kNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716969958; x=1717574758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5XpAlzs8/5dy/UfJxZhXqs4EkV35bosYx2T12GiUv4=;
        b=cKJtLWD2eMcAkNhCndHmc3zFlhVej8XyKzWZXtKwPDeRem9Nb637JIZ3N/LAx8ydes
         4iAOOAmJO7J+fVUMONDcPgtagKp3sBoFUNCJVU0ELYT0FhviAJ0QyBidSoIXU9T19h3g
         230lQhROIVUkXze/H/hzIYpUOHI/7O1daLyvjlh+s5kgJNyGcvzjAtRvJtT/juyXZme8
         cfrN6idHcvadNGTf1fqC822i/MLouuN9xYl+253Rs1Lx8yuJHDU0dZ/n5P3/BgArEU2T
         8Jc6c4HTVbOIcofabvY0y+VoPefmaq4Of+nKDthhbrQFfjCtuhyOw2BhhM+r4VpfcrR/
         zOnw==
X-Forwarded-Encrypted: i=1; AJvYcCUZtqa8O5+w44zBRaq99EafsbCsSejF7x5pJkdLpYPLpTApntnMMppluzxEvHRq0MGTngu0Y7Dl5T6dPHqEHYG0HeNn84Rf77BD+rCh
X-Gm-Message-State: AOJu0YzQi/Y68Wz+LDypvIGjm3FYfnko9I+jxaBbdBtpa0EMBWjcAzG0
	6x79W/32LHL3/MQPKE962w5rn/tZd+ibf1BqKf8jpIsm3GRDD5kjvsQ1COIkbpo=
X-Google-Smtp-Source: AGHT+IEWL+ZvoWTTto3nvB8MwaNuX1ufrqSVnU1SJZSJmLczqxuu5qf+e7ikQWSXZHaCbOMhNsFeCQ==
X-Received: by 2002:adf:f1c9:0:b0:351:c934:e9e6 with SMTP id ffacd0b85a97d-3552fdfa7a8mr9781890f8f.64.1716969958385;
        Wed, 29 May 2024 01:05:58 -0700 (PDT)
Received: from localhost.localdomain (62.83.84.125.dyn.user.ono.com. [62.83.84.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a0908e4sm14132958f8f.63.2024.05.29.01.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:05:58 -0700 (PDT)
From: Oscar Salvador <osalvador@suse.com>
X-Google-Original-From: Oscar Salvador <osalvador@suse.de>
Date: Wed, 29 May 2024 10:05:56 +0200
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v4 12/16] powerpc/e500: Encode hugepage size in PTE
 bits
Message-ID: <Zlbh5Bwsx7WqEEWr@localhost.localdomain>
References: <cover.1716815901.git.christophe.leroy@csgroup.eu>
 <10eae3c6815e3aba5f624af92321948e4684c95a.1716815901.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10eae3c6815e3aba5f624af92321948e4684c95a.1716815901.git.christophe.leroy@csgroup.eu>

On Mon, May 27, 2024 at 03:30:10PM +0200, Christophe Leroy wrote:
> Use U0-U3 bits to encode hugepage size, more exactly page shift.
> 
> As we start using hugepages at shift 21 (2Mbytes), substract 20
> so that it fits into 4 bits. That may change in the future if
> we want to use smaller hugepages.

What other shifts we can have here on e500? PUD_SHIFT?
Could you please spell them out here?
Or even better,

> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/nohash/hugetlb-e500.h | 6 ++++++
>  arch/powerpc/include/asm/nohash/pte-e500.h     | 3 +++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/nohash/hugetlb-e500.h b/arch/powerpc/include/asm/nohash/hugetlb-e500.h
> index 8f04ad20e040..d8e51a3f8557 100644
> --- a/arch/powerpc/include/asm/nohash/hugetlb-e500.h
> +++ b/arch/powerpc/include/asm/nohash/hugetlb-e500.h
> @@ -42,4 +42,10 @@ static inline int check_and_get_huge_psize(int shift)
>  	return shift_to_mmu_psize(shift);
>  }
>  
> +static inline pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
> +{
> +	return __pte(pte_val(entry) | (_PAGE_U3 * (shift - 20)));
> +}
> +#define arch_make_huge_pte arch_make_huge_pte
> +
>  #endif /* _ASM_POWERPC_NOHASH_HUGETLB_E500_H */
> diff --git a/arch/powerpc/include/asm/nohash/pte-e500.h b/arch/powerpc/include/asm/nohash/pte-e500.h
> index 975facc7e38e..091e4bff1fba 100644
> --- a/arch/powerpc/include/asm/nohash/pte-e500.h
> +++ b/arch/powerpc/include/asm/nohash/pte-e500.h
> @@ -46,6 +46,9 @@
>  #define _PAGE_NO_CACHE	0x400000 /* I: cache inhibit */
>  #define _PAGE_WRITETHRU	0x800000 /* W: cache write-through */
> +#define _PAGE_HSIZE_MSK (_PAGE_U0 | _PAGE_U1 | _PAGE_U2 | _PAGE_U3)
> +#define _PAGE_HSIZE_SHIFT	14

Add a comment in above explaining which P*_SHIFT we need cover with these
4bits.

 

-- 
Oscar Salvador
SUSE Labs

