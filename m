Return-Path: <linux-kernel+bounces-439804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2AB9EB41B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C809B1622FE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F521B3940;
	Tue, 10 Dec 2024 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h17Puscb"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304091A01D4;
	Tue, 10 Dec 2024 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842721; cv=none; b=Dmsfjhdvpgr2H6Osg3cSRbmNcEMh37pImLoxC8jBr/Mvg60+sN12qY4mbYX2N75cWh+W3e6iEPCL/rDxSie7kn85SruoFLLrulWGL9yykORVAhKBlpP7CCuv/Rxa2DoE/7pntrr2UlGJzLJCZsAajXygxC1GbU0uC0iKtfXzDRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842721; c=relaxed/simple;
	bh=AFXL2cx7lVDFMtZEhTqRl5L9XALWWLwSh/jaS0CRf0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkJOcrZh6DUggVuFvrrtQy8uAkmO0rN1ysReD1JLGgNrdXc1DGLpwPVVR4xc0Wil4Wzq8oJRJybU5rKmg4ISvc3evH9agM6uXzkfepGrKYsrRq5PGCSyOmE+Gt7GX/+toZoZwpTKMMPrVgEfQ3t9h+NtlesPWprhEcojgZMPvGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h17Puscb; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DB0E240004;
	Tue, 10 Dec 2024 14:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733842716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wnRE7cR/cIXyL2IFtw6/8xgjxOhuuf+yLB9jfbOtyvk=;
	b=h17PuscbBXcTBoUzfumiPfUxHfm9BKb1RIB3Rmt1WYFakf3U273nLgvp8bRql8R3LeJp95
	NyFoBznTIkAYCpmd2xR/gFrkBAUi+qJrc4YOfHJ6lmJriOytgkT4PxNyFaJU+tuyzMbyk4
	KdM+QawN2fNgJTvkBEC280FibMuy28AXWwxasGfPWrn+WYu01JkIJhx6SqC0XU5qx9SP/S
	Ve6tdxmMl4mbPLvxEqwU0A5gH2ROzmkxRHsA77sOUGWOMuuNvqbeXIx/j2O6i7AePijyjd
	5J/LM0bwTH49BLawXuu3jbjz3fkDQoDV3vVQP8CgALk2BuTMCBHpUYz0XISyhw==
Date: Tue, 10 Dec 2024 15:58:33 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Andrew Davis <afd@ti.com>,
 Ayush Singh <ayush@beagleboard.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana Kannan
 <saravanak@google.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Devicetree Compiler
 <devicetree-compiler@vger.kernel.org>
Subject: Re: [PATCH 0/7] of: overlay: Add support for export-symbols node
 feature
Message-ID: <20241210155833.76357d50@bootlin.com>
In-Reply-To: <CAL_JsqJCbmMJWJnmr8FneKrW4pjvTcyEco94Ot32o2YtaVxRQQ@mail.gmail.com>
References: <20241209151830.95723-1-herve.codina@bootlin.com>
	<CAL_JsqLT3prYBcxnsUwAShULCLJScYoU29ta29RJLGyiNkCrTg@mail.gmail.com>
	<20241210091604.512496d3@bootlin.com>
	<CAL_JsqJCbmMJWJnmr8FneKrW4pjvTcyEco94Ot32o2YtaVxRQQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Rob,

On Tue, 10 Dec 2024 07:46:02 -0600
Rob Herring <robh@kernel.org> wrote:

> +dtc list and David G.
> 
> On Tue, Dec 10, 2024 at 2:16 AM Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > Hi Rob,
> >
> > On Mon, 9 Dec 2024 14:11:09 -0600
> > Rob Herring <robh@kernel.org> wrote:
> >
> > ...  
> > > >
> > > > Our overlay using the nexus node can contains:
> > > >    node {
> > > >       foo-gpio = <&connector 0 GPIO_ACTIVE_HIGH>;
> > > >    };  
> > >
> > > Couldn't we make something like this work:
> > >
> > > connector: __overlay__ {
> > >
> > >    node {
> > >       foo-gpio = <&connector 0 GPIO_ACTIVE_HIGH>;
> > >    };
> > > };
> > >
> > > We already have to process all the phandles in the overlay. So this
> > > just changes handling of 'connector' from being a local phandle which
> > > we just renumber to an unresolved phandle which we have to lookup and
> > > replace the phandle uses with.
> > >  
> >
> > I have tried what you suggested but I've got some issues with dtc.
> >
> > If a label is not used as a phandle in a dts, dtc doesn't create the phandle
> > property in the pointed node (except if we use '-@' option but I don't want
> > to add all symbols in my dtb just for one or two connector symbols).  
> 
> Sorry, but that's the cost of using overlays, and that's pretty
> orthogonal to the issue of how the overlay references the connector
> node.
> 
> However, I agree '-@' is a pretty big switch and an issue that's been
> discussed before. I also don't like that all labels become part of the
> ABI nor the fact that overlays can make any random modification
> anywhere in the DT. I would rather see some sort of explicit opt-in
> mechanism of nodes we can apply overlays to. Perhaps we could do
> something like this:
> 
> /export/ label: node {
> };
> 
> And then __symbols__ can be only those exported labels (unless -@ is used).
> 
> > The way to make sure that the phandle property will be created in the base
> > DT node by dtc is to reference the label as a phandle in the base DT.
> > The export-symbols node references this label as a phandle in the base DT
> > and so, with that, dtc creates the phandle property.
> >
> > Also, using 'connector: __overlay__' allows to have only one label from
> > the base DT to be referenced by the overlay.
> >
> > I don't know if use cases exist where more than one label need to be
> > referenced but this 'one label' constraint is not present with the
> > export-symbols node.
> >
> > The use case where more than one label would be needed is the need for a
> > phandle from the overlay that couldn't be translated by the connector nexus
> > node. Maybe pinctrl because it uses of_find_node_by_phandle().  
> 
> Labels are an ABI. I can't see that we need to remap them when we can
> just say the name must be X. We can have multiple labels on a node as
> well. So I think the problem space is purely mapping 1 name to
> multiple possible names.

So, with a base DT having:
  /export/ label0: node@0 {
  }

  /export/ label1: node@1 {
  }

the __symbols__ node will contains:
  __symbols__ {
	label0 = ...;
	label1 = ...;
  }

without export-symbols, the overlay will look like this:
  connector: __overlay__ {
	...
	ref = <&connector>;
  }

The "connector" label is the only one we can use from the overlay to
reference the base DT (special label defined on the __overlay__ node).
As it is defined to point to __overlay__, it has to be resolved to the
exported symbol that point to the node where the overlay is applied.

If the overlay is applied on node@0, 'connector' is resolved to node@0.

This case cannot be handled:
   connector: __overlay__ {
	...
	ref1 = <&connector>;
        ref2 = <&other-label-from-base-dt>;
   }

Indeed, only one 'connector' label can be resolved to node@0 or node@1.
other-label-from-base-dt cannot be resolved based on the node the overlay
is applied to.

Again, I am not sure on my side that we have to handle this case of multiple
labels in the overlay that point to the base DT dependent on node@0 or node@1.

On my use case, I considered the node@0 or node@1 as nexus nodes and so, all
GPIOs (soon PWM, I hope, and probably other ressources in the future) can be
referenced using nexus nodes.

> 
> The connector handling has to be addressed binding by binding at least
> for each pattern of binding. Pinctrl binding is pretty unique, so we
> should make sure we can handle it in this case.

If pinctrl can be handled using nexus node, it should be ok. Otherwise
things are going to be complicated. Again, with your proposal, we can
reference only one label from the overlay, the node where the overlay
is applied to.

> 
> > Last point, having export-symbols node makes some nodes explicitly
> > candidates for an overlay and defines the label to be used on the base DT
> > node side. This specific label can be described in the node binding as well
> > as the nexus node properties.  
> 
> Both David (IIRC) and I feel that putting the overlay info
> (__symbols__, __fixups__, etc.) within the DT data rather than in the
> DTB format was a mistake. The export-symbols node expands on that, so
> I'm not sure that's the right direction.
> 
> (We should have rev'ed the DTB format to store type information for
> (at a minimum) phandles.)
> 
> > With 'connector: __overlay__', the overlay can be applied on any nodes, at
> > least from the needed label point of view without any restrictions.  
> 
> Certainly that is something I'd like to have some control over. An
> /export/ tag would accomplish that.
> 
> One idea I have there is that the overlay could have the compatible of
> the connector and we use that for matching. That would give us a way
> to know what base DTs overlays apply to. Then you could load an
> overlay and dispatch it to the correct driver to handle. It would have
> to be handled as a special case as the compatible may match, but
> wouldn't necessarily be equal values.

compatible property will not be enough. We can have two exact same
connectors on the same base board:
  /export/ label0: node@0 {
     compatible = 'foo,addon-connector';
  }

  /export/ label1: node@1 {
     compatible = 'foo,addon-connector';
  }

To load the overlay, we can match compatible for sure but we need to node
the overlay is supposed to be applied to.

Also, it you want to check bindings for node@0 available in the base DT
and bindings in the overlay, having one compatible string with different
meaning will introduce some complexity.
A compatible string can now define the "provider" part (the base DT) and
the "consumer" part (the overlay).

> 
> 
> I'll throw out another idea. What if we make resolving phandle errors
> something that can be handled by the connector driver? The driver
> knows 'connector' resolves to the connector node it is applying the
> overlay to.

Well, my proposal was to give enough information to the resolver instead of
handling errors.

I probably miss something but I don't see what could be the benefit to do
that in the other way. Can you give me more details about your idea?

Best regards,
Hervé

