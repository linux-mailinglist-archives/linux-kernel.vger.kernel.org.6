Return-Path: <linux-kernel+bounces-532336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A292A44BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FED53B4FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C1C20D517;
	Tue, 25 Feb 2025 19:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wsgFSmnY"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CAF1DC9BB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 19:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740512968; cv=none; b=OVjQn0kkynbqIWgJOJuaVRdSi0XFmtOyL/JR3tnCIL/AQKvpVMFMy15MVyqNtMaAIs9hvHiGFSPEv9JedVdHQouh4Two+uhlsz1zLB5BMp4uUFxEZ+G19YIUiwkfxXy088igKeZWjHkT5nfsxcn4dSHafbyF2FYgf5IzC5k3gBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740512968; c=relaxed/simple;
	bh=zcWCkK0WkY6qco1HKIBObhO7+M912iIc5Cep4FFpXxY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R5h0kEXivy//TSFD59LRdbMgxQuXSE3HF9R5yIi3TtPKCtYN58efmaOXX7AHVs30etE2XxGFr3YeyKuBKsTJdnFyuOyG+TMtqFkVDrexIHnO47/26UMHLltT7ralB6Vmgg+Q++T2cpTj4U9gncvKA1tHFuClSkDVUi8+yjjBJF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wsgFSmnY; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc1e7efdffso19723828a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740512966; x=1741117766; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kkBizlLFjc9YWF9Gri6wHCj+vId91L67ElQWW5urls0=;
        b=wsgFSmnYDlEVgt+4/tK4rqLwpThC98gUYreGs8kd+kk8dywXuFTXRQ7IBV4CejQoYc
         roA0715sLg0B6hPEcFbdGgq6xV4aQ/RldqlpCfpo4j4DA/gh9b4t6Zy+x9FaIpeuKt58
         VSalSNKUONl8XeBuU1+J8f102QjJ+pBCqsBh/WSFwEiXCHz6OARnsXV/9GPByzHsqqVU
         ParVUbMxSXHqOtIHZF5FONqXVCs2ssQE0QlFSEXQv1g/lTmnnbUy7D9HgU6ObZpuDDEI
         fg5Q2O642cNM2iqi4JjDJ0yPUVogM4QaM5VAsKufRIoUT4ppnqbZL7hqGiwWwIkOZyV9
         Jtig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740512966; x=1741117766;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kkBizlLFjc9YWF9Gri6wHCj+vId91L67ElQWW5urls0=;
        b=wjfAfZ1Ga7Z6O34cZtE40axgqWruWgfvHSfRx6RbtCi1sp0NdaD/bbSguxKmmtRrd7
         T/hQQqz5EkMDrGx+FVZr2buFWjmwiPcLj6IFvKBEyEZyTMoQnlV1z5c387E59Rw8+1tw
         nTcLGv81ZXy8xx42EIb/2FyHZQqNJnSOto0ewpDdUOx52OB+YvJ0Kx9XghdvcD9NrHU3
         RDMPNSLPaocVB5PQvMyuaw5qjDhDB7sFE/fKXD8WLqsdsEzzcufBY1GYJU1T4N+bFcQ/
         Y/iaZwa9xY/lgDuKkdgW7b19x+5cnc+LY10TkvFXCZjBP5VlGjVIBzzAOoTx83o/uVR3
         93+w==
X-Forwarded-Encrypted: i=1; AJvYcCWuzj3c2YUnO6rmrq40E7Ga2Zhb34vjpzTxCpGNxwPmtndIcbyyw2mgXM3RP2I7vOWi3m+1LEDJr9WSN60=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHXGxqS072XsWE7XS8gNOI+nsBCkk3cqo2Md3IWql5EKDrVwFz
	spFqzE5HSjZrxDrWNWp/KFkdao3fUgP32iyaatgVpSgyxJG9KkCSylToaGj7Zmr23GDZgWmz44/
	ACw==
X-Google-Smtp-Source: AGHT+IGiSQmtxSYJOgm788wJ2szimVYfR07vW6izchKFgwQ5IHXM0rL2fGmxqRS9BVczgO7MvgMwEVqbjKk=
X-Received: from pjbsg16.prod.google.com ([2002:a17:90b:5210:b0:2fc:11a0:c549])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:6c8:b0:2f2:a664:df20
 with SMTP id 98e67ed59e1d1-2fe68acd6demr7754869a91.7.1740512966057; Tue, 25
 Feb 2025 11:49:26 -0800 (PST)
Date: Tue, 25 Feb 2025 11:49:24 -0800
In-Reply-To: <20250219220826.2453186-5-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250219220826.2453186-1-yosry.ahmed@linux.dev> <20250219220826.2453186-5-yosry.ahmed@linux.dev>
Message-ID: <Z74exImxJpQI9iyA@google.com>
Subject: Re: [PATCH 4/6] x86/bugs: Use a static branch to guard IBPB on vCPU load
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 19, 2025, Yosry Ahmed wrote:
> Instead of using X86_FEATURE_USE_IBPB to guard the IBPB execution in the
> vCPU load path, introduce a static branch, similar to switch_mm_*_ibpb.
> 
> This makes it obvious in spectre_v2_user_select_mitigation() what
> exactly is being toggled, instead of the unclear X86_FEATURE_USE_IBPB
> (which will be shortly removed). It also provides more fine-grained
> control, making it simpler to change/add paths that control the IBPB in
> the vCPU load path without affecting other IBPBs.
> 
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> ---
>  arch/x86/include/asm/nospec-branch.h | 2 ++
>  arch/x86/kernel/cpu/bugs.c           | 5 +++++
>  arch/x86/kvm/svm/svm.c               | 2 +-
>  arch/x86/kvm/vmx/vmx.c               | 2 +-
>  4 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index 7cbb76a2434b9..a22836c5fb338 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -552,6 +552,8 @@ DECLARE_STATIC_KEY_FALSE(switch_to_cond_stibp);
>  DECLARE_STATIC_KEY_FALSE(switch_mm_cond_ibpb);
>  DECLARE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
>  
> +DECLARE_STATIC_KEY_FALSE(vcpu_load_ibpb);

How about ibpb_on_vcpu_load?  To make it easy for readers to understand exactly
what the knob controls.

