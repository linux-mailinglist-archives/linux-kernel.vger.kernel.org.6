Return-Path: <linux-kernel+bounces-289187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86CC95439C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FAD3283F81
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA280143757;
	Fri, 16 Aug 2024 07:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXF2kbFO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6962137903
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 07:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723793874; cv=none; b=VWniRc4XhOYebjy2mAJeJY6rj3ivCSBvXki6Kr+LWtjP7hSSgY3ZZ2lvD+apMQMT8xxKzc84AdoRWR0+Oe9CX/C51Ut7xVwtseL+4jQJPm9FqAiOfW5uG699P4G7cl+gtOagD0MlnFLdAxVmQZeGGGsQd3FxE1XFJvJNmbwGCjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723793874; c=relaxed/simple;
	bh=1dC6qge5j6u0iMd7Y9iF2l9tSLTNhq/Z8HDaN5NFEKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0trlEg0+iUnlWn7TowjgaA3Ahtm7dJKeW4KBs84NzVVVBIvtYZQ0wkz3uvIKE5jSttmVHk/TlZCTLR6uQJl9MqpdgLAzQ5PH1G9QGKltyx4QpyKywlSzKmLtgZq5dt55OpLiYADUMsDCqC7pXE615ZlowMjZ/U12u5o8RN9Tj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXF2kbFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A306C4AF11;
	Fri, 16 Aug 2024 07:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723793873;
	bh=1dC6qge5j6u0iMd7Y9iF2l9tSLTNhq/Z8HDaN5NFEKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DXF2kbFOu/d0z+t1Ms+g5NWG//Ep0IG5elrFrqpzaQwKmFjK24inwdZMTckRHm7Dz
	 ZR3SyNvp0Sl+GxTr4rmgvWYkdMVdoelD4KYiKyi+DkKmWOexSe6tz4HzaN4tYzUlN7
	 Blbt8I3FgFnoUdTpooR3xBIiZ+6n8RqECQarWWVpkDzPwcbHMVead9+KQZKC5Zx640
	 hmlPQAdkwwmI4j+doVKPmRLBxrU1mO31F4cz1MqHnOkKocome/JoIteJx/DkWGjz3G
	 16PMdVYWFgiOtSRkUZACyWV8aRlE9rNVLnbR8lLHljvqq89UVyHNxyrf/fitwTVBiH
	 ZsNHrSBB1BXUg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1serWx-000000055ez-2v1X;
	Fri, 16 Aug 2024 09:37:51 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Cleber Rosa <crosa@redhat.com>,
	John Snow <jsnow@redhat.com>,
	linux-kernel@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH v8 11/13] scripts/arm_processor_error.py: retrieve mpidr if not filled
Date: Fri, 16 Aug 2024 09:37:43 +0200
Message-ID: <9fab07e7af3efaae9546ab2c7b12b2482ba02da5.1723793768.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1723793768.git.mchehab+huawei@kernel.org>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
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
 scripts/arm_processor_error.py | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/scripts/arm_processor_error.py b/scripts/arm_processor_error.py
index 62e0c5662232..0a16d4f0d8b1 100644
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
@@ -174,11 +172,24 @@ def send_cper(self, args):
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
+
         if arm_valid_init:
             if args.affinity:
                 cper["valid"] |= self.arm_valid_bits["affinity"]
 
-            if args.mpidr:
+            if "mpidr-el1" in cper:
                 cper["valid"] |= self.arm_valid_bits["mpidr"]
 
             if "running-state" in cper:
@@ -362,7 +373,7 @@ def send_cper(self, args):
                 if isinstance(ret, int):
                     arg["midr-el1"] = ret
 
-        util.data_add(data, arg.get("mpidr-el1", 0), 8)
+        util.data_add(data, cper["mpidr-el1"], 8)
         util.data_add(data, arg.get("midr-el1", 0), 8)
         util.data_add(data, cper["running-state"], 4)
         util.data_add(data, arg.get("psci-state", 0), 4)
-- 
2.46.0


