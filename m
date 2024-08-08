Return-Path: <linux-kernel+bounces-279448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F3494BD77
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B0E1C22955
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD76218CBFF;
	Thu,  8 Aug 2024 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOVb1vRm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250641891D6
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120003; cv=none; b=cFxXNEEXyMQ3T+NCd7Ig2v/DUhS+shw4/Iqk0objJ6Q4TTQ8QgFHh6j4F3mx2l1/b7//FFRwlGbWP41d+82wkr6+SuQvmgV3uEp9H+fjs9QRTZhAL7uBT8Bkbpb+m4CXmiSRoRb4TTAM6V1soRu0rsD6RUUj0FWqUVXxVSDVp4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120003; c=relaxed/simple;
	bh=u+gtNcYPnwzIRNiBgtrexQw/P62CjJ4KAOxlXUYS31Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtnxK9e7JGwSSUnPFrs9fZ+GhkOGz1Nw4HtxGH7uhi9gFerCr7p7AOyNFSOBqXaBGVTnOCkd7miSKzRZopg9fn2MStcuM26MgqjW9VgWm7jw0OMx6ZeVkhqUYZUx7kTig6FPcsso7B9B//L93dz0WTvA6mfBTzv+k0tBhNumhBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOVb1vRm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C7EC32782;
	Thu,  8 Aug 2024 12:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723120002;
	bh=u+gtNcYPnwzIRNiBgtrexQw/P62CjJ4KAOxlXUYS31Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UOVb1vRmy7xP4czfIIFhRtb08tspyh+2pJJCOZDcRycIvlJbpzco+8m9UoEo35M6A
	 cQDpbp6gCbhXFGdTMBLCBkdrLZBT+PDHGwwOTwB4IR6XCrrS5AY0L9W81HySxrwFVW
	 DerW1OdriegC2dLOnugF+f9d3XCXbqF1BsRg8ScAcYKgUH2Ppb+P/Z9KeNk1EOXfdV
	 /a7FEiDa20f+nfLE2aJcPVSIDNGEIxo/rcmx9owHZENZHBL1XCclDLHldiAuWtx0lG
	 g684BeDwcXMn1qeUGz6djBFlMP3O7XaCMoiWfoQ2B6oCtdQvCIFUOMoYPkT7etUDEM
	 joSGivAYiCEcA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1sc2E4-00000000oDa-4AWQ;
	Thu, 08 Aug 2024 14:26:40 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v6 07/10] docs: acpi_hest_ghes: fix documentation for CPER size
Date: Thu,  8 Aug 2024 14:26:33 +0200
Message-ID: <93ae03bd89b47731f6703dab5925ed2f7a9fd426.1723119423.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1723119423.git.mchehab+huawei@kernel.org>
References: <cover.1723119423.git.mchehab+huawei@kernel.org>
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
2.45.2


