Return-Path: <linux-kernel+bounces-307645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFE59650B8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068C51F229FA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B401BAED6;
	Thu, 29 Aug 2024 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xPHC0chf"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC4A335C0
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724963126; cv=none; b=I7q45kVn8kcA/We7LldH9UE2k4Xj78JbhUVDTmd6PbTgnB5nf2/y9MldEBfjHczZC9ZvUadLFbSyNSUyPKqc5FXfK8VMlJinyUHsao+fApkxDPSnmmrdApzLsZrLPd86pfVNu1n4vrPk1ljJ39YY8Rs0KRwESHClTv+MLqE4zBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724963126; c=relaxed/simple;
	bh=fpL8d1zkyZn05vY5z6Vn+j7d09Z1sZ4NkIVQgdi8FR8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dehkJxpRW8svvMQWozaWsqgcng0TLffQ5xiXsPqtom7RyID2jnGaMoBKAFDf9LyX7uu/Hln9pVeueHeThWD091YI+SObkJQCjscfPXXv7qRT5mNKoD+5Iu5gC2lvODRZEdDfFaeptMJI1eZJayp5Jbi8pFIn9IAlFibBdVvAZ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xPHC0chf; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0b3742b309so1906393276.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724963123; x=1725567923; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uoafdzW7H8ylwT6yLMzc6nHyC2YnEZ8PmgInewseDtk=;
        b=xPHC0chf/df4d1CcDo++8unEoHpfAwRAqKifuuZ0yyp5RUTW7UVEyNjYWZQMa+Ex7f
         WY2IITrqxbNdtxkbyNWGpKEZQzuP6XeiJzwWxecI0SwWr2OcAyvC2Ape9n9RX/HNJBhv
         lvQQ1wPZt0SEnjYw6xYIGJZHqqBE0iaLts8VnfB2+FY7Gn4RjsH4+8mUNs8MNzMUZ1PZ
         fT8uLkvkvsdxfWVaM6TuSPvvb5pDUWWHd4cOebDFILk49nlQ73vuf3HkS4BFkKjc2gE3
         FV1RE6/yRG/pjEzTocOsACCALRApCPEDiR/2SsH0Em/YQZ5dDQ3gvdZIbmT7IfJIHpi9
         5e7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724963123; x=1725567923;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uoafdzW7H8ylwT6yLMzc6nHyC2YnEZ8PmgInewseDtk=;
        b=vsxcZdie0gYozS+L4iyztjKprrj6SByNoWhZ5t5uOqKktt4LfHXD4ZYOgPpGiawt+J
         zh1PPpsti7Cgppb8xAQDZqQAW3MH1W/JYsEexJhFHGMmUVJYeq6QxwX51tJF9hGRBMoC
         4ih9vOLpDzgiDdFZuM0VFwomUeY8E/MT+JgIduVH4s7KeVHAZKt/eMnV5p8Np8kodQjN
         3b05rDk+NVODMd+1jGgKN4mWC9+pdWIz3K7CaMu4tSaltJwr5aNbN0UzPGyaI/OLj0wA
         kceg9l2M9Em+Za8LfpXiqHtxBaGKXxSfwNeI6l9kF/BNe25G76vJhOx22Xrns+YD3iZ0
         qhsA==
X-Forwarded-Encrypted: i=1; AJvYcCUvkZ9qUl9J7uQo7n5rBAxzgQ7CyMeOH+PoOf/MML4a0Ugt9omO4ax53VSZNhmhQg7eIk3Me1nejMtQUyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWCto1fImExpy/LOBNSLu+0HKnyb8QuEegMuXy55gbYKuInilH
	1hlUKqRxp4cPNTdB8JGK3zZA6HgZh9VU3La/sXDoDE4r3tm7QfdmW6OMvbpcnVJ11mw9NUJwdTi
	2nA==
X-Google-Smtp-Source: AGHT+IGQsy627eLrUEJI9itKdehuX55XydsE9neI3iy886/uRMrdb1e7PV473E3IR/0NyRmTcFrKUAhuKa0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:aba1:0:b0:e05:eccb:95dc with SMTP id
 3f1490d57ef6-e1a7a15bfadmr14276.6.1724963123407; Thu, 29 Aug 2024 13:25:23
 -0700 (PDT)
Date: Thu, 29 Aug 2024 13:25:21 -0700
In-Reply-To: <gsntjzg09tgm.fsf@coltonlewis-kvm.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <Zs0BSCb_Khyxg08x@google.com> <gsntjzg09tgm.fsf@coltonlewis-kvm.c.googlers.com>
Message-ID: <ZtDZMZgYp7F6e_Qd@google.com>
Subject: Re: [PATCH 2/6] KVM: x86: selftests: Define AMD PMU CPUID leaves
From: Sean Christopherson <seanjc@google.com>
To: Colton Lewis <coltonlewis@google.com>
Cc: Mingwei Zhang <mizhang@google.com>, kvm@vger.kernel.org, ljr.kernel@gmail.com, 
	jmattson@google.com, aaronlewis@google.com, pbonzini@redhat.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 28, 2024, Colton Lewis wrote:
> Hi Mingwei, thanks for reviewing!
> 
> Mingwei Zhang <mizhang@google.com> writes:
> 
> > On Tue, Aug 13, 2024, Colton Lewis wrote:
> > > This defined the CPUID calls to determine what extensions and
> > > properties are available. AMD reference manual names listed below.
> 
> > > * PerfCtrExtCore (six core counters instead of four)
> > > * PerfCtrExtNB (four counters for northbridge events)
> > > * PerfCtrExtL2I (four counters for L2 cache events)
> > > * PerfMonV2 (support for registers to control multiple
> > >    counters with a single register write)
> > > * LbrAndPmcFreeze (support for freezing last branch recorded stack on
> > >    performance counter overflow)
> > > * NumPerfCtrCore (number of core counters)
> > > * NumPerfCtrNB (number of northbridge counters)
> 
> > > Signed-off-by: Colton Lewis <coltonlewis@google.com>
> > > ---
> > >   tools/testing/selftests/kvm/include/x86_64/processor.h | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> 
> > > diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h
> > > b/tools/testing/selftests/kvm/include/x86_64/processor.h
> > > index a0c1440017bb..9d87b5f8974f 100644
> > > --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> > > +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> > > @@ -183,6 +183,9 @@ struct kvm_x86_cpu_feature {
> > >   #define	X86_FEATURE_GBPAGES		KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 26)
> > >   #define	X86_FEATURE_RDTSCP		KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 27)
> > >   #define	X86_FEATURE_LM			KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 29)
> > > +#define	X86_FEATURE_PERF_CTR_EXT_CORE	KVM_X86_CPU_FEATURE(0x80000001,
> > > 0, ECX, 23)
> > > +#define	X86_FEATURE_PERF_CTR_EXT_NB	KVM_X86_CPU_FEATURE(0x80000001,
> > > 0, ECX, 24)
> > > +#define	X86_FEATURE_PERF_CTR_EXT_L2I	KVM_X86_CPU_FEATURE(0x80000001,
> > > 0, ECX, 28)
> 
> > You won't be testing Northbridge counters and L2I counters, so these two
> > could be optional to the patch.
> 
> That's correct. Since it was a small thing to include I thought it best
> to include and save someone in the future from digging through the
> reference manual again.

+1.  They're defines, i.e. have no meaningful cost.  And anything that *might*
save me from having to find CPUID entries in the SDM/APM is worth adding.

