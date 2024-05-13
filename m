Return-Path: <linux-kernel+bounces-177429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37E18C3E79
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 107451C210D2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76ED14A097;
	Mon, 13 May 2024 09:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Xn+ALl5c"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82810148FE3;
	Mon, 13 May 2024 09:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715594264; cv=none; b=byJeK9/xjzMULM5KS+Q1a38+x7P66eYGc5l782LfSdb7cCoW1scIAIUQA+2KL9RIQ7JwzsmPr9w3o9bGtnnIKsGHWKzdP2monMnwHwVDpcGncThMrrUT4tfef9tfEe7i7T6y8a/iCttuLLmpDkO2Yytl0T4j7wW0sZa4pOrMVNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715594264; c=relaxed/simple;
	bh=I3TEGDltJv2QQsYppV9FRanJLs8vAg/I31dXMaxtWyk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rs4Un3UhRWCepVNZrl1l2rZQdsypNA8G8odEbuXqSOBZrwpvXmiXE2p2fEp+M9FWwni+R2v++eQscQYj2Q7CVVsoiy61knuAAwZSH1hPrso6uBtfNr9Q3S6nhiWa1fH7UdTMpNsfZKiflAUk/jhKvjXXeF7nkr3Qn3u3N5KUl5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Xn+ALl5c; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44D8M5wE008202;
	Mon, 13 May 2024 11:57:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=IVz8GLj
	JytTTaf9y+4NV3G5TkNUJmDm03ovIMIb2MbE=; b=Xn+ALl5clpNlkGDk5FTGdl0
	EaVogPgMkKil0F46xIH7ubIMtpMgfvVPkR75Pd8sV8xjAPjpF2irfrhAu9AJM8Vd
	rDMOjYEgl/7VImDtUn8W08BZioT1N8KZ/k4aDX6x0GEKcj6MjmkHh9XGgPz6Rtxq
	PtH2ymI9OzUcUSP6TjO/DX75VQ3Zl9ieC98v65ddvbPYPmMPYK6JiIYhAM4xuY4P
	NdOVsKMXcz3siW7D5SgpBOi0PGZCFyI6khG/G+V0oUZMtsTUAx1eGuKQOmdsBf+Q
	digsh3YJi+5bG9uC5QVFtZdulb/7hiVuB4/NrypjCzqxdHdXe6rUpSJYt7xNJsw=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y2kmhkjd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 11:57:26 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DC1D840058;
	Mon, 13 May 2024 11:57:16 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E9B53216605;
	Mon, 13 May 2024 11:56:31 +0200 (CEST)
Received: from localhost (10.48.87.205) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 11:56:31 +0200
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
Subject: [PATCH v3 0/2] ARM: st: add new compatible for PWR regulators on STM32MP13
Date: Mon, 13 May 2024 11:56:03 +0200
Message-ID: <20240513095605.218042-1-patrick.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_06,2024-05-10_02,2023-05-22_02


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


Changes in v3:
- Replace oneOf/const by enum; solve the V2 issues for dt_binding_check

Changes in v2:
- Add new compatible for STM32MP13 and change title after Rob remarks
  V1: "ARM: st: use a correct pwr compatible for stm32mp15"

Patrick Delaunay (2):
  dt-bindings: regulator: st,stm32mp1-pwr-reg: add compatible for
    STM32MP13
  regulator: stm32-pwr: add support of STM32MP13

 .../devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml    | 4 +++-
 drivers/regulator/stm32-pwr.c                                 | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.25.1


