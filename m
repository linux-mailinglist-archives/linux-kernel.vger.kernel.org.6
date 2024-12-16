Return-Path: <linux-kernel+bounces-447603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF049F34C9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4571888D17
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2452136337;
	Mon, 16 Dec 2024 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="wDnQ/1e9"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609DC148FF6;
	Mon, 16 Dec 2024 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363658; cv=none; b=PGOeNhM1YfZwnpbZhUQulU7y0nApyMaCO4nSn0CVL0elCMe5Vt2VERqz106JYbPOtmP9k412jXykM76Ti+r8x9Y4++V5RYvZ0XhfoERwx3LAgZGWo8o64xvtp4yCkuZ2VU0LABKWpmQoY9vb6e5gHC1j8hzKoM2unaTQJfX7VEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363658; c=relaxed/simple;
	bh=g3zMj0gYkE0JeMJPamSBlKCB1YyYSBAnavDGG2D5vNI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=McqnY7QUpQo4uZ+bilPWlUoS1pz+r+w6Dqktfqt7smdlTfKBiUL6tXv1IWNs3hLHD6/qiQGUjp8vOYmlFUooIuQWVSXWW9AbZTiMrSodvoCip9aXJ8yynHsdywN7AnOo5yY5NdMdL9ikr9Pb9ellHEQut4Q3Vb4m6AC7eU1sSsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=wDnQ/1e9; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGEYBor024315;
	Mon, 16 Dec 2024 16:40:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=u5wGE5wijHPgCUYNBXHSuk
	VMCuhvYNDhcscMJnWi4EI=; b=wDnQ/1e9NzRlJAEmmolrW6ZfzCwN5bhKfft1Ma
	HToVJAVUpNZSsw6/W3NtPZUSSdIBgeGQ1/S+t/Te6jQ7X3W0U23rJWJ6HR2RrGa1
	2xJI1QYNVTAg8lPQbWhzr+z3uwfu8b4kJEJFKGHSW2hKEBopC2VMmHSA9vdh8Qn4
	m5o1yNCDe+akkZc63m7wpZgZHyzT3WImJCVjoNtyJuPi8R1c4zfEIJwKrUvkkMWn
	s7u6ucNOtzACQMkWpIuBFkWkkl98QVNSOkxEisil+qIUtQkJ1SWhHw4Ca05Br4dQ
	g0riPTWuwuCyZvIjcf9RkVDQyG6oF+bY4jULKYmAd7sx1Saw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43jp3887bw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 16:40:42 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8130440048;
	Mon, 16 Dec 2024 16:39:47 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6BECB277BE6;
	Mon, 16 Dec 2024 16:39:19 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 16 Dec
 2024 16:39:19 +0100
Received: from localhost (10.252.30.129) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 16 Dec
 2024 16:39:18 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <alexandre.torgue@foss.st.com>
CC: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>, <olivier.moysan@foss.st.com>
Subject: [PATCH 0/5] ARM: dts: stm32: add counter nodes on stm32mp13 and stm32mp15
Date: Mon, 16 Dec 2024 16:39:03 +0100
Message-ID: <20241216153908.3069548-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Counter driver originally had support limited to quadrature interface
and simple counter. It has been improved[1], so populate and enable
stm32 timer counter nodes on stm32mp13 and stm32mp15.

[1] https://lore.kernel.org/linux-arm-kernel/20240307133306.383045-1-fabrice.gasnier@foss.st.com/

Fabrice Gasnier (5):
  ARM: dts: stm32: populate all timer counter nodes on stm32mp13
  ARM: dts: stm32: populate all timer counter nodes on stm32mp15
  ARM: dts: stm32: add counter subnodes on stm32mp135f-dk
  ARM: dts: stm32: add counter subnodes on stm32mp157c-ev1
  ARM: dts: stm32: add counter subnodes on stm32mp157 dk boards

 arch/arm/boot/dts/st/stm32mp131.dtsi      | 40 ++++++++++++++++++++++
 arch/arm/boot/dts/st/stm32mp135f-dk.dts   | 12 +++++++
 arch/arm/boot/dts/st/stm32mp151.dtsi      | 41 +++++++++++++++++++++++
 arch/arm/boot/dts/st/stm32mp157c-ev1.dts  |  9 +++++
 arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi | 18 ++++++++++
 5 files changed, 120 insertions(+)

-- 
2.25.1


