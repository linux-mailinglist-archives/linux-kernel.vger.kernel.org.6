Return-Path: <linux-kernel+bounces-271454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55397944E69
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B88128ACBA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E911E1AE873;
	Thu,  1 Aug 2024 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gN6Q4ysI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D8B1A7F70
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722523638; cv=none; b=ndSaUlImbNyLqlzMe+bi1+N3ZgJYandlbXBQNZ9dmWnHqJ5KKHAY4H2wSV0d1Toggn6VgvnOVoUIC8PEL0KKqPW4pb/zoq6aK8vE3F9cDxSL8C3gYUpOM5Da16Qbw2u+vSrRbhHTv5sFNaxPGKoGZr9jJdOjGkEnHhdHfsSMtN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722523638; c=relaxed/simple;
	bh=J469TvAJbu9OT0Cil07DbO38OnPS8L+awPtnfxvDPSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4l7oNMas2JtBFRwbrC9RFWE7AXmlP4eew0U2xB4f4ao0Qv/Cc64pHyHL0olkPaGj9xj+Oo0KEtOm6eoVZQK+ioJcv0genBZobamORabzEjTVL4VGGnd1VWanVfMnuxn8L/gAcrLkk95KnH9g8M22OuxczmjcEXcLRv2KRaX3S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gN6Q4ysI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940CFC32786;
	Thu,  1 Aug 2024 14:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722523638;
	bh=J469TvAJbu9OT0Cil07DbO38OnPS8L+awPtnfxvDPSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gN6Q4ysIMw+v+8CFFdoQg6KeqyzHSJ4rxFa71boQlJ2lqILHjkJyurjhvFp2aSVHd
	 R8JGOvg9MVDKWmc+kh20tWdtBMMU8niLLCRnj0XG0hvL/s1iYwfd5T6H+5rIZoUTR4
	 00n0RoGS/c/7/ZJgJdBWi9K+D6CqCl9CzhfVoFu2YJ2LQNMwQTNHwK1+J7nP0Ku+27
	 dn+sI1/OSncOpOfF5+SiKA5r2IoQMCvhdlv1jTvxrJz5sPE/73rQ4VHZmbs8VO+7Hm
	 ccUD4JHRAoG/XyCK/HnzPsfAzJw6p/UIXzXkCedpLCKbypiFFPFNgXQUQK7otaFomL
	 tesLlDOfMzHaA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1sZX5H-00000001WCr-3Tj6;
	Thu, 01 Aug 2024 16:47:15 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Cleber Rosa <crosa@redhat.com>,
	John Snow <jsnow@redhat.com>,
	linux-kernel@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH v4 7/7] scripts/ghes_inject: add a script to generate GHES error inject
Date: Thu,  1 Aug 2024 16:47:10 +0200
Message-ID: <0a9047370233f9e5b3363217d64ff2d93015466d.1722523312.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722523312.git.mchehab+huawei@kernel.org>
References: <cover.1722523312.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Using the QMP GHESv2 API requires preparing a raw data array
containing a CPER record.

Add a helper script with subcommands to prepare such data.

Currently, only ARM Processor error CPER record is supported.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS            |   1 +
 scripts/ghes_inject.py | 673 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 674 insertions(+)
 create mode 100755 scripts/ghes_inject.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 655edcb6688c..9e4874bb552d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2081,6 +2081,7 @@ S: Maintained
 F: hw/arm/ghes_cper.c
 F: hw/acpi/ghes_cper_stub.c
 F: qapi/ghes-cper.json
+F: scripts/ghes_inject.py
 
 ppc4xx
 L: qemu-ppc@nongnu.org
diff --git a/scripts/ghes_inject.py b/scripts/ghes_inject.py
new file mode 100755
index 000000000000..99ee93bc2f34
--- /dev/null
+++ b/scripts/ghes_inject.py
@@ -0,0 +1,673 @@
+#!/usr/bin/env python3
+#
+# pylint: disable=C0301, C0114, R0912, R0913, R0915, W0511
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2024 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+
+# TODO: current implementation has dummy defaults.
+#
+# For a better implementation, a QMP addition/call is needed to
+# retrieve some data for ARM Processor Error injection:
+#
+#   - machine emulation architecture, as ARM current default is
+#     for AArch64;
+#   - ARM registers: power_state, midr, mpidr.
+
+import argparse
+import json
+import socket
+import sys
+
+EINJ_DESCRIPTION = """
+Handle ACPI GHESv2 error injection logic QEMU QMP interface.\n
+
+It allows using UEFI BIOS EINJ features to generate GHES records.
+
+It helps testing Linux CPER and GHES drivers and to test rasdaemon
+error handling logic.
+
+Currently, it support ARM processor error injection for ARM processor
+events, being compatible with UEFI 2.9A Errata.
+
+This small utility works together with those QEMU additions:
+- https://gitlab.com/mchehab_kernel/qemu/-/tree/arm-error-inject-v2
+"""
+
+
+#
+# Socket QMP send command
+#
+def qmp_command(host, port, commands):
+    """Send commands to QEMU though QMP TCP socket"""
+
+    # Needed to negotiate QMP and for QEMU to accept the command
+    commands.insert(0, '{ "execute": "qmp_capabilities" } ')
+
+    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
+    s.connect((host, port))
+
+    data = s.recv(1024)
+
+    print("\t", data.decode("utf-8"), end="")
+
+    for command in commands:
+        print(command)
+
+        s.sendall(command.encode("utf-8"))
+        data = s.recv(1024)
+        print("\t", data.decode("utf-8"), end="")
+
+    s.shutdown(socket.SHUT_WR)
+    while 1:
+        data = s.recv(1024)
+        if data == b"":
+            break
+        print("\t", data.decode("utf-8"))
+
+    s.close()
+
+
+#
+# Helper routines to handle multiple choice arguments
+#
+def get_choice(name, value, choices, suffixes=None):
+    """Produce a list from multiple choice argument"""
+
+    new_values = []
+
+    if not value:
+        return new_values
+
+    for val in value.split(","):
+        val = val.lower()
+
+        if suffixes:
+            for suffix in suffixes:
+                val = val.removesuffix(suffix)
+
+        if val not in choices.keys():
+            sys.exit(f"Error on '{name}': choice {val} is invalid.")
+
+        val = choices[val]
+
+        new_values.append(val)
+
+    return new_values
+
+
+def get_mult_array(mult, name, values, allow_zero=False, max_val=None):
+    """Add numbered hashes from integer lists"""
+
+    if not allow_zero:
+        if not values:
+            return
+    else:
+        if values is None:
+            return
+
+        if not values:
+            i = 0
+            if i not in mult:
+                mult[i] = {}
+
+            mult[i][name] = []
+            return
+
+    i = 0
+    for value in values:
+        for val in value.split(","):
+            try:
+                val = int(val, 0)
+            except ValueError:
+                sys.exit(f"Error on '{name}': {val} is not an integer")
+
+            if val < 0:
+                sys.exit(f"Error on '{name}': {val} is not unsigned")
+
+            if max_val and val > max_val:
+                sys.exit(f"Error on '{name}': {val} is too little")
+
+            if i not in mult:
+                mult[i] = {}
+
+            if name not in mult[i]:
+                mult[i][name] = []
+
+            mult[i][name].append(val)
+
+        i += 1
+
+
+def get_mult_choices(mult, name, values, choices,
+                     suffixes=None, allow_zero=False):
+    """Add numbered hashes from multiple choice arguments"""
+
+    if not allow_zero:
+        if not values:
+            return
+    else:
+        if values is None:
+            return
+
+    i = 0
+    for val in values:
+        new_values = get_choice(name, val, choices, suffixes)
+
+        if i not in mult:
+            mult[i] = {}
+
+        mult[i][name] = new_values
+        i += 1
+
+
+def get_mult_int(mult, name, values, allow_zero=False):
+    """Add numbered hashes from integer arguments"""
+    if not allow_zero:
+        if not values:
+            return
+    else:
+        if values is None:
+            return
+
+    i = 0
+    for val in values:
+        try:
+            val = int(val, 0)
+        except ValueError:
+            sys.exit(f"Error on '{name}': {val} is not an integer")
+
+        if val < 0:
+            sys.exit(f"Error on '{name}': {val} is not unsigned")
+
+        if i not in mult:
+            mult[i] = {}
+
+        mult[i][name] = val
+        i += 1
+
+
+#
+# Data encode helper functions
+#
+def bit(b):
+    """Simple macro to define a bit on a bitmask"""
+    return 1 << b
+
+
+def data_add(data, value, num_bytes):
+    """
+    Adds bytes from value inside a bitarray.
+    If the value is a list, assume it to be a bitmap, where each
+    bit is on a different element inside a list. Such list is
+    converted to a single bitmap integer.
+    """
+
+    if isinstance(value, list):
+        bits = 0
+        for b in value:
+            bits |= b
+
+        value = bits
+
+    data.extend(value.to_bytes(num_bytes, byteorder="little"))
+
+
+def to_uuid(time_low, time_mid, time_high, nodes):
+    """Create an integer array with elements from an UUID"""
+
+    values = bytearray()
+
+    data_add(values, time_low, 4)
+    data_add(values, time_mid, 2)
+    data_add(values, time_high, 2)
+
+    for i in nodes:
+        data_add(values, i, 1)
+
+    return list(values)
+
+
+#
+# Arm processor EINJ logic
+#
+ACPI_GHES_ARM_CPER_LENGTH = 40
+ACPI_GHES_ARM_CPER_PEI_LENGTH = 32
+
+# TODO: query it from emulation. Current default valid only for Aarch64
+CONTEXT_AARCH64_EL1 = 5
+
+CPER_ARM_PROCESSOR_ERROR = to_uuid(0xE19E3D16, 0xBC11, 0x11E4,
+                                   [0x9C, 0xAA, 0xC2, 0x05,
+                                    0x1D, 0x5D, 0x46, 0xB0])
+
+
+class ArmProcessorEinj:
+    """
+    Implements ARM Processor Error injection via GHES
+    """
+
+    def __init__(self, args=None):
+        """
+        Initialize the error injection class. There are two possible
+        ways to initialize it:
+        1. passing a set of arguments;
+        2. passing a dict with error inject command parameters. Each
+            column is handled in separate.
+        """
+
+        # Valid choice values
+        self.arm_valid_bits = {
+            "mpidr":    bit(0),
+            "affinity": bit(1),
+            "running":  bit(2),
+            "vendor":   bit(3),
+        }
+
+        self.pei_flags = {
+            "first":        bit(0),
+            "last":         bit(1),
+            "propagated":   bit(2),
+            "overflow":     bit(3),
+        }
+
+        self.pei_error_types = {
+            "cache":        bit(1),
+            "tlb":          bit(2),
+            "bus":          bit(3),
+
+            "micro-arch":   bit(4),
+            "vendor":       bit(4),
+        }
+
+        self.pei_valid_bits = {
+            "multiple-error":   bit(0),
+            "flags":            bit(1),
+
+            "error":            bit(2),
+            "error-info":       bit(2),
+
+            "virt":             bit(3),
+            "virtual":          bit(3),
+
+            "phy":              bit(4),
+            "physical":         bit(4),
+        }
+
+        self.arm = {}
+
+        if not args:
+            self.args = args
+            return
+
+        pei = {}
+        ctx = {}
+        vendor = {}
+
+        # Handle global parameters
+        if args.arm:
+            arm_validation_init = False
+            self.arm["validation"] = get_choice(name="validation",
+                                                value=args.arm,
+                                                choices=self.arm_valid_bits,
+                                                suffixes=["-error", "-err"])
+        else:
+            self.arm["validation"] = []
+            arm_validation_init = True
+
+        if args.affinity:
+            self.arm["affinity-level"] = args.affinity
+            if arm_validation_init:
+                self.arm["validation"].append(self.arm_valid_bits["affinity"])
+        else:
+            self.arm["affinity-level"] = 0
+
+        if args.mpidr:
+            self.arm["mpidr-el1"] = args.mpidr
+            if arm_validation_init:
+                self.arm["validation"].append(self.arm_valid_bits["mpidr"])
+        else:
+            # TODO: query it from emulation
+            self.arm["mpidr-el1"] = 0
+
+        if args.midr:
+            self.arm["midr-el1"] = args.midr
+        else:
+            # TODO: query it from emulation
+            self.arm["midr-el1"] = 0
+
+        if args.running is not None:
+            if args.running:
+                self.arm["running-state"] = bit(0)
+            else:
+                self.arm["running-state"] = 0
+            if arm_validation_init:
+                self.arm["validation"].append(self.arm_valid_bits["running"])
+        else:
+            # TODO: query it from emulation
+            self.arm["running-state"] = 0
+
+        if args.psci:
+            self.arm["psci-state"] = args.psci
+            if arm_validation_init:
+                self.arm["validation"].append(self.arm_valid_bits["running"])
+        else:
+            # TODO: query it from emulation
+            self.arm["psci-state"] = 0
+
+        # Handle PEI
+        if not args.type:
+            args.type = ["cache-error"]
+
+        get_mult_choices(
+            pei,
+            name="validation",
+            values=args.pei_valid,
+            choices=self.pei_valid_bits,
+            suffixes=["-valid", "-info", "--information", "--addr"],
+        )
+        get_mult_choices(
+            pei,
+            name="type",
+            values=args.type,
+            choices=self.pei_error_types,
+            suffixes=["-error", "-err"],
+        )
+        get_mult_choices(
+            pei,
+            name="flags",
+            values=args.flags,
+            choices=self.pei_flags,
+            suffixes=["-error", "-cap"],
+        )
+        get_mult_int(pei, "error-info", args.error_info)
+        get_mult_int(pei, "multiple-error", args.multiple_error)
+        get_mult_int(pei, "phy-addr", args.physical_address)
+        get_mult_int(pei, "virt-addr", args.virtual_address)
+
+        for i, p in pei.items():        # pylint: disable=W0612
+            # UEFI 2.10 doesn't define how to encode error information
+            # when multiple types are raised. So, provide a default only
+            # if a single type is there
+            if "error-info" not in p:
+                if len(p["type"]) == 1:
+                    if p["type"][0] == bit(1):
+                        p["error-info"] = 0x0091000F
+                    if p["type"][0] == bit(2):
+                        p["error-info"] = 0x0054007F
+                    if p["type"][0] == bit(3):
+                        p["error-info"] = 0x80D6460FFF
+                    if p["type"][0] == bit(4):
+                        p["error-info"] = 0x78DA03FF
+
+            if "validation" not in p:
+                p["validation"] = []
+                if "multiple-error" in p:
+                    p["validation"].append(self.pei_valid_bits["multiple-error"])
+
+                if "flags" in p:
+                    p["validation"].append(self.pei_valid_bits["flags"])
+
+                if "error-info" in p:
+                    p["validation"].append(self.pei_valid_bits["error-info"])
+
+                if "phy-addr" in p:
+                    p["validation"].append(self.pei_valid_bits["phy-addr"])
+
+                if "virt-addr" in p:
+                    p["validation"].append(self.pei_valid_bits["virt-addr"])
+
+        # Handle context
+        get_mult_int(ctx, "type", args.ctx_type, allow_zero=True)
+        get_mult_int(ctx, "minimal-size", args.ctx_size, allow_zero=True)
+        get_mult_array(ctx, "register", args.ctx_array, allow_zero=True)
+
+        get_mult_array(vendor, "bytes", args.vendor, max_val=255)
+
+        # Store PEI
+        self.arm["error"] = []
+        for k in sorted(pei.keys()):
+            self.arm["error"].append(pei[k])
+
+        # Store Context
+        self.arm["context"] = []
+        if ctx:
+            for k in sorted(ctx.keys()):
+                self.arm["context"].append(ctx[k])
+
+        # Vendor-specific bytes are not grouped
+        self.arm["vendor-specific"] = []
+        if vendor:
+            for k in sorted(vendor.keys()):
+                self.arm["vendor-specific"] += vendor[k]["bytes"]
+
+    def encode_pei(self):
+        """Encode bytes at the PEI table"""
+
+        data = bytearray()
+
+        for pei in self.arm["error"]:
+            # Version
+            data_add(data, 0, 1)
+
+            data_add(data, ACPI_GHES_ARM_CPER_PEI_LENGTH, 1)
+
+            data_add(data, pei["validation"], 2)
+            data_add(data, pei["type"], 1)
+            data_add(data, pei.get("multiple-error", 1), 2)
+            data_add(data, pei.get("flags", 0), 1)
+            data_add(data, pei.get("error_info", 0), 8)
+            data_add(data, pei.get("virt_addr", 0xDEADBEEF), 8)
+            data_add(data, pei.get("phy_addr", 0xABBA0BAD), 8)
+
+        return data
+
+    def encode_vendor(self):
+        """Encode bytes at the vendor data"""
+
+        data = bytearray()
+
+        for i in self.arm.get("vendor-specific", []):
+            data_add(data, i, 1)
+
+        return data
+
+    def encode_context(self):
+        """Encode bytes for the register context"""
+
+        data = bytearray()
+
+        if "context" not in self.arm:
+            return data
+
+        for ctx in self.arm["context"]:
+            if "type" not in ctx:
+                ctx["type"] = CONTEXT_AARCH64_EL1
+
+            reg_size = len(ctx["register"])
+            size = 0
+
+            if "minimal-size" in ctx:
+                size = ctx["minimal-size"]
+
+            size = max(size, reg_size)
+
+            size = (size + 1) % 0xFFFE
+
+            # Version
+            data_add(data, 0, 2)
+
+            data_add(data, ctx["type"], 2)
+
+            data_add(data, 8 * size, 4)
+
+            for r in ctx["register"]:
+                data_add(data, r, 8)
+
+            for i in range(reg_size, size):   # pylint: disable=W0612
+                data_add(data, 0, 8)
+
+        return data
+
+    def encode(self):
+        """Encode bytes for the ARM processor Error record"""
+
+        pei_data = self.encode_pei()
+        vendor_data = self.encode_vendor()
+        context_data = self.encode_context()
+
+        data = bytearray()
+
+        data_add(data, self.arm["validation"], 4)
+
+        error_info_num = len(self.arm["error"])
+        data_add(data, error_info_num, 2)
+
+        context_info_num = len(self.arm["context"])
+        data_add(data, context_info_num, 2)
+
+        # Calculate the length of the CPER data
+        cper_length = ACPI_GHES_ARM_CPER_LENGTH
+        cper_length += len(pei_data)
+        cper_length += len(vendor_data)
+        cper_length += len(context_data)
+        data_add(data, cper_length, 4)
+
+        data_add(data, self.arm["affinity-level"], 1)
+
+        # Reserved
+        data_add(data, 0, 3)
+
+        data_add(data, self.arm["mpidr-el1"], 8)
+        data_add(data, self.arm["midr-el1"], 8)
+        data_add(data, self.arm["running-state"], 4)
+        data_add(data, self.arm["psci-state"], 4)
+
+        # Add PEI
+        data.extend(pei_data)
+        data.extend(context_data)
+        data.extend(vendor_data)
+
+        return list(data)
+
+    def run(self, host, port):
+        """Execute the QMP commands"""
+
+        # Fill the commands to be sent
+        commands = []
+
+        cmd_arg = {
+            'cper': {
+                'notification-type': CPER_ARM_PROCESSOR_ERROR,
+                "raw-data": ""
+            }
+        }
+
+        cmd_arg["cper"]["raw-data"] = self.encode()
+
+        command = '{ "execute": "ghes-cper", '
+        command += '"arguments": ' + json.dumps(cmd_arg) + " }"
+
+        commands.append(command)
+
+        qmp_command(host, port, commands)
+
+
+#
+# Argument parser for ARM Processor CPER
+#
+
+
+def arm_handle_args(subparsers):
+    """Add a subparser for ARM-specific arguments"""
+
+    parser = subparsers.add_parser("arm", help="Generate an ARM processor CPER")
+
+    # UEFI N.16 ARM Validation bits
+    g_arm = parser.add_argument_group("ARM processor")
+    g_arm.add_argument("--arm", "--arm-valid",
+                       help="ARM validation bits: mpidr,affinity,running,vendor")
+    g_arm.add_argument("-a", "--affinity",  "--level", "--affinity-level",
+                       type=lambda x: int(x, 0),
+                       help="Affinity level (when multiple levels apply)")
+    g_arm.add_argument("-l", "--mpidr", type=lambda x: int(x, 0),
+                       help="Multiprocessor Affinity Register")
+    g_arm.add_argument("-i", "--midr", type=lambda x: int(x, 0),
+                       help="Main ID Register")
+    g_arm.add_argument("-r", "--running",
+                       action=argparse.BooleanOptionalAction, default=None,
+                       help="Indicates if the processor is running or not")
+    g_arm.add_argument("--psci", "--psci-state", type=lambda x: int(x, 0),
+                       help="Power State Coordination Interface - PSCI state")
+
+    # TODO: Add vendor-specific support
+
+    # UEFI N.17 bitmaps (type and flags)
+    g_pei = parser.add_argument_group("ARM Processor Error Info (PEI)")
+    g_pei.add_argument("-t", "--type", nargs="+",
+                       help="one or more error types: cache,tlb,bus,vendor")
+    g_pei.add_argument("-f", "--flags", nargs="*",
+                       help="zero or more error flags: first-error,last-error,propagated,overflow")
+    g_arm.add_argument("-V", "--pei-valid", "--error-valid", nargs="*",
+                       help="zero or more PEI validation bits: multiple-error,flags,error-info,virt,phy")
+
+    # UEFI N.17 Integer values
+    g_pei.add_argument("-m", "--multiple-error", nargs="+",
+                       help="Number of errors: 0: Single error, 1: Multiple errors, 2-65535: Error count if known")
+    g_pei.add_argument("-e", "--error-info", nargs="+",
+                       help="Error information (UEFI 2.10 tables N.18 to N.20)")
+    g_pei.add_argument("-p", "--physical-address",  nargs="+",
+                       help="Physical address")
+    g_pei.add_argument("-v", "--virtual-address",  nargs="+",
+                       help="Virtual address")
+
+    # UEFI N.21 Context
+    g_pei.add_argument("--ctx-type", "--context-type", nargs="*",
+                       help="Type of the context (0=ARM32 GPR, 5=ARM64 EL1, other values supported)")
+    g_pei.add_argument("--ctx-size", "--context-size", nargs="*",
+                       help="Minimal size of the context")
+    g_pei.add_argument("--ctx-array", "--context-array", nargs="*",
+                       help="Comma-separated arrays for each context")
+
+    # Vendor-specific data
+    g_pei.add_argument("--vendor", "--vendor-specific", nargs="+",
+                       help="Vendor-specific byte arrays of data")
+
+
+#
+# Main Program. Each error injection logic is handled by a separate subparser
+#
+
+
+def main():
+    """Main program"""
+
+    # Main parser - handle generic args like QEMU QMP TCP socket options
+    parser = argparse.ArgumentParser(prog="einj.py",
+                                     formatter_class=argparse.RawDescriptionHelpFormatter,
+                                     usage="%(prog)s [options]",
+                                     description=EINJ_DESCRIPTION,
+                                     epilog="If a field is not defined, a default value will be applied by QEMU.")
+
+    g_options = parser.add_argument_group("QEMU QMP socket options")
+    g_options.add_argument("-H", "--host", default="localhost", type=str,
+                           help="host name")
+    g_options.add_argument("-P", "--port", default=4445, type=int,
+                           help="TCP port number")
+
+    # Call subparsers
+    subparsers = parser.add_subparsers()
+    arm_handle_args(subparsers)
+
+    args = parser.parse_args()
+
+    # Handle subparser commands
+    if "arm" in args:
+        einj = ArmProcessorEinj(args)
+        einj.run(args.host, args.port)
+    else:
+        sys.exit("Error: type of error injection missing.")
+
+
+if __name__ == "__main__":
+    main()
-- 
2.45.2


