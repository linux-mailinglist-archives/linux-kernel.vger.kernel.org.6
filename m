Return-Path: <linux-kernel+bounces-176195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CCA8C2B89
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0671C22628
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC1013B59A;
	Fri, 10 May 2024 21:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="FhcenxIo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wk/T96gk"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F231910965
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 21:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715375410; cv=none; b=M5rjSFwxvfTrv/gIa+nFtFqdQXaKhOH5r6gcf4EirA3uRO9E/+6ykQKZ44l1rbz2YtoilDkGXeRi3DPlZhRJf7DcgOsfTjvLY8NgvBk456yOyl3V3O5LhbeOGwmOaqI+dojJ/oX5zn7Dh6wXPa7Y61EEvvyMPaLq6PFpPUwAM38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715375410; c=relaxed/simple;
	bh=Dh6AnZdSSPBb1iLqNAXse+tTR93JOCTsymGGYe9GFVI=;
	h=MIME-Version:Message-Id:Date:From:To:Cc:Subject:Content-Type; b=imiP+wY1kOakBoAV6kOPkSXO8eiTl649AjrOcrDQo1sPDIYvilzXNGMdS5lrY9np2LoSiGVZpXkOvh0+x3mZ0Samh948yEbk7xwCAu5BLX2zANZHxrKcHga27b+O1hK2zVNEfTjF1UpmjW3/9m26fg2rYZW8gXG6j3NVOz3uipM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=FhcenxIo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wk/T96gk; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CBB51114014A;
	Fri, 10 May 2024 17:10:06 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 10 May 2024 17:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1715375406; x=1715461806; bh=Qp
	0d37EeYSDGa8u2dFFm0dTX4imjRuYf1YYBDTaOs6o=; b=FhcenxIof2DD6UpUqu
	jCphudh7MnIwzvCQ/sDF7WAZume5FH9kZqpqQIEhxe+6t0M2JLNEyACjiCf4aVI1
	WvsuPYYidWyG2dHQwHkPfIPqAFUbUUMIp+Z0b4xid11n+zkcbHDDGWtK52UhRKsR
	TMhVo3HqNLIED3k/HXp3urw9ZXzVDJLD0Pm0Bp870eMutv5SstzCGO7R2yU17Ts9
	Ej0xoq+XFdUjkUfeCAChBUuaMMM+SVh/5ov/hjS36647SkdLeyp/qsvIHkRD9OIO
	PpLmvBi0be12l5XTZnrpRgyvSsL954pOcicTf17eeyW5yGzbDa4+A2ySJmh8JVD1
	/Rhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1715375406; x=1715461806; bh=Qp0d37EeYSDGa
	8u2dFFm0dTX4imjRuYf1YYBDTaOs6o=; b=Wk/T96gkfAnF29raJPb6hDrJVsK61
	+3qGa+YSTJUEAyNpIeZ2TGS9ayjJ7AjV0f47dA2KgcWJtJTbvQpVtnK4KFB0hruV
	11MGBgpnDSz/UJq8ys3/zMFTfuFebw3UQSEfP5vwrW6hhAzpfM3CBpxqdtfHEfy1
	7EXlj844ebUlV6SmcpvYLztKzSKWjKRgkescVxVD7c3FBOdUZ3T6I+9eB6uCwMaJ
	a6YsCJi0hmxWbePEdoJMkUtMOjPTIXmHKvYJIsrYpEAJqk9ufB0x3LEHuFismTQP
	IEpVQWTveJT3GF/ymf9Aa4BkO9Wo3X9YpHSpW/QoCzIIElUxcflJfgazA==
X-ME-Sender: <xms:Lo0-ZhZGnkGBQWM8bLdyNSVHyKW5j9dliSBY06CwGJIlkYzHb0EIdA>
    <xme:Lo0-Zoa3mRsy-sLMdSGpARWmGBj9Dm4bxHt2pV1FA7NfoNrDnvHLDBg71HCjLRhku
    QIm7gpzj42kP1TCTxc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepfeehleefteehledvieeifeeftefhkedvheehudelteevieekhefhgefhveek
    ffeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Lo0-Zj_gPTY7oQRO2t3_Nl-4flAa-EH13nXhqGX8DRfY_ofpRfRDWQ>
    <xmx:Lo0-ZvqAyFAEC5uR-wAnw1x_n00zvLCIQgf4xhRzmedSNBSTiymyfg>
    <xmx:Lo0-ZspK-3fwFbm19iUH1ORUkkMYSfQ4kpcFXO2N4br0qlIxYkHhgg>
    <xmx:Lo0-ZlTwTnqqfWhA1kB_NvUGhrGUoCX5j-qo3BeES4dZonO5QyQTXg>
    <xmx:Lo0-ZnWMPZlbf54zJ6PzsmUP9qGGazEQOnoyzvL_GRuW4KALmokfT94T>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 644CDB6008D; Fri, 10 May 2024 17:10:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-443-g0dc955c2a-fm-20240507.001-g0dc955c2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fa20b5a4-a131-49b4-9597-15886435a288@app.fastmail.com>
Date: Fri, 10 May 2024 23:09:45 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 0/4] arm soc changes for 6.10
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

This release is rather uneventful for the soc tree, with very
little notable changes, and a smaller than usual total number
of changes. There are five branches in total, but I'm sending
only the first four today, as some of the devicetree changes
came rather late.

One notable addition is the ST "firewall" bus driver that
was under work for a while, and a larger than usual number
of changes to the various firmware drivers.

With all five branches, there are 821 non-merge changesets
from 192 developers, notably these authors with 10 or more
patches:

     88 Krzysztof Kozlowski
     52 Uwe Kleine-K=C3=B6nig
     20 Manivannan Sadhasivam
     19 Dmitry Baryshkov
     17 Tony Lindgren
     17 Luca Weiss
     17 Andrew Davis
     14 Peter Yin
     14 Peng Fan
     13 Geert Uytterhoeven
     12 Neil Armstrong
     12 Konrad Dybcio
     11 Yang Chen
     11 Tudor Ambarus
     11 Gatien Chevallier
     11 Bjorn Andersson
     10 Sebastian Reichel
     10 Muhammed Efe Cetin
     10 Frank Li
     10 Fabio Estevam
     10 Abel Vesa

Dirstat
   0.3% Documentation/devicetree/bindings/access-controllers/
   0.4% Documentation/devicetree/bindings/arm/
   0.5% Documentation/devicetree/bindings/bus/
   0.2% Documentation/devicetree/bindings/soc/
   0.6% Documentation/devicetree/bindings/
   0.3% Documentation/tee/
   0.8% arch/arm/boot/dts/allwinner/
   9.7% arch/arm/boot/dts/aspeed/
   0.9% arch/arm/boot/dts/broadcom/
   3.7% arch/arm/boot/dts/nxp/imx/
   6.4% arch/arm/boot/dts/qcom/
   2.0% arch/arm/boot/dts/renesas/
  10.0% arch/arm/boot/dts/st/
   0.9% arch/arm/boot/dts/ti/omap/
   0.2% arch/arm/boot/dts/
   0.4% arch/arm/mach-orion5x/
   1.4% arch/arm64/boot/dts/allwinner/
   2.2% arch/arm64/boot/dts/amlogic/
   3.1% arch/arm64/boot/dts/exynos/google/
   8.1% arch/arm64/boot/dts/freescale/
   0.5% arch/arm64/boot/dts/hisilicon/
   0.3% arch/arm64/boot/dts/marvell/
   0.2% arch/arm64/boot/dts/microchip/
   6.6% arch/arm64/boot/dts/qcom/
   2.2% arch/arm64/boot/dts/renesas/
  12.8% arch/arm64/boot/dts/rockchip/
   0.2% arch/arm64/boot/dts/sprd/
   1.4% arch/arm64/boot/dts/st/
   2.1% arch/arm64/boot/dts/ti/
   0.6% arch/arm64/boot/dts/
   0.2% arch/riscv/boot/dts/renesas/
   0.4% arch/riscv/boot/dts/sophgo/
   2.4% arch/riscv/boot/dts/starfive/
   0.2% arch/
   2.7% drivers/bus/
   0.5% drivers/firmware/arm_ffa/
   3.2% drivers/firmware/arm_scmi/
   0.2% drivers/firmware/qcom/
   1.5% drivers/pinctrl/
   0.7% drivers/soc/mediatek/
   0.3% drivers/soc/qcom/
   0.3% drivers/tee/optee/
   1.4% drivers/tee/tstee/
   0.3% drivers/tee/
   0.3% drivers/
   0.5% include/dt-bindings/clock/
   0.5% include/linux/bus/
   0.5% include/linux/soc/mediatek/
   2.2% include/linux/

