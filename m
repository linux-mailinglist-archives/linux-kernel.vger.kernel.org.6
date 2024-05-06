Return-Path: <linux-kernel+bounces-169434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 881898BC898
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DCF91F22453
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7CF1420B8;
	Mon,  6 May 2024 07:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ih9yhy/v"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FB1140E2E;
	Mon,  6 May 2024 07:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714981801; cv=none; b=BmkVkaY3Rv6tT0SpCR6aSGqKz0GMfZaFuoCcxwiQg5fyN46iaQ53HAOqe2OTSfUIVIdKXTHotZfE+EV91yXTU9/kzekXucHRetEeISfhnqHRsoSDHP2ZK0rNjg0YdGgCzwWBJMdgFto/ZjSFFbwHDIBtrvcUa/YZe0M+NqoDKac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714981801; c=relaxed/simple;
	bh=nxjYtTOk4wofMpPel3ZmiyyJQPYo7VkLkJLA6OmGX78=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pl7/ai74OmjCIiD7MlhETRIMDLuS7MVG5kTQOvcXwl9wld0vs8MKu06s9VtEiiBQdqLv+VM1ZAqgy7pRd+IVjzCJtvKrTQLZwn1qBQ68Ch/B/d1kJ9HS3na88hDV8v4ssTN1ckAJdKsz3vPzWOArG/K/QYiwfRm7goj8SChek34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ih9yhy/v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4464ealH001645;
	Mon, 6 May 2024 07:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=j1CVj2o
	ZnYRlZs5a/i5QRPv/1AqJugNmm/k5hNeHcqU=; b=Ih9yhy/vbbwvAiiwh3wCs2h
	K8mybdjk/TLnATd+P/fP+q/KwTgn1kfx/D8GvwWzgPci0qbP0w8WpQ5wtLpVdMBW
	imIdcxHANfzJlMPN5aaq7J/u2Ic7oJi2/7GBhMzHAamPDaP1YN58NiqonAzMWUbo
	WCVqFK6dQe99woRcrHu482UsTR1WTvJFtGKaIFQb5SbEFo1ZL4V7V8QtFCfoBvUC
	Jl8wtpRbtOJgWwAR/CDQ70KNbCfY9jwO7oTe9GzxUBjT6dniWDdluGKuNTxNkJnr
	GTOPjc3Hl6UovJ5w2E+RL0nCVFH6XrB9TXTE4F9MFssOMmFavMN4UMUDRn7CTqQ=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xwd3yaxvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 07:49:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4467nqSl009975
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 May 2024 07:49:52 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 6 May 2024 00:49:49 -0700
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Krishna Kurapati
	<quic_kriskura@quicinc.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] usb: dwc3: core: Fix unused variable warning in core driver
Date: Mon, 6 May 2024 13:19:39 +0530
Message-ID: <20240506074939.1833835-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KfaW0eNgj8nXo7IJOufUNp50r1Hf-48l
X-Proofpoint-GUID: KfaW0eNgj8nXo7IJOufUNp50r1Hf-48l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_04,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 mlxlogscore=508 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405060050

While fixing a merge conflict in linux-next, hw_mode variable
was left unused. Remove the unused variable in hs_phy_setup call.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/all/202405030439.AH8NR0Mg-lkp@intel.com/
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
Changes in v2:
Added reported by and closes tags.

 drivers/usb/dwc3/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 8b6f7769fcd5..7f176ba25354 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -676,11 +676,8 @@ static int dwc3_ss_phy_setup(struct dwc3 *dwc, int index)
 
 static int dwc3_hs_phy_setup(struct dwc3 *dwc, int index)
 {
-	unsigned int hw_mode;
 	u32 reg;
 
-	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
-
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(index));
 
 	/* Select the HS PHY interface */
-- 
2.34.1


