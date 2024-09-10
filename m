Return-Path: <linux-kernel+bounces-323637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FB39740F0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29FAA1F21C5C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416301A38D1;
	Tue, 10 Sep 2024 17:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMqBuEow"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4F5192D98
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725990224; cv=none; b=LVFUcck7Ful6nCVm4tJmkS5LCwrWyeGWlJqhJDhV/lte3d+g4yXSclHoYwhFCWc2vOI5+WscD2JWk/KYu1f8HW7opEC3MM1jxr0mfl4o0sDW5VJtrOe8PVK8Pwcm0I9FbaAXOGRZ2CParaDCcwMKa5Dk+jIP4VRsvrUusz8mYic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725990224; c=relaxed/simple;
	bh=A3MRxS5w1nIIFu75V4LqJDn3T7sdTVQMHilFFHG+mFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VtcIZNE8+pCPYBgELc3eEt23JG3hBD2Q0Cb9iZicI8/N4yDQ5ylSrYsCkok97bh4NUkHkcOZEWb2BAPnw7tbNLlLsriJjRTFsqy5sCNjHa59kb+06AacAGjPceSKAYRc0B1Rm0lczNEep/Z8iD3IcRPAaGogNfr+rGK7NaQrZMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMqBuEow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBD9C4CEC3;
	Tue, 10 Sep 2024 17:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725990224;
	bh=A3MRxS5w1nIIFu75V4LqJDn3T7sdTVQMHilFFHG+mFg=;
	h=From:Date:Subject:To:Cc:From;
	b=cMqBuEowbEN7cf92VlL1bYPui5iL+AckQ1PxOCQ92TkiSYTjMPXsizCYaE4RdjGe4
	 5KFta3Ia3krrAGkstG7+PQibbXFQOTkJOW8L1diy0qjeCQjAgOkz0MgZARyaDbrItY
	 IVxIz6fz3QfLWqQ7vtc6XlIABqm+MARm7pgyevi58WIKIITYgMgAdBMBMC2IU0IcOD
	 UfPGQVRPvDMsJ7/34GVuAmI0AOKhFQe7GJYT45/XfVIfAhFuAom0r5+A7qtIRsvGzx
	 2++3UjQt+/hBi6KU/eJIrRr9xlEsGM1bdTWqdizHuFgQ8BkYyWrjMcsKgzbRi8N+dq
	 PShGkb3Kgwyzw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 10 Sep 2024 13:43:34 -0400
Subject: [PATCH v3] timekeeping: don't use seqcount loop in
 ktime_mono_to_any() on 64-bit systems
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-mgtime-v3-1-84406ed53fad@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEWF4GYC/22MwQ6CMBAFf4Xs2Zq20CKe/A/joZQtbJRiWtJoC
 P9u4Wb0OC9vZoGIgTDCuVggYKJIk89QHgqwg/E9Muoyg+Sy4o3gbOxnGpHVpUBjsbbWKMjnZ0B
 Hrz10vWUeKM5TeO/dJLb1J5EEE6xUrtVV23Hj1OWOwePjOIUetkaS/z2ZPWz0SWpjlXb8y1vX9
 QN/MkuA1QAAAA==
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3001; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=A3MRxS5w1nIIFu75V4LqJDn3T7sdTVQMHilFFHG+mFg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm4IVILSIpk2p3M0YDZMJl/huDsKyUuHQDPNS/L
 FdMNAWV9mKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZuCFSAAKCRAADmhBGVaC
 FbFMD/93XHcJuSNTLFB3qlmBo1oA+ZkyfKW4BVxcXrGzK3z9wGcPTU3gUYxiAxhyyhH2NxBGXOA
 pIQNIGiBUjSc0NFc7H5tDUxiO7wJOKmOT+ox37X7ltfigrnaYVMMBUKLKxwHERCNnCvoYzurXd3
 u1wfA55K8NuKS9jaA8W+w8znHGXR9c0kVIFBPWYDfJv+LLi0ZRrcNiiwuhfteAEVzLe73g9YiFR
 UbDFmtbV/4ciDI4Ih6IOU5922Bvf/FJEWTx/oXFXmubOb6fKT/WxZQvBL7UyZ3vI1XjMpry/0Q/
 thjCD2y9jpNVAI/KYr0ybGiDk/SF/9/iAozAkcNEXaS4zPhYUMfUwXptq/nRXO5T88UJZQJB4kY
 3tFh9yOz5ckCAyVayKxVBlSC9PNoLwmY+rVCc6kY9WB99dB20mmrCkuLVoe972G3OQNy5KkmmwX
 g2hbEXUXxl+/4hmsUFRW9TxKmWLgSSWlOwtvoGHlHH/znFo8H48X+oEv+rdbVWaqHgfKrURVhbX
 eTuRtVl7JykozU2NTCcwOy0FMgME/RbqhPsw144G4KoqgeELt6r+qVsNBG6ycLCmfMNfOgnMNDR
 XLW8KN+K9iJbrUb0TgAI/PysnkbPalQ1G043IhqO3zddSCWy1tkYkW99yA0mgkHnP617CF2YWoF
 HhpHayJMzM2s3zg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

ktime_mono_to_any() only fetches the offset inside the loop. This is a
single word on 64-bit hosts, and seqcount_read_begin() implies a full
SMP barrier.

When BITS_PER_LONG == 64, use READ_ONCE to fetch the offset instead of
doing a seqcount loop. This means that we also need to use WRITE_ONCE to
update the offsets in tk_set_wall_to_mono() and tk_update_sleep_time().

Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
This one puts back the READ_ONCE and adds WRITE_ONCEs (as Thomas
suggested).
---
Changes in v3:
- add back the READ_ONCE, and use WRITE_ONCE to update the offsets
- Link to v2: https://lore.kernel.org/r/20240910-mgtime-v2-1-e96826ac56f0@kernel.org

Changes in v2:
- drop the READ_ONCE
- clean up changelog
- Link to v1: https://lore.kernel.org/r/20240910-mgtime-v1-1-35fb64bd0af5@kernel.org
---
 kernel/time/timekeeping.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 99381e04a871..ec999a39d9cb 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -161,13 +161,15 @@ static void tk_set_wall_to_mono(struct timekeeper *tk, struct timespec64 wtm)
 	WARN_ON_ONCE(tk->offs_real != timespec64_to_ktime(tmp));
 	tk->wall_to_monotonic = wtm;
 	set_normalized_timespec64(&tmp, -wtm.tv_sec, -wtm.tv_nsec);
-	tk->offs_real = timespec64_to_ktime(tmp);
-	tk->offs_tai = ktime_add(tk->offs_real, ktime_set(tk->tai_offset, 0));
+	/* paired with READ_ONCE in ktime_mono_to_any */
+	WRITE_ONCE(tk->offs_real, timespec64_to_ktime(tmp));
+	WRITE_ONCE(tk->offs_tai, ktime_add(tk->offs_real, ktime_set(tk->tai_offset, 0)));
 }
 
 static inline void tk_update_sleep_time(struct timekeeper *tk, ktime_t delta)
 {
-	tk->offs_boot = ktime_add(tk->offs_boot, delta);
+	/* paired with READ_ONCE in ktime_mono_to_any */
+	WRITE_ONCE(tk->offs_boot, ktime_add(tk->offs_boot, delta));
 	/*
 	 * Timespec representation for VDSO update to avoid 64bit division
 	 * on every update.
@@ -954,6 +956,15 @@ EXPORT_SYMBOL_GPL(ktime_get_coarse_with_floor_and_offset);
  * @tmono:	time to convert.
  * @offs:	which offset to use
  */
+#if BITS_PER_LONG == 64
+ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs)
+{
+	ktime_t *offset = offsets[offs];
+
+	/* paired with WRITE_ONCEs in tk_set_wall_to_mono and tk_update_sleep_time */
+	return ktime_add(tmono, READ_ONCE(*offset));
+}
+#else /* BITS_PER_LONG == 64 */
 ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs)
 {
 	ktime_t *offset = offsets[offs];
@@ -967,6 +978,7 @@ ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs)
 
 	return tconv;
 }
+#endif /* BITS_PER_LONG == 64 */
 EXPORT_SYMBOL_GPL(ktime_mono_to_any);
 
 /**

---
base-commit: a833754dba0fcc8984e8e86042a8877be70187d9
change-id: 20240910-mgtime-731eace7cca5

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


