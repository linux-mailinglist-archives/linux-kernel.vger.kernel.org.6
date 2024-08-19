Return-Path: <linux-kernel+bounces-291963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB8F956968
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E8841C2191A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9D2166F07;
	Mon, 19 Aug 2024 11:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ia3lvB6G"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EC115DBB2
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724067390; cv=none; b=Cv5qDtlktIs3mJpdx59eb2kYJkBgd388Zw1mr2hYySwDBuQ8L/435uKX2glDOb+6FbFw4AqXd/AKpm4IFZ1yLt2CK9hSRTuvOsseztBwJDgQIum8a8JkBL0fMeHDZNdV6fwLT/5cPqv0U8DAWUMQ8Tw4L/Vyl4wK8FkBPE+PFFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724067390; c=relaxed/simple;
	bh=NRN89sayifMoy1kilIGDYtPCK1wF4xGXEZA5elSPLlc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nn28VlJ8XqZ0juYdse840fgR1n/93XnoTJ3k7ywUjOjq86Q3tCQrAEDcl0JZiJG7oaGsZn72aAnzpvy07WK7Kgo6+3Xhkopi7LQahw/hMbqYdTtp4whAPy3zSOCI+CZYFUELur/xDsi0AuLuQ9FPyQYEcrk6TYFN1Bxa6cfHxmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ia3lvB6G; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2021c03c13aso11387125ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 04:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724067389; x=1724672189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+WiREMffi25nyyIzqdE8W4yA++e1IQrLgdZzBEOgG4c=;
        b=Ia3lvB6GUA/jNoqumGqQamG+JSAgGrpmyKvyBPecYa34u7gKi0+Yg1MDmFXxJzZKqQ
         /pOQhY2S40pP2WpcRCMmpYOw6Tk3sttyI6OjhGD/P+RAE6KcNFPN4coVDA0GcgzWGiUd
         IVpp08w1FKEogmXrhFjb8A6h0ACLy+pLBO8EpjmO2kB4VEh6NAT6rshJm+t+HuTiiWnd
         nB3KaGkoUtu3zbzyFHwNS3E8ITmfKZ6L8RojBd9ZQHHbiYeWezkiN+g8/5V4eKymrPxH
         5QJWKl2+5ZMOibhL7lFGmKBj+4XsoHxikSV9kMWfso4WH8Gpa7Q6WOv6cOkVD2iWMY83
         dqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724067389; x=1724672189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+WiREMffi25nyyIzqdE8W4yA++e1IQrLgdZzBEOgG4c=;
        b=gBn3RTF6YlzNQjvnd9a0MOHwe0ltqmshE2YgnQs+qUNqp3m7vu0XQEJ6IMxju043V/
         O1KTCmX5sqJ4NwGMX44GLalw+lhNetDdtcF1Bz7jb6S3I/EbJvAS4vqI0RSGNJOdFijM
         MhbDQBdOpJArrlz5znxR0Se9f1IDqRSoOxY5bRI2BjMRd+nuLQQ/XQ71lCmdikEDcN2/
         W4oN+B2gU3e0QkCykIEVXW+CoG0oYvk226GfmDratfXx1cKdkXKYb8p8SGbhoOZhBbNv
         Jy3xkxfeoUAChu3c8E6vrFoyWxlP6866xcPLqyz7KIE8Qeq2ouozPw3KM24oVAgJRncx
         R5nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAEpjXPwKylyElUmDnJo9R7/V+RA9fZny/ZdT+fCeyYAuWMGCq+2u0CiV2YJcuyhjsZhUFGYEREOXjr2Vj7AJmRX9pNrIDRotNC0I2
X-Gm-Message-State: AOJu0Ywq3QTMTGIGf3kXTewPjIATby3qMn5zh0I/FZBQ+9Mz2xxoYP2+
	/QxJFeG3A0o9lGh3ZwQBHbrqEQzitSIu6WxrMaslrvTxUSiyga29uWqJshUF/Ds=
X-Google-Smtp-Source: AGHT+IHGh02cvfBz2W5qfnXKONV2HpC6aEUYbSAynA7KDT1UIEitJ0Iyq8mXZoWh7adSZXcMLQbKYg==
X-Received: by 2002:a17:903:35c4:b0:201:eb46:1be5 with SMTP id d9443c01a7336-20206162588mr139288285ad.3.1724067388543;
        Mon, 19 Aug 2024 04:36:28 -0700 (PDT)
Received: from vernon-pc.. ([121.232.96.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0319683sm61362135ad.67.2024.08.19.04.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 04:36:27 -0700 (PDT)
From: Vernon Yang <vernon2gm@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Vernon Yang <vernon2gm@gmail.com>
Subject: [PATCH] mm/util: Fix meminfo CommitLimit
Date: Mon, 19 Aug 2024 19:36:19 +0800
Message-Id: <20240819113619.1267937-1-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a machine with 8GB memory, no any swap device, the /proc/meminfo
CommitLimit shows 4070944KB regardless of overcommit_memory being set to
0/1/2. This patch fixes this bug, and the final effect is as follows:

- when overcommit_memory being set to 0  ## OVERCOMMIT_GUESS
CommitLimit:     8141884 kB
- when overcommit_memory being set to 1  ## OVERCOMMIT_ALWAYS
CommitLimit:           0 kB
- when overcommit_memory being set to 2  ## OVERCOMMIT_NEVER
  and overcommit_ratio 50
CommitLimit:     4070940 kB

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
---
 mm/util.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index bd283e2132e0..4ee93c11dd62 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -932,12 +932,21 @@ int overcommit_kbytes_handler(const struct ctl_table *table, int write, void *bu
 }
 
 /*
- * Committed memory limit enforced when OVERCOMMIT_NEVER policy is used
+ * Committed virtual memory limit
+ *
+ * return 0 if OVERCOMMIT_ALWAYS policy is used, otherwise return committed
+ * memory limit enforced if OVERCOMMIT_GUESS or OVERCOMMIT_NEVER policy is used.
  */
 unsigned long vm_commit_limit(void)
 {
 	unsigned long allowed;
 
+	if (sysctl_overcommit_memory == OVERCOMMIT_ALWAYS)
+		return 0;
+
+	if (sysctl_overcommit_memory == OVERCOMMIT_GUESS)
+		return totalram_pages() + total_swap_pages;
+
 	if (sysctl_overcommit_kbytes)
 		allowed = sysctl_overcommit_kbytes >> (PAGE_SHIFT - 10);
 	else

base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
-- 
2.34.1


