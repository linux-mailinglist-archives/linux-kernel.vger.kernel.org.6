Return-Path: <linux-kernel+bounces-197514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA988D6BAB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 292132879D4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0463680034;
	Fri, 31 May 2024 21:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YTdaWx0M"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA377CF1F;
	Fri, 31 May 2024 21:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191328; cv=none; b=Znw0OpHwS+UN523+K+57dVIOE6eT9t35uYejw78huwhAFciPZZQQxZARlf8pLwrwpIapSi69LNDcaqJ+mOk0ogphC1SPcMGTPGv5I4TLoMTd+W8zEzvtVHOCPjQHOESJOFHk+Z74d8xfQRiaIeQ4O8yRMTAPmEnJ0mN73Egqouc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191328; c=relaxed/simple;
	bh=EBLle0cZpCIXZD7rmqgDVXdaUXUTA2nKtAXDK6Ecjio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bxR/0u6/R1Uyexgo3nrKFTzMQ+xkli4Lf2wkXzTKpJtncual8tenLuu6SZdlm5/SfTh36DifxD089DDNuZsk/kqHPrcCnM5z34kmiXvEddjQDSGixhbV2sx4muqbzFCr5sbrNK1um67iie/L90/eY4p5CqeKHd4sffaOSnGjOQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YTdaWx0M; arc=none smtp.client-ip=192.19.144.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 90857C0000F4;
	Fri, 31 May 2024 14:29:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 90857C0000F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1717190984;
	bh=EBLle0cZpCIXZD7rmqgDVXdaUXUTA2nKtAXDK6Ecjio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YTdaWx0MWUZOS956hQZhcU0vMs+W6r+E9aBTHOAXuCHYCLgl5D2kOTRgMom2ap3gu
	 Dq/qCuXJ7Yv1Rx71UIobkMMHc7WKbKpELeqo1zlnKtGsKn0IL5SK5otDYbz6O9V3JQ
	 NjCZi2FuEiay7sbR/Hcf4Hfubjy9ZFFuU+Ewq4Y0=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 73F9718041CAC7;
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
Subject: [PATCH v2 2/3] firmware: Default RASPBERRYPI_FIRMWARE to y
Date: Fri, 31 May 2024 14:29:41 -0700
Message-Id: <20240531212942.3340484-3-florian.fainelli@broadcom.com>
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

The firmware driver provides the communication interface for a number of
other essential drivers, including a clock provider. Having it the
default when enabling CONFIG_ARCH_BCM2835 ensures that we have a
provider for essential system functions.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/firmware/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 71d8b26c4103..964f6c45c446 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -116,6 +116,7 @@ config ISCSI_IBFT
 config RASPBERRYPI_FIRMWARE
 	tristate "Raspberry Pi Firmware Driver"
 	depends on BCM2835_MBOX
+	default y
 	help
 	  This option enables support for communicating with the firmware on the
 	  Raspberry Pi.
-- 
2.34.1


