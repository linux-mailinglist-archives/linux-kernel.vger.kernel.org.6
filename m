Return-Path: <linux-kernel+bounces-257040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 692A0937463
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05813B22391
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 07:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3999158ABC;
	Fri, 19 Jul 2024 07:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+soXRwa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4FA57C8D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 07:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721374098; cv=none; b=iWr/TbsOlqt0qy3GSeTlM6D4RkcP0eNNQKTnFYtAkGrwQJYPbmhTgF00BT1I/8rJ6oVSQbv5R/xJLjka64Lp/JfrHfCi1m9Btwia8dZN6WTrSVM0Yp4lfZaJIBgqw7ws15HDNaGprFltYVVpx3Nrg9WPQ7EZx7qE5GivVxKcGbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721374098; c=relaxed/simple;
	bh=Ui8UaqyBTSE898Dbvr8zLZbCGmxQq7br3UP3Ob3yp5w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MmC27DH9/lW6Z7Gf5Eq1TVzGe+LH0drm7aLujkWzGAP08RUg1oSnRusRkqOfplRCLA0+0QKk9/2+48jm9VA5rDGJp60OJe1ZSqXnlfAwiE1QHftDNtcKeMxJ1qRxdN+4esu86IOrc5PKmqvBr3AfiCFCvyNDVeK3R94XRRdl5Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+soXRwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC6FC32782;
	Fri, 19 Jul 2024 07:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721374098;
	bh=Ui8UaqyBTSE898Dbvr8zLZbCGmxQq7br3UP3Ob3yp5w=;
	h=From:To:Cc:Subject:Date:From;
	b=D+soXRwapxApziRw9qYeSuz57yKJml8YKkg1VRGVJXdBGvCMY0tJMLnYeW/Cufrpx
	 VHs+VAAYJqHq0+H2gxP6MxreLyqjRESDFbujKtuQQRxoq0r4PjivcvXPq0NWq7uaWq
	 siiYv6rMdOvpYx0zLuKujv9W4VkocztARdYqybe4a//1MlvRGYO59NK+1LB2aIl/iW
	 Tb2z40+Bz73SBGutptKLLblNsJeBUL0sVaukeREawRFkqzatrEYwLsoApAWCAglrVS
	 qwz53Y8ofG6Lmt5/XsNnpO46dB8eqeusPZ5eJhBTHhz/HTzywr6049RN3O6V2bLPr/
	 GJykETdKl74HQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: qcom: don't select HAVE_PWRCTL when PCI=n
Date: Fri, 19 Jul 2024 09:27:47 +0200
Message-Id: <20240719072813.1844151-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The new HAVE_PWRCTL option is defined in the PCI subsystem, so
selecting it unconditionally when PCI is disabled causes a harmless
warning:

WARNING: unmet direct dependencies detected for HAVE_PWRCTL
  Depends on [n]: PCI [=n]
  Selected by [y]:
  - ARCH_QCOM [=y]

Add 'if PCI' in the qualcomm platform to hide the warning.

Fixes: ed70aaac7c35 ("Kconfig: reduce the amount of power sequencing noise")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/Kconfig.platforms | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 9b62c63781ec..6c6d11536b42 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -266,7 +266,7 @@ config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
 	select PINCTRL
-	select HAVE_PWRCTL
+	select HAVE_PWRCTL if PCI
 	help
 	  This enables support for the ARMv8 based Qualcomm chipsets.
 
-- 
2.39.2


