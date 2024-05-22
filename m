Return-Path: <linux-kernel+bounces-185680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA888CB8D7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 04:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB6B1C229A0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 02:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D958328FD;
	Wed, 22 May 2024 02:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="iDH0SNoN"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFD717565
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 02:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716343659; cv=none; b=ZqUldWUTMMWt/0j6gDHNUmY4mc2Um69g6Y7VLmvgmmLqCbNfdTH9vz2bOitHo0r6V4en5HbikltiAd3x1QGgfzqfzrwFk7KU2dGkq1k4+ffwxfzaZlbRcb4JTJD40gx0VIlW7mfZPpa403mA/9J8X+LrxF7BSde8YYjma2R/4C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716343659; c=relaxed/simple;
	bh=sHmcpqxgBdpr6NKvbSB1hEzLwZl/AQ4FUeAazfsrH14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmB4+2tvA03uIxyOXhR4KaTL6fKbT0HmASorXfFxNtSZmT4VUbVpFN2Hm336MAiQlReR/qTKGhPjfIglTKfQ3XnkE76Xv6c+8kxSU9dcwlXSYGhFMIaj1amDbW9Y2VJzCVgQVlpPxyFgLR/GdyFF8nfZ5OfBcphAvrk95nNAQ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=iDH0SNoN; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1716343657;
	bh=sHmcpqxgBdpr6NKvbSB1hEzLwZl/AQ4FUeAazfsrH14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iDH0SNoN6XplhIjzAYStnxex25bjIWl8CuiMdorV/MytsatSJWmE71o5TvqzS0Cuq
	 VgzMqVM5sx6iFYeSTP/7k59gRUWQXPFSvpXjYYtiZVHRM23aJeAZU5Hennpg0KVpyU
	 FbXvRHiMltCsGqmAy06UTrYb7nlEnR29VBe8mes0=
Received: from stargazer.. (unknown [IPv6:240e:358:11a2:a00:dc73:854d:832e:3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id D088C1A3FBD;
	Tue, 21 May 2024 22:07:31 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Xi Ruoyao <xry111@xry111.site>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [PATCH v10 2/2] x86/mm: Don't disable PCID if the kernel is running on a hypervisor
Date: Wed, 22 May 2024 10:06:25 +0800
Message-ID: <20240522020625.69418-2-xry111@xry111.site>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522020625.69418-1-xry111@xry111.site>
References: <20240522020625.69418-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Intel erratum for "incomplete Global INVLPG flushes" says:

    This erratum does not apply in VMX non-root operation. It applies
    only when PCIDs are enabled and either in VMX root operation or
    outside VMX operation.

So if the kernel is running in a hypervisor, we are in VMX non-root
operation and we should be safe to use PCID.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michael Kelley <mhklinux@outlook.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Link: https://lore.kernel.org/all/168436059559.404.13934972543631851306.tip-bot2@tip-bot2/
Link: https://cdrdv2.intel.com/v1/dl/getContent/740518 # RPL042, rev. 13
Link: https://cdrdv2.intel.com/v1/dl/getContent/682436 # ADL063, rev. 24
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/x86/mm/init.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index e960196e8058..1efd55835fc5 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -279,7 +279,7 @@ static const struct x86_cpu_id invlpg_miss_ids[] = {
 
 static void setup_pcid(void)
 {
-	const struct x86_cpu_id *invlpg_miss_match;
+	const struct x86_cpu_id *invlpg_miss_match = NULL;
 
 	if (!IS_ENABLED(CONFIG_X86_64))
 		return;
@@ -287,7 +287,9 @@ static void setup_pcid(void)
 	if (!boot_cpu_has(X86_FEATURE_PCID))
 		return;
 
-	invlpg_miss_match = x86_match_cpu(invlpg_miss_ids);
+	/* Only bare-metal is affected.  PCIDs in guests are OK.  */
+	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		invlpg_miss_match = x86_match_cpu(invlpg_miss_ids);
 
 	if (invlpg_miss_match &&
 	    boot_cpu_data.microcode < invlpg_miss_match->driver_data) {
-- 
2.45.1


