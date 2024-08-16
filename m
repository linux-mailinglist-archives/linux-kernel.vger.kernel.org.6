Return-Path: <linux-kernel+bounces-288844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F7E953F65
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 04:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5751F25322
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F2D7407A;
	Fri, 16 Aug 2024 02:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="acSMy4ki"
Received: from out0-216.mail.aliyun.com (out0-216.mail.aliyun.com [140.205.0.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5032BB0D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723774236; cv=none; b=oeX3P4oDYi6i+9fa+oVhg+tHDvsHZin4pojbgjDlcK1rJRxq2KzJKZPNWA9dojvjg+FVlvgy/sG8TAavDy/1hYxX7G8T2HA7wV9ZBt8zJuhzqZACjRHx2XV36ihlKbYuvjWkGVWX5YuUgx73vrmh/WeBCk4mGnG9JpqeX52IwxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723774236; c=relaxed/simple;
	bh=SWpKeh7MbepZmFz4/Z15Hq6trYkAJkpcDXccW0JFLqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uqN/X3Nuid0kP3Z/zk3p1jOtt88VDFgCzd6LID6C0X0P5GJ8cQD/Q+fkALrgH3UtZ+TO6xN9juDv6x4sApoJ3vRDLxBZkDxw6QY7hGOxW+x+vQF7Gb5G9nrZRof41AfvQWGk9ayWIVDcxF8VUImfCTuyf8Kk4nQ+NH5rjx3ywto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=acSMy4ki; arc=none smtp.client-ip=140.205.0.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1723774229; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Nrudy3y11XA7JWBXeZ+LwBKZ+ByI+KD/BZ+2ukqvBAE=;
	b=acSMy4kis823snoVp19muFTx0jjxbv6ZgsWgqTnAhgrG6G31ahmQUalWvxH7IPKzLRij41f3nQ8m5bw5sPKpWF3a5S0EcExqRV/RIjYLNG2rSulRPrFaXwxyWBFxZocRaLzD4AcC3xZ5zrkqyaKfwzhTQNwfhAzkPTjHumwkPQ4=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.YtEBojj_1723773296)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 09:54:56 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 3/6] um: Remove unused fields from thread_struct
Date: Fri, 16 Aug 2024 09:54:44 +0800
Message-Id: <20240816015447.320394-4-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816015447.320394-1-tiwei.btw@antgroup.com>
References: <20240816015447.320394-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These fields are no longer used since the removal of tt mode.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/processor-generic.h | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index 5a7c05275aa7..864389ee29f6 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -28,19 +28,11 @@ struct thread_struct {
 	struct arch_thread arch;
 	jmp_buf switch_buf;
 	struct {
-		int op;
 		union {
-			struct {
-				int pid;
-			} fork, exec;
 			struct {
 				int (*proc)(void *);
 				void *arg;
 			} thread;
-			struct {
-				void (*proc)(void *);
-				void *arg;
-			} cb;
 		} u;
 	} request;
 };
@@ -51,7 +43,7 @@ struct thread_struct {
 	.fault_addr		= NULL, \
 	.prev_sched		= NULL, \
 	.arch			= INIT_ARCH_THREAD, \
-	.request		= { 0 } \
+	.request		= { } \
 }
 
 /*
-- 
2.34.1


