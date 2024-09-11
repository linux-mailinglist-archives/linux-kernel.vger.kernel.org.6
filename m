Return-Path: <linux-kernel+bounces-324944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC133975308
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3F11C220B4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2FC19259F;
	Wed, 11 Sep 2024 12:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="gY9oOD/X"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED4F1714AC
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726059513; cv=none; b=EtufZCYO3k0K/RpG6ZOiggQMmRCGJaE8zExtxGPY9qptqaitTcJA3HihYh+glGBz04CTw72mQkdFeEV8+0o9+ZdbFaLPbUiBBbHZr0Ht2KW3WSKDAYIxW6Adag3BfTky7WHfkEhmr4VZYewJzxsRMHeucxb+fNfctLFpjuPXqFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726059513; c=relaxed/simple;
	bh=H9016pDN+jnRk7afjG42UwRS+TxBKUvEeWbGSrqKomQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VfhTvA/EyrEXCo9wOck4UtlCVSkYYW0hUCOI3Wu/E+Jte4mizdl8Xmdwl2OQwQI5txZVvqWwXjaqn8pfC6gD8AXBWyy8naI29WxixO+LhFhfh1V9mNOb+9hGYCyhIB5oAHI59vvAx80HFps5k77DLjnGo3mdkxQZmd4HsyZV1Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=gY9oOD/X; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1726058585; x=1728650585;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=H9016pDN+jnRk7afjG42UwRS+TxBKUvEeWbGSrqKomQ=;
	b=gY9oOD/Xt73+euTy58ORHsy/weqhaTgWe3duHlVnA2c8pk1hX0s1M8W9B3cedMXF
	0de/iviFAQ2s5Oggm7sMxQAGyB9WXe360r2pCvbAKwm+xgIAV4nFsGeMP4ZhCb4M
	Xs/rMMvV0lGdH0fCn4by8PuymrR9BtvZ6Vg5TRhDyPM=;
X-AuditID: ac14000a-4637f70000004e2a-df-66e19059ef28
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 3A.35.20010.95091E66; Wed, 11 Sep 2024 14:43:05 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 11 Sep
 2024 14:43:05 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
CC: <d.schultz@phytec.de>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
Subject: [PATCH 1/3] arm64: dts: ti: k3-am62-phycore-som: Add M4F remoteproc nodes
Date: Wed, 11 Sep 2024 14:42:49 +0200
Message-ID: <20240911124251.702590-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsWyRpKBRzdywsM0g7+njCzW7D3HZDH/yDlW
	i+WfZ7NbvJx1j81i0+NrrBaXd81hs3jz4yyTxf89O9gtut+pW/w/+4Hdgctj06pONo/NS+o9
	+rtbWD2O39jO5PF5k1wAaxSXTUpqTmZZapG+XQJXxuHfuxkLbgtU/Dz4hLGBcS9vFyMHh4SA
	icTVY4VdjFwcQgJLmCRmT2ljhnAeM0qsP7KXqYuRk4NNQF3izoZvrCAJEYE2RomVf6+zgTjM
	ApMYJS78+8kCUiUsECTR8+AHWAeLgKrEm+O/2EFW8ApYSKx4JQ0SlhCQl5h56Ts7iM0rIChx
	cuYTsFZmoHjz1tnMELaExMEXL8BsIaD4i0vLWWB6p517zQxhh0ps/bKdaQKjwCwko2YhGTUL
	yagFjMyrGIVyM5OzU4sys/UKMipLUpP1UlI3MYJCX4SBawdj3xyPQ4xMHIyHGCU4mJVEePvt
	7qUJ8aYkVlalFuXHF5XmpBYfYpTmYFES513dEZwqJJCeWJKanZpakFoEk2Xi4JRqYKx5PKXg
	nZ3V8+OdTM46hiHyDRzuL28vl/A47+5bELpRKX2dq0x8mK6F7v95nh8viOzp40+5EeCnsdbJ
	T9tY94LcNf6U+3eYbqdNOfGk6OxNf6cojexnG2Jt55o1Zbo2OslVyytZHNiw5UxIUcxcGV+P
	SsezNqfYjad466tyTF5vLXXrpusuJZbijERDLeai4kQAODGEDWsCAAA=

The AM62x SoCs of the TI K3 family have a Cortex M4F core in the MCU
domain. This core can be used by non safety applications as a remote
processor. When used as a remote processor with virtio/rpmessage IPC,
two carveout reserved memory nodes are needed. The first region is used
as a DMA pool for the rproc device, and the second region will furnish
the static carveout regions for the firmware memory.

The current carveout addresses and sizes are defined statically for
each rproc device. The M4F processor does not have an MMU, and as such
requires the exact memory used by the firmware to be set-aside.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 .../boot/dts/ti/k3-am62-phycore-som.dtsi      | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
index 43488cc8bcb1..bbf99938c187 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
@@ -45,6 +45,18 @@ ramoops@9ca00000 {
 			pmsg-size = <0x8000>;
 		};
 
+		mcu_m4fss_dma_memory_region: m4f-dma-memory@9cb00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9cb00000 0x00 0x100000>;
+			no-map;
+		};
+
+		mcu_m4fss_memory_region: m4f-memory@9cc00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9cc00000 0x00 0xe00000>;
+			no-map;
+		};
+
 		secure_tfa_ddr: tfa@9e780000 {
 			reg = <0x00 0x9e780000 0x00 0x80000>;
 			alignment = <0x1000>;
@@ -196,6 +208,13 @@ cpsw3g_phy1: ethernet-phy@1 {
 	};
 };
 
+&mailbox0_cluster0 {
+	mbox_m4_0: mbox-m4-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
+
 &main_i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
@@ -295,6 +314,13 @@ i2c_som_rtc: rtc@52 {
 	};
 };
 
+&mcu_m4fss {
+	mboxes = <&mailbox0_cluster0 &mbox_m4_0>;
+	memory-region = <&mcu_m4fss_dma_memory_region>,
+			<&mcu_m4fss_memory_region>;
+	status = "okay";
+};
+
 &ospi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ospi0_pins_default>;
-- 
2.34.1


