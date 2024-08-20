Return-Path: <linux-kernel+bounces-293932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 561FC9586AB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007AB1F2564B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B05B18FC93;
	Tue, 20 Aug 2024 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ouWqtsTe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0107118B48D;
	Tue, 20 Aug 2024 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724156133; cv=none; b=PY8teVmEw0tnPyhtIUXtocGR8eMhS58Y5HTEhfc/wSM5wgxh/OU3TtDcdoKlXIX7N3Gkleje/h4YE+b6thvRJ01NkAOK+X0uG9JPRn4MSr0vxQ5RVcPlzOFfmgGoWbwLJM22xnYkodPXeuYHG9ThrCoNF+nL/OAXq4CYqZpr+Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724156133; c=relaxed/simple;
	bh=Z4xe6jEfZ5KTh4rfWb/uoY/IdUUslSwwWSaZcLRO2+s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ta8twJTrE+5xByKRu6G7SKduud9j3H1w0BNfCAdW5Cs6r2kBk1m5a2+iDKHM+Z4YWBvcjjR+ZSvqxVy/eH68XoSw/ca5n2skPSrrehDbrxmUIHKVnqZ44oC/zTa85pwxZdwPNM+Jc5zpknllHXJQDGb1YQO2POgNSp6ynBs/NjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ouWqtsTe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47K8vs5m001126;
	Tue, 20 Aug 2024 12:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k/GEw8BgJg/67/FhttEOkHwMmg1WkEY4jXTADC+q3qc=; b=ouWqtsTeCWdLWMcm
	ZKVVML3XRAWcMsS2RH0/X3mlJvAKFj5AZex98vMcAAzwSlAW4+ScQoyEVs/paLmp
	tSLXCBVP6WBaGV81aBlEVnhQ5Q2088Ust8brMBcn707Z3kyLxd7IrI4uqd/d6WMO
	2nxm85dbmN7cnH7AO4oUK2Pp1zABdLI27gfA2IMNWHNtGRo4hGIzeVCxmNXns/L/
	PW2lekaV3MLgdJfurogerayx2asH8aSOktSGrSc9SWyqBWSv4UMh+FwsuLe4L1Tg
	NMdv42sjOVCv6O1KVjqulJ4AehfPRob7BT8TEeTLAciKozNBrZvQrEiHTW/QGzQ6
	1ERFQQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 412jtryr6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 12:15:26 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47KCFORn009427
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 12:15:24 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 20 Aug 2024 05:15:22 -0700
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <Thinh.Nguyen@synopsys.com>, <gregkh@linuxfoundation.org>,
        <mathias.nyman@intel.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_zhonhan@quicinc.com>
Subject: [PATCH 2/2] usb: xhci: ext-caps: Use cpu_relax() when polling registers
Date: Tue, 20 Aug 2024 20:15:01 +0800
Message-ID: <20240820121501.3593245-3-quic_zhonhan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: otxIxkeyCTZiGiB6Kk47urf640p35LmK
X-Proofpoint-GUID: otxIxkeyCTZiGiB6Kk47urf640p35LmK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_09,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 suspectscore=0 bulkscore=0 mlxlogscore=506 mlxscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408200091

It is considered good practice to call cpu_relax() in busy loops, see
Documentation/process/volatile-considered-harmful.rst. This can lower
CPU power consumption or yield to a hyperthreaded twin processor and
also serve as a compiler barrier. In addition, if something goes wrong
in the busy loop at least it can prevent things from getting worse.

Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
---
 drivers/usb/host/xhci-ext-caps.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/xhci-ext-caps.h b/drivers/usb/host/xhci-ext-caps.h
index 96eb36a58738..25d148d60ab0 100644
--- a/drivers/usb/host/xhci-ext-caps.h
+++ b/drivers/usb/host/xhci-ext-caps.h
@@ -144,6 +144,8 @@ static inline int xhci_find_next_ext_cap(void __iomem *base, u32 start, int id)
 		if (offset != start && (id == 0 || XHCI_EXT_CAPS_ID(val) == id))
 			return offset;
 
+		cpu_relax();
+
 		next = XHCI_EXT_CAPS_NEXT(val);
 		offset += next << 2;
 	} while (next);
-- 
2.25.1


