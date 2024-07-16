Return-Path: <linux-kernel+bounces-253295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A8B931F2C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435FF281BBD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D929F17BD2;
	Tue, 16 Jul 2024 03:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ues8khed"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C023111711
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 03:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721099512; cv=none; b=b+2th1oAcoEzqQnOFvWY+5VERlXeYXa0hgMFdvFF4i2pc9fo0acOcxT8lfNCeAmkOCGbp55Q6ZTHlUuJ6gwVyWP/ecZPc43f5brwbj8YyGy4Vg2O1RhMtoOsaSySkXe31s1GyGitkHwxkiwFTOZMZZzhVtHi0qvYMbMCfC9G2+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721099512; c=relaxed/simple;
	bh=LnBS3o8J0dIInBfgM5JVOMuusXCvnyzC5LzWqp6aq84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=goT9tVVQYx1bgrTeqZs1hb7LH3aq0pB6joA49qDcujfOql0/0SBqBLXdteewgRzblPzFZ/KuayMRIixce3nM9h7PFAjPKT26PxDZMQet0w7fFT28MbH+84LuulYUQ6VaOqrr1IxnYeBJR7gyqaxVa2zAflBvOWBsJGNFu8SKtWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ues8khed; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EF0C03FE4E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 03:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1721099507;
	bh=wYKfkQhlmAQpjsnay3TVuvCtalPKMOXrFYtZFkyFmGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=ues8khed7DBEGooUXqByU1E4vhLsEu0ZmmpKCSCYe7cevTqE+vK3JrMnbi/fhtSSa
	 SeZF+beM5jJkbtPLdFZzcVr2coem0H8vSxrukcJnPX1wtzKOhznwCj/C5Zca8HkULC
	 BrYtHKuxYvu/64Oq4gF1UHLDfJIhGz/oWgiobTsXwkOxwmru4sVfUB8BZBgpg7Nv5F
	 4NaZuO1QqGAWSUKvXAsqFdCFkafZ/WQVuDpEvHfPpaPwcS8i+ZglIL6BxDWEmSsKCR
	 ADmdrU/cXOxks1vvUc5QpTTGKDt6jBOJMyWqTuU4nBi91270mAainYmPmLmOTZIvw0
	 obQAemxuEmjBw==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-70b06b3439fso3034585b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 20:11:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721099506; x=1721704306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYKfkQhlmAQpjsnay3TVuvCtalPKMOXrFYtZFkyFmGI=;
        b=cS1l/YZ70Gib2iNwL/fzWfckdx6p59mJYeUOflttI3052UQJFYvlgY0p7odUTIeLbr
         XPsITrvPHT0fSzy/SmXwcgdzBYF8fHUXL5+aDrLlp0d7HkdR5z7etgNj2W7tHaV0h/L1
         DqdS95cUL/jlaG5XI9d2QgGVDDdB0dVodTWWIAok18X0j1Dc3l5mprav2+3IFbXnZPwd
         EeEhF10qXHfz0FHwQ0wcRZrSrgQLVGJQN73o9Hph/dUVLSP6Ir26QrH8FK+o2/3SKRbT
         UviNuAnQJQhFBb8M2qgvo2fLDcF95D7fUJ6eVTfzH2PGTTruvskA9e3fhfxhdY4hIITk
         e46g==
X-Forwarded-Encrypted: i=1; AJvYcCVUhqgsKchqGILvRRmxvVLJ3691yI1A7RSGs+Y3t98icqjYfEoRdg8jwm9dUec5jIDJ4RmpAsyVpJkCihxyIs1/0jmZ+1ZXxTg8HW/G
X-Gm-Message-State: AOJu0Yx4gdkbD3m8zp4bX6H/LT58y/osUdk2dvipFMfM/8r3Pc/tix5E
	IfyB1BSh7vwq8ONSQGADSUw6+2GOwKYagnhaIFLom7FUFyF0kIoLhw9oTs+12Iv+yS0Od7hcrqP
	SjHg2u1oMSjzBS+rLg+GUi/z+cWt4ZZgm+KX1gIEV6b1TpnD5IXbZy4fuAPTWJiZbfJOzha5Ao8
	c0H5t/zze6wg==
X-Received: by 2002:a05:6a00:cc7:b0:708:10:f42d with SMTP id d2e1a72fcca58-70c1fbb989cmr1131459b3a.14.1721099506036;
        Mon, 15 Jul 2024 20:11:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTmDlys/y4islF7hIuFItEmfYjirTiQvrB84pSb8fSZuLGYaiUT/OT9S1FsLtrLRREcLAJ7Q==
X-Received: by 2002:a05:6a00:cc7:b0:708:10:f42d with SMTP id d2e1a72fcca58-70c1fbb989cmr1131443b3a.14.1721099505633;
        Mon, 15 Jul 2024 20:11:45 -0700 (PDT)
Received: from kylee-ThinkPad-E16-Gen-1.. ([122.147.171.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eb9c861sm5114218b3a.24.2024.07.15.20.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 20:11:45 -0700 (PDT)
From: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
To: kuan-ying.lee@canonical.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] scripts/gdb: Add 'lx-kasan_mem_to_shadow' command
Date: Tue, 16 Jul 2024 11:11:10 +0800
Message-Id: <20240716031110.17609-3-kuan-ying.lee@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716031110.17609-2-kuan-ying.lee@canonical.com>
References: <20240716031110.17609-2-kuan-ying.lee@canonical.com>
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


