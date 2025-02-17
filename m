Return-Path: <linux-kernel+bounces-517938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72471A387D2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC714173DCF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C61225A29;
	Mon, 17 Feb 2025 15:39:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47AA22540A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806776; cv=none; b=JkAeo0MMY4LhgYrnEhl9hUXLzAFwq7FAmEBeAdAUdw0icQ9DeHgjfji8tpyIOWWgSZQEA9b3vnRK/Bq9XvvDnZO4PKhYhbTiSdKWFknpXl5nOvgZmPYQDAkkkcoShDzyTdfjAFYNlIE+BNJ4BHUCnd93mXcGk6BFXKGmh8ItRHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806776; c=relaxed/simple;
	bh=ZiI+o4/xD0+sVTO80TuOTg2mkZUoOiDa0Hm9f3l0JUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=LxT5pWjbQoONhLYDlOsp1F1F97uNP86EyrT4/VcTvBk8tivqZE5Bf/Hofownr6HykRm4D12icW45zpaF1m/NToyj74Nsbft5tNCMu1BYUWmSP+URY0buEPBgv82bxnjB9zxw7rvH8HlEa4i/NXygsE9xfrbMYm5mc7KiZO91XtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 282881692;
	Mon, 17 Feb 2025 07:39:53 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 417D83F6A8;
	Mon, 17 Feb 2025 07:39:33 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 17 Feb 2025 15:38:46 +0000
Subject: [PATCH v3 05/19] firmware: arm_ffa: Fix big-endian support in
 __ffa_partition_info_regs_get()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-ffa_updates-v3-5-bd1d9de615e7@arm.com>
References: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
In-Reply-To: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3021; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=ZiI+o4/xD0+sVTO80TuOTg2mkZUoOiDa0Hm9f3l0JUE=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBns1guew0YRkg8z32s3kG6Fe1sx95jZL5K1KIVT
 gWi0evAxp+JAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ7NYLgAKCRAAQbq8MX7i
 mPDnEACqI8MINPPKKOLiDxwBMxxWvLh8vA/CCDimYHgIW4Y2Qv2QbO5GG88LWxeTrxFp+2PUni5
 DeEGMHWmnLemPp8FxjTBf47KzdHk/4GHhNCWxO/oVYw3cKL/5w5MyR0GGI26Qh+dwiU8TaNDEvL
 pLxRudQcrRof9vNxkCfVaIbGbnja6Ee6HSDxZip4JVKLBRKtKlF9K6E15NFxDb00GiTw6c/CHA6
 TnPuVGffcoVZINhWU7T+BnuEvIliZNmUQt6N26VmgvgSGn7QSLBOU8LlYiJM/Om25D3N2rYEF/g
 4hXDxbUiCnbvy4nowvMg7JCQZSThhRqwUXFMeu2K+MMWnoBTG2jPyj8mXx/7HcBW6Jcs8Luj0d4
 QVH3Jnio1389tb/SEdXKL1g7L/ZfiiMome3GACtDRTDloo4uaZYAwmUv94vZkeC/NUIe8ehdixq
 oqvq9iFCvPbElDMOhmrOo8RGgvWdQTTXvSaT4v0I2doPRKhoBmsUizTQupKOKkeaDytIql4U77U
 SHbxcbnR2relc68vKHSnH+PH+IOmJDDVfulOmPtLG5qURlsIybcvq/ShKiXXdL5ivSlIXiBX0qD
 GjPLiMmTGcWRkZLxTDaWHhTGBQ2BrnMtmsNQJFTpxoGdzCbbzNBQJeJGjOm5lepGsppBHecr8N6
 csc1WG1viaKNb3Q==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

Currently the FF-A driver doesn't support big-endian correctly. It is
hard to regularly test the setup due to lack of test infrastructure and
tools.

In order to support full stack, we need to take small steps in getting
the support for big-endian kernel added slowly. This change fixes the
support in __ffa_partition_info_regs_get() so that the response from the
firmware are converted correctly as required. With this change, we can
enumerate all the FF-A devices correctly in the big-endian kernel if the
FFA_PARTITION_INFO_REGS_GET is supported.

Tested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index bc6ffd25ad2e2fea0fe3610cf896718dbed8f0ad..87e106c728b89f3ce7c11219cf7cad9cc166dda2 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -307,14 +307,24 @@ __ffa_partition_info_get(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
 #define CURRENT_INDEX(x)	((u16)(FIELD_GET(CURRENT_INDEX_MASK, (x))))
 #define UUID_INFO_TAG(x)	((u16)(FIELD_GET(UUID_INFO_TAG_MASK, (x))))
 #define PARTITION_INFO_SZ(x)	((u16)(FIELD_GET(PARTITION_INFO_SZ_MASK, (x))))
+#define PART_INFO_ID_MASK	GENMASK(15, 0)
+#define PART_INFO_EXEC_CXT_MASK	GENMASK(31, 16)
+#define PART_INFO_PROPS_MASK	GENMASK(63, 32)
+#define PART_INFO_ID(x)		((u16)(FIELD_GET(PART_INFO_ID_MASK, (x))))
+#define PART_INFO_EXEC_CXT(x)	((u16)(FIELD_GET(PART_INFO_EXEC_CXT_MASK, (x))))
+#define PART_INFO_PROPERTIES(x)	((u32)(FIELD_GET(PART_INFO_PROPS_MASK, (x))))
 static int
 __ffa_partition_info_get_regs(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
 			      struct ffa_partition_info *buffer, int num_parts)
 {
 	u16 buf_sz, start_idx, cur_idx, count = 0, prev_idx = 0, tag = 0;
+	struct ffa_partition_info *buf = buffer;
 	ffa_value_t partition_info;
 
 	do {
+		__le64 *regs;
+		int idx;
+
 		start_idx = prev_idx ? prev_idx + 1 : 0;
 
 		invoke_ffa_fn((ffa_value_t){
@@ -338,8 +348,25 @@ __ffa_partition_info_get_regs(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
 		if (buf_sz > sizeof(*buffer))
 			buf_sz = sizeof(*buffer);
 
-		memcpy(buffer + prev_idx * buf_sz, &partition_info.a3,
-		       (cur_idx - start_idx + 1) * buf_sz);
+		regs = (void *)&partition_info.a3;
+		for (idx = 0; idx < cur_idx - start_idx + 1; idx++, buf++) {
+			union {
+				uuid_t uuid;
+				u64 regs[2];
+			} uuid_regs = {
+				.regs = {
+					le64_to_cpu(*(regs + 1)),
+					le64_to_cpu(*(regs + 2)),
+					}
+			};
+			u64 val = *(u64 *)regs;
+
+			buf->id = PART_INFO_ID(val);
+			buf->exec_ctxt = PART_INFO_EXEC_CXT(val);
+			buf->properties = PART_INFO_PROPERTIES(val);
+			uuid_copy(&buf->uuid, &uuid_regs.uuid);
+			regs += 3;
+		}
 		prev_idx = cur_idx;
 
 	} while (cur_idx < (count - 1));

-- 
2.34.1


