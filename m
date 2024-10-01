Return-Path: <linux-kernel+bounces-345813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 328B198BB6E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC322816B9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8CF1C174A;
	Tue,  1 Oct 2024 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgNzPOKR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AAB1BF81B
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782997; cv=none; b=JydIZO7s2/m286wwKCyysk7tXQTSS8tCshXD0w+BI0ntRsBXwXIRAaohBMVg0dkMIaC8css4YTkkrXyHioX/Quq1ptIN+7icNVwmFAszSgMYwEHH+rghhYHAZgjpeHjkFdDVIwdfPx/Tzjd8GwvGGnp3p0DSOROEMYXKQ2V4/vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782997; c=relaxed/simple;
	bh=OmsP3DqrqNm0WJLhnZV1GEFEXlt09IzMH8EXulzidmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=peBzrY5Zd2dcRWUZnsdSWxUZBaq95Z37VI1YLJu4T5ArDyGt3esP7KNi9Kkxf50WXa4E7dj40YRp5znU7svj493VOYil8k//KzeD5OTrTMGDeZry0sK9PV78VRAJY1YzjKSvlH4iGT00tV6SK8GozhOaelcUOuFjgB04DU4/vdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgNzPOKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914B0C4AF0D;
	Tue,  1 Oct 2024 11:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727782996;
	bh=OmsP3DqrqNm0WJLhnZV1GEFEXlt09IzMH8EXulzidmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tgNzPOKRN3kMxoU5WMSAUQzW2EvlbnxZopmlN5TrHv0Cz5c4zGJr70gVk7RW197Uq
	 7ZVRnfrdSVu97awYB0UtdAUFBEcG61cVcug9VGRc1+70tZcDim4JqRiEtdAvIQgqDN
	 FaReNMJctAcU/tX4haTAPUpth9Nj303q64Lf5jL6Y+d91SS4Z5sF6Zv9EMx2pBGTOD
	 cDcavJuMrcCZjS3uz7PwTharullU8GxBDUjQIuS+t9UCTMCkGOygCfiQemzGQJU3FM
	 yR4XyAuNIZ6/tRNWZEqauDuXIp5+mSWwr+h0T74c0uZe4nNkB6eIcDsdvOXUP268ng
	 NR0IUROGMbZzA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1svbHd-0000000Adcy-3PHC;
	Tue, 01 Oct 2024 13:43:13 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	linux-kernel@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH RFC 3/5] acpi/generic_event_device: Update GHES migration to cover hest addr
Date: Tue,  1 Oct 2024 13:42:48 +0200
Message-ID: <d29cdf2bbb67c660142841c2d854db280c18e5e0.1727782588.git.mchehab+huawei@kernel.org>
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

The GHES migration logic at GED should now support HEST table
location too.

Increase migration version and change needed to check for both
ghes_addr_le and hest_addr_le.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/generic_event_device.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index d4dbfb45e181..49ca1fb8e84a 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -369,6 +369,34 @@ static const VMStateDescription vmstate_ghes_state = {
     }
 };
 
+static const VMStateDescription vmstate_hest = {
+    .name = "acpi-ghes",
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
+    .name = "acpi-ged/ghes",
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
@@ -380,6 +408,7 @@ static const VMStateDescription vmstate_acpi_ged = {
     .subsections = (const VMStateDescription * const []) {
         &vmstate_memhp_state,
         &vmstate_ghes_state,
+        &vmstate_hest_state,
         NULL
     }
 };
-- 
2.46.1


