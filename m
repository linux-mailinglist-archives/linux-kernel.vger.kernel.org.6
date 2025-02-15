Return-Path: <linux-kernel+bounces-516434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 213F6A3715F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 00:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE9DE166308
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 23:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229331FC0FC;
	Sat, 15 Feb 2025 23:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="Q+28DYTI"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D681FDA95;
	Sat, 15 Feb 2025 23:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739663713; cv=pass; b=t4NcpgwXu6ehAijhocgiS874qJE/O2cKdGO115VPweYU598v8ZZ+7jxezny2RjtLmKkuVfXKJ9C2RhIRM6yS0/TZskvgnue9ipTV45qgTrvE31xeLjC3RT10mlq7wHyENfyVN9do0UATpN8120v6BxrriKYF/6+sXmsj0wknFFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739663713; c=relaxed/simple;
	bh=HgDhczPzTI9dLyLIlaaLSsFF3eu77yGDeD7VQP8jvsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GuP/46SgUgVcaCmG05TRgdBg5vHmlHlAlgae4jmOdlGVkPS3LDZQGQn+4LbiT2Bt/zOAyIUOKwNZOZrernRjoY/C+UGdXelRKF7OIG8TMsuJsmR9nO5BABxdVuHBbHBwOAnfqe0k1mq+GnF/pC5xB0MCiFixeircibmcT8OULbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=Q+28DYTI; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739663690; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=I3Rz674TSt7JNyHhimTE/Bs1MiCE7z0sxEXnX9FCZjGGKsigFslJnKMZETJWe0H9L5HYixJ1MXqnftiAC2PdDgXgD5iOAK6JKHrv+eZCSILdqZJijZtDqg+8gKCTkTMPk3jamSni3/kHojI+yh5AQubuUuso95CIEjbFKA78H0w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739663690; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ocWfKoH5gDKazB1hVFkL3Wbr2WlAHIEIf1+b/BiZMfE=; 
	b=N3GKMzn61y2wnS0ZEaO5S0zd4m3FCT8H35csVkRDz1syCpOWTan63/23VBhZWEKHl3xWQuQRdHhbLKPx5oMFxl5iw8XdnUayBvdYeH6Cf20dOwVAFKB11zGqeWwpWbCJKvDkpmdM8vjcmUKpEDMzUkMuxb3i3BE+5P99UM58pgQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739663690;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ocWfKoH5gDKazB1hVFkL3Wbr2WlAHIEIf1+b/BiZMfE=;
	b=Q+28DYTI56kuGt23zFPv8pFjQOcfx1XkSMq4tVaAu49OjBRlbUsqWCb4RBGGCKF/
	vK4mc5pVsciXW9nIVZG+3EHkOCx3Y/97JNaFu1/Tu3J3gIdC+dTQUVtS7++c++R8fgZ
	1+/3F+tqWhbsk/lstGrrJt3BiwiJNjKeHTcIMA9Y=
Received: by mx.zohomail.com with SMTPS id 1739663687773929.678192902661;
	Sat, 15 Feb 2025 15:54:47 -0800 (PST)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Marc Zyngier <maz@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kever Yang <kever.yang@rock-chips.com>,
	XiaoDong Huang <derrick.huang@rock-chips.com>,
	Peter Geis <pgwipeout@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	kernel@collabora.com
Subject: [PATCH v1 2/4] arm64: dts: rockchip: rk356x: Add dma-noncoherent property to GIC node
Date: Sun, 16 Feb 2025 02:54:29 +0300
Message-ID: <20250215235431.143138-3-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250215235431.143138-1-dmitry.osipenko@collabora.com>
References: <20250215235431.143138-1-dmitry.osipenko@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Rockchip 3566/8 SoCs are affected by the GIC integration issue where
GIC reports that it supports programmable shareability in a feature
register, while in fact it doesn't support this feature. Rockchip
assigned Errata ID #3568001 for the issue.

Add dma-noncoherent GIC property, denoting that a SW quirk is required
for the GIC.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
index de5e6c0c3d24..28be38b7182e 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
@@ -284,6 +284,7 @@ gic: interrupt-controller@fd400000 {
 		mbi-alias = <0x0 0xfd410000>;
 		mbi-ranges = <296 24>;
 		msi-controller;
+		dma-noncoherent;
 	};
 
 	usb_host0_ehci: usb@fd800000 {
-- 
2.48.1


