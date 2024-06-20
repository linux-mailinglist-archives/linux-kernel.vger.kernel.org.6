Return-Path: <linux-kernel+bounces-222016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A0490FBB3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 05:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660381C21606
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 03:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6C221364;
	Thu, 20 Jun 2024 03:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YTm9juk5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5904D3C00
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 03:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718854520; cv=none; b=ZSK1cXTNP58ta1Bw6gM0ju8mIdel/uLWkF5+E8qlvynve8KEvvEJX7fjVoe5AW9UXSgJfsK/YMRQOMMbh/vk31FpssP/X1wWWH+85zchZ5CsbothtXGk1ziGToiI84WxvKWqkDSLHzeilHjG8P4lVDfs9goD7JyJEqc/Tp5TxZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718854520; c=relaxed/simple;
	bh=OJN682JQ0IRzpsi7pQEo2eXAzG7PtVnK0pQDq2jmkz4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bu4OoZBqjOeZxgs14ePd1CBnZ3+O3Ijahc7AVf58klOp2Gje4M4bp70wZPE70d+CkYSdXRbQ86d8TujgNcHejAVQ6NTejbSMs9IC+IjPG3lAydeTGYs7MnKM/TPA7fnI0He0PDVuiI8yPsRqGsFJq1B+31iEOyAf7P85HJ2t2PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YTm9juk5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JEw7Da025146;
	Thu, 20 Jun 2024 03:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/8F1oqaHP7W8dzdNx4W8F2
	ghTuXXnl53DkuSaN9iNVo=; b=YTm9juk53ITPUX4Twa7CGMgzmDel8/dF2w0bWV
	3LrHg7sSjTH2fyGJA94aWtcuV1TLMaACXwuTLVpyUUuFSiDlwjo08EZHPZKQrA0d
	KWh/DuCZ8qJQ9zzfTaAwj7OeUOml+N4B8E9URyVvI0Ag+h/5znk/lhgA2YhlCoVy
	cSEo6Ys2barVGyWtnPnChK62iLJAXnQ8OSLCciIiU0YCVTMqwlC5mowdQinGhKXu
	OOQGAWaHsxNvM3IE4oYp5k0QkTorEn/1pfjvl/v7EIgEL26jYV2mfdYnizU5edwZ
	1FlVh4JAOS2mtdeEJQ5js0X/1/hGumiZmOPuWweDSNkfHU4A==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yv1j91a05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 03:34:54 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45K3Yq7K002169
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 03:34:52 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 19 Jun 2024 20:34:49 -0700
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <andy.chiu@sifive.com>, <conor.dooley@microchip.com>,
        <ancientmodern4@gmail.com>, <ben.dooks@codethink.co.uk>,
        <bjorn@rivosinc.com>
CC: <quic_bjorande@quicinc.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <quic_zhonhan@quicinc.com>
Subject: [PATCH] riscv: signal: Remove unlikely() from WARN_ON() condition
Date: Thu, 20 Jun 2024 11:34:34 +0800
Message-ID: <20240620033434.3778156-1-quic_zhonhan@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4w2VTZiM0lcOsouI3XGulbIfQtvP8HMm
X-Proofpoint-GUID: 4w2VTZiM0lcOsouI3XGulbIfQtvP8HMm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_01,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxscore=0 adultscore=0
 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200024

"WARN_ON(unlikely(x))" is excessive. WARN_ON() already uses unlikely()
internally.

Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/riscv/kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 5a2edd7f027e..dcd282419456 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -84,7 +84,7 @@ static long save_v_state(struct pt_regs *regs, void __user **sc_vec)
 	datap = state + 1;
 
 	/* datap is designed to be 16 byte aligned for better performance */
-	WARN_ON(unlikely(!IS_ALIGNED((unsigned long)datap, 16)));
+	WARN_ON(!IS_ALIGNED((unsigned long)datap, 16));
 
 	get_cpu_vector_context();
 	riscv_v_vstate_save(&current->thread.vstate, regs);
-- 
2.25.1


