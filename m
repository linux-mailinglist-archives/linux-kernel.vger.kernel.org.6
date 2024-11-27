Return-Path: <linux-kernel+bounces-423261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D543F9DA529
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ACC7283F1E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2823419539F;
	Wed, 27 Nov 2024 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hv2HdCil"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695D318FC81;
	Wed, 27 Nov 2024 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732701176; cv=none; b=dyw0zChE6snKgjEgoR7fRmRBaDNXbywzw3OcvU3fKbd60OXnWNes8HEvkBUS+Zw+w6xz1prC1biuQmoSAD9QZ8mGxsKiiY5CCZjJc8hdXz4qq0k4KM9PJPoVycMfvPavodMy5/BPHSmgKjm7X3y6WVMi/QQXyGQO31oRSFqOXDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732701176; c=relaxed/simple;
	bh=AlyikN0YqHFLUKRJr7wvyyU0Pc9nGL/KGQvMwi2DpR8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kPqXJ6sQSXlKFnYZ72JgJ6GGZU5YgVGqYbUgtttFWjFajfrZa01CvfRVC/AgKhoB2yJyRfRyX+cdyWFdWT6xwJ2MSoGUYdJbLWtbvYziMdvdlPLFM6w0Q0rM8kiG/b+FuCEDu0XzKRqT3vrskN+UI/xx9MYFqDUDwd3BGSGOj4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hv2HdCil; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5ADEC4CED2;
	Wed, 27 Nov 2024 09:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732701176;
	bh=AlyikN0YqHFLUKRJr7wvyyU0Pc9nGL/KGQvMwi2DpR8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=hv2HdCilkMpUWYEU783nsyE69FxvGxLzg29TL/jAjEUUj3HV5SdcX0SQTMBfvYpGX
	 +Obp40IlsfRlFN8QAhTCI4XoiHLOhnwnsIaqZO+d0l1ZCv5lC9OqU4k+CjGGc4Z+9r
	 eXu5CjWm0tGL01ugSeyFRCpMJ1n5Gz5kRQrAlgI+UmMEQh0bwNalojj5m6lozCQ5sz
	 5VYlkgJEQvwVVzrBLR+yQa3YWehQrB9rebvynLwke0TwLaYSVN//jFpUWjkNdD2c4m
	 FfbeomSmHcKXsMHWMTL8S+H6liob07uIiYjo2NaKlAxSyhyk8xPWvXXlWh8kd22Z+n
	 cKTUEJlLAhiJg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9771D609C7;
	Wed, 27 Nov 2024 09:52:55 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Subject: [PATCH RESEND 0/5] Add Apple SPI controller and spi-nor dt nodes
Date: Wed, 27 Nov 2024 10:52:27 +0100
Message-Id: <20241127-asahi-spi-dt-v1-0-907c9447f623@jannau.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2640; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=AlyikN0YqHFLUKRJr7wvyyU0Pc9nGL/KGQvMwi2DpR8=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnS311+Xf7aYfyjSyzxHbGFn/4yrqeGzt6kzbc+d4D9h1
 48+Q4v9HaUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACaikcjIsGKT6ONE7uldsnP8
 dOeVS0zWTntgsj5G2ve0Mf8H7Vp1e4Z/BgdUN8RyPdA7+jW8uyb+6uUFGzml5170U6k0E4isYsl
 mAgA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/yk2024 with auth_id=264
X-Original-From: Janne Grunau <j@jannau.net>
Reply-To: j@jannau.net

This series adds SPI controller and SPI NOR flash device nodes to the
man Apple silicon SoC dts files. Only the subset of used SPI controllers
is added. Five SPI controllers exists according to pmgr ADT data but the
commits only add controllers found in use on any of the devices. The
parameters for the missing nodes are guessable but there's no point in
adding them since no further M1 or M2 devices are expected.
Together with controller nodes the first SPI device is added. All Apple
silicon devices connect a SPI NOR flash to spi1. This holds Apple's 1st
stage bootloader, firmwares, platform and machine specific config data
and a writeable key-value store (nvram). Expose only the nvram as mtd
partition since it has use beyond exploring the content. Tools from
asahi-nvram [1] can modify the (default) boot configuration
(asahi-bless), read Bluetooth sync keys (asahi-btsync) and read and
write arbitrary keys (asahi-nvram).

Devicetree bindings are included in the driver series. Last version at
https://lore.kernel.org/linux-devicetree/20241101-asahi-spi-v3-0-3b411c5fb8e5@jannau.net/

This series passes `make CHECK_DTBS=1 dtbs` with the spi bindings except
for "local-mac-address" for the Bluetooth device (I need get back to
this).

[1] https://github.com/WhatAmISupposedToPutHere/asahi-nvram/

Signed-off-by: Janne Grunau <j@jannau.net>
---
Hector Martin (1):
      arm64: dts: apple: t8103: Fix spi4 power domain sort order

Janne Grunau (4):
      arm64: dts: apple: t8103: Add spi controller nodes
      arm64: dts: apple: t8112: Add spi controller nodes
      arm64: dts: apple: t600x: Add spi controller nodes
      arm64: dts: apple: Add SPI NOR nvram partition to all devices

 arch/arm64/boot/dts/apple/spi1-nvram.dtsi      | 39 +++++++++++++++
 arch/arm64/boot/dts/apple/t600x-common.dtsi    |  7 +++
 arch/arm64/boot/dts/apple/t600x-die0.dtsi      | 28 +++++++++++
 arch/arm64/boot/dts/apple/t600x-gpio-pins.dtsi | 14 ++++++
 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi |  2 +
 arch/arm64/boot/dts/apple/t600x-j375.dtsi      |  2 +
 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi      |  2 +
 arch/arm64/boot/dts/apple/t8103-pmgr.dtsi      | 18 +++----
 arch/arm64/boot/dts/apple/t8103.dtsi           | 68 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8112-jxxx.dtsi      |  2 +
 arch/arm64/boot/dts/apple/t8112.dtsi           | 44 ++++++++++++++++-
 11 files changed, 216 insertions(+), 10 deletions(-)
---
base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
change-id: 20241101-asahi-spi-dt-58245bb1da3e

Best regards,
-- 
Janne Grunau <j@jannau.net>



