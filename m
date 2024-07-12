Return-Path: <linux-kernel+bounces-250914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4487A92FE7B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFBA0281518
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C5717624A;
	Fri, 12 Jul 2024 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0762GMVx"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B161741F0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720801673; cv=none; b=JSby99PmQi6J4bpvBDny2NE9tzdF0TvsK07rPf/GLIg/GMuZjBOEqOU1aSoao8FclsyFdPGdqwH9+UhjydDlScKp0I6iNcHgxuv0Y5//wWHBPKBvWHlIcW6gKZpqOcvvO+OlKqJ3z8L6PpM4gYyClkcBSC5or+9uG4eZAWcE+NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720801673; c=relaxed/simple;
	bh=qwr8oCZNV/KmUE+KTkQdbZ4A96F4ooAb3w3bj6Z7kBU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jAU/yIgid77E8D5MGHnce/yFmeDVhNIhIeKQ2phBRLyaqOG4SgVwVp2aKBGsB+dqcqYjiSIH2iuX2v1Jkyg4cgoKXAhmStNw5cyx2Qqgy76aV82k9rhernxAv7nb4SotPoyxmsTI0dNbXaYKVVmEGs3oLR6dANTDnqwxeSyPtmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0762GMVx; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2c96cb48a8bso1928442a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720801669; x=1721406469; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wEYr9JA8qEfnEiiFVxdx0TK1LeJE+9gMywwztiTkPVc=;
        b=0762GMVx/dDBDmRsp4aAYeGY/VnLjuoMlkFevxfmJS+HX2N6PUR9Qdh1voUJzjR3Mk
         BQOIb+KUSFci8ZR1cmeYYJ8mWjGChj4DWGx5PvEPxAOKHBc1bFVeSaGqHKcIhvdO3Q6E
         wi+T9Mnz5jSO7YpcX9/1yKQzZMAiotJ4zDsfEmIxV/2/3MNG8+RRsOBExNmcyX1TjPw5
         MUr5rom2OJVi2PaSAcnDyOwSMVkLYNuf5UU+a5nGO98qw5SaGkZDFr5wlG31VR14qBBJ
         xrG6oH+Ykt3zpvqnkJjvIo0dZrknYhSdjAJEpegQVWwb86WQZsC+Qevt6q98JWXprX3M
         6LZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720801669; x=1721406469;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wEYr9JA8qEfnEiiFVxdx0TK1LeJE+9gMywwztiTkPVc=;
        b=ADpVJRY1thl76fQs8ODtwmyEpqHO6/74zQXftIdkUUH7bCCZos74sVwqwSJhmRC8rp
         zrXvhWN4khOdKmDLMyKQh51oTpALz6WVYlxFzMjjksazy9V0LZTWZRDQS0lYEwp6IREK
         iXXG2oiuwJgV7H/oiqpAeFKJQSRl34omfIg4LcAt+B5lgjgX9Fbsr2Gk1u/GIBHuMP/L
         h0VBPkYKFtuxAv3yc+iGa21jMk6or7rck4ef68CSXpzJLThDfUUrLK5w4hAO4yvBaN62
         MrZIcHhCKVyDNC+48AhyRqoxHHR+c9zS2aHfKSM+jHX7c50fs3adaub99gvMUnCAmVSc
         T4/g==
X-Gm-Message-State: AOJu0Yy9tiC3hcKcF3g326dmTGhYczzUeVZPW43Qwr14rJHzjADruX1U
	T4r/53XO50iGllH7xfCnF99LGY9e/0MxYTtT9QAiwEe3TvcVhAJHogw74u+aSkrVN3TstB8t+Cl
	L8w==
X-Google-Smtp-Source: AGHT+IExMjSzRoFzJZULA3iZrj2G4RD4SsmatrlRYdXUdzDN8jkO4bSuFKvy2f442Y3Vs24dL56BOimEEwQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:257:b0:2c9:a168:9719 with SMTP id
 98e67ed59e1d1-2ca35d4ea2bmr27995a91.6.1720801669355; Fri, 12 Jul 2024
 09:27:49 -0700 (PDT)
Date: Fri, 12 Jul 2024 09:27:47 -0700
In-Reply-To: <SA1PR11MB67341A4D3E4D11DAE8AF6D2EA8A62@SA1PR11MB6734.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-10-xin3.li@intel.com>
 <ZmoYvcbFBPJ5ARma@google.com> <SA1PR11MB67348BD07CCCF8D52FCAC8FEA8A42@SA1PR11MB6734.namprd11.prod.outlook.com>
 <ZpFH86n_YY5ModwK@google.com> <SA1PR11MB67341A4D3E4D11DAE8AF6D2EA8A62@SA1PR11MB6734.namprd11.prod.outlook.com>
Message-ID: <ZpFZg-9MTveHfn_4@google.com>
Subject: Re: [PATCH v2 09/25] KVM: VMX: Switch FRED RSP0 between host and guest
From: Sean Christopherson <seanjc@google.com>
To: Xin3 Li <xin3.li@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	Ravi V Shankar <ravi.v.shankar@intel.com>, "xin@zytor.com" <xin@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 12, 2024, Xin3 Li wrote:
> > > > > Switch MSR_IA32_FRED_RSP0 between host and guest in
> > Alternatively, is the desired RSP0 value tracked anywhere other than the MSR?
> 
> Yes, It's simply "(unsigned long)task_stack_page(task) + THREAD_SIZE".
> 
> > E.g. if it's somewhere in task_struct, then kvm_on_user_return() would restore
> > the current task's desired RSP0.
> 
> So you're suggesting to extend the framework to allow per task constants?

Yeah, or more likely, special case MSR_IA32_FRED_RSP0.  If KVM didn't already
have the user return framework, I wouldn't suggest this as I doubt avoiding WRMSR
when switching between vCPU tasks will be very meaningful, but it's easy to handle
FRED_RSP0, so why not.

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1783986d8626..ebecb205e5de 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -352,6 +352,7 @@ static void kvm_on_user_return(struct user_return_notifier *urn)
                = container_of(urn, struct kvm_user_return_msrs, urn);
        struct kvm_user_return_msr_values *values;
        unsigned long flags;
+       u64 host_val;
 
        /*
         * Disabling irqs at this point since the following code could be
@@ -365,9 +366,15 @@ static void kvm_on_user_return(struct user_return_notifier *urn)
        local_irq_restore(flags);
        for (slot = 0; slot < kvm_nr_uret_msrs; ++slot) {
                values = &msrs->values[slot];
-               if (values->host != values->curr) {
-                       wrmsrl(kvm_uret_msrs_list[slot], values->host);
-                       values->curr = values->host;
+
+               if (kvm_uret_msrs_list[slot] == MSR_IA32_FRED_RSP0)
+                       host_val = get_current_fred_rsp0();
+               else
+                       host_val = values->host;
+
+               if (host_val != values->curr) {
+                       wrmsrl(kvm_uret_msrs_list[slot], host_val);
+                       values->curr = host_val;
                }
        }
 }

