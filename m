Return-Path: <linux-kernel+bounces-388802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72B59B648D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9765E2820F1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF781EB9F2;
	Wed, 30 Oct 2024 13:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gr5l+MEg"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857701E2838
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295989; cv=none; b=KyrWhZk89FFxleq7pncUPYuwoZevepW+9d6mxsUH6azzW3518cYHpHyWkhncNohFPvgAtfLaNwROyyOgUzhflOTWXa/n3GWQJgi3I++KRJFIw0a6XKGHlM1/Ct3jCKJXPI5+3k522LctKyfWQStDea9P0b5fqtdOyDIz+E2aHts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295989; c=relaxed/simple;
	bh=Y1a9aM6tWWaV5uzVx8wzzg/C3IB0sCgO5AuemKo86Jo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rM4cgnzckftk7ZW4RPVnZ2c+HopGh3DrhQwobqPPvXmaZPmVJi69U5TPVnl9+WtFDrnWpSpIVAmc9yg4krJEjSyXszAqXd2QV3qKS96XLeAZiroHIupw53jixgVWkl1Ww2e99sTM5TL/ZAxOcLykP1F7N60IzUgzz+TxicV+DHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gr5l+MEg; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7eb0a32fc5aso5489796a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 06:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730295986; x=1730900786; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FtfXzQfaJ/EYKD+CJMQGAg9z8wKP66O4MQ222guzR8o=;
        b=Gr5l+MEgTcxy1MB28zEiYeQDW7I6oTVbV++EJGlKny+0rQ0cKlEa7wbA9OARJxjWn7
         Bm1Cv1ioADW2pW5u7SdZtMGu8Qf//aTALXfsqpfAJaCQ/LBzzpMX6W8O4vx2iu7Nd0BD
         C+kGKHGGKzyKLj6qfgaDf+6Ed5dLcezCcbiXUc3XL11LAiym6nd4dRwRdVCOUQs5xsJo
         ePQQIIE6crzyH05Y/U6/tEgLBGr6jyAJ+DWat++QwQCW0pp1SyPwk+dZFo/MAejZeG+u
         U/17MudTLn5hqB207ZKFAzIch6+4t8wCN9b8g3b0GpImVe4Jy7LB/3erJJ8h/VZy4dF7
         CR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730295986; x=1730900786;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FtfXzQfaJ/EYKD+CJMQGAg9z8wKP66O4MQ222guzR8o=;
        b=aOgrkoEB4X7v2zUEekvmr0R/K/U5YoQjPHfTOT5LiBkH5AxuM9ZOYZhLtrldJILfh1
         1YEmboRJYi0Q4aGFV/wYNQwT2Etkkos4MtVTZ+YK4nCiwfERKsPK8segA5UXgng7BRH9
         XSLj+CqcxT/o4jL+YV7WLWWxf+3EhXfcb1W3/4bOhZ88ljOyxnvsmvWklv1Dy67PjOLh
         zX3uonAidB0Pv6Rg3Jf8U4wCsTA1OhPEktRge+XarWEcM3T7CnTOeZguct6i/QGJRNOV
         lJjRB9TEZCSgLZoYRuTe7Ehci7214iMkKbqL90UHOtEdjax4U7psX8v8t2jQS708Yfyr
         A9sw==
X-Forwarded-Encrypted: i=1; AJvYcCX/ou7qfi3yn3GCCexH+xHHaSvqvWAdvMKdngcERUkEu4HEI5pEeZiJT3fre0SXPmMA++mstpqUAvwUE2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK3qv3XUp/bYFqor+hb2c78rDB2DEnGkr3zNyvzwkdpWLPLa2a
	i59jYvGlHRvcGyLGlFXL7HInCwpRzz55cI8HybIZVT1cP0rIsiV7cV5OxPCQfAF56cHReUbCDqC
	5jg==
X-Google-Smtp-Source: AGHT+IFm2Yxq+cP+3QVS7378b8ToiwEaMp35x6FfIFMaHRLEbNI+8XbUnisHEWBxThlhwzgcDC7XrtglZ9o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a63:4f62:0:b0:6d4:4eea:bd22 with SMTP id
 41be03b00d2f7-7edd7b857bfmr25632a12.4.1730295985486; Wed, 30 Oct 2024
 06:46:25 -0700 (PDT)
Date: Wed, 30 Oct 2024 06:46:24 -0700
In-Reply-To: <71f0fb41-d5a7-450b-ba47-ad6c39dce586@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240905124107.6954-1-pratikrajesh.sampat@amd.com>
 <20240905124107.6954-3-pratikrajesh.sampat@amd.com> <Zw2fW2AJU-_Yi5U6@google.com>
 <4984cba7-427a-4065-9fcc-97b9f67163ed@amd.com> <Zx_QJJ1iAYewvP-k@google.com> <71f0fb41-d5a7-450b-ba47-ad6c39dce586@amd.com>
Message-ID: <ZyI4cRLsaTQ3FMk7@google.com>
Subject: Re: [PATCH v3 2/9] KVM: selftests: Add a basic SNP smoke test
From: Sean Christopherson <seanjc@google.com>
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, pgonda@google.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 28, 2024, Pratik R. Sampat wro4te:
> On 10/28/2024 12:55 PM, Sean Christopherson wrote:
> > On Mon, Oct 21, 2024, Pratik R. Sampat wrote:
> >>>> +		if (unlikely(!is_smt_active()))
> >>>> +			snp_policy &= ~SNP_POLICY_SMT;
> >>>
> >>> Why does SNP_POLICY assume SMT?  And what is RSVD_MBO?  E.g. why not this?
> >>>
> >>> 		u64 policy = is_smt_active() ? SNP_POLICY_SMT : SNP_POLICY;
> >>>
> >>
> >> I think most systems support SMT so I enabled the bit in by default and
> >> only unset it when there isn't any support.
> > 
> > That's confusing though, because you're mixing architectural defines with semi-
> > arbitrary selftests behavior.  RSVD_MBO on the other is apparently tightly coupled
> > with SNP, i.e. SNP can't exist without that bit, so it makes sense that RSVD_MBO
> > needs to be part of SNP_POLICY
> > 
> > If you want to have a *software*-defined default policy, then make it obvious that
> > it's software defined.  E.g. name the #define SNP_DEFAULT_POLICY, not simply
> > SNP_POLICY, because the latter is too easily misconstrued as the base SNP policy,
> > which it is not.  That said, IIUC, SMT *must* match the host configuration, i.e.
> > whether or not SMT is set is non-negotiable.  In that case, there's zero value in
> > defining SNP_DEFAULT_POLICY, because it can't be a sane default for all systems.
> > 
> 
> Right, SMT should match the host configuration. Would a
> SNP_DEFAULT_POLICY work if we made it check for SMT too in the macro?
> 
> Instead of,
> #define SNP_POLICY	(SNP_POLICY_SMT | SNP_POLICY_RSVD_MBO)
> 
> Have something like this instead to make it generic and less ambiguous?
> #define SNP_DEFAULT_POLICY()		 			       \
> ({								       \
> 	SNP_POLICY_RSVD_MBO | (is_smt_active() ? SNP_POLICY_SMT : 0);  \
> })

No, unless it's the least awful option, don't hide dynamic functionality in a macro
that looks like it holds static data.  The idea is totally fine, but put it in an
actual helper, not a macro, _if_ there's actually a need for a default policy.
If there's only ever one main path that creates SNP VMs, then I don't see the point
in specifying a default policy.

> > Side topic, I assume one of SEV_POLICY_NO_DBG or SNP_POLICY_DBG *must* be specified, 
> > and that they are mutualy exclusive?  E.g. what happens if the full policy is simply
> > SNP_POLICY_RSVD_MBO?
> 
> SEV_POLICY_NO_DBG is mainly for the guest policy structure of SEV and
> SEV-ES - pg 31, Table 2
> https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/55766_SEV-KM_API_Specification.pdf
> 
> and, SNP_POLICY_DBG is a bit in the guest policy structure of SNP - pg
> 27, Table 9
> https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/56860.pdf
> 
> In the former, a SEV guest disables debugging if SEV_POLICY_NO_DBG is
> set. Similarly, a SNP guest enables debugging if SNP_POLICY_DBG is set.

Ugh, one is SEV_xxx, the other is SNP_xxx.  Argh!  And IIUC, they are mutually
exclusive (totally separate thigns?), because SNP guests use an 8-byte structure,
whereas SEV/SEV-ES use a 4-byte structure, and with different layouts.

That means this is _extremely_ confusing.  Separate the SEV_xxx defines from the
SNP_xxx defines, because other than a name, they have nothing in common.

+/* Minimum firmware version required for the SEV-SNP support */
+#define SNP_FW_REQ_VER_MAJOR   1
+#define SNP_FW_REQ_VER_MINOR   51

Side topic, why are these hardcoded?  And where did they come from?  If they're
arbitrary KVM selftests values, make that super duper clear.

+#define SNP_POLICY_MINOR_BIT   0
+#define SNP_POLICY_MAJOR_BIT   8

s/BIT/SHIFT.  "BIT" implies they are a single bit, which is obviously not the
case.  But I vote to omit the extra #define entirely and just open code the shift
in the SNP_FW_VER_{MAJOR,MINOR} macros.

 #define SEV_POLICY_NO_DBG      (1UL << 0)
 #define SEV_POLICY_ES          (1UL << 2)
+#define SNP_POLICY_SMT         (1ULL << 16)
+#define SNP_POLICY_RSVD_MBO    (1ULL << 17)
+#define SNP_POLICY_DBG         (1ULL << 19)
+#define SNP_POLICY             (SNP_POLICY_SMT | SNP_POLICY_RSVD_MBO)
+
+#define SNP_FW_VER_MAJOR(maj)  ((uint8_t)(maj) << SNP_POLICY_MAJOR_BIT)
+#define SNP_FW_VER_MINOR(min)  ((uint8_t)(min) << SNP_POLICY_MINOR_BIT)

