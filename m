Return-Path: <linux-kernel+bounces-395652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D799BC111
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6561C20E7B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3071FDFA5;
	Mon,  4 Nov 2024 22:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R1QIXK5/"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508591D3195
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 22:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730760413; cv=none; b=rTkLNOXSohio2u7IVDNCfRFffevmSTs5Qx5APWioPb+rA2HfATHKKyhpNFbcSGE/5rSeriYGSIS54pAwLPFxCkTMDiPyb/3lPkiqwf79o214IeQB3IWWi1kb+TBz12GJuNz5ns1mNB9VDbtadIx/ebvJzasWDpwej7TPC8MLLmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730760413; c=relaxed/simple;
	bh=2oaDc2OJ7mzjPDEaJXHaxhscLcv5YcDngwGO97Zgmzc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DPcByRNhFefoDIYH+DRI2WYH00Yt3BIMfudR5wPQ8IRpcHPtSgm7ye4CmV6mafLw5nwUgb2bMAWviRYhghsrbHFwt4H/0k6R/lYAVpgxvLO8jJfOReG6BWMmigrrqq0GUawFTqZjlwTGXc0k5/aqNvVcss4MB+9W5mhOxReNr4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R1QIXK5/; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-20ca7d8670cso51362405ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 14:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730760411; x=1731365211; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V+1OOWu8otwPmKdeaUQvk9hr3vFCRqynmh+NOX9eZ3c=;
        b=R1QIXK5/Tn2BZVMA6uY6Qbl+VYxdBcvzu+fzb7zCBJ4RHGtvy64grcxJ1OHI9OKJKN
         wG8Q99YrjjHWdHCamyUZJ0gtWRZ6E0NWFQqRbdBQnRlm9sV1zBKSMzFpffhBL03vC3ez
         QUixPhdlitdhPcrcE7hdn1tHoDC88uZy2rtc4SmlPVwZiGlkyTZMBPZDAQYk/HZe+SNf
         WojWJXw4ip2Zq6qATVWoUBx1J2rvdAG+CUN3f/5MfSqT70cavfTxYcXCtzVKcQM4ZJJJ
         O1+/8N2Kx7rbWl7KN6Y2E2rz0MhhVUgcJPq9C3JU8sqlBuu/0XXtkXIKS0qjWgJFD2QE
         PkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730760411; x=1731365211;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+1OOWu8otwPmKdeaUQvk9hr3vFCRqynmh+NOX9eZ3c=;
        b=tRkp/xH4S9fQ71T7tVHjIjrk24/hEDlpvgd7d7Q+K5glCOgrbdT7uhcK7ZWRIFOgGb
         zDH0pqSPKUEshXMt5KVwj2UjsngyiUrrsl2ryGXBWbTFrOCu0+1xUIDbAG9c/4ZFi6a0
         XjKb/0DHCksgNn2jcegh0+FQEBOfrcYkPZHBVeauOoFrBksthkbXoNCHmNg5f0cy/BXB
         bn/Bf33Rhv83XwAEGmudxSAQP6kyY57htFNZrjHUQPdtpdauLsn+Dbhof1ji0nSrnPmn
         GZbEM64OonxsCbHYlDlMLkzJZYm3WCLkOt1sUMjqtrXtwT4vwAFF+djdGWfsf48FHdBn
         CHgg==
X-Forwarded-Encrypted: i=1; AJvYcCXEUXm4Bg4qoyj7jJh54PImQVLXKQQeVIuDI+s5UNazIq2XwspeSXlHdQJg320hE6votPMPNK/Yo1HwA80=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrjuSIKjMABZc5zPReZQ/u0jSrEH7vD1yIMMCbQE/ZII9+ZMOh
	5DrwWmeQQua96GpGyU7QwsNHbIv5tmgnQk8UgzXq/ta9C4VDt0gKqvSpugLpDBmuHiNL0OTUQtm
	wzw==
X-Google-Smtp-Source: AGHT+IH961JbdDRngsNL3HXo7Pps7CDujvk4M+rePauZedo1saIfHgi+uDIEl/7TAdCI+OWuC5eEi6QRXok=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:903:3644:b0:20c:a97d:cc71 with SMTP id
 d9443c01a7336-2111aee3787mr167625ad.3.1730760411549; Mon, 04 Nov 2024
 14:46:51 -0800 (PST)
Date: Mon, 4 Nov 2024 14:46:50 -0800
In-Reply-To: <c7b8f395-579b-40d9-b3eb-29a347f73ec9@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241101185031.1799556-1-seanjc@google.com> <20241101185031.1799556-2-seanjc@google.com>
 <c7b8f395-579b-40d9-b3eb-29a347f73ec9@intel.com>
Message-ID: <ZylO2lHCydixvYCL@google.com>
Subject: Re: [PATCH 1/2] KVM: VMX: Bury Intel PT virtualization (guest/host
 mode) behind CONFIG_BROKEN
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 04, 2024, Xiaoyao Li wrote:
> On 11/2/2024 2:50 AM, Sean Christopherson wrote:
> > Hide KVM's pt_mode module param behind CONFIG_BROKEN, i.e. disable support
> > for virtualizing Intel PT via guest/host mode unless BROKEN=y.  There are
> > myriad bugs in the implementation, some of which are fatal to the guest,
> > and others which put the stability and health of the host at risk.
> > 
> > For guest fatalities, the most glaring issue is that KVM fails to ensure
> > tracing is disabled, and *stays* disabled prior to VM-Enter, which is
> > necessary as hardware disallows loading (the guest's) RTIT_CTL if tracing
> > is enabled (enforced via a VMX consistency check).  Per the SDM:
> > 
> >    If the logical processor is operating with Intel PT enabled (if
> >    IA32_RTIT_CTL.TraceEn = 1) at the time of VM entry, the "load
> >    IA32_RTIT_CTL" VM-entry control must be 0.
> > 
> > On the host side, KVM doesn't validate the guest CPUID configuration
> > provided by userspace, and even worse, uses the guest configuration to
> > decide what MSRs to save/load at VM-Enter and VM-Exit.  E.g. configuring
> > guest CPUID to enumerate more address ranges than are supported in hardware
> > will result in KVM trying to passthrough, save, and load non-existent MSRs,
> > which generates a variety of WARNs, ToPA ERRORs in the host, a potential
> > deadlock, etc.
> > 
> > Fixes: f99e3daf94ff ("KVM: x86: Add Intel PT virtualization work mode")
> > Cc: stable@vger.kernel.org
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/x86/kvm/vmx/vmx.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index 6ed801ffe33f..087504fb1589 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -217,9 +217,11 @@ module_param(ple_window_shrink, uint, 0444);
> >   static unsigned int ple_window_max        = KVM_VMX_DEFAULT_PLE_WINDOW_MAX;
> >   module_param(ple_window_max, uint, 0444);
> > -/* Default is SYSTEM mode, 1 for host-guest mode */
> > +/* Default is SYSTEM mode, 1 for host-guest mode (which is BROKEN) */
> >   int __read_mostly pt_mode = PT_MODE_SYSTEM;
> > +#ifdef CONFIG_BROKEN
> >   module_param(pt_mode, int, S_IRUGO);
> > +#endif
> 
> I like the patch, but I didn't find any other usercase of CONFIG_BROKEN in
> current Linux.

Ya, BROKEN is typically used directly in Kconfigs, e.g. "depends on BROKEN".  But
I can't think of any reason using it in this way would be problematic.

