Return-Path: <linux-kernel+bounces-321380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D63EC9719D2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80FDA1F234EC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DC61B9B46;
	Mon,  9 Sep 2024 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vod4ssiG"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AEE1B9B2B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886057; cv=none; b=Vb84aEv8jOIrTtG+aQKvNCKd4EB4nEdnql1iAyVUb6YT3w7s2pgtYruljHmCp1ClcYvJ1i75BGswamTVvLLT3218abIM+XBfIr6CYRF3JEXnQZMwbCODqSnxGfj0G73shXcVT90SuDJbha8a76lKNcTjvzfNToVKaBnhPVGF9tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886057; c=relaxed/simple;
	bh=zuE6bjdcg3jxewdqHSkBJadxfnaCAk197XNJPJ4G1wA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FfBOoiKSGMWazOClhTC6yUobtemKrles4Cs+IpjTLjC5L6QdPiHog0Cpf7Q8HNDLNpRl+9HkMn0wn9Pb+n+Yz28TUlwskKGF+utSfI/PLYg4B13dCo/wz4ekK1iVsSl38v2RhSVAKb7f68r8NqEPLL7h8gOOeFgs3Dl7Hc1kPGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vod4ssiG; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-42cb0ed9072so15264155e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 05:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725886054; x=1726490854; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8qvkXCdHWEWBsZylsWm6hwfThTp5oWOCgEDtNeKXpl8=;
        b=Vod4ssiGW/aREMfcE+5dHsYhPXyWRbDQBF/NGNG2aO6PNcZbXTyV/Kw3yw3P8suDTc
         xPF3r21HdyJ/08j5yXsdt8F2OpXTGEOwMwMiu0q1HqFo/gkLGGIno3nQ2rh2yjIAWY9G
         C0l6tyhY4gNJ/LMteYU8QXoK9papIrD8MlsW11arxNLvTREpIxIygiGQglwsZD12L5Vm
         dgXYkpJjCkR45xD73i+YD0lZuBxf3nd5+NpetZtz5/94CqmuS+ZbKphC/KnJEV3Sp0t+
         pIQ9fPEx0Nt50J63R5fFZSp/1I2UJGo7cZoo2stTYjZHdH7wqWV9RXPiOVpQDCLfg+iH
         QKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725886054; x=1726490854;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8qvkXCdHWEWBsZylsWm6hwfThTp5oWOCgEDtNeKXpl8=;
        b=W2HLf25XH2ou7dsTeTwDZsO/EI7nI/ATuafTJ7JPMY6X1PFfyLzzXf3/NvisjfxQd1
         F/WpaQlfYyEI3uBT+7sXaLmf4dhtr1ULcnFzPg6GQ8UKivaO2hamvR6XgzmHlrrPHIc7
         2YyVkbKGVrpSZuKaKEJLvR2kOfSMKHvL1txkV4/VAK36B32/W7QVmPC4AHP19eqzX5ps
         9IN1FMegBEJOve85wSeXA+dg6lquj7+cCfYKWWA79DTOOcHOnHJvMS9muXwcLd7tLjH3
         XyMwQWHtvzQIqxZ9QZIHGEmFU1YINj5320bOZAxiLgoLfH4sRdgInmy+bZUYUZ72RYnn
         yzEg==
X-Forwarded-Encrypted: i=1; AJvYcCUva9awfylPuyY6cE8KqaHLsQBHm4JpGD/suMBsq8R/xN6Lyr5aFcM7V+iJaS/h9gBCfEXwpg4GaPgvPFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC44U45fdpuWPsQSWeHz4h/bTqtCm39/c9YWiCKIjDYbY+eiD1
	YNTO1nk1kxjEGmyuDX1pPMU034pyfzEJTvz+bjUp+zFgKH6FXcOqNop0fyn11MnKsOUPYwVu6W2
	+CUKEYDPydqHDRgFJ7uDVR+XxWw==
X-Google-Smtp-Source: AGHT+IHXNUAE7VdC5OTZOKpQ5J1caGnUk0ojDWhw1KiR9y5AZtlPfQlw2THkS+FmwEps5TC/2oefb8PtdRKpmxLL8Qc=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:68:fe9:ac10:f1b7])
 (user=sebastianene job=sendgmr) by 2002:adf:f4d0:0:b0:374:badb:3cc0 with SMTP
 id ffacd0b85a97d-3788969b893mr13963f8f.9.1725886054280; Mon, 09 Sep 2024
 05:47:34 -0700 (PDT)
Date: Mon,  9 Sep 2024 12:47:20 +0000
In-Reply-To: <20240909124721.1672199-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240909124721.1672199-1-sebastianene@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240909124721.1672199-5-sebastianene@google.com>
Subject: [PATCH v10 4/5] arm64: ptdump: Don't override the level when
 operating on the stage-2 tables
From: Sebastian Ene <sebastianene@google.com>
To: akpm@linux-foundation.org, alexghiti@rivosinc.com, ankita@nvidia.com, 
	ardb@kernel.org, catalin.marinas@arm.com, christophe.leroy@csgroup.eu, 
	james.morse@arm.com, vdonnefort@google.com, mark.rutland@arm.com, 
	maz@kernel.org, oliver.upton@linux.dev, rananta@google.com, 
	ryan.roberts@arm.com, sebastianene@google.com, shahuang@redhat.com, 
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Ptdump uses the init_mm structure directly to dump the kernel
pagetables. When ptdump is called on the stage-2 pagetables, this mm
argument is not used. Prevent the level from being overwritten by
checking the argument against NULL.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/mm/ptdump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index ca53ef274a8b..264c5f9b97d8 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -197,8 +197,8 @@ void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 	u64 prot = 0;
 
 	/* check if the current level has been folded dynamically */
-	if ((level == 1 && mm_p4d_folded(st->mm)) ||
-	    (level == 2 && mm_pud_folded(st->mm)))
+	if (st->mm && ((level == 1 && mm_p4d_folded(st->mm)) ||
+	    (level == 2 && mm_pud_folded(st->mm))))
 		level = 0;
 
 	if (level >= 0)
-- 
2.46.0.469.g59c65b2a67-goog


