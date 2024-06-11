Return-Path: <linux-kernel+bounces-210040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 733EA903E6C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A91A1C22659
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E60617D88D;
	Tue, 11 Jun 2024 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGmDUaKy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646AC1DDF4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718115101; cv=none; b=MBG5yhfYkftJu/mtucKELRBiaZmVoYbJZ3CrvnmAwYz5SBk5Cexju/P1knQMRcY62jFHneKivDxQm/4/mjzrt7OadG4xTbTzVttBrmIkRgYWrVO0+K6x2Xld4KuDR/hvTWLrLaWeSdlgoWafFs1Crx20ZL9pHo5ZTvsE0umlAA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718115101; c=relaxed/simple;
	bh=pIcYc7qj+KGZTsXvqC+Dyfy5a8D1ol5MLnz6Q2+/6T0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5YUBjHWgyKuQF2YfWYCvbIulg4TV4nSMSQCm4C8oqhr8rdyj2/HDtaK7Xfi9RHYeo+zAbNT/Q0cqSZIN4X8PLe7p7DYdh8ciRmyIIwd1U9xgPlNBKQd5MGWSrjxu5cMWC25nFNEvHKYsXBr8Y/pdSSTQA4nzsClmHhfOm/IxYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CGmDUaKy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718115099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RpDAWqVGKOY605xFCvj/GBOlGGRTneCE6rG1ivSak+k=;
	b=CGmDUaKyDS+MXAIOAB2TebwVwrUtllmxzvMDMzE7Fa004x0ITqiEo2+vN/zCthFPqhC1g7
	MMPG0cQs1ED+z3Jjyi4jhA/Kv53i4Q+zkiBj2Dv8E9WqZK2LGkzspoj0x6pj9PNx9xzq1z
	GpxOHZnqKVlyPHCn4ZXrG47p3/XKQqg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-ui_OQuWEMWWAyXh20vg2Aw-1; Tue, 11 Jun 2024 10:11:37 -0400
X-MC-Unique: ui_OQuWEMWWAyXh20vg2Aw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ebdc5ccb17so20649211fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 07:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718115095; x=1718719895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpDAWqVGKOY605xFCvj/GBOlGGRTneCE6rG1ivSak+k=;
        b=iv/esMmNkJtifLtGiW8dXrBLxbf6O2GjyheHBSS0b2gE+i1WO6h8dnpfaeUzKBI0m5
         QsK1bO3LXjAUgUsHgJzF538+254uXzfr/qGFUI56EbBf7SnK6QFvmbXPPIw1KHyE4oiT
         xJW+rId6Nvem+KbSEiA2c7Rbf+Xt+ZcLoRJUHc5PWSTKNbTh+wUGYT5mnhfGtfM32du2
         jVDfy4912EJNhONeQXahjr3bZESaWgyoHddyjG4vwtks+mfyRXv4jZxYB6SPucxQ6+Rf
         /paaHe9HEgQvvhKdL6MKBB7c4Wbz2Xc2KFbF7xDKLQdSINwV+CFM83eufvc1PI4EjXta
         GXug==
X-Forwarded-Encrypted: i=1; AJvYcCU4FyQf+6CRCjs9mBIOsfeHoUo3Fn6PGAhK40gUrHWU9vdhE+KhQotbYRKmoUnqO+/bJd7bnZRMgu6ydJKGPdVF7XAf6ZNDOPuk+ZAR
X-Gm-Message-State: AOJu0YzwAXC99sGb3vA7hKcwy+LMRibOI8IjNl0a1uYs8zV+muAzpwN6
	u9mVhr+xSecVifFIosgnjeDWxAY65lVgKAivDi9kjy81iFjpLnZs22QG+uI3ehZ4vqiYEwjjylY
	T4VlFmy97fc1o4guF43A56sZs+9k/5FMBuGDhWHUWl7/zw9mCKdEXXlzz6XWxMNMCymmtgsC4Gd
	1dQPPmjehJSrSpUNUJALWNK61ZJDDNMFLiIfUi
X-Received: by 2002:a2e:9b95:0:b0:2eb:dc60:6ca9 with SMTP id 38308e7fff4ca-2ebdc6071f1mr44281981fa.21.1718115095636;
        Tue, 11 Jun 2024 07:11:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdNr89xOFxsu/OE+Qb/AhaeTb6Ok/589nDo93/+gKXMC8huDBP4tutt942gwRvE3O+A/NcNjdibu2XZ8tiX8Y=
X-Received: by 2002:a2e:9b95:0:b0:2eb:dc60:6ca9 with SMTP id
 38308e7fff4ca-2ebdc6071f1mr44281841fa.21.1718115095310; Tue, 11 Jun 2024
 07:11:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708933498.git.isaku.yamahata@intel.com>
 <9c4547ea234a2ba09ebe05219f180f08ac6fc2e3.1708933498.git.isaku.yamahata@intel.com>
 <ZiJ3Krs_HoqdfyWN@google.com> <aefee0c0-6931-4677-932e-e61db73b63a2@linux.intel.com>
In-Reply-To: <aefee0c0-6931-4677-932e-e61db73b63a2@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 11 Jun 2024 16:11:23 +0200
Message-ID: <CABgObfb9DC744cQeaDeP5hbKhgVisCvxBew=pCP5JB6U1=oz-A@mail.gmail.com>
Subject: Re: [PATCH v19 116/130] KVM: TDX: Silently discard SMI request
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>, isaku.yamahata@intel.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, isaku.yamahata@gmail.com, erdemaktas@google.com, 
	Sagi Shahar <sagis@google.com>, Kai Huang <kai.huang@intel.com>, chen.bo@intel.com, 
	hang.yuan@intel.com, tina.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 3:18=E2=80=AFPM Binbin Wu <binbin.wu@linux.intel.co=
m> wrote:
> >>   }
> >>
> >> diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
> >> index ed46e7e57c18..4f3b872cd401 100644
> >> --- a/arch/x86/kvm/vmx/main.c
> >> +++ b/arch/x86/kvm/vmx/main.c
> >> @@ -283,6 +283,43 @@ static void vt_msr_filter_changed(struct kvm_vcpu=
 *vcpu)
> >>      vmx_msr_filter_changed(vcpu);
> >>   }
> >>
> >> +#ifdef CONFIG_KVM_SMM
> >> +static int vt_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
> >> +{
> >> +    if (is_td_vcpu(vcpu))
> >> +            return tdx_smi_allowed(vcpu, for_injection);
> > Adding stubs for something that TDX will never support is silly.  Bug t=
he VM and
> > return an error.
> >
> >       if (KVM_BUG_ON(is_td_vcpu(vcpu)))
> >               return -EIO;
>
> is_td_vcpu() is defined in tdx.h.
> Do you mind using open code to check whether the VM is TD in vmx.c?
> "vcpu->kvm->arch.vm_type =3D=3D KVM_X86_TDX_VM"

I'd move it to some place that main.c can see. Or vmx.c as Sean says
below, but I am not sure I like the idea too much.

Paolo

> > And I wouldn't even bother with vt_* wrappers, just put that right in v=
mx_*().
> > Same thing for everything below.

If it's a KVM_BUG_ON()


