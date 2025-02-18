Return-Path: <linux-kernel+bounces-518725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 875E8A393CA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3E3188B8B5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF9C1B87E2;
	Tue, 18 Feb 2025 07:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSCXzaNV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7E77482;
	Tue, 18 Feb 2025 07:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739863965; cv=none; b=sVwV2GxgF3SI3eOg8UUw7Ao/W9naRfALpUmsg2MeI8VpZNErLwuG5zyfCEHNzkWCN6r5jlS5e3GdlXGHXN5AoIFykfYqwO6u4MdI4qHipY0VOqOsRgvu5on9iDtRcy9OwBkUyxvg3VEcL2anGQSJsOCQkCZHxVUiLybQ7DBjDr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739863965; c=relaxed/simple;
	bh=ELjkZOQawhuwmeauN28utiadevXnlUbcLvOdJvMmgJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXzrL57lsEnbb3/aBTeU7eS/ps5+n7A2piCwwj39q7yZBgW2DcH9EIsSVHHv0+3K3wre2bG8fAD43E5V/RJuNw7mB4DldygpANX+nbGSYcOMHLEj/wAr+dlFq8+UalvT+md2uivg83uIzhBOyzf2EpZ/0Tv51x/193LLPMwnUSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSCXzaNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15F3C4CEE2;
	Tue, 18 Feb 2025 07:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739863964;
	bh=ELjkZOQawhuwmeauN28utiadevXnlUbcLvOdJvMmgJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sSCXzaNVHev7vwOOh6h5k7NBDXxAG35+HA/yRYdbd5rIxPfNBdoNyUXUj0zmnoCa4
	 +kwwZ2D8Duq55Eas4zqJ/sii6d1k+SK0CERAqksEhlu7Chhy4qyz2fyD5RY4EFQn8T
	 4l8AcudUc67A8SRyzg4UhK7zZR7vhHTI4kXC2LyVV6/SRVGfNrUznwVvWtbmq1Ih/z
	 wRrqMPy3OClmLK7ggZ2AA/f5ntarekNU3KregSjjsNuYbWGT4W7z+LnyXYdpA7K5vI
	 72nnAfX8Gvpk5YpkbhXTvocMzjtQDjl0cKkkEg2jWRyuclFfFRgbSv0OitlCpBbnXb
	 7YA+wUsxNcpeg==
Date: Tue, 18 Feb 2025 08:32:41 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kyle Hendry <kylehendrydev@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, =?utf-8?Q?Fern=C3=A1ndez?= Rojas <noltari@gmail.com>, 
	Jonas Gorski <jonas.gorski@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 3/5] dt-bindings: net: bcm6368-mdio-mux: add gphy-ctrl
 property
Message-ID: <20250218-glaring-maroon-impala-1eb78a@krzk-bin>
References: <20250218013653.229234-1-kylehendrydev@gmail.com>
 <20250218013653.229234-4-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250218013653.229234-4-kylehendrydev@gmail.com>

On Mon, Feb 17, 2025 at 05:36:42PM -0800, Kyle Hendry wrote:
> Add documentation for the brcm,gphy-ctrl phandle to the
> register for controlling ghpy modes.
> 
> Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
> ---
>  .../devicetree/bindings/net/brcm,bcm6368-mdio-mux.yaml     | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/brcm,bcm6368-mdio-mux.yaml b/Documentation/devicetree/bindings/net/brcm,bcm6368-mdio-mux.yaml
> index 9ef28c2a0afc..9630b87b0473 100644
> --- a/Documentation/devicetree/bindings/net/brcm,bcm6368-mdio-mux.yaml
> +++ b/Documentation/devicetree/bindings/net/brcm,bcm6368-mdio-mux.yaml
> @@ -24,6 +24,11 @@ properties:
>    reg:
>      maxItems: 1
>  

Looks like whitespace error

> +properties:
> +  brcm,gphy-ctrl:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: A phandle to the gphy control register

Missing items. Why is this array?

Anyway, explain the purpose of this phandle - how it is used by the
*device*.

Best regards,
Krzysztof


