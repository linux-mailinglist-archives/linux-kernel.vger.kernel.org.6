Return-Path: <linux-kernel+bounces-389531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEE39B6E18
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8339B1F24C20
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F6F21730F;
	Wed, 30 Oct 2024 20:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1IYk/rxY"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9211F706A
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 20:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321354; cv=none; b=sCnIxKkCvduVRUkrAnfA80tRVbn6mdC91Q4TVg01bTkCVhI1cxWzm+SFfdpTVZFgJM4DBSyI5bOja0T+S7fNihuY0b1uTg4HwZm52zyEkJ0fiV6O7JZLycYd0+UH74cj8fYKoq+20pYlk1xZ15WE0JTEOYzayynnLc3F6ZOXRH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321354; c=relaxed/simple;
	bh=BSbrJP26iMUlUZXuWcsHYFQevcGJ4YpUgw2kHcKg4E4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D9ToSCrEpF5CNzZKrbQY9GlqmlqOXsmhz0vk0ZFzVAzu/0VRzG/Zj9coS4nvP15niMOJR4BC+luTOMlnhdv3cbxnGUjzEKezDWRzFWm6oc35Y57wj/CFkFo2Fe2ljV6GogJqYVWVW/sye6hTVHAK5q2N8Bma+EZH8eUdWZGXX+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1IYk/rxY; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3d660a1afso4812857b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 13:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730321351; x=1730926151; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SeFqo81TVa993P1UT9r403cyNl4J0BGEEsHtf60u0hE=;
        b=1IYk/rxYw5TRVV1WaZGs1i0Dn1jD6hm2hnSZGwOj8myo/CmP94g016/8ILBQVSPKKG
         FB1hLpjjIz2r2PcB+K9roeqaBVYCN4rwoZUOWyVCMEphiE3a8PWzwNxLi57uRe8ztmoy
         /XKwwKWyrahbBPxp1p9OcCtoMbRHDw7qSzu+uGAvzZ4Z5i0oY9caxu1jao3509fQ2Ds6
         XMyQBBhperDWt0v6eXRvsYIkO9c+qOehKMldpHQN2pC0xhwZbwGBztvZrCrmXQieJqzD
         6SPmanpJdlPUAs38ckPtdybLWyvuEIQSX9/yG+BjUAgCWfDRtBb1NTTyds0VLk426Y08
         0t5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730321351; x=1730926151;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SeFqo81TVa993P1UT9r403cyNl4J0BGEEsHtf60u0hE=;
        b=DFx31oE85UTZs6fUOSV4tVn2L7kTQcnnXLYz7knA8HTWj8cUQRQJt50JShdOjjclO2
         ufM/jU+Ju2aG7VkoqPN3pBYqi2mQie9ns9/2IcgXr6G/cpXLrgcim2LVLMamlC9F/FtZ
         xfLDy2PQ6Qhnvqom6LWNuWPeQekXNK3SUyNZE4vdTjsRunXn1tb+aDxqZQ/gj+DAsUUH
         s8v9taixKAoyD8dBCyU+W1+bRhci+Gck6NCLBKPt9OjjMwgxDJ1ljdEaTaU1ROW4+f17
         7YL7Rx2dhGFUp5ajMfPWtZ+gzhio4P5iQW/Jnx20A7lX6G1mFWyNuPtz5DxIsr0mLk0U
         rmIA==
X-Forwarded-Encrypted: i=1; AJvYcCVenWinC0HEDTjcgd4sBKV0RIafyCpLlBX5pE0RL9p9gmRbqy8qY+rJyYWmb6CK/1dHmss95ayAZrLpK5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Ovwme8/W0Djt0w34XbcUczr1XUbFOxX6BlDtLIPKhcWJHGfn
	GkvFcMuMsS14DUDVB/5SJ+v2a/p4Qo/dB+iF4Sp1+mbnISEi+WOQ2BwxnmY802ktAnwGPfr2P/N
	Qbg==
X-Google-Smtp-Source: AGHT+IEn8h41YbaT+L04c8w3Xl8aoNl1JkVAjjSsbklSHuOpKenKWVXjUNmT4rfc76Zvii2eIb/Y3r57W2c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:b88:b0:6e3:19d7:382a with SMTP id
 00721157ae682-6e9d887c22cmr10081197b3.1.1730321351090; Wed, 30 Oct 2024
 13:49:11 -0700 (PDT)
Date: Wed, 30 Oct 2024 13:49:09 -0700
In-Reply-To: <20240826022255.361406-2-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240826022255.361406-1-binbin.wu@linux.intel.com> <20240826022255.361406-2-binbin.wu@linux.intel.com>
Message-ID: <ZyKbxTWBZUdqRvca@google.com>
Subject: Re: [PATCH v3 1/2] KVM: x86: Check hypercall's exit to userspace generically
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	isaku.yamahata@intel.com, rick.p.edgecombe@intel.com, kai.huang@intel.com, 
	yuan.yao@linux.intel.com, xiaoyao.li@intel.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 26, 2024, Binbin Wu wrote:
> Check whether a KVM hypercall needs to exit to userspace or not based on
> hypercall_exit_enabled field of struct kvm_arch.
> 
> Userspace can request a hypercall to exit to userspace for handling by
> enable KVM_CAP_EXIT_HYPERCALL and the enabled hypercall will be set in
> hypercall_exit_enabled.  Make the check code generic based on it.
> 
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> ---
>  arch/x86/kvm/x86.c | 5 +++--
>  arch/x86/kvm/x86.h | 4 ++++
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 966fb301d44b..e521f14ad2b2 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10220,8 +10220,9 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
>  	cpl = kvm_x86_call(get_cpl)(vcpu);
>  
>  	ret = __kvm_emulate_hypercall(vcpu, nr, a0, a1, a2, a3, op_64_bit, cpl);
> -	if (nr == KVM_HC_MAP_GPA_RANGE && !ret)
> -		/* MAP_GPA tosses the request to the user space. */
> +	/* Check !ret first to make sure nr is a valid KVM hypercall. */
> +	if (!ret && user_exit_on_hypercall(vcpu->kvm, nr))

I don't love that the caller has to re-check for user_exit_on_hypercall().  I
also don't love that there's a surprising number of checks lurking in
__kvm_emulate_hypercall(), e.g. that CPL==0, especially since the above comment
about "a valid KVM hypercall" can be intrepreted as meaning KVM is *only* checking
if the hypercall number is valid.

E.g. my initial reaction was that we could add a separate path for userspace
hypercalls, but that would be subtly wrong.  And my second reaction was to hoist
the common checks out of __kvm_emulate_hypercall(), but then I remembered that
the only reason __kvm_emulate_hypercall() is separate is to allow it to be called
by TDX with different source/destionation registers.

So, I'm strongly leaning towards dropping the above change, squashing the addition
of the helper with patch 2, and then landing this on top.

Thoughts?

--
Subject: [PATCH] KVM: x86: Use '0' in __kvm_emulate_hypercall()  to signal
 "exit to userspace"

Rework __kvm_emulate_hypercall() to use '0' to indicate an exit to
userspace instead of relying on the caller to manually check for success
*and* if user_exit_on_hypercall() is true.  Use '1' for "success" to
(mostly) align with KVM's de factor return codes, where '0' == exit to
userspace, '1' == resume guest, and -errno == failure.  Unfortunately,
some of the PV error codes returned to the guest are postive values, so
the pattern doesn't exactly match KVM's "standard", but it should be close
enough to be intuitive for KVM readers.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e09daa3b157c..5fdeb58221e2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10024,7 +10024,7 @@ unsigned long __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
 
 	switch (nr) {
 	case KVM_HC_VAPIC_POLL_IRQ:
-		ret = 0;
+		ret = 1;
 		break;
 	case KVM_HC_KICK_CPU:
 		if (!guest_pv_has(vcpu, KVM_FEATURE_PV_UNHALT))
@@ -10032,7 +10032,7 @@ unsigned long __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
 
 		kvm_pv_kick_cpu_op(vcpu->kvm, a1);
 		kvm_sched_yield(vcpu, a1);
-		ret = 0;
+		ret = 1;
 		break;
 #ifdef CONFIG_X86_64
 	case KVM_HC_CLOCK_PAIRING:
@@ -10050,7 +10050,7 @@ unsigned long __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
 			break;
 
 		kvm_sched_yield(vcpu, a0);
-		ret = 0;
+		ret = 1;
 		break;
 	case KVM_HC_MAP_GPA_RANGE: {
 		u64 gpa = a0, npages = a1, attrs = a2;
@@ -10111,12 +10111,21 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 	cpl = kvm_x86_call(get_cpl)(vcpu);
 
 	ret = __kvm_emulate_hypercall(vcpu, nr, a0, a1, a2, a3, op_64_bit, cpl);
-	if (nr == KVM_HC_MAP_GPA_RANGE && !ret)
-		/* MAP_GPA tosses the request to the user space. */
+	if (!ret)
 		return 0;
 
-	if (!op_64_bit)
+	/*
+	 * KVM's ABI with the guest is that '0' is success, and any other value
+	 * is an error code.  Internally, '0' == exit to userspace (see above)
+	 * and '1' == success, as KVM's de facto standard return codes are that
+	 * plus -errno == failure.  Explicitly check for '1' as some PV error
+	 * codes are positive values.
+	 */
+	if (ret == 1)
+		ret = 0;
+	else if (!op_64_bit)
 		ret = (u32)ret;
+
 	kvm_rax_write(vcpu, ret);
 
 	return kvm_skip_emulated_instruction(vcpu);

base-commit: 675248928970d33f7fc8ca9851a170c98f4f1c4f
-- 

