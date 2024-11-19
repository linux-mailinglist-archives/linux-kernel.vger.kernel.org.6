Return-Path: <linux-kernel+bounces-414760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2089D2CF2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20ECD281314
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749FB1D221C;
	Tue, 19 Nov 2024 17:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJHuJ0az"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF191CC89E;
	Tue, 19 Nov 2024 17:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732038564; cv=none; b=pdlQy0VpOKe9DkTgAMWgp3CI15kiOo+oi57E/9qTXHjUWYVVpfKaz/wY0aQlOYR0iVHTRccavD8fk2RbPmloaDiERvXqEzcg2JrCqel3AYo1aHxoJIp2IvECfaNrtiAHI/xq9vnj3Z3U6gjsBkR4MH+plt7vtEOu7I7MmWHHZG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732038564; c=relaxed/simple;
	bh=FikHNGJ1QtpCtUQBGGfnptDmKYQVJIWUypOil92hb5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HaeJUHSFFkcdQi/aHNjm2iHL52Bxz3lDGnKZExtRNhvPFDCfhJPsi9XzpCnRbtrlFDX2EYdEMjC3qQLj5hvtS1WFJYwqCCoRKQHo6GSsSm3nuYcaL4cSqS33Gol0XhuRBS57t9wOg6YBOpVRWw7cnckHhPmE6sFOiSkJjGhITLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJHuJ0az; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65628C4CED0;
	Tue, 19 Nov 2024 17:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732038564;
	bh=FikHNGJ1QtpCtUQBGGfnptDmKYQVJIWUypOil92hb5k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MJHuJ0azEWjpXrStcQ0J+WZAoyZPGHeN5a+l3hTTfVe+wS3m51R9232FPyhk1yxA1
	 x2EDzKx1PBPTDDQWHaAap6NCnInI8HutXS1RsnRuS8oQjNXsddfhpxBFiAcV59gLZ4
	 bvItcnCywcxxim/MrbrczTJruEjBiOzfwcgWzoh2J6+i9dkpley0eSLt66G1SqgrQK
	 hhUbyg0w8pMDNg9tvdxtSlhMmtkhmiV/1PKQ8MtXk4C9tMTLKIsDM9sJJT6KktO41Z
	 TWv/m89T6xWDS0ckv3b5NyreUXo3cKZghSHot2ZGDY3PZSr3WMrF/FRez72W5hli5P
	 EORtgqKcHgdxg==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ee745e3b2bso333037b3.0;
        Tue, 19 Nov 2024 09:49:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVaODcsrS1FFtzG9t66Nv3E1OHSUqG1S0JCQ3u+dvtvp7EmDVZ9xsNq5hXyDwh8nPS3/N4O3UMyXsWi@vger.kernel.org, AJvYcCWOixR1zlq7XiL5h4VyFwbK2b+RNqnfP8QtMyyhyYQ0QcBU63+Q0bj3K9jK6eAmafmypjSMi8JBTbcswPsI@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7GRWAGYy6/02syxkk0wJEhjQbRTOStAs/13I4cPra1iEml9tD
	ApdN5v2N8VuftQIXr0Ly/0lAxtqLeP79I2WYNCURkj6HvRhklb1bC/0f5G5HnCc5JPpjHsz52ez
	Vd6XhYRKed964tY38gJKyPFwaXA==
X-Google-Smtp-Source: AGHT+IHcxvaZPuyKcnTQ+KCUfqN9GrPk6w9RFIomNZLRe4D2WigFnVWUl/PsIV32XxtrjlnyS5ch4EUpypla3iGIA+A=
X-Received: by 2002:a05:690c:7010:b0:6dd:f81a:80fb with SMTP id
 00721157ae682-6eeaa326b8cmr36600807b3.1.1732038563632; Tue, 19 Nov 2024
 09:49:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114195652.3068725-1-samuel.holland@sifive.com>
 <20241119154117.GA1537069-robh@kernel.org> <1f78898b-f703-4fd9-8f68-c0835a85de9e@sifive.com>
In-Reply-To: <1f78898b-f703-4fd9-8f68-c0835a85de9e@sifive.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 19 Nov 2024 11:49:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ0K5z9rNHKNF1Xq8XnAkrxZaG-Th-e-G-zy5bo9_8=QA@mail.gmail.com>
Message-ID: <CAL_JsqJ0K5z9rNHKNF1Xq8XnAkrxZaG-Th-e-G-zy5bo9_8=QA@mail.gmail.com>
Subject: Re: [PATCH] of: property: fw_devlink: Do not use interrupt-parent directly
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 10:47=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Rob,
>
> On 2024-11-19 9:41 AM, Rob Herring wrote:
> > On Thu, Nov 14, 2024 at 11:56:49AM -0800, Samuel Holland wrote:
> >> commit 7f00be96f125 ("of: property: Add device link support for
> >> interrupt-parent, dmas and -gpio(s)") started adding device links for
> >> the interrupt-parent property. Later, commit f265f06af194 ("of:
> >> property: Fix fw_devlink handling of interrupts/interrupts-extended")
> >> added full support for parsing the interrupts and interrupts-extended
> >> properties, which includes looking up the node of the parent domain.
> >> This made the handler for the interrupt-parent property redundant.
> >>
> >> In fact, creating device links based solely on interrupt-parent is
> >> problematic, because it can create spurious cycles. A node may have
> >> this property without itself being an interrupt controller or consumer=
.
> >> For example, this property is often present in the root node or a /soc
> >> bus node to set the default interrupt parent for child nodes. However,
> >> it is incorrect for the bus to depend on the interrupt controller, as
> >> some of the bus's childre may not be interrupt consumers at all or may
> >
> > typo
> >
> >> have a different interrupt parent.
> >>
> >> Resolving these spurious dependency cycles can cause an incorrect prob=
e
> >> order for interrupt controller drivers. This was observed on a RISC-V
> >> system with both an APLIC and IMSIC under /soc, where interrupt-parent
> >> in /soc points to the APLIC, and the APLIC msi-parent points to the
> >> IMSIC. fw_devlink found three dependency cycles and attempted to probe
> >> the APLIC before the IMSIC. After applying this patch, there were no
> >> dependency cycles and the probe order was correct.
> >>
> >> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> >
> > I assume this should go to stable? It needs Fixes tags.
>
> What commit should I put in the Fixes tag? f265f06af194 ("of: property: F=
ix
> fw_devlink handling of interrupts/interrupts-extended"), because it finis=
hed
> making this code redundant? That commit didn't introduce any new bugs--th=
is code
> was always wrong--but I would be hesitant to backport this change any fur=
ther,
> because it might cause regressions without the "interrupts" property pars=
ing in
> place.

I'd guess that f265f06af194 has been backported to everything with
7f00be96f125. I think we want either all 3 commits or none of them. If
something only works with a subset, then upstream is broken.

Rob

