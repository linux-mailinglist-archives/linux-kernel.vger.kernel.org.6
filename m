Return-Path: <linux-kernel+bounces-360533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6417999C35
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8B21F24BBF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 05:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CA91F9A97;
	Fri, 11 Oct 2024 05:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BFg4Hjdc"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A2E199FBB;
	Fri, 11 Oct 2024 05:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728625524; cv=none; b=KRHCykfUfAtuzJAfzl21OkwCLMkIKBuJ9Pi2xCE2mIaOAqFvNUmyRaecJI8+/gYIwCaPp1FwZ0GBnctRsmyY144FkArFf6vdfSjx4ZM//GlE7yhz8YNavHG00OxbdZIt3lvn42OJpa/l0KKehu9zicEGWIyKz8NZHqqFsqFYPP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728625524; c=relaxed/simple;
	bh=nmbF2PhNdJ7/xL34LGBrOuJMIZrELMaifyTLK8hvpsA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QIBwFuZIxZNfhH1HiEWevMtYAdkBUHINnrlWYo3g3cpmbF/1Gkt8CaikQuXOppBltcDVctXlcRhF/Wv96dMHmOHFsdSwVtqOFh7ECO/yMyiZkTfM2ZTpMoeXInwH+THt1/H0SpGJwmm1ymg4mrIx6SFIPLh9DQhdZ3xT27pTHVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BFg4Hjdc; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49B5jAaN100941;
	Fri, 11 Oct 2024 00:45:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728625510;
	bh=tv0D3m9QqlL2V3O1Ly4Bj2ftcITzo4LxkkV37gOOOVk=;
	h=From:To:CC:Subject:Date;
	b=BFg4Hjdc8gZ3Ju0LwF0VoUDTw1QiUXBG+36bvtBY5OSdqvWljoQe5qcWgQVNDBciL
	 7zZGAHhDju+c/rRZRzl+GosEDVaB8oHtm3nvxJtVUCTvMbX2EjbzD7nhn65UFtuxI1
	 2OutxfDIXhrNPPTxlX6PPFK0D1cwJng6UCLd7PWk=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49B5jA1e028069
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Oct 2024 00:45:10 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Oct 2024 00:45:09 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Oct 2024 00:45:09 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49B5j6Dj045606;
	Fri, 11 Oct 2024 00:45:07 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <peter.chen@kernel.org>, <pawell@cadence.com>, <rogerq@kernel.org>,
        <gregkh@linuxfoundation.org>, <felipe.balbi@linux.intel.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH] usb: cdns3: cdns3-gadget: Fix cdns3_ep_config() by setting ep.maxpacket
Date: Fri, 11 Oct 2024 11:15:06 +0530
Message-ID: <20241011054506.2810565-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The function cdns3_ep_config() calculates the maximum packet size based
on the Endpoint Type and the Gadget Speed and stores it in the variable
"max_packet_size". This value is then programmed in the USB Controller
for the corresponding Endpoint. This may result in a mismatch between
the maximum packet size programmed in the USB controller and the maximum
packet size seen by the UDC Core via "maxpacket" member of "struct usb_ep".
Additionally, since TD_SIZE as well as TOTAL_TDL are calculated in
cdns3_ep_run_transfer() on the basis of the maximum packet size stored in
the "maxpacket" member of "struct usb_ep", it may lead to incorrect values
of TD_SIZE and TOTAL_TDL when compared with what the USB controller
actually expects (max_packet_size). This also applies to the calculation of
TDL in cdns3_ep_run_stream_transfer().

Fix this.

Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
1d227fcc7222 Merge tag 'net-6.12-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
of Mainline Linux.

Regards,
Siddharth.

 drivers/usb/cdns3/cdns3-gadget.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index fd1beb10bba7..e89bd248e81d 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -2145,6 +2145,16 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 		return -EINVAL;
 	}
 
+	/*
+	 * The Endpoint is configured to handle a maximum packet size of
+	 * max_packet_size. Hence, set priv_ep->endpoint.maxpacket to
+	 * max_packet_size. This is necessary to ensure that TD_SIZE and
+	 * TOTAL_TDL are calculated correctly in cdns3_ep_run_transfer(),
+	 * and also to ensure that TDL is calculated correctly in
+	 * cdns3_ep_run_stream_transfer().
+	 */
+	priv_ep->endpoint.maxpacket = max_packet_size;
+
 	if (max_packet_size == 1024)
 		priv_ep->trb_burst_size = 128;
 	else if (max_packet_size >= 512)
-- 
2.40.1


