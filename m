Return-Path: <linux-kernel+bounces-544105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C5AA4DD69
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3646D1670B2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D1A1FF1C5;
	Tue,  4 Mar 2025 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bpQ4SNJJ"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2D91F1905
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089839; cv=none; b=h2BkgYNIa4nXq/nxCsiOpeFUgcko85skdTssV3QQgE9xwWLza50qTbE88gcsivm4OFhc6fTL/W97KHiIDHW4dDKGQAdEH5VPuo0KhbKiFZimP9DSWkoXwlsQG5Lz0BTZFVMuQOQvtTPS3OL1el7T7nHDidE4AwBjTrktakOVMow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089839; c=relaxed/simple;
	bh=CR9oemOhz57B69WcQRqGOem2t60IKU+VN/UKE9p4ENU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lHEDKBKPye2hM99OTVHspkXgDNyyeNhIj9sPxrqW9HnHLV8nqoPLBvMUrgn62mctpxyrIhrM3JIewXjYsYrhNs4DmDRFaDSkRz/aDodUX0jmBrfz6g0E/MWc5LhbCQtZr7V8rjbyYrLSzjBgbah8oQZeb6mHPJj8pwOP/E2TY0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bpQ4SNJJ; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 524C3QsV3589547
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 06:03:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741089806;
	bh=Sx0YCaXeKShwrE/m6agNawDS0BbMWcKtDVV1e8NgZ1I=;
	h=From:To:CC:Subject:Date;
	b=bpQ4SNJJ5I73c5pFSrVx3egsUXZLZGRIyHzYUXwfxpfuh76M8r2ODqwdvSA9UA48j
	 MMrBKWzzHP6oilxSnurUs9iWrWnAOFTMLKOyQlNPCW099dGcJBIHl/dqWPYk4GpIN/
	 v81Pc4b6Lc4Pyx57xf4QnIsJfbQ7wjXjPZXSJWlc=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 524C3Qva070667
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Mar 2025 06:03:26 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Mar 2025 06:03:25 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Mar 2025 06:03:25 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.227.4])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 524C3K2A035887;
	Tue, 4 Mar 2025 06:03:21 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <quic_bjorande@quicinc.com>,
        <geert+renesas@glider.be>, <krzysztof.kozlowski@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <arnd@arndb.de>,
        <nfraprado@collabora.com>, <quic_tdas@quicinc.com>,
        <biju.das.jz@bp.renesas.com>, <javier.carrasco@wolfvision.net>,
        <ebiggers@google.com>, <ross.burton@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <h-salunke@ti.com>, <danishanwar@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH] arm64: defconfig: Enable config for PL2303 USB to serial adapter
Date: Tue, 4 Mar 2025 17:33:20 +0530
Message-ID: <20250304120320.874617-1-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Enable support for Prolific PL2303 USB Serial single port adapter.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
This patch is based on commit
20d5c66e1810  Add linux-next specific files for 20250304

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3a3706db2982..8b233b7ea857 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1113,6 +1113,7 @@ CONFIG_USB_ISP1760=y
 CONFIG_USB_SERIAL=m
 CONFIG_USB_SERIAL_CP210X=m
 CONFIG_USB_SERIAL_FTDI_SIO=m
+CONFIG_USB_SERIAL_PL2303=m
 CONFIG_USB_SERIAL_OPTION=m
 CONFIG_USB_QCOM_EUD=m
 CONFIG_USB_HSIC_USB3503=y
-- 
2.34.1


