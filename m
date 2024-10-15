Return-Path: <linux-kernel+bounces-366836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 539B599FB45
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808F51F21A67
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED0A1D63E1;
	Tue, 15 Oct 2024 22:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJ5OWFOg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EBF185B47;
	Tue, 15 Oct 2024 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030848; cv=none; b=YPtHEeRv7hNUXdxR5oQXWhwkU8g0VSKKYd9Fc+VOrHw11F5KCI6FNYRVzX4ljmSRToCVF72+L0jjsZEmXOY929GteseXZM8ID1llt9TtpE89t9ZyoXzoV5rNgbVbnAGpNIBONfER+NRVZIy4IE3npJoRMvBJNJw8/nVGsv6plWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030848; c=relaxed/simple;
	bh=cz0wcw3Y7yNv81Eqmq/jRhBRalPGnIOBsVA8ozyzCVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZy9Bfi4z3j+I8HXhZXlF8p1PHezXB6Gr5qiQJjGC+tOkjbkTh+iWB30gcvq8ERU97ubYjkvqzMcmJlaA3AQFdvdxI8VmN5TKVmBGecPEvtG5Ye8XE6TLggY8v62WLBSYVjOepm+nLsSNN0BZb31CU3taMv5OlhKuPGT9mjn7uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJ5OWFOg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F57FC4CEC6;
	Tue, 15 Oct 2024 22:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729030847;
	bh=cz0wcw3Y7yNv81Eqmq/jRhBRalPGnIOBsVA8ozyzCVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QJ5OWFOgkkbenFSC429aGainB2dB4o0Q1vBAUtQN81RS+VdC7+NpsQcZaLWnrJu+N
	 4/M8AGaJGNfzask2wpXq4U9kC2eZ6g+ZKzHkJ++CXumOaNt2Jk2AkWMWsNeFoqYciM
	 sYYvXSbooEjQgj5oYEjH3Fkab210ZGDzdwoeqfxmtLVG6gmH61DMfc4GvcC3ngxaOg
	 k73Ht2ipOfeaooBnACRFeOPJPk9nKiVjxBXA44plZvh5BhM7dS8/DzlQUr37Y5FhTM
	 uv/KZcWhx/zMKVPaaJ8aAYyecBQPV9scgLLS2W3fFlV0SZvruGCX4BCpDiyo8X6Siv
	 Ap/ZZCi9S8Jcg==
Date: Tue, 15 Oct 2024 17:20:46 -0500
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
Subject: Re: [PATCH] dt-bindings: usb: mtu3: add mediatek,usb3-drd property
Message-ID: <20241015222046.GA2164669-robh@kernel.org>
References: <20241015172100.15150-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015172100.15150-1-macpaul.lin@mediatek.com>

On Wed, Oct 16, 2024 at 01:21:00AM +0800, Macpaul Lin wrote:
> Add optional 'mediatek,usb3-drd' property to MediaTek MTU3 DT Schema.
> This flag specify whether it is a USB3 Dual-role device hardware.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
> index d4e187c78a0b..1e70af0dac82 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
> @@ -155,6 +155,12 @@ properties:
>        property is used. See graph.txt
>      $ref: /schemas/graph.yaml#/properties/port
>  
> +  mediatek,usb3-drd:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Specify whether it is a USB3 Dual-role device hardware.
> +    type: boolean
> +

Don't the standard properties such as usb-role-switch or dr_mode work 
for you?

>    enable-manual-drd:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:
> -- 
> 2.45.2
> 

