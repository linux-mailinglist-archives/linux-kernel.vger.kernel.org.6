Return-Path: <linux-kernel+bounces-389890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025839B7297
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8569285E9D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B3112C489;
	Thu, 31 Oct 2024 02:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g2vIdfwy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618FF4689
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 02:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730342570; cv=none; b=ij2+oVP5RqMeDiBQOV/0Cr6tXurxGHBD5j6drjbzBmhOuNK8FpCIPYceF7KQjNREG7IU1vGg5XfHkzsF882XAwOQZNAug/HXdKkxx90YjGJpmPctVcG2r45xtuLvK3c86yZ0pTkYYzJp/F5QPEYRaH18nY0I6U+VB63Xn/psU3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730342570; c=relaxed/simple;
	bh=LDHRoTtshFiAmUCz06O6JZlHmksy5yY0Xp2QZ5YM/7k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KLUTX6a7kY7xftN/6UocMEP8uxvhXCQNVByY+NbN2mWzQRCQloa7cBdaHoxJX0CypWtBpfgTLOdrCIkWNhbRzsZgswpstUUw6CY0zJhnETFRL28u4NWiAC6bZL7TQxLfwubitwZuDXJ3K8Xv+R9QxwNn5zmbeFKvirVWM8WAu7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g2vIdfwy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49UDW0aW002939;
	Thu, 31 Oct 2024 02:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=VoeMw0FW+IRO+n76hZY1fl
	Baj/L0y7QsbJuQOvp6PX0=; b=g2vIdfwywMhojD1fSRrMaKvLyJTxcDuZigejPM
	uFmd5Pzd5S0dg5/5jH4Z7fgj7tD8pSWjzdKUAslAloB3SFyrBGUimSi5D7MKoWIK
	UUtwqMTPTcYdI1QJO28Ku5hl1ENTyKN3DbDGrzBqcGSNxF7EcsyWnzHObw1r35jG
	iWau4m8oN5kTXjWSGhr7GBTnJ+Miyw4JnpMG0vb1vWQL0OwbDynLLbA/tK3MHGQe
	2GJY1WVLaHmusNXfS8q0KpWpr86r6MPtVfMOgFRwYn+pD/RgqC8xBLZGYisxiisx
	k/eWOm7bHpoL7YlfdsBun5nks0zxIvJPnMTJD0EaPih6kEVA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42kns3hufb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 02:42:35 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49V2gZK6023815
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 02:42:35 GMT
Received: from maow2-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 30 Oct 2024 19:42:32 -0700
From: Kassey Li <quic_yingangl@quicinc.com>
To: <akpm@linux-foundation.org>, <vbabka@kernel.org>
CC: <minchan@kernel.org>, <vbabka@suse.cz>, <iamjoonsoo.kim@lge.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <quic_yingangl@quicinc.com>
Subject: [PATCH] trace/events/page_ref: add page info to page_ref trace event
Date: Thu, 31 Oct 2024 10:42:22 +0800
Message-ID: <20241031024222.505844-1-quic_yingangl@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yHC0Sl4KRjJY-8XbBSO5xS_I2Fc41cJj
X-Proofpoint-ORIG-GUID: yHC0Sl4KRjJY-8XbBSO5xS_I2Fc41cJj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410310020

This followed
commit 53d884a6675b ("mm, tracing: unify PFN format strings")
to add page info.

In many kernel code we are talking with page other than pfn,
here we added page algin with pfn.

Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
---
 include/trace/events/page_ref.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/page_ref.h b/include/trace/events/page_ref.h
index fe33a255b7d0..76df13b2a5b3 100644
--- a/include/trace/events/page_ref.h
+++ b/include/trace/events/page_ref.h
@@ -18,6 +18,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_template,
 
 	TP_STRUCT__entry(
 		__field(unsigned long, pfn)
+		__field(const struct page *, page)
 		__field(unsigned long, flags)
 		__field(int, count)
 		__field(int, mapcount)
@@ -28,6 +29,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_template,
 
 	TP_fast_assign(
 		__entry->pfn = page_to_pfn(page);
+		__entry->page = page;
 		__entry->flags = page->flags;
 		__entry->count = page_ref_count(page);
 		__entry->mapcount = atomic_read(&page->_mapcount);
@@ -36,8 +38,9 @@ DECLARE_EVENT_CLASS(page_ref_mod_template,
 		__entry->val = v;
 	),
 
-	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d",
+	TP_printk("pfn=0x%lx page=%p flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d",
 		__entry->pfn,
+		__entry->page,
 		show_page_flags(__entry->flags & PAGEFLAGS_MASK),
 		__entry->count,
 		__entry->mapcount, __entry->mapping, __entry->mt,
@@ -66,6 +69,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_and_test_template,
 
 	TP_STRUCT__entry(
 		__field(unsigned long, pfn)
+		__field(const struct page *, page)
 		__field(unsigned long, flags)
 		__field(int, count)
 		__field(int, mapcount)
@@ -77,6 +81,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_and_test_template,
 
 	TP_fast_assign(
 		__entry->pfn = page_to_pfn(page);
+		__entry->page = page;
 		__entry->flags = page->flags;
 		__entry->count = page_ref_count(page);
 		__entry->mapcount = atomic_read(&page->_mapcount);
@@ -86,8 +91,9 @@ DECLARE_EVENT_CLASS(page_ref_mod_and_test_template,
 		__entry->ret = ret;
 	),
 
-	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d ret=%d",
+	TP_printk("pfn=0x%lx page=%p flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d ret=%d",
 		__entry->pfn,
+		__entry->page,
 		show_page_flags(__entry->flags & PAGEFLAGS_MASK),
 		__entry->count,
 		__entry->mapcount, __entry->mapping, __entry->mt,
-- 
2.25.1


