Return-Path: <linux-kernel+bounces-568950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CA5A69C96
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 00:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F71D4818FC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1AF223308;
	Wed, 19 Mar 2025 23:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ix6gZjFu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE0D21506D;
	Wed, 19 Mar 2025 23:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742425844; cv=none; b=eaLzsAbbhx0yuOpzlv93FdVe2PE+246Bh364cE10v4o4QzRmKZBSl00UqhlUlg0LESIHVIot/yE7fAhHN4pBX+eGhuCQGgW90qjYZ63Fg8k9CpLH3KPlASlMchLlTj8FlIin7Ng+4g+ZjlrNlgNm4fnAkdi1QWhQ5L/SgfEEW6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742425844; c=relaxed/simple;
	bh=L6HRrJPe/oD/P33omcYeeISqRniz4IThgwzvXP5TlNA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=tp9z1Uz2y041gywdXuUpGebzcF5D5TCadsV6sVGxH1L40ukxvhwfcqaYhH4/kM3xUvqcJyZNU5os6EFBDdFW1SsdahQFHXFOksWC90qzcX65VNamqr6H3Ps/Evt2O8hQBJ5AS/Hq5xh6gOGb9X/27thpLXcyGDeSe2QSzdpXDOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ix6gZjFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991ECC4CEE4;
	Wed, 19 Mar 2025 23:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742425843;
	bh=L6HRrJPe/oD/P33omcYeeISqRniz4IThgwzvXP5TlNA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=ix6gZjFuakS6xfWCWprsg52TMUp9Ym+v6mx/x2FIEZyyrLuhxYAmH/XHlLpF2vqeO
	 wmASTT8Eah9zofiT9Lz8xNDgnywYqQFWntdh8PE/PDULvrZJy0SJ+pLqU8fn5hoZcm
	 SM7homPHBiiXMoknIkuIW56wUyN3xX0UbO8MvLdZkgpKFlcf1tz4kxq8bn4XxSqlLR
	 5/blFlLYjkRfXuO+qPMTC48fVDW/dpuDEfuygfRdDBY0J3ygm+AqetldtUsyYIeMFE
	 mVeui53KLVAvFrt9bQuT5Vsa0QjkFuZ/BoVNxC4YDz3+Mpbkf0/PANa0+/DvnmYr55
	 vWrlMRY0AiAWQ==
Date: Wed, 19 Mar 2025 18:10:42 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Kevin Hilman <khilman@baylibre.com>, Artur Weber <aweber.kernel@gmail.com>, 
 Christian Hewitt <christianshewitt@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, ~postmarketos/upstreaming@lists.sr.ht, 
 Conor Dooley <conor+dt@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>, 
 Karl Chan <exxxxkc@getgoogleoff.me>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-kernel@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 devicetree@vger.kernel.org
To: Ferass El Hafidi <funderscore@postmarketos.org>
In-Reply-To: <20250319190150.31529-2-funderscore@postmarketos.org>
References: <20250319190150.31529-2-funderscore@postmarketos.org>
Message-Id: <174242564139.2499881.5985170981835885510.robh@kernel.org>
Subject: Re: [PATCH v5 0/2] Add support for Xiaomi Mi TV Stick


On Wed, 19 Mar 2025 19:01:48 +0000, Ferass El Hafidi wrote:
> This patch series aims to add initial support for the Xiaomi Mi TV
> Stick.
> 
> Xiaomi Mi TV Stick is a small Amlogic-based Android TV stick released in
> 2020, and known as `xiaomi-aquaman` internally (in the downstream kernel,
> u-boot, ...)
> Its specifications are as follows:
>  * Amlogic S805Y SoC (believed to be mostly identical to S805X)
>  * 8 GB eMMC
>  * 1 GB of RAM
>  * Wi-Fi + Bluetooth
>  * Android TV 9, upgradable to Android TV 10
>  * Google-certified
> 
> There are multiple variants:
>  * 1. Green PCB, manufactured in 2020, known UART pinout (helpfully
>    labeled on the board)
>  * 2. Blue PCB, not much documentation about it, presumably manufactured
>    between 2021 and 2023
>  * 3. Green PCB, manufactured in 2023/2024, known UART pinout, some layout
>    changes compared to the 2020 variant
> 
> Among these variants, there are many boards using multiple different
> Wi-Fi chips.  Supporting all of them is out of scope for this patch
> series.  However, there has been some work identifying Wi-Fi/Bluetooth
> since v4.  Some variants use a Realtek module while others use an
> Amlogic module.
> 
> As of the time of writing this has only been tested on the 3rd variant.
> It is believed that software-wise all three work mostly the same (if we
> don't count Wi-Fi/BT), but testing on the other variants would still be
> appreciated.  Sadly, booting Mainline linux is slightly more
> challenging on some versions of the original firmware.
> 
> The devicetree is based on the Amlogic P241 DTS.
> 
> Changes since v4 [1]:
>  * add Acked-by from krzk
>  * Wi-Fi on sd_emmc_b
> 
> Changes since v3 [2]:
>  * typo fix (`vbus-supply` in `&usb`)
> 
> Changes since v2 [3]:
>  * fix SoB/From mismatch
> 
> Changes since v1 [4]:
>  * remove useless nodes: cvbs-connector, ethmac, internal_phy, ir
>  * add `amlogic,s805y` DT binding section
>  * add S805Y dtsi: meson-gxl-s805y.dtsi
>  * adjust DT `model` to "Xiaomi Mi TV Stick (Aquaman)"
>  * explain the changes being done a bit more in the commit message for
>    the DT patch
>  * drop `clocks` and `clock-names` from pwm_ef (background: [5])
>  * change sound `model` to "XIAOMI-AQUAMAN"
> 
> More information is available on the postmarketOS wiki page [6].
> 
> [1]: https://lore.kernel.org/all/20250203174346.13737-1-funderscore@postmarketos.org/
> [2]: https://lore.kernel.org/all/20250203091453.15751-1-funderscore@postmarketos.org/
> [3]: https://lore.kernel.org/all/20250201193044.28856-1-funderscore@postmarketos.org/
> [4]: https://lore.kernel.org/all/20250131200319.19996-1-funderscore@postmarketos.org/
> [5]: https://lore.kernel.org/linux-amlogic/20241227212514.1376682-1-martin.blumenstingl@googlemail.com/
> 
> 
> Ferass El Hafidi (2):
>   dt-bindings: arm: amlogic: add S805Y and Mi TV Stick
>   arm64: dts: amlogic: add support for xiaomi-aquaman/Mi TV Stick
> 
>  .../devicetree/bindings/arm/amlogic.yaml      |   7 +
>  arch/arm64/boot/dts/amlogic/Makefile          |   1 +
>  .../meson-gxl-s805y-xiaomi-aquaman.dts        | 292 ++++++++++++++++++
>  .../boot/dts/amlogic/meson-gxl-s805y.dtsi     |  10 +
>  4 files changed, 310 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s805y-xiaomi-aquaman.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s805y.dtsi
> 
> --
> 2.47.1
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


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/amlogic/' for 20250319190150.31529-2-funderscore@postmarketos.org:

Error: arch/arm64/boot/dts/amlogic/meson-gxl-s805y-xiaomi-aquaman.dts:243.1-2 syntax error
FATAL ERROR: Unable to parse input tree
make[3]: *** [scripts/Makefile.dtbs:131: arch/arm64/boot/dts/amlogic/meson-gxl-s805y-xiaomi-aquaman.dtb] Error 1
make[2]: *** [scripts/Makefile.build:461: arch/arm64/boot/dts/amlogic] Error 2
make[2]: Target 'arch/arm64/boot/dts/amlogic/meson-gxl-s805y-xiaomi-aquaman.dtb' not remade because of errors.
make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1475: amlogic/meson-gxl-s805y-xiaomi-aquaman.dtb] Error 2
make: *** [Makefile:248: __sub-make] Error 2
make: Target 'amlogic/meson-gxl-s905x-hwacom-amazetv.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905d-sml5442tw.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905d-phicomm-n1.dtb' not remade because of errors.
make: Target 'amlogic/meson-s4-s805x2-aq222.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905w-p281.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxm-s912-libretech-pc.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12a-sei510.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxm-q200.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905x-khadas-vim.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxlx-s905l-p271.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxm-mecool-kiii-pro.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxm-vega-s96.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12a-fbx8am.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-bananapi-cm4-cm4io.dtb' not remade because of errors.
make: Target 'amlogic/amlogic-c3-c308l-aw419.dtb' not remade because of errors.
make: Target 'amlogic/meson-axg-s400.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxm-nexbox-a1.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-dreambox-one.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxm-khadas-vim2.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxm-wetek-core2.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12a-radxa-zero.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxbb-vega-s95-telos.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905x-libretech-cc-v2.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-a311d-khadas-vim3.dtb' not remade because of errors.
make: Target 'amlogic/meson-axg-jethome-jethub-j100.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-gsking-x.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxbb-vega-s95-pro.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxm-q201.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905d-p230.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-a311d-bananapi-m2s.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxbb-wetek-play2.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905d-mecool-kii-pro.dtb' not remade because of errors.
make: Target 'amlogic/meson-axg-jethome-jethub-j110-rev-2.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxbb-odroidc2.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxm-gt1-ultimate.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12a-x96-max.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905d-libretech-pc.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905d-p231.dtb' not remade because of errors.
make: Target 'amlogic/meson-sm1-x96-air.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905x-vero4k.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxbb-vega-s95-meta.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905w-tx3-mini.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxm-minix-neo-u9h.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s805x-libretech-ac.dtb' not remade because of errors.
make: Target 'amlogic/meson-sm1-a95xf3-air-gbit.dtb' not remade because of errors.
make: Target 'amlogic/meson-sm1-khadas-vim3l.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905d-vero4k-plus.dtb' not remade because of errors.
make: Target 'amlogic/meson-sm1-h96-max.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-bananapi-cm4-mnt-reform2.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905x-p212.dtb' not remade because of errors.
make: Target 'amlogic/meson-a1-ad401.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-odroid-go-ultra.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-radxa-zero2.dtb' not remade because of errors.
make: Target 'amlogic/meson-sm1-x96-air-gbit.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-dreambox-two.dtb' not remade because of errors.
make: Target 'amlogic/meson-sm1-bananapi-m5.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12a-u200.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxm-rbox-pro.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxbb-p201.dtb' not remade because of errors.
make: Target 'amlogic/meson-sm1-a95xf3-air.dtb' not remade because of errors.
make: Target 'amlogic/amlogic-a4-a113l2-ba400.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s805y-xiaomi-aquaman.dtb' not remade because of errors.
make: Target 'amlogic/meson-sm1-bananapi-m2-pro.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxbb-p200.dtb' not remade because of errors.
make: Target 'amlogic/meson-sm1-odroid-c4.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-s922x-bananapi-m2s.dtb' not remade because of errors.
make: Target 'amlogic/meson-sm1-sei610.dtb' not remade because of errors.
make: Target 'amlogic/meson-sm1-odroid-hc4.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-odroid-n2l.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905x-libretech-cc.dtb' not remade because of errors.
make: Target 'amlogic/amlogic-c3-c302x-aw409.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905x-nexbox-a95x.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-a311d-libretech-cc.dtb' not remade because of errors.
make: Target 'amlogic/amlogic-t7-a311d2-khadas-vim4.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905w-jethome-jethub-j80.dtb' not remade because of errors.
make: Target 'amlogic/meson-sm1-s905d3-libretech-cc.dtb' not remade because of errors.
make: Target 'amlogic/amlogic-a5-a113x2-av400.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxbb-wetek-hub.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-s922x-khadas-vim3.dtb' not remade because of errors.
make: Target 'amlogic/amlogic-t7-a311d2-an400.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxbb-kii-pro.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-odroid-n2.dtb' not remade because of errors.
make: Target 'amlogic/meson-a1-ad402.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxbb-nexbox-a95x.dtb' not remade because of errors.
make: Target 'amlogic/meson-axg-jethome-jethub-j110-rev-3.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-odroid-n2-plus.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-gtking-pro.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-ugoos-am6.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s805x-p241.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-gtking.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxbb-nanopi-k2.dtb' not remade because of errors.






