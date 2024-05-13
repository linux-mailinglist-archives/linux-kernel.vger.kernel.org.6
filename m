Return-Path: <linux-kernel+bounces-178193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8FC8C4A41
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 01:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A805C284B21
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 23:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB48D85C4E;
	Mon, 13 May 2024 23:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C7xRaDfZ"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C720E8564F;
	Mon, 13 May 2024 23:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715644368; cv=none; b=D9fV9iWo+7QttrCsS3I2nJCcwOWD2sFb6UgCai5wYD4Q84k/Uqy0vnZgYn5cwStVfsVE6xnzni8+i4ASzEYzj5Acbv+I3ofptzRwyFnvburgXTueADEXJY3OHE7Tn1uUhW1z75xQKmoadSF+e5PTIkcW/z3/T083RpnUJzCiOKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715644368; c=relaxed/simple;
	bh=TJ7m5K0tasIolZHkk2fjtG/5NyKihE+J+PRepHVqxKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lEZesG9BsTlebizbXcDOAz3nvlf3KnZq27OhgbBPfJk3t+x+p/8veU7FyLodkWDji6/B4rVe2KevnNn4cOH9SxFoCvX91VMJ2x7BlIBr2AoT+y64S1wOiDloSQjhwfjMVV7KlaLFTw2C+cf+MZK7OgyexFeJ4LMQKvDIF9B16nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=C7xRaDfZ; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 24D8EC0000E3;
	Mon, 13 May 2024 16:52:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 24D8EC0000E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1715644360;
	bh=TJ7m5K0tasIolZHkk2fjtG/5NyKihE+J+PRepHVqxKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C7xRaDfZRYdEvUmRU42rRy7TR2x4HzfC9xIKMXhNlaWuJCg62hvgNIoCUQ6shr1kB
	 y1qVbfpSX/9uHbiTKEi4lxV4/PCWsU3vysVHB1464qcYRD0MTSxgBEbJmTkaLzvtNm
	 TVyrss2VvhaB/qUUv0Db3F/dxXhZVStti5n2UKUw=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 1AFEF18041CAC7;
	Mon, 13 May 2024 16:52:38 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	linux-kernel@vger.kernel.org (open list),
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 2/3] firmware: Default RASPBERRYPI_FIRMWARE to ARCH_BCM2835
Date: Mon, 13 May 2024 16:52:33 -0700
Message-Id: <20240513235234.1474619-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513235234.1474619-1-florian.fainelli@broadcom.com>
References: <20240513235234.1474619-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The firmware driver provides the communication interface for a number of
other essential drivers, including a clock provider.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/firmware/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 71d8b26c4103..ae9b28703165 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -116,6 +116,7 @@ config ISCSI_IBFT
 config RASPBERRYPI_FIRMWARE
 	tristate "Raspberry Pi Firmware Driver"
 	depends on BCM2835_MBOX
+	default ARCH_BCM2835
 	help
 	  This option enables support for communicating with the firmware on the
 	  Raspberry Pi.
-- 
2.34.1


