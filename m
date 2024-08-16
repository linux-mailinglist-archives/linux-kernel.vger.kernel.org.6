Return-Path: <linux-kernel+bounces-289193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE729542F9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632AC1F27218
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234C6143C67;
	Fri, 16 Aug 2024 07:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPnHQlGf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21648139590
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 07:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723793874; cv=none; b=A+ZNkggZLgVTPW0NVgyJtWfEWnAiqz4bfehVjHGjxwF4CfKJeiYPXZwsU7iqDCrxnPh9V8w/SsVYxVW/0XF7DqwsXHeFsJLF+3sXhEBjePV/cMqXkU6UXFgDm91VtrEzb9qkdDuhE9qhGgILhY86Wm7prJcRi9EJmjErh4R8wK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723793874; c=relaxed/simple;
	bh=LhonfX5szAcii0iSJEisUGaz09LnvbNzPlyCpn2Dcys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0Xg5f7mP6PdVx6Y5x8sEj09bCJBTfxB9bYfNjHKWgnxKSDTNe720j2yvjIX+8oZ03J57GI9Aouwo3PoVutkqtHA+z0RyrYNZcigILc/4HcHtKlrRM84wyZnrBSAStQKpswHUxDh3AR6Rs6C9l2N14F8mwmtYylfE8X2YTmBbBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPnHQlGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B8BC4AF16;
	Fri, 16 Aug 2024 07:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723793873;
	bh=LhonfX5szAcii0iSJEisUGaz09LnvbNzPlyCpn2Dcys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iPnHQlGfj7oEFjKfob4/34r5CTTUH/bzK/dJoAyJlI8UY/0xZAwng5cD3bIgkVIg3
	 hr77iH6c/9xfUU+KmPlRjCE8rNW7gtOjyfqLibObsnj+t9XSdmDnB5vKvz5qodIP+v
	 8QmnZlFl2tBtAfgddDVja/mOppKyECF8BEmew8KNxrF251yNz7qRRBHxcAcuhMekc+
	 qUvxZ3fe9Jfm/wv7yzR472kBb/uib8zbxyk5vJ2UXQ22P8TyHWvnUxaAvhtD53c0y2
	 Xoi0qY5qc9/oUa7cJNJ0HQw0o3HWs0BHT3wVMO8piOZYHSm6xCxWOUocHrv+nvaHxf
	 wh907YVpkjP7Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1serWx-000000055en-2aTs;
	Fri, 16 Aug 2024 09:37:51 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH v8 08/13] docs: acpi_hest_ghes: fix documentation for CPER size
Date: Fri, 16 Aug 2024 09:37:40 +0200
Message-ID: <e9c2a180d1c68fb114409c9ee5f40b64c332c390.1723793768.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1723793768.git.mchehab+huawei@kernel.org>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

While the spec defines a CPER size of 4KiB for each record,
currently it is set to 1KiB. Fix the documentation and add
a pointer to the macro name there, as this may help to keep
it updated.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Igor Mammedov <imammedo@redhat.com>
---
 docs/specs/acpi_hest_ghes.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/docs/specs/acpi_hest_ghes.rst b/docs/specs/acpi_hest_ghes.rst
index 68f1fbe0a4af..c3e9f8d9a702 100644
--- a/docs/specs/acpi_hest_ghes.rst
+++ b/docs/specs/acpi_hest_ghes.rst
@@ -67,8 +67,10 @@ Design Details
 (3) The address registers table contains N Error Block Address entries
     and N Read Ack Register entries. The size for each entry is 8-byte.
     The Error Status Data Block table contains N Error Status Data Block
-    entries. The size for each entry is 4096(0x1000) bytes. The total size
-    for the "etc/hardware_errors" fw_cfg blob is (N * 8 * 2 + N * 4096) bytes.
+    entries. The size for each entry is defined at the source code as
+    ACPI_GHES_MAX_RAW_DATA_LENGTH (currently 1024 bytes). The total size
+    for the "etc/hardware_errors" fw_cfg blob is
+    (N * 8 * 2 + N * ACPI_GHES_MAX_RAW_DATA_LENGTH) bytes.
     N is the number of the kinds of hardware error sources.
 
 (4) QEMU generates the ACPI linker/loader script for the firmware. The
-- 
2.46.0


