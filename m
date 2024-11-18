Return-Path: <linux-kernel+bounces-412839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E709D0FE0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C331F22ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139EE1990AD;
	Mon, 18 Nov 2024 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WI1maX+T"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E923718B47E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 11:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731930109; cv=none; b=f0npy8zePsanK0IgtxTeJB/GedYsVyTx8hGUKPxy/l5p4P1nBuKvcYs/aMrXkO1lRO3ZYEHjLqT8tHFqdm9nXOYSwA0Cw2RSBjmw78drofFr0Ukye1nfI+Cp/89ESnC+m9W9qaET7CXxScicxyAc7zlIeHjRnhRb1NJhVjMHRcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731930109; c=relaxed/simple;
	bh=2NaPqIQqcLDtmxbca0ILT97HbRyHpZ1oRiAoDN21R/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r1cWm9ve5xb/thqfCAwoLTVk6YkGBHuB6UGcSQoNUzuDazEzQQWbJ2+uI0TPekLIYZ1WA0bZuy+RFou+olBQh1CtxhKWFrOl6ddbWb3CoU14RAIT3ZWajk4wMVYuykmrMtOFWmR0iyVf7H4aGBI//wobFwlKiFpCJJs9oJ3MdjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WI1maX+T; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI37EHb032120;
	Mon, 18 Nov 2024 11:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6xrE/gtThAVFqCKFC
	lL7h8R5FiTofGAnJybX2eQOVFU=; b=WI1maX+Toine6XeYjCAm2DOtaLs1vSxQ/
	wNH3v3im9EX0DRCabfppGwTvdMxKQYS6EVE5p+ty0r89NrZhB/LEmjjth9sz0OI4
	JjJ/HxDfM7b6+lmpLpbpjUryBIWhPYSTiZVCEnCo4HKm7/VeErumYpyLEAMnswGK
	dCEizc2pw/BA3G/r98Ab+1eWqUg/dpzjtUvtcjNoqiVKTHz/RhVHPTUpwTL/E1xq
	/Lua1haQgzvWVo9k+t70lwBFKg4KAYoik7uTnRn06wkd33uYB/LsxyqcKhHyOYZL
	dJNzyLZKR7YEJ8J7sr8pdduwCoPeg8TWnnhQ5XS1Kq8cTfS4egn6Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xyu1fcfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 11:41:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI1GPhQ030569;
	Mon, 18 Nov 2024 11:41:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42y5qsajq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 11:41:27 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AIBfN5w64487846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 11:41:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3692520043;
	Mon, 18 Nov 2024 11:41:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94A7120040;
	Mon, 18 Nov 2024 11:41:20 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.96.153])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 Nov 2024 11:41:20 +0000 (GMT)
From: Kajol Jain <kjain@linux.ibm.com>
To: mpe@ellerman.id.au, maddy@linux.ibm.com
Cc: atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com, disgoel@linux.ibm.com,
        hbathini@linux.ibm.com, adubey@linux.ibm.com, gautam@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] docs: ABI: sysfs-bus-event_source-devices-vpa-pmu: Document sysfs event format entries for vpa_pmu
Date: Mon, 18 Nov 2024 17:11:12 +0530
Message-ID: <20241118114114.208964-2-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241118114114.208964-1-kjain@linux.ibm.com>
References: <20241118114114.208964-1-kjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D3Xx0tBQhNiIcoTuUQxZF3Iktu8Rm2-m
X-Proofpoint-ORIG-GUID: D3Xx0tBQhNiIcoTuUQxZF3Iktu8Rm2-m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411180096

Details are added for the vpa_pmu event and format
attributes in the ABI documentation.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Co-developed-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
---
 .../sysfs-bus-event_source-devices-vpa-pmu    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-vpa-pmu

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-vpa-pmu b/Documentation/ABI/testing/sysfs-bus-event_source-devices-vpa-pmu
new file mode 100644
index 000000000000..8285263ff78d
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-vpa-pmu
@@ -0,0 +1,24 @@
+What:           /sys/bus/event_source/devices/vpa_pmu/format
+Date:           November 2024
+Contact:        Linux on PowerPC Developer List <linuxppc-dev@lists.ozlabs.org>
+Description:    Read-only. Attribute group to describe the magic bits
+                that go into perf_event_attr.config for a particular pmu.
+                (See ABI/testing/sysfs-bus-event_source-devices-format).
+
+                Each attribute under this group defines a bit range of the
+                perf_event_attr.config. Supported attribute are listed
+                below::
+			event = "config:0-31" - event ID
+
+		For example::
+
+		  l1_to_l2_lat = "event=0x1"
+
+What:           /sys/bus/event_source/devices/vpa_pmu/events
+Date:           November 2024
+Contact:        Linux on PowerPC Developer List <linuxppc-dev@lists.ozlabs.org>
+Description:	Read-only. Attribute group to describe performance monitoring
+                events for the Virtual Processor Area events. Each attribute
+		in this group describes a single performance monitoring event
+		supported by vpa_pmu. The name of the file is the name of
+		the event (See ABI/testing/sysfs-bus-event_source-devices-events).
-- 
2.43.5


