Return-Path: <linux-kernel+bounces-240976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C560927535
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE371F24CDC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5491AC42F;
	Thu,  4 Jul 2024 11:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BQm5NC0+"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCDD1AC42A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 11:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720092756; cv=none; b=SgTJTbl67lIVoAAJFp/eiiKRBotsWMNpeSaIO+/D6sWHsBzK2RzKd7jskeF2NAAZic+73gkjF7w5toW+43vX5uXpfFcZQtzoP6ecDUZJnrPNOvNZy/fWeOXlbztpxaFjLIccNA8R5gZ0P3+Wes9lQ+asTAmS5ZdrQjjNkDgBEgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720092756; c=relaxed/simple;
	bh=BLi9cpRdI8r2rsx7X99fvWGZxFHNzE6du74kqz4Nejo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=bsIvFFObW0YGCfcjM7OHLSdYicO+Gu8uRmbx2hbjmR9HPyBrWQHy50HK1hqisTk89Xf0K9i6d3aJ7qh+aqvkxUHMi79V69Gi85QY9dic43CYVOE+7D5+XaWPYvPNG9AUKSkmAf4aOlgCsQJ6jfQuAj0/KhWlNWJBI93BeFScqYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BQm5NC0+; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so7138071fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 04:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720092753; x=1720697553; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OyFi9x9INtIv4d9qpzSvgmCuzNnPn55s3NPB9qeKEL8=;
        b=BQm5NC0+3r2LKWLOIdy2GnH9aUWq7jRD2ng7aSaTmuMP9xk8gTxnlrc84uQIl2Xnwm
         UiMwO8OlDJmGDmvQH74gq6bGydoF3ROVZ85XHXLguaC/ViTMVMp6XLtmG/ritSi8Fj+K
         v5npOelDZ3nGBjp9bdU5rQE/PHGyMcORoqN7D+GZ3aOj6ixKSWRuMHDICn2eGAreF9k2
         ImYYOErLt/f2MXhT5he3S1bmjeppNWbWjHLTtC2QnLL86R+M3Q2VpHF8nW+svbO5meD8
         xKfVJE75dfwoeFSvmpDgyBKK6Otha0mZE3IgXVgZ2BpcEU0tZhktvlQve3M2eRZcWXOC
         hUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720092753; x=1720697553;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OyFi9x9INtIv4d9qpzSvgmCuzNnPn55s3NPB9qeKEL8=;
        b=SPKbfzygiGWSllH8BDa5U76qniOsT4IKj8SAUwUxO6PWWdmK/tCfnYnqHi8O6t/kII
         CJUTX7bGnFdwS9h8EIGwBzzxqNsW3pZmb+520GxLmo6RjAhm2E3c7mnGzSrrT/8kHnaR
         F8bZy9xEag66A/ypSYNWbogS7st/qJl10PL0uILcT28LxHuu70sSquv2r1fYSB3HQRef
         vR/EJFB7Ylm7/rzx7rzMH6WarEr0jgRBbmgm85488eIrC1PEqKvQr2osRY/oSC1D6dC5
         3ejXkX3Z3mxN2BAhuBacm5QnowAWs3x1bCLTummxe11JhKPUHMshn0BTJSB85HQ6rIoh
         olUA==
X-Gm-Message-State: AOJu0YzUhH2cG3zCp/06lFsx7rDiglj+W8bKAJvoci+LAnTr38kY5V3a
	0wxxBkpOSyH6Df/BMgPB7vh0KtmUY2Rnxq/Qs5jMEEr3OB3Bd4Le6Re059zdnL+8iMXKQ0p/s0A
	=
X-Google-Smtp-Source: AGHT+IFFBKNUobxfeZRLGuNTCj9q1DhSbiyymcMH/RMhWkpZ+vdYGYihWQfAL4zucOkDBRlp9rCCxg==
X-Received: by 2002:a2e:8789:0:b0:2ee:8817:422d with SMTP id 38308e7fff4ca-2ee8ed69ce3mr10879491fa.5.1720092752701;
        Thu, 04 Jul 2024 04:32:32 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a93e499sm1283903a91.2.2024.07.04.04.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 04:32:32 -0700 (PDT)
Message-ID: <32f5ce15-e9e8-4351-a231-c23ebb4b083c@suse.com>
Date: Thu, 4 Jul 2024 13:32:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lkml <linux-kernel@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 the arch/x86 maintainers <x86@kernel.org>
From: Jan Beulich <jbeulich@suse.com>
Subject: [PATCH] x86/xstate: don't globally disable TILE_DATA just on its own
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In XCR0 certain bits need to be simultaneously set / clear. Since
fpu__init_cpu_xstate() wants to pass fpu_user_cfg.max_features to
XSETBV, make sure invalid values cannot end up there in case XFD is not
available. Do the clearing right for fpu_kernel_cfg.max_features (which
fpu_user_cfg.max_features is derived from), to avoid that field holding
an invalid combination of bits either.

Fixes: 2ae996e0c1a3 ("x86/fpu: Calculate the default sizes independently")
Signed-off-by: Jan Beulich <jbeulich@suse.com>
---
#GP observed in a virtualized environment with AMX enabled, but XFD off
(which is an architecturally legal combination of features, afaict).

--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -49,6 +49,9 @@
 /* Features which are dynamically enabled for a process on request */
 #define XFEATURE_MASK_USER_DYNAMIC	XFEATURE_MASK_XTILE_DATA
 
+/* Features which the above ones are tied to. */
+#define XFEATURE_MASK_USER_DYN_DEPS	XFEATURE_MASK_XTILE_CFG
+
 /* All currently supported supervisor features */
 #define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_PASID | \
 					    XFEATURE_MASK_CET_USER)
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -799,8 +799,15 @@ void __init fpu__init_system_xstate(unsi
 			fpu_kernel_cfg.max_features &= ~BIT_ULL(i);
 	}
 
-	if (!cpu_feature_enabled(X86_FEATURE_XFD))
-		fpu_kernel_cfg.max_features &= ~XFEATURE_MASK_USER_DYNAMIC;
+	if (!cpu_feature_enabled(X86_FEATURE_XFD)) {
+		/*
+		 * Besides disabling all dynamic features, also disable all
+		 * of their dependents, such that the resulting value can be
+		 * handed to XSETBV without causing #GP.
+		 */
+		fpu_kernel_cfg.max_features &= ~(XFEATURE_MASK_USER_DYNAMIC |
+						 XFEATURE_MASK_USER_DYN_DEPS);
+	}
 
 	if (!cpu_feature_enabled(X86_FEATURE_XSAVES))
 		fpu_kernel_cfg.max_features &= XFEATURE_MASK_USER_SUPPORTED;

