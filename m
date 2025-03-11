Return-Path: <linux-kernel+bounces-555605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7444A5BA2A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02A61714D5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B0222258F;
	Tue, 11 Mar 2025 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAs0RnLo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EB9146593;
	Tue, 11 Mar 2025 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741679436; cv=none; b=Ffpxsk/zQaxXY+N47TCBphMyIKFudWfV8Rvs/LPpslasetjraUhdIklS3XQ3DlUFqxSWQBHNmySDFGT/OfNV96OGpNhGcs2s46/V5gKqqJAro2c2XhfZ1Z4zi9KBQcj17K4MS4q4EW+3Tc16jP1uTs2RXLY+oW0yUNFAEmCngBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741679436; c=relaxed/simple;
	bh=PfXD9LAIRac4LpEfNqgo9lEHLBGVzIakFvPgYg4Zlqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fw+JYKTVuaEzxiZQyPUfjtGY7Dg/yecPO0JmnXI0crhgKW35HHo7RmRj4DC3iViTv/3HK0m6EUd1uSxJYJIirIFuPwaQP93gkftptieo4UfNn1KdfQytMnAVQO5m3zL2OZBL8/kJxUNPC4O/M9+5W+WdJVj5Tsn75l8w8zPog6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAs0RnLo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C2CC4CEE9;
	Tue, 11 Mar 2025 07:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741679434;
	bh=PfXD9LAIRac4LpEfNqgo9lEHLBGVzIakFvPgYg4Zlqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tAs0RnLoI8rz3aCg9hWT1uA95q7khX3NJxB0yOf6mE5yOofZUZf3G14AjQ8X2V7rI
	 HJU2efgzLf9yGmc/Cqwxk9JbtAXMtl46w9XumQqPYSF2+ZWGk8fo3e2E/zjVGNvZiO
	 PA7WoNEixNm1Mx10vllM/P+LeLkdxC5+lyg3CsRI2wUmxhV5/h7zX4Tvkzxv9kWSoz
	 LQqPSIpq6fXuyzFPQVXhD7IcL583+quvTWBgEHYsaPxhobp/ginjTDgQtgSCplbEuo
	 ICJv3qLPhD8DuQxzirhAZH8rInv768zAu6/j2d6JgX+y1ACfXvpVPnthX/I8x4UDXk
	 5f6z4/T23+5oA==
Date: Tue, 11 Mar 2025 08:50:31 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Matt Coster <matt.coster@imgtec.com>
Cc: Frank Binns <frank.binns@imgtec.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Randolph Sapp <rs@ti.com>, Darren Etheridge <detheridge@ti.com>, 
	Alessio Belle <alessio.belle@imgtec.com>, Alexandru Dadu <alexandru.dadu@imgtec.com>
Subject: Re: [PATCH v3 01/18] dt-bindings: gpu: img: Future-proofing
 enhancements
Message-ID: <20250311-flashy-rattlesnake-of-rain-dcc4f6@krzk-bin>
References: <20250310-sets-bxs-4-64-patch-v1-v3-0-143b3dbef02f@imgtec.com>
 <20250310-sets-bxs-4-64-patch-v1-v3-1-143b3dbef02f@imgtec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250310-sets-bxs-4-64-patch-v1-v3-1-143b3dbef02f@imgtec.com>

On Mon, Mar 10, 2025 at 01:10:25PM +0000, Matt Coster wrote:
> The first compatible strings added for the AXE-1-16M are not sufficient to
> accurately describe all the IMG Rogue GPUs. The current "img,img-axe"
> string refers to the entire family of Series AXE GPUs, but this is
> primarily a marketing term and does not denote a level of hardware
> similarity any greater than just "Rogue".
> 
> The more specific "img,img-axe-1-16m" string refers to individual AXE-1-16M
> GPU. For example, unlike the rest of the Series AXE GPUs, the AXE-1-16M
> only uses a single power domain.
> 
> The situation is actually slightly worse than described in the first
> paragraph, since many "series" (such as Series BXS found in the TI AM68
> among others and added later in this series) contain cores with both Rogue
> and Volcanic architectures.
> 
> Besides attempting to move away from vague groupings defined only
> by marketing terms, we want to draw a line between properties inherent to
> the IP core and choices made by the silicon vendor at integration time.
> For instance, the number of power domains is a property of the IP core,
> whereas the decision to use one or multiple clocks is a vendor one.
> 
> In the original compatible strings, we must use "ti,am62-gpu" to constrain
> both of these properties since the number of power domains cannot be fixed
> for "img,img-axe".
> 
> Work is currently underway to add support for volcanic-based Imagination
> GPUs, for which bindings will be added in "img,powervr-volcanic.yaml".
> As alluded to previously, the split between rogue and volcanic cores is
> non-obvious at times, so add a generic top-level "img,img-rogue" compatible
> string here to allow for simpler differentiation in devicetrees without
> referring back to the bindings.
> 
> The currently supported GPU (AXE-1-16M) only requires a single power
> domain. Subsequent patches will add support for BXS-4-64 MC1, which has
> two power domains. Add infrastructure now to allow for this.
> 
> Also allow the dma-coherent property to be added to IMG Rogue GPUs, which
> are DMA devices. The decision for coherency is made at integration time and
> this property should be applied wherever it accurately describes the
> vendor integration.
> 
> Note that the new required properties for power domains are conditional on
> the new base compatible string to avoid an ABI break.
> 
> Signed-off-by: Matt Coster <matt.coster@imgtec.com>
> ---
> Changes in v3:
> - Remove unnecessary example
> - Remove second power domain details, add these where they're used instead
> - Avoid ABI breaks by limiting new required properties to new compatible
>   strings and making all binding changes in a single patch.
> - Links to v2:
>   https://lore.kernel.org/r/20241118-sets-bxs-4-64-patch-v1-v2-1-3fd45d9fb0cf@imgtec.com
>   https://lore.kernel.org/r/20241118-sets-bxs-4-64-patch-v1-v2-3-3fd45d9fb0cf@imgtec.com
>   https://lore.kernel.org/r/20241118-sets-bxs-4-64-patch-v1-v2-4-3fd45d9fb0cf@imgtec.com
> ---
>  .../devicetree/bindings/gpu/img,powervr-rogue.yaml | 43 ++++++++++++++++++----
>  1 file changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> index 256e252f8087fa0d6081f771a01601d34b66fe19..5c16b2881447c9cda78e5bb46569e2f675d740c4 100644
> --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> @@ -12,10 +12,20 @@ maintainers:
>  
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - ti,am62-gpu
> -      - const: img,img-axe # IMG AXE GPU model/revision is fully discoverable
> +    oneOf:
> +      - items:
> +          - enum:
> +              - ti,am62-gpu
> +          - const: img,img-axe-1-16m
> +          - const: img,img-rogue

That's still ABI break. You got here NAK. You ust preserve img,img-axe.
Your marketing troubles do not concern Linux.

> +
> +      # This legacy combination of compatible strings was introduced early on
> +      # before the more specific GPU identifiers were used.
> +      - items:
> +          - enum:
> +              - ti,am62-gpu
> +          - const: img,img-axe
> +        deprecated: true
>  
>    reg:
>      maxItems: 1
> @@ -34,8 +44,13 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  power-domains:
> -    maxItems: 1
> +  power-domains: true

No, widest constraints always stay here.

> +
> +  power-domain-names:
> +    items:
> +      - const: a

That's not a useful name. Are you sure that datasheet calls it power
domain A?

> +
> +  dma-coherent: true

Best regards,
Krzysztof


