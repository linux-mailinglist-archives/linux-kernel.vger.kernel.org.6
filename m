Return-Path: <linux-kernel+bounces-279451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BDC94BD7F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AED91C22A50
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF6D18FC8C;
	Thu,  8 Aug 2024 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8ihsHNY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F16A18C934
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120003; cv=none; b=b1WWqIp2jN3x7oyjnlK6mf2ir7fChtwjy9MorZttQ7IYygaUk3qmhRC9OrjmyYdYqhd4TfuuxCNCKZ81BdMTV36J9gFAsxWP8eCf/1hqIBPdakUNFw84nLSqQvE+ueEyaOn5CH5NcK2GKWeXhLO1598nFweHb+A018TjIykqcUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120003; c=relaxed/simple;
	bh=DqGykFu1jG3JtlVqxIFokAXnHANj1wNOdFBp0jaEKBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nC/7V29zIl85iHJWYCIEOc0/ScPaaipIFOuV3u0BbWRbL0RBBx0Jx7Neg2CPlDRlTwdDD4yGWdl/NF8Ou8KYHLgUU+r2nzm9ojrsHuouAP6Vespp3VwCv9MDrX7pIfmSYTSUB/Hy7XDePjEiNY8NqMtm8m9zDxvNt8pqST8jIjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8ihsHNY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DE2C4AF13;
	Thu,  8 Aug 2024 12:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723120003;
	bh=DqGykFu1jG3JtlVqxIFokAXnHANj1wNOdFBp0jaEKBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H8ihsHNYUwD+ZeNdtnoqEsgYCOf9F0TFDyhat1sX6PnWHJYkaOsXspAnuYrXrb27J
	 IYrW3jJx2B5vcngmrnhIkT3FAQAlhr+vUhpGa3w6by/j4qhs564MgQHWulsEMhq6i9
	 O8rqYZpgMdUCmim3DFEzfcgMK792VTVA9VYse6SqnR1fbs5EfFoaSnFET1HeENeP1N
	 C0T+mzmQJtw21sJ90WP4EFn+aEUCPetOePM6qCBwTkcRjg3cKaPy6btAMWCUaoam3S
	 US3eUSrDKZtRnji5P1vBgFLGvcVsCkWaV10+sbB54Q5fnbm90m3xUYxgz0bGAgu/Nd
	 cKdVNEke/TYcg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1sc2E4-00000000oDO-3q7E;
	Thu, 08 Aug 2024 14:26:40 +0200
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
Subject: [PATCH v6 04/10] qapi/ghes-cper: add an interface to do generic CPER error injection
Date: Thu,  8 Aug 2024 14:26:30 +0200
Message-ID: <87799362699e4349ce4a44f3d25698d5764735c6.1723119423.git.mchehab+huawei@kernel.org>
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

Creates a QMP command to be used for generic ACPI APEI hardware error
injection (HEST) via GHESv2.

The actual GHES code will be added at the followup patch.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 MAINTAINERS              |  7 +++++
 hw/acpi/Kconfig          |  5 ++++
 hw/acpi/ghes_cper.c      | 45 ++++++++++++++++++++++++++++++++
 hw/acpi/ghes_cper_stub.c | 19 ++++++++++++++
 hw/acpi/meson.build      |  2 ++
 hw/arm/Kconfig           |  5 ++++
 include/hw/acpi/ghes.h   |  7 +++++
 qapi/ghes-cper.json      | 55 ++++++++++++++++++++++++++++++++++++++++
 qapi/meson.build         |  1 +
 qapi/qapi-schema.json    |  1 +
 10 files changed, 147 insertions(+)
 create mode 100644 hw/acpi/ghes_cper.c
 create mode 100644 hw/acpi/ghes_cper_stub.c
 create mode 100644 qapi/ghes-cper.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 10af21263293..a0c36f9b5d0c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2077,6 +2077,13 @@ F: hw/acpi/ghes.c
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
index 000000000000..2358e039b181
--- /dev/null
+++ b/hw/acpi/ghes_cper_stub.c
@@ -0,0 +1,19 @@
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
+    error_setg(errp, "GHES QMP error inject is not compiled in");
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
index ce6f82a1155a..a7a18c7b50cf 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -23,6 +23,7 @@
 #define ACPI_GHES_H
 
 #include "hw/acpi/bios-linker-loader.h"
+#include "qapi/error.h"
 #include "qemu/notify.h"
 
 extern NotifierList acpi_generic_error_notifiers;
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


