Return-Path: <linux-kernel+bounces-523684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6358A3D9F2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98F919C38D0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919EF1F8AE2;
	Thu, 20 Feb 2025 12:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jMk7s72z"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B671F892D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054229; cv=none; b=PVyCvFEb9Z61SOySUH6AH8EghR+H3xs/lmXpM9N/waS/yP5qlhewMxrEboZTQyO+rG8/6hKhKf9tRagh+foRWigrL9xcgVPTM4KT4USr1vDOLQ0BvE9R+50l3Y7cRzj0uwS57uC3hNONOwV1lgCx1QxUtFvjMxrJTDnRZotTReQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054229; c=relaxed/simple;
	bh=JfISonVf5WAUeH9hdJ9WCP9G15Zj9cQkWLhBMBSwA/g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CE8lgMh/xp9caxg1Z67glExR3A3SLnRGTzUS0I4poXcCPvizZd1/MkFo441qNfAPGIE2U1ad6nTYJwKrUONeqjYqniaL9FWYsHb4hBhsUQvK5eQxt8UR2GX4i0+NroUH6ynu1zUl/xg3Ns/xqC+hNxkgGoalGoURtPx6CwPZu0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jMk7s72z; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-38f4cce15c8so450744f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 04:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740054226; x=1740659026; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6QUGPrXZZ75gNSgwcmI9jdy9kTZO3KcWC6EoeJkyMd0=;
        b=jMk7s72z2iATBJ1QyK/5mNcPu46PrC8b4TyJjFPPu2ZVvXv5ZMjWLXQnIYMoen4dja
         FZhUdgpfMDvNP3BId58s3XTU861Df8w+ZkG3W0xbXxxccajNGm8hWsHWBVD+u2VfHwLu
         Svq/Mbtizw4QGVB8KxMmDj81leYeE3My3ebMWqEzzWAAdX82Bp/EXSudt2vEkyZnvH/s
         h2nItxCnrghrh+ER24MykSSdsZ2WSr/jwkmaFTHAdoWzG3m50YYaUFOueCwI3eN4lijL
         T8bbB89amUlZ09tsO68WLizyqkVMpYfB7vLXfTcAfnbZk4sQWmxWNEDz0GDM7mBWJLFP
         R92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740054226; x=1740659026;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6QUGPrXZZ75gNSgwcmI9jdy9kTZO3KcWC6EoeJkyMd0=;
        b=vqrRXLnik1cejnKWtgWDrXlQxCUIUZp3CE/P9+CdAD4yMvW/eRdxOtZrC6jMqvjWug
         r7GtW/8LcPjcDHvTZkUWqPpn10avdzZZ/o5raKy4gUFEWT5TKdYS0khVod3D3N0UEtzF
         12NQ/PMHVIF53Q69r1tKbcTe1aNuOcRSKOEEXsIN5lf5XaFBSYbGKInRHGifLzjLasVa
         UDUzLQnHy/48fXqU2K5GFqVvsSUQufUqs/GodfNHrd+qKbq3Wm15kKsXvDTQMcdSCeMY
         gBZ49RY0w9HuoVGmYB/lyQEHmSQmHRuvRPCW7mEIpO/1v5ViJptRIVLCVv6MLmG3TqSc
         fsZg==
X-Forwarded-Encrypted: i=1; AJvYcCXGYpKv/sLbMbwRA0e+KwJebXqKKOlWKgpRRE4u1afruOw6n1RfgxQXKJGLrMD76Y4YxEMWKolupFgOtBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3HdfeSw9IJkjIsLIR5Q0STcAgfqbpqrZQ80Pdf/hX5Ghfsavo
	ipG361FsGyhEMZDBAiJQQgoFT8pQLOkApBhSSbo2xr+ovMsZYrQ9y9PT5VsbzivgLkbY+nKiR7n
	IdiMBtS8VHg==
X-Google-Smtp-Source: AGHT+IFg1WZLiKvPjXkpIxkol2adlvDbMXXmQrMhOTycFgInF7QtmIy7H+MHq0b0zQbPwnCD4/y3r7/K0S67KA==
X-Received: from wmqe9.prod.google.com ([2002:a05:600c:4e49:b0:439:81e4:9ca6])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5885:0:b0:38d:d99d:d221 with SMTP id ffacd0b85a97d-38f33f3750fmr18906201f8f.1.1740054226455;
 Thu, 20 Feb 2025 04:23:46 -0800 (PST)
Date: Thu, 20 Feb 2025 12:23:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMset2cC/3WMwQ7CIBAFf6XZs2sAMYgn/8P0oLBQkloI1Kam4
 d/F3j29zEtmNiiUAxW4dhtkWkIJcWogDh2Y4TF5wmAbg2DizATXOK6YKKNJb0xzW22dPTF9UYJ Dk1ImF9Y9eO8bD6HMMX/2/sJ/79/UwpHjU0otnJGKk7r5GP1IRxNf0Ndav7GnNuKtAAAA
X-Change-Id: 20250219-lx-per-cpu-ptr-c9dfd3098721
X-Mailer: b4 0.15-dev
Message-ID: <20250220-lx-per-cpu-ptr-v2-1-945dee8d8d38@google.com>
Subject: [PATCH v2] scripts/gdb: Add $lx_per_cpu_ptr()
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
Since I think this is an uncontroversial patch I'm sending v2
immediately instead of waiting for more review comments. If that's
annoying, let me know and I'll wait a few days next time :)

Changes in v2:
- Formatting fixup (was missing a blank line)
- Link to v1: https://lore.kernel.org/r/20250219-lx-per-cpu-ptr-v1-1-b4492fc471e7@google.com
---
 scripts/gdb/linux/cpus.py | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index 13eb8b3901b8fc5e2500138c7d204ac5f7c9858c..1a50a4195def6a82f1391f5e162a5d063e794db8 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -46,7 +46,7 @@ def per_cpu(var_ptr, cpu):
             # !CONFIG_SMP case
             offset = 0
     pointer = var_ptr.cast(utils.get_long_type()) + offset
-    return pointer.cast(var_ptr.type).dereference()
+    return pointer.cast(var_ptr.type)
 
 
 cpu_mask = {}
@@ -149,11 +149,29 @@ Note that VAR has to be quoted as string."""
         super(PerCpu, self).__init__("lx_per_cpu")
 
     def invoke(self, var, cpu=-1):
-        return per_cpu(var.address, cpu)
+        return per_cpu(var.address, cpu).dereference()
 
 
 PerCpu()
 
+
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


