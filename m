Return-Path: <linux-kernel+bounces-197973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B73E8D716B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 19:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2054D282305
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 17:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B0A154C02;
	Sat,  1 Jun 2024 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A91RfA58"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCA71D6AA;
	Sat,  1 Jun 2024 17:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717264419; cv=none; b=It1jWebhj4ExFAsrWZ3MDubo4E4jfvp6aKoon5gzD4+CONhW7FJiT8HijGZ6noyopwVXJR4sUwJqtG7p5mvICBOoXv7/00aAf5LLg0cJNnWdV9W6K53kKYqGKU/zuAACHWCzyeOOO0ChnjGSYOkvXHhQBVcjnRvUYFHi9QKgOVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717264419; c=relaxed/simple;
	bh=W6fL1LIeb6SdadBn0BaQJD5p8r/LYlVrESLXuy7w8WI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Ici2vmAR6miyO/NDJA8gAvK7fXfV4OQjCOWTfslPXkb8o7M23InXykTQ575cV7SVqppSSu79g6cOjyXHLwA7ZQ3uFFlLkeeSB8gQfWpqD73oFbt4uEmuUpO5RBt7rksOM0gvvEPzfIEk5vvI/t7VPAh90cYRQXnMFiABzfKxVlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A91RfA58; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 451HP6Oj009692;
	Sat, 1 Jun 2024 17:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=x05cazM9/0t6I2+hrJPXOF
	8T8X6PoTVxElCNY6MYCKg=; b=A91RfA58yiKMqajuwy/u444MbBxODe0rcMPwSj
	AJJRAcBs2mI1UUAOQIjppPcfpQqKiw8MfXM/y1JaJv4z5/dBp8ws0ERWEWjqgaxU
	A3WkKp5VQk/5fq4qS8wC3qVLXqNgfhby61SYppDfu+glvrpiovQ7Nbxx21U6BlSQ
	XGYy34NcvELsR07tw8yP5Gu8aR5D4VgFSB2zPaDCV6sXJVAECM27BoDpoBHZCDy4
	+77PTZrgzXPeOnJj6wBLjgzbyE9oARXOW0/T91qjRDD+WvvMP+jgnw7jbOD1s2Lt
	atvypyYN2p1Y1Y3puxJIY69q45V7BbHq7g9LOthkSguoDB9g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw6qh3xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Jun 2024 17:53:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 451HrZU3025037
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 1 Jun 2024 17:53:35 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 1 Jun 2024
 10:53:34 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 1 Jun 2024 10:53:34 -0700
Subject: [PATCH] kunit: add missing MODULE_DESCRIPTION() macros to
 lib/*_kunit.c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240601-md-lib-kunit-tests-v1-1-4493fe0032b9@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAB1gW2YC/x3MTQ6CQAxA4auQrm0yjIg/VzEupkyVRhhJOxgSw
 t0ZXX6L91YwVmGDW7WC8ldMPqmgPlTQ9SG9GCUWg3e+ca2rcYw4COF7TpIxs2XDSxtPdPXHSPE
 MJZyUn7L8p/dHMQVjJA2p63+rQdK84Bgss8K27cdhblCDAAAA
To: Andrew Morton <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: n7uprtwNucPae3OSa_7In_bS5TKK8rkZ
X-Proofpoint-ORIG-GUID: n7uprtwNucPae3OSa_7In_bS5TKK8rkZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-01_11,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0 malwarescore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406010141

make allmodconfig && make W=1 C=1 reports for lib/*kunit:
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/bitfield_kunit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/checksum_kunit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/cmdline_kunit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/is_signed_type_kunit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/overflow_kunit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/stackinit_kunit.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
This is a subset of the modules having this issue with a source path
of lib/*_kunit.c and which are not explicitly referenced by an entry
in the MAINTAINERS file.
---
 lib/bitfield_kunit.c       | 1 +
 lib/checksum_kunit.c       | 1 +
 lib/cmdline_kunit.c        | 1 +
 lib/is_signed_type_kunit.c | 1 +
 lib/overflow_kunit.c       | 1 +
 lib/stackinit_kunit.c      | 1 +
 6 files changed, 6 insertions(+)

diff --git a/lib/bitfield_kunit.c b/lib/bitfield_kunit.c
index 1473d8b4bf0f..5ccd86f61896 100644
--- a/lib/bitfield_kunit.c
+++ b/lib/bitfield_kunit.c
@@ -151,4 +151,5 @@ static struct kunit_suite bitfields_test_suite = {
 kunit_test_suites(&bitfields_test_suite);
 
 MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
+MODULE_DESCRIPTION("Test cases for bitfield helpers");
 MODULE_LICENSE("GPL");
diff --git a/lib/checksum_kunit.c b/lib/checksum_kunit.c
index 404dba36bae3..4e4d081a1d3b 100644
--- a/lib/checksum_kunit.c
+++ b/lib/checksum_kunit.c
@@ -639,4 +639,5 @@ static struct kunit_suite checksum_test_suite = {
 kunit_test_suites(&checksum_test_suite);
 
 MODULE_AUTHOR("Noah Goldstein <goldstein.w.n@gmail.com>");
+MODULE_DESCRIPTION("Test cases csum_* APIs");
 MODULE_LICENSE("GPL");
diff --git a/lib/cmdline_kunit.c b/lib/cmdline_kunit.c
index 705b82736be0..c1602f797637 100644
--- a/lib/cmdline_kunit.c
+++ b/lib/cmdline_kunit.c
@@ -153,4 +153,5 @@ static struct kunit_suite cmdline_test_suite = {
 };
 kunit_test_suite(cmdline_test_suite);
 
+MODULE_DESCRIPTION("Test cases for API provided by cmdline.c");
 MODULE_LICENSE("GPL");
diff --git a/lib/is_signed_type_kunit.c b/lib/is_signed_type_kunit.c
index 0a7f6ae62839..88adbe813f3a 100644
--- a/lib/is_signed_type_kunit.c
+++ b/lib/is_signed_type_kunit.c
@@ -46,4 +46,5 @@ static struct kunit_suite is_signed_type_test_suite = {
 
 kunit_test_suite(is_signed_type_test_suite);
 
+MODULE_DESCRIPTION("is_signed_type() KUnit test suite");
 MODULE_LICENSE("Dual MIT/GPL");
diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index 4ef31b0bb74d..6c44fb26719f 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -1223,4 +1223,5 @@ static struct kunit_suite overflow_test_suite = {
 
 kunit_test_suite(overflow_test_suite);
 
+MODULE_DESCRIPTION("Test cases for arithmetic overflow checks");
 MODULE_LICENSE("Dual MIT/GPL");
diff --git a/lib/stackinit_kunit.c b/lib/stackinit_kunit.c
index 3bc14d1ee816..c14c6f8e6308 100644
--- a/lib/stackinit_kunit.c
+++ b/lib/stackinit_kunit.c
@@ -471,4 +471,5 @@ static struct kunit_suite stackinit_test_suite = {
 
 kunit_test_suites(&stackinit_test_suite);
 
+MODULE_DESCRIPTION("Test cases for compiler-based stack variable zeroing");
 MODULE_LICENSE("GPL");

---
base-commit: b050496579632f86ee1ef7e7501906db579f3457
change-id: 20240601-md-lib-kunit-tests-86d5b923dbd7


