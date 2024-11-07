Return-Path: <linux-kernel+bounces-400123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E618B9C0943
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22E811C23827
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3EF212F06;
	Thu,  7 Nov 2024 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="HgnlWPA9"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550AE20ADDC;
	Thu,  7 Nov 2024 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730991023; cv=none; b=p0w62mY8wTcEUl2Q0DF3EypLoKS7Ri3Notyv3kTyJ759ezAs8eie1cCVvA0ZCUGpYNhTvTOcbadf8NOoV1WPTug3ps6bqsMMMyjle+vITU0bLpq4fLJ94SeCp3mpV+QFfGbxd2TrOTjui3EKLccs08F4YzAJ8DPbLbgjnAlpgrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730991023; c=relaxed/simple;
	bh=3O72Z+3ro0YdY4QPvLsYsBDWaP5dAZLcJHG4CDkfOL0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KCocm/HO79NxUKab+FqrlBuPIFsW8UxDzEKGcwmwFHO6rnpM8GNFWBGWGVlofjOSaTjUhvg/F15DrVXsMWuzcQIS1jSJT4ZWoVCcYBh4t1skyd87hYAzg0fFa0Kac2Z4YTVt2lU6RedZ1xcLvbcM4PranVR3kr/UEEi6R0grvMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=HgnlWPA9; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7BUge3024535;
	Thu, 7 Nov 2024 15:50:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=lgjTU7mFnOg/SBXD0HtS+z
	UHuNPPBH2haMWI1pZhhns=; b=HgnlWPA96eHXz3S4FZAHm3+T+EFIJmDLiRoMcv
	NmgrgaaUPXqqzaz0hQrQAFAKaZEtSp9VDEaGS7T3X+UohfzQSk5fmMCg5yV+72zw
	524zAgOu6ukTT9FY/kBIuUu27QuvHUCILUlfC1x8dy/bNOWz8Bs3bxObxrkHPaNZ
	WzUAWpNB0blG4IwYsUQBpOQW1mAB/+4w/HD2UWalKiIo4pP80bMqutcYpLkeuk7e
	P/MSgVhQwup0QfFzJYc0RKlFRJCPh/TPuEbfZuQcswD9ihocbwOPfydG8LJNEiNn
	EloRXtEn7tFkkx18ZXbYQIqmJ/GSMxJdofbE/DD9t9hS+3BA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42nd05q0mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 15:50:08 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5CFD84002D;
	Thu,  7 Nov 2024 15:48:29 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7D3482BA0A7;
	Thu,  7 Nov 2024 15:47:36 +0100 (CET)
Received: from localhost (10.48.86.132) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 7 Nov
 2024 15:47:36 +0100
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen
	<arnaud.pouliquen@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] ASoC: stm32: i2s: add stm32mp25 support
Date: Thu, 7 Nov 2024 15:47:10 +0100
Message-ID: <20241107144712.1305638-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Update STM32 I2S driver and binding to support STM32MP25 SoCs.

Changes in v2:
- Rearrange clocks and clock-names ranges depending on compatible.

Olivier Moysan (2):
  ASoC: dt-bindings: add stm32mp25 support for i2s
  ASoC: stm32: i2s: add stm32mp25 support

 .../bindings/sound/st,stm32-i2s.yaml          |  36 ++-
 sound/soc/stm/stm32_i2s.c                     | 211 ++++++++++++++++--
 2 files changed, 222 insertions(+), 25 deletions(-)


base-commit: 2fd094b86c8ae266b618359e4154ab94e806a412
-- 
2.25.1


