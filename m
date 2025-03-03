Return-Path: <linux-kernel+bounces-541492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21855A4BD6F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4731896DEE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0763A1F1525;
	Mon,  3 Mar 2025 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SwpM+PMf"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B471C1F0E28
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999903; cv=none; b=Edwpfdn7DmWlSncJ10evongPN7/6KzDUc3niK+lKXFqkBnwE/+AFR6gcuiDUSMOmxa19/R7fEUaPb7wseLAWKB4oUmBmwN5O8Ivl6ZIRa9OOrMV7ThCkkMZYQcSjfu9mn1ZMK0NRYc4RIGVKcnbNPCI0o2iwpqV3MI35hq45ClU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999903; c=relaxed/simple;
	bh=ElPUpFVk5goLrUhi20SmWPJuNqF/zH/QadL3bQmEVLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZzNv3IEQa3Kp0wRjrxD9/5p8owRYi4n0xSkbOxLDGG4Loz3A+Lhjrgie2LqzpuY/pNEqfw5r4AG+vb+f1qwlWCx7QQy6LDS6465LAFBJJhiYlieeG9SQKa29Yjyn/MkMOplRwUeNaR9iVc3SDx6hhQxivtINIbV9P3T2FhhD6uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SwpM+PMf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5239DKtZ021844;
	Mon, 3 Mar 2025 11:04:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=n/GdrlCzxlGmTSrTof6eoGpfhQQom0LPXfxQRGIhC
	rY=; b=SwpM+PMf5bfViuQMRJgB56VAwXmVIUM1OHtuw4j1b6DMUU9CY3Q6wV35I
	9CgdNuxEaCCctEnIXnNnuaSj8VkLya9Tva/6FNuFdp4RRmxqSGVz8XBRxgxYI/O+
	hA6gXx4Uux/F2e5ZaHUGCNhM9hPBY+timZ30u8CLwSoDJfrTvj+jLEdheUzCFyuJ
	fqNjHV3D4Zk55bQW1GV4unMlHy7CxD2XKgUVe6xhqm43hP0rBWBvbwRVs/r2wYe9
	syOPzKowxxhq9oSeBr/QwR8yraDxSmqNbfLZF5tdMwJOiQaB6tzf7AKtKEcAf1gr
	S7TXR3bKLzX/tO6r3UHXHOQ7UK4BA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 454xhyjx3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 11:04:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5239Tff5020800;
	Mon, 3 Mar 2025 11:04:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 454esjphqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 11:04:55 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 523B4pvi59769202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Mar 2025 11:04:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 432302004B;
	Mon,  3 Mar 2025 11:04:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA1222004F;
	Mon,  3 Mar 2025 11:04:50 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.39.224])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Mar 2025 11:04:50 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>
Cc: linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] scripts/gdb/symbols: Determine KASLR offset on s390
Date: Mon,  3 Mar 2025 12:03:58 +0100
Message-ID: <20250303110437.79070-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VcK3q7rr65Y0KTE7yEsR_WHfoJKAnsQU
X-Proofpoint-ORIG-GUID: VcK3q7rr65Y0KTE7yEsR_WHfoJKAnsQU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_04,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030084

Use QEMU's qemu.PhyMemMode [1] functionality to read vmcore from the
physical memory the same way the existing dump tooling does this.
Gracefully handle non-QEMU targets, early boot, and memory corruptions;
print a warning if such situation is detected.

[1] https://qemu-project.gitlab.io/qemu/system/gdb.html#examining-physical-memory

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 scripts/gdb/linux/symbols.py | 31 ++++++++++++++++++++++++++++++-
 scripts/gdb/linux/utils.py   | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index f6c1b063775a..3126329c7f26 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -14,6 +14,7 @@
 import gdb
 import os
 import re
+import struct
 
 from linux import modules, utils, constants
 
@@ -53,6 +54,29 @@ if hasattr(gdb, 'Breakpoint'):
             return False
 
 
+def get_vmcore_s390():
+    with utils.qemu_phy_mem_mode():
+        vmcore_info = 0x0e0c
+        paddr_vmcoreinfo_note = gdb.parse_and_eval("*(unsigned long long *)" +
+                                                   hex(vmcore_info))
+        inferior = gdb.selected_inferior()
+        elf_note = inferior.read_memory(paddr_vmcoreinfo_note, 12)
+        n_namesz, n_descsz, n_type = struct.unpack(">III", elf_note)
+        desc_paddr = paddr_vmcoreinfo_note + len(elf_note) + n_namesz + 1
+        return gdb.parse_and_eval("(char *)" + hex(desc_paddr)).string()
+
+
+def get_kerneloffset():
+    if utils.is_target_arch('s390'):
+        try:
+            vmcore_str = get_vmcore_s390()
+        except gdb.error as e:
+            gdb.write("{}\n".format(e))
+            return None
+        return utils.parse_vmcore(vmcore_str).kerneloffset
+    return None
+
+
 class LxSymbols(gdb.Command):
     """(Re-)load symbols of Linux kernel and currently loaded modules.
 
@@ -155,7 +179,12 @@ lx-symbols command."""
                 obj.filename.endswith('vmlinux.debug')):
                 orig_vmlinux = obj.filename
         gdb.execute("symbol-file", to_string=True)
-        gdb.execute("symbol-file {0}".format(orig_vmlinux))
+        kerneloffset = get_kerneloffset()
+        if kerneloffset is None:
+            offset_arg = ""
+        else:
+            offset_arg = " -o " + hex(kerneloffset)
+        gdb.execute("symbol-file {0}{1}".format(orig_vmlinux, offset_arg))
 
         self.loaded_modules = []
         module_list = modules.module_list()
diff --git a/scripts/gdb/linux/utils.py b/scripts/gdb/linux/utils.py
index 245ab297ea84..03ebdccf5f69 100644
--- a/scripts/gdb/linux/utils.py
+++ b/scripts/gdb/linux/utils.py
@@ -11,6 +11,11 @@
 # This work is licensed under the terms of the GNU GPL version 2.
 #
 
+import contextlib
+import dataclasses
+import re
+import typing
+
 import gdb
 
 
@@ -216,3 +221,33 @@ def gdb_eval_or_none(expresssion):
         return gdb.parse_and_eval(expresssion)
     except gdb.error:
         return None
+
+
+@contextlib.contextmanager
+def qemu_phy_mem_mode():
+    connection = gdb.selected_inferior().connection
+    orig = connection.send_packet("qqemu.PhyMemMode")
+    if orig not in b"01":
+        raise gdb.error("Unexpected qemu.PhyMemMode")
+    orig = orig.decode()
+    if connection.send_packet("Qqemu.PhyMemMode:1") != b"OK":
+        raise gdb.error("Failed to set qemu.PhyMemMode")
+    try:
+        yield
+    finally:
+        if connection.send_packet("Qqemu.PhyMemMode:" + orig) != b"OK":
+            raise gdb.error("Failed to restore qemu.PhyMemMode")
+
+
+@dataclasses.dataclass
+class VmCore:
+    kerneloffset: typing.Optional[int]
+
+
+def parse_vmcore(s):
+    match = re.search(r"KERNELOFFSET=([0-9a-f]+)", s)
+    if match is None:
+        kerneloffset = None
+    else:
+        kerneloffset = int(match.group(1), 16)
+    return VmCore(kerneloffset=kerneloffset)
-- 
2.48.1


