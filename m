Return-Path: <linux-kernel+bounces-286021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 311D7951576
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13141F2AA3A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 07:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E083F13D2B2;
	Wed, 14 Aug 2024 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cHzMLDsm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E33513C9B8;
	Wed, 14 Aug 2024 07:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723619777; cv=none; b=a963fyK32s58w5g+JMTbrnDlT0ubcIC6xObS/2p6ierjhKXV/vhDo3zisROeqfh2Td34GOKfr+OT3e6E3a8/EkCWSGHp46/HeT2FOev5NV4117mVbHfQmgvNAvkocipO+nCGXFaFzkl0wrmJITdiCJKRoxPFFR4b9jaOMK+OHQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723619777; c=relaxed/simple;
	bh=2DFuhkegAKw2VGmG0aMHoO6HwcjsJ3J4ofOBi5GoYu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8tBsjjuvYdbn257zrYI/Z7eEPC7enAXYf0fXQM1FhM8I0hKm69sF+bS8WlahK0IhJ1hPXyuTgPhocpVeB3QrdX6Z7sJ5H3roBhug/2yYLkNSu/Mtgd/toETPR2bajIqjaBQO0MFV03rqM6sD1Za5RolrLyJtYyZs3YqXFFwCWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cHzMLDsm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB108C32786;
	Wed, 14 Aug 2024 07:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723619776;
	bh=2DFuhkegAKw2VGmG0aMHoO6HwcjsJ3J4ofOBi5GoYu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cHzMLDsmU/rORQXzXPzmat9Ppd9CIC1cK2ptJBvO33EkEYMQ9MNHJfmukC5+6EFRO
	 ebm3sgl4of0tfRoOXy9jTbF4Cehmvz38NM4O7haF8SzyNNcKBBVFz5QU9O5HYSOlyT
	 DLh34mWL2K+4ejbDsMQ3k6D5StAkTExWozE94gWQ=
Date: Wed, 14 Aug 2024 09:16:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: usb: microchip,usb2514: Fix reference
 USB device schema
Message-ID: <2024081400-stallion-suffix-3a0b@gregkh>
References: <20240814065833.36372-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814065833.36372-1-alexander.stein@ew.tq-group.com>

On Wed, Aug 14, 2024 at 08:58:32AM +0200, Alexander Stein wrote:
> An USB hub is not a HCD, but an USB device. Fix the referenced schema
> accordingly. Adjust example to keep it aligned to other schemas.
> 
> Fixes: bfbf2e4b77e27 ("dt-bindings: usb: Document the Microchip USB2514 hub")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> As this USB hub also can contain an USB (ethernet) sub device, I copied
> the subdevice part from usb-hcd.yaml.
> 
> I had to add 'additionalProperties: true' as well, because I got that warning
> upon dt_binding_check otherwise:
> > Documentation/devicetree/bindings/usb/microchip,usb2514.yaml: 
> >   ^.*@[0-9a-f]{1,2}$: Missing additionalProperties/unevaluatedProperties constraint
> 
> I added a Fixes tag to keep this schema aligned in v6.10 stable tree.
> 
>  .../devicetree/bindings/usb/microchip,usb2514.yaml    | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
> index 245e8c3ce6699..aa3db8e373c70 100644
> --- a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
> +++ b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
> @@ -10,7 +10,7 @@ maintainers:
>    - Fabio Estevam <festevam@gmail.com>
>  
>  allOf:
> -  - $ref: usb-hcd.yaml#
> +  - $ref: usb-device.yaml#
>  
>  properties:
>    compatible:
> @@ -36,6 +36,13 @@ required:
>    - compatible
>    - reg
>  
> +patternProperties:
> +  "^.*@[0-9a-f]{1,2}$":
> +    description: The hard wired USB devices
> +    type: object
> +    $ref: /schemas/usb/usb-device.yaml
> +    additionalProperties: true
> +
>  unevaluatedProperties: false
>  
>  examples:
> @@ -47,7 +54,7 @@ examples:
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
> -        usb-hub@1 {
> +        hub@1 {
>              compatible = "usb424,2514";
>              reg = <1>;
>              clocks = <&clks IMX6QDL_CLK_CKO>;
> -- 
> 2.34.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

