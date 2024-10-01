Return-Path: <linux-kernel+bounces-345810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B527498BB70
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38D00B2188E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6A01C1744;
	Tue,  1 Oct 2024 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqkLMWwq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A071A00EE
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782997; cv=none; b=KjjVozLbBPIQXm0onJvZc5Q3I35nqTjpXv4fDnOi3vR3C83s+Wv96xBQG6v5XfCpJ8uY40NZq3EIvaGubN6Tw9/rEDcxyeYqddZDRmfS4Wb2Ex8OrLoIrIdbaC6bzyUFXXSguYb3HB5d9SqTOzM381LNNOvNNItme2bn+xtKzgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782997; c=relaxed/simple;
	bh=IyUOOIPt26ymtGpZVs8Q3SZ/F5X7AIWjPA1DhypfsoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAkJI+tCHrxJAKgPsBfqaB5MFaZZ+nESoZd1cr+9bAM2WPKCkO+74aBTMnnlxeQ26eB3S5inp3rBbuHqjB/5GHSwxt6SiqtV9+UcoybOAHAJWSghOA3nLGm+dSd4Ejh+4BGmkov1FSkYeCh0jlZ/Y9+gwz/KCP3ntXFQcmDc880=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqkLMWwq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CB5C4CED1;
	Tue,  1 Oct 2024 11:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727782996;
	bh=IyUOOIPt26ymtGpZVs8Q3SZ/F5X7AIWjPA1DhypfsoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MqkLMWwqY4LgSRssHKEOUG8SdbQoskVNezXq0ZLvCnHxw5RAMZoXBUg92txi1lzu8
	 FCGzX+oDVbXdDsnSLKhsTC1b/hWGmqURIg+x+dmMSjXkedwzZD2yWIIvFpREEHORT/
	 NN99RYPUfzk779N7GUDTtJDMK4i2qAGpeaBUoUiuYW5lhtb+yCsFwkDlh2lGDQl+SY
	 I998W4eVY6yuiEw0+HORF0Ipz8fkqWlLCRwGNJ8D8SR3oHYrcKWAfP4or5rrn3U7ig
	 GjDQl24qfdpxIbSYre5o7mYDsEZMFDdip8aSWENiYyX4GwJvzlZnjrHyvT+gNrZ3IE
	 z26nyMabNTPEg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1svbHd-0000000Add8-3d7C;
	Tue, 01 Oct 2024 13:43:13 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Shannon Zhao <shannon.zhaosl@gmail.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH RFC 5/5] arm/virt-acpi-build: Properly handle virt-9.1
Date: Tue,  1 Oct 2024 13:42:50 +0200
Message-ID: <2b5b4e57eb5332c83789d4bd0f01214861cc7f0a.1727782588.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1727782588.git.mchehab+huawei@kernel.org>
References: <cover.1727782588.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

A virt-9.1 machine can have only one source ID.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/arm/virt-acpi-build.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 476c365851c4..8036eb5953d0 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -894,6 +894,10 @@ static const AcpiNotificationSourceId hest_ghes_notify[] = {
     {ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA},
 };
 
+static const AcpiNotificationSourceId hest_ghes_notify_9_1[] = {
+    {ACPI_HEST_SRC_ID_QMP, ACPI_GHES_NOTIFY_GPIO},
+};
+
 static
 void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 {
@@ -947,10 +951,28 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     build_dbg2(tables_blob, tables->linker, vms);
 
     if (vms->ras) {
-        acpi_add_table(table_offsets, tables_blob);
-        acpi_build_hest(tables_blob, tables->hardware_errors, tables->linker,
-                        hest_ghes_notify, ARRAY_SIZE(hest_ghes_notify),
-                        vms->oem_id, vms->oem_table_id);
+        AcpiGhesState *ags;
+        AcpiGedState *acpi_ged_state;
+
+        acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
+                                                       NULL));
+        if (acpi_ged_state) {
+            ags = &acpi_ged_state->ghes_state;
+
+            acpi_add_table(table_offsets, tables_blob);
+
+            if (!ags->hest_lookup) {
+                acpi_build_hest(tables_blob, tables->hardware_errors,
+                                tables->linker, hest_ghes_notify_9_1,
+                                ARRAY_SIZE(hest_ghes_notify_9_1),
+                                vms->oem_id, vms->oem_table_id);
+            } else {
+                acpi_build_hest(tables_blob, tables->hardware_errors,
+                                tables->linker, hest_ghes_notify,
+                                ARRAY_SIZE(hest_ghes_notify),
+                                vms->oem_id, vms->oem_table_id);
+            }
+        }
     }
 
     if (ms->numa_state->num_nodes > 0) {
-- 
2.46.1


