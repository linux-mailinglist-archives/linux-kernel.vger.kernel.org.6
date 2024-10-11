Return-Path: <linux-kernel+bounces-360496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B4B999BB7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A352866BF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237281F4FB7;
	Fri, 11 Oct 2024 04:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="CUsYi+Uk"
Received: from out0-217.mail.aliyun.com (out0-217.mail.aliyun.com [140.205.0.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627FE1922C4
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 04:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728621352; cv=none; b=gEaROaU5W0ROvK2vpDXU98WWKG5ZPe19MYwUQwvDqDWFZ76hp9BPgXjuC85y3jktOBO+iudMtJjACqTMkXd25ZlvZN/hD4DfZZFnH8Q3hBzl+YOwbk/tMu5A0hPJWUyqk6QMG1sjZS8lEw8z8SnF++V/EZ0k8EAQe+iJqdtk/Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728621352; c=relaxed/simple;
	bh=J42O+doOhRUx/QZLvUwQVDtcDtTfzW0HZYmzwTsySnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SYt0vlSqvxmm04pSG+3ixIWn6/Mmz7xv0TdZ+h4J3Z9UiKIMXC+4NQpJ0HkXBzI7q3x9srMkH9HMc3C8NX+rBbNqHl6/kns68B4u7o2ZPt46NmeKqJ6mdPoY9dlx3M5MRQcwhIGCxAeGHJ6/FQI+gUIB1wueIVtow2bAvrKI8wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=CUsYi+Uk; arc=none smtp.client-ip=140.205.0.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728621345; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=r4f8uaoElW6Tz/MJWwXbPIXXxPfOt+tP+zCNiNmUVAs=;
	b=CUsYi+UklyUIP0M+Su34jPv53GcstmnSCbVVTgU6rhPrCGeHWyQmQz+DHvl+UoYxXg7y6cDkt8UWzao3NmRS+CnIJ9oWBctoGuxGrhPY7AAvu6pebBLpKyp68xWirzZtOLyC2wO2DS5VX0rNjN/nQq1uu3taC8eItrQDGfycpyc=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Ze33ty8_1728619494)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 12:04:54 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 2/9] um: Do not propagate mem parameter to kernel
Date: Fri, 11 Oct 2024 12:04:34 +0800
Message-Id: <20241011040441.1586345-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
References: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This parameter is UML specific and is unknown to kernel. It should not
be propagated to kernel, otherwise it will be passed to user space as
an environment option by kernel with a warning like:

Unknown kernel command line parameters "mem=2G", will be passed to user space.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/physmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index 636830fe00f2..d60df3626727 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -139,6 +139,8 @@ EXPORT_SYMBOL(phys_mapping);
 static int __init uml_mem_setup(char *line, int *add)
 {
 	char *retptr;
+
+	*add = 0;
 	physmem_size = memparse(line,&retptr);
 	return 0;
 }
-- 
2.34.1


