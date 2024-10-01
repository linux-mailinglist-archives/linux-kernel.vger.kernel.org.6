Return-Path: <linux-kernel+bounces-345811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B507998BB6D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0E31F2247B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9261C1746;
	Tue,  1 Oct 2024 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9HB2I3s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A5E1BF804
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782997; cv=none; b=OgQ9j4iGyfktPZK1FElVnoxs3/IPF0AQCEnA6JjsdAUjnMovgS1pNrzwivMCZCZ9pCLq0aZ8T7gYrJShG/+hCrZlcsDouH1YKK3z/aO3IYAAlO9XV3eE9GRMaV+ktgiwEciBjlkSbZ1E/Xkm4chSUSLvOzZcfllDoSozy5Zz3eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782997; c=relaxed/simple;
	bh=WMzyqBucezOMnHHpXmRsw3gT5aZdm3L5sQnhRw37Wa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=higqeMlmWdaOgDyWHPN9cKIFr6N3wijmTh01Wip1jbR3WzAtVs16+0Pvg15Nrwe6n3f5fl87p3pZVGLySLqQpScrfFiN7u5p/vnjgKtKt+qbwSi6CQG+NevPi/BId4UBq6Wr9FS2zfrnvCui6Dlj/3W0v7rb4fxfIEobFlJ5ppU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9HB2I3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91463C4AF0C;
	Tue,  1 Oct 2024 11:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727782996;
	bh=WMzyqBucezOMnHHpXmRsw3gT5aZdm3L5sQnhRw37Wa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l9HB2I3sX7gMOBxj8YsketMDNA2hnt0ErMnaMT1PMwbPckXgZ7gWjvJ79Lhw9GhnO
	 eKy5e7XczvQoy5g+0XeBX42hJ2JvsgqUmEhOcsUnYHxgPmfFyLkt7RLBpdtRoWQsyL
	 89CnC6h2LftQHKRCQJtoJSJDCaVQJ3FPmbR7u0+wxHw55xRQQdiAI75NtQLyOdCseW
	 vGAI1sQ6ruEDUhK/1AHRF8Q/BFyb+zCB6u5sVEwgBf2OXzZyUvM+U5SKQH1mX4lI4Z
	 dclhZLX8Ti8io5JKhAX6zy23Q+mp+Iaw6wXpu1JqEKgt66NyRyBTzf/aSZ14t+mU7H
	 MP/HhCKke95Jg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1svbHd-0000000Add4-3WEp;
	Tue, 01 Oct 2024 13:43:13 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	Eduardo Habkost <eduardo@habkost.net>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Yanan Wang <wangyanan55@huawei.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH RFC 4/5] acpi/generic_event_device: add logic to detect if HEST addr is available
Date: Tue,  1 Oct 2024 13:42:49 +0200
Message-ID: <176693e011a411db92be9e912bfc4a9da0e664b7.1727782588.git.mchehab+huawei@kernel.org>
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

Create a new property (x-has-hest-addr) and use it to detect if
the GHES table offsets can be calculated from the HEST address
(qemu 9.2 and upper) or via the legacy way via an offset obtained
from the hardware_errors firmware file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/generic_event_device.c | 1 +
 hw/acpi/ghes.c                 | 2 +-
 hw/core/machine.c              | 4 +++-
 include/hw/acpi/ghes.h         | 1 +
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 49ca1fb8e84a..c4677c9ae6b4 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -318,6 +318,7 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
 
 static Property acpi_ged_properties[] = {
     DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
+    DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState, ghes_state.hest_lookup, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 313a6e453af6..86bad865168c 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -513,7 +513,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
     }
     ags = &acpi_ged_state->ghes_state;
 
-    if (!ags->hest_addr_le) {
+    if (!ags->hest_lookup) {
         get_ghes_offsets(le64_to_cpu(ags->hw_error_le),
                          &cper_addr, &read_ack_register_addr);
     } else {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index adaba17ebac1..b58afe48aa71 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -34,7 +34,9 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "audio/audio.h"
 
-GlobalProperty hw_compat_9_1[] = {};
+GlobalProperty hw_compat_9_1[] = {
+    {"x-has-hest-addr", "false"},
+};
 const size_t hw_compat_9_1_len = G_N_ELEMENTS(hw_compat_9_1);
 
 GlobalProperty hw_compat_9_0[] = {
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index a07c30ef13b7..040d6ee366b2 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -61,6 +61,7 @@ typedef struct AcpiGhesState {
     uint64_t hest_addr_le;
     uint64_t hw_error_le;
     bool present; /* True if GHES is present at all on this board */
+    bool hest_lookup; /* True if HEST address is present */
 } AcpiGhesState;
 
 /*
-- 
2.46.1


