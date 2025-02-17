Return-Path: <linux-kernel+bounces-517937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF00A387D1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B0E3B4BE9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E36622577C;
	Mon, 17 Feb 2025 15:39:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5772253EA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806775; cv=none; b=NZ5aCSOZPvjAJQW0QFS9ZRXYQ5tmsU5tU1HuwLMia26kkTFIt68nOwEaE16c/OzBPphEIpT+V8sacmMhvVCfdWnXDboiWyIxZpRBrjOPXRx9p2PAhDKWGsTjxu/w4LTv9V2C16VLBMXEJcyXfQ6NWkflTzKuLdc9YTP5nTp6Ly8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806775; c=relaxed/simple;
	bh=kZ4/y9DUzlAVsB+B8wZcgeoxtKetDWyU/DxHjgkskJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=bvu5pUioPs3GeAR55Z5qbRoOGTncb+TrqWzXVbL4qjE7jfKWEeS28IReVQ1Pw5wc8erA2wL+H2d7gr4Hp50bnjdlO1ZxnQfIeudmTfk3YAOuern3nG7ZK9kzR4VwHrS34SFz3lAwss9iyGZqcaERFCESkvaGV+zUgfIdvT76V/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E6FA152B;
	Mon, 17 Feb 2025 07:39:52 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39E633F6A8;
	Mon, 17 Feb 2025 07:39:32 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 17 Feb 2025 15:38:45 +0000
Subject: [PATCH v3 04/19] firmware: arm_ffa: Fix big-endian support in
 __ffa_partition_info_get()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-ffa_updates-v3-4-bd1d9de615e7@arm.com>
References: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
In-Reply-To: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1786; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=kZ4/y9DUzlAVsB+B8wZcgeoxtKetDWyU/DxHjgkskJo=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBns1guejv910xM8qLwgUybkj8V3zFB0dE+XXyEL
 ysdpk5aHfWJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ7NYLgAKCRAAQbq8MX7i
 mB9jD/9pahw2bI9ZGgs+Lk8rfGttLPSDcZKs/caLMhRMeHBrLa98jGOCsq7AAOmndqBvzmxi475
 GqdtBeW1KuVIuwXdS4ICus1lAcDpyhZpYK/L2MEHSn+CR0fX7Eutks2uLS+exiaKBXVPb+lcKG6
 zOM1YJAc1T3UZ9PqECQWbIZlVmV0BxsIEmyvyyEO9yPULIv4/0aUiHQynQls2fPFpYKeD0PMlTY
 IAuSl8lpSvwfp7rXnBJ5gNfbPGMFoIYlsZ3NAJpyeKQf6mN2BOSCBtZSe8uLkOB5M+gxUY7HvmG
 OtiTcksj1+tv99gLS4x12FRFX2k/9SF6UbH1Qlf8t/PAaEaqNsFuVPT347VJjOk3ewrGU6WFj59
 dABMEXM6g1Rvv5eKFXsD1qSJUiLGwU9WikpXYSXfFydH0keAh+gje6kEg2mGrrlhmCJ4HPJ0eEc
 kb11fIAYwSFlaa0ARoDi+f53GK5kpmz+WXeh8/NYJTOM7GL03QocyIBeKEwWGb2eXRkuQeHp6VJ
 bN0VQ5yMyAHqO5MhMl5MFO1RAp9S1kVlA1yb9Ayjl3+57gdiTX676BT0vLbNuR7XfU0lKAtm/Xs
 Ao9zj7VMe/lZFd520GOWh7FTmDVnCsG0vlp9YtvIgMQmx+2qht/76Sf8a93x7D5pujag+NXj+C1
 J4OC1ciJuH9wqJQ==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

Currently the FF-A driver doesn't support big-endian correctly. It is
hard to regularly test the setup due to lack of test infrastructure and
tools.

In order to support full stack, we need to take small steps in getting
the support for big-endian kernel added slowly. This change fixes the
support in __ffa_partition_info_get() so that the response from the
firmware are converted correctly as required. With this change, we can
enumerate all the FF-A devices correctly in the big-endian kernel.

Tested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 037e0d684994fd30971f40bf139367d1e45c1bf0..bc6ffd25ad2e2fea0fe3610cf896718dbed8f0ad 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -276,9 +276,21 @@ __ffa_partition_info_get(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
 	}
 
 	if (buffer && count <= num_partitions)
-		for (idx = 0; idx < count; idx++)
-			memcpy(buffer + idx, drv_info->rx_buffer + idx * sz,
-			       buf_sz);
+		for (idx = 0; idx < count; idx++) {
+			struct ffa_partition_info_le {
+				__le16 id;
+				__le16 exec_ctxt;
+				__le32 properties;
+				uuid_t uuid;
+			} *rx_buf = drv_info->rx_buffer + idx * sz;
+			struct ffa_partition_info *buf = buffer + idx;
+
+			buf->id = le16_to_cpu(rx_buf->id);
+			buf->exec_ctxt = le16_to_cpu(rx_buf->exec_ctxt);
+			buf->properties = le32_to_cpu(rx_buf->properties);
+			if (buf_sz > 8)
+				import_uuid(&buf->uuid, (u8 *)&rx_buf->uuid);
+		}
 
 	ffa_rx_release();
 

-- 
2.34.1


