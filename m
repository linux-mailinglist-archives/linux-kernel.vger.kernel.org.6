Return-Path: <linux-kernel+bounces-217193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE95A90ACBD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBDBB1C20CBB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3596194AE1;
	Mon, 17 Jun 2024 11:18:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9EC194AD5
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623133; cv=none; b=rzZICV3TnaewxHymU2jx9YUHDVvNaxpKmaD46sftGru29TcjV64OkwYoZwK6iFctSRqBbutFKvKdSQtn9yz3e72FzndA3BNu5bpVvKnm/IBF4Gq8XftrmPax0yuwy8xo+9s1+Ge7nQFcD4V1FrzFo7kSrwJontqtiEGaolEvdbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623133; c=relaxed/simple;
	bh=wVpzW1Z+tykW9msrAWC2ldL34MP3GDc8CX+ga2Hi1pY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tcQUPdNr6Nwdzcd/krruPM1SHBVXfKfwqwdMN33v/ff1CyHeCU32RM8J2EhDJvwbGV7JnVwllntkhlXXrK6SiZYQVWokmvpWWEe6XZ6ZcKtx/ZhfAp3KhNON2/9bE8fdUyJGcyU1iOrbYxH3wxnLtfwrPDoPiqDvD0T2bNry8T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81421FEC;
	Mon, 17 Jun 2024 04:19:15 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C75013F6A8;
	Mon, 17 Jun 2024 04:18:49 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: alexandru.elisei@arm.com,
	catalin.marinas@arm.com,
	linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	tglx@linutronix.de,
	will@kernel.org
Subject: [PATCH v2 1/5] wordpart.h: Add REPEAT_BYTE_U32()
Date: Mon, 17 Jun 2024 12:18:37 +0100
Message-Id: <20240617111841.2529370-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240617111841.2529370-1-mark.rutland@arm.com>
References: <20240617111841.2529370-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some cases it's necessary to replicate a byte across a u32 value, for
which REPEAT_BYTE() would be helpful. Currently this requires explicit
masking of the result to avoid sparse warnings, as e.g.

    (u32)REPEAT_BYTE(0xa0))

... will result in a warning:

    cast truncates bits from constant value (a0a0a0a0a0a0a0a0 becomes a0a0a0a0)

Add a new REPEAT_BYTE_U32() which does the necessary masking internally,
so that we don't need to duplicate this for every usage.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
---
 include/linux/wordpart.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/wordpart.h b/include/linux/wordpart.h
index 4ca1ba66d2f07..5a7b97bb7c956 100644
--- a/include/linux/wordpart.h
+++ b/include/linux/wordpart.h
@@ -39,6 +39,14 @@
  */
 #define REPEAT_BYTE(x)	((~0ul / 0xff) * (x))
 
+/**
+ * REPEAT_BYTE_U32 - repeat the value @x multiple times as a u32 value
+ * @x: value to repeat
+ *
+ * NOTE: @x is not checked for > 0xff; larger values produce odd results.
+ */
+#define REPEAT_BYTE_U32(x)	lower_32_bits(REPEAT_BYTE(x))
+
 /* Set bits in the first 'n' bytes when loaded from memory */
 #ifdef __LITTLE_ENDIAN
 #  define aligned_byte_mask(n) ((1UL << 8*(n))-1)
-- 
2.30.2


