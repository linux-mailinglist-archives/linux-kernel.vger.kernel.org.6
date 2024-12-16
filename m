Return-Path: <linux-kernel+bounces-448283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4FA9F3E22
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192761881CEA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365901D9339;
	Mon, 16 Dec 2024 23:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="siR/rlVZ"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0C31A83F1
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 23:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734390999; cv=none; b=t0DmY9+4No77+T/k0QAbIWTO/ZshKCBtMnTTJ4jYOTbZMP1SFNJYXdUc4znVSRF9Cs0rk7voDrsHb3DwsqTCxJ1JZXoKQHAzQussHW+gR08znHoNiPJ1F9jmzsn0/a4HDMvSD1pXr8ZHlNzU8CZ9laUpc2dxxRQri6Wuz1IIDtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734390999; c=relaxed/simple;
	bh=QbC5g1iB0XjloilOJA7ZBor/kTHwMHRtOFD/mNAsFhM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gNXLWD/H7JeGzXEIDeq9tddJ6xnIRna60XTb6v+ATMSJ+mt6SSw5m3YqqXEdag4ESMFLZChntRcGfxPKJLes7GJhZkORfrLMfk8RdK76zihw5kyiOmvAZU6u4ELxIXw/4Ve7OBPUet7g5Itr1YNXm3Y/g2e7tYHlEiHrrxpa1GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=siR/rlVZ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2eeeb5b7022so4368309a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 15:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734390997; x=1734995797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bh59gmjWYtusGCF0p90acp83ZY1LfaTbvHTo9iq0hFk=;
        b=siR/rlVZoRgCrq/Nzkvh0A188+ZVZiXLvCEM9Q+TijwKYBSOKl5nMyz7E2xw8ofNZm
         WwKKAXQ2c45rVtSAtg/LmPvxMooipXvHIN0TnfoI317bAwCwR5mPy/hbR6Rg++eCNOTU
         A104IUOQ5KGtmVFzOZ7D1YE8L5iVcyCl/mpGjlh62VtBmqLScaii9WEoCAVljjCZHz68
         wYgqGljkCueNkcXHPVer+XSMaS9GVCunKfdLNXeZ3jb1A5V7JInTwZ14w7AqoFwsbyGE
         ngzceTOKBAfNobKU/Jd4Z/LmseVeB94RqPXdQ6ReYe9qkGEOTu1SdhjaNmYSir3eTgeN
         Vdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734390997; x=1734995797;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bh59gmjWYtusGCF0p90acp83ZY1LfaTbvHTo9iq0hFk=;
        b=hzZe7QnqmSiQhEhsgKj6pX4Uf5ZldkvC02G0nPjyXUfvZUriAAcbCpapQehUs7Y43Z
         yY2oOnxBTE7vymaeenedJ0t6gYYSTnIa77pGPtCP76Hj8iw69URq9yKtbfrYizKLuAQU
         Vi45nDMW9bgeZWW42OPhZ41pgs9eIEAxfN50nvjn3bweeevUxjdiDtKocjwKHrKWHshM
         tXOFdLmXaNLvjVRMhkU2KSoOQYlijimhAtOPC+EXp76YFJqMFIxS1R5PAgjqQGswBCE1
         h3Iowrdmk8gkuPFxSfL9VS/NSwaCKb8SKkLyzFgS1jgF3u1/EXO0Uz/caapmW3Up0qNB
         Oj/g==
X-Forwarded-Encrypted: i=1; AJvYcCVcoYxdsSO+5XO0slXp9u0SlIm0Ot4Ttn55MhlOuPSyrk49RQGcYTPfBlq/MULxyoPidFT+OhtyXbqRnbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTyB2zVafkjDMACCB+rj1Rts8S+NiEwJGhQwir3Cgu+4/Myiy1
	HzJYgboyGZZ3O08OF7KyAK0QfkJy72jYVEm5BpkCyYlLDutPOdEjDpYC68AIH9QSxqEEgXWjTP6
	3ow==
X-Google-Smtp-Source: AGHT+IHYqVjK1adC5LAAJ4dkiCtlixDDCy3D3XjNpph2EXYwjy1TVslGF25mn205V97JtTp6ehx8tNJBuhQ=
X-Received: from pjvb16.prod.google.com ([2002:a17:90a:d890:b0:2ea:5613:4d5d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f88:b0:2ee:ba0c:1718
 with SMTP id 98e67ed59e1d1-2f290dbdd9bmr21125837a91.37.1734390997568; Mon, 16
 Dec 2024 15:16:37 -0800 (PST)
Date: Mon, 16 Dec 2024 15:16:36 -0800
In-Reply-To: <CALMp9eQaqYG4F6f9gm0_a9v+6A_1jXBxX5Wy3J-pDBk8iar1YA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211013302.1347853-1-seanjc@google.com> <CALMp9eQaqYG4F6f9gm0_a9v+6A_1jXBxX5Wy3J-pDBk8iar1YA@mail.gmail.com>
Message-ID: <Z2C01HZUkU7UFHHv@google.com>
Subject: Re: [PATCH 0/5] KVM: x86: Address xstate_required_size() perf regression
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024, Jim Mattson wrote:
> On Tue, Dec 10, 2024 at 5:33=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > Fix a hilarious/revolting performance regression (relative to older CPU
> > generations) in xstate_required_size() that pops up due to CPUID _in th=
e
> > host_ taking 3x-4x longer on Emerald Rapids than Skylake.
> >
> > The issue rears its head on nested virtualization transitions, as KVM
> > (unnecessarily) performs runtime CPUID updates, including XSAVE sizes,
> > multiple times per transition.  And calculating XSAVE sizes, especially
> > for vCPUs with a decent number of supported XSAVE features and compacte=
d
> > format support, can add up to thousands of cycles.
> >
> > To fix the immediate issue, cache the CPUID output at kvm.ko load.  The
> > information is static for a given CPU, i.e. doesn't need to be re-read
> > from hardware every time.  That's patch 1, and eliminates pretty much a=
ll
> > of the meaningful overhead.
> >
> > Patch 2 is a minor cleanup to try and make the code easier to read.
> >
> > Patch 3 fixes a wart in CPUID emulation where KVM does a moderately
> > expensive (though cheap compared to CPUID, lol) MSR lookup that is like=
ly
> > unnecessary for the vast majority of VMs.
> >
> > Patches 4 and 5 address the problem of KVM doing runtime CPUID updates
> > multiple times for each nested VM-Enter and VM-Exit, at least half of
> > which are completely unnecessary (CPUID is a mandatory intercept on bot=
h
> > Intel and AMD, so ensuring dynamic CPUID bits are up-to-date while runn=
ing
> > L2 is pointless).  The idea is fairly simple: lazily do the CPUID updat=
es
> > by deferring them until something might actually consume guest the rele=
vant
> > bits.
> >
> > This applies on the cpu_caps overhaul[*], as patches 3-5 would otherwis=
e
> > conflict, and I didn't want to think about how safe patch 5 is without
> > the rework.
> >
> > That said, patch 1, which is the most important and tagged for stable,
> > applies cleanly on 6.1, 6.6, and 6.12 (and the backport for 5.15 and
> > earlier shouldn't be too horrific).
> >
> > Side topic, I can't help but wonder if the CPUID latency on EMR is a CP=
U
> > or ucode bug.  For a number of leaves, KVM can emulate CPUID faster tha=
n
> > the CPUID can execute the instruction.  I.e. the entire VM-Exit =3D> em=
ulate
> > =3D> VM-Enter sequence takes less time than executing CPUID on bare met=
al.
> > Which seems absolutely insane.  But, it shouldn't impact guest performa=
nce,
> > so that's someone else's problem, at least for now.
>=20
> Virtualization aside, perhaps Linux should set
> MSR_FEATURE_ENABLES.CPUID_GP_ON_CPL_GT_0[bit 0] on EMR, and emulate
> the CPUID instruction in the kernel?  :)

Heh, that thought crossed my mind too.

