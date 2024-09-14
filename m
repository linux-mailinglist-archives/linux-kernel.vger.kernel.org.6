Return-Path: <linux-kernel+bounces-329164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 334EC978E3B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 08:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43DA91C2291B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 06:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FF0147C86;
	Sat, 14 Sep 2024 06:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYOIxiJ/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFB5629E4
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 06:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726294434; cv=none; b=L4LIP4Np+EbEDs2Sdeq9LIbaWveltncA5HVXb0tn38jYPZnlNGHC2yDIn5i4YTrNRXVkkIq7pdJ+0IIBUSnlC94HV5JQMJQeoH82QzuDwKhfkPr/XGL1pqABu0k5WkK4bRP0sSrzZtGP4DETK4KUpDPgxOqA3BBvOZW3G1cemmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726294434; c=relaxed/simple;
	bh=vpDuK1QOOxW/nhXim4UoOwQVPFVm8z+z0ABlhDW3SxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPedszZ2c5xtZ1Tnd6gvfiAMYNsuX0aGFZ50Gy5YHcyLlK78PyI6vv5Xv9PXpPnc6wZlip5OmTM54HtCgNUXb/pmC0y6nC1+2XogNzdaIb4a88qCzyc72CpBmeEe4KT3dVTZHvxtEPDIzJ4jmZhWvQ9NcyymY3GE705CrhF9i+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYOIxiJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04459C4CED1;
	Sat, 14 Sep 2024 06:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726294434;
	bh=vpDuK1QOOxW/nhXim4UoOwQVPFVm8z+z0ABlhDW3SxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VYOIxiJ/A/QYzgOAFp31F2+2pZuGt+OAL7PxzpOjtJ1f35xLUhxJN/gWjVZ6UTRJ2
	 jXAQWmu2ijiFrY9HOyc9QCCNA1ZW6ssQ02XeipW0NQH3IUFIVD5hr3PbBQdPgY8xvt
	 dcx0KKMzOpju1G2bOBiluid0p3ChUePkg/HD10jnZ1zSFLl/9EJLIIEzmmdMG7edgL
	 3RMLkjP71R69B3oAZL3OxmjiNys0lCUfLmmXIxj+ScYmF7hcMvR3CQ2Lt4NQrjUWCe
	 FPsr0sp2UrV+wkF4WDIGkfat3+PU4eS9UFeULL+4hGe3j37EOplV8XVvWdbwgr0R2Y
	 Dh7mND7JVVAZQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1spM2a-00000003V5v-0bm1;
	Sat, 14 Sep 2024 08:13:52 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v10 08/21] acpi/ghes: Change the type for source_id
Date: Sat, 14 Sep 2024 08:13:29 +0200
Message-ID: <64de87ae9e03e9be6cb98dc75e2eb02503354904.1726293808.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726293808.git.mchehab+huawei@kernel.org>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

HEST source ID is actually a 16-bit value. Yet, make it a little
bit more generic using just an integer type.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes-stub.c    | 2 +-
 hw/acpi/ghes.c         | 2 +-
 include/hw/acpi/ghes.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
index c315de1802d6..58a04e935142 100644
--- a/hw/acpi/ghes-stub.c
+++ b/hw/acpi/ghes-stub.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/ghes.h"
 
-int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
+int acpi_ghes_record_errors(int source_id, uint64_t physical_address)
 {
     return -1;
 }
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 6e5f0e8cf0c9..4e34b16a6ca9 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -416,7 +416,7 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
     ags->present = true;
 }
 
-int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
+int acpi_ghes_record_errors(int source_id, uint64_t physical_address)
 {
     uint64_t hest_read_ack_start_addr, read_ack_start_addr;
     uint64_t hest_addr, cper_addr, err_source_struct;
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 7485f54c28f2..6471934d7775 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -75,7 +75,7 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
                      const char *oem_id, const char *oem_table_id);
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
-int acpi_ghes_record_errors(uint8_t source_id,
+int acpi_ghes_record_errors(int source_id,
                             uint64_t error_physical_addr);
 void ghes_record_cper_errors(const void *cper, size_t len,
                              uint16_t source_id, Error **errp);
-- 
2.46.0


