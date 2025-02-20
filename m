Return-Path: <linux-kernel+bounces-524734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22F4A3E676
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3016A701F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B1E1E571F;
	Thu, 20 Feb 2025 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IpdwEOo1"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45516265624
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086202; cv=none; b=VgKaBy0rZ5I2SZKX0NAKzsZ7Onz+uSeg+wi50dx1RHficC3V1wFuUj866E3xL+Nu6nsVn7kC3ddC4zo1npnoHHKXq6z/BG6KIvGvnyfsEVVnRwrlYZAhq/3o1aejV/3H/nvpGAuo7REyw7HEMe44ASDH/L5fiL5/c4M+hplGR/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086202; c=relaxed/simple;
	bh=hk5AWDB4W5UZ+6Tp1jtEm33iRhnz3QVE85inx63D63Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mr0pBAm0A10nzlQU9A/NICHzLBBoDiMbQDm8ymXV6Ge7jjresg31dj/lbPzKhRfUYlNQVHdO+gvk7BzVpHtMb37hmOjYKgPjIsDPTDQeaal8jJr+PDu2HAsIgw/a1bkJJ0FW8LtuZjjbK+FIbfoEUy+3MhlUuOrxso+Ma0uetZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IpdwEOo1; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220ec5c16e9so30750975ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740086200; x=1740691000; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=quyobmO4eU+KkdFfJQBwLa4/b8ryJDbeKM+f3W5YJ/A=;
        b=IpdwEOo1FPqx2K2x0acG7aVXrLgLVsU0cT1g2GvM/SPPr/mRNnjphip37lHMwf9hdl
         qdD/YEioDhEbjGB1PuCp6C3pAjC/kXLZ/+ARXJPivc7+SeE3Qk6HVeqB6kzxijN9aGPE
         ekQl1FvOVLoXpbar1UXdBmwr221wr4hvljWTb1dk1kAW5DZLeCzvmA+MwQZG2vtPjqkn
         BmaSHGxK3wza23TmjKpRUPKxLERyRWfBVmJy464rJvh66+uSkythyfuzcEdO99luBRwZ
         /kP1cGOGDiSEiefiROL4bG+CQy0oa6ozKi+PJIcv0G3WaQSNi66ZdSFtXyKPks/C8ysQ
         OyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740086200; x=1740691000;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=quyobmO4eU+KkdFfJQBwLa4/b8ryJDbeKM+f3W5YJ/A=;
        b=NW5fy8wfjtSEgHPQjgsRHhXtsFfzVjxoWikRrt0M7gwRU3Ve1BwWccJamPUk6xag8Y
         ImO9a0cTrNFisg9uEz3p9GaRI64s+ERrGfwdltatKYERy9OUZfBH5NHjQzrfG09A4LPM
         Yc9+ffjuAfgN4Ojs02Y+BEFZbX00DrAK92QPCNyq8GYI2gyPgwIOwcdYun/RVIPU5iad
         Dj5LsnPRmTDm996Hr52EEzPt9RBk437Jmia6yFhgI5GhwfTt7ieWZOZkpOSVJPVsxdz8
         F6/HcEpevn97T8mWK2MPMhEtALLRlaOZKahjuN3X6OcITivJpvpLj7jlpeNVpIPX1rd5
         njHA==
X-Forwarded-Encrypted: i=1; AJvYcCUnoujBYDb8u4MDpTIWT7GO4A7IS9UQ17ODg5d6qh0uOMYLWRjImOK9kU1Pn73kVlRt2dtnGjIeeMIknlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7JDFKxrjdoZxjeMz0Ye1Qq1rer/Ga+I+HMixtq4itg1YVGX5t
	Ejc+HXxIyIiSEZhNxx9EommB98yDoyDbQxK7gHg7qH5S3Qgn9o0Y+FJK0cnRsd37FlcOsPkG7cg
	i1YK8Qn3ejekQDLOCpg==
X-Google-Smtp-Source: AGHT+IFH/02hpcYpkuLearHBpYEc1K/JoFIFji35ux8Zqev6Sl2eJQqFAy9n3707vNd7DLLP/QXifjbDResJq7SG
X-Received: from pgbcw14.prod.google.com ([2002:a05:6a02:428e:b0:ad5:444f:7093])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:164e:b0:1ee:aa06:1a48 with SMTP id adf61e73a8af0-1eef52f7e0dmr496913637.22.1740086200687;
 Thu, 20 Feb 2025 13:16:40 -0800 (PST)
Date: Thu, 20 Feb 2025 21:16:28 +0000
In-Reply-To: <20250220211628.1832258-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250220211628.1832258-1-vannapurve@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250220211628.1832258-5-vannapurve@google.com>
Subject: [PATCH V5 4/4] x86/tdx: Remove TDX specific idle routine
From: Vishal Annapurve <vannapurve@google.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev
Cc: pbonzini@redhat.com, seanjc@google.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, oupton@google.com, 
	pgonda@google.com, kirill@shutemov.name, dave.hansen@linux.intel.com, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, jgross@suse.com, 
	ajay.kaher@broadcom.com, alexey.amakhalov@broadcom.com, 
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
index 16ac337df9fa..46f7bb82c8b7 100644
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
2.48.1.601.g30ceb7b040-goog


