Return-Path: <linux-kernel+bounces-551807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114B4A5713F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52B93178D79
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EFA253322;
	Fri,  7 Mar 2025 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbt/xoxZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C9F2505C4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741374898; cv=none; b=CXgqo+4Q+9BG4GH6NlfkCNO+/9ZFoQTV6pobseRlvv2o70nYl41o3B8ajep3M7B6u38lP8tDX8IloUjK6fDIc4lVEpOWBGmmA2UwWm+u9beI9o238AfUoY2XrERhuqIm5YgMrcZq9u4ZYDiS941U0kL77yvjN3uGlf2d2wQDGBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741374898; c=relaxed/simple;
	bh=LvlI96l+YbIl5MsIJDnbtQxU7YniO+B5OBQkHO2lJqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOslX2h2Nx5x53aNnPywdUA5rFSjqciAhoEdHPmvpaeq+MzDg3otVjUp126ynSHgr4bpnBtOh7oalqrbVRvpVEUHBq0VCR4+kjK809WhDPzagbBzfIncm4hh6u85mdZd589m1FHPtwYY+AixkMpefvYHQdPB8WWBdaCjKbg6r1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbt/xoxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84B6C4CEEA;
	Fri,  7 Mar 2025 19:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741374897;
	bh=LvlI96l+YbIl5MsIJDnbtQxU7YniO+B5OBQkHO2lJqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cbt/xoxZQCzmWvuaKadzoWUZ6b+stlN+VllunKJ3ScaANDLd5HZLleyJbaRLUZ9X5
	 8f2zTWtjEAa5stb15RzSVU+88KHcGy4J4+Zoy+J15xLWnX9TO7/v7G4Nn0oqx6ANzB
	 g5CAvn14JzHSInSCXz/pusb34wVqTzDC+NTVJxmquCE8w4R5e31roNqjZUFEyPbyC6
	 +4epYM0QPNnG4FUVJsHUHOCgpkhsrV78t67nDWj7wJ4CpkFKkL1DmdS/t9wsRFsOnK
	 gCYIOzxQdp/JRcGz7mtJDbiisky1Z3ZiWjghdE1AC1ptwVYXu0QJTjgVwjz0Pvg2q4
	 n86V6m4fDC4vw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tqd9r-0000000BQmv-3kKe;
	Fri, 07 Mar 2025 20:14:55 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Gavin Shan" <gshan@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 10/20] acpi/ghes: add a notifier to notify when error data is ready
Date: Fri,  7 Mar 2025 20:14:39 +0100
Message-ID: <af2bb6dd484aca8fd8baf29200cf2a04e365befe.1741374594.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741374594.git.mchehab+huawei@kernel.org>
References: <cover.1741374594.git.mchehab+huawei@kernel.org>
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


