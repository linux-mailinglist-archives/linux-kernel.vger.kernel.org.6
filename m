Return-Path: <linux-kernel+bounces-430665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 043069E343B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2DBB167FFF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 07:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195B318FDBC;
	Wed,  4 Dec 2024 07:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sozOBgIy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BA118E02A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298153; cv=none; b=lN5okWf5FLhHn/izBYuNSAUAg3WxE4jdrlL4ON0w6CvNsl9WaNID9rQG2Wq0FxEk/kL9GL740RJe4vUSgI4XEqzfpOzyIRXBubDVC5ea3NrRKw0rtMRki4zpkkyAHx+zyuGWpGL95B7J8S8YK+LZawHl8iINjrlBScOCEXRolCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298153; c=relaxed/simple;
	bh=WpC/WWVfFKAeHGzqCpuL7CrOqSUL9tc8JrM8fpL82sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AANG0D7w3KFcM5us2RxXRcxtGY2ESFX1bVQMnb6Yz8bSVV5UoXTUMlRnEMIGUHoC67KWmda6XJOY2cC3qdVs6PuGLGXRZbRrwTbuzIq2M3u7KBonYhipoWzJPWyT7recSuyAhlKusb6o/loef/uQp9ctemcvxk+gD/TL+JRv/1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sozOBgIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB05C4CEE5;
	Wed,  4 Dec 2024 07:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733298153;
	bh=WpC/WWVfFKAeHGzqCpuL7CrOqSUL9tc8JrM8fpL82sA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sozOBgIyoTmdDcqWlHvwaC7qMgGAu0fMbQPiEErorL490dHR8ssKpRWpWjFPfIFs/
	 /w4XvNNZmqmgBuoB+C5PhtaEgbh53TDbQkOF3Dfx8hcwM3awXdUUlX13wjANoLBiln
	 UTCDUPj6coarkAj8WFsXi+ruCK8qHfNWRy9XxCGmC5zI0fH04oau+bJIqLU33/Vkln
	 OClY1yuWfIq4WRjtzqkB7/tM6JW2eDoSfA4H1ea0JHScFkxppmg1laTMigy6W4NDns
	 AZhjbBgwDY9l9/szN93zs4fOefJKaySs46fuE3aK/kETR1hUxOm/EpglYofChUllvh
	 sEc8bbKCzNFVw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tIk1n-00000004Kiq-02QW;
	Wed, 04 Dec 2024 08:42:31 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Shannon Zhao <shannon.zhaosl@gmail.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v5 03/16] acpi/ghes: simplify the per-arch caller to build HEST table
Date: Wed,  4 Dec 2024 08:41:11 +0100
Message-ID: <0617c0652412212cc34ba182a93b55fa0b12cc90.1733297707.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733297707.git.mchehab+huawei@kernel.org>
References: <cover.1733297707.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The GHES driver requires not only a HEST table, but also a
separate firmware file to store Error Structure records.
It can't do one without the other.

Simplify the caller logic for it to require one function.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

---

Changes from v10:
- Removed the logic which associates notification and source
  ID. This will be placed on a separate patch.

Changes from v8:
- Non-rename/cleanup changes merged altogether;
- source ID is now more generic, defined per guest target.
  That should make easier to add support for 86.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c           | 7 +++++--
 hw/arm/virt-acpi-build.c | 5 ++---
 include/hw/acpi/ghes.h   | 4 ++--
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index e66f3be1502b..4a6c45bcb4be 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -233,7 +233,7 @@ static int acpi_ghes_record_mem_error(uint64_t error_block_address,
  * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cfg blobs.
  * See docs/specs/acpi_hest_ghes.rst for blobs format.
  */
-void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
+static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
 {
     int i, error_status_block_offset;
 
@@ -356,12 +356,15 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
 }
 
 /* Build Hardware Error Source Table */
-void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
+void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
+                     BIOSLinker *linker,
                      const char *oem_id, const char *oem_table_id)
 {
     AcpiTable table = { .sig = "HEST", .rev = 1,
                         .oem_id = oem_id, .oem_table_id = oem_table_id };
 
+    build_ghes_error_table(hardware_errors, linker);
+
     acpi_table_begin(&table, table_data);
 
     /* Error Source Count */
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 620992c92c12..e059317b002e 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -942,10 +942,9 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     build_dbg2(tables_blob, tables->linker, vms);
 
     if (vms->ras) {
-        build_ghes_error_table(tables->hardware_errors, tables->linker);
         acpi_add_table(table_offsets, tables_blob);
-        acpi_build_hest(tables_blob, tables->linker, vms->oem_id,
-                        vms->oem_table_id);
+        acpi_build_hest(tables_blob, tables->hardware_errors, tables->linker,
+                        vms->oem_id, vms->oem_table_id);
     }
 
     if (ms->numa_state->num_nodes > 0) {
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 59e3b8fb24b9..20016c226d1f 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -68,8 +68,8 @@ typedef struct AcpiGhesState {
     bool present; /* True if GHES is present at all on this board */
 } AcpiGhesState;
 
-void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker);
-void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
+void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
+                     BIOSLinker *linker,
                      const char *oem_id, const char *oem_table_id);
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
-- 
2.47.1


