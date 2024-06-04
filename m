Return-Path: <linux-kernel+bounces-199870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D73108FA6FD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 02:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646F11F23ED2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 00:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D556FBF;
	Tue,  4 Jun 2024 00:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="puxjbxBT"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9AE4A0F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 00:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717460993; cv=none; b=PRcFkLHCW7Z1ayR5OYI3KG/JDFLiNNgBDE7qVZ5mOrrbPCZ3F1oc3VIpCRiKxejph9mMn/z79RvzQcJCd3esIJLmCuZTUgrWkLk031RUnr4T8s0jxJyfKhNee93dVWzvWOGvFa/+0gv7G/qJhFUHEHxKt63ihxD43hHHWLDUfCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717460993; c=relaxed/simple;
	bh=tHNlljHyl4OWf1KxKCEPYA1CiqsKpPT13VLxPLbrxl8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OPlIVQQGvQremj2LMWuRBAuFLJF+QD5wW2wJVKArBradZltz6j2xqyJpySZycxlD6gKRxPhNyM7efpaTHcrS9/fzeH9A0kRvz6HRytzAprcqcuVaihfYWRecdlwwclD9aDJSdRUgaibcFRs/N2WbywvR3k4dIV4Sgl0mG+YncBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=puxjbxBT; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6658818ad5eso3699535a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 17:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717460991; x=1718065791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QxIMQXFvRFWSOBKMLO/Pb11VLx9FgWxOAKpcjqg1q6M=;
        b=puxjbxBTG5z3Upww4V6uBpPm3gT6S16Fh/4hFzQnft+qQUhCffRGP8yUD+0M/Y0BTF
         t80sR1UETBui4VWEC5izZ6Y8k0lq81iM2k9DX2auu95AjbleBwkIMJ1kYn+iRVKjqtOJ
         TNN4BZQoewG55+6C5TOEBRUiCr5SyTNx7tpVYnQ/FTN5Bp6SapIJT+tu3hdu+PStimkS
         0RfRGfAImQnfZdDfSfHvC814+/YkuIhFCJBEShpWm3nJuvoosaIf+iNyskVf1kJiix9d
         BYFr2cgkFmIrb0Jmd88+P9eQ4EGysGGVrXi//MiWRpYOTrPBDwTLwfQQznIk+5cZfCKl
         coeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717460991; x=1718065791;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QxIMQXFvRFWSOBKMLO/Pb11VLx9FgWxOAKpcjqg1q6M=;
        b=NEEK+s+hIKTdcbF+Ln8e+p3kOCH+0dyCqcMvi7rAV/QbVvqUtfggFiabZCvpMbu1Mg
         zc0K3nvR43FnCzYbaHj3Z2mfbG/ocp1uIW5RYG67f0dz7lxVJtsLwKtVLuC2wS1HDsLI
         OfqGsYqtdWOujWG8LESIXbFKijawR2V1C/ZuBH0BoYISllBoEqLa/opg0nt8w2RX9pqx
         G1FT1/WZUwiypqhy8oWr+eZeG+qwz1zywKlzHckLWqLeK5FyrheGVYoBuE2fT2YpQYf+
         eYSpawZNE2VxQO9pp+V53EUD/gG5Gkz8tn6RNqxmcwvWRGS0cDhG8K+I8HE3RoosK+9I
         C/gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ/QGya/VcKR6/x+2VhJI7BsPN3Fvhp1GUcyI6GUWHBLgDTTrUkxVv19MrV+nPwNNFYxn27ZZ/xtyUJ6IW1xlx9aWPp9u0yTCmVVIG
X-Gm-Message-State: AOJu0YwgK+1VL42LJ2qIIvQph0M++DiRcDrBfdkwCIZUeHKOo01M6g5S
	6fXVcLrdpkBmuPfqR1WlIiVTI1gV+YzhZmOQllU0smTBBA6UnrOcg1nwWSAfHTEvOnvZThDK3mi
	0QQ==
X-Google-Smtp-Source: AGHT+IENLGEaWbs37HwWar6l9tfsoGWg6m42nFsyoTQfIezFlKVeE9IraziAYhpEU9jmdwNYoPJqg3Pzh8c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f7c1:b0:1f4:620b:6a47 with SMTP id
 d9443c01a7336-1f6370524bemr2945395ad.4.1717460990723; Mon, 03 Jun 2024
 17:29:50 -0700 (PDT)
Date: Mon, 3 Jun 2024 17:29:49 -0700
In-Reply-To: <20240514.OoPohLaejai6@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240503131910.307630-1-mic@digikod.net> <20240503131910.307630-4-mic@digikod.net>
 <ZjTuqV-AxQQRWwUW@google.com> <20240506.ohwe7eewu0oB@digikod.net>
 <ZjmFPZd5q_hEBdBz@google.com> <20240507.ieghomae0UoC@digikod.net>
 <ZjpTxt-Bxia3bRwB@google.com> <20240514.OoPohLaejai6@digikod.net>
Message-ID: <Zl5f_T7Nb-Fk8Y1o@google.com>
Subject: Re: [RFC PATCH v3 3/5] KVM: x86: Add notifications for Heki policy
 configuration and violation
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Alexander Graf <graf@amazon.com>, 
	Angelina Vu <angelinavu@linux.microsoft.com>, 
	Anna Trikalinou <atrikalinou@microsoft.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Forrest Yuan Yu <yuanyu@google.com>, James Gowans <jgowans@amazon.com>, 
	James Morris <jamorris@linux.microsoft.com>, John Andersen <john.s.andersen@intel.com>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Marian Rotariu <marian.c.rotariu@gmail.com>, 
	"Mihai =?utf-8?B?RG9uyJt1?=" <mdontu@bitdefender.com>, 
	"=?utf-8?B?TmljdciZb3IgQ8OuyJt1?=" <nicu.citu@icloud.com>, Thara Gopinath <tgopinath@microsoft.com>, 
	Trilok Soni <quic_tsoni@quicinc.com>, Wei Liu <wei.liu@kernel.org>, 
	Will Deacon <will@kernel.org>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	"=?utf-8?Q?=C8=98tefan_=C8=98icleru?=" <ssicleru@bitdefender.com>, dev@lists.cloudhypervisor.org, 
	kvm@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, qemu-devel@nongnu.org, 
	virtualization@lists.linux-foundation.org, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024, Micka=C3=ABl Sala=C3=BCn wrote:
> On Tue, May 07, 2024 at 09:16:06AM -0700, Sean Christopherson wrote:
> > On Tue, May 07, 2024, Micka=C3=ABl Sala=C3=BCn wrote:
> > > If yes, that would indeed require a *lot* of work for something we're=
 not
> > > sure will be accepted later on.
> >=20
> > Yes and no.  The AWS folks are pursuing VSM support in KVM+QEMU, and SV=
SM support
> > is trending toward the paired VM+vCPU model.  IMO, it's entirely feasib=
le to
> > design KVM support such that much of the development load can be shared=
 between
> > the projects.  And having 2+ use cases for a feature (set) makes it _mu=
ch_ more
> > likely that the feature(s) will be accepted.
> >=20
> > And similar to what Paolo said regarding HEKI not having a complete sto=
ry, I
> > don't see a clear line of sight for landing host-defined policy enforce=
ment, as
> > there are many open, non-trivial questions that need answers. I.e. upst=
reaming
> > HEKI in its current form is also far from a done deal, and isn't guaran=
teed to
> > be substantially less work when all is said and done.
>=20
> I'm not sure to understand why "Heki not having a complete story".  The
> goal is the same as the current kernel self-protection mechanisms.

HEKI doesn't have a complete story for how it's going to play nice with kex=
ec(),
emulated RESET, etc.  The kernel's existing self-protection mechanisms Just=
 Work
because the protections are automatically disabled/lost on such transitions=
.
They are obviously significant drawbacks to that behavior, but they are acc=
epted
drawbacks, i.e. solving those problems isn't in scope (yet) for the kernel.=
  And
the "failure" mode is also loss of hardening, not an unusable guest.

In other words, the kernel's hardening is firmly best effort at this time,
whereas HEKI likely needs to be much more than "best effort" in order to ju=
stify
the extra complexity.  And that means having answers to the various interop=
erability
questions.

