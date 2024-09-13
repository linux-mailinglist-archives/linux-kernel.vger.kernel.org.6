Return-Path: <linux-kernel+bounces-328368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8E5978281
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AAA71C22125
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A66BA2E;
	Fri, 13 Sep 2024 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="LZlnHXjt"
Received: from out187-4.us.a.mail.aliyun.com (out187-4.us.a.mail.aliyun.com [47.90.187.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D29945A
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726237639; cv=none; b=u8EE6O34oZI7Iv8MAaFI8utZ2A/cQmdh68cwHnyUwUHe2GEYEpedrqCMLZ8tt8iMxA/UIwIlIAt+pYhJinwAXLBSCqBaVZLwhLQRHcwgiEO+JYzjG5wmqcOSHDVlXRUklpL+sDtFoCzMjKXggFTyl6kqOPcbren1cAsWOOiH+Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726237639; c=relaxed/simple;
	bh=2hwyDiwQgYMUKTn//I27PURPTzmcDJLpyDKMOWb3Xt0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fb+jGPy4WaCy3Z1kg7DLB51yRhYrfQzJgr9Zs0V3JcTn1TXVf0H7ZrSDzNftKCP7J3jMRMooJdLMHmW8egEDp4wtpHGhe0Ua4sSPztAavjtm8xJCjw2PJXiVexvpACVKap+DEKazFH+oYu+b0ECuZcyvMCHvxCKBUl+BiqHcsgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=LZlnHXjt; arc=none smtp.client-ip=47.90.187.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1726237623; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=il6g9/DKpO4uIRhZ89sH+VLpafro2K8XMn8EYlmhmKI=;
	b=LZlnHXjtW18eTA1AM1cYiuxitbKNiI5R8eUhv+KFJRkJQVqYles2J/6YaUYF3/OOU3GvDNAZYuXcVk9reE0Z9Re/G+57eI1jz5joituSRaQLoItFR+Lq+yzQYRhSa12FgMtxuvDU4MeKVnfZ9o2zwvYYdjlT5AB4QeYL0rIdJSQ=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZIP7E8W_1726237306)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 22:21:46 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 3/3] um: Fix the definition for physmem_size
Date: Fri, 13 Sep 2024 22:21:37 +0800
Message-Id: <20240913142137.248245-4-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913142137.248245-1-tiwei.btw@antgroup.com>
References: <20240913142137.248245-1-tiwei.btw@antgroup.com>
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
index cc5238c1bf1e..cee3d09ba429 100644
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


