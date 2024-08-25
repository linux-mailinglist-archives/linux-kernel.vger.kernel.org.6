Return-Path: <linux-kernel+bounces-300236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 012B195E0E2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 05:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324EB1C20EA5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 03:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172DF4DA13;
	Sun, 25 Aug 2024 03:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKA339dS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E60147F4D
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 03:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724557625; cv=none; b=nb+u+iric9yr5uXCRNoYPHmD99M9opbnWAPYKlFNLgKLJS41f0mxsMojYwb/cPUnZ6R5Dy/Ia+4R2eAZwKZqO4hZV7s56tYIubbMtHUMZDaIEkedX2/K/U6CmWbrHuILFmCrMpmBiZzOJZA+H/QmIhkftIyaIZcEzo8l1FtHthc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724557625; c=relaxed/simple;
	bh=LhonfX5szAcii0iSJEisUGaz09LnvbNzPlyCpn2Dcys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ame0A3BA9h0Gmf/YDU/w9YBPvKDxJg23yi9HDacPvNAyngEZBjMYLyrs7prI1yDFyqceG40EC2HKqczocJzSDFdD3VHdofAI+fmt0cVIl2w1gI6LFgRZIRh7f5wdR8mkWUB8yPZKY6PNl2T07VqvZ7BrP/wA+wTm4XEXRVEx6wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKA339dS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3253EC4AF10;
	Sun, 25 Aug 2024 03:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724557625;
	bh=LhonfX5szAcii0iSJEisUGaz09LnvbNzPlyCpn2Dcys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NKA339dSbfHfp4KedP6XRTu5n4x8t8OWeAgFehrjvdevOjYtWatBM66bLhpfWK8VS
	 26NjfamCm5pNwlFDlkY4yW0yov0zKMMQD5+tcagu3pU73DO3355PozV1o+uQRe8wfK
	 AYg31DiPdS41cTwvp8Q/I3juQwNHJDuSJlk08cmNIP7KOXuFPUBxfVaZQbVRlZvieg
	 XfjaXaFcd9dLqewcY/gXajuXZ0W+LdWv0X+fVCNT2Lb4lTXi5r7RpY1rJqW012/9aD
	 Fw6sZijMrn59c7Guz0sOfoFYP+Ep8N/IOyadPhjH4aWOGPJOlA8J8cJ8txhOJ4aE9Y
	 MHk0TnMKmbfOA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab@kernel.org>)
	id 1si4Ch-00000001RMv-2rOU;
	Sun, 25 Aug 2024 05:46:11 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH v9 09/12] docs: acpi_hest_ghes: fix documentation for CPER size
Date: Sun, 25 Aug 2024 05:46:04 +0200
Message-ID: <e81a142a8de9e5b8e1c108a4bd089e4825a17132.1724556967.git.mchehab+huawei@kernel.org>
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


