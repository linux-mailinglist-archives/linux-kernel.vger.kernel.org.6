Return-Path: <linux-kernel+bounces-183815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2078C9E8B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 16:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C1E1F21F31
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A91136992;
	Mon, 20 May 2024 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="xNqjhzzM"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC83A53E20;
	Mon, 20 May 2024 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716213717; cv=none; b=FKomVTsunBzXw1tvSLe63woDzFP3BblkUGylHZBJKBAbFZch88pPAwYJvOvIygS5krEumkye/Se9pqApMqUcRYQYQXIp+mloKP1gvnKGNhL+Dc96jBSdQkBoP88UW7YGRj9QPpEpHe+dCsAMe1p9zuk8C4aWafWHoagFQOHKM48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716213717; c=relaxed/simple;
	bh=nqUvc6sU6vpcddIpClyKh9qpVYre+r9fzZH4SsuS2ag=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MN31n20bn9PXzmKQbCPbfIe9Q5Sew6+8zwPqWUrYqYgAJR3qBXpX7zCM7K+c+SOfjK1DU1YUqVzNXvqkaoueWuStGaU/suSG3U/60Gdfk28x/QuMZPwBIkqfsYSuyjZG3cfDBZ8srvreYTHrgeFLKgxKLbStQSPvO72powWJoz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=xNqjhzzM; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44KDtKnN018364;
	Mon, 20 May 2024 16:01:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=/eWZVhr
	f80If0Zu1V4FcVn5XIUfeeeYvTullFqKWqvU=; b=xNqjhzzMZ0EpV3j+0L2WojM
	vfYR+H6ZE3j8r0HKFHK1FlGd8CHsdqS8epSHMIeq5ZOlbQJmJBo0b03hmFVsfm1S
	HyId82NCOKuudcy7bH5x9gP7CYmpzSkmEpssEkraWxRXo8A53JnfdkyTgPmxJjHW
	6vmdqz8tukQwNVpLlF27xDuAlAXdXAjWpLoubULMldK+wdcVM9gD8wJCmsTKObm7
	QICSkm+yUzNd7wuZBv208r8AFgcc8d9Ms2hMh9jOS5GBJ4ttL/MpDrBHp7TIfJWP
	D77eAg7C7QuVZnVsIamf4jZ9CMbmrXg9gtSfLWPf4QeX5j7uwe7NkdZ59HRpWUA=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y6n337bnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 16:01:28 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9D9CC4004A;
	Mon, 20 May 2024 16:01:06 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F02D8222C81;
	Mon, 20 May 2024 16:00:35 +0200 (CEST)
Received: from localhost (10.48.86.111) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 May
 2024 16:00:35 +0200
From: Valentin Caron <valentin.caron@foss.st.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH 0/3] arm64: dts: st: add usart nodes for stm32mp25
Date: Mon, 20 May 2024 16:00:21 +0200
Message-ID: <20240520140024.3711080-1-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
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

STM32MP25 got the same serial hardware block as STM32MP1x but with two improvements:
 - TX and RX FIFO have been extended to 64 bytes.
 - one instance more than in STM32MP1x series (4x usart and 5x uart).
 
STM32MP257F-EV1 board has one usart used by console and one usart on IO port.

Valentin Caron (3):
  arm64: dts: st: add usart nodes on stm32mp25
  arm64: dts: st: add usart6 pinctrl used on stm32mp257f-ev1 board
  arm64: dts: st: add usart6 on stm32mp257f-ev1 board

 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi | 41 +++++++++++
 arch/arm64/boot/dts/st/stm32mp251.dtsi        | 72 +++++++++++++++++++
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    | 10 +++
 3 files changed, 123 insertions(+)

-- 
2.25.1


