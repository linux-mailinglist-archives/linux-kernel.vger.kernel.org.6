Return-Path: <linux-kernel+bounces-568626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C8BA69891
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299EB463344
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8551020B808;
	Wed, 19 Mar 2025 19:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="HTFNVaXB"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DC21CAA81
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742410976; cv=none; b=YP/qeMuNTD6qkM52FZQPnGT6/mp15LFBxfBjtFE6WwitJtwu5Vrt71BltjCwfaW/DuK0DtMG/3Ts36ncj91fci0vO1ES6/qJeZ8uR01d7mnXBwSjP3LkMKAiozlFlS/1jK7h/5l9cSxcwFh68snTjLux5jrc/oZKML0reqMYD0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742410976; c=relaxed/simple;
	bh=GUJ5eSUZvMDOX8lBfqVeAr0bjHXRhxYHxrq2jqKZfkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K7In16X9VhGRMPBinsx0IeHodKUgmIBk5PKtI8xARXR/tLd/aGHJUHAhrAHamQm2v7v2g2z9L03Eefoq4yxeeNqIZ7dnp0pO/cx9vsYaxcSTWKOJpG81WGuUjg26QYR6TUaDDbbZXJa9Osvk7wlTTzTGVAKm/Yp1s83mTk28/kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=HTFNVaXB; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1742410971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y0Eo0e6YOE9ilTmD+cbKmf0J9gx2iyifBh05aUNn6ks=;
	b=HTFNVaXBvtCpqdADiDu6dLds+9rJtE3cC135zOWlGP8GMkavL7UwCTSERgmI1+N/YbR2zL
	IEHVqcG0Ic2MFqL7auYiwTlyVD8keAw+htKk7GJuN4DzbNCH2Cko10va7mRpEuJaDmCwo3
	zaUHPoRovRpxt8WQxgOMuey4tk5bJmHb0lrfFOTmNryDn3127qOtzJi4576EkBAMJNvUrn
	LfZu6ckscoZdk0CAxEkR4QpLULUkEFdl9CKmeu09AUKlURN5rD48ONoLo7e0ltMKPghWBY
	Z+9phY67o6B/BEwg1BX7rGu/6O6nXMGmA+Yfg7gufFmUAU55rA52nIYgKf9ArA==
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	funderscore@postmarketos.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Artur Weber <aweber.kernel@gmail.com>,
	Karl Chan <exxxxkc@getgoogleoff.me>,
	Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v5 0/2] Add support for Xiaomi Mi TV Stick
Date: Wed, 19 Mar 2025 19:01:48 +0000
Message-ID: <20250319190150.31529-2-funderscore@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch series aims to add initial support for the Xiaomi Mi TV
Stick.

Xiaomi Mi TV Stick is a small Amlogic-based Android TV stick released in 
2020, and known as `xiaomi-aquaman` internally (in the downstream kernel,
u-boot, ...)
Its specifications are as follows:
 * Amlogic S805Y SoC (believed to be mostly identical to S805X)
 * 8 GB eMMC
 * 1 GB of RAM
 * Wi-Fi + Bluetooth
 * Android TV 9, upgradable to Android TV 10
 * Google-certified

There are multiple variants:
 * 1. Green PCB, manufactured in 2020, known UART pinout (helpfully 
   labeled on the board)
 * 2. Blue PCB, not much documentation about it, presumably manufactured
   between 2021 and 2023
 * 3. Green PCB, manufactured in 2023/2024, known UART pinout, some layout
   changes compared to the 2020 variant

Among these variants, there are many boards using multiple different
Wi-Fi chips.  Supporting all of them is out of scope for this patch
series.  However, there has been some work identifying Wi-Fi/Bluetooth 
since v4.  Some variants use a Realtek module while others use an
Amlogic module.

As of the time of writing this has only been tested on the 3rd variant.
It is believed that software-wise all three work mostly the same (if we 
don't count Wi-Fi/BT), but testing on the other variants would still be
appreciated.  Sadly, booting Mainline linux is slightly more
challenging on some versions of the original firmware.

The devicetree is based on the Amlogic P241 DTS.

Changes since v4 [1]:
 * add Acked-by from krzk
 * Wi-Fi on sd_emmc_b

Changes since v3 [2]:
 * typo fix (`vbus-supply` in `&usb`)

Changes since v2 [3]:
 * fix SoB/From mismatch

Changes since v1 [4]:
 * remove useless nodes: cvbs-connector, ethmac, internal_phy, ir
 * add `amlogic,s805y` DT binding section
 * add S805Y dtsi: meson-gxl-s805y.dtsi
 * adjust DT `model` to "Xiaomi Mi TV Stick (Aquaman)"
 * explain the changes being done a bit more in the commit message for
   the DT patch
 * drop `clocks` and `clock-names` from pwm_ef (background: [5])
 * change sound `model` to "XIAOMI-AQUAMAN"

More information is available on the postmarketOS wiki page [6].

[1]: https://lore.kernel.org/all/20250203174346.13737-1-funderscore@postmarketos.org/
[2]: https://lore.kernel.org/all/20250203091453.15751-1-funderscore@postmarketos.org/
[3]: https://lore.kernel.org/all/20250201193044.28856-1-funderscore@postmarketos.org/
[4]: https://lore.kernel.org/all/20250131200319.19996-1-funderscore@postmarketos.org/
[5]: https://lore.kernel.org/linux-amlogic/20241227212514.1376682-1-martin.blumenstingl@googlemail.com/


Ferass El Hafidi (2):
  dt-bindings: arm: amlogic: add S805Y and Mi TV Stick
  arm64: dts: amlogic: add support for xiaomi-aquaman/Mi TV Stick

 .../devicetree/bindings/arm/amlogic.yaml      |   7 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../meson-gxl-s805y-xiaomi-aquaman.dts        | 292 ++++++++++++++++++
 .../boot/dts/amlogic/meson-gxl-s805y.dtsi     |  10 +
 4 files changed, 310 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s805y-xiaomi-aquaman.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s805y.dtsi

-- 
2.47.1


