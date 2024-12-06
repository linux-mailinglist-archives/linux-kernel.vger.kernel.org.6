Return-Path: <linux-kernel+bounces-435405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FEB9E770D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41BA7287947
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D68821AA39;
	Fri,  6 Dec 2024 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OA4NN6jh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88458204584
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505688; cv=none; b=eXKKTNKuPtLdws7wxyeUNYWJVGwwdYpmVfSkZmWrueMDq/W0GE01YXhwBcRtMNKY4DpX8wmQKMufuMuKkwPahZ4ZEerielkuYxlKvT2rIzU0MUvi6naEQUyEIBv7WUbVEbc6+lcxeZ5Onhr3gWSWXESzaLIslXhpibiOhZ1PBj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505688; c=relaxed/simple;
	bh=8PDComTDvpWMdoAF+aMthXOxNOYusavoA3WH9HKn+eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anfhJeo2uRCDbkLi25GOMJmv03zXkJocekA+K9xazuo1RZLxigeO0LWANWFldjvLz6XqqUPV5yegMJYEZKeCR93Gbi5INLwTpBvdmqbswh7UesIrcYsKnKe9l/yG/W/jdLvuFxTIud3GGqI8iYE9+e7LzSx8xiSO4tRlnLpOytQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OA4NN6jh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06727C4CEE3;
	Fri,  6 Dec 2024 17:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505688;
	bh=8PDComTDvpWMdoAF+aMthXOxNOYusavoA3WH9HKn+eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OA4NN6jht0uOJWtQT8tHO+a/mn68UNs4A4zW/WJxYPYPqSYwVamLMRvuvROwqDtfn
	 CsT7iTwpRuYRPa7LDFXVtFO+BSHyA6Ov6as505di/lRtoFowKGWLyXG+cFMNVqesIO
	 nMugdA6NCwCrEBDQVg+aEsfagfBU6vf7rY1R6lFL1GxFnlmMRwJMEhTqBbjVMj1o3n
	 1JquVxREj8kE0IDarC8/FN+8fwlz1EQ+XiQ9aBNau7DOlAueUBnDvIfRhEqL/36b66
	 VmIbog3UcOHHO+wsgQwbcZjyMMDHpKdHfqSMyAKkw7sb2Ug8wJ/KCDk2pnxRfxtYrG
	 jnSsd0QPdGP2g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tJc18-00000005RL8-0gHl;
	Fri, 06 Dec 2024 18:21:26 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Cleber Rosa <crosa@redhat.com>,
	John Snow <jsnow@redhat.com>,
	linux-kernel@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH 25/31] scripts/arm_processor_error.py: retrieve mpidr if not filled
Date: Fri,  6 Dec 2024 18:12:47 +0100
Message-ID: <3a52f5fb5baa850cfca1bdceee05c66918181ba8.1733504943.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733504943.git.mchehab+huawei@kernel.org>
References: <cover.1733504943.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Add support to retrieve mpidr value via qom-get.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/arm_processor_error.py | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/scripts/arm_processor_error.py b/scripts/arm_processor_error.py
index 62e0c5662232..b4321ff45517 100644
--- a/scripts/arm_processor_error.py
+++ b/scripts/arm_processor_error.py
@@ -5,12 +5,10 @@
 #
 # Copyright (C) 2024 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
 
-# TODO: current implementation has dummy defaults.
-#
-# For a better implementation, a QMP addition/call is needed to
-# retrieve some data for ARM Processor Error injection:
-#
-#   - ARM registers: power_state, mpidr.
+# Note: currently it lacks a method to fill the ARM Processor Error CPER
+# psci field from emulation. On a real hardware, this is filled only
+# when a CPU is not running. Implementing support for it to simulate a
+# real hardware is not trivial.
 
 import argparse
 import re
@@ -174,11 +172,26 @@ def send_cper(self, args):
         else:
             cper["running-state"] = 0
 
+        if args.mpidr:
+            cper["mpidr-el1"] = arg["mpidr"]
+        elif cpus:
+            cmd_arg = {
+                'path': cpus[0],
+                'property': "x-mpidr"
+            }
+            ret = qmp_cmd.send_cmd("qom-get", cmd_arg, may_open=True)
+            if isinstance(ret, int):
+                cper["mpidr-el1"] = ret
+            else:
+                cper["mpidr-el1"] = 0
+        else:
+            cper["mpidr-el1"] = 0
+
         if arm_valid_init:
             if args.affinity:
                 cper["valid"] |= self.arm_valid_bits["affinity"]
 
-            if args.mpidr:
+            if "mpidr-el1" in cper:
                 cper["valid"] |= self.arm_valid_bits["mpidr"]
 
             if "running-state" in cper:
@@ -362,7 +375,7 @@ def send_cper(self, args):
                 if isinstance(ret, int):
                     arg["midr-el1"] = ret
 
-        util.data_add(data, arg.get("mpidr-el1", 0), 8)
+        util.data_add(data, cper["mpidr-el1"], 8)
         util.data_add(data, arg.get("midr-el1", 0), 8)
         util.data_add(data, cper["running-state"], 4)
         util.data_add(data, arg.get("psci-state", 0), 4)
-- 
2.47.1


