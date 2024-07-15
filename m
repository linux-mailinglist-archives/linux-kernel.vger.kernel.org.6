Return-Path: <linux-kernel+bounces-252866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D821793191C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58595B21BF8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED647446AF;
	Mon, 15 Jul 2024 17:19:21 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FDD46522
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721063961; cv=none; b=k4i2km3fqRdb3bZFtWVLIBaJUDmedc6n1uNYu1PlYriflNGBSz4fmRl3G0zQYQjloE0ijy6S4FRHY+pN55ZJ+LmPRSOw0qmBnaKDGhRlY60bLQFJE360cxzOQbfAQz5nQulLIFwgatAyBE8avc5haewQV5kWBvfcSfic9H8xXRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721063961; c=relaxed/simple;
	bh=md+7J16UGb6TuombcMGoH0SvjIWScME3Kk8wOFtdJ6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=CkHBADQXlBNIB/aHzjnaF8PatQjWKj2rK0OfNG5S8ctVlxp7sCtaCAbRHWsSY/gZ1mDNrW4ETqqrNAPYy//uxQAD9GfkwOxpjKE9nx9XT/HukNNfTNl1nmIGJK9AxtZcv44FH5FfAk4p91urOvndUVWdA8msMxRGtaUUIZy+1EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1sTPLl-0000000039C-2PCm;
	Mon, 15 Jul 2024 13:18:57 -0400
Date: Mon, 15 Jul 2024 13:18:53 -0400
From: Rik van Riel <riel@surriel.com>
To: Juergen Gross <jgross@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, x86@kernel.org, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, kernel-team@meta.com
Subject: [PATCH] x86,spinlock: make disabling virt_spin_lock_key contingent
 on CONFIG_PARAVIRT
Message-ID: <20240715131853.313c3bae@imladris.surriel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@surriel.com

The existence of virt_spin_lock_key is contingent only on CONFIG_PARAVIRT, not 
on CONFIG_PARAVIRT_SPINLOCKS.

As a result, a kernel with CONFIG_PARAVIRT enabled, but CONFIG_PARAVIRT_SPINLOCKS
disabled will end up disabling queued spinlocks when running on bare metal.

Making the disabling of virt_spin_lock_key contingent on CONFIG_PARAVIRT, which 
controls whether the key exists, results in queued spinlocks being enabled on
bare metal again.

Signed-off-by: Rik van Riel <riel@surriel.com>
Cc: stable@vger.kernel.org
Fixes: ce0a1b608bfc ("x86/paravirt: Silence unused native_pv_lock_init() function warning")
---
 arch/x86/kernel/paravirt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 5358d43886ad..dd542a9c6667 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -55,7 +55,7 @@ DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
 
 void __init native_pv_lock_init(void)
 {
-	if (IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) &&
+	if (IS_ENABLED(CONFIG_PARAVIRT) &&
 	    !boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		static_branch_disable(&virt_spin_lock_key);
 }
-- 
2.45.2


