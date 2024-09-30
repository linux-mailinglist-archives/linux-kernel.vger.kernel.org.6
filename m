Return-Path: <linux-kernel+bounces-344487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D07C098AA54
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C161F23D33
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB7D194C79;
	Mon, 30 Sep 2024 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u6BxRKVf"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB6A193426
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715185; cv=none; b=TguRFqnzA8fOn+29+AE5bMesZL47B/L9VMxQMorHcmt89gl8WfXt7gM7y0W8FSjtXwGvOFuSljLaJtkZMQn98azjOii5FCj2Pg+kwhIedPoCy9PikC5tGcWWY4EenudGeBPBbqL3f+oaoIJkWg5icUXPuHbKRxDYCGPbQ8J4atk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715185; c=relaxed/simple;
	bh=/Vjl/ZJLHSij4d9eWY+B4SNisMmOORAdCrjxxFVqiA0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AzSuc/8EJiwYUWuVd456GJRQzT2T+5uGSMnX7bhUwkB1aWU0Sbon33+3oxePjJmCMeTQqJD9NcVaID63A//XZDWiVfMKRstDkPbQDv4RLTV3iMpdnyYMECsxYRGC4KbNsqzm+mYHR4nDT9jfyUJv/pAQDp1q53MvjJcTsRf5hjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u6BxRKVf; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2e08517d5afso4429858a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 09:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727715183; x=1728319983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEwQEY6QLu2ZxCHrJG6gmvFcLB+g6ofk2SqEEjVaHwA=;
        b=u6BxRKVfKtR2qejJJA2U0iCWjXtKeTnerPHJ2Y7WfVpzciYjsc/MGIb0ja/xo2E5rG
         CY3jvgBW23zKabCoHnwVUqbthDcsMrbOUgD3Rzd2b1ywMwLMQ9SS8sxIQzuOQm+Wck9T
         RNMvT8K/a7C7yv7QeA6ERTI0z9haAi6XOPYMD5bGaS3yh0VGl6UMq1Nhx2OkRgI6ppJX
         klF5kwWl2VHzso8Hof6IlNqUAhazU0mPIrBDdiKgv0LwLRafZ+fcpF8+/Iv3Ej8HcCO7
         Cp/EhF6qzIZAYsBA15l+lVz/2qu2av8fPRnUwUgb5A0yWZGei/x10vL+EpbslILUGod6
         jNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727715183; x=1728319983;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oEwQEY6QLu2ZxCHrJG6gmvFcLB+g6ofk2SqEEjVaHwA=;
        b=ASN6iRi2M8SW5KCPidTeOAW+VDOd7NwXpPTFpl+5qHMkwtC20TvBQCABx6sv4xGWJN
         dre1pP31PYZVr41HQNwZMGgC6iY0ur3JHgq2avi11AL2iPXbFKQf7zk7qjtNVoDSpeJG
         0lM9kTPqaFIyLoU4g/IwQ3A4PGFOj07GcwwiPrHH9FLuQgCSvFJeFS59AnGoG5SupMEG
         Y2szovvdruFvWRD2iX0taMlIP9V97stYUxBelDQ/J0NijP7AOyPO6bXOMKXP0tguAaBH
         EYXKiVnABn5uz6Vum+vFxXbBxB7GSfb48Wfgz65L+FMt+71Hhjk9fT10JVAa1RhOc+ku
         s9Og==
X-Forwarded-Encrypted: i=1; AJvYcCWwX3buKGH/eRGLD1NNY/xR+cAtJxL34zIq0fLNHsiW7C2DDdJ4CAE9xuzjrajf+GMsigasKTuEEmpqP0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+YFJzbfKZj/zp7U8NlfIv3i+Ex/C858Vp6TTJ33AA1NSvvNq0
	IDowvGUYITodFwmoI0GyZg4Emvp6WT9ZXkFl+TUDfiwdmmWRbTgcE6LGJUjQBNL1RMtV3+xhBTk
	Qaw==
X-Google-Smtp-Source: AGHT+IENEpbjiPuFVUxbg28yfnUOvGYGhS5DjWHlgtklGL/S8Zda/DNWAcGsWoAHYkdhQO6qxgpJK5aavAI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:dd8f:b0:2d8:817b:a22b with SMTP id
 98e67ed59e1d1-2e15a35b0e3mr361a91.3.1727715182847; Mon, 30 Sep 2024 09:53:02
 -0700 (PDT)
Date: Mon, 30 Sep 2024 09:53:01 -0700
In-Reply-To: <a402dec0-c8f5-4f10-be5d-8d7263789ba1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240928153302.92406-1-pbonzini@redhat.com> <CAHk-=wiQ2m+zkBUhb1m=m6S-H1syAgWmCHzit9=5y7XsriKFvw@mail.gmail.com>
 <a402dec0-c8f5-4f10-be5d-8d7263789ba1@redhat.com>
Message-ID: <ZvrXbRLzAThvpoj4@google.com>
Subject: Re: [GIT PULL] KVM/x86 changes for Linux 6.12
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kai Huang <kai.huang@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Farrah Chen <farrah.chen@intel.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024, Paolo Bonzini wrote:
> On Sun, Sep 29, 2024 at 7:36=E2=80=AFPM Linus Torvalds <torvalds@linux-fo=
undation.org> wrote:
> > The culprit is commit 590b09b1d88e ("KVM: x86: Register "emergency
> > disable" callbacks when virt is enabled"), and the reason seems to be
> > this:
> >=20
> >   #if IS_ENABLED(CONFIG_KVM_INTEL) || IS_ENABLED(CONFIG_KVM_AMD)
> >   void cpu_emergency_register_virt_callback(cpu_emergency_virt_cb *call=
back);
> >   ...
> >=20
> > ie if you have a config with KVM enabled, but neither KVM_INTEL nor
> > KVM_AMD set, you don't get that callback thing.
> >=20
> > The fix may be something like the attached.
>=20
> Yeah, there was an attempt in commit 6d55a94222db ("x86/reboot:
> Unconditionally define cpu_emergency_virt_cb typedef") but that only
> covers the headers and the !CONFIG_KVM case; not the !CONFIG_KVM_INTEL
> && !CONFIG_KVM_AMD one that you stumbled upon.
>=20
> Your fix is not wrong, but there's no point in compiling kvm.ko if
> nobody is using it.
>=20
> This is what I'll test more and submit:
>=20
> ------------------ 8< ------------------
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] KVM: x86: leave kvm.ko out of the build if no vendor mod=
ule is requested
> kvm.ko is nothing but library code shared by kvm-intel.ko and kvm-amd.ko.
> It provides no functionality on its own and it is unnecessary unless one
> of the vendor-specific module is compiled.  In particular, /dev/kvm is
> not created until one of kvm-intel.ko or kvm-amd.ko is loaded.
> Use CONFIG_KVM to decide if it is built-in or a module, but use the
> vendor-specific modules for the actual decision on whether to build it.
> This also fixes a build failure when CONFIG_KVM_INTEL and CONFIG_KVM_AMD
> are both disabled.  The cpu_emergency_register_virt_callback() function
> is called from kvm.ko, but it is only defined if at least one of
> CONFIG_KVM_INTEL and CONFIG_KVM_AMD is provided.
>=20
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>=20
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 4287a8071a3a..aee054a91031 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -17,8 +17,8 @@ menuconfig VIRTUALIZATION
>  if VIRTUALIZATION
> -config KVM
> -	tristate "Kernel-based Virtual Machine (KVM) support"
> +config KVM_X86_COMMON
> +	def_tristate KVM if KVM_INTEL || KVM_AMD
>  	depends on HIGH_RES_TIMERS
>  	depends on X86_LOCAL_APIC
>  	select KVM_COMMON
> @@ -46,6 +47,9 @@ config KVM
>  	select KVM_GENERIC_HARDWARE_ENABLING
>  	select KVM_GENERIC_PRE_FAULT_MEMORY
>  	select KVM_WERROR if WERROR
> +
> +config KVM
> +	tristate "Kernel-based Virtual Machine (KVM) support"

I like the idea, but allowing users to select KVM=3Dm|y but not building an=
y parts
of KVM seems like it will lead to confusion.  What if we hide KVM entirely,=
 and
autoselect m/y/n based on the vendor modules?  AFAICT, this behaves as expe=
cted.

Not having documentation for kvm.ko is unfortunate, but explaining how kvm.=
ko
interacts with kvm-{amd,intel}.ko probably belongs in Documentation/virt/kv=
m/?
anyways.

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 730c2f34d347..4350b83b63d8 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -18,7 +18,7 @@ menuconfig VIRTUALIZATION
 if VIRTUALIZATION
=20
 config KVM
-       tristate "Kernel-based Virtual Machine (KVM) support"
+       def_tristate m if KVM_INTEL=3Dm || KVM_AMD=3Dm
        depends on X86_LOCAL_APIC
        select KVM_COMMON
        select KVM_GENERIC_MMU_NOTIFIER
@@ -45,19 +45,6 @@ config KVM
        select KVM_GENERIC_HARDWARE_ENABLING
        select KVM_GENERIC_PRE_FAULT_MEMORY
        select KVM_WERROR if WERROR
-       help
-         Support hosting fully virtualized guest machines using hardware
-         virtualization extensions.  You will need a fairly recent
-         processor equipped with virtualization extensions. You will also
-         need to select one or more of the processor modules below.
-
-         This module provides access to the hardware capabilities through
-         a character device node named /dev/kvm.
-
-         To compile this as a module, choose M here: the module
-         will be called kvm.
-
-         If unsure, say N.
=20
 config KVM_WERROR
        bool "Compile KVM with -Werror"
@@ -88,7 +75,8 @@ config KVM_SW_PROTECTED_VM
=20
 config KVM_INTEL
        tristate "KVM for Intel (and compatible) processors support"
-       depends on KVM && IA32_FEAT_CTL
+       depends on IA32_FEAT_CTL
+       select KVM if KVM_INTEL=3Dy
        help
          Provides support for KVM on processors equipped with Intel's VT
          extensions, a.k.a. Virtual Machine Extensions (VMX).
@@ -125,7 +113,8 @@ config X86_SGX_KVM
=20
 config KVM_AMD
        tristate "KVM for AMD processors support"
-       depends on KVM && (CPU_SUP_AMD || CPU_SUP_HYGON)
+       depends on CPU_SUP_AMD || CPU_SUP_HYGON
+       select KVM if KVM_AMD=3Dy
        help
          Provides support for KVM on AMD processors equipped with the AMD-=
V
          (SVM) extensions.


>  	help
>  	  Support hosting fully virtualized guest machines using hardware
>  	  virtualization extensions.  You will need a fairly recent
> diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
> index 5494669a055a..4304c89d6b64 100644
> --- a/arch/x86/kvm/Makefile
> +++ b/arch/x86/kvm/Makefile
> @@ -32,7 +32,7 @@ kvm-intel-y		+=3D vmx/vmx_onhyperv.o vmx/hyperv_evmcs.o
>  kvm-amd-y		+=3D svm/svm_onhyperv.o
>  endif
> -obj-$(CONFIG_KVM)	+=3D kvm.o
> +obj-$(CONFIG_KVM_X86_COMMON) +=3D kvm.o
>  obj-$(CONFIG_KVM_INTEL)	+=3D kvm-intel.o
>  obj-$(CONFIG_KVM_AMD)	+=3D kvm-amd.o
> ------------------ 8< ------------------
>=20
> On top of this, the CONFIG_KVM #ifdefs could be changed to either
> CONFIG_KVM_X86_COMMON or (most of them) to CONFIG_KVM_INTEL; I started
> cleaning up the Kconfigs a few months ago and it's time to finish it
> off for 6.13.

If you haven't already, can you also kill off KVM_COMMON?  The only usage i=
s in
scripts/gdb/linux/constants.py.in, to print Intel's posted interrupt IRQs i=
n
scripts/gdb/linux/interrupts.py, which is quite ridiculous.

