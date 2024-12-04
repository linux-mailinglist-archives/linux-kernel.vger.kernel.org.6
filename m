Return-Path: <linux-kernel+bounces-430664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 683089E343C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F075FB27C47
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 07:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DED818FDB1;
	Wed,  4 Dec 2024 07:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJ8XBERW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B5218E028
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298153; cv=none; b=j+seSHFoUAd9u8S97lkHYu2egtijjTyc3GAjJDLtVfB3ylfjbHTlju9r9fo3yqG0wXnrccjS+rfspGaI7wexoVR8/PjLSGQmYjI73rLbBnPl310Fm98WYwzwT2gbid/JkF6ma+9EDjf5t5OTz4i3fd6AVE9b9A9sYs+g9xr5wms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298153; c=relaxed/simple;
	bh=PPyhW6VsW+yo+jj9o/izTT956e12rFUm5rYlBvONhoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itTqUhyE84lhC5Xfveg6m2xEHjf/fqyWwGAGZ+VPmfYJb8CcEyPc4n+vQFsbKTvntx4vd6KjY7qVXc4IyTMUTNWXTVJbFEwcSAv8SY4a82PDcJc3IZUPBgI5ptHVe3dKObjpA8SoGqzzwfTRxNv13ZFPTQxjc6/9KSpTtjVu4xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJ8XBERW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CA9C4CEE3;
	Wed,  4 Dec 2024 07:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733298153;
	bh=PPyhW6VsW+yo+jj9o/izTT956e12rFUm5rYlBvONhoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DJ8XBERWRFmjXTGFjdtz+V4WEC/5Pv4Nd9dmhR5QRKDHErXAg1C3smig7ab9ZRAOY
	 hUZ5LBbcxP73LIiByGw8DJkp3Z0CK+IXm35xC10xoT+3gRv8Rm3cKAZlWZGpzpQTdO
	 a3itGBiIArjJ/Wnju0gqTlVRBF6RCxU2sUhguwmVLxaeklvh3lHUYIIkpL+dkx2mYL
	 hbsFAIBIq+TNgwHDeFBvx7JeyPho6FnH8ZwxXA+JImrfiQEsVEmp7+TUvZ+SLKNCqs
	 /ltZI8BVingWE8TjFnqYEYejJr0QZOkBQwJU6++B0beyKlRvHbpOWA5XVUHkCg4dD4
	 vKXbIp0oRfG8A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tIk1n-00000004Kj6-0Tim;
	Wed, 04 Dec 2024 08:42:31 +0100
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
Subject: [PATCH v5 07/16] acpi/ghes: Change the type for source_id
Date: Wed,  4 Dec 2024 08:41:15 +0100
Message-ID: <905c6c7329c39bde6f67f6f6636245de8baeca14.1733297707.git.mchehab+huawei@kernel.org>
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

As described at: ACPI 6.5 spec at:
	18.3.2. ACPI Error Source

In particular at GHES/GHESv2 table:
	Table 18.10 Generic Hardware Error Source Structure

HEST source ID is actually a 16-bit value.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/ghes-stub.c    | 2 +-
 hw/acpi/ghes.c         | 2 +-
 include/hw/acpi/ghes.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
index c315de1802d6..2b64cbd2819a 100644
--- a/hw/acpi/ghes-stub.c
+++ b/hw/acpi/ghes-stub.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/ghes.h"
 
-int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
+int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
 {
     return -1;
 }
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 5f67322bf0f2..edc74c38bf8a 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -383,7 +383,7 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
     ags->present = true;
 }
 
-int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
+int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
 {
     uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
     uint64_t start_addr;
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 50e3a25ea384..9295e46be25e 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -73,7 +73,7 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
                      const char *oem_id, const char *oem_table_id);
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
-int acpi_ghes_record_errors(uint8_t source_id, uint64_t error_physical_addr);
+int acpi_ghes_record_errors(uint16_t source_id, uint64_t error_physical_addr);
 
 /**
  * acpi_ghes_present: Report whether ACPI GHES table is present
-- 
2.47.1


