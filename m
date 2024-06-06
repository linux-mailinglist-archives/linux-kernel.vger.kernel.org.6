Return-Path: <linux-kernel+bounces-204620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3808FF156
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594831C20F5C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430C7198832;
	Thu,  6 Jun 2024 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V265MyD2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D73D197501
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717689338; cv=none; b=qIeLSRHRFOUBQxwn/bh+GYgcRMS0BUkVQSEd2qRtWtaM9jvRD40UxBvoBhLh+fqOsVl6sUvzg3VGgVAwRd+ILIkxMZpbu/uTe8W4eMoo9qCKqL6QiALmN2yHwa63wuuk+qmkwpuy8h2wUvVzaBW566gPeoFH0LLeG0QncdofKPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717689338; c=relaxed/simple;
	bh=sYwMXyFF5ixGHvNGo97vEq7NFrrcLjDHWZL8/TD1lOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fm7beObSUJIWh9O9c7o2CrZlEZSfcmRZ7UbsqTxxqrjTOOjI4h+RSnteF75RW+ANpug7WFNgoSxAB33GhCaR2x69/nrd4MjPL5h2M7pUhkkSu0OB/V6ZFPHMICKhuz5byGj3EY7tZRnPz0S0QB45yLd6P84Zp/nBxD/KeO0qo5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V265MyD2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717689336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VAS3T4eIlsBeIGJQaMBH344OaeO565Bp+YWQvYSRJRg=;
	b=V265MyD2GbWc1jWwxIk/M3hUDpf74xOgcSRuCFUaYGyeXXXsDJuBuOvWAW7A5CMgZnev9p
	1VEuXsQqnkokjZbfqkGXqA/8LBY5ITS9nyO1UFnWxdu7rs7nFhGs07ODnUoWoYGkF9a/xq
	INl4MPPXe7FVT2a3+S5gBxuPyVZYhA8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-41JCmumAOlW7tA81O1pVOA-1; Thu, 06 Jun 2024 11:55:34 -0400
X-MC-Unique: 41JCmumAOlW7tA81O1pVOA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-35dca4a8f2dso701931f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 08:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717689333; x=1718294133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAS3T4eIlsBeIGJQaMBH344OaeO565Bp+YWQvYSRJRg=;
        b=QgqnagvXKbpgR0POlKUtm0SGwFVA0PGVIRpn6gVApCCtB1J9+MbhRzBnsx58g/+2IE
         EEozn9oK9cYrPXhjUoq+/DLw81plO85H1l/nTXXUfYuJcfPYkaaufa3bBMgG1ro4+LUG
         KjMpPt06fxm9DuttgCQkwoagaOFnVaR/8P9u1vhL0jKfUeP6kWLn36J7aCqQS0P1W9yw
         C1b+U5sU+EYpW1Rd7Raxde+RjaFmdbp0o5tm4ax1qCogDJAOo5+DttX7rDP5N+MRxD+G
         RQhCj54Yq8jt1gFGqI0LBM4AIgWc/obo0+dsOTWWlulcbSjdeYW2IP0O97LZUhTothO/
         2f7A==
X-Forwarded-Encrypted: i=1; AJvYcCWT0dwuOunA0ccF5/Z3CCafeqL0hCR+GcMq0Siq2VVphMzFePNl+ui0vHs8i/Jq7qWJ3DTvJU6fF4WCFUA5hKU9EtYYdfbqimYAE7gc
X-Gm-Message-State: AOJu0Yysv4R1JVpQHgkliPVPMdWYVyBFClkW2sDXwUR7STh1/88DwpHI
	YWfSz5w6fpRUjEEe9srGFCr8UWGl7p0fL69V0rj0dz03BhpuYx+x0jl7igI3yz4OPVFo9esvVG2
	WV6q8xxt2yh0bi/VoBO7ZkHXLm6n6jLXSj0fWBOw283STZiHuAmVXCdo/Z+snM2KCbMJfnyoDPm
	u+724DK+lmf8AT1U+GSLU8IlfZ8/Ge+E4nyPrX
X-Received: by 2002:adf:ed86:0:b0:355:451:df52 with SMTP id ffacd0b85a97d-35efed7287emr30394f8f.34.1717689333253;
        Thu, 06 Jun 2024 08:55:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2Y8tswbPAEDMxvcnWmmCT8GpIPg0n2c4bvuPyToo4YuEroQzgcRPSS7Py1HooVbVd0cTca+l6fSiY5takNSY=
X-Received: by 2002:adf:ed86:0:b0:355:451:df52 with SMTP id
 ffacd0b85a97d-35efed7287emr30378f8f.34.1717689332948; Thu, 06 Jun 2024
 08:55:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530210714.364118-1-rick.p.edgecombe@intel.com> <20240530210714.364118-2-rick.p.edgecombe@intel.com>
In-Reply-To: <20240530210714.364118-2-rick.p.edgecombe@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 6 Jun 2024 17:55:21 +0200
Message-ID: <CABgObfZ8qOJtui9ozU4sd-hnjNM_33qwA-jcJEeDc=RY5EoqfA@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] KVM: Add member to struct kvm_gfn_range for
 target alias
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: seanjc@google.com, kvm@vger.kernel.org, kai.huang@intel.com, 
	dmatlack@google.com, erdemaktas@google.com, isaku.yamahata@gmail.com, 
	linux-kernel@vger.kernel.org, sagis@google.com, yan.y.zhao@intel.com, 
	Isaku Yamahata <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 11:07=E2=80=AFPM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
> +       /* Unmmap the old attribute page. */

Unmap

> +       if (range->arg.attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE)
> +               range->process =3D KVM_PROCESS_SHARED;
> +       else
> +               range->process =3D KVM_PROCESS_PRIVATE;
> +
>         return kvm_unmap_gfn_range(kvm, range);
>  }
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index c3c922bf077f..f92c8b605b03 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -260,11 +260,19 @@ union kvm_mmu_notifier_arg {
>         unsigned long attributes;
>  };
>
> +enum kvm_process {
> +       BUGGY_KVM_INVALIDATION          =3D 0,
> +       KVM_PROCESS_SHARED              =3D BIT(0),
> +       KVM_PROCESS_PRIVATE             =3D BIT(1),
> +       KVM_PROCESS_PRIVATE_AND_SHARED  =3D KVM_PROCESS_SHARED | KVM_PROC=
ESS_PRIVATE,
> +};

Only KVM_PROCESS_SHARED and KVM_PROCESS_PRIVATE are needed.

> +       /*
> +        * If/when KVM supports more attributes beyond private .vs shared=
, this
> +        * _could_ set exclude_{private,shared} appropriately if the enti=
re target

this could mask away KVM_PROCESS_{SHARED,PRIVATE} if the entire target...

Paolo

> +        * range already has the desired private vs. shared state (it's u=
nclear
> +        * if that is a net win).  For now, KVM reaches this point if and=
 only
> +        * if the private flag is being toggled, i.e. all mappings are in=
 play.
> +        */
> +
>         for (i =3D 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
>                 slots =3D __kvm_memslots(kvm, i);
>
> @@ -2506,6 +2519,7 @@ static int kvm_vm_set_mem_attributes(struct kvm *kv=
m, gfn_t start, gfn_t end,
>         struct kvm_mmu_notifier_range pre_set_range =3D {
>                 .start =3D start,
>                 .end =3D end,
> +               .arg.attributes =3D attributes,
>                 .handler =3D kvm_pre_set_memory_attributes,
>                 .on_lock =3D kvm_mmu_invalidate_begin,
>                 .flush_on_ret =3D true,
> --
> 2.34.1
>


