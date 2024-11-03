Return-Path: <linux-kernel+bounces-393780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B74529BA521
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 11:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1EA281645
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 10:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F55E16F824;
	Sun,  3 Nov 2024 10:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GdOnzd3M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0M7z6joo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E84155C8C
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 10:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730629869; cv=none; b=LXbdyzXaONRWRHWq5VBnFcayRUBDJaNPM3J3R0Sz5g1ouU+S+SmkNU8/brkfSuZBqA9Vngw8Bvx686bxupXbooi6cF5Y0OaWH3B+XjEquZYuR48LC8dLsuUVCbQw6ztAl8gRK/e88EHM1r8+Blj6+b3kbXz2sGdD6wJk2tAtnmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730629869; c=relaxed/simple;
	bh=DS3qHCWU42QTk4d6g11RyiagiH6p2EUvYrzKSXcFJ/8=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=nYzeR4FiDWTKZOYl5SfIdQVxCuGY23fSISLXeh5Udw3IDTrN8nNlcHnOA65FQWFVnDEJCsUvxa4jr8ut6yKVRHyGyhWugguB1OZoQYAK6NP0k3+aN08ksW5qzwyf/faT5vdngs7J0th74huQXQn1DIp1YyqwUCbehlaX8fV5xEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GdOnzd3M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0M7z6joo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730629861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=d6WYsJQuFE2vceQcED2c5WI+PFqXo71FloNT/z1IOvY=;
	b=GdOnzd3MtjWtohODqfIPJbdDD0uFKAWZFszg7HqvExaxpH9KZPbKFbeUwbh5oMltLBvKD0
	mM5RJrzK5jRpye8hmM3CwIld2HrkltlBsjE7Ht+zRnG4nT7qDPfflyw0E+fwtVSgqpXvrL
	NO5Z0COZtKOPYsPMQUyoDcOum0Mjcc0XvSyeZ1ZSOMnuSZqQCEJ71r2vUN3Mrb2onmEvVp
	5hf03E3NTUag2jZQhAkwWtRZ/yxp//z6N3zLE2ioRtJNMyRVsjZO6yY7H0d+Kvzs1X3VMb
	lWZ7hD50ldq7Dh9UPAzMTcRx3LV/vrpJPbCNUpc2skkDz5O/t1NaNvNNS6Tniw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730629861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=d6WYsJQuFE2vceQcED2c5WI+PFqXo71FloNT/z1IOvY=;
	b=0M7z6jooAfSbruY3CCrGuVcJxwAhXGBOgaAMZiLROSBMtrHUAlR6r9eN8Pl7oKNdlSQtHQ
	TaxybFO4KCbav+Ag==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] perf/urgent for v6.12-rc6
References: <173062982864.1467946.2540622433845043721.tglx@xen13>
Message-ID: <173062983020.1467946.18431922666552238508.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun,  3 Nov 2024 11:31:00 +0100 (CET)

Linus,

please pull the latest perf/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024=
-11-03

up to:  e3dfd64c1f34: perf: Fix missing RCU reader protection in perf_event_c=
lear_cpumask()

A single fix for perf:

  perf_event_clear_cpumask() uses list_for_each_entry_rcu() without being
  in a RCU read side critical section, which triggers a "suspicious RCU
  usage" warning.

  It turns out that the list walk does not be RCU protected because the
  write side lock is held in this contxt.

  Change it to a regular list walk.

Thanks,

	tglx

------------------>
Kan Liang (1):
      perf: Fix missing RCU reader protection in perf_event_clear_cpumask()


 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index cdd09769e6c5..df27d08a7232 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13959,7 +13959,7 @@ static void perf_event_clear_cpumask(unsigned int cpu)
 	}
=20
 	/* migrate */
-	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
+	list_for_each_entry(pmu, &pmus, entry) {
 		if (pmu->scope =3D=3D PERF_PMU_SCOPE_NONE ||
 		    WARN_ON_ONCE(pmu->scope >=3D PERF_PMU_MAX_SCOPE))
 			continue;


