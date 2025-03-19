Return-Path: <linux-kernel+bounces-568170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF3DA69094
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6029B1B653C2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B4E1C5D4D;
	Wed, 19 Mar 2025 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fF0jRTBR"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686DF1BFE00
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394331; cv=none; b=eXKnh/kyoTPMZNOBcSArj9gvMsJliafrhyF3qXQglippG3MmCVHrVa1U27wquyKlNp8+qdxnMXrOKkpvRIuf1a5IJoQkt/CYMnJYOn4G8oyguYCVBW5Wc9GpARqy6PTC3b9LwTF67pqwt44RnAJzrXApeJPmY+2jqyqTaNVqeCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394331; c=relaxed/simple;
	bh=5nNA9CQHqQ1WfDgMMifv1mbYfQtpCj03kthBPRLViO4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=YNUcFlgyF0Ye7/IwikKP1lgkb74MjyQtXTqE6C8xQY48qnCYrwrHvSKGEdVU37lvqzc73wBFntybSo4aRkFiE/uLuj8+kiDNIE3JLtU5LY8T3Nuc4NtsOVvwPt1Xs2b4q8jDrPhyuyVN0i+gTyB0NYq6Gp+8y5KfYHlge2ucz+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fF0jRTBR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JEFA1T018941
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:date:from:message-id:subject:to; s=pp1; bh=9aU219uCB6OHr5oGTNcK
	7PNyKSHgJjQP36U1aXyLUCk=; b=fF0jRTBR78YjXsn3sKbLx7H5SfKP62zo0ZeY
	TJLYOEj4pc3pDSfdTM+QuZnpkbquavxV3vcv3uKrt4vIeAQx881W/FzP9vKnLl6Y
	3mmEgfD5o4p25AXKCUKEKeTq7EKAN5xq4bAWxabYeVzo9Syubng4ZC6QXieweuiO
	mAt1+C2B5bkJIom4T4OKdbI478VAa3yQFKabzLvyIGRsNyw1822KNa3g9QH/iBsR
	RTeLRSUfLEgnDmUS1ApCYG81CKhe0mTVribGhXqFiJsjiLve5vM9+84rB8oc0dJZ
	o/YKLwO/1YzKOnpZtV98JCNHkuZL8RsRqcxvjZqQU4632N68jA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fpa9k1u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:25:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52JBDxkb023196
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:25:27 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dp3ksu1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:25:27 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52JEPQ3929295356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 14:25:26 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2071658055;
	Wed, 19 Mar 2025 14:25:26 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB63058066;
	Wed, 19 Mar 2025 14:25:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.89])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Mar 2025 14:25:25 +0000 (GMT)
From: wenxiong@linux.ibm.com
To: linux-kernel@vger.kernel.org, gjoyce@linux.ibm.com
Cc: Wen Xiong <wenxiong@linux.ibm.com>
Subject: [PATCH 1/1] genirq/msi: Dynamic remove/add stroage adapter hits EEH
Date: Wed, 19 Mar 2025 07:14:34 -0500
Message-Id: <1742386474-13717-1-git-send-email-wenxiong@linux.ibm.com>
X-Mailer: git-send-email 1.6.0.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RIzwlIOPoZ3KN_kkKqwRA3ztd6TOlTs9
X-Proofpoint-ORIG-GUID: RIzwlIOPoZ3KN_kkKqwRA3ztd6TOlTs9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_05,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190095
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Wen Xiong <wenxiong@linux.ibm.com>

When enable irqbalance daemon, Dynamic remove/add stroage
adapter(Scsi IPR and FC Qlogic) test hits EEH on PPC.

EEH: [c00000000004f75c] __eeh_send_failure_event+0x7c/0x160
EEH: [c000000000048444] eeh_dev_check_failure.part.0+0x254/0x650
EEH: [c008000001650678] eeh_readl+0x60/0x90 [ipr]
EEH: [c00800000166746c] ipr_cancel_op+0x2b8/0x524 [ipr]
EEH: [c008000001656524] ipr_eh_abort+0x6c/0x130 [ipr]
EEH: [c000000000ab0d20] scmd_eh_abort_handler+0x140/0x440
EEH: [c00000000017e558] process_one_work+0x298/0x590
EEH: [c00000000017eef8] worker_thread+0xa8/0x620
EEH: [c00000000018be34] kthread+0x124/0x130
EEH: [c00000000000cd64] ret_from_kernel_thread+0x5c/0x64
EEH: This PCI device has failed 1 times in the last hour and will be.

We took a pcie bus trace and found out that a vector of msix is clear
to 0 by irqbalance daemon. If we disable irqbalance daemon, we won't
see the issue on both of adapters.

We enabled debug in ipr driver,
[   44.103071] ipr: Entering __ipr_remove
[   44.103083] ipr: Entering ipr_initiate_ioa_bringdown
[   44.103091] ipr: Entering ipr_reset_shutdown_ioa
[   44.103099] ipr: Leaving ipr_reset_shutdown_ioa
[   44.103105] ipr: Leaving ipr_initiate_ioa_bringdown
[   44.149918] ipr: Entering ipr_reset_ucode_download
[   44.149935] ipr: Entering ipr_reset_alert
[   44.150032] ipr: Entering ipr_reset_start_timer
[   44.150038] ipr: Leaving ipr_reset_alert
[   44.244343] scsi 1:2:3:0: alua: Detached
[   44.254300] ipr: Entering ipr_reset_start_bist
[   44.254320] ipr: Entering ipr_reset_start_timer
[   44.254325] ipr: Leaving ipr_reset_start_bist
[   44.364329] scsi 1:2:4:0: alua: Detached
[   45.134341] scsi 1:2:5:0: alua: Detached
[   45.860949] ipr: Entering ipr_reset_shutdown_ioa
[   45.860962] ipr: Leaving ipr_reset_shutdown_ioa
[   45.860966] ipr: Entering ipr_reset_alert
[   45.861028] ipr: Entering ipr_reset_start_timer
[   45.861035] ipr: Leaving ipr_reset_alert
[   45.964302] ipr: Entering ipr_reset_start_bist
[   45.964309] ipr: Entering ipr_reset_start_timer
[   45.964313] ipr: Leaving ipr_reset_start_bist
[   46.264301] ipr: Entering ipr_reset_bist_done
[   46.264309] ipr: Leaving ipr_reset_bist_done

--->
There is very small window: irqbalance daemon kicks in before ipr driver
calls pci_restore_state(pdev), irqbalance daemon read back all 0 for that
msix vector in __pci_read_msi_msg(). When ipr driver call
pci_restore_state(pdev) in ipr_reset_restore_cfg_space(), the msix vector
has been cleared by irqbalance daemon in pci_write_msg_msix().

Below is MSIX table for ipr adapter after 'irqbalance" dameon kicked in.

Dump MSIx table: index=0 address_lo=c800 address_hi=10000000 msg_data=0
Dump MSIx table: index=1 address_lo=c810 address_hi=10000000 msg_data=0
Dump MSIx table: index=2 address_lo=c820 address_hi=10000000 msg_data=0
Dump MSIx table: index=3 address_lo=c830 address_hi=10000000 msg_data=0
Dump MSIx table: index=4 address_lo=c840 address_hi=10000000 msg_data=0
Dump MSIx table: index=5 address_lo=c850 address_hi=10000000 msg_data=0
Dump MSIx table: index=6 address_lo=c860 address_hi=10000000 msg_data=0
Dump MSIx table: index=7 address_lo=c870 address_hi=10000000 msg_data=0
Dump MSIx table: index=8 address_lo=0 address_hi=0 msg_data=0
					-------> hit EEH
Dump MSIx table: index=9 address_lo=c890 address_hi=10000000 msg_data=0
Dump MSIx table: index=10 address_lo=c8a0 address_hi=10000000 msg_data=0
Dump MSIx table: index=11 address_lo=c8b0 address_hi=10000000 msg_data=0
Dump MSIx table: index=12 address_lo=c8c0 address_hi=10000000 msg_data=0
Dump MSIx table: index=13 address_lo=c8d0 address_hi=10000000 msg_data=0
Dump MSIx table: index=14 address_lo=c8e0 address_hi=10000000 msg_data=0
Dump MSIx table: index=15 address_lo=c8f0 address_hi=10000000 msg_data=0

[   46.264312] ipr: Entering ipr_reset_restore_cfg_space
[   46.267439] ipr: Entering ipr_fail_all_ops
[   46.267447] ipr: Leaving ipr_fail_all_ops
[   46.267451] ipr: Leaving ipr_reset_restore_cfg_space
[   46.267454] ipr: Entering ipr_ioa_bringdown_done
[   46.267458] ipr: Leaving ipr_ioa_bringdown_done
[   46.267467] ipr: Entering ipr_worker_thread
[   46.267470] ipr: Leaving ipr_worker_thread

irabalance daemon calls this:
In _pci_read_msi_msg(),
void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
{
    struct pci_dev *dev = msi_desc_to_pci_dev(entry);

    BUG_ON(dev->current_state != PCI_D0);

    if (entry->pci.msi_attrib.is_msix) {
        void __iomem *base = pci_msix_desc_addr(entry);

        if (WARN_ON_ONCE(entry->pci.msi_attrib.is_virtual))
            return;

        msg->address_lo = readl(base + PCI_MSIX_ENTRY_LOWER_ADDR);
			-> it is 0 before calling pci_restore_state()

        msg->address_hi = readl(base + PCI_MSIX_ENTRY_UPPER_ADDR);
			-> it is 0 before calling pci_restore_state()

        msg->data = readl(base + PCI_MSIX_ENTRY_DATA);
...
...
}

Then call pseries_msi_write_msg to set 0 to entry->msg.

static void pseries_msi_write_msg(struct irq_data *data,...)
{
    struct msi_desc *entry = irq_data_get_msi_desc(data);

    entry->msg = *msg;
}

Later ipr driver calls pci_restore_save(pdev)
-> __pci_restore_msix_state()

pci_restore_msix_state(struct pci_dev *dev)
  -> pci_write_msg_msix()

static inline void pci_write_msg_msix()
{
..   writel(msg->address_lo, base + PCI_MSIX_ENTRY_LOWER_ADDR);
			->already clear to 0 by irqbalance daemon

    writel(msg->address_hi, base + PCI_MSIX_ENTRY_UPPER_ADDR); 
			->already clear to 0 by irqbalance daemon
    writel(msg->data, base + PCI_MSIX_ENTRY_DATA);

}

I tried the following patch and we didn't hit the issue. If you are
familiar with MSI domain code, Please suggest the better solution.

Thanks,
Wendy

Signed-off-by: Wen Xiong <wenxiong@linux.ibm.com>
---
 kernel/irq/msi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 396a067a8a56..fcde35efb64c 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -671,7 +671,8 @@ int msi_domain_set_affinity(struct irq_data *irq_data,
 	if (ret >= 0 && ret != IRQ_SET_MASK_OK_DONE) {
 		BUG_ON(irq_chip_compose_msi_msg(irq_data, msg));
 		msi_check_level(irq_data->domain, msg);
-		irq_chip_write_msi_msg(irq_data, msg);
+		if ((msg->address_lo != 0) && (msg->address_hi != 0))
+			irq_chip_write_msi_msg(irq_data, msg);
 	}
 
 	return ret;
-- 
2.43.5


