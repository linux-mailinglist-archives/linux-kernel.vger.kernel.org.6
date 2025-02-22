Return-Path: <linux-kernel+bounces-527432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2CEA40B1E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7606E7AD7D1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983D8214A69;
	Sat, 22 Feb 2025 19:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnVH+XDN"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAAF2147FA
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740251219; cv=none; b=pljY/wAbg/APzPycD45/gWSsXtSLE8y8JGR+bprJj2UQBH3+20ww+6ITqxzUsG7vZ4ucQQ0W8iooC2Gin3WQSGUuBEmeZ+sMoM/TOX41lrISFH88SXZ3J6rkb4Xq5Evkp6oD8SETCvyWwkbfuLCh7dhPSkd1+Vk0izAdKD1WSS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740251219; c=relaxed/simple;
	bh=xiFG5PYCkAJ25zl9pu9erSTUhptfDwvFMoWSnA5q02w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZlKdI+pGQtaEjTMmeeNXs2iqg0vnpJlTmU+8akfT8Ffkw7Guaq16kFkcL1fzdctulhi2NZPgkO8apbm0iS7NSGMt/Q9JzU6QaDLPwXgQIZajBkA4vqinE8bcxKa5OazjnVr36Ta+yC4RWmdtJOyz+MYVVk1Gqa28yF9VNjANqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnVH+XDN; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e44fda56e3so31283416d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740251215; x=1740856015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=he+DNqPCx269JMfrjm2gD6jmCJvnxgXUTS3R67Dcs3A=;
        b=GnVH+XDNOL3IeEmpfM3d0UbPnJ75bTKzfpLi5aQ1CzOK41ewd0Fr0oGCIYVMVcJjew
         tlXkEhdemG7lUsJnQ8LthiCyFafLkfLvjE+ofZpfgj/nn/ON8HS5ODiLnF1KKfwzakcH
         4rynlQBE1oGcltWJzYjtVppUz+T8/frlFXnP+lzDTpenv9l5ORgjrUF27g7wCD2iYN3M
         0JLVbAUsPFcZCO7ndGtqYXPat4HR1tFZZbi4AEB71/0BR2taMkSZHCAOleenfErY6TaS
         q2SfhREH1Iwrh6RzhXcJojcvSRlUjRMiIQmb7OazKDoHn2dpuQK/k7GS1G0uNF1hlODZ
         3LdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740251215; x=1740856015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=he+DNqPCx269JMfrjm2gD6jmCJvnxgXUTS3R67Dcs3A=;
        b=p+gF8vFLop6NronkOcGAwiXOm43by0O+HngJmgEHilPxrrqCDXMDtb+ANwbWk9U6wL
         ixjCcGHtfOlD2zBHcgLhw/FJWkfi88kVC/JhBs5PlaOLHUG/CJQb+C6oT1eHU6Nw4xBU
         Zc0e4hibyLZtgwGoY0YbJIZXNA/0wydFtMH2NxOuQF5Cz+LvVZfUqsKaBaHH/zSx/ah9
         iNFBk0IWimp+08Q4bDd/9TJbjWBWBrbD2FVbVaiep+UtkXaSra1WUoJRmCZWcFEruQHq
         r3pNKFH36M4fgfViOKdlhDteTliLNwSxUA8C5vxPabwUX9SvdeQmkq1dokWAvLdsEU5O
         EJCQ==
X-Gm-Message-State: AOJu0YwFscxvxPtLyasrSELy4yrckAX6rPkZERfmffjVgzc2e01lNMUZ
	mjWRFh184LiZ8kcebklxKJwGChsRPfmN20kezJkmoKg+htALHEq9NuM+
X-Gm-Gg: ASbGncsm1GsMJGmg9vO/6+/yyclM756o8qYNm6+PTZgKuIPNjT806i0zMzzrq09jwB7
	x+b8AFWIPMkazxJxtfWt7L6hzMh7tpZ1s14XNSkKKlF84/HY4T43SevprWgDCtH/afqjizH0xt6
	PtaeBy0yv2niyg6JAdiammLH4gCj0kMkV5DWHbxtq7+7NCmtQVgOlXEEDkVyG6qxrRPR/5mOh8q
	xJuqNlTYiqj/o2cYMpjkY1k23uUFByWHrQqRbza5rWy/uc8bGU5uPJddolHQs5VFvdxMO5q7zGS
	TG7UrW0=
X-Google-Smtp-Source: AGHT+IE+Zw8vbcCy8txGNkOqHiMVJV1xsVCjUTwbDKQuKaS7rCvCFZb8Fgewse/hVoiE6PIxb7GCXA==
X-Received: by 2002:a05:6214:cc5:b0:6e6:5a83:dcf5 with SMTP id 6a1803df08f44-6e6a264cb20mr194861376d6.21.1740251214908;
        Sat, 22 Feb 2025 11:06:54 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b1ef73b8sm550185285a.65.2025.02.22.11.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 11:06:53 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [RFC PATCH 09/11] x86/percpu: Remove pcpu_hot
Date: Sat, 22 Feb 2025 14:06:21 -0500
Message-ID: <20250222190623.262689-10-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250222190623.262689-1-brgerst@gmail.com>
References: <20250222190623.262689-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All fields have been moved to the percpu hot section.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/current.h | 11 -----------
 arch/x86/kernel/cpu/common.c   |  4 ----
 arch/x86/kernel/vmlinux.lds.S  |  1 -
 3 files changed, 16 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index 043888c258bd..b6d1adb5538f 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -12,17 +12,6 @@
 
 struct task_struct;
 
-struct pcpu_hot {
-		u8	pad[64];
-};
-static_assert(sizeof(struct pcpu_hot) == 64);
-
-DECLARE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot);
-
-/* const-qualified alias to pcpu_hot, aliased by linker. */
-DECLARE_PER_CPU_ALIGNED(const struct pcpu_hot __percpu_seg_override,
-			const_pcpu_hot);
-
 DECLARE_PER_CPU_HOT(struct task_struct *, current_task);
 /* const-qualified alias provided by the linker. */
 DECLARE_PER_CPU_HOT(struct task_struct * const, const_current_task);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index f4ec6bcb2a5e..ba78ee8fdb21 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2014,10 +2014,6 @@ static __init int setup_clearcpuid(char *arg)
 }
 __setup("clearcpuid=", setup_clearcpuid);
 
-DEFINE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot);
-EXPORT_PER_CPU_SYMBOL(pcpu_hot);
-EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
-
 DEFINE_PER_CPU_HOT(struct task_struct *, current_task) = &init_task;
 EXPORT_PER_CPU_SYMBOL(current_task);
 EXPORT_PER_CPU_SYMBOL(const_current_task);
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 3c87bb620434..0cfdaa0e05a0 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -43,7 +43,6 @@ ENTRY(phys_startup_64)
 #endif
 
 jiffies = jiffies_64;
-const_pcpu_hot = pcpu_hot;
 const_current_task = current_task;
 const_cpu_current_top_of_stack = cpu_current_top_of_stack;
 
-- 
2.48.1


