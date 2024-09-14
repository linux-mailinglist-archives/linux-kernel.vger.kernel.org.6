Return-Path: <linux-kernel+bounces-329165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0580C978E3D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 08:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C0D284775
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 06:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407061482ED;
	Sat, 14 Sep 2024 06:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKtc53yV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF896E614
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 06:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726294434; cv=none; b=IRt5upJp63BWwjN+yi5pYQuSdrv0N1hc8H+UwD/6jn79DPYpCnOJ5IXHNjME+4HCyTwYGmU/6gIsPA+tgML1uQEDP9tn3yZ3c7BNCWpUQSpnnffk794ascWSbMa9ECWkVmNNkOM+TnkONWVfzj60RJcLlAFEhq74zwBLxwZW1xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726294434; c=relaxed/simple;
	bh=rOz2cndH3nNMcDN2uIMMMoryGTnl09uDUgmaCBrSPzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHIV8g+SR2Ozq7ho389j/9TRwpaJ7geJernABGAIdo8PvhF/Q8U58ZU/maSVxeCpegF8ryT98mCjO977/+FnXoAT7V+1okThVPJEe/vdg5g7zRUli47Xy9/6c0sOyoZ2kWgRKXR/hM75/b7jg9GOjO3WjcmwIOvqCxd+AiLKz8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKtc53yV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287FEC4AF0D;
	Sat, 14 Sep 2024 06:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726294434;
	bh=rOz2cndH3nNMcDN2uIMMMoryGTnl09uDUgmaCBrSPzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CKtc53yV3Irs96TZAqTudg8emR0URa67qodP02zdVGPrMX8LxRyCRlO44LF9AoFg4
	 vK/AF+AXcskeHQH25OLrFLo87iSQmL1PrfuS1oOiqNlODG5mqzbgFTTAKe8PPZsEWP
	 xeL4WJV9pwFfQ9WUxaQTzPgx+uhvYEFR9eigEmWZpv/VHCEl9EpELpbHUU4EPCoDGC
	 a/STbxLG2IbS34rdKN305o+HqaISAZ5yCxbXf3l/hxjO3wocyW80w3bUuPqsH8cT1H
	 tOvWZeQ0XM1SUBKerL6TybU7DYyJEgluT3eW8t4znXpc+g7RWoB9e8B+ZyRbcOot3g
	 8cIOVxkpnW2mQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1spM2a-00000003V6J-1Gmn;
	Sat, 14 Sep 2024 08:13:52 +0200
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
Subject: [PATCH v10 14/21] acpi/ghes: add a notifier to notify when error data is ready
Date: Sat, 14 Sep 2024 08:13:35 +0200
Message-ID: <bdcbee82bbcb614dd7ed57fd63d504af5cd5c558.1726293808.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726293808.git.mchehab+huawei@kernel.org>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
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
---
 hw/acpi/ghes.c         | 5 +++++
 include/hw/acpi/ghes.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index a8feb39c9f30..7bea265c7ef3 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -409,6 +409,9 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
     ags->present = true;
 }
 
+NotifierList acpi_generic_error_notifiers =
+    NOTIFIER_LIST_INITIALIZER(error_device_notifiers);
+
 void ghes_record_cper_errors(const void *cper, size_t len,
                              uint16_t source_id, Error **errp)
 {
@@ -499,6 +502,8 @@ void ghes_record_cper_errors(const void *cper, size_t len,
 
     /* Write the generic error data entry into guest memory */
     cpu_physical_memory_write(cper_addr, cper, len);
+
+    notifier_list_notify(&acpi_generic_error_notifiers, NULL);
 }
 
 int acpi_ghes_memory_errors(int source_id, uint64_t physical_address)
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 7a7961e6078a..83c912338137 100644
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


