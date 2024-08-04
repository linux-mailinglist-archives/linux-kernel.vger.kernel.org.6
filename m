Return-Path: <linux-kernel+bounces-273858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46812946EEE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1332826A5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 13:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB183F9F9;
	Sun,  4 Aug 2024 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ty0yXpEu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nR17txsH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994CD13C9C7
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 13:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722776577; cv=none; b=C3bb8pCsU60f82YLCDxAWjAG/tas9lby7jvutvvUn/xpd6Isibx+Q6sa85bvkWSTVv2nID3dIQw6jBizp39OUtLZ1XVyb8QtUgsK2QbLCnPb+I/zvVCRLF+9fNgffAVFlmfacubZjguBTpnF2ReobBLgw3qM2xs5S0YFi6vfxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722776577; c=relaxed/simple;
	bh=efoyqiZB8R4EmIrWsu20AjNLXpWy7f9hs+HO62mJqDo=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=ijUA/JORMVYlggQkMPK1hgolLWVof80hH4pkAoxQZwpDHTRJ6gZPgUfEkgnzOnNLdrxNavxwVYYoGPcoIwM4Y0w5zilKSLRbCPN7PgD/fjZ/tzJ2wPA4FjG6FXTqOH4KqxnpRefXbL/XFZX/hWCf8gXD2Cmhd9JI6QvA7oz1xpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ty0yXpEu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nR17txsH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722776574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=gcoTjHjGusLcNX0+DmkIX42dZXydwC0YResXTBFbQAE=;
	b=ty0yXpEuBYP6xTTJF87HUsDYG/96cHHTDiRrb75kcTZ6vRh+j5fc5HO3iWtwoXry6DHPye
	z0QnI1F3KFVpMB3ggNZ0Qe2nkFsDSGSqTcNOgOPlD7lIgi9sLIcoXgLF8kej+plxms7GVo
	WeCQE+WHhg6WQmlkee47i4FoxpcjHgsNwnE25CJA+az4XWTXWdpYpm8/OGD08WhhKNsAav
	QEW5dNUYNpIShW6S1OECzYjucg0ksgirreyRhvVICq1SxzLTkzj6VJ1FYzqiSlu8GtDskq
	tkpAQJi5KM7Kr+ubtkG6DEh7Vg+uiWvfEX4TeEPVEHL6Bm07Yvpxfn9+7KEU+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722776574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=gcoTjHjGusLcNX0+DmkIX42dZXydwC0YResXTBFbQAE=;
	b=nR17txsHBJur5nyZ0ef9Ai9h+OREFsV4G5DBD/qjPv/Cp4XsuR1PPhj2MOIa5i6765zuOJ
	1eK6T9ppLKx3MiBA==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] locking/urgent for v6.11-rc2
References: <172277654174.866296.10517632866315552419.tglx@xen13>
Message-ID: <172277654327.866296.9693656850505128683.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun,  4 Aug 2024 15:02:53 +0200 (CEST)

Linus,

please pull the latest locking/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2=
024-08-04

up to:  224fa3552029: jump_label: Fix the fix, brown paper bags galore


Two fixes for locking and jump labels:

   - Ensure that the atomic_cmpxchg() conditions are correct and evaluating
     to true on any non-zero value except 1. The missing check of the
     return value leads to inconsisted state of the jump label counter.

   - Add a missing type conversion in the paravirt spinlock code which
     makes loongson build again.


Thanks,

	tglx

------------------>
Peter Zijlstra (1):
      jump_label: Fix the fix, brown paper bags galore

Uros Bizjak (1):
      locking/pvqspinlock: Correct the type of "old" variable in pv_kick_node=
()


 kernel/jump_label.c                 | 4 ++--
 kernel/locking/qspinlock_paravirt.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 4ad5ed8adf96..6dc76b590703 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -236,7 +236,7 @@ void static_key_disable_cpuslocked(struct static_key *key)
 	}
=20
 	jump_label_lock();
-	if (atomic_cmpxchg(&key->enabled, 1, 0))
+	if (atomic_cmpxchg(&key->enabled, 1, 0) =3D=3D 1)
 		jump_label_update(key);
 	jump_label_unlock();
 }
@@ -289,7 +289,7 @@ static void __static_key_slow_dec_cpuslocked(struct stati=
c_key *key)
 		return;
=20
 	guard(mutex)(&jump_label_mutex);
-	if (atomic_cmpxchg(&key->enabled, 1, 0))
+	if (atomic_cmpxchg(&key->enabled, 1, 0) =3D=3D 1)
 		jump_label_update(key);
 	else
 		WARN_ON_ONCE(!static_key_slow_try_dec(key));
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_p=
aravirt.h
index f5a36e67b593..ac2e22502741 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -357,7 +357,7 @@ static void pv_wait_node(struct mcs_spinlock *node, struc=
t mcs_spinlock *prev)
 static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
 {
 	struct pv_node *pn =3D (struct pv_node *)node;
-	enum vcpu_state old =3D vcpu_halted;
+	u8 old =3D vcpu_halted;
 	/*
 	 * If the vCPU is indeed halted, advance its state to match that of
 	 * pv_wait_node(). If OTOH this fails, the vCPU was running and will


