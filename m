Return-Path: <linux-kernel+bounces-361873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3434399AE31
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26371F21569
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A2A1D1E77;
	Fri, 11 Oct 2024 21:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e1GFP2zs"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24CC1D1753
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 21:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728683065; cv=none; b=NzfGGd+CIrCOQlqO4/rLwNAbbY8so5gJfCio572wfSQ0CZx7o6AY9a8AQr5AR+54Vqxe2L+2eBE9IsrcG3FGSNZPLHizR3zdCcvBEaSRV6+Ao/e/YBVqutlcDCgnCU3DIDe8fwgaguNJmtgNNgDYJbvG/je2piNj/FBpKcwfyAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728683065; c=relaxed/simple;
	bh=FySfe5RrrfJjXgO8V1GOxagEYmAWMeDCEI02fIbT6Cw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZUBroqETbo9Z2TO/nHC8DMeYb4c7La1jbSzJSDHlrGLD+8X22v+ab5tk/XagrwrotZ+pAMFuw6VNWY90b9IUwaCDANvZjtc8ASOhZaDsG50tXMNUcVZE+hogluww6WmSTyG+spQLxo+wioJjYKDs6DM72TZrsDSl8rLXfaDhKTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e1GFP2zs; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-71e00c8adf9so2583083b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728683063; x=1729287863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7BzS7UcNh/RHQXZP7p5KB3mv/Z/fAaS/j1ugPEdV3OM=;
        b=e1GFP2zs+OF3N2lrWLB4XE468pn3R9m/dMTsdIDZtFHvWT/Bfoq1+PxTXnB9vT1lEa
         NVryKd+sdIYjs6QGGEnG1aMX8K+vGfKHPSs1izweNonB8RzPO0q605OPngCEMehDUu14
         C7w6pAm5P0KJstL3kFFLC6YpPJmVaSTvspcN9WI53ITdD10Yw7lgnE7yJb5oITeGoZ+C
         FTaSvowdQP6LaqS9UFzwM9YO0/VRPzyLIOIPraHecnZgW36c+4xh53iuo3zJyniyIMPs
         W4GB7nrTCNnkEwe2p1ZGETlkz820hZeoK1VEiMaF79v7nx3tH/6+JlR2UTXX7qNz9Hba
         Zb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728683063; x=1729287863;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7BzS7UcNh/RHQXZP7p5KB3mv/Z/fAaS/j1ugPEdV3OM=;
        b=FZ5+zRoAyH7GiFUp93xAhbANHMgR6SxIqD8hN+os1UPtSXinPBmbHMGkcbvh8uAFYo
         EiyVR0rSxQM3ueS8xxQ2MAIYZgOt7gE4/89wE6XtenMevuCVdpObmjmvf9mHF/98RltU
         iH3f433GxmVpufuQE+66nuNpbCvNQKCT6UmNL3Qs/Rdy20RCSfD+sZG+FyRD+BnSpJno
         icrluHgoURNPjbWWjSyR4RT4TK+5Y8ixZR9GJ2tL+PC5lxMUWaxEZfDA5EUVAWAsJt8c
         U8kVv4ZZ/lgenimNmtn7DEADvDUpxbA5vYi7PxtuE5qQ3vJViNukmm5IsNkW53CrA703
         i7Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUcfQl7/R+7HVzexqBfEJvaDyOLJ9kHY9FmiQTEevB8Vy9yuoFKkrf0sYOn6pZClxJjQnAmOe2xdU61Hyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpaAt9GjEx7DmB0hisFs0G0lJZR9QqN7A1sfWdRPFVdC4ZMEN2
	D8Bhk/3GlsHYdn4yvFRjaNTV0S4K0S9Yko5jlOXnJ2fP0WhCqZHuilpHC/NEiTa+S0MpwJMTQXu
	8rTlLEW6oFw==
X-Google-Smtp-Source: AGHT+IHiuMA0lbrxoSV6pFu0qHQjNnerRePAfG3XsNaL0Dp4l+zOxesosad5IkpAuo20QGe5tFe367ODjHjpUw==
X-Received: from loggerhead.c.googlers.com ([fda3:e722:ac3:cc00:f3:525d:ac13:60e1])
 (user=jmattson job=sendgmr) by 2002:a05:6a00:91c1:b0:71d:fe0f:c875 with SMTP
 id d2e1a72fcca58-71e3810af0cmr7016b3a.6.1728683063059; Fri, 11 Oct 2024
 14:44:23 -0700 (PDT)
Date: Fri, 11 Oct 2024 14:43:52 -0700
In-Reply-To: <20241011214353.1625057-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011214353.1625057-1-jmattson@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011214353.1625057-4-jmattson@google.com>
Subject: [PATCH v5 3/4] KVM: x86: Advertise AMD_IBPB_RET to userspace
From: Jim Mattson <jmattson@google.com>
To: kvm@vger.kernel.org
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	jpoimboe@kernel.org, kai.huang@intel.com, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, pawan.kumar.gupta@linux.intel.com, pbonzini@redhat.com, 
	sandipan.das@amd.com, seanjc@google.com, tglx@linutronix.de, x86@kernel.org, 
	Jim Mattson <jmattson@google.com>, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

This is an inherent feature of IA32_PRED_CMD[0], so it is trivially
virtualizable (as long as IA32_PRED_CMD[0] is virtualized).

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kvm/cpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 41786b834b16..53112669be00 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -755,7 +755,7 @@ void kvm_set_cpu_caps(void)
 		F(CLZERO) | F(XSAVEERPTR) |
 		F(WBNOINVD) | F(AMD_IBPB) | F(AMD_IBRS) | F(AMD_SSBD) | F(VIRT_SSBD) |
 		F(AMD_SSB_NO) | F(AMD_STIBP) | F(AMD_STIBP_ALWAYS_ON) |
-		F(AMD_PSFD)
+		F(AMD_PSFD) | F(AMD_IBPB_RET)
 	);
 
 	/*
-- 
2.47.0.rc1.288.g06298d1525-goog


