Return-Path: <linux-kernel+bounces-520164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15061A3A683
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F44E1781EC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205F21E51EF;
	Tue, 18 Feb 2025 18:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="m4o2vYKw"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015A31E51E1;
	Tue, 18 Feb 2025 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739904916; cv=none; b=jnrlZl/NhYmhqXQFNz+8ih7o1B76qF5BhH02GRUa1aFe2GLhhr4YzfvhWsp09pNrWTIOcloYIdGIzi/D588RfY3HIB0deirBZqF8zyq13tatkl8IxtXU9LlcBZs3pIcz3RAZNGCfbc83kXbo5Ung6ZYTMwN0zYw+eqfUV2wGtpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739904916; c=relaxed/simple;
	bh=StQmRH1Emk+mZWakl93uljiJjxjeVM7AlESiVXef0Ng=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H0jK1Karz2EblzvIatrM7WM/Hw+KzDQctNJbBO/6/SX2aUQfxNAgQ3zJ3FQLfNKXLeBcpK+CtInXVM+4HZzF6QBRv7yXKNBSIQ31QhdHs9ojDHiwNVykb3RjzmCroenhBoHTb3e5f2f1ZbYbmK1pUZSksw+cMZXnU25ClXCOnbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=m4o2vYKw; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51IIsv1L1601132
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 12:54:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739904897;
	bh=l5l755ruyNtPADHoOrFA6bFojSmArHIdny0GJW4lNQI=;
	h=From:To:CC:Subject:Date;
	b=m4o2vYKwiqUJ+OYW+cGctshgQ4uJb3sxGP/VCh337zZgspeJwnlEaJccwJXW0dz/2
	 fOiI7vDR2Oo7Pw1bHXaegEDNvGzPOJyQOtIVlyYEnC4jim2sseIR3EvOnuyMhyBnUZ
	 h63lRG1YKXzsuqEPTyPqm+PS4oPuGpBK6nlejSGc=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51IIsvBM000686
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Feb 2025 12:54:57 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Feb 2025 12:54:56 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Feb 2025 12:54:56 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51IIsrxY123821;
	Tue, 18 Feb 2025 12:54:53 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, <jai.luthra@linux.dev>,
        <y-abhilashchandra@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH 0/5] Add J722S CSI support
Date: Wed, 19 Feb 2025 00:24:47 +0530
Message-ID: <20250218185452.600797-1-vaishnav.a@ti.com>
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

This series adds support for CSI2RX capture on J722S EVM
and enables IMX219 and OV5640 overlays to enables
4 sensors on EVM, this provides a reference for a user to
enable a different sensor on any of the ports.

Test logs:
IMX219: https://gist.github.com/vaishnavachath/60cc2ef257601f27f28a315f8cf669c4
OV5640: https://gist.github.com/vaishnavachath/648202286d4d34d4d25f7c8c9db8b8bd

Vaishnav Achath (5):
  arm64: dts: ti: k3-j722s-main: Add BCDMA CSI overrides
  arm64: dts: ti: k3-j722s-main: Add CSI2RX nodes
  arm64: dts: ti: k3-j722s-evm: Add camera peripherals
  arm64: dts: ti: k3-j722s-evm: Add overlay for quad IMX219
  arm64: dts: ti: k3-j722s-evm: Add overlay for TEVI OV5640

 arch/arm64/boot/dts/ti/Makefile               |   9 +
 ...k3-j722s-evm-csi2-quad-rpi-cam-imx219.dtso | 304 +++++++++++++++++
 .../k3-j722s-evm-csi2-quad-tevi-ov5640.dtso   | 319 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts       |  28 ++
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi     | 193 +++++++++++
 5 files changed, 853 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-evm-csi2-quad-rpi-cam-imx219.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-evm-csi2-quad-tevi-ov5640.dtso

-- 
2.34.1


