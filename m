Return-Path: <linux-kernel+bounces-398417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FA29BF107
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4616D1F21B1F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55268202F78;
	Wed,  6 Nov 2024 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JX3rSfS2"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71FD201101
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905271; cv=none; b=m78551d8KR7EVSMqLv+IWstMx95RFl5ddyZkZz032LVz2pnwJnASGIxTVbu4VYtLJZKTkF7A5HJNPbkzA9XKxdeqLRjfS1Wvnw1NLMap5GXxz7Ydz8s05FnoidaMEfDVgYvhoRpUdSU870bHlI4IEna3gP71fTKQO0RXnODD3Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905271; c=relaxed/simple;
	bh=Z0c8gs4NeTG3e67oDj5S9Cg2zsOgPpj1v/lEMsG2g8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hxBz4bo5fuyLkZ8R2t57mzVYo/iue1r8p3wV87uCdxdjj+hbgORn68LA9K5iERAE2Sm7R/paSwW5J1a9JhRiG670g8EIIC3DKPjjbycUp+rCbv83nD/62I1CVfd+OHIW9h6+YmKwfrl5Y8IbGQXJH1N467I2OuFhcxuZMgCVMvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JX3rSfS2; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea8a5e86e9so73063657b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 07:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730905269; x=1731510069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VYAfhvKkuerdSihdQhzi/pfe/p7rv1z+IVs1L+3kk6s=;
        b=JX3rSfS2rBAaimztpfu6GWd+dGHRw2ro4a9aHTWlB0yIavWHLXvNh1OHU0zW3tRcyf
         84r73vOnKIRn4VF+6m9Q8+qpEtoSgso4pW0qZN4n0kgVGDuTYHSKd4k2HMryEOb1V0hf
         eiFf3FzBnsV9fMI7h+CuXYkgUzs9oUKzia3iVaoH0QpaTzYeCjpXoeVmEDdKHBjo4oD8
         2KKwSlZ0pd4ITJXFfCBammamDBMQ/Re4ep5MkiiA7LK6e0jlqnVqxN8YNL84g9poV5Zo
         YnW/TroLJoFbRMGlgVIMfNwLGFx9o/ZiZvAoA3T3MOKAV9a4KyPNyMCJKuQDXJi+X0am
         MmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730905269; x=1731510069;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VYAfhvKkuerdSihdQhzi/pfe/p7rv1z+IVs1L+3kk6s=;
        b=Iwc4Dw0d6NbH28AF/zUSwk/1C62xg3qNXu75qoegamnjSZLECeAqgAQic/kP8d0Wk0
         eApjJcBZ2qYRCKg3igPOuIjQ6Pob7Ca+PwbGbmTA7buhple43Sv/OdzKwwYk+W2jBjOI
         L9Qs5CjxK2P4ijtDp+lcqSokh91ut0GlEv0MG4r738byweAJFOpSKVU3Oti9fpsSOfsm
         6j51FvQ3FPTeLUk9jmcHxjZMWL448vriwTNfA9nwJsLAdDZcLiIlZUmZ8dExLmYiWWVD
         ZWffn+TmW8OIkSych/WXDJV09MOQ/zP/XVm0oFNm0ymzMRcUS8emzBSjF04WuhSBAL/v
         H1ww==
X-Forwarded-Encrypted: i=1; AJvYcCU7nQkfp1nSpHw3a0bb36MGcWlb7Snac0LZr1rhxHvbC0Vd72zuChZ599L8DOqf/RkSdyJvgXo7aQsZSqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiYM+Mk/eJVdtYsouCpQUdPvarJ+dG3WapeNhf1EZWyGdU9hg6
	ulzpPd9wTRCwBoxRzShSxZ0CwU4xsxwGUOPLg/o8OmCzcEcuycJsi0zjsWOHHeBKaJcbtBXn7hC
	/Ew==
X-Google-Smtp-Source: AGHT+IGmvLLu4xkARPXEZr5dolMVkPcsce9DoXRZ0LomVsW3PA7xZnWHHtjVZwtg9qxjt3KGd5Xl0NReBz0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:c8c:b0:6e6:c8b:4afa with SMTP id
 00721157ae682-6ea52532623mr1803527b3.5.1730905268872; Wed, 06 Nov 2024
 07:01:08 -0800 (PST)
Date: Wed, 6 Nov 2024 07:01:07 -0800
In-Reply-To: <37f497d9e6e624b56632021f122b81dd05f5d845.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1730120881.git.kai.huang@intel.com> <f7394b88a22e52774f23854950d45c1bfeafe42c.1730120881.git.kai.huang@intel.com>
 <ZyJOiPQnBz31qLZ7@google.com> <46ea74bcd8eebe241a143e9280c65ca33cb8dcce.camel@intel.com>
 <ZyPnC3K9hjjKAWCM@google.com> <37f497d9e6e624b56632021f122b81dd05f5d845.camel@intel.com>
Message-ID: <ZyuDgLycfadLDg3A@google.com>
Subject: Re: [PATCH 3/3] KVM: VMX: Initialize TDX during KVM module load
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, Dave Hansen <dave.hansen@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Dan J Williams <dan.j.williams@intel.com>, 
	Yan Y Zhao <yan.y.zhao@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Tony Lindgren <tony.lindgren@intel.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kristen@linux.intel.com" <kristen@linux.intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2024, Kai Huang wrote:
> On Thu, 2024-10-31 at 13:22 -0700, Sean Christopherson wrote:
> > On Thu, Oct 31, 2024, Kai Huang wrote:
> > > On Wed, 2024-10-30 at 08:19 -0700, Sean Christopherson wrote:
> > > > > +void __init tdx_bringup(void)
> > > > > +{
> > > > > +	enable_tdx =3D enable_tdx && !__tdx_bringup();
> > > >=20
> > > > Ah.  I don't love this approach because it mixes "failure" due to a=
n unsupported
> > > > configuration, with failure due to unexpected issues.  E.g. if enab=
ling virtualization
> > > > fails, loading KVM-the-module absolutely should fail too, not simpl=
y disable TDX.
> > >=20
> > > Thanks for the comments.
> > >=20
> > > I see your point.  However for "enabling virtualization failure" kvm_=
init() will
> > > also try to do (default behaviour), so if it fails it will result in =
module
> > > loading failure eventually. =C2=A0So while I guess it would be slight=
ly better to
> > > make module loading fail if "enabling virtualization fails" in TDX, i=
t is a nit
> > > issue to me.
> > >=20
> > > I think "enabling virtualization failure" is the only "unexpected iss=
ue" that
> > > should result in module loading failure.  For any other TDX-specific
> > > initialization failure (e.g., any memory allocation in future patches=
) it's
> > > better to only disable TDX.
> >=20
> > I disagree.  The platform owner wants TDX to be enabled, KVM shouldn't =
silently
> > disable TDX because of a transient, unrelated failure.
> >=20
> > If TDX _can't_ be supported, e.g. because EPT or MMIO SPTE caching was =
explicitly
> > disable, then that's different.  And that's the general pattern through=
out KVM.
> > If a requested feature isn't supported, then KVM continues on updates t=
he module
> > param accordingly.  But if something outright fails during setup, KVM a=
borts the
> > entire sequence.
> >=20
> > > So I can change to "make loading KVM-the-module fail if enabling virt=
ualization
> > > fails in TDX", but I want to confirm this is what you want?
> >=20
> > I would prefer the logic to be: reject loading kvm-intel.ko if an opera=
tion that
> > would normally succeed, fails.
>=20
> I looked at the final tdx.c that in our development branch [*], and below=
 is the
> list of the things that need to be done to init TDX (the code in
> __tdx_bringup()), and my thinking of whether to fail loading the module o=
r just
> disable TDX:
>=20
> 1) Early dependency check fails.  Those include: tdp_mmu_enabled,
> enable_mmio_caching, X86_FEATURE_MOVDIR64B check and check the presence o=
f
> TSX_CTL uret MSR.
>=20
> For those we can disable TDX only but continue to load module.
>=20
> 2) Enable virtualization fails.
>=20
> For this we fail to load module (as you suggested).
>=20
> 3) Fail to register TDX cpuhp to do tdx_cpu_enable() and handle cpu hotpl=
ug.
>=20
> For this we only disable TDX but continue to load module.  The reason is =
I think
> this is similar to enable a specific KVM feature but the hardware doesn't
> support it.  We can go further to check the return value of tdx_cpu_enabl=
e() to
> distinguish cases like "module not loaded" and "unexpected error", but I =
really
> don't want to go that far.

Hrm, tdx_cpu_enable() is a bit of a mess.  Ideally, there would be a separa=
te
"probe" API so that KVM could detect if TDX is supported.  Though maybe it'=
s the
TDX module itself is flawed, e.g. if TDH_SYS_INIT is literally the only way=
 to
detect whether or not a module is loaded.

So, absent a way to clean up tdx_cpu_enable(), maybe disable the module par=
am if
it returns -ENODEV, otherwise fail the module load?

> 4) tdx_enable() fails.
>=20
> Ditto to 3).

No, this should fail the module load.  E.g. most of the error conditions ar=
e
-ENOMEM, which has nothing to do with host support for TDX.

> 5) tdx_get_sysinfo() fails.
>=20
> This is a kernel bug since tdx_get_sysinfo() should always return valid T=
DX
> sysinfo structure pointer after tdx_enable() is done successfully.  Curre=
ntly we
> just WARN() if the returned pointer is NULL and disable TDX only.  I thin=
k it's
> also fine.
>=20
> 6) TDX global metadata check fails, e.g., MAX_VCPUS etc.
>=20
> Ditto to 3).  For this we disable TDX only.

Where is this code?

