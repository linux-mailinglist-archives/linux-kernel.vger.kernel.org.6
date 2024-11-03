Return-Path: <linux-kernel+bounces-393779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8729BA520
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 11:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7D01F21A0A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 10:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC0216DEAC;
	Sun,  3 Nov 2024 10:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="feG3ijQ6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1nULEa4q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70B88614E
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 10:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730629869; cv=none; b=cff2uYOeIxopML89Q02q4kU+9i5M3sSGcbsN+KuJJTGPQ44z86ovIPiXzRiLl1wnb1Anbi/upTZUCzT1wOEcFv2Ninc6LpuVarJKRtBrx+aZMZMxQrdLB0fHHAfI/+r+1+d85KaxlRBe7AZlljHrPmU7WsHgn2/XU4pbo82c7s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730629869; c=relaxed/simple;
	bh=EPp6jO0ZBMjk3jSYH512s6CpBQd/c0LL4Z3Lql1+yBE=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=NbpB+eszZ5l2ZRG1JLEPbKPVZlXKBjl2iofuNiUqP7veD4gT4VjW4168nOnfIBUEokTF7LxKli2r/8y40KLZFcsZOXP2g9s9wWZ5qhA4QR0zOaWlOO6zdUo2dGp0BNpgWzUgtQs00qHrLhJ4r1AcZBAsqHQeSLm9MjdM2QK+Q4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=feG3ijQ6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1nULEa4q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730629866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=LBx+y2Pk4K9JDp08PNyloTJeVFmM+pU8UFMMZ7Cmjn4=;
	b=feG3ijQ6jbQM1d3XKqfNmlLlPzJ2sY0RNx0VmiG6evSmLrkIons6ENQcIbunZwbjb30u7X
	cfyV9j+gZP1Txrg2z8VeyPGw8bho8/dtmn4q++MZOnxXnGs09TZi8Dl/JiwdAB/joC319i
	Ius6mxN4AA7tpxNNbLZ15pXWhWJKryT1cC7/7Qr/YBmbxBgYH+dW5rVAjzZHMR3BT3JVTI
	7DvEztoGYDOT5om1H3atxLWtGJKzpOWQFCrflrr/Pj2rVqctHaCyZeVFjfBs+ubBIsHKFF
	7Crm95bI0pvyg6IKt37yxvWzd+U6tGUQokgz0cQs438atEZHqeyrNQKfAk7vkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730629866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=LBx+y2Pk4K9JDp08PNyloTJeVFmM+pU8UFMMZ7Cmjn4=;
	b=1nULEa4qe95+f5h9bUjT3BpvzMUdWV4GPnFxRN+RkCALg4iVzHJAb4FzVM0xSkKiENQKAL
	1hyquWkZApkzZwBg==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v6.12-rc6
References: <173062982864.1467946.2540622433845043721.tglx@xen13>
Message-ID: <173062983493.1467946.4360836633216822317.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun,  3 Nov 2024 11:31:05 +0100 (CET)

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-=
11-03

up to:  fce9642c765a: x86/amd_nb: Fix compile-testing without CONFIG_AMD_NB


A trivial compile test fix for x86

  When CONFIG_AMD_NB is not set a COMPILE_TEST of an AMD specific driver
  fails due to a missing inline stub. Add the stub to cure it.

Thanks,

	tglx

------------------>
Arnd Bergmann (1):
      x86/amd_nb: Fix compile-testing without CONFIG_AMD_NB


 arch/x86/include/asm/amd_nb.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 6f3b6aef47ba..d0caac26533f 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -116,7 +116,10 @@ static inline bool amd_gart_present(void)
=20
 #define amd_nb_num(x)		0
 #define amd_nb_has_feature(x)	false
-#define node_to_amd_nb(x)	NULL
+static inline struct amd_northbridge *node_to_amd_nb(int node)
+{
+	return NULL;
+}
 #define amd_gart_present(x)	false
=20
 #endif


