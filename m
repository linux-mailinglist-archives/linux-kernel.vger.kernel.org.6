Return-Path: <linux-kernel+bounces-439644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC719EB223
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E18C188C250
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AF11AA7A3;
	Tue, 10 Dec 2024 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvBPD1tR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D9A26AF6;
	Tue, 10 Dec 2024 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838375; cv=none; b=F19QeEa/RYFx55FPufyLzrz9nTObd/T5R1WDWoU+QVEKZQDXIFR9KP5t2mDziASTMKCJhTiDuS6gye6f042fkPEA8TFLCfoPi8S1Yx8LYkvH40QOrsP+5Lqy1mcsqvHrDZ/SwHniTSsjURFQHSn3kDHP1VDCj74i60AV6bZ+Sqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838375; c=relaxed/simple;
	bh=x730fyX6dMkFw5tutqwYFzZbDyd2+aZYRXnREzK9WoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCbM6BfHwV7CWiYjOe9HNJLZP3oWSNnuIdvBXFxOXkbMjxTo8xMMUHtrToZkt0qVPYgkqh5Oz/l5YuUeyaJmyl+ixPCnWmcTFV+19sPKYIL5QVjWLZeSfBldFjea7iCTpQ6HfZJTCY9HBr36/GQA8Yj/rWUBWIbl/FpZBZHK3Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvBPD1tR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04344C4AF0B;
	Tue, 10 Dec 2024 13:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733838375;
	bh=x730fyX6dMkFw5tutqwYFzZbDyd2+aZYRXnREzK9WoQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XvBPD1tRBD7OU7iZzwf69SJy3kJ8KrrMxWMwC/bmZjw3iULXdkmxudhpcaTsL8aQa
	 s+u3+1DPUeVBLUIaHQ8qW2LZQDCcsES+AWLks2sLLZ2tNjX7Sj2PpB38U8XzlMsOoc
	 JtYXX3pymBvtNuMt0YNrULJMaxxXY7NKObjRbJD3P85Ojcocr+WCdYsg+3NBTi0yRt
	 EyWImMyp+ie/SMsXZ++kkH3mcrrfCpeyBCS/4x0VLfFqukWC0pjsaCAOg00J/E//iN
	 qExim+WBCNMQBvZX0DtGfDMvzK0kXtJ/HiRKgRlCkjr0QsQNPYkJ//sowYA6xtCEAy
	 HncGDn6HADjvg==
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e3988fdb580so4471679276.2;
        Tue, 10 Dec 2024 05:46:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5veoMHfkjqYxo2okQgrH3dAqGZ8H79rytxb4u4y1UKMUCgaLHtSNQu4NQESUNUFuN5J8zr6yRWk3SwA==@vger.kernel.org, AJvYcCWK/6pUrCZJuCn/1ujrJpORc53bX2AzMVSDgqWoT9Jz8AXZOIt6JcTLTR2FChRGcRsNxaGfBPhfMsJDv8Hc@vger.kernel.org, AJvYcCWk3gQM2yHjIWBpSNsEBDw0JdyDEPEgeuvzjE0Z7SVkmhxZPZZ9wwAytIVW4BRjlWVq4UVLP7lUsN/UzJHOiok79gVZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzYs3o3drmZVuPJjWISMDu8IcMlIkF83021W537glQvwLr5uQNK
	CAlYF31wG6iGT7Bg9sw7ZyLReSoSm7zqRQPOmZSmGul8LaPe9x89iMIYRHMUZHabIr2JE/nZWxQ
	mOVeT0xd1NQCK+bJVJpB2/T/ruw==
X-Google-Smtp-Source: AGHT+IFEJu9NTYWGNNmGhCKFl6IIPQSbjUyN0ns29zQAUyT/ZrhFzuKfUga+5b6UJ+tGB6G+6RDedWNBOIows2KSM80=
X-Received: by 2002:a05:6902:2009:b0:e39:9b9f:7f83 with SMTP id
 3f1490d57ef6-e3a59afd53emr4031159276.12.1733838373977; Tue, 10 Dec 2024
 05:46:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209151830.95723-1-herve.codina@bootlin.com>
 <CAL_JsqLT3prYBcxnsUwAShULCLJScYoU29ta29RJLGyiNkCrTg@mail.gmail.com> <20241210091604.512496d3@bootlin.com>
In-Reply-To: <20241210091604.512496d3@bootlin.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 10 Dec 2024 07:46:02 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJCbmMJWJnmr8FneKrW4pjvTcyEco94Ot32o2YtaVxRQQ@mail.gmail.com>
Message-ID: <CAL_JsqJCbmMJWJnmr8FneKrW4pjvTcyEco94Ot32o2YtaVxRQQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] of: overlay: Add support for export-symbols node feature
To: Herve Codina <herve.codina@bootlin.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Andrew Davis <afd@ti.com>, Ayush Singh <ayush@beagleboard.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana Kannan <saravanak@google.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Devicetree Compiler <devicetree-compiler@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+dtc list and David G.

On Tue, Dec 10, 2024 at 2:16=E2=80=AFAM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> Hi Rob,
>
> On Mon, 9 Dec 2024 14:11:09 -0600
> Rob Herring <robh@kernel.org> wrote:
>
> ...
> > >
> > > Our overlay using the nexus node can contains:
> > >    node {
> > >       foo-gpio =3D <&connector 0 GPIO_ACTIVE_HIGH>;
> > >    };
> >
> > Couldn't we make something like this work:
> >
> > connector: __overlay__ {
> >
> >    node {
> >       foo-gpio =3D <&connector 0 GPIO_ACTIVE_HIGH>;
> >    };
> > };
> >
> > We already have to process all the phandles in the overlay. So this
> > just changes handling of 'connector' from being a local phandle which
> > we just renumber to an unresolved phandle which we have to lookup and
> > replace the phandle uses with.
> >
>
> I have tried what you suggested but I've got some issues with dtc.
>
> If a label is not used as a phandle in a dts, dtc doesn't create the phan=
dle
> property in the pointed node (except if we use '-@' option but I don't wa=
nt
> to add all symbols in my dtb just for one or two connector symbols).

Sorry, but that's the cost of using overlays, and that's pretty
orthogonal to the issue of how the overlay references the connector
node.

However, I agree '-@' is a pretty big switch and an issue that's been
discussed before. I also don't like that all labels become part of the
ABI nor the fact that overlays can make any random modification
anywhere in the DT. I would rather see some sort of explicit opt-in
mechanism of nodes we can apply overlays to. Perhaps we could do
something like this:

/export/ label: node {
};

And then __symbols__ can be only those exported labels (unless -@ is used).

> The way to make sure that the phandle property will be created in the bas=
e
> DT node by dtc is to reference the label as a phandle in the base DT.
> The export-symbols node references this label as a phandle in the base DT
> and so, with that, dtc creates the phandle property.
>
> Also, using 'connector: __overlay__' allows to have only one label from
> the base DT to be referenced by the overlay.
>
> I don't know if use cases exist where more than one label need to be
> referenced but this 'one label' constraint is not present with the
> export-symbols node.
>
> The use case where more than one label would be needed is the need for a
> phandle from the overlay that couldn't be translated by the connector nex=
us
> node. Maybe pinctrl because it uses of_find_node_by_phandle().

Labels are an ABI. I can't see that we need to remap them when we can
just say the name must be X. We can have multiple labels on a node as
well. So I think the problem space is purely mapping 1 name to
multiple possible names.

The connector handling has to be addressed binding by binding at least
for each pattern of binding. Pinctrl binding is pretty unique, so we
should make sure we can handle it in this case.

> Last point, having export-symbols node makes some nodes explicitly
> candidates for an overlay and defines the label to be used on the base DT
> node side. This specific label can be described in the node binding as we=
ll
> as the nexus node properties.

Both David (IIRC) and I feel that putting the overlay info
(__symbols__, __fixups__, etc.) within the DT data rather than in the
DTB format was a mistake. The export-symbols node expands on that, so
I'm not sure that's the right direction.

(We should have rev'ed the DTB format to store type information for
(at a minimum) phandles.)

> With 'connector: __overlay__', the overlay can be applied on any nodes, a=
t
> least from the needed label point of view without any restrictions.

Certainly that is something I'd like to have some control over. An
/export/ tag would accomplish that.

One idea I have there is that the overlay could have the compatible of
the connector and we use that for matching. That would give us a way
to know what base DTs overlays apply to. Then you could load an
overlay and dispatch it to the correct driver to handle. It would have
to be handled as a special case as the compatible may match, but
wouldn't necessarily be equal values.


I'll throw out another idea. What if we make resolving phandle errors
something that can be handled by the connector driver? The driver
knows 'connector' resolves to the connector node it is applying the
overlay to.

Rob

