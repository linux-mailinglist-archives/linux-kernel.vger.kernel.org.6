Return-Path: <linux-kernel+bounces-542094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBCEA4C58D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D53188CBD9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8187E214A90;
	Mon,  3 Mar 2025 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bWcq469t"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317A5214A77
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016777; cv=none; b=Hwjz2qSnNNqeIVpT72cHq1minXVOaC7/KsRI3NHC+yVhwfKY61vQIcAbdBe6c2uS6H62yUXF2buONgqmI3FDDqG/Kdoenx98Uk7N92azIQ61bivSFivu0rSmThaJRMHnltOYbmpqlabO6c2qc40QMuU/WeyzTxV/I9I+zMJtWEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016777; c=relaxed/simple;
	bh=uRHVXOOGkSa8hfRoeSoSU7knCA1aK8LLB9UbK1oC8A0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A44b1aOtXI8sCNaihrvoivyd4X+6lB4VJINf3Zbr+nEp/Ls3AiAfsesMJwrZkJonFTyQeoy4YU5uO8QYIeEcS8ZWqdj62mi4OZEGTW5mwXy8jHiHindvUIH6vU43g7mScJ4776klLnKKX3C6IbqMmGOnwEkEStPBL5Tcj1fvtBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bWcq469t; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-390f365274dso1213808f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741016773; x=1741621573; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1977++wS9Q+/5+3vqWvLo8Ngdbsn/3d3T1ml+Hsnu5c=;
        b=bWcq469t1TBkuFPDygWX3dbkS46TC8h06wuTnUhqi/5qMO1yjquMhHOnY2vHQIunNe
         GU3NaIEFFi+sFJVw2r5X0UwZikiBg2nc56e0SbivA1ebKrJ7m7IY1cVcZ+X5TrkyyJBy
         Bdodl3VnHBiGQqBph0liA+Us7F9Refiol0lIF6PEqi1Jp8fdN8LKv756BUyd/CSfFgo2
         EKhWurS1Z5OhW9sHcw/RI4EP+I7+7BPWeSp5icJFsa7x494osH7tD3vxR9AREjEk8dM/
         36Id01lR9T7VWyW8LE7YaHeqbW2xCXzTZ1kh/y0dKB2MN6D1W0SFsTDEZIspcb91zkEg
         EyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741016773; x=1741621573;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1977++wS9Q+/5+3vqWvLo8Ngdbsn/3d3T1ml+Hsnu5c=;
        b=XuuNwNSlZqOgg5i4l62nkfu6OVP+NSogJXAc60vuF9VssLMWEBrG5zkqRDMFsG5EA9
         gKS2Lrxk7xkZAISHQwt/IdWlIe4PtUp/fCImZDBBzYWkQQPOovraBxJRdiu+KuSMDMLI
         s2/NWGrjnBh0Mfxwo5uN+sG6e95EBb/J5CPO1TnaLBY90JUce6D+B16bhSbpf0QFNMbI
         ElhtVl/2XZXh2qDCwimogetY+NMrfbCE82VcEtfLbcsQMLI734a+uPKlhktab94hRShI
         gCHSyR5pw4UJL0zldMyH/r1gGh3quYdLZTS01Ka4refQF4G9lW4yIgdOblj4cmwHPrmi
         q71Q==
X-Gm-Message-State: AOJu0YyPzZT+eAgGKbkPXenALygzp01+1/lkLK7V4Er78I5QsyQf7Tw8
	cqer24E/F+AD2w8gBUfKOFm1G03EuOl1LMWQkZhExGteILpjee77LkqwV8K78uXeWEU5TOy2N0Y
	UBZV2JmMvQQ==
X-Google-Smtp-Source: AGHT+IGVzP5CppYQAZHhrUVqzcIc+Ul5dt40Y0wJtWUm8nf69LMknegdfM1RvsAVRhlPsLe2P5UJqYd+gHUj5g==
X-Received: from wmqe20.prod.google.com ([2002:a05:600c:4e54:b0:43b:c7e5:66e0])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1787:b0:390:df83:1f22 with SMTP id ffacd0b85a97d-390e18d20ddmr14728105f8f.25.1741016773525;
 Mon, 03 Mar 2025 07:46:13 -0800 (PST)
Date: Mon, 03 Mar 2025 15:45:37 +0000
In-Reply-To: <20250303-setcpuid-taint-louder-v1-0-8d255032cb4c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250303-setcpuid-taint-louder-v1-0-8d255032cb4c@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250303-setcpuid-taint-louder-v1-1-8d255032cb4c@google.com>
Subject: [PATCH 1/3] x86/cpu: Remove some macros about feature names
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

These macros used to abstract over CONFIG_X86_FEATURE_NAMES, but that
was removed in commit 7583e8fbdc49 ("x86/cpu: Remove
X86_FEATURE_NAMES"). Now they are just unnecessary indirection, remove
them.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/include/asm/cpufeature.h |  5 -----
 arch/x86/kernel/cpu/common.c      | 12 ++++++------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index de88f9b4fa3bfa7477bbdf7c5efe9582e1b87b4f..7937823ded89d08e1928ad6ca60ed8d76c65387d 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -38,13 +38,8 @@ enum cpuid_leafs
 	NR_CPUID_WORDS,
 };
 
-#define X86_CAP_FMT_NUM "%d:%d"
-#define x86_cap_flag_num(flag) ((flag) >> 5), ((flag) & 31)
-
 extern const char * const x86_cap_flags[NCAPINTS*32];
 extern const char * const x86_power_flags[32];
-#define X86_CAP_FMT "%s"
-#define x86_cap_flag(flag) x86_cap_flags[flag]
 
 /*
  * In order to save room, we index into this array by doing
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0f32b6ffbf04f5394e15b50188c7d32943b0b111..b5fdaa6fd4c4ff7701009a0443ff57332503bc77 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -667,8 +667,8 @@ static void filter_cpuid_features(struct cpuinfo_x86 *c, bool warn)
 		if (!warn)
 			continue;
 
-		pr_warn("CPU: CPU feature " X86_CAP_FMT " disabled, no CPUID level 0x%x\n",
-			x86_cap_flag(df->feature), df->level);
+		pr_warn("CPU: CPU feature %s disabled, no CPUID level 0x%x\n",
+			x86_cap_flags[df->feature], df->level);
 	}
 }
 
@@ -1502,9 +1502,9 @@ static inline void parse_set_clear_cpuid(char *arg, bool set)
 
 				/* empty-string, i.e., ""-defined feature flags */
 				if (!x86_cap_flags[bit])
-					pr_cont(" " X86_CAP_FMT_NUM, x86_cap_flag_num(bit));
+					pr_cont(" %d:%d", bit >> 5, bit & 31);
 				else
-					pr_cont(" " X86_CAP_FMT, x86_cap_flag(bit));
+					pr_cont(" %s", x86_cap_flags[bit]);
 
 				if (set)
 					setup_force_cpu_cap(bit);
@@ -1523,9 +1523,9 @@ static inline void parse_set_clear_cpuid(char *arg, bool set)
 			const char *flag;
 
 			if (bit < 32 * NCAPINTS)
-				flag = x86_cap_flag(bit);
+				flag = x86_cap_flags[bit];
 			else
-				flag = x86_bug_flag(bit - (32 * NCAPINTS));
+				flag = x86_bug_flags[bit - (32 * NCAPINTS)];
 
 			if (!flag)
 				continue;

-- 
2.48.1.711.g2feabab25a-goog


