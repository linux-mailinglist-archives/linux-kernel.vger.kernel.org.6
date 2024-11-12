Return-Path: <linux-kernel+bounces-405566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8B19C52F3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3AC01F24532
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5112141C0;
	Tue, 12 Nov 2024 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WztjL6Ah"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA052123DB
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406510; cv=none; b=cRoy8IBUykKce0dbaGDt1e9KaSkpczZf039l8C2Tji1UNRQNMqVxUs7wUFG0kYRfs1cAdz63frLxBpSpKniY5bEx0leR3byHpGA/+yC1Va+yIapT3SEB14AkTM+I+8bE30Ung+/Wa7xe6b+uljiHWfSitOiM32JRzeGOmT4hksQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406510; c=relaxed/simple;
	bh=80tymdZsA4gV0nz/70yruPzz2rfWPx4O9L07JwfBNsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OsqMxeHyM1BuWKhoteIcXB9hNeL/XhsFv53buf81NPX27JbmrvWePv2yaV2Dbe6TmsLd8/YTEPxsTxuV3BG2H/6z1VTU4JIlncJONvCkjADQOvy3bpym6byMmn7LeLEVSLihBSQYjdj0je28SaM8ZuFochqoWT+Dtw6O9nSer8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WztjL6Ah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4C4C4CED7;
	Tue, 12 Nov 2024 10:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731406509;
	bh=80tymdZsA4gV0nz/70yruPzz2rfWPx4O9L07JwfBNsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WztjL6AhubudZTvxzLhNCseRAn9TvO56Zay6n022SOniJHBLgeSbzwpOBUe+Ib7yp
	 thoae8fDuBMtMAlitZWi8IZmt6otUsw0hHjWVegeplNG3YqlEmTbqKzwX8nLqL41J8
	 5KXUydgO+JDLwsYfdWbpxhGI1sBBa6kRL+vuluSyvU34qreEtEkHko284RU2WCSNlV
	 pSjXJIoU8utqVB6SBX6DYUaAMgSWrokDTbsNQBwJ3ZBZIUYNNFuaqftaDwTIMTL2Fr
	 IvS++8RiNSNvMyQSehQdEt8yp20s6kLBkQL4JQNCCisEiLqc0Di7PGD+4GLMz9O9cw
	 HsippVJCNAJrQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tAnvP-00000000Jcq-0NpS;
	Tue, 12 Nov 2024 11:15:07 +0100
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
Subject: [PATCH v3 05/15] acpi/ghes: Fix acpi_ghes_record_errors() argument
Date: Tue, 12 Nov 2024 11:14:49 +0100
Message-ID: <df6572aaa4667f255e18052631c816de059c504f.1731406254.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731406254.git.mchehab+huawei@kernel.org>
References: <cover.1731406254.git.mchehab+huawei@kernel.org>
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
2.47.0


