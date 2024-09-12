Return-Path: <linux-kernel+bounces-326677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF06976B9B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4631C22505
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCACD1B12E9;
	Thu, 12 Sep 2024 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7m+Aq+V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AD51D52B
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726150179; cv=none; b=D6o1WOP7g+vvFm2bQ3OFPUfzpyj6b4BBy2XDOFDWYT+SaGOoEgpZ6D3nV2MGanr8rd66fSqR3SZpnaeihXr5lyjDqQIyN5nf9VbQSihDqxKc6cMm5ulVDBDxJdlEAi56UhtRdHybkzq1UNeyNS99tyq6eMLdV22VusjJ5NMTlJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726150179; c=relaxed/simple;
	bh=LBWsfuA61ZgLh8l5H+nPmaCDGDpV3miRWF5Qsk8z0WM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ABNWPkFlHyMsfEaWN6BL5E0zFKk1PqQgXlcEcu5+yzb9DjVXY13iRJR2o9MIdCcmMLH4nVY7djnI8W4pO9Zs3cq7l5+q8dy9JB9lFXftXk0YRUEMI6ymtXrgKUgXosFplui71AQYZWMOrkBh1XVz3d7HFGGx4lheDD1HHpDE3jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B7m+Aq+V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726150176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B/noI6L46LpMySUAEmkZWrNHzOowp74DcO8neknTAA4=;
	b=B7m+Aq+V5fcb4v3o2mScCGQ/4rtE8y51M9IIT0JDTIPpcXps+iGBP1Txg4dZbJebKzGKHO
	UIihwHC4zGPw+1KVkqCSnULVfLO23H+JGlZ3ab/wygy4xsyxkQuQF/f+XRNI4vEhEmdMJw
	J5WCMlF6Qc0Ir4VrLUrCUcq+v/JYZcw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-eopb85Z7OyC7FUF6eovosQ-1; Thu, 12 Sep 2024 10:09:35 -0400
X-MC-Unique: eopb85Z7OyC7FUF6eovosQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5344b7df784so837946e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726150173; x=1726754973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/noI6L46LpMySUAEmkZWrNHzOowp74DcO8neknTAA4=;
        b=Yg9qhKL4A0DAXNn9Z0Rw4kr/8yvFROou9x7mJ+i3KD5QMGTFkU4Hcq13bZbhDAewWR
         cAPUWpV8asYebSssIaaulA1ZKLVeZSOfG7WrpKZ5S5Jns3sedmnjJ2kWMI0age58sUvV
         P/EhpJ0XaOCouBC+6W4uaX0xWnXqSc5EHFgLCAVOGwl5cbIhgEPWIy8zOYksfc3ST0a8
         FThN8JL0XFIPc4C2ehajy8ihINuYRwkEVIcA0uvBwNFYag8Tf2WiGY0JoUVQjeb6eEpl
         kVy6+iRxSxprkJvFRb0A2SvHiOon+wpEKM/H1+kFCkMtmRNWl+V27alZiNwUmpObzww8
         8Kdg==
X-Forwarded-Encrypted: i=1; AJvYcCVGbcvdEM2mtMYkQ+wwVkShNRmxXi5b4gpEdHj2tLfgbVtwiJhqefsZN4NSKQWXlTqMQOT09gAiky1U8BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyquh4GMftlv6llU3/nsoQH6hz3IagU0LLC7bJsNwHL/ZxfkmQB
	OclSjE6Xz1c8CZs47ZF4bCavkrXZQvApwdNT8rf9lsasBgA9dWHKsnQZsFnoXXWpzFjDLrLlL0F
	Bmm2fVqPcYAAluepF0BQ8VXK7C1cRuVDkW9T1bu1NfEboH5k8K7QkMNvrzCxWOjfbTJXkBtj9Oq
	v2HCs3YjIav9U6/n9VejOgyc1htXgcOjnmzABy5fzRrnYzX/pzdw==
X-Received: by 2002:a05:6512:398c:b0:535:63a9:9d8c with SMTP id 2adb3069b0e04-53678fba292mr1725779e87.17.1726150173368;
        Thu, 12 Sep 2024 07:09:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvoyuxSck7Et6Xyrx9KV/p41KKDpZ4FwZ6ViBs3qjK4/W94E9cZZm7edQZrVbkHf45A1ngSmJQ5PU6Hx52O4Y=
X-Received: by 2002:a05:6512:398c:b0:535:63a9:9d8c with SMTP id
 2adb3069b0e04-53678fba292mr1725750e87.17.1726150172863; Thu, 12 Sep 2024
 07:09:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812224820.34826-1-rick.p.edgecombe@intel.com>
 <20240812224820.34826-26-rick.p.edgecombe@intel.com> <05cf3e20-6508-48c3-9e4c-9f2a2a719012@redhat.com>
 <cd236026-0bc9-424c-8d49-6bdc9daf5743@intel.com>
In-Reply-To: <cd236026-0bc9-424c-8d49-6bdc9daf5743@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 12 Sep 2024 16:09:21 +0200
Message-ID: <CABgObfbyd-a_bD-3fKmF3jVgrTiCDa3SHmrmugRji8BB-vs5GA@mail.gmail.com>
Subject: Re: [PATCH 25/25] KVM: x86: Add CPUID bits missing from KVM_GET_SUPPORTED_CPUID
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, seanjc@google.com, kvm@vger.kernel.org, 
	kai.huang@intel.com, isaku.yamahata@gmail.com, tony.lindgren@linux.intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 9:48=E2=80=AFAM Xiaoyao Li <xiaoyao.li@intel.com> w=
rote:
> On 9/11/2024 1:52 AM, Paolo Bonzini wrote:
> > On 8/13/24 00:48, Rick Edgecombe wrote:
> >> For KVM_TDX_CAPABILITIES, there was also the problem of bits that are
> >> actually supported by KVM, but missing from get_supported_cpuid() for =
one
> >> reason or another. These include X86_FEATURE_MWAIT, X86_FEATURE_HT and
> >> X86_FEATURE_TSC_DEADLINE_TIMER. This is currently worked around in
> >> QEMU by
> >> adjusting which features are expected.
>
> I'm not sure what issue/problem can be worked around in QEMU.
> QEMU doesn't expect these bit are reported by KVM as supported for TDX.
> QEMU just accepts the result reported by KVM.

QEMU already adds some extra bits, for example:

        ret |=3D CPUID_EXT_HYPERVISOR;
        if (kvm_irqchip_in_kernel() &&
                kvm_check_extension(s, KVM_CAP_TSC_DEADLINE_TIMER)) {
            ret |=3D CPUID_EXT_TSC_DEADLINE_TIMER;
        }

> The problem is, TDX module and the hardware allow these bits be
> configured for TD guest, but KVM doesn't allow. It leads to users cannot
> create a TD with these bits on.

KVM is not going to have any checks, it's only going to pass the
CPUID to the TDX module and return an error if the check fails
in the TDX module.

KVM can have a TDX-specific version of KVM_GET_SUPPORTED_CPUID, so
that we can keep a variant of the "get supported bits and pass them
to KVM_SET_CPUID2" logic, but that's it.

> > This is the kind of API that we need to present for TDX, even if the
> > details on how to get the supported CPUID are different.  Not because
> > it's a great API, but rather because it's a known API.
>
> However there are differences for TDX. For legacy VMs, the result of
> KVM_GET_SUPPORTED_CPUID isn't used to filter the input of KVM_SET_CPUID2.
> But for TDX, it needs to filter the input of KVM_TDX_VM_INIT.CPUID[]
> because TDX module only allows the bits that are reported as
> configurable to be set to 1.

Yes, that's userspace's responsibility.

> With current designed API, QEMU can only know which bits are
> configurable before KVM_TDX_VM_INIT, i.e., which bits can be set to 1 or
> 0 freely.

The API needs userspace to have full knowledge of the
requirements of the TDX module, if it wants to change the
defaults provided by KVM.

This is the same as for non-TDX VMs (including SNP).  The only
difference is that TDX and SNP fails, while non-confidential VMs
get slightly garbage CPUID.

> For other bits not reported as configurable, QEMU can know the exact
> value of them via KVM_TDX_GET_CPUID, after KVM_TDX_VM_INIT and before
> TD's running. With it, QEMU can validate the return value is matched
> with what QEMU wants to set that determined by users input. If not
> matched, QEMU can provide some warnings like what for legacy VMs:
>
>    - TDX doesn't support requested feature: CPUID.01H.ECX.tsc-deadline
> [bit 24]
>    - TDX forcibly sets features: CPUID.01H:ECX.hypervisor [bit 31]
>
> If there are ioctls to report the fixed0 bits and fixed1 bits for TDX,
> QEMU can validate the user's configuration earlier.

Yes, that's fine.

Paolo


