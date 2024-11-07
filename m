Return-Path: <linux-kernel+bounces-400217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587159C0A81
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9D128348C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88583215002;
	Thu,  7 Nov 2024 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="aZvDmzmm"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C7E1DFDAD;
	Thu,  7 Nov 2024 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730994938; cv=none; b=TEiS0iT7BxbRBueZhhVkk7S1GyOI/et7TuvaQEc9WDZH3W4V9Lu/LvaJ5o5Bpa5AxIV9z4ltTdeZnhmwHdLhYngPowzK0d5hiaE5sAKi+kITBr3Iyj+DH3mFZKkPZgiIYeevM6QEtMDIN1WbDbnNhEiyHQpXY94vZ6Wlsbb46yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730994938; c=relaxed/simple;
	bh=GOOs4Jgfwk8v9Nj1gxjpI02+cnRNHZ+/pbPhQuoNk28=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MWXWHwZGm+a4dXYojLRY+ToLaihZeWx+Kn39UKkjScQUOHXePg3+B8uUtvw0SgjbJ6zVv0YOda8M3vr4ivXFDFpxHgi9g0uPUKVRydixQOLZ/ZijngwCcMhebRrdpR/ki7O4LMxAFOJXxr07Oj8ZxH06f6+t3xmW8Tq7LmdyOPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=aZvDmzmm; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7BCI8G020688;
	Thu, 7 Nov 2024 16:55:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=e2VlH/uuBQt3wReNKxARkD
	7iZtlOIa3l9BKSWUf02Sg=; b=aZvDmzmmkAWb2LsThYyhr48PEZCZHYnedSHamC
	3hRGMDbxDFXH7eFajG34rl7pbriqJv8iu3Ee3V+G9FGRrghKAL7Mfjfhz98caEcy
	oXhEk4zq+/qno9QXP58O94nMmK/RXRoVkwb3QrQXx5ZGYGndVBKnDLpww5gLtcUp
	2k9lwAA1XbEqCpI0Yq70zZ3QqjVjfVf/9Rusq/pGurHA+TelsGCu1sxtq3qz9UjA
	g+svF0ysEU0x0g/PasWbPvBqOFz79EdU5f/YUd8IQuqv/i/WG/ha1IPh1VlyN/eO
	b5Zi6UpvUuHZBHY/2qaJo7SoAFMs88vHhDmooQ1SPTTdGVZQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42rra1jm01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 16:55:08 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B01C040049;
	Thu,  7 Nov 2024 16:53:53 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 98C802B6E40;
	Thu,  7 Nov 2024 16:52:00 +0100 (CET)
Received: from localhost (10.48.86.132) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 7 Nov
 2024 16:52:00 +0100
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
Subject: [PATCH 0/2] ASoC: stm32: sai: add stm32mp25 support
Date: Thu, 7 Nov 2024 16:51:40 +0100
Message-ID: <20241107155143.1340523-1-olivier.moysan@foss.st.com>
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

Update STM32 SAI driver and binding to support STM32MP25 SoCs.

Olivier Moysan (2):
  ASoC: dt-bindings: add stm32mp25 support for sai
  ASoC: stm32: sai: add stm32mp25 support

 .../bindings/sound/st,stm32-sai.yaml          |  26 +++-
 sound/soc/stm/stm32_sai.c                     |  58 +++++--
 sound/soc/stm/stm32_sai.h                     |   6 +
 sound/soc/stm/stm32_sai_sub.c                 | 144 +++++++++++++++++-
 4 files changed, 216 insertions(+), 18 deletions(-)


base-commit: 2fd094b86c8ae266b618359e4154ab94e806a412
-- 
2.25.1


