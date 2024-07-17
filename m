Return-Path: <linux-kernel+bounces-254977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4CD933A15
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D3B283740
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E5C42040;
	Wed, 17 Jul 2024 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNhZvrWm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7363032A;
	Wed, 17 Jul 2024 09:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721209085; cv=none; b=LTMoT8z9B8OL8HrdoMhMbgm/zAFPfTwrpH7I6AB9zTwq3jlgY32YexZ1fwvMrHs9AujIlJUp+KtPCe2JGvKTWF1uztbyNJd2Suj8VxW8gZ+qQmmdXp2OHhaet3y5Fu/0WU2NTujgANk2brUB/zB9bG9yeMzN8xtxM3B2kr82bM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721209085; c=relaxed/simple;
	bh=KwABkoRC4NHxGqyD41TdUDeSlwt8lkJ5FHVYu3NQ0Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=upMdnoIkfp2fYB4DpbGbc9ITLQMsrNjFN7aTQbjvqg+BoZTIdGzdHzbGnB0gZahvgcEkNsTTGCIIMbvRvpV13LB3myXLQSDpx6zlk/Uk5lw6MYLGt9jTh29MvukEpj8a2gzpnLFFjW2hIWmIO3kxNYfWVDDFohZWI5V8Uuk/ejo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNhZvrWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4EDC32782;
	Wed, 17 Jul 2024 09:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721209085;
	bh=KwABkoRC4NHxGqyD41TdUDeSlwt8lkJ5FHVYu3NQ0Qk=;
	h=From:To:Cc:Subject:Date:From;
	b=tNhZvrWml/ON035dM1pgyvB/gEMyfQmpAtG8uhSyjPWsI4iwVCW5NHaTKv8BZtaIC
	 3LvXWCiJloC7416UYOkb+bDbQFyn7DNKreuORtOfs3nhETAznr2yzjy1bbCZeWXYNL
	 oOP7TeMaE1x9h7a3j7cjvK5YAsYCJrLAzXjgAZWsA4w7zcGCA9sTk0MgsbgHm3O/XK
	 cadCk1hSI5IEtYbi3TotYKGQtzZ4sTVzPSkkN44To15XbDy8ZslgD9RKlz5OXH62PC
	 5oY9Pb40bwnb3DHEdIkBeNA8m91EjT1NEkhfmN+qU8/aVxOeKIQ1N940aJzbzQyjFl
	 gH+ZCiYsAQ67Q==
From: Conor Dooley <conor@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	imx@lists.linux.dev,
	loongarch@lists.linux.dev
Subject: [PATCH v1 0/4] Removal of non-existent DAC nodes
Date: Wed, 17 Jul 2024 10:37:52 +0100
Message-ID: <20240717-anvil-ashy-544e80a1317c@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1842; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=4e+rXBXLqQqSSHVIEfEJhU6tlJcG6qGYp0VGcEYWqUA=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGnTJ3x07+n9FSmZuEFwahLXo9MLWjzyLBx9tCcstVk84 d+GXVmLO0pZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCR1VwMf7iSZSUnTgyaq/ek XOt+E8ue0wYrhe8c9f2XGaYmt9GmtZThF3My88PT6loSutwznp1/VD7druJPippXCJ/aKfZfpXO TeQA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Recently I've been getting triggered by abuse of the Rohm dh2228fv
compatible to get the spidev driver probing in Linux on development
kits by employees of various silicon vendors (like NXP or my own
employer). I had a look around the kernel and all users other than the
original Clearfontz board added by Maxime appear to be similar abuse.
Drop the non-existent nodes from all of these devices :)

Fun fact: the dh2228fv isn't even real, and was originally a typo! The
real DAC is a bh2228fv

Cheers,
Conor.

CC: Dinh Nguyen <dinguyen@kernel.org>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>
CC: Heiko Stuebner <heiko@sntech.de>
CC: Shawn Guo <shawnguo@kernel.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>
CC: Pengutronix Kernel Team <kernel@pengutronix.de>
CC: Fabio Estevam <festevam@gmail.com>
CC: Huacai Chen <chenhuacai@kernel.org>
CC: WANG Xuerui <kernel@xen0n.name>
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
CC: linux-rockchip@lists.infradead.org
CC: imx@lists.linux.dev
CC: loongarch@lists.linux.dev

Conor Dooley (4):
  arm64: dts: imx8: remove non-existent DACs
  ARM: dts: rockchip: remove unlikly-to-exist DAC from elgin-r1
  loongarch: dts: remove non-existent DAC from 2k1000-ref
  ARM: dts: socfpga: remove non-existent DAC from CycloneV devkit

 .../arm/boot/dts/intel/socfpga/socfpga_cyclone5_socdk.dts | 6 ------
 arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts            | 8 --------
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts             | 6 ------
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts              | 6 ------
 arch/loongarch/boot/dts/loongson-2k1000-ref.dts           | 5 -----
 5 files changed, 31 deletions(-)

-- 
2.43.0


