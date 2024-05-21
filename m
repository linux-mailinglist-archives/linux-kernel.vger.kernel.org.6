Return-Path: <linux-kernel+bounces-185503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 368CE8CB5F3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 00:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B451C20643
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 22:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87B914A089;
	Tue, 21 May 2024 22:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNpEabnP"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E480149E09
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 22:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716330137; cv=none; b=odWkW6Z/rLsNMYZGkqFxud/stqb7Ukkybuod95UPtF7xVVWVuW7v8B+RdBd22iP2I/D0fpKycFBQcXF2JHPB68A/oMwPjZCWORKqqti5PShLrALWr8AeXV/rm7OJ01EKP+/5F4jGe+YJkr2B96Fqz1F35zdNXWfeUB8ft8ufZ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716330137; c=relaxed/simple;
	bh=9OG6YJiBWX1BZTcot8mqUeoZzedcfSoPqvFGl2LVFE0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=suTBmyihQckNeszow1Db/RTSEjt+1YwAwh8wCLbKCeO+jLcIxFRernWb5ZytVgHeRUn7dLNLF3eGR8vVoQ27D2sJxQpqeXCXa1KMChUzh8oLAdynmUgVS6nHxFr6xkoKuhhywrhQ1PIjSvZgLgrDRobsV3jDLKxRQloQHAH+NTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dNpEabnP; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f441afba80so14836834b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 15:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716330136; x=1716934936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5X8zj2X7DR7aVs20Q87SeB4Pux8IsayFQH3hL1ralw=;
        b=dNpEabnP3S6jjmxWAmxrZe1HXhtbmCABbBBmvejSZcruo5FbFsGdNRFLvoJdMtkVdO
         JMRxn1AsghyXRY1HNzGkI0kNIPCt/PjUmkIb+Ju9nuxWwfpBlp8UxLKjqhoqBhGacsbN
         TgaGcgIouISItwpdsOkFkoTcRVtn22yZTDI1G6MsZVpFc4Got536HJR4ung/pFbZDcxG
         4dW8kOCeDF+VxGecUJxmBWrhMgBMBamRqT5441HX+GfOrEoAvXkU6BG8AV2pTcB8F0nH
         X5eCZK24K1aRhnvaEJzsfz7PiSa90WB1M4iotYVunipKoIhZl8yf+52IDQhLWK43GbN/
         ob+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716330136; x=1716934936;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p5X8zj2X7DR7aVs20Q87SeB4Pux8IsayFQH3hL1ralw=;
        b=q+yK2t3JSD+9W85PHpOIZ68c1UWcaI4bikO3gp9Mq+tH39B2D78D0dQEc4Y2ip7YcX
         rHgBU7hwYUSPUmTTp5j5EtQ3s5syP7KdnGwbNMGQUD9EVgUfdmPol9sdURfJb2Iv1iWU
         kum8jsog2/E2w2rNrR+vVJ7tT7jE/K4zP+Z49QI0VMbPnxvRipah9AmsReTQH+lZcAOj
         Gh1iNzjHINcPQX48alvl1YCm2rC104pdmjMhPF+pxYMZ9ubTfBtqTzFTHP110cMAQhZW
         rkeNhxGzXYUOJSYK86bB8hhrCbEbHfz9u3txY59NcrIEbcOtS3G2sWpjsBxDYGPJkIa3
         xgag==
X-Forwarded-Encrypted: i=1; AJvYcCVo/N5DaCZPlZD6/UuXEoDnyiW1cpT52waF1k3Sa+PxjPM9g/m5WSaaIqo37eklr5HpHVSUSIM0gasZEsr8jXLUqr5UTMsC4i97k9Gv
X-Gm-Message-State: AOJu0Yzc+THpaxP1RLtF9MpFcIpNwfiu3TvG4p6VtGXnavRAAmVp8Sz/
	AGpcFzPUFfREpeqxo0Jp/NQF4EwGc+rEvAiyH7CKt/auOu01LgjG9Jbb/3RqYrjswg8xtp2pTFp
	10Q==
X-Google-Smtp-Source: AGHT+IHFPsL3uiNWYdiJkx1v3DG58IcGSEF/hxExDOJYHbxUqqUBZhntnVfZeeHm5febwPQFWTQoov/b8rQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2349:b0:6ea:baf6:57a3 with SMTP id
 d2e1a72fcca58-6f6d649cfebmr638b3a.6.1716330135521; Tue, 21 May 2024 15:22:15
 -0700 (PDT)
Date: Tue, 21 May 2024 15:22:14 -0700
In-Reply-To: <CABgObfaXAERePMQrrpWg8PqM1TOq8TJT65i3WgU0n0-vePDGNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416050338.517-1-ravi.bangoria@amd.com> <ZjQnFO9Pf4OLZdLU@google.com>
 <9252b68e-2b6a-6173-2e13-20154903097d@amd.com> <Zjp8AIorXJ-TEZP0@google.com>
 <305b84aa-3897-40f4-873b-dc512a2da61f@amd.com> <ZkdqW8JGCrUUO3RA@google.com>
 <b66ea07a-f57e-014c-68b4-729f893c2fbd@amd.com> <Zk0ErRQt3XH7xK6O@google.com> <CABgObfaXAERePMQrrpWg8PqM1TOq8TJT65i3WgU0n0-vePDGNg@mail.gmail.com>
Message-ID: <Zk0elnvnF0n_exKt@google.com>
Subject: Re: [PATCH v2] KVM: SEV-ES: Don't intercept MSR_IA32_DEBUGCTLMSR for
 SEV-ES guests
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>, thomas.lendacky@amd.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, michael.roth@amd.com, nikunj.dadhania@amd.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, santosh.shukla@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024, Paolo Bonzini wrote:
> On Tue, May 21, 2024 at 10:31=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> >
> > On Mon, May 20, 2024, Ravi Bangoria wrote:
> > > On 17-May-24 8:01 PM, Sean Christopherson wrote:
> > > > On Fri, May 17, 2024, Ravi Bangoria wrote:
> > > >> On 08-May-24 12:37 AM, Sean Christopherson wrote:
> > > >>> So unless I'm missing something, the only reason to ever disable =
LBRV would be
> > > >>> for performance reasons.  Indeed the original commits more or les=
s says as much:
> > > >>>
> > > >>>   commit 24e09cbf480a72f9c952af4ca77b159503dca44b
> > > >>>   Author:     Joerg Roedel <joerg.roedel@amd.com>
> > > >>>   AuthorDate: Wed Feb 13 18:58:47 2008 +0100
> > > >>>
> > > >>>     KVM: SVM: enable LBR virtualization
> > > >>>
> > > >>>     This patch implements the Last Branch Record Virtualization (=
LBRV) feature of
> > > >>>     the AMD Barcelona and Phenom processors into the kvm-amd modu=
le. It will only
> > > >>>     be enabled if the guest enables last branch recording in the =
DEBUG_CTL MSR. So
> > > >>>     there is no increased world switch overhead when the guest do=
esn't use these
> > > >>>     MSRs.
> > > >>>
> > > >>> but what it _doesn't_ say is what the world switch overhead is wh=
en LBRV is
> > > >>> enabled.  If the overhead is small, e.g. 20 cycles?, then I see n=
o reason to
> > > >>> keep the dynamically toggling.
> > > >>>
> > > >>> And if we ditch the dynamic toggling, then this patch is unnecess=
ary to fix the
> > > >>> LBRV issue.  It _is_ necessary to actually let the guest use the =
LBRs, but that's
> > > >>> a wildly different changelog and justification.
> > > >>
> > > >> The overhead might be less for legacy LBR. But upcoming hw also su=
pports
> > > >> LBR Stack Virtualization[1]. LBR Stack has total 34 MSRs (two cont=
rol and
> > > >> 16*2 stack). Also, Legacy and Stack LBR virtualization both are co=
ntrolled
> > > >> through the same VMCB bit. So I think I still need to keep the dyn=
amic
> > > >> toggling for LBR Stack virtualization.
> > > >
> > > > Please get performance number so that we can make an informed decis=
ion.  I don't
> > > > want to carry complexity because we _think_ the overhead would be t=
oo high.
> > >
> > > LBR Virtualization overhead for guest entry + exit roundtrip is ~450 =
cycles* on
> >
> > Ouch.  Just to clearify, that's for LBR Stack Virtualization, correct?
>=20
> And they are all in the VMSA, triggered by LBR_CTL_ENABLE_MASK, for
> non SEV-ES guests?
>=20
> > Anyways, I agree that we need to keep the dynamic toggling.
> > But I still think we should delete the "lbrv" module param.  LBR Stack =
support has
> > a CPUID feature flag, i.e. userspace can disable LBR support via CPUID =
in order
> > to avoid the overhead on CPUs with LBR Stack.
>=20
> The "lbrv" module parameter is only there to test the logic for
> processors (including nested virt) that don't have LBR virtualization.
> But the only effect it has is to drop writes to
> MSR_IA32_DEBUGCTL_MSR...
>=20
> >                 if (kvm_cpu_cap_has(X86_FEATURE_LBR_STACK) &&
> >                     !guest_cpuid_has(vcpu, X86_FEATURE_LBR_STACK)) {
> >                         kvm_pr_unimpl_wrmsr(vcpu, ecx, data);
> >                         break;
> >                 }
>=20
> ... and if you have this, adding an "!lbrv ||" is not a big deal, and
> allows testing the code on machines without LBR stack.

Yeah, but keeping lbrv also requires tying KVM's X86_FEATURE_LBR_STACK capa=
bility
to lbrv, i.e. KVM shouldn't advetise X86_FEATURE_LBR_STACK if lbrv=3Dfalse.=
  And
KVM needs to condition SEV-ES on lbrv=3Dtrue.  Neither of those are difficu=
lt to
handle, e.g. svm_set_cpu_caps() already checks plenty of module params, I'm=
 just
not convinced legacy LRB virtualization is interesting enough to warrant a =
module
param.

That said, I'm ok keeping the param if folks prefer that approach.

