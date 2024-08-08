Return-Path: <linux-kernel+bounces-279455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A989994BD80
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E6FEB242C6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787B118FC89;
	Thu,  8 Aug 2024 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUFymcJd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BDC18C937
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120003; cv=none; b=T/Hz4y7yN4yB87iMPTdTdPpMGFNAQX3B8ZlKdZH9juD5lVqsHGCqw3mPVjIftlMsPMtweI3mtAcOx4oob7oAf51Dw70QoVmzjmRT5+3tNfHBbs9OIkAeCeLA10jiDXhnjPEUfSF7YdaywwDiIJ4xPlA8w4b4gglB5b5Nae4SM/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120003; c=relaxed/simple;
	bh=rEyXbt+nHyXfhaHjwgifZvCFRsjRrNRv8uaioILzvnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGGsqCOX7hJQijdjwhU6eu2fKqe0USB8SQe9yn26mFrZRW/G3rjjnfRF4Ds4G7FDh69LZePwV6xrcscszSUqHb0Zr/MjddIpeja4+7/mA6/pZNuWxVng53Qw2a0zhb7fobSHaK4PcookMG157mYKtDmbyPcFmCXXgdtPWN+7G58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUFymcJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB218C4AF19;
	Thu,  8 Aug 2024 12:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723120003;
	bh=rEyXbt+nHyXfhaHjwgifZvCFRsjRrNRv8uaioILzvnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oUFymcJd+FLhY18BhBN9DZVPJ5JTVDrqAPSAC08ovTReEk4oiVx0HGCueUBlAO2d/
	 GvY2OIXFCWhWSWSrcR0/IgtcWHeg+GDS5rY+ZnBypCh3mrZnBeF3c4ZiFOkk7ag9VA
	 buMx+OvGVC1wk/KTfh2l4RZRNsfMQ5jNGttUwgs3ZDiubg4DWsrYu3ETCzC7gGdO+f
	 tvJvYV43YEGMsfIBSAXQjB0sH7ncL85O0aVtYZLJqNtdgpt5asn4sOar/BaMAg69Mk
	 PlGQg35UZN6JchM7EMAomGYibgnuSdR3VKZh4UhorTCHm9ZE/GyTjEVd1F0YMt4aS1
	 KH3yMmcQCMXaA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1sc2E5-00000000oDm-0Iiu;
	Thu, 08 Aug 2024 14:26:41 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Cleber Rosa <crosa@redhat.com>,
	John Snow <jsnow@redhat.com>,
	linux-kernel@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH v6 10/10] scripts/arm_processor_error.py: retrieve mpidr if not filled
Date: Thu,  8 Aug 2024 14:26:36 +0200
Message-ID: <f23fd60f36a9d1a1483f80eb298de06526b46eb6.1723119423.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1723119423.git.mchehab+huawei@kernel.org>
References: <cover.1723119423.git.mchehab+huawei@kernel.org>
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
 scripts/arm_processor_error.py | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/scripts/arm_processor_error.py b/scripts/arm_processor_error.py
index b464254c8b7c..756935a2263c 100644
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
@@ -168,11 +166,27 @@ def send_cper(self, args):
         else:
             cper["running-state"] = 0
 
+        if args.mpidr:
+            cper["mpidr-el1"] = arg["mpidr"]
+        elif cpus:
+            get_mpidr = {
+                "execute": "qom-get",
+                "arguments": {
+                    'path': cpus[0],
+                    'property': "x-mpidr"
+                }
+            }
+            ret = qmp_cmd.send_cmd(get_mpidr, may_open=True)
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
@@ -360,7 +374,7 @@ def send_cper(self, args):
                 if isinstance(ret, int):
                     arg["midr-el1"] = ret
 
-        util.data_add(data, arg.get("mpidr-el1", 0), 8)
+        util.data_add(data, cper["mpidr-el1"], 8)
         util.data_add(data, arg.get("midr-el1", 0), 8)
         util.data_add(data, cper["running-state"], 4)
         util.data_add(data, arg.get("psci-state", 0), 4)
-- 
2.45.2


