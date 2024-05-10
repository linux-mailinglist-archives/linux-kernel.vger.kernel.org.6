Return-Path: <linux-kernel+bounces-175302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC03F8C1DC9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 07:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28D771C21165
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 05:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4531D168B1F;
	Fri, 10 May 2024 05:38:42 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FC615B147
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 05:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715319521; cv=none; b=mkBXdTu123IFAS0Xbwwxkorb4qKKhjqcx7HCDTh8iVSRs9MI8O+ivAT7TCUirzK73L05x7OMXoif9iKB2fMlu2bDn6WKPxMX17iEf/xeeugNnL+f1mVjLitcuGjtFiN2oaOGj8I5pfVaV5IWq/oDEq+XcoaysPvdQHmLZiaiyHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715319521; c=relaxed/simple;
	bh=OnGBnLvZZ6CqirGTlXSx75/bxrE2ofGg3Zw9/s/7K4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gEL1DsbXkQ9sj2HEqu6YMRr8BAPyfDl1HhdCyXisbx897IGITc2dCykqoR8IvmqFUUPEWl6Kki4YbPCYp6mSXzWt2jvf7KcGKjEacnxmAVrZ70DodlCkgZcoYXUF87I+VNwWhKsC8+uDvqjolCKwxE/Ob4zu33LDIzoXOM6UyB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1s5Ixk-0006RZ-4d; Fri, 10 May 2024 07:38:32 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1s5Ixh-000a4E-F9; Fri, 10 May 2024 07:38:29 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1s5Ixh-00A7cH-1I;
	Fri, 10 May 2024 07:38:29 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH net-next v3 2/3] net: dsa: microchip: dcb: add comments for DSCP related functions
Date: Fri, 10 May 2024 07:38:27 +0200
Message-Id: <20240510053828.2412516-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240510053828.2412516-1-o.rempel@pengutronix.de>
References: <20240510053828.2412516-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

All other functions are commented. Add missing comments to following
functions:
ksz_set_global_dscp_entry()
ksz_port_add_dscp_prio()
ksz_port_del_dscp_prio()

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
---
changes v2:
- move this patch after IPV->IPM rename patch
---
 drivers/net/dsa/microchip/ksz_dcb.c | 31 +++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_dcb.c b/drivers/net/dsa/microchip/ksz_dcb.c
index af7af515e0434..07f6742df41bd 100644
--- a/drivers/net/dsa/microchip/ksz_dcb.c
+++ b/drivers/net/dsa/microchip/ksz_dcb.c
@@ -310,6 +310,17 @@ int ksz_port_get_dscp_prio(struct dsa_switch *ds, int port, u8 dscp)
 	return (data >> shift) & mask;
 }
 
+/**
+ * ksz_set_global_dscp_entry - Sets the global DSCP-to-priority mapping entry
+ * @dev: Pointer to the KSZ switch device structure
+ * @dscp: DSCP value for which to set the priority
+ * @ipm: Priority value to set
+ *
+ * This function sets the global DSCP-to-priority mapping entry for the
+ * specified DSCP value.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
 static int ksz_set_global_dscp_entry(struct ksz_device *dev, u8 dscp, u8 ipm)
 {
 	int reg, per_reg, shift;
@@ -377,6 +388,16 @@ static int ksz_init_global_dscp_map(struct ksz_device *dev)
 	return 0;
 }
 
+/**
+ * ksz_port_add_dscp_prio - Adds a DSCP-to-priority mapping entry for a port on
+ *			    a KSZ switch.
+ * @ds: Pointer to the DSA switch structure
+ * @port: Port number for which to add the DSCP-to-priority mapping entry
+ * @dscp: DSCP value for which to add the priority
+ * @prio: Priority value to set
+ *
+ * Return: 0 on success, or a negative error code on failure
+ */
 int ksz_port_add_dscp_prio(struct dsa_switch *ds, int port, u8 dscp, u8 prio)
 {
 	struct ksz_device *dev = ds->priv;
@@ -387,6 +408,16 @@ int ksz_port_add_dscp_prio(struct dsa_switch *ds, int port, u8 dscp, u8 prio)
 	return ksz_set_global_dscp_entry(dev, dscp, prio);
 }
 
+/**
+ * ksz_port_del_dscp_prio - Deletes a DSCP-to-priority mapping entry for a port
+ *			    on a KSZ switch.
+ * @ds: Pointer to the DSA switch structure
+ * @port: Port number for which to delete the DSCP-to-priority mapping entry
+ * @dscp: DSCP value for which to delete the priority
+ * @prio: Priority value to delete
+ *
+ * Return: 0 on success, or a negative error code on failure
+ */
 int ksz_port_del_dscp_prio(struct dsa_switch *ds, int port, u8 dscp, u8 prio)
 {
 	struct ksz_device *dev = ds->priv;
-- 
2.39.2


