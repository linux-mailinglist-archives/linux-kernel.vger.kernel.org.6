Return-Path: <linux-kernel+bounces-197543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F05408D6C4F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 00:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DBAD1C24AFC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 22:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD41380626;
	Fri, 31 May 2024 22:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L1oAFopk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862E57C6D5;
	Fri, 31 May 2024 22:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717192890; cv=none; b=aKkpnO8Gn+Qnw813/osKHz69mKwBSjEAYFtZ9jVrtESHd3Bar0nOJWTT1t82djL/mgbZgpx0mQsIFcqQzfktls/btYgHXfrBju9/KhO8YnujD891R+FXPIrizlEMZxg3cfk2wmt5DtDm/gnor0HU8WFfBymiOcW4tNSUdsSrfXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717192890; c=relaxed/simple;
	bh=GEv0qDvfvODZ6seXHQ7UUUQ4eKVs2Wh3/3XrNIWWv7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=ZtaSwkxSacaZMywalBu6X2h9EaEeLaYXGxYAwBdr7XX8O98kDx3pmaSRCztocEZdPFhqBhSRPSytDnIvHNmjwjepptyFEVx3QapnXAUEqYYRNFs6Klf9a3PV9PdwdWm0ZdveTLX60xSV7S5kwuY9eB8jXV2BWioeLxuWpp5dNyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L1oAFopk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VHP8OE016293;
	Fri, 31 May 2024 22:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=IUh6ggCC9Qril41TpwYvch
	5CFUtO1Qcti3THYUHCXiU=; b=L1oAFopkQab/MC4oV5beJy2m2ZvXWgRvE+uJ8+
	YpfAY3rGtfk9ByKFxEOc43c8EiTMYotI3m6aAx3iil7BamNLnuRxo913BFQI1kvt
	Oz/6z8z/3XhPFmsS1oQbzK4qOH6w9W21L/iqPBjkGp2A25yMZQkmKLCXmEScgSVD
	DkecXVl628NsLpLvwieofPp1rRO4IWyUmkDMvCd51PXkBhXdrmhEzFfmYrtTqrh9
	myOIQ+4265upBUqzPGQ03O3xminfKa0LpvAUdajyy+bU5A5oOjBQniiC+4G6o52l
	Lkzvj/ZpgqEZJeePOq9CNPaO3iZtvgV1bsQvJqYOjxNPZthA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2n8ax3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 22:01:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44VM1FV6032364
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 22:01:15 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 15:01:14 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 31 May 2024 15:01:14 -0700
Subject: [PATCH] dyndbg: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240531-md-test_dynamic_debug-v1-1-2194b477f55e@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAKlIWmYC/x3M0QrCMAxA0V8ZeTawrRuCvyIymjZuARul6WQy9
 u9WH8/DvTsYZ2GDS7ND5reYPLWiOzUQFq8zo8Rq6Nt+aEfXYYpY2MoUP+qThCkyrTNSdI5HCmf
 iAWr7ynyX7f+93qrJGyNlr2H53R6i64bJW+EMx/EFvpS/W4YAAAA=
To: Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron
	<jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BECvLFVWUARQCasFl5wp_Ldsfukel1MJ
X-Proofpoint-ORIG-GUID: BECvLFVWUARQCasFl5wp_Ldsfukel1MJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_14,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=992 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310168

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_dynamic_debug.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 lib/test_dynamic_debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 8dd250ad022b..77c2a669b6af 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -162,4 +162,5 @@ module_init(test_dynamic_debug_init);
 module_exit(test_dynamic_debug_exit);
 
 MODULE_AUTHOR("Jim Cromie <jim.cromie@gmail.com>");
+MODULE_DESCRIPTION("Kernel module for testing dynamic_debug");
 MODULE_LICENSE("GPL");

---
base-commit: b050496579632f86ee1ef7e7501906db579f3457
change-id: 20240531-md-test_dynamic_debug-bd33e5bc7be4


