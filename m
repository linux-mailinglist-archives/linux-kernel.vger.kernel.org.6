Return-Path: <linux-kernel+bounces-268904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CE0942AF6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59721281F0D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AA91B3720;
	Wed, 31 Jul 2024 09:38:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982D51B012C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418696; cv=none; b=P13I0xu2kqFOCXuUugSAL/xapSvc4CZxcYR/ZYN17nrCTcabHPVNsE1HiNjSB5gg/YHUXrDa158C0VOQDDwP5gkGh0ZZXoqrmC4nHZWqf7dmGpG9EQps4O12yz5VtDqKoTKiG3jFZAFfTByd33Md+N7KMpCI7jks89ql/wMRjc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418696; c=relaxed/simple;
	bh=0fQxig7gDaZbE8nWIiLavEYV63pJFyEPC6WX7ivRp0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B27cyrbytnH+fdwu+CwSK4JaVhsDu72jtKB4Z2bk5Xbtsglbt8oTIU2TBwsHPKpSSbzUEO6umtG0xrjn1Ej7qXeT9bMQ1XjOJg4I4+yRE8wtpOYP7+4S8hWKDk+vU89I3CSTk4EbjD5VNf4jKk37ZGszOhKQRPwyZAPIEEIAcD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sZ5mb-0005mZ-I9
	for linux-kernel@vger.kernel.org; Wed, 31 Jul 2024 11:38:09 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sZ5mS-003Uw2-Ny
	for linux-kernel@vger.kernel.org; Wed, 31 Jul 2024 11:38:00 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 3770D312940
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:38:00 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 5B257312860;
	Wed, 31 Jul 2024 09:37:54 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 48719550;
	Wed, 31 Jul 2024 09:37:42 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 31 Jul 2024 11:37:15 +0200
Subject: [PATCH can-next v2 13/20] can: rockchip_canfd: implement
 workaround for erratum 12
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-rockchip-canfd-v2-13-d9604c5b4be8@pengutronix.de>
References: <20240731-rockchip-canfd-v2-0-d9604c5b4be8@pengutronix.de>
In-Reply-To: <20240731-rockchip-canfd-v2-0-d9604c5b4be8@pengutronix.de>
To: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 David Jander <david.jander@protonic.nl>
Cc: Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1861; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=0fQxig7gDaZbE8nWIiLavEYV63pJFyEPC6WX7ivRp0I=;
 b=owGbwMvMwMWoYbHIrkp3Tz7jabUkhrRVrDe33Szp7Pi3wO5i9Cc/jx+NjP8fmdyY7Ha/seF0k
 lPWxX3TOxmNWRgYuRhkxRRZAhx2tT3YxnJXc49dPMwgViaQKQxcnAIwkc3fOBj6C1nvmE9Kuz+L
 /7mWQ+A0vbBOudN7U67M+i5ocK3epKVx8Z4NBuv09i9nbp7BGVvi+6LK5/6X5D41tSr2v58P9Ea
 quzoGL21/wzCRzdTagvnbVKmE9gzdC+VKaoxT7zQJsPcKKu/Sk/trGLJaVyCzgcmqrsJ2WWGBqm
 692Yrkfx9Pt3jI39tmfavqhsr1QwVl4VbH3Tscky1vGOlVzbpYumXVDyV5blWW3I8h+4vki7etF
 Ywqn5H7b7LpU8Hv1g9267Gdn/1dIdbtIe8C/ewjKnxnb559mu+a8VT5um6sdX64i+Df0tTr5Xy/
 Sx5fnry8XEvAV3Gpb8/cygWyDYx7Pqyt23HnULe6lWoIAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The rk3568 CAN-FD errata sheet as of Tue 07 Nov 2023 11:25:31 +08:00
says:

| A dominant bit at the third bit of the intermission may cause a
| transmission error.
|
| When sampling the third bit of the intermission as a dominant bit, if
| tx_req is configured to transmit extended frames at this time, the
| extended frame may be sent to the bus in the format of a standard
| frame. The extended frame will be sent as a standard frame and will not
| result in error frames

Turn on "Interframe Spaceing RX Mode" only during TX to work around
erratum 12, according to rock-chip:

| Spaceing RX Mode = 1, the third Bit between frames cannot receive
| and send, and the fourth Bit begins to receive and send.
|
| Spaceing RX Mode = 0, allowing the third Bit between frames to
| receive and send.

Message-ID: <be72939f-0a9e-0608-dfff-7b0096a26eba@rock-chips.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-tx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
index e98e7a836b83..9db6d90a4e7f 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
@@ -11,7 +11,14 @@
 static void rkcanfd_start_xmit_write_cmd(const struct rkcanfd_priv *priv,
 					 const u32 reg_cmd)
 {
+	if (priv->devtype_data.quirks & RKCANFD_QUIRK_RK3568_ERRATUM_12)
+		rkcanfd_write(priv, RKCANFD_REG_MODE, priv->reg_mode_default |
+			      RKCANFD_REG_MODE_SPACE_RX_MODE);
+
 	rkcanfd_write(priv, RKCANFD_REG_CMD, reg_cmd);
+
+	if (priv->devtype_data.quirks & RKCANFD_QUIRK_RK3568_ERRATUM_12)
+		rkcanfd_write(priv, RKCANFD_REG_MODE, priv->reg_mode_default);
 }
 
 void rkcanfd_xmit_retry(struct rkcanfd_priv *priv)

-- 
2.43.0



