Return-Path: <linux-kernel+bounces-302698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC91D96020A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB6E1C2232E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09B5156887;
	Tue, 27 Aug 2024 06:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWCQLoDC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D6215359A;
	Tue, 27 Aug 2024 06:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724740681; cv=none; b=r/QuGQPVS0ws7+kkw+FeSMD3FF0NBpaF3C+xeyaP/Z8PUUyL6iclif4pxnWO+EJpW/IXrGjseszBvJY2NCpESLAJCqU5R5TKRxaWjpzySlD/mTJiozaZiZnCA5Mpi3vC58IR5/RU+65mcsBYBnA57N54bw/nrqYo4GI4r+3sCR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724740681; c=relaxed/simple;
	bh=2mx9WDRudhyYuN8MI4kGv4eicHoi16dNhN/i44tfG3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWzdOmr1wLYkSxc4nDjsXecUwWsc7sJP+vwdL8cDAdfBKzR9hERBYwBp7mbGiIyZgmpSCQ8+LTYWcmSbAh4CKZX76fb9iLJAYQJU3VdG/esLJwkC0ONlrO/pplzVPn/oVEXoC6nEOmtaOTDnpjDS8s59SD4INwu7MaC5LxdhZwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWCQLoDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3F0C8B7A9;
	Tue, 27 Aug 2024 06:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724740680;
	bh=2mx9WDRudhyYuN8MI4kGv4eicHoi16dNhN/i44tfG3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QWCQLoDCkziIESzz3hPPQu7/M5a91gVILBCfojQL0ud94BoPqE4FRhq9rnptQYiUx
	 SbBtpLxnZBu9pbTxIRWzmYFdA2QW8gxWgwVHgbkapqEsHJb0GT7Aew45Xa9bvxO/JA
	 ScXuqmy/SLo3Jz+2JKvo2OIrZHzKhPRQzevHy9Cbtke9JWmCC5m9RUpYNz+VCzml8V
	 cnspt3kt5IDO4YfQtmGXsoHrq+qnDK8O1qiwHnbgFdpMTEAFAZDU4/rMn/JnUVdCVR
	 7bmTzw3N8w3WEua6kSjL/ZbT3edsTl5RCzjrQJPJnsWCy8oVg9a5NykKDxW+Uf+Nyv
	 LH35iJluHS0aw==
Date: Tue, 27 Aug 2024 08:37:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Bao Cheng Su <baocheng.su@siemens.com>, 
	Hua Qian Li <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>
Subject: Re: [PATCH v2 3/6] dt-bindings: PCI: ti,am65: Extend for use with PVU
Message-ID: <afyz3i4xihir4fnt4djo45saytz5ubu3wel6munq7cinwcb55m@ohdelne4xf34>
References: <cover.1724709007.git.jan.kiszka@siemens.com>
 <82ac9e266f6aca42699ec4a3c8f10887789ee6bf.1724709007.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <82ac9e266f6aca42699ec4a3c8f10887789ee6bf.1724709007.git.jan.kiszka@siemens.com>

On Mon, Aug 26, 2024 at 11:50:04PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Describe also the VMAP registers which are needed in order to make use
> of the PVU with this PCI host. Furthermore, permit to specify a
> restricted DMA pool by phandle.

That's an ABI break without explanation why it is necessary.

> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  .../devicetree/bindings/pci/ti,am65-pci-host.yaml   | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
> index 0a9d10532cc8..72f78f21e1e8 100644
> --- a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
> @@ -20,7 +20,7 @@ properties:
>        - ti,keystone-pcie
>  
>    reg:
> -    maxItems: 4
> +    maxItems: 6
>  
>    reg-names:
>      items:
> @@ -28,6 +28,8 @@ properties:
>        - const: dbics
>        - const: config
>        - const: atu
> +      - const: vmap_lp
> +      - const: vmap_hp
>  
>    interrupts:
>      maxItems: 1
> @@ -69,6 +71,9 @@ properties:
>      items:
>        pattern: '^pcie-phy[0-1]$'
>  
> +  memory-region:
> +    description: phandle to restricted DMA pool to be used for all devices behind this controller

missing constraints, maxItems

Best regards,
Krzysztof


