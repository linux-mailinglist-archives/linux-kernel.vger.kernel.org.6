Return-Path: <linux-kernel+bounces-407217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A628E9C6A4D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9F71F2464B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 08:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525D7189BA9;
	Wed, 13 Nov 2024 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="afbiIZed";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3M9HbEZZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6751C12C484
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731485236; cv=none; b=Kktuk0pnglVwTOmaiiI6XLmWo+O3KjFQklISOKLbd9KjikglkNZX9B8E9f96M2sXPq1gyjnGnjTVV1ZUtdSH9QbdDBfQ1S00lmx6CUlBJuCQV94BcCHEeaMpv2st6ppegDy+ppQVwHuoY1/0lwOUCDdz3czuxDpu0Y4cuE2956g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731485236; c=relaxed/simple;
	bh=3++6GpS6eJ69KS1+HG0bM6vN9BkdaF9jmm+cxdj1OjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZeT9VqxNPb+UEjRKsL6GgD08UJFwwJ9cg9rEtB41gKq8QbrYapNXopBW/sxYANKn7iHIe+Y4gSsVK8zSk1+NHOKtlMDRRtd/mcInfLjzFNx9oB8XBu8M3l3vtCfBDLcDcp95uYEIe9aWdFStPogmqKiDo7sKAqz7Tb5jMPFcok4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=afbiIZed; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3M9HbEZZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731485233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8azP5RNKEmRw7ZN4Xa0xxJU6YEoeWjRUA4LawtiKvo4=;
	b=afbiIZedd8fjvcocSc7LR2J8T27HQ+08dyKfVR4mVgKkppqBHVlnVG5+7yG9kHL0VYIvj/
	1Dl+3p5Rg2xRIMiCiIjsaFL5hFgLpoMGo8pAyRL/zFrjw8XX9OfcT2HU/tkRMOdxIK6j3B
	7buNIGrihkkRXCdhLN43lP/4vKdLILhntlYLoIapNtR2wN//YwNh0DQUs/D451DxYflAzg
	924P8FiVXSIrz8fFdzD/yJmDflJhbPoyz5RPDKQhsVE4t2ZC5eFYtHrltck0C7pyv7ksO3
	B9ZtHeBKtxP8V/IHgi8Kf+4GGj7sNCICiFQ/2mJVPy3gjpdzb9gWIGWr6mwGvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731485233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8azP5RNKEmRw7ZN4Xa0xxJU6YEoeWjRUA4LawtiKvo4=;
	b=3M9HbEZZFUv5QG4IVDnNTxhB3+CTXd2Pg0kQxS6sMEES1y0QDnOn785MZmE7M4BSeTcIFu
	RVjVy8ITPufKX+CQ==
Date: Wed, 13 Nov 2024 09:06:58 +0100
Subject: [PATCH] powerpc/vdso: Remove unused clockmode asm offsets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241113-vdso-powerpc-asm-offsets-v1-1-3f7e589f090d@linutronix.de>
X-B4-Tracking: v=1; b=H4sIACFeNGcC/x3MPQqAMAxA4atIZgON/3gVcRBNNYO2NFIF8e4Wx
 2947wHlIKzQZw8EjqLijgTKM5i36VgZZUmGwhQVEZUYF3Xo3cXBzzjpjs5a5VPR1I2hxnaG2gp
 S7gNbuf/1ML7vB3nugSNqAAAA
X-Change-ID: 20241113-vdso-powerpc-asm-offsets-056016f80174
To: Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731485232; l=1145;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=3++6GpS6eJ69KS1+HG0bM6vN9BkdaF9jmm+cxdj1OjY=;
 b=7k7xztxEb90B3z0PQNrCn9sYj/veenq47sbzWWVsCUd9eIVPMfRzbGC4SfuxAJnkjnUpgR/7N
 qgs5QNJ93MdCkyiTvePnxuN+CSLY7KZR17wVNVo5lnAz6WEnD4fJCKE
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

These offsets are not used anymore, delete them.

Fixes: c39b1dcf055d ("powerpc/vdso: Add a page for non-time data")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
This is based on powerpc/topic/vdso.
Feel free to fold this change into the original commit.
---
 arch/powerpc/kernel/asm-offsets.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 7b3feb6bc2103bc89ea14fbaac6937f1c97d4ff8..23733282de4d9f975aa9450b26c1049688e6663e 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -346,8 +346,6 @@ int main(void)
 #else
 	OFFSET(CFG_SYSCALL_MAP32, vdso_arch_data, syscall_map);
 #endif
-	OFFSET(VDSO_CLOCKMODE_OFFSET, vdso_arch_data, data[0].clock_mode);
-	DEFINE(VDSO_CLOCKMODE_TIMENS, VDSO_CLOCKMODE_TIMENS);
 
 #ifdef CONFIG_BUG
 	DEFINE(BUG_ENTRY_SIZE, sizeof(struct bug_entry));

---
base-commit: 0161bd38c24312853ed5ae9a425a1c41c4ac674a
change-id: 20241113-vdso-powerpc-asm-offsets-056016f80174

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


