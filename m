Return-Path: <linux-kernel+bounces-222036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B394E90FBE1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D18A1F23C5D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 04:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A75EC7;
	Thu, 20 Jun 2024 04:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="ga2GhdmY"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCE1224CE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 04:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718856731; cv=none; b=RN9BXKVTy51iyNY5Ot5G/5c9qMHsxyLrlTA9ohJXCkMAispcv0R5cazX/FFHEHNUT0Qkclhgu58cdOWB9MYYQONKfdTuQd4yT9CQT1LAbnQjJvzibTaLIBIdssJqill3mnY1N1Y6xcvJrcMnzBuByni89c/u2KWoQsf8A8L0m8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718856731; c=relaxed/simple;
	bh=aPsYJOVzcEVzbyF9dNUx19mkstx4hNHbolSbJAhNQXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tIbztqiC1yMPDSrFYnIguX9iAdXvjwIQFnSKlcwUxneHd24CSUc3Tfkrhl2iDTXY+yaGaZdqn2g744NN4VHGEgeefrnwuWeqMYD0gExnzanSmJgPOCANjheKM6JUNb3AN3ARwcoDnLsX3yh1sOEFfqKmrNnVXLmX8xtGQfAEXL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=ga2GhdmY; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 33E3F2C041E;
	Thu, 20 Jun 2024 16:12:06 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1718856726;
	bh=LjErDauhNJbMedMS8Kk9A/fllU4EgkRiXtuqKdmdTLs=;
	h=From:To:Cc:Subject:Date:From;
	b=ga2GhdmYiPpNeb32B7Q+TlGwDAQHMljzrc86bjZLrLGtKT9JWaVTsCqNw8z8MV5AF
	 nOMmYJvLpjJ1tQzYeF1cYpBWFSQZ7P65sCNhzVTOhd2WAkwFY6idb31Hm9F+bCLQRC
	 Yg6HjeRFUA+VgYUsXx7i6dO7DZkSj7SCNnpDouV2mgG2OSLT7HEK/ynPLfLcY+k+ss
	 BJfmmz1h4eeri4xRYlm1WNCetblvPlRXzlU0RbiOfU18u6Yc5pMhckhmJc2cNVsPA1
	 O88Ndxw6fw4AAKuS+NogCLq4314jrRY214rREJQvnaIRZGtd6lCR2o+yPnM2cnxdbB
	 8joGF3jUy7i+g==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6673ac160000>; Thu, 20 Jun 2024 16:12:06 +1200
Received: from aryans-dl.ws.atlnz.lc (aryans-dl.ws.atlnz.lc [10.33.22.38])
	by pat.atlnz.lc (Postfix) with ESMTP id 0EA8F13ED63;
	Thu, 20 Jun 2024 16:12:06 +1200 (NZST)
Received: by aryans-dl.ws.atlnz.lc (Postfix, from userid 1844)
	id 0B5F62A0FF5; Thu, 20 Jun 2024 16:12:06 +1200 (NZST)
From: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v0] net: mvpp2: fill-in dev_port attribute
Date: Thu, 20 Jun 2024 16:12:02 +1200
Message-ID: <20240620041202.3306780-1-aryan.srivastava@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=CvQccW4D c=1 sm=1 tr=0 ts=6673ac16 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=T1WGqf2p2xoA:10 a=hHNv8qNozdUxR9ekqBsA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Fill this in so user-space can identify multiple ports on the same CP
unit.

Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/ne=
t/ethernet/marvell/mvpp2/mvpp2_main.c
index 23adf53c2aa1..7cf9a0f5b583 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -6903,6 +6903,7 @@ static int mvpp2_port_probe(struct platform_device =
*pdev,
 	/* 9704 =3D=3D 9728 - 20 and rounding to 8 */
 	dev->max_mtu =3D MVPP2_BM_JUMBO_PKT_SIZE;
 	device_set_node(&dev->dev, port_fwnode);
+	dev->dev_port =3D port->id;
=20
 	port->pcs_gmac.ops =3D &mvpp2_phylink_gmac_pcs_ops;
 	port->pcs_gmac.neg_mode =3D true;
--=20
2.43.2


