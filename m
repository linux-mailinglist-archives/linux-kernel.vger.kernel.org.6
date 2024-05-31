Return-Path: <linux-kernel+bounces-197513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF138D6BAA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97DC92876F0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B4280032;
	Fri, 31 May 2024 21:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MbbGP5Mg"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A907407E;
	Fri, 31 May 2024 21:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191328; cv=none; b=F9PH00CdfBu2ah17F6XM3EaWrAKbMYx5RzHfy/iPM99L7UZBlhxzVV5YTT5vOuKxOjiUuHuT1agAfeTv3OWm6qiIQRh8b45Qpgv1r5r5BhA/ey6jI85rXy+uBC5zo2xBk00l4BhF5iSnWw90Pq+Xg+4zUZt7+ToSkL4Gc+K4JXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191328; c=relaxed/simple;
	bh=iQs8wnrGJPnYLiftqnSQsTcFMR6GgBHRqApPehEgWes=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vDguxsOy+uMQXXCkf4TONKZBeS4iSuiiAeu6UyYGBplqs9WdBuaf/AaTfxON8E0aRjaJii01qaRAlGMcO6cqUWjgQoilmbfOeiLdLa8+Lv1kmc4kewMGhF5PU4pQElesK1SepOuTuQ/XBd/dR7guym8IcjjzswCcbCuwUhDyyFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MbbGP5Mg; arc=none smtp.client-ip=192.19.144.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 4204CC0000D8;
	Fri, 31 May 2024 14:29:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 4204CC0000D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1717190984;
	bh=iQs8wnrGJPnYLiftqnSQsTcFMR6GgBHRqApPehEgWes=;
	h=From:To:Cc:Subject:Date:From;
	b=MbbGP5MgOufiTKNZysTzCpoV2idPHUURGSg8lsfe5vYrcUuWkH8RJNx8heprxTcE6
	 TKY8g2OL/3ag5jy1RbAd+XitlpIO8s9lYGV2Ulev/D7/7bPvF4bIhBphW66FDYVxfg
	 MRUpRx85JcYVySo+LUGkyQq5Rf35GEOH5mIlDAr0=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 1324018041CAC4;
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
Subject: [PATCH v2 0/3] ARCH_BCM2835 Kconfig changes
Date: Fri, 31 May 2024 14:29:39 -0700
Message-Id: <20240531212942.3340484-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series updates a number of Kconfig entries such that enable
ARCH_BCM2835 guarantees that essential drivers are also enabled, saves a
lot of configuration and troubleshooting time for when they are not.

Changes in v2:

- used "default y" instead of "default ARCH_BCM2835" per Conor's
  suggestion
- added Stephen's ack to the clock driver

Florian Fainelli (3):
  mailbox: Make BCM2835_MBOX default to ARCH_BCM2835
  firmware: Default RASPBERRYPI_FIRMWARE to y
  clk: bcm: Make CLK_RASPBERRYPI default to RASPBERRYPI_FIRMWARE

 drivers/clk/bcm/Kconfig  | 1 +
 drivers/firmware/Kconfig | 1 +
 drivers/mailbox/Kconfig  | 1 +
 3 files changed, 3 insertions(+)

-- 
2.34.1


