Return-Path: <linux-kernel+bounces-205587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29ED48FFDD4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC0128AE89
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A941115ADA4;
	Fri,  7 Jun 2024 08:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgfEXFYY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929AA1C2AF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 08:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717747846; cv=none; b=X6ghRabEUjvuGlXDbKZIPlypWbaXaHx8dJw1v/mi/f4pVn9zKjsNU33qKcFkmvTSN1vGCzl0b/sNG40mJ0DDv/I5j5Toei6gj6OsMTkKNzhTAsEzoEpeVtkDr7CLKH0mBwUkhJZn58XW4iM0pdIRsgSeV68Yjt7/THwXIRDpmnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717747846; c=relaxed/simple;
	bh=xan89PWRu7zP6FjR4igFX3BzW5xabnOUhXxUie21/G8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dR91VtuKIeYDXeP/6Rw4kg6WzrXXUgueplzkVO2V1CJ4EFD08rSOuEKJkEZsHHe6wlC4qS9EBKmf5UhzPnpAXQJ4aX4pOJaM/4WwiChFSHDdLLl0EK4meFLLA1YP7IpT9xla+RH6fhl9jwF/NCN39H60iXPlqG27AXREnVHZIuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dgfEXFYY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717747843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IpzQWE3Fx+gen53+97uqx2lsnAb/FfxkaVcs1hIq2p0=;
	b=dgfEXFYYHTz5bUTOIPSvE8OCEc44NwjFXo4LEcxFSenfMSMx4jaD7hSRWon5PFjdSaBjhl
	D8kHam+mcE5j3GQ080VkIwm/fbd8NReWM9qxV22zLBhmG3uCWdojzvcQbekzyknaHXAmLh
	iNVMXA2bjzlYwyf2AM9thZfmbhGNxwk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-zpq3coNXOVSfH-73SqPnGA-1; Fri, 07 Jun 2024 04:10:41 -0400
X-MC-Unique: zpq3coNXOVSfH-73SqPnGA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52bc1e919deso55686e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 01:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717747840; x=1718352640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpzQWE3Fx+gen53+97uqx2lsnAb/FfxkaVcs1hIq2p0=;
        b=mc7tTGEoL92vNNMicrXxsBmGaufMhAib+H3upbgsUbDDnb4dp4ckMo8L+H4r8ZQzHI
         r6Tp0p2usG+79dcCVHqIU8Owv4DdO/Q0uomUEIos9puwjrjGbgeMoHdQCZYBO5z7AeSx
         Hrdrnk1ZLhMFVRR6Ev1siUlWxIv1yt8zRK6h8JiR86p3Jy5OUkQ4K0ABSinKR6b32vGR
         CbQhxtBBhjrawFtC2J8/BS3LDY5OaS7MQTzhKs11rFCbV2M4sUKljIbhh3bsXLTmB6lS
         REfk887Hk0umfKdDxOlQn125VHIWXVFUy2/ZgWVUA2xWKWHev1WVKkVHvON4nFdZdBJI
         GSlA==
X-Forwarded-Encrypted: i=1; AJvYcCWML2+evgElF3Oul3LKcwu2rXdLq9sX7cI6czeeCt+ALwfE924KzNv9PhFNExj0e2sFrH4jwvwSKwPdX4EwXCqumF0KJN0VhemK7CRr
X-Gm-Message-State: AOJu0YxLOL0IHtVTCzLb3cKb2ouU31ujyPpUs1dXZxh48UG6P2l6VqHK
	zpRCpKXLS/CP4+ZOeSFX/YQkIdcIrVvJA9Ag7F5udLyX9Q94dniIuEteYIv6fcY/NF+UJYe2aDw
	XjruwlwpTRlaaiDrHe6q/xccvoPQ7fCrNOzdh0mvYmP9uVsEoSHQ+ouYTYJQHOsWo9GKaExDXls
	PBNfgYB6HKTCezksNGiCIivY0n8yc9ZPZtUYPh
X-Received: by 2002:a19:ac47:0:b0:51f:3fea:cbcf with SMTP id 2adb3069b0e04-52bb9fc458fmr1131226e87.52.1717747840496;
        Fri, 07 Jun 2024 01:10:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE22lzSu2t1eaY4ixWZwC3DnY7OJWdzQaXo6iDo3zOQV+ZZthH0LMFdtFi7RdQRJiObbC2NGO5n46x4ubLPcE=
X-Received: by 2002:a19:ac47:0:b0:51f:3fea:cbcf with SMTP id
 2adb3069b0e04-52bb9fc458fmr1131216e87.52.1717747840096; Fri, 07 Jun 2024
 01:10:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530210714.364118-1-rick.p.edgecombe@intel.com> <20240530210714.364118-9-rick.p.edgecombe@intel.com>
In-Reply-To: <20240530210714.364118-9-rick.p.edgecombe@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 7 Jun 2024 10:10:28 +0200
Message-ID: <CABgObfZr_YNcymua7ejapiL0+M=0CQhroheerj-1_YYxisp=Ug@mail.gmail.com>
Subject: Re: [PATCH v2 08/15] KVM: x86/tdp_mmu: Introduce KVM MMU root types
 to specify page table type
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: seanjc@google.com, kvm@vger.kernel.org, kai.huang@intel.com, 
	dmatlack@google.com, erdemaktas@google.com, isaku.yamahata@gmail.com, 
	linux-kernel@vger.kernel.org, sagis@google.com, yan.y.zhao@intel.com, 
	Isaku Yamahata <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 11:07=E2=80=AFPM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
> +enum kvm_tdp_mmu_root_types {
> +       KVM_VALID_ROOTS =3D BIT(0),
> +
> +       KVM_ANY_ROOTS =3D 0,
> +       KVM_ANY_VALID_ROOTS =3D KVM_VALID_ROOTS,

I would instead define it as

    KVM_INVALID_ROOTS =3D BIT(0),
    KVM_VALID_ROOTS =3D BIT(1),
    KVM_ALL_ROOTS =3D KVM_VALID_ROOTS | KVM_INVALID_ROOTS,

and then

  if (root->role.invalid)
    return types & KVM_INVALID_ROOTS;
  else
    return types & KVM_VALID_ROOTS;

Then in the next patch you can do

     KVM_INVALID_ROOTS =3D BIT(0),
-    KVM_VALID_ROOTS =3D BIT(1),
+   KVM_DIRECT_ROOTS =3D BIT(1),
+   KVM_MIRROR_ROOTS =3D BIT(2),
+   KVM_VALID_ROOTS =3D KVM_DIRECT_ROOTS | KVM_MIRROR_ROOTS,
     KVM_ALL_ROOTS =3D KVM_VALID_ROOTS | KVM_INVALID_ROOTS,

and likewise

  if (root->role.invalid)
    return types & KVM_INVALID_ROOTS;
  else if (likely(!is_mirror_sp(root)))
    return types & KVM_DIRECT_ROOTS;
  else
    return types & KVM_MIRROR_ROOTS;

This removes the need for KVM_ANY_VALID_ROOTS (btw I don't know if
it's me, but ALL sounds more grammatical than ANY in this context). So
the resulting code should be a bit clearer.

Apart from this small tweak, the overall idea is really good.

Paolo

> +};
> +
>  bool kvm_tdp_mmu_zap_leafs(struct kvm *kvm, gfn_t start, gfn_t end, bool=
 flush);
>  bool kvm_tdp_mmu_zap_sp(struct kvm *kvm, struct kvm_mmu_page *sp);
>  void kvm_tdp_mmu_zap_all(struct kvm *kvm);
> --
> 2.34.1
>


