Return-Path: <linux-kernel+bounces-541075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D91ECA4B81C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618083A76F9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 07:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D081E98F2;
	Mon,  3 Mar 2025 07:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pHgu5mJR"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AA01E7C07
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 07:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740985711; cv=none; b=o66lINw403XndWiqtODCwtGiqJkU2vC47UAz85dK/+yK4kaVX8/PDnE0Wia67e/44dkUM2S/2pq2KGERzoTCz6fOMFDrrCVPk3wmaozVM/pgbP7iSUpPSahGm5H6iGJhMEE8q+O7UX4XUNxtYKLgsFbbtLShOiBla3jcZGsiNYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740985711; c=relaxed/simple;
	bh=u6ZIZjS6voSWh+p6UIlMuU4y2eD19VRAPFYD3C1F11g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugFC06fbiLJm41Ha9DkgPilDWWUTyxqS9WTUMfw9RYv5d3hvJmjQMfNc0aJtgo3PFADloTx2lRc8lIPvE0IaeAYhWkTFCA4bw/q9O8J5lbI36N+5zV+jqv2W/wzh/0K3iHbEvKN2jry/GQF5F0nRrzGw95TfAmKgqP+o9aIILp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pHgu5mJR; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47201625705so50332151cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 23:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740985709; x=1741590509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6ZIZjS6voSWh+p6UIlMuU4y2eD19VRAPFYD3C1F11g=;
        b=pHgu5mJRISlPwyxO+L0TJ1V7dWpmJQOShmgO01vF453veJh0G0+V3ZpDxk+wZDIGRa
         7eqb+TpS5xkFP8psDygYXWYUnWowBnqJHKDPRK6hkZX7VjoCuRh6Ixxhq1/gq7f894IH
         3WQXkES7L9ex5rnCK7mf19L+4KEwddO9rmFX77ypNUPzZX9UgW3XupEAx++QG0Zdy4EK
         bTf1fTWRnL4/8HuC5c/LFGDWni9hsO6oCkE5h3FxRZAdLArwAF9NM0hvB4bvolgn1f2i
         04r1UrYdNvAbzn76pwTM1Xq9xH1X67ILHnwL/OmQpZA37BvBxqbGWP/HcgCKbjEpMd3b
         ddtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740985709; x=1741590509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6ZIZjS6voSWh+p6UIlMuU4y2eD19VRAPFYD3C1F11g=;
        b=oS7JfxomWVR0VValq3btAwj0a94nF7rl3jHyUm/Fs7ow86tp1aPdtorMGgnXwPrTaH
         BzHogGVIrpCg3jr6gNJTqiafm9Ow7u+2vTUJsrU8Oc/kGdhJFg1pyd0pxqqRJnP9wQYm
         zqt5GvR3HgkErsVBQsMN0FDSLVDffj5HSDVj/3c4eVXjvUyWTWFsbOQ53lSCzLtolu3Z
         7b5cJDDSmZDfS763Z9E2guZqZYRodGdrzB03zLPhgIrBz9x/d3XoZI0LR/nwD4cvF1Sg
         aDDsssWtjlISq2xSzt9Ee4V8GXlpkvEqfWf69anme8hyF8jzXudJI4ItJI/KpVB8llWI
         o+3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWmuz+oL/ozCck2W56Adm+Wjkl+q3Jb7tkmK8qomgzbZnI7I3eZ/Lo/b4nQtSGCzCHD0ak3AS6ERCHYZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeBxQ19XmTfGnFKLlsdhELuyFt7AYavA1XQOC1w//SMsVGU/CT
	fZWQ6ITTj1/xsPsds1vjuYt7gBGkVh1A7c8t3cxw1MSvXt6edyLtB7XYE2rYbpFv28zAuxIv3nq
	OqhLzy0Y9ITx7SrzdcIJ4iDL4cxkVZzhTZhzV
X-Gm-Gg: ASbGncsI+y+Esc0DFhQ6g+uonzQ0mJ/fgaFldszbetnR/efSehw8OW9Ak1FiAjErrxz
	VBAjoSrYU3RYGSUchS+ZM+Al7G5wNQJmQJ7GGNWlCiySYlQivZ0ZMQV4W05cnQjUymIBEIr0Lgf
	hTbCkm4goZs+y6vdSGT9wLW4VybbMH2Ozxr/7hcpDtCUe/KBMN5650dEI=
X-Google-Smtp-Source: AGHT+IGWRhC+I0EstiOv53N5AGXVU9McVcnTWkXTyb/rcTCTUYGJc4FiMvUjBK4+IKNwqQPt/LTrRrAOyNKwMb9Q0uQ=
X-Received: by 2002:a05:622a:6185:b0:474:d06a:6118 with SMTP id
 d75a77b69052e-474d06a6245mr95942581cf.2.1740985708659; Sun, 02 Mar 2025
 23:08:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115083215.2781310-1-danielsftsai@google.com>
 <20250127100740.fqvg2bflu4fpqbr5@thinkpad> <CAK7fddC6eivmD0-CbK5bbwCUGUKv2m9a75=iL3db=CRZy+A5sg@mail.gmail.com>
 <20250211075654.zxjownqe5guwzdlf@thinkpad> <CAK7fddDkQX1aj5ZyTjh1_Pk+XME3AY=m5ouEFRgmLuJjBJytbA@mail.gmail.com>
 <20250214071552.l4fufap6q5latcit@thinkpad> <Z6-fjJv3LXTir1Yj@google.com>
 <20250219175119.vjfdgvltutpzyyp5@thinkpad> <8634g9sthr.wl-maz@kernel.org> <20250219180931.mjhvibbq3xyppv5g@thinkpad>
In-Reply-To: <20250219180931.mjhvibbq3xyppv5g@thinkpad>
From: Tsai Sung-Fu <danielsftsai@google.com>
Date: Mon, 3 Mar 2025 15:08:17 +0800
X-Gm-Features: AQ5f1JoMGYv6abq_HgGVXFoper_sT6Pdjqvzgx8yjaFdAQvxNnYiBDG_MXVBA4w
Message-ID: <CAK7fddCjmJfa1p9HSm2ZKM3PcK2E3bqmWR8VT4tkcKJim79TQw@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: Separate MSI out to different controller
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Brian Norris <briannorris@chromium.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Chant <achant@google.com>, 
	Sajid Dalvi <sdalvi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Whatever your proposal is, please get it reviewed by Marc.

Since Marc has removed him as the maintainer, I will add other IRQ
chip maintainer as CC when sending out the patch for reviewing.

Thanks

On Thu, Feb 20, 2025 at 2:09=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Wed, Feb 19, 2025 at 06:02:24PM +0000, Marc Zyngier wrote:
> > On Wed, 19 Feb 2025 17:51:19 +0000,
> > Manivannan Sadhasivam <mani@kernel.org> wrote:
> > >
> > > On Fri, Feb 14, 2025 at 11:54:52AM -0800, Brian Norris wrote:
> > > > On Fri, Feb 14, 2025 at 12:45:52PM +0530, Manivannan Sadhasivam wro=
te:
> > > > > On Tue, Feb 11, 2025 at 04:23:53PM +0800, Tsai Sung-Fu wrote:
> > > > > > >Because you cannot set affinity for chained MSIs as these MSIs=
 are muxed to
> > > > > > >another parent interrupt. Since the IRQ affinity is all about =
changing which CPU
> > > > > > >gets the IRQ, affinity setting is only possible for the MSI pa=
rent.
> > > > > >
> > > > > > So if we can find the MSI parent by making use of chained
> > > > > > relationships (32 MSI vectors muxed to 1 parent),
> > > > > > is it possible that we can add that implementation back ?
> > > > > > We have another patch that would like to add the
> > > > > > dw_pci_msi_set_affinity feature.
> > > > > > Would it be a possible try from your perspective ?
> > > > > >
> > > > >
> > > > > This question was brought up plenty of times and the concern from=
 the irqchip
> > > > > maintainer Marc was that if you change the affinity of the parent=
 when the child
> > > > > MSI affinity changes, it tends to break the userspace ABI of the =
parent.
> > > > >
> > > > > See below links:
> > > > >
> > > > > https://lore.kernel.org/all/87mtg0i8m8.wl-maz@kernel.org/
> > > > > https://lore.kernel.org/all/874k0bf7f7.wl-maz@kernel.org/
> > > >
> > > > It's hard to meaningfully talk about a patch that hasn't been poste=
d
> > > > yet, but the implementation we have at least attempts to make *some=
*
> > > > kind of resolution to those ABI questions. For one, it rejects affi=
nity
> > > > changes that are incompatible (by some definition) with affinities
> > > > requested by other virqs shared on the same parent line. It also up=
dates
> > > > their effective affinities upon changes.
> > > >
> > > > Those replies seem to over-focus on dynamic, user-space initiated
> > > > changes too. But how about for "managed-affinity" interrupts? Those=
 are
> > > > requested by drivers internally to the kernel (a la
> > > > pci_alloc_irq_vectors_affinity()), and can't be changed by user spa=
ce
> > > > afterward. It seems like there'd be room for supporting that, provi=
ded
> > > > we don't allow conflicting/non-overlapping configurations.
> > > >
> > > > I do see that Marc sketched out a complex sysfs/hierarchy API in so=
me of
> > > > his replies. I'm not sure that would provide too much value to the
> > > > managed-affinity cases we're interested in, but I get the appeal fo=
r
> > > > user-managed affinity.
> > > >
> > >
> > > Whatever your proposal is, please get it reviewed by Marc.
> >
> > Please see b673fe1a6229a and avoid dragging me into discussion I have
> > purposely removed myself from. I'd also appreciate if you didn't
> > volunteer me for review tasks I have no intention to perform (this is
> > the second time you are doing it, and that's not on).
> >
>
> Apologies for not catching up with the MAINTAINERS update. Since you were=
 pretty
> much involved in the affinity discussion, I thought about asking your hel=
p.
>
> Regarding looping you in, I thought you only wanted to avoid reviewing th=
e new
> driver changes that were deviating from the spec too much.
>
> But anyway, now it is clear to me that you are not maintaining the irqchi=
p
> drivers, so I will not bother you anymore. Sorry about that.
>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

