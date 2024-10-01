Return-Path: <linux-kernel+bounces-345352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2887698B523
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D199A2820B3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D601BCA06;
	Tue,  1 Oct 2024 07:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbdEIOSH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1A11BC9FE
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 07:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727766251; cv=none; b=hd/FBit4G74QFlyxboMvV/xwHdqphCKB7jDw4K4P+n4jskF+oIGGnew/Ld14nIy2GvL5xTHWtOqrHDc8wH2VGmuD7fGzt0fwnKPJhG06GbUWSbO1RxfoGBmDHYDui7pDM4NLpfX1+zzVCA043MSOkNfhTew+HEdOok7V89OWCpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727766251; c=relaxed/simple;
	bh=EJVWpswAKBYpia55XxrfUeFsgJFUVC4eU7FXqYotZ8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOGdboQaqRdNmOLbmhIKgCpQBUWFi84IIMhOZAtjiP8FYI5WKrxkK5t0OH8Lv6z1sCRqoGG6lHc3OPZpVcisqkuGrHrXX0DSWRr+vU/HtLnLH1lacIPWtPIMGkufXjksLbwKZcc80mioHDwHO26zf95PmHAk2PfRk76zwh8IVbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbdEIOSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FC0C4CECE;
	Tue,  1 Oct 2024 07:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727766251;
	bh=EJVWpswAKBYpia55XxrfUeFsgJFUVC4eU7FXqYotZ8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lbdEIOSHXyxJBttsD0hhLCe1RusKtnmHmQWlTOIgxddLpLsFEsqpcbEpB73I602zd
	 GwP0gijk7IYDGWRLIrvPtxOXCYvZDPAMNOT5XwR6W12DuRxgFatuHZaedPHt2bKpFK
	 jfXRFt8xAFKRysku8opfATzqaocQXoGIXWMOSYIsXob6tXdgmd+JkOWsWiYGJRKin4
	 lza3R/CGU2XC/+2MdboJbLC9cXS2WJ0LbjTM3FISoMD7i0OCF6t4wttvzh2nKJkwxh
	 ATOmJAN+x8zZh1SCA7t+bkznmQWQe2rnkvDZNbi7VaZNseRG5I3cFxWZyhGUOhP25/
	 nKpLOxus0fK1A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab@kernel.org>)
	id 1svWvY-00000001V0o-2NKo;
	Tue, 01 Oct 2024 09:04:08 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 07/15] acpi/ghes: Change the type for source_id
Date: Tue,  1 Oct 2024 09:03:44 +0200
Message-ID: <4149830f15bcad19f6e32981754d437493f3aeba.1727766088.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1727766088.git.mchehab+huawei@kernel.org>
References: <cover.1727766088.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

HEST source ID is actually a 16-bit value

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/acpi/ghes-stub.c    | 2 +-
 hw/acpi/ghes.c         | 2 +-
 include/hw/acpi/ghes.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
index c315de1802d6..2b64cbd2819a 100644
--- a/hw/acpi/ghes-stub.c
+++ b/hw/acpi/ghes-stub.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/ghes.h"
 
-int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
+int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
 {
     return -1;
 }
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 5f67322bf0f2..edc74c38bf8a 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -383,7 +383,7 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
     ags->present = true;
 }
 
-int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
+int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
 {
     uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
     uint64_t start_addr;
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 50e3a25ea384..9295e46be25e 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -73,7 +73,7 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
                      const char *oem_id, const char *oem_table_id);
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
-int acpi_ghes_record_errors(uint8_t source_id, uint64_t error_physical_addr);
+int acpi_ghes_record_errors(uint16_t source_id, uint64_t error_physical_addr);
 
 /**
  * acpi_ghes_present: Report whether ACPI GHES table is present
-- 
2.46.0


