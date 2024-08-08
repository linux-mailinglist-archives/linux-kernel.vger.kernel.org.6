Return-Path: <linux-kernel+bounces-279159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460EB94B9BB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38E8281166
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5153D1898E1;
	Thu,  8 Aug 2024 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="T3Qqp8+q"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB48584A51
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723109700; cv=none; b=r2lG73XzuEE1nTuNCGFvDEcGXJPZ1L8tiBa/qxO7VzB29J+MgLqluZiNPq57aW3Y0AzK+1n//eCaLREjeJoflEce57ZZk8fDYG+QwEa5dlp22gOg0olbCUag0UoBwsjHSeLHpROd8NArAm79LHOELN7tNxfbkfGsyD2G6JBUqCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723109700; c=relaxed/simple;
	bh=dw0hDc4N+New1YNkCHwaTg6SvF73/Z+JYHmdWlzrch4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=ssnAWauxA9BWwNILhbng/1Qv76c8oo56xbcBib8pRsbGQ3OtG8e2wyIeP/FKpnZdOeKNukQPcSvDv3CmapaL9IseOa+bXKhYs3hO3kOKVzOpmcd8HcuNslA9sK94HaYvTsbcnj//EU7xr6dSa/PzGucXrHuoKo/zY0xhcm6SA+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=T3Qqp8+q; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1723109695; x=1725701695;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dw0hDc4N+New1YNkCHwaTg6SvF73/Z+JYHmdWlzrch4=;
	b=T3Qqp8+qDQafcon5AQkU2eNNw7G3N572fFXiUFm3BPem8HLw9HEUfJsj+T8PT7z4
	3Snc6P2qAlcV7GYO4EGECa63kODKb8buNtk21sGOZtKjKK7QKxpu7mA/H4O92c6k
	NoqeLOgqwT8AINXHEL2bl7ZUamycL5LkTCLLZ9bIbBc=;
X-AuditID: ac14000a-03251700000021bc-a5-66b4913fd30a
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 81.3B.08636.F3194B66; Thu,  8 Aug 2024 11:34:55 +0200 (CEST)
Received: from llp-hahn.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 8 Aug 2024
 11:34:54 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Thu, 8 Aug 2024 11:34:49 +0200
Subject: [PATCH] dts: freescale: imx8mp-phyboard-pollux-rdk: Add console
 UART bootargs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240808-add_bootargs_to_devicetree-v1-1-79f7ba50b174@phytec.de>
X-B4-Tracking: v=1; b=H4sIADiRtGYC/x3MMQqAMAxA0atIZgtRRKxXESm1iZrFSlpEEO9uc
 XzD/w8kVuEEY/WA8iVJ4lHQ1BWE3R8bG6FiaLHtcMDBeCK3xJi9bsnl6KhEgbMym94ikrWLX/s
 AZXAqr3L/82l+3w/z6RcnbAAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Teresa Remmet
	<t.remmet@phytec.de>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723109694; l=908;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=dw0hDc4N+New1YNkCHwaTg6SvF73/Z+JYHmdWlzrch4=;
 b=zHbYCNKN6V6oVjk8YRE4jWVidcoXg+5EeelHNDOy2Sr6nb7KcKqfYg5x3Bi6xMZyKQnwZ9khf
 aAFarcE98nEBDMmtWxlFGniDZKMVKAGAlqGQ2LXUF9LHuaZ5oGHos0S
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42JZI8nAo2s/cUuaQf9zDos1e88xWcw/co7V
	4uFVf4uZ91rZLFZN3cli8XLWPTaLTY+vsVpc3jWHzeL/nh3sFn+3b2KxeLFF3KL7nboDj8fO
	WXfZPTat6mTz2Lyk3uPF5pmMHv3dLawe/X8NPD5vkgtgj+KySUnNySxLLdK3S+DK+PRvBnNB
	H3vFss/7mBsYJ7F1MXJySAiYSHzq6WTtYuTiEBJYwiSx4+J8dgjnAaPEmc+vmUGq2ATUJHa9
	ec0KYrMIqEhsPfYOLC4sECGx8/ZfdhCbV0BQ4uTMJyxdjBwczAKaEut36YOEmQXkJba/ncMM
	UeIr0b72Mdh8CYEdjBKbFuwFu0JEYAeTxON+Q5AEs8BBRon153cyQ5wnLPF59xo2iI5dTBLd
	v+8wg2yQEEiU2PlaDqRGSEBW4ub5LVDvyEtMO/caqjdUYuuX7UwTGIVnIblvFsJ9s5Dct4CR
	eRWjUG5mcnZqUWa2XkFGZUlqsl5K6iZGUJSJMHDtYOyb43GIkYmD8RCjBAezkghvc/imNCHe
	lMTKqtSi/Pii0pzU4kOM0hwsSuK8qzuCU4UE0hNLUrNTUwtSi2CyTBycUg2MG488v1L4Vevo
	o2+1U4ujj39/xXzr1e+1XzqCwssE2eJF/7dqZTxz+Ken9er4zyhe9xmHFHqTdk6endOyb/t8
	y2kZitN55lx4fnZn0q7qXyb58lUq/xlYZQ49fTA7dsrvexniavJObdflOK+sD6zqCf/w+fr1
	mtxiJUmGlVel+zjj5n/9yXxkiRJLcUaioRZzUXEiAO21qEugAgAA

Pass the console UART bootargs parameter via the devicetree for booting
EFI binaries.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
index 00a240484c25..552b528fb663 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
@@ -16,6 +16,7 @@ / {
 		     "phytec,imx8mp-phycore-som", "fsl,imx8mp";
 
 	chosen {
+		bootargs = "console=ttymxc0,115200";
 		stdout-path = &uart1;
 	};
 

---
base-commit: 17712b7ea0756799635ba159cc773082230ed028
change-id: 20240808-add_bootargs_to_devicetree-6900d99baf6c

Best regards,
-- 
Benjamin Hahn <B.Hahn@phytec.de>


