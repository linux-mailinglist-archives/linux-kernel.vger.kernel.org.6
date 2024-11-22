Return-Path: <linux-kernel+bounces-417982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49599D5B8F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FFADB228CA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9886C1DE8BC;
	Fri, 22 Nov 2024 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lb332XM2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AC6183CAE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732266709; cv=none; b=mGyvZHrp8BS7lfCrhe4oXDaL5cK5ugaqSshWLeVnfs7HGufPTqVYqbiUd90IMj4np+vH2nBIgRa4w2B1kzR7qNT5g2Nlejzgc+7qBBGpDMAkuUSYpCAbe7+MsD0zx5iDQ+uqxt1yaAWanOD3ZyFDo2duyxCXVaX6BBdV3I1rx8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732266709; c=relaxed/simple;
	bh=6YF6O7FV32gcRBG0RLhIa4885AgC80LqdL+tPakkMdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQ4C+gMAWlTqVpfOh1dpxWsFD5+1XAhT/YuFHs88PB4fOWUizZtuPzia5Z3uFod+0kkaqXsIZcWh03xFLgukYG0ufpLB5dL6kJ3a7zn0CB74+pnPDiwoITg7QZY7H1/8FmGSeCN1WwPDuQKYdZBNXtrHCTzbznKVYiaTg9/5ODs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lb332XM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CD1C4CED6;
	Fri, 22 Nov 2024 09:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732266708;
	bh=6YF6O7FV32gcRBG0RLhIa4885AgC80LqdL+tPakkMdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lb332XM2ifwY0ztPjDw1L6LAkgS8ZYPt6aqAG3aWH5Wms8IaEHcY5OjyJNFKkZldO
	 XjR138ysD02CL39unykzwDkGB3qNcD4OSrzDAeCd0AgOZvsPOykvVg4IJppUEvypIN
	 WvGci1Yn/KaLCoTNSo+sF61ajOghAzaD08xj5yUAteMj/+eNPZtFEgfmVZqA1aasHf
	 UAEcSFC0UO/FiZQq7mN4PXbqE5uCmuGyRTuDp+W8j/T7opfFhlN7O+j8stTtok36ZK
	 OUS0wsj73jnaeDBM3R4MHpV1xvra1oW0UVasTMMhwWNBaNavVJMVtyLCdHTJufuDep
	 wTaYqhn2Ynehw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tEPhX-00000006l3n-0Q2F;
	Fri, 22 Nov 2024 10:11:43 +0100
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
Subject: [PATCH v4 06/15] acpi/ghes: Remove a duplicated out of bounds check
Date: Fri, 22 Nov 2024 10:11:23 +0100
Message-ID: <1aae261ad685e3d50fa8fbe530b9e3c677ec28e4.1732266152.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732266152.git.mchehab+huawei@kernel.org>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

acpi_ghes_record_errors() has an assert() at the beginning
to ensure that source_id will be lower than
ACPI_GHES_ERROR_SOURCE_COUNT. Remove a duplicated check.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/acpi/ghes.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 29cd7e4d8171..5f67322bf0f2 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -404,9 +404,7 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
         return -1;
     }
 
-    if (source_id < ACPI_GHES_ERROR_SOURCE_COUNT) {
-        start_addr += source_id * sizeof(uint64_t);
-    }
+    start_addr += source_id * sizeof(uint64_t);
 
     cpu_physical_memory_read(start_addr, &error_block_addr,
                              sizeof(error_block_addr));
-- 
2.47.0


