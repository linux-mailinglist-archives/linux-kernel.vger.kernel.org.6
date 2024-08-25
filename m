Return-Path: <linux-kernel+bounces-300235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF8895E0DE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 05:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39EC81C20D7D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 03:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8D42207A;
	Sun, 25 Aug 2024 03:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDuQ68HG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B57210FB
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 03:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724557623; cv=none; b=OGyxq5K+mVmUwLXuzYujyTSir0qbOrUHMp3tKw4o2iXpBJ/72PczAZ9AdwZIKYJYlrmK/N+NmrtFKspanpQVYDxcR2TvRVb961l5I9NMI/WQyi4z4uPw0RC38sl2W6HRkkFTk8m+QQCE4ePWc79T+5CA3PS6LmYKy6nc/aS8c5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724557623; c=relaxed/simple;
	bh=5AZ7gcx7Epfz/DsbRMWAPh0EKquiqLdFovJJ8Emue9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jmUkGamXPxyeouNjMxIfFnPRtKbNZuQ3w0FaBgqfJcfngjzNIyGZwVkQYDFEIwrIEHbzQmvSY6XxT9h2WlvFeTiNnjBA4/yXXUHSuxWikWOoBgy2ivo35W0FWGJEQ2euxhchZWIktToNnHB+ONa7sHuGs/YnYDtm40Ais5U8gbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDuQ68HG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F46C32782;
	Sun, 25 Aug 2024 03:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724557623;
	bh=5AZ7gcx7Epfz/DsbRMWAPh0EKquiqLdFovJJ8Emue9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IDuQ68HGu9TVTaDbCf9ZxmlkulgF/+YTcCsgPXvTghLswq365IGw5Ug8svwVGJnhm
	 i0PXMeiRfGn586PLzisvk9pVM6LnLaL9tYyIVX0FYR4ggyb2vhfEF/7yfP5XEEj7kY
	 LB2+dT4l9jXtBHgqBecib5p7uob4DpvmDzASJmmIFhOjdweKNx4fnFCuAd5E7qOOci
	 F6HrB33qsZOGyvjR27VWujJhuhrnHOuUZH8quldDvUoPwBwjCasvTDt3gZeJLHUiM1
	 wI5PLvDQSZ0Hi+U1hdfDh3iq35Xl4O3tlttK5jrKb4rEjHYCtvntP+uQvBdouxqKDC
	 wQofiTVB+Wjog==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab@kernel.org>)
	id 1si4Ch-00000001RMj-2VWA;
	Sun, 25 Aug 2024 05:46:11 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v9 05/12] acpi/ghes: add a notifier to notify when error data is ready
Date: Sun, 25 Aug 2024 05:46:00 +0200
Message-ID: <de2b61eee8b76f6d696f2de986176cfd02e23fe2.1724556967.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724556967.git.mchehab+huawei@kernel.org>
References: <cover.1724556967.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

Some error injection notify methods are async, like GPIO
notify. Add a notifier to be used when the error record is
ready to be sent to the guest OS.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c         | 5 +++++
 include/hw/acpi/ghes.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 10ed9c0614ff..2b7103a678a1 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -402,6 +402,9 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
     ags->present = true;
 }
 
+NotifierList acpi_generic_error_notifiers =
+    NOTIFIER_LIST_INITIALIZER(error_device_notifiers);
+
 void ghes_record_cper_errors(const void *cper, size_t len,
                              uint16_t source_id, Error **errp)
 {
@@ -492,6 +495,8 @@ void ghes_record_cper_errors(const void *cper, size_t len,
 
     /* Write the generic error data entry into guest memory */
     cpu_physical_memory_write(cper_addr, cper, len);
+
+    notifier_list_notify(&acpi_generic_error_notifiers, NULL);
 }
 
 int acpi_ghes_memory_errors(int source_id, uint64_t physical_address)
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index be53b7c53c91..b1ec9795270f 100644
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
2.46.0


