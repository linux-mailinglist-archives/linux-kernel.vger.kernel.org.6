Return-Path: <linux-kernel+bounces-285622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C23B951083
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54DCF284CDC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0A11AE030;
	Tue, 13 Aug 2024 23:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yx9MluHJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D118D1AC42B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 23:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723591451; cv=none; b=pL3LV5Y1JGo5vhYFh3D3O1u9AX2HmX9SNH3DyKgCJWalpRdO+5w+Bsr/cHEdDsqEhApn4p+BSNDx4ylPnQe76d4dLzjdXIvrahF3R38+1VUkRgsZT/po4eP1S8rhSutiHEFiXtE2vOcqcSWHQKeJDpPwV0WIj0vhfkeaEJNNDEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723591451; c=relaxed/simple;
	bh=j486ons4LyU7EE4gQ8GJy4aORh/7MBRYapAi7rAlR+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ha44NNBrSfo7mYz+jxsb4fV+D7c5WvmOsfJOgFj9r7SDxgi9xKCg9zQ3aImaiaSSNfxCs0raFmH3dTLtVIJBzUIiUWIQ9q4N8yZCNPUgdB3Lhqs54f8Fu0uPFGgc0KQbWHViTbh/ocLNjrmgHQxNVE/FosL+z6i0YT9JPf7m/8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yx9MluHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63EAEC4AF13;
	Tue, 13 Aug 2024 23:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723591451;
	bh=j486ons4LyU7EE4gQ8GJy4aORh/7MBRYapAi7rAlR+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yx9MluHJQmDwLQG3DJapFOoAdn5xMLfX5NVv0dsyrsYubiIW+gEv9OsMna87IYz/h
	 akhdJFXIwELLRJ1nYSLqJrpDqGs3UADWfrRqUulCrex73TfTNW7H0GgyP/VcIDLAMP
	 XmLOm6zd8VRmalAtkp1DhALF+ppVDCvl4169EWsyhPXWLsUASzwV9Kz5jfmZbhUj7R
	 7xRIBTlAZ6sdeNk9Vhq5n/qvuu6IQX94GAvavM87c9BlF4I0E90EkZlJhNytA5D0Rn
	 TTNTnfJVpdrjHlR74fIFAL8B+AFC3jE3CfQUJpBNZHBYHQCYE00nw89EFnbnH2k/fP
	 jqpVgEMwcednw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1se0s5-00000002ask-2DMl;
	Wed, 14 Aug 2024 01:24:09 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Cleber Rosa <crosa@redhat.com>,
	John Snow <jsnow@redhat.com>,
	linux-kernel@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH v7 10/10] scripts/arm_processor_error.py: retrieve mpidr if not filled
Date: Wed, 14 Aug 2024 01:23:32 +0200
Message-ID: <01a655b405ab098aed7396fe87f8fd406e966141.1723591201.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1723591201.git.mchehab+huawei@kernel.org>
References: <cover.1723591201.git.mchehab+huawei@kernel.org>
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
index 2643e4ddc5f3..f869f07860b8 100644
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
@@ -168,11 +166,24 @@ def send_cper(self, args):
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
@@ -356,7 +367,7 @@ def send_cper(self, args):
                 if isinstance(ret, int):
                     arg["midr-el1"] = ret
 
-        util.data_add(data, arg.get("mpidr-el1", 0), 8)
+        util.data_add(data, cper["mpidr-el1"], 8)
         util.data_add(data, arg.get("midr-el1", 0), 8)
         util.data_add(data, cper["running-state"], 4)
         util.data_add(data, arg.get("psci-state", 0), 4)
-- 
2.46.0


