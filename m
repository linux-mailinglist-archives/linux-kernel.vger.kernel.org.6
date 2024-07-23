Return-Path: <linux-kernel+bounces-259670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC8D939B27
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13D71C21C97
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 06:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF8F14EC53;
	Tue, 23 Jul 2024 06:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="FwKl7jyR"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1259214D2B2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717387; cv=none; b=aDeGxVbUGO3uIk7DimEFI7OAMgiHo0jAa1lFpXyabpLXodUO8OuLgsnuno8q5WUZ5+G1rwiG6vLMD8CM+74JZwUJymWH6h8g+/AWCAuL+t4D3eJ/bGwYjwd6acS2faKVgGQ5Q7msEaZeB3g0iYOshAIviKQ9DcYGYUIylfz5VK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717387; c=relaxed/simple;
	bh=LnBS3o8J0dIInBfgM5JVOMuusXCvnyzC5LzWqp6aq84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eICBQw/O1cF6TvkNS7y8mRuuUE59zMX0SPQAHi8HsKFNboKQWNxVlGdA7fDtGeinGQGjt7/+J/6I6eFiy9TmwGpbQziVW2x2NRgaDIXw63/pOnE6R9BaSsqwoREMlpx6mevjsEXKedg8NArJ+4S1x448BjrmvvS0lC77XFq48eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=FwKl7jyR; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A5C1941081
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1721717384;
	bh=wYKfkQhlmAQpjsnay3TVuvCtalPKMOXrFYtZFkyFmGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=FwKl7jyRzm7UKftIBxpkcHEbgYH80l0/JvuQYFQsn3Xw5nrvfTFaKEk1xz4vrZnUX
	 CqhjnzQ4kXWzm+3KqyyuwASP9n0D24CdzLN2CmmyD8zSSijl4RkBo4rUocuOU9/VIs
	 6xuLLR1yV21JmO3ag6E6sBQZnCuwohzk9dcos16w55op6SD/7kT1Kye/omiU0GTuUC
	 XDXco/Zn5W4hseK4hsOOfrUsRyR8GGW4vFFGQX5lcRHk1pXmWKtziUW4/Q24HhW8mi
	 RraxdFzKSUZ5LiK0e8ZrYvREKa2io7CovGzA7YlDw2A2A610ZCc/gdn/giafiIpqjl
	 vXxtssL2WiMCA==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2cb512196c1so4686006a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 23:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721717383; x=1722322183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYKfkQhlmAQpjsnay3TVuvCtalPKMOXrFYtZFkyFmGI=;
        b=CuXMBPD6JBY5uSZ8gve7jQHDWNbbk0lUqS2MuwX4TvbDXsh3NSVMNR1+Aj53jAls5G
         +1OMGOUEORdInaoMNBFFxWOmCAdv7xoSiC4RG75vRr9NPE9j9dsxcszxOitxyDR9nDyz
         3RdfHH4jE2QBdVRA/9PH0mHjVs+vE+h5q/PgEFq91rR9KWKDF6LDTOUKp2zv6MXEFx36
         hwdYCWrNQRRcUb/dSRajSJcCGOLMCOUB+FN0RYol1D44CcOE+q3K94fsIa+MpdUWNWX5
         wPUjxBePov2hpoW5UgI294sRff1qB0p9VpZ2T4puUnXyuXMsvtRejYRhgBkJTME9Pvmq
         Z5Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVM3JoQHZ5sfFZN/+O9PEtXO0KZ8NLzcNbtOSALw4OvSHenppyW4FfT8s6JAL4ABmD4yih3a7FlyL/B/9mrAVkUKS3FSjF3KMxJFqtT
X-Gm-Message-State: AOJu0YwxlUa3bRUEDMIFL3hsN7uX1pYVcXEJhx8356mLxdz79XWRndGS
	VyLXXrKW6GzmL5IIYRehsIX2da1oozWYqHKe554/9Ao5XGgyFHmFXAschullr3sJ4AVsDv3c/8R
	jwV8OcsSk+G4LNhcg/kw3n9Qn06lXuwRPDaaEKY+q7Gco8+hF85zkJ0gdyt35L/STbMDI8d9Pae
	BqmA==
X-Received: by 2002:a17:90a:e501:b0:2cd:1e60:9c31 with SMTP id 98e67ed59e1d1-2cd1e609c71mr5483418a91.30.1721717383184;
        Mon, 22 Jul 2024 23:49:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFl31sX6VxPv7cHZhXyRmzKNIeGHs2Q9sPpSI1pZKYGAWsC+89F8KKIt8KWDuUcYG9dGvD/Q==
X-Received: by 2002:a17:90a:e501:b0:2cd:1e60:9c31 with SMTP id 98e67ed59e1d1-2cd1e609c71mr5483405a91.30.1721717382832;
        Mon, 22 Jul 2024 23:49:42 -0700 (PDT)
Received: from kylee-ThinkPad-E16-Gen-1.. ([122.147.171.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf7c5391bsm8354749a91.24.2024.07.22.23.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 23:49:42 -0700 (PDT)
From: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
To: kuan-ying.lee@canonical.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] scripts/gdb: Add 'lx-kasan_mem_to_shadow' command
Date: Tue, 23 Jul 2024 14:49:01 +0800
Message-Id: <20240723064902.124154-6-kuan-ying.lee@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240723064902.124154-1-kuan-ying.lee@canonical.com>
References: <20240723064902.124154-1-kuan-ying.lee@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This command allows users to quickly translate memory address
to the kasan shadow memory address.

Example output:
(gdb) lx-kasan_mem_to_shadow 0xffff000019acc008
shadow addr: 0xffff600003359801

Signed-off-by: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
---
 scripts/gdb/linux/kasan.py | 44 ++++++++++++++++++++++++++++++++++++++
 scripts/gdb/vmlinux-gdb.py |  1 +
 2 files changed, 45 insertions(+)
 create mode 100644 scripts/gdb/linux/kasan.py

diff --git a/scripts/gdb/linux/kasan.py b/scripts/gdb/linux/kasan.py
new file mode 100644
index 000000000000..56730b3fde0b
--- /dev/null
+++ b/scripts/gdb/linux/kasan.py
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright 2024 Canonical Ltd.
+#
+# Authors:
+#  Kuan-Ying Lee <kuan-ying.lee@canonical.com>
+#
+
+import gdb
+from linux import constants, mm
+
+def help():
+    t = """Usage: lx-kasan_mem_to_shadow [Hex memory addr]
+    Example:
+        lx-kasan_mem_to_shadow 0xffff000008eca008\n"""
+    gdb.write("Unrecognized command\n")
+    raise gdb.GdbError(t)
+
+class KasanMemToShadow(gdb.Command):
+    """Translate memory address to kasan shadow address"""
+
+    p_ops = None
+
+    def __init__(self):
+        if constants.LX_CONFIG_KASAN_GENERIC or constants.LX_CONFIG_KASAN_SW_TAGS:
+            super(KasanMemToShadow, self).__init__("lx-kasan_mem_to_shadow", gdb.COMMAND_SUPPORT)
+
+    def invoke(self, args, from_tty):
+        if not constants.LX_CONFIG_KASAN_GENERIC or constants.LX_CONFIG_KASAN_SW_TAGS:
+            raise gdb.GdbError('CONFIG_KASAN_GENERIC or CONFIG_KASAN_SW_TAGS is not set')
+
+        argv = gdb.string_to_argv(args)
+        if len(argv) == 1:
+            if self.p_ops is None:
+                self.p_ops = mm.page_ops().ops
+            addr = int(argv[0], 16)
+            shadow_addr = self.kasan_mem_to_shadow(addr)
+            gdb.write('shadow addr: 0x%x\n' % shadow_addr)
+        else:
+            help()
+    def kasan_mem_to_shadow(self, addr):
+        return (addr >> self.p_ops.KASAN_SHADOW_SCALE_SHIFT) + self.p_ops.KASAN_SHADOW_OFFSET
+
+KasanMemToShadow()
diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
index fc53cdf286f1..d4eeed4506fd 100644
--- a/scripts/gdb/vmlinux-gdb.py
+++ b/scripts/gdb/vmlinux-gdb.py
@@ -49,3 +49,4 @@ else:
     import linux.page_owner
     import linux.slab
     import linux.vmalloc
+    import linux.kasan
-- 
2.34.1


