Return-Path: <linux-kernel+bounces-446901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4339F2AC2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F29618889F5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16FA1B415D;
	Mon, 16 Dec 2024 07:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qJhKjp+f"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B0F20E6
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 07:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734333347; cv=none; b=rm2paVCtnnF1dmkFC0pcM7D6SMCqXjWlEOhSCThGwzzbWbYTdKxIi1qUDUFZkJ30gleQsclGGW+Des/egBAvncwMRjFqYvbULVBaZ0ragBxHAovh2I7Fnj8nCVwc287mnCR5tMHa6+ez1NrxRlKztI+kvvATBdGnyZHtZQBT9uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734333347; c=relaxed/simple;
	bh=ZqncAwd7YBeEtprKOHV1f4kQMi0okH9LjOK6mq0n5Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mK6RCAWqmZdd9C/6nyotcluKfc5jCvkB9lqG3FzEyhYaefpcI0/e6q82rfI5CXYNcmfOuOf54O56ueWHPnvZZButT0i5mG/hUstgRwiYnjgeXNfVzb/43FibZJxhae5DDCrjB0g2RR9w+uHBmrzjnmeoqz3UdzCDXIVQ5lK6Pbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qJhKjp+f; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG3qPaX011550;
	Mon, 16 Dec 2024 07:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0PHupSe7X1mAzk4xY
	pwZLN+jZWhSd26lXshtsjf3qNE=; b=qJhKjp+fMSjQVCVLdX/kdEY5PsxpVdOGX
	wlDwadjaWxMOinK8zvAo3V/Q63ndXBNTF65eHdqC9tmu8pMQmjXrsaquRQLAPbGL
	XpC2MaUBlLRHbII16rnlgvNAZejkQixIpfesTMs0hjtsvhUzkG+G2EDaqwM6gsfI
	qWw5QGg54/ZnKXVR4+lWcMwbM9/jG4DVmY4FwvQSX5oDgKvnw6CsgJP8Sa0mRT+s
	j71f42PHoNid95omHMHhCOdM35Kz4w7B3TG9r8WBb0ULfVjFQcnIcYX9QyP3ninx
	pv+d3vYQx0aBV2NlMKYGlTOkg3xugagORgbPSDAzb1DBOy5DmGqBg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jcpb0rgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 07:15:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG6kWkX014383;
	Mon, 16 Dec 2024 07:15:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hq21cfsg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 07:15:35 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BG7FVmt45744580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 07:15:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1042020043;
	Mon, 16 Dec 2024 07:15:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C604620040;
	Mon, 16 Dec 2024 07:15:28 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.28.229])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Dec 2024 07:15:28 +0000 (GMT)
From: Kajol Jain <kjain@linux.ibm.com>
To: mpe@ellerman.id.au, maddy@linux.ibm.com
Cc: atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com, disgoel@linux.ibm.com,
        hbathini@linux.ibm.com, adubey@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] docs: ABI: sysfs-bus-event_source-devices-vpa-dtl: Document sysfs event format entries for vpa_dtl pmu
Date: Mon, 16 Dec 2024 12:45:16 +0530
Message-ID: <20241216071516.104324-2-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241216071516.104324-1-kjain@linux.ibm.com>
References: <20241216071516.104324-1-kjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TQ75Y9PW-TgNEthqywJUEhPQcR3NlTt4
X-Proofpoint-GUID: TQ75Y9PW-TgNEthqywJUEhPQcR3NlTt4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412160056

Details are added for the vpa_dtl pmu event and format
attributes in the ABI documentation.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 .../sysfs-bus-event_source-devices-vpa-dtl    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-vpa-dtl

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-vpa-dtl b/Documentation/ABI/testing/sysfs-bus-event_source-devices-vpa-dtl
new file mode 100644
index 000000000000..e0da65b6da16
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-vpa-dtl
@@ -0,0 +1,25 @@
+What:           /sys/bus/event_source/devices/vpa_dtl/format
+Date:           December 2024
+Contact:        Linux on PowerPC Developer List <linuxppc-dev@lists.ozlabs.org>
+Description:    Read-only. Attribute group to describe the magic bits
+                that go into perf_event_attr.config for a particular pmu.
+                (See ABI/testing/sysfs-bus-event_source-devices-format).
+
+                Each attribute under this group defines a bit range of the
+                perf_event_attr.config. Supported attribute are listed
+                below::
+
+				event  = "config:0-7"  - event ID
+
+		For example::
+
+		  dtl_cede = "event=0x1"
+
+What:           /sys/bus/event_source/devices/vpa_dtl/events
+Date:           December 2024
+Contact:        Linux on PowerPC Developer List <linuxppc-dev@lists.ozlabs.org>
+Description:	(RO) Attribute group to describe performance monitoring events
+                for the Virtual Processor Dispatch Trace Log. Each attribute in
+		this group describes a single performance monitoring event
+		supported by vpa_dtl pmu.  The name of the file is the name of
+		the event (See ABI/testing/sysfs-bus-event_source-devices-events).
-- 
2.43.0


