Return-Path: <linux-kernel+bounces-205631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 223AC8FFE4B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BDAE1F275D1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9A115B14E;
	Fri,  7 Jun 2024 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SU8dgZ01"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F3C405F8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749998; cv=none; b=CYyTUZek76h+oXFi8YZ+zhJIccpEbYb+uOYYxTz0mIqfwbGvjiyjU2rnKx17Np5rjswJQ1hscuBRTnHxwAOV++omHpJqgKbxFaEhoOxUY8LYuddUtpaqurhj09A9nbzzvOC3LQnRgpv3dGPHgalqJ08mztnAL3lWL6xxYI24Ewc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749998; c=relaxed/simple;
	bh=2Wa8WJN+LkbpX5rIrmW7DojlEn69aWowv37cc5RuTJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTZlNBJeA6HHWdO+7m+n2EsIuEdzusUrGp5p+5GP5x0dmbwnav5sAQaDteqRPR48puWlAWjbFu2JpCy7LAnh1fislh5gcpGqHLPCSqjFMqTI+X4ujxZk4i1Fy147T4VI2LpXTcNiHbZLsqkeWiAGWpy3AGDV2CnBxzxtygoEtH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SU8dgZ01; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717749995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pHc7ht3SZXEa6o5dCgAIwUAQvCXAypKl+sYnw9GSGFg=;
	b=SU8dgZ01aGw2km91ot3aIqA8QeD+nZlsAl0xGU/PMJgJcY0b/n3t1jJnGuLDWuM0uqMqEZ
	pdEHcoI6epWPmKxuRG4wvoSg3gtB7/qtX5fNpHLhCOSlqCBIdB0eL+mUYsfkjiV7V/xMuV
	7Zi9ofTvVvx0z+vHAgCMwqp99sIQMbM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519--r8-GXrAO72qig3MfoYghg-1; Fri, 07 Jun 2024 04:46:29 -0400
X-MC-Unique: -r8-GXrAO72qig3MfoYghg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52bbe6a1c80so295202e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 01:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717749988; x=1718354788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHc7ht3SZXEa6o5dCgAIwUAQvCXAypKl+sYnw9GSGFg=;
        b=aw1zMe/kwqZqSAr6WeoT0auGyvPrALiscfJOAwBpCYRqpGJukU2c+7xTtcPIEz4O9K
         4L9+5uIIZk2ra9oJs8ABkEakEZ7sHkqal6UPRuC02wb6jYwIPUTtW9iuLOngB0d0IIFN
         dEkbf0Yj0ArpTSZjgRlSJCLX9UPT9uPgGnNBiman0iy0IOVBt7lUV04CbdKAUZJBBCOo
         Ao+4KWBOmARCZfZsM2xx+KbZjAL+dcaXbUY6kccnKwD57S3EAhRIHQPIu+IlUbTx2S1g
         1rg5z332Mxn/VbKB/w16aTPEzE4fFWXy2z4s2x4uMl3F/tW8iwk2FSO8oJahAPGZFOMI
         ffOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpcpR4Kn5+hTUuIg5Z48EBCmNlSroyaMrxxZrX8PN/JGEQsL9RUQ7l4oaCmz+hnKzhM6sZkaq8Zxryc6mooulobXdm14hsZMEGXsa3
X-Gm-Message-State: AOJu0YzDPCRlqgEnX/7McSawy4eJyIfVpz6rSba2whI6umRJQ9PimxF+
	lOStagMHf6M93y/gRZChn6suY6Vj0FSS+M3KDF4IPYlrHPAM/AlgJmZX1hAAQMuZAS7Z9n2b1Rf
	4fzIGJyHXNe9zv46UErCwkE7BULBoYNieYrRjhGDwNQQNbcNK5uUgjkALC8BMKOzG9ClfUaGQAZ
	8AdgVQ6y4gm/M3F8W61LRc9HZbSOLb2QkKfeSp
X-Received: by 2002:a05:6512:484f:b0:518:c69b:3a04 with SMTP id 2adb3069b0e04-52bb9f17544mr1580693e87.0.1717749988141;
        Fri, 07 Jun 2024 01:46:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/RUpTs7PSC3j3HsAZ81KZAsJhPLtVSgMtkMt2HZENken/B/jFKI6iqgyxSHoSLGc1sRRr8s9LzxGLTffk/Ic=
X-Received: by 2002:a05:6512:484f:b0:518:c69b:3a04 with SMTP id
 2adb3069b0e04-52bb9f17544mr1580678e87.0.1717749987705; Fri, 07 Jun 2024
 01:46:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530210714.364118-1-rick.p.edgecombe@intel.com> <20240530210714.364118-10-rick.p.edgecombe@intel.com>
In-Reply-To: <20240530210714.364118-10-rick.p.edgecombe@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 7 Jun 2024 10:46:15 +0200
Message-ID: <CABgObfbzjLtzFX9wC_FU2GKGF_Wq8og+O=pSnG_yD8j1Dn3jAg@mail.gmail.com>
Subject: Re: [PATCH v2 09/15] KVM: x86/tdp_mmu: Support mirror root for TDP MMU
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: seanjc@google.com, kvm@vger.kernel.org, kai.huang@intel.com, 
	dmatlack@google.com, erdemaktas@google.com, isaku.yamahata@gmail.com, 
	linux-kernel@vger.kernel.org, sagis@google.com, yan.y.zhao@intel.com, 
	Isaku Yamahata <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 11:07=E2=80=AFPM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
> +static inline bool kvm_on_mirror(const struct kvm *kvm, enum kvm_process=
 process)
> +{
> +       if (!kvm_has_mirrored_tdp(kvm))
> +               return false;
> +
> +       return process & KVM_PROCESS_PRIVATE;
> +}
> +
> +static inline bool kvm_on_direct(const struct kvm *kvm, enum kvm_process=
 process)
> +{
> +       if (!kvm_has_mirrored_tdp(kvm))
> +               return true;
> +
> +       return process & KVM_PROCESS_SHARED;
> +}

These helpers don't add much, it's easier to just write
kvm_process_to_root_types() as

if (process & KVM_PROCESS_SHARED)
  ret |=3D KVM_DIRECT_ROOTS;
if (process & KVM_PROCESS_PRIVATE)
  ret |=3D kvm_has_mirror_tdp(kvm) ? KVM_MIRROR_ROOTS : KVM_DIRECT_ROOTS;

WARN_ON_ONCE(!ret);
return ret;

(Here I chose to rename kvm_has_mirrored_tdp to kvm_has_mirror_tdp;
but if you prefer to call it kvm_has_external_tdp, it's just as
readable. Whatever floats your boat).

>         struct kvm *kvm =3D vcpu->kvm;
> -       struct kvm_mmu_page *root =3D root_to_sp(vcpu->arch.mmu->root.hpa=
);
> +       enum kvm_tdp_mmu_root_types root_type =3D tdp_mmu_get_fault_root_=
type(kvm, fault);
> +       struct kvm_mmu_page *root =3D tdp_mmu_get_root(vcpu, root_type);

Please make this

  struct kvm_mmu_page *root =3D tdp_mmu_get_root_for_fault(vcpu, fault);

Most other uses of tdp_mmu_get_root() don't really need a root_type,
I'll get to them in the reviews for the rest of the series.

>  enum kvm_tdp_mmu_root_types {
>         KVM_VALID_ROOTS =3D BIT(0),
> +       KVM_DIRECT_ROOTS =3D BIT(1),
> +       KVM_MIRROR_ROOTS =3D BIT(2),
>
> -       KVM_ANY_ROOTS =3D 0,
> -       KVM_ANY_VALID_ROOTS =3D KVM_VALID_ROOTS,
> +       KVM_ANY_ROOTS =3D KVM_DIRECT_ROOTS | KVM_MIRROR_ROOTS,
> +       KVM_ANY_VALID_ROOTS =3D KVM_DIRECT_ROOTS | KVM_MIRROR_ROOTS | KVM=
_VALID_ROOTS,

See previous review.

> +static inline enum kvm_tdp_mmu_root_types tdp_mmu_get_fault_root_type(st=
ruct kvm *kvm,
> +                                                                     str=
uct kvm_page_fault *fault)
> +{
> +       if (fault->is_private)
> +               return kvm_process_to_root_types(kvm, KVM_PROCESS_PRIVATE=
);
> +       return KVM_DIRECT_ROOTS;
> +}
> +
> +static inline struct kvm_mmu_page *tdp_mmu_get_root(struct kvm_vcpu *vcp=
u, enum kvm_tdp_mmu_root_types type)
> +{
> +       if (type =3D=3D KVM_MIRROR_ROOTS)
> +               return root_to_sp(vcpu->arch.mmu->mirror_root_hpa);
> +       return root_to_sp(vcpu->arch.mmu->root.hpa);
> +}

static inline struct kvm_mmu_page *
tdp_mmu_get_root_for_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fa=
ult)
{
  hpa_t root_hpa;
  if (unlikely(fault->is_private && kvm_has_mirror_tdp(kvm)))
    root_hpa =3D vcpu->arch.mmu->mirror_root_hpa;
  else
    root_hpa =3D vcpu->arch.mmu->root.hpa;
  return root_to_sp(root_hpa);
}

Paolo


