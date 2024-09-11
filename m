Return-Path: <linux-kernel+bounces-325122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B03F975540
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA3B1F25DEC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E5119F111;
	Wed, 11 Sep 2024 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="Qiq1bK0b"
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6994E19C549
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726064867; cv=none; b=Cq9evBsyC3VJlDjBwQZ3y9K1UxOJ/ge0DOnjG8sYmOshjDHHqXkJFbsGWzU/j00bVoyOAxOIJiStcQTGDzdtESN9+JbH3pxq31es6WAg/b1iPW6l5Y1pzn+5F57sOOhA+v1gdMf26ApBubyVqisQtHwINYobwR43Q1hGd/d7HxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726064867; c=relaxed/simple;
	bh=XuUJVYFaL7KrJnI1SIfCWtxVEkhCeaGGZWCG4EnXi4A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FyFcqbN83VKZxMmql8Nu78L0wbGxwT1uGcYGuilWFOY/RdEjzGDp+S3NruoEmn4UBRqAT81z0TnSztL5c8TfCibOdRQkJuxfYCI1P7HKUjEOy1Ra79mvrvPV+BKLnj7mrYdyEI6FALB9JMOHVYG8UIGrGGitysseCVuLTtukIcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=Qiq1bK0b; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2d86f713557so4464032a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1726064865; x=1726669665; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6/WzskX9Go8nWXOifWB23WvB1MNJZrDHBqH1eKR21ek=;
        b=Qiq1bK0bDw7yRWMBATssev1875nXEK1cn7lRTB/nOS+9NGbgjO+cLpruQojQhI9kRQ
         1NQILmNHyeKOG/KHHlC+IvBTox9d/x+h/3Rsh1GnXgBeACLdFc/8C07t4QbwcgRLCYdD
         ApWT2oI2gX8YCYg3HnpQ0TNA4tNDEsZfk3W3tGCdqlhA90Ianem3A1vVdSllDCxzQgzs
         oSQH/YogwLo4zGcrpSC6tMHIXW1FQ5jDKGFV+jfGRex3JBGYhm/r/MsaVczpCtVc3FLH
         E07II4A+rXrnVZ5YSZdVALS4Nf44mWFUDMtHs8Myman3sn6N/WJHxNQTXSTzay/uijGC
         dYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726064865; x=1726669665;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/WzskX9Go8nWXOifWB23WvB1MNJZrDHBqH1eKR21ek=;
        b=r3claLou72Fx1pKvvheYCpqGtniYxtInh23hrUCzD8H0byEJbQ+5Rkdvh8Fjfu/G7q
         7Yxe9LvTBsgxc0IHy1HdTzaVn9UAi9u0+uQ+BQP+Q2eRTtORGfdn5pwnyu3yz3ntFnCX
         cTWQ/JKENtIOJHd8LZG03ujzQiTv0/8TihTlAUA4vlM1K6ZA2p9lkhILY1VnZ4/vjdA/
         IK1VlYzOwt8LhpewNSrm9DBmv8xRPl9yKW6X29ycQG5GXnycOAHrzx2YofacxCiNzM37
         vD75q6ryP8u29LPHzK5hi/FzJin7IZaJ14IZXHspgIx/X8Xde7IbkefswwdOzeYov3Pm
         emXA==
X-Gm-Message-State: AOJu0Yw9Zf9JRAvRH5HTis70GKh+XdF2PzXuynO+kZJpmglguiVS5Wm+
	elR8PWbvqSemYEcpW51NCK78fCyOS/nP3n70MW1jrvnJyo/TRdtLeIJ3KY/QVA==
X-Google-Smtp-Source: AGHT+IE5BKt2yDajA1Yc3kmCBvgh9rPRVNNylDSz69umvGgfJdK38l9Sjwoe7Yv6xKP5opGpv/aOBg==
X-Received: by 2002:a17:90a:510b:b0:2c9:a3ca:cc98 with SMTP id 98e67ed59e1d1-2dad4de137fmr20670675a91.7.1726064864449;
        Wed, 11 Sep 2024 07:27:44 -0700 (PDT)
Received: from [172.16.118.100] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadbfe46c9sm10639116a91.11.2024.09.11.07.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:27:44 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Subject: [PATCH 0/8] Add generic overlay for MikroBUS addon boards
Date: Wed, 11 Sep 2024 19:57:17 +0530
Message-Id: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMao4WYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCyMz3dzM7KL8pNJi3ZQSXVOj1MTExJQUgyTDNCWgjoKi1LTMCrBp0bG
 1tQDBRQBAXQAAAA==
To: fabien.parent@linaro.org, d-gole@ti.com, lorforlinux@beagleboard.org, 
 jkridner@beagleboard.org, robertcnelson@beagleboard.org, 
 Andrew Davis <afd@ti.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>, 
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ayush Singh <ayush@beagleboard.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7197; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=XuUJVYFaL7KrJnI1SIfCWtxVEkhCeaGGZWCG4EnXi4A=;
 b=owEBbQKS/ZANAwAIAQXO9ceJ5Vp0AcsmYgBm4ajUEQDU7T96PVlwx8Pj9jyhhfKN/Ay4+kwOx
 MNUs9SoSX6JAjMEAAEIAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCZuGo1AAKCRAFzvXHieVa
 dGsvD/0UlJ0UfQxA8ZCx5fm8/039nBk+VNJ0fh5bOpLVq06oTO3kr8fvZrJ7tDdBJ8LmS3QPaPx
 Pq3SIY+GZ2p2cYzDBPff8hxhyDzcsxtF2LGCIKG+XrLx1YXcyrqn3GnOxulXVhcH+XVKf6O9rcK
 xYoLUiGCelS528QMcxL2BH6seKuNj7XrYy+g0jze6k1MtfnmaJ1nOq08cw6M+7M6EDkRzE9QHdI
 5Qa1eH3iStuTxyxhbwFkPrqQZ9E98+rs/Pkkk6jch0Ao5Yf/CVBJbN8Aeksazsy908tJf2wEmjy
 aXRHp3IPKlIosFRFlU6rEOSQxN3jgsLVWE0RDCEyxVTLVrE1XqNypdZ9HPQCmP7j9BGALFRofJf
 EbXdRg/PwBhVqrnTpIfgrE5/Wpo7sz/CJpga/axW93WZvbRRLCCw1cbHIaq4WaRH0yUziQkrrhP
 Aco4o1OaGdc/jVgBYurwGrTj9RTJI6nyHK0vDDoLkoqTD3+XDtSWpK6WqucuzDzC93iaUDVA7St
 +fuyckAO4skO+HQ1uzj2110MSNfM6X9i2/P+oEFZCxZOe0mjT/PbbCpbQQA75bt5vp90r2OktuG
 W4X1Bl15iCoMnvxBDIdKw5BMcmIzw2C4lhiSvxBbyhxsGRM0idCVzIEdNcRDl1RGN1D8fBQjxpz
 7wydyANLwKvev6Q==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

Hello all,

This is an attempt to add MikroBUS addon support using the approach
described by Grove connector patch series [0].

The patch series tests out 2 addon boards + pwm and GPIO on the MikroBUS
connector. The boards used are GPS3 Click (for UART) [1] and Weather
Click (for I2C) [2]. Additionally, I have tested relative GPIO numbering
using devicetree nexus nodes [3].

The patch series does not attempt to do any dynamic discovery for 1-wire
eeprom MikroBUS addon boards, nor does it provide any sysfs entry for
board addition/removal. The connector driver might include them after
the basic support is ironed out, but the existing patches for dynamic
overlays work fine.

The patch series has been tested on BeaglePlay [4].

I will now go over individual parts of the patch series, but for a
better picture of the approach, it would be best to checkout [0] first.

MikroBUS connector driver
-------------------------

Just a stub platform driver for now. Will be extended in the future for
dynamic board discovery using 1-wire eeprom present in some MikroBUS
addon boards.

While it is a stub driver, disabling it will make the GPIO connector
nexus node unreachable (any driver attempting to use it will enter
differed probing). So it is required.

MikroBUS connector Devicetree
------------------------------

The connector devicetree defines the MikroBUS GPIO nexus node. This
allows using pin numbering relative to MikroBUS connector pins in the
addon boards overlay. Currently, the patch uses a clockwise numbering:

  0: PWM
  1: INT
  2: RX
  3: TX
  4: SCL
  5: SDA
  6: MOSI
  7: MISO
  8: SCK
  9: CS
  10: RST
  11: AN

Additionally, in case PWM pin is not using channel 0, a nexus node for pwm
should also be used and go in the connector devicetree.

MikroBUS connector symbols overlay
----------------------------------

To make an overlay generic we need a standard name scheme which we
use across base boards. For the connector pins the pinmux phandle
shall be:

<connector-name>_<pin-name>_mux_<pin-function>

For the parent provider phandle, we use a similar naming scheme:

<connector-name>_<pin-name>_<pin-function>

For GPIO controller, I am using `MIKROBUS_GPIO` name since with nexus
nodes, we do not need to define individual pin gpio controllers.

The string symbols can be replaced with phandles once [5] is accepted.
That will make connector stacking much simpler.

MikroBUS addon board overlay
----------------------------

The patch puts the addon board overlays in their own directory. I am
using the following naming scheme for MikroBUS addon boards:

<vendor>-<product_id>.dtso

Mikroe [6] lists this for all boards in their website, but I am not sure
if other vendors have a product_id.

This naming also makes future dynamic discovery easier, since click id
spec [7] contains vendor_id and product_id in the header.

Usage
-----

So what does this all look like? Let's take an example of a BeaglePlay
with one MikroBUS connectors for which we have physically attached a
Wather click module to the first connector. Doing ahead of time
command-line DT overlay application:

./fdtoverlay \
	-o output.dtb \
	-i k3-am625-beagleplay.dtb \
		k3-am625-beagleplay-mikrobus-connector0.dtbo mikroe-5761.dtbo

Open Items
----------

- SPI Support: 
  Currently SPI dt requires `reg` property to specify the
  chipselect to use. This, makes the SPI device overlay dependent on the
  SPI controller. Thus for SPI support, we need a way to allow defining
  SPI chipselect relative to MikroBUS pins, and not the actual device
  controller.

  One possible solution is to introduce something like `named-reg` and
  allow selecting the chipselect by string array. But this probably
  requires more discussion so I have left out SPI support for now.

  NOTE: pins other than the CS MikroBUS pin can be used as chipselect.
  See [8].

- Controller symbol duplication
  The current symbol scheme has multiple symbols for the same underlying
  controller (Eg: MIKROBUS_SCL_MUX_I2C_SCL and MIKROBUS_SDA_MUX_I2C_SDA)
  point to the same i2c controller.

  I think both of them will always use the same i2c controller, but
  maybe there are some exceptions? So I have left it as it is for this
  patch series. The same thing also applies to UART and SPI.

  NOTE: with the use of nexus node for GPIO, the GPIO controller symbol
  will be the same for all pins.

- Nexus node dt-bindings
  I am not quite sure how to deal with the nexus node properties
  (#gpio-cells, gpio-map, gpio-map-mask, gpio-map-pass-thru) since they
  seem to conflict with upstream gpio schema (gpio-controller is a
  dependency of #gpio-cells).

[0]: https://lore.kernel.org/linux-arm-kernel/20240702164403.29067-1-afd@ti.com/
[1]: https://www.mikroe.com/gps-3-click
[2]: https://www.mikroe.com/weather-click
[3]: https://devicetree-specification.readthedocs.io/en/v0.3/devicetree-basics.html#nexus-nodes-and-specifier-mapping
[4]: https://www.beagleboard.org/boards/beagleplay
[5]: https://lore.kernel.org/r/20240902-symbol-phandle-v1-0-683efb2a944b@beagleboard.org
[6]: https://www.mikroe.com/
[7]: https://github.com/MikroElektronika/click_id
[8]: https://www.mikroe.com/spi-extend-click

Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
Ayush Singh (7):
      dt-bindings: connector: Add MikorBUS connector
      mikrobus: Add mikrobus driver
      dts: ti: k3-am625-beagleplay: Enable mikroBUS connector
      dts: ti: beagleplay: Add mikrobus connector symbols
      addon_boards: Add addon_boards plumbing
      addon_boards: mikrobus: Add Weather Click
      addon_boards: mikrobus: Add GPS3 Click

Fabien Parent (1):
      rust: kernel: Add Platform device and driver abstractions

 .../bindings/connector/mikrobus-connector.yaml     |  40 +++
 Kbuild                                             |   1 +
 Kconfig                                            |   2 +
 MAINTAINERS                                        |   8 +
 addon_boards/Kconfig                               |  16 +
 addon_boards/Makefile                              |   3 +
 addon_boards/mikrobus/Makefile                     |   4 +
 addon_boards/mikrobus/mikroe-1714.dtso             |  28 ++
 addon_boards/mikrobus/mikroe-5761-i2c.dtso         |  28 ++
 arch/arm64/boot/dts/ti/Makefile                    |   1 +
 .../k3-am625-beagleplay-mikrobus-connector0.dtso   |  49 +++
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts     |  53 ++-
 drivers/misc/Kconfig                               |  17 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/mikrobus.rs                           |  32 ++
 rust/bindings/bindings_helper.h                    |   1 +
 rust/kernel/lib.rs                                 |   1 +
 rust/kernel/platform.rs                            | 380 +++++++++++++++++++++
 18 files changed, 659 insertions(+), 6 deletions(-)
---
base-commit: 9aaeb87ce1e966169a57f53a02ba05b30880ffb8
change-id: 20240826-mikrobus-dt-52eaaadd0b1f

Best regards,
-- 
Ayush Singh <ayush@beagleboard.org>


