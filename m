Return-Path: <linux-kernel+bounces-439722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED389EB31C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5572837ED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8843A1B4F04;
	Tue, 10 Dec 2024 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nFKYOI4i"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5970B1A9B3F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840657; cv=none; b=WVEcnfEKuTk8Zsf1ThdcLZoKzg8pyBv3e1BKh4aw+4q550AXlt4Tt4FZ5zVeigTSVpOIjb4VEUOa/OvMyCJfZgc2CO+X0wqlxDM848+V942HDTjGCwDMFVHLhl9GiUA8DXKfKkui/9Xm+EsSimB5jAoXu5IYONA6EESvW4gEseM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840657; c=relaxed/simple;
	bh=o7Aeuhh/zUkUiI+rI5JJZaIjuea04BOVBQ6VJYKURdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=g7Z56d3KlMEH5r/f1sSDgH/hHlkl0l6EQp0noacTAhiHuADDWP0C3DMv7L9j1OLK+QlOlTxr/HknrBk9WJ58nlzdu1h+k3qBPtnO1pSVDCKs4Wt3/84EdYWle79Cqfkd1I+cwxgQggOt0xORtJjayd0p6gJKMz/qmj43xyItgaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=nFKYOI4i; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee9a780de4so4266284a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1733840655; x=1734445455; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K5qH0MfXKfA82FtJGAtiD9e44kpeNSF59qHyzqUktew=;
        b=nFKYOI4iisIVieq3fTDJm3MtBR/ASZp4eYY81gHRYPrkJZ1AqPAmXwWLNePzfnJWyJ
         qkpWIqBMYl3tamcd5Z8IBg3sZm2GMWzpIAaVnchqa4sHDaQlWLntZEN5Byxs6oeiONpO
         D+rOOOeC4FeESdX7xYkoxm9Hms+3U7fnkqQIy1fBVOt6kbu7Ekrws6OqB9vPWl7d7+16
         EQCegeofAkG14UOGy1ML/L0K6VvABIMumZ8XYJ5dcoUASc8EfmeygboMUDCvfgJc8MpE
         pRHDEoxTyHJ+eVdyPbjvmfn4nxhLKUrg5eMqVzvehCl9EJhMMdf/gjJQojT4LUqW+/na
         /p3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733840655; x=1734445455;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K5qH0MfXKfA82FtJGAtiD9e44kpeNSF59qHyzqUktew=;
        b=tL72cVg5c0DndTbaJXx5WQkm17Tdro0VF+6/C3r6BX4p3bnGyfIPEffUJOL2cA0Gqo
         jgYk4NtdM/rqgMCLcgimCEvE5R/5/hMkaAH/YaapkyuJ/YYINypMgZWvU62L16xFFxMo
         2N+PDcksQZL4qwT5DoxcUNALj+3J7g5lNecVzsgY2duK0Kloz72kwpsPrAb+TDrUXkra
         w4rSrYQGNkh0ojsnkIgq6sbjSFAqmDMqBVpP4OYw4rkGFuHYmPopj0igkkvodKw8TlBZ
         hOdQwuS75XwF1SAdbgFCvNsm4rI80TxwX7D6OqjAX4say6Y32PisWpBOhFWhc34yYFVP
         kPHA==
X-Gm-Message-State: AOJu0YzTHJUSNB8NFCSWM1sxzehPdEmZU6TSr7sUfI3pHCFGXqyVBLBq
	BsdxgIpbDpwhggrzZTj5QXhuIQfR4b2yFYwxcKgc5aYKPq7qB0sZBhebRHV7dHPmT89IgKu3InL
	x/x2QBJUFvv4mundlNACs4HTB9wTW7ZRt7qeUmjIAniM8vgZ8ROy90d6UcVWqvJe2Wh7z2TxZNp
	TV5CYiJ7FKj9DYSZ6HEDTcyk/OeOC2/LuaxdLzFQYfp4CRMx+JNJj2jA==
X-Gm-Gg: ASbGncumP1exirbgD3k7XLTcmSlbKtivOhcJ1YMA0jxGlEYxeCFHSCkhIw3//t4ZnNJ
	XzlEhVuEpBYpvQQgkgpTQOXX3YA0LAnuiifXDRo1jDNuKphtIcgP5PEyQnm/IB7o9sUPvSbnb60
	xfu5h0G9g7/iyEAjI6oVzbodLfSPzv8RvhZsv8WKaPg+L4uqnjnJN3rg4jyUQ0Me5E5Pz+2Jwwe
	rjVbujsao4QtiHUDnBzIf2osUXcXe/im75yhnfe8opLnxhFraTFEYqbeFp8VI4uy/ukQb6mj0P0
	937DkVDM
X-Google-Smtp-Source: AGHT+IE4HixJrIDtqZonmKGjORacp6uNTwKs9GuvdA/FUm9KmXGsasElmICG8/zrqS2NRhVFZTIRCA==
X-Received: by 2002:a17:90b:52d0:b0:2ee:741c:e9f4 with SMTP id 98e67ed59e1d1-2ef69fffa77mr23841080a91.11.1733840654766;
        Tue, 10 Dec 2024 06:24:14 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef7315fd3asm7538444a91.44.2024.12.10.06.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 06:24:14 -0800 (PST)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andy Chiu <andybnac@gmail.com>,
	Zong Li <zong.li@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Guo Ren <guoren@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 2/2] riscv: signal: fix signal_minsigstksz
Date: Tue, 10 Dec 2024 22:23:50 +0800
Message-Id: <20241210142353.6457-3-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241210142353.6457-1-yongxuan.wang@sifive.com>
References: <20241210142353.6457-1-yongxuan.wang@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The init_rt_signal_env() funciton is called before the alternative patch
is applied, so using the alternative-related API to check the availability
of an extension within this function doesn't have the intended effect.
Instead, the riscv_isa bitmap should be used to properly check whether
given extension is available. This patch also refactors the estimation of
signal_minsigstksz by extracting it from the get_rt_frame_size() funciton.

Fixes: e92f469b0771 ("riscv: signal: Report signal frame size to userspace via auxv")
Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/kernel/signal.c | 40 ++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index c3c517b9eee5..85eac84719e9 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -203,22 +203,18 @@ static long restore_sigcontext(struct pt_regs *regs,
 	return err;
 }
 
-static size_t get_rt_frame_size(bool cal_all)
+static size_t get_rt_frame_size(struct pt_regs *regs)
 {
 	struct rt_sigframe __user *frame;
-	size_t frame_size;
+	size_t frame_size = sizeof(*frame);
 	size_t total_context_size = 0;
 
-	frame_size = sizeof(*frame);
-
-	if (has_vector()) {
-		if (cal_all || riscv_v_vstate_query(task_pt_regs(current)))
-			total_context_size += riscv_v_sc_size;
-	}
+	if (has_vector() && riscv_v_vstate_query(regs))
+		total_context_size += riscv_v_sc_size;
 
 	frame_size += total_context_size;
-
 	frame_size = round_up(frame_size, 16);
+
 	return frame_size;
 }
 
@@ -228,7 +224,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	struct rt_sigframe __user *frame;
 	struct task_struct *task;
 	sigset_t set;
-	size_t frame_size = get_rt_frame_size(false);
+	size_t frame_size = get_rt_frame_size(regs);
 
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
@@ -318,7 +314,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 	struct rt_sigframe __user *frame;
 	long err = 0;
 	unsigned long __maybe_unused addr;
-	size_t frame_size = get_rt_frame_size(false);
+	size_t frame_size = get_rt_frame_size(regs);
 
 	frame = get_sigframe(ksig, regs, frame_size);
 	if (!access_ok(frame, frame_size))
@@ -465,19 +461,33 @@ void arch_do_signal_or_restart(struct pt_regs *regs)
 void init_rt_signal_env(void);
 void __init init_rt_signal_env(void)
 {
-	riscv_v_sc_size = sizeof(struct __riscv_ctx_hdr) +
-			  sizeof(struct __sc_riscv_v_state) + riscv_v_vsize;
+	struct rt_sigframe __user *frame;
+	size_t frame_size = sizeof(*frame);
+
+	/*
+	 * init_rt_signal_env() is called before applying alternative patch. Do not use
+	 * __riscv_has_extension_likely()/__riscv_has_extension_unlikely() to check the
+	 * availiablity of an extension in this function.
+	 */
+	if (__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_v)) {
+		riscv_v_sc_size = sizeof(struct __riscv_ctx_hdr) +
+				  sizeof(struct __sc_riscv_v_state) + riscv_v_vsize;
+		frame_size += riscv_v_sc_size;
+	}
+
+	frame_size = round_up(frame_size, 16);
+
 	/*
 	 * Determine the stack space required for guaranteed signal delivery.
 	 * The signal_minsigstksz will be populated into the AT_MINSIGSTKSZ entry
 	 * in the auxiliary array at process startup.
 	 */
-	signal_minsigstksz = get_rt_frame_size(true);
+	signal_minsigstksz = frame_size;
 }
 
 #ifdef CONFIG_DYNAMIC_SIGFRAME
 bool sigaltstack_size_valid(size_t ss_size)
 {
-	return ss_size > get_rt_frame_size(false);
+	return ss_size > get_rt_frame_size(current_pt_regs());
 }
 #endif /* CONFIG_DYNAMIC_SIGFRAME */
-- 
2.17.1


