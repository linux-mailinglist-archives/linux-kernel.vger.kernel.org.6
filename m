Return-Path: <linux-kernel+bounces-286898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3731C95202C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CB94B22886
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829161B8EB3;
	Wed, 14 Aug 2024 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="LnVR+YGW"
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F18A1B86D1
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723653447; cv=none; b=WlYQNR9HE/z+UF5sq5jUIW4H8tok7zWRQUFSytPq5jxn4dXT+62kbJBDvrYPqk8rC/xBmSjXqBv+ElgVlYb4Jtpl30/K+bQabYnHPa/wyPwgGR4VwWDEvBJzzCQjxHnDEVWF8Kc/l9hA4ZF+lvOzHsk3ufILYF/F1JpoKpQy3bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723653447; c=relaxed/simple;
	bh=xwO4qZm3Gbqbi5R6FcqkiTL12YiVG+Slagrb4NBEdyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LH2UbO7jFxBBP8GoaqWQvmYYgrKmxkuDr8cN1+DeJ1sfNBCNAbbZPB0/tpGSfRWtC0Pq4DvcOR85JMGykmNHDHiy4h4SksyUJeQp/OLX7G1NgaLPs07dDJ/8mb3bLyKHzZqPGuCOqb2DpY+51YfOhlo1sgwFi8hiAgNVovS5ghM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=LnVR+YGW; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20240814163720001a5b008817363848
        for <linux-kernel@vger.kernel.org>;
        Wed, 14 Aug 2024 18:37:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=nESrF5vTvc0qOhMZmjkHj4ky91fAdlGMxwFql/ii16Q=;
 b=LnVR+YGWfnNZHD9zQoHI8hDNmfvGE2HsYysH4jLvQWicgfiOrixn3EJUPD1LoFbSYFOWMA
 edE8kZ/Bn0SsQKDZxhCuz2vQ4HXZkyS3zD2ggJLr6igScWqOKjyuHu3myRuiLoSElieSLHN4
 tCqMIQHVbfWuQaMtDaR9p5g8sKe4lsLHLTxANbb1pfnPiVsWqPEautjBfSqmFTYSKnGIM5VQ
 PFU09IGuUTe3Yhnef0ucn8ta2j2njgrvNkPgx5Qx/R2f8N/xhOSPNNlspuddWALWFCm/2xGv
 r3XP04FQuV+V9l7kmKFDx2uvUL+ChR/n635l6N4XAzzHjHehQXjQFPMA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>
Subject: [PATCH v4 1/3] arm64: dts: ti: k3-am642-evm: Silence schema warning
Date: Wed, 14 Aug 2024 18:37:17 +0200
Message-ID: <c16521bd55ebed8d1625f11c2ed6fd2c45e8baa5.1723653439.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1723653439.git.jan.kiszka@siemens.com>
References: <cover.1723653439.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

The resolves

k3-am642-evm.dtb: adc: 'ti,adc-channels' is a required property
        from schema $id: http://devicetree.org/schemas/iio/adc/ti,am3359-adc.yaml#

As the adc is reserved, thus not used by Linux, this has no practical
impact.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 6bb1ad2e56ec..42015a55e0d3 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -646,6 +646,10 @@ cpsw3g_phy0: ethernet-phy@0 {
 &tscadc0 {
 	/* ADC is reserved for R5 usage */
 	status = "reserved";
+
+	adc {
+		ti,adc-channels = <0 1 2 3 4 5 6 7>;
+	};
 };
 
 &ospi0 {
-- 
2.43.0


