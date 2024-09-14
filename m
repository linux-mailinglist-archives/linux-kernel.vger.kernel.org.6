Return-Path: <linux-kernel+bounces-329163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA496978E3C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 08:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D016B24360
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 06:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D591474B2;
	Sat, 14 Sep 2024 06:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euhGzDg+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA426A8D2
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 06:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726294434; cv=none; b=CFjTYu76334Tq1iXN2P2CiPrrXJliKc+hwnmtfYI83Pm3anC3STVdnEo17jJuFChlMyetLo4WXFA1WGtV3LDuwAYnhYMgEy0adFM0abf4MCPm8yNRwh9NS7faou59F2Jxf7RKd7xjjVOqChCtv2ivz09jRmaeAyxLQpIfsjwB9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726294434; c=relaxed/simple;
	bh=398lt+dM/AeQyr12FaU/wO3g2lZqBP80FkHI8K0fguk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uERFNaDgzLncjngzuSSyPLa+dOAUnU3tY4slEwiz5AbC4mG7nC0cfMb+EO5Z7q9N8jeMGQ4+xYaWFdpM3J9s2/VOatQrrUyGFCDsyxUuk+aBKGzYGKfOpfmL0nfYfFcNNYW0MTvOG0LXgF+JLQAIRWZPL6xPrc3IqeUjmSI6SnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euhGzDg+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B56C4CED3;
	Sat, 14 Sep 2024 06:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726294434;
	bh=398lt+dM/AeQyr12FaU/wO3g2lZqBP80FkHI8K0fguk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=euhGzDg+oAezRRnu7M6VV0DJocPTu6XQlbNzzVpBl1Hm3D9PlLJgQutabQYei93Dc
	 RCIjmzSWTM/naz7e1HK/Hd4RAepts2tSb43dFgj+EyQcAzLZf9xYayu+TBaD+p/UIX
	 XR1IIUgzoJz6vGhX1ckSxW/J7b1XRrGyPtHdOFclsdPXFXrQ76bNqTX++Qq9gT4FBo
	 leKs9edBdoQZULis5Tiu03ol6JWdSoWkAnm80VfmV3lKWBGZw8EHvLU6Eaw/3AJv8r
	 raK6h+E5yEc6aWhBRJxwUKPc0uBViwL5JFgRTBR2ZEsIhQwt2JwRTXo2mH70VRthVj
	 0qRDngYKyl/0g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1spM2a-00000003V5n-0O8Q;
	Sat, 14 Sep 2024 08:13:52 +0200
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
Subject: [PATCH v10 06/21] acpi/ghes: Remove a duplicated out of bounds check
Date: Sat, 14 Sep 2024 08:13:27 +0200
Message-ID: <25bdbb971c3f7ccbc0e1964605dfe954193b8fcb.1726293808.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726293808.git.mchehab+huawei@kernel.org>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
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
---
 hw/acpi/ghes.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 939e89723a2f..36fe5f68782f 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -420,9 +420,7 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
         return -1;
     }
 
-    if (source_id < ACPI_GHES_ERROR_SOURCE_COUNT) {
-        start_addr += source_id * sizeof(uint64_t);
-    }
+    start_addr += source_id * sizeof(uint64_t);
 
     cpu_physical_memory_read(start_addr, &error_block_addr,
                                 sizeof(error_block_addr));
-- 
2.46.0


