Return-Path: <linux-kernel+bounces-248819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D0D92E261
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F9F1F24243
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CFE155A43;
	Thu, 11 Jul 2024 08:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ty6jpyPJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3742915B0F8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686658; cv=none; b=GmwEtfxsZJoiAR1+5X4oM/p3T51FWwhyOlyTW9lF4CrkjlfSrX7yBLqbFN8LSzDtbKx/fCN5SBxmwqyBktza11sRanL4TbHn/0sQxyUDLNAre8b0HpY0QICWTUW1hgIJ/OBDA924/D+WO1Bx4l0uIy7MLe1weq/oO4eHKojmxgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686658; c=relaxed/simple;
	bh=vq/fsSFpj4lf62kfSjY69N/eyTlPYqc7EZyIMw8xTZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6DikLTcV6End7PurGgsFt2ZsZdwTZIJs4304/QAtLB53HtF3W5A2Zm90SusyJOvEXhuDio+7D3ydEZidtqqbxQSKaCLe/f6OcYxhqRA9zZ+Sxe+Tjj4tkrC9Oxo0x0p9s0eXKySp4fm1PM285bv7uRg+Z31I1OURofyXntUoKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ty6jpyPJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720686656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btXtWBcxdT6FJlBZbVF8gxUbmtiHEm3rZNQvGlu5PqE=;
	b=Ty6jpyPJbrIokUWDj6Zm2n+pD3h1hdM1hDQOebIAWl98K2YDWm6Tjh5glrnw0Wfbz/9rlT
	s30mjfNekGUbjkL60aAY2vyNBOhc1dBu3GBSTGa8GVTx73pzQpHcKGQieTpA8L8a9ReqME
	MI/vSSDBp2WWr5fmt6Ns1eICUe1bM5A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-59sh4HlZPpW-qrgD4_be-Q-1; Thu, 11 Jul 2024 04:30:54 -0400
X-MC-Unique: 59sh4HlZPpW-qrgD4_be-Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4279837c024so4482485e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720686653; x=1721291453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btXtWBcxdT6FJlBZbVF8gxUbmtiHEm3rZNQvGlu5PqE=;
        b=V6g6HKlTyhbVdE3bHDf+Gd1gUHq66PxVJvJCJ0+fuOi53oOjfkchOSShcdfNbwuGQc
         E2Yjof4AVNP39RhyF4bfSAuxcMMlXqdEaskYuCREJDwyF8eHW5M/th9qqrFnxgqSxkCy
         u9gz5REPqjdJ2bjeRRJ/7Wt6M7J5n/hNzUlZmFqfU9wDXIDx70RRQKAAs/kfwpCxC7qd
         csbcOxshzeDytBZNZ1gXVxyQMno/f9IdE1X/UvJllPlFBTJ4Ldv2XGDkn3vORCzQoBe1
         FU2KhSxoYwKCxB4dPE8Mo29tOfTzE1h3Obub+/35dvsZuSbXWIFxhlISHRW9FigrMv8Z
         ZjhQ==
X-Gm-Message-State: AOJu0Yy5dI0j36QvaTiX1EVsHb+y0aPp3V1i75oYTKixpds68pVg15E3
	jA2cf25U3NGNaUbFxQjS5DBdE4i23T81v9D+KIntysiw/dhjR8duHx6q5iF68slVfF9A7qO4KkR
	Aa566O/D5r79jVWPKR6qEZy9nUnZpYmvAHqcpUMn7WCfahhCKUJMwfRsP9Ei3mUXzeoVbbLKmA/
	vNHjSQ4vWkGjXBtdhhHzMj92pNezDmUNIpcM/1
X-Received: by 2002:a5d:58f1:0:b0:367:8900:c621 with SMTP id ffacd0b85a97d-367ceaca897mr5750897f8f.56.1720686653569;
        Thu, 11 Jul 2024 01:30:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQE2zYNCu9jnbKuJ1vYypQltqtn1W53LvxLUbv4GeYPR8FiICVkKa9B4B4Tli9UJizVyY3iyXiiUMPse135wM=
X-Received: by 2002:a5d:58f1:0:b0:367:8900:c621 with SMTP id
 ffacd0b85a97d-367ceaca897mr5750879f8f.56.1720686653218; Thu, 11 Jul 2024
 01:30:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710174031.312055-1-pbonzini@redhat.com> <20240710174031.312055-7-pbonzini@redhat.com>
 <cd52fe00-b57b-495c-b55c-54fd381f7c66@linux.intel.com>
In-Reply-To: <cd52fe00-b57b-495c-b55c-54fd381f7c66@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 11 Jul 2024 10:30:41 +0200
Message-ID: <CABgObfZfyWzKRafPVcTyQ23oO=aAkc7Pmg8En4412J0vx1WotQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] KVM: x86: Implement kvm_arch_vcpu_pre_fault_memory()
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	isaku.yamahata@intel.com, seanjc@google.com, xiaoyao.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 7:37=E2=80=AFAM Binbin Wu <binbin.wu@linux.intel.co=
m> wrote:
> On 7/11/2024 1:40 AM, Paolo Bonzini wrote:
> > Wire KVM_PRE_FAULT_MEMORY ioctl to __kvm_mmu_do_page_fault() to populat=
e guest
>
> __kvm_mmu_do_page_fault() -> kvm_mmu_do_page_fault()
>
> > memory.  It can be called right after KVM_CREATE_VCPU creates a vCPU,
> > since at that point kvm_mmu_create() and kvm_init_mmu() are called and
> > the vCPU is ready to invoke the KVM page fault handler.
> >
> > The helper function kvm_mmu_map_tdp_page take care of the logic to
>
> kvm_mmu_map_tdp_page -> kvm_tdp_map_page()?

Yes, will fix.

> > diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> > index 80e5afde69f4..4287a8071a3a 100644
> > --- a/arch/x86/kvm/Kconfig
> > +++ b/arch/x86/kvm/Kconfig
> > @@ -44,6 +44,7 @@ config KVM
> >       select KVM_VFIO
> >       select HAVE_KVM_PM_NOTIFIER if PM
> >       select KVM_GENERIC_HARDWARE_ENABLING
> > +     select KVM_GENERIC_PRE_FAULT_MEMORY
> >       select KVM_WERROR if WERROR
> >       help
> >         Support hosting fully virtualized guest machines using hardware
> [...]
> > index ba0ad76f53bc..a6968eadd418 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -4705,6 +4705,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm,=
 long ext)
> >       case KVM_CAP_MEMORY_FAULT_INFO:
> >               r =3D 1;
> >               break;
> > +     case KVM_CAP_PRE_FAULT_MEMORY:
> > +             r =3D tdp_enabled;
> > +             break;
> If !CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY, this should return 0.

This is x86-specific code and it CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY
is always selected by CONFIG_KVM on x86 (that is, it does not depend
on TDX or anything else).

Paolo


