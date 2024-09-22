Return-Path: <linux-kernel+bounces-335267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D7F97E345
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 22:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1CA41C20E7F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 20:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9191A59155;
	Sun, 22 Sep 2024 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKGM6gv9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BF82AEFC;
	Sun, 22 Sep 2024 20:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727037631; cv=none; b=ZzDQSzd/LoAwH7QEvHI/kD35QXpfBKofqt3Fwy8j/xXoNmvzsBcO9HyHizYZv92OHAFcs/7gg+IptAgC5vvlMmmTzuwAwQntt4XiBKJ/+7MkOcfT4WE+uK9x1gxcZKCsD08Gplt8iu5YB+CbUNAU3WJou5hvg9M3fqrsSvr6akY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727037631; c=relaxed/simple;
	bh=u0jmX+4P2TILi/C5bbfXVYKw7H7u1hfnwLxWdlhqJoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDBwzMoe/IbCojbkIQzY73nB/6kQ9jLNPqZX3dqGPxe2x8JxJy9SAUEhLB3yX8EnrX4y3HnY4T6noIpOr8WAcCa+4RVsM9XTTCHXw46A5ccRkhGD+bmwOLVT2y5U1Zj7qgnwN+fvZ4GCWIrQX8UEW5SoGNtEGWRr3buaPXTr+FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKGM6gv9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD987C4CEC3;
	Sun, 22 Sep 2024 20:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727037630;
	bh=u0jmX+4P2TILi/C5bbfXVYKw7H7u1hfnwLxWdlhqJoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KKGM6gv9O6G8jgE9+u+lvgLW4qhclGBONgrrz9SSyQHLhhR3n3an2CoUw/itQcVY/
	 7VAMBV4CIu3Drh5bTRP9bTFECJbJ20DNU9AuidonqXo+PHHFN6y6xdUot/q1dRVNw6
	 p8DvGirrorChkaBwIE0xYxDZeImL5Z3/IkQA1qnvrzb/q6O9Iy8DTl3ookfnLMXNxU
	 PEZNdIs4MEirQkY+a3q22B1VhEdUqXp9PoP/HESsWpBT0ijj43uSl6QqK8zPwJH//I
	 7y9YYH9NWzLSQmdoB3a3KAhCI7TDKDIfQZ6U2g1UPlsUQuFYapxEbRXBxAP1QjY7K8
	 /atRYQSkqrShw==
Date: Sun, 22 Sep 2024 22:40:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Erez Geva <erezgeva@nwtime.org>
Cc: linux-mtd@lists.infradead.org, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, linux-kernel@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Esben Haabendal <esben@geanix.com>, Erez Geva <ErezGeva2@gmail.com>
Subject: Re: [PATCH v5 3/5] dt-bindings: mtd: spi-nor: add OTP parameters
Message-ID: <2fo7pndjqieq6lfydmq2pnwb374oqoqnrcsezycgougmr7mtl5@2wm6fe3inf5u>
References: <20240920181231.20542-1-erezgeva@nwtime.org>
 <20240920181231.20542-4-erezgeva@nwtime.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240920181231.20542-4-erezgeva@nwtime.org>

On Fri, Sep 20, 2024 at 08:12:29PM +0200, Erez Geva wrote:
> From: Erez Geva <ErezGeva2@gmail.com>
> 
> Some flash devices need OTP parameters in device tree.
> As we can not deduce the parameters based on JEDEC ID or SFDP.
> 
> Signed-off-by: Erez Geva <ErezGeva2@gmail.com>
> ---
>  .../bindings/mtd/jedec,spi-nor.yaml           | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> index 6e3afb42926e..4f7bb3f41cb1 100644
> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> @@ -90,6 +90,43 @@ properties:
>        the SRWD bit while writing the status register. WP# signal hard strapped to GND
>        can be a valid use case.
>  
> +  otp-n-regions:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Some flash devices need OTP parameters in the device tree.
> +      As we can not deduce the parameters based on JEDEC ID or SFDP.
> +      This parameter indicates the number of OTP regions.

OTP regions where? In DTS? On flash itself?

> +      The value must be larger or equal to 1 and mandatory for OTP.

Don't repeat constraints in free form text. Add proper minimum and
default, although it is confusing - property is not required but it is
mandatory for OTP?



> +
> +  otp-len:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Some flash devices need OTP parameters in the device tree.
> +      As we can not deduce the parameters based on JEDEC ID or SFDP.

Don't repeat the same.

> +      This parameter indicates the size (length) in bytes of an OTP region.

What if each region has different length? Is it possible?

> +      Currently the driver supports symmetric OTP,
> +       which means all regions must use the same size.

Drop unneeded space in front.

> +      The value must be positive and mandatory for OTP.

Same comments as before.

> +
> +  otp-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Some flash devices need OTP parameters in the device tree.
> +      As we can not deduce the parameters based on JEDEC ID or SFDP.
> +      This parameter indicates the offset in bytes of
> +       an OTP region relative to its previous.
> +      User can omit it if the offset equals the length.
> +      Or in case we have a single OTP region.
> +
> +  otp-base:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Some flash devices need OTP parameters in the device tree.
> +      As we can not deduce the parameters based on JEDEC ID or SFDP.
> +      This parameter indicates the base in bytes of the first OTP region.
> +      User can omit it if the base is zero.

so default: 0?

I am not sure, but all this looks like duplicated description of nvmem
cells or some sort of partitions.

Considering that this is first time the binding mentions OTP, I really
do not get what you are doing it. If the properties are to stay, please
describe better the problem (and hardware!) in commit msg.

Best regards,
Krzysztof


