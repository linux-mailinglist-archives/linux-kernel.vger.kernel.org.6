Return-Path: <linux-kernel+bounces-238119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49C29243D2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC8A2875BD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6AA1BE234;
	Tue,  2 Jul 2024 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O7ACIInw"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DBF1BD50C;
	Tue,  2 Jul 2024 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719938669; cv=none; b=PqSKR7L81CAOi4NlCCO6Mm+qM/beW0+y0OqEJM+zZzJnNfoh49bmcE1aA3Hzdlqt4SIKrmUsHJL5o3WKpk/BmOLL75WcPOFlZcxflJDf3VPm6RhjNIfNUI1NdJwAeBNOQb4xzmO5Lh1hMIZLA8pYEvu7e8U+CAm7NOEmS/G5aHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719938669; c=relaxed/simple;
	bh=FLUSq1hIV63SE6OJNfvqA13Mb1SGXfL91XMsBLfw0ko=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mqDeaabUyN808fXmzDDQ2UYJffvQ6TZ+69LpjChNDu76Fs3w2j72AbOCACyD1mq9JZupb9MNhAXYQJUcf9KcCgBvHrIo8TFQU8FaOFTuc85EPCh8oQ0xcinUArFkHsvcyiIxiRkAtbis11kS9u92XU83N9aDCd3dp0o0Rhl0QNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=O7ACIInw; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 462Gi6jK041356;
	Tue, 2 Jul 2024 11:44:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719938646;
	bh=qQzeOA+K6eBl08tIYJflOHwd2vwIBpLVg0O3CYTulF0=;
	h=From:To:CC:Subject:Date;
	b=O7ACIInw38w9ntH28QJqqa3S6PCux4UM33YibRDA1Naoc+nm8oT0HWEiNHLAdATO4
	 1UFDeywJWYZr9TxMZ6m8NZWcnSn1GP+SvlZ8Foxvc5xkzb8N8eijTdG0q0dd1E4II5
	 LKYs3UFl0HpsTyWSdGWDlIKRqb5LQJEbKFdRU/x4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 462Gi5Dg030980
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Jul 2024 11:44:06 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Jul 2024 11:44:05 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Jul 2024 11:44:05 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 462Gi4YA112748;
	Tue, 2 Jul 2024 11:44:04 -0500
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vaishnav M A
	<vaishnav@beagleboard.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan
 Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Michael Walle
	<mwalle@kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson
	<robertcnelson@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Ayush Singh <ayush@beagleboard.org>,
        Ayush Singh <ayushdevel1325@gmail.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH RFC 0/3] Add generic Overlay for Grove Sunlight Sensor
Date: Tue, 2 Jul 2024 11:44:00 -0500
Message-ID: <20240702164403.29067-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello all,

A new attempt at solving the long standing "add-on board" problem was
recently posted[0]. The current out-of-tree solutions usually involve
Device Tree Overlays. Recently, Overlays have started being accepted into
the kernel repo, this makes now the perfect time to solve this issue.
Here is my attempt at a generic solution.

Problem statement
-----------------

The Device tree(DT) system provides hardware descriptions to the Linux
kernel (or other DT compatible SW). When the hardware is modular this
description becomes dynamic. For this we use DT Overlays which take a base
hardware description and append the description of the add-on hardware.
Due to the design of DT, these DT overlays are specific to a given base
hardware board. The add-on itself is usually not specific to a single
board. Some examples of add-on ecosystems to consider:

Beaglebone Cape
Raspberry Pi HAT
MikroBUS Click Boards
Seeed Grove
SparkFun Qwiic
etc..

Some of these ecosystems already have more than a thousand(!) add-on boards.
If a DT description needed to be written specific to each of the multitude
of base boards that support each add-on, the combinatorial explosion would
be unmanageable. We need to define a scheme that allow for creating and
applying generic add-on overlays.

Goals
-----

* Each add-on board should be described by only one DT overlay. That DT
overlay should be generic enough to apply to the DT of any base board
that supports that add-on.

* Some base boards have multiple instances of a given add-ons connector
port. An add-on's overlay must apply to any available connection port
without modification to the overlay.

* Some connectors are stackable, stacked application of overlays shall
function as expected. Chained connectors from one ecosystem to another
shall be supported also (i.g. This thing[1] which connects to a BeagleBone
Cape connector and then exposes a number of Grove connectors).

* We should reuse as much existing infrastructure as possible (ideally no
changes should be needed). The basic application of DT overlays is well
supported and documented.

* An overlay for an add-on board that is not compatible with the base board
shall fail to apply at application time, not silently later. Incompatibility
includes add-ons which require a function from a pin for which the matching
pin on the base board cannot provide. We see this with some HATs and Capes
where they use non-standard muxing of pins that only work for some subset
of base boards. For instance, the BeaglePlay's Grove connector supports
Digital/UART/I2C functions but not "Analog". So any Grove module that uses
Analog pins should fail to apply.

* Nothing in this solution should preclude runtime application of these DT
overlays. Hardware auto-detection and runtime DT modification are orthogonal
problems. 

Solution
--------

This is a classic many-to-many problem, we propose to solve this the
same as the database folks, with an associative(join) table like adapter
overlay. We add an adapter overlay in-between the base board and the add-on. This
adapter overlay prepares the base DTB for the application of an add-on
targeting a specific connector. Adapting the base board's specifics to accept
the generic connector names contained in the add-on overlay. There will
be one adapter overlay per base board connector.

We already have the infrastructure to implement these adapter overlays
today. The DT overlay system makes use of a symbol table in the
base DT and a fixup table in the overlay. The magic is in using the
__fixups__ table to modify the __symbols__ table itself.

Let's use the Grove connector[2] as an example. Grove is a good example
target as it has

 * Low pin count (2 signal pins keeps the example gasket DTBOs simple, everything here can be extended to any number of signal pins)
 * Multiple connectors per base board
 * Has an add-on board that exposes more add-on board connectors
 * Each pin can have multiple functions depending on the base board
 * Moderately sized collection of add-on boards which contain parts already supported in Linux/DT

To make an overlay generic we need a standard name scheme which we
use across base boards. For the connector pins the pinmux phandle
shall be:

<connector-name>_<pin-name>_mux_<pin-function>

All capitalized to make it easy to identify that this name is
not the final phandle name, but will instead be fixed during
overlay application.

Each pin will have a definition for each function it can take,
so pin1 in the Grove ecosystem has 4 possible functions, and
pin2 has the same, therefor 8 definitions are needed in the
connector's adapter overlay:

 /* Grove connector 0 Pin1 options */
GROVE_PIN1_MUX_I2C_SCL = &grove_pins_i2c;
GROVE_PIN1_MUX_DIGITAL = &grove_pins_digital;
/* GROVE_PIN1_MUX_ANALOG not available on this pin on this connector on this board */
...
GROVE_PIN2_MUX_UART_TX = &grove_pins_uart;
etc..

(see patch [2/3] for a complete example)

By listing each pin/function combination separately we allow for add-on
boards that only use a subset of pins, or mix pin functions
(pin1->digital and pin2->uart_tx).

This also means is if a given base board does not support some function
on a connector pin, then it is not defined and application of an overlay
which uses that pin/function will correctly fail as expected.

For the parent provider phandle, we use a similar naming scheme:

<connector-name>_<pin-name>_<pin-function>

Note we list this per-pin. Even though one IP/bus may service multiple
pins, we cannot know this in a generic way. For instance some boards
may have all GPIO functions served by one controller, others may have
some pins on different controllers.

Patch [3/3] is a complete example overlay for an add-on board[3].

So what does this all look like? Let's take an example of a BeaglePlay
with two Grove connectors for which we have physically attached a
Sunlight module to the first connector, and an Air Quality sensor to
the second. Doing ahead of time command-line DT overlay application:

./fdtoverlay \
	-o output.dtb \
	-i k3-am625-beagleplay.dtb
		k3-am625-beagleplay-grove-connector0.dtbo grove-sunlight-sensor.dtbo \
		k3-am625-beagleplay-grove-connector1.dtbo grove-air-quality.dtbo

We start with the base board, then apply the adapter overlay for the
specific connector we are going to attach the add-on. The next add-on
overlay applied will attach to the connector most recently applied.
This can be continued as needed, simply apply the next connector's
adapter overlay, then the next add-on, rinse, repeat. 

Note that the connector adapter overlay is board specific, but the add-on
overlay is completely generic. It can be applied to any base board.

./fdtoverlay \
	-o output.dtb \
	-i bcm2837-rpi-3-b.dtb \
		grove-base-hat.dtbo \
			grove-base-hat-connector0.dtbo grove-sunlight-sensor.dtbo \
			grove-base-hat-connector1.dtbo grove-air-quality.dtbo

Should work just the same for any board supporting that extender HAT,
for instance the BeagleY-AI would be:

./fdtoverlay \
	-o output.dtb \
	-i k3-am67a-beagley-ai.dtb \
		grove-base-hat.dtbo \
			grove-base-hat-connector0.dtbo grove-sunlight-sensor.dtbo \
			grove-base-hat-connector1.dtbo grove-air-quality.dtbo \
			grove-base-hat-connector4.dtbo etc..

All of the above works just the same at boot time (U-Boot overlay support)
or runtime using the in-kernel runtime overlay support (when that is enabled).
For connectors with board detection I'd expect the detector to be described
in the base board connector node. On board identification, the adapter overlay
for that connector would be loaded by the detector driver followed by th
overlay for the identified board.

Although this is an RFC, the patches in this series are functional and
meet all the above goals. They require no additional DT schema nor
kernel/tooling modifications. Nested adapters (add-ons on top of add-on
connectors) require a small fix in DTC which will be sent separately.

Open items
----------

Variable cell count providers. The provider specifies the cell count
and meaning. For GPIO this is handled very well, there is a standard
2 cell format (GPIO number and flags). Any device can request a
controllers' 4th GPIO with active high output the exact same way for
all controllers. Interrupts on the other hand have providers with one,
two, and even three cells variations. There is no universal way to say
"I want this controller's 4th IRQ line with rising edge triggering".
These cells may need some level of indirection in the connector node
itself to handle variable cell counts/meanings.

Where to store the add-on overlay source files. These are not specific
to any one board, nor even to one architecture. For now I put the
grove-sunlight-sensor.dtb in arch/arm64/boot/dts/ti but it needs a
better home acceptable by all boards.

More testing, I currently have very few add-on boards to test with right
now (but I did just put some on order). Hopefully I can get some more
complex ones to really exercise this idea. Maybe a stack like the one
in the 4th image here[4], a RPi HAT that exposes a couple MikroBUS
connectors, that then have 4 Grove ports on that.

This isn't perfect, but the Goals section should be applicable to any
solution, and the adapter overlay concept hopefully can be reused as
needed for whatever solution the community chooses.

Thanks,
Andrew

[0] https://lore.kernel.org/linux-arm-kernel/20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org/
[1] https://wiki.seeedstudio.com/Grove_Base_Cape_for_BeagleBone_v2/
[2] https://wiki.seeedstudio.com/Grove_System/
[3] https://wiki.seeedstudio.com/Grove-Sunlight_Sensor/
[4] https://www.tindie.com/products/pmunts/mikrobus-grove-adapter-3/

Andrew Davis (3):
  arm64: dts: ti: k3-am625-beagleplay: Add Grove connector pinmux
    options
  arm64: dts: ti: k3-am625-beagleplay: Add Grove connector adapter
    overlays
  arm64: dts: ti: grove: Add Grove Sunlight Sensor overlay

 arch/arm64/boot/dts/ti/Makefile               |  5 +++
 .../boot/dts/ti/grove-sunlight-sensor.dtso    | 31 ++++++++++++++
 .../k3-am625-beagleplay-grove-connector0.dtso | 41 +++++++++++++++++++
 .../k3-am625-beagleplay-grove-connector1.dtso | 22 ++++++++++
 .../arm64/boot/dts/ti/k3-am625-beagleplay.dts | 32 +++++++++++----
 5 files changed, 124 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/grove-sunlight-sensor.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-beagleplay-grove-connector0.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-beagleplay-grove-connector1.dtso

-- 
2.39.2


