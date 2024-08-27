Return-Path: <linux-kernel+bounces-303506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F671960D1C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A315D1C22611
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83B51C7B75;
	Tue, 27 Aug 2024 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="wwpRrUbO"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CD51C2DD2;
	Tue, 27 Aug 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767566; cv=none; b=uHbohPkswHjbS+EahfnVbN+KeVjYAbKZzGOxfIue8RZDvdQVPfKEtg0Lr72wimCs5WU5/kThBSCyvVarunNhsLom4f/624lnZqv4Zcwl/p8vYVK5KjliWoUhg/On6yDkpavnMxtHP4PVey6yOhQoeY2eP5K82o+SIYXobRKQAxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767566; c=relaxed/simple;
	bh=Evx5XcWGCvoJGEV0yplmmPsw6IPd1tfRhfMriMckTiI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MBTDQYeuom0YWZ72ZbOh3zhcZxlwCEZLPePlHoMLZyypuqlolHrUqdreGw7zGFEVC4ctF9m+9rX1RjjCauHZBKSn0bfVGkbyDzOJSiSeHz6oX1rc4K3r7vKRwuxd1MvW+iDX15BbvhkcQ68STwEoFoL7PdS+GsTreE5shjIKHtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=wwpRrUbO; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RDTQfE001622;
	Tue, 27 Aug 2024 16:05:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	h2H4zfGmWKtl+SLiruiqM/WMeBQn0m8bdXnUWVPtp+0=; b=wwpRrUbODf0KwgGd
	H6nijKxCoy8avDeMMBtoHgwVsPOCbFv42HDZbx/hcEy4CLFeqx2pVd8tH1N0qQnK
	en4qg6SrB1YrD+i3jHXh35SSmhsq/eLXwR+k5H8gd6eNgV8obIH6rsiUwVtu8VQz
	u2RFiadqOTKEK/TKCviLgVylrtJakGItHLx1iGgi/trBKAGNxcFSq60K+61MhtSs
	m7DZOYYvRP2IDe/cw+D6y4IVKu4aQCI0umuGVNlSEBp7axPFOA6GTIDGRP/f7jl8
	XYUY+qhF6NfPk67R7VpAZNOXSJJkv9cy8pmbc/SmtWvytGNEj1FYPFu3od6FSwPT
	V4pkSw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 419fqs850x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 16:05:44 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2CF4840048;
	Tue, 27 Aug 2024 16:05:41 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8168926C451;
	Tue, 27 Aug 2024 16:05:11 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 27 Aug
 2024 16:05:12 +0200
Received: from localhost (10.48.86.111) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 27 Aug
 2024 16:05:11 +0200
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
Subject: [PATCH 1/9] ARM: dts: stm32: rtc, add pin to provide LSCO on stm32mp15
Date: Tue, 27 Aug 2024 16:04:47 +0200
Message-ID: <20240827140455.345086-2-valentin.caron@foss.st.com>
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
 definitions=2024-08-27_07,2024-08-27_01,2024-05-17_01

Declare pin for LSCO in stm32-pinctrl provider node to reserve this pin
for RTC OUT2_RMP, in stm32mp15-pinctrl.dtsi.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
index ae83e7b102323..0df526cc48f2b 100644
--- a/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
@@ -1696,6 +1696,13 @@ pins {
 		};
 	};
 
+	/omit-if-no-ref/
+	rtc_rsvd_pins_a: rtc-rsvd-0 {
+		pins {
+			pinmux = <STM32_PINMUX('I', 8, ANALOG)>; /* RTC_OUT2_RMP */
+		};
+	};
+
 	/omit-if-no-ref/
 	sai2a_pins_a: sai2a-0 {
 		pins {
-- 
2.25.1


