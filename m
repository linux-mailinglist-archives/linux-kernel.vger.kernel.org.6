Return-Path: <linux-kernel+bounces-435407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 672839E7710
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7055C18825C7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C7421E98F;
	Fri,  6 Dec 2024 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+RyoIW8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC0920458D
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505688; cv=none; b=HfWcLl0KsgeeX0m5OKazNsdGkPkBJNeuSPhyDFplExxtAlXRJqwJTaBmK1ZAvyG8jCZyV+un6mVOKp6ma86fUKauYZz1+wFdRjG761eFUil5EcxqqXZO41N5NIG8d354zoxlQ2vhER4P7XeGSiUwluOTElHtOlnpsig0o6hwF9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505688; c=relaxed/simple;
	bh=DZq3ehynlc63lZ3iGs1SNcajfqzDutIBxgWe19LJFlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJbRFeTxjwTn1SgmBFe9DPO820ONxjddIFKoqTyNBTMikXHqhrSTLzwoUV0LC2ewsKgCRzGaBx5zuBy4C1k82LBbSUJ4vFFTXk6DbNMoW6nOH1UXzR1BfbFBiSVYhWgjrmEDlAor/i/NraeYgVZQ8mhoGYtiSLEORr5zSnID97s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+RyoIW8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A59EC4CED1;
	Fri,  6 Dec 2024 17:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505688;
	bh=DZq3ehynlc63lZ3iGs1SNcajfqzDutIBxgWe19LJFlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g+RyoIW8bHE/jCi5h2WD2niAuaS+GZ1/o3Mynthkk8pQy+XooGoRNwvV7fnHo9bHq
	 g+E3icfW2ETNZUdbtcdh+ErCOZ6PXfOOBvkZ1VC9qhm2Ojn8Xf5jT4mw5xGdyJesqW
	 tZjAjwCEUOVmo0s7j85HDASUad56eJVIXNkQ/oI445EIO4h3bROnrlOav2+cMZDuwi
	 vlrdENRTN5b2XUHfpCFHAeRKQswxGpik5ynKkdGCj5svn/HSUWACWRS0e6GROlHOZS
	 99SxzijvGNLI+lRgLNU9cCZsTpATEn9i5fqCtjj/Sj0J1dm2Vnvp4KCeeL49GyJDcK
	 pr2Is0anIslwQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tJc18-00000005RLT-1FIQ;
	Fri, 06 Dec 2024 18:21:26 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH 30/31] docs: acpi_hest_ghes: fix documentation for CPER size
Date: Fri,  6 Dec 2024 18:12:52 +0100
Message-ID: <abd4dbe629f95a5c0d5f26d052e3f819b37c89fb.1733504943.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733504943.git.mchehab+huawei@kernel.org>
References: <cover.1733504943.git.mchehab+huawei@kernel.org>
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
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
2.47.1


