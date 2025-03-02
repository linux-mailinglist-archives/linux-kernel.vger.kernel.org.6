Return-Path: <linux-kernel+bounces-540431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B55A4B084
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 09:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6F0B7A758E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1751DB148;
	Sun,  2 Mar 2025 08:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7C/SZ1u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DF2EEC8
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 08:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740903737; cv=none; b=fGOZWs39QSscVOITvMqCYWE/3FN8rcCbDM5d/X4RRUdHS+3ryeby4/8MbELz5H+Sak+SeYfiPa40P3p98R/cBttN94eEtYUA6vfwdYsffCShjTEm2Q9PMU+1DlypQs8v17RtkjecmEkmHJ/p6P5ApaUb/Ic4ryXzEWSPUUnQkTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740903737; c=relaxed/simple;
	bh=LvlI96l+YbIl5MsIJDnbtQxU7YniO+B5OBQkHO2lJqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVBjUrNKj0MXEogxuHFMHDJruG6qcJYJOIjdtF3dSqtuXNmRmQYEy9a0COhtLxeqZ0AhZGhWvCBWSM0WMGfv+IGVf4uzArCI30yQ2li5ln/n+MIGJSa3SJG9oAPYhy8lwVoOpZxmuLbgeHgviXQIIzybxF9fPGnYlkQUOe//FM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7C/SZ1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFC0C4AF0B;
	Sun,  2 Mar 2025 08:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740903737;
	bh=LvlI96l+YbIl5MsIJDnbtQxU7YniO+B5OBQkHO2lJqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p7C/SZ1uHSjQxjnVUw53vjjHVcqNcPp6caMOXp8UNn+LwKDFIxSnFaXgtD3G8D2KC
	 dDaRs34uFwu3dp8T247CnHJgnvsijRQGjJhuNv+ZsUU7N+ff0j8h3QCUwdbTceYgkZ
	 1qNReLuH/DGNJUYYRVf7dcqclWoG1AIQBdCvmGmJ+qe8k2Ixp6sbtRX6kVDFh5oLeg
	 E+G5xo9hYgJlMMMfQwwcSolt++8Zbl3jjnV1HwzYUsMRAaBiXBe1+1Dc6TjenhUCEn
	 943ml/YhxvFF7zUKgjLd7zzgdvUJUYXbAawM4sLLwKXBEwQB1KeNE3yeEInsz1dp1W
	 KX7+iiWGQj0Gg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1toeaU-000000043S4-2xlj;
	Sun, 02 Mar 2025 09:22:14 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 09/19] acpi/ghes: add a notifier to notify when error data is ready
Date: Sun,  2 Mar 2025 09:21:56 +0100
Message-ID: <50b5db8420a552e3502b4f9f654f48ee8546dcdf.1740903110.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740903110.git.mchehab+huawei@kernel.org>
References: <cover.1740903110.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Some error injection notify methods are async, like GPIO
notify. Add a notifier to be used when the error record is
ready to be sent to the guest OS.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/ghes.c         | 5 ++++-
 include/hw/acpi/ghes.h | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index f49d0d628fc4..0135ac844bcf 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -510,6 +510,9 @@ static void get_ghes_source_offsets(uint16_t source_id,
     *read_ack_start_addr = le64_to_cpu(*read_ack_start_addr);
 }
 
+NotifierList acpi_generic_error_notifiers =
+    NOTIFIER_LIST_INITIALIZER(error_device_notifiers);
+
 void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
                              uint16_t source_id, Error **errp)
 {
@@ -550,7 +553,7 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
     /* Write the generic error data entry into guest memory */
     cpu_physical_memory_write(cper_addr, cper, len);
 
-    return;
+    notifier_list_notify(&acpi_generic_error_notifiers, NULL);
 }
 
 int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 8c4b08433760..390943e46d99 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -24,6 +24,9 @@
 
 #include "hw/acpi/bios-linker-loader.h"
 #include "qapi/error.h"
+#include "qemu/notify.h"
+
+extern NotifierList acpi_generic_error_notifiers;
 
 /*
  * Values for Hardware Error Notification Type field
-- 
2.48.1


