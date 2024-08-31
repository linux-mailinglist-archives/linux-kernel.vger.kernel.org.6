Return-Path: <linux-kernel+bounces-309695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8024E966F65
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 07:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276631F24E3E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 05:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1485C13CA97;
	Sat, 31 Aug 2024 05:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="lS6+8Lqe"
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7B3763F8
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 05:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725081868; cv=none; b=Z8KgmX0+vXkgizFwNbTLqPM9BG0KTMaWxw4MoxOWuPmzmhBut4f5reh8ukAJPQlx0Di/3N9OYLipb91fQAeWKuvdMQto55zun+hQ/D0pLvVsEQlqoJXNVjikoXy46lVfgf4P/WWFFwX+2SRpV7Q69Fs7ZymYbo/spwXa+2ufm5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725081868; c=relaxed/simple;
	bh=Qrydd6FpfGREKFpUumfU+PND9ypJPQ0rvGA5gim0Y0I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EVO6yAzdQQvQ4uokWwkyctibgh/vTEZ61abOG13Xfa9m8xb7oYE9lbyekJb/sT7HL+NZ4SK4J1pjaQp8e7XLyrTuuSOjCIyAvDr25co9RsjVL2Itwxq0nX8P6ckWCFmfcKCRSkZO27I+w7gZz8XEEZXSlf1pKpVE2xwDFyPqKJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=lS6+8Lqe; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1725081795;
	bh=BeFS78svjvX4dgZ/pXmTXrW3I/8Ubt/o8uwqmQay4rc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=lS6+8LqeCYg27XDxF6TuwCvzN6M0aLM/fliy5tWtRFWZa268/Xxk0s6vg9uKjveLA
	 CGvctqtcpp0hNI3VUkz2Q6msqowr961ol/zxRbA3g5Anp5vk011EDaX9a5WRA7ro/p
	 ZuvpwkJLiaAtcXaoGUcFIVsqDakXw0nXNy3nQixs=
X-QQ-mid: bizesmtp85t1725081789tfeka6ky
X-QQ-Originating-IP: E3dMKFpfvXJ0xiShuJTZplZjy33NIhkzA8HM6/RTArs=
Received: from localhost.localdomain ( [111.172.4.23])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 31 Aug 2024 13:23:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2311621511106180187
From: Wentao Guan <guanwentao@uniontech.com>
To: henhuacai@kernel.org,
	kernel@xen0n.name,
	loongarch@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Wentao Guan <guanwentao@uniontech.com>,
	Wangyuli <wangyuli@uniontech.com>
Subject: [PATCH] Loongarch64: pci: fix memleak in pci_acpi_scan_root
Date: Sat, 31 Aug 2024 13:21:57 +0800
Message-Id: <20240831052157.13532-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0

Add kfree(root_ops) in this case to avoid memleak root_ops,
leaks when pci_find_bus() != 0.
Also delay assign root_ops when used for making code read clean.
Found by code review

Signed-off-by: Wangyuli <wangyuli@uniontech.com>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 arch/loongarch/pci/acpi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/pci/acpi.c b/arch/loongarch/pci/acpi.c
index 3eb61b8cd5e3..7f3539f5fa23 100644
--- a/arch/loongarch/pci/acpi.c
+++ b/arch/loongarch/pci/acpi.c
@@ -219,17 +219,18 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		return NULL;
 	}
 
-	root_ops->release_info = acpi_release_root_info;
-	root_ops->prepare_resources = acpi_prepare_root_resources;
-	root_ops->pci_ops = (struct pci_ops *)&info->cfg->ops->pci_ops;
-
 	bus = pci_find_bus(domain, busnum);
 	if (bus) {
 		memcpy(bus->sysdata, info->cfg, sizeof(struct pci_config_window));
 		kfree(info);
+		kfree(root_ops);
 	} else {
 		struct pci_bus *child;
 
+		root_ops->release_info = acpi_release_root_info;
+		root_ops->prepare_resources = acpi_prepare_root_resources;
+		root_ops->pci_ops = (struct pci_ops *)&info->cfg->ops->pci_ops;
+
 		bus = acpi_pci_root_create(root, root_ops,
 					   &info->common, info->cfg);
 		if (!bus) {
-- 
2.20.1


