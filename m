Return-Path: <linux-kernel+bounces-217358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B1B90AEB0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82B91C249E2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134E6199382;
	Mon, 17 Jun 2024 13:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D5WEAjyC"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D80199237;
	Mon, 17 Jun 2024 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718629445; cv=none; b=Ollh0fF8drq2UhN4gxhXSCPkyLlvGK3WHIMyjrMaV3w8w6zcJSLWO5jB2/31W7mbz4uYPJ8y7o5fLd6e75yD/OzW+ac5cIxFdBr5sHYX2szSLr4MPcu6CW4gPelPDD6ywgomiphEDwZxJFAmqpaSQ9XUVQY2zjJUEIUrhO4thw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718629445; c=relaxed/simple;
	bh=XbvpTuTFZSjOFb0Dl0+7xfLw8Q3eqPKqKNAbu6xICKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=evAsZVivyk6lfR99938EF2n0efNx3QAhKU1sRkYhMDB09acjlLW65MCnQRhZOY27RYRnBPn0ymh30ReuW1oNHTdyiFKVXxTW/Zp6c7hcbeMcYCdcJQOuGnqaxljJ3t+HiTpOntRHAo7Va+dQzytiaGRDO7JK6b77G3PhUaDk4gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D5WEAjyC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HCuJ2P029439;
	Mon, 17 Jun 2024 13:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=jMWoQhTKi5b+U
	4EY97mVeZVcSB908Ae2+adgmdY4C28=; b=D5WEAjyCnNLDzowIsv5IuDkReuXZ0
	+KJGCQQAM+fWfNXDqure/NzHtBPqnT07ODMNW0/dzBeeS8N65yrgrtiaUOk52k2W
	xWrmdVA/A7om5dKzufH+zgj2GIsgS63FgVF/QmCGP+D/bXc4O2mu864wgzWiJ9aw
	h7wFqIsujclmbAjiv71cYQeXC/o1F9PXV5Ic7BuV+N14OYTdeXjhMo+3aUp6U+xM
	oyoULsejyeL3097natSITb9a+3VOzjs18NKggZGlZncZw3q+b9sH3x0qLpHyX3qO
	2mnP8vDsH7UxLvxrh8LcWaPwBLeqw6TLTatq8pHiaNA48JuApEVZmJfYg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytkv60abn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 13:03:51 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45HD3pKF010037;
	Mon, 17 Jun 2024 13:03:51 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytkv60abm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 13:03:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45HC82Ui011355;
	Mon, 17 Jun 2024 13:03:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yspsmt2mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 13:03:49 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45HD3hU949217794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 13:03:45 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0CC22004B;
	Mon, 17 Jun 2024 13:03:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 247C92005A;
	Mon, 17 Jun 2024 13:03:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.120.218])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Jun 2024 13:03:40 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH V2 3/3] tools/perf: Fix parallel-perf python script to replace new python syntax ":=" usage
Date: Mon, 17 Jun 2024 18:33:32 +0530
Message-Id: <20240617130332.13427-3-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240617130332.13427-1-atrajeev@linux.vnet.ibm.com>
References: <20240617130332.13427-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uR2z0rw8GBcd15yO0Jw7F-yTq8IAimiq
X-Proofpoint-ORIG-GUID: cHytTiVi8hICKZBOJR5ishlNk1lpsILG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_11,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406170100

perf test "perf script tests" fails as below in systems
with python 3.6

	File "/home/athira/linux/tools/perf/tests/shell/../../scripts/python/parallel-perf.py", line 442
	if line := p.stdout.readline():
             ^
	SyntaxError: invalid syntax
	--- Cleaning up ---
	---- end(-1) ----
	92: perf script tests: FAILED!

This happens because ":=" is a new syntax that assigns values
to variables as part of a larger expression. This is introduced
from python 3.8 and hence fails in setup with python 3.6
Address this by splitting the large expression and check the
value in two steps:
Previous line: if line := p.stdout.readline():
Current change:
	line = p.stdout.readline()
	if line:

With patch

	./perf test "perf script tests"
	 93: perf script tests:  Ok

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
Changelog:
 v1 -> v2
 Added "Acked-by" from Adrian

 tools/perf/scripts/python/parallel-perf.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/parallel-perf.py b/tools/perf/scripts/python/parallel-perf.py
index 21f32ec5ed46..be85fd7f6632 100755
--- a/tools/perf/scripts/python/parallel-perf.py
+++ b/tools/perf/scripts/python/parallel-perf.py
@@ -439,7 +439,8 @@ def ProcessCommandOutputLines(cmd, per_cpu, fn, *x):
 	pat = re.compile(r"\s*\[[0-9]+\]")
 	p = subprocess.Popen(cmd, stdout=subprocess.PIPE)
 	while True:
-		if line := p.stdout.readline():
+		line = p.stdout.readline()
+		if line:
 			line = line.decode("utf-8")
 			if pat.match(line):
 				line = line.split()
-- 
2.35.3


