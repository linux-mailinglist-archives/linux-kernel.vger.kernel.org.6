Return-Path: <linux-kernel+bounces-180506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 372678C6F66
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 02:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A9281C215EF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 00:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5547631;
	Thu, 16 May 2024 00:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lkgdqFSI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8957E1
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 00:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715818052; cv=none; b=MTs4Efjx5R0Rt0zC0RC3z/uK5zxdQxOaZZRvL9VK6D33jp7nDJ9YEPwP2fMh7fYJSAfEb8CjVg1eojL6Lz/re/tmsSZN7zmiWNOF15iWS5TgPRam2ekaG/xUy9YFw8nIjnT4u7ZX7x+Nms6VxcKX8y2eRPuTmw27z0jHw7ckWiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715818052; c=relaxed/simple;
	bh=Nem0lDg0yoRbX3iL7WUUigqbThC1zz4wHtmz2wjwpLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=PXDf5hTY0AChpLfNU3UPNMuac+kqMFSyQFaF0Q1ShaKc1ih4X3dgfJvYgBJULt/5wZ2Gl7j3ojMBhDf+5s9QQ/nrYYtaVMfVnQs3nQLH0mwNlgk5hwHeetW0e8bn4wiBfqDpbfuxrO7EGwMFa7TzDpvqBpvCtfyxK8hTmLg2cNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lkgdqFSI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44FJb9RH009174;
	Thu, 16 May 2024 00:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=Nem
	0lDg0yoRbX3iL7WUUigqbThC1zz4wHtmz2wjwpLc=; b=lkgdqFSI+04u1sEPyZl
	MjyGM55XKBGe76XKCc0DLmAQ0vF9JdwaNX0EQsf0bIr695odmhPqn8cbe2eki9FD
	xEXJAvVgi/s6MrEwM+gnud4+MZRg5SCJe/5k3kwvmwiv97D8gH5/o7Pdoz0u/+Qn
	ZdtvBe/YHKOVci/QO/c81CjHV4d23epWIHQYHQ2ZdtF+Cn7KhWS/kaAqa6/mfhgR
	BSpo2vdCwVD9oJ24ckAKh8U7GzEH8rOQoSAhevGHBCXA+IODNwdoNy3CtbW9RCG1
	iTRY93DYXvcTEATKRWOYsMQznd88L7HB14XXdNlnA0xlv6qvw5VBt1fK1O5+nWGF
	NWA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y3x51naq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 00:06:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44G06jeu003511
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 00:06:45 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 15 May
 2024 17:06:45 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 15 May 2024 17:06:39 -0700
Subject: [PATCH] x86/mm: add testmmiotrace MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240515-testmmiotrace-md-v1-1-10919a8b2842@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAA5ORWYC/x3MwQqDMAyA4VeRnBdoZe1grzJ2iDWbgbWOpA5Bf
 Hfrjt/h/zcwVmGDe7eB8k9M5tLgLx2kicqbUcZm6F1/dcEHrGw1Z5mrUmLMI6bogksxUvA3aNl
 X+SXrf/l4Ng9kjINSSdM5+khZVsxklRX2/QCl+/kJgQAAAA==
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
	<mhiramat@kernel.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen
	<ppaalanen@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Andy
 Lutomirski" <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Thomas
 Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <linux-kernel@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LNrfZ_9cuNvpXh4UHDKCwsRLpWST2gcL
X-Proofpoint-ORIG-GUID: LNrfZ_9cuNvpXh4UHDKCwsRLpWST2gcL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_14,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 impostorscore=0 adultscore=0 clxscore=1011 mlxlogscore=886
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405150171

Fix the following 'make W=1' warning:

WARNING: modpost: missing MODULE_DESCRIPTION() in arch/x86/mm/testmmiotrace.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 arch/x86/mm/testmmiotrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/mm/testmmiotrace.c b/arch/x86/mm/testmmiotrace.c
index bda73cb7a044..ae295659ca14 100644
--- a/arch/x86/mm/testmmiotrace.c
+++ b/arch/x86/mm/testmmiotrace.c
@@ -144,3 +144,4 @@ static void __exit cleanup(void)
 module_init(init);
 module_exit(cleanup);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Test module for mmiotrace");

---
base-commit: 8c06da67d0bd3139a97f301b4aa9c482b9d4f29e
change-id: 20240515-testmmiotrace-md-c6050c66a517


