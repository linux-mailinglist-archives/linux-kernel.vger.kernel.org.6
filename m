Return-Path: <linux-kernel+bounces-368822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A65979A1543
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA7728626E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41BF1DB546;
	Wed, 16 Oct 2024 21:52:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE76D1D5CF9
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115556; cv=none; b=Mu7Glx2tPQGf9c76/7QO5imDfpvA02DPBo4x5IAiFc3mjqNEy/UFZMwy//hQ6C5BusJ4siTMdN0DXTfQbMi/IHNu01MTHnknf3SJHICyLxiPuWLyA1tBmWgtGI9MwnITJIAmcfrYEpnNjVnY3PTzStFJgg2BV4L43YxkCgOGbfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115556; c=relaxed/simple;
	bh=r2Bczt3iY/LW5Q+NASe8BndjjkWWTrpEdZ4llRpFXxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t92h5DQtosOzV4Zl0Exs2kK+/Ma07ddcHR0Or2LOUtIeMT6NII2HEWjQcoomJlqEpoHhLFU0t6XrZmQHvvwRZlKk4m73oFXgunpJXi86VfyVRYQJ4Nnod6Q4+Yu5tAISKmT4v6mc1hgo5jydh/lyRHAq2A0RE++P9CE2o2uh4s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1BwU-0003Ru-D4
	for linux-kernel@vger.kernel.org; Wed, 16 Oct 2024 23:52:30 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1BwQ-002OUu-Jr
	for linux-kernel@vger.kernel.org; Wed, 16 Oct 2024 23:52:26 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 4AE0E35492F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:52:26 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 53CF9354884;
	Wed, 16 Oct 2024 21:52:20 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 6890ce52;
	Wed, 16 Oct 2024 21:52:19 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 16 Oct 2024 23:51:54 +0200
Subject: [PATCH net-next 06/13] net: fec: fec_restart(): make use of
 FEC_ECR_RESET
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-fec-cleanups-v1-6-de783bd15e6a@pengutronix.de>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
In-Reply-To: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=837; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=r2Bczt3iY/LW5Q+NASe8BndjjkWWTrpEdZ4llRpFXxs=;
 b=owGbwMvMwMWoYbHIrkp3Tz7jabUkhnQB07Z3H6xXrwh34VPUf3Avj2XyPtvVSVqLOysvBUw7N
 UurYKpgJ6MxCwMjF4OsmCJLgMOutgfbWO5q7rGLhxnEygQyhYGLUwAmIryNg2G6xm27LN3Fv3VX
 fv6TO+ulrVjoktyfgg9y2H7U3N+pkda/pICJ7btt+++PZhkVmcZfjgvrXWp+/+DcW+Zf87xU33h
 Mbp+U9Vm/128Jq+fn7ybN+6YFVPz6GcXrvJHbOMjragyvzu+60Jqo1yUhVi/urd1hnRoj8tOly/
 mM97e8ZE2ZpMt3VloyHnILv3g4h/vUEpPeP5ILlV2Ct0oZirpuSsjNZZDcpDitaLG8sKH/xW+3W
 9tmKuQ5Tw2TWdx4059RO87peGLF2cDqruW/+bfH6G+5qvlJK+veg7bdCsLPNLkkUn/cfSBTf92l
 PkmE7+bk52+NDhk2CM4U/yLePN24zIJxJ6vEQcWb4WkrAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Replace the magic number "1" by the already existing define
FEC_ECR_RESET.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 2ee7e4765ba3163fb0d158e60b534b171da26c22..d948ed9810027d5fabe521dc3af2cf505dacd13e 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1089,7 +1089,7 @@ fec_restart(struct net_device *ndev)
 	    ((fep->quirks & FEC_QUIRK_NO_HARD_RESET) && fep->link)) {
 		writel(0, fep->hwp + FEC_ECNTRL);
 	} else {
-		writel(1, fep->hwp + FEC_ECNTRL);
+		writel(FEC_ECR_RESET, fep->hwp + FEC_ECNTRL);
 		udelay(10);
 	}
 

-- 
2.45.2



