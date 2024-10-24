Return-Path: <linux-kernel+bounces-380286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 303B19AEBAB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2411C22754
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A905E1F80C8;
	Thu, 24 Oct 2024 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAapXxRR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE4A1AB6CC;
	Thu, 24 Oct 2024 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729786700; cv=none; b=ZL7wsQYtIidUC0NUgZzwtnvtnu1E7dlK2wIKd15uCOVW9QgerTVPAfM02BGqb537+njQ+370TmnZ6mUfF1PmbAWK2zh6StJPje4UJeB5qmIbDcs0o3a1u3b3bLW6Gi+aH+BOg3PpWZg1jNCq2Wl1WAj6Ty7wbYJROmV0TTUriK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729786700; c=relaxed/simple;
	bh=HMi4vh0ZfmM/XHXhdHdVQKPsA6QQ26DG3ecTNW+84QA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TtO7JPPQlm4PUfM15KsMo3y4vYvT28f+2PhnKAUlV+tIQArIatucPW4SS4SBxEP5KLMIhAyiVn5/8QgNLGHnZO0wz66FKfCwgXQAyFm2sC+rl3pJdeqQmrUqAB6nnMa9YmW6jbMW1TFFPHtMBM2zjrKNSK8HzXHuVRAVgHYZyxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAapXxRR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8773EC4CEC7;
	Thu, 24 Oct 2024 16:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729786699;
	bh=HMi4vh0ZfmM/XHXhdHdVQKPsA6QQ26DG3ecTNW+84QA=;
	h=From:To:Cc:Subject:Date:From;
	b=MAapXxRR2TlUdIr0ODf5QSUTkEMrtS9s0rIbJEQV5gkcLjDDxAuLvxCbKYiCeRMo5
	 yRoiODHCbLt7SAszyz0uhGUAkt2rfrUXSdGIvCrViW3Y79S4lCbRYzkq4kuHx1pzQ0
	 pvzrs659N0OIS9CkjL42/DcMJujdaWygH6X2aW5Xm4Zid++tSh/kQtnHb4/AnupRBG
	 Zk4j6eJLMhEZeAJDIWgTnnERb/MW0At243UUFLGnezTqffnJHv5w265kM2LQNvKIkJ
	 6OBXL4ROcDVDwDRWwFzlS1qE3stmWBaESFlNS2SDBs4ZyJ6YYkyNkK0eWl9YLTXGpn
	 gE2y3Q/xt9hIQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1t40XR-006W9S-Go;
	Thu, 24 Oct 2024 17:18:17 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Sibi Sankar <quic_sibis@quicinc.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] arm64: dts: qcom: x1e80100: Route pcie5 MSIs to the GIC ITS
Date: Thu, 24 Oct 2024 17:18:14 +0100
Message-Id: <20241024161814.1827514-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, quic_sibis@quicinc.com, konradybcio@kernel.org, abel.vesa@linaro.org, johan+linaro@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

There is no reason to use the PCIe root port widget for MSIs for
pcie5 while both pcie4 and pcie6a are enjoying the ITS.

This is specially useful when booting the kernel at EL2, as KVM
can then configure the ITS to have MSIs directly injected in guests
(since this machine has a GICv4.1 implementation).

Tested on a x1e001de devkit.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Sibi Sankar <quic_sibis@quicinc.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>
Cc: Abel Vesa <abel.vesa@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 3441d167a5cc..48f0ebd66863 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -3281,6 +3281,8 @@ pcie5: pci@1c00000 {
 			linux,pci-domain = <5>;
 			num-lanes = <2>;
 
+			msi-map = <0x0 &gic_its 0xd0000 0x10000>;
+
 			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.39.5


