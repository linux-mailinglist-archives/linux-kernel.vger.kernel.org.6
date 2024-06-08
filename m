Return-Path: <linux-kernel+bounces-206931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AC2901002
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 09:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637711F2176F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 07:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5ED176AB7;
	Sat,  8 Jun 2024 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+wsui7z"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47E2178381
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717831947; cv=none; b=YziR9R7y/L3Kmsz/iUK1WLn+wJt3IexBYPpua16xfuHjQJgBZNIla6eJQGmajMDro0Mow5v63ozay9baoahUQ6Ef/AeGyMCj0oH0iNrGlNhlch8jZS21IpgDJAunMm6hel/MGd7CvxnF2mnzC0W6W5iF+ujdVh8YLb9z3gALgjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717831947; c=relaxed/simple;
	bh=/arA0q+ZqEDOvBVRkBmE3eeTb/jaxsKWnY2VXckEO6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FbJ2qebE2anzP33UJdu4vm7v/LENbixH/FK0diY9XgiNHMdV9Eii6bOU4JZOszGPxuYr8u8snnRKL0hAuXW4AvIkCJEb7mZPpi78yRSUIqpoAa7U8gki99ytTNWdlwRjYCz+EQiYccFA8WRPmyjdOOkAzqAxj8/mPYugdTZEU48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+wsui7z; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6efae34c83so62018466b.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 00:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717831944; x=1718436744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zc9zdoZTU2HtpSaQSQQvfOvaA8FJgHyN4TtVoE5f3Fc=;
        b=g+wsui7zS6lzX/2AUU9p7o1HJhSeVOlP+XjUEGBPNPq0Nxs7VJoDkDlauW34iYBzht
         8H6clXitPiuNS7ehLlDH+1OYFp2XKQF/VLDY10qUc9qyWWcrvt+S+2RtOPZ/4QJ/gR21
         khpb3JuFzJ/LYug3fxPYML8IueH054wZ/2wrTQnC2eL/Q51ljntnMNbm4Y5BjRefIDdG
         0wFJYkfcpbRYMfZAqafCgNDGQRDZ3fsMLC8k0gIKkWpXnuH890dgyoiYwuOSAPFYAOFi
         8meZIREdZP9vvAnfxxBNtzKaHExNhSEMpnqrpBwknZw8inKQDBY6mIMDkVuqKrtjsuXx
         1S/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717831944; x=1718436744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zc9zdoZTU2HtpSaQSQQvfOvaA8FJgHyN4TtVoE5f3Fc=;
        b=DdfsxmyBW0YuldvP2CjpcQ4R6D2EqA2DU1kiuJca1i5mXHf/WOpnE1EpBfm7XQMxC4
         mlyS5RKph56Do9a/n2yrMX+6mVv0MA2niEj8t0aztStAfGukHr59hEU7Ni919uECfaTj
         vwFJVRV/iCFMktEFO5ixp4M7bE3sHw/hPIOwFw0O8wCUiY6siTqC6epWjEPhKVk6TD6x
         6ms+jCh+/qSUJ0Qw++nYFNxDUwgcc06JAFxAA2mqMZzSpMY12TzcKyDic1obfdtfB6ZG
         2z+/vORbSacesRSrtjscaO17rzrDvwDGzEQflTS5CXNOHBbivC5RpDljo1f2CidBRBH3
         SLcg==
X-Gm-Message-State: AOJu0YwJUE6ct1m/RFVSxGMf3v91WsD57+//bNac37rKXC46K1pHdRhr
	DeOTzZMaHGNX7f6Bbb+QZaCIoB1bFGH8+YYFi+TsiseDRokkbe/WOQEH9WOB
X-Google-Smtp-Source: AGHT+IE46tGL/W1VkXbgT3VsNOGPktELmeaFc45mHs3+HXaw5xlaFTvd4SXUQ8w8Oa/ntZbOAX83FA==
X-Received: by 2002:a17:906:3556:b0:a6e:f763:1c88 with SMTP id a640c23a62f3a-a6ef7631ce7mr131817966b.37.1717831944142;
        Sat, 08 Jun 2024 00:32:24 -0700 (PDT)
Received: from kepler.. (1F2EF20A.nat.pool.telekom.hu. [31.46.242.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6efe5262cdsm61350466b.117.2024.06.08.00.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 00:32:23 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH 8/9] x86/fpu: Use 'fpstate' variable names consistently
Date: Sat,  8 Jun 2024 09:31:33 +0200
Message-ID: <20240608073134.264210-9-mingo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240608073134.264210-1-mingo@kernel.org>
References: <20240608073134.264210-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few uses of 'fps' snuck in, which is rather confusing
(to me) as it suggests frames-per-second. ;-)

Rename them to the canonical 'fpstate' name.

No change in functionality.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/fpu/api.h |  2 +-
 arch/x86/kernel/fpu/core.c     | 14 +++++++-------
 arch/x86/kernel/fpu/xstate.c   |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index f86ad3335529..708ea13ab2b0 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -139,7 +139,7 @@ static inline void fpstate_free(struct fpu *fpu) { }
 #endif
 
 /* fpstate-related functions which are exported to KVM */
-extern void fpstate_clear_xstate_component(struct fpstate *fps, unsigned int xfeature);
+extern void fpstate_clear_xstate_component(struct fpstate *fpstate, unsigned int xfeature);
 
 extern u64 xstate_get_guest_group_perm(void);
 
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index db608afa686f..6aef0116add4 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -266,16 +266,16 @@ EXPORT_SYMBOL_GPL(fpu_alloc_guest_fpstate);
 
 void fpu_free_guest_fpstate(struct fpu_guest *gfpu)
 {
-	struct fpstate *fps = gfpu->fpstate;
+	struct fpstate *fpstate = gfpu->fpstate;
 
-	if (!fps)
+	if (!fpstate)
 		return;
 
-	if (WARN_ON_ONCE(!fps->is_valloc || !fps->is_guest || fps->in_use))
+	if (WARN_ON_ONCE(!fpstate->is_valloc || !fpstate->is_guest || fpstate->in_use))
 		return;
 
 	gfpu->fpstate = NULL;
-	vfree(fps);
+	vfree(fpstate);
 }
 EXPORT_SYMBOL_GPL(fpu_free_guest_fpstate);
 
@@ -326,12 +326,12 @@ EXPORT_SYMBOL_GPL(fpu_update_guest_xfd);
  */
 void fpu_sync_guest_vmexit_xfd_state(void)
 {
-	struct fpstate *fps = x86_task_fpu(current)->fpstate;
+	struct fpstate *fpstate = x86_task_fpu(current)->fpstate;
 
 	lockdep_assert_irqs_disabled();
 	if (fpu_state_size_dynamic()) {
-		rdmsrl(MSR_IA32_XFD, fps->xfd);
-		__this_cpu_write(xfd_state, fps->xfd);
+		rdmsrl(MSR_IA32_XFD, fpstate->xfd);
+		__this_cpu_write(xfd_state, fpstate->xfd);
 	}
 }
 EXPORT_SYMBOL_GPL(fpu_sync_guest_vmexit_xfd_state);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 1f37da22ddbe..68dea76b4afc 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1392,9 +1392,9 @@ void xrstors(struct xregs_state *xstate, u64 mask)
 }
 
 #if IS_ENABLED(CONFIG_KVM)
-void fpstate_clear_xstate_component(struct fpstate *fps, unsigned int xfeature)
+void fpstate_clear_xstate_component(struct fpstate *fpstate, unsigned int xfeature)
 {
-	void *addr = get_xsave_addr(&fps->regs.xsave, xfeature);
+	void *addr = get_xsave_addr(&fpstate->regs.xsave, xfeature);
 
 	if (addr)
 		memset(addr, 0, xstate_sizes[xfeature]);
-- 
2.43.0


