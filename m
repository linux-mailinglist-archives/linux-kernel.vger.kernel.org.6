Return-Path: <linux-kernel+bounces-517123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE98A37C65
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FEB3161F9A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC6A199254;
	Mon, 17 Feb 2025 07:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sJDfWOJv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vSe2WVK+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D0B17B425
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 07:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739777986; cv=none; b=cAq8gZxZxa84IamjHOZ8AoSGHgJY9iHkAh95GsUUba60+YP09SJTMCTKJ7fOsnbBJS8FcgFoSVNBVqAYzr6EyTYY6mOOe0e1zMFrIHEiCVOwPDjE05K3EkieXYMkpPidKw8iYzrViYcIDndclp0fW/jKau1u2taIAZ0jNDzsGck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739777986; c=relaxed/simple;
	bh=kjiQYrE6V+TzqI5qEPcFJIH5Y9ABiiapfv4xGeGSJXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a6bERwru6zBC66oN+qrTS+z54dfUgy67udyPonNibhzEWg+snaWimBP1FqoPfJ2iep0NPp9Cp8rv/DvV5Gofd3y9fpjpOztmHJBFi/uf6+X6kNlMRCPthrb102YUq0AGA3S+H2GTDNv299MIcxHsVKRk0uPUTT2COP4R6Pdi8FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sJDfWOJv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vSe2WVK+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739777983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7E7dYykXYQTWjl7/oNXyhreXroGqUk/4p813PlASVtw=;
	b=sJDfWOJvq4GycCxYqIkiTLc8aY/PzbqNTkooQaYTu3EmQz+l9f3iNBO1g7cceXZSa73Sm/
	TQ3rUbzZLqKfCJ/eSdnKxfBJsd1lnDTt5iznJXqEQYmiXVF/M0VLbioYPhFWMaymlzuMcU
	ufbxUGm67cOIoFMeiOn7p7abkAiPbcghJ1UuwmDINMWluF5CiP3gtvGMhY2dXIoQnkesPG
	yuOEv64v0YzhdjUcLDbsRsEMQ8z025K2Y6A7t73PyhtUczxUltINV/0dy90lclnO55ekrZ
	jYxcENAjulDYpVOwByIjbppUSFocs12HIcAi5iyNPFn0nR9nvGyVUn9YOelahw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739777983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7E7dYykXYQTWjl7/oNXyhreXroGqUk/4p813PlASVtw=;
	b=vSe2WVK+48Fz505c7SK7kBOBcb8hoevySXg7GjkGjgQ2R6L1LkuS2fJgXZuNgpbk4wYA4q
	hm8DGiINCIt44XBA==
Date: Mon, 17 Feb 2025 08:39:41 +0100
Subject: [PATCH] powerpc: Don't use %pK through printk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250217-restricted-pointers-powerpc-v1-1-32c6bff63c9a@linutronix.de>
X-B4-Tracking: v=1; b=H4sIALznsmcC/x3MQQqDMBBG4avIrBswIUbtVUoXEn91NjHMhFoQ7
 25w977NO0khDKV3c5Lgx8p7qrCvhuI2pRWG52pyretaZ3sj0CIcC2aTd04FojUOSI5msXbogx+
 DD57qIQsW/j/3z/e6bpZHth5tAAAA
X-Change-ID: 20250217-restricted-pointers-powerpc-f11876496464
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver O'Halloran <oohall@gmail.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739777983; l=2981;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=kjiQYrE6V+TzqI5qEPcFJIH5Y9ABiiapfv4xGeGSJXc=;
 b=lHxXcgUcaE7rXQGVPGeozmCBwXxrozW0Hai4AkmlmfMCXeSu/N6xT2aqcBV0XUlieHx4rhUuN
 i+vEPM0aO78Aq59Xz6NY0YdnQ+rbBOq9cb0FcKWNthu+BjwhR8i5ie1
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Restricted pointers ("%pK") are not meant to be used through printk().
It can unintentionally expose security sensitive, raw pointer values.

Use regular pointer formatting instead.

Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/powerpc/kernel/eeh_driver.c | 2 +-
 arch/powerpc/perf/hv-24x7.c      | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 7efe04c68f0fe3fb1c3c13d97d58e79e47cf103b..10ce6b3bd3b7c54f91544ae7f7fd3f32a51ee09a 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -907,7 +907,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 		/* FIXME: Use the same format as dump_stack() */
 		pr_err("EEH: Call Trace:\n");
 		for (i = 0; i < pe->trace_entries; i++)
-			pr_err("EEH: [%pK] %pS\n", ptrs[i], ptrs[i]);
+			pr_err("EEH: [%p] %pS\n", ptrs[i], ptrs[i]);
 
 		pe->trace_entries = 0;
 	}
diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index d400fa391c2765cf201ee4dc754007e655cc74ca..f6d734431b1dcdfec3b9205c3b48577b4fc26b53 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -713,12 +713,12 @@ static ssize_t catalog_event_len_validate(struct hv_24x7_event_data *event,
 	ev_len = be16_to_cpu(event->length);
 
 	if (ev_len % 16)
-		pr_info("event %zu has length %zu not divisible by 16: event=%pK\n",
+		pr_info("event %zu has length %zu not divisible by 16: event=%p\n",
 				event_idx, ev_len, event);
 
 	ev_end = (__u8 *)event + ev_len;
 	if (ev_end > end) {
-		pr_warn("event %zu has .length=%zu, ends after buffer end: ev_end=%pK > end=%pK, offset=%zu\n",
+		pr_warn("event %zu has .length=%zu, ends after buffer end: ev_end=%p > end=%p, offset=%zu\n",
 				event_idx, ev_len, ev_end, end,
 				offset);
 		return -1;
@@ -726,14 +726,14 @@ static ssize_t catalog_event_len_validate(struct hv_24x7_event_data *event,
 
 	calc_ev_end = event_end(event, end);
 	if (!calc_ev_end) {
-		pr_warn("event %zu has a calculated length which exceeds buffer length %zu: event=%pK end=%pK, offset=%zu\n",
+		pr_warn("event %zu has a calculated length which exceeds buffer length %zu: event=%p end=%p, offset=%zu\n",
 			event_idx, event_data_bytes, event, end,
 			offset);
 		return -1;
 	}
 
 	if (calc_ev_end > ev_end) {
-		pr_warn("event %zu exceeds its own length: event=%pK, end=%pK, offset=%zu, calc_ev_end=%pK\n",
+		pr_warn("event %zu exceeds its own length: event=%p, end=%p, offset=%zu, calc_ev_end=%p\n",
 			event_idx, event, ev_end, offset, calc_ev_end);
 		return -1;
 	}

---
base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
change-id: 20250217-restricted-pointers-powerpc-f11876496464

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


