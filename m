Return-Path: <linux-kernel+bounces-431574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF31E9E411A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DF9EB3CFB7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD98E217F2D;
	Wed,  4 Dec 2024 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wq0sP/uY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319B4217675
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327908; cv=none; b=UTF4MaRSFrZaIl6HX4G0Z132eZz8N+L512YncF1S0Qc3xSP8W1nYZmrTG/d62XfCj+bEtN//jmtUpKuMIgm44plw41aJ/d840/D04x4bDP9poaZd6NW5XohADYkAK+ouV71fla6OKJ/H25SbqTVDA3NqZLPRT0jVavio9q2TIOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327908; c=relaxed/simple;
	bh=wU6bEN0SPz/LlKhqMAmMkomSPYpkFTOMIKtUFlzjV24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V30n70nHnhizpSKwe6o8iYlid9goR9DGzf17dVypL8htK6zncboN2jnxlOQXljCC5hwlMiqje9dHC20abx7aTuxD8korvOxY+6wXEcHOO1ap/XZDiDWn9v7+py/82VtShIrVyiNGS5eS3hUmr7nWZYAGAqbJZCLh2MJcpEuXd20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wq0sP/uY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB00CC4CECD;
	Wed,  4 Dec 2024 15:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733327907;
	bh=wU6bEN0SPz/LlKhqMAmMkomSPYpkFTOMIKtUFlzjV24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wq0sP/uYRy6wBHCyaOxRnQnXx7qltJQxOLT4nHQXa89WS6mb34iS7kgNrSln2eLXA
	 24tHjTnarFcxmtL1b6E/aAtz487ZGnTQlLB7/aGNBTR1QjHi3jtI4h/8t/05pQxs1T
	 no99A0ICF78fPZmvBY0+p3qWP3TU8rdd/87m1SoM6UwNpHtXumes6mlWSJh9ZRiph9
	 9jL5PsKnwZYKQ6VW0PQcTLEy501+ieKjkuVNF88VC+idjI3C+AG9qt/7nDLw692t/J
	 17lx14rVz/61/q+LJ5fI9jUwiCJmiPIqVdEOYh0FYaj/Eb1Za98oQOqBj+iPEAUUFq
	 28rwySq7sDjEQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab@kernel.org>)
	id 1tIrlf-00000000HZ1-3WaO;
	Wed, 04 Dec 2024 16:58:23 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	linux-kernel@vger.kernel.org,
	qemu-devel@nongnu.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 4/5] acpi/generic_event_device: Update GHES migration to cover hest addr
Date: Wed,  4 Dec 2024 16:57:58 +0100
Message-ID: <9be1bc41db1705a23ade82ecfcb978e6e0db273a.1733327276.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733327276.git.mchehab+huawei@kernel.org>
References: <cover.1733327276.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

The GHES migration logic at GED should now support HEST table
location too.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/acpi/generic_event_device.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 17baf36132a8..c1116dd8d7ae 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -387,6 +387,34 @@ static const VMStateDescription vmstate_ghes_state = {
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
@@ -399,6 +427,7 @@ static const VMStateDescription vmstate_acpi_ged = {
         &vmstate_memhp_state,
         &vmstate_cpuhp_state,
         &vmstate_ghes_state,
+        &vmstate_hest_state,
         NULL
     }
 };
-- 
2.47.1


