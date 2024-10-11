Return-Path: <linux-kernel+bounces-360470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF4B999B81
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4D41F2363B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B941B1F4FCD;
	Fri, 11 Oct 2024 04:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="FbqFCNmM"
Received: from out0-216.mail.aliyun.com (out0-216.mail.aliyun.com [140.205.0.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FC42FB2
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 04:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728619819; cv=none; b=YMt/Wuu9B5G5vxcWK4GUS2OeG0xS/CcxKVF5KC2pU0W+KfFXwNuof/OMls/UztX23tp+8oKygwhEMXUb/+nJ5RNc+ZjWRrQmME2axJ9aOXbz86ZxeaIMEyYjFCbBiDCAKQGbn+QakBn5EzCT0LySSucED9k00XRIMZs5jtEAIqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728619819; c=relaxed/simple;
	bh=LUR8oA2I+CYugPR0HaQau2Ssqs86RtunwupGj/abuuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ADkXgPPTRQCmLx681QTZ0XaBNgZlUwZWKrCQ2RqyjRlzJZ1MwPMihq6Uu86ElxkZ9Xtni4pAEKye+zW4QcbZkv+a5VvqkUXYbFZbUBCB79iVl14S5oyVzd7QlCDAp6DOlWlgRf3NTQ0P+bqWZtdcnCYmj6hk1wHcAFcXbS28qb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=FbqFCNmM; arc=none smtp.client-ip=140.205.0.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728619813; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=KsXLx7unjaR1Z1JlqwiOWIQ7xIjntSghjwdL0iHHK+U=;
	b=FbqFCNmM7Nm4OsFhS6VPgOijbnShUB2Rrs4OOLdTd/jwueMHROIJJCf03Kb8vuZLKy6MBKcVEAw0jwzAb8KgVqTgZvOmk/xZkaP7p3+gbfO3yu7RUoymN6IOv6UQ4+GjBELIr+XZetOwJHYrA1f7gK7Yp6rXkogRZsBNBHl3aZU=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Ze33tyt_1728619495)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 12:04:55 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 5/9] um: Do not propagate noreboot parameter to kernel
Date: Fri, 11 Oct 2024 12:04:37 +0800
Message-Id: <20241011040441.1586345-6-tiwei.btw@antgroup.com>
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
be propagated to kernel, otherwise it could be passed to user space as
a command line option by kernel with a warning like:

Unknown kernel command line parameters "noreboot", will be passed to user space.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/os-Linux/skas/process.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 2286486bb0f3..8b328eb9d1f7 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -622,6 +622,7 @@ static bool noreboot;
 
 static int __init noreboot_cmd_param(char *str, int *add)
 {
+	*add = 0;
 	noreboot = true;
 	return 0;
 }
-- 
2.34.1


