Return-Path: <linux-kernel+bounces-407239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 628F89C6AA4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF1CCB23303
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 08:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21A718B47B;
	Wed, 13 Nov 2024 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRGETCq4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D18B189F5A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731487058; cv=none; b=tkq5aglsVwdmxjaAiFITvtYaVWtRVg4E1V/kAS8XSLljHZJDA2tZMrYPFkhizZj9dDnqMasAoeAdLM/dzInJr2UgfDhsSWlyDy1DtMPV9X6Llhil6Ueqa6xQmWfRt+/4SnAiA4hAZtFWYZsvt4Sy28Q2Xo+cNaYVFpBA4jcY8lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731487058; c=relaxed/simple;
	bh=odJOZG7yNovZKCssQmjOTgaaR33S7IrbHrH+B011h6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IkPXEEkUnRqRz6UAryN5/tHc+kGDJzO1BBKQcNSqMw6MOGlbjr7flQRfnm/TOZDLSsy95HHiMC9BfWhPBMLZjTGBP8BQqABbc8cpeytCq1NAdi+bF5Ag4bCp2RLvPZ50dn61LN7Em6Fi09s9yQWPAezxneMFWGwDdB81uB/2Q70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRGETCq4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11389C4CED8;
	Wed, 13 Nov 2024 08:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731487058;
	bh=odJOZG7yNovZKCssQmjOTgaaR33S7IrbHrH+B011h6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VRGETCq42M0V3Ais3xXC3y8kQ46dfX6xhuY0CSNYnZp59Y/0MXzQAUle+xqdirKxu
	 MkQ8MiT5xFj7/A2CKjwnrtpx8BVfPx57+ns++G929VxUuvXjMk4aLSHK0x0YZzr/o4
	 PuIOIk+ExeUeQFAdOzJnXCnNr9NuAJvMmpyhr6pJkdRwLogkhR+OARandTVqTCjuPH
	 yCJfXNmMXVMyBw2HeXdSPf00jyRiX8iAcrbhgbkD8HjjV4vhG2buUSgOUKQUqajyNH
	 jaIwmw+AxqAYz0hEeMEVoXT7t96mkY7D7ixQEjUQKPgFx3C67k9i4hdEBoUtIrfaIH
	 1TcN8I9xdL3DQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tB8sZ-00000001KwD-3kqP;
	Wed, 13 Nov 2024 09:37:35 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	linux-kernel@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH 5/6] acpi/generic_event_device: Update GHES migration to cover hest addr
Date: Wed, 13 Nov 2024 09:37:02 +0100
Message-ID: <6391dfec0a26b83641c2b2062115b839490cc902.1731486604.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731486604.git.mchehab+huawei@kernel.org>
References: <cover.1731486604.git.mchehab+huawei@kernel.org>
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


