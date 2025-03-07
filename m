Return-Path: <linux-kernel+bounces-551821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3D9A5715F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA081899B33
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401D625A2C9;
	Fri,  7 Mar 2025 19:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwtCCb0R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B572528E4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741374898; cv=none; b=h6Fr4p5gKIuN8u15wwFk7p29Fgc0idjyH1CY8tuU8Q3R793Jw1bffnPUyFsr0TICCEKcmZ16H1KpGRYl+4xqHq4bLigL3xSvueWnf/8r3sa4QwDSRrnC2cJtcQBpXpJdUnpMo1wnMW0AY8/x9i8GJfvZWIm+VO123jLThh5fTNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741374898; c=relaxed/simple;
	bh=J/oceRB+tMp1dlwMr5XDGzHWlOY6Ma1Afet+7GnEmTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqEltFeOd1DsA86I8JJi8I9xnIEwWesrSWWS6LtGpsyu5Hg/tT09T2DSB0mw3BvNQxvfZ1q71V4MSmja+jdm0PLhjfoqRcVdeIvUBqhDbFH5fNZfzkVx/H+EbTM9tP0qnGlKledt0LnAU/FsZGLiYbQRexhCEMGqza3aPpipj0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwtCCb0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C0BC4CEF9;
	Fri,  7 Mar 2025 19:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741374898;
	bh=J/oceRB+tMp1dlwMr5XDGzHWlOY6Ma1Afet+7GnEmTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SwtCCb0Ro0LiZmwFPPWMIpptkzE64sp6hkpc96HCL6G3cRqYOyVR9bs9VqZ9+6drp
	 KeNYivajAc+Z8+/yqeCeQNTjCjhyo55SUBVlAk+CGqjdcnqt4wM6R+GeU6yGFX9CQb
	 mVRwAo/sQMJYk0tKNqB81qdgKQYi5A9gExf9dKQdEUNcp+i9pzl5F7MoQHPRKpjquZ
	 KhSqwfgc47W4aHG3Mkqk8NANzlHvRTIoWkCFrGVjbWFBTQ+IYLJ2Rynkiu132Y4Fp3
	 YsXADhey233FuKH5u3Ra+rJjzyNyMXRgmHZJyrYHL1ylH1vF06Mf1RBghvr1yEDYau
	 NX4VmYdyYArMw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tqd9s-0000000BQnW-0WMr;
	Fri, 07 Mar 2025 20:14:56 +0100
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
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 19/20] docs: hest: add new "etc/acpi_table_hest_addr" and update workflow
Date: Fri,  7 Mar 2025 20:14:48 +0100
Message-ID: <1cceb0e97bdddf0eabb8da794fdaaea295faee41.1741374594.git.mchehab+huawei@kernel.org>
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

While the HEST layout didn't change, there are some internal
changes related to how offsets are calculated and how memory error
events are triggered.

Update specs to reflect such changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 docs/specs/acpi_hest_ghes.rst | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/docs/specs/acpi_hest_ghes.rst b/docs/specs/acpi_hest_ghes.rst
index c3e9f8d9a702..3d1b85d74b70 100644
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
+    Using above mentioned 'fw_cfg' files, the firmware can send back the
+    guest-side allocation addresses to QEMU. They contain a 8-byte entry.
+    QEMU generates a single WRITE_POINTER command for the firmware. The
+    firmware will write back the start address of either "etc/hardware_errors"
+    or HEST table at the corresponding fw_cfg file.
 
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


