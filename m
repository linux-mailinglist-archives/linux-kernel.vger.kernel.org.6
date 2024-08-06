Return-Path: <linux-kernel+bounces-276030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5A7948D7A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5B61C21433
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996401C231C;
	Tue,  6 Aug 2024 11:13:32 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C25143C4B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722942812; cv=none; b=eOUia3tFK0Qz5j3lysfmpWYiJ3cQ/iHFTLAxXGIqNZTyVjVMepT+UHdfoFv9xFkyNeZuQMZetkKXpDyu/RyVty8pA/nutsszBBEBipM5oWI2kvOQL/3dVoHMIQ1XmlFEcF0ahGFNR9RIRx8v9lBZjkmTbuBzvp5ss0RF0xmvXFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722942812; c=relaxed/simple;
	bh=sKgteq022n2PL+FDhwndU4jU1OgLpwLaMFAYVYvWkJU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aoAA4mNd5AYfpixYiyWfopm1uMtL11SHmdg5WJ6CtimYJuAUkjqJhuVM7KGHFUY8vFclAL6AdORopqOUBPo+rehkBBJkd5TUV0Pzg4PIDIgCbFKg7hu97+Q4uWNaKFQ2dsIvJbkDvie39PwPF+egV1/NvhFgFWf9jFGWp0K3vVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WdVwL6TShz6K7Fc;
	Tue,  6 Aug 2024 19:10:42 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
	by mail.maildlp.com (Postfix) with ESMTPS id 19489140B3C;
	Tue,  6 Aug 2024 19:13:26 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 12:13:25 +0100
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.039;
 Tue, 6 Aug 2024 12:13:25 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Dongjiu Geng
	<gengdongjiu1@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Subject: RE: [PATCH v5 6/7] acpi/ghes: add support for generic error injection
 via QAPI
Thread-Topic: [PATCH v5 6/7] acpi/ghes: add support for generic error
 injection via QAPI
Thread-Index: AQHa5SUqlFywcvx4lEKDYS91pOZMWrIaGOEQ
Date: Tue, 6 Aug 2024 11:13:25 +0000
Message-ID: <e41d0c8cc8b54643adc318c1bb7bd26c@huawei.com>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
In-Reply-To: <20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
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
>Sinha <anisinha@redhat.com>; Dongjiu Geng <gengdongjiu1@gmail.com>; Igor
>Mammedov <imammedo@redhat.com>; linux-kernel@vger.kernel.org; qemu-
>arm@nongnu.org; qemu-devel@nongnu.org
>Subject: [PATCH v5 6/7] acpi/ghes: add support for generic error injection=
 via
>QAPI
>
>Provide a generic interface for error injection via GHESv2.
>
>This patch is co-authored:
>    - original ghes logic to inject a simple ARM record by Shiju Jose;
>    - generic logic to handle block addresses by Jonathan Cameron;
>    - generic GHESv2 error inject by Mauro Carvalho Chehab;
>
>Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
>Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Cc: Shiju Jose <shiju.jose@huawei.com>
>Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

>---
> hw/acpi/ghes.c         | 159 ++++++++++++++++++++++++++++++++++++++---
> hw/acpi/ghes_cper.c    |   2 +-
> include/hw/acpi/ghes.h |   3 +
> 3 files changed, 152 insertions(+), 12 deletions(-)
>
>diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c index
>a745dcc7be5e..e125c9475773 100644
>--- a/hw/acpi/ghes.c
>+++ b/hw/acpi/ghes.c
>@@ -395,23 +395,22 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags,
>FWCfgState *s,
>     ags->present =3D true;
> }
>
>+static uint64_t ghes_get_state_start_address(void)
>+{
>+    AcpiGedState *acpi_ged_state =3D
>+        ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED, NULL));
>+    AcpiGhesState *ags =3D &acpi_ged_state->ghes_state;
>+
>+    return le64_to_cpu(ags->ghes_addr_le); }
>+
> int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)=
  {
>     uint64_t error_block_addr, read_ack_register_addr, read_ack_register =
=3D 0;
>-    uint64_t start_addr;
>+    uint64_t start_addr =3D ghes_get_state_start_address();
>     bool ret =3D -1;
>-    AcpiGedState *acpi_ged_state;
>-    AcpiGhesState *ags;
>-
>     assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
>
>-    acpi_ged_state =3D ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GE=
D,
>-                                                       NULL));
>-    g_assert(acpi_ged_state);
>-    ags =3D &acpi_ged_state->ghes_state;
>-
>-    start_addr =3D le64_to_cpu(ags->ghes_addr_le);
>-
>     if (physical_address) {
>         start_addr +=3D source_id * sizeof(uint64_t);
>
>@@ -448,9 +447,147 @@ int acpi_ghes_record_errors(uint8_t source_id,
>uint64_t physical_address)
>     return ret;
> }
>
>+/*
>+ * Error register block data layout
>+ *
>+ * | +---------------------+ ges.ghes_addr_le
>+ * | |error_block_address0 |
>+ * | +---------------------+
>+ * | |error_block_address1 |
>+ * | +---------------------+ --+--
>+ * | |    .............    | GHES_ADDRESS_SIZE
>+ * | +---------------------+ --+--
>+ * | |error_block_addressN |
>+ * | +---------------------+
>+ * | | read_ack0           |
>+ * | +---------------------+ --+--
>+ * | | read_ack1           | GHES_ADDRESS_SIZE
>+ * | +---------------------+ --+--
>+ * | |   .............     |
>+ * | +---------------------+
>+ * | | read_ackN           |
>+ * | +---------------------+ --+--
>+ * | |      CPER           |   |
>+ * | |      ....           | GHES_MAX_RAW_DATA_LENGT
>+ * | |      CPER           |   |
>+ * | +---------------------+ --+--
>+ * | |    ..........       |
>+ * | +---------------------+
>+ * | |      CPER           |
>+ * | |      ....           |
>+ * | |      CPER           |
>+ * | +---------------------+
>+ */
>+
>+/* Map from uint32_t notify to entry offset in GHES */ static const
>+uint8_t error_source_to_index[] =3D { 0xff, 0xff, 0xff, 0xff,
>+                                                 0xff, 0xff, 0xff, 1,
>+0};
>+
>+static bool ghes_get_addr(uint32_t notify, uint64_t *error_block_addr,
>+                          uint64_t *read_ack_addr) {
>+    uint64_t base;
>+
>+    if (notify >=3D ACPI_GHES_NOTIFY_RESERVED) {
>+        return false;
>+    }
>+
>+    /* Find and check the source id for this new CPER */
>+    if (error_source_to_index[notify] =3D=3D 0xff) {
>+        return false;
>+    }
>+
>+    base =3D ghes_get_state_start_address();
>+
>+    *read_ack_addr =3D base +
>+        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
>+        error_source_to_index[notify] * sizeof(uint64_t);
>+
>+    /* Could also be read back from the error_block_address register */
>+    *error_block_addr =3D base +
>+        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
>+        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
>+        error_source_to_index[notify] * ACPI_GHES_MAX_RAW_DATA_LENGTH;
>+
>+    return true;
>+}
>+
> NotifierList generic_error_notifiers =3D
>     NOTIFIER_LIST_INITIALIZER(error_device_notifiers);
>
>+void ghes_record_cper_errors(AcpiGhesCper *cper, Error **errp,
>+                             uint32_t notify) {
>+    int read_ack =3D 0;
>+    uint32_t i;
>+    uint64_t read_ack_addr =3D 0;
>+    uint64_t error_block_addr =3D 0;
>+    uint32_t data_length;
>+    GArray *block;
>+
>+    if (!ghes_get_addr(notify, &error_block_addr, &read_ack_addr)) {
>+        error_setg(errp, "GHES: Invalid error block/ack address(es)");
>+        return;
>+    }
>+
>+    cpu_physical_memory_read(read_ack_addr,
>+                             &read_ack, sizeof(uint64_t));
>+
>+    /* zero means OSPM does not acknowledge the error */
>+    if (!read_ack) {
>+        error_setg(errp,
>+                   "Last CPER record was not acknowledged yet");
>+        read_ack =3D 1;
>+        cpu_physical_memory_write(read_ack_addr,
>+                                  &read_ack, sizeof(uint64_t));
>+        return;
>+    }
>+
>+    read_ack =3D cpu_to_le64(0);
>+    cpu_physical_memory_write(read_ack_addr,
>+                              &read_ack, sizeof(uint64_t));
>+
>+    /* Build CPER record */
>+
>+    /*
>+     * Invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
>+     * Table 17-13 Generic Error Data Entry
>+     */
>+    QemuUUID fru_id =3D {};
>+
>+    block =3D g_array_new(false, true /* clear */, 1);
>+    data_length =3D ACPI_GHES_DATA_LENGTH + cper->data_len;
>+
>+    /*
>+        * It should not run out of the preallocated memory if
>+        * adding a new generic error data entry
>+        */
>+    assert((data_length + ACPI_GHES_GESB_SIZE) <=3D
>+            ACPI_GHES_MAX_RAW_DATA_LENGTH);
>+
>+    /* Build the new generic error status block header */
>+    acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE,
>+                                    0, 0, data_length,
>+                                    ACPI_CPER_SEV_RECOVERABLE);
>+
>+    /* Build this new generic error data entry header */
>+    acpi_ghes_generic_error_data(block, cper->guid,
>+                                ACPI_CPER_SEV_RECOVERABLE, 0, 0,
>+                                cper->data_len, fru_id, 0);
>+
>+    /* Add CPER data */
>+    for (i =3D 0; i < cper->data_len; i++) {
>+        build_append_int_noprefix(block, cper->data[i], 1);
>+    }
>+
>+    /* Write the generic error data entry into guest memory */
>+    cpu_physical_memory_write(error_block_addr, block->data,
>+ block->len);
>+
>+    g_array_free(block, true);
>+
>+    notifier_list_notify(&generic_error_notifiers, NULL); }
>+
> bool acpi_ghes_present(void)
> {
>     AcpiGedState *acpi_ged_state;
>diff --git a/hw/acpi/ghes_cper.c b/hw/acpi/ghes_cper.c index
>7aa7e71e90dc..d7ff7debee74 100644
>--- a/hw/acpi/ghes_cper.c
>+++ b/hw/acpi/ghes_cper.c
>@@ -39,7 +39,7 @@ void qmp_ghes_cper(CommonPlatformErrorRecord
>*qmp_cper,
>         return;
>     }
>
>-    /* TODO: call a function at ghes */
>+    ghes_record_cper_errors(&cper, errp, ACPI_GHES_NOTIFY_GPIO);
>
>     g_free(cper.data);
> }
>diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h index
>06a5b8820cd5..ee6f6cd96911 100644
>--- a/include/hw/acpi/ghes.h
>+++ b/include/hw/acpi/ghes.h
>@@ -85,6 +85,9 @@ typedef struct AcpiGhesCper {
>     size_t data_len;
> } AcpiGhesCper;
>
>+void ghes_record_cper_errors(AcpiGhesCper *cper, Error **errp,
>+                             uint32_t notify);
>+
> /**
>  * acpi_ghes_present: Report whether ACPI GHES table is present
>  *
>--
>2.45.2


