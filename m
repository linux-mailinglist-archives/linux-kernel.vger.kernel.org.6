Return-Path: <linux-kernel+bounces-417986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A1F9D5B8E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A197E1F23479
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988A81DE8BD;
	Fri, 22 Nov 2024 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jS8pVzYE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1931218BBA2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732266709; cv=none; b=EvUMi8TnytdMA2ikDunhgM4qwWbbhlI6ctM3DormbRSCNWByvnaGr0e5sbBVM+N2KRc81jzeCdCW1b5xeXozTn647Iv5jlGJ1vnkR+vFrwJeMVFI9gDhoEGItE1MTVaVfLgNARwtDMgZscIPoNUxuMSMUbudvD27Xb2zJTpzNzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732266709; c=relaxed/simple;
	bh=3q4iw0X8CIIZSET8d9LVRHez80oiBXEYI6La10ZBs2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUr6jSOUsC8RVNxbACO7ag5AhEtZgaeJf557oav+fSUDx4d/8kqcfAfqbnuoiUQ6/aKQ8z3F1NFJp4LlkAvgmTiF8s/Q62wxndLyruwZG76DqajQVA9QYRfONYGkfjpkmpr51h7AR4RsLjJlWm+TMfUEd6I5KoSCgacE6qHuAdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jS8pVzYE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83057C4CEDB;
	Fri, 22 Nov 2024 09:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732266708;
	bh=3q4iw0X8CIIZSET8d9LVRHez80oiBXEYI6La10ZBs2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jS8pVzYEGdbIOf/LBSWmnly7FTCZTAoGJWxB97Cq7HFPyhat1ohlQdORYAPkhi5HE
	 dalvTn3KTjHgFeLNYUHYUTXhqEGVQX4IG6xEQsJUUPakjtSgjrJzelsh80vWYjo/Zh
	 QRBZJywblfOa6a3nEy9a7kf2m/4bN0iRZz4mwjvuzeBa3aHPV3fuiNpxelHY3D4STa
	 3FH1hbRbVi+QX4/U1UkaJ+uKFlJfsBGSAwvI8HDD34yS72BS3ndyRP972SvVSen6/6
	 2Ld64jsIh6b4/3UNPleUQhVTaOoBE+rkMQ2YXwwogJonp/wm6UPgTDjMkVpWxLah+9
	 gfA5MePoZ2iZQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tEPhX-00000006l4H-1Q5o;
	Fri, 22 Nov 2024 10:11:43 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v4 15/15] docs: acpi_hest_ghes: fix documentation for CPER size
Date: Fri, 22 Nov 2024 10:11:32 +0100
Message-ID: <3bfe6c991d187f48b9c34500be106296b9480059.1732266152.git.mchehab+huawei@kernel.org>
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

While the spec defines a CPER size of 4KiB for each record,
currently it is set to 1KiB. Fix the documentation and add
a pointer to the macro name there, as this may help to keep
it updated.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
2.47.0


