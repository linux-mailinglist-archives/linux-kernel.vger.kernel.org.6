Return-Path: <linux-kernel+bounces-200953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A888FB792
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C45EB23AAD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F66148856;
	Tue,  4 Jun 2024 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mb5BLESp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1A0148FED;
	Tue,  4 Jun 2024 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717514938; cv=none; b=Jbnelqlg0fKuZot+QtZMwv59dJAyKn5h6vna9ejT2qk1rf/nPVmcz02TVnPXKiQmFnILpiIt1zDrRZYfZsj4Ox7MDQ3P2EKIIGADLzks3syBq0pJKYREnrT3iyw7wEbHhKzon7GYp3QAl1RmJWulLqVXkeeYbYWF8dIOdcAnG4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717514938; c=relaxed/simple;
	bh=aXE8gOS2TuQOrCEK4qKB62qDKs93x0nvxlcAsf6CsQg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=A1f5pp8KYFl8jn0PGU9tuTfik15Zs+DKae4rt483bmuy+vbqWIpJ33gD3IkLClOCWINm9ghGE8O+3A+XRIy7YRy3jD6N0kG7Vo0F4gEeWL8woG4jKyt9SdFNqk0E1ivh9YUks6CCOTX66mciKKFK9QhFbty2tqyIz3OYBZv5QeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mb5BLESp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C879DC4AF07;
	Tue,  4 Jun 2024 15:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717514938;
	bh=aXE8gOS2TuQOrCEK4qKB62qDKs93x0nvxlcAsf6CsQg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=mb5BLESp0dCeu1l4lVu/jtlOXaoiG+X9Tk0jKTHIF6aArnOo3vs/aI0TzWnuFLjm4
	 3FcGMhI6J8BByrzvmX1srj1un0RRU32bHH98btU7RE6VuaTjUlHn6rX3AVGQDp0f07
	 PcRZPf6LcwRVxeMWona4WjGK/KYmo7P7OZujTmcjdDjayNyIPSbDZtvdHp3vdD6Drp
	 y/2ZxIIWDk4ALp26sV/jBA4dxnm10tBd3oUCRpzKtb4mzECWgUGKW72zdEIbjT/lkW
	 oQePp8Vjruy7WoeARDGBtalzZw6aD9fGOgSulDnRu0n8tpv7TRBrWauD1mi9q4aUvq
	 7ykG8peR3pbhQ==
Date: Tue, 04 Jun 2024 10:28:55 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 linux-amlogic@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>
In-Reply-To: <20240604084134.3315841-1-christianshewitt@gmail.com>
References: <20240604084134.3315841-1-christianshewitt@gmail.com>
Message-Id: <171751454959.786114.9525171695833472350.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: amlogic: add GXLX/S905L/p271
 reference board


On Tue, 04 Jun 2024 08:41:33 +0000, Christian Hewitt wrote:
> Add support for an Amlogic GXLX based S905L SoC and P271 reference
> design board. The S905L is a low-cost design similar to the P281
> (S905W) and is similarly derived from P212 (S905X). However S905L
> omits support for the VP9 codec and uses Mali 450-MP2 (not MP3).
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y amlogic/meson-gxlx-s905l-p271.dtb' for 20240604084134.3315841-1-christianshewitt@gmail.com:

arch/arm64/boot/dts/amlogic/meson-gxlx-s905l-p271.dtb: /soc/bus@c1100000/adc@8680: failed to match any schema with compatible: ['amlogic,meson-gxlx-saradc', 'amlogic,meson-saradc']
arch/arm64/boot/dts/amlogic/meson-gxlx-s905l-p271.dtb: /soc/video-codec@c8820000: failed to match any schema with compatible: ['amlogic,gxlx-vdec', 'amlogic,gx-vdec']
arch/arm64/boot/dts/amlogic/meson-gxlx-s905l-p271.dtb: sound: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
	from schema $id: http://devicetree.org/schemas/sound/amlogic,gx-sound-card.yaml#
arch/arm64/boot/dts/amlogic/meson-gxlx-s905l-p271.dtb: sound: 'anyOf' conditional failed, one must be fixed:
	'clocks' is a required property
	'#clock-cells' is a required property
	from schema $id: http://devicetree.org/schemas/clock/clock.yaml#






