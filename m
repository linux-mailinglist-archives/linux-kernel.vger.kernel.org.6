Return-Path: <linux-kernel+bounces-181177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E58E8C7889
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD671F22241
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB4E14B974;
	Thu, 16 May 2024 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="rm/JyvVs"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1B8225D0
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715870398; cv=none; b=sH+YA4HIL5AJEqZDdunLzXNaAPer9q5X/l36fTzfFi3SghBi2FHJMk34uk4fwhkO06pYgI/JZ7NdANW6bQtO+2P0hnBP62hr9p1BqXi9V6GgaPnFraTWVtTVP+xKHcO1sGJhEcrECna3ZSHLik+4fHf0nGZTAEBdHFtMOhWwL+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715870398; c=relaxed/simple;
	bh=vc3rGzOVvzFelycXJ1pDcYNPxetD6J5GoLUwsKnR864=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xx+L8PGqs9joOCYaz0TXO/zl6AGFJ2wsDWrvuY79G+UTFR0Vu6PqmVhnqNJ4b22hO2xDpukibsRRRX6zMuFs6v94e1sHT3Zeirr9X0Q9Y85DhGRwAsHkVd9MiUb3QBI1n0BJIOvIyfM+KFjEMdmtwuvCw2KqfsN1S/vwiBL8hVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rm/JyvVs; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62777fe7b86so16765207b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 07:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715870395; x=1716475195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zpZS4ufdGYjcABwthGAJQK0pYz3YRaST36jpxGjIiPQ=;
        b=rm/JyvVswA9jOWIfPDt7PMJ+02o1+bfnPcsdw47L8LKtdQaUt5nawn1ADFmfu9Y0Q8
         NtCknabAvhAowqucjfKCHZ/FXsSxUOx+YJ/n+JuHsSILtIwDWYDpzIsVNEbPO+CkHHnM
         gwjoyJM1WzB4PRMRin6/C8o8TGO+hIE7Om1PGms5qYA9LHIR/EX2Y2o5j1pkEz/gGf9S
         quMEThUyIyIyv97lFaVr/kquSXsqH1wLKeAUcAveuCn+Pz1RHzkZFL5fLy/OGOmpkVQ1
         +IbOqoFeATFjnexNyvOxRIVbOaFRmEBa4BKrSJk6layCMqoDBIKNEwYF+7Cbu19yMOMS
         /aBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715870395; x=1716475195;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zpZS4ufdGYjcABwthGAJQK0pYz3YRaST36jpxGjIiPQ=;
        b=bgC1+M9NQ+RymyXBQoZeIbYDjCX3a0Y+yuKDqooysufE0v0hiaMOTexT0kvGwTLOYG
         vOJ7QIdxSZY6dQLTqd4c6OARCVjKMTihwuaqrr8y4LhLwKJ6qPk4P0fqm8MAxbbPMbMR
         Iy9iDvMVKWypHlFYuSbBaex37zu3/F6KaolRVTWGNcH+dtnzxbtqvNS4TuMPDyfbnszA
         tCQJEnwSbrSmsGeWGP4B5cdK/RRq7vGHP//j9iZHRudunL8oMdsJJFsBmSvB0yCm2OL/
         2GTObRshKGvkX7g4E4GkgQPoCa56KeeAgOrtNbU02MwIGrN5Vr/rmnUEkHwByZ29g/aW
         zbTg==
X-Forwarded-Encrypted: i=1; AJvYcCW14wx2BymdEFVHyfGGbqA4b26Ab3hAbI9MmPGqsXJwJ/h4XP8NUtWj0X0v+BccYnk8ZC1ajq6Egl0OmsCfQLTiM8cMx+UE4SXl6sd0
X-Gm-Message-State: AOJu0YzD30krPV7G5NWO9XH9ZZZHfrLblbAX7oRi4qd4TorTZNG22TnI
	q42bIc0KBMbfIcmUiBGSpTmzGlW/so6rvbAw+z0skryn56mCnNbqHj7H0K7IxcDKXBjz8EToWce
	nbQ==
X-Google-Smtp-Source: AGHT+IHVtLu9UCPFuOUuBvCNpOrqW5lPUfFjJC9X2uq74NBH/vD63xB/W9ejzFWXbtPGSfyISsJyN3w/3d8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:6107:b0:61b:e165:44ba with SMTP id
 00721157ae682-622aff75294mr43894097b3.1.1715870395487; Thu, 16 May 2024
 07:39:55 -0700 (PDT)
Date: Thu, 16 May 2024 07:39:53 -0700
In-Reply-To: <39b95ac6-f163-4461-93f3-eaa653ab1355@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219074733.122080-1-weijiang.yang@intel.com>
 <20240219074733.122080-25-weijiang.yang@intel.com> <ZjLNEPwXwPFJ5HJ3@google.com>
 <39b95ac6-f163-4461-93f3-eaa653ab1355@intel.com>
Message-ID: <ZkYauRJBhaw9P1A_@google.com>
Subject: Re: [PATCH v10 24/27] KVM: x86: Enable CET virtualization for VMX and
 advertise to userspace
From: Sean Christopherson <seanjc@google.com>
To: Weijiang Yang <weijiang.yang@intel.com>
Cc: rick.p.edgecombe@intel.com, pbonzini@redhat.com, dave.hansen@intel.com, 
	x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, chao.gao@intel.com, mlevitsk@redhat.com, 
	john.allen@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024, Weijiang Yang wrote:
> On 5/2/2024 7:15 AM, Sean Christopherson wrote:
> > On Sun, Feb 18, 2024, Yang Weijiang wrote:
> > > @@ -696,6 +697,20 @@ void kvm_set_cpu_caps(void)
> > >   		kvm_cpu_cap_set(X86_FEATURE_INTEL_STIBP);
> > >   	if (boot_cpu_has(X86_FEATURE_AMD_SSBD))
> > >   		kvm_cpu_cap_set(X86_FEATURE_SPEC_CTRL_SSBD);
> > > +	/*
> > > +	 * Don't use boot_cpu_has() to check availability of IBT because th=
e
> > > +	 * feature bit is cleared in boot_cpu_data when ibt=3Doff is applie=
d
> > > +	 * in host cmdline.
> > I'm not convinced this is a good reason to diverge from the host kernel=
  E.g.
> > PCID and many other features honor the host setup, I don't see what mak=
es IBT
> > special.
> >=20
> >=20
> Hi, Sean,
> We synced the issue internally, and got conclusion that KVM should honor =
host
> IBT config.  In this case IBT bit in boot_cpu_data should be honored.=C2=
=A0 With
> this policy, it can avoid CPUID confusion to guest side due to host ibt=
=3Doff
> config.

What was the reasoning?  CPUID confusion is a weak justification, e.g. it's=
 not
like the guest has visibility into the host kernel, and raw CPUID will stil=
l show
IBT support in the host.

On the other hand, I can definitely see folks wanting to expose IBT to gues=
ts
when running non-complaint host kernels, especially when live migration is =
in
play, i.e. when hiding IBT from the guest will actively cause problems.

