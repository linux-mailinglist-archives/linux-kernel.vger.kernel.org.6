Return-Path: <linux-kernel+bounces-269806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFF594370A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32ECB1C21973
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A516C1662E4;
	Wed, 31 Jul 2024 20:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Uthw2ChL"
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A77B182D8
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 20:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722457135; cv=none; b=jPcMMx7MkbNCOreD7lCWlAL0DL6f4/Odmij+v4ScOUtDrGKl7/HyakfkM97IBKXClLmsvGSpdr0kdxbPXssVIv+jX0U2R8RRKRcNppx6+f/oZP/NTyjy7DZDEPm99tcP6npIvHyTzzS10AmaZ+KtS6IcCzsq02Yus2ufhxhOST0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722457135; c=relaxed/simple;
	bh=hJTw+GiUOoZVXYBY2SqKLbU3okLjyk+qiCKhn/Gu0xE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GL8QK8dA8bL/woIg8Ct6fqRXw3ddrLbyo24rW9uUejP4bUIFQWmsVAmvnG3v5Vo+byLNAP5sglR2Qr2tORqnRUM80sEVn2JJklT/fqh9lllTkX2wX5aXmoZtIMfRSOOmFO5VIyNAek3k8awKBEueY/nvOsRelli8U1ugqY0dE6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Uthw2ChL; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202407312018431f01ca28bbb590e0c3
        for <linux-kernel@vger.kernel.org>;
        Wed, 31 Jul 2024 22:18:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=K3tmAYtJFHQxY5Qv/OUlau8tmffz0uL7OeNMBjM/53c=;
 b=Uthw2ChLh6B6H9OCSMfUcqx0SSLb85YAR4qUN3Un1UYTseoTkiS4sfVAy7eiLibnxSLp5n
 tHwhxfc+ueSKtboIwxwXOuLfMm7CLslHWlnZS4fRg3u4pZR8QQnRbW+TeksGly88MpdACENG
 YVdtpYmS/G/1u8OI1pUf/dhvpzlSI77cSqn+PBNH3Iy4v2GSDSpB2GqAgiop78P0IPdGtkqh
 0euVB5h9r/6Lc9m9iQtw1MJiRyzzrvVcbz7vDeLUxHfv/bKizsrs4F5zYcGHrbUKciDPY9QU
 JVk/W7aCxTyNPW71XT+LbSe+SyOkFoDhXOn+Gc2kSidfjczxIfyfTHjA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Minda Chen <minda.chen@starfivetech.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 0/3] riscv: jh7110: Fix configuration for on-chip USB 2.0 support
Date: Wed, 31 Jul 2024 22:18:40 +0200
Message-ID: <cover.1722457123.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

While mainline has support for the USB controller of the JH7110 since 6.5,
this never really worked, even not with latest downstream kernels by Starfive -
unless you were also using an old downstream U-Boot version. The reason for
that was a missing syscon setting that prevented the connection between USB
2.0 PHY and the controller. This series finally fixes the issue.

Jan

CC: Conor Dooley <conor+dt@kernel.org>
CC: Emil Renner Berthing <kernel@esmil.dk>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Rob Herring <robh@kernel.org>

Jan Kiszka (3):
  dt-bindings: phy: jh7110-usb-phy: Add sys-syscon property
  riscv: dts: starfive: jh7110: Add sys-syscon property to usbphy0
  phy: starfive: jh7110-usb: Fix link configuration to controller

 .../bindings/phy/starfive,jh7110-usb-phy.yaml | 11 ++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  1 +
 drivers/phy/starfive/phy-jh7110-usb.c         | 20 +++++++++++++++++++
 3 files changed, 32 insertions(+)

-- 
2.43.0


