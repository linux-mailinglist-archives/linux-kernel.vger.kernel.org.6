Return-Path: <linux-kernel+bounces-273175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B69A894653C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379201F2213D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B00913BAE5;
	Fri,  2 Aug 2024 21:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNahGYBM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A65130A7C
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722635064; cv=none; b=C92lJB9DASj+255zGREPcNKqLLE7mcoXS3u5JY5IQvmw8Z0bgyHwNmgo3SeSVwkIZsPvG/kUhDUVjzxl+5LZB0pFxwyF+HxxGM99b9gAtASk+RKUfnmoiGsCLeYWHQ0VAhnvlFyMiyG5kdjUJShHkXFR+loKmG6pCnfs2GBAH34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722635064; c=relaxed/simple;
	bh=GnUXlC1iZIgwbN3LEYc4i/jTC5ISOQaQxV76+UJ2Bvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKPlxVqnZeUVW4Tw9dHBFbLSMgDKSEiVmjK4aSwI5e66P1+4kmZr5r7pWCsYzGknzNCW/Q4SBVLwRC1AfCriuTwViYc1uvgrhTvrLmWa7KIoAwkzVKUcIywYCV4qcyT8ylSJSpnTmtRtQIqLMXDZhYVu5BtuJ34N99Zy+tXdpw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNahGYBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A50C32782;
	Fri,  2 Aug 2024 21:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722635063;
	bh=GnUXlC1iZIgwbN3LEYc4i/jTC5ISOQaQxV76+UJ2Bvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tNahGYBMQdlFaaKnXJnsNdhZ56yhScx/2bY+QMKd5CtFRUfGGb5HvUCDrDd/02+Kh
	 YrW0C4boN/WszsbR7u5eHlHfwYji14eVdCf1i//6S5Y7gnhMEhKVMQm/HJjdiqOY3q
	 dMI1TGbTzTNHan8vq1ARdY/fOYQN8y0HGNb52RMVj4oX9PVcqq270YsyodcnTCE8Cj
	 eYvnFBc+SovP0U+cjMxBjZg+we330zqm2Cy/QUwDGdf3fOwBY5RpZCuV4hJ1BzJksp
	 s9xMxP0V/NiV+OYBLgRvEHR5bips4ft4okDEvWd+NIlJsY7pu64QxNBUztYprEKBZu
	 GvUwBvoNg+0uQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1sa04T-00000002naT-35wP;
	Fri, 02 Aug 2024 23:44:21 +0200
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
Subject: [PATCH v5 5/7] qapi/ghes-cper: add an interface to do generic CPER error injection
Date: Fri,  2 Aug 2024 23:44:00 +0200
Message-ID: <51cbdc8a53e58c69ee17b15c398feeeeeeb64f34.1722634602.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722634602.git.mchehab+huawei@kernel.org>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Creates a QMP command to be used for generic ACPI APEI hardware error
injection (HEST) via GHESv2.

The actual GHES code will be added at the followup patch.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS              |  7 +++++
 hw/acpi/Kconfig          |  5 ++++
 hw/acpi/ghes_cper.c      | 45 ++++++++++++++++++++++++++++++++
 hw/acpi/ghes_cper_stub.c | 18 +++++++++++++
 hw/acpi/meson.build      |  2 ++
 hw/arm/Kconfig           |  5 ++++
 include/hw/acpi/ghes.h   |  7 +++++
 qapi/ghes-cper.json      | 55 ++++++++++++++++++++++++++++++++++++++++
 qapi/meson.build         |  1 +
 qapi/qapi-schema.json    |  1 +
 10 files changed, 146 insertions(+)
 create mode 100644 hw/acpi/ghes_cper.c
 create mode 100644 hw/acpi/ghes_cper_stub.c
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
index 000000000000..7aa7e71e90dc
--- /dev/null
+++ b/hw/acpi/ghes_cper.c
@@ -0,0 +1,45 @@
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
+
+#include "qemu/base64.h"
+#include "qemu/error-report.h"
+#include "qemu/uuid.h"
+#include "qapi/qapi-commands-ghes-cper.h"
+#include "hw/acpi/ghes.h"
+
+void qmp_ghes_cper(CommonPlatformErrorRecord *qmp_cper,
+                   Error **errp)
+{
+    int rc;
+    AcpiGhesCper cper;
+    QemuUUID be_uuid, le_uuid;
+
+    rc = qemu_uuid_parse(qmp_cper->notification_type, &be_uuid);
+    if (rc) {
+        error_setg(errp, "GHES: Invalid UUID: %s",
+                   qmp_cper->notification_type);
+        return;
+    }
+
+    le_uuid = qemu_uuid_bswap(be_uuid);
+    cper.guid = le_uuid.data;
+
+    cper.data = qbase64_decode(qmp_cper->raw_data, -1,
+                               &cper.data_len, errp);
+    if (!cper.data) {
+        return;
+    }
+
+    /* TODO: call a function at ghes */
+
+    g_free(cper.data);
+}
diff --git a/hw/acpi/ghes_cper_stub.c b/hw/acpi/ghes_cper_stub.c
new file mode 100644
index 000000000000..7ce6ed70a265
--- /dev/null
+++ b/hw/acpi/ghes_cper_stub.c
@@ -0,0 +1,18 @@
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
+#include "qapi/error.h"
+#include "qapi/qapi-commands-ghes-cper.h"
+#include "hw/acpi/ghes.h"
+
+void qmp_ghes_cper(CommonPlatformErrorRecord *cper, Error **errp)
+{
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
index 33be1eb5acf4..06a5b8820cd5 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -23,6 +23,7 @@
 #define ACPI_GHES_H
 
 #include "hw/acpi/bios-linker-loader.h"
+#include "qapi/error.h"
 #include "qemu/notify.h"
 
 extern NotifierList generic_error_notifiers;
@@ -78,6 +79,12 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
 int acpi_ghes_record_errors(uint8_t notify, uint64_t error_physical_addr);
 
+typedef struct AcpiGhesCper {
+    uint8_t *guid;
+    uint8_t *data;
+    size_t data_len;
+} AcpiGhesCper;
+
 /**
  * acpi_ghes_present: Report whether ACPI GHES table is present
  *
diff --git a/qapi/ghes-cper.json b/qapi/ghes-cper.json
new file mode 100644
index 000000000000..3cc4f9f2aaa9
--- /dev/null
+++ b/qapi/ghes-cper.json
@@ -0,0 +1,55 @@
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
+# specification.  See
+# https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#record-header
+# for more details.
+#
+# @notification-type: pre-assigned GUID string indicating the record
+#   association with an error event notification type, as defined
+#   at https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#record-header
+#
+# @raw-data: Contains a base64 encoded string with the payload of
+#   the CPER.
+#
+# Since: 9.2
+##
+{ 'struct': 'CommonPlatformErrorRecord',
+  'data': {
+      'notification-type': 'str',
+      'raw-data': 'str'
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
index b1581988e4eb..c1a267399fe5 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -75,6 +75,7 @@
 { 'include': 'misc-target.json' }
 { 'include': 'audio.json' }
 { 'include': 'acpi.json' }
+{ 'include': 'ghes-cper.json' }
 { 'include': 'pci.json' }
 { 'include': 'stats.json' }
 { 'include': 'virtio.json' }
-- 
2.45.2


