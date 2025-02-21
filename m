Return-Path: <linux-kernel+bounces-525924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CDDA3F761
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14913188D482
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F154A213E89;
	Fri, 21 Feb 2025 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3aSV6eQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7163321018F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148536; cv=none; b=KRsUK5sAVRGpKarosXh+C3GNJC1k3EBSZwXz/8+fTcqccVXkFCq9Zul8EP77/GXw6RzxEGfvyjs165wdSfipCJFLM0uzd2sNUjll7uoMSajjyy7ah1sw+xbb2QLXm0XKJOrt2rcAkwFhp/htQoGyxPEtTbhc2jA3jIRmuYQsfeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148536; c=relaxed/simple;
	bh=WNgUSU0OrqFnvTXh8PzzTv6ghTQeysRMH1deXYrrJ9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=li2l5zVOto0NQ4EMSgcHVq0g0IGKQob0yBYcnM5HbCf+iBwCTvUbn9AXX1cHRynelpeiVBhfVCvalbZ10d3qqIAD7wcWGbIipxrglIO2REaUkgV/WHbN2/q9dpck8B0iVm4i2hyfDo4v/yYoLhPLd9xmwfd9hPVElqIvkjEE8Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3aSV6eQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9942BC4AF0B;
	Fri, 21 Feb 2025 14:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740148535;
	bh=WNgUSU0OrqFnvTXh8PzzTv6ghTQeysRMH1deXYrrJ9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k3aSV6eQBcdel1uaTYsqdAzZg53CxDtf/ggXqNM2fCOrOFXs9IxheY9kYUwgoUktW
	 5vSQAB3kD2Yuzib4dJVN8GC2ZruGrS6SDXOF20SEkV6/YHQwGVtS4XrcjtFYym3VQ5
	 YTkQe5vnXFUKi2uP5VWTSdkgQxwT2FqkasFOHKXQ7ODUuLMTnoWuiKNlgovVjzCbwF
	 A0t8CpsI/9/lkPtm9oSQj6Myp4veIA/vsMZLPllUlQQ+KfLMPb+Yyc4z6EwR8fmLHU
	 YfJzQphtNLlZErAIiVqjgaaGMWb7lG2/kvbYsrwHiH8lbYVDO2kyUfdXJTkl8Iigqu
	 FWPgRX0qX34WQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tlU7m-00000002jDz-39BU;
	Fri, 21 Feb 2025 15:35:30 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ani Sinha <anisinha@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/14] acpi/generic_event_device: Update GHES migration to cover hest addr
Date: Fri, 21 Feb 2025 15:35:16 +0100
Message-ID: <f771a4766ed29483f0be0e68741ca07b010ad5ce.1740148260.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740148260.git.mchehab+huawei@kernel.org>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The GHES migration logic should now support HEST table location too.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/generic_event_device.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index c85d97ca3776..5346cae573b7 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -386,6 +386,34 @@ static const VMStateDescription vmstate_ghes_state = {
     }
 };
 
+static const VMStateDescription vmstate_hest = {
+    .name = "acpi-hest",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(hest_addr_le, AcpiGhesState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static bool hest_needed(void *opaque)
+{
+    AcpiGedState *s = opaque;
+    return s->ghes_state.hest_addr_le;
+}
+
+static const VMStateDescription vmstate_hest_state = {
+    .name = "acpi-ged/hest",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = hest_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
+                       vmstate_hest, AcpiGhesState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_acpi_ged = {
     .name = "acpi-ged",
     .version_id = 1,
@@ -398,6 +426,7 @@ static const VMStateDescription vmstate_acpi_ged = {
         &vmstate_memhp_state,
         &vmstate_cpuhp_state,
         &vmstate_ghes_state,
+        &vmstate_hest_state,
         NULL
     }
 };
-- 
2.48.1


