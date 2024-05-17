Return-Path: <linux-kernel+bounces-182513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC888C8C33
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 20:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 873B8B22EA6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 18:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286AC13E02C;
	Fri, 17 May 2024 18:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yTRYcepZ"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C951FC8
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 18:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715969886; cv=none; b=opy2b/2ychvbFP1JDrcwljTdnx0KjNkhe2tVFo5qYqDS7Xx4AtrJletL/Qh3jAK638gwg3dGllEaAMtrtbtkkqPy+B6ZNU6LYqGnGSrzoOUab2T1fh9KkAC7Od7f1EhBFofGk3VzKrHGAxJ46BJUxP0iDxOKfKsdh+rMPsWPvkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715969886; c=relaxed/simple;
	bh=aky1cahglAB1y4MqK2Iamwqc//KM6c7IOYkdVF4P1To=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D0xZSZOn9WKQ9hbYT29Ee1NTOnW18DIshq6yY/+5iKq2OLpQ0/3mNAXVSg/NQGaCK0DES6FBRUusSmuhqcMhz/amil2kN6pUBak63w83arBwJWfFIcEkDZXVJT9O6Qe5riffIXbOQ73L99ssmoXEn+ay+8i58g9ZF1yx4d9cGO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yTRYcepZ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2b96f302d84so4489201a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 11:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715969883; x=1716574683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8xVzAsGv+y30edk8rMoB9eS/H+1j0ce9hhs1hSlbOiw=;
        b=yTRYcepZciaXZLDku/OgRdY1s5CMUiMTWIFFVUQh0LSEVZkIf6tXsea3aI/uAiHmRF
         1lEobEXReNUCvDxXZA15LhLSr7VpOao9wMYW2Wi9D2fdYGAVdivvzMPoDDty61LzG/Q1
         Bc/t75Cb5CcY1sZDHjyoBRixunt3ORQ71VW/3asQrtirJLYorPAw4WmHFP/t5amSwwNW
         gIcAytjV4bGfna6vCojcRUDkEzJD1mrkKEySzkL2gC/hK8alwLCzCu1Vv4fr/qWVn3sw
         ZjexkwQkO7M1v94FTIfVdL2WYxO6FW+DRT5X7XGLBP5x8M/lEQNtz2mcuSYicxFzedsf
         RmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715969883; x=1716574683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8xVzAsGv+y30edk8rMoB9eS/H+1j0ce9hhs1hSlbOiw=;
        b=XXwUnzky7HQmA1+COnNnd/PpiRiT7xDiPXtFKPyYPoxQw+DjPqKfY3sFTjL3/9toDa
         mS8WjmvT7ht2S444qitkE90rY6sANqPUpLTkbjKvvdh6cyr4+c9Ows0aeeRia0x3wBPl
         XtrrG1xDscvQxc1O+AEXtezrD8M23B8RcuHSsKCeJvroGXBtiFpsERI+Xb1XyIbTxrzc
         v9DRPRmF9N1/ITzhaAAMI3fg5INFzgak0ZxhMmwDouSOkvdKrtXctjtE04+0zv4ifSJg
         UAlBoP/k/AIQFSFTPJb1wEBWA4jMg7rbfcCWGJbYZgPDymES/M0DcrUFkuzgflffL1WF
         BLEg==
X-Gm-Message-State: AOJu0YwX7GWV1BSqS6I2v3N1GJfocfxYXGeXjwxqd4u+qRw67bF3eeQh
	W5smV5h62ljgQOcd60sQmJ2ZWmULq+1IoSYkNXUR1vGkfMJWj9GNNWC0ssbveQ/jLU7cz61yx8e
	b4Q==
X-Google-Smtp-Source: AGHT+IGPkl9n5BpMbeHRuLtgY41tMM51adcGfN6Aj5GCBRsJDZjY2oEAyerlriT9sgOl6jtQP/0tAMw8Kdc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:440b:b0:2b1:6a65:c73a with SMTP id
 98e67ed59e1d1-2b6cc03b3bemr78411a91.2.1715969883448; Fri, 17 May 2024
 11:18:03 -0700 (PDT)
Date: Fri, 17 May 2024 11:17:55 -0700
In-Reply-To: <2450ce49-2230-45a2-bc0d-b21071f2cce6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507154459.3950778-1-pbonzini@redhat.com> <20240507154459.3950778-8-pbonzini@redhat.com>
 <ZkVHh49Hn8gB3_9o@google.com> <7c0bbec7-fa5c-4f55-9c08-ca0e94e68f7c@redhat.com>
 <ZkeH8agqiHzay5r9@google.com> <2450ce49-2230-45a2-bc0d-b21071f2cce6@redhat.com>
Message-ID: <ZkefU_PhjvnaEE7Q@google.com>
Subject: Re: [PATCH 7/7] KVM: VMX: Introduce test mode related to EPT
 violation VE
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Isaku Yamahata <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, May 17, 2024, Paolo Bonzini wrote:
> On 5/17/24 18:38, Sean Christopherson wrote:
> > > > I've hit this three times now when running KVM-Unit-Tests (I'm pretty sure it's
> > > > the EPT test, unsurprisingly).  And unless I screwed up my testing, I verified it
> > > > still fires with Isaku's fix[*], though I'm suddenly having problems repro'ing.
> > > > 
> > > > I'll update tomorrow as to whether I botched my testing of Isaku's fix, or if
> > > > there's another bug lurking.
> > > > 
> > > > https://lore.kernel.org/all/20240515173209.GD168153@ls.amr.corp.intel.com
> > > I cannot reproduce it on a Skylake (Xeon Gold 5120), with or without Isaku's
> > > fix, with either ./runtests.sh or your reproducer line.
> > > 
> > > However I can reproduce it only if eptad=0 and with the following line:
> > > 
> > > ./x86/run x86/vmx.flat -smp 1 -cpu max,host-phys-bits,+vmx -m 2560 \
> > >    -append 'ept_access_test_not_present ept_access_test_read_only'
> > 
> > FWIW, I tried that on RPL, still no failure.
> 
> Ok, so it does look like a CPU issue.  Even with the fixes you identified, I
> don't see any other solution than adding scary text in Kconfig, defaulting
> it to "n", and adding an also-very-scary pr_err_once("...") the first time
> VMPTRLD is executed with CONFIG_KVM_INTEL_PROVE_VE.

I don't think we need to make it super scary, at least not yet.  KVM just needs
to not kill the VM, which thanks to the BUSY flag is trivial: just resume the guest.
Then the failure is "just" a WARN, which won't be anywhere near as problematic for
KVM developers.  I doubt syzbot will hit this, purely because syzbot runs almost
exclusively in VMs, i.e. won't have #VE support.

If we don't have a resolution by rc6 or so, then maybe consider doing something
more drastic?

I agree that it should be off by default though.  And the help text should be
more clear that this intended only for developers and testing environments.

I have a handful of patches, including one to not kill the VM.  I'll try to post
them later today, mostly just need to write changelogs.

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 75082c4a9ac4..5c22186671e9 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -98,15 +98,15 @@ config KVM_INTEL
 
 config KVM_INTEL_PROVE_VE
         bool "Check that guests do not receive #VE exceptions"
-        default KVM_PROVE_MMU || DEBUG_KERNEL
-        depends on KVM_INTEL
+        depends on KVM_INTEL && KVM_PROVE_MMU
         help
-
           Checks that KVM's page table management code will not incorrectly
           let guests receive a virtualization exception.  Virtualization
           exceptions will be trapped by the hypervisor rather than injected
           in the guest.
 
+          This should never be enabled in a production environment.
+
           If unsure, say N.
 
 config X86_SGX_KVM


