Return-Path: <linux-kernel+bounces-232344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5103F91A720
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C42E71F2722A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCE0181337;
	Thu, 27 Jun 2024 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HaT6tEOC"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF24E17BB22;
	Thu, 27 Jun 2024 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493074; cv=none; b=ZUlpZAdm5rq7kDQozBeIMdLV42b0DfBj48/ckBtu+3cQg7EkuGynbkSMAMj56D7YT1lbEiUa3uKk7BEaY5o3qK2s9gF4vzLbwwY9kjXMhFGplKy9a2lqqV/2FmNxcclIb5Lhran3ViFEpSx/+e7+CmaYkeIy2mjsrcA5B9RkZAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493074; c=relaxed/simple;
	bh=xg3lHUwKPp7F8eqeG58G3q7W55s5Bo41hz0h9ZzPxFs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HmXzGFnBtpFwL6Ix2uE9w/LfTyEYARFQ9x9/pa5qsvcHi4gOPu7Ch7o1tZWQWIgoqH1zDD0oLFM1l1WRKIsBHwXEtXfR78+T22jYj7HNi4c1YSXu8jdRzJ53+nI8BkFwbK2Z/+iN3r1bOstUoSkMvgiLIve04TzoaWgvgweSfOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HaT6tEOC; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 59F27C0005;
	Thu, 27 Jun 2024 12:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719493070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MrmQr8hB4InQ3Jl4oyeWJTm4qwkgjrEBNjcKLZTC4CM=;
	b=HaT6tEOCfC7RAgGp2ovA28C9kcTIIeYHWm6KQQKl1kWTujCU5vpXC0I9LUNE21ViZ145hh
	XM7dgmLQouzE/a16pDFK1lUW9PcLDCGgEl7OLyXCFvIrJejVRljjCpubOUblgdUiveazmc
	CsFYQ5n5iboVgsjcImpJ8vRJkUM98UmdtFs6ioelKXqrV48i1l+9i1Sf992TAbJO5FppHn
	9WrZhUgJ3qXBPTkGyLhn2vyM86SsdNskkXTyOumcZL/emU46P+Q8nrY9Fnn4ZoICkszbyP
	5laHqenDYuvqox3xhNuyB8stooTsm/ECzmElOWoISgWdb2Tie68D6dcBT3PH3Q==
Date: Thu, 27 Jun 2024 14:57:47 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Saravana Kannan <saravanak@google.com>,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Herv=C3=A9?= Codina
 <herve.codina@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: Fixing property memory leaks on device tree overlay removal
Message-ID: <20240627145747.7afb5607@booty>
In-Reply-To: <5215b589-d00d-4be4-9213-aaf547228fb7@linaro.org>
References: <20240624232122.3cfe03f8@booty>
	<CAL_Jsq+=mGEJXsjq1UZFMJtHko_z+doiFMXnx9K7exDuznymSA@mail.gmail.com>
	<5215b589-d00d-4be4-9213-aaf547228fb7@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: luca.ceresoli@bootlin.com

On Wed, 26 Jun 2024 09:24:46 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 25/06/2024 19:02, Rob Herring wrote:
> > On Mon, Jun 24, 2024 at 3:21=E2=80=AFPM Luca Ceresoli <luca.ceresoli@bo=
otlin.com> wrote: =20
...
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> Problem description
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> In the kernel every 'struct device_node' is refcounted so the OF core
> >> knows when to free it. There are of course get/put imbalance bugs
> >> around, but these are "just" bugs that need to be fixed as they are
> >> found.
> >>
> >> On the other hand, there is no refcounting for 'struct property'. Yet
> >> some of the internal kernel APIs to access properties, e.g.
> >> of_property_read_string(), return either a 'struct property' pointer or
> >> a copy of the 'char *value' field. This is not a bug, it is an API
> >> design flaw: any user (e.g. any OF driver) can take a pointer to
> >> property data that was allocated and should be deallocated by the OF
> >> core, but the OF core has no idea of when that pointer will stop being
> >> used.
> >>
> >> Now, when loading a DT overlay there are three possible cases:
> >>
> >>  1. both the property and the containing node are in the base tree
> >>  2. both the property and the containing node are in the same overlay
> >>  3. the property is in an overlay and the containing node is either
> >>     in the base tree or in a previously-loaded overlay
> >>
> >> Cases 1 and 2 are not problematic. In case 1 the data allocated for the
> >> properties is never removed. In case 2 the properties are removed when
> >> removing the parent node, which gets removed when removing the overlay
> >> thanks to 'struct device_node' refcounting, based on the assumption
> >> that the property lifetime is a subset of the parent node lifetime. The
> >> problem exists in case 3. Properties in case 3 are usually a small part
> >> of all the properties but there can be some (and there are some in the
> >> product we are working on), and that's what needs to be addressed. =20
> >=20
> > I'd like to better understand what are the cases where you need to
> > change/add properties in a node (other than "status"). I'm not
> > entirely convinced we should even allow that. =20
>=20
> Just to clarify that I understand the problem correctly - we talk only
> about memory leaks, not about accessing released memory (use-after-free)?

Well, the "unsafe" property accessors do return a pointer to struct
property or its values, so they would become use-after-free in case 1)
the struct property is freed (=3Doverlays) and 2) the caller keeps the
pointer until after the property is freed.

To avoid use-after-free, all properties falling in case 3 are put into
a "deadprops" list within the struct device_node and will be released
only when the node is released, which is never for nodes in the base
tree. This trades a use-after-free for a memory leak.

> I think that during EOSS 2024 discussions we reached consensus that in
> general you will not have use-after-free problem with DT properties at
> all. If all devices are unbound, their resources get released (including
> some core structures registered in subsystems) thus nothing will use any
> of properties. With proper kernel code there will be no use of device
> node properties after device is unbound.

I agree this is the normal situation, but I'm not sure there is
consensus about that. My reply to Rob in this thread aims at clarifying
exactly what problem we need to solve. Totally eradicating the "unsafe"
property accessors would eliminate all possible use-after-free or leak
of property data. However I agree it would be a large effort to fix a
small number of issues, which can be avoided by trusting drivers a bit
more.

> >> Preventing new usages of old accessors will be important. Tools to
> >> achieve that:
> >>
> >>  * Extend checkpatch to report an error on their usage
> >>  * Add a 'K:' entry to MAINTAINERS so that patches trying to use them
> >>    will be reported (to me at least) =20
>=20
> Or just use lore/lei with proper keywords. I track few misuses of kernel
> code that way.

Didn't know about lore+lei, interesting. Thanks, it really looks like a
tool option for this task.

Luca

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

