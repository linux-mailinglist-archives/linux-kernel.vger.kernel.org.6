Return-Path: <linux-kernel+bounces-562276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2313AA6219F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 00:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DEC8420868
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 23:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3478A1F3FCB;
	Fri, 14 Mar 2025 23:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gahfdjbX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C90A17BA1;
	Fri, 14 Mar 2025 23:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741994720; cv=none; b=uZSe1qnw5U2IvO01n/eLcQfhsAy6mc0YqU8ZG+TxN12RLXmsWByLkWjknp8sev5Z3CXKH3fWYOPUcLHQw3iim6s/oVRYp3V40ZY+fNKjqGrynYhsCbjd8oG3tTkzhIOyxBikng4OHPwxGJT7iEfbTqNWi6nxKbOQTmK+/fQijH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741994720; c=relaxed/simple;
	bh=Cty/226PgKZsCVk/Xe3DBWuQQLcVWkAPJTZqcDVhSLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMA3KORw09S1+c5JyrJT7JrHgkTGBn7GSpr6mUiEiir+KF0zCTHqTNyQslZLZF6MEaQFArLHWiu86bvBoZbQw5LcSV1KjE25iU4B1DJy+c2ipveTS9fN5/MVKKI6k/VbOO5hdFhdTKoBWlaEqMJeJSVUv4kZNFKBfG0hfjTycEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gahfdjbX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3607C4CEE3;
	Fri, 14 Mar 2025 23:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741994720;
	bh=Cty/226PgKZsCVk/Xe3DBWuQQLcVWkAPJTZqcDVhSLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gahfdjbXCKI1r8hLV3782odEP7znP+mqjlXUa5nA/SFbfZjNMEFUcBScsZbiX8s1R
	 +X3F0yO7txvA3eogQT0xy9XYClSvqpOsEzMbdUlV9jfl1ICYOPo5ghPBjeHlxljDas
	 BksI6Qkeb+OLzdDz9zWWh7zPd0gNV1dIHR2tCmmjbGOQ0Odyhqw0YSeUJcDstEr42G
	 ul/XDC28VBkdkNFWxIm9F73g3SdtgCxDHEyOxcMZktlGu7uodRngEEGXVMdIG7sDv9
	 GSVf7rhFiHZGTTzeuFM5Jtm5eCf3nZB/ffwGILeOpoXghex5mZxJ6LVTv/Wjij0fj6
	 uY1ZTz/jccGOw==
Date: Fri, 14 Mar 2025 18:25:18 -0500
From: Rob Herring <robh@kernel.org>
To: Nick Hu <nick.hu@sifive.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: timer: Add SiFive CLINT2
Message-ID: <20250314232518.GA2513550-robh@kernel.org>
References: <20250314081255.3718-1-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314081255.3718-1-nick.hu@sifive.com>

On Fri, Mar 14, 2025 at 04:12:54PM +0800, Nick Hu wrote:
> Add compatible string and property for the SiFive CLINT v2.

Conor asked about being backwards compatible with v1. Please say why it 
isn't here.

> 
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> - v2 changes:
>   - Don't allow sifive,clint2 by itself. Add '-{}' to the first entry
>   - Mark the sifive,fine-ctr-bits as the required property when
>     the compatible includes the sifive,clint2
> 
>  .../bindings/timer/sifive,clint.yaml          | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> index 76d83aea4e2b..4b9dad11c1e9 100644
> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> @@ -36,6 +36,10 @@ properties:
>                - starfive,jh7110-clint   # StarFive JH7110
>                - starfive,jh8100-clint   # StarFive JH8100
>            - const: sifive,clint0        # SiFive CLINT v0 IP block
> +      - items:
> +          - {}
> +          - const: sifive,clint2        # SiFive CLINT v2 IP block
> +        description: SiFive CLINT v2 is the HRT that supports the Zicntr
>        - items:
>            - enum:
>                - allwinner,sun20i-d1-clint
> @@ -62,6 +66,22 @@ properties:
>      minItems: 1
>      maxItems: 4095
>  
> +  sifive,fine-ctr-bits:
> +    maximum: 15
> +    description: The width in bits of the fine counter.
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: sifive,clint2
> +then:
> +  required:
> +    - sifive,fine-ctr-bits
> +else:
> +  properties:
> +    sifive,fine-ctr-bits: false
> +
>  additionalProperties: false
>  
>  required:
> -- 
> 2.17.1
> 

