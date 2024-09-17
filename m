Return-Path: <linux-kernel+bounces-331955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3282F97B36D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 19:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1BFB285F98
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F92818787B;
	Tue, 17 Sep 2024 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="roCiRuUy"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11B417A918
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726593422; cv=none; b=Nc1HrNXjSwB/TY61TSGDmUH6SNBEFQF2Ju/2Q6ec1+0zVbf5C92cU/7ImQS7flW8OwnQZasJW72te3zwQ1k95HxM2JRuYrC8+xRoDYmD/W8B7E6OtBIhmfu0M4sXuiZgFsIcDgrZ6/sDwNfaNuw/XJMXrJWZgu5oTM/y91NhU8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726593422; c=relaxed/simple;
	bh=bkdsRhmgJqDVzC7XHM6BWMkO04lzz7E8Zz71sTsljlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+OzsBojS4DVONhF7gIlF/4qgjsKhsiP+zr/Zbn+PoFymPGw2hb5tD5SO31J8CIi2tD4zJ+CBjJckLmzFC01QdxE6V568rY53+IJ4tsZMgeqfDrYeZ1fRMFcuX6wvW6Eh4PXOXZe9jjo44DlML9kc5fhBiQl0X4Rl7ts+xLZdYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=roCiRuUy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48HAWcAb007563;
	Tue, 17 Sep 2024 17:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=auvVqVcKz5YeE
	RFMqylcHHB6e1RaNYyOqCXDawt1Ph4=; b=roCiRuUyFUGWr6ImV6/5TXubK2Zqr
	z3aGTVX20e/n/fprdkTKCNWXHvUCn2T6DqOxqxD8wLXvWabO/U6rpKneO++9Bpor
	5HOcLxyq/u4RtOZNaSvrUw72F/sljwdd7aHE9DTIoxGses+YvSuljL7DktR/i/LJ
	lZjBY8fV7A175V4XxDGNGkfhtViBQgRtnWIO0+yyp+7ycX7JvLhlQ2y3Hc5YwIKW
	CwkRNulFd38yszk7k+eEwJr6wOE8KS7SHboSUSShsgj8/cCDrqxA97TLnuy3FEdJ
	h7+Po+ZfugJ9dsfNXRHv5PriPuqaEOjbHHqOGqIA8hfTK+OGA0hZ7fo2A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vdhjrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 17:16:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48HFvnsl000731;
	Tue, 17 Sep 2024 17:16:50 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41nntq6ern-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 17:16:50 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48HHGnYR49021322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 17:16:49 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6791E58062;
	Tue, 17 Sep 2024 17:16:49 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44A585805D;
	Tue, 17 Sep 2024 17:16:49 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.93.228])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Sep 2024 17:16:49 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-fsi@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@codeconstruct.com.au, eajames@linux.ibm.com,
        ninad@linux.ibm.com
Subject: [PATCH 07/15] fsi: core: Add slave error trace
Date: Tue, 17 Sep 2024 12:16:39 -0500
Message-ID: <20240917171647.1403910-8-eajames@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 0TwwxtEgLqv4PglX27NKUHu98DVfFiwN
X-Proofpoint-GUID: 0TwwxtEgLqv4PglX27NKUHu98DVfFiwN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_08,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 mlxlogscore=791 priorityscore=1501 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409170122

Trace out the FSI slave status and interrupt status.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c     |  1 +
 include/trace/events/fsi.h | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 5200078af8fd..8ce187bbaf22 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -185,6 +185,7 @@ static int fsi_slave_report_and_clear_errors(struct fsi_slave *slave)
 
 	dev_dbg(&slave->dev, "status: 0x%08x, sisc: 0x%08x\n",
 			be32_to_cpu(stat), be32_to_cpu(irq));
+	trace_fsi_slave_error(slave, be32_to_cpu(irq), be32_to_cpu(stat));
 
 	/* clear interrupts */
 	return fsi_master_write(master, link, id, FSI_SLAVE_BASE + FSI_SISC,
diff --git a/include/trace/events/fsi.h b/include/trace/events/fsi.h
index fed8835f438e..5509afc98ee8 100644
--- a/include/trace/events/fsi.h
+++ b/include/trace/events/fsi.h
@@ -115,6 +115,25 @@ TRACE_EVENT(fsi_master_unregister,
 	TP_printk("fsi%d (%d links)", __entry->master_idx, __entry->n_links)
 );
 
+TRACE_EVENT(fsi_slave_error,
+	TP_PROTO(const struct fsi_slave *slave, uint32_t sisc, uint32_t sstat),
+	TP_ARGS(slave, sisc, sstat),
+	TP_STRUCT__entry(
+		__field(int, master_idx)
+		__field(int, link)
+		__field(uint32_t, sisc)
+		__field(uint32_t, sstat)
+	),
+	TP_fast_assign(
+		__entry->master_idx = slave->master->idx;
+		__entry->link = slave->link;
+		__entry->sisc = sisc;
+		__entry->sstat = sstat;
+	),
+	TP_printk("fsi%d:%02d sisc:%08x sstat:%08x", __entry->master_idx, __entry->link,
+		  __entry->sisc, __entry->sstat)
+);
+
 TRACE_EVENT(fsi_slave_init,
 	TP_PROTO(const struct fsi_slave *slave),
 	TP_ARGS(slave),
-- 
2.43.0


