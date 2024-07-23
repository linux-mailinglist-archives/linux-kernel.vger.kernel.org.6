Return-Path: <linux-kernel+bounces-259669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF88939B25
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B0F1F2298A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 06:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D0A14D42C;
	Tue, 23 Jul 2024 06:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="sAaNEfTP"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D5014B972
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717385; cv=none; b=P8z7DmGZ5B1ZGQOQ3BqB08+mxFYlwTQIDnIbQQAjre5wXvZ5UdPObDiMk26qmJMyxvUJL3uYWS8hQNyW7zI2CzuyxAepmftn9RXdzWSVDnoSZDJXiMAeLqnB5BTNsdNfAbq+N6b/vhtTemeWO7kXY0aDpqNlb9YA2qD7Un/sZEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717385; c=relaxed/simple;
	bh=2ClJSGpQlOfadgc5A4aHxtJcDdzYIw2wdmVA6IeimOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ONsXPLrTR62Dmx1qJMMoVk1AD6XxArr5Hp5lbSlD11cnCN28/8EpDU1fDl6lMhjevczTD69HtfQ+0ZOU6VlrlERAcPu3XOHA4iMQgOPr3TdV0NSz6BcuHAS3XPPo9UZqtkjJBn/hn3IXu/BrhePeV3s+q4vhtgVBVP04cviuHj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=sAaNEfTP; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EA5AD401AC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1721717381;
	bh=p8WnU9klM9imNroT/ir5Cxun9HbZF+Zv15lDq/QcnHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=sAaNEfTPngXFMsXzwBKH8RlOqLk6C6WZjYnTf+8NdUhMJ2uQEiu/+ajmfmWDTu0u8
	 xAVBHrN3EMpsvLdJnwBYDKJBb7UQcCXkMPst+cIKbJHBOUNqfxxZziTTIYHdebCMqj
	 kFgPWKNUFZr8kx5Uu2fJwb/kVQ+iDSK/RtGn8MFH8015UMsK0n7RE01p/tHmHUHVl7
	 r6Bsq8clz59+i5Q3AJ8xwVTNAlfPxK8ZOqgUS3JzHhrELNFX+Ny4133PUdtdIUnwuL
	 a6BMvwE0LKFVxfeCi0buQxSXBJ0TFh2MLi6B723NEv2ACJZlREX9ctKl5MfkwTKTtW
	 Wu4LotgoJ2Mvg==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2cd3bb0a9c7so2202095a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 23:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721717380; x=1722322180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8WnU9klM9imNroT/ir5Cxun9HbZF+Zv15lDq/QcnHE=;
        b=uH9lBKsZCTPshdOrZloO/I/N/8LFkQaUkHudAqSPUMtb4rkyEYrH/VJ9XZq0rdgyqH
         va7/a4vBV/DDh8Lw00Xm6VdnMTqJg4oNxc6dq327DeZhX9pYXgIOKbIDN2w7gc4m3b0Q
         1JrtxeCHP9uuM98FT5Hts488KwMmQSsYQMJBQhN0mqKwWF7/ZGHqmjzKYZmTIOyDW9zY
         /5CtTPdFUR6i9cGqnDez0cya3maX5nplMHaYlcVvkW+F1rQ5W6vj488JP9TvfVQc7zYd
         40zNumMbmen84g528FXAk7xjZP2IrbNZwurO1YahQqjdVtp8CNuiPMyXA5AzBylVfNGC
         5R8A==
X-Forwarded-Encrypted: i=1; AJvYcCXY05JBtQsgetcOhVixJUWftfgalSIRWkG2ISKKIYkvpPaLOI7jN5EUUfDh2v8BUre1fKqsVa0OZr+nxLXP46l3JR3MTsOzRSkimWGM
X-Gm-Message-State: AOJu0YxRtsjchXCkYiNkt44+ZgH8IFr2pR3lGOoRkDezzF6mQF1PBFQ9
	4eiSfusGCl8It9CgGeNuuKs/gAr76FNYbySLifLxIH7oIXK0J7YJikCrgh4YWFXu5E4PVDXwHML
	nJPz60rqgnvoNxwzNcZ7oGDuBw25piLDkrgY80zefIW2AnHQEVOhtqp2Hh4lo8pMxnNh6+Yky3E
	DPvA==
X-Received: by 2002:a17:90a:734b:b0:2c9:90f5:cfca with SMTP id 98e67ed59e1d1-2cd274dabb9mr4925269a91.42.1721717380517;
        Mon, 22 Jul 2024 23:49:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAsMwdXkeKQBJPyfug9/lQ1wFoE87H0ZOyB6iwoKjmcAasHQ62oHoidxTUkiX05wTzPVeRCA==
X-Received: by 2002:a17:90a:734b:b0:2c9:90f5:cfca with SMTP id 98e67ed59e1d1-2cd274dabb9mr4925257a91.42.1721717380184;
        Mon, 22 Jul 2024 23:49:40 -0700 (PDT)
Received: from kylee-ThinkPad-E16-Gen-1.. ([122.147.171.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf7c5391bsm8354749a91.24.2024.07.22.23.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 23:49:40 -0700 (PDT)
From: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
To: kuan-ying.lee@canonical.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] scripts/gdb: Add 'lx-stack_depot_lookup' command.
Date: Tue, 23 Jul 2024 14:49:00 +0800
Message-Id: <20240723064902.124154-5-kuan-ying.lee@canonical.com>
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


