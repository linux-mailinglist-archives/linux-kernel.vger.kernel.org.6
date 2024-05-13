Return-Path: <linux-kernel+bounces-178195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EC98C4A44
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 01:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5AD41C21629
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 23:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E51126F33;
	Mon, 13 May 2024 23:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C2qJYaB4"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE0D1F934;
	Mon, 13 May 2024 23:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715644369; cv=none; b=mZSIjaJjvE1msMdK3kO0iPMKgmORL/+zs0JguffeUefjGVZF1C4nkiB4X/bce49zcToXHUjipD/6ZaKJqTUFd0SYJ0h2WKvu0DIGHeugtxjmybpFmdBlKM6AifLR8wmGGaxcSgdnFdB+T56g9osSktusPGqw7AeiiW1eIOR2TPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715644369; c=relaxed/simple;
	bh=lQIjl5hEK45jvJkbp0UsHwivkT2VE8Fl/ArGh+n9d1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hhjJM6ZTuN7fndHajaUfqZ8MjQBgbMXgCg2zZ8okig4kwaf49gEr91b5bJQwetkyvGHVIg9n+0l/xBQ/evP1GWPEUvP8ALIqgdfzhVLbU3NA9YUbmwttGyyV2H5TJujsB9q1oB6YNrlXIt5rpOMnKrNr+/V0p4Og1gWlIU1G5Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=C2qJYaB4; arc=none smtp.client-ip=192.19.144.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id EF809C0000ED;
	Mon, 13 May 2024 16:52:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com EF809C0000ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1715644360;
	bh=lQIjl5hEK45jvJkbp0UsHwivkT2VE8Fl/ArGh+n9d1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C2qJYaB4mxlvkP5y70+GCmFuzibx3q7p8lvpAHB7sezpR4/2AeUh2yr0Ujau9Kr/4
	 bXdw07kM3u9Nq0Rae0PtEu2AAOheuJ22sd9lfe+MI6i/MsMzYfBtYkLdo639v/mAEd
	 EE9VldDqz68nW1Zj+3CxpAibi89o//AIhH3tc/20=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id E041218041CAC6;
	Mon, 13 May 2024 16:52:37 -0700 (PDT)
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
Subject: [PATCH 1/3] mailbox: Make BCM2835_MBOX default to ARCH_BCM2835
Date: Mon, 13 May 2024 16:52:32 -0700
Message-Id: <20240513235234.1474619-2-florian.fainelli@broadcom.com>
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

This driver is depended on by CONFIG_FIRMWARE_RASPBERRYPI which provides
a number of essential services, including but not limited to a Linux
common clock framework provider. Make sure that enable
CONFIG_ARCH_BCM2835 does enable the corresponding mailbox driver.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/mailbox/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 42940108a187..2b4cde562a90 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -109,6 +109,7 @@ config ALTERA_MBOX
 config BCM2835_MBOX
 	tristate "BCM2835 Mailbox"
 	depends on ARCH_BCM2835
+	default ARCH_BCM2835
 	help
 	  An implementation of the BCM2385 Mailbox.  It is used to invoke
 	  the services of the Videocore. Say Y here if you want to use the
-- 
2.34.1


