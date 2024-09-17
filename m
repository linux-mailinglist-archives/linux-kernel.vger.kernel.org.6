Return-Path: <linux-kernel+bounces-331741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF1897B0BB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92F3BB22B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08B516B75B;
	Tue, 17 Sep 2024 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XGZu8KDA"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143621EB35
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726579514; cv=none; b=CVSOJpWoJBY5cSAN8kReoG0qAvuX44cgcAulwXWZjx+uly5RNTEJt4yKuhEEZBWjfHZ42ThxPZyPHJk024hLf8iHQzDUvdsaLHsskbIlEv3qaOJTUB8sRq+qDQq0UXqw7PiJTOjKa5oNOa/fS3/CWjXAl59OyAMAXVgf1/F3Kbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726579514; c=relaxed/simple;
	bh=vlt+KcaN724O/p16KqlKcvB/L9UhKK53yAL+yY5yOZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lKLMUJG0mHNtwerv9Nv+qIDi1BtaU460AgyfHKjT4b+jRxtgk8egMvEYKcW83Q0NAtbuEvxoxkEReoAcrCNONibWO3CnRHXwV8OHPycdng24lkuSNU6mqlevoIXjFesNyIOb0RDKJEamFQlEUv9txvfGXfzrMGMgQZusCq559YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XGZu8KDA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48H8FO9B031957;
	Tue, 17 Sep 2024 13:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=Z769WCX4OS1KZIRuK7qzRG9PO/TL5XYkQB5PvLA
	PAPc=; b=XGZu8KDAexY7PMt62ocFEdx0R0/V6sFh6a7GCpxQ4GVS0X3vTx4skGF
	d0ZchNvzoB8XHgGaJRbjPLd+fhvgxP1GLCX6RpDJmHPlRlQ8zc8aVaxtGcEqiWkQ
	pmputr2u0LLe6CmSIjXBFxy080Q0yDpMkdv3NhulSpbGQP52Cq5ozb1DAJZpzLkh
	ttDHQ9pquJTq3ALP1pTANvMbjAI/B8alGiOa/CoSmTilqPBAHoVa2nAMD4R4KJ1O
	JsKJyS08iFIuFKQ3ww/ND5vw7tRvH7aYUP7DnZMaIlJw5gpO3/X2qL13zHYnu5P8
	uX+ns8HzS2JrRY0au8v8HnGtJv+L5ww==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3uj8c40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 13:24:55 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48HDOtbJ020134;
	Tue, 17 Sep 2024 13:24:55 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3uj8c3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 13:24:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48HAQsrI024699;
	Tue, 17 Sep 2024 13:24:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41nq1mw5ta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 13:24:54 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48HDOoDx43581880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 13:24:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77D5A20043;
	Tue, 17 Sep 2024 13:24:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA8D520040;
	Tue, 17 Sep 2024 13:24:48 +0000 (GMT)
Received: from ltc-wspoon17.aus.stglabs.ibm.com (unknown [9.3.101.49])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Sep 2024 13:24:48 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org, vaibhav@linux.ibm.com,
        ganeshgr@linux.ibm.com, sbhat@linux.ibm.com
Subject: [PATCH] powerpc/pseries/eeh: move pseries_eeh_err_inject() outside CONFIG_DEBUG_FS block
Date: Tue, 17 Sep 2024 09:24:45 -0400
Message-Id: <20240917132445.3868016-1-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FtQ074m2Rfo7OijiNExjd6AeztopPfs4
X-Proofpoint-GUID: 0axfa_oxoiyn_dZJi0weoiAiqHLdxOI1
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_05,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409170094

Makes pseries_eeh_err_inject() available even when debugfs
is disabled (CONFIG_DEBUG_FS=n). It moves eeh_debugfs_break_device()
and eeh_pe_inject_mmio_error() out of the CONFIG_DEBUG_FS block
and renames it as eeh_break_device().

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409170509.VWC6jadC-lkp@intel.com/
Fixes: b0e2b828dfca ("powerpc/pseries/eeh: Fix pseries_eeh_err_inject")
Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 198 +++++++++++++++++++-------------------
 1 file changed, 99 insertions(+), 99 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 49ab11a287a3..0fe25e907ea6 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1574,6 +1574,104 @@ static int proc_eeh_show(struct seq_file *m, void *v)
 }
 #endif /* CONFIG_PROC_FS */
 
+static int eeh_break_device(struct pci_dev *pdev)
+{
+	struct resource *bar = NULL;
+	void __iomem *mapped;
+	u16 old, bit;
+	int i, pos;
+
+	/* Do we have an MMIO BAR to disable? */
+	for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
+		struct resource *r = &pdev->resource[i];
+
+		if (!r->flags || !r->start)
+			continue;
+		if (r->flags & IORESOURCE_IO)
+			continue;
+		if (r->flags & IORESOURCE_UNSET)
+			continue;
+
+		bar = r;
+		break;
+	}
+
+	if (!bar) {
+		pci_err(pdev, "Unable to find Memory BAR to cause EEH with\n");
+		return -ENXIO;
+	}
+
+	pci_err(pdev, "Going to break: %pR\n", bar);
+
+	if (pdev->is_virtfn) {
+#ifndef CONFIG_PCI_IOV
+		return -ENXIO;
+#else
+		/*
+		 * VFs don't have a per-function COMMAND register, so the best
+		 * we can do is clear the Memory Space Enable bit in the PF's
+		 * SRIOV control reg.
+		 *
+		 * Unfortunately, this requires that we have a PF (i.e doesn't
+		 * work for a passed-through VF) and it has the potential side
+		 * effect of also causing an EEH on every other VF under the
+		 * PF. Oh well.
+		 */
+		pdev = pdev->physfn;
+		if (!pdev)
+			return -ENXIO; /* passed through VFs have no PF */
+
+		pos  = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
+		pos += PCI_SRIOV_CTRL;
+		bit  = PCI_SRIOV_CTRL_MSE;
+#endif /* !CONFIG_PCI_IOV */
+	} else {
+		bit = PCI_COMMAND_MEMORY;
+		pos = PCI_COMMAND;
+	}
+
+	/*
+	 * Process here is:
+	 *
+	 * 1. Disable Memory space.
+	 *
+	 * 2. Perform an MMIO to the device. This should result in an error
+	 *    (CA  / UR) being raised by the device which results in an EEH
+	 *    PE freeze. Using the in_8() accessor skips the eeh detection hook
+	 *    so the freeze hook so the EEH Detection machinery won't be
+	 *    triggered here. This is to match the usual behaviour of EEH
+	 *    where the HW will asynchronously freeze a PE and it's up to
+	 *    the kernel to notice and deal with it.
+	 *
+	 * 3. Turn Memory space back on. This is more important for VFs
+	 *    since recovery will probably fail if we don't. For normal
+	 *    the COMMAND register is reset as a part of re-initialising
+	 *    the device.
+	 *
+	 * Breaking stuff is the point so who cares if it's racy ;)
+	 */
+	pci_read_config_word(pdev, pos, &old);
+
+	mapped = ioremap(bar->start, PAGE_SIZE);
+	if (!mapped) {
+		pci_err(pdev, "Unable to map MMIO BAR %pR\n", bar);
+		return -ENXIO;
+	}
+
+	pci_write_config_word(pdev, pos, old & ~bit);
+	in_8(mapped);
+	pci_write_config_word(pdev, pos, old);
+
+	iounmap(mapped);
+
+	return 0;
+}
+
+int eeh_pe_inject_mmio_error(struct pci_dev *pdev)
+{
+	return eeh_break_device(pdev);
+}
+
 #ifdef CONFIG_DEBUG_FS
 
 
@@ -1727,99 +1825,6 @@ static const struct file_operations eeh_dev_check_fops = {
 	.read   = eeh_debugfs_dev_usage,
 };
 
-static int eeh_debugfs_break_device(struct pci_dev *pdev)
-{
-	struct resource *bar = NULL;
-	void __iomem *mapped;
-	u16 old, bit;
-	int i, pos;
-
-	/* Do we have an MMIO BAR to disable? */
-	for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
-		struct resource *r = &pdev->resource[i];
-
-		if (!r->flags || !r->start)
-			continue;
-		if (r->flags & IORESOURCE_IO)
-			continue;
-		if (r->flags & IORESOURCE_UNSET)
-			continue;
-
-		bar = r;
-		break;
-	}
-
-	if (!bar) {
-		pci_err(pdev, "Unable to find Memory BAR to cause EEH with\n");
-		return -ENXIO;
-	}
-
-	pci_err(pdev, "Going to break: %pR\n", bar);
-
-	if (pdev->is_virtfn) {
-#ifndef CONFIG_PCI_IOV
-		return -ENXIO;
-#else
-		/*
-		 * VFs don't have a per-function COMMAND register, so the best
-		 * we can do is clear the Memory Space Enable bit in the PF's
-		 * SRIOV control reg.
-		 *
-		 * Unfortunately, this requires that we have a PF (i.e doesn't
-		 * work for a passed-through VF) and it has the potential side
-		 * effect of also causing an EEH on every other VF under the
-		 * PF. Oh well.
-		 */
-		pdev = pdev->physfn;
-		if (!pdev)
-			return -ENXIO; /* passed through VFs have no PF */
-
-		pos  = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
-		pos += PCI_SRIOV_CTRL;
-		bit  = PCI_SRIOV_CTRL_MSE;
-#endif /* !CONFIG_PCI_IOV */
-	} else {
-		bit = PCI_COMMAND_MEMORY;
-		pos = PCI_COMMAND;
-	}
-
-	/*
-	 * Process here is:
-	 *
-	 * 1. Disable Memory space.
-	 *
-	 * 2. Perform an MMIO to the device. This should result in an error
-	 *    (CA  / UR) being raised by the device which results in an EEH
-	 *    PE freeze. Using the in_8() accessor skips the eeh detection hook
-	 *    so the freeze hook so the EEH Detection machinery won't be
-	 *    triggered here. This is to match the usual behaviour of EEH
-	 *    where the HW will asynchronously freeze a PE and it's up to
-	 *    the kernel to notice and deal with it.
-	 *
-	 * 3. Turn Memory space back on. This is more important for VFs
-	 *    since recovery will probably fail if we don't. For normal
-	 *    the COMMAND register is reset as a part of re-initialising
-	 *    the device.
-	 *
-	 * Breaking stuff is the point so who cares if it's racy ;)
-	 */
-	pci_read_config_word(pdev, pos, &old);
-
-	mapped = ioremap(bar->start, PAGE_SIZE);
-	if (!mapped) {
-		pci_err(pdev, "Unable to map MMIO BAR %pR\n", bar);
-		return -ENXIO;
-	}
-
-	pci_write_config_word(pdev, pos, old & ~bit);
-	in_8(mapped);
-	pci_write_config_word(pdev, pos, old);
-
-	iounmap(mapped);
-
-	return 0;
-}
-
 static ssize_t eeh_dev_break_write(struct file *filp,
 				const char __user *user_buf,
 				size_t count, loff_t *ppos)
@@ -1831,7 +1836,7 @@ static ssize_t eeh_dev_break_write(struct file *filp,
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
 
-	ret = eeh_debugfs_break_device(pdev);
+	ret = eeh_break_device(pdev);
 	pci_dev_put(pdev);
 
 	if (ret < 0)
@@ -1847,11 +1852,6 @@ static const struct file_operations eeh_dev_break_fops = {
 	.read   = eeh_debugfs_dev_usage,
 };
 
-int eeh_pe_inject_mmio_error(struct pci_dev *pdev)
-{
-	return eeh_debugfs_break_device(pdev);
-}
-
 static ssize_t eeh_dev_can_recover(struct file *filp,
 				   const char __user *user_buf,
 				   size_t count, loff_t *ppos)
-- 
2.39.2


