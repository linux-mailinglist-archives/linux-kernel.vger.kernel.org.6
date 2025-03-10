Return-Path: <linux-kernel+bounces-553579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E72CA58BEA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D8F93AB0CF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 06:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0831C9EAA;
	Mon, 10 Mar 2025 06:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LRLrd6pt"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A7F19DF52
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 06:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741587864; cv=none; b=lO8pMMAFyJXSRltR968g6AoeroSfBaouqjHcEp8NEE4YIlOdryGe6vP3yfP/WrWPu7aNEFutTBZgH0vUBDp90g6YwF1+N+kK2icfAUs1wc7csYOaiH+6EplFZhbaFhzxCr6IOGE3uOu8lNKAeYUjibLNgtBP8rEBQ9dAFjg8DKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741587864; c=relaxed/simple;
	bh=tcK0PUbslR+bvlzbsya5uMAg/XjaMmmEMZecFtDIMBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MVpSm2Zm+8EaFBaeoejudy5Wn91Nb89G423P01OF1SafYV/yMuxO8jmAPoJAXqm00yDUgMB1ZK9r3QdbkxU9zfv0fZ5qB5Z6kuRX0OuMPb4WjyfieYuNg73j1OTBevEHiqTeIHU9HUuHjn1RMf261BhIQC5PAhMmzGVMZT6C2Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LRLrd6pt; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A1fgPo012416;
	Mon, 10 Mar 2025 06:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=b75Mf9h9xctxfUDt
	GDtlI0oDRLNI6xBjqBOo1l7zqmU=; b=LRLrd6ptTD4zFLhQ1hcc9jjZ2wJdortb
	Gfqhx7enUyMyYxoR+ofr48bGagnpYBAHdwdF51spAwVIBhDt8IUsVyjlcwm/OCpR
	2Iji4m882M+K1WfsoXWx4dWc/en5Hk78t3G4ykmxtPIulaJpmiwSYmxGJc4zKTzr
	hRwy9tlXNwaLIeVxrl91CZ6xcq5B2LV2A6UKva7Am88QluQEaZvKG9Vcm7gnCmJu
	7SCnr1i3UoxH4wgxwMEbahsC9BBiZoN0WWDbYixMnJKLli9Qff5AP2LUAnsrzNbg
	vKGA9ddZEadDzyzEJl1o5N3QvairSDLL1dMZrZh617XuirS/MaDsBQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458dgt1tfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 06:23:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52A3rEFL017091;
	Mon, 10 Mar 2025 06:23:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458cbddtyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 06:23:56 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52A6NtPP008111;
	Mon, 10 Mar 2025 06:23:55 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 458cbddtyn-1;
	Mon, 10 Mar 2025 06:23:55 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: cve@kernel.org
Cc: andypma@tencent.com, Jesse.Zhang@amd.com, forst@pen.gy,
        adobriyan@gmail.com, vegard.nossum@oracle.com,
        linux-kernel@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH] Add vulnerable commits for few CVEs
Date: Sun,  9 Mar 2025 23:23:49 -0700
Message-ID: <20250310062349.206687-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_02,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=660 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100049
X-Proofpoint-GUID: imYP1n-CVVQfB53S_AGJkFE_xitmtw_z
X-Proofpoint-ORIG-GUID: imYP1n-CVVQfB53S_AGJkFE_xitmtw_z

CVE-2024-49994: block: fix integer overflow in BLKSECDISCARD
 — Fixes: 44abff2c0b97 ("block: decouple REQ_OP_SECURE_ERASE from REQ_OP_DISCARD")
Reason: The overflowing addition in blk_ioctl_secure_erase() is added in
above mentioned broken commit.

CVE-2024-46861 kernel: usbnet: ipheth: do not stop RX on failing RX callback
 — Fixes: a2d274c62e44 ("usbnet: ipheth: add CDC NCM support")
Reason: dev->rcvbulk_callback() was added in the broken commit, and the
CVE fix is to remove the return statement on failure.
Note: The CVE fix is preventing driver to stop on non-critical failures
-- I think this shouldn't be a CVE

CVE-2024-46819 kernel: drm/amdgpu: the warning dereferencing obj for nbio_v7_4
 - Fixes: 28f87950d935 ("drm/amdgpu: clear ras controller status registers when interrupt occurs")
Reason: ras_manager was first brought into usage in the above mentioned
broken commit.

CVE-2024-40997 kernel: cpufreq: amd-pstate: fix memory leak on CPU EPP exit
 — Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
Reason: memory allocation in amd_pstate_epp_cpu_init() with kzalloc is
added in the above mentioned broken commit.

Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 cve/published/2024/CVE-2024-40997.vulnerable | 2 +-
 cve/published/2024/CVE-2024-46819.vulnerable | 1 +
 cve/published/2024/CVE-2024-46861.vulnerable | 1 +
 cve/published/2024/CVE-2024-49994.vulnerable | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)
 create mode 100644 cve/published/2024/CVE-2024-46819.vulnerable
 create mode 100644 cve/published/2024/CVE-2024-46861.vulnerable
 create mode 100644 cve/published/2024/CVE-2024-49994.vulnerable

diff --git a/cve/published/2024/CVE-2024-40997.vulnerable b/cve/published/2024/CVE-2024-40997.vulnerable
index c45e2b019603..b715f1e960e6 100644
--- a/cve/published/2024/CVE-2024-40997.vulnerable
+++ b/cve/published/2024/CVE-2024-40997.vulnerable
@@ -1 +1 @@
-ec437d71db77a181227bf6d0ac9d4a80e58ecf0f
+ffa5096a7c338641f70fb06d4778e8cf400181a8
diff --git a/cve/published/2024/CVE-2024-46819.vulnerable b/cve/published/2024/CVE-2024-46819.vulnerable
new file mode 100644
index 000000000000..d8021d7b9571
--- /dev/null
+++ b/cve/published/2024/CVE-2024-46819.vulnerable
@@ -0,0 +1 @@
+28f87950d935eec2ba1076933535213f4f5c8a06
diff --git a/cve/published/2024/CVE-2024-46861.vulnerable b/cve/published/2024/CVE-2024-46861.vulnerable
new file mode 100644
index 000000000000..84ad606d707a
--- /dev/null
+++ b/cve/published/2024/CVE-2024-46861.vulnerable
@@ -0,0 +1 @@
+a2d274c62e44b1995c170595db3865c6fe701226
diff --git a/cve/published/2024/CVE-2024-49994.vulnerable b/cve/published/2024/CVE-2024-49994.vulnerable
new file mode 100644
index 000000000000..7ab1e0c8c338
--- /dev/null
+++ b/cve/published/2024/CVE-2024-49994.vulnerable
@@ -0,0 +1 @@
+44abff2c0b970ae3d310b97617525dc01f248d7c
-- 
2.46.0


