Return-Path: <linux-kernel+bounces-178194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 460C48C4A42
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 01:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77AC11C20F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 23:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6F485C59;
	Mon, 13 May 2024 23:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VUDwdl/9"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE5184DE3;
	Mon, 13 May 2024 23:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715644368; cv=none; b=IqeiWFPzVHTYKIQXxt7tJadobZYHfTsGlfDp9ELd5xOVBq8yOr6bZhKwo1v9AOIujimkDl/BeNMmrMOH9o6hqiM4zOAJzjT7WHXpD0lKtN07/bU8KVCxMVTDx1P+af3JC5q52OcNiN9leP0JM/tGEfhpvu3FIrzbB/vZpJ+Dbx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715644368; c=relaxed/simple;
	bh=CgglF9AYIa374nzIGZ8DrZU9JTTF3trFBwVc5yQ5UBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q7UxJNWBTJrQo4hFqB/Y43gelNCmZwcJw1vPb0CAZ9XeWeuC/qNki4g8kr6Mi630CWfEkmKtLEkaKJ1y/9g6uKMmwgM5rqpGH05vjyh+BVlqy65b0piHjc487gMmGQ66d7EXuUh7wVqMBWnlcfterxXwdI45xyvicRPd76ZUNmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VUDwdl/9; arc=none smtp.client-ip=192.19.144.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 58F82C0000EC;
	Mon, 13 May 2024 16:52:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 58F82C0000EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1715644360;
	bh=CgglF9AYIa374nzIGZ8DrZU9JTTF3trFBwVc5yQ5UBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VUDwdl/90EA7fYv3NbI8V6ds10mvzUdOK6boeHWdKoCdvxYGhp9TOOON0kJyaLTef
	 XzDkCEEPjW91dqa+7kD8H0ibulJTsxYcgOQmWwOtV52KqQ2kHg0XS2mdZ2GoAP54A0
	 kD1vVKAyuxAyhHpo5vGDQgzC0cl+FnGJHnbMiHWQ=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 5696A18041CAC4;
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
Subject: [PATCH 3/3] clk: bcm: Make CLK_RASPBERRYPI default to RASPBERRYPI_FIRMWARE
Date: Mon, 13 May 2024 16:52:34 -0700
Message-Id: <20240513235234.1474619-4-florian.fainelli@broadcom.com>
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

The clock driver is essential in providing clocks for UARTs and other
peripherals, make it enabled by default.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/clk/bcm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/bcm/Kconfig b/drivers/clk/bcm/Kconfig
index a972d763eb77..90e7bab851ae 100644
--- a/drivers/clk/bcm/Kconfig
+++ b/drivers/clk/bcm/Kconfig
@@ -106,6 +106,7 @@ config CLK_BCM_SR
 config CLK_RASPBERRYPI
 	tristate "Raspberry Pi firmware based clock support"
 	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)
+	default RASPBERRYPI_FIRMWARE
 	help
 	  Enable common clock framework support for Raspberry Pi's firmware
 	  dependent clocks
-- 
2.34.1


