Return-Path: <linux-kernel+bounces-253294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D09D931F2B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27081F21EC3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2B313FF9;
	Tue, 16 Jul 2024 03:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="AwxwFe8h"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FF9C8E1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 03:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721099510; cv=none; b=nSNjZ39f1QzzcVCXIfyt3jQZ9o16zHW5L2iuaLsEevYsTMK5v5PvFlFw4yING1pmNVnmCtiMGlnZyNvLrkqKlWZL5zjVjVY6hadmNQxxmn2K8a2n0/l8lXI2beyOxHSi+FyZd9jIqSLTuYJWltKKk7EYyQOcxrmP6CE34Rw1N90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721099510; c=relaxed/simple;
	bh=2ClJSGpQlOfadgc5A4aHxtJcDdzYIw2wdmVA6IeimOI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HBF2huZFToKlKIGd7f9F/aV734mIiynTqYp0uBrgfJldw7sVuOCIzlvlEPUN/oKCVoVSUt1ZJnlyIWQWUf1z4l/VAiPxd5FOVEZVCM6MxrujapE5FH2zOwjhYIZvmDW5DaZQWzp+d4hZ8pCwcghbHGKFL/921d0mOXGzJkEmYzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=AwxwFe8h; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BE5E53F298
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 03:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1721099504;
	bh=p8WnU9klM9imNroT/ir5Cxun9HbZF+Zv15lDq/QcnHE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=AwxwFe8hIGxm6ZI8bcZ33QMGbq5Zi+vkIHgEn7po9KLlUgunhzg8s/htZCHJavgA+
	 avbxCUfjZXQg8vtqcOtePNg01rHNDy2bgJPaZm0l+GjjYqSYTNqFBW1rVsgUv6yCYQ
	 4npEuHNqgJNXBH0nOFS94u/4N0QJhoSQVgwBdEhwEHuex5lVCERwjqJ1I/L32dDr3E
	 a44NMv0PX9KZGmm0eWcPrGNm8/mQ+oR+MkFKRU7NAgVBuvPEVSvGUJprHr4s9aeK3a
	 qUc4Fa4/xH1Jk/jQ1hfbIITAznirEQIg9j/mjw0E2/OpmVOqf24wJnNHTMqtBnY2z3
	 yS/Mmnxlkbr6w==
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3d93adfd9f1so1067428b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 20:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721099503; x=1721704303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p8WnU9klM9imNroT/ir5Cxun9HbZF+Zv15lDq/QcnHE=;
        b=kafYUwEoREHY4Ue5C356EX+MFpV0ZBZ7FuZDypVpsa1uMsHpS+yb9e1AK2VsJsp6Mx
         2/QzAVBg2YNC3XPLnvfmlf3/qEtT9Fxeu/47ykE4iWwtIXKMC19pxv8zujSQD/Bzj+10
         2Rbb5XDJMYF+HAzgB/oiK21GjkHo8xxvQGchG6TEocp5SKIaXWt0uHLn5VpeY26+Dw5l
         bvfVWxCf653Hh+vn5xBuchIBtYJRRkmzJFMpQfnT1Lm5TCFbZsF7dDJ6v0tLxMkLYKlt
         UM/zu3TK9/Q+FBIMZf0e6uetyO67Jqc+VwD8Oi9eaGYblAS9XzzJDWCr1LYoMGrHxmsV
         78Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVe0KCvK1ekAeObbPKoOM53fEsif6buI/g50EJaEmbx//Hcj156fvGmrT6H240NE+cXtsIfzyFajUequP/Ad+ev1zwDIcOSvRrA0L6i
X-Gm-Message-State: AOJu0YyB42uhnUbF4cGsQ7FECL34h+t3vYwf0dItbJIZv27VfWuzWO18
	RQavD8jTDVKcd42XgIknf/amxWShUPuPR8EFOhjA3zwlXnT/H4l+FZvb++VhyZ6X3HzvObsREfz
	s88YNYpsAAxrgqbxOaxzqHKawB/yYYXcunay6do3r8SEkchIm70yO+fnjJ/zHcIBZ8iKpg6dn/b
	JIUg==
X-Received: by 2002:a05:6808:17a2:b0:3d9:dabc:7b8c with SMTP id 5614622812f47-3dac7bb83cfmr1135277b6e.29.1721099503607;
        Mon, 15 Jul 2024 20:11:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHowPgA+IiXr3y5Go99oz/oxKjZGD2rxznC7h39UKLaYhioEGurvdSOJrv7x0YiqWmiYI5Dww==
X-Received: by 2002:a05:6808:17a2:b0:3d9:dabc:7b8c with SMTP id 5614622812f47-3dac7bb83cfmr1135252b6e.29.1721099503237;
        Mon, 15 Jul 2024 20:11:43 -0700 (PDT)
Received: from kylee-ThinkPad-E16-Gen-1.. ([122.147.171.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eb9c861sm5114218b3a.24.2024.07.15.20.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 20:11:42 -0700 (PDT)
From: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
To: kuan-ying.lee@canonical.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] scripts/gdb: Add 'lx-stack_depot_lookup' command.
Date: Tue, 16 Jul 2024 11:11:09 +0800
Message-Id: <20240716031110.17609-2-kuan-ying.lee@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This command allows users to quickly retrieve a stacktrace
using a handle obtained from a memory coredump.

Example output:
(gdb) lx-stack_depot_lookup 0x00c80300
   0xffff8000807965b4 <kmem_cache_alloc_noprof+660>:    mov     x20, x0
   0xffff800081a077d8 <kmem_cache_oob_alloc+76>:        mov     x1, x0
   0xffff800081a079a0 <test_version_show+100>:  cbnz    w0, 0xffff800081a07968 <test_version_show+44>
   0xffff800082f4a3fc <kobj_attr_show+60>:      ldr     x19, [sp, #16]
   0xffff800080a0fb34 <sysfs_kf_seq_show+460>:  ldp     x3, x4, [sp, #96]
   0xffff800080a0a550 <kernfs_seq_show+296>:    ldp     x19, x20, [sp, #16]
   0xffff8000808e7b40 <seq_read_iter+836>:      mov     w5, w0
   0xffff800080a0b8ac <kernfs_fop_read_iter+804>:       mov     x23, x0
   0xffff800080914a48 <copy_splice_read+972>:   mov     x6, x0
   0xffff8000809151c4 <do_splice_read+348>:     ldr     x21, [sp, #32]

Signed-off-by: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
---
 scripts/gdb/linux/stackdepot.py | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/scripts/gdb/linux/stackdepot.py b/scripts/gdb/linux/stackdepot.py
index bb3a0f843931..37313a5a51a0 100644
--- a/scripts/gdb/linux/stackdepot.py
+++ b/scripts/gdb/linux/stackdepot.py
@@ -13,6 +13,13 @@ if constants.LX_CONFIG_STACKDEPOT:
     stack_record_type = utils.CachedType('struct stack_record')
     DEPOT_STACK_ALIGN = 4
 
+def help():
+    t = """Usage: lx-stack_depot_lookup [Hex handle value]
+    Example:
+        lx-stack_depot_lookup 0x00c80300\n"""
+    gdb.write("Unrecognized command\n")
+    raise gdb.GdbError(t)
+
 def stack_depot_fetch(handle):
     global DEPOT_STACK_ALIGN
     global stack_record_type
@@ -57,3 +64,23 @@ def stack_depot_print(handle):
                 gdb.execute("x /i 0x%x" % (int(entries[i])))
             except Exception as e:
                 gdb.write("%s\n" % e)
+
+class StackDepotLookup(gdb.Command):
+    """Search backtrace by handle"""
+
+    def __init__(self):
+        if constants.LX_CONFIG_STACKDEPOT:
+            super(StackDepotLookup, self).__init__("lx-stack_depot_lookup", gdb.COMMAND_SUPPORT)
+
+    def invoke(self, args, from_tty):
+        if not constants.LX_CONFIG_STACKDEPOT:
+            raise gdb.GdbError('CONFIG_STACKDEPOT is not set')
+
+        argv = gdb.string_to_argv(args)
+        if len(argv) == 1:
+            handle = int(argv[0], 16)
+            stack_depot_print(gdb.Value(handle).cast(utils.get_uint_type()))
+        else:
+            help()
+
+StackDepotLookup()
-- 
2.34.1


