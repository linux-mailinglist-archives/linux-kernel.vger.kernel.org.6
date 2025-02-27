Return-Path: <linux-kernel+bounces-536785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393BFA48430
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 584363A6822
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5BD26E166;
	Thu, 27 Feb 2025 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ey7RwX5u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B0A1AF0C9
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672063; cv=none; b=j8lFOG4eOmiOTlOH4ry0kS71ElC0JKwyeBS+kmxWpXTJ7oihtj7aN1RPObMoZc8AT9orsF5iE+PTbBY9XunlwnkcA02wyE7YLrVrl4vN0byQypI/XOXQZL1lRqaWyro1D+S//WP9TqhwVHEoNueD3T+s0Y4N3Q0q2xyTrEtzQy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672063; c=relaxed/simple;
	bh=bxK9Et1UjLido8TcaM0YtPM1EGz6KNWSFKPtGUAIaGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRyNvvGMhVMe+x+njmPXtMBj3xECQ+NbhAn9160OtHCbpp0IaI4Gc9zq2hNMQU+P0y18xsNFBIzvxt6Cq1ROmIOAdOr5CjwLHVct8fpVL/eyjsaKgh59yBHIbaXgmqrLMLH/AdtPeWzc88Kob5i5zxQZF7SkJ5kFITe7CddfSIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ey7RwX5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149A3C113D0;
	Thu, 27 Feb 2025 16:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740672063;
	bh=bxK9Et1UjLido8TcaM0YtPM1EGz6KNWSFKPtGUAIaGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ey7RwX5uYigzJuDdeBDBXHhjx2+oD7DhU0XnlvLVuXcnICl2v+ztVZqLXR0B9s3Mr
	 NF9yngAHJ4OdGd8+YuC/OeU/3O8uuZxMNlDwvOUJdmSbiKeQbgMsry2iyZwMxKOUnJ
	 yQGdeoQ/FYCbQvC3A8LdNHpkBWaohJw2d87ZBgmQi7Rywx47jWqekQHVI3KYJHZ9Zc
	 W1Hbrr+lbJR9G1AKOS8r4NSHoc89q0+Y7LcApvdfHAC0uVhDGMxqYuW33cJ9SxVyqU
	 Daox1uiMXivZBZXgRkaqzV63xALQPHyMs6yksUKyAIYgbH+fu3pq13GAGJdWymCITP
	 4RBeR2DfVs1Qw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tngJp-000000023bt-0vId;
	Thu, 27 Feb 2025 17:01:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 18/19] docs: hest: add new "etc/acpi_table_hest_addr" and update workflow
Date: Thu, 27 Feb 2025 17:00:56 +0100
Message-ID: <445f7d41b01ffc5bd79d6fd83bc7c4c621bcbc85.1740671863.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740671863.git.mchehab+huawei@kernel.org>
References: <cover.1740671863.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

While the HEST layout didn't change, there are some internal
changes related to how offsets are calculated and how memory error
events are triggered.

Update specs to reflect such changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 docs/specs/acpi_hest_ghes.rst | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/docs/specs/acpi_hest_ghes.rst b/docs/specs/acpi_hest_ghes.rst
index c3e9f8d9a702..4311a9536b21 100644
--- a/docs/specs/acpi_hest_ghes.rst
+++ b/docs/specs/acpi_hest_ghes.rst
@@ -89,12 +89,21 @@ Design Details
     addresses in the "error_block_address" fields with a pointer to the
     respective "Error Status Data Block" in the "etc/hardware_errors" blob.
 
-(8) QEMU defines a third and write-only fw_cfg blob which is called
-    "etc/hardware_errors_addr". Through that blob, the firmware can send back
-    the guest-side allocation addresses to QEMU. The "etc/hardware_errors_addr"
-    blob contains a 8-byte entry. QEMU generates a single WRITE_POINTER command
-    for the firmware. The firmware will write back the start address of
-    "etc/hardware_errors" blob to the fw_cfg file "etc/hardware_errors_addr".
+(8) QEMU defines a third and write-only fw_cfg blob to store the location
+    where the error block offsets, read ack registers and CPER records are
+    stored.
+
+    Up to QEMU 9.2, the location was at "etc/hardware_errors_addr", and
+    contains a GPA for the beginning of "etc/hardware_errors".
+
+    Newer versions place the location at "etc/acpi_table_hest_addr",
+    pointing to the GPA of the HEST table.
+
+    Through that such GPA values, the firmware can send back the guest-side
+    allocation addresses to QEMU. They contain a 8-byte entry. QEMU generates
+    a single WRITE_POINTER command for the firmware. The firmware will write
+    back the start address of either "etc/hardware_errors" or HEST table at
+    the corresponding fw_cfg file.
 
 (9) When QEMU gets a SIGBUS from the kernel, QEMU writes CPER into corresponding
     "Error Status Data Block", guest memory, and then injects platform specific
@@ -105,8 +114,5 @@ Design Details
      kernel, on receiving notification, guest APEI driver could read the CPER error
      and take appropriate action.
 
-(11) kvm_arch_on_sigbus_vcpu() uses source_id as index in "etc/hardware_errors" to
-     find out "Error Status Data Block" entry corresponding to error source. So supported
-     source_id values should be assigned here and not be changed afterwards to make sure
-     that guest will write error into expected "Error Status Data Block" even if guest was
-     migrated to a newer QEMU.
+(11) kvm_arch_on_sigbus_vcpu() report RAS errors via a SEA notifications,
+     when a SIGBUS event is triggered.
-- 
2.48.1


