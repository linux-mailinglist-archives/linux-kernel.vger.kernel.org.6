Return-Path: <linux-kernel+bounces-391241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A5B9B8446
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECAA21F23FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56D01CBEB4;
	Thu, 31 Oct 2024 20:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YCuAAVdH"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508C81A2562
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730406161; cv=none; b=RXocn25ASELOPdEH/exoD0EKXzUusZYCPwgOYCO8Kp/XsiodQs7vptMHbN07hO5yfmPI8GAUUZTwZFHKFkE6q22O5WVMkV/Ag/ugT8vj/2dw57GQUAJjag3wcqobOP1Vhv+iNHkbMnAhhMobUmru9RpKMArE6alNAKb5YTd0mPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730406161; c=relaxed/simple;
	bh=0m0Sx0hef3cQHUhmb323kP1v6my3krL3Tt1ub0MAh6k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CxdMN3P32bRoMigwG4fVDInYzDyCP7auZH9w1ouljKoDa7heAL75DaI2LcaaraHvvOv8bBM+ZPFk92zgyEjpmW5ASAqZo9xD6Sj2svtHg62q2GWCiTiw7LMac9oLKeVPbpzqQDTv5SDLm7EKftVAF+H4CzGKg4n0kWH33RJjEKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YCuAAVdH; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e293150c2c6so3521959276.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730406158; x=1731010958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/SodepQoLygHqd2aIldey6b/axW8k35n8oLJSW1lWCE=;
        b=YCuAAVdHLCquoG9tYFMy4eQgR38kRF5icus3fJdo47jZbcoG1bsLGJmkOmaSU0Ae/+
         fmHKJ1GqefQJFrNuhR/9GAuf/e3Sq9V3sTSBvnbgkU5Lrk0p3phCryArIAdXQQAYywRT
         ry0bb+qECq7Z62gW4sP9NtK8JFYCOTHviimR8xu/HNaYIkeQcdkgmpMR2YJs6uPbnl7U
         UPWrHH7GFvhtLPLtGzgFI3TnlbnT8D/1seORNXsW9jYQQTOgTC3DjKcfa7Ep7uKA0GZY
         Ul4FD/lUUmc/z8fk3/7TVefIgXQvz2hvM5O64eUzZlHZE1TS6PhXkZ7gd+uMlhOaHbKT
         S5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730406158; x=1731010958;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/SodepQoLygHqd2aIldey6b/axW8k35n8oLJSW1lWCE=;
        b=dORb1lODc0B7hXXcai27ZfB3o5ZcBM6/9wcdH4UIunPzQ2GBEOXYUOjBOlaov3Utqf
         MVLQsrWKyyzG5dGo+st9TquZ8PKFOUnSf1tgioDm8Q19GMoTur3c9bv+ElxFPS859uQ0
         Or9nsqIoPYhIhyaLa5r6svkZblnR4zwLMhV5zSwo6t6krIRINLAekIYUi+pZVEaVcKnT
         W+LnEwj8O+Rjy/k/JCeWPciMib6zh2o74oOHGmiR+g1Ca9ayHPvoMsmAH7luFSX7rvQo
         EqFy0RQzQb0W7Nujw0pyY/Zf8EZglruWmiEYeCk2dVTwFQHXp++NArkN2mXHWr4QYs+p
         plgA==
X-Forwarded-Encrypted: i=1; AJvYcCVqYdP+125V/c4eQ52VDM1Gpxxf6daGh7zmbILXjFMXl19fBt9B0+q2LOlRPXMGidU7AnUgWrYow1aLi+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxezEVIhjL1ufeBGQAVu0/uZtcHgfe1+QN1mIIT5kHRBjUYRU+m
	G0PHymVVrQpEG5XbaBlEy0Nrc38NMwYNMpwP56QuVs5n4CIPVnPV42WxeQVrnKqrJ2A5g4eVB0l
	rkg==
X-Google-Smtp-Source: AGHT+IGagymATZ1f8HFi1REGMYbBEYlBwt4gqBQox/2m1F48NnAk7T3TDIO03eVpTTcrSv+78KNe61QhODc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:3611:0:b0:e30:d518:30f2 with SMTP id
 3f1490d57ef6-e30e5a04ademr2512276.1.1730406157307; Thu, 31 Oct 2024 13:22:37
 -0700 (PDT)
Date: Thu, 31 Oct 2024 13:22:35 -0700
In-Reply-To: <46ea74bcd8eebe241a143e9280c65ca33cb8dcce.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1730120881.git.kai.huang@intel.com> <f7394b88a22e52774f23854950d45c1bfeafe42c.1730120881.git.kai.huang@intel.com>
 <ZyJOiPQnBz31qLZ7@google.com> <46ea74bcd8eebe241a143e9280c65ca33cb8dcce.camel@intel.com>
Message-ID: <ZyPnC3K9hjjKAWCM@google.com>
Subject: Re: [PATCH 3/3] KVM: VMX: Initialize TDX during KVM module load
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: Dan J Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@intel.com>, 
	Tony Lindgren <tony.lindgren@intel.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kristen@linux.intel.com" <kristen@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024, Kai Huang wrote:
> On Wed, 2024-10-30 at 08:19 -0700, Sean Christopherson wrote:
> > > +void __init tdx_bringup(void)
> > > +{
> > > +	enable_tdx =3D enable_tdx && !__tdx_bringup();
> >=20
> > Ah.  I don't love this approach because it mixes "failure" due to an un=
supported
> > configuration, with failure due to unexpected issues.  E.g. if enabling=
 virtualization
> > fails, loading KVM-the-module absolutely should fail too, not simply di=
sable TDX.
>=20
> Thanks for the comments.
>=20
> I see your point.  However for "enabling virtualization failure" kvm_init=
() will
> also try to do (default behaviour), so if it fails it will result in modu=
le
> loading failure eventually. =C2=A0So while I guess it would be slightly b=
etter to
> make module loading fail if "enabling virtualization fails" in TDX, it is=
 a nit
> issue to me.
>=20
> I think "enabling virtualization failure" is the only "unexpected issue" =
that
> should result in module loading failure.  For any other TDX-specific
> initialization failure (e.g., any memory allocation in future patches) it=
's
> better to only disable TDX.

I disagree.  The platform owner wants TDX to be enabled, KVM shouldn't sile=
ntly
disable TDX because of a transient, unrelated failure.

If TDX _can't_ be supported, e.g. because EPT or MMIO SPTE caching was expl=
icitly
disable, then that's different.  And that's the general pattern throughout =
KVM.
If a requested feature isn't supported, then KVM continues on updates the m=
odule
param accordingly.  But if something outright fails during setup, KVM abort=
s the
entire sequence.

> So I can change to "make loading KVM-the-module fail if enabling virtuali=
zation
> fails in TDX", but I want to confirm this is what you want?

I would prefer the logic to be: reject loading kvm-intel.ko if an operation=
 that
would normally succeed, fails.

