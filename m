Return-Path: <linux-kernel+bounces-310206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5255C967648
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 13:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE69281BD1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 11:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F3B175D5F;
	Sun,  1 Sep 2024 11:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YJftPHou";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dIkQ4yd3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AAC16F8E9
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 11:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725191051; cv=none; b=bH7RXram1vM6c55DeUEuPVFAmxaC+mBJaqeEwZ/9dVDGRzVfbhC6Mic+oT0LFQuV67t+75OciYpWQ4JGK0w7FW4A74+pmqj2JFp2At4WhPhXxxEfcM1QUS1D5l9h08IZMnOle2IEuV2fv85160azoT4JcH4cLqvpMW2Dwna8L9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725191051; c=relaxed/simple;
	bh=xfmj2b/QcJ8hdDyfPwaT7EC3SQi1aCSv7lNj5nhOHsU=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=hufhFcTC+YJtJyiEsJFWapfyGQaRkGltatUTSgwrCYgLNmCeszihH4vE1i1Z4SvQlqjv/j9gibfncYvawXETJhHuHTtsVW5gUIYpDuP9xb8BrsIs3hAIdh6YbzKZXvBpXlzneWOShFpDImtp4MlkACM/Z0bqCSP0fZ9dZ6sHwyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YJftPHou; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dIkQ4yd3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725191043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=JduJ+JRotfUN1EaWrvdQWj9GoTPL7HHkgDKugkZnSSY=;
	b=YJftPHouaBy8WZe84GQH/kfufCDo5ORO0k2HtcOJM4GXbaiWfPGTGuX/lA1qGZiakkWGNA
	EgO/pqTQC11hz2awj8s4RytEoVMQjff7RpcEZpRB+ZNNhmdzbnQbtJj8xRh4RqaUwx0JiX
	njwQqDpSY9FWKRgZtNqI09h7ex1optL32l27EVwDvITl7WDLQ2tFPRNSRiitSWOwj5UKqu
	D/DggaDNXFnZ7Dyu7B3z0NZV5F8yIncUNL1XIT41Jo12nBESvcJqtPgPpOk5e43CBHJuLR
	TN18WbMM4GFXUhxLExPl0A00RtcprKkDYv4qV3IRhsN5dMkQcFNlSTUzd4e85Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725191043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=JduJ+JRotfUN1EaWrvdQWj9GoTPL7HHkgDKugkZnSSY=;
	b=dIkQ4yd3HN7zUX6CTwiAiYJHTSozkKvbssnIWvnkzxIcgP21YDCZzoYSPtOwlf2UFM24K2
	F86wpS1j9BRpQ0Ag==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] perf/urgent for v6.11-rc7
References: <172519097408.1871736.16401401125691449823.tglx@xen13>
Message-ID: <172519097718.1871736.2200605429051036011.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun,  1 Sep 2024 13:44:02 +0200 (CEST)

Linus,

please pull the latest perf/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024=
-09-01

up to:  25dfc9e357af: perf/x86/intel: Limit the period on Haswell

A single fix for x86 performance monitoring:

  Haswell PMUs suffer from several errata and require to limit the minimal
  period for counter events, otherwise they suffer from endless loops in
  the PMU interrupt.

Thanks,

	tglx

------------------>
Kan Liang (1):
      perf/x86/intel: Limit the period on Haswell


 arch/x86/events/intel/core.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0c9c2706d4ec..9e519d8a810a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4589,6 +4589,25 @@ static enum hybrid_cpu_type adl_get_hybrid_cpu_type(vo=
id)
 	return HYBRID_INTEL_CORE;
 }
=20
+static inline bool erratum_hsw11(struct perf_event *event)
+{
+	return (event->hw.config & INTEL_ARCH_EVENT_MASK) =3D=3D
+		X86_CONFIG(.event=3D0xc0, .umask=3D0x01);
+}
+
+/*
+ * The HSW11 requires a period larger than 100 which is the same as the BDM1=
1.
+ * A minimum period of 128 is enforced as well for the INST_RETIRED.ALL.
+ *
+ * The message 'interrupt took too long' can be observed on any counter which
+ * was armed with a period < 32 and two events expired in the same NMI.
+ * A minimum period of 32 is enforced for the rest of the events.
+ */
+static void hsw_limit_period(struct perf_event *event, s64 *left)
+{
+	*left =3D max(*left, erratum_hsw11(event) ? 128 : 32);
+}
+
 /*
  * Broadwell:
  *
@@ -4606,8 +4625,7 @@ static enum hybrid_cpu_type adl_get_hybrid_cpu_type(voi=
d)
  */
 static void bdw_limit_period(struct perf_event *event, s64 *left)
 {
-	if ((event->hw.config & INTEL_ARCH_EVENT_MASK) =3D=3D
-			X86_CONFIG(.event=3D0xc0, .umask=3D0x01)) {
+	if (erratum_hsw11(event)) {
 		if (*left < 128)
 			*left =3D 128;
 		*left &=3D ~0x3fULL;
@@ -6766,6 +6784,7 @@ __init int intel_pmu_init(void)
=20
 		x86_pmu.hw_config =3D hsw_hw_config;
 		x86_pmu.get_event_constraints =3D hsw_get_event_constraints;
+		x86_pmu.limit_period =3D hsw_limit_period;
 		x86_pmu.lbr_double_abort =3D true;
 		extra_attr =3D boot_cpu_has(X86_FEATURE_RTM) ?
 			hsw_format_attr : nhm_format_attr;


