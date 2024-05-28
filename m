Return-Path: <linux-kernel+bounces-192887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D088D2388
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310311C22D83
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC84D17106F;
	Tue, 28 May 2024 18:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uRbUt9YL"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB3739FFB
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716922465; cv=none; b=CBhTG4Z3xyd0CmkpiTGDRRkRA/eRFpicjFLVJ4V+VloGw4/p2dBmhkxUJVEGlpUmHHEJ0kiKYSJEuVChPpmfrvo0BpU1fSdwnDvPSZX6ARs40UTmmpz58VC10bjm3HKq4Qf0s467qreRMdN9b0onZFjf3/lOm3hkP7qDl7HloK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716922465; c=relaxed/simple;
	bh=XjKB9lMK3weOkRqQznxEfeDYvHTiHYFA26fDuZyRHLU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qv29BCIttS3YqKaYnFYRbGIkTkbed54eML1CFG+nquySZ2XASUMJTaRn5UCewCLMX/RnmeRlcl4etj/+Yt2EZ42NbO84HKKliT7NQYOa9btPqOBuXdRDZWtxK10kWlbjbOzn9mumXeuDxf+XmdiypvQS61XHC894Z2VfdX0axiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uRbUt9YL; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6819fd023b9so1291166a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716922463; x=1717527263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vF5iO2/CLnl6BCwM18Rm/a6cGRlrHRV+x/d0GOpSVW4=;
        b=uRbUt9YLagloMhdkm6dV0Vo6AtTRPxZf1nnGH5X/3zaoB24JeN81XVTFgLsiosh/Qk
         oaW0RwTL/V5gqimd7kyZCzU8OkpMtWvrjGXJ5kZ/SuYYRsDIkrSG+1y2rwlJyYgLt/8j
         hbBpH6ZO51eDqhvmu6x1/WWTywgr6Wnow+fXKxDWr3xU+CxwSeT4Q7NuOV1arE1XJpAO
         Nq+HwwTdSwt6aTZSp6w6WwY7bsc95Q9FhunT81zxiI7LBqLhD16BtKbnnuhBTbXJZADO
         UliZHn33A64tqZcLht6EfoIAeYjjE4b+iLizaW3IvpkOY7MLRwz7Iws23dxJIaLWS2nR
         1MfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716922463; x=1717527263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vF5iO2/CLnl6BCwM18Rm/a6cGRlrHRV+x/d0GOpSVW4=;
        b=rraRdqHEwLv6XcqOpufPRiJJuFI3QYS+DFGXv2k9Zpg9csLuKz8e2u4+cUAxLKGDRw
         dwMhNDIf+qRrFG/4mt4QdemR+Xp9nRIdCOQnrF04o5kn880emJv7Jc3+0WAr/C+NBNGM
         6Eb+C+zS1yomAo2eUQCa9PGOmJ0UYhHMjNhmBj8OAzuZIAndXoZjp1b9Ntb9tc48+Wh7
         HtqkHE7EDGgvWk0Dtpj/LwqrWXp5bTUxNG8cfTmZIVJpZmoerSXVnVG+sF7Ub43TwTVX
         lVKTpBzTObi1zYa0H2/Bz8yBGXCwegNiVz15V+lmZwavkI11ot8Ko/An/fCtxtRuMq6b
         PtuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgo6Si3c5eXbw2EWFB2GJahbJCX8Nr7BI76EVj4fKIl7vdtJ4W9WYViPnS0f6kKBcp2cvbXka5zhk7HeCpTnsCGm37teBuwby43MXO
X-Gm-Message-State: AOJu0Yz1KwwDM54M4bpn+9oJ2+MsW6LeLILehFqN8ubywjLMqGpYN9Fp
	NjcO1QM9ezX24AmXQhwHmyR/ZUNXwy1j8FTZIVrInShb7JHXR0TKKlPZSUiwH8qHJHRKkCRICxi
	u4A==
X-Google-Smtp-Source: AGHT+IHZ8xHJVep2OJ2nfEnf3wxs4HlLEBkQLwwY9dzNuA2RoPiVORZFKSEwyGSnVgAX+c5WpSrZJsRNY3g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:778c:0:b0:65c:2c22:111 with SMTP id
 41be03b00d2f7-681ad64b81dmr36484a12.8.1716922463270; Tue, 28 May 2024
 11:54:23 -0700 (PDT)
Date: Tue, 28 May 2024 11:54:21 -0700
In-Reply-To: <7ed7f3b7-4970-4723-8969-6452aed41b01@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com> <20240517173926.965351-21-seanjc@google.com>
 <7ed7f3b7-4970-4723-8969-6452aed41b01@linux.intel.com>
Message-ID: <ZlYoXYzW70gbljHk@google.com>
Subject: Re: [PATCH v2 20/49] KVM: x86: Rename kvm_cpu_cap_mask() to kvm_cpu_cap_init()
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	Kechen Lu <kechenl@nvidia.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 22, 2024, Binbin Wu wrote:
> On 5/18/2024 1:38 AM, Sean Christopherson wrote:
> > Rename kvm_cpu_cap_mask() to kvm_cpu_cap_init() in anticipation of merging
> > it with kvm_cpu_cap_init_kvm_defined(), and in anticipation of _setting_
> > bits in the helper (a future commit will play macro games to set emulated
> > feature flags via kvm_cpu_cap_init()).
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/x86/kvm/cpuid.c | 36 ++++++++++++++++++------------------
> >   1 file changed, 18 insertions(+), 18 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > index a802c09b50ab..5a4d6138c4f1 100644
> > --- a/arch/x86/kvm/cpuid.c
> > +++ b/arch/x86/kvm/cpuid.c
> > @@ -74,7 +74,7 @@ u32 xstate_required_size(u64 xstate_bv, bool compacted)
> >    * Raw Feature - For features that KVM supports based purely on raw host CPUID,
> >    * i.e. that KVM virtualizes even if the host kernel doesn't use the feature.
> >    * Simply force set the feature in KVM's capabilities, raw CPUID support will
> > - * be factored in by kvm_cpu_cap_mask().
> > + * be factored in by __kvm_cpu_cap_mask().
> 
> kvm_cpu_cap_init()?

Drat, yes.  IIRC, I tried to get clever to avoid having to update this comment a
second time, but then I ended up removing __kvm_cpu_cap_mask() entirely.

