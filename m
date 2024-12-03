Return-Path: <linux-kernel+bounces-429984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F8C9E2A49
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA17B1666E8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B581FC7EF;
	Tue,  3 Dec 2024 18:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="OVggdtwt"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B271FC7F0;
	Tue,  3 Dec 2024 18:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249089; cv=none; b=rPRu1f7cIQyMdEjm2fPecHukljarWeHwKOF8ClVoWHK5JMZ8zf69TKeRmIfaJmCPlpYbDBdmmklsgYGfzDZZT8+9aXuO39MqSAG36bN+YN9/dpvE26HyREWT40HvVYqbk7PtlbYiTnGJtdXT9Y11a+xGM3nKBXmHmm7HL9/F95I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249089; c=relaxed/simple;
	bh=CrMO/tRsD0YpGcnX2BE59r25dvEmkX1t4dphQwhmMSk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NFniE/T3B6tqyh5UUZ05tHR6PvCI+2vhnhTuwsmDwJ01PFhetK5MiqNqx2JCdY9ee8FCqoEyP1DVE/nfIa/q41ejrSMtaaG28g+2OYjjAGsKTXy3pAKPuMlN3DdShP7Ho0UpMwlBg/c7228WuO7XJ3dJSdlsY1+/ClUSdrrz0gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=OVggdtwt; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3C077w008565;
	Tue, 3 Dec 2024 18:40:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=LoV8E+YWhIydOLMEnE/SzJ
	/Hu5kN6Y7HhbbpbAHakYU=; b=OVggdtwtNIMpzMGX4KSl6eJlFr2LntxkG6zVyr
	0r4Q8NChRpw/CQ8nHVYOZ/SnlN7y0S5ArnoprBOg0j28/E0vs4w/0XByqzm26svI
	hx7m859VAXu8DMW8NAsj5aA3TBiKwr6MlNtVfp61iQH2lAy8Gdk8++GGo4RJO1Oy
	HxUEtBEH4vr4+X9+SHd888tB5dSjBTvFzBjDeB22k/C9NdMxpUWRTzlJb3u9QNXL
	hbU1r9UPmowj3lSDq0/K5VTxIwifVH6yd1ROpGD9OVpxUwRFh/sjrxtmW4RYFj1a
	sgyJBWir0taA2W4IcR/XQlI9bqmplQEfEJSyWs2nx8ynOdrw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 437rq96b6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 18:40:38 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id BB19D4004A;
	Tue,  3 Dec 2024 18:39:44 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7A4772359C7;
	Tue,  3 Dec 2024 18:39:10 +0100 (CET)
Received: from localhost (10.48.86.128) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 3 Dec
 2024 18:39:10 +0100
From: Etienne Carriere <etienne.carriere@foss.st.com>
To: <linux-kernel@vger.kernel.org>
CC: Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi
	<cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        Etienne
 Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v2 0/2] firmware: arm_scmi: unbound discrete rates, support round rate
Date: Tue, 3 Dec 2024 18:39:06 +0100
Message-ID: <20241203173908.3148794-1-etienne.carriere@foss.st.com>
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

These 2 patches propose to remove the limitation of 16 discrete rate max on
SCMI clocks and implements an effective round_rate operation on SCMI clocks
that provides non-linear possible rates.

The 1st patch removes a limitation on SCMI clocks that is not really needed
since the SCMI clock driver does not need to store the full list of
supported discrete rates but only require to store the min and max rate
values. This change was initially proposed in:
https://lore.kernel.org/lkml/20240729065306.1210733-1-etienne.carriere@foss.st.com/

The second patch implements a real round_rate operation that is needed for
example on STM32MP25 platforms for the video and the sound drivers that needs
to know the effective possible clock rates in order to select a compliant sample
clock frequency regarding the audio quality constraints.

STM32MP25 platforms also need the 1st patch of this series since many of the
audio clocks (SAIx and MDFx interfaces) and the LTDC video clock are provided
by SCMI clocks (CK_SCMI_FLEXGEN_x).

Etienne Carriere (2):
  firmware: arm_scmi: get only min/max clock rates
  firmware: arm_scmi: round rate bisecting in discrete rates

 drivers/clk/clk-scmi.c            |  21 ++-
 drivers/firmware/arm_scmi/clock.c | 205 +++++++++++++++++++++++++++++-
 include/linux/scmi_protocol.h     |   7 +-
 3 files changed, 220 insertions(+), 13 deletions(-)

-- 
2.25.1


