Return-Path: <linux-kernel+bounces-435384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F969E76ED
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A2B18826AD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83343204583;
	Fri,  6 Dec 2024 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0FCr4tb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CF21FFC72
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505687; cv=none; b=U0vlM0rXViSTqKJ2JveCXLAQbiP82Nsyp0Pg5s4G4RhfbLp0pQRZo398igMc5AoajZEgKZyRfqsBpnfxlGDZQFAv8CYwBaRe1oaojYm2EpnIQ5bACjsNDKmbaGUMv6rLtQISZ4hMcSqSRBpSHxVfUsrvu2wB7y4YV18Vgq3MEH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505687; c=relaxed/simple;
	bh=WUvT8Ughz2H3l7zFkf4yAqTlDCn4hpG5JQNObbE2feQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oq6pme8G3C7YTLhvEcfXakwGvoUZqVKFCyeS8Gt2HSZiuZdeMNHXwE03HQlvPWeK9tI9uhaWtxc7fMUrcg364hezaxusulWoB4jk+Gm2vWtXiJbDjRfTToxmSFLd7348J3nyCraTIgWopEpVFq+2IlrtCDcWOq1j27WD6HIAr7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0FCr4tb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D30C4CED1;
	Fri,  6 Dec 2024 17:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505687;
	bh=WUvT8Ughz2H3l7zFkf4yAqTlDCn4hpG5JQNObbE2feQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k0FCr4tblq0DzVcTJ2Ifi0qJj/OU6l3nWnggOftjhOy2KDxlzxKZtln+/Got8Nd7Q
	 F1h3VBNqxk9C8+VRNk7w83w/xqnY3FCh3fvoRv+0o+8FpWl7dBFSET5bOT3ZK6TR0x
	 7/SeyBmS7UZV+Be397Kpx529/2FwI5dNonWIrRhry9MEBsHvl9DxXcRUpchQhmx79Q
	 5IqwOBhvsgoaoG1ld4TuwDTVlNkAQcjfj7Jfc2Vx3rzaplIjAnZ9MhxL/YovuJJ7Mk
	 WinmZGZZKS6pJgU7/WPgv5QdN5zaKxM+iiYW1sCQ+zSC/uT7i5L5YJ3Wbi91xNkWoG
	 AyOPgj2UaG3Hw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tJc17-00000005RJq-2TaG;
	Fri, 06 Dec 2024 18:21:25 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 05/31] acpi/ghes: Fix acpi_ghes_record_errors() argument
Date: Fri,  6 Dec 2024 18:12:27 +0100
Message-ID: <f0f3bd96ea31d334dbbcba460c3d0a98d4270a41.1733504943.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733504943.git.mchehab+huawei@kernel.org>
References: <cover.1733504943.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Align the header file with the actual implementation of
this function, as the first argument is source ID and not
notification type.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

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
2.47.1


