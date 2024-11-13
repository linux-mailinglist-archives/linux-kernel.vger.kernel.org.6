Return-Path: <linux-kernel+bounces-407238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F689C6AA5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98642B23288
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 08:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0250518B481;
	Wed, 13 Nov 2024 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHZPti3N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D143189F33
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731487058; cv=none; b=dowThznZ5S2xcbZOpUfDvloh3UPS7BnGB59WHcuLoo48JIXEAjXrdM3SA3d3wbzY7VYmmzfsQrfTHYt4XI1ejDaWlIFGbUPtfBDiuSTseE0Di4SuFkwotVN8ZSbPWSKqMi9ss0Yz3yzBOeV2pl8uV4i1vcsHfn55Pq250Qrtr3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731487058; c=relaxed/simple;
	bh=lwZ1IuYRe5DepXtgbkyvIhp+Y4LghKbMjDoi/VUdCE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=trT+wkNZ2J2g3c2RzqOJGJQJWQEartvLsBhLsn0388H//YohUkHCnn2kUZje7JrAEk9QyP5etpeOpdoR+nt4x1+2IH9aewSujti0TU4FjJiP7JpcVwigVHVvj0Vj3JdbKsi9GqRk1Z/xFccsmt1OKBm1y09T1FGFkh41CfvLopY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHZPti3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5FFC4CED2;
	Wed, 13 Nov 2024 08:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731487058;
	bh=lwZ1IuYRe5DepXtgbkyvIhp+Y4LghKbMjDoi/VUdCE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DHZPti3NrNr/nB9WNK34DSpnoerejVPDIZd8LPTwgfyh5EE1e2a6R/FJl34ek9DHq
	 2YxxlABSLWXNG1lnI6HM1V1ONtK8+ikIbqUAP7+I6mXGX3tMWf6M9cegfDp19MJAvz
	 td32tEJWZdeqHLHAeg6TsbSFjZLbQN9nK7TaummK93APgOI1rGve8yfWJEihIuDb+J
	 whRl9ThXVg9+oe3m8pVoeKMdx3UJ+0pGFVq2otWojx/y7lUCPK5vVFdiGMK5N10Zq9
	 dsGNvded3W7dQFG4puOuEa5ZIi0IUMHbtq0NNNSy6H/XUhKtmbRHySnXkHRf4vRBmP
	 AvwY5tNHE6I6g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tB8sZ-00000001Kw7-3WGE;
	Wed, 13 Nov 2024 09:37:35 +0100
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
Subject: [PATCH 3/6] acpi/ghes: rename the function which gets hw error offsets
Date: Wed, 13 Nov 2024 09:37:00 +0100
Message-ID: <3dccd08b82755bd42ab61408d5d86b2bfe2f2f01.1731486604.git.mchehab+huawei@kernel.org>
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

Rename: get_ghes_offsets->get_hw_error_offsets
to make clear that this function return offsets based on the
hardware error firmware.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 4cd79d42cd04..c93bbaf1994a 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -399,9 +399,9 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
     ags->present = true;
 }
 
-static void get_ghes_offsets(uint64_t ghes_addr,
-                             uint64_t *cper_addr,
-                             uint64_t *read_ack_register_addr)
+static void get_hw_error_offsets(uint64_t ghes_addr,
+                                 uint64_t *cper_addr,
+                                 uint64_t *read_ack_register_addr)
 {
     if (!ghes_addr) {
         return;
@@ -445,7 +445,8 @@ void ghes_record_cper_errors(const void *cper, size_t len,
     }
     ags = &acpi_ged_state->ghes_state;
 
-    get_ghes_offsets(le64_to_cpu(ags->hw_error_le), &cper_addr, &read_ack_register_addr);
+    get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
+                         &cper_addr, &read_ack_register_addr);
 
     cper_addr = le64_to_cpu(cper_addr);
     if (!cper_addr) {
-- 
2.47.0


