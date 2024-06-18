Return-Path: <linux-kernel+bounces-219583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6557790D5C3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBD1DB263F0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480EF178370;
	Tue, 18 Jun 2024 14:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qsDCY/O3"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B165F1741FF;
	Tue, 18 Jun 2024 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719473; cv=none; b=fTd1ufvM2+TF5ynL+SjMCpgi3ewkv7cW1s/MGhO1g+j+1pqArOxEw6md3ISEg2gSlZqpjwX6/KqT5ZAvZonDrHNSCe3XHov3EzJnGzZJzvcehM+JwcNQvxYifauUbPhGBXTkXYPMU860tYiyIVIOTJ2GaZeSNTYDqca/o5z2iXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719473; c=relaxed/simple;
	bh=TNrQkppq23456E4mBiNJ1ZZ6N8RGVEuFD5g005xUDkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mih4Wr6pIxOOYklHiYxlO45+ELTCt8MixT+fOtJV7oRzsU29j6T+XSdggHP6kOKu/qAS9UY18WFY6XawWyI3za72P+3l9S6SCsp4UEqN2G1YN+rEjmPvt4NeKjUxYHVzcfUAEFMfWs3So+DCVR/+D8im5hUX2uhLYB73HxqFFR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qsDCY/O3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IDwqVV021940;
	Tue, 18 Jun 2024 14:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=SVxEI1Xo6AFLf
	6kIIt2Gs7dNrEuAM0rikRzL+VZn28w=; b=qsDCY/O3Od/EZxjiRk/jBXmC75vKx
	knEpMw6PMNfpPGnIidSVZ5cGYc4uwd4A2cRJhuqGBqPsC9FEfx4rLC//23Lc9nm5
	ZeMNey158ChzxDEqwLc3/cdxRcVeXk3q/KSMUxSrXRfkGI8azUNmFRCii2D1NL5W
	oy5nY0SQ4E3WqJs+woWIJpiKuBaWS/eI0d9Z2OPQXa22ExZmDjwYs3fHaDDFper9
	ayhfPeNtIO3oZv2KEEuObofXJF2UGurMY7/Qh0hVa2T9Zd8O7gaVwyRJ5pVNs9Pr
	ow6cJwaJtHpye18QgkF0SkuQPeFI4x97/h+OEcZ3gEwHQqwVGVBv1c8ww==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yubkdr0jh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 14:04:17 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45IE3HKM029654;
	Tue, 18 Jun 2024 14:04:17 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yubkdr0je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 14:04:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45ICYMRL006136;
	Tue, 18 Jun 2024 14:04:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysn9um406-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 14:04:15 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45IE4AAg52036010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 14:04:12 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5537420043;
	Tue, 18 Jun 2024 14:04:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AC802004D;
	Tue, 18 Jun 2024 14:04:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.108.117])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Jun 2024 14:04:05 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH V3 2/3] tools/perf: Use is_perf_pid_map_name helper function to check dso's of pattern /tmp/perf-%d.map
Date: Tue, 18 Jun 2024 19:33:53 +0530
Message-Id: <20240618140354.5765-2-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240618140354.5765-1-atrajeev@linux.vnet.ibm.com>
References: <20240618140354.5765-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: InNWIRnUihqGiH0z_06b-wwFWPX68NZe
X-Proofpoint-GUID: AEklJCeYBgdOnXrov_IMQY9PaqoVWnYl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180104

commit 80d496be89ed ("perf report: Add support for profiling JIT
generated code") added support for profiling JIT generated code.
This patch handles dso's of form "/tmp/perf-$PID.map".

Some of the references doesn't check exactly for same pattern.
some uses "if (!strncmp(dso_name, "/tmp/perf-", 10))". Fix
this by using helper function perf_pid_map_tid and
is_perf_pid_map_name which looks for proper pattern of
form: "/tmp/perf-$PID.map" for these checks.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/util/dsos.c    | 2 +-
 tools/perf/util/srcline.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index ab3d0c01dd63..846828ea1f00 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -275,7 +275,7 @@ static void dso__set_basename(struct dso *dso)
 	char *base, *lname;
 	int tid;
 
-	if (sscanf(dso__long_name(dso), "/tmp/perf-%d.map", &tid) == 1) {
+	if (perf_pid_map_tid(dso__long_name(dso), &tid)) {
 		if (asprintf(&base, "[JIT] tid %d", tid) < 0)
 			return;
 	} else {
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 9d670d8c1c08..51eb78993fe2 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -39,7 +39,7 @@ static const char *srcline_dso_name(struct dso *dso)
 	if (dso_name[0] == '[')
 		return NULL;
 
-	if (!strncmp(dso_name, "/tmp/perf-", 10))
+	if (is_perf_pid_map_name(dso_name))
 		return NULL;
 
 	return dso_name;
-- 
2.35.3


