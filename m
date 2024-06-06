Return-Path: <linux-kernel+bounces-204663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 974A08FF1EE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826491C24E32
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5FC19AA54;
	Thu,  6 Jun 2024 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZsH5F47"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3862819A2AE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690270; cv=none; b=E3I1g+KqFJwVEKPKzXOq5kaOtTMRlarebVQaDfDjkqLio/b9UuTh8cNaguG89JuaolbAK29M8P+nN0FOFIt5JF7KM/q3Gmd9F30iOfv8/hLilD07chVKmM1AbbpG7Zes+M1wmJWbxDm8+ALA1loFKDr28QUAVK+T4EpqWw9sGzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690270; c=relaxed/simple;
	bh=C6xOxQ9P1I2nAifuPJPu4NYJEtpJMNEvDpiLCEcU+FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hd56cW44Iqt2s6uyeTPC71a84vqDUcJkXOpQuMxoca62ZAbEYSMhMMSeZ9Rp08HE3l+WsDkF1Lzfk3oyb9Oqja5Po/aGNJ5q5M2bcPo0qGaoFz2US6TjV2gaxbxSPv1/FRIgJAD4vhRlaLNKfXLnjfV7KQVB1zdK7fEOpID2yiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GZsH5F47; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717690267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bMxHuzTNqwoExnxxNXUTJ+We8jv8Inb+JPwzg5VCJYY=;
	b=GZsH5F47oDtmiJr1IQIQWRPvvttvvqXZOiqblioOtSwiyk8zkW5Ow0Bk17BbDESS1Cjthf
	AetgSEULhMbAXMBTcdpmAwPe+yU7MZLFkNSi1EgYdBOX+Jzo6Zb+5XPFVk1eIgr+lccPBS
	95541d91HSOfxKYbyDxgrOda9Hk/+es=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-MXMRIsdiNpOUl2O-yQ1tVQ-1; Thu, 06 Jun 2024 12:11:03 -0400
X-MC-Unique: MXMRIsdiNpOUl2O-yQ1tVQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35e5b42c85fso782761f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 09:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717690261; x=1718295061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMxHuzTNqwoExnxxNXUTJ+We8jv8Inb+JPwzg5VCJYY=;
        b=G/1rMg9hUvh56ebUjH+u4DY87cN/9Zb/2EV0Z9L7PP8SblJxbtsXD+MwLCwb8EFrCI
         SERL3Mt+QtTgCOJD/twCdt9SoqbXlB0s4tx/tf/AxRv+nCljjmTY3OyH+KZf3ELBJlzR
         7xi4slG6X/crKioDxKSLp4ahcbi2k+h+H3D7FbCerwgGxKdjZphAUIUdTFCH4kEHY6yl
         J6I1q4C0rDqS79CsSCudq8d9R3YlUmDcnxG4DrtwdhVo2MHmOQ6qoO2tkQk+sUYAnaF3
         J3+TCEMUOqy7ai7V+h8KICQwdQZ+umFoCsyKhv5WjEwH7Hk0hZ+I+w+OWT1rW8+8pqo2
         PNHA==
X-Forwarded-Encrypted: i=1; AJvYcCUywnkVcS/WWbieRAnaEsS9vc9kD1oY46SYQJaXoPBmEx0tIbfbV5skr9baRn8n8ji45AHc5oUgG48UiqEDAfdVvFjGvMehlXhDJneb
X-Gm-Message-State: AOJu0YxJHN6gPGFgwec3lHcpfRIU8EIQBTdnccv0hRFfLGDhHVYANpmR
	PiTXZctsBelKwyy81TN9tRbq2y1Vz4PmgCHRrbSvfYxy54DtvJ+95CRLTFNJVPUA7WvIzF7bClj
	4msc/F76j769cYUpAnWvNkG7EnrOukawz5FFvyoU8x4Jea441B2XmC4PZG6+NLCdovvC4R5gJW5
	WivmcptB7+8pLbVbGiJJ0fReSu0Nj+JcJnYflB
X-Received: by 2002:a5d:4a10:0:b0:35e:f25f:6c9 with SMTP id ffacd0b85a97d-35efea7e179mr96641f8f.0.1717690261395;
        Thu, 06 Jun 2024 09:11:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1Es/YGWhv/S13Xa529CXDzdBf9/542vQsdMCXTwyiGCXBRAw5/xXSrsUeTWLoCWoMiQ8MJfY8HjgEvFhux/g=
X-Received: by 2002:a5d:4a10:0:b0:35e:f25f:6c9 with SMTP id
 ffacd0b85a97d-35efea7e179mr96619f8f.0.1717690261123; Thu, 06 Jun 2024
 09:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530210714.364118-1-rick.p.edgecombe@intel.com> <20240530210714.364118-6-rick.p.edgecombe@intel.com>
In-Reply-To: <20240530210714.364118-6-rick.p.edgecombe@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 6 Jun 2024 18:10:49 +0200
Message-ID: <CABgObfYgF9gcokAg2gOjXqfuxj_oDBmEu4HfDaRc0CLSkmWhoA@mail.gmail.com>
Subject: Re: [PATCH v2 05/15] KVM: x86/mmu: Make kvm_tdp_mmu_alloc_root()
 return void
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: seanjc@google.com, kvm@vger.kernel.org, kai.huang@intel.com, 
	dmatlack@google.com, erdemaktas@google.com, isaku.yamahata@gmail.com, 
	linux-kernel@vger.kernel.org, sagis@google.com, yan.y.zhao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 11:07=E2=80=AFPM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
> The kvm_tdp_mmu_alloc_root() function currently always returns 0. This
> allows for the caller, mmu_alloc_direct_roots(), to call
> kvm_tdp_mmu_alloc_root() and also return 0 in one line:
>    return kvm_tdp_mmu_alloc_root(vcpu);
>
> So it is useful even though the return value of kvm_tdp_mmu_alloc_root()
> is always the same. However, in future changes, kvm_tdp_mmu_alloc_root()
> will be called twice in mmu_alloc_direct_roots(). This will force the
> first call to either awkwardly handle the return value that will always
> be zero or ignore it. So change kvm_tdp_mmu_alloc_root() to return void.
> Do it in a separate change so the future change will be cleaner.
>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

> ---
> TDX MMU Prep:
>  - New patch
> ---
>  arch/x86/kvm/mmu/mmu.c     | 6 ++++--
>  arch/x86/kvm/mmu/tdp_mmu.c | 3 +--
>  arch/x86/kvm/mmu/tdp_mmu.h | 2 +-
>  3 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 5070ba7c6e89..12178945922f 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3700,8 +3700,10 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu =
*vcpu)
>         unsigned i;
>         int r;
>
> -       if (tdp_mmu_enabled)
> -               return kvm_tdp_mmu_alloc_root(vcpu);
> +       if (tdp_mmu_enabled) {
> +               kvm_tdp_mmu_alloc_root(vcpu);
> +               return 0;
> +       }
>
>         write_lock(&vcpu->kvm->mmu_lock);
>         r =3D make_mmu_pages_available(vcpu);
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index e7cd4921afe7..2770230a5636 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -224,7 +224,7 @@ static void tdp_mmu_init_child_sp(struct kvm_mmu_page=
 *child_sp,
>         tdp_mmu_init_sp(child_sp, iter->sptep, iter->gfn, role);
>  }
>
> -int kvm_tdp_mmu_alloc_root(struct kvm_vcpu *vcpu)
> +void kvm_tdp_mmu_alloc_root(struct kvm_vcpu *vcpu)
>  {
>         struct kvm_mmu *mmu =3D vcpu->arch.mmu;
>         union kvm_mmu_page_role role =3D mmu->root_role;
> @@ -285,7 +285,6 @@ int kvm_tdp_mmu_alloc_root(struct kvm_vcpu *vcpu)
>          */
>         mmu->root.hpa =3D __pa(root->spt);
>         mmu->root.pgd =3D 0;
> -       return 0;
>  }
>
>  static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
> index 58b55e61bd33..437ddd4937a9 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.h
> +++ b/arch/x86/kvm/mmu/tdp_mmu.h
> @@ -10,7 +10,7 @@
>  void kvm_mmu_init_tdp_mmu(struct kvm *kvm);
>  void kvm_mmu_uninit_tdp_mmu(struct kvm *kvm);
>
> -int kvm_tdp_mmu_alloc_root(struct kvm_vcpu *vcpu);
> +void kvm_tdp_mmu_alloc_root(struct kvm_vcpu *vcpu);
>
>  __must_check static inline bool kvm_tdp_mmu_get_root(struct kvm_mmu_page=
 *root)
>  {
> --
> 2.34.1
>


