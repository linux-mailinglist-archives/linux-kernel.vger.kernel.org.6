Return-Path: <linux-kernel+bounces-330172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C950979A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E974E2822D3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 05:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4246282FA;
	Mon, 16 Sep 2024 05:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="ndjOabvJ"
Received: from out0-193.mail.aliyun.com (out0-193.mail.aliyun.com [140.205.0.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32611BDC8
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 05:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726463136; cv=none; b=ZTCTc9F0xd1sLFw4Be2z7x4+kK5WEUQUUIgeivAsR5SZ77nQPxDyKOzisyPH1kNSim3yv4CdT6kJarc0DeQVCSTNtm/zCYkYiH/5VvwyJ6BJBw1wkvBG0/WqalgFNYZQX7wQ0hSt4y9ga6DH5sl1IM2VHnL+w19di/kk/DznzPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726463136; c=relaxed/simple;
	bh=KVtJ0GFPR0VI0VxEJUftCKj8p2hAtkW1h7R09xBM5j4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LjJEk5h5h9NWq3/DlTJBEk08xgNPy+fo5Vnq0iuVPtv/URD0+xUzbXhMjqwM2TYI2UaE8cijPQGIjc060hqSuWfdOsuUm0wpaqDkrUkmB3yQWxbnaK1rkUd8cs8qZ3AUq7zET/Gk7UnabbKXv/2XH58fWWhyWDCeAb5XmGx0ap0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=ndjOabvJ; arc=none smtp.client-ip=140.205.0.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1726463124; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=CJgZGzYMVBL3IfrmAZkoR5Aw2/PtQZpaw3y5LK6ZT4k=;
	b=ndjOabvJpPQxxFT5JqMp6hfbZSmh2vUqL6dwGH1wPlgt+FWEMhERZ/0CQ0aWoluny/99KBTEOKabeRCHGboH/8Den2WxBSbzv3B+nRv0Nle7N6tD0l002ZXt1usmMD/H8+dm2q+Un7LMksGWI5ImM/ASzMNe+NMkwChYuZjYsYU=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZKOkLXb_1726462805)
          by smtp.aliyun-inc.com;
          Mon, 16 Sep 2024 13:00:05 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
   <benjamin@sipsolutions.net>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 4/4] um: Fix the definition for physmem_size
Date: Mon, 16 Sep 2024 12:59:50 +0800
Message-Id: <20240916045950.508910-5-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916045950.508910-1-tiwei.btw@antgroup.com>
References: <20240916045950.508910-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently physmem_size is defined as long long but declared locally
as unsigned long long before using it in separate .c files. Make them
match by defining physmem_size as unsigned long long and also move
the declaration to a common header to allow the compiler to check it.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/virtio_uml.c       | 2 --
 arch/um/include/shared/as-layout.h | 2 ++
 arch/um/kernel/physmem.c           | 2 --
 arch/um/kernel/um_arch.c           | 2 +-
 4 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index e7f5556e3c96..4d3e9b9f5b61 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -72,8 +72,6 @@ struct virtio_uml_vq_info {
 	bool suspended;
 };
 
-extern unsigned long long physmem_size;
-
 #define vu_err(vu_dev, ...)	dev_err(&(vu_dev)->pdev->dev, ##__VA_ARGS__)
 
 /* Vhost-user protocol */
diff --git a/arch/um/include/shared/as-layout.h b/arch/um/include/shared/as-layout.h
index 61965a06c18a..283226c34ca4 100644
--- a/arch/um/include/shared/as-layout.h
+++ b/arch/um/include/shared/as-layout.h
@@ -36,6 +36,8 @@ struct cpu_task {
 
 extern struct cpu_task cpu_tasks[];
 
+extern unsigned long long physmem_size;
+
 extern unsigned long high_physmem;
 extern unsigned long uml_physmem;
 extern unsigned long uml_reserved;
diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index 94aca17993fd..636830fe00f2 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -22,8 +22,6 @@ static int physmem_fd = -1;
 unsigned long high_physmem;
 EXPORT_SYMBOL(high_physmem);
 
-extern unsigned long long physmem_size;
-
 void __init mem_total_pages(unsigned long physmem, unsigned long iomem)
 {
 	unsigned long phys_pages, iomem_pages, total_pages;
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 8f86aa468b50..99cdf4b2d648 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -131,7 +131,7 @@ static int have_root __initdata;
 static int have_console __initdata;
 
 /* Set in uml_mem_setup and modified in linux_main */
-long long physmem_size = 64 * 1024 * 1024;
+unsigned long long physmem_size = 64 * 1024 * 1024;
 EXPORT_SYMBOL(physmem_size);
 
 static const char *usage_string =
-- 
2.34.1


