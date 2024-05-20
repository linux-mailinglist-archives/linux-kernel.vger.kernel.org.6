Return-Path: <linux-kernel+bounces-183814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C208C9E85
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 16:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582A61C210B3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D8A13664B;
	Mon, 20 May 2024 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="1oE7Otpp"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6D645026;
	Mon, 20 May 2024 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716213698; cv=none; b=tmModCGTHTsWqSTG5Kktcl0EqAN9eNggAbPuuLparQDZndUE95aBUMy13BZRJUu2om+TsvjqcQrZHqT+3Vg9ThlyIQ/sQgf+jrAhPvCOZEeSgJwTkhinoV1XMQP+HS4ePcu4FP650xYGhrK57R3fjN9vI4W6+MU9wrAjMGsEmjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716213698; c=relaxed/simple;
	bh=In9zIq8IukzKSjyjDxEXgTEBcFek8fe0l1bt3l/HRAk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e2QC63oqMItIiJj4dBDAeOUVPgqWFfToG/fdvKpm7yY6LJE9H7KyM8jS61SgeaTUMEwdvM80oZaXX9HatdBaqZe1KIuSa6iMU0XD++vqwNt5yf4GkD4c/OjrPG+6178NysSFCrm6+gilSyuZleh6/5hFpBaCjm9oR4aIeeEBAYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=1oE7Otpp; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44KBMT05021385;
	Mon, 20 May 2024 16:01:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=ZgsE3xWv3XDME8Xvz+S9s6R3DQC6mEdB9EsMvdI4S4s=; b=1o
	E7Otpp6d79XNB/2IazpsVg28JQpX5aqqehm+H8sgpMP7kUUaTFxouySUstnwqm3k
	8KJiTjNyplYl4Xd/9d6vP57EOTkdiM3MKqPwMt5VttB4GjVOpNKJCatplLqRnBBT
	bhJVNgz6IZ3s0hLIEtBTKm34ttR0aKUBG+ZGD4jnZRVj4BZcX+OXKRChUbZMNNjT
	Qr6FHqMWQp0p354LtkuSyrnbtouTbtg9QhyFwT+T6kV2FOsm36wb0J4SROiYUu0e
	pwbJGMYMW2eXpEYPOErlCcMNPqUfox+yWMOQJ9xkxNLtjAjOwHoo8/OMUesXzNlx
	0+7zC7Q1IlOhKrqwvUtA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y75w05m43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 16:01:11 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2AF044004F;
	Mon, 20 May 2024 16:01:07 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 578D4222C89;
	Mon, 20 May 2024 16:00:38 +0200 (CEST)
Received: from localhost (10.48.86.111) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 May
 2024 16:00:38 +0200
From: Valentin Caron <valentin.caron@foss.st.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH 3/3] arm64: dts: st: add usart6 on stm32mp257f-ev1 board
Date: Mon, 20 May 2024 16:00:24 +0200
Message-ID: <20240520140024.3711080-4-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240520140024.3711080-1-valentin.caron@foss.st.com>
References: <20240520140024.3711080-1-valentin.caron@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_05,2024-05-17_03,2024-05-17_01

Add node for USART6 on stm32mp257f-ev1 board.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 27b7360e5dbaf..18c6266532b29 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -18,6 +18,7 @@ / {
 
 	aliases {
 		serial0 = &usart2;
+		serial1 = &usart6;
 	};
 
 	chosen {
@@ -109,3 +110,12 @@ &usart2 {
 	pinctrl-2 = <&usart2_sleep_pins_a>;
 	status = "okay";
 };
+
+&usart6 {
+	pinctrl-names = "default", "idle", "sleep";
+	pinctrl-0 = <&usart6_pins_a>;
+	pinctrl-1 = <&usart6_idle_pins_a>;
+	pinctrl-2 = <&usart6_sleep_pins_a>;
+	uart-has-rtscts;
+	status = "disabled";
+};
-- 
2.25.1


