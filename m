Return-Path: <linux-kernel+bounces-187858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3E28CD9A5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 20:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DB5AB2238C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 18:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5649B82D6D;
	Thu, 23 May 2024 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="g71+vPPc"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2C981723;
	Thu, 23 May 2024 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716487553; cv=none; b=aiyC3RxN6PLJBPUenfHZ3L5aGBdGgdiMUb8KlU4I4TRahX11zwtMcFdnEfgvdjOW0vvK2TvfJr/SkVcM6lTVP8KogkhAyE8SvZ3r5HeOe35PKiiTj06o3ey7riDbY72G2Wmr07y7TCN4kY7K9f9NqVAu4rWmP9PGusMT/qWw3T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716487553; c=relaxed/simple;
	bh=AsaeKSwTzhcRyWKh5+2LKndNSSsb37+HBmFxmiu6nfA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hUNYitDGGJnfAXU51V4c3mmCQC6BcH+QpQqb8218mRa7A7NDek5a00iMRu8rLxmdIgsX1mghB00H76vORTind74T7v7KAFaV0CuSMxrgHbZm6mYi515jYAZHMBggtI8duDIrhMNYwp8RCBxfuPMvrbC6a1iolgy58lTEKmtvqNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=g71+vPPc; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44NHUR7w016252;
	Thu, 23 May 2024 20:05:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=DH8LgcGQni+MPZrykXYaYa
	wW21NSo9zAq2v3pQC/Wms=; b=g71+vPPcNMk3qJKETtWwdKKi3gp8Dwm7pTkEcu
	UlqyHB+nc2XPNi9vnomYZq41Rt1R46bUbfgmDDDmuJOJuzxcqDnX5JgoHTItoWWU
	pIjSUWR2QSwXZgp0jlemCelUplSbaBBe2tRnlcXstdwZk62yxa5IKTUYhvjknISh
	5lZ9o2fFBOt6wRUaSf/k9tjO9ZTfmbBPmNPlmy5ZbnHC8AMDYep/jDSzDZHTj8At
	WV0t5Xm+JaepV8oI7naOiL+iDw+TLi0MEWXOFgIemQx9FBPcNvhPvq3e35yjU3hw
	uPZyNLZ9pn9B8x2pTItfbwvgKuENX6SKg5cQlpVznrF9omdg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yaa8qg2h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 20:05:28 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A084E4002D;
	Thu, 23 May 2024 20:05:24 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 412EC21BF58;
	Thu, 23 May 2024 20:04:38 +0200 (CEST)
Received: from localhost (10.48.87.205) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 20:04:37 +0200
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Pascal
 Paillet <p.paillet@foss.st.com>
CC: Marek Vasut <marex@denx.de>,
        Patrick Delaunay
	<patrick.delaunay@foss.st.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v4 0/2] ARM: st: add new compatible for PWR regulators on STM32MP13
Date: Thu, 23 May 2024 20:04:32 +0200
Message-ID: <20240523180435.583257-1-patrick.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_11,2024-05-23_01,2024-05-17_01


This patchset adds the new PWR regulators compatible for STM32MP13:
"st,stm32mp13-pwr-reg".

As this node is just introduced by [1] and it is is not used by any
board in Linux,  it is the good time to introduced this compatible
and update the STM32MP13 SoC dtsi without ABI break.

A new compatible is needed as the content of the PWR_CR3 register,
used by this driver change with new bits on STM32MP13 for SD IO domain:
- bit 23: VDDSD2VALID
- bit 22: VDDSD1VALID
- bit 16: VDDSD2RDY
- bit 15: VDDSD2EN
- bit 14: VDDSD1RDY
- bit 13: VDDSD1EN

I will push a update on STM32MP13 SoC dtsi if this new compatible
is accepted to preserve the bisectability.

[1] commit f798f7079233 ("ARM: dts: stm32: add PWR regulators support on stm32mp131")
    https://lore.kernel.org/linux-arm-kernel/b89d0531-067f-4356-91b0-ed7434cee3d7@foss.st.com/


Changes in v4:
- use fallback as proposed by Marek on V3 for STM32MP13:
  compatible = "st,stm32mp13-pwr-reg", "st,stm32mp1,pwr-reg"

Changes in v3:
- Replace oneOf/const by enum; solve the V2 issues for dt_binding_check

Changes in v2:
- Add new compatible for STM32MP13 and change title after Rob remarks
  V1: "ARM: st: use a correct pwr compatible for stm32mp15"

Patrick Delaunay (2):
  dt-bindings: regulator: st,stm32mp1-pwr-reg: add compatible for
    STM32MP13
  regulator: stm32-pwr: add support of STM32MP13

 .../devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml | 7 ++++++-
 drivers/regulator/stm32-pwr.c                              | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.25.1


