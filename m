Return-Path: <linux-kernel+bounces-430672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C209E9E3449
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21669B29A26
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 07:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75253194C85;
	Wed,  4 Dec 2024 07:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnKzYgWl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB80518EFCC
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298153; cv=none; b=plteDuICP65ombwJHZYKMOZIV70LDZRLZhEJPLuRdplksS3A8Lxvlgw2z1kfHO7WFPni8vjffV7GgT+hSzxT11rLCffWiXGs+ZsVhhKtALCTXgfMeEwYMntbo4SYFW5GmdXoa1+8kz9b4AZ4qaGxP7gEH1nhn/XBjkwFT3LiY5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298153; c=relaxed/simple;
	bh=mtr3SAhcJul8SH7gyq7dWJqCajR+YSKyCDlfSYBqOeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcDq4L6iUoFG+z2M9HGh3iu0NBCe0OOa9yLPtLE/wA30npnUYHT7/E2Qe+pObqiDH2uVv964XHaEyO0t/NSPvLdbMgGWmG86bOhJLYrOU/PRiKADrRa6Vp2cUKWEcYipDwDuGhaDLrrB0cv1Wmq/WRavYK4SLYDa7V4e4qSTZuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnKzYgWl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA57C4CEE9;
	Wed,  4 Dec 2024 07:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733298153;
	bh=mtr3SAhcJul8SH7gyq7dWJqCajR+YSKyCDlfSYBqOeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nnKzYgWlEY4eCl1TbECjPQe0NywyeGcVa9klsW3z8dEdH4tGq0SU+wN3KN+sQFAKG
	 RqsR5lQRfRvZarKiSAFNVOU/4fh76kkVfg1pr4aT7SDKR130zefC5ToE7P7m7QL6e4
	 oVDnw4mGbjFPc8B3P6k4WYLRKQD9dCKJEq1X8gl9Hnheyq8syWF5BsR/lTP91GPavk
	 RaaA7+R4wezzRiZgzK1NB3e3jj86Ar/RfWn6SCoHaHfLk9/X5sRnvTZGHY99gw3oRP
	 UCXTS41cBm/omSd/VsEUxNImh1Rud8k5V+kWJ+c5Px1+RtWwnF20Py8qpXYhsFgANf
	 wOasEZJpZpBAQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tIk1n-00000004Kj2-0N2r;
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
Subject: [PATCH v5 06/16] acpi/ghes: Remove a duplicated out of bounds check
Date: Wed,  4 Dec 2024 08:41:14 +0100
Message-ID: <3447853c8f174a8f2a1a0e8c029c73c403a85ba0.1733297707.git.mchehab+huawei@kernel.org>
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
2.47.1


