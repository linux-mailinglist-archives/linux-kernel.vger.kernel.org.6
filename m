Return-Path: <linux-kernel+bounces-303500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE56C960D11
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8F828968B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C898B1C4EE7;
	Tue, 27 Aug 2024 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="cKZDbtuM"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2667B1E487;
	Tue, 27 Aug 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767565; cv=none; b=c8nFeeeftxhMmZYvduIOSEebXgbbB9NPAmh6Zr21qwqOaGcn8yir2cr+GUttNAcLCIgvTF0iVb6tzbTOmD6BbG0/vbjXN5nVgV537DdRUVH94gZIx02nfGD78oGWNYoIrc56KUyHHydDDRje/cJM47QdXlPjXmCNidHbSJT2HjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767565; c=relaxed/simple;
	bh=vGkL0jnP6QGMEDrT22CXB041nfp/m4hGI4oqS2YGItw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OgyTCKXU3aPamwFBEh88cupuZ0asrof9oT5OdtF/dHCceP1f1488N15b0l4j45QJR2Sw5BcitHv9wi0GNuoSOdvYoNQ+Y7jeRnuh1mkCz2fGX18JnnDhIw3APQ2qU49CjFe3q+HnUsaX2un8zKdhT2lkwHHzKj1HoKY9Xfj2rcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=cKZDbtuM; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RBOCjT004259;
	Tue, 27 Aug 2024 16:05:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	2RVEzwg7gNF7vdYlJEOaTv0kpjM83f635tK0bmh+/GE=; b=cKZDbtuMTX50uMC0
	znEwisAJs3YYEdScw1Ny1xWfeR7nP3kTIEApYevnqE0NKBkla4fcGQE98odAHpiy
	ju9FWmt2eK1IP5BgVjNB6RNTZI1R9DMzGKmJXr9YUk0avZXJJZqPqW8RzPXNweHR
	UghIM9tfi0aNALJHFMUQYi2BWJTnXFuI+JJsNHZZvP0YSnHdooOoAhjFCB2F6Sue
	ZINAcXHaYSUTttv9VF0s4o4Faog/Y6WDOS5wL+BpqLMNuUjNG4GO83eetgeiBPW5
	Bn7caT1Qk9K6lsjrFANBzcArEC/Jfcgl4J6LbSozssYAWMrerTZYivgMe3xm+raD
	afeCiA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 419dw5rpmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 16:05:50 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 54ADF40052;
	Tue, 27 Aug 2024 16:05:45 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 07B1C26C463;
	Tue, 27 Aug 2024 16:05:17 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 27 Aug
 2024 16:05:16 +0200
Received: from localhost (10.48.86.111) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 27 Aug
 2024 16:05:16 +0200
From: Valentin Caron <valentin.caron@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Valentin Caron
	<valentin.caron@foss.st.com>
Subject: [PATCH 8/9] arm64: dts: st: enable RTC on stm32mp257f-ev1 board
Date: Tue, 27 Aug 2024 16:04:54 +0200
Message-ID: <20240827140455.345086-9-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240827140455.345086-1-valentin.caron@foss.st.com>
References: <20240827140455.345086-1-valentin.caron@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_08,2024-08-27_01,2024-05-17_01

Enable RTC on stm32mp257f-ev1 board.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 214191a8322b8..6b68aeaf79ba3 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -93,6 +93,10 @@ &i2c8 {
 	status = "disabled";
 };
 
+&rtc {
+	status = "okay";
+};
+
 &scmi_regu {
 	scmi_vddio1: regulator@0 {
 		regulator-min-microvolt = <1800000>;
-- 
2.25.1


