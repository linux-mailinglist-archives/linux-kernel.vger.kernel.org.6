Return-Path: <linux-kernel+bounces-192822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F978D22B9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FFCA1F243F4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D958629402;
	Tue, 28 May 2024 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfR5vCDG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679B0224FD
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716918219; cv=none; b=B22tSWXexUcv0CVskU7MZxJwMBDserUgBlOW9O/Y74OpYIfe5jia6C+8xXEhy0OPNq2GzEBvfuQMDHtelUg4u2neMmZnS7yXh4WWidELkEB79fAZdpQrkvS091WwZNqC9tZ8Hhe68/ccvRsBzWIowPstq6K3ZiFW+CnT5ZP6TRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716918219; c=relaxed/simple;
	bh=5ss+AAnDNgpFoZHquQjyHRTVRnwByHqRQ9kN4FAyIBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fW+1Y5fEgjof5nAt/apNDm8BqqWJCR2wB4XHr06ZwVQ7/Vhp+/xj4Bl2Uk2Y1L0CcXk6mb1sZ/gCtIwRlz6mJ5iu3et4Ev/EM/T6AkCzb3B+LwpcHhYxDdWRLCl3afli3iCH5rwvz1bGtSloipMngHf0eI8PLzSduI6a+ydGvSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FfR5vCDG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716918216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BgC1mBmX/uzbi9oKpLMQ8UHWTdsyAuGhZK7pefKFgjk=;
	b=FfR5vCDG3B1md5I5fTu+1bj4IoLEXuNxPJeVkYy7uplU/tz9JMxLi7oGG++wb+4uxZGSRj
	EfACyPY5tsHV+tST+DCNfAny8n8NY1kxecApaEVEOjozkP2Kl4spySAQz9LkjawQMf2tQd
	DDzjBMa+MDH6u97pzaRBf6Y4hcmE7rk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-aG2KsOEgN42ywBQI0uOQZA-1; Tue, 28 May 2024 13:43:34 -0400
X-MC-Unique: aG2KsOEgN42ywBQI0uOQZA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42110ebbd0fso7901045e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716918214; x=1717523014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgC1mBmX/uzbi9oKpLMQ8UHWTdsyAuGhZK7pefKFgjk=;
        b=GK1/DCG6QB3gYqv3LMGORa47xHbnaKH4G4OZpHqPODUJiiPZY3C1c6ceXyxwTKfjhB
         zNTn4Cn9s/6QTPYSlwvsYxv2+ec8BvMqC9pg6BSNAWYv40qW3CWS6eXS+v5+miDO0q8c
         KitmPX6kKfuL2VqYA8gnLB122+MjTQ4lAOV4XUGxk69kbZs1L5tNJ/++qpFD4F9ais0y
         qJGxyguYp1yTpULgtCyMRDFC12cPx0yfhJXxFCuwBYXJv2/Mm3Z9KnrFkRtfCFRNq5uT
         1hD88Vu/cfga7wveR2iH9woaD+Amiu0RG1SU4Bz4dGZ8lS3rUx54G4c3nOu7l3k6twOY
         sAYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXw7/OwZFTalVa2Wj14mrdbWfLAmMzxCStbieNYnblSKLuAh/f1siaVI5blyuuGR04BCgx3npBbTuQKvpO2x1hGwc6ZEJ+dTnhtWEl
X-Gm-Message-State: AOJu0YxyrlReeLhME9NIe4a8Eg8hthJi2jlz2lCjDkMXIGrMpu5BJ4yK
	mda6I7ro57YrXYx4VIGO2y8BUaD2b6GjSpUC9Z5wZXj9cKybNkxmq23YzYYYSaZtHNHQtBWjQ8E
	2DBsng1edgxeMt1E1M6MaMnd9vdzTvj9a1C3E5aUn6jUmecxWDgNmdQOBxbQUdfgf7GFk6lYJX8
	DNCO02vqf/mU7Vyg8VXwq7rynRjYHJPDC2M8Mm
X-Received: by 2002:a5d:5692:0:b0:34c:9a24:7a40 with SMTP id ffacd0b85a97d-3552fe19565mr8133822f8f.56.1716918213759;
        Tue, 28 May 2024 10:43:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF331e0QppI8ltPGCBE9BOpld9BHKKJ4O1No2M3EWSNTxEDCrihDkeZIocL+V45WCsid2VaNJL704Yanbx2wZA=
X-Received: by 2002:a5d:5692:0:b0:34c:9a24:7a40 with SMTP id
 ffacd0b85a97d-3552fe19565mr8133794f8f.56.1716918213277; Tue, 28 May 2024
 10:43:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1d247b658f3e9b14cefcfcf7bca01a652d0845a0.camel@intel.com>
 <a08779dc-056c-421c-a573-f0b1ba9da8ad@intel.com> <588d801796415df61136ce457156d9ff3f2a2661.camel@intel.com>
 <021e8ee11c87bfac90e886e78795d825ddab32ee.camel@intel.com>
 <eb7417cccf1065b9ac5762c4215195150c114ef8.camel@intel.com>
 <20240516194209.GL168153@ls.amr.corp.intel.com> <55c24448fdf42d383d45601ff6c0b07f44f61787.camel@intel.com>
 <20240517090348.GN168153@ls.amr.corp.intel.com> <d7b5a1e327d6a91e8c2596996df3ff100992dc6c.camel@intel.com>
 <20240517191630.GC412700@ls.amr.corp.intel.com> <20240520233227.GA29916@ls.amr.corp.intel.com>
In-Reply-To: <20240520233227.GA29916@ls.amr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 28 May 2024 19:43:20 +0200
Message-ID: <CABgObfZSdXLwH4cMZGz5KmqxVM04pg7RMyRUs6bT8tXFWRUURA@mail.gmail.com>
Subject: Re: [PATCH 10/16] KVM: x86/tdp_mmu: Support TDX private mapping for
 TDP MMU
To: Isaku Yamahata <isaku.yamahata@intel.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"seanjc@google.com" <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, 
	"sagis@google.com" <sagis@google.com>, 
	"isaku.yamahata@linux.intel.com" <isaku.yamahata@linux.intel.com>, "Aktas, Erdem" <erdemaktas@google.com>, 
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, 
	"isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>, "dmatlack@google.com" <dmatlack@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 1:32=E2=80=AFAM Isaku Yamahata <isaku.yamahata@inte=
l.com> wrote:
> +static void vt_adjust_max_pa(void)
> +{
> +       u64 tme_activate;
> +
> +       mmu_max_gfn =3D __kvm_mmu_max_gfn();
> +       rdmsrl(MSR_IA32_TME_ACTIVATE, tme_activate);
> +       if (!(tme_activate & TME_ACTIVATE_LOCKED) ||
> +           !(tme_activate & TME_ACTIVATE_ENABLED))
> +               return;
> +
> +       mmu_max_gfn -=3D (gfn_t)TDX_RESERVED_KEYID_BITS(tme_activate);

This would be be >>=3D, not "-=3D". But I think this should not look at
TME MSRs directly, instead it can use boot_cpu_data.x86_phys_bits. You
can use it instead of shadow_phys_bits in __kvm_mmu_max_gfn() and then
VMX does not need any adjustment.

That said, this is not a bugfix, it's just an optimization.

Paolo

> +       }
>
>  out:
>         /* kfree() accepts NULL. */
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 7f89405c8bc4..c519bb9c9559 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -12693,6 +12693,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned lo=
ng type)
>         if (ret)
>                 goto out;
>
> +       kvm->arch.mmu_max_gfn =3D __kvm_mmu_max_gfn();
>         kvm_mmu_init_vm(kvm);
>
>         ret =3D static_call(kvm_x86_vm_init)(kvm);
> @@ -13030,7 +13031,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kv=
m,
>                 return -EINVAL;
>
>         if (change =3D=3D KVM_MR_CREATE || change =3D=3D KVM_MR_MOVE) {
> -               if ((new->base_gfn + new->npages - 1) > kvm_mmu_max_gfn()=
)
> +               if ((new->base_gfn + new->npages - 1) > kvm_mmu_max_gfn(k=
vm))
>                         return -EINVAL;
>
>  #if 0
>
> --
> Isaku Yamahata <isaku.yamahata@intel.com>
>


