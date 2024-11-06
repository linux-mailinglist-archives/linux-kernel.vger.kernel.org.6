Return-Path: <linux-kernel+bounces-398466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982E29BF1AA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE9D284EF7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA2E2040B9;
	Wed,  6 Nov 2024 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="4EP93/3P"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3252038D8;
	Wed,  6 Nov 2024 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906962; cv=none; b=fLpQ+tkqFRjhXwI9MnLm60zofX0TsC+L68FjYUJ5LgIyCF4Cs4Ep3cpANEp/nUT/QlKCDOkPxHw2d9vsC63EYqay2rfHFjGN+8YOD5Dk7SXMYrjU655InFQRERjk9LKINn2ueUkgNT7KMnehmfzZWJjvuHeeVO09GYDZi/Ew008=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906962; c=relaxed/simple;
	bh=61/derlr1u9nim3SN+NsdL2335McQNB001C9gfQQztI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T6g8W31RBp9tMz5cKmNPeJJxXq11zrkMCa12rpXAeGiBlzXeOtNeTxXYa0K15S8zT/pzSsD2EuKlqhUucICN8DW19fPoIE+D048Ad5Txh9nWRq+b3JDTyhOq+5yAxBvp9pDCdWQMUCCLj5q5s4DZB4nx+6CWP93kfsSnfjw47fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=4EP93/3P; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6Chj0j006298;
	Wed, 6 Nov 2024 16:28:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=QbyN14rz0QK0IY3T2SnPN8
	Jeg7AV51TUAEGYh14mf/E=; b=4EP93/3Pn93384e/6EBLV188xYzgwlPOylMd51
	SKet9fLKECn12GwR0ubfuEAqApVRN8PJ4LXYlBSF6GHR0mnY/gAp0muOo24s9Qo7
	Q3i84Vc+OQc71fHORn43ymO7DNezBAkKzeBgxFPuT0svC5yuNhyuulT+XQNkVgfX
	mCmdua+peCWD9MIezMiQ6iyzaMVo+niQSdwTijBb/DKaBoQ4GJqIf6swDByczTqx
	A5TFU9WJDL00linAa651RnijRjqkfHRfo8ynwfv+tlqTOXGwAR5izyqHw5BQmCjj
	ALTCzveNjW5cH5B1peimIEmHFvxOq/SbzffZzlZp7nSZwEJA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42r8qfgrtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 16:28:55 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 66FD740046;
	Wed,  6 Nov 2024 16:27:41 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6CF2E26553F;
	Wed,  6 Nov 2024 16:25:34 +0100 (CET)
Received: from localhost (10.252.15.15) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 6 Nov
 2024 16:25:34 +0100
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
Subject: [PATCH 0/2] ASoC: stm32: i2s: add stm32mp25 support
Date: Wed, 6 Nov 2024 16:25:26 +0100
Message-ID: <20241106152528.939232-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Update STM32 I2S driver and binding to support STM32MP25 SoCs.

Olivier Moysan (2):
  ASoC: dt-bindings: add stm32mp25 support for i2s
  ASoC: stm32: i2s: add stm32mp25 support

 .../bindings/sound/st,stm32-i2s.yaml          |  60 +++--
 sound/soc/stm/stm32_i2s.c                     | 211 ++++++++++++++++--
 2 files changed, 236 insertions(+), 35 deletions(-)


base-commit: a18dadd1209acb6d2fc22eb13873ec987ebcb77a
-- 
2.25.1


