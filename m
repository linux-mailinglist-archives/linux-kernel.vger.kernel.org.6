Return-Path: <linux-kernel+bounces-233828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1FE91BDD2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE78C1C20C31
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583A8158D7A;
	Fri, 28 Jun 2024 11:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KfiMMsM/"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B55158A39
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719575388; cv=none; b=ApkzDBHBsSz0XZ8tQurbAmsZi9evTWwp6I6y5TvWxt61GYx5xAvtaR+R80m3QAHUknsblTxWvgqCXRhYOmQ8+0V3QMUv2+vSDWhXtQWVyz1/ryCiyFXo9B/5ehGsZ5UbLtlDzNLdRc6V5VSHxl0QLwsyyVbDYn/hORoczroysHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719575388; c=relaxed/simple;
	bh=taL4GOBsvT+8XQGDyCJPzeIPD7Qw2srQKSSDZ9+6VgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RY61h+7RaqfQ8i766v9gylqTfijkOphN1ukge8E2sftgJjnSayQUT9QyQWhuGSKMDYHc2MbieSkL04M42Ww9DQC8iYKn5VZwu2NipaunynTks8iIvyBaBLIMvfMkzJKaK0OFwcS1Vg2sv9qHaYTXR+/cpdxg3fzXLnQf3wVfHlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=KfiMMsM/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f4c7b022f8so3150335ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 04:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719575386; x=1720180186; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HH4LzaMr0mqAdzm5E26L7uIUYBJEjQsUHuIAOuMmrB0=;
        b=KfiMMsM/P03Y8+7TgN5cL1sbfQgjvJ9N/RGRIFogh24NO9cNA/vZRSTQ4SMYcQxz7T
         5xZ63wYhN8m3bFZIxo1qv096rT0irwcBfwnzaaTYZacHZUwcgQWLUfV1Uk0NhkqVzGKy
         Xn1ocY5mv6chXTVOCyxHBMI780Vse/R8X6ZQz/ZTUo0BUAva3BWSnm02gNt9/n77ZntT
         lyhj4BcNduG4uWfjUvA5IXVmNg2XT+xZ1H2NBBYPMr0Uqt6m1tq0QP9v7vGNgns/2zV6
         OxLjSwvkfBrSrVntSWVCc8pNXG0p18shLReVPbHVVYgvHIgz0o0gbc356H1nDq00Tm1E
         X1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719575386; x=1720180186;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HH4LzaMr0mqAdzm5E26L7uIUYBJEjQsUHuIAOuMmrB0=;
        b=iUzUaoROgFE/l1NhYK6LlAOuSiJvg2MGchHVvjC2bu1R5F390l4Q8NvWZgg8Ujcsfu
         cFFFy4azCnsOT2lIsN534Zg50TOIwPISzWHKrz86IYMv0GO9bm9bbUcqOe3Y1QktbZeF
         inJ0A5USidMVnc0IREMtG7ZRcURQNZLh+zrGT01ewER9rV47lFfp4qJvHVz72Qb5nqy7
         J4+qWPnmO1B0n7RFAQzyiNzwHd/f+m3LU5mO5W6f0l+heEsCAWJGp0e6Hfp73vLd79JG
         O8+TDqI6popNBqy/t3t8fpjIZG/buLrqpvYvgBAgjemBsW+xuuhGynLHp9r8diyZ/pB+
         c2xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxio35xWycZO//FZOos0fs4l27cRWlDjTHUmvVR2J7v2WtLc5KB7Ogc0/4xsaf9bXFxmINven9kBO5zMtDx36mk4WEqLDCONDV6e3Y
X-Gm-Message-State: AOJu0YxRc65NlAsnFzAmqdE4EvQrrIrxyaTrRsbsIeQCAO3ADBfYVk7L
	KxOvC5lKVtwVyaqDfcHvceXEPdj1IyqYw8IIsfXExzCZ41BPF5rqwfF+b1umKLrHLFAQ3/hR3ZA
	dN0bk/4ReOxWUSqo78Xar71RmxdmR3KDa8YyJHAoUqnPOO6nP7brdFrfBXX8HfM6o+y21SQrepQ
	Gmi5vM1AFMaZZuK9Cxxti8OpyBj78iBdGcqOjatW4U5qVm3A==
X-Google-Smtp-Source: AGHT+IHDu8SA1RMrM4zoJJjLyMPyVUMO3S5x4KKSa2ipO+ye+by9TbUq/jttoCmYWbgSnnaQg1bGzg==
X-Received: by 2002:a17:902:ccce:b0:1f7:126:5bab with SMTP id d9443c01a7336-1fa23ed509dmr174450865ad.40.1719575386170;
        Fri, 28 Jun 2024 04:49:46 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d1a82sm13530635ad.59.2024.06.28.04.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 04:49:45 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Fri, 28 Jun 2024 19:49:12 +0800
Subject: [PATCH] riscv: vector: treat VS_INITIAL as discard
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-dev-vstate_discard-v1-1-18e1c5d7997e@sifive.com>
X-B4-Tracking: v=1; b=H4sIADejfmYC/x3MQQqAIBBA0avErBPKyqyrRITkVLOxcEQC8e5Jy
 7f4PwGjJ2SYqwQeIzHdrqCtK9gv404UZItBNrJvlNTCYhSRgwm4WeLdeCuGUfdqkJPSpoMSPh4
 Pev/psub8ATW0KgBkAAAA
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
 Andy Chiu <andy.chiu@sifive.com>
X-Mailer: b4 0.13-dev-a684c

The purpose of riscv_v_vstate_discard() is to invalidate v context at
entries of syscalls. So users happen to use v after a syscall without
re-configuring would see a failure. It was achieved by setting vector
registers and CSRs to -1 and marking the context busy. However, this
results in redundant saving of v-context if the process is scheduled out
in a syscall. Moreover, restoring the invalidated context from memory is
a costly operation. In fact, all can be prevented if we can delay
vstate_discard before returning back to the user space. To be more
specific, the kernel can mark v-context as INITIAL and set the restore
flag at syscall entries. This is the indication for the vstate_restore,
so it awares that the vstate has to be invalidated before returning back
to the user space.

After applying this patch, the context switch performance has improved
6.78% on vector enabled lmbench running on a FPGA with VLEN=512. The
result was obtained by averaging the output from the following command.

$ lat_ctx 2
Before the patch: 599.8357692
After the patch: 559.1748148

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
 arch/riscv/include/asm/vector.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index be7d309cca8a..1221f8b8f564 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -170,8 +170,8 @@ static inline void riscv_v_vstate_discard(struct pt_regs *regs)
 	if ((regs->status & SR_VS) == SR_VS_OFF)
 		return;
 
-	__riscv_v_vstate_discard();
-	__riscv_v_vstate_dirty(regs);
+	set_tsk_thread_flag(current, TIF_RISCV_V_DEFER_RESTORE);
+	riscv_v_vstate_on(regs);
 }
 
 static inline void riscv_v_vstate_save(struct __riscv_v_ext_state *vstate,
@@ -186,7 +186,9 @@ static inline void riscv_v_vstate_save(struct __riscv_v_ext_state *vstate,
 static inline void riscv_v_vstate_restore(struct __riscv_v_ext_state *vstate,
 					  struct pt_regs *regs)
 {
-	if ((regs->status & SR_VS) != SR_VS_OFF) {
+	if ((regs->status & SR_VS) == SR_VS_INITIAL) {
+		__riscv_v_vstate_discard();
+	} else if ((regs->status & SR_VS) != SR_VS_OFF) {
 		__riscv_v_vstate_restore(vstate, vstate->datap);
 		__riscv_v_vstate_clean(regs);
 	}
@@ -197,7 +199,7 @@ static inline void riscv_v_vstate_set_restore(struct task_struct *task,
 {
 	if ((regs->status & SR_VS) != SR_VS_OFF) {
 		set_tsk_thread_flag(task, TIF_RISCV_V_DEFER_RESTORE);
-		riscv_v_vstate_on(regs);
+		__riscv_v_vstate_clean(regs);
 	}
 }
 

---
base-commit: 60a6707f582ebbdfb6b378f45d7bf929106a1cd5
change-id: 20240628-dev-vstate_discard-5784652968a3

Best regards,
-- 
Andy Chiu <andy.chiu@sifive.com>


