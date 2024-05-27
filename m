Return-Path: <linux-kernel+bounces-190743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B71B28D0229
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDBF8B2C567
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C891F15F3F2;
	Mon, 27 May 2024 13:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="0PU3lNHz"
Received: from out0-198.mail.aliyun.com (out0-198.mail.aliyun.com [140.205.0.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF46513BAC2
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716817251; cv=none; b=StR/bDcBuRedcvxM2FDGQb4rvj4cc7/rpUMcLLn6HBDyKcIYBZnZ6Sqr9OnNogcTNzvVxs20acsCbcXBgbdQvd2U0mXsSAtlwzevTQohqyI4225GRka99fzMdsoUo/91ssyu0Vof0eNiSM7US9OGfTfZXtHzOvEZuW7cS8Moc7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716817251; c=relaxed/simple;
	bh=QKpX0bSGLsdAjVTG0scQJ+FLSyArjYLDTHJbZunjSH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ILQaTyOtjfKxXgseSADtWy2bVm/iH6437QavbTnCUieqZtWAEkIKxIInJtTjZGN7ya3XZmw0/nzHP+ljhtnFg5leWhy9HqK1B+WiischNAngCNHleZqXRrXwQR7DIkKqboLYCN7MYml1T3lEUzYZyxE0vbiafhz3rBV1gataTo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=0PU3lNHz; arc=none smtp.client-ip=140.205.0.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1716817238; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=98TUkS0b+gRj1ZLjZVnojSNV/GxHrgmcGS9QODi+eTo=;
	b=0PU3lNHzuYsVyQkGbjR2E9UsdBnYcy103Qnc0YVkbacLCQavUKKRhad6WbQ0K2b+YcE3hP1W+vVn6nHw84+DEbFY5m5ACqQd1OS6avG1AIdxmkdrZIqqWZfkbdKGvkPKoOP930xfUqghDO56vysxvFzHOWV1ZSbr9kvFCdCzPmw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033070043001;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.XofsrHJ_1716817237;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XofsrHJ_1716817237)
          by smtp.aliyun-inc.com;
          Mon, 27 May 2024 21:40:37 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 1/2] um: Remove unused ncpus variable
Date: Mon, 27 May 2024 21:40:23 +0800
Message-Id: <20240527134024.1539848-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527134024.1539848-1-tiwei.btw@antgroup.com>
References: <20240527134024.1539848-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's no longer used. And uml_ncpus_setup doesn't exist anymore.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/shared/kern_util.h | 1 -
 arch/um/kernel/um_arch.c           | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index 95521b1f5b20..d8ffd2db168e 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -13,7 +13,6 @@ struct siginfo;
 
 extern int uml_exitcode;
 
-extern int ncpus;
 extern int kmalloc_ok;
 
 #define UML_ROUND_UP(addr) \
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index e95f805e5004..8e594cda6d77 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -126,9 +126,6 @@ unsigned long uml_reserved; /* Also modified in mem_init */
 unsigned long start_vm;
 unsigned long end_vm;
 
-/* Set in uml_ncpus_setup */
-int ncpus = 1;
-
 /* Set in early boot */
 static int have_root __initdata;
 static int have_console __initdata;
-- 
2.34.1


