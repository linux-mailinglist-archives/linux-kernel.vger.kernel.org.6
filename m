Return-Path: <linux-kernel+bounces-417978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A2F9D5B7C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B26F4B22094
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830521D798E;
	Fri, 22 Nov 2024 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R52bK5dT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF0215D5CA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732266708; cv=none; b=cDRb1GGyMWZsrEXtS0UXBFAD7oWpkd4tzoQqi+0qLdflr+kU4Q443laM37atFeO4gVLUgNDgKNOV46lJTERHa/CKkqsmLdIa2k84rwKUnex6v5yNRYqLYjyrfrGw9jR/tNcxZlEFAlUVY1bG+zSxniEXezdZDafstrobJsNT690=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732266708; c=relaxed/simple;
	bh=Jpw03OAVmKrjW75U8f0KTzCuzLgX024dWth/Db/t5WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bifAela9BIkYp4bwWtLf13NKefb4vTsYIUj4urvNGwbDK8tIm7RyHtz6nU1CFQzFheHWaDzBo4EN7uJitYvgSHp/pIKFgCuZlH2P2h0zdQfcz4ut121SqmFjizRqKdWs9h3U4ZC0W21k4Zo8XLEbY+/QUmQeftuTBCCgGma8XFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R52bK5dT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67097C4CED0;
	Fri, 22 Nov 2024 09:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732266708;
	bh=Jpw03OAVmKrjW75U8f0KTzCuzLgX024dWth/Db/t5WE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R52bK5dTR0zzen9fII3gqQNS4BqfPmKY2XVN7fqHlHtzQbv7MkRM2K9MvopXr1vCf
	 JrAdzM/+ac6x4mKhoG4pfvxcJQLHXm+9cJIaXrOnhP+ZIWbysvHAIjlXnOKmBk8O7g
	 5NKQ9gGNm38HiSZUh5UcoaD8jd7C57ZHrBwKZuufAc5sgRj0s75iRpw3TPAMMY2L6u
	 wdDq3Ho7VJWej2CilYvDFxWAN6XMHRJ9aC4eVrVRjfZYDfNM4/+d1aYTj+b5K+faC4
	 7aaC5xWOIktemQTzc12dMe0NQ256PFkZ3PiBUTEcDj5UfX+dIqVJLBgzKdVnMSJ6ok
	 dTw5LBsCxW4dw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tEPhX-00000006l4E-1JNH;
	Fri, 22 Nov 2024 10:11:43 +0100
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
Subject: [PATCH v4 14/15] acpi/ghes: Change ghes fill logic to work with only one source
Date: Fri, 22 Nov 2024 10:11:31 +0100
Message-ID: <cf16e0900e10c5a39e11b590f5267a4b9c228060.1732266152.git.mchehab+huawei@kernel.org>
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

Extending to multiple sources require a BIOS pointer to the
beginning of the HEST table, which in turn requires a backward-compatible
code.

So, the current code supports only one source. Ensure that and simplify
the code.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/acpi/ghes.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index d99697b20164..b0b1865dc8d3 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -387,15 +387,13 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
      * As the current version supports only one source, the ack offset is
      * just sizeof(uint64_t).
      */
-    *read_ack_register_addr = ghes_addr +
-			      ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
+    *read_ack_register_addr = ghes_addr + sizeof(uint64_t);
 }
 
 void ghes_record_cper_errors(const void *cper, size_t len,
                              uint16_t source_id, Error **errp)
 {
     uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;
-    uint64_t start_addr;
     AcpiGedState *acpi_ged_state;
     AcpiGhesState *ags;
 
@@ -412,11 +410,9 @@ void ghes_record_cper_errors(const void *cper, size_t len,
     }
     ags = &acpi_ged_state->ghes_state;
 
-    start_addr = le64_to_cpu(ags->hw_error_le);
-
-    start_addr += source_id * sizeof(uint64_t);
-
-    get_hw_error_offsets(start_addr, &cper_addr, &read_ack_register_addr);
+    assert(ACPI_GHES_ERROR_SOURCE_COUNT == 1);
+    get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
+                         &cper_addr, &read_ack_register_addr);
 
     cper_addr = le64_to_cpu(cper_addr);
     if (!cper_addr) {
-- 
2.47.0


