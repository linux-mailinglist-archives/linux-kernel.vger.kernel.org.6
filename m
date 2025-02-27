Return-Path: <linux-kernel+bounces-536083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0943A47B47
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE933AC687
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B3D232392;
	Thu, 27 Feb 2025 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrVgsis/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93CD22B8AB
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654239; cv=none; b=MOVX2HmBhFWTCauqI1Q9CazRdlGhF5oy9xL835KvWDgZOIH97rgfNegCl2bZGexDfJBGQJzlJA5+2DEuQ7oPNN2jX1E123bh5ujyKuif+KP4sd8NiE5mhoeTF1dgranPghGTm9fimE3U63cmksd3j9jknNuCxFONYIZRA2Syb0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654239; c=relaxed/simple;
	bh=7pWw0XPiGki8/osmgRZp7rIVqK77bpRTth1SrWLV1Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HS1W1mcJC++aeQEU+aP5ZWKXcDTmNRLyeaumxPXEndiiu5YwQeWKOkXhvZNWXSUbUQlHDnSGqWvoXQiCjmByVre4DBTyeGxRjIWWBSFCy+2NyBs4jIPESYE9LRMla7YnINyxCnRjc/V+jQ02NKPOcWTE7ck/9xYUvBl4aJeO5Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrVgsis/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D1DC4CEFC;
	Thu, 27 Feb 2025 11:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740654238;
	bh=7pWw0XPiGki8/osmgRZp7rIVqK77bpRTth1SrWLV1Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NrVgsis/zn+myqn0+9KBshDOnUajifwe45W6qqXdJxkxytd/qe1U72OwyBl/cYx9H
	 ttHMT7q79Df1e3urEjp+0I/lx8ixWYa/N9iWzTx1Wg+rWC6pjiG/EyFCbry40lA68W
	 xDOqGT2PqxtnNJmprFym/AEJRpf9Oh2Ereg/zk41GUwEvKIS0qt7BmQi6AEcHecP+P
	 HHyJAF3nyuxNOMWDyMtGMHqeNhK7fqSou4m7JNOULUadOtLxCnNO7thmppRYmGDpvm
	 umR/ABeioL+jIDOG/xO8E86TCb7++HRSpNG0/ToLrSI2cnluMMEifOFasB14tnun7O
	 AO+MWk6gZh5uQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tnbgK-00000001mRa-1o9X;
	Thu, 27 Feb 2025 12:03:56 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	Eric Blake <eblake@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Michael Roth <michael.roth@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Shannon Zhao <shannon.zhaosl@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 16/21] qapi/acpi-hest: add an interface to do generic CPER error injection
Date: Thu, 27 Feb 2025 12:03:46 +0100
Message-ID: <8744d8db3a6bfb6560758ac8f34f923d456aa007.1740653898.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740653898.git.mchehab+huawei@kernel.org>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Creates a QMP command to be used for generic ACPI APEI hardware error
injection (HEST) via GHESv2, and add support for it for ARM guests.

Error injection uses ACPI_HEST_SRC_ID_QMP source ID to be platform
independent. This is mapped at arch virt bindings, depending on the
types supported by QEMU and by the BIOS. So, on ARM, this is supported
via ACPI_GHES_NOTIFY_GPIO notification type.

This patch is co-authored:
    - original ghes logic to inject a simple ARM record by Shiju Jose;
    - generic logic to handle block addresses by Jonathan Cameron;
    - generic GHESv2 error inject by Mauro Carvalho Chehab;

Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS              |  7 +++++++
 hw/acpi/Kconfig          |  5 +++++
 hw/acpi/ghes.c           |  2 +-
 hw/acpi/ghes_cper.c      | 38 ++++++++++++++++++++++++++++++++++++++
 hw/acpi/ghes_cper_stub.c | 19 +++++++++++++++++++
 hw/acpi/meson.build      |  2 ++
 hw/arm/virt-acpi-build.c |  1 +
 hw/arm/virt.c            |  7 +++++++
 include/hw/acpi/ghes.h   |  1 +
 include/hw/arm/virt.h    |  1 +
 qapi/acpi-hest.json      | 35 +++++++++++++++++++++++++++++++++++
 qapi/meson.build         |  1 +
 qapi/qapi-schema.json    |  1 +
 13 files changed, 119 insertions(+), 1 deletion(-)
 create mode 100644 hw/acpi/ghes_cper.c
 create mode 100644 hw/acpi/ghes_cper_stub.c
 create mode 100644 qapi/acpi-hest.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 1911949526ce..7358735007c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2081,6 +2081,13 @@ F: hw/acpi/ghes.c
 F: include/hw/acpi/ghes.h
 F: docs/specs/acpi_hest_ghes.rst
 
+ACPI/HEST/GHES/ARM processor CPER
+R: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+S: Maintained
+F: hw/arm/ghes_cper.c
+F: hw/acpi/ghes_cper_stub.c
+F: qapi/acpi-hest.json
+
 ppc4xx
 L: qemu-ppc@nongnu.org
 S: Orphan
diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
index 1d4e9f0845c0..daabbe6cd11e 100644
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
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 0135ac844bcf..1d02ef6dcb70 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -553,7 +553,7 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
     /* Write the generic error data entry into guest memory */
     cpu_physical_memory_write(cper_addr, cper, len);
 
-    notifier_list_notify(&acpi_generic_error_notifiers, NULL);
+    notifier_list_notify(&acpi_generic_error_notifiers, &source_id);
 }
 
 int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
diff --git a/hw/acpi/ghes_cper.c b/hw/acpi/ghes_cper.c
new file mode 100644
index 000000000000..0a2d95dd8b27
--- /dev/null
+++ b/hw/acpi/ghes_cper.c
@@ -0,0 +1,38 @@
+/*
+ * CPER payload parser for error injection
+ *
+ * Copyright(C) 2024-2025 Huawei LTD.
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
+#include "qapi/qapi-commands-acpi-hest.h"
+#include "hw/acpi/ghes.h"
+
+void qmp_inject_ghes_v2_error(const char *qmp_cper, Error **errp)
+{
+    AcpiGhesState *ags;
+
+    ags = acpi_ghes_get_state();
+    if (!ags) {
+        return;
+    }
+
+    uint8_t *cper;
+    size_t  len;
+
+    cper = qbase64_decode(qmp_cper, -1, &len, errp);
+    if (!cper) {
+        error_setg(errp, "missing GHES CPER payload");
+        return;
+    }
+
+    ghes_record_cper_errors(ags, cper, len, ACPI_HEST_SRC_ID_QMP, errp);
+}
diff --git a/hw/acpi/ghes_cper_stub.c b/hw/acpi/ghes_cper_stub.c
new file mode 100644
index 000000000000..5ebc61970a78
--- /dev/null
+++ b/hw/acpi/ghes_cper_stub.c
@@ -0,0 +1,19 @@
+/*
+ * Stub interface for CPER payload parser for error injection
+ *
+ * Copyright(C) 2024-2025 Huawei LTD.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-acpi-hest.h"
+#include "hw/acpi/ghes.h"
+
+void qmp_inject_ghes_v2_error(const char *cper, Error **errp)
+{
+    error_setg(errp, "GHES QMP error inject is not compiled in");
+}
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index 73f02b96912b..56b5d1ec9691 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -34,4 +34,6 @@ endif
 system_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c', 'acpi_interface.c'))
 system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridge-stub.c'))
 system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
+system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
+system_ss.add(when: 'CONFIG_GHES_CPER', if_false: files('ghes_cper_stub.c'))
 system_ss.add(files('acpi-qmp-cmds.c'))
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 841078f65880..eb580459f271 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -896,6 +896,7 @@ static void acpi_align_size(GArray *blob, unsigned align)
 
 static const AcpiNotificationSourceId hest_ghes_notify[] = {
     { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
+    { ACPI_HEST_SRC_ID_QMP, ACPI_GHES_NOTIFY_GPIO },
 };
 
 static const AcpiNotificationSourceId hest_ghes_notify_9_2[] = {
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3faf32f900b5..116428ab582e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1012,6 +1012,13 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
 
 static void virt_generic_error_req(Notifier *n, void *opaque)
 {
+    uint16_t *source_id = opaque;
+
+    /* Currently, only QMP source ID is async */
+    if (*source_id != ACPI_HEST_SRC_ID_QMP) {
+        return;
+    }
+
     VirtMachineState *s = container_of(n, VirtMachineState, generic_error_notifier);
 
     acpi_send_event(s->acpi_dev, ACPI_GENERIC_ERROR);
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index bf9f3de27122..2a5ac3d20c76 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -65,6 +65,7 @@ enum AcpiGhesNotifyType {
  */
 enum AcpiGhesSourceID {
     ACPI_HEST_SRC_ID_SYNC,
+    ACPI_HEST_SRC_ID_QMP,       /* Use it only for QMP injected errors */
 };
 
 typedef struct AcpiNotificationSourceId {
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index f3cf28436770..56f270f61cf5 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -33,6 +33,7 @@
 #include "exec/hwaddr.h"
 #include "qemu/notify.h"
 #include "hw/boards.h"
+#include "hw/acpi/ghes.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/bsa.h"
 #include "hw/block/flash.h"
diff --git a/qapi/acpi-hest.json b/qapi/acpi-hest.json
new file mode 100644
index 000000000000..fff5018c7ec1
--- /dev/null
+++ b/qapi/acpi-hest.json
@@ -0,0 +1,35 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+
+##
+# == GHESv2 CPER Error Injection
+#
+# Defined since ACPI Specification 6.1,
+# section 18.3.2.8 Generic Hardware Error Source version 2. See:
+#
+# https://uefi.org/sites/default/files/resources/ACPI_6_1.pdf
+##
+
+
+##
+# @inject-ghes-v2-error:
+#
+# Inject an error with additional ACPI 6.1 GHESv2 error information
+#
+# @cper: contains a base64 encoded string with raw data for a single
+#     CPER record with Generic Error Status Block, Generic Error Data
+#     Entry and generic error data payload, as described at
+#     https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#format
+#
+# Features:
+#
+# @unstable: This command is experimental.
+#
+# Since: 10.0
+##
+{ 'command': 'inject-ghes-v2-error',
+  'data': {
+    'cper': 'str'
+  },
+  'features': [ 'unstable' ]
+}
diff --git a/qapi/meson.build b/qapi/meson.build
index e7bc54e5d047..35cea6147262 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -59,6 +59,7 @@ qapi_all_modules = [
 if have_system
   qapi_all_modules += [
     'acpi',
+    'acpi-hest',
     'audio',
     'cryptodev',
     'qdev',
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index b1581988e4eb..baf19ab73afe 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -75,6 +75,7 @@
 { 'include': 'misc-target.json' }
 { 'include': 'audio.json' }
 { 'include': 'acpi.json' }
+{ 'include': 'acpi-hest.json' }
 { 'include': 'pci.json' }
 { 'include': 'stats.json' }
 { 'include': 'virtio.json' }
-- 
2.48.1


