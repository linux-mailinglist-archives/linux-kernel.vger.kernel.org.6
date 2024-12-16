Return-Path: <linux-kernel+bounces-447012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D73A29F2C06
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF72D1888B31
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78B11FFC65;
	Mon, 16 Dec 2024 08:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phby1jvS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDBF1C3318;
	Mon, 16 Dec 2024 08:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734338054; cv=none; b=jQc4Aj1iZfWNq47T6N/jXjC72GSXTKqOcv2RFk4bOv1c94ayvFQYTNRYfgCGBg3QXh3KCwhvRA4LUDBSWtRroKxTu3AplnFKBWSnqYsDGHuKGOakBFMiB/Kow9T44IE+irt5RjxWUqfFoU1r5ICEsFr6zvGroCWNrfqwV17thRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734338054; c=relaxed/simple;
	bh=Eo1ajtnJsnButOoKnoFQoNlk/tRZVz/zZ906wj6eUAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IlfNujjuHWJouqsG28XB2PTWruR499J2byffIFsPffpU0tq1jQWwWjwRIHioO+UHEMsAGOj1iyt7Nct91ur860qwJg2FDTldgfD8M3N0Ux7EYI+Qr/FrThTjtlTrIj6cQr47MLkkDj+QxDvXxhsgKId6OmR5QnAHzodk+vik17w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phby1jvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1B3C4CED0;
	Mon, 16 Dec 2024 08:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734338053;
	bh=Eo1ajtnJsnButOoKnoFQoNlk/tRZVz/zZ906wj6eUAQ=;
	h=From:To:Cc:Subject:Date:From;
	b=phby1jvSqidDr3SQMGHLdOqPb+aoGOuAFeaWQpy+ZpF5gdIpz3KXuKVnVVdAHNTOH
	 defami4R6qBtVUcA/MEHYLcrkphjujGhF08MxTmC5bz6TxXcS9ygGeaiej2DXVsGsT
	 8DVbSKk4w4uzVn19lckzH5C62T8Y0e57OJ+iwtineADRl84/AbKARDyQiND1hTGmcD
	 GX5WKXFI3JRwGuSk7+AO9qla6NXmmD+5WvrveGj3KqQqXyTp27qo4LOzwFA0cFNDkB
	 5PNlR5x3TkSZyzTKInqPundu0FperblyvqcV7Sh6pp8o7ZjB9E8zjYUk19ZkXauJJu
	 rwcDmJy2AQh7A==
From: Arnd Bergmann <arnd@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86/intel: bytcrc_pwrsrc: fix power_supply dependency
Date: Mon, 16 Dec 2024 09:34:05 +0100
Message-Id: <20241216083409.1885677-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The driver now fails to link when the power supply core is missing
or in a loadable module:

_64-linux/bin/x86_64-linux-ld: drivers/platform/x86/intel/bytcrc_pwrsrc.o: in function `crc_pwrsrc_irq_handler':
bytcrc_pwrsrc.c:(.text+0x2aa): undefined reference to `power_supply_changed'
x86_64-linux-ld: drivers/platform/x86/intel/bytcrc_pwrsrc.o: in function `crc_pwrsrc_psy_get_property':
bytcrc_pwrsrc.c:(.text+0x2f6): undefined reference to `power_supply_get_drvdata'
x86_64-linux-ld: drivers/platform/x86/intel/bytcrc_pwrsrc.o: in function `crc_pwrsrc_probe':
bytcrc_pwrsrc.c:(.text+0x644): undefined reference to `devm_power_supply_register'

Add the appropriate dependency for it.

Fixes: 0130ec83c553 ("platform/x86/intel: bytcrc_pwrsrc: Optionally register a power_supply dev")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/intel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index eb698dcb9af9..19a2246f2770 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -83,6 +83,7 @@ config INTEL_BXTWC_PMIC_TMU
 config INTEL_BYTCRC_PWRSRC
 	tristate "Intel Bay Trail Crystal Cove power source driver"
 	depends on INTEL_SOC_PMIC
+	depends on POWER_SUPPLY
 	help
 	  This option adds a power source driver for Crystal Cove PMICs
 	  on Intel Bay Trail devices.
-- 
2.39.5


