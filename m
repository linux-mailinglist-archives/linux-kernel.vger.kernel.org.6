Return-Path: <linux-kernel+bounces-514477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD932A35784
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AF3B18922DA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0354205ACB;
	Fri, 14 Feb 2025 06:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BKpiAB4x"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B472054F0;
	Fri, 14 Feb 2025 06:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739516378; cv=none; b=hAiMkQ4QM6W7+hUm7BMIBGvTZIf8AKcH0wh7uHXSQOkyQuO/Gs2Xf0qlk/BV3LZ2xth4kfZThAB+Z4dO8LnUxDt9jv7TyqayWhHcNtAqno1GyAm5WrPpTqrD7emr2tFPRXlNqkld8xdGrvaQFDJVSvyg8ml4lULxg/XOMA4Nk0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739516378; c=relaxed/simple;
	bh=VD6419GwC3op+1NsNa8YOPceiCy14z1AxbjSC8sFaRs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0AN0rtuc6WKKEgnS6oGuRR5CQ7E+QpBG60BRd04Q5/M6UcnVRrxzDVkqYZcgFnN3aMuMq4cR0K9Efhk+FjodmK6AFg+j6KwQwJ8SFMmBN2MQXOwYlIDgbtlVOmQ1JHgshkFDTnhNM8XtAVurUEtus/GyuKF6GiJl+jN32NpJ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BKpiAB4x; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E5nqkZ012347;
	Thu, 13 Feb 2025 22:59:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=U
	qntbEvQ4oDjd8z8ktk+NOdbapcG49CuahKXXtXd4jQ=; b=BKpiAB4xIa5QqogLo
	C6r4rd/+YvuQA4tLdceE3VIxYFSGvQj4lW9PTY7A7iXzqgaLPAvIuDSNsTipnVHK
	phmO/xjJmBDeSj/YBRtGV66vsUOajrFur2S6teqVLSVfzjgpZRL/ZM9wJZjU0fg8
	xngwXZjd8xmkiJdxhZRj8ZDnOGe59K82bmzmSY3BebSYWJZq5077PlBALM6Cf7ts
	wQlCMO0/ooEjh4lzqr+k0wPHdR2CRAF1yLOP8kQdC8z9XfmNpVYnSys9Xc+RkKzq
	d3/CryUU8hah3vqgVS65WItESWgcS9Dk4WXLZM1ePOROGn1YoemJzatZz8blYmSl
	Ahaqw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44t01f03fa-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 22:59:25 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 13 Feb 2025 22:58:48 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 13 Feb 2025 22:58:48 -0800
Received: from wd-ubuntu-24-04.marvell.com (wd-ubuntu-24-04.marvell.com [10.111.132.113])
	by maili.marvell.com (Postfix) with ESMTP id B61653F7090;
	Thu, 13 Feb 2025 22:58:48 -0800 (PST)
From: Wilson Ding <dingwei@marvell.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
        <salee@marvell.com>, <gakula@marvell.com>,
        Wilson Ding <dingwei@marvell.com>
Subject: [PATCH 2/4] [PATCH 2/4] reset: simple: Add support for Armada8K reset controller
Date: Thu, 13 Feb 2025 22:58:31 -0800
Message-ID: <20250214065833.530276-4-dingwei@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214065833.530276-1-dingwei@marvell.com>
References: <20250214065833.530276-1-dingwei@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1FHO47QsLdwd09cmpuryZ2amASV6Uwg3
X-Proofpoint-GUID: 1FHO47QsLdwd09cmpuryZ2amASV6Uwg3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_02,2025-02-13_01,2024-11-22_01

Armada8k has one register for unit soft-reset configuration within the
system controller register area.

Signed-off-by: Wilson Ding <dingwei@marvell.com>
---
 drivers/reset/reset-simple.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index e4e777d40a79..a792b913e1b1 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -183,6 +183,13 @@ static const struct reset_simple_devdata reset_simple_active_low = {
 	.status_active_low = true,
 };
 
+static const struct reset_simple_devdata reset_simple_armada8k = {
+	.nr_resets = 32,
+	.active_low = true,
+	.status_active_low = true,
+	.syscon_dev = true,
+};
+
 static const struct of_device_id reset_simple_dt_ids[] = {
 	{ .compatible = "altr,stratix10-rst-mgr",
 		.data = &reset_simple_socfpga },
@@ -203,6 +210,8 @@ static const struct of_device_id reset_simple_dt_ids[] = {
 		.data = &reset_simple_active_low },
 	{ .compatible = "sophgo,sg2042-reset",
 		.data = &reset_simple_active_low },
+	{ .compatible = "marvell,armada8k-reset",
+		.data = &reset_simple_armada8k },
 	{ /* sentinel */ },
 };
 
-- 
2.43.0


