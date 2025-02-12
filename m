Return-Path: <linux-kernel+bounces-510243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02336A31A2F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 032583A862E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6BC29405;
	Wed, 12 Feb 2025 00:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YvAFwhB6"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB841EB2F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739318905; cv=none; b=mJtLUWrtD1EYaBGTgGI5cVVoTJJeqJO2JCJeYKPsoMvnGKnspLjZFwdgtMChVBdnu5xue33ozLofhniShz4Dq3uSPqjijKwQrNdBCbS9V5QN6xmS44Ol2zNewuWsUHwrXZo9ACg/TqTUsm0etlJCmUm1msHnbW52T29nNF2g5wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739318905; c=relaxed/simple;
	bh=Ry//zRj6xrQGvb+QLd5PGQ2AmxS5vbX9LInUxHl69YU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fN+ToQf3trAZsf4PifNprMzZK+66+IVPi6F6UjlVfUGnAIXmKsn109bU6Sc7PyNYYYHNsiqioio8Sy3dzmfyZ6EGUBk84UwT0BOXNzr2Aor3qoc7Ehm4x5Q/4TdQJbRJcKhEfNPiQOE23cX6x92BKnL+8zBewHgW2u+vtrc+v2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YvAFwhB6; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fa3b466245so8116624a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 16:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739318903; x=1739923703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qWVkozr8oT2oqbRq082DQxpQr7C1Te5FFbGPk2fd3qk=;
        b=YvAFwhB64JA5wiZwsx8qNLS60M8Tox7r5/9iByoBX3t6JYCycU5FqQwhttL4ZxYiK8
         FWz+hRs5Yccjg3xveJZVHKqaavqrEAuaRWPlDXG6oC19dWKlQreqNWr7nZLr1e0olaZd
         9UXx70T0t//Jwf66ZjlLmzZasFxYiHkg0G9P3pS75oy8zCgu/geCguFO4Bg9F1glfmKg
         Du7tSZ6n4Sh+Z0+e5/GL5Sdb/GfpwMUjIGg+tOQTtccsx5MQR78g9Yhcs5Nw/7AQGaPD
         gfSAY7LhhQKVyHz2au9oWBjRlU4FwoVAxHuokiPRJVwvz+8F7uGflBsBv52fS/pilShp
         ezaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739318903; x=1739923703;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWVkozr8oT2oqbRq082DQxpQr7C1Te5FFbGPk2fd3qk=;
        b=YF8+lOJ9Yk/zDgNMblOMy2aTROWco7Zmm/Id87AN1DZ353JjPd/WPcWL2vRQbnJnjk
         C0+M66bY3aNolB1wfmcWXixhY0Fh66J/RFik9bfWYs4bVTvLOz4lDaMttI+y9iDqJhXd
         GRnMVkkdyrcLgg1VYgdNIcJJlo0qr6jwd8bmoNf7I9FmshGKoNh2jRtlQL1RAM18Emsp
         /EyGKUHWxrNiVvMP0I1qqtEhLdSuugIo3vmwDaZJJ5mgfHH/oiHGnnPhDXuKIwgyaHC5
         J4TkTVclSjQdjoqLk+wGK7Kcr0sV9qGtFdAZK+cngJ3chNP3uN4DQXiV8noBQKfkZb5z
         EBQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9NaV04R1erXY5OHS/fYrF9sLo/z6JXnkX4QF9lNni6ulxSC01prAUudv93pI48Xmaw4fV5m17ycwmO34=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBa2Q6BnF1F8G91pTsYB46RrjMEgDEpo5Fdj6YPJzhL/mLMYl2
	oJRW3YRk3PAgntPs7l929bBCRtRb3kUBVdMWsqWKViZkgDhKxyydJkayoxmGi0K4Qvq2Iu4zgb6
	wvPWhisD+jqV1ae7v3w==
X-Google-Smtp-Source: AGHT+IEEYDooFC6yZwCAZXg+Qe55IRgCOFsgi1vdwniEiq9a0JjJhwh4h37DZWM3PfdySr35aQ8I4TeUG3Jg4tag
X-Received: from pjbpv10.prod.google.com ([2002:a17:90b:3c8a:b0:2f2:ea3f:34c3])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:51c6:b0:2f2:ab09:c256 with SMTP id 98e67ed59e1d1-2fbf5c6abf5mr1891723a91.33.1739318902913;
 Tue, 11 Feb 2025 16:08:22 -0800 (PST)
Date: Wed, 12 Feb 2025 00:07:47 +0000
In-Reply-To: <20250212000747.3403836-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250212000747.3403836-1-vannapurve@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212000747.3403836-5-vannapurve@google.com>
Subject: [PATCH V4 4/4] x86/tdx: Remove TDX specific idle routine
From: Vishal Annapurve <vannapurve@google.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, oupton@google.com, 
	pgonda@google.com, kirill@shutemov.name, dave.hansen@linux.intel.com, 
	linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"

With explicit dependency on CONFIG_PARAVIRT and TDX specific
halt()/safe_halt() routines in place, default_idle() is safe to execute for
TDX VMs. Remove TDX specific idle routine override which is now
redundant.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 arch/x86/coco/tdx/tdx.c    | 2 +-
 arch/x86/include/asm/tdx.h | 2 --
 arch/x86/kernel/process.c  | 3 ---
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 54baf93d9218..3578f7f7a502 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -407,7 +407,7 @@ static int handle_halt(struct ve_info *ve)
 	return ve_instr_len(ve);
 }
 
-void __cpuidle tdx_halt(void)
+static void __cpuidle tdx_halt(void)
 {
 	const bool irq_disabled = false;
 
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 393ee2dfaab1..6769d1da4c80 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -58,8 +58,6 @@ void tdx_get_ve_info(struct ve_info *ve);
 
 bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve);
 
-void tdx_halt(void);
-
 bool tdx_early_handle_ve(struct pt_regs *regs);
 
 int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport);
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index d11956a178df..9b21989c283b 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -932,9 +932,6 @@ void __init select_idle_routine(void)
 	if (prefer_mwait_c1_over_halt()) {
 		pr_info("using mwait in idle threads\n");
 		static_call_update(x86_idle, mwait_idle);
-	} else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
-		pr_info("using TDX aware idle routine\n");
-		static_call_update(x86_idle, tdx_halt);
 	} else {
 		static_call_update(x86_idle, default_idle);
 	}
-- 
2.48.1.502.g6dc24dfdaf-goog


