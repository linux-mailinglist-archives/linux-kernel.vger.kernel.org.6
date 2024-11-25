Return-Path: <linux-kernel+bounces-420765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F19B59D82E8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91F2816411E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FB819068E;
	Mon, 25 Nov 2024 09:52:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235AE1922DC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528379; cv=none; b=QHdoR93fAGQHjzDfesCxUL4nUYON4YRcJfA9MQlX1mh6ZtT1slmiypA9WQT25JY5cgErfcDVzrY6+TSjJuhER2HZdOHnV0hD4I4G8bnp1aVnXv6Pnc70o7d+2BkIizHx4aoe1rxQwjFKDHpk/K41FQKekzjf2qqwxgojgCkxC28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528379; c=relaxed/simple;
	bh=ubZ04BAzavQP2t/iuBNv8I/bCNuPwsYNnJT0ixXEHFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jWekjZhexZGBzz7q4LiA2ykelgX+j20RZbX93d117V+nTXLqlq55JEtnNZKvidZSjJayc0Xh0KbnJZWzxAhwRIh7gaNX6hPiuzXnALbInL1YJq6Bv9JqJ7e8HcevejMvE8mceCIUEEW8mZRM/OVeMRgr4kq33maxAd7KREEF7a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A93C01692;
	Mon, 25 Nov 2024 01:53:27 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 95C7F3F5A1;
	Mon, 25 Nov 2024 01:52:56 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sudeep.holla@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	nd@arm.com,
	Levi Yun <yeoreum.yun@arm.com>
Subject: [PATCH 2/3] arm_ffa.h: add properties bit related direct msg version 2
Date: Mon, 25 Nov 2024 09:52:50 +0000
Message-Id: <20241125095251.366866-3-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125095251.366866-1-yeoreum.yun@arm.com>
References: <20241125095251.366866-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Levi Yun <yeoreum.yun@arm.com>

According to FF-A specificaiton [0], There are flags to be used to
check whether partition supports send/receive direct msg version 2.

Add related flags.

Link: https://developer.arm.com/documentation/den0077/latest [0]
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 include/linux/arm_ffa.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 3fb9c7a3453b..b697675c76ba 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -238,6 +238,10 @@ struct ffa_partition_info {
 #define FFA_PARTITION_NOTIFICATION_RECV	BIT(3)
 /* partition runs in the AArch64 execution state. */
 #define FFA_PARTITION_AARCH64_EXEC	BIT(8)
+/* partition supports receipt of direct requests version 2 */
+#define FFA_PARTITION_DIRECT_RECV_V2	BIT(9)
+/* partition can send direct requests. */
+#define FFA_PARTITION_DIRECT_SEND_V2	BIT(10)
 	u32 properties;
 	u32 uuid[4];
 };
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


