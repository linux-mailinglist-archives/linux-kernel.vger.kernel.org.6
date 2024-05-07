Return-Path: <linux-kernel+bounces-172073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F8E8BECC4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 21:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51FDC2850D0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 19:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E7816E86A;
	Tue,  7 May 2024 19:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="trK+3LpY"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDC221373
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 19:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715111211; cv=none; b=pKwCTaum6sikFTLIYy374D40WoypEL6yLHS5iDCXyExwW4c3u9q6FWdi5i6fP3SSbNdDuVAKoUiu6bSugleb8BB9HUtaf7Kc0ypGe9sPN6FttXPp7wE20uKYgSIore3kmwaPdyyTKgyyN2f+Obvzp/Lx9IDv3BiRSdnm3W9EGhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715111211; c=relaxed/simple;
	bh=/iKfbgmsg7HhdE2MK0fNdHy+IRyhoRs4ckTjnij3JHc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PC9C+hHqiBrjQ5Z0DwG6Ly/qIsmU7r4n7U/mYhiSPLixYk2UrIfLaltwoUJqm7QmZNeUZ/+otqIDceoxp1jgOPi5Gv+kDTUXb2bnWFuuBv6efsijLDJVVZzxs7goxxrBCeacWU8QAks1a/M73N9jCTbeBY4oh7F8i7Ew49gbLKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=pass smtp.mailfrom=us.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=trK+3LpY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 447JfaXg007428;
	Tue, 7 May 2024 19:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=P8W7NnRFFxY2LW3IvjIIkcaMNnstdZP2WIkMb7nC6fY=;
 b=trK+3LpYtb4aTiXVyeoCEvDMzI/NfgLftdBfNZEkBAWx9r1+UUeT+JiWcEr2pgJGnXTL
 qg1uNEAObdCyM6Q6sixEmsovp+0bMsKP6ReoHGMs1uIWv0/BKdkXc4C6U077pz/7B8F/
 gjoyTAymzpIkA6eJvPSGoGy/FiLQ36l8ybAApQFF3xSAZpKq9owKT56DIqRDODHfg+zs
 mntsHbuooNwsZkzY7duxZg4mqZfYLZ4sKEsyMFXiMffbAAQExRWQq5MYFPkZjDwEizVe
 3bbXZqPQLcdFDUUyzNwt3424zqRsfP4ulni+xPpDSk0inuGobiNd+NMTCpxwy95cVobj tg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xysmf86qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 19:46:36 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 447ILp7Z004174;
	Tue, 7 May 2024 19:46:35 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xysgs8cwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 19:46:35 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 447JkUoL27787872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 May 2024 19:46:32 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB1A558060;
	Tue,  7 May 2024 19:46:28 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C706958054;
	Tue,  7 May 2024 19:46:28 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  7 May 2024 19:46:28 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
	id 5AC7B740052; Tue,  7 May 2024 14:46:27 -0500 (CDT)
From: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To: jdelvare@suse.com, linux@roeck-us.net
Cc: Lakshmi Yadlapati <lakshmiy@us.ibm.com>, ninad@linux.ibm.com,
        eajames@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v1] hwmon: (ucd90320) Increase delay from 250 to 500us
Date: Tue,  7 May 2024 14:46:03 -0500
Message-Id: <20240507194603.1305750-1-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: B8B-TnBt_pjLPRyajKkmJvsFGhnxgD2n
X-Proofpoint-GUID: B8B-TnBt_pjLPRyajKkmJvsFGhnxgD2n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_12,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 mlxlogscore=679
 spamscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405070137

Following the failure observed with a delay of 250us, experiments were
conducted with various delays. It was found that a delay of 350us
effectively mitigated the issue.

To provide a more optimal solution while still allowing a margin for
stability, the delay is being adjusted to 500us.

Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
---
 drivers/hwmon/pmbus/ucd9000.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/pmbus/ucd9000.c b/drivers/hwmon/pmbus/ucd9000.c
index 8d9d422450e5..d817c719b90b 100644
--- a/drivers/hwmon/pmbus/ucd9000.c
+++ b/drivers/hwmon/pmbus/ucd9000.c
@@ -80,11 +80,11 @@ struct ucd9000_debugfs_entry {
  * It has been observed that the UCD90320 randomly fails register access when
  * doing another access right on the back of a register write. To mitigate this
  * make sure that there is a minimum delay between a write access and the
- * following access. The 250us is based on experimental data. At a delay of
- * 200us the issue seems to go away. Add a bit of extra margin to allow for
+ * following access. The 500 is based on experimental data. At a delay of
+ * 350us the issue seems to go away. Add a bit of extra margin to allow for
  * system to system differences.
  */
-#define UCD90320_WAIT_DELAY_US 250
+#define UCD90320_WAIT_DELAY_US 500
 
 static inline void ucd90320_wait(const struct ucd9000_data *data)
 {
-- 
2.40.1


