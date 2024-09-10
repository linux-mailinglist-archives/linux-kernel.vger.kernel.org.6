Return-Path: <linux-kernel+bounces-322410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E539728B5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42A81C23D98
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C0A171671;
	Tue, 10 Sep 2024 04:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EYFoorPY"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6B91531F8
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 04:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725944343; cv=none; b=Vkxoz7j5BMvb+lfPgEqBDm+eFtWmCbxScnNtWzsayc8q7KkCG1/+VgYCWPgoaz55YzdP56UYDIb/LL1dieW/DYw7+oFBOeNBxIiebwYp1AGOqdLoeOdhYd35psYbHR7V1wpc+rYtkz/X8Sj+xCK6MBlv/bRsZTxdQajeQD9iRVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725944343; c=relaxed/simple;
	bh=Ae2qavWM93IcDPqVgwoLj6XUINmWv4ydoOEoGu+ufYU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OU1gkkGIzX5CyYZd0oWEuQDaGxhTjr7dUaO9U2m2CDygVTcRi8vxd8mbgtq4P0IlUBDMkfwhUIx9gVK8h55wWD1RBH4Gm/Gnrs5bs3j6JQP20i7pxTCM4kGre/bczJfvqrPsM/UKRFyEXYzoOsH/udLFvJjlNP/fRJBX2QlYnbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EYFoorPY; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2052d07ff07so56708945ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 21:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725944341; x=1726549141; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L+Jgrf2s3ry0BOEm3TEhTCAuxHBdVQbazzqaUgicweU=;
        b=EYFoorPYA6F6wGLuBGcnIHw08kBJCgvwtQYC+eLHG/7b4DnX6we+EvkqdH/rlpKAsH
         2xcjTKi58LoFQ1hWU6s+G8O1ckCQESr/B4S9uSxlzrvHgkEVYfA+gP7IeryMQMlj/6Pw
         gggT+X3MaqxNTLHXMI7euicPNvU1FBXaQRuVZEGihMxeLGNT283KhD3pep6Irj6KRuaU
         i9syDF0XpS/w1dXPBMqkgh3z85hqmujDGLm4JnuumD/SHIEQ1f7yRhfhREOZxVhuk4vC
         9JgbMuzAj/w7K/syHrUI4OeQ/9P0eiXlUuS9D2NWoIWN4nUNknF7rdnPt7/NN1LrC67y
         J6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725944341; x=1726549141;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+Jgrf2s3ry0BOEm3TEhTCAuxHBdVQbazzqaUgicweU=;
        b=l/cVIoAY1scuUnuGbB8tQtCKzrf4k/ZV6xtYVFT0jbwEYdT5xTQ2pbZaEtXEfiTjan
         p1n/5gyFZzFgbnL2CW/X0fFghdyLLr3tKgNJXq9ft7StBNtT7SFcQGnr+rpKX+fF/f44
         8yfGhGxI0Bk1zn3rsqdZMGtXUSGewbEjTHds950/2ir0lrSwgVQXkzalJb4mlyyYlZiG
         zZ6fiTRCmXWbShT2qnM/fTTg4TLId2rb3e3ccsJQRQfsI1GSapIRgSz18iFUFUkiy64z
         Rm+RbIOQht5edzhKMCkCPRnYn0orNa8e5Q11tTyEEB50PGsoay/jDsSbJRznuFFEz+vO
         h//g==
X-Forwarded-Encrypted: i=1; AJvYcCUXGCYohSNtrQsai5VFfj51UXV7pfrHufK1GBCM27AClsHA9oHfPt0Y1DO9klyhVheTdECmg17+bHHm+lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhhaWt+/yXq1MT4qZOuh0i0EPMQqoy7JaaAbAkCHgp+qD6AnBF
	FwefbKAeHJ9/8CNGqnFc+WCzhMM5cHcpDX3dZsavfQD2Fm9VqHW0BY5Y82+z9LJUk77XipXMi08
	nwQ==
X-Google-Smtp-Source: AGHT+IFEMbpmwfciH3atJ2FsVcYOyT+gS8VZOX2/4dXCvdCctY9SlbsZB6JWKqem73D6wByDBVGoZcdOhPU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:cecb:b0:206:a858:40d0 with SMTP id
 d9443c01a7336-206f05fafa2mr13101045ad.9.1725944340845; Mon, 09 Sep 2024
 21:59:00 -0700 (PDT)
Date: Mon,  9 Sep 2024 21:56:36 -0700
In-Reply-To: <20240831001538.336683-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240831001538.336683-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <172594257572.1553323.3113270200615863364.b4-ty@google.com>
Subject: Re: [PATCH v2 00/22] KVM: x86: Fix multiple #PF RO infinite loop bugs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yuan Yao <yuan.yao@intel.com>, Yuan Yao <yuan.yao@linux.intel.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 30 Aug 2024 17:15:15 -0700, Sean Christopherson wrote:
> Fix an amusing number of minor bugs that can lead to KVM putting the guest into
> an infinite "retry #PF" loop, and cleanup and consolidate the unprotect+retry
> paths (there are four-ish).
> 
> As a bonus, adding RET_PF_WRITE_PROTECTED obviates the need for
> kvm_lookup_pfn()[*].
> 
> [...]

Applied to kvm-x86 mmu, except for patch 1, which I put at the end of "vmx" in
case Paolo wants to take it through his tree for the CoCo stuff.

[01/22] KVM: VMX: Set PFERR_GUEST_{FINAL,PAGE}_MASK if and only if the GVA is valid
        https://github.com/kvm-x86/linux/commit/f3009482512e
[02/22] KVM: x86/mmu: Replace PFERR_NESTED_GUEST_PAGE with a more descriptive helper
        https://github.com/kvm-x86/linux/commit/4ececec19a09
[03/22] KVM: x86/mmu: Trigger unprotect logic only on write-protection page faults
        https://github.com/kvm-x86/linux/commit/989a84c93f59
[04/22] KVM: x86/mmu: Skip emulation on page fault iff 1+ SPs were unprotected
        https://github.com/kvm-x86/linux/commit/2fb2b7877b3a
[05/22] KVM: x86: Retry to-be-emulated insn in "slow" unprotect path iff sp is zapped
        https://github.com/kvm-x86/linux/commit/c1edcc41c360
[06/22] KVM: x86: Get RIP from vCPU state when storing it to last_retry_eip
        https://github.com/kvm-x86/linux/commit/019f3f84a40c
[07/22] KVM: x86: Store gpa as gpa_t, not unsigned long, when unprotecting for retry
        https://github.com/kvm-x86/linux/commit/9c19129e535b
[08/22] KVM: x86/mmu: Apply retry protection to "fast nTDP unprotect" path
        https://github.com/kvm-x86/linux/commit/01dd4d319207
[09/22] KVM: x86/mmu: Try "unprotect for retry" iff there are indirect SPs
        https://github.com/kvm-x86/linux/commit/dfaae8447c53
[10/22] KVM: x86: Move EMULTYPE_ALLOW_RETRY_PF to x86_emulate_instruction()
        https://github.com/kvm-x86/linux/commit/41e6e367d576
[11/22] KVM: x86: Fold retry_instruction() into x86_emulate_instruction()
        https://github.com/kvm-x86/linux/commit/2df354e37c13
[12/22] KVM: x86/mmu: Don't try to unprotect an INVALID_GPA
        https://github.com/kvm-x86/linux/commit/b7e948898e77
[13/22] KVM: x86/mmu: Always walk guest PTEs with WRITE access when unprotecting
        https://github.com/kvm-x86/linux/commit/29e495bdf847
[14/22] KVM: x86/mmu: Move event re-injection unprotect+retry into common path
        https://github.com/kvm-x86/linux/commit/b299c273c06f
[15/22] KVM: x86: Remove manual pfn lookup when retrying #PF after failed emulation
        https://github.com/kvm-x86/linux/commit/620525739521
[16/22] KVM: x86: Check EMULTYPE_WRITE_PF_TO_SP before unprotecting gfn
        https://github.com/kvm-x86/linux/commit/19ab2c8be070
[17/22] KVM: x86: Apply retry protection to "unprotect on failure" path
        https://github.com/kvm-x86/linux/commit/dabc4ff70c35
[18/22] KVM: x86: Update retry protection fields when forcing retry on emulation failure
        https://github.com/kvm-x86/linux/commit/4df685664bed
[19/22] KVM: x86: Rename reexecute_instruction()=>kvm_unprotect_and_retry_on_failure()
        https://github.com/kvm-x86/linux/commit/2876624e1adc
[20/22] KVM: x86/mmu: Subsume kvm_mmu_unprotect_page() into the and_retry() version
        https://github.com/kvm-x86/linux/commit/6b3dcabc1091
[21/22] KVM: x86/mmu: Detect if unprotect will do anything based on invalid_list
        https://github.com/kvm-x86/linux/commit/d859b16161c8
[22/22] KVM: x86/mmu: WARN on MMIO cache hit when emulating write-protected gfn
        https://github.com/kvm-x86/linux/commit/98a69b96caca

--
https://github.com/kvm-x86/linux/tree/next

