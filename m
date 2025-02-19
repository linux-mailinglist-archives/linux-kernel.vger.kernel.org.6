Return-Path: <linux-kernel+bounces-521931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D851A3C40D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA9777A961B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEAF1FC104;
	Wed, 19 Feb 2025 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VFqEizxP"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9CA1E885
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979634; cv=none; b=JIW7+O2Qz31wxwzPik5N3JDF+dLXpN7m5QjnUYpoqblKN9+oDTB0xUL4EawIKXfjjToU1XTOGANMouJYHK8h+NNH3r87Z+qyFA9pQJLnZu6sKHPFrQA8vppNFyy6Cvjp988onBtvilWQDmKH0gmgCI+LG69tQUNVfkUpFQ4TNXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979634; c=relaxed/simple;
	bh=lhw9iIqeY0rMUOFrAAe70oZmuW9594NHsdSt36EJT3k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iobQQwKKCFZ0XLlTValMdlKj4prQz9asav4tbhkoRNCxeFmHpmOGLPMmS67CLkXgDCRFWsOIngRKwxxLpO7sbQSrKvHnZqYVi9DTInINeYNCL7cjyQFMEta05ot+k+CT2FCTwlhEryNVgzOyERCFy5wruwuqJt0HIAZzCYnw4jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VFqEizxP; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4399a5afc72so5494435e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 07:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739979630; x=1740584430; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dsoyyheG5eYnfYlWZPRHrjZCkRWZfS8w+U1gKGkozWU=;
        b=VFqEizxPbaRIXJg5utS1tF276kmFCrx4zYU6WW8Pt/PHyAHsbnFqTM8CH5sV0KjYbN
         L8fX8ms9j0KQBfWUXZMvsGi0NpWkxA2uaBQM7DonFxfzJVukoI0UdjrHWs7cEoqEAqI/
         QjRwXG+oZR2WDZGWxT7uLg1NMDaOeLlt8gHWJLJXO9FGbWZWCgkCBnD0PJRXnj2OQo7Y
         FMKPgCSWAEovBMzsN5q968NiBnl/1MwV4GPQIHJvd7unulOFmEYEQ2X/miEE8buP/f2z
         mFd27JKnXEVNsGtHdO0k2lB6NdK5u097+5Li4Xr51yFNO6WfrUNLVdaWnDyy8DOSWRfo
         f9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739979630; x=1740584430;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dsoyyheG5eYnfYlWZPRHrjZCkRWZfS8w+U1gKGkozWU=;
        b=m98du0/r/LP49c/FtIXIiO8C/A8DVTk0hBv2MsOkquzqpqgIpI/iRuJwvOt/x8sacr
         Ap96UV3LEVtjlgJmnXv3IlGlgwDqk/O+PFhTeVhoKhQOq1Mj1ViaCFWvr2cVRNeYFkll
         uhjQ6HebNCcvVk+A1TCDsvg7f1CsLb67eGGBhFBIzGW4E9VoMzKY377ax1ZO8eTcJb0C
         9+OTF6RPWtiqXcWEIWG3CWX+8stAhrXgZJVjWhH7aRfocf/mNMYNUOsrucu2rFnvPSUc
         P6VYJhVxu6s7aHY/9EXNprNWtJU/APxeMz/A7UVkP3UuXIJMbepFe0Xvi+DCK175gWou
         GVaw==
X-Forwarded-Encrypted: i=1; AJvYcCUvs/Eq5EyURtBOS+ExlaxYbOwAZmgnSW+9jAhmo9UujBUoGhaeKwVkEUdmwVb5pFheJrKwuhtNCoZkAG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxggKZEDubNsBCH30wlD3ucNYz/b+cIqLiccFF2TnfBKGKPdeJa
	++O0QQvSl5HoHUtYT6Flgi3yfA/5iYTqwk+Cmp0WOEwKdbBXyxjxXBW+Lp7NAiNNTu0vvI6C7Lo
	ctpQd0SGarw==
X-Google-Smtp-Source: AGHT+IF2Ji0kRCZEUvwuqRlmx5jaUs3gvVr5uXlpZ7FXngrGZjd8PDbLbHNXrHxLgegwCyHsoGRFDC8zswzKcg==
X-Received: from wmbes14.prod.google.com ([2002:a05:600c:810e:b0:439:8cc3:4f3b])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:401f:b0:38f:4531:3989 with SMTP id ffacd0b85a97d-38f45313c69mr12438222f8f.51.1739979630529;
 Wed, 19 Feb 2025 07:40:30 -0800 (PST)
Date: Wed, 19 Feb 2025 15:40:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGj7tWcC/x2MQQqAIBAAvyJ7bkE3ouwr0SF0q4Uo0Yog/HvSa
 ZjDzAuJo3CCXr0Q+ZYkx17EVArcOu0Lo/jiQJoaTcbi9mDgiC5cGM5C62dfa9u1ZKBEIfIszz8 cxpw/XIL6VGAAAAA=
X-Change-Id: 20250219-lx-per-cpu-ptr-c9dfd3098721
X-Mailer: b4 0.15-dev
Message-ID: <20250219-lx-per-cpu-ptr-v1-1-b4492fc471e7@google.com>
Subject: [PATCH] scripts/gdb: Add $lx_per_cpu_ptr()
From: Brendan Jackman <jackmanb@google.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>
Cc: Florian Rommel <mail@florommel.de>, linux-kernel@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

We currently have $lx_per_cpu() which works fine for stuff that kernel
code would access via per_cpu(). But this doesn't work for stuff that
kernel code accesses via per_cpu_ptr():

(gdb) p $lx_per_cpu(node_data[1].node_zones[2]->per_cpu_pageset)
Cannot access memory at address 0xffff11105fbd6c28

This is because we take the address of the pointer and use that as the
offset, instead of using the stored value.

Add a GDB version that mirrors the kernel API, which uses the pointer
value.

To be consistent with per_cpu_ptr(), we need to return the pointer value
instead of dereferencing it for the user. Therefore, move the existing
dereference out of the per_cpu() Python helper and do that only in the
$lx_per_cpu() implementation.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 scripts/gdb/linux/cpus.py | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index 13eb8b3901b8fc5e2500138c7d204ac5f7c9858c..1f7e62efb38bf4ddee0058fea8634fd377317669 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -46,7 +46,7 @@ def per_cpu(var_ptr, cpu):
             # !CONFIG_SMP case
             offset = 0
     pointer = var_ptr.cast(utils.get_long_type()) + offset
-    return pointer.cast(var_ptr.type).dereference()
+    return pointer.cast(var_ptr.type)
 
 
 cpu_mask = {}
@@ -149,11 +149,28 @@ Note that VAR has to be quoted as string."""
         super(PerCpu, self).__init__("lx_per_cpu")
 
     def invoke(self, var, cpu=-1):
-        return per_cpu(var.address, cpu)
+        return per_cpu(var.address, cpu).dereference()
 
 
 PerCpu()
 
+class PerCpuPtr(gdb.Function):
+    """Return per-cpu pointer.
+
+$lx_per_cpu_ptr("VAR"[, CPU]): Return the per-cpu pointer called VAR for the
+given CPU number. If CPU is omitted, the CPU of the current context is used.
+Note that VAR has to be quoted as string."""
+
+    def __init__(self):
+        super(PerCpuPtr, self).__init__("lx_per_cpu_ptr")
+
+    def invoke(self, var, cpu=-1):
+        return per_cpu(var, cpu)
+
+
+PerCpuPtr()
+
+
 def get_current_task(cpu):
     task_ptr_type = task_type.get_type().pointer()
 

---
base-commit: f527c5c2abb60ddfd6b929d479b985071500419d
change-id: 20250219-lx-per-cpu-ptr-c9dfd3098721

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


