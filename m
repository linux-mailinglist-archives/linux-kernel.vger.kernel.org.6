Return-Path: <linux-kernel+bounces-303761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 699329614D7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C3FB1C20BCF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1490C1CC163;
	Tue, 27 Aug 2024 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="SF6V2Rqk"
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7CD45025
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778094; cv=none; b=ncOvFsMny7sa06q9SvP9kh2dSgTpouwd7InbxmDrWtsY0tw0kARdJQD+84/wrI+cj/bRGpUKS9p9vsMWpFFOh7xrV5GxBAczQsNE5MY+xUh01+MtMSfp790MARCvUUEbXq+WpPFXqKXfh5TT9bXeiXN5ij74XIgMWF6N9sX7ZBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778094; c=relaxed/simple;
	bh=RKj2A739sA4Obux5jf5l7UBy7tPeCyHGt1w07OH0N00=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=GHJVb9NoVNcaRt8wxLh5mQ2s+cX1WnDe/PPEAgoBG46nG1J3QMy41rx1MnoqcUwNqrpX24pGcv7n/kDtsHOJN2ZuUL3mmwsniePh2UlrhifIj27eb0dFQB+vaLnH8onXvHb+JEygC5EmFyMTGp8MViUm/N+FfBj04BzCa1Es1GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=SF6V2Rqk; arc=none smtp.client-ip=173.37.86.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1897; q=dns/txt; s=iport;
  t=1724778092; x=1725987692;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RfG56hGqjnMogAQ1kemhMsBw/PeTnTehLen/hEWIk60=;
  b=SF6V2RqkVEV7COSKGIj+vErnbnViBztEPOIVdLKHUbTCMStKD4x5QjJY
   r71Iml9Og/CW6/LbmM33ucztTg2BE3cAfiHUsAcx2Z8gcKFKX7E/W7Mte
   b0S+XeW7WhGW3eY8+90LU2mTdd/zpNYt0Ka2LsX3TA2KGW94xnxxMBc9a
   s=;
X-CSE-ConnectionGUID: oo54NwhnS2aKVTzum9nITQ==
X-CSE-MsgGUID: /f30QSFiQTGLLcRexs+ZgA==
X-IronPort-AV: E=Sophos;i="6.10,180,1719878400"; 
   d="scan'208";a="251946415"
Received: from rcdn-core-10.cisco.com ([173.37.93.146])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 17:00:22 +0000
Received: from sjc-ads-3421.cisco.com (sjc-ads-3421.cisco.com [171.68.249.119])
	by rcdn-core-10.cisco.com (8.15.2/8.15.2) with ESMTP id 47RH0LmO008603;
	Tue, 27 Aug 2024 17:00:21 GMT
From: Oleksandr Ocheretnyi <oocheret@cisco.com>
To: xe-linux-external@cisco.com, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Oleksandr Ocheretnyi <oocheret@cisco.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] powerpc/pci: restore LSI mappings on card present state change
Date: Tue, 27 Aug 2024 09:57:35 -0700
Message-Id: <20240827165738.1083422-1-oocheret@cisco.com>
X-Mailer: git-send-email 2.35.6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 171.68.249.119, sjc-ads-3421.cisco.com
X-Outbound-Node: rcdn-core-10.cisco.com

Commit 450be4960a0f ("powerpc/pci: Remove LSI mappings on device
teardown") frees irq descriptors on PCIe hotplug link change event
(Link Down), but the disposed mappings are not restored back on PCIe
hotplug link change event (Card present).

This change restores IRQ mappings disposed earlier when pcieport
link's gone down. So, the call pci_read_irq_line is invoked again
on pcieport's state change (Card present).

Fixes 450be4960a0f ("powerpc/pci: Remove LSI mappings on device teardown")
Signed-off-by: Oleksandr Ocheretnyi <oocheret@cisco.com>
---
 arch/powerpc/kernel/pci-common.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index eac84d687b53..a0e7cab2baa7 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -390,22 +390,32 @@ static void ppc_pci_intx_release(struct kref *kref)
 	kfree(vi);
 }
 
+static int pci_read_irq_line(struct pci_dev *pci_dev);
+
 static int ppc_pci_unmap_irq_line(struct notifier_block *nb,
 			       unsigned long action, void *data)
 {
 	struct pci_dev *pdev = to_pci_dev(data);
 
-	if (action == BUS_NOTIFY_DEL_DEVICE) {
-		struct pci_intx_virq *vi;
-
-		mutex_lock(&intx_mutex);
-		list_for_each_entry(vi, &intx_list, list_node) {
-			if (vi->virq == pdev->irq) {
-				kref_put(&vi->kref, ppc_pci_intx_release);
-				break;
+	switch (action) {
+		case BUS_NOTIFY_DEL_DEVICE:
+			{
+				struct pci_intx_virq *vi;
+
+				mutex_lock(&intx_mutex);
+				list_for_each_entry(vi, &intx_list, list_node) {
+					if (vi->virq == pdev->irq) {
+						kref_put(&vi->kref, ppc_pci_intx_release);
+						break;
+					}
+				}
+				mutex_unlock(&intx_mutex);
 			}
-		}
-		mutex_unlock(&intx_mutex);
+			break;
+
+		case BUS_NOTIFY_ADD_DEVICE:
+			pci_read_irq_line(pdev);
+			break;
 	}
 
 	return NOTIFY_DONE;
-- 
2.39.3


