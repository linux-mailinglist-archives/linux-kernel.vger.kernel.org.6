Return-Path: <linux-kernel+bounces-415383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6DA9D354B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D6A286B0B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E09C16DC36;
	Wed, 20 Nov 2024 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bF9Zttze"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D5A1B7F4;
	Wed, 20 Nov 2024 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732090949; cv=none; b=ENRYwYxJNaNMi5CeJQzxIIO9gfPsEbMlz3/71+mAb3s1w9KguqgXawtFWVH2e2tqlB3bRhtuaXg1UzOUXqjQunF/xQME+fRc/UB2aq5rPpZREUn6Mxeh3jBhp8BO4Lt4ypI3FZJa+SLVm7OE1+MkEWCCmeD8i94+nJ5lDuChuJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732090949; c=relaxed/simple;
	bh=76zuNGW4eisgA6+rUAF0FiulsIP5rdtlV6s0x8DYYBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXbKpVeLuvExVjTDOpkBFyXi4Yn0WWbGlmyCR9SCtCQxwJogO7FPlr6VOhrljHiRKvHBVf74lBe6ztYNuhkpH8Bwj47rwZaUkQuyW5azcYcBKLTQCFq4RODb5r8X1Uu4fxRjDPi7b6ZxbQVVOOXbgiC2nbYVDADdd4TeG8nRd1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bF9Zttze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26FEC4CECD;
	Wed, 20 Nov 2024 08:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732090948;
	bh=76zuNGW4eisgA6+rUAF0FiulsIP5rdtlV6s0x8DYYBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bF9Zttzesv7JIRF5B7lKUfzK3zcIwLwysn2ymuQcrxecpgPxrl+ohzHEhPfO57QE8
	 7HaMyMC6/yPsRURu53Qo4PBnMVnduHf9IdWpWVSFpsUDIKELiNe3S2umd/FELw/A6S
	 C4/0fvRigCUfJsr/4kPLvCT6xL+7p001tQ3uShpokS5oITAyngcZnQttPwWwppZeg9
	 ICvjul2C1NKhCSFiyZk/UqAXH7qxz9c9LJM4PRyOpKmzsaiT7VirqElCYXRY0WB7on
	 14pgurY9r+wzs2mYZxZ+PGTyP0RSJasfs78B+I5vixiLU0iPBCikoPAkBJdrHq226a
	 GDWaWeJaY+9ng==
Date: Wed, 20 Nov 2024 09:22:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Matt Coster <matt.coster@imgtec.com>
Cc: Frank Binns <frank.binns@imgtec.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Randolph Sapp <rs@ti.com>, Darren Etheridge <detheridge@ti.com>
Subject: Re: [PATCH v2 01/21] dt-bindings: gpu: img: More explicit compatible
 strings
Message-ID: <2pfix2ozehlfb6pwrrhxhqh7gho56dh33usrnaqxq7anstytsp@ij5y7zm5cqlu>
References: <20241118-sets-bxs-4-64-patch-v1-v2-0-3fd45d9fb0cf@imgtec.com>
 <20241118-sets-bxs-4-64-patch-v1-v2-1-3fd45d9fb0cf@imgtec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118-sets-bxs-4-64-patch-v1-v2-1-3fd45d9fb0cf@imgtec.com>

On Mon, Nov 18, 2024 at 01:01:53PM +0000, Matt Coster wrote:
> The current compatible strings are not specific enough to constrain the

No, they are specific enough.

> hardware in devicetree. For example, the current "img,img-axe" string
> refers to the entire family of Series AXE GPUs. The more specific
> "img,img-axe-1-16m" string refers to the AXE-1-16M GPU which, unlike the
> rest of its family, only uses a single power domain.
> 
> While in this instance there is already "ti,am62-gpu" for the more

That's the specific compatible.

> specific case, the intent here is to draw a line between properties
> inherent to the IP core and choices made by the silicon vendor at
> integration time. For example, the number of power domains is a property
> of the IP core, whereas the decision to use one or three clocks (see
> next patch) is a vendor one.
> 
> Work is currently underway to add support for volcanic-based Imagination
> GPUs, for which bindings will be added in "img,powervr-volcanic.yaml".
> The split between rogue and volcanic cores is non-obvious at times, so
> add a generic top-level "img,img-rogue" compatible string here to allow
> for simpler differentiation in devicetrees without referring back to the
> bindings.
> 
> Make these changes now before introducing more compatible strings to keep
> the legacy versions to a minimum.
> 
> Signed-off-by: Matt Coster <matt.coster@imgtec.com>
> ---
> Changes in v2:
> - Clarified justification for compatible strings
> - Link to v1: https://lore.kernel.org/r/20241105-sets-bxs-4-64-patch-v1-v1-1-4ed30e865892@imgtec.com
> ---
>  .../devicetree/bindings/gpu/img,powervr-rogue.yaml    | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> index 256e252f8087fa0d6081f771a01601d34b66fe19..ef7070daf213277d0190fe319e202fdc597337d4 100644
> --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> @@ -12,10 +12,19 @@ maintainers:
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

NAK, that's ABI break. You are stuck with whatever you sent earlier.


> +
> +      # This legacy combination of compatible strings was introduced early on before the more
> +      # specific GPU identifiers were used. Keep it around here for compatibility, but never use
> +      # "img,img-axe" in new devicetrees.

Wrap according to Linux coding style. But anyway this is not needed,
just deprecate things.

> +      - items:
> +          - const: ti,am62-gpu
> +          - const: img,img-axe

So you want to use deprecated here?

Anyway, entire change is not needed and without proper justification.
Your marketing terms are not proper justification.

Best regards,
Krzysztof


