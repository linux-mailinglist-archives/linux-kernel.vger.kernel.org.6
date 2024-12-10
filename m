Return-Path: <linux-kernel+bounces-440417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD7E9EBDB6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E433C188CD81
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2131940B2;
	Tue, 10 Dec 2024 22:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHc4Fdum"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0BF2451F6;
	Tue, 10 Dec 2024 22:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733868910; cv=none; b=L5IjRvHiV7G7gIuLtP2wy2bQ6cDY0hg21xnwjlWQLGJJp88OixHVLTQfRDYY4lIq/fUYngOcvDkOK942vFBvb7ysamiArPjAR7vQnwRTR4yTAO9DSNP+vLdeuU8VLGXMs4pkA43ppm6/2r6LJr+JfS+WDgG6s3jfqtBg5jotvh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733868910; c=relaxed/simple;
	bh=3x4SgvgxpD/lcEUf3nJ+mjH3qTFRRg7PIFRh0uDdLlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i09k07kaYSCU7/rn5FpMI8PBJTru+MGATHaZvJQKUlrKo1eiHfMdZ5SQv7qxzcCc3+VCZtPmGXAw1taf1TRoaEXu6oUd+Rles1mp9DRl/nz327tR00BE0k4bvbHHh1gy3ZxFTbIxijDbYwUFYrJjEdOYdS1IXH9FER2jtAs57Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHc4Fdum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351F7C4CED6;
	Tue, 10 Dec 2024 22:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733868910;
	bh=3x4SgvgxpD/lcEUf3nJ+mjH3qTFRRg7PIFRh0uDdLlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rHc4FdumgPQ+I6A2FJ6RnWwGc0HaSnQsLrVKxDly7JbPsBhnwWvn72/Nn689Wuqkm
	 obCpEtWZitbcfbR65XcrDV/ZhF9KBPAoEvHEQ0gvmNkSJCwGbxyACOTAAc/sCcWNlD
	 nFZSD0zH2HLB+8Yv6/0Yh4Ie4n/whG3Nb3x/j2pxJdYenYJHFhg5TO2ufhJQRvGA4Q
	 +UFz8q5+HJMcMI66JctRNjv809VrNHAfyNTEDNrP3aUSdghd/CE2os5bhRmPMO/E15
	 6cTTsq0ykol5TEDftvEIQmGtULteXOkL2wj2Y4Eq1SfoRbPQ5x0XXoSTYOuunzSJwo
	 0B2TTlBlYVglA==
Date: Tue, 10 Dec 2024 16:15:08 -0600
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
Message-ID: <20241210221508.GA550635-robh@kernel.org>
References: <20241209033923.3009629-1-victor.liu@nxp.com>
 <20241209033923.3009629-2-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209033923.3009629-2-victor.liu@nxp.com>

On Mon, Dec 09, 2024 at 11:39:05AM +0800, Liu Ying wrote:
> Freescale i.MX8qxp Display Controller is implemented as construction set of
> building blocks with unified concept and standardized interfaces.  Document
> all existing processing units.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v6:
> * No change.
> 
> v5:
> * Document aliases for processing units which have multiple instances in
>   the Display Controller.  Drop Rob's previous R-b tag. (Maxime)
> 
> v4:
> * Collect Rob's R-b tag.
> 
> v3:
> * Combine fsl,imx8qxp-dc-fetchunit-common.yaml,
>   fsl,imx8qxp-dc-fetchlayer.yaml and fsl,imx8qxp-dc-fetchwarp.yaml
>   into 1 schema doc fsl,imx8qxp-dc-fetchunit.yaml. (Rob)
> * Document all processing units. (Rob)
> 
> v2:
> * Drop fsl,dc-*-id DT properties. (Krzysztof)
> * Add port property to fsl,imx8qxp-dc-tcon.yaml. (Krzysztof)
> * Fix register range sizes in examples.
> 
>  .../display/imx/fsl,imx8qxp-dc-blitblend.yaml |  46 ++++++
>  .../display/imx/fsl,imx8qxp-dc-clut.yaml      |  49 ++++++
>  .../imx/fsl,imx8qxp-dc-constframe.yaml        |  49 ++++++
>  .../display/imx/fsl,imx8qxp-dc-dither.yaml    |  49 ++++++
>  .../display/imx/fsl,imx8qxp-dc-extdst.yaml    |  77 +++++++++
>  .../display/imx/fsl,imx8qxp-dc-fetchunit.yaml | 147 ++++++++++++++++++
>  .../display/imx/fsl,imx8qxp-dc-filter.yaml    |  47 ++++++
>  .../display/imx/fsl,imx8qxp-dc-framegen.yaml  |  68 ++++++++
>  .../display/imx/fsl,imx8qxp-dc-gammacor.yaml  |  38 +++++
>  .../imx/fsl,imx8qxp-dc-layerblend.yaml        |  45 ++++++
>  .../display/imx/fsl,imx8qxp-dc-matrix.yaml    |  48 ++++++
>  .../display/imx/fsl,imx8qxp-dc-rop.yaml       |  48 ++++++
>  .../display/imx/fsl,imx8qxp-dc-safety.yaml    |  34 ++++
>  .../imx/fsl,imx8qxp-dc-scaling-engine.yaml    |  89 +++++++++++
>  .../display/imx/fsl,imx8qxp-dc-signature.yaml |  58 +++++++
>  .../display/imx/fsl,imx8qxp-dc-store.yaml     | 100 ++++++++++++
>  .../display/imx/fsl,imx8qxp-dc-tcon.yaml      |  50 ++++++
>  17 files changed, 1042 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-blitblend.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-clut.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-constframe.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-dither.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-extdst.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-fetchunit.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-filter.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-framegen.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-gammacor.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-layerblend.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-matrix.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-rop.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-safety.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-scaling-engine.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-signature.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-store.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-tcon.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-blitblend.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-blitblend.yaml
> new file mode 100644
> index 000000000000..7f800e72c3f3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-blitblend.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/imx/fsl,imx8qxp-dc-blitblend.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX8qxp Display Controller Blit Blend Unit
> +
> +description: |
> +  Combines two input frames to a single output frame, all frames having the
> +  same dimension.
> +
> +  Each Blit Blend Unit device should have an alias in the aliases node, in the
> +  form of dc<x>-blitblend<y>, where <x> is an integer specifying the Display
> +  Controller instance and <y> is an integer specifying the Blit Blend Unit
> +  device instance.

That's really an abuse of aliases. If you need to describe connections 
between components, use the graph binding like everyone else does for 
display path components.

Rob

