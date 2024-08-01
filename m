Return-Path: <linux-kernel+bounces-271451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D68BE944E65
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 469AFB23B6B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF591A99D0;
	Thu,  1 Aug 2024 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Si/dw9s7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E061A6169
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722523638; cv=none; b=QQifbKCZFiZFHAVtUhOKfGgY26naBXC8mEWfEQNKFLD1tSQQ4bI3AV6cPOkecvRH9TUUNIiDvq6SLEiJI2pkrO4dHaK2e+4O1LA3nsx0wJM5P8BLe2vvIOpGwjVonXNR5f4f2peNuWYSl4LPyIgovpOeoeOovqKHEcuPZgOBmcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722523638; c=relaxed/simple;
	bh=inI4stFbv14+sS7oa5RIwxj/FX+TvJx1kVyZnVYHKuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpWN/TaxJjRXZQce8TH15YYy6cQIjen8QAqreG7287s9PbD0scDqsHJztzn+4/0ZtkKmwBnjSsBQZrQmIE1dOF/KIfdRCwZYh/CAxHyQ6XbMIH2lw/QPHwfwHZ7R8NylEiK6q5PCFgDsBDwoozwzurOgoZ6QLKCSSSVW72Scg7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Si/dw9s7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A673DC4AF12;
	Thu,  1 Aug 2024 14:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722523637;
	bh=inI4stFbv14+sS7oa5RIwxj/FX+TvJx1kVyZnVYHKuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Si/dw9s7gbhmlNguqCDcHfrC1uhpkaOK49d1rpKo5guVajK1i39WlYhSSIi7JJp89
	 eDL9UdjAD0pEcgn+hokuXtdBVaIqHSdey/ODL8bwB0tJAO5j2w3PWz+/lcQhu/RMh2
	 R4O3WkOJUdFyGTVxVOKdYHQLX0/qKIslVfq5uysQ7boyyJs5pKUFpqYD/mgd8t88A+
	 vbWYCnSPAyrjRyLZCHoRSKkvj45wu+UsPOIKjuYlEgn+0xaGo1R46ppCQwpTpLlnDu
	 jAGa0MpWUdoARAzi4h2Z1Lrgy9YWXoN6aBfcFwuMx4XtPYF960eHduRU5nV1k/kRCY
	 /bV+vo3iOhIUA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1sZX5H-00000001WCj-3Fzx;
	Thu, 01 Aug 2024 16:47:15 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	Eric Blake <eblake@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Michael Roth <michael.roth@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v4 5/7] qapi/ghes-cper: add an interface to do generic CPER error injection
Date: Thu,  1 Aug 2024 16:47:08 +0200
Message-ID: <5a4da771f04beea4e7488eee8080c0ace372e9a0.1722523312.git.mchehab+huawei@kernel.org>
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

Creates a QAPI to be used for generic ACPI APEI hardware error
injection (HEST) via GHESv2.

The actual GHES code will be added at the followup patch.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS            |  7 ++++++
 hw/acpi/Kconfig        |  5 ++++
 hw/acpi/ghes_cper.c    | 53 +++++++++++++++++++++++++++++++++++++++++
 hw/acpi/meson.build    |  2 ++
 hw/arm/Kconfig         |  5 ++++
 include/hw/acpi/ghes.h |  6 +++++
 qapi/ghes-cper.json    | 54 ++++++++++++++++++++++++++++++++++++++++++
 qapi/meson.build       |  1 +
 qapi/qapi-schema.json  |  1 +
 9 files changed, 134 insertions(+)
 create mode 100644 hw/acpi/ghes_cper.c
 create mode 100644 qapi/ghes-cper.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 98eddf7ae155..655edcb6688c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2075,6 +2075,13 @@ F: hw/acpi/ghes.c
 F: include/hw/acpi/ghes.h
 F: docs/specs/acpi_hest_ghes.rst
 
+ACPI/HEST/GHES/ARM processor CPER
+R: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+S: Maintained
+F: hw/arm/ghes_cper.c
+F: hw/acpi/ghes_cper_stub.c
+F: qapi/ghes-cper.json
+
 ppc4xx
 L: qemu-ppc@nongnu.org
 S: Orphan
diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
index e07d3204eb36..73ffbb82c150 100644
--- a/hw/acpi/Kconfig
+++ b/hw/acpi/Kconfig
@@ -51,6 +51,11 @@ config ACPI_APEI
     bool
     depends on ACPI
 
+config GHES_CPER
+    bool
+    depends on ACPI_APEI
+    default y
+
 config ACPI_PCI
     bool
     depends on ACPI && PCI
diff --git a/hw/acpi/ghes_cper.c b/hw/acpi/ghes_cper.c
new file mode 100644
index 000000000000..0d32874a84f1
--- /dev/null
+++ b/hw/acpi/ghes_cper.c
@@ -0,0 +1,53 @@
+/*
+ * ARM Processor error injection
+ *
+ * Copyright(C) 2024 Huawei LTD.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-ghes-cper.h"
+#include "hw/acpi/ghes.h"
+
+void qmp_ghes_cper(CommonPlatformErrorRecord *qmp_cper,
+                   Error **errp)
+{
+    unsigned int uuid_len = 0, i;
+    uint8List *p;
+    AcpiGhesCper cper;
+
+    for (p = qmp_cper->notification_type; p; p = p->next) {
+        uuid_len++;
+        if (uuid_len > 16) {
+            break;
+        }
+        cper.uuid[uuid_len - 1] = p->value;
+    }
+
+    if (uuid_len != 16) {
+        error_report("GHES CPER record has an invalid UUID size");
+        return;
+    }
+
+    cper.data_len = 0;
+
+    for (p = qmp_cper->raw_data; p; p = p->next) {
+        cper.data_len++;
+    }
+
+    cper.data = g_malloc(cper.data_len);
+
+    p = qmp_cper->raw_data;
+    for (i = 0; i < cper.data_len; i++, p = p->next) {
+        cper.data[i] = p->value;
+    }
+
+    /* TODO: call a function at ghes */
+
+    g_free(cper.data);
+}
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index fa5c07db9068..6cbf430eb66d 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -34,4 +34,6 @@ endif
 system_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c', 'acpi_interface.c'))
 system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridge-stub.c'))
 system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
+system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
+system_ss.add(when: 'CONFIG_GHES_CPER', if_false: files('ghes_cper_stub.c'))
 system_ss.add(files('acpi-qmp-cmds.c'))
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 1ad60da7aa2d..bed6ba27d715 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -712,3 +712,8 @@ config ARMSSE
     select UNIMP
     select SSE_COUNTER
     select SSE_TIMER
+
+config GHES_CPER
+    bool
+    depends on ARM
+    default y if AARCH64
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 33be1eb5acf4..02ea3715f655 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -78,6 +78,12 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
 int acpi_ghes_record_errors(uint8_t notify, uint64_t error_physical_addr);
 
+typedef struct AcpiGhesCper {
+    uint8_t uuid[16];
+    char *data;
+    uint32_t data_len;
+} AcpiGhesCper;
+
 /**
  * acpi_ghes_present: Report whether ACPI GHES table is present
  *
diff --git a/qapi/ghes-cper.json b/qapi/ghes-cper.json
new file mode 100644
index 000000000000..2b0438431054
--- /dev/null
+++ b/qapi/ghes-cper.json
@@ -0,0 +1,54 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+
+##
+# = GHESv2 CPER Error Injection
+#
+# These are defined at
+# ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2
+# (GHESv2 - Type 10)
+##
+
+##
+# @CommonPlatformErrorRecord:
+#
+# Common Platform Error Record - CPER - as defined at the UEFI
+# specification. See
+# https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#record-header
+# for more details.
+#
+# @notification-type: pre-assigned GUID value indicating the record
+#   association with an error event notification type, as defined
+#   at https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#record-header
+#
+# @raw-data: Contains the payload of the CPER.
+#
+# Since: 9.2
+##
+{ 'struct': 'CommonPlatformErrorRecord',
+  'data': {
+      'notification-type': ['uint8'],
+      'raw-data': ['uint8']
+  }
+}
+
+##
+# @ghes-cper:
+#
+# Inject ARM Processor error with data to be filled according with
+# ACPI 6.2 GHESv2 spec.
+#
+# @cper: a single CPER record to be sent to the guest OS.
+#
+# Features:
+#
+# @unstable: This command is experimental.
+#
+# Since: 9.2
+##
+{ 'command': 'ghes-cper',
+  'data': {
+    'cper': 'CommonPlatformErrorRecord'
+  },
+  'features': [ 'unstable' ]
+}
diff --git a/qapi/meson.build b/qapi/meson.build
index e7bc54e5d047..bd13cd7d40c9 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -35,6 +35,7 @@ qapi_all_modules = [
   'dump',
   'ebpf',
   'error',
+  'ghes-cper',
   'introspect',
   'job',
   'machine-common',
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index b1581988e4eb..54165c8d6655 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -81,3 +81,4 @@
 { 'include': 'vfio.json' }
 { 'include': 'cryptodev.json' }
 { 'include': 'cxl.json' }
+{ 'include': 'ghes-cper.json' }
-- 
2.45.2


