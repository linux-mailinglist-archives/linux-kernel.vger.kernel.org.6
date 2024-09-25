Return-Path: <linux-kernel+bounces-337973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4839851C7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 06:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239EB1F23049
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 04:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F394314F9FA;
	Wed, 25 Sep 2024 04:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBpqOl5V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DCE14B94C
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 04:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727237088; cv=none; b=aDyPbJvB4IGwJxFl4/TxNCGKAW2/NuCXE9oIhUWRaIuMnsUMAL/hNzWM8m3TuUicwa22f4KVzbjlud2Wl1idbZmVcJi3DgVsoqic1TcSlSeZU6QjRBJ7tex9/mBHj5AgVehvhBsSx4Ryhy1ouF7uEmeE0ol2KL6xS0N3cLdcaBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727237088; c=relaxed/simple;
	bh=BSna6PtTcJXhc2BwT04xbR58a+FIME41kCjBdqVnEa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDlI6PuWXByJNQT494DjyOUMHReeM0FEbBAu1bIXW4wQ06iZtoyhNlZ3r98qIO7UA1JL7kAf+P7wSxOUG7hSAuFxdkWp4W6AE009Y9MvAFSH/5wUV+YREEwh+5EB6lw/xh/Y5zs66fhHsmmGGbVZVoh/nvtthqv5j5N8oVW2DeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBpqOl5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07961C4CECE;
	Wed, 25 Sep 2024 04:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727237088;
	bh=BSna6PtTcJXhc2BwT04xbR58a+FIME41kCjBdqVnEa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IBpqOl5VZruvvoSmGlu3kZ3tJ8SCyosM78IgpTjij0u3uNNeY7TjmHDdLXDSnKXcR
	 ybOWAg5aVBUwYafMsD2XG2xLTJuNdhVA2ryAVFb+5oEgvu0V7c7bJI6qKknRuWuQUu
	 q3v4iJ3ynhYsMI+LkM6kWZKg5qde4Q8H7vNHPwwMVtfJ+AYVpVcDDVJ+xe2pcE325G
	 Q+Q/5mHab6utJL/12m30b0q2I9h0fV63yXRe/m9l6l0KAvfVnotVgJYO6EzsBRe9sl
	 QkKvvV7HNfYZwRgi31YTpQnl4BEPB4TkwDdaU5Lfmiw6OIMcTKEp3I91rTaumHxI55
	 +roBRiu6iz/8g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1stJGg-0000000827x-0lpG;
	Wed, 25 Sep 2024 06:04:46 +0200
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
Subject: [PATCH 05/15] acpi/ghes: Fix acpi_ghes_record_errors() argument
Date: Wed, 25 Sep 2024 06:04:10 +0200
Message-ID: <58444cff65cc5b9164f47db4685910a2602b7d13.1727236561.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1727236561.git.mchehab+huawei@kernel.org>
References: <cover.1727236561.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The first argument is source ID and not notification type.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

---

Changes from v8:
- Non-rename/cleanup changes merged altogether;
- source ID is now more generic, defined per guest target.
  That should make easier to add support for 86.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/hw/acpi/ghes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 20016c226d1f..50e3a25ea384 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -73,7 +73,7 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
                      const char *oem_id, const char *oem_table_id);
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
-int acpi_ghes_record_errors(uint8_t notify, uint64_t error_physical_addr);
+int acpi_ghes_record_errors(uint8_t source_id, uint64_t error_physical_addr);
 
 /**
  * acpi_ghes_present: Report whether ACPI GHES table is present
-- 
2.46.1


