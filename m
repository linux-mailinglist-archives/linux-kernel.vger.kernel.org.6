Return-Path: <linux-kernel+bounces-533974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 202AFA460FE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22BDF179F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C310315E5AE;
	Wed, 26 Feb 2025 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Qqoukv+D"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBCD101FF
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576772; cv=none; b=s8LeGXozww1JJZFBZ45I3aOf5hQPpPAU7ehQdJum0e1BTmaP3pD3tFxC47CzWltxRXgfC7IybZNNLpuSSwq3wGsvb9C48hpkzC7Tm1Wz4xkEzZ/1GOQ+heLJl8fPsZ001tCEczS7mLuhTWcKHfaSUN+VAdJXNuIr9byUriB/EYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576772; c=relaxed/simple;
	bh=zYf2TGn1bduJfQJOUoeRinZjy8HAppg9lifk3sexQ84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N2RDZXqVPQG2frTCbgJoTWc2aRUXKAEADP/rquoETsXwXHXElUigEqSNLfLRvSKbgfQTHW356f5OsdZMkmNIXl3AeB8Ix9BtuZ9X27Oggyip5k6NkPPTj+fN6BHnSQSGfu0qh2i4noRm3tELq5/5lB1WdnJiWm3eR4UdYeNxQcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Qqoukv+D; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=owRcVAIfAdo/eBUmry6xKaLhXuxlLmRZar2zptWsOeY=; t=1740576770; x=1741786370; 
	b=Qqoukv+DiZrPAKRksi6yhlQ7/DirGpWFMCmJ9icuN8H5OSyNJExGBiusmsBcDR76u+8fnvk+9eT
	62ofBQx3PY5W6VCali9YbF9ynhDDNHTSr2veMVAU72OvxIxKS8tUpXA8un92+k74qYZWh2+FGIAYV
	dAy8pD31q1H6reEsnI+R0dMeJkTX/Oj3Dqpsm/a55vVEXb4T8JOLNuok3ApfwUBo/Ap5W9lgr1exy
	APAR8WG2fKoz5Zqz1q+VKfq32o6MQUoAynKX0A4RGuTRxhyfg+iRDJalK5lWF2etLs8lOwmB1h+Oe
	kDh8CO9NVmIChNDt6q1/coLkI76ywaQaEdRQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tnHWp-0000000BVAQ-1rwO;
	Wed, 26 Feb 2025 14:32:48 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	mingo@kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2] x86: avoid copying dynamic FP state from init_task
Date: Wed, 26 Feb 2025 14:31:36 +0100
Message-ID: <20250226133136.816901-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The init_task instance of struct task_struct is statically allocated and
may not contain the full FP state for userspace. As such, limit the copy
to the valid area of both init_task and dst and ensure all memory is
initialized.

Note that the FP state is only needed for userspace, and as such it is
entirely reasonable for init_task to not contain parts of it.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Fixes: 5aaeb5c01c5b ("x86/fpu, sched: Introduce CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT and use it on x86")

----

v2:
- Fix code if arch_task_struct_size < sizeof(init_task) by using
  memcpy_and_pad.
---
 arch/x86/kernel/process.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 6da6769d7254..a8f65c17df10 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -93,7 +93,13 @@ EXPORT_PER_CPU_SYMBOL_GPL(__tss_limit_invalid);
  */
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 {
-	memcpy(dst, src, arch_task_struct_size);
+	/* init_task is not dynamically sized (incomplete FPU state) */
+	if (unlikely(src == &init_task))
+		memcpy_and_pad(dst, arch_task_struct_size,
+			       src, sizeof(init_task), 0);
+	else
+		memcpy(dst, src, arch_task_struct_size);
+
 #ifdef CONFIG_VM86
 	dst->thread.vm86 = NULL;
 #endif
-- 
2.48.1


