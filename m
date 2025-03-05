Return-Path: <linux-kernel+bounces-546343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A3BA4F974
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CDAA16952A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0981FC7D1;
	Wed,  5 Mar 2025 09:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="idXzb7jg"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1A21FCFE6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741165389; cv=none; b=gtDquyIsVB7x8xhyyzluELNoDOGYNFJFZ+Fx1G6UXoT5Ly9k7qJj6TJ4tpVpKc35qwZlPXULltOlzOCib9+nSoONiaj4H2Nfhoma2KaIa0gVikly9evBhlRCiKl8uPgFy5d9l5B9l4n3YWYcpNWj3BsSqfGtOHCv4rTT2amWJfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741165389; c=relaxed/simple;
	bh=OQ/3sc5DysD/5W6k0zs3RrGx5Cp8e7MoJKbSSXk129o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OPK6O2KnNR5jbItZ6ab0mFKKtiDsq549YQnqaEbIF3Tje2OIFSF84qLf47cRg3FEOqqW7pE7Rv2BwXTCcP35ODU4hbQD5NwH6XtODNaUg5O+mT/CZvl3+7v8wzszCf5QEWH1Hco/aXvbFGguuxvdu5Lt2uZA65yRaxt1yg5HnQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=idXzb7jg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5258fDFP008325;
	Wed, 5 Mar 2025 09:02:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=n1z2e9mVbdazKv/D+7yQN/ZVbR7ipkcxFW+oD3l7R
	jw=; b=idXzb7jgXBXuYsVeJaUSaDwesp7bkOuVKlFflWDLVQE0v3VlGp4pMrW/K
	A8ba3gCk4MOS4Avf9JhpocEc7A5EZsvAdcf+UN2izFKnplbH5s8W8RKbZ8+DWlc5
	5WiWygaRdYk75hWB9z9Gilv7+GZe3QJgZZs2VaF/HYZKp0KKWCYMYsoBaO7JpL1X
	tj9i3UZ54p+awFkROvBWeOfi4UrfTkJvn6Uewo6Bg+Aj1si0xo3ZJEHVG3Ar35Ve
	ohD+ufGw8rwbiBTobeiwnXYrHA7zJzjokErbPyUMpMIfC98QESyIokSCBNx/SKJf
	zdZos9SL0L5HGny92XYHJcH0OdUlw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4568ppahp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 09:02:46 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5258vqXG029793;
	Wed, 5 Mar 2025 09:02:46 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4568ppahp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 09:02:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5257gU36013776;
	Wed, 5 Mar 2025 09:02:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2ksvth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 09:02:45 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52592fPf24773228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 09:02:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5396820040;
	Wed,  5 Mar 2025 09:02:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AD1A20043;
	Wed,  5 Mar 2025 09:02:39 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.in.ibm.com (unknown [9.204.206.66])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Mar 2025 09:02:39 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, vaibhav@linux.ibm.com
Subject: [PATCH] powerpc/pseries/msi: Avoid reading PCI device registers in reduced power states
Date: Wed,  5 Mar 2025 14:32:36 +0530
Message-ID: <20250305090237.294633-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XMEYmXGLWR-uqDp97woI17Cud8XvfrSk
X-Proofpoint-ORIG-GUID: qBkNYmHN-zrEB8W6tWAMSOdOUG5YmdZY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_03,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050071

When a system is being suspended to RAM, the PCI devices are also
suspended and the PPC code ends up calling pseries_msi_compose_msg() and
this triggers the BUG_ON() in __pci_read_msi_msg() because the device at
this point is in reduced power state. In reduced power state, the memory
mapped registers of the PCI device are not accessible.

To replicate the bug:
1. Make sure deep sleep is selected
	# cat /sys/power/mem_sleep
	s2idle [deep]

2. Make sure console is not suspended (so that dmesg logs are visible)
	echo N > /sys/module/printk/parameters/console_suspend

3. Suspend the system
	echo mem > /sys/power/state

To fix this behaviour, read the cached msi message of the device when the
device is not in PCI_D0 power state instead of touching the hardware.

Fixes: a5f3d2c17b07 ("powerpc/pseries/pci: Add MSI domains")
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/msi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index fdc2f7f38dc9..458d95c8c755 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -525,7 +525,12 @@ static struct msi_domain_info pseries_msi_domain_info = {
 
 static void pseries_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	__pci_read_msi_msg(irq_data_get_msi_desc(data), msg);
+	struct pci_dev *dev = msi_desc_to_pci_dev(irq_data_get_msi_desc(data));
+
+	if (dev->current_state == PCI_D0)
+		__pci_read_msi_msg(irq_data_get_msi_desc(data), msg);
+	else
+		get_cached_msi_msg(data->irq, msg);
 }
 
 static struct irq_chip pseries_msi_irq_chip = {
-- 
2.47.0


