Return-Path: <linux-kernel+bounces-418264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C1E9D5F92
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 14:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF211F22233
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349381DF27D;
	Fri, 22 Nov 2024 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXmXQ1jq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882B81DE2DF
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732281264; cv=none; b=aXsuZFtw9FbDo3WuHXxvZCjgLgPZH2Lt0DOytuiud+GBabYzF2n92hD4WxC8LPmzo7B2XGplc0tg07EdP+Iq3F9TpPAAWDdf6cit9Fh5Cc5Zh4jZKWKiAtIgagqhj2rs87ZWog1hGhzozkT5GyzYn9MEq1PcJ7MHQEtqFwSxbr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732281264; c=relaxed/simple;
	bh=knD0TP3MMmZwwVXl9X/8uUAw8uoJGhkCzWhBHEKXJzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kv6aBVz2p/IBRXPJT6aWQRPB+R2GaEr5ioCdmF7DHwSTz1JiIynooe/xRvMCibXtpTXzVKSAWSpaNd2NOeGrkukapYnpZ7nhNyXpZWwMxbV0pOnxeEjxgGOwv6VpZrJBKb8SYMbLjkjhDbcq/ccssHWf9FWkTTb60uzjcZlUS/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXmXQ1jq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A77C4CED3;
	Fri, 22 Nov 2024 13:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732281264;
	bh=knD0TP3MMmZwwVXl9X/8uUAw8uoJGhkCzWhBHEKXJzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JXmXQ1jqNFtcWhfXXxUQ4miScwPVF9LXnSKIOjjKm9YvfM7eQcWpEZPGhqQhH4nk6
	 EtyYax4oYDZOC2LlgMOBx5ekXIoMjhO8/Ox/nfcGzZL1q9OZ4nKABKUduJxFCupVcu
	 ROgdMAJcJ27A1xxPse0Sam2Wd6TXZNfaeqzU1hmWUX0dkrT2cEe3tJimL2/Pluc4m2
	 4qldJRY9MtfZ5rKpKSpyX/fzcImaZFgrw8aaSYB+31/GIGcWzJvTaS60/vTGxbcgEI
	 k6w1n28etemef+T1uofsUdIanA/Jqm075F6Lg8Zf4z4yORmFL+8JJWVTzHmh9zCwJT
	 9pqtIFEk6CayQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tETUM-00000006v9r-0RNX;
	Fri, 22 Nov 2024 14:14:22 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 4/5] acpi/generic_event_device: Update GHES migration to cover hest addr
Date: Fri, 22 Nov 2024 14:14:14 +0100
Message-ID: <9aa962a596769f5fa35c8af84b5a522cb12947f2.1732281080.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732281080.git.mchehab+huawei@kernel.org>
References: <cover.1732281080.git.mchehab+huawei@kernel.org>
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

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
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
2.47.0


