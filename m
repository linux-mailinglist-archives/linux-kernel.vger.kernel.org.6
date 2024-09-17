Return-Path: <linux-kernel+bounces-331967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EC497B37B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 19:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2951F23C9C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E001925AB;
	Tue, 17 Sep 2024 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jMC9Md/m"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A862518950D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726593426; cv=none; b=h2e39W0BTLc+rlJC115caEmVMhykTNsZaAWgfEw/lPxjyIBjJkiT3hYFgCAgWNbnq7lgZFftzkf5N0feb30Tzkqo/H/6SAFt2hWzFHs5Oc7Qgxs19PubVFo7B8Ss5exQmDLer0UuaBRQovBSnSPWhMFRhcjIp1Bs9aX34PB4MmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726593426; c=relaxed/simple;
	bh=S0auuSOh/oi04h/vbNPcg+E+3quYBQV0hgcbzxknLtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7v+5Z3F7wgf2itCvYJ2AJg2/V9tL0sjBFX/0AHXEBvAwQsnVW5m1A9OdusY2mwoOri0hT39RKrVMnjFkdrjP7Fw1oogatdcpD22f/ZxTBy1CbmfwAbjvJgO0noLjrEL8jZmEQv2EK9aoi7ITdQmC1tlEE5evh5InfDuxckQscc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jMC9Md/m; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48H905Wx006129;
	Tue, 17 Sep 2024 17:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=HgYlD5+Ra+xIx
	1Im47aMRh3RzyMTiHzBaPtfxKNouIs=; b=jMC9Md/m8ue0tYEoUg3SXTeTzxKVJ
	PPxqH5710NISP6bOuX9IsuOmPsg1n4PTstrJ1Qmvl/lv7q/eGQb/JfX+/6jOImzc
	yQGkZPanaO+SqPA4JGqfILiySerC9SUJXXFbKGfoolgd3+3zceX/qsUIp+HONQ/S
	6C/pzpmAgZekuUa5mcLwrhDywOCGrBKQ9sIKd7ChdFvz8fksjWWW150ZRVVC8/KK
	+u3UyJxnQc3EhPdM93y3IWPo69xgNTUegKxD5Xld9aT+tKT5DyfPXMOGTyvcxTlj
	DnRC6VLtcpbcdxzMeDK+WBKOw3oWjaO2SSQCk2pbFtm78KE79DEHGBr4g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n41agwbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 17:16:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48HGtiWB024672;
	Tue, 17 Sep 2024 17:16:50 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41nq1mx7u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 17:16:50 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48HHGn5J49873244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 17:16:49 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D2CC58059;
	Tue, 17 Sep 2024 17:16:49 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11BB158062;
	Tue, 17 Sep 2024 17:16:49 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.93.228])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Sep 2024 17:16:49 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-fsi@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@codeconstruct.com.au, eajames@linux.ibm.com,
        ninad@linux.ibm.com
Subject: [PATCH 06/15] fsi: core: Improve master read/write/error traces
Date: Tue, 17 Sep 2024 12:16:38 -0500
Message-ID: <20240917171647.1403910-7-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240917171647.1403910-1-eajames@linux.ibm.com>
References: <20240917171647.1403910-1-eajames@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Tqr49ybq_XUZw8o5MV3Vd8y-EgO4sWIV
X-Proofpoint-ORIG-GUID: Tqr49ybq_XUZw8o5MV3Vd8y-EgO4sWIV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_08,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 mlxlogscore=740 bulkscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409170122

Consolidate the master read and write traces into one trace and
change the result trace into an error trace for less spam.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c     |  26 +++++----
 include/trace/events/fsi.h | 112 ++++++++++++-------------------------
 2 files changed, 51 insertions(+), 87 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 1abbde4a9783..5200078af8fd 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -1116,14 +1116,15 @@ static int fsi_master_read(struct fsi_master *master, int link,
 {
 	int rc;
 
-	trace_fsi_master_read(master, link, slave_id, addr, size);
-
 	rc = fsi_check_access(addr, size);
-	if (!rc)
+	if (!rc) {
 		rc = master->read(master, link, slave_id, addr, val, size);
-
-	trace_fsi_master_rw_result(master, link, slave_id, addr, size,
-			false, val, rc);
+		if (rc)
+			trace_fsi_master_error(master->idx, link, slave_id, addr, size, val, rc,
+					       true);
+		else
+			trace_fsi_master_xfer(master->idx, link, slave_id, addr, size, val, true);
+	}
 
 	return rc;
 }
@@ -1133,14 +1134,15 @@ static int fsi_master_write(struct fsi_master *master, int link,
 {
 	int rc;
 
-	trace_fsi_master_write(master, link, slave_id, addr, size, val);
-
 	rc = fsi_check_access(addr, size);
-	if (!rc)
+	if (!rc) {
 		rc = master->write(master, link, slave_id, addr, val, size);
-
-	trace_fsi_master_rw_result(master, link, slave_id, addr, size,
-			true, val, rc);
+		if (rc)
+			trace_fsi_master_error(master->idx, link, slave_id, addr, size, val, rc,
+					       false);
+		else
+			trace_fsi_master_xfer(master->idx, link, slave_id, addr, size, val, false);
+	}
 
 	return rc;
 }
diff --git a/include/trace/events/fsi.h b/include/trace/events/fsi.h
index 5ff15126ad9d..fed8835f438e 100644
--- a/include/trace/events/fsi.h
+++ b/include/trace/events/fsi.h
@@ -8,101 +8,63 @@
 
 #include <linux/tracepoint.h>
 
-TRACE_EVENT(fsi_master_read,
-	TP_PROTO(const struct fsi_master *master, int link, int id,
-			uint32_t addr, size_t size),
-	TP_ARGS(master, link, id, addr, size),
+TRACE_EVENT(fsi_master_xfer,
+	TP_PROTO(int master_idx, int link, int id, uint32_t addr, size_t size, const void *data,
+		 bool read),
+	TP_ARGS(master_idx, link, id, addr, size, data, read),
 	TP_STRUCT__entry(
-		__field(int,	master_idx)
-		__field(int,	link)
-		__field(int,	id)
-		__field(__u32,	addr)
-		__field(size_t,	size)
+		__field(int, master_idx)
+		__field(int, link)
+		__field(int, id)
+		__field(uint32_t, addr)
+		__field(int, size)
+		__field(uint32_t, data)
+		__field(bool, read)
 	),
 	TP_fast_assign(
-		__entry->master_idx = master->idx;
+		__entry->master_idx = master_idx;
 		__entry->link = link;
 		__entry->id = id;
 		__entry->addr = addr;
-		__entry->size = size;
-	),
-	TP_printk("fsi%d:%02d:%02d %08x[%zu]",
-		__entry->master_idx,
-		__entry->link,
-		__entry->id,
-		__entry->addr,
-		__entry->size
-	)
-);
-
-TRACE_EVENT(fsi_master_write,
-	TP_PROTO(const struct fsi_master *master, int link, int id,
-			uint32_t addr, size_t size, const void *data),
-	TP_ARGS(master, link, id, addr, size, data),
-	TP_STRUCT__entry(
-		__field(int,	master_idx)
-		__field(int,	link)
-		__field(int,	id)
-		__field(__u32,	addr)
-		__field(size_t,	size)
-		__field(__u32,	data)
-	),
-	TP_fast_assign(
-		__entry->master_idx = master->idx;
-		__entry->link = link;
-		__entry->id = id;
-		__entry->addr = addr;
-		__entry->size = size;
+		__entry->size = (int)size;
 		__entry->data = 0;
 		memcpy(&__entry->data, data, size);
+		__entry->read = read;
 	),
-	TP_printk("fsi%d:%02d:%02d %08x[%zu] <= {%*ph}",
-		__entry->master_idx,
-		__entry->link,
-		__entry->id,
-		__entry->addr,
-		__entry->size,
-		(int)__entry->size, &__entry->data
-	)
+	TP_printk("fsi%d:%02d:%02d %s %08x {%*ph}", __entry->master_idx, __entry->link,
+		  __entry->id, __entry->read ? "read" : "write", __entry->addr, __entry->size,
+		  &__entry->data)
 );
 
-TRACE_EVENT(fsi_master_rw_result,
-	TP_PROTO(const struct fsi_master *master, int link, int id,
-			uint32_t addr, size_t size,
-			bool write, const void *data, int ret),
-	TP_ARGS(master, link, id, addr, size, write, data, ret),
+TRACE_EVENT(fsi_master_error,
+	TP_PROTO(int master_idx, int link, int id, uint32_t addr, size_t size, const void *data,
+		 int ret, bool read),
+	TP_ARGS(master_idx, link, id, addr, size, data, ret, read),
 	TP_STRUCT__entry(
-		__field(int,	master_idx)
-		__field(int,	link)
-		__field(int,	id)
-		__field(__u32,	addr)
-		__field(size_t,	size)
-		__field(bool,	write)
-		__field(__u32,	data)
-		__field(int,	ret)
+		__field(int, master_idx)
+		__field(int, link)
+		__field(int, id)
+		__field(uint32_t, addr)
+		__field(int, size)
+		__field(uint32_t, data)
+		__field(int, ret)
+		__field(bool, read)
 	),
 	TP_fast_assign(
-		__entry->master_idx = master->idx;
+		__entry->master_idx = master_idx;
 		__entry->link = link;
 		__entry->id = id;
 		__entry->addr = addr;
-		__entry->size = size;
-		__entry->write = write;
+		__entry->size = (int)size;
 		__entry->data = 0;
-		__entry->ret = ret;
-		if (__entry->write || !__entry->ret)
+		if (!read)
 			memcpy(&__entry->data, data, size);
+		__entry->ret = ret;
+		__entry->read = read;
 	),
-	TP_printk("fsi%d:%02d:%02d %08x[%zu] %s {%*ph} ret %d",
-		__entry->master_idx,
-		__entry->link,
-		__entry->id,
-		__entry->addr,
-		__entry->size,
-		__entry->write ? "<=" : "=>",
-		(int)__entry->size, &__entry->data,
-		__entry->ret
-	)
+	TP_printk("fsi%d:%02d:%02d %s %08x {%*ph} %d", __entry->master_idx, __entry->link,
+		  __entry->id, __entry->read ? "read" : "write", __entry->addr, __entry->size,
+		  &__entry->data, __entry->ret)
 );
 
 TRACE_EVENT(fsi_master_break,
-- 
2.43.0


