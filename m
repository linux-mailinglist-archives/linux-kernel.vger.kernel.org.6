Return-Path: <linux-kernel+bounces-203366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E4E8FD9FF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E866B24371
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D2F160794;
	Wed,  5 Jun 2024 22:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NgoHWauk"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657EC13AA2F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 22:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717627534; cv=none; b=JcLZD4i0h6Ps+ZvkZ4OJ7lnSRIvE70dETPcSCUKp/+cCtUbZLJw8rhL41i8J/xGDGu1dviW7Wn/DmHCQCF9DzCvFAfV7cjhanOKX0S2muYix14UyYVUumptUxZnhjRAq6xReytxhyHd0vfqm2spVkYtShKg89zj9e2m25CkbPCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717627534; c=relaxed/simple;
	bh=wNn6c821drsCNYXOaK4PG8rk6Ikph6sPxNX8fnupBAs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KKJG+9fUeHdxKINnR30aqoeY+sjcECu4sdTETlC1U6tHhAfVUG1TtvGJ2wLJbpE9Hr4Iif5CJLUGX0k6af7ArR7Jpxq9e6XOtPdT1FGCss4QmafogeHCl0tcKos42OWFjYCr5jeKNTYXH97hDPn9zQIv+bXNo6yE5ZIQsxEpR+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NgoHWauk; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-70287dabb74so241567b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 15:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717627533; x=1718232333; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=t3pD+F4v0/739SU44JmflpbRX20XhjpSLT2Xtqw96TI=;
        b=NgoHWauk11odDcrx9igBLSCAsgIiCQCrCMKCM9ujD2IaOksbGvs9ma3aCiHR42MDAR
         pHHN0hlVnwI6Y2iaSZk0motNToL8fF7aFnU2bKys6V9zq3No6q3LQOT5OZdL/o6KWxcX
         Bv8pIfTuGkxu0/HVNVqMgi0tDKm3usEYssMCYckUOe1VVYla3ppFoCh1CUfrnjkbtX9X
         zBYlaUNYD5+1JPIRFPENawyH0LetN0Qi+XCPQQDwAcvGxXx328+2H24qqbQZfPO1Ns24
         S+aZ+q0N83g8AxLlfLxFkCoaT4WnKHyElo6mst8FRnTLdCfkRmMx1HJb0qj6MrBB3kHW
         yShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717627533; x=1718232333;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3pD+F4v0/739SU44JmflpbRX20XhjpSLT2Xtqw96TI=;
        b=K0lpeilBrAUWeBT++n6JLOlG606+1t7pMMFwuQlpLzITfEAr1PfQTGfyNikg4a4jwj
         fqQPeO9yuntbEomzDsFhfe+1j0K85mzsAqVuqM1CeiuG7QWTfd1SEq7WOdMtREPz8UKJ
         EHWKqGNh9O+xntrzh/K9p/Kdw5ZnqbQcbepWMJosw3BC4LDlIOxyChr+0TP+mkYXnzCf
         x8bVzQPztUvMoIazBUfvHCHFmzr8zLMJJ3ZlZKjV5eHtZLm68lpdA2UjGB3jXtUTf3na
         5vi33zCvlmAoJ6k8WYLFUOfz4FY5VuugZJD0Q0nFU4wf7Et/SfbX/jg2Ra4CyDFsCKTT
         m7NA==
X-Gm-Message-State: AOJu0Yw9yvIkbOTtldD6JECriiCqy6eNgqyn6/H54uiJIPmZm9VB2+f2
	nJDIEncP7UFzRIU/GiUQ64WhTcD18DBd/5bBLPU2bcijAyX7AKBSsSGPDB959AzeLtDn0NRTDkL
	5xQ==
X-Google-Smtp-Source: AGHT+IE2rHCOwxKt2V/ZJZC3ldSt1tMRifzebZtLw4TsCasroKRH//SWaEqLnNRcE+u0aB/gJdWSyMLTits=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:92a5:b0:6ec:f406:ab4b with SMTP id
 d2e1a72fcca58-703e5a21865mr253337b3a.4.1717627532532; Wed, 05 Jun 2024
 15:45:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  5 Jun 2024 15:45:26 -0700
In-Reply-To: <20240605224527.2907272-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240605224527.2907272-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240605224527.2907272-2-seanjc@google.com>
Subject: [PATCH 1/2] nVMX: Ensure host's PAT is loaded at the end of all VMX tests
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, Xiangfei Ma <xiangfeix.ma@intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Load the host's original PAT on VM-Exit by default in all VMX tests, and
manually write PAT with the original value in the test that verifies all
legal PAT values can be loaded via HOST_PAT.  Failure to (re)load the
correct host PAT results in all tests that run after test_load_host_pat()
using UC memtype for all memory.

Opportunistically fix a message goof for the ENT_LOAD_PAT=0 case.

Reported-by: Xiangfei Ma <xiangfeix.ma@intel.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 x86/vmx.c       | 4 +++-
 x86/vmx_tests.c | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/x86/vmx.c b/x86/vmx.c
index 9f08c096..c803eaa6 100644
--- a/x86/vmx.c
+++ b/x86/vmx.c
@@ -1126,6 +1126,8 @@ static void init_vmcs_host(void)
 	vmcs_write(HOST_CR4, read_cr4());
 	vmcs_write(HOST_SYSENTER_EIP, (u64)(&entry_sysenter));
 	vmcs_write(HOST_SYSENTER_CS,  KERNEL_CS);
+	if (ctrl_exit_rev.clr & EXI_LOAD_PAT)
+		vmcs_write(HOST_PAT, rdmsr(MSR_IA32_CR_PAT));
 
 	/* 26.2.3 */
 	vmcs_write(HOST_SEL_CS, KERNEL_CS);
@@ -1247,7 +1249,7 @@ int init_vmcs(struct vmcs **vmcs)
 	/* All settings to pin/exit/enter/cpu
 	   control fields should be placed here */
 	ctrl_pin |= PIN_EXTINT | PIN_NMI | PIN_VIRT_NMI;
-	ctrl_exit = EXI_LOAD_EFER | EXI_HOST_64;
+	ctrl_exit = EXI_LOAD_EFER | EXI_HOST_64 | EXI_LOAD_PAT;
 	ctrl_enter = (ENT_LOAD_EFER | ENT_GUEST_64);
 	/* DIsable IO instruction VMEXIT now */
 	ctrl_cpu[0] &= (~(CPU_IO | CPU_IO_BITMAP));
diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index 22e8812a..8a17dd90 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -7233,6 +7233,7 @@ static void test_guest_efer(void)
 static void test_pat(u32 field, const char * field_name, u32 ctrl_field,
 		     u64 ctrl_bit)
 {
+	u64 pat_msr_saved = rdmsr(MSR_IA32_CR_PAT);
 	u32 ctrl_saved = vmcs_read(ctrl_field);
 	u64 pat_saved = vmcs_read(field);
 	u64 i, val;
@@ -7252,7 +7253,7 @@ static void test_pat(u32 field, const char * field_name, u32 ctrl_field,
 				report_prefix_pop();
 
 			} else {	// GUEST_PAT
-				test_guest_state("ENT_LOAD_PAT enabled", false,
+				test_guest_state("ENT_LOAD_PAT disabled", false,
 						 val, "GUEST_PAT");
 			}
 		}
@@ -7274,6 +7275,8 @@ static void test_pat(u32 field, const char * field_name, u32 ctrl_field,
 					error = 0;
 
 				test_vmx_vmlaunch(error);
+				wrmsr(MSR_IA32_CR_PAT, pat_msr_saved);
+
 				report_prefix_pop();
 
 			} else {	// GUEST_PAT
-- 
2.45.1.467.gbab1589fc0-goog


