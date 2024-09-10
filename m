Return-Path: <linux-kernel+bounces-323916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD4197452B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA122B24942
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A55A1ABEAD;
	Tue, 10 Sep 2024 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5zcA+qo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661541ABEC7;
	Tue, 10 Sep 2024 21:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726005558; cv=none; b=tv0/a7DRQtg7KdG5KJskh3auQBUKktb5AtS7BMBVvgut9lblaE7xl6hCK9V5My4OrLZ6MQgHlM25SwdADmKMX+a6RhwZscOfkAXpXgGeSfojcgFg2SG1uskGQkk6levpYBq7DX6+m2g+aKbihVeYHhGJHf99ftLVs3/k0toEvXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726005558; c=relaxed/simple;
	bh=FQG5W9GsG2Ukh7vtLW2D6Qd/8DEqsDb10kek7cnE8Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BQhoY8Ur3CrTEgHpR2WIL1dxWgSGJWlaqqd1flUmB60ukGoAvrUGy9miNQjPQal0ykDr+IOzcsfGdMLSJGiNdJ+7OthRybbIhqC3u/+QuzdZcmnlTQqkwODwo6M65R2W7GoAXBv8o9Mex2ZiNTm0rFUffJo/AFGhQuK/CJcu+KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5zcA+qo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A54C4CEC3;
	Tue, 10 Sep 2024 21:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726005558;
	bh=FQG5W9GsG2Ukh7vtLW2D6Qd/8DEqsDb10kek7cnE8Mc=;
	h=From:To:Cc:Subject:Date:From;
	b=G5zcA+qoyuOExyMK26tG9yY8glwkte64vQAbaqqdx2ZH+jN2emWDD2DJjWWT+MPPC
	 klYEJfN/BsdgipMlEYEEkzNWuluKPSbpIAtZr7GJZKBHljUZr9UPjWRPVezsy/4sTK
	 HpGAzaxdJZG5MXVZDigr/YVlI9VLd0Df3cApo1lODxqmK7/3EUJzMGSFIpFx7w2gaM
	 kdGK1MRzJkHy+h0fInQFsQXRwPw6VSdrRiScOUgWo1Tjm0fdaeJ0OiWmJwQClukpXS
	 IoB88vej3xfX784nq20ZVFZlHJc9NoEuKCmljz01YsGdPFOfQmTTh6TzrxIbXI6s3G
	 NMAjiWYypteEw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: marvell: kirkwood: Fix at24 EEPROM node name
Date: Tue, 10 Sep 2024 16:59:13 -0500
Message-ID: <20240910215914.823546-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

at24.yaml defines the node name for at24 EEPROMs as 'eeprom'.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm/boot/dts/marvell/kirkwood-openblocks_a7.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/marvell/kirkwood-openblocks_a7.dts b/arch/arm/boot/dts/marvell/kirkwood-openblocks_a7.dts
index 9c438f10f737..2bc4b68bd723 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-openblocks_a7.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-openblocks_a7.dts
@@ -44,7 +44,7 @@ sata@80000 {
 		i2c@11100 {
 			status = "okay";
 
-			s24c02: s24c02@50 {
+			s24c02: eeprom@50 {
 				compatible = "atmel,24c02";
 				reg = <0x50>;
 			};
-- 
2.45.2


