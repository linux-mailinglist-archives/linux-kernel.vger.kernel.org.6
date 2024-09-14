Return-Path: <linux-kernel+bounces-329157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1DE978E30
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 08:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5261F23DA6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 06:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022D57E792;
	Sat, 14 Sep 2024 06:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gT1T3Y9Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1032556F
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 06:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726294434; cv=none; b=hAYR+DyllST+1EHga7XD7RsyhQEJLcrJIMqMAhkbiN3+WUp2a6K5aa5aNJ+tocuPWTN+v3NcgqX+wqnzU6O0Cjm4C53AG0RmrMEUQz8DGwbFjEXd5DXhBfcQeCj45ztN1lsRayJjk3Z6HUf41SrxfPRDWq+QTsvFdJOcwZu57uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726294434; c=relaxed/simple;
	bh=WkMRajvi3DCu8ik/79aRicilu7jypqPMaL43Kk8gHHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDhDOUTihc/kJjHzdEVrpBKVGRrxdFag2sJxxWXMLdCG5KJuv4ic1K+15TzohU/pOw4Hnuv74zsRPtjKZddJm1bmoAQpnc+hjrlCQ6TsFjDfa+MFiZqY9cvm1Hn1Wo+F6wDk/g9Tk5QDOu0I2+Tz8AMzlIEgxC/6PL5drSTFNXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gT1T3Y9Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB309C4CEC0;
	Sat, 14 Sep 2024 06:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726294433;
	bh=WkMRajvi3DCu8ik/79aRicilu7jypqPMaL43Kk8gHHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gT1T3Y9QqE/ne0QamJVQbVZjny6f5v709D8ZBo/G2u26VToEw/UL7zODVW935LUR+
	 pYpzfYYqqVdeUe9UVPwe2l7DvaTZxgaf55lcqZE66v0bMBqWPupIdXfUp0wWH0oSmv
	 DtSfqi09dFso25uc03k5Rnpf4Wk+6kAkEfj7U0cK2/PEtohx3cGWWLiOxtrWGkMv1d
	 OwB6slwHmOB5wR/89Kft5jbSkqjRmzJ/B0wj554pWQgn3tWKGvIYPuTMgfavIi/gZu
	 utngWJQ6UEq6xuMwk0XDKRxdDZuqowYIbUP9zmiPKghJ5sExx17QLkL6rNnuEeTH7s
	 8qcZHw76Q1p5w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1spM2Z-00000003V5W-49AL;
	Sat, 14 Sep 2024 08:13:51 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	linux-kernel@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH v10 02/21] acpi/generic_event_device: Update GHES migration to cover hest addr
Date: Sat, 14 Sep 2024 08:13:23 +0200
Message-ID: <bed4b2da51e0c894cc255f712b67e2e57295d826.1726293808.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726293808.git.mchehab+huawei@kernel.org>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
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
 hw/acpi/generic_event_device.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 15b4c3ebbf24..4e5e387ee2df 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -343,10 +343,11 @@ static const VMStateDescription vmstate_ged_state = {
 
 static const VMStateDescription vmstate_ghes = {
     .name = "acpi-ghes",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
+        VMSTATE_UINT64(hest_addr_le, AcpiGhesState),
         VMSTATE_END_OF_LIST()
     },
 };
@@ -354,13 +355,13 @@ static const VMStateDescription vmstate_ghes = {
 static bool ghes_needed(void *opaque)
 {
     AcpiGedState *s = opaque;
-    return s->ghes_state.ghes_addr_le;
+    return s->ghes_state.ghes_addr_le && s->ghes_state.hest_addr_le;
 }
 
 static const VMStateDescription vmstate_ghes_state = {
     .name = "acpi-ged/ghes",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .needed = ghes_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
-- 
2.46.0


