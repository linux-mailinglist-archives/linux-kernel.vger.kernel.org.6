Return-Path: <linux-kernel+bounces-203398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8CB8FDA4D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4430B1C23182
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B956171065;
	Wed,  5 Jun 2024 23:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iMGJWMAT"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026F816E878
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 23:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717629575; cv=none; b=FhU9sr+hMXuglpcxQeFSPQmFy5XnFhTLJrcRZ1ewW8ZabOWUCSw8WdGcrXPQnJk39kHgDfd8U8x+wI7vP+T8MsaGtxM1zCkUtOXLkwlH0li9BPx+2XuMRqfnxZni3tZcXp4NjX0ojty+jk/7zcZ66F0NbQGxHZp7WWIujQY7JHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717629575; c=relaxed/simple;
	bh=FRu/kZatnQdr9XzHy/g1OUjfeBWGEavtPQGcyQPsq5Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e+9GWROayai0pZNa12KX1eXjpX2bSysScF7/HKkHclo6yiByQCbntZbQqcJ+fv5QrFEeJYejk1c3ldcvNBDNkKHs9uFomYctfd0ZGYcyBpNZ4vw/JosSU2y9fcEZXfmtj9QJqctwGhsVrX49W1OxMpBY/bUaMFOiGfMktUeuFJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iMGJWMAT; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-68196e85d64so223287a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 16:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717629573; x=1718234373; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pvvZ8DaNbDzOA56vK/6BLcIWihuQnHvhNAp4+dw9cQU=;
        b=iMGJWMATggWfHjoOT9DVXxedxK6LCc4djxkDQmeSaBE2j0hnR3XLQ3HJdhxYzjUVwE
         iHLllx1JZcMZpjJFGSjbzO4pgadCMFeR1iipCDJ/xcuQEQdUXl23oVF19S+q9SqdUjwc
         A8uOTDqeMsXnGJnXQISU1klzpqkY7A4Ds65o1Tvju5Uv1E2t3ONOOMsG4dgaxq75Ms8o
         e8TithXEA1WLywI8HbDDheBUtMV/P6Fi194QrXMu9jjAP957MXUE6dFcc+cPOOHyQLVG
         Q3n62eqnbhrwsE9T6L1isWNdkSdIXjLdFvz5irilZ8UP93ZvKtaZ1k15t129qkULcok9
         azcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717629573; x=1718234373;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pvvZ8DaNbDzOA56vK/6BLcIWihuQnHvhNAp4+dw9cQU=;
        b=ubjuArhCgD5zDR89FMTCXNPM7u1xfG09PIZozAza5rYMlIZKeSAEHV4v4sVVZ81qau
         sO5UdCNTr3DYLwfSU5It6qW7lhovpBrvKNlxOzGWTw8Kf5S818gaceYK7wq4b4zA9EdC
         GZb/JILGF5FEObUEf2xCBlCPybitndTW51JF7CsBwv1emFTZxYkFunuT+A1JaCq8+MDe
         wHbpPrTapbTiy4vjBG+m/JfRDykjBI/r59fw5ngUs3mHrJKfRMjbNL62aeVKZ2ZZjDsf
         wJa2Ixy1ZvwyxESZOk5NlVuG63tNK/ju1NoP9900FnvLfm93Su7boJicapoK5TZirJdd
         dDbQ==
X-Gm-Message-State: AOJu0Ywr5imKZB/oOIqtZBT1MyItjx/yWzo54LZbK3cJiz1d1lrlcr9N
	l15FfG2HEkH+OEkEFD9QXW/LjjUyU8dLw3ufBl6MKqDslle1S/x30eacB6bvB53eESPkU+4LJ8u
	C/w==
X-Google-Smtp-Source: AGHT+IHOil81jTTKEkgMi93RtvAaNFM2ic8gL0rWPxlBlpOJz0HjG3ROR/xU+gQkDYAzR5CBOZFKc/dmHMM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ec81:b0:1f6:8033:f361 with SMTP id
 d9443c01a7336-1f6a5a12dcbmr362625ad.6.1717629573132; Wed, 05 Jun 2024
 16:19:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  5 Jun 2024 16:19:14 -0700
In-Reply-To: <20240605231918.2915961-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240605231918.2915961-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240605231918.2915961-7-seanjc@google.com>
Subject: [PATCH v8 06/10] KVM: nVMX: Use macros and #defines in vmx_restore_vmx_basic()
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Jim Mattson <jmattson@google.com>, Shan Kang <shan.kang@intel.com>, Xin Li <xin3.li@intel.com>, 
	Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Xin Li <xin3.li@intel.com>

Use macros in vmx_restore_vmx_basic() instead of open coding everything
using BIT_ULL() and GENMASK_ULL().  Opportunistically split feature bits
and reserved bits into separate variables, and add a comment explaining
the subset logic (it's not immediately obvious that the set of feature
bits is NOT the set of _supported_ feature bits).

Cc: Shan Kang <shan.kang@intel.com>
Cc: Kai Huang <kai.huang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
[sean: split to separate patch, write changelog, drop #defines]
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 3bd6c026f192..6402def985af 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1250,21 +1250,32 @@ static bool is_bitwise_subset(u64 superset, u64 subset, u64 mask)
 
 static int vmx_restore_vmx_basic(struct vcpu_vmx *vmx, u64 data)
 {
-	const u64 feature_and_reserved =
-		/* feature (except bit 48; see below) */
-		BIT_ULL(49) | BIT_ULL(54) | BIT_ULL(55) |
-		/* reserved */
-		BIT_ULL(31) | GENMASK_ULL(47, 45) | GENMASK_ULL(63, 56);
+	const u64 feature_bits = VMX_BASIC_DUAL_MONITOR_TREATMENT |
+				 VMX_BASIC_INOUT |
+				 VMX_BASIC_TRUE_CTLS;
+
+	const u64 reserved_bits = GENMASK_ULL(63, 56) |
+				  GENMASK_ULL(47, 45) |
+				  BIT_ULL(31);
+
 	u64 vmx_basic = vmcs_config.nested.basic;
 
-	if (!is_bitwise_subset(vmx_basic, data, feature_and_reserved))
+	BUILD_BUG_ON(feature_bits & reserved_bits);
+
+	/*
+	 * Except for 32BIT_PHYS_ADDR_ONLY, which is an anti-feature bit (has
+	 * inverted polarity), the incoming value must not set feature bits or
+	 * reserved bits that aren't allowed/supported by KVM.  Fields, i.e.
+	 * multi-bit values, are explicitly checked below.
+	 */
+	if (!is_bitwise_subset(vmx_basic, data, feature_bits | reserved_bits))
 		return -EINVAL;
 
 	/*
 	 * KVM does not emulate a version of VMX that constrains physical
 	 * addresses of VMX structures (e.g. VMCS) to 32-bits.
 	 */
-	if (data & BIT_ULL(48))
+	if (data & VMX_BASIC_32BIT_PHYS_ADDR_ONLY)
 		return -EINVAL;
 
 	if (vmx_basic_vmcs_revision_id(vmx_basic) !=
-- 
2.45.1.467.gbab1589fc0-goog


