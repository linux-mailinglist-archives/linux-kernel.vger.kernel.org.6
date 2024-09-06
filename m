Return-Path: <linux-kernel+bounces-319508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB2996FD83
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 23:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964D61F257B5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F22415990C;
	Fri,  6 Sep 2024 21:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TuSdooYF"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D3C1B85C1
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 21:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725658769; cv=none; b=UR8hPqbGp4dcMl590+J/fakoNNSEyufk1VZDkQ2FPwHDZ5el7IlJeexSFCwKhj5JCa0F4WsL3yJOuMBZtC3SFktEoU9+i7cuXXPEDYV6GD0XvG9maBcTRRIk5tUYabY4VjtHJr9AbEnVtDcM0HLrxFAFmCDd0x2G/pgn9A+0IVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725658769; c=relaxed/simple;
	bh=xHLYJeJak1kvJwAAwSNxodmq46kdsG5N8/rFBGfs7Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rMuKk4tOX9jIcTuZELpdJRioYXBc4KnoheFSBAlgvVnjz6DvfAc4XcTUxuwqokDuhw0G1yryX43wLmJkWOg2kWtRYP9Afl/IDAiPLkn0GDy0FTnzskFnNoo7sBD/P9rDEKCpZ6BPzu+3FaaznXas0nZf/pdQShrvRVPi2sWPXcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TuSdooYF; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 6D182C0000F8;
	Fri,  6 Sep 2024 14:39:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 6D182C0000F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1725658760;
	bh=xHLYJeJak1kvJwAAwSNxodmq46kdsG5N8/rFBGfs7Mo=;
	h=From:To:Cc:Subject:Date:From;
	b=TuSdooYFkFoG3I+6hVZdZIE2mLQCIkDKs1/jyd1JK4IZ8Neg4t52Kynmq5mg4IM1s
	 gpAxvL6by9vlFY0ALfPRjK539iNQrjT+NmDjNvE8QNXd8V6kdwJi8bDpiJe2DzOzUS
	 fvQsUDKY8HLLt0RhWnZG/K1yvBx5NSVTg/U+oTGU=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 0333718041CAC6;
	Fri,  6 Sep 2024 14:39:19 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andrew Davis <afd@ti.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mark Brown <broonie@kernel.org>,
	Etienne Carriere <etienne.carriere@foss.st.com>,
	Trevor Woerner <twoerner@gmail.com>,
	Javier Carrasco <javier.carrasco@wolfvision.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: multi_v7_defconfig: Enable debugging symbols by default
Date: Fri,  6 Sep 2024 14:39:05 -0700
Message-ID: <20240906213907.611684-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly to the ARM64 defconfig, enable debugging symbols and rely upon
the toolchain's default DWARF implementation.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 62734530a3d6..eee71f6ae131 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1322,5 +1322,8 @@ CONFIG_CRYPTO_DEV_STM32_HASH=m
 CONFIG_CRYPTO_DEV_STM32_CRYP=m
 CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_REDUCED=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
-- 
2.43.0


