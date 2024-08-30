Return-Path: <linux-kernel+bounces-309379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7BA966989
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 21:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8239F1C21D41
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D67E1BE24A;
	Fri, 30 Aug 2024 19:26:59 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDDA1BD038
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725046018; cv=none; b=sjaJWk07k525xlBNa0jW2/F0EgdtuK3lOSfWHuf9/Ml5WkmtLTAzEEuHLbzjOSSIGWtkZUIRrK4xZLAmEY0hjupFeLKfI3LQT5vlrHVG3QZqtEAEOOiXRLkK3pm8nfbVEMhgXuuXuku7zpRwYZ1dpZjeU54tLNf5mAsMEYEb7pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725046018; c=relaxed/simple;
	bh=H+PYOR8/pV6bhxws++RaYVUTR55YYubqw7tU6wNDWQM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fNxgtUBjp8AaDtWOgZzKhJ36zhFzj7fKsDO4kwD24POPwADF1t3RxhcGGeyvDUxrUpQKKoavBvvC1XzNwJwcqVcCETiTceTejjvAkfPEpvGhsdCVHHIFaaoMLhgv9R7L6j/WK3i0ZN1SXGZ5D7BWLQX3EIAp/I7p++wh7t9lLbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk7Gn-000699-V6
	for linux-kernel@vger.kernel.org; Fri, 30 Aug 2024 21:26:53 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk7Gl-004Dez-42
	for linux-kernel@vger.kernel.org; Fri, 30 Aug 2024 21:26:51 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id BCE7832E15D
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 19:26:50 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id D41AF32E0ED;
	Fri, 30 Aug 2024 19:26:45 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3f107de8;
	Fri, 30 Aug 2024 19:26:45 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH can-next v3 00/20] can: rockchip_canfd: add support for
 CAN-FD IP core found on Rockchip RK3568
Date: Fri, 30 Aug 2024 21:25:57 +0200
Message-Id: <20240830-rockchip-canfd-v3-0-d426266453fa@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMYc0mYC/3XNTQqDMBAF4KvIrJuSP7XtqvcoXWgy0aEQJbHBI
 t69IauCdPl4877ZIGIgjHCrNgiYKNLkc1CnCszY+QEZ2ZxBcql5K68sTOZlRpqZ6byzTEulTCs
 cN6aBPJoDOloL+IB8wjyuCzxzM1JcpvApn5Io/T80CcaZ64SsubNNj+o+ox/eS5g8rWeLxUvyx
 1DiYMhs2GvDtal73ePlYOz7/gVt4Rve/wAAAA==
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
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 David Jander <david@protonic.nl>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=4059; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=H+PYOR8/pV6bhxws++RaYVUTR55YYubqw7tU6wNDWQM=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm0hzVl2FusVAXajEAut0yssqC7y0Gu1zy4gIQO
 J7dkX4BM+uJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZtIc1QAKCRAoOKI+ei28
 b4nFB/oDFFbNrBZNRWM68rKM9Dx6p3rXrYlTHGVFsb04k4tFOiUc0LHTcbv8PlA31BKSPfRi5xX
 r77ZZJ0JmW9OB3U3spouu31qQ0gMg9TwOkdHB8+YKJ9k3Uf36nxaSzCFWmka636qRENwZNhMKI8
 hk/1rb/9leFMzD2zHTaAsDI2C8ZJ6E58A3yh2+H6vZgLjYuI7nc1n2GZcjcvZtRg0usiconKlLA
 XCm3+y+6vjPk2KpKiN8YlLungWVA9otU9ygnSxYEl/gA8S5I0Q9P4oTYdFOFtRl6aOFkVeG1p+u
 kLSXuwmQnoELPsixa3/z+O7X9wP6nK8Jo6kthCn3hDC9JXBR
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This series adds support for the CAN-FD IP core found on the Rockchip
RK3568.

The IP core is a bit complicated and has several documented errata.
The driver is added in several stages, first the base driver including
the RX-path. Then several workarounds for errata and the TX-path, and
finally features like hardware time stamping, loop-back mode and
bus error reporting.

regards,
Marc

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v3:
- dt-bindings: renamed file to rockchip,rk3568-canfd.yaml (thanks Rob)
- dt-bindings: reworked compatibles (thanks Rob)
- Link to v2: https://lore.kernel.org/all/20240731-rockchip-canfd-v2-0-d9604c5b4be8@pengutronix.de

Changes in v2:
- dt-bindings: remove redundant words from subject and patch
  description (thanks Rob)
- dt-bindings: clean up clock- and reset-names (thanks Rob)
- base driver: add missing bitfield.h header
- base driver: rkcanfd_handle_rx_int_one(): initialize header to avoid
  uninitialzied variable warning on m68k
- base driver: rkcanfd_get_berr_counter_raw(): don't add assigned only
  variable (bec_raw), move to 14/20 (thanks Simon)
- CAN-FD frame equal check + TX-path: squash, to avoid unused
  functions (thanks Simon)
- TX-path: rkcanfd_handle_tx_done_one(): don't add assigned only
  variable (skb), move to 18/20 (thanks Simon)
- HW-timetamping: add missing timecounter.h header (thanks Simon)
- Link to v1: https://lore.kernel.org/all/20240729-rockchip-canfd-v1-0-fa1250fd6be3@pengutronix.de

---
David Jander (2):
      arm64: dts: rockchip: add CAN-FD controller nodes to rk3568
      arm64: dts: rockchip: mecsbc: add CAN0 and CAN1 interfaces

Marc Kleine-Budde (18):
      dt-bindings: can: rockchip_canfd: add rockchip CAN-FD controller
      can: rockchip_canfd: add driver for Rockchip CAN-FD controller
      can: rockchip_canfd: add quirks for errata workarounds
      can: rockchip_canfd: add quirk for broken CAN-FD support
      can: rockchip_canfd: add support for rk3568v3
      can: rockchip_canfd: add notes about known issues
      can: rockchip_canfd: rkcanfd_handle_rx_int_one(): implement workaround for erratum 5: check for empty FIFO
      can: rockchip_canfd: rkcanfd_register_done(): add warning for erratum 5
      can: rockchip_canfd: add TX PATH
      can: rockchip_canfd: implement workaround for erratum 6
      can: rockchip_canfd: implement workaround for erratum 12
      can: rockchip_canfd: rkcanfd_get_berr_counter_corrected(): work around broken {RX,TX}ERRORCNT register
      can: rockchip_canfd: add stats support for errata workarounds
      can: rockchip_canfd: prepare to use full TX-FIFO depth
      can: rockchip_canfd: enable full TX-FIFO depth of 2
      can: rockchip_canfd: add hardware timestamping support
      can: rockchip_canfd: add support for CAN_CTRLMODE_LOOPBACK
      can: rockchip_canfd: add support for CAN_CTRLMODE_BERR_REPORTING

 .../bindings/net/can/rockchip,rk3568-canfd.yaml    |  74 ++
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts     |  14 +
 arch/arm64/boot/dts/rockchip/rk3568.dtsi           |  39 +
 drivers/net/can/Kconfig                            |   1 +
 drivers/net/can/Makefile                           |   1 +
 drivers/net/can/rockchip/Kconfig                   |   9 +
 drivers/net/can/rockchip/Makefile                  |  10 +
 drivers/net/can/rockchip/rockchip_canfd-core.c     | 969 +++++++++++++++++++++
 drivers/net/can/rockchip/rockchip_canfd-ethtool.c  |  73 ++
 drivers/net/can/rockchip/rockchip_canfd-rx.c       | 299 +++++++
 .../net/can/rockchip/rockchip_canfd-timestamp.c    | 105 +++
 drivers/net/can/rockchip/rockchip_canfd-tx.c       | 167 ++++
 drivers/net/can/rockchip/rockchip_canfd.h          | 553 ++++++++++++
 14 files changed, 2322 insertions(+)
---
base-commit: cff69f72d33318f4ccfe7d5ff6c5616d00dd45a7
change-id: 20240729-rockchip-canfd-4233c71f0cc6

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



