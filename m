Return-Path: <linux-kernel+bounces-281308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B5794D55B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4DD91C20EFC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2203B4AEDA;
	Fri,  9 Aug 2024 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qwv4A3nl"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA798210EE
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 17:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224242; cv=none; b=IEUbbS62Uyw4gdU3W9IgW9k+nu3+7U+Sd/yZkjNvQUL52hhsOA02NDp8+j45S3fX77lfz4jkqtr2KuVZOJqJ22eLhLV5kLOB47b9xNhNZ1LcVgP2XRUCJxZdwIN+7WcUYO0M0t8UfQte8XsDOGnRhbT9mCO5KAFMDtvKOWIiDzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224242; c=relaxed/simple;
	bh=U79tLyON/wgpPV2sORNRCWw4Qth2wqbqkWm0MKGXRQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxoHKG1nBkRmGcNtWdaV5vClhR9eI7fLCeMR1AH6tHuOpZe28PHtLV3/Z3nbL1ea+hqJGrC73CXtFJ3hjepjS7sRhAcIGtFOgLfBQ8tb6KaVOygQtLVtDCSY1UOlZicGk1Um1WMquexGLMBCgKDdsJHXjaWB8sK0ac4/lwPtcIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qwv4A3nl; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-36bb2047bf4so1486162f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 10:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723224239; x=1723829039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QdjlOHuBnkWT9u/9CGI9uaBMM/Qi29TBnTB7AP5Y7M=;
        b=qwv4A3nlUQvK0itivuk/DGYak6pyIzD/uhRLfoqU1RBLYzF2k6bha39TYNijg1d0OJ
         6EjK4amSE0Ey3w260FAC7ZJYBGSfmUuokEmbXUY6VaJQYCd5O1NAwfAuz6Hi1QaYi828
         obj5tkVWuhTo84yUQkxCXPkEUyp5/mKVKwZ8S+zZR8HYa++E/sdIYvJ/YLsi/c6fOM7X
         b1SG2EqMX3zKcrUlrt1W0RQRxSkVqRicxS6FaIzC6qV+jjyDLLCaEfkjLcaZ0ih/ro/f
         3DpDQqYki4OIIe5/PBaCqGgeMB7wtDa+SYN4+8TsF1e3VdOSqnTdH2i7erO/GMdT33u2
         bamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723224239; x=1723829039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QdjlOHuBnkWT9u/9CGI9uaBMM/Qi29TBnTB7AP5Y7M=;
        b=vWZE6QkOodV6ht4jnoL10xOSa409isMlCfnGU4UsUkz+b6tfb+f+ae10aIrZWHSJRx
         GSdu3mLQWCI9bcxusMeSLJ/9jPIiNqJ1Cw9ZbXJW23xDYqnPBoBsl5lwqlIwsR+AKUjP
         6IPYrEekIK1wy9sybrG+Vl2uoryysVEhrXfoE4m7L9Fkshn35ZmN65VnRo6TXbM7GXtx
         uf9rOYj+QF+8T8mSij9Ca9kHwrQJHxnILBTIioTcWA9J1kn3bYsGPEHVWH0RTgp5umj9
         vAvpJUoivEedhRSb5iko0PwgwHdW9Vd4jLzYFkUS+TNFp2SSXmyFUxpAg8ke0dH1c3Zj
         wclQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoZvuyWX55mBcRhK1h8DON3VIGmbXFWJ0T/IKuy9BPkTIOMKPbCXw/9KecCq8UZC7bfx3obKMZ2kdlWaX1TMN2H4VDEsKNmKPZ7cAb
X-Gm-Message-State: AOJu0YzwOVNwcRQy3mHp8a+e7VCcsMQdFaJKYKOM0IfunQrPldy6Wzvj
	R7AE6XEx9IGhp8LXWikazriFwPIXxJ3i63BEP5ZH4/FWmLqTbS3jfCSHIQJXFfBsuQolCrUxQxO
	fpZBhnzCaNk525f7i2A9Y5XHXYbzst4nFTs+SvTZ6fcDTXNSVrA==
X-Google-Smtp-Source: AGHT+IGV1vzsTB3E9qHHAZ2PxwMColOAwLwBW9dzPhmi0xSxisZYI7WVPSVv2jYwNAL5k0yIXCNHSXuqEEMn/3swSXc=
X-Received: by 2002:a05:6000:d04:b0:365:f52f:cd44 with SMTP id
 ffacd0b85a97d-36d61cd2059mr1603070f8f.57.1723224238792; Fri, 09 Aug 2024
 10:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809160909.1023470-1-peterx@redhat.com> <20240809160909.1023470-11-peterx@redhat.com>
In-Reply-To: <20240809160909.1023470-11-peterx@redhat.com>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Fri, 9 Aug 2024 10:23:20 -0700
Message-ID: <CAJHvVciF4riGPQBhyBwNeSWHq8m+7Zag7ewEWgLJk=VsaqKNPQ@mail.gmail.com>
Subject: Re: [PATCH 10/19] KVM: Use follow_pfnmap API
To: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Oscar Salvador <osalvador@suse.de>, Jason Gunthorpe <jgg@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, 
	Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Alistair Popple <apopple@nvidia.com>, Borislav Petkov <bp@alien8.de>, David Hildenbrand <david@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 9:09=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> Use the new pfnmap API to allow huge MMIO mappings for VMs.  The rest wor=
k
> is done perfectly on the other side (host_pfn_mapping_level()).

I don't think it has to be done in this series, but a future
optimization to consider is having follow_pfnmap just tell the caller
about the mapping level directly. It already found this information as
part of its walk. I think there's a possibility to simplify KVM /
avoid it having to do its own walk again later.

>
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  virt/kvm/kvm_main.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index d0788d0a72cc..9fb1c527a8e1 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2862,13 +2862,11 @@ static int hva_to_pfn_remapped(struct vm_area_str=
uct *vma,
>                                unsigned long addr, bool write_fault,
>                                bool *writable, kvm_pfn_t *p_pfn)
>  {
> +       struct follow_pfnmap_args args =3D { .vma =3D vma, .address =3D a=
ddr };
>         kvm_pfn_t pfn;
> -       pte_t *ptep;
> -       pte_t pte;
> -       spinlock_t *ptl;
>         int r;
>
> -       r =3D follow_pte(vma, addr, &ptep, &ptl);
> +       r =3D follow_pfnmap_start(&args);
>         if (r) {
>                 /*
>                  * get_user_pages fails for VM_IO and VM_PFNMAP vmas and =
does
> @@ -2883,21 +2881,19 @@ static int hva_to_pfn_remapped(struct vm_area_str=
uct *vma,
>                 if (r)
>                         return r;
>
> -               r =3D follow_pte(vma, addr, &ptep, &ptl);
> +               r =3D follow_pfnmap_start(&args);
>                 if (r)
>                         return r;
>         }
>
> -       pte =3D ptep_get(ptep);
> -
> -       if (write_fault && !pte_write(pte)) {
> +       if (write_fault && !args.writable) {
>                 pfn =3D KVM_PFN_ERR_RO_FAULT;
>                 goto out;
>         }
>
>         if (writable)
> -               *writable =3D pte_write(pte);
> -       pfn =3D pte_pfn(pte);
> +               *writable =3D args.writable;
> +       pfn =3D args.pfn;
>
>         /*
>          * Get a reference here because callers of *hva_to_pfn* and
> @@ -2918,9 +2914,8 @@ static int hva_to_pfn_remapped(struct vm_area_struc=
t *vma,
>          */
>         if (!kvm_try_get_pfn(pfn))
>                 r =3D -EFAULT;
> -
>  out:
> -       pte_unmap_unlock(ptep, ptl);
> +       follow_pfnmap_end(&args);
>         *p_pfn =3D pfn;
>
>         return r;
> --
> 2.45.0
>

