Return-Path: <linux-kernel+bounces-324480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD27974CFE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D94BC288657
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C7C176FAC;
	Wed, 11 Sep 2024 08:45:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAC314A60E
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044339; cv=none; b=J3nOe2YW/tRJ//ornIaKFKPdyZCo9Sj1AFpNbRdjvXKpjKObuJbJaHaW/6g0W74/FyTlURQgY9Qux2kBWUAevsi0OPjDwMGu2lLejdjs2YzNxJFL/9q2DKb6F6yfnqVNe3dh+01Nl8Y0f/GokcoqVgih5KDXYkHuknrOEI7H0lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044339; c=relaxed/simple;
	bh=FYsbjJVzwxPaRyPqACbgrzhpJ2D/uLoe7SJ0dYP09Js=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nx/oUbo+bUfJrieh4s5dc6HIlJwo/D437H//iN//cW7SKFkUlJ6h+9z4QblSmH3K1a8f/wFfIiE6+KKV8mLIhIIUKpzaNeq+pXcHlSi1GlSN49LysTQ1/5PRrusuOZuz4vV3ktgJzNUsa6gGtpFZIREun95HZ8VVXGXmrIfRzyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1soIyl-0002g0-DZ
	for linux-kernel@vger.kernel.org; Wed, 11 Sep 2024 10:45:35 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1soIyk-00760M-Ik
	for linux-kernel@vger.kernel.org; Wed, 11 Sep 2024 10:45:34 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 3836A33815C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:45:34 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 29182338139;
	Wed, 11 Sep 2024 08:45:31 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id debe3747;
	Wed, 11 Sep 2024 08:45:30 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 11 Sep 2024 10:45:26 +0200
Subject: [PATCH can-next 2/2] can: rockchip_canfd:
 rkcanfd_handle_error_int_reg_ec(): fix decoding of error code register
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-can-rockchip_canfd-fixes-v1-2-5ce385b5ab10@pengutronix.de>
References: <20240911-can-rockchip_canfd-fixes-v1-0-5ce385b5ab10@pengutronix.de>
In-Reply-To: <20240911-can-rockchip_canfd-fixes-v1-0-5ce385b5ab10@pengutronix.de>
To: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.15-dev-88a27
X-Developer-Signature: v=1; a=openpgp-sha256; l=1660; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=FYsbjJVzwxPaRyPqACbgrzhpJ2D/uLoe7SJ0dYP09Js=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm4VioSw/JfPWRyX7TNulq+OD3P1if17X5AXUkc
 eelM/LXK+mJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZuFYqAAKCRAoOKI+ei28
 b3TBB/4tpzx27rhQMW8/qzL1OyS2I+lGF0hA0iAcYabRDbNQgvJc1eD2bwvuuXxGXgBBLIDSCrb
 mSRCs8Z0Tw0qWZJsbKCfjJq7+DgVi1vCjzQ2qFeDnhAPo4sMB5UTXrX1uf94WXVWPUfNapKPEMP
 mfb3zMgj/EPVH56I+aEmOPUqQtMnn/GORbtGgcOZx2bm/EsJ22trts64MkLFpIHE2U3I+95+0dL
 8m2gAvI4noaXh2v9ntqEIfrS1OQFWptO46NKmHXWbmcUFkacbH6TrKCJ4abBKrF88Tuiv7sR6rw
 +6YiakHcHj2+T4aZpqHar3krvFG6Mvj7nOohp9OHkIJz5YKh
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Probably due to a copy/paste error rkcanfd_handle_error_int_reg_ec()
checks twice if the RKCANFD_REG_ERROR_CODE_TX_ACK_EOF bit is set in
reg_ec.

Keep the correct check for RKCANFD_REG_ERROR_CODE_TX_ACK_EOF and
remove the superfluous one.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://patch.msgid.link/9a46d10d-e4e3-40a5-8fb6-f4637959f124@stanley.mountain
Fixes: ff60bfbaf67f ("can: rockchip_canfd: add driver for Rockchip CAN-FD controller")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 6883153e8fc15e82684d4f06447de3e88168b9ae..df18c85fc0784148d55d7a0086713555fb48c008 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -491,11 +491,9 @@ rkcanfd_handle_error_int_reg_ec(struct rkcanfd_priv *priv, struct can_frame *cf,
 		else if (reg_ec & RKCANFD_REG_ERROR_CODE_TX_CRC)
 			cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
 		else if (reg_ec & RKCANFD_REG_ERROR_CODE_TX_ACK_EOF)
-			cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+			cf->data[3] = CAN_ERR_PROT_LOC_ACK_DEL;
 		else if (reg_ec & RKCANFD_REG_ERROR_CODE_TX_ACK)
 			cf->data[3] = CAN_ERR_PROT_LOC_ACK;
-		else if (reg_ec & RKCANFD_REG_ERROR_CODE_TX_ACK_EOF)
-			cf->data[3] = CAN_ERR_PROT_LOC_ACK_DEL;
 		/* RKCANFD_REG_ERROR_CODE_TX_ERROR */
 		else if (reg_ec & RKCANFD_REG_ERROR_CODE_TX_OVERLOAD)
 			cf->data[2] |= CAN_ERR_PROT_OVERLOAD;

-- 
2.45.2



