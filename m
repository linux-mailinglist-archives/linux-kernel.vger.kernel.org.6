Return-Path: <linux-kernel+bounces-365575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890E899E489
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E4328400A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD461E907D;
	Tue, 15 Oct 2024 10:51:25 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B228B1E8830
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989485; cv=none; b=XLmgh0TftnV06FYrWAJ+fVlp3tbVmimun6axNopZucFNZ2CQcGDpcWVSm5CJJg8ZOgVqM8ln/2u0tDkt8Wnj37QiLKCti/eU4VR6auBVSHBV7StrcCFsmIWgy0DGo9r1+LlAPY8w+r/ga1dyQzDIKIbDqC3X9VLchGL+K/VL3g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989485; c=relaxed/simple;
	bh=noKDIv0h7Ynv810imGOXTcEg1IQAlLRsP4VhEHZUHOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpzXIDJ5IRofYimZu3FCdQecMnKkpSjmsEyRMZpogdFTnG7b2TXCeJMVM8cGDjBIYqwgQzGHwn8HRnJKdYuy8AXPXyfVrXHyxBKsEOUELR9zEGd3h83lyu4+ntdONLmlNtgxvI7ZRXDnZpaQ3h8j+Bf2WuGexwYpI4ZvDyNAPhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso2664358e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728989482; x=1729594282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icEUaeGE3WMkx6ZfDT6djzDVF/cO+oPPN/8W1btpyhI=;
        b=Clww0QyKN3m5aMFJPijDUw0VdaG8l9Ex3uXJYmSpB86WeV0bfpiqCQ1kBQkv/7LX2E
         C29qOKJW/Y2HtGPum6/aJI6A34FysuyFzvU5S2w31LvkzuHsX6yLOridHEWj6J/YzlMh
         3ujQArio5OxRqaK4YszgJ2vunP15q1FLETrAhdMzEbXSj53x7jZW4pM1wc/dUZ2uyGYm
         IcHVt+KEdXIQsM/875F7Ili5OEYEinzFLriCk+7BEDNKhhYGBnZYFvzLaE+uG3eohtVL
         QV353pDOonvCrU4ZLXsc2MyrEFz5GYRnr5Pjg34vYmSRw/2tydyHQaYX6vu3suwrvBvz
         5wDA==
X-Forwarded-Encrypted: i=1; AJvYcCXz/1RwMJZWvUdSiWjKBIyJL2/85fETO7KdwkJmCGhGSAcccjKKglkbJLMmSQ7iKIatdZpqEsz5Flq/p0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YykjFeF9ZAFdpaTOPBkarZc0GVbuOdMnOct+GVu9zs2Y9NIqZrq
	GPIEOahVQH4ZdtcwXYPZkcEuko2K7stuRCzpNGQt7zVIMDiOiqNA
X-Google-Smtp-Source: AGHT+IF0OuV2qhV2mSH72m35MPN1Rq40TLgvgJeV1aeG7yeagMUM9BETj9YDa2vmdJieEV8Gk/yyfg==
X-Received: by 2002:a05:6512:10d1:b0:532:c197:393e with SMTP id 2adb3069b0e04-539e54d7ba7mr4799747e87.11.1728989481381;
        Tue, 15 Oct 2024 03:51:21 -0700 (PDT)
Received: from localhost (fwdproxy-lla-112.fbsv.net. [2a03:2880:30ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6c6464sm14062525e9.46.2024.10.15.03.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 03:51:20 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: bp@alien8.de,
	x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86/bugs: Use cpu_smt_possible helper
Date: Tue, 15 Oct 2024 03:51:05 -0700
Message-ID: <20241015105107.496105-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241015105107.496105-1-leitao@debian.org>
References: <20241015105107.496105-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a helper function to check if SMT is available. Use this helper
instead of performing the check manually.

The helper function cpu_smt_possible() does exactly the same thing as
was being done manually inside spectre_v2_user_select_mitigation().
Specifically, it returns false if CONFIG_SMP is disabled, otherwise
it checks the cpu_smt_control global variable.

This change improves code consistency and reduces duplication.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/kernel/cpu/bugs.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d1915427b4ff..6d3b61d7be9c 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1315,16 +1315,11 @@ static void __init
 spectre_v2_user_select_mitigation(void)
 {
 	enum spectre_v2_user_mitigation mode = SPECTRE_V2_USER_NONE;
-	bool smt_possible = IS_ENABLED(CONFIG_SMP);
 	enum spectre_v2_user_cmd cmd;
 
 	if (!boot_cpu_has(X86_FEATURE_IBPB) && !boot_cpu_has(X86_FEATURE_STIBP))
 		return;
 
-	if (cpu_smt_control == CPU_SMT_FORCE_DISABLED ||
-	    cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
-		smt_possible = false;
-
 	cmd = spectre_v2_parse_user_cmdline();
 	switch (cmd) {
 	case SPECTRE_V2_USER_CMD_NONE:
@@ -1385,7 +1380,7 @@ spectre_v2_user_select_mitigation(void)
 	 * so allow for STIBP to be selected in those cases.
 	 */
 	if (!boot_cpu_has(X86_FEATURE_STIBP) ||
-	    !smt_possible ||
+	    !cpu_smt_possible() ||
 	    (spectre_v2_in_eibrs_mode(spectre_v2_enabled) &&
 	     !boot_cpu_has(X86_FEATURE_AUTOIBRS)))
 		return;
-- 
2.43.5


