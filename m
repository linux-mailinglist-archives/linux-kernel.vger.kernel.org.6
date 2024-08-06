Return-Path: <linux-kernel+bounces-275925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D53948C02
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 298CAB23906
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DE41BD50E;
	Tue,  6 Aug 2024 09:16:03 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4ED1BC9E8
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 09:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722935762; cv=none; b=oqEFtUvJDvWjOKZAA7CLcDZKpAMtXTxpogqXNEojTX61TwWfpfNC4Fvdw+NLxKBAbIuTzNM6m20N2/rao/1uSkZPQvslWnJG8Yn08pzyukBoAPb0zVoPiCOm+QLPaEkOAmsycbA4SzmPUSSS+4d7rIPI2vU5U97sw2dUTrwRFBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722935762; c=relaxed/simple;
	bh=YIqj2O9EJr0Ey9WgxTFoPvM0Pa+oxYWwQ39cnF7YPTQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h39aJ/PTP5LGXHOK5ZqZfsdq3Z8YWQC13pNKbyS8ip2nZg9cK+yB8hUWM7tT61NZFXnYeQzCrx+WeBJG2fnykIOeB9+rfQ4WmbxkdKDcUFSu6EKaiB6Ta98PuFDhTMewBxwSqQLdKlRc8/jFv8ox8fUQLEV+dFFJcJ45x1pmPnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WdSJf1RGcz6H6nL;
	Tue,  6 Aug 2024 17:13:06 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 66A491404F9;
	Tue,  6 Aug 2024 17:15:56 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 10:15:56 +0100
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.039;
 Tue, 6 Aug 2024 10:15:56 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Dongjiu Geng
	<gengdongjiu1@gmail.com>, Eric Blake <eblake@redhat.com>, Igor Mammedov
	<imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth
	<michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
	<peter.maydell@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v5 5/7] qapi/ghes-cper: add an interface to do generic
 CPER error injection
Thread-Topic: [PATCH v5 5/7] qapi/ghes-cper: add an interface to do generic
 CPER error injection
Thread-Index: AQHa5SUrnXMtv9j2GEOPeOVXQpQotLIZ7iog
Date: Tue, 6 Aug 2024 09:15:56 +0000
Message-ID: <cf6581ad2d9846fbaf7ff8b5d424eeeb@huawei.com>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <51cbdc8a53e58c69ee17b15c398feeeeeeb64f34.1722634602.git.mchehab+huawei@kernel.org>
In-Reply-To: <51cbdc8a53e58c69ee17b15c398feeeeeeb64f34.1722634602.git.mchehab+huawei@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



>-----Original Message-----
>From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>Sent: 02 August 2024 22:44
>Cc: Jonathan Cameron <jonathan.cameron@huawei.com>; Shiju Jose
><shiju.jose@huawei.com>; Mauro Carvalho Chehab
><mchehab+huawei@kernel.org>; Michael S. Tsirkin <mst@redhat.com>; Ani
>Sinha <anisinha@redhat.com>; Dongjiu Geng <gengdongjiu1@gmail.com>; Eric
>Blake <eblake@redhat.com>; Igor Mammedov <imammedo@redhat.com>;
>Markus Armbruster <armbru@redhat.com>; Michael Roth
><michael.roth@amd.com>; Paolo Bonzini <pbonzini@redhat.com>; Peter
>Maydell <peter.maydell@linaro.org>; linux-kernel@vger.kernel.org; qemu-
>arm@nongnu.org; qemu-devel@nongnu.org
>Subject: [PATCH v5 5/7] qapi/ghes-cper: add an interface to do generic CPE=
R
>error injection
>
>Creates a QMP command to be used for generic ACPI APEI hardware error
>injection (HEST) via GHESv2.
>
>The actual GHES code will be added at the followup patch.
>
>Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Few minor comments inline.
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

>---
> MAINTAINERS              |  7 +++++
> hw/acpi/Kconfig          |  5 ++++
> hw/acpi/ghes_cper.c      | 45 ++++++++++++++++++++++++++++++++
> hw/acpi/ghes_cper_stub.c | 18 +++++++++++++
> hw/acpi/meson.build      |  2 ++
> hw/arm/Kconfig           |  5 ++++
> include/hw/acpi/ghes.h   |  7 +++++
> qapi/ghes-cper.json      | 55 ++++++++++++++++++++++++++++++++++++++++
> qapi/meson.build         |  1 +
> qapi/qapi-schema.json    |  1 +
> 10 files changed, 146 insertions(+)
> create mode 100644 hw/acpi/ghes_cper.c
> create mode 100644 hw/acpi/ghes_cper_stub.c  create mode 100644
>qapi/ghes-cper.json
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 98eddf7ae155..655edcb6688c 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -2075,6 +2075,13 @@ F: hw/acpi/ghes.c
> F: include/hw/acpi/ghes.h
> F: docs/specs/acpi_hest_ghes.rst
>
>+ACPI/HEST/GHES/ARM processor CPER
>+R: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>+S: Maintained
>+F: hw/arm/ghes_cper.c
>+F: hw/acpi/ghes_cper_stub.c
>+F: qapi/ghes-cper.json
>+
> ppc4xx
> L: qemu-ppc@nongnu.org
> S: Orphan
>diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig index
>e07d3204eb36..73ffbb82c150 100644
>--- a/hw/acpi/Kconfig
>+++ b/hw/acpi/Kconfig
>@@ -51,6 +51,11 @@ config ACPI_APEI
>     bool
>     depends on ACPI
>
>+config GHES_CPER
>+    bool
>+    depends on ACPI_APEI
>+    default y
>+
> config ACPI_PCI
>     bool
>     depends on ACPI && PCI
>diff --git a/hw/acpi/ghes_cper.c b/hw/acpi/ghes_cper.c new file mode 10064=
4
>index 000000000000..7aa7e71e90dc
>--- /dev/null
>+++ b/hw/acpi/ghes_cper.c
>@@ -0,0 +1,45 @@
>+/*
>+ * ARM Processor error injection
>+ *
>+ * Copyright(C) 2024 Huawei LTD.
>+ *
>+ * This code is licensed under the GPL version 2 or later. See the
>+ * COPYING file in the top-level directory.
>+ *
>+ */
>+
>+#include "qemu/osdep.h"
>+
>+#include "qemu/base64.h"
>+#include "qemu/error-report.h"
>+#include "qemu/uuid.h"
>+#include "qapi/qapi-commands-ghes-cper.h"
>+#include "hw/acpi/ghes.h"
>+
>+void qmp_ghes_cper(CommonPlatformErrorRecord *qmp_cper,
>+                   Error **errp)
>+{
>+    int rc;
>+    AcpiGhesCper cper;
>+    QemuUUID be_uuid, le_uuid;
>+
>+    rc =3D qemu_uuid_parse(qmp_cper->notification_type, &be_uuid);
>+    if (rc) {
>+        error_setg(errp, "GHES: Invalid UUID: %s",
>+                   qmp_cper->notification_type);
>+        return;
>+    }
>+
>+    le_uuid =3D qemu_uuid_bswap(be_uuid);
>+    cper.guid =3D le_uuid.data;
>+
>+    cper.data =3D qbase64_decode(qmp_cper->raw_data, -1,
>+                               &cper.data_len, errp);
>+    if (!cper.data) {
>+        return;
>+    }
>+
>+    /* TODO: call a function at ghes */
>+
>+    g_free(cper.data);
>+}
>diff --git a/hw/acpi/ghes_cper_stub.c b/hw/acpi/ghes_cper_stub.c new file
>mode 100644 index 000000000000..7ce6ed70a265
>--- /dev/null
>+++ b/hw/acpi/ghes_cper_stub.c
>@@ -0,0 +1,18 @@
>+/*
>+ * ARM Processor error injection
>+ *
>+ * Copyright(C) 2024 Huawei LTD.
>+ *
>+ * This code is licensed under the GPL version 2 or later. See the
>+ * COPYING file in the top-level directory.
>+ *
>+ */
>+
>+#include "qemu/osdep.h"
>+#include "qapi/error.h"
>+#include "qapi/qapi-commands-ghes-cper.h"
>+#include "hw/acpi/ghes.h"
>+
>+void qmp_ghes_cper(CommonPlatformErrorRecord *cper, Error **errp) { }
May be add an unsupported or similar log in the stub function?=20

>diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build index
>fa5c07db9068..6cbf430eb66d 100644
>--- a/hw/acpi/meson.build
>+++ b/hw/acpi/meson.build
>@@ -34,4 +34,6 @@ endif
> system_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c', 'aml-bu=
ild-
>stub.c', 'ghes-stub.c', 'acpi_interface.c'))
> system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridge=
-
>stub.c'))
> system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
>+system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
>+system_ss.add(when: 'CONFIG_GHES_CPER', if_false:
>+files('ghes_cper_stub.c'))
> system_ss.add(files('acpi-qmp-cmds.c'))
>diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig index
>1ad60da7aa2d..bed6ba27d715 100644
>--- a/hw/arm/Kconfig
>+++ b/hw/arm/Kconfig
>@@ -712,3 +712,8 @@ config ARMSSE
>     select UNIMP
>     select SSE_COUNTER
>     select SSE_TIMER
>+
>+config GHES_CPER
>+    bool
>+    depends on ARM
>+    default y if AARCH64
>diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h index
>33be1eb5acf4..06a5b8820cd5 100644
>--- a/include/hw/acpi/ghes.h
>+++ b/include/hw/acpi/ghes.h
>@@ -23,6 +23,7 @@
> #define ACPI_GHES_H
>
> #include "hw/acpi/bios-linker-loader.h"
>+#include "qapi/error.h"
> #include "qemu/notify.h"
>
> extern NotifierList generic_error_notifiers; @@ -78,6 +79,12 @@ void
>acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                           GArray *hardware_errors);  int
>acpi_ghes_record_errors(uint8_t notify, uint64_t error_physical_addr);
>
>+typedef struct AcpiGhesCper {
>+    uint8_t *guid;
>+    uint8_t *data;
>+    size_t data_len;
>+} AcpiGhesCper;
>+
> /**
>  * acpi_ghes_present: Report whether ACPI GHES table is present
>  *
>diff --git a/qapi/ghes-cper.json b/qapi/ghes-cper.json new file mode 10064=
4
>index 000000000000..3cc4f9f2aaa9
>--- /dev/null
>+++ b/qapi/ghes-cper.json
>@@ -0,0 +1,55 @@
>+# -*- Mode: Python -*-
>+# vim: filetype=3Dpython
>+
>+##
>+# =3D GHESv2 CPER Error Injection
>+#
>+# These are defined at
>+# ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2 # (GHESv2
>+- Type 10) ##
>+
>+##
>+# @CommonPlatformErrorRecord:
>+#
>+# Common Platform Error Record - CPER - as defined at the UEFI #
>+specification.  See #
>+https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.htm
>+l#record-header
>+# for more details.
>+#
>+# @notification-type: pre-assigned GUID string indicating the record
>+#   association with an error event notification type, as defined
>+#   at
>https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html
>#record-header
>+#
>+# @raw-data: Contains a base64 encoded string with the payload of
>+#   the CPER.
>+#
>+# Since: 9.2
>+##
>+{ 'struct': 'CommonPlatformErrorRecord',
>+  'data': {
>+      'notification-type': 'str',
>+      'raw-data': 'str'
>+  }
>+}
>+
>+##
>+# @ghes-cper:
>+#
>+# Inject ARM Processor error with data to be filled according with #
>+ACPI 6.2 GHESv2 spec.
 Since ghes-cper is  generic interface, mentioning term "ARM Processor erro=
r" here may not be appropriate? =20

>+#
>+# @cper: a single CPER record to be sent to the guest OS.
>+#
>+# Features:
>+#
>+# @unstable: This command is experimental.
>+#
>+# Since: 9.2
>+##
>+{ 'command': 'ghes-cper',
>+  'data': {
>+    'cper': 'CommonPlatformErrorRecord'
>+  },
>+  'features': [ 'unstable' ]
>+}
>diff --git a/qapi/meson.build b/qapi/meson.build index
>e7bc54e5d047..bd13cd7d40c9 100644
>--- a/qapi/meson.build
>+++ b/qapi/meson.build
>@@ -35,6 +35,7 @@ qapi_all_modules =3D [
>   'dump',
>   'ebpf',
>   'error',
>+  'ghes-cper',
>   'introspect',
>   'job',
>   'machine-common',
>diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json index
>b1581988e4eb..c1a267399fe5 100644
>--- a/qapi/qapi-schema.json
>+++ b/qapi/qapi-schema.json
>@@ -75,6 +75,7 @@
> { 'include': 'misc-target.json' }
> { 'include': 'audio.json' }
> { 'include': 'acpi.json' }
>+{ 'include': 'ghes-cper.json' }
> { 'include': 'pci.json' }
> { 'include': 'stats.json' }
> { 'include': 'virtio.json' }
>--
>2.45.2

Thanks,
Shiju

