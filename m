Return-Path: <linux-kernel+bounces-226715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA9F9142A4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5300A1F21390
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 06:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B232EB1D;
	Mon, 24 Jun 2024 06:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="O3WTSSTZ"
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2526219E1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 06:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719210064; cv=none; b=itoHPSV/28eA41RmX2jQdS8zt+AUIhfHf08iiojInrNzLXHJj8aZGKvgSRJT+c1gdM3B+P5tB3Ft6He2/8RcEqVI2IB03+OlC0wuPX9b4l98bIlF0Fs8kQvT8tqd19Xmt+GEtVLY4Hw36NAwU3fgKAD0oWldMfQXMiBD1+grb1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719210064; c=relaxed/simple;
	bh=cSteKp6CIOnq1PYX49xABbAigJDBuMpb7FyGBju3kUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9Y97H336cebjQ+Xc+6OIEVvNzwh5zHzamEpC+XzUpELRAVObeCJfRWkgNN5nDnsWDMtMMKIQf2lGUZrBEW/jTRNdYDdWuGW+N3rqDF8hSoOJvwcoo9vVgRQ7B+HYUy0/n+esRM0/W69nIefX93EmFg4RJ0A7kmeLKQS1R3Fcgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=O3WTSSTZ; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240624062052b347ae19a0973c3743
        for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jun 2024 08:20:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=HcAaeWHnc9AqXonQzh8RdFlKgEgIVm0dEwxF9CuTCBs=;
 b=O3WTSSTZ/bQypc6tBxOQhl2+ytoa+LHZ0bGnyh82YzuzBi1p4ZQYbedpvhutjlZlG6ijt1
 oiiBUz7kqN5ipesVdDvore4RzSBVZ1Y+yHuqcuKav69I/k156Gj6pdXLDqjh6TJ3aosfgtAn
 ZS7+4tjpA/kS3mtQiepMMzEw9/sSo=;
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
Subject: [PATCH 2/4] arm64: dts: ti: k3-am642-evm: Silence schema warning
Date: Mon, 24 Jun 2024 08:20:48 +0200
Message-ID: <5d7d852a2fd7666df5ca8b735cee544f7ca3549f.1719210050.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1719210050.git.jan.kiszka@siemens.com>
References: <cover.1719210050.git.jan.kiszka@siemens.com>
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
index e20e4ffd0f1f..0e42d09aa785 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -640,6 +640,10 @@ cpsw3g_phy0: ethernet-phy@0 {
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


