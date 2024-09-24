Return-Path: <linux-kernel+bounces-336883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A7F984228
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 314D4B29800
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02E31714C4;
	Tue, 24 Sep 2024 09:26:25 +0000 (UTC)
Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [195.130.137.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A751714B7
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169985; cv=none; b=q7TBg3o63iA0pEpITmqBsTwrGekP6CaZyfNCTEo35nN74bkBqsSTOJgezkE5ba3qKsixX623hSmvinnJzg15V0t7AT++JAXSOWlgUki8UdcO3xidU3lMJFnKDn9la51gblaqQLYuUC55hj/IrmJFb7UtY3FoE1DqgS8+uAHxbuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169985; c=relaxed/simple;
	bh=Rpiia7W171dhBiA2KDt3R+l32OjCdJgEQC5KzQ/YRWc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M09t89b3E1kbRnQYkWHMlI/gaAY1gE2b/NqvL1zMDPT86Xt7DsUgGNDd0w+YdZZxMItXcApKmsjOw6cMV65XAl1fM/8CKZvUT5wAaEpRbayxOEk//AMGkJyO343A8u9NvRaiHBTNSa3dwvP0RzTQsQZ7W/Svrf5qef7uPU5aOD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
	by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4XCZ893kPNz4x9fm
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 11:20:09 +0200 (CEST)
Received: from ramsan.of.borg ([84.195.187.55])
	by laurent.telenet-ops.be with cmsmtp
	id G9Kw2D00J1C8whw019Kw7X; Tue, 24 Sep 2024 11:20:02 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1st1dq-000ShT-KK;
	Tue, 24 Sep 2024 11:15:34 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1st1du-0003Zv-Gj;
	Tue, 24 Sep 2024 11:15:34 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] can: CAN_ROCKCHIP_CANFD should depend on ARCH_ROCKCHIP
Date: Tue, 24 Sep 2024 11:15:31 +0200
Message-Id: <a4b3c8c1cca9515e67adac83af5ba1b1fab2fcbc.1727169288.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Rockchip CAN-FD controller is only present on Rockchip SoCs.  Hence
add a dependency on ARCH_ROCKCHIP, to prevent asking the user about this
driver when configuring a kernel without Rockchip platform support.

Fixes: ff60bfbaf67f219c ("can: rockchip_canfd: add driver for Rockchip CAN-FD controller")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/can/rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/rockchip/Kconfig b/drivers/net/can/rockchip/Kconfig
index e029e2a3ca4b04df..fd8d9f5eeaa434ac 100644
--- a/drivers/net/can/rockchip/Kconfig
+++ b/drivers/net/can/rockchip/Kconfig
@@ -3,6 +3,7 @@
 config CAN_ROCKCHIP_CANFD
 	tristate "Rockchip CAN-FD controller"
 	depends on OF || COMPILE_TEST
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	select CAN_RX_OFFLOAD
 	help
 	  Say Y here if you want to use CAN-FD controller found on
-- 
2.34.1


