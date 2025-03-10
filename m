Return-Path: <linux-kernel+bounces-555272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3CFA5AE28
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 00:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ADF51746CC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 23:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8A0221DA7;
	Mon, 10 Mar 2025 23:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=hetzenecker.me header.i=@hetzenecker.me header.b="H5CkC7cR"
Received: from mail2.hetzenecker.me (mail2.hetzenecker.me [141.147.52.116])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7422822172A;
	Mon, 10 Mar 2025 23:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.147.52.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741649845; cv=none; b=ueZga63WXBxBXT1esZje22zhV41cPfBEMlMVtUJKItFIFA/0zVR4RFVIvrjx7V4V147CUo1XxWCMiEWPZjtsW659nXNDuxv2aAgRB56hEP9Y/2GzsRWD2d63804E9Ibhwe2wqkrgIJddzcsGjaRh9gHg5OXZGEbJGfe/pdp4Itc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741649845; c=relaxed/simple;
	bh=tH7hIPoqrqBoInrprJwtXYr2kij8m2SlRyannnSuNu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CVGZRc3K6jvwVo7rC0+HD001VHift11eUvBKJRnlnw1iJ2OPRd/BRCMbHW+rJ0BvDCEc7lV92VT+fNGeWHXdJLFCI0mJsBReE2Ailx/GhivHscO74k//L/zYDfu1C8Fay4KBl4lJhey0XXkrm0qLLrYxlvJ6DnVsB1J93lISAwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hetzenecker.me; spf=pass smtp.mailfrom=hetzenecker.me; dkim=temperror (0-bit key) header.d=hetzenecker.me header.i=@hetzenecker.me header.b=H5CkC7cR; arc=none smtp.client-ip=141.147.52.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hetzenecker.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzenecker.me
From: Lukas Hetzenecker <lukas@hetzenecker.me>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hetzenecker.me;
	s=dkim; t=1741649306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/3YkJbSM1WGojFyxRIEvfJcKllwCxHiUM0ucN+KwcEI=;
	b=H5CkC7cRUWYsqZliWBqPpkGmBGhIGCFh87cpkF8OI63hc+4uvX/KqbJRGzA6jN/zhX5VqG
	tOwFW3WvC/mX0nCOA2VvNa9DSiAVIixCjQ32kquxWjta1PaYHjF7ABWk++NQ7OSSl1BjSJ
	64S1eHu3PZXE/spfjWWdu9zjg0Ucw+M=
Authentication-Results: mail2.hetzenecker.me;
	auth=pass smtp.mailfrom=lukas@hetzenecker.me
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Maximilian Luz <luzmaximilian@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Hetzenecker <lukas@hetzenecker.me>
Subject: [PATCH] platform/surface: aggregator_registry: Add Support for Surface Pro 11
Date: Tue, 11 Mar 2025 00:28:03 +0100
Message-ID: <20250310232803.23691-1-lukas@hetzenecker.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +
X-Spam-Level: *

Add SAM client device nodes for the Surface Pro 11 (Intel).
Like with the Surface Pro 10 already, the node group
is compatible, so it can be reused.

Signed-off-by: Lukas Hetzenecker <lukas@hetzenecker.me>
---
 drivers/platform/surface/surface_aggregator_registry.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index d4f32ad66530..a594d5fcfcfd 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -371,7 +371,7 @@ static const struct software_node *ssam_node_group_sp8[] = {
 	NULL,
 };
 
-/* Devices for Surface Pro 9 (Intel/x86) and 10 */
+/* Devices for Surface Pro 9, 10 and 11 (Intel/x86) */
 static const struct software_node *ssam_node_group_sp9[] = {
 	&ssam_node_root,
 	&ssam_node_hub_kip,
@@ -430,6 +430,9 @@ static const struct acpi_device_id ssam_platform_hub_acpi_match[] = {
 	/* Surface Pro 10 */
 	{ "MSHW0510", (unsigned long)ssam_node_group_sp9 },
 
+	/* Surface Pro 11 */
+	{ "MSHW0583", (unsigned long)ssam_node_group_sp9 },
+
 	/* Surface Book 2 */
 	{ "MSHW0107", (unsigned long)ssam_node_group_gen5 },
 
-- 
2.43.0


