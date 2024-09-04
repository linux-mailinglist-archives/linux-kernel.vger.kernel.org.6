Return-Path: <linux-kernel+bounces-315238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0346396BFB2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363FB1C2198B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C1E1DB947;
	Wed,  4 Sep 2024 14:08:19 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFFE1DA311
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458898; cv=none; b=JVpqBUQ4HAUO1quiDqfcyb2tvwB0PcBvbexzdJa+f61DAbWaojLOtC6A6EuzbFHT+05cH9O21c5paaFkJR1cd1nEc/ooVD7hnOH2sMZf5qVgjQiwZVNZDH77s5qcBStJDnt6dHTZMvtbNMOpjlgNwBOYPUmp4tmjOzDMsamdjOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458898; c=relaxed/simple;
	bh=kd9E40PQBFEWrTjYdxm/EiNgkyAQn3UseBk97RlZljA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qvLiMUG20698bBrkQ7k3pndJazbTN5RY7z+26d/daLOXpLvKevJDtJ2zRuW6dQfYKolZKvk6JrotNobMqN+KKeQrUza5LO50VQWKjHaaZHjp/DbKj6FK2oPe4PVAfVtE2SDEpd8+5y7Oc58+SaLMY02kMmEI9YdnVnGPfATvYhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1slqgA-00038p-Fg
	for linux-kernel@vger.kernel.org; Wed, 04 Sep 2024 16:08:14 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1slqg9-005TSO-Sf
	for linux-kernel@vger.kernel.org; Wed, 04 Sep 2024 16:08:13 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 8F2B8332980
	for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 14:08:13 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 744AC33295B;
	Wed, 04 Sep 2024 14:08:10 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id efa89c82;
	Wed, 4 Sep 2024 14:08:09 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 0/2] arm64: dts: rockchip: rk3568: add CAN-FD controller
Date: Wed, 04 Sep 2024 16:07:55 +0200
Message-Id: <20240904-rk3568-canfd-v1-0-73bda5fb4e03@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALtp2GYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSwMT3aJsY1MzC93kxLy0FF1T40RTM6PE1DQDszQloJaCotS0zAqwcdG
 xtbUA3n1WF14AAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: kernel@pengutronix.de, David Jander <david@protonic.nl>, 
 Alibek Omarov <a1ba.omarov@gmail.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=kd9E40PQBFEWrTjYdxm/EiNgkyAQn3UseBk97RlZljA=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm2GnFxpWKaInvtdWH/pDwe0TPVCSfLmYkktUa/
 G64Np4mB16JATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZthpxQAKCRAoOKI+ei28
 bxc1B/9Xhh40JT5rXUQwzROGWVPCn8HbwD6tU+C0mluTt1awCG6CpnaSCUyTIMwwrQ3ASng2WRk
 xTYZu20Jf7Y0bj/wEFWK6hzCuptxeva3n2Mp/0FUx8bw94U8yR6gcflLTgRwGaUFnnyYzNiWp1i
 aNXEYI6ccnoT4E+9oZbUgHMni22hAg30cfo00L3E7009MzRVch/JQhMWM0EET2oJgVjsY9/jd2a
 qOQt3snn2qujw21cd20jJVC4vB3UpmfS5eYPODLBtBWSdTRhWI4tsFk9I4PG+eV+Dyhhiq7/IYN
 VjyG2qc5V2SZ+fpCAb/LAldGXXqiU4labSxCRi5m3PwbwiUO
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This series first adds the CAN-FD controllers nodes to the rk3568
devicetree, then it enables the CAN-FD controllers on the
rk3568-mecsbc board.

The DT bindings for this series are going upstream via
can-next/net-next into v6.12 with this PR:

| https://patch.msgid.link/all/20240904130256.1965582-1-mkl@pengutronix.de

So when applied to v6.12-armsoc/dts64 this series produces checkpatch
warnings about undocumented DT compatible strings. Maybe we have to
postpone this series a bit.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes:
- rk3568-mecsbc: fixed order of phandles (thanks Heiko)
- These Patches were previously part of another series and have now
  been spun off.
- Link to previous version: https://patch.msgid.link/20240904-rockchip-canfd-v5-0-8ae22bcb27cc@pengutronix.de

---
David Jander (2):
      arm64: dts: rockchip: add CAN-FD controller nodes to rk3568
      arm64: dts: rockchip: mecsbc: add CAN0 and CAN1 interfaces

 arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts | 14 +++++++++
 arch/arm64/boot/dts/rockchip/rk3568.dtsi       | 39 ++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)
---
base-commit: 78d500329b65217c45422ac0adf5c030783d3e58
change-id: 20240904-rk3568-canfd-53a562aef06f

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



