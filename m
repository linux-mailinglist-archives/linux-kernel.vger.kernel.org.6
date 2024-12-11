Return-Path: <linux-kernel+bounces-441013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A849EC7EB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59281888EC9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22D41F2379;
	Wed, 11 Dec 2024 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CO9Lmqk0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25F21F2367
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907416; cv=none; b=spkHTxnFnjnzwbuAhwmvmyestf5EqRnVjLQyT4VwEAkserKCzXKnWrwNMnQ6LOkW5Pb6BXwo4oENyacAKOt6a2obqGtJnycQQ4nfkudLUhF/sRcrI4koSorkdk8Q1gLK6HSF2Rz1cP7A86xrmgCuYu8vhlIW/LnpaRZO2Ic0Az0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907416; c=relaxed/simple;
	bh=cyIwLAKJrKHsHqsCqBfcxjQwI+X5qPRd5NeoIz855ho=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BrLUR9JwtPtqBE1Rntjr9f03tyYSCHTTXRYHpnA8ZAuuTSKg9N5ec3f/Um035y0S0mqTXoKK1/mDgJLMD7B5JSS8T2yM8gAL6g/u543nuN1FZI8F889XdJa/vbXf4kUbew2k6ctooepzlzbzKLfYFCeHU4Q6zmOk5obzusQwsRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CO9Lmqk0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB2OrXb001566;
	Wed, 11 Dec 2024 08:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=mnkTWhh/H73fvu1GHFu+JR
	PYbASHz6VCplZ/mfBshIw=; b=CO9Lmqk0An9arlh8FZgDZE7STlv4M4BJFrQ8k6
	xVi9udZAY2eyJKPwmM/MqppeghA4JSuTtYRrgkOXH//4qeOdPCpQzp9rGvFKMPGO
	GEP+/IlixjPdEBcGQLv+i2OnruGxmNEIjPoeZAUr+xl66iUad6QiZB+7e3OT+/fB
	mPMz5mf8sw1rDGXmn2ES5PABXJeeD3V6q9v6K1MXPLUZX+72PLQWIhMHHo3Q43Rm
	3l5t5Bf7kbua6Jxqj282a3X5UPimgtZxPJla6XIT11ffSy9jN1ODZemMGsbUttGa
	zxwN9PYhunNvXkjOGHb19FX9LDbN6xwZV8Y42Vbb5Ye5ihhg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f1xd11f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 08:56:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BB8ujk3004945
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 08:56:45 GMT
Received: from ap-kernel-sh01-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 11 Dec 2024 00:56:43 -0800
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
To: <akpm@linux-foundation.org>, <surenb@google.com>,
        <kent.overstreet@linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Zhenhua Huang
	<quic_zhenhuah@quicinc.com>
Subject: [PATCH] mm/code_tag: Skip displaying the code_tag if it is not called
Date: Wed, 11 Dec 2024 16:56:16 +0800
Message-ID: <20241211085616.2471901-1-quic_zhenhuah@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KUm7iSj61Yk96K2urOeeGbp4dpFiyd5R
X-Proofpoint-GUID: KUm7iSj61Yk96K2urOeeGbp4dpFiyd5R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 clxscore=1011 bulkscore=0 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412110067

/proc/allocinfo is full of callsites which are not called at all.
Let's only output if the callsite actually been invoked.

Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
---
 lib/alloc_tag.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 35f7560a309a..06fb7eb5c0bc 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -95,10 +95,12 @@ static void alloc_tag_to_text(struct seq_buf *out, struct codetag *ct)
 	struct alloc_tag_counters counter = alloc_tag_read(tag);
 	s64 bytes = counter.bytes;
 
-	seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls);
-	codetag_to_text(out, ct);
-	seq_buf_putc(out, ' ');
-	seq_buf_putc(out, '\n');
+	if (bytes || counter.calls) {
+		seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls);
+		codetag_to_text(out, ct);
+		seq_buf_putc(out, ' ');
+		seq_buf_putc(out, '\n');
+	}
 }
 
 static int allocinfo_show(struct seq_file *m, void *arg)
-- 
2.25.1


