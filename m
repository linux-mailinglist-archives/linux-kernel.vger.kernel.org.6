Return-Path: <linux-kernel+bounces-568528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF339A696DD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49B197A8FD8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E242066C8;
	Wed, 19 Mar 2025 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eP/c84Ih"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A813205E14
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 17:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406820; cv=none; b=QkDtHGJvgwIxnENqSsvCp8lvOkqHWZH9QIZfuUNF56T2TBErryAxcA+3YcbHGTRolmMdXtTBNCNOQAFDQK+d5LeT5j+o8u+0VSLcPDyH0BoL3h9qy3DUXu9YB0qD9kElj9Tp+PVGDNeUGFIzspiF5AX4Zz9FRqxeZ07LFhFTZ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406820; c=relaxed/simple;
	bh=yst4v9JnTiT4PTxoeqBe+yurneaOgE/gGgr4bVoCocU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VoAPKbcqEmmBIkEMRdnOQIR2pib5qXd8Ok9DM0AInPLOCISRdXiCj3SP4q8qbIUSbZzZigTrwUqFTuLzpZMqu6BdKfz5uw4zRUjuDdONsA5Qrj3BPc0WH6NL1wnxhGxsFpnR/rKH1aHVmkNBqOSTGNXc2euKpkEiuwHxeNBpH1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eP/c84Ih; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742406817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FlQnSYJjSWWCJiJ5ZGHjM5i7+2vyC77jTfcRlrKWNwg=;
	b=eP/c84IhFGySTvw4EAllYlXeWiq6/hia5Qe4TSXMLXjLAhWLCBH8OOxfAl0IFlTm6hI1GS
	m8Ln4QWIR9KiOqIrI8MD5vO1RnKh5gaYv4qDdNP29kfV3/a4TKy2IYOjRHs2/xyqIiUKrf
	RtKjg4014i1+lQsnI5Rkqq0NBpC0wvs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-zhSeRAV-MBOYlTxmicIZoA-1; Wed, 19 Mar 2025 13:53:35 -0400
X-MC-Unique: zhSeRAV-MBOYlTxmicIZoA-1
X-Mimecast-MFC-AGG-ID: zhSeRAV-MBOYlTxmicIZoA_1742406814
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d3b211d0eso5976595e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742406814; x=1743011614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlQnSYJjSWWCJiJ5ZGHjM5i7+2vyC77jTfcRlrKWNwg=;
        b=vkjJImxmnIPCwcv+MaeSbCPwHeTwTwYok+Kq6aCdpnJuFGpX8vLD4OSb4jE3FRebH2
         7Q42mM1vr0Xd+BRpjUEKK09tCyZSsCgM2L43K4R/woF+P7ZgSxrM7WSa4sGEHzgRfcyY
         7F73o06pPcikByzvesH5Nbq+bpNwT+sJyHmoeAeUaLw0XYgfrSfYtQ0I8W+a61/By8Pu
         RgCw9l+mP8l8Hr+WvTdZQzmDwgs50PVgCGyInJ0jTnLkeaSd2PRKYlTLeWElJch0bBMA
         UK4XgtRRh7Pfe//MSK5rcz/8FtTb6te8YZFgMjRE6oupG6NB814dXHE8crtnpXb5UhUf
         4cmw==
X-Forwarded-Encrypted: i=1; AJvYcCXJkNog/CDwmAQFIOLaj6l7bJkGKR0l3pMU83fjee76AdIieE2HkEYQMgAXh7FWLRXTnpwV6LO+cmBQJTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbdbs54blDsotmc4x9/fpKIV5TeACnZSB25wvRlda/JyQjZM3g
	0oOOGNd9CcexaY5/c5eC51hGNw3Ir2gUEVX7pxS0c3NR9BhzxNdP8b8GLr1IF6EnmD9wWFz8nqi
	5cuUsnnzWfAMHNdWKj9JETFBSgUNZ1HJi2DlefMWp6qrux7mRH52yWms479udf8F/cIOWyV3Cy4
	aSr9AgJdjeP0pFkwfQD9aPY/8b0FFGjQOHdCPr
X-Gm-Gg: ASbGnctRm0JxFeT8VcQo57SNz5s+fSxQEVoXJH5V5utNubBo+mikDLHMHyvyBebPAi4
	GxQ4lBPxOOOTBr7TupVbQCbA4OcPQQnU0njZUvO1aewxENoOKE/ytlSiqboRF1l+jaIFuF0c/Jg
	==
X-Received: by 2002:a05:600c:cc:b0:43b:c592:7e16 with SMTP id 5b1f17b1804b1-43d4915e6bemr3628525e9.3.1742406814423;
        Wed, 19 Mar 2025 10:53:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtZ1bzllCMq6d3Zvj42Dk0a7iurgCzlP3ig7MTVxnM83ohKflegbY3SnZD2KbFSAko7x0YjMQ4ZsmCUA3JJp0=
X-Received: by 2002:a05:600c:cc:b0:43b:c592:7e16 with SMTP id
 5b1f17b1804b1-43d4915e6bemr3628345e9.3.1742406813957; Wed, 19 Mar 2025
 10:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318180303.283401-1-seanjc@google.com>
In-Reply-To: <20250318180303.283401-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Mar 2025 18:53:22 +0100
X-Gm-Features: AQ5f1Jr94wsujy5-Prg2eZ25XgCVHjBFKdayi8ReAIGM7WoUFXZuVvcoETEPU9g
Message-ID: <CABgObfbMDAtaLvaLrDA7ptU+9kjej_LVArp3dCNao8+qtiEDww@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: Changes for 6.15
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 7:03=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> There are two conflicts between the PV clock pull request and the Xen
> pull request.
>
> 1. The Xen branch moves Xen TSC leaf updates to CPUID emulation, and the =
PV
>    clock branch renames the fields in kvm_vcpu_arch that are used to upda=
te
>    the Xen leafs.  After the dust settles, kvm_cpuid() should look like:
>
>                 } else if (IS_ENABLED(CONFIG_KVM_XEN) &&
>                            kvm_xen_is_tsc_leaf(vcpu, function)) {
>                         /*
>                          * Update guest TSC frequency information if nece=
ssary.
>                          * Ignore failures, there is no sane value that c=
an be
>                          * provided if KVM can't get the TSC frequency.
>                          */
>                         if (kvm_check_request(KVM_REQ_CLOCK_UPDATE, vcpu)=
)
>                                 kvm_guest_time_update(vcpu);
>
>                         if (index =3D=3D 1) {
>                                 *ecx =3D vcpu->arch.pvclock_tsc_mul;
>                                 *edx =3D vcpu->arch.pvclock_tsc_shift;
>                         } else if (index =3D=3D 2) {
>                                 *eax =3D vcpu->arch.hw_tsc_khz;
>                         }
>                 }
>
> 2. The Xen branch moves and renames xen_hvm_config so that its xen.hvm_co=
nfig,
>    while PV clock branch shuffles use of xen_hvm_config/xen.hvm_config fl=
ags.
>    The resulting code in kvm_guest_time_update() should look like:
>
> #ifdef CONFIG_KVM_XEN
>         /*
>          * For Xen guests we may need to override PVCLOCK_TSC_STABLE_BIT =
as unless
>          * explicitly told to use TSC as its clocksource Xen will not set=
 this bit.
>          * This default behaviour led to bugs in some guest kernels which=
 cause
>          * problems if they observe PVCLOCK_TSC_STABLE_BIT in the pvclock=
 flags.
>          *
>          * Note!  Clear TSC_STABLE only for Xen clocks, i.e. the order ma=
tters!
>          */
>         if (ka->xen.hvm_config.flags & KVM_XEN_HVM_CONFIG_PVCLOCK_TSC_UNS=
TABLE)
>                 hv_clock.flags &=3D ~PVCLOCK_TSC_STABLE_BIT;
>
>         if (vcpu->xen.vcpu_info_cache.active)
>                 kvm_setup_guest_pvclock(&hv_clock, v, &vcpu->xen.vcpu_inf=
o_cache,
>                                         offsetof(struct compat_vcpu_info,=
 time));
>         if (vcpu->xen.vcpu_time_info_cache.active)
>                 kvm_setup_guest_pvclock(&hv_clock, v, &vcpu->xen.vcpu_tim=
e_info_cache, 0);
> #endif

Thanks, pulled everything to kvm/queue. I assume you want me to put
the following on top:

* KVM: Drop kvm_arch_sync_events() now that all implementations are nops
* KVM: x86: Fold guts of kvm_arch_sync_events() into kvm_arch_pre_destroy_v=
m()
* KVM: x86: Unload MMUs during vCPU destruction, not before
* KVM: Assert that a destroyed/freed vCPU is no longer visible
* KVM: x86: Don't load/put vCPU when unloading its MMU during teardown

Paolo


