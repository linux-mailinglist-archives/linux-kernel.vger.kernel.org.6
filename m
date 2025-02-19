Return-Path: <linux-kernel+bounces-521757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCD3A3C1F3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E72C1897DCE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DEE1EB1B8;
	Wed, 19 Feb 2025 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Na6eQl/u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8D51E5B65;
	Wed, 19 Feb 2025 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739974846; cv=none; b=C5NAXO1gNmX0o+qGtIHIGVhoBaD17p1dgLfyF2jxZmOxZG/EojynKhkKrNFnA07TLhgBGp6pyg+R1Lz3/QQgrIvIZ1sSLauh0ldoQPSBJYhdrXFgpah08rdNo7PXjZdGctr1FuKKpnkAHeZnH1mylB7LmNqkBIZIAEDNamWYhEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739974846; c=relaxed/simple;
	bh=tXlCdH0X+xikR3zseXWRre0Ou4/Yp8Pw7Nsiy7ySbig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Evo8TQ3BBHKyXThsNqGPOKlgRrBRcSJ8qn/6D9lGpmRTQl+QuigEXVNHQBsjOMPRVlIftfCfZLa3fUu5U+Hrk+KuEeCLtGnUDTFS0K/uoIMAwzRKATfguLKNhJj4auY12/wVYYpj5m8LB1s2VRsLJOx/fn9kuGEL8w9vwnhCeH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Na6eQl/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C92C4CED1;
	Wed, 19 Feb 2025 14:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739974844;
	bh=tXlCdH0X+xikR3zseXWRre0Ou4/Yp8Pw7Nsiy7ySbig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Na6eQl/uA9zuc0lfzqHgEBKDBNxXa+POV4YGyC7MYTKQgEeIiqC0LwfmCEMI7xaPl
	 W14jPeyWZh3KH0yFp2GUqn+n/JygquKIcYT2GdLQNHcndZFCcwajW4ccDus/IVmYHA
	 XnaX2P6VoI4YbhQggPkLIiXhfWwoEDOwe8xMIARPegxooK+KEg3vN0GequKbRixfax
	 yd7dURDozQQqAqnbAuAe0ig3ChKUWIoRy+13B5BqnVqfnfryZvXSw2Q6mGE7AWr42P
	 Hnda7rXxX8eTL5mwbb+nII8mRGSs6Oj0j2Pg4DyMqMIEyzaYRf/r7kzy/b0faJS7bF
	 XOVYd78wU1bVA==
Date: Wed, 19 Feb 2025 08:20:42 -0600
From: Rob Herring <robh@kernel.org>
To: Aradhya Bhatia <aradhya.bhatia@linux.dev>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Simona Vetter <simona@ffwll.ch>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Devarsh Thakkar <devarsht@ti.com>,
	Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>,
	Jayesh Choudhary <j-choudhary@ti.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	DRI Development List <dri-devel@lists.freedesktop.org>,
	Devicetree List <devicetree@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>
Subject: Re: [PATCH v5 2/3] dt-bindings: display: ti: Add schema for AM625
 OLDI Transmitter
Message-ID: <20250219142042.GA2436009-robh@kernel.org>
References: <20250209160925.380348-1-aradhya.bhatia@linux.dev>
 <20250209160925.380348-3-aradhya.bhatia@linux.dev>
 <16db8f3d-04a2-408a-964f-4cf9478229b4@ideasonboard.com>
 <8c6e790e-f1b6-46ab-9acf-bdea8076405b@linux.dev>
 <cd62bf21-adad-4422-8fac-ebd20e8b39a5@ideasonboard.com>
 <062b78a3-7e83-4202-a753-4e7bd43e8bc2@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <062b78a3-7e83-4202-a753-4e7bd43e8bc2@linux.dev>

On Fri, Feb 14, 2025 at 06:11:11PM +0530, Aradhya Bhatia wrote:
> Hi Tomi,
> 
> 
> On 13/02/25 18:50, Tomi Valkeinen wrote:
> > Hi,
> > 
> > On 13/02/2025 14:33, Aradhya Bhatia wrote:
> > 
> >>>> +  ti,companion-oldi:
> >>>> +    $ref: /schemas/types.yaml#/definitions/phandle
> >>>> +    description:
> >>>> +      phandle to companion OLDI transmitter. This property is
> >>>> mandatory for the
> >>>> +      primarty OLDI TX if the OLDI TXes are expected to work either
> >>>> in dual-lvds
> >>>> +      mode or in clone mode. This property should point to the
> >>>> secondary OLDI
> >>>> +      TX.
> >>>> +
> >>>> +  ti,secondary-oldi:
> >>>> +    type: boolean
> >>>> +    description:
> >>>> +      Boolean property to mark the OLDI transmitter as the secondary
> >>>> one, when the
> >>>> +      OLDI hardware is expected to run as a companion HW, in cases of
> >>>> dual-lvds
> >>>> +      mode or clone mode. The primary OLDI hardware is responsible
> >>>> for all the
> >>>> +      hardware configuration.
> >>>
> >>> I think these work, but I'm wondering if we would ever need to check
> >>> something from the main oldi from the secondary oldi. In that case
> >>> "crossed phandles" would be better, i.e. something like:
> >>>
> >>> (in the first oldi:)
> >>> ti,slave-oldi = <phandle-to-second-oldi>
> >>>
> >>> (in the second oldi:)
> >>> ti,master-oldi = <phandle-to-first-oldi>
> >>
> >> When I had first designed the code and the devicetree for OLDI, it was
> >> done so with the belief that we wouldn't reqiure a bridge instance for
> >> the secondary OLDI, at all.
> >>
> >> While that idea holds true for dual-lvds configuration, it doesn't so
> >> for the clone mode configuration. For clone mode, as you pointed out, we
> >> will require a 2nd bridge instance to configure any of the bridges and
> >> panels that come after the 2nd OLDI.
> >>
> >>
> >>>
> >>> Then again, if we ever need that, even with these bindings the driver
> >>> could find the first oldi, but needs to go via the dss's node.
> >>
> >> While it is possible to do it this way, it might not be the cleanest
> >> one. And _if_ there is a ever a DSS in future with more than 2 OLDI
> >> TXes, say 4, then the decipher logic may get too complicated.
> >>
> >> While I cannot think of any case where the secondary OLDI bridge DT
> >> might need to access the primary OLDI bridge at the moment, I wonder if
> >> we should play it safer and have this option anyway.
> >>
> >> Maybe something like this?
> >>
> >> (primary OLDI)
> >> ti,primary-oldi;
> >> ti,companion-oldi = <phandle-to-secondary-oldi>;
> >>
> >> (secondary OLDI)
> >> ti,secondary-oldi;
> >> ti,companion-oldi = <phandle-to-primary-oldi>;
> > 
> > How is this different than my proposal, except a bit more verbose?
> 
> That's all the difference there is. Just an alternative to what you
> suggested.
> 
> > 
> > If you're thinking about a 4-OLDI hardware, how would this work there?
> 
> I didn't mean that my alternative would be more helpful. I meant that
> passing phandles would be a simpler way for 4-OLDI hardware in general.
> 
> We'd have to sift through a max of 4 OLDI nodes to find the right
> primary OLDI for a given secondary OLDI - if we try to find it via the
> dss and oldi-transmitter parent DT nodes. Passing phandles directly
> would save on all that logic.

I prefer the data in the DT be the minimum needed. Parsing the DT 
doesn't need to be particularly fast because you should only do it once. 
There's even a function already to find occurrences of a property name 
all over the tree.

Rob

