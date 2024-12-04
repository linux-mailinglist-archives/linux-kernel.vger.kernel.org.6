Return-Path: <linux-kernel+bounces-430678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 933379E3450
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ECA71682BA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 07:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2962B1991CB;
	Wed,  4 Dec 2024 07:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxXWcFIu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA9618FC72
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298153; cv=none; b=FaYLw9gVwIkUmHV+Cryz/cxUQ3kfyvfGC/MtRy2Y+T+IVEYlO78rSh/J2EH9kA6bG7YsgvEVgIStBjo/O/MGoK/CY4sV/4/qeFm5EN/iuDe8Q03OCG09cW1PofUMA5UacJ8KQAf4oUdmqPdGCd8bbtanyv3w3C5Kl+FH8tGpCv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298153; c=relaxed/simple;
	bh=0CyS+5uMH4bliw7AWJd+kEIWAWXpqKGP1aXYbGP2T70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/HpIFEvd948NjN2Ux5C+Ny43RGrhZCp5wEMhnT/3He6GQzF9hy4qosVwiaZpjYYjVJ6Fh2GQBmfIVJ1qqGlNpXvmk6NyC4vbU7hUfZ/z8C3ZQ0GwRlO8N0ESV3jHDdZKK3O+8GA0S22/JjOWvAHMBMIDMx1siFIxCstGsDDNnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxXWcFIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F2AC4AF0E;
	Wed,  4 Dec 2024 07:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733298153;
	bh=0CyS+5uMH4bliw7AWJd+kEIWAWXpqKGP1aXYbGP2T70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cxXWcFIuBV+Uv+qb3yeN7e37cAaw4wxRTpUKKpdloMjvgg+jEPA0sVEQ6sFDuWcjE
	 VxiH/ZVVsK0Logs1wRdr/QYITIwsWgY9Xb6nFjVk41NvjpncKmKM8gdVz/0oEKFhkO
	 9STGetQjuSOlM6jwHeB+IoCNs7V+MX41ZD4H0BUpzKySAmSAl6J3b8Gy8CkJPP2yC1
	 D/eBJ1GRdNeQqPVlfXyE44syuWDDgmjmxxrE4SLnZWB5KbtAzrSp7haX7ldWRNby2F
	 BgWUTmyDz3NWnh6OcnDD0JNElqAwDDQcvUXw/UWVtA1JrSPWk3UPJTItg15RTj7CxG
	 4gBRku+r/appA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tIk1n-00000004Kjc-1NTs;
	Wed, 04 Dec 2024 08:42:31 +0100
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
Subject: [PATCH v5 15/16] acpi/ghes: Change ghes fill logic to work with only one source
Date: Wed,  4 Dec 2024 08:41:23 +0100
Message-ID: <a633f129131a22e2aad6b1b9543b88867bf9d424.1733297707.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733297707.git.mchehab+huawei@kernel.org>
References: <cover.1733297707.git.mchehab+huawei@kernel.org>
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
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/ghes.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index a4453ee357bc..5efa50413af3 100644
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
 
     if (!cper_addr) {
         error_setg(errp, "can not find Generic Error Status Block");
-- 
2.47.1


