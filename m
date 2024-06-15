Return-Path: <linux-kernel+bounces-216015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DC99099F1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 23:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F2B283641
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 21:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF10D61FEB;
	Sat, 15 Jun 2024 21:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ToglYsRd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DBC1870;
	Sat, 15 Jun 2024 21:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718485283; cv=none; b=LBEbryIJ1u4kpWQuMcTdLLWCoYVgP2t4TLCYQf13sp2JpJLKI60nBFGvG1Bc+A9078rcoc2z9lwiGtkuyg4V/u5Rbaq6yOBm91aG83tKEulGuV8ooklqxkw1zAcqFnIdXfSDrLUdHsUJFETiIVF1xHu5qKjoszItLVmgcROChNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718485283; c=relaxed/simple;
	bh=V/vJ49yGU1PljdmfA1ioBDXkNhCbpTa8U/XnxpPFETs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=nxAsFXMsLoBmXcdJeysmj82CwbJm8ke03DHqDwB8ljKjIdFu85CwPnNBeDPVQYXIK0CVNO6S043kdg+yvWoF5TCjSaDjU8nd/6+JVo0h9QhSi3ocSl+m10TsaWr+wH6p7vlNXiIa4gkBk2KdMbknrqS/HRv1ACYj3g93Tjqbv30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ToglYsRd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45FL12ea018306;
	Sat, 15 Jun 2024 21:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=3rdlMPl/UjGJyNmiFVwR3A
	A09994lksilMqKf7ZyvhY=; b=ToglYsRd1sQgJmo/VLw8LbyGn/qRDzUHQNPYBN
	BpT8W7ELi4BwQEadnenOiI1E65LgymJ7W6ZZ+DeagoZGaCrbG+g/hdv4DQGYgQcx
	M8F9kT12rUR2cHIoca8C+Np5bbNoT3BhD0MIoYXmPXHDZEaxTw4wqNQeC+8iNk3x
	W3/y7YTWvHdJcsnSKB6oJlEYM2FU56a3kJMb+VFa9/kpDONcZQ0VtXN6wIhhSU4W
	YOreqGJtJWZZaZ2t0XTF0TyAYDxmfwyekvsbVhuwcjIqFyuwdgNqgcDCWC/83NMH
	s1tHc2Tjd2SfZgROcrm5FainOKKw8xmieIAs31N2yFildhtg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys31u1282-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 21:01:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45FL1F6v000770
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 21:01:15 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 15 Jun
 2024 14:01:13 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 15 Jun 2024 14:01:12 -0700
Subject: [PATCH] agp: uninorth: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240615-md-powerpc-drivers-char-agp-v1-1-b79bfd07da42@quicinc.com>
X-B4-Tracking: v=1; b=H4sIABcBbmYC/x3M0QqDMAxA0V+RPC+gpcrYr4w9pG2mgVlLMp0g/
 vu6PR643AOMVdjg1hygvInJkiu6SwNxojwySqoG1zrfDl2Pc8KyfFhLxKSysRrWUJHGgikM3qf
 QX6PzUA9F+Sn7/35/VAcyxqCU4/R7viSvO85kb1Y4zy/65ajgjAAAAA==
To: David Airlie <airlied@redhat.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GuiBh1OeaLRH8GLIw1ZG47TC9WIt75-3
X-Proofpoint-ORIG-GUID: GuiBh1OeaLRH8GLIw1ZG47TC9WIt75-3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-15_14,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406150160

With ARCH=powerpc, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/agp/uninorth-agp.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/char/agp/uninorth-agp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/agp/uninorth-agp.c b/drivers/char/agp/uninorth-agp.c
index 84411b13c49f..b8d7115b8c9e 100644
--- a/drivers/char/agp/uninorth-agp.c
+++ b/drivers/char/agp/uninorth-agp.c
@@ -726,4 +726,5 @@ MODULE_PARM_DESC(aperture,
 		 "\t\tDefault: " DEFAULT_APERTURE_STRING "M");
 
 MODULE_AUTHOR("Ben Herrenschmidt & Paul Mackerras");
+MODULE_DESCRIPTION("Apple UniNorth & U3 AGP support");
 MODULE_LICENSE("GPL");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240615-md-powerpc-drivers-char-agp-db644db58c24


