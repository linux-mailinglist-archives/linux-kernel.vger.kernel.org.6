Return-Path: <linux-kernel+bounces-185276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 083D58CB2FD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 19:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1761F22304
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF351487F7;
	Tue, 21 May 2024 17:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihHVYZ5j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19931487D4
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716313008; cv=none; b=oeojyLQxCjxyEiFyECyG6uZygEBHYLInTgy6l3oGX3yOcpwFWhk2qKK1NubkT3RazJsMpix6Eqml//t/L3UTnAXUyUnWk1AALXxM5SrSt480peFgpt4RWnyZXR7BK+3PmSeVlORO7aMlqOAotDrtYtogwlEU79VNk5mW/rvYa+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716313008; c=relaxed/simple;
	bh=wd0KBKKWgEMxHkVHXyAYq++wArTKYEyiWOm/WGzUV7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccgoluXv1V0NLcmBlXIFIJ4NIIzX2Y72qg5Ii1W934EWyPFLxPVadgck/zbNzbCIs0eaNH4aI8F+QagrBF9FewP/AQp2X8fBoosdkFGHHKbPlnvIVpFcaYD5ktD1nzdKeaNwtvUuyQUOSAMBUYGo9knC7yqgWhN3PthRPSC34/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ihHVYZ5j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716313005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5zUpod+RhthWixXTCuMGnpnj5+irE7qQCxPAzed+KE=;
	b=ihHVYZ5jC1N2ILBJ+/A0RsA4/UYYdFUGYdT8KQf7+MrT8LK2sV1R8i2vlSDGIT9TfTRQ56
	9FoNQIV0DIJ1retAE8r/vsgYJr3LuSGJSVwQ/xjeB29M7NWh0NTZk/nuiArFy7kvsrkVN8
	sNrzH87AyPGPbKxKI071GWpeQwhX9ME=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-7vMXpCsoPZ2IjVxEz7wEBA-1; Tue, 21 May 2024 13:36:43 -0400
X-MC-Unique: 7vMXpCsoPZ2IjVxEz7wEBA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4201f100188so46782355e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 10:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716312999; x=1716917799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5zUpod+RhthWixXTCuMGnpnj5+irE7qQCxPAzed+KE=;
        b=m1z7x8Y9EFPrXax5N8wdWnawoIVubtJz9QKZB0MDTIiTLgunTQleINDJXkUtz2B8KU
         eGhQ4YQaBCPk88lyItXpD5JVgwmne1e1vWom7FNnIL1u6fBW/qAjMjsdZwbDzFiCGtJi
         ZQVy2q2cdrQNI5t4OtQTyFICaC+vuddh1GJQBc6zXWh5m/UbuDxLZCF/LfbyqS4RUM2l
         jSg6ICiFZwclYwn5X84R9KcbXeQiGm0EyFB+Wl9eRgtEqxaiNL5qiS2yhrCDw8Ox5BWb
         oc0r6cVM6V8VvK5Vk4A2/VuB/Xdt5uZVywMb6kuzL7s8IKGBfP65Tu7g/bKwpyGbvPPV
         qwmA==
X-Forwarded-Encrypted: i=1; AJvYcCVvUZKoJwSoruokaXBAdX36NbYiI/4zRiPieZS1NwU9vp3BDndGwXrIKCHl6BSPTFQ2QrRk3IGCYe3TV0WZfSCerxse3NPNBxS8Ifh4
X-Gm-Message-State: AOJu0YyZb2JE1JcU4QCfraG6NF5ip+2i8bxaKvRAFnEym/PLVfc8VxUu
	QK58m5Eo328nCLJR8Eq58tJW2zJ7eemYQxKrlomInFrST7fKortj36QXI3jKG2YygMx9iE/02KO
	cItAAcIRff2F+pFaVigg0+RxDzU8oMoanM2t8fO28EAF/qojkwjvnyiWp3+OtiADZZcK40o33Ob
	gsfcA0SSFMqTiD21k7eA5a0ALm1EfJuG2twW+Diw0HOYTbA80=
X-Received: by 2002:a05:600c:35c2:b0:41c:2313:da92 with SMTP id 5b1f17b1804b1-41fea93afeemr277991505e9.4.1716312999337;
        Tue, 21 May 2024 10:36:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGndNhJCjRsgtfdjd7EnztAR09WI4tEm4q2+MYJA7kncWp/ZgsQ/grGnsNbVM0PTqn4dlJqpJWUz3TjMCFFBjw=
X-Received: by 2002:a05:600c:35c2:b0:41c:2313:da92 with SMTP id
 5b1f17b1804b1-41fea93afeemr277991385e9.4.1716312998926; Tue, 21 May 2024
 10:36:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240518000430.1118488-1-seanjc@google.com> <20240518000430.1118488-10-seanjc@google.com>
In-Reply-To: <20240518000430.1118488-10-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 May 2024 19:36:26 +0200
Message-ID: <CABgObfYo3jR7b4ZkkuwKWbon-xAAn+Lvfux7ifQUXpDWJds1hg@mail.gmail.com>
Subject: Re: [PATCH 9/9] KVM: x86: Disable KVM_INTEL_PROVE_VE by default
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2024 at 2:04=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
> Disable KVM's "prove #VE" support by default, as it provides no functiona=
l
> value, and even its sanity checking benefits are relatively limited.  I.e=
.
> it should be fully opt-in even on debug kernels, especially since EPT
> Violation #VE suppression appears to be buggy on some CPUs.

More #VE trapping than #VE suppression.

I wouldn't go so far as making it *depend* on DEBUG_KERNEL.  EXPERT
plus the scary help message is good enough.

What about this:

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index b6831e17ec31..2864608c7016 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -97,14 +97,15 @@ config KVM_INTEL

 config KVM_INTEL_PROVE_VE
         bool "Check that guests do not receive #VE exceptions"
-        depends on KVM_INTEL && DEBUG_KERNEL && EXPERT
+        depends on KVM_INTEL && EXPERT
         help
           Checks that KVM's page table management code will not incorrectl=
y
           let guests receive a virtualization exception.  Virtualization
           exceptions will be trapped by the hypervisor rather than injecte=
d
           in the guest.

-          This should never be enabled in a production environment.
+          Note that #VE trapping appears to be buggy on some CPUs.
+          This should never be enabled in a production environment!

           If unsure, say N.


Paolo

> Opportunistically add a line in the help text to make it abundantly clear
> that KVM_INTEL_PROVE_VE should never be enabled in a production
> environment.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 2a7f69abcac3..3468efc4be55 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -97,15 +97,15 @@ config KVM_INTEL
>
>  config KVM_INTEL_PROVE_VE
>          bool "Check that guests do not receive #VE exceptions"
> -        default KVM_PROVE_MMU || DEBUG_KERNEL
> -        depends on KVM_INTEL
> +        depends on KVM_INTEL && DEBUG_KERNEL && EXPERT
>          help
> -
>            Checks that KVM's page table management code will not incorrec=
tly
>            let guests receive a virtualization exception.  Virtualization
>            exceptions will be trapped by the hypervisor rather than injec=
ted
>            in the guest.
>
> +          This should never be enabled in a production environment.
> +
>            If unsure, say N.
>
>  config X86_SGX_KVM
> --
> 2.45.0.215.g3402c0e53f-goog
>


