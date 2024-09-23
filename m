Return-Path: <linux-kernel+bounces-335439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8553197E5BF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 07:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478D5281684
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 05:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CEF1642B;
	Mon, 23 Sep 2024 05:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deepcomputing-io.20200927.dkim.feishu.cn header.i=@deepcomputing-io.20200927.dkim.feishu.cn header.b="YMFGpOCB"
Received: from va-2-31.ptr.blmpb.com (va-2-31.ptr.blmpb.com [209.127.231.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE42F17BA5
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 05:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727070635; cv=none; b=gyUq/hkID80w9Sr2pBpuk8u9wFYN6vEcaQRTsEpzrBiiHfff7OR8mjCBE9w74rfyRvlvwrZXGqY6m22Mfa7A7DSDiIlBmeQAQzUnjDOAqVniIIc4JTaQun/Mj9tVkVnbHQxPZYcoMLIDPsj2vXjeN7W87YcDYPB1orVgMPt8m6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727070635; c=relaxed/simple;
	bh=ptmjIw8FJAcZmr3i7dr2a/bUUTxikO1K9k2lxjjHBJ0=;
	h=Cc:From:Date:Message-Id:To:Content-Type:Mime-Version:Subject; b=OIZwTcuEtpLyNk8IMPnI34nj9NmwWxJ5yk9uOLXjeg8HvTDRUrJqS+NhjoE3qWxFqiKun0ewPLayIOss+MM13AIqmoSNqN+D6sXcUa7tD1bwFiPPqknXbpnLkDb1cJGDE2DpyQEOrfcwuV07VwwhE9xie4m2mJtN93nfGvVogXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepcomputing.io; spf=pass smtp.mailfrom=deepcomputing.io; dkim=pass (2048-bit key) header.d=deepcomputing-io.20200927.dkim.feishu.cn header.i=@deepcomputing-io.20200927.dkim.feishu.cn header.b=YMFGpOCB; arc=none smtp.client-ip=209.127.231.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepcomputing.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepcomputing.io
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=deepcomputing-io.20200927.dkim.feishu.cn; t=1727069813;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=ZbMcawlsAgdaVt5ccYbl800Dyq5oo00DqzA8zRTS0iU=;
 b=YMFGpOCB0uXyMUJruf3Orxy3f66ALntYk2cCmOylfk6VafWamyS41YLlSRNJBODnfd8wVo
 XXner3jn1Deil2HTzZLl2YP2Rw6CKDUJnBDstbWCl22MZ764Noi2H5M910W6xxy+YVmkTu
 vdxwAMqXFel13RyYWj4EdJtYE1hiTCaV/fbzs5vyE08JOqrooSKsNbWakxR4dvewVZmsAr
 k+sqXzs0OqqWzFTO9rqo74veXV1lvLOSZ3zinDknpFlGanqFhBDZ2K44UfzFEdOoX7kFCS
 J8MeB8OfjdyS4aH81xC8d8rPd6bFRiZaEHKWISOzi0aQHEnVj4qDU3eowHKT3A==
X-Mailer: git-send-email 2.34.1
Received: from roma-MacBookPro.. ([61.141.249.188]) by smtp.feishu.cn with ESMTPS; Mon, 23 Sep 2024 13:36:52 +0800
Cc: "Conor Dooley" <conor@kernel.org>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Paul Walmsley" <paul.walmsley@sifive.com>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>, 
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Sandie Cao" <sandie.cao@deepcomputing.io>
From: "Sandie Cao" <sandie.cao@deepcomputing.io>
Date: Mon, 23 Sep 2024 13:36:20 +0800
Message-Id: <20240923053621.1585972-2-sandie.cao@deepcomputing.io>
To: "Emil Renner Berthing" <kernel@esmil.dk>
X-Lms-Return-Path: <lba+266f0fe75+29cd5d+vger.kernel.org+sandie.cao@deepcomputing.io>
X-Original-From: Sandie Cao <sandie.cao@deepcomputing.io>
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 1/2] riscv:dts:starfive:add framework dts

Add dts to support RISC-V Framework Laptop 13 Mainboard. 

Signed-off-by: Sandie Cao <sandie.cao@deepcomputing.io>
---
 arch/riscv/boot/dts/starfive/Makefile         |  1 +
 .../boot/dts/starfive/jh7110-framework.dts    | 35 +++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-framework.dts

diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
index 7a163a7d6ba3..ebc8966fde0c 100644
--- a/arch/riscv/boot/dts/starfive/Makefile
+++ b/arch/riscv/boot/dts/starfive/Makefile
@@ -12,3 +12,4 @@ dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-mars.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-pine64-star64.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.2a.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.3b.dtb
+dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-framework.dtb
diff --git a/arch/riscv/boot/dts/starfive/jh7110-framework.dts b/arch/riscv/boot/dts/starfive/jh7110-framework.dts
new file mode 100644
index 000000000000..4da7ade5c8e7
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh7110-framework.dts
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2022 StarFive Technology Co., Ltd.
+ * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
+ */
+
+/dts-v1/;
+#include "jh7110-common.dtsi"
+
+/ {
+	model = "jh7110 framework";
+	compatible = "jh7110 framework", "starfive,jh7110";
+};
+
+&gmac0 {
+	status = "disabled";
+};
+
+&gmac1 {
+	status = "disabled";
+};
+
+&usb0 {
+	dr_mode = "host"; /*host or peripheral*/
+	status = "okay";
+};
+
+&pwmdac {
+	status = "disabled";
+};
+
+
+&pcie0 {
+	status = "disabled";
+};
-- 
2.34.1

