Return-Path: <linux-kernel+bounces-396472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9142A9BCD95
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 292532817AD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D9D1D63C4;
	Tue,  5 Nov 2024 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLkg8d5I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ECC1D86C4;
	Tue,  5 Nov 2024 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730812315; cv=none; b=AJAo/dZkFTI+M7oYbMbuA8vtleviXkcVGdxZBUXWpbxD6lU68TsnAEwmC7aeV83ItyLHsR1e6Rq5YDkWG2uOPUqM6h3U+boahiMUQ1ZcnRpmvpgkIHwLYq3iRcke05yfikPdczW25d+ghRrFYWB7pc8J9B6gu/4G6LD8MOXHHv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730812315; c=relaxed/simple;
	bh=V4Mts+tTs6BPCP3dh+3MW/ylGLY1ZG6m9fyFwGZSwV8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=O3kWA8QvlD7q/BOD2pXrIk1r/gXcORpJ+mTIof0MKxONLQTOt2bRFcm4CvqoKh+zKUfeVle5Kv4DJTDxbpxcY00l9uHHYXAIVJ5mfQtdPGtVCDmmVnOCbsUAGvPIr876Nl6pzD+g8P0O63DWoSts096Z0rSDsHNqfI7OWwAR7DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLkg8d5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB0AC4CECF;
	Tue,  5 Nov 2024 13:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730812314;
	bh=V4Mts+tTs6BPCP3dh+3MW/ylGLY1ZG6m9fyFwGZSwV8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=GLkg8d5IIwEzLYkzHHKe8/xMkGK1BrT8J+ooQHDtu/Hse5jRPRe1MDFMbytX9sMvv
	 pIWSP2AmB/b9n7zA+oCEC04BTqj7LdnjD9+I8YvTTe1wvhFNEMOJD7M1E5NemPK5pA
	 UxNoEfGJ9kF4QG9Ek4zOH7TupenL4chlvvVdk30rGaYxTMMU1bxEttZRJVSsdVKQqb
	 Cj0xlQu/HpGoEMOr1+cdSXktrf0B+izarjAOAvxBkyhFbZklzNZZXWmTiRh/WSaKUm
	 XbTVS5J5Z/yFDEiYLGH+8wjX+ZgkKV4XesL92kmDpYLY7oqRxyqy52idofBGgZ8Tqv
	 GOOVJoSRfMdnw==
Date: Tue, 05 Nov 2024 07:11:53 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Hans de Goede <hdegoede@redhat.com>, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Benjamin Tissoires <bentiss@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Hsin-Yi Wang <hsinyi@chromium.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <20241105-post-reset-v2-0-c1dc94b65017@chromium.org>
References: <20241105-post-reset-v2-0-c1dc94b65017@chromium.org>
Message-Id: <173081219810.3053131.3032719089885564327.robh@kernel.org>
Subject: Re: [PATCH RESEND v2 0/4] Using i2c-hid-of-elan driver instead of
 i2c-hid-of driver


On Tue, 05 Nov 2024 03:08:10 +0000, Hsin-Te Yuan wrote:
> After commit 2be404486c05 ("HID: i2c-hid-of: Add reset GPIO support to
> i2c-hid-of"), i2c-hid-of driver resets the touchscreen without having
> proper post-reset delay on OF platform.  From the commit message of that
> commit, not to decribe poset-reset delay in device tree is intended.
> Instead, describing the delay in platform data and changing to use
> specialized driver is more preferable solution.
> 
> Also workaround the race condition of pinctrl used by touchscreen and
> trackpad in this series to avoid merge conflict.
> 
> Adding other second source touchscreen used by some mt8183 devices in
> this series since this should be based on the workaround of pinctrl
> issue.
> 
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
> Changes in v2:
> - Add second source touchscreen patches since they should based on the
>   first patch of this series.
> - Link to v1: https://lore.kernel.org/r/20241018-post-reset-v1-0-5aadb7550037@chromium.org
> 
> ---
> Hsin-Te Yuan (4):
>       arm64: dts: mediatek: mt8183: Fix race condition of pinctrl
>       arm64: dts: mediatek: mt8183: Switch to Elan touchscreen driver
>       arm64: dts: mediatek: mt8183: kenzo: Support second source touchscreen
>       arm64: dts: mediatek: mt8183: willow: Support second source touchscreen
> 
>  arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts |  2 --
>  arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts  |  3 ---
>  arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts   | 12 +++---------
>  .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts   | 11 ++---------
>  .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts   | 11 ++---------
>  .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts   | 11 ++---------
>  .../arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi |  3 ---
>  .../boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper.dtsi      |  3 ---
>  arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico.dts   |  3 ---
>  arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts  |  3 ---
>  .../arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi |  3 ---
>  arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi       | 10 +++-------
>  12 files changed, 12 insertions(+), 63 deletions(-)
> ---
> base-commit: eca631b8fe808748d7585059c4307005ca5c5820
> change-id: 20241018-post-reset-ac66b0351613
> 
> Best regards,
> --
> Hsin-Te Yuan <yuanhsinte@chromium.org>
> 
> 
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


New warnings running 'make CHECK_DTBS=y mediatek/mt8183-kukui-jacuzzi-burnet.dtb mediatek/mt8183-kukui-jacuzzi-cozmo.dtb mediatek/mt8183-kukui-jacuzzi-damu.dtb mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dtb mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dtb mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dtb mediatek/mt8183-kukui-jacuzzi-kenzo.dtb mediatek/mt8183-kukui-jacuzzi-pico.dtb mediatek/mt8183-kukui-jacuzzi-pico6.dtb' for 20241105-post-reset-v2-0-c1dc94b65017@chromium.org:

arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dtb: dsi@14014000: Unevaluated properties are not allowed ('ports' was unexpected)
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dsi.yaml#






