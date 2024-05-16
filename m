Return-Path: <linux-kernel+bounces-181346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D72148C7AC5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428BD1F21EBF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7CA14A0AE;
	Thu, 16 May 2024 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pWeD82FN"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABE14A3D
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715878720; cv=none; b=MeyjagNnFq+FCfOMz5dhW2lhclXYHfV+OL4BqJDHDiDT3inlHUDbcsbYakmq7sKh04TXgQqe5QhvE/iII23HxX0wc6Kp68YGzTZvTo1QiTa9dZxXib8zFvcV+ZtHbLCFW6vVT0sEMvj5Pe9zR782Vi4Vot6kLjJy4IjMrvpdsL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715878720; c=relaxed/simple;
	bh=fU/c6HrGJfHpZI7B1NOeoFi3w5X1FCUEXZajmkpmbl8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G9lN/BVqMrjSuzMehcD/soq5dk4vPS7dYTUDSPrZgvxt6iEr821LNiHbk1CbSvZpYWPUkRDltWnYj9Mw/5yZXuJ40F7xwsRsgaIHpuyn6d36EiQ+F3vqxnycrr3Qcj1uVp1WKL2MM+L3zkoyJgCXq3KZk0C/LnxeflK59tWUMTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pWeD82FN; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-658b03ebe58so1168495a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 09:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715878719; x=1716483519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VYOU9HPjB76w/RXd8VAXD/28+sXZKX4A/bOVr9SyK1c=;
        b=pWeD82FN1lLaqosaNPMDybaqG3D36e9YC5ZNK24iw3HYWOKid5WPPrbUj+ctIUbDQV
         avDIUwEEFTHaRS9FS5PPx7u6pRG86trON9ClTl7BQQYCj85bskavOKMKNyR4hJqd3gYz
         kIfk/WTdPwNJqd+aaHZu5+eRxMfq31Srh9T7/UGAl3wf9wx2qZFLCbH/CFp6FD6lEV3q
         yM9UjkJ98eEnJ37o7N+Q19b8qfoGgrLfdKTtaWKu0nYbdKVddxx/T/LPMw8QPUOD8XSn
         Gzhslbh7P3d5em1kY2tbk7Ap1lu5084tJ2nEYG7GlyR4fTphZzdrDu62EskKQfW7BpJK
         C8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715878719; x=1716483519;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VYOU9HPjB76w/RXd8VAXD/28+sXZKX4A/bOVr9SyK1c=;
        b=sVgfcdN2qC5ckbXHyMzX3MrAQPk4EtaRX2HkjBS2QhExOKfNrMPNjgYadROHtNZB14
         XkJNdxxKWZtYLm7lO1d0iXuRLcL3PXn5ioU2Tu4U6CMusqFX/i97tCOwPsdkSQ+4Umx4
         D2BgoLiTD3JbFLeRnXbIRgN1O2q275KDZ0MSX6iYKeA8QNROflYGZycWhhmojdaAwbj/
         TNvmd0rKsFD0/AG/rIdgxUhWTNPbQrb3qZvW9k5QenxSceU5hTtijpv8O8NOXk42D2fr
         zTYpjfiGI8KAgMSd0UZB2VjsmcaIeL4L2tYXAbqKaoL7FuQoA6gxJj26xS18cYihCzYY
         D/kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHYrDSBiiVN0lfVk9kmzqEHgX2xxFfCRKtJxy7ZhPgDhYNtXk2Ih4W+1LtEjuAtR7OVEOP6cykyBF4p6cAyHM79+s1+GABshoUJb9e
X-Gm-Message-State: AOJu0Yx1uJic+2EKbpAPQLNWDGzLp7F7cqilaAcHttVQA2A0VqcQKH5Y
	QKsCsruUCGcZpTObxi+ssZUABQKMHwAWMRVzwt7SFYGGvu63Xl0XDMg13lJNv549JPauDksAsOe
	5rA==
X-Google-Smtp-Source: AGHT+IGkW9xGFtXyZxtk1zO2vktTlKEU4xznjefUNTVhjQ1iMyPlYoEtgmVFLWiTc+08JgEUIDI04/TgaA8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:b609:0:b0:619:f921:b6e0 with SMTP id
 41be03b00d2f7-6373d2172afmr46520a12.5.1715878718905; Thu, 16 May 2024
 09:58:38 -0700 (PDT)
Date: Thu, 16 May 2024 09:58:37 -0700
In-Reply-To: <f2d6d62d-09be-4940-9c6e-92f80811587f@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219074733.122080-1-weijiang.yang@intel.com>
 <20240219074733.122080-25-weijiang.yang@intel.com> <ZjLNEPwXwPFJ5HJ3@google.com>
 <39b95ac6-f163-4461-93f3-eaa653ab1355@intel.com> <ZkYauRJBhaw9P1A_@google.com>
 <f2d6d62d-09be-4940-9c6e-92f80811587f@intel.com>
Message-ID: <ZkY7PblLmWdFYeSa@google.com>
Subject: Re: [PATCH v10 24/27] KVM: x86: Enable CET virtualization for VMX and
 advertise to userspace
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Weijiang Yang <weijiang.yang@intel.com>, rick.p.edgecombe@intel.com, 
	pbonzini@redhat.com, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, peterz@infradead.org, chao.gao@intel.com, 
	mlevitsk@redhat.com, john.allen@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024, Dave Hansen wrote:
> On 5/16/24 07:39, Sean Christopherson wrote:
> >> We synced the issue internally, and got conclusion that KVM should hon=
or host
> >> IBT config.  In this case IBT bit in boot_cpu_data should be honored.=
=C2=A0 With
> >> this policy, it can avoid CPUID confusion to guest side due to host ib=
t=3Doff
> >> config.
> > What was the reasoning?  CPUID confusion is a weak justification, e.g. =
it's not
> > like the guest has visibility into the host kernel, and raw CPUID will =
still show
> > IBT support in the host.
>=20
> I'm basically arguing for the path of least resistance (at least to start=
).
>=20
> We should just do what takes the least amount of code for now that
> results in mostly sane behavior, then debate about making it perfect late=
r.
>=20
> In other words, let's say the place we'd *IDEALLY* end up is that guests
> can have any random FPU state which is disconnected from the host.  But
> the reality, for now, is that the host needs to have XFEATURE_CET_USER
> set in order to pass it into the guest and that means keeping
> X86_FEATURE_SHSTK set.
>=20
> If you want guest XFEATURE_CET_USER, you must have host
> X86_FEATURE_SHSTK ... for now.

Ah, because fpu__init_system_xstate() will clear XFEATURE_CET_USER via the
X86_FEATURE_SHSTK connection in xsave_cpuid_features.=20

Please put something to that effect in the changelog.  "this literally won'=
t work
(without more changes)" is very different than us making a largely arbitrar=
y
decision.

