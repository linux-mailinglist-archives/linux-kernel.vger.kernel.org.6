Return-Path: <linux-kernel+bounces-234442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4CD91C6B6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AAF0B23463
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996AE7603A;
	Fri, 28 Jun 2024 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="fkaYtyaT"
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6217580C
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719603331; cv=none; b=cZvztYgv7eP50KzmqFL/q077q5MwgsBDeyFaePaqiDYL1Zuc72eCsu/4XKf/FOtGHY0YRg4mSKI6mlAhd8Y+oIMntAbMCKhkGxyTsCkj0cPIXzuYVAEivF7V6kxpUSGLjKs4WD1a8OmbKGGcwByt1naTT6qR8WOiiFKTswr3lmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719603331; c=relaxed/simple;
	bh=V1n0jSVI7xMfEz9FUwuO2gqV3cikEUg92c/eEUOkS50=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=grWbkcSNCtOqXouP5ZLLgPGTPZu8gTPGwW/uWnFQfvQ27Y49qPsSCvY4vLd82z0JA0vPSFtla4aBrWB+mGK2DKgxd4UcVri4RQ19GQNF3k/dlLuUi9GB80h8ij1qbY9eETqDveWlfgyDhCMHl8K/n7IuuH2JbUpy0TRSyY5Wf/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=fkaYtyaT; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 45SICamJ026311
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:35:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=qi5
	EVzJwLUQs420W6Yudug3rC6S4mmrf0e4GLHSgKKE=; b=fkaYtyaT9TrtHElmWEs
	sB1HRcQUMdy/QI7L5cZ4Pz7s4h6u3H5l7mNKAtt7JYTqZL7XLltuvE6RTK+hOyeO
	JXCAfA5vdjCeylEz910qigq/IYHTMf52i8VuFFp6ZHTxx8sP6VUkZsCO0sJ4bdZ5
	h7U7ySN4qDJSNkNiars8OBZACZ5B+0PTMB1Zme/bF9iNxKWO/aWz0q2hccj3U0Kn
	+ucUZOVO2BRSrZAruycB5ZIbLZOsaq5g2Mj83xJNTs6unL5pygM/ZrezmrLlN4s1
	0AZRXz2JcKdmLyT2L+Wuw4gk/36FsHqCOi2eilFYsi5EOaSDDc3w/+gCcUYX2Duz
	oEw==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4016w2tfkb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:35:28 -0700 (PDT)
Received: from twshared48820.07.ash9.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 28 Jun 2024 19:35:28 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 06CE9FF8D73F; Fri, 28 Jun 2024 12:35:23 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
CC: Keith Busch <kbusch@kernel.org>, Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] PCI: fix recusive device locking
Date: Fri, 28 Jun 2024 12:35:14 -0700
Message-ID: <20240628193514.1680137-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Z3eZXuiu2luSr_3CfgKIhwBNMBXtQZwH
X-Proofpoint-GUID: Z3eZXuiu2luSr_3CfgKIhwBNMBXtQZwH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_14,2024-06-28_01,2024-05-17_01

From: Keith Busch <kbusch@kernel.org>

If one of the bus' devices has subordinates, the recursive call locks
itself, so no need to lock the device before the recusion or it will
surely deadlock.

Fixes: dbc5b5c0d268f87 ("PCI: Add missing bridge lock to pci_bus_lock()"
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 46beaf1815fab..d9f357812b3c5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5487,9 +5487,10 @@ static void pci_bus_lock(struct pci_bus *bus)
=20
 	pci_dev_lock(bus->self);
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		pci_dev_lock(dev);
 		if (dev->subordinate)
 			pci_bus_lock(dev->subordinate);
+		else
+			pci_dev_lock(dev);
 	}
 }
=20
@@ -5501,7 +5502,8 @@ static void pci_bus_unlock(struct pci_bus *bus)
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if (dev->subordinate)
 			pci_bus_unlock(dev->subordinate);
-		pci_dev_unlock(dev);
+		else
+			pci_dev_unlock(dev);
 	}
 	pci_dev_unlock(bus->self);
 }
--=20
2.43.0


