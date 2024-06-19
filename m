Return-Path: <linux-kernel+bounces-220549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C75190E38B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97896B229AA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A018A757EF;
	Wed, 19 Jun 2024 06:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="M81PsjXq"
Received: from mail02.habana.ai (habanamailrelay.habana.ai [213.57.90.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B2C7406C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 06:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.57.90.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718778898; cv=none; b=fkH8G9RLuqHKuCYGdp6mx0fZSWhZnbWBeg3ycWhGaBXSDKIiSTJO/TXfutpm07isPeWKst0cxYpS8XnpnpkAv0Qqf3QAsfW/NLaqnRCLstkt7kEgvLcJTNTpErBpG23xS8BPIA8PsbGUW1n6RUyPvfhvXIonkDaEuo0xkRjvceo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718778898; c=relaxed/simple;
	bh=yVIz9ixUV8yNzzj5u0E3tyrmSA6nt1p/MJB5rrHIEOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l9CrfDAbBSvu4BNW5vSoaFl5cLzObn0HYsK4oGorvBx+sg9X17+0OEWRwuE1rpF3aKyzgGGXqmosDQgIeFja2D0s9lN5zVnQ6GGMKORWC/rt/x+ykg3xu+WON4144Bp8/OyDT8P1ksJrXTZ8yRaA4CZDWBjmqonPMRHZ+HN8Rp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=M81PsjXq; arc=none smtp.client-ip=213.57.90.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1718778894; bh=yVIz9ixUV8yNzzj5u0E3tyrmSA6nt1p/MJB5rrHIEOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M81PsjXqqwh1IM+TailoLyqtoGDjX8+DyTrmFk+LBcnZaCzq6V+kWHB74zH0PRF74
	 vzT54D3A6PjTWohor4uPd6J8ONwhiNBc3jLMSwLA+Zpe5/r6821KHkPuz88HzLxydM
	 Tcts5N1cOamLU6uAO0PNFhypeggiEnlmzFeZYQeBBJTRPHmkJrR39lQyGwcCFfCvxV
	 CCphi4N2Zkst5I3FODjUS0+aiu/DLaj5EnyoO8Z7E2SsN6JkWaiJkCmrZ+QzdjNIzh
	 nN/k4m40eCjWX3zEeHTk2iBN/aNgmt6SMFCd+Lfppejx/pNAR0Td7SQHFtZReKMjak
	 zRIi98WRuUHLA==
Received: from obitton-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by obitton-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 45J6YQB91377354;
	Wed, 19 Jun 2024 09:34:33 +0300
From: Ofir Bitton <obitton@habana.ai>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Didi Freiman <dfreiman@habana.ai>
Subject: [PATCH 9/9] accel/habanalabs: gradual sleep in polling memory macro
Date: Wed, 19 Jun 2024 09:34:25 +0300
Message-Id: <20240619063425.1377327-9-obitton@habana.ai>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619063425.1377327-1-obitton@habana.ai>
References: <20240619063425.1377327-1-obitton@habana.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Didi Freiman <dfreiman@habana.ai>

It’s better to avoid long sleeps right from the beginning of the polling
since the data may be available much sooner than the sleep period.
Because polling host memory is inexpensive, this change gradually
increases the sleep time up to the user-requested period.

Signed-off-by: Didi Freiman <dfreiman@habana.ai>
Reviewed-by: Ofir Bitton <obitton@habana.ai>
---
 drivers/accel/habanalabs/common/habanalabs.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index a06e5a966f45..6f27ce4fa01b 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -2729,11 +2729,16 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
  * updated directly by the device. If false, the host memory being polled will
  * be updated by host CPU. Required so host knows whether or not the memory
  * might need to be byte-swapped before returning value to caller.
+ *
+ * On the first 4 polling iterations the macro goes to sleep for short period of
+ * time that gradually increases and reaches sleep_us on the fifth iteration.
  */
 #define hl_poll_timeout_memory(hdev, addr, val, cond, sleep_us, timeout_us, \
 				mem_written_by_device) \
 ({ \
+	u64 __sleep_step_us; \
 	ktime_t __timeout; \
+	u8 __step = 8; \
 	\
 	__timeout = ktime_add_us(ktime_get(), timeout_us); \
 	might_sleep_if(sleep_us); \
@@ -2751,8 +2756,10 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 				(val) = le32_to_cpu(*(__le32 *) &(val)); \
 			break; \
 		} \
-		if (sleep_us) \
-			usleep_range((sleep_us >> 2) + 1, sleep_us); \
+		__sleep_step_us = sleep_us >> __step; \
+		if (__sleep_step_us) \
+			usleep_range((__sleep_step_us >> 2) + 1, __sleep_step_us); \
+		__step >>= 1; \
 	} \
 	(cond) ? 0 : -ETIMEDOUT; \
 })
-- 
2.34.1


