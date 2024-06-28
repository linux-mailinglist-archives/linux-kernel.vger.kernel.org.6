Return-Path: <linux-kernel+bounces-233829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CE391BDD3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646B01F23A05
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD930158216;
	Fri, 28 Jun 2024 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dwOPbOEW"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1EC158213
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719575421; cv=none; b=J1n0GaxflnNAf3ZxNZU8IEcODV/p0lFPJGwRbRuJKFfTZcNGlv6c9DGV5W54NkEPl8/FpUUDwWIZ1F7g+IWkFZx6SrEpO4VFsm4zwy6JMjNjdqg/e4MpMrUM5BOE9lLvpCvQ83kyget/effwBNrSSJfo2P4mO0MR70/5+XpIHGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719575421; c=relaxed/simple;
	bh=4RxwJG7QdGFmOl2KUb4Janwhv5UUML70tD8BQ4dtAhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rHiN/X3nM4B7RFS6HY5x+NgBIEG8jpJa2h97yT7/01BufD09BiSXrl5b3TLqzFyA0iqXU52+UvtcPNocVeXIihBoXRSn7hebq03OI3ZEHokn3EY5MTbdWGCdsdAKDO1boLR8F8h0hsEKAo4Nmok+j34gep8OwdF4IER/DPKZmnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=dwOPbOEW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fa2ea1c443so3511285ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 04:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719575420; x=1720180220; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jDkERiCQ0W+JOyjAnotwTfkJvLnFYyeR6Qb1524j9kg=;
        b=dwOPbOEWmk4ustjam9mKWhaq6HC/MXqJwg3xd23k2gCknfq8luUz0GWI3vinUYtcDe
         vTAkEjVewH0Nmazvkd6vh7wQ4VRJ57TlvA99fNOIcZQp4gbBasw+L/EhfwRBbO5yqdl+
         Tqrf9PJFQuEWQGfa/43xd+fwTKCbpLHK3Vkn0cDkBduBMctwggda39E1h/xYhSqJwttH
         C37ybWlMf9gWpWAauGSQRAAKifRPNtTj5f14XDvJmxdv4kta4mo5wVYEdfJqHh1P9a9k
         aZAMQ0mPC75hyidvPGhf3yOXiTmRNedxN6N5UTICWNQFDmc0DrKzCr6wuOphJ/trDQb3
         8xbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719575420; x=1720180220;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jDkERiCQ0W+JOyjAnotwTfkJvLnFYyeR6Qb1524j9kg=;
        b=rNQ/QIMXrVGKu9XYc4kxJL30FxBWJETQMNJDJYYQAtVhSqhmm5TmZUbPwNzdWHdBqg
         bBNk6jQOtEfF3q7DuEiOXpHvSYSDKw+ktSSV4gNdrHztAYMus/8EsZYdaEwGmBXBhZmH
         OpEwvUdgQMd1a6MjJzT6zq9uHTWkhP/yeZ+AWEVgTnKFz5pdZEslASKG5cl9Hi0Rfusc
         AzOULA5zwedeUQPBEDpIR7QgzOf2FKCxMVfYhGeX8MgfD7fouzVqhONYDtMG+0X4iDWD
         I/baDXdFCfdrAOMsOgG0v7ybnt54WdGExz0z4XQlQxdm/tkvROnYOqA8908uYg3FK7tD
         i0dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ5rB9v55hEhexvz6J/pA1MZHNCKmiiGCeJif1QUd9EXc1wSaKxXBTw+a4WnS6ipb9JAdYm5wjWVwm7wwLmjiVLN97zRHSIAHKLGSb
X-Gm-Message-State: AOJu0YwW2h90YC4ty4hrn9YUOqwnHUKUbXQgxyI9heVfnn0mRBbczRYN
	n9ObTRaLBf4nB+wX7tEszoEybCw55Vxy/Yobi5f6ij5CeqRWESCbCtaPTSXh2kI=
X-Google-Smtp-Source: AGHT+IFmQ94BPvo45dLsSc/fXtrlVJyxIjuxBvy9HErlZWIz0JMBJ76CrcDuItu29//kRb0mvech0A==
X-Received: by 2002:a17:903:2290:b0:1f9:fb39:2fb5 with SMTP id d9443c01a7336-1fa23bd1987mr168448695ad.21.1719575419755;
        Fri, 28 Jun 2024 04:50:19 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac155c382sm13519285ad.189.2024.06.28.04.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 04:50:19 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Fri, 28 Jun 2024 19:50:13 +0800
Subject: [PATCH] riscv: signal: abstract header saving for setup_sigcontext
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-dev-signal-refactor-v1-1-0c391b260261@sifive.com>
X-B4-Tracking: v=1; b=H4sIAHSjfmYC/x2MQQqAMAzAvjJ6tqBV1PkV8VBm1YJM2WQI4t8dH
 kNIHogSVCIM5oEgSaMePkNVGHAb+1VQ58xAJTVlSz3OkjDq6nnHIAu76wjoaisVd2SJW8jlmY3
 e/3Wc3vcDKPhkBGUAAAA=
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Andy Chiu <andy.chiu@sifive.com>
X-Mailer: b4 0.13-dev-a684c

The function save_v_state() served two purposes. First, it saved
extension context into the signal stack. Then, it constructed the
extension header if there was no fault. The second part is independent
of the extension itself. As a result, we can pull that part out, so
future extensions may reuse it. This patch adds arch_ext_list and makes
setup_sigcontext() go through all possible extensions' save() callback.
The callback returns a positive value indicating the size of the
successfully saved extension. Then the kernel proceeds to construct the
header for that extension. The kernel skips an extension if it does
not exist, or if the saving fails for some reasons. The error code is
propagated out on the later case.

This patch does not introduce any functional changes.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
 arch/riscv/kernel/signal.c | 53 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 5a2edd7f027e..eb16742ed106 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -70,16 +70,17 @@ static long save_fp_state(struct pt_regs *regs,
 
 #ifdef CONFIG_RISCV_ISA_V
 
-static long save_v_state(struct pt_regs *regs, void __user **sc_vec)
+static long save_v_state(struct pt_regs *regs, void __user *sc_vec)
 {
-	struct __riscv_ctx_hdr __user *hdr;
 	struct __sc_riscv_v_state __user *state;
 	void __user *datap;
 	long err;
 
-	hdr = *sc_vec;
-	/* Place state to the user's signal context space after the hdr */
-	state = (struct __sc_riscv_v_state __user *)(hdr + 1);
+	if (!(has_vector() && riscv_v_vstate_query(regs)))
+		return 0;
+
+	/* Place state to the user's signal context spac */
+	state = (struct __sc_riscv_v_state __user *)sc_vec;
 	/* Point datap right after the end of __sc_riscv_v_state */
 	datap = state + 1;
 
@@ -97,15 +98,11 @@ static long save_v_state(struct pt_regs *regs, void __user **sc_vec)
 	err |= __put_user((__force void *)datap, &state->v_state.datap);
 	/* Copy the whole vector content to user space datap. */
 	err |= __copy_to_user(datap, current->thread.vstate.datap, riscv_v_vsize);
-	/* Copy magic to the user space after saving  all vector conetext */
-	err |= __put_user(RISCV_V_MAGIC, &hdr->magic);
-	err |= __put_user(riscv_v_sc_size, &hdr->size);
 	if (unlikely(err))
-		return err;
+		return -EFAULT;
 
-	/* Only progress the sv_vec if everything has done successfully  */
-	*sc_vec += riscv_v_sc_size;
-	return 0;
+	/* Only return the size if everything has done successfully  */
+	return riscv_v_sc_size;
 }
 
 /*
@@ -147,6 +144,19 @@ static long __restore_v_state(struct pt_regs *regs, void __user *sc_vec)
 #define __restore_v_state(task, regs) (0)
 #endif
 
+struct arch_ext_priv {
+	__u32 magic;
+	long (*save)(struct pt_regs *regs, void __user *sc_vec);
+};
+
+struct arch_ext_priv arch_ext_list[] = {
+	{
+		.magic = RISCV_V_MAGIC,
+		.save = &save_v_state,
+	},
+};
+const size_t nr_arch_exts = ARRAY_SIZE(arch_ext_list);
+
 static long restore_sigcontext(struct pt_regs *regs,
 	struct sigcontext __user *sc)
 {
@@ -276,7 +286,8 @@ static long setup_sigcontext(struct rt_sigframe __user *frame,
 {
 	struct sigcontext __user *sc = &frame->uc.uc_mcontext;
 	struct __riscv_ctx_hdr __user *sc_ext_ptr = &sc->sc_extdesc.hdr;
-	long err;
+	struct arch_ext_priv *arch_ext;
+	long err, i, ext_size;
 
 	/* sc_regs is structured the same as the start of pt_regs */
 	err = __copy_to_user(&sc->sc_regs, regs, sizeof(sc->sc_regs));
@@ -284,8 +295,20 @@ static long setup_sigcontext(struct rt_sigframe __user *frame,
 	if (has_fpu())
 		err |= save_fp_state(regs, &sc->sc_fpregs);
 	/* Save the vector state. */
-	if (has_vector() && riscv_v_vstate_query(regs))
-		err |= save_v_state(regs, (void __user **)&sc_ext_ptr);
+	for (i = 0; i < nr_arch_exts; i++) {
+		arch_ext = &arch_ext_list[i];
+		if (!arch_ext->save)
+			continue;
+
+		ext_size = arch_ext->save(regs, sc_ext_ptr + 1);
+		if (ext_size <= 0) {
+			err |= ext_size;
+		} else {
+			err |= __put_user(arch_ext->magic, &sc_ext_ptr->magic);
+			err |= __put_user(ext_size, &sc_ext_ptr->size);
+			sc_ext_ptr = (void *)sc_ext_ptr + ext_size;
+		}
+	}
 	/* Write zero to fp-reserved space and check it on restore_sigcontext */
 	err |= __put_user(0, &sc->sc_extdesc.reserved);
 	/* And put END __riscv_ctx_hdr at the end. */

---
base-commit: 60a6707f582ebbdfb6b378f45d7bf929106a1cd5
change-id: 20240628-dev-signal-refactor-c39e1a7292a6

Best regards,
-- 
Andy Chiu <andy.chiu@sifive.com>


