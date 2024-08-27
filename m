Return-Path: <linux-kernel+bounces-303250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC209609B0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390621F240B1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016461A071C;
	Tue, 27 Aug 2024 12:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gh8hjlzr"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BB01A00E7
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760487; cv=none; b=kAFaL2VKRbTj74hV4cEvmZBdaNhjrGh+jv47Wmd9+cCkHSvENvKPwuiotustI3Mhs3uYb5Mw/H8r6icuQlxJmcTBPKqTgTijRKVG9Zc5rIMXAOkPpbAsngf9REbkKimPQUuEG+DCjINgKbRzkwZRRLImF7diRZecQHcNtSio/c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760487; c=relaxed/simple;
	bh=6M+nHmI/jR+6rnNWnqux2kfj/LQJv0vxMYYl4v4VyMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kdcYCzlFy4PqrdU2uHYktEP5Im6vfwv80Q+K4riZPQxcUGqjVkmmrxfSLLgLKM6NnVxA4kWbOuDnL8/j6uaraOUmeXDTFdey9qz/j6CYA3dHqRCkyP4UlhjVRnS9lvFXPVlqcymUfnsKxc/RzhwLuQvxNPcw3zHjlwSfmRV4GxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gh8hjlzr; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724760481; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=q2tlarXIgLt6OrJjsD4q51knjwb30u9WluJeiZLGIWI=;
	b=gh8hjlzrdXVHNDgDSsZXbLStZbE0kppJQzCfhdEUBz26UnT99sLq5w+aaf+J+bzbruYXOZdEJpXPTICUU+gmCyzuDaO9ASOGw4nt+2DGzxVOFGZUxRHS30Dh5G2smN77OCmmqXfiM9V1glbiOW1nCaAWvhI307EtZymBz7kS9VI=
Received: from localhost.localdomain(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0WDmZ2g6_1724760458)
          by smtp.aliyun-inc.com;
          Tue, 27 Aug 2024 20:08:01 +0800
From: Xianting Tian <xianting.tian@linux.alibaba.com>
To: kees@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	tianxianting.txt@alibaba-inc.com,
	Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH v2] lkdtm: mark lkdtm_kprobe_handler for kprobe unavailable
Date: Tue, 27 Aug 2024 20:07:36 +0800
Message-ID: <20240827120736.32434-1-xianting.tian@linux.alibaba.com>
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
index 5732fd59a227..b32b18f498ea 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -223,6 +223,7 @@ static int lkdtm_kprobe_handler(struct kprobe *kp, struct pt_regs *regs)
 
 	return 0;
 }
+NOKPROBE_SYMBOL(lkdtm_kprobe_handler);
 
 static ssize_t lkdtm_debugfs_entry(struct file *f,
 				   const char __user *user_buf,
-- 
2.43.5


