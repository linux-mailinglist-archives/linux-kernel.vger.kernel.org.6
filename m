Return-Path: <linux-kernel+bounces-197515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6188D6BAE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188341C25622
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4419A81AC3;
	Fri, 31 May 2024 21:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QxnMnJ2D"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AD078C9C;
	Fri, 31 May 2024 21:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191329; cv=none; b=hJcp4qNXJf72Vuyqolzt2WcEVK3lHf2IWUxFI7xXIJU4ori1qqAmrRXsZz/4hK7niXLspFhHdkPtK6WKVbL1d3uvEKdz+axsIr0W3nYrcBGtswFLr1alBWHTDRZH+QcUMIsBWirQFBhI8ly6WE1/yoOTdLD7jBuDS42V+3ISm7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191329; c=relaxed/simple;
	bh=mjBnWdIpAfjAZO3tAVyHWZmi3iW8UcI6ABCHF3cvcwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mcEExdhP6xMmIxwb1sZF0B6X3UKRRCmDHNRuRdNIge7pqVzwU0An7PFdFkg88WLcLatEm2PBzAdxQV68Hv2/aE3IeMl9xIQM0HJowTfVp0XSXT2tyZYOItV7ZahwyjY9B03YJOYbR1YVaBJLGXNUZe7UboHY97nanLhY8nnqkh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QxnMnJ2D; arc=none smtp.client-ip=192.19.144.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 6B243C0000EC;
	Fri, 31 May 2024 14:29:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 6B243C0000EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1717190984;
	bh=mjBnWdIpAfjAZO3tAVyHWZmi3iW8UcI6ABCHF3cvcwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QxnMnJ2DH/OEjbUVEvujWvJflW0ZstYqKPujJV1FY9ljpfVwhMTVsBXdWqEY/jC6/
	 nFhD/1zQi6nbYoVrZGc9WmnR42n+S9qavRIUG6TlwhJ/WYKWje0jsU1Bpmuf6CO3ID
	 /KrQHd/HnIiOfUorxAXbATSSq8ixUy9hrfxFu/NA=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 4920418041CAC6;
	Fri, 31 May 2024 14:29:42 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
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
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH v2 1/3] mailbox: Make BCM2835_MBOX default to ARCH_BCM2835
Date: Fri, 31 May 2024 14:29:40 -0700
Message-Id: <20240531212942.3340484-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531212942.3340484-1-florian.fainelli@broadcom.com>
References: <20240531212942.3340484-1-florian.fainelli@broadcom.com>
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
CONFIG_ARCH_BCM2835 does enable the corresponding mailbox driver as
well.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/mailbox/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 3b8842c4a340..b5108896dd72 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -112,6 +112,7 @@ config ALTERA_MBOX
 config BCM2835_MBOX
 	tristate "BCM2835 Mailbox"
 	depends on ARCH_BCM2835
+	default y
 	help
 	  An implementation of the BCM2385 Mailbox.  It is used to invoke
 	  the services of the Videocore. Say Y here if you want to use the
-- 
2.34.1


