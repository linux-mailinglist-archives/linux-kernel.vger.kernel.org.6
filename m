Return-Path: <linux-kernel+bounces-300233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B9095E0DC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 05:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BC43B2118D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 03:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC7E34CD8;
	Sun, 25 Aug 2024 03:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHKV5FC0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A422BB1C
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 03:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724557612; cv=none; b=NcByC7diOj9u3SXIDpgdRsUBaIZTp5i2RKDF7YDiyC9JugAbn9hjMAUx/Q6t8abCff8ISxg1XbY+2G1HtGKgtZduBuO9PNWhETyu5ahoyEJeJVOElGPxCgUNQGloUTawi/rqkX+CuXmhQXzwaJcvK1hkyrzszAXwZhljahb22tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724557612; c=relaxed/simple;
	bh=1dC6qge5j6u0iMd7Y9iF2l9tSLTNhq/Z8HDaN5NFEKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXlzpEAyBLoOEQxDDG61hRzyBMIsqOq006mogyBGqAeoteE9uBK3CUHbM9q+ex5hkYo3+vAIrRD8R7wvssStNp5yw0PZcCjjucL0KnYFF1kBFWufBy1M5qhpvPpK/T8mjFoPNMDjAjy63YJ7Nc1ICdtZWRL93d/sRORRgyO32mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHKV5FC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8A3C4AF10;
	Sun, 25 Aug 2024 03:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724557612;
	bh=1dC6qge5j6u0iMd7Y9iF2l9tSLTNhq/Z8HDaN5NFEKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PHKV5FC0ukHPxbP1G86qA+1tMDF6dVFCGADA5ElLGl5e1JJh1opxdVUtoVvtnzFfm
	 QST0LfrjCgcPSJh/LQfXD2AHBv8S/heI1660Zk6Jss3ab5OSDSq16G3WuKlTlKvu9N
	 ot+7PKfGsShm+M2W+h6vNo3/ucE1EYYUvReUnszrPvU9NYAgrgP8Wl+PaEE5s6wh0j
	 P+7RiEyQz/rqD+cdudy5NEnpo95H4yT1ETfam3E5WGVtSm43H8QTKcI1RG8EcORuqo
	 GOIKqbCj/CKcHxyXg2XO80WZiHSkDmGVGWM/ur0UgJ+J/jXDfxV07NqBiz7a2l0EPJ
	 pqf/8jap8bYHg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab@kernel.org>)
	id 1si4Ch-00000001RN4-37Ga;
	Sun, 25 Aug 2024 05:46:11 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Cleber Rosa <crosa@redhat.com>,
	John Snow <jsnow@redhat.com>,
	linux-kernel@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH v9 12/12] scripts/arm_processor_error.py: retrieve mpidr if not filled
Date: Sun, 25 Aug 2024 05:46:07 +0200
Message-ID: <2aeadf20d49a6896f3cec6b0ca5a388f5d7fdf5b.1724556967.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724556967.git.mchehab+huawei@kernel.org>
References: <cover.1724556967.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

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


