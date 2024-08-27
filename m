Return-Path: <linux-kernel+bounces-303021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D025960644
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 502902869EE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666B182D91;
	Tue, 27 Aug 2024 09:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ma1Z/eHO"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8CF19CCE8
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752381; cv=none; b=hwiPB38EHUxFfRps5m36jvm6Iaoz0NNqYCPpAlBiCtRzYBuHiJcFujAwwIzdf4s+rRPqqzwj7lqzZvqfjWKgo7AbmzxZGQD0SN6K7m1fVnTOfv+JP9Kjw4tas160+cnIzfYvOleA/dIJw6XEFf8gDWIMdfi2jDP+vMqkpAjigwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752381; c=relaxed/simple;
	bh=nmyAnaR2DpkTGwl5Q+iWox+i7eb/vCYhfXq0jaNcKks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W5PX4eMW7BEqRrHjUzLNBBexeS4v21abBxczWq/tmbJGrF2SwOYhS315fjzCFyx9Rnje5o09RYWoC3E5IeWFu7tGhA+xe3StiEql/RcyJCAc+yZsahEOMDKbR1wrGtvGAl+sq0aqW5lfo+rBubtLQhbiZzgZxjHJZxgSHXaT8wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ma1Z/eHO; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724752370; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=c4Pz7uo16XtHsW53e3gFxPfdxVdnSisKCshLJLSCjFc=;
	b=Ma1Z/eHOyYWS3vXp6H0OSU7DlCNE6yF1yL7Om+XUHysl3UyPwXAgQ+LUcnabepRg1cKihewfp4bkO6wLgJddcb/ZOp19p80L52WhSSoBq/iTwdxHw5tTIVPSSUC+ri48dhgBJBnSotDYxQhCIyh9nxhGfqYVk+UJdSRb61iSk90=
Received: from localhost.localdomain(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0WDm4PPo_1724752357)
          by smtp.aliyun-inc.com;
          Tue, 27 Aug 2024 17:52:49 +0800
From: Xianting Tian <xianting.tian@linux.alibaba.com>
To: kees@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	tianxianting.txt@alibaba-inc.com,
	Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH] lkdtm: mark lkdtm_kprobe_handler for kprobe unavailable
Date: Tue, 27 Aug 2024 17:52:35 +0800
Message-ID: <20240827095235.12039-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 drivers/misc/lkdtm/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 5732fd59a227..90e1eb253bd8 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -223,6 +223,7 @@ static int lkdtm_kprobe_handler(struct kprobe *kp, struct pt_regs *regs)
 
 	return 0;
 }
+NOKPROBE_SYMBOL(lkdtm_kprobe_handler)
 
 static ssize_t lkdtm_debugfs_entry(struct file *f,
 				   const char __user *user_buf,
-- 
2.43.5


