Return-Path: <linux-kernel+bounces-198057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CB18D72EB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 02:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC6B1F21781
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 00:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFBAEBE;
	Sun,  2 Jun 2024 00:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ViZM8Vg9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE33386;
	Sun,  2 Jun 2024 00:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717287930; cv=none; b=kKq6dDQxLDMP1HnXVQkUj1WJAjeN5yVAJ7EK/VBZi/Dr52xRflwjC6lH4lrzoq9A0lktC67WhRB7mW1HbjTJ+O/vTJj5XYGSjF6d/eyduipu5r+9txY87T6Nhaq5RFLSXKsyE1nyqysVZ9Vaf4lMDyMbtCCpL3mksyOWVzf5ywg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717287930; c=relaxed/simple;
	bh=RHLo5I/CnK6EdaCaebUkR0C5pGnV0meL6FCpkLKBEs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=SDnr66YId16f6i5pqANePgP4Mpx+TE1YQLyz2Zi5eIMLI5wmtm3Xw/rNks4P2vStPBeoNaKeImRAlMFP6qM98wJytwgOL4KlssPDvOfqSZ6RdlJcRGmxAkcS2aGjbEuRaLT+UFq066kKj1XIyJA00uNNsIihnSyc4aTIqDNZOkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ViZM8Vg9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 451NqTb3012016;
	Sun, 2 Jun 2024 00:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=b57Bz9K0g3EUlsFdhpEzjD
	KwQajXnJFpOYBc0sGwSVw=; b=ViZM8Vg9Hd1wCbwyOcV5RZg8I4XoQK2RF0yyp8
	T42xZQ7+Q7S6RN066VVc7QyMBPWwePzmb5pcU/M6UFc96K4bAW0s3q1cLTgY5Acu
	oiIPskB5lG8cfIGZu18UeKdA/gwEy9knRYN83x8nrXCCdpT2W1Xd+kAuZPKfhaka
	qWjYCXg3cDYmXxECGYZW17CXZeFn39ZcQ7AImzvg/dhPtzpf9CranGWbaFy8mtLS
	id+vv96q4dhpzxwjyr5KmseHqJzpqWSboDYhD1t/L8qvHutib8Jrm6D73S+4uHZC
	D42k9vOJ5f+SrxvQwg8uXMDkZUTf0Dhflz/P/9jBYOXu73Qw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw5khe1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Jun 2024 00:25:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4520PNGj031950
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 2 Jun 2024 00:25:23 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 1 Jun 2024
 17:25:23 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 1 Jun 2024 17:25:22 -0700
Subject: [PATCH] fprobe: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240601-md-samples-fprobe-v1-1-5d256a956612@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAPG7W2YC/x3M0QrCMAyF4VcZuTbQdSrqq4gX7Zq5wNqVZI7B2
 LsbvfzgnH8HJWFSeDQ7CK2sPBdDe2qgH0N5E3Iyg3f+7K6uxZxQQ64TKQ5V5kgYfbz7dIvUXRz
 YrwoNvP2bz5c5BrWRhNKPv9LE5bNhDrqQwHF8AcK1F22CAAAA
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt
 (Google)" <rostedt@goodmis.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LNdpA7JpVhxZUNdVfD0P-B0j-xDQSWAf
X-Proofpoint-ORIG-GUID: LNdpA7JpVhxZUNdVfD0P-B0j-xDQSWAf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-01_11,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406020001

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in samples/fprobe/fprobe_example.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 samples/fprobe/fprobe_example.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/fprobe/fprobe_example.c b/samples/fprobe/fprobe_example.c
index 64e715e7ed11..0a50b05add96 100644
--- a/samples/fprobe/fprobe_example.c
+++ b/samples/fprobe/fprobe_example.c
@@ -150,4 +150,5 @@ static void __exit fprobe_exit(void)
 
 module_init(fprobe_init)
 module_exit(fprobe_exit)
+MODULE_DESCRIPTION("sample kernel module showing the use of fprobe");
 MODULE_LICENSE("GPL");

---
base-commit: b050496579632f86ee1ef7e7501906db579f3457
change-id: 20240601-md-samples-fprobe-b2b92d8be350


