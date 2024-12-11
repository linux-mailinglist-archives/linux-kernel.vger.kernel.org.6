Return-Path: <linux-kernel+bounces-441492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA279ECF25
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD36283E9C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D00A19F41B;
	Wed, 11 Dec 2024 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peUBRvN0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFEC1494CC;
	Wed, 11 Dec 2024 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928944; cv=none; b=jGLKiCz2r6+f4Ck71fWFpISnKi9+s0LX7odHZT6mseNfOzO6wwgVBYojz3P0Ke5IUbKzDtcq+j1nIf9ntqBxe7JNRPIKIVPDOZEZ1ZkbUDqNIHksaJnpRw70Wm+9YpXnAauPHDTbebDLF8+z1GtOWXZVjbGxbSCMyOaVlgsdL7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928944; c=relaxed/simple;
	bh=xbrvzOnKmd+0otzRNpHPJb3BuEKlAKM+LRet5dI/QFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRE6PMu7YRXmggosVmOYa5wU6xSBHGW7ZZA8dd/smoSV/6fLogNN4pWA85l4TUAP0ALo1KGaaCSnVZ9X+VU0dQ+27rc2cYdpG5ger2TSF2M54Kr3yqC7wWQd0jMf184WGFzTbIbyX6pXMhIRnAjBBRLpy0d/YEFSOK0/M2vTCLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peUBRvN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D48C4CED2;
	Wed, 11 Dec 2024 14:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733928943;
	bh=xbrvzOnKmd+0otzRNpHPJb3BuEKlAKM+LRet5dI/QFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=peUBRvN0IEISX29AB3ZNPIQivo4QMCveLHjUqU1w5qLySytfCtKgrGM87dp28gCp9
	 tJCkZDyJWE4g13yXcR0GATm0SsAqbV4dzTL7k4pOcMitPgoPzdfnRsvHa/CeJ931g+
	 qU5eTJ0wJXWNPZINRFip93r99B1fMjz3iYOf4MNXd9ajRtlzkVOP7n/koJblirgz3V
	 tZkvQl2jkwYAJ1MWUKqafamJSZFc8QecZEFjN2kYVaI5ppQL9S9cpHoAqg6SW2XcnD
	 TOpsszRq3AjAbFmhujMfhqjwGHtuiDIwzdlLxATMWOTsFZ+hBgeYaFmN97HE6INXDF
	 zCBUgK+TCJf/g==
Date: Wed, 11 Dec 2024 08:55:41 -0600
From: Rob Herring <robh@kernel.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	p.zabel@pengutronix.de, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, tglx@linutronix.de, vkoul@kernel.org,
	kishon@kernel.org, aisheng.dong@nxp.com, agx@sigxcpu.org,
	francesco@dolcini.it, frank.li@nxp.com, dmitry.baryshkov@linaro.org,
	u.kleine-koenig@baylibre.com
Subject: Re: [PATCH v6 01/19] dt-bindings: display: imx: Add i.MX8qxp Display
 Controller processing units
Message-ID: <20241211145541.GA2837320-robh@kernel.org>
References: <20241209033923.3009629-1-victor.liu@nxp.com>
 <20241209033923.3009629-2-victor.liu@nxp.com>
 <20241210221508.GA550635-robh@kernel.org>
 <30924a9e-7d01-46f6-9e47-405c08acdde3@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30924a9e-7d01-46f6-9e47-405c08acdde3@nxp.com>

On Wed, Dec 11, 2024 at 11:05:52AM +0800, Liu Ying wrote:
> On 12/11/2024, Rob Herring wrote:
> > On Mon, Dec 09, 2024 at 11:39:05AM +0800, Liu Ying wrote:
> >> Freescale i.MX8qxp Display Controller is implemented as construction set of
> >> building blocks with unified concept and standardized interfaces.  Document
> >> all existing processing units.
> >>
> >> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> >> ---
> >> v6:
> >> * No change.
> >>
> >> v5:
> >> * Document aliases for processing units which have multiple instances in
> >>   the Display Controller.  Drop Rob's previous R-b tag. (Maxime)
> >>
> >> v4:
> >> * Collect Rob's R-b tag.
> >>
> >> v3:
> >> * Combine fsl,imx8qxp-dc-fetchunit-common.yaml,
> >>   fsl,imx8qxp-dc-fetchlayer.yaml and fsl,imx8qxp-dc-fetchwarp.yaml
> >>   into 1 schema doc fsl,imx8qxp-dc-fetchunit.yaml. (Rob)
> >> * Document all processing units. (Rob)
> >>
> >> v2:
> >> * Drop fsl,dc-*-id DT properties. (Krzysztof)
> >> * Add port property to fsl,imx8qxp-dc-tcon.yaml. (Krzysztof)
> >> * Fix register range sizes in examples.
> >>
> >>  .../display/imx/fsl,imx8qxp-dc-blitblend.yaml |  46 ++++++
> >>  .../display/imx/fsl,imx8qxp-dc-clut.yaml      |  49 ++++++
> >>  .../imx/fsl,imx8qxp-dc-constframe.yaml        |  49 ++++++
> >>  .../display/imx/fsl,imx8qxp-dc-dither.yaml    |  49 ++++++
> >>  .../display/imx/fsl,imx8qxp-dc-extdst.yaml    |  77 +++++++++
> >>  .../display/imx/fsl,imx8qxp-dc-fetchunit.yaml | 147 ++++++++++++++++++
> >>  .../display/imx/fsl,imx8qxp-dc-filter.yaml    |  47 ++++++
> >>  .../display/imx/fsl,imx8qxp-dc-framegen.yaml  |  68 ++++++++
> >>  .../display/imx/fsl,imx8qxp-dc-gammacor.yaml  |  38 +++++
> >>  .../imx/fsl,imx8qxp-dc-layerblend.yaml        |  45 ++++++
> >>  .../display/imx/fsl,imx8qxp-dc-matrix.yaml    |  48 ++++++
> >>  .../display/imx/fsl,imx8qxp-dc-rop.yaml       |  48 ++++++
> >>  .../display/imx/fsl,imx8qxp-dc-safety.yaml    |  34 ++++
> >>  .../imx/fsl,imx8qxp-dc-scaling-engine.yaml    |  89 +++++++++++
> >>  .../display/imx/fsl,imx8qxp-dc-signature.yaml |  58 +++++++
> >>  .../display/imx/fsl,imx8qxp-dc-store.yaml     | 100 ++++++++++++
> >>  .../display/imx/fsl,imx8qxp-dc-tcon.yaml      |  50 ++++++
> >>  17 files changed, 1042 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-blitblend.yaml
> >>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-clut.yaml
> >>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-constframe.yaml
> >>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-dither.yaml
> >>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-extdst.yaml
> >>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-fetchunit.yaml
> >>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-filter.yaml
> >>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-framegen.yaml
> >>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-gammacor.yaml
> >>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-layerblend.yaml
> >>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-matrix.yaml
> >>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-rop.yaml
> >>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-safety.yaml
> >>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-scaling-engine.yaml
> >>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-signature.yaml
> >>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-store.yaml
> >>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-tcon.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-blitblend.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-blitblend.yaml
> >> new file mode 100644
> >> index 000000000000..7f800e72c3f3
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-blitblend.yaml
> >> @@ -0,0 +1,46 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/display/imx/fsl,imx8qxp-dc-blitblend.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Freescale i.MX8qxp Display Controller Blit Blend Unit
> >> +
> >> +description: |
> >> +  Combines two input frames to a single output frame, all frames having the
> >> +  same dimension.
> >> +
> >> +  Each Blit Blend Unit device should have an alias in the aliases node, in the
> >> +  form of dc<x>-blitblend<y>, where <x> is an integer specifying the Display
> >> +  Controller instance and <y> is an integer specifying the Blit Blend Unit
> >> +  device instance.
> > 
> > That's really an abuse of aliases. If you need to describe connections 
> > between components, use the graph binding like everyone else does for 
> > display path components.
> 
> I need to describe components' instance numbers which imply the connections
> between components but not vice versa. If I use the graph binding, I cannot
> get the instance numbers(0 or 1) of the two display engines(documented by
> fsl,imx8qxp-dc-display-engine.yaml). If you have no objections, I may add the
> instance numbers to compatible strings, like brcm,bcm2835-pixelvalve0.yaml.
> What do you think?

You could have dc<x> and blitblend<y> aliases and use the graph to 
define the connections. But I'm not really a fan of adding custom 
aliases either. Why are the instance numbers important?

Are the programming models or features of the instances different? If 
so, then a different compatible or property describing the feature may 
be appropriate.

Rob

