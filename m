Return-Path: <linux-kernel+bounces-417739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 469489D5898
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 04:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62001F22C6E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 03:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE40156C5F;
	Fri, 22 Nov 2024 03:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsTyKHp4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A883C18651
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 03:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732246554; cv=none; b=kdv/AwJcR9SWmrv1FC7YN+RzYEnS7FyGXKZTCK4Rb5BvnW2ysTQ8fIIEPpCGkv1vK3ZI+Lm7YTyXLNwjuyo+hHdOpfrRTae/k6f5uGL6ShG0MEEtoan5Ut84nwHVXtpIco+YDx9ccJuorbdO5HIhfqL6nXl2MKvpoahZKSNQlYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732246554; c=relaxed/simple;
	bh=KTvFDp9QD5ijXLqnlkxWgnqB3se/WaIsEOe2XJj0bM0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NfqvkVApFRBkomSe5GQ6gQBdzdMwUjM44zUQKl3pDPrnB4XMxByZsxhxKrLZ5sHtMN1Ss3FoHGeK05noqgBIo9cB2NoTI4PeHF2NP17nBBomMOH/U7wMyhuX7+uX4tCbLjaw0uriZqR/Czjmko2L4+cBenyMWARtce/NKk2S4U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JsTyKHp4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732246551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5oMByVgskSlAO+H6dfEVs61hv0tol8zLwPvoHoN0zXQ=;
	b=JsTyKHp46feWn/62Y//LKw71yFUdpmqlI0v+AbW7GfjDApxCC1eLEsa6syl1gaFEgQ7+nD
	OCThedOnHf+G1uPqMmrjkELVHV4EoQC48vQ2mMGNOTo0k9dbI/8WsXMEX/W2nnpvwznZSJ
	vp0HiPR7NSTWM/FLPhwZrzQBp7SnqCM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-0Wn0eqfUONG4dUeRKDxPUQ-1; Thu, 21 Nov 2024 22:35:49 -0500
X-MC-Unique: 0Wn0eqfUONG4dUeRKDxPUQ-1
X-Mimecast-MFC-AGG-ID: 0Wn0eqfUONG4dUeRKDxPUQ
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b35b1b9663so522964285a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 19:35:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732246549; x=1732851349;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5oMByVgskSlAO+H6dfEVs61hv0tol8zLwPvoHoN0zXQ=;
        b=qGCDVr2zGP997MXiM/fgKxYk8rh45jkcBpYiKsDTfUZZriM9pm2BmrqeCVPXcpagCL
         P36qS8RHGeTKK2nj/JXZ2lg9wLxJMot+7oxhfC0uaOY2UOdQph9URQDBWNecOc9bxk3y
         vZ4UZQP/+5c6fiPKxpWTFTiFklNnsBO4Wbt4dLlI4Am4UeUvDnpvvbieTKCGHY2RA77C
         VOWYm/dtrR3vzS18Q/hNpO+OKQna66KNHpCnmlM/xBA2l/ioU43wLLjQP6oEvdUlD3vO
         WGwp/Agb4PI/Bgn2Bzuq0w7ebWkJ4ETZXyV9ulcfK3QLBm3Qch1YHHIH7DlSEHV/Jgqa
         f9xg==
X-Forwarded-Encrypted: i=1; AJvYcCW4mAXGPZIIZ0MBk2Z4E4a5QLFn1Pmwo1vZc5B1GLANrN272/+BjAA8C05iJ3KDGj4Lagq/CJgx4hwV8CE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdlareabwEJCHoZEXDMy04/DsywRwW9m49cB751rmgXFEb2FE3
	uEokXx2bFZP4Y2DRv6hpz7KMUXUxbBA52TWKupLLn5OPuVqkZZu57GpDkqJ9P0qiSZC9Xt/+Avb
	lyoumzx2qE5EIF5fzdm7Vt/2iZhQQNyOSBPIoelGN9yxEUmwAIk5oIuJJg/jv7w==
X-Gm-Gg: ASbGncsN8YqM68P+0gr9oqJ578HrtCwyDCvU+AiTEjlWHDh+XfRvcfDyEL7uKhOF9nj
	kPPi3a2xuGeUGm6xN8CbQJ5Iwdi8XD6NRKbpbm8ybualQWkEJnG5Vt+JKIeht3s2ctjdQz/Na2v
	r6k8TUbtToNnDGiRMDelZH8RxmLaRDgKxtb/VFOWuQza40O01L073PeQXEaUC/pTYReslh0hFh7
	f17caDqq2skpu+GBpte28rye3KS7uM/CaJ0/SlCoS3TlDlcsw==
X-Received: by 2002:a05:620a:2450:b0:7b2:fa17:f7d7 with SMTP id af79cd13be357-7b51403cdabmr258709785a.6.1732246548982;
        Thu, 21 Nov 2024 19:35:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN+J1bJodpM9PMzVK1b6LgI1yRvNPBKfxwy6rPr8dHKDm/izGv3gPubPdaJ5huR5NYalePUA==
X-Received: by 2002:a05:620a:2450:b0:7b2:fa17:f7d7 with SMTP id af79cd13be357-7b51403cdabmr258708385a.6.1732246548653;
        Thu, 21 Nov 2024 19:35:48 -0800 (PST)
Received: from starship ([2607:fea8:fc01:8d8d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b5141537basm44920785a.105.2024.11.21.19.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 19:35:48 -0800 (PST)
Message-ID: <c0f7e5b96829407d839d9e5f3907943c4c0f960f.camel@redhat.com>
Subject: Re: vmx_pmu_caps_test fails on Skylake based CPUS due to read only
 LBRs
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 21 Nov 2024 22:35:47 -0500
In-Reply-To: <948408887cbe83cbcf05452a53d33fb5aaf79524.camel@redhat.com>
References: <c9d8269bff69f6359731d758e3b1135dedd7cc61.camel@redhat.com>
	 <Zx-z5sRKCXAXysqv@google.com>
	 <948408887cbe83cbcf05452a53d33fb5aaf79524.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 2024-11-03 at 18:32 -0500, Maxim Levitsky wrote:
> On Mon, 2024-10-28 at 08:55 -0700, Sean Christopherson wrote:
> > On Fri, Oct 18, 2024, Maxim Levitsky wrote:
> > > Hi,
> > > 
> > > Our CI found another issue, this time with vmx_pmu_caps_test.
> > > 
> > > On 'Intel(R) Xeon(R) Gold 6328HL CPU' I see that all LBR msrs (from/to and
> > > TOS), are always read only - even when LBR is disabled - once I disable the
> > > feature in DEBUG_CTL, all LBR msrs reset to 0, and you can't change their
> > > value manually.  Freeze LBRS on PMI seems not to affect this behavior.
> > > 
> > > I don't know if this is how the hardware is supposed to work (Intel's manual
> > > doesn't mention anything about this), or if it is something platform
> > > specific, because this system also was found to have LBRs enabled
> > > (IA32_DEBUGCTL.LBR == 1) after a fresh boot, as if BIOS left them enabled - I
> > > don't have an idea on why.
> > > 
> > > The problem is that vmx_pmu_caps_test writes 0 to LBR_TOS via KVM_SET_MSRS,
> > > and KVM actually passes this write to actual hardware msr (this is somewhat
> > > wierd),
> > 
> > When the "virtual" LBR event is active in host perf, the LBR MSRs are passed
> > through to the guest, and so KVM needs to propagate the guest values into hardware.
> 
> Yes, but usually KVM_SET_MSRS doesn't touch hardware directly, even for registers/msrs
> that are passed through, but rather the relevant values are loaded when the guest vCPU
> is loaded and/or when the guest is entered.
> I don't know the details though.
> 
> 
> > > and since the MSR is not writable and silently drops writes instead,
> > > once the test tries to read it, it gets some random value instead.
> > 
> > This just showed up in our testing too (delayed backport on our end).  I haven't
> > (yet) tried debugging our setup, but is there any chance Intel PT is interfering?
> > 
> >   33.3.1.2 Model Specific Capability Restrictions
> >   Some processor generations impose restrictions that prevent use of
> >   LBRs/BTS/BTM/LERs when software has enabled tracing with Intel Processor Trace.
> >   On these processors, when TraceEn is set, updates of LBR, BTS, BTM, LERs are
> >   suspended but the states of the corresponding IA32_DEBUGCTL control fields
> >   remained unchanged as if it were still enabled. When TraceEn is cleared, the
> >   LBR array is reset, and LBR/BTS/BTM/LERs updates will resume.
> >   Further, reads of these registers will return 0, and writes will be dropped.
> > 
> >   The list of MSRs whose updates/accesses are restricted follows.
> >   
> >     • MSR_LASTBRANCH_x_TO_IP, MSR_LASTBRANCH_x_FROM_IP, MSR_LBR_INFO_x, MSR_LASTBRANCH_TOS
> >     • MSR_LER_FROM_LIP, MSR_LER_TO_LIP
> >     • MSR_LBR_SELECT
> >   
> >   For processors with CPUID DisplayFamily_DisplayModel signatures of 06_3DH,
> >   06_47H, 06_4EH, 06_4FH, 06_56H, and 06_5EH, the use of Intel PT and LBRs are
> >   mutually exclusive.
> > 
> > If Intel PT is NOT responsible, i.e. the behavior really is due to DEBUG_CTL.LBR=0,
> > then I don't see how KVM can sanely virtualize LBRs.
> > 
> 
> Hi!
> 
> 
> I will check PT influence soon, but to me it looks like the hardware implementation has changed. 
> It is just too consistent:
> 
> When DEBUG_CTL.LBR=1, the LBRs do work, I see all the registers update, although
> TOS does seem to be stuck at one value, but it does change sometimes, and it's non zero.
> 
> The FROM/TO do show healthy amount of updates 
> 
> Note that I read all msrs using 'rdmsr' userspace tool.
> 
> However as soon as I disable DEBUG_CTL.LBR, all these MSRs reset to 0, and can't be changed.

Hi,
I tested this on another skylake based machine (Intel(R) Xeon(R) Silver 4214) and I see the same behavior: 
LBR_TOS is readonly:

It's 0 when LBRS disabled in DEBUG_CTL, and running (changes all the time as expected)
when LBRS are enabled in the DEBUG_CTL.

IA32_RTIT_CTL.TraceEn is disabled (msr 0x570 is 0).

Also on this machine BIOS didn't left LBRs running.

I guess we need to at least disable the check in the unit test or at least
speak with someone from Intel to clarify on what is going on.
What do you think?

Best regards,
	Maxim Levitsky

> 
> I'll check this on another Skylake based machine and see if I see the same thing.
> 
> Best regards,
> 	Maxim Levitsky
> 





