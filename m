Return-Path: <linux-kernel+bounces-535759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E52AA476D0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB7C37A439C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52FD223715;
	Thu, 27 Feb 2025 07:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="CeVlpRfs"
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1F62222B8
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740642513; cv=none; b=I2Npy8iTogCyYzmTQSbP1Rz44Ins7haFJhQbTnN+DqRpwOiM8rgT7UpakakD+zde90w+b9J25at8nSP0x2s1VPQD9WCaIFFWzC4wOEScsnRUE6hhIK0OuCQHTnvxD31EiKFEhscVuxgkjQrHL2sbCiFmx7AV7c9x3RUyiaEGe5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740642513; c=relaxed/simple;
	bh=LcTTmUaiUueHzxkqqk4T+6kRWsuH1UVWB8bDZx3I/t4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DLOH9x6Bo6ehUZ343jWVa99lyw8r/eFRPjcfM0m/ixmHKwe+EbkaXBm5FAGlBQ3vUxbQWMX6Pk/Df6at8lLxU87zblGPr115qVgT34fphQcjOuV5x7k+IHE3PcBbn8QA5wd4+ubCUvy2FKPuHj9FRashZCpBAJhq/Ccc1TUpXI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=CeVlpRfs; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2025022707482405f637aac6e48568cb
        for <linux-kernel@vger.kernel.org>;
        Thu, 27 Feb 2025 08:48:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=is2ITOYKTL7kmTYspiTeObOPS74J39ADsO954CSY7t8=;
 b=CeVlpRfsRHIVS/dTMY+Uq9NSXNSfWpXZdFo+B6VL2fIU53UFm+HimvRh6Oxe+cZsrBS1j7
 z4UzWbEhxkPCws2te2J1N64dyB3Qrnw2DzGaxPhVz68WQpn22CNL40JLSF+tucBpLAcVxs0c
 IyKoL0fsHXxXoHWJEyBJ4j38HHgFvZun3uq0hLQB8I8VmUkrbAPH7z5YvkCqb1WmntMDkj9E
 kFPvSrVN/kgu62T+yMGmspC4iZ6NZGQjZ217BoNLRqbCdNIbBEjlAsUDml+rfCRqN1psL6ii
 qTACQc1MVvQCxTyynCuuRpzuZxAvk0IUpkpH4EkVBIQ791PTioPiuRmQ==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	netdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: ethernet: ti: cpsw_new: populate netdev of_node
Date: Thu, 27 Feb 2025 08:46:46 +0100
Message-ID: <20250227074704.4067481-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

So that of_find_net_device_by_node() can find cpsw-nuss ports and other DSA
switches can be stacked downstream. Tested in conjunction with KSZ8873.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/net/ethernet/ti/cpsw_new.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index cec0a90659d94..66713bc931741 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1418,6 +1418,7 @@ static int cpsw_create_ports(struct cpsw_common *cpsw)
 		ndev->netdev_ops = &cpsw_netdev_ops;
 		ndev->ethtool_ops = &cpsw_ethtool_ops;
 		SET_NETDEV_DEV(ndev, dev);
+		ndev->dev.of_node = slave_data->slave_node;
 
 		if (!napi_ndev) {
 			/* CPSW Host port CPDMA interface is shared between
-- 
2.48.1


