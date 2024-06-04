Return-Path: <linux-kernel+bounces-200173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E598FAC53
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BB3FB22AB2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD3A1411CF;
	Tue,  4 Jun 2024 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkpsAyIm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD18E140399;
	Tue,  4 Jun 2024 07:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717486963; cv=none; b=KHLvziMs2EnEU8yD1reYSuA/CCCFhLK2TVe7TveVqs13f9pjth5uCd5Eak9nuO6KiCnleIGXcy1HVYOzS1GhfXA3/1PciYcso05E7K7LEYPBE1n7n/O4HO7mIf9YxqnRhFR1kmJPwFaB0F1H/svGXwCxQt9Tyxj5v3pUqP5PSm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717486963; c=relaxed/simple;
	bh=SN5J7RI6JSHiLzdRYcIH1OJvtJI+2IfG/BlH4wBvC/A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gVyPXHFxIyQ+ytTvichNRDXue1smPUKfaUfcNxoJug4xM7V7PeDMQ9VMNyYhuN5JAvcX6URJwevyqHeL0j4E95Lo0w5DJCRtzt1cyqwT4OUW9zkviN5mASNVsi4YP22h8T1HUirk6NaKZacYzHZWpQht1KWxBp2UccxcIRIcrHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkpsAyIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990D2C32782;
	Tue,  4 Jun 2024 07:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717486963;
	bh=SN5J7RI6JSHiLzdRYcIH1OJvtJI+2IfG/BlH4wBvC/A=;
	h=From:To:Cc:Subject:Date:From;
	b=YkpsAyIm/8xj6wyJAerwgfsp6uB58wAiiiT8NaZhiv9RDKz8VXNXynIvY5lFjy1bB
	 WY8W/C+CpCvv9gEuOIlo+d8t6UvotWwk3sfnkZI5v0RX/lsiPkEwRW8JXstdyXmi2k
	 QZPpEZDqnmFivbuC7VV+Vu7nvIbNUQNBzF0Gvsw9822a4IRvAbOL9S0SVX5akr+QLl
	 QD5yi/IxD7HlFsPHez6oRuDHiARY+cafvsOfX+M9aIe0JEBQdhMxXYNKF8OeocjywJ
	 8Btpe6CzHj8cRwv6hmvPF9mmO6X73+RfLDfy4qff3S+MQKs36IClQNyCvsDqo85pvY
	 feoJcmFQfawCw==
From: Michael Walle <mwalle@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Thorsten Scherer <t.scherer@eckelmann.de>,
	Marek Vasut <marex@denx.de>,
	Imre Kaloz <kaloz@openwrt.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH] dt-bindings: mtd: spi-nor: deprecate Everspin MRAM devices
Date: Tue,  4 Jun 2024 09:42:31 +0200
Message-Id: <20240604074231.1874972-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

These devices are more like an AT25 compatible EEPROM instead of
flashes. Like an EEPROM the user doesn't need to explicitly erase the
memory, nor are there sectors or pages. Thus, instead of the SPI-NOR
(flash) driver, one should instead use the at25 EEPROM driver.

Signed-off-by: Michael Walle <mwalle@kernel.org>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Thorsten Scherer <t.scherer@eckelmann.de>
Cc: Marek Vasut <marex@denx.de>
Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Flavio Suligoi <f.suligoi@asem.it>
---
The referenced binding only supports the true AT25 compatible EEPROMs
where you have to specify additional properties like size and page size
or cypress FRAM devices where all the properties are discovered by the
driver. I don't have the actual hardware, therefore I can't work on a
proper driver and binding. But I really want to deprecate the use of
these EEPROM like devices in SPI-NOR. So as a first step, mark the
devices in the DT bindings as deprecated.

There are three in-tree users of this. I hope I've CCed all the relevant
people. With the switch to the at25 driver also comes a user-space
facing change: there is no more MTD device. Instead there is an "eeprom"
file in /sys now, just like for every other EEPROM.

Marek already expressed, that the sps1 dts can likely be removed
altogether. I'd like to hear from the other board DTS maintainers if
they seem some problems moving to the EEPROM interface - or maybe that
device isn't used at all anyway. So in the end, we can hopefully move
all the users over to the at25 driver.
---
 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index 6e3afb42926e..2dccb6b049ea 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -21,7 +21,6 @@ properties:
               (m25p(40|80|16|32|64|128)|\
               n25q(32b|064|128a11|128a13|256a|512a|164k)))|\
               atmel,at25df(321a|641|081a)|\
-              everspin,mr25h(10|40|128|256)|\
               (mxicy|macronix),mx25l(4005a|1606e|6405d|8005|12805d|25635e)|\
               (mxicy|macronix),mx25u(4033|4035)|\
               (spansion,)?s25fl(128s|256s1|512s|008k|064k|164k)|\
@@ -42,6 +41,14 @@ properties:
               - spansion,s25fs512s
           - const: jedec,spi-nor
       - const: jedec,spi-nor
+
+      # Deprecated bindings
+      - items:
+          - pattern: "^everspin,mr25h(10|40|128|256)$"
+          - const: jedec,spi-nor
+        description:
+          Deprecated binding, use Documentation/devicetree/bindings/eeprom/at25.yaml.
+        deprecated: true
     description:
       SPI NOR flashes compatible with the JEDEC SFDP standard or which may be
       identified with the READ ID opcode (0x9F) do not deserve a specific
-- 
2.39.2


