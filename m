Return-Path: <linux-kernel+bounces-513254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CC0A34630
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3912216F14E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856C5139566;
	Thu, 13 Feb 2025 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jlESITdj"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752E626B0B8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459841; cv=none; b=rElRUoGV/yU4JFwq3GSTJHxl8nMGs7cd09OcKhCJxpXmbpY2DTyMzvJNxfjGhVmCzvABB3kNRD9JMj7nKoJVlhmygrdNHhzM5dkpLBXMDrNnQLHC3M7huBDpMX1ehd/A2oLb6qGfkbBU6/njctFBsXWMbjBY7K3yMm8p5ejYdSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459841; c=relaxed/simple;
	bh=s+JnwwgybD5c8wcFAbgzYyrwhvw2mcU6LOxkjYGlr8Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DkhS6alYul/5vCJoX6cQvmME2BSm5UKPuDBwBSQZ8fr/K2W2lV4DjpP1qbnGHJO6b0Xe2k7wljG3fTYUsJjJ67KB04x3T+imW8Wyi5VSGuyRE46wiXz+5GeOwJwTJ62LKWDCMllcVQyRI9s7lP35MRftnATvo781FUhAC8Q5UrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jlESITdj; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fbfa786a1aso3427222a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 07:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739459840; x=1740064640; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eOwHWbAixNGdS5d63qBoFewmVLXrDRZ9JT49WkI2vX4=;
        b=jlESITdjXfQzR9CtSvtHlEgLjJN+/2RAr/LsdSgNVV2+udMVo1RSr5N84sqscFiCpy
         eP6rPg8SYwKDeNI1tNj9wmatDAxRYs5ANSquxoKneOJNomU+LCwQGaoXojt1IDobV8GV
         1V0YVxzFX1N7M/tryopgKEOTzZjXwYaYZe6f8osyq5KFq4jcO8/xKkJ8Ohaq8P9P2JlS
         FSpQhWrjx4a2wEvAosPSgvxi+00kvrOZMeb05sxW0vOywFMql+9nlLSIdZNIUMUUj9Nl
         zaRCAnfnIUVcKxdQxkhZeO6YLdl7pcBwNSmIOI/VgTmsHZ6vzIcK7543QnWIaHAinYzI
         fIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739459840; x=1740064640;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eOwHWbAixNGdS5d63qBoFewmVLXrDRZ9JT49WkI2vX4=;
        b=OPIVXjOtNMgkV7L7EaUTz39frc9qoQMyRlzj+D2wb+1+8fhcfb8PbTRuzlM5dkxPi/
         1SaeY4AEzFuY39lXRNKnZIVGLk6OvhoLYFsj+VgfwBDq6eYhNGtAKkqAG8Ol2g9jRiKC
         zDDcPlLMgDDcUXjIwCSMFxmgE8+YMBm6FChQyhe9Dqlo5rhziSre8V7T4NiiwiKrL+cE
         LnaHC8N1uzlnt48e1Hae4W8J2uQEsj1oJDLnEjeGo8o7svLNeYJ2ui9gXFJmk44iXm//
         gHbiAVbLTCt6Ou+LwG1nalzEjPNEJvcsCCsQBSanYnWYbCuCxf8Ol+C0gKBAucNfwnjb
         vRUg==
X-Forwarded-Encrypted: i=1; AJvYcCVDsFgUmNK/c+gSFwT2gfouTJL3kEpOtfQ2Sx/6nD7n40TUOUC9N6qB8D/jjEpaUwOTj4JTKjhQywBTRQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhdcdcoA1Om/x6EaC1vl2Nyd5F5y1w7R42oz0BpgiTRuIb/x0k
	83lEugZTRqT6Ei216eW9n1Uhq7uSZllWtM/HwfxBQH0i38tGUAz7B95pnGr685imswbc8t6wvDx
	eDw==
X-Google-Smtp-Source: AGHT+IGsi9yJU25HvdPk8HOYfcll3xvyhe/BnSZ4dy+lHC/8X4HkqcVKif5dPKQXJcJUFZhpfpccD6DC6tM=
X-Received: from pfjd17.prod.google.com ([2002:a05:6a00:2451:b0:730:8566:41dd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e84:b0:730:937f:e835
 with SMTP id d2e1a72fcca58-7323c1c7e5dmr4736495b3a.17.1739459839665; Thu, 13
 Feb 2025 07:17:19 -0800 (PST)
Date: Thu, 13 Feb 2025 07:17:18 -0800
In-Reply-To: <c47f0fa1-b400-4186-846e-84d0470d887e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250211025442.3071607-1-binbin.wu@linux.intel.com>
 <20250211025442.3071607-6-binbin.wu@linux.intel.com> <Z6r0Q/zzjrDaHfXi@yzhao56-desk.sh.intel.com>
 <926a035f-e375-4164-bcd8-736e65a1c0f7@linux.intel.com> <Z6sReszzi8jL97TP@intel.com>
 <Z6vvgGFngGjQHwps@google.com> <3033f048-6aa8-483a-b2dc-37e8dfb237d5@linux.intel.com>
 <Z6zu8liLTKAKmPwV@google.com> <f12e1c06-d38d-4ed0-b471-7f016057f604@linux.intel.com>
 <c47f0fa1-b400-4186-846e-84d0470d887e@linux.intel.com>
Message-ID: <Z64M_r64CCWxSD5_@google.com>
Subject: Re: [PATCH v2 5/8] KVM: TDX: Handle TDG.VP.VMCALL<MapGPA>
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Chao Gao <chao.gao@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com, 
	kvm@vger.kernel.org, rick.p.edgecombe@intel.com, kai.huang@intel.com, 
	adrian.hunter@intel.com, reinette.chatre@intel.com, xiaoyao.li@intel.com, 
	tony.lindgren@intel.com, isaku.yamahata@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 13, 2025, Binbin Wu wrote:
> On 2/13/2025 11:23 AM, Binbin Wu wrote:
> > On 2/13/2025 2:56 AM, Sean Christopherson wrote:
> > > On Wed, Feb 12, 2025, Binbin Wu wrote:
> > > > On 2/12/2025 8:46 AM, Sean Christopherson wrote:
> > > > > I am completely comfortable saying that KVM doesn't care about STI/SS shadows
> > > > > outside of the HALTED case, and so unless I'm missing something, I think it makes
> > > > > sense for tdx_protected_apic_has_interrupt() to not check RVI outside of the HALTED
> > > > > case, because it's impossible to know if the interrupt is actually unmasked, and
> > > > > statistically it's far, far more likely that it _is_ masked.
> > > > OK. Will update tdx_protected_apic_has_interrupt() in "TDX interrupts" part.
> > > > And use kvm_vcpu_has_events() to replace the open code in this patch.
> > > Something to keep an eye on: kvm_vcpu_has_events() returns true if pv_unhalted
> > > is set, and pv_unhalted is only cleared on transitions KVM_MP_STATE_RUNNABLE.
> > > If the guest initiates a spurious wakeup, pv_unhalted could be left set in
> > > perpetuity.
> > 
> > Oh, yes.
> > KVM_HC_KICK_CPU is allowed in TDX guests.

And a clever guest can send a REMRD IPI.

> > The change below looks good to me.
> > 
> > One minor issue is when guest initiates a spurious wakeup, pv_unhalted is
> > left set, then later when the guest want to halt the vcpu, in
> > __kvm_emulate_halt(), since pv_unhalted is still set and the state will not
> > transit to KVM_MP_STATE_HALTED.
> > But I guess it's guests' responsibility to not initiate spurious wakeup,
> > guests need to bear the fact that HLT could fail due to a previous
> > spurious wakeup?
> 
> Just found a patch set for fixing the issue.

FWIW, Jim's series doesn't address spurious wakeups per se, it just ensures
pv_unhalted is cleared when transitioning to RUNNING.  If the vCPU is already
RUNNING, __apic_accept_irq() will set pv_unhalted and nothing will clear it
until the next transition to RUNNING (which implies at least an attempted
transition away from RUNNING).

