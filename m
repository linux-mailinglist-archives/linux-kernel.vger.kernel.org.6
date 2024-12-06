Return-Path: <linux-kernel+bounces-435409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0819E7711
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B87B2879CF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A4821E9A2;
	Fri,  6 Dec 2024 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qo6Qvl/A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC7220459A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505688; cv=none; b=Xlsac9vjlJuSEg00dz/FTTUUaUTT26go4L4/b39nbjB7dCSnr7u4Hc59oOw0tEsiNoeSNT7mbuzlFSwdP5mSLzaN48esgG0EFjc1abNllytO86be5aExHz8bFf058ORfU8PqKdwXsA7u8HSu0wJMdnQO67i7+lnW0wIbmXbKGSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505688; c=relaxed/simple;
	bh=W9YAnoSIBP0h6QQnoV6iGZCBdgmPfaExfAOZs9Xc2y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhXmOxTdaAFEGFflEBNheyvTfidN1Fc4G5eoJ0ce5TmIcT3cpTVkTW5b8JzLbrp0/xUzbcjLSgHwsTRBIY623+NVMcNtkdEQlF4Qqt0zhn5pA1D3Nnm7+QRRIi8C0Y/QLUuwsKxvWgJKmesMtFHYNNGAAys3Ez1gdi6n4UTgguE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qo6Qvl/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F973C4CEE0;
	Fri,  6 Dec 2024 17:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505688;
	bh=W9YAnoSIBP0h6QQnoV6iGZCBdgmPfaExfAOZs9Xc2y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qo6Qvl/AlnhWF5v8CxOyjJ2xt+dHAFRzTKQJRKmuAk6A6DbJU455anBXw/yEL6Zi8
	 LSwEGEPWthIrWYIlKBsD626h2EnuywXyAuRDpBaV+8184vS7t4kdFoFDQrUm3aTyMN
	 bm69gPmBuaaIKG67LcbNgzOv9nskajkrTv7dPBVqUnM8jkKezDIk6IDScruoA3SFsu
	 /DcAuxRjVeyUIPNHb4UmT5+G+2n8ztihJlV+iqYUmVhIkuqYCcHvCeZdh70QXleEZD
	 OndxeMhW4xy5b+0iOxybYu/dB33lAlZuVvSON3qBoYhhwiHWpb6KaupDzPAnjU7NQv
	 dhgFLewey1ykg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tJc18-00000005RLX-1MdH;
	Fri, 06 Dec 2024 18:21:26 +0100
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
Subject: [PATCH 31/31] FIXME: acpi/ghes: properly set data record size
Date: Fri,  6 Dec 2024 18:12:53 +0100
Message-ID: <104add143d349685cea1b47298b8f5d367a3a15e.1733504943.git.mchehab+huawei@kernel.org>
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

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 1fe4c536611a..856551df2103 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -211,6 +211,12 @@ ghes_gen_err_data_uncorrectable_recoverable(GArray *block,
      */
     QemuUUID fru_id = {};
 
+    /*
+     * Calculate the size with this block. No need to check for
+     * too big CPER, as CPER size is checked at ghes_record_cper_errors()
+     */
+    data_length += ACPI_GHES_GESB_SIZE;
+
     /* Build the new generic error status block header */
     acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE,
         0, 0, data_length, ACPI_CPER_SEV_RECOVERABLE);
@@ -580,21 +586,12 @@ int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
           UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
                   0xED, 0x7C, 0x83, 0xB1);
     Error *errp = NULL;
-    int data_length;
     GArray *block;
 
     block = g_array_new(false, true /* clear */, 1);
 
-    data_length = ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH;
-    /*
-     * It should not run out of the preallocated memory if adding a new generic
-     * error data entry
-     */
-    assert((data_length + ACPI_GHES_GESB_SIZE) <=
-            ACPI_GHES_MAX_RAW_DATA_LENGTH);
-
     ghes_gen_err_data_uncorrectable_recoverable(block, guid,
-                                                data_length);
+                                                ACPI_GHES_MAX_RAW_DATA_LENGTH);
 
     /* Build the memory section CPER for above new generic error data entry */
     acpi_ghes_build_append_mem_cper(block, physical_address);
-- 
2.47.1


