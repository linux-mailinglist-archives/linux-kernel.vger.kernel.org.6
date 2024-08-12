Return-Path: <linux-kernel+bounces-283928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C9294FA84
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 01:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51E3BB21535
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3C619A2A8;
	Mon, 12 Aug 2024 23:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jaUCRFJ7"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58FF170A0C
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 23:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723507184; cv=none; b=A5/tRuk1GLV4vCJINqHI/P/pxfk7nbiEcC9Jatz4aYEcZDYn1mY2wLufrkqgZ2INzT5WwDnNnXPATB2aPiAOKmnCf7kVa8jjAg++Y1p3KLfaNiX8V+H6DhdkORWY8DjqpUIZu3lOYjGhn3aZokgXujVl62W+OwYTKIQ/Gx+J7wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723507184; c=relaxed/simple;
	bh=g0tyl5PUP+wK9NuBMt6TH2vOO/Fwr+C64cHZyDZ4lDs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NQqcbgjmOx2dLL1H9hQ6ln0Jv7hQ7FuRiheOY8EZmlBzYOUBtwdrsIo9eYYLSF7iRNH279arfOL9V71kXICaPrBmKBS3NRmFJAHJBf6LGvUl+zuqEcpco4uCyNhZLcsMWEI32Ch/IVMIrfqEDEcDWhj6fO905tiUGg+Bfq1BfeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jaUCRFJ7; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fc47634e3dso43334365ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 16:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723507182; x=1724111982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xkVLv7LlrGu9r3Iv9qG0e2Nje3x1aHRRiIR2Xt4n2gc=;
        b=jaUCRFJ7VnQ4Zh+zkARZDOII52M0Bv3V0vDHmmz7v3GNbyNldjhOlcjTcL42z7rIc3
         3w9TsaNLkZDSUSAebxqTIKqfQk1ORNnKJ/s8609G/x0zvZVbyA2bD+IZ6C07ovd5+N1B
         myp9oIOmsHgqIsPYYnjq4qULIH9PrSoOLhiAdL3aNPNlOjeFkB2XPvkZTPGkYvTal1TF
         1ryqbngTFFYT/JZBCKJ3cpxKSBtYtOssgJAjC/7NhyzzItHfz/pXdK6m+1Hw4mGEDm7S
         82M8xUJI2TAhgrbrD/8Dp98sgYJ1Kr75eO6p1no59w9I7Zlbw3fCl3VT+m8ceolAPQCH
         0sTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723507182; x=1724111982;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xkVLv7LlrGu9r3Iv9qG0e2Nje3x1aHRRiIR2Xt4n2gc=;
        b=RdOv/81G3/QD4DdrvjFzyfRHxCXw9MzN2mmkdJPoLgG0BUujuOqNlB0KqO9bjUeyVZ
         WkRgidvBV3r3zrxJB77bJk4hIEvQW6Eew5imfj2tdVR8fbPOn0qVxsqql69Q47WxKk1L
         xcInHAxHnw5/M58MYz9dsFzzXV9ZXroBh/OI6NhikxnMEwCwpKaGG+7B/u85bG/qW/J+
         v58osScbqiX6AIvpHTQt2NonYi1yuJRfgcKWnyaWa77YmFFcEgp6sQP7zWZbr9XvlKJD
         Kekf4JlqCe0DMSLkzWA0Cc/6O+cPwo+qfN1uKb8OljfTRPQEgi5etKIgsauEv64pzh/k
         Szbw==
X-Forwarded-Encrypted: i=1; AJvYcCWOPCqbP7kmeVTxdcWv0m9tjhdpeyDCXc0iTeWn6eVSZ9j/EiiU6qvLBC2p2hok6DA27gH/2ND5HRFvbzMYzNikFXtaxEjj9M/7zM7f
X-Gm-Message-State: AOJu0YysuJ2r+yV/F3NfXtHX60yk/HAY22X6gGfi/k6ol6DA2NCyOrGu
	258rgo0n5pEgozTyP0bX7rdYdNDqy2w+2+t+sKrMcH4ncbSvoijgnOfsPXU1zlm4WFqGs7VMWdl
	Kfg==
X-Google-Smtp-Source: AGHT+IE54zpvNYRIpauQx2fUW2c4J1ybAMAV0sQcl0g+l007AvifWUKHU2UqnMcCve5fnXfoOaV5cigMM/Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:c406:b0:1fd:9d0c:999e with SMTP id
 d9443c01a7336-201ca19e6e6mr690325ad.9.1723507181791; Mon, 12 Aug 2024
 16:59:41 -0700 (PDT)
Date: Mon, 12 Aug 2024 16:59:40 -0700
In-Reply-To: <35624750846f564e6789c22801300a542cafa7fb.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <1675732476-14401-1-git-send-email-lirongqing@baidu.com>
 <87ttg42uju.ffs@tglx> <SN6PR02MB41571AE611E7D249DABFE56DD4B22@SN6PR02MB4157.namprd02.prod.outlook.com>
 <87o76c2hw2.ffs@tglx> <30eb7680b3c7ae5370dfbf7510e664181f38b80e.camel@infradead.org>
 <ZqzzVRQYCmUwD0OL@google.com> <35624750846f564e6789c22801300a542cafa7fb.camel@infradead.org>
Message-ID: <Zrqh7GlPMRVOVtvY@google.com>
Subject: Re: [PATCH] clockevents/drivers/i8253: Do not zero timer counter in shutdown
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Michael Kelley <mhklinux@outlook.com>, 
	"lirongqing@baidu.com" <lirongqing@baidu.com>, "kys@microsoft.com" <kys@microsoft.com>, 
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, 
	"decui@microsoft.com" <decui@microsoft.com>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2024, David Woodhouse wrote:
> On Fri, 2024-08-02 at 07:55 -0700, Sean Christopherson wrote:
> > On Fri, Aug 02, 2024, David Woodhouse wrote:
> > > On Thu, 2024-08-01 at 20:54 +0200, Thomas Gleixner wrote:
> > > > On Thu, Aug 01 2024 at 16:14, Michael Kelley wrote:
> > > > > I don't have a convenient way to test my sequence on KVM.
> > > >=20
> > > > But still fails in KVM
> > >=20
> > > By KVM you mean the in-kernel one that we want to kill because everyo=
ne
> > > should be using userspace IRQ chips these days?
> >=20
> > What exactly do you want to kill?=C2=A0 In-kernel local APIC obviously =
needs to stay
> > for APICv/AVIC.
>=20
> The legacy PIT, PIC and I/O APIC.
>=20
> > And IMO, encouraging userspace I/O APIC emulation is a net negative for=
 KVM and
> > the community as a whole, as the number of VMMs in use these days resul=
ts in a
> > decent amount of duplicated work in userspace VMMs, especially when acc=
ounting
> > for hardware and software quirks.
>=20
> I don't particularly care, but I thought the general trend was towards
> split irqchip mode, with the local APIC in-kernel but i8259 PIC and I/O
> APIC (and the i8254 PIT, which was the topic of this discussion) being
> done in userspace.

Yeah, that's where most everyone is headed, if not already there.  Letting =
the
I/O APIC live in userspace is probably the right direction long term, I jus=
t don't
love that every VMM seems to have it's own slightly different version.  But=
 I think
the answer to that is to build a library for (legacy?) device emulation so =
that
VMMs can link to an implementation instead of copy+pasting from somwhere el=
se and
inevitably ending up with code that's frozen in time.

