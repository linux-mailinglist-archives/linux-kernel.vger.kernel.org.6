Return-Path: <linux-kernel+bounces-293935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C169586B2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D40F6281F52
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C33190493;
	Tue, 20 Aug 2024 12:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QclY7f9j"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E5518E76E;
	Tue, 20 Aug 2024 12:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724156141; cv=none; b=pBkW5/ePPh5WVVw6UtHMDcSFeop5tlapIG5jiIPfy8Y41dirb2NsQKF15hmqkhBJWae36orSHgWVDcEmApALTs6gZKGPD7DI2q4whMHDb3yjZA3pPP7FZNc8BTSVd2PBxyMe1IYMT3zCEJyH6cTMeH2TjF5NsyRt4DLCugRKmhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724156141; c=relaxed/simple;
	bh=8zJhHVbMjE3Xkm9dt/qt0GiFzBTzwByZQAz6eCkn4HU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CIivjJuYa7BVozps1m4geayDrGK4GreZAYP8+5/9sN2LHIiIX5JKIwGZPjKliBZZ4kiv2s6XEINBzPp3ajFtowTDuV649m7eIYD9Gs5J64G9h0NAdyZydCkoPVwJkDhb0oP1w/F0T471sWoR1GGEvqHVgfE1Uli27QRksp6xD9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QclY7f9j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47K74Pp8013240;
	Tue, 20 Aug 2024 12:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aP5KX24UJ/vW0xetZirucPnqfr8HBBYCQbmFG+U/ZlY=; b=QclY7f9jKoqADfxE
	UG1376jrcfeYZnn1UkbUtw1ujQiiVzsvIFvivNZQUOD16eFR2xsjunYW7n1eVXvM
	Y5L2+sqHiXhd6tyFpca3MCyfH0DJWTJnvoPrbr6Z6wKNEXuzFjyGu31d5J9u+SvG
	9trVeoo9utlS6vwwoZRMu7zO9esDtmwvVWN0Cy7RR0l7+1gFo7D76B7AzhM5JMHI
	/xD49opVnltEtANBwE7gEjAx1LSFkLLgQqiBm0iIiPM6iMwCBX6sj23baVdqlDWX
	EzeezzhXNrkF3sHfs7JaumEuE2+9JizsrgKlCrg9EM24eoiFsIqx5o45GAwnkBL8
	HHSdSw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 414pe5gxdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 12:15:36 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47KCFLQN009369
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 12:15:22 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 20 Aug 2024 05:15:20 -0700
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <Thinh.Nguyen@synopsys.com>, <gregkh@linuxfoundation.org>,
        <mathias.nyman@intel.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_zhonhan@quicinc.com>
Subject: [PATCH 1/2] usb: dwc3: core: Call cpu_relax() in registers polling busy loops
Date: Tue, 20 Aug 2024 20:15:00 +0800
Message-ID: <20240820121501.3593245-2-quic_zhonhan@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240820121501.3593245-1-quic_zhonhan@quicinc.com>
References: <20240820121501.3593245-1-quic_zhonhan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: YHhRBb7PrubpZgOHvQg7EzUJPFXSHZv5
X-Proofpoint-GUID: YHhRBb7PrubpZgOHvQg7EzUJPFXSHZv5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_09,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 spamscore=0 mlxlogscore=688 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408200091

Busy loops that poll on a register should call cpu_relax(). On some
architectures, it can lower CPU power consumption or yield to a
hyperthreaded twin processor. It also serves as a compiler barrier,
see Documentation/process/volatile-considered-harmful.rst. In addition,
if something goes wrong in the busy loop at least it can prevent things
from getting worse.

Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
---
 drivers/usb/dwc3/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 734de2a8bd21..498f08dbbdb5 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2050,6 +2050,8 @@ static int dwc3_get_num_ports(struct dwc3 *dwc)
 		if (!offset)
 			break;
 
+		cpu_relax();
+
 		val = readl(base + offset);
 		major_revision = XHCI_EXT_PORT_MAJOR(val);
 
-- 
2.25.1


