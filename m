Return-Path: <linux-kernel+bounces-430974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DAD9E37B2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E1A285F1B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECD71AF0CD;
	Wed,  4 Dec 2024 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exostellar.io header.i=@exostellar.io header.b="j+g49PD+"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F6D2B9B7
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308646; cv=none; b=etG8/u4i7ePm/nxmESmJ/cqOTMtxHlwesVc7ENQmSxRxWP9/5h5jKyIlP3ugYgfZf34QaX1b0JKXECLp76fvjMWlrVdjgDh8oDFzH1PyG5NyFS/fmg7bCXrFbNCOnmDfZz8dvvNKsmvnL1gGNx+fSmAYzU/U4zB2LpOswSsnE8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308646; c=relaxed/simple;
	bh=k2PPOVMqVv7byef6x7iqEdVTlhX2SFXnJ8/dx+rXx8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VuY08TdNn9w9RJLjRi7gMfPTeyhUENIpfhb5S5LMqXEvdNF0dyZqfjsHfjLwIfpJEIPaozeMqasxmL3HaAvgK5GcYCwVWTfxtg7f0+efb3yjqw81cb0OApKU3+OnIIWIFX/bHsetJvUB9+Z/FpdxbofPH/Cpa5FoT1b9EagpWhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exostellar.io; spf=pass smtp.mailfrom=exostellar.io; dkim=pass (2048-bit key) header.d=exostellar.io header.i=@exostellar.io header.b=j+g49PD+; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exostellar.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exostellar.io
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b678da9310so520163685a.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 02:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exostellar.io; s=google; t=1733308643; x=1733913443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UKZBElfC/runRO3THcVur0T/wfu1RwMrcL6FtcVDe5Y=;
        b=j+g49PD+JpyUGAAz7oZjbBukf6nB5uEvnKC4/EzpLLjX+xcxom3Ar5+V7fUL1fV9BO
         kAwlUiANlfxzPudnTwIeANF0O0+4Qvw4N4/Rae4dItqV6HbvdruAC1SXP31Td0yaUkps
         Wb4n2lMB7vSKllFP1GRRNbzvkAdi4/2s8BOupB93GsaccUZImlWdM0wPh5ZVwsxiykWy
         ajlfifhO778Ufc71xugkxMl8L5ONl4qVJVgxeP4RJdbhT5xAZAK4h4SuRIBGshZJe0Wp
         9/pnDRGJPE2pmQgpZjBLkSc6VxpAC0Ajsv96Q5rWTdvCZQsod2OB+nS/OJU+TyqcEjBW
         jgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733308643; x=1733913443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKZBElfC/runRO3THcVur0T/wfu1RwMrcL6FtcVDe5Y=;
        b=f+5WHmxnEKGKGVdbrEoMS7YvxI+MMEBPCutVgF4XizXK7ypKK6s1jvPuxbSYB05Fw6
         Cb21Q27tWRyle4OA/QSICbFL2+pkkHvUjzqJU5Q7brsuCo655qOuwJPZvJQ0tMamKTZD
         hcrHy3JWHfHIKp2hTQcVO5mXc8BSczbZcQkb4fT/CYXh87JWCqjJB/TimNcIvfgWAhrV
         8HwlkUm3UeTTVWpGBm5Q6pwfAY9CSD7cTJvxX2I0evV8h3cqnAMGy4eaeKm25VJJtBny
         MT3LoEeYCBgb3qmwD2VuLPQO51396EFwpyp6Xs7vJHOcDMKDKFWREOXRhWUsVKt15YHx
         aJjA==
X-Forwarded-Encrypted: i=1; AJvYcCW2sLAEWFbyKwSCMRJUbZUkHy4XQBjzHXVhGLjyX2ySMGqTheT+/2yIozn5dOEMVe95khE8IeGWh/7jSxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkAjMaRlrM0n0QAjWYG7wxlnujALhaUpZBYUqwgfHuEAyclCDy
	oedmxqlyDAm+lwd9mjDCPayjAS2GDeFGOllfSBcjGxqQX491qjvBFoEGiHrNLEs=
X-Gm-Gg: ASbGncsWgsa5UxPJPxvR89PMYTyJZMq80cPbzvrX0lKFPsPORMKkoBu1r2r2C37VVYI
	OWImMmldZAawUrgumFlbMiHdGIcP7ntqN5AqxMTQqOaaqFZExzz6ldckn2JhGYO2Wx9ua0rRu2p
	kwPmw8dt6Z2HI/n5qeapykudNTjxk+P/kWiYd4v3BZSGJOuOkUTHcDol9m1cOKi0bF4AJGHkwC0
	t6HVQ8RvLhKRnl4ecNmGGJv1mcrgGDIx2XPhNBTlSwWUaZNO0f5
X-Google-Smtp-Source: AGHT+IFzj1Z+lwW7ef4Zyi/r9kehnRmxvWWd7pNR8/zIhzo8RWZkM08u76l5FSHquIrCZJ6GngUFjA==
X-Received: by 2002:a05:620a:1724:b0:7b1:522a:b07 with SMTP id af79cd13be357-7b6a61cc099mr1057430985a.61.1733308643628;
        Wed, 04 Dec 2024 02:37:23 -0800 (PST)
Received: from jupiter.home ([188.91.253.160])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5997ffc1bsm714073566b.83.2024.12.04.02.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:37:22 -0800 (PST)
From: Maksym Planeta <maksym@exostellar.io>
To: Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Maksym Planeta <maksym@exostellar.io>,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Grab mm lock before grabbing pt lock
Date: Wed,  4 Dec 2024 11:35:15 +0100
Message-ID: <20241204103516.3309112-1-maksym@exostellar.io>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Function xen_pin_page calls xen_pte_lock, which in turn grab page
table lock (ptlock). When locking, xen_pte_lock expect mm->page_table_lock
to be held before grabbing ptlock, but this does not happen when pinning
is caused by xen_mm_pin_all.

This commit addresses lockdep warning below, which shows up when
suspending a Xen VM.

[ 3680.658422] Freezing user space processes
[ 3680.660156] Freezing user space processes completed (elapsed 0.001 seconds)
[ 3680.660182] OOM killer disabled.
[ 3680.660192] Freezing remaining freezable tasks
[ 3680.661485] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[ 3680.685254]
[ 3680.685265] ==================================
[ 3680.685269] WARNING: Nested lock was not taken
[ 3680.685274] 6.12.0+ #16 Tainted: G        W
[ 3680.685279] ----------------------------------
[ 3680.685283] migration/0/19 is trying to lock:
[ 3680.685288] ffff88800bac33c0 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: xen_pin_page+0x175/0x1d0
[ 3680.685303]
[ 3680.685303] but this task is not holding:
[ 3680.685308] init_mm.page_table_lock
[ 3680.685311]
[ 3680.685311] stack backtrace:
[ 3680.685316] CPU: 0 UID: 0 PID: 19 Comm: migration/0 Tainted: G        W          6.12.0+ #16
[ 3680.685324] Tainted: [W]=WARN
[ 3680.685328] Stopper: multi_cpu_stop+0x0/0x120 <- __stop_cpus.constprop.0+0x8c/0xd0
[ 3680.685339] Call Trace:
[ 3680.685344]  <TASK>
[ 3680.685347]  dump_stack_lvl+0x77/0xb0
[ 3680.685356]  __lock_acquire+0x917/0x2310
[ 3680.685364]  lock_acquire+0xce/0x2c0
[ 3680.685369]  ? xen_pin_page+0x175/0x1d0
[ 3680.685373]  _raw_spin_lock_nest_lock+0x2f/0x70
[ 3680.685381]  ? xen_pin_page+0x175/0x1d0
[ 3680.685386]  xen_pin_page+0x175/0x1d0
[ 3680.685390]  ? __pfx_xen_pin_page+0x10/0x10
[ 3680.685394]  __xen_pgd_walk+0x233/0x2c0
[ 3680.685401]  ? stop_one_cpu+0x91/0x100
[ 3680.685405]  __xen_pgd_pin+0x5d/0x250
[ 3680.685410]  xen_mm_pin_all+0x70/0xa0
[ 3680.685415]  xen_pv_pre_suspend+0xf/0x280
[ 3680.685420]  xen_suspend+0x57/0x1a0
[ 3680.685428]  multi_cpu_stop+0x6b/0x120
[ 3680.685432]  ? update_cpumasks_hier+0x7c/0xa60
[ 3680.685439]  ? __pfx_multi_cpu_stop+0x10/0x10
[ 3680.685443]  cpu_stopper_thread+0x8c/0x140
[ 3680.685448]  ? smpboot_thread_fn+0x20/0x1f0
[ 3680.685454]  ? __pfx_smpboot_thread_fn+0x10/0x10
[ 3680.685458]  smpboot_thread_fn+0xed/0x1f0
[ 3680.685462]  kthread+0xde/0x110
[ 3680.685467]  ? __pfx_kthread+0x10/0x10
[ 3680.685471]  ret_from_fork+0x2f/0x50
[ 3680.685478]  ? __pfx_kthread+0x10/0x10
[ 3680.685482]  ret_from_fork_asm+0x1a/0x30
[ 3680.685489]  </TASK>
[ 3680.685491]
[ 3680.685491] other info that might help us debug this:
[ 3680.685497] 1 lock held by migration/0/19:
[ 3680.685500]  #0: ffffffff8284df38 (pgd_lock){+.+.}-{3:3}, at: xen_mm_pin_all+0x14/0xa0
[ 3680.685512]
[ 3680.685512] stack backtrace:
[ 3680.685518] CPU: 0 UID: 0 PID: 19 Comm: migration/0 Tainted: G        W          6.12.0+ #16
[ 3680.685528] Tainted: [W]=WARN
[ 3680.685531] Stopper: multi_cpu_stop+0x0/0x120 <- __stop_cpus.constprop.0+0x8c/0xd0
[ 3680.685538] Call Trace:
[ 3680.685541]  <TASK>
[ 3680.685544]  dump_stack_lvl+0x77/0xb0
[ 3680.685549]  __lock_acquire+0x93c/0x2310
[ 3680.685554]  lock_acquire+0xce/0x2c0
[ 3680.685558]  ? xen_pin_page+0x175/0x1d0
[ 3680.685562]  _raw_spin_lock_nest_lock+0x2f/0x70
[ 3680.685568]  ? xen_pin_page+0x175/0x1d0
[ 3680.685572]  xen_pin_page+0x175/0x1d0
[ 3680.685578]  ? __pfx_xen_pin_page+0x10/0x10
[ 3680.685582]  __xen_pgd_walk+0x233/0x2c0
[ 3680.685588]  ? stop_one_cpu+0x91/0x100
[ 3680.685592]  __xen_pgd_pin+0x5d/0x250
[ 3680.685596]  xen_mm_pin_all+0x70/0xa0
[ 3680.685600]  xen_pv_pre_suspend+0xf/0x280
[ 3680.685607]  xen_suspend+0x57/0x1a0
[ 3680.685611]  multi_cpu_stop+0x6b/0x120
[ 3680.685615]  ? update_cpumasks_hier+0x7c/0xa60
[ 3680.685620]  ? __pfx_multi_cpu_stop+0x10/0x10
[ 3680.685625]  cpu_stopper_thread+0x8c/0x140
[ 3680.685629]  ? smpboot_thread_fn+0x20/0x1f0
[ 3680.685634]  ? __pfx_smpboot_thread_fn+0x10/0x10
[ 3680.685638]  smpboot_thread_fn+0xed/0x1f0
[ 3680.685642]  kthread+0xde/0x110
[ 3680.685645]  ? __pfx_kthread+0x10/0x10
[ 3680.685649]  ret_from_fork+0x2f/0x50
[ 3680.685654]  ? __pfx_kthread+0x10/0x10
[ 3680.685657]  ret_from_fork_asm+0x1a/0x30
[ 3680.685662]  </TASK>
[ 3680.685267] xen:grant_table: Grant tables using version 1 layout
[ 3680.685921] OOM killer enabled.
[ 3680.685934] Restarting tasks ... done.

Signed-off-by: Maksym Planeta <maksym@exostellar.io>
---
 arch/x86/xen/mmu_pv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 55a4996d0c04..2c70cd35e72c 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -781,6 +781,7 @@ void xen_mm_pin_all(void)
 {
 	struct page *page;
 
+	spin_lock(&init_mm.page_table_lock);
 	spin_lock(&pgd_lock);
 
 	list_for_each_entry(page, &pgd_list, lru) {
@@ -791,6 +792,7 @@ void xen_mm_pin_all(void)
 	}
 
 	spin_unlock(&pgd_lock);
+	spin_unlock(&init_mm.page_table_lock);
 }
 
 static void __init xen_mark_pinned(struct mm_struct *mm, struct page *page,
@@ -887,6 +889,7 @@ void xen_mm_unpin_all(void)
 {
 	struct page *page;
 
+	spin_lock(&init_mm.page_table_lock);
 	spin_lock(&pgd_lock);
 
 	list_for_each_entry(page, &pgd_list, lru) {
@@ -898,6 +901,7 @@ void xen_mm_unpin_all(void)
 	}
 
 	spin_unlock(&pgd_lock);
+	spin_unlock(&init_mm.page_table_lock);
 }
 
 static void xen_enter_mmap(struct mm_struct *mm)
-- 
2.42.0


