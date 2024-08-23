Return-Path: <linux-kernel+bounces-299773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D85895D9E6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 01:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538991F22FF7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B531C93AE;
	Fri, 23 Aug 2024 23:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PIebXDOw"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE5119342B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 23:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724457248; cv=none; b=LikxO0/WLMrNPGUGYfXcTNSF8lZMDEYAG1VtIDpWQaCkAshTHXeBA9OTWMQifOEnLXGtZ1adLcO4nkbdqsM1qYGzKDbnG70M3Q5ZXADZ7H9xgdAlf76WEyp6nQWNnhwDdzGFpUQT7/1S5E1CPaLWVgR1dNxDkuHuqsG9bc8Cp6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724457248; c=relaxed/simple;
	bh=syaC91o95OEEW2s70JvlpUn03eys1tP3gYIKE9pNcmg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ceDpDXxULoLEX2deDOu1K201jsbR3xf5OcI2h+BfoHIqtrp+HZC8yZ9JOO30ajX5Lqx49Bj8oJylXnH/dWNLe8p/P346UWT39O5UuzUe3u82dWB2ekoRx2zTQOwXQoYMxoUM7MD55o54B9wLQzSYv0x08RiW4nhuic7S/2S/Ijg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PIebXDOw; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7143d76d29fso2160838b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724457246; x=1725062046; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wjeQ4sUJxepKMd1YuoYTecnAndxcQA2Py/BA+Uc+sjo=;
        b=PIebXDOwaWVr245X0FWO/V2qscbX/0dVO9w5BUs/HrDmFczAPodEA3h+EluVfPzCwt
         4MjSBV6ihFHjmrO4ltTMLUIbGVFa1613vsPegSY8Vlp3RJuF0PDoK5sqHhSNolNDoq2n
         2omtH1y4rI5sXsOlWONev4dpJ8igotUcJIq+lQvxfmiHmra9Tky4mX/Gowc8DnbCV8GD
         6qh6VhD5Ef7AYBXpKtkoeyvOEUVkjALzme96kqwfU1z4H9SrccKFPMNQY+VaXUZZUF4h
         6tTz5qTFrd6pJOp/EZxJYi0KnBVTRlkMWWDeOWIZRqw9JdfegNtnYvHE8JgTAf1EfeSu
         MbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724457246; x=1725062046;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wjeQ4sUJxepKMd1YuoYTecnAndxcQA2Py/BA+Uc+sjo=;
        b=dXqPDLsjoncGEFAQ+7UKx/bTHYZh41opUmYHJJJB8MmAjMNKVzUbQmIjTyWvXPamPk
         a2UFnNnFGnVgh+gC2VqPc8FIV+vy0Qg7g1R6wpMEr4+Qhs1SPq9QzXpb1lq/k/WYjYTm
         XaojQP4+fslK2Ls8CAhCzdr7jH0wVYt/A3Cbh2psyt6FCO8/BNYtOlAaXyC4SZnYEfM1
         xS2b4JygFqIcvetkF910Fi6mV6SyV+K795/r75jyS7Prblit7vAzxpBmDaZjVeQkPBzr
         0SM+AKYey57iUbWe6UT58GBXfAZ9rVxFwJmulmzVbCBX0vY3GFE6JCWMXyJK4YgxeEsR
         7KOA==
X-Forwarded-Encrypted: i=1; AJvYcCU0SxMbPnqnap04SuTF4zV5Z+974TYcZFqPe9hOfANtiFFD1sRf4HrmI3shZvb8NfFqklRLiX4CPI3K/18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+BiOAxObSVurX4dkhd1hjBilNHvEwc+ymXfAVoVjaOzoK57NW
	spDrbZ3bJC45L3eHsm12RcLd/8zX+CmhLzQCUDyWk6aMgK4ivDRqRcS6obGY5Zi6Ma2Aiw801tR
	vTA==
X-Google-Smtp-Source: AGHT+IGkirtwyUTKyL39wix+m1OnVtTNEg7AM+vXXhVJfwyHpsD/kM8ZEV5NLVaNIrH2ZTAFsjxvpNTM4u0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:9181:b0:70d:30a8:abaa with SMTP id
 d2e1a72fcca58-71445aa7003mr10252b3a.5.1724457245889; Fri, 23 Aug 2024
 16:54:05 -0700 (PDT)
Date: Fri, 23 Aug 2024 16:47:47 -0700
In-Reply-To: <20240802181935.292540-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802181935.292540-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <172443897959.4130036.5832329559174205887.b4-ty@google.com>
Subject: Re: [PATCH v2 00/10] KVM: x86: Clean up MSR access/failure handling
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 02 Aug 2024 11:19:25 -0700, Sean Christopherson wrote:
> Rework KVM's MSR access handling, and more specific the handling of failures,
> to begin the march towards removing host_initiated exemptions for CPUID
> checks, e.g. to eventually turn code like this:
> 
> 		if (!msr_info->host_initiated &&
> 		    !guest_cpuid_has(vcpu, X86_FEATURE_XSAVES))
> 			return 1;
> 
> [...]

Applied to kvm-x86 misc, thanks!

[01/10] KVM: SVM: Disallow guest from changing userspace's MSR_AMD64_DE_CFG value
        https://github.com/kvm-x86/linux/commit/74a0e79df68a
[02/10] KVM: x86: Move MSR_TYPE_{R,W,RW} values from VMX to x86, as enums
        https://github.com/kvm-x86/linux/commit/b58b808cbe93
[03/10] KVM: x86: Rename KVM_MSR_RET_INVALID to KVM_MSR_RET_UNSUPPORTED
        https://github.com/kvm-x86/linux/commit/aaecae7b6a2b
[04/10] KVM: x86: Refactor kvm_x86_ops.get_msr_feature() to avoid kvm_msr_entry
        https://github.com/kvm-x86/linux/commit/74c6c98a598a
[05/10] KVM: x86: Rename get_msr_feature() APIs to get_feature_msr()
        https://github.com/kvm-x86/linux/commit/b848f24bd74a
[06/10] KVM: x86: Refactor kvm_get_feature_msr() to avoid struct kvm_msr_entry
        https://github.com/kvm-x86/linux/commit/7075f1636150
[07/10] KVM: x86: Funnel all fancy MSR return value handling into a common helper
        https://github.com/kvm-x86/linux/commit/1cec2034980a
[08/10] KVM: x86: Hoist x86.c's global msr_* variables up above kvm_do_msr_access()
        https://github.com/kvm-x86/linux/commit/3adef9034596
[09/10] KVM: x86: Suppress failures on userspace access to advertised, unsupported MSRs
        https://github.com/kvm-x86/linux/commit/64a5d7a1091f
[10/10] KVM: x86: Suppress userspace access failures on unsupported, "emulated" MSRs
        https://github.com/kvm-x86/linux/commit/44dd0f5732b4

--
https://github.com/kvm-x86/linux/tree/next

