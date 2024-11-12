Return-Path: <linux-kernel+bounces-405574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 510069C53B5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2AE0B2FDED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DFA214420;
	Tue, 12 Nov 2024 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ro0Bc80Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE332123F4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406510; cv=none; b=HJO8zx5KTDqhdlrPQhTEQUeC1hgoDL58E9sI6tH2+Y1SWLBaZ/dnaGtLEFopijiTUiPVz/La+Xs0I/IVd6t1MaOOCm+jozZSAIYnJwAQhuFKpAmpp0U8hNldPt1AwBP7CT/k8W9MtTgPtGg15CTkTFlDV0YqKNU21yu73MERtEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406510; c=relaxed/simple;
	bh=6YF6O7FV32gcRBG0RLhIa4885AgC80LqdL+tPakkMdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EES66VKUZviF2EkWOlCpN6Qf4I/ykmS0/qRHG20ffDnSzlLK+8CKOSXw6/lBMJdIPoFwWXXPSL1veKmIVs0HAOXDXdJIgDc7aUjACj+Jo9rwkehp8rUQoIW6yZNY4IAyIKTZbNCLGID4/H8nflyoJCQh7HgxgjPw1+9CAGoYpIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ro0Bc80Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15D0C4CEDE;
	Tue, 12 Nov 2024 10:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731406510;
	bh=6YF6O7FV32gcRBG0RLhIa4885AgC80LqdL+tPakkMdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ro0Bc80QnhDFIy3SqCL9P5xv0rSf/dJRGdazWiZFscjLVV+CCF1xn3LWKsvSGW5DZ
	 040HYBBUGwfg48Y0GlZuMgu+LR9EOHHIki6OMcEnNst/RWCI5xre3T6m2r11qEFP5j
	 2uJo11sewfqpX2hcmRkMGwtMvk7sn98uVI2+mOcveRRL8qA9dTfKRoTvnNBrfJ5XMl
	 kj7/2O0Z6KYjmb2jMtcWIq4xuRRKrMAFFf9ravJ3fKOhRb538nUxcocuQ3ROgFYvLb
	 CPA4kuJeE0q75lyT451I0y/5rxJxefur940hO9TdqcZeFmVz6yaw45Hfiup6uPMicy
	 h9He8u83N3TbQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tAnvP-00000000Jct-0UYk;
	Tue, 12 Nov 2024 11:15:07 +0100
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
Subject: [PATCH v3 06/15] acpi/ghes: Remove a duplicated out of bounds check
Date: Tue, 12 Nov 2024 11:14:50 +0100
Message-ID: <fe7628cdb38ff6fcfa3f4a2bcc51d64f481a3eae.1731406254.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731406254.git.mchehab+huawei@kernel.org>
References: <cover.1731406254.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

acpi_ghes_record_errors() has an assert() at the beginning
to ensure that source_id will be lower than
ACPI_GHES_ERROR_SOURCE_COUNT. Remove a duplicated check.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/acpi/ghes.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 29cd7e4d8171..5f67322bf0f2 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -404,9 +404,7 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
         return -1;
     }
 
-    if (source_id < ACPI_GHES_ERROR_SOURCE_COUNT) {
-        start_addr += source_id * sizeof(uint64_t);
-    }
+    start_addr += source_id * sizeof(uint64_t);
 
     cpu_physical_memory_read(start_addr, &error_block_addr,
                              sizeof(error_block_addr));
-- 
2.47.0


