Return-Path: <linux-kernel+bounces-271727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9C49452A3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 303A1286BD5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7A01474CC;
	Thu,  1 Aug 2024 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxBH2q8n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AD61482E2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722536143; cv=none; b=aNp2Ocbln4/9Jt+snll+ellTsSz6+hv7gSQ5oBuF4wDZook4WjohiWfqUCRl4L2ULtNf5YHSOY/+Xt3LVvkRFaX33VwNl3mFm4scAYCnM2JrExXHPre5J9kZgSpJHMgk8orJLYjSMNdRX7nskJxB1Z0NljYdSmRs4Vczxp1Mzn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722536143; c=relaxed/simple;
	bh=SUfyZKUo0IFCp9KDhlQwd3l6b/z5WFA0jaDZUeAQ/tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urcroPmlQV3zrUrEwB2XkPe8MVQ+mDFzLw/pjFCVILcBZeeum7durcK5DbGM2GIqxILLKGp5BXc0eFHlHSVVSKSnaEGdCcvOg3IbgxBpTqd+sED+BXVJGNI03zMuZX2CiukTLhwc8AROnendzxA+kQCIsct3hnfdCVtxOVzHMEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VxBH2q8n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722536139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UaZOROEvjpdbqu1dopLC2Lkrj6Dr9/VPZUA+DhTI8M4=;
	b=VxBH2q8nYTHs4Z8BI7582eeX7CddIaIke5fISUef+EdHtrENSkU3KWU5oE4vvQVlipFF/7
	sd2NCuWitQHcyml4jd/Fnmty5eF9GvOK/B+3DapKeEV8QGUftKP6V8hdjX67UvgepbsAD5
	EEvpaSrTznYKkg16C8dC+D4JZ27VtBY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-rHvRRMbqMTSErsiMjUp96Q-1; Thu, 01 Aug 2024 14:15:37 -0400
X-MC-Unique: rHvRRMbqMTSErsiMjUp96Q-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52f00bde210so8080681e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 11:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722536135; x=1723140935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UaZOROEvjpdbqu1dopLC2Lkrj6Dr9/VPZUA+DhTI8M4=;
        b=JX3Sg9EaR1ML8M9G3AspuP1j5hrbHhTV2l6/OFw5OqUG1mcKFTcwr6DMbizAPD6EC2
         TPpye8bJEiel7JPkoS0jDEw9s/pky7DRubAO943C0rn+t1YQovmCyeff99v3y/0B6ZV1
         NxsMI79GxUEDVYfzaOhEx22JmuPQB1nPLmP8GHWieYx1ynMvoOBMO5DFeaye0hgeVh3q
         fbrKWDExeJ0b92vBOGV7BPOFzEN7rEmSnvTzyJS3Ozytc86NElpN9IjhmFfloGzbOED2
         TmEi2BaTjPTCCKaSSICI2baa2VFqNzSTioz+psu+EtHXorEOPW5DxbUwcKYaH+SbKMWX
         iknw==
X-Forwarded-Encrypted: i=1; AJvYcCVwHelee/wH42Qyqqlc4x6MaxZzw8r25ejUhEDte/1aBSs75nbfaaTHrCVRZG7QxmmHbtMegAAgGuHLVOtopLilowGUxSuoNhoRKyXP
X-Gm-Message-State: AOJu0YxmoDNxDxRY8bu+QcGHB5zuQ0bRVuUq5+cnRrzU1lmGNpf+8GXt
	GBTDHGBaa3N7vOI+9RLl9HEEY/THhjwLuYaulu6MDSOSf4wYvB7/GA6LHsWWQ5jSKscspphoHeX
	0W2vvwSQhaeH+ULORCbuJfbkPCVORRdHV062Z+0drpWHTYbK8cs2ExbODY6gbTsHXt+wF7LYfML
	tlHzC5bW3NKkJAjWTK0wd/m2W4WBor4jvKPFoF
X-Received: by 2002:a2e:874b:0:b0:2ef:29b7:18a7 with SMTP id 38308e7fff4ca-2f15ab0c224mr8026821fa.37.1722536134879;
        Thu, 01 Aug 2024 11:15:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW/QthBnS2n2JpnEiBTz7UDN3Rn0ZpSHt4zKv0qUnmJfmwCaik8m91bLxVWR1bJoJl2RmwJ89dnkiDtZdyq7c=
X-Received: by 2002:a2e:874b:0:b0:2ef:29b7:18a7 with SMTP id
 38308e7fff4ca-2f15ab0c224mr8026601fa.37.1722536134319; Thu, 01 Aug 2024
 11:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501085210.2213060-3-michael.roth@amd.com> <20240801173955.1975034-1-ackerleytng@google.com>
In-Reply-To: <20240801173955.1975034-1-ackerleytng@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 1 Aug 2024 20:15:22 +0200
Message-ID: <CABgObfZbS7LsKM_w2ZSpb82oBAHF=pJfVJ+45k7=vVVWHK5Y6A@mail.gmail.com>
Subject: Re: [PATCH] Fixes: f32fb32820b1 ("KVM: x86: Add hook for determining
 max NPT mapping level")
To: Ackerley Tng <ackerleytng@google.com>
Cc: michael.roth@amd.com, ak@linux.intel.com, alpergun@google.com, 
	ardb@kernel.org, ashish.kalra@amd.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, dovmurik@linux.ibm.com, hpa@zytor.com, 
	jarkko@kernel.org, jmattson@google.com, vannapurve@google.com, 
	erdemaktas@google.com, jroedel@suse.de, kirill@shutemov.name, 
	kvm@vger.kernel.org, liam.merwick@oracle.com, linux-coco@lists.linux.dev, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, luto@kernel.org, mingo@redhat.com, 
	nikunj.dadhania@amd.com, pankaj.gupta@amd.com, peterz@infradead.org, 
	pgonda@google.com, rientjes@google.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com, slp@redhat.com, 
	srinivas.pandruvada@linux.intel.com, tglx@linutronix.de, 
	thomas.lendacky@amd.com, tobin@ibm.com, tony.luck@intel.com, vbabka@suse.cz, 
	vkuznets@redhat.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 7:40=E2=80=AFPM Ackerley Tng <ackerleytng@google.com=
> wrote:
>
> The `if (req_max_level)` test was meant ignore req_max_level if
> PG_LEVEL_NONE was returned. Hence, this function should return
> max_level instead of the ignored req_max_level.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Change-Id: I403898aacc379ed98ba5caa41c9f1c52f277adc2

It's worth pointing out that this is only a latent issue for now,
since guest_memfd does not support large pages ( __kvm_gmem_get_pfn
always returns 0).

Queued with a small note in the commit message and fixed subject.

Thanks,

Paolo


> ---
>  arch/x86/kvm/mmu/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 901be9e420a4..e6b73774645d 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4335,7 +4335,7 @@ static u8 kvm_max_private_mapping_level(struct kvm =
*kvm, kvm_pfn_t pfn,
>         if (req_max_level)
>                 max_level =3D min(max_level, req_max_level);
>
> -       return req_max_level;
> +       return max_level;
>  }
>
>  static int kvm_faultin_pfn_private(struct kvm_vcpu *vcpu,
> --
> 2.46.0.rc2.264.g509ed76dc8-goog
>


