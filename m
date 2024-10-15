Return-Path: <linux-kernel+bounces-366653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0623799F84D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4761F22B76
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361331F9ED8;
	Tue, 15 Oct 2024 20:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhbRwCJs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D691F80DD;
	Tue, 15 Oct 2024 20:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729025646; cv=none; b=KS6cWK9aYZzS/Tiq85QT/YIoxu4L6sjVXHrsySraxthgjhQZdYgTcD34VRsvBXcEgZMgy8m2AsN5v4AfRdK//wrboavPBEwBMfNibxQSZoOcKo2eQjRV8g/J/0xSgEzOJi+Qc17Tii/7d47KKU//ViaD3atk5hVjWNN6I+4KL4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729025646; c=relaxed/simple;
	bh=9wxjI5r/Gdefhk0EShbLW4iHqs+1lKibN5Vf788gSqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0wl2/ARlffBjEbe5UmkNjevoCtz1SIMW3bDzZBTghcan6XnDwFCJvVp+3A0a5AvpTT4i9aYeF/gBXBmOHhq5ptNq4R6kg8JNmszol/SnW8rlCtH7uMvBW7sNDF4mELqhGZ1iiw8IhbYogruY2TPKsuqBwd4nVXrS9ehHrTlmJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhbRwCJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A719C4CEC6;
	Tue, 15 Oct 2024 20:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729025646;
	bh=9wxjI5r/Gdefhk0EShbLW4iHqs+1lKibN5Vf788gSqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fhbRwCJsK0YIM74AH6OIEukQtGWuMTAcTKdSgRzAYswYMg/JugZFFYjjOjHy6Xluy
	 XiAL4uQGLyDDumnbNRLtnHpl5Di2fZC6ja1sQr+kcvJNJOGy7fzna7zIXXDzR54wnu
	 Q/10XN6kHU9gNXewPhTEOWKMjRR0w7dwcgHywbig8jQhGUu7Aud+GNedFfSOFWyYJW
	 PjXqxmYO11X6UVr/n+xN6/areN0If7HKaS0Bpb8xomcAMZr7prPNVcQsQ7WU8E3/cS
	 GlraG+jHbXXIwjAmrp9NUKmNfi2yluOF3STC7fFMMrHcd8FqI3HCRYZ+Eew0vx72Am
	 Q27dT6e4GRYGQ==
Date: Tue, 15 Oct 2024 15:54:05 -0500
From: Rob Herring <robh@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	ChiYuan Huang <cy_huang@richtek.com>, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bear Wang <bear.wang@mediatek.com>,
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	Chris-qj chen <chris-qj.chen@mediatek.com>
Subject: Re: [PATCH 1/2] dt-bindings: usb: mediatek,mt6360-tcpc: add ports
 properties
Message-ID: <20241015205405.GA1934266-robh@kernel.org>
References: <20241015103337.20479-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015103337.20479-1-macpaul.lin@mediatek.com>

On Tue, Oct 15, 2024 at 06:33:36PM +0800, Macpaul Lin wrote:
> Add 'ports' and sub node 'port' properties to specify connectors on the
> High-Speed/Super-Speed data bus, or Sideband Use (SBU) AUX lines
> endpoints of the USB controller.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  .../bindings/usb/mediatek,mt6360-tcpc.yaml    | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
> index 053264e60583..5b6ea0d734ea 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
> @@ -32,6 +32,27 @@ properties:
>      description:
>        Properties for usb c connector.
>  
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    description:
> +      Any connector to the data bus of this controller should be specified.
> +    properties:

> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0

No need for these, already defined in the $ref'ed schema.

> +
> +    patternProperties:
> +      "port@[0-2]$":
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          It could be one of the following interface types. High-Speed
> +          (HS) data bus endpoint to the Type-C connector, SuperSpeed (SS)
> +          data bus endpoint to the Type-C connector, or Sideband Use (SBU)
> +          AUX lines endpoint to the Type-C connector for the purpose of
> +          handling altmode muxing and orientation switching.

You have to define what each port number is.

However, I'm completely confused as to why you need any of this. The 
description sounds like the usb-c-connector which is already defined as 
a child node.

Rob

