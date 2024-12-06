Return-Path: <linux-kernel+bounces-435396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 738D79E76FE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045631882B6D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E7A21B1AC;
	Fri,  6 Dec 2024 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7TK5J34"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F1020456F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505688; cv=none; b=VSU32pupyY7u8w02WasaEllKJxxWy1xz8CEBxZbAyrOa/sZLTaUB3CSlWQKp9CS0kMzjoDsUFxn9YQaqzs5ph9d6kxowwzKGFG8EXNssw8IdGZOXWp0R4EH8050VK/tEtx0m0NMxZ73JOOStF2clt+q1JuSQQIwSR8E4GcmNLwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505688; c=relaxed/simple;
	bh=b69HHmbxNrBqg55Yd1AraPonts1JMQymrFJS7+Ypliw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLTkXxso+PFzKyEYBCphhLU1yplquiaoNEHr3lcPHam7Dt1BfZfYDhKhEgU0v7WJk923341cTdQ5m3/Dyzc8orzxnIm29d9pFIAiQ6YAqN8BBcmPxQIyqNSwyXRFDsvICjX4k7ZmXAMiF8AOZMufvCH56BsyWTatEXx5YShj8y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7TK5J34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDC6C4CEEA;
	Fri,  6 Dec 2024 17:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505687;
	bh=b69HHmbxNrBqg55Yd1AraPonts1JMQymrFJS7+Ypliw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o7TK5J34v8vVAVYL9MvxviGP8hFpqijKi0A4AhYcTCtnsrQE8Olu/Lut98h/cC1wX
	 sLW2xFhxVzdqjuTLxgZMobkV7NCY5aSyZmuPTlKvWHCEb8B10Jqt1OfLAw/RHGZ9Ej
	 YVNCG5eK2npYC75wU2LSBNiPOgOEyj760YH8qnZbha53csdvTI5kKpFPsjlg5fQ4Dj
	 rtLGr+iw6pwEcipUoootnjrN1eugUvdub0QJx0ikbvdZaZSo5HS1pcq2aDd+IO0hD3
	 NtBXTRcXqtkhnglSRBi6t3tpAE3vt3xIcxemGEG0dsdci4VdzZ5xhv6nLMlA09lutc
	 O6qddpa4kwpqw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tJc17-00000005RKM-3Sj6;
	Fri, 06 Dec 2024 18:21:25 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 13/31] acpi/ghes: better name the offset of the hardware error firmware
Date: Fri,  6 Dec 2024 18:12:35 +0100
Message-ID: <a8c89525bfd8137dbf1209ef72d603c523aad82c.1733504943.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733504943.git.mchehab+huawei@kernel.org>
References: <cover.1733504943.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The etc/hardware_errors fw_cfg file is where the HEST error
source structures store registers pointed by Generic Address
Structures, as defined at:

	https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#generic-error-data-entry

and

	https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#generic-hardware-error-source-version-2-ghesv2-structure

As the name of the firmware file is hardware_errors, better
name the variable where the offset pointing to it will be stored
from ghes_error_le to hw_error_le.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/generic_event_device.c | 4 ++--
 hw/acpi/ghes.c                 | 4 ++--
 include/hw/acpi/ghes.h         | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 663d9cb09380..17baf36132a8 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -364,7 +364,7 @@ static const VMStateDescription vmstate_ghes = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
+        VMSTATE_UINT64(hw_error_le, AcpiGhesState),
         VMSTATE_END_OF_LIST()
     },
 };
@@ -372,7 +372,7 @@ static const VMStateDescription vmstate_ghes = {
 static bool ghes_needed(void *opaque)
 {
     AcpiGedState *s = opaque;
-    return s->ghes_state.ghes_addr_le;
+    return s->ghes_state.hw_error_le;
 }
 
 static const VMStateDescription vmstate_ghes_state = {
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 52c2b69d3664..90d76b9c2d8c 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -359,7 +359,7 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
 
     /* Create a read-write fw_cfg file for Address */
     fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
-        NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);
+        NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
 
     ags->present = true;
 }
@@ -385,7 +385,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
     }
     ags = &acpi_ged_state->ghes_state;
 
-    start_addr = le64_to_cpu(ags->ghes_addr_le);
+    start_addr = le64_to_cpu(ags->hw_error_le);
 
     start_addr += source_id * sizeof(uint64_t);
 
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 21666a4bcc8b..39619a2457cb 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -65,7 +65,7 @@ enum {
 };
 
 typedef struct AcpiGhesState {
-    uint64_t ghes_addr_le;
+    uint64_t hw_error_le;
     bool present; /* True if GHES is present at all on this board */
 } AcpiGhesState;
 
-- 
2.47.1


