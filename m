Return-Path: <linux-kernel+bounces-536792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5491CA4843B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD603AD83D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7634E26FA79;
	Thu, 27 Feb 2025 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/Mg9IyU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE9A1B0103
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672063; cv=none; b=ODrJsLRDTYiiuOFlwKtaTtI1IjytfsLT9kjyGf7RNY4xFr+o3OqjqWW8Fyz14vOzDLmpnkah4zQzq/5sCQaT9wkTTA73RDBpLpdWoxWUwKq9aKKfqc2oSy9k86Je+8gJ4KWbF5TwjqLKNB9uKBh6pxr0zvbzWvyAcHci1PouaFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672063; c=relaxed/simple;
	bh=WNgUSU0OrqFnvTXh8PzzTv6ghTQeysRMH1deXYrrJ9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFI6vk+SAhk9+I/4LhrIsQTLscdMTm2+/fiUeJ44PemrWu5yeoE+VsfkLj1l75Qhi3pq/TWa8H39YQHqbh8w47ftKIe9fgVd6402lvRHLqLVb+v6D8U454mWtOoY+cX2FZqHjt/P7hJZy+AOqG+s3pUinRhlNChmxwdC5FOop3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/Mg9IyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CC3C4CEF7;
	Thu, 27 Feb 2025 16:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740672062;
	bh=WNgUSU0OrqFnvTXh8PzzTv6ghTQeysRMH1deXYrrJ9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y/Mg9IyUodcfdaRqg8tN4fvu/AgxkRqJVgxlkzRlvSt7Kns053gpqm3jmMY5TK/vH
	 R0+ABeLp8aZ6fq7byf27hvf5HuCHxQmcgzfx4sDl+VqjeOMZz46gT2T7BY4O4cRuQx
	 uR8+18Suu2q+m1fvEbWy0Sv0snROFrI0dlIQ/J51shflFrQ07VR2cxNYzbW+albJC6
	 ZuYT20D1E++nnlPAzF7czN//T4rp8GX0jdYHSp4yTSe9oNBXB/JmZ4HtcB5O/Foi3Z
	 1OmfAPxAeyqPuKfJg9IqcthUVljGieJuJognKev/J1brDaCtSK9sz9UwtgOAXMPK9G
	 5ji/sjO1SvtoA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tngJo-000000023bL-4Bm0;
	Thu, 27 Feb 2025 17:01:01 +0100
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
Subject: [PATCH v6 10/19] acpi/generic_event_device: Update GHES migration to cover hest addr
Date: Thu, 27 Feb 2025 17:00:48 +0100
Message-ID: <c291cdfd61e25437b85e5e660f3a67520a89d13c.1740671863.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740671863.git.mchehab+huawei@kernel.org>
References: <cover.1740671863.git.mchehab+huawei@kernel.org>
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


