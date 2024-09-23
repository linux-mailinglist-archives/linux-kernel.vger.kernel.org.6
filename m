Return-Path: <linux-kernel+bounces-335660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC1897E8B1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09A4AB20920
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B66194ACA;
	Mon, 23 Sep 2024 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fA9rCV/V"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D75319343C
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727083799; cv=none; b=XciCqG3zasvXiqSXEH2bvrmmzKJyO9Hy50bM5I6kmvCtO4BYE/lTY49UnovQpZiLF6P/F+OMSfS6NS6oj7ZwrAaiUgZ4b8iwu/aQm7ugZYStHcMHYkIQCcSCQW5IIv7BL01G4XDosleewFxwIgFaXRV+MX7hDoghe2uDX3BKIN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727083799; c=relaxed/simple;
	bh=JxlWTKfLKfV1N7stRJBPiFZggE9mXH97QTo/q/pDES0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dgESL0HnA00N9YRt8KNBcuRWPmMfrYGW2GbyEeLFcXe39UJiQ1soUneWg/39GBtmvpnW6g1FTA5efXE3oyCrrG41+DbfqX1e+N2No9efxLOd6hva5nOj6hckgROZASXGDzoSJAHzTm75ljUoccmpmufvqKIVxP5Rt+ZKwsVXyiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fA9rCV/V; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7db1762d70fso3402308a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 02:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727083798; x=1727688598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JxlWTKfLKfV1N7stRJBPiFZggE9mXH97QTo/q/pDES0=;
        b=fA9rCV/VNMoIic2tJjpRyqBuR6+vmd1ns6HpenQBMUId4OwuzHACAlXY9R/H+P8wjo
         ZuNYcYVdKcENNPrkTCDmAg/fpYKAcuTyCmEfU3tB5JGmDCC59SXp5tPA8TY29RhvOjkg
         zJU2wimE0DhAnPOfoE8jZgFkoYRIoMfGo/ufmAoimVqJmr7H9Nqn/DeUY6rPWb2h1OYm
         rsOLtFwyuM7utymutJi3RCLSmW2IXZUUNoB9P7KCSKEi48uu60cwgSytjwr35lCNJHAR
         Z0sm33MtFmzLh5yVHfy3sbX9P8eFH0nSG1riQ6VXbqL6/xUCEXDlZLpnqFeYzBNGErud
         NW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727083798; x=1727688598;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JxlWTKfLKfV1N7stRJBPiFZggE9mXH97QTo/q/pDES0=;
        b=VL6fQnmJWY1w6G/qXTzuFOk1U3xfDXgStT1M1e3/JcZQNwWr0M5iogtgbZgcXuYGQV
         tZODDtIwlPO2fLHH+Dw0H9lEAFKH5APakA6gKPzJ6BOMaR1FMHCcIIdDiBJCAegTrL6p
         0Ipm/JwFGMD7EYNXbbi2l2S1HWf8A5tCz5TlXcE694yCbQghG9PWPxDdjxn/Vz0u5ge2
         uz52Z7Mehkk247oFEZxUjyNJCMsNtRR3xzEmqkOmPnCv51voaAPi5zYrs6eqssakzQOx
         zJS8ySmpZehcAHPORLoM7G9x2NUoaUFT0CwLd5ZCooSYmIJPSoMWXynqJgZSZ3vxCueK
         nbFg==
X-Forwarded-Encrypted: i=1; AJvYcCV09Cp0a19qPwE0EK9wrfmS1dAfTwXQ5qvhn5QwveqpRQlkpct8Xr6DIsp2qwSgLMC1LZdoGZRJ3xXlg8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6WsB25hoX1oY1fhnzwTT5/OeH/sTq4BgBYmOrTINB7KY4XPM1
	+qkr+Ee60UnANlcqjv7T3YwRWIIveMjlQoLl3tIVAFtyG7+NdNtElvV37dJX4NRT81t0SHzq9l7
	CFA==
X-Google-Smtp-Source: AGHT+IFSZX5FuNM8tCzpug601r0FUEjufJORJGp2xW2npv3HHNvfqWh9QPhzOBODH4in3nPCT3E6eApyC4U=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:2305:b0:7db:2689:f6ee with SMTP id
 41be03b00d2f7-7e6ae037512mr783a12.7.1727083797611; Mon, 23 Sep 2024 02:29:57
 -0700 (PDT)
Date: Mon, 23 Sep 2024 02:29:55 -0700
In-Reply-To: <e5218efaceec20920166bd907416d6f88905558d.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231002115723.175344-1-mlevitsk@redhat.com> <ZRsYNnYEEaY1gMo5@google.com>
 <1d6044e0d71cd95c477e319d7e47819eee61a8fc.camel@redhat.com> <e5218efaceec20920166bd907416d6f88905558d.camel@redhat.com>
Message-ID: <ZvE06wB0JGWXGxpK@google.com>
Subject: Re: [PATCH v3 0/4] Allow AVIC's IPI virtualization to be optional
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024, Maxim Levitsky wrote:
> On Wed, 2023-10-04 at 16:14 +0300, Maxim Levitsky wrote:
> > =D0=A3 =D0=BF=D0=BD, 2023-10-02 =D1=83 12:21 -0700, Sean Christopherson=
 =D0=BF=D0=B8=D1=88=D0=B5:
> > > On Mon, Oct 02, 2023, Maxim Levitsky wrote:
> > > > Hi!
> > > >=20
> > > > This patch allows AVIC's ICR emulation to be optional and thus allo=
ws
> > > > to workaround AVIC's errata #1235 by disabling this portion of the =
feature.
> > > >=20
> > > > This is v3 of my patch series 'AVIC bugfixes and workarounds' inclu=
ding
> > > > review feedback.
> > >=20
> > > Please respond to my idea[*] instead of sending more patches.=20
> >=20
> > Hi,
> >=20
> > For the v2 of the patch I was already on the fence if to do it this way=
 or to refactor
> > the code, and back when I posted it, I decided still to avoid the refac=
toring.
> >=20
> > However, your idea of rewriting this patch, while it does change less l=
ines of code,
> > is even less obvious and consequently required you to write even longer=
 comment to=20
> > justify it which is not a good sign.
> >=20
> > In particular I don't want someone to find out later, and in the hard w=
ay that sometimes
> > real physid table is accessed, and sometimes a fake copy of it is.
> >=20
> > So I decided to fix the root cause by not reading the physid table back=
,
> > which made the code cleaner, and even with the workaround the code=20
> > IMHO is still simpler than it was before.
> >=20
> > About the added 'vcpu->loaded' variable, I added it also because it is =
something that is=20
> > long overdue to be added, I remember that in IPIv code there was also a=
 need for this,=20
> > and probalby more places in KVM can be refactored to take advantage of =
it,
> > instead of various hacks.
> >=20
> > I did adopt your idea of using 'enable_ipiv', although I am still not 1=
00% sure that this
> > is more readable than 'avic_zen2_workaround'.
>=20
> Hi!
>=20
> Sean, can you take another look at this patch series?

Ya, it might take a week or two, but it's on my todo list.

