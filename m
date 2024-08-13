Return-Path: <linux-kernel+bounces-285368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B540F950CA3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8C6285722
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F501A4F05;
	Tue, 13 Aug 2024 18:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfOtq4WS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9D21A3BC8;
	Tue, 13 Aug 2024 18:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723575474; cv=none; b=nfkZJh2fcCq7pdd/aJ7Xm5sevKwkDXgK8Br/40qMWk/ZbUHKJ7a6M/q1c1A493kKT/VMkq8FucKCC393vuvgy0N6lqVm7N+nD3v9/Cz6+P3YnQfZMxrrQLFWqTp86YxeRGKKkX5r20Fzpi75/0Sqcsqn+J4N4n0PL11yyeRqp8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723575474; c=relaxed/simple;
	bh=3wO7JwEYq4lkWUmFKVclTxSav2GWMKw4EYd1vHhtdl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YT0kQAnekvp0DSAU8Y41hTAiBcJKQ/b47f2KTRroJEH4Yeda+TUaulH33Nv1hA9ZQDKj55Wa6BljVSjuExuV7Uwmsxd2Ry720GFbiGiZSYspfpT/nJELRYroagGXB6JSHgW0NyWB4vQYFNv5TEdEer+StW005vA5sKIrDqZLBic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfOtq4WS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E248AC32782;
	Tue, 13 Aug 2024 18:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723575474;
	bh=3wO7JwEYq4lkWUmFKVclTxSav2GWMKw4EYd1vHhtdl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SfOtq4WS/gwDDtNTQZPoMvFzzGe/4fGFsst9VGvJGyGwcsflkJ5lejIpbwGhwGAdf
	 hjSo5ihukyEdbcQRZgdQq6io/uxYhIpKDOtfQoz4/biq9OQTPE/dWrvYAgYjmH8anq
	 Hn9n7OQPdskmwjNYfDPrp9R3jO4LaZ9P7itibyGaTBKzryv/S6RO1c6DR8VCVawTBC
	 BscXvF+Wk01wr5/J2yGBG+mlszrKbhzS0BH3OFM3UlARPNN3qWnexy5OXnWInYiSLe
	 Sa1z3gnauDVoFhuRZ6mYedyz0KAGEh7w7JG+Bv8KK3v001CJIK9tGHIC5tuwX4JOgx
	 4aeKvmzvacVFQ==
Date: Tue, 13 Aug 2024 12:57:52 -0600
From: Rob Herring <robh@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthias Kaehlcke <mka@chromium.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: usb: microchip,usb2514: add support for
 port vbus-supply
Message-ID: <20240813185752.GA1423091-robh@kernel.org>
References: <20240807-b4-v6-10-topic-usb-onboard-dev-v1-0-f33ce21353c9@pengutronix.de>
 <20240807-b4-v6-10-topic-usb-onboard-dev-v1-2-f33ce21353c9@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807-b4-v6-10-topic-usb-onboard-dev-v1-2-f33ce21353c9@pengutronix.de>

On Wed, Aug 07, 2024 at 04:36:52PM +0200, Marco Felsch wrote:
> Some PCB designs don't connect the USB hub port power control GPIO and
> instead make use of an host controllable regulator. Add support for this
> use-case by introducing an portX-vbus-supply property.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/usb/microchip,usb2514.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
> index 783c27591e56..51d02c4b8f2d 100644
> --- a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
> +++ b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
> @@ -35,6 +35,13 @@ required:
>    - compatible
>    - reg
>  
> +patternProperties:
> +  "^port[1-7]-vbus-supply$"
> +    type: object
> +    description:
> +      Regulator controlling the USB VBUS on portX. Only required if the host
> +      controls the portX VBUS.

This is completely external to the Microchip part, right?

I think each port node should have a 'vbus-supply' property instead.

Rob

