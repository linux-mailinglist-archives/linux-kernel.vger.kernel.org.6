Return-Path: <linux-kernel+bounces-337985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2230C9851DA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 06:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D562A2811CB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 04:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBA1158533;
	Wed, 25 Sep 2024 04:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7HNZwap"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B484914E2C0
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 04:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727237088; cv=none; b=jIjZx0RXQL0xYxQHv70qqlH2SpBIwd4q8WoxniY04PPhA26E4ZaNP/ltMlObLYG73ymPdSOZKhl0nZsD5ZTFEIMl1FzwjLZt9Vcy8up3n1fN49MmOpwNwz5iMxbl9IgjxAmtQuebSgO/M2Da3+NkhHpCQXnZlgS6NPbfP08fxMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727237088; c=relaxed/simple;
	bh=EPNa3UpkebUjcFO0jhrd/3A1k55FLfyHJyyXhy8vljw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRXm+Gb9K3jmI4nqKSB0Sg3V8btANTUsOsMtJnmg8x8aSOor8HE1Drp9VAKsYlNU2RaHECZmmh8/TzKlBRtXqQiTgCSlVAZBTBnzDBbYxLPpPJ7B7uYfzxRMsSMiU0kyEfcNVpl1Zx0WYtDKNUE50ciYbh5QD7wPu8ow9BbHaY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7HNZwap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D6EC4CEDB;
	Wed, 25 Sep 2024 04:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727237088;
	bh=EPNa3UpkebUjcFO0jhrd/3A1k55FLfyHJyyXhy8vljw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H7HNZwap8YuDFEhVgTnBWrtr0SIkRjPteonQ0lp59gxEiqbHoHeqdaNYqRhBW9Bh5
	 DQkFYLkw/8OFcJu39ReVm0nRoJn1Lzd7pwmmi8SRHIgOgEpp3WFBC/K0wAYqVeKpaq
	 m03uHTk+u2lEx7z/EHgQBcbi3jn0X9nU1RHki9FkqUF94D0zpThgVDIOjaX/bneJ7x
	 3spVCxmqTnDu15gzZ+SBUSA0IJrYnHEQLGEWcPaEsg9ucuUpB8suYyWXkSWTKQX+IW
	 bGOpvGezG/RHUUJ/j5UbTaeOAF8N2dttUKV5u1XNiZfLn/kBEuIXIMcY3TcgC2qOCO
	 jz7Tt/VsZwHRg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1stJGg-0000000828X-1m1D;
	Wed, 25 Sep 2024 06:04:46 +0200
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
Subject: [PATCH 14/15] better name the offset of the hardware error firmware
Date: Wed, 25 Sep 2024 06:04:19 +0200
Message-ID: <94dec32ef07d95940ee63445f151899ae7b430b3.1727236561.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1727236561.git.mchehab+huawei@kernel.org>
References: <cover.1727236561.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The hardware error firmware is where HEST error structures are
stored. Those can be GHESv2, but they can also be other types.

Better name the location of the hardware error.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/generic_event_device.c | 4 ++--
 hw/acpi/ghes.c                 | 4 ++--
 include/hw/acpi/ghes.h         | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 15b4c3ebbf24..d4dbfb45e181 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -346,7 +346,7 @@ static const VMStateDescription vmstate_ghes = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
+        VMSTATE_UINT64(hw_error_le, AcpiGhesState),
         VMSTATE_END_OF_LIST()
     },
 };
@@ -354,7 +354,7 @@ static const VMStateDescription vmstate_ghes = {
 static bool ghes_needed(void *opaque)
 {
     AcpiGedState *s = opaque;
-    return s->ghes_state.ghes_addr_le;
+    return s->ghes_state.hw_error_le;
 }
 
 static const VMStateDescription vmstate_ghes_state = {
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 3d03506fdaf8..8b3292be07e7 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -379,7 +379,7 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
 
     /* Create a read-write fw_cfg file for Address */
     fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
-        NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);
+        NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
 
     ags->present = true;
 }
@@ -430,7 +430,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
     }
     ags = &acpi_ged_state->ghes_state;
 
-    get_ghes_offsets(le64_to_cpu(ags->ghes_addr_le),
+    get_ghes_offsets(le64_to_cpu(ags->hw_error_le),
                      &cper_addr, &read_ack_register_addr);
 
     if (!cper_addr) {
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 051a9322141f..e47ffacbb5c9 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -58,7 +58,7 @@ enum AcpiGhesNotifyType {
 };
 
 typedef struct AcpiGhesState {
-    uint64_t ghes_addr_le;
+    uint64_t hw_error_le;
     bool present; /* True if GHES is present at all on this board */
 } AcpiGhesState;
 
-- 
2.46.1


