Return-Path: <linux-kernel+bounces-331017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E19897A74A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 20:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB181C22816
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8539815B572;
	Mon, 16 Sep 2024 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PhDmi8QY"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FE813211F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 18:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726511069; cv=none; b=oY+BBMY0aWvwFQUF3++tZ2iJp8nSMNl0ijoatGVvLm0nZ7ywN8PFaAc7kvDLRzf4qUk+AfLts3F97S351yhc0msC7emrxyxl4hxQru+S07qxlSQLUW374ZODSyav9Z/fC/Ai7GGZCcJQicLqDRPxQjGuVKcjrT85puLHdWFjQSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726511069; c=relaxed/simple;
	bh=KyN8GKvHoP6oAAePFJM111cdcf+1s0w20NMicGPpf5o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dcOvg75V5lpOhP7EhnFmAph6Aemq//NNIJPxocf5Y130B6P0hkFUDo/QHD/p4I5St5pW0Id1qKmJwslmCdEPHWY7icZkKQynNTlyf4f9yz4wnR0TivMsqiqBXGYJxReD+B9o75/TN8Y5z6UngP5Co6dlgcOPlXGrYL2aFKr7CYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PhDmi8QY; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e17bb508bb9so7928674276.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 11:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726511067; x=1727115867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWVVert/0duLgr8lppMjlBcvaVlhn5CV2P73SctPY5A=;
        b=PhDmi8QY8HXvWeZDVLCDmpjTTaxYVgf3GoXVan3Qim27iF9p3KG+odLNLZwNB5WOTd
         EvnBVSKt3lZ7/PSSMsLs8/y7OcXPsfiAyylEQt8KESVWflKzdbcMtVjxvL7GNYQpMRWJ
         QHCCqzf0NidZ27O8zNMBZZMGNSa44LAFz56kzDWstcWxIc3Lqi10TpIhn4gNQlXvo5qp
         tgt8410g4gkdZ1HRExxHOWOn4MFZte8qEDzAwPJ+AiaabGVjC4hVwqncbgWCxDqbmA4W
         VpOsuytOtojxEwfHDGkp4ivWF4B/ym4813pmIp7DTjIY8sxuUMHXEGWgVcXQ4fEJzmJj
         VYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726511067; x=1727115867;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PWVVert/0duLgr8lppMjlBcvaVlhn5CV2P73SctPY5A=;
        b=I4ZWf6pLHhdx1elAUnVKFzbBs0+8XgqtFcTLLRlJUaR13mIo+j2rknsFuO3lc0MRe0
         D8/JhjHl63AVrSeyaQDHZWjGaL7Q3yZQ6B3k5Am+8Y5T+HtZW7VnICALXdyFqRrF08o0
         k+cCdOmiTwLB0BVveKLWhgzExzFasTVoogqDSxhDduNlr7L4djlazI8fiZPBBjrkfu3g
         3+FpiMvudinjXTExuK5bpE4FLi6Luq29uR8N/j4kFzwuzFzpm3Jba6x5TBNVM50yldq2
         9dVeuFxf18Wc1f28obYq9ML9gMHYNQO2FnclB0Ipv1pNC7F7qCJOoOU6tT6D2Y/G4OTZ
         oU2w==
X-Forwarded-Encrypted: i=1; AJvYcCXTou+hZ03Cx4MfmtEan8Vy97Cvmir3pjNMs+wG8tZjr4pWdzXNjVptAqvZ9VjKF5U4efTbFzkTITU4mPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr/FJTPJcYlByLO6PhJRe4zIhqbKt9O3lZvY4jlBLH/Ix/2h0M
	iW3SvhyOh/RQiNvdssfp6P1bQcIzJcMOZa2NT7CsTVVWf3mtIjpTAgUz6qGnk0wu2/R64SPlWRC
	bnQ==
X-Google-Smtp-Source: AGHT+IGw6+fTdMMlTRPuPFeoq64qFkHtSG8aeQPj9JG0eFHtNo93fBF43eoD6YBxvGRG6q4NAAC5M9oExS0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:c4a:0:b0:e17:c4c5:bcb2 with SMTP id
 3f1490d57ef6-e1db00d2b9dmr49146276.7.1726511067380; Mon, 16 Sep 2024 11:24:27
 -0700 (PDT)
Date: Mon, 16 Sep 2024 11:24:25 -0700
In-Reply-To: <CABgObfZ1oZHU+9LKc_uiPZs1uwqxczcknspCD=BJCFZd5+-yyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240914011348.2558415-1-seanjc@google.com> <CABgObfbV0HOAPA-4XjdUR2Q-gduEQhgSdJb1SzDQXd08M_pD+A@mail.gmail.com>
 <CABgObfZ1oZHU+9LKc_uiPZs1uwqxczcknspCD=BJCFZd5+-yyw@mail.gmail.com>
Message-ID: <Zuh32evWMcs8hTAM@google.com>
Subject: Re: [GIT PULL] KVM: x86 pull requests for 6.12
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024, Paolo Bonzini wrote:
> On Sat, Sep 14, 2024 at 4:54=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
> >
> > On Sat, Sep 14, 2024 at 3:13=E2=80=AFAM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > > There's a trivial (and amusing) conflict with KVM s390 in the selftes=
ts pull
> > > request (we both added "config" to the .gitignore, within a few days =
of each
> > > other, after the goof being around for a good year or more).
> > >
> > > Note, the pull requests are relative to v6.11-rc4.  I got a late star=
t, and for
> > > some reason thought kvm/next would magically end up on rc4 or later.
> > >
> > > Note #2, I had a brainfart and put the testcase for verifying KVM's f=
astpath
> > > correctly exits to userspace when needed in selftests, whereas the ac=
tual KVM
> > > fix is in misc.  So if you run KVM selftests in the middle of pulling=
 everything,
> > > expect the debug_regs test to fail.
> >
> > Pulled all, thanks. Due to combination of being recovering from flu +
> > preparing to travel I will probably spend not be able to run tests for
> > a few days, but everything should be okay for the merge window.
>=20
> Hmm, I tried running tests in a slightly non-standard way (compiling
> the will-be-6.12 code on a 6.10 kernel and installing the module)
> because that's what I could do for now, and I'm getting system hangs
> in a few tests. The first ones that hung were
>=20
> hyperv_ipi
> hyperv_tlb_flush

This one failing gives me hope that it's some weird combination of 6.10 and=
 the
for-6.12 code.  Off the top of my head, I can't think of any relevant chang=
es.

FWIW, I haven't been able to reproduce any failures with kvm/next+kvm-x86/n=
ext,
on AMD or Intel.

> xapic_ipi_test
>=20
> And of course, this is on a machine that doesn't have serial
> console... :( I think for now I'll push the non-x86 stuff to kvm/next
> and then either bisect or figure out how to run tests normally.

