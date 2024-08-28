Return-Path: <linux-kernel+bounces-305307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6B8962CAE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11FA1F22961
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7873F1A257A;
	Wed, 28 Aug 2024 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JwKkGPPe"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4311419ADB6
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859835; cv=none; b=hpGPJckEXsSTE3ElUwVyUpX8xjOoLqy7ZZfc4wjMmTm0BnGacdfo3yTYWlWR3+WAvFjetaAug/49mlu/0+sRiLLRw2yEZGC0dB7I0nD7teHMUB6ziDq6ck1PNIXGVGiIjGKUCubRQps8dYH63BV8/e02VfSpuTKQalPdJtabKFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859835; c=relaxed/simple;
	bh=/VUMMu2Pi7naGdR4ykznSreRbDniSUyvNFVWp6tFALI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xe6pbUeqDx5OU7RVsq/Uw1xSi5n+CT6ioprsURMPEyVwoM5G6Mc5HbvMgqfbfYUEOdkghkHDoEAwHBBO57yAjxjO06MBlkb/zOtyjLf7KaFYnyLdQz/3V17LTVQc5JyOYHDPdfSN9+ws7f1to24mvdNWjxL1Q3Cl8FNSyxAMDyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JwKkGPPe; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SCMRKO010628;
	Wed, 28 Aug 2024 15:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=5HNJaYTxf+e5ah
	b4QBDVs6QDRlesqJfpK0V51xkKkSQ=; b=JwKkGPPeMfdA4pWmAsfXA5I445+OWo
	X6/g7rS2PI1N4N1pV726LclIf4zqi9Qwyg36L17LiXcX1BzgxE2uU+lznTbJd8QT
	x1ky8MOITEFMu4WvH3cIMxBPjhM7C/QvOo3k/byHeAqwZ2+LmvunNg3fY2tI/opf
	mqrCRDWPOW2oAdqc8lBGX1n5Lmy/M01iJ6k/n4vkGjNvK0zqa4wwIEpugCU+STBk
	SvCK2wduMtsgZsBZ+CyNSATWLJkodhZvrhhfZRwHyLCZTNQ+GdZt93CChIQvC3ue
	BmeOWwwos4+kUE2n0ZCtWo44Ilwzb4uR0UjfnTLwOEbAZ4TjQ+JoQFyw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pugsnxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 15:43:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47SEUt5B010512;
	Wed, 28 Aug 2024 15:43:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41894pgr17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 15:43:42 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47SFdlSZ021391;
	Wed, 28 Aug 2024 15:43:41 GMT
Received: from localhost.localdomain ([100.99.32.179])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41894pgqyj-1;
	Wed, 28 Aug 2024 15:43:41 +0000
From: David Fernandez Gonzalez <david.fernandez.gonzalez@oracle.com>
To: Bryan Tan <bryan-bt.tan@broadcom.com>,
        Vishnu Dasa <vishnu.dasa@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        George Zhang <georgezhang@vmware.com>, Andy king <acking@vmware.com>,
        Dmitry Torokhov <dtor@vmware.com>, linux-kernel@vger.kernel.org
Cc: harshit.m.mogalapalli@oracle.com, vegard.nossum@oracle.com
Subject: [PATCH] VMCI: Fix use-after-free when removing resource in vmci_resource_remove()
Date: Wed, 28 Aug 2024 15:43:37 +0000
Message-ID: <20240828154338.754746-1-david.fernandez.gonzalez@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_06,2024-08-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408280113
X-Proofpoint-GUID: neplYgYYjlV8Fecumb5YrUruX3pxIi7z
X-Proofpoint-ORIG-GUID: neplYgYYjlV8Fecumb5YrUruX3pxIi7z

When removing a resource from vmci_resource_table in
vmci_resource_remove(), the search is performed using the resource
handle by comparing context and resource fields.

It is possible though to create two resources with different types
but same handle (same context and resource fields).

When trying to remove one of the resources, vmci_resource_remove()
may not remove the intended one, but the object will still be freed
as in the case of the datagram type in vmci_datagram_destroy_handle().
vmci_resource_table will still hold a pointer to this freed resource
leading to a use-after-free vulnerability.

BUG: KASAN: use-after-free in vmci_handle_is_equal include/linux/vmw_vmci_defs.h:142 [inline]
BUG: KASAN: use-after-free in vmci_resource_remove+0x3a1/0x410 drivers/misc/vmw_vmci/vmci_resource.c:147
Read of size 4 at addr ffff88801c16d800 by task syz-executor197/1592
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x82/0xa9 lib/dump_stack.c:106
 print_address_description.constprop.0+0x21/0x366 mm/kasan/report.c:239
 __kasan_report.cold+0x7f/0x132 mm/kasan/report.c:425
 kasan_report+0x38/0x51 mm/kasan/report.c:442
 vmci_handle_is_equal include/linux/vmw_vmci_defs.h:142 [inline]
 vmci_resource_remove+0x3a1/0x410 drivers/misc/vmw_vmci/vmci_resource.c:147
 vmci_qp_broker_detach+0x89a/0x11b9 drivers/misc/vmw_vmci/vmci_queue_pair.c:2182
 ctx_free_ctx+0x473/0xbe1 drivers/misc/vmw_vmci/vmci_context.c:444
 kref_put include/linux/kref.h:65 [inline]
 vmci_ctx_put drivers/misc/vmw_vmci/vmci_context.c:497 [inline]
 vmci_ctx_destroy+0x170/0x1d6 drivers/misc/vmw_vmci/vmci_context.c:195
 vmci_host_close+0x125/0x1ac drivers/misc/vmw_vmci/vmci_host.c:143
 __fput+0x261/0xa34 fs/file_table.c:282
 task_work_run+0xf0/0x194 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x184/0x189 kernel/entry/common.c:187
 exit_to_user_mode_prepare+0x11b/0x123 kernel/entry/common.c:220
 __syscall_exit_to_user_mode_work kernel/entry/common.c:302 [inline]
 syscall_exit_to_user_mode+0x18/0x42 kernel/entry/common.c:313
 do_syscall_64+0x41/0x85 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x6e/0x0

This change ensures the type is also checked when removing
the resource from vmci_resource_table in vmci_resource_remove().

Fixes: bc63dedb7d46 ("VMCI: resource object implementation.")
Cc: stable@vger.kernel.org
Reported-by: George Kennedy <george.kennedy@oracle.com>
Signed-off-by: David Fernandez Gonzalez <david.fernandez.gonzalez@oracle.com>
---
 drivers/misc/vmw_vmci/vmci_resource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_resource.c b/drivers/misc/vmw_vmci/vmci_resource.c
index 692daa9eff34..19c9d2cdd277 100644
--- a/drivers/misc/vmw_vmci/vmci_resource.c
+++ b/drivers/misc/vmw_vmci/vmci_resource.c
@@ -144,7 +144,8 @@ void vmci_resource_remove(struct vmci_resource *resource)
 	spin_lock(&vmci_resource_table.lock);
 
 	hlist_for_each_entry(r, &vmci_resource_table.entries[idx], node) {
-		if (vmci_handle_is_equal(r->handle, resource->handle)) {
+		if (vmci_handle_is_equal(r->handle, resource->handle) &&
+		    resource->type == r->type) {
 			hlist_del_init_rcu(&r->node);
 			break;
 		}
-- 
2.43.5


