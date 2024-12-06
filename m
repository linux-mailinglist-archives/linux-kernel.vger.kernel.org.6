Return-Path: <linux-kernel+bounces-435387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 426809E76F3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0313528788A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A44219E99;
	Fri,  6 Dec 2024 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLrv2fx6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F423A1FFC7C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505688; cv=none; b=ZK+ikIRAnYyjEQtn9kVNvqxtaeQLYHOg1WuAAi6KQ7kQ5bRjWvAkRGAB84fu4iOJF19udCTlBiNthS4Ws9HG/no5FLRi25AlpmswejTPELT3tv1GR5IzjtAywzXxtHMNz5yIW/nMP/gp1IyCqAlhYFtvM6/3LDRmt7mnrN2XX6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505688; c=relaxed/simple;
	bh=mtr3SAhcJul8SH7gyq7dWJqCajR+YSKyCDlfSYBqOeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LB8NalpwW7wmZH5zF/FRa1lCSxkk+a8Nl+Zc/XRqYvC/1sjlIynevvZcGnNoqT4j5uwq2dkSa01hkAarIE8fL4kqOzHgwk0s6Kno2tHxaFS73EVxSHollrRZv08JAj6nlhK9MHWLr+t9WWbUf5xNzsJSj1eRqU9fq+rhg89N9/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLrv2fx6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770D6C4CEDF;
	Fri,  6 Dec 2024 17:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505687;
	bh=mtr3SAhcJul8SH7gyq7dWJqCajR+YSKyCDlfSYBqOeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tLrv2fx6MC5CiMFBLd/p0iq9ZUt5Q9H5mAQYkddE5INb8kfN35WucDfDlKaid3CMw
	 3h32xzaO389ClJtr/75/BvnBLEBC8nP/7Tp5TaSEIeGNGRLY240wU9Oqof3uqnZsaW
	 Q0fRKPX+rj0tdnrQ3AIlNl1hNmD4r2MS0xpUJYKeRQXMkJzl2H6T6T6PaUT7jdcNhD
	 gCNph/Ph90RRh1FpOXykvd2CmSfO0DhetZXuXIR2Y5L3tET7/8RPiESK80vY6nhbPX
	 MDBkAfkyHMnzkZUB6lWv2vAafVD09cPmO1fcxNjGJfvdFmFys8jLgR8v2M9yHDRhL3
	 Esgu1ZIMAjbCg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tJc17-00000005RJu-2bEV;
	Fri, 06 Dec 2024 18:21:25 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 06/31] acpi/ghes: Remove a duplicated out of bounds check
Date: Fri,  6 Dec 2024 18:12:28 +0100
Message-ID: <9167a48674ab418596a87fda9d89db78aefec312.1733504943.git.mchehab+huawei@kernel.org>
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


