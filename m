Return-Path: <linux-kernel+bounces-532657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 300F5A4505F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD17188E4BD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB6E22170B;
	Tue, 25 Feb 2025 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KR6N7hwy"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4507F22156F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740523227; cv=none; b=Qz+RCPv/lwN6ETkXYvXWtYsyxGzTDrx5o3JsfxASrqEhC96xxmFWCL3vYABqBImrWv+Zd6s6zsGlqTHLz3d46sVzL40a6lCoVjk2L5dlUT9XhJUg4T5+zg9xIB2XlmpL/XmSHiCRAELL33n5qlCAXNw5g3a8xYr0LY0hh0ObAVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740523227; c=relaxed/simple;
	bh=1hDnW4sSsif1W/oJ0EX1HaqGkpc76pps3MWJcqWjUhA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rM2ALa//WZ5nKHzw1YUW5YLovTizoed54VPs2RdhiYMNh7GexL/AU500R99v/rHw1vS1ExxoreL8za5/+8luysdqe/w+/BXyh3N+3J55j8BWWTDWYwgnGj4egaMHSWzEmqxGbXLGifjnY1UPK6dfC14hiid6Vgg/k8lV7UB+knU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KR6N7hwy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f816a85facso12559156a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740523225; x=1741128025; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XmSKEWW0shi1vSudB6Rq15IiksgIwOjih3aNXb9mVbw=;
        b=KR6N7hwyJBhhu/x8goSlFMSVNSGc2D4d49rq3BK/FE5uQxqJ6i7oM+sKF6+do/LwzS
         fpGqvoLURqFQdx7iTeDVH5KIswUfa5hyyMkP7cciiyOLHBtsRvoLZVlyRj8rLe92AhgV
         XF8lReLL6hRxzX1HTNmlyVok65Qps/Dr7UC0b4l0H1Tv3T4QhzuD6d64QXV9Wa0+MES0
         nw3iYKGh3tBYkKvkUBItquEVtD5AcBV0DMYDsAqYtvMtIQuXz4nvviibjdVJc+594VYS
         f8gWa23dlf3IWG7FUjGKv9MEzOGtLdJ+0CPw89wCAFuOFfyaBxw1h7sTT6Ll5mdnx99r
         wjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740523225; x=1741128025;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XmSKEWW0shi1vSudB6Rq15IiksgIwOjih3aNXb9mVbw=;
        b=lmgfJqF0AR9a23UprGfCVEWRAP8eR99hXmd8ouWn59qKCfelCSsXR1SCEEimW9yVte
         eoSZt1TqWNL0mWlyiUCF3EeFLOp1Z8U01ClDak4ENJKrBoNQbaZ6QgRUO45E9MMfVr+6
         wU/DhY1ISvU18pXVT1p6i1z8G/CsLla3GMq0SEb+Ddg/SfKdXgd+bz+zZnCuYyt+rMcy
         Vj1ejRhj3MtsRpCsV99pbe6xeQi3JsvczD5CcXlJIPt71lIEwz8GW960V4+uMoD+aSvb
         rXm5fya09P6IPbd8YarIC5UBXZw6LWXo69bphqPSzsYO8Eed+q/tJTCxbHWwSkoTKCGE
         Jb8g==
X-Forwarded-Encrypted: i=1; AJvYcCXg0QrZVazSGJnq9v+67bIQ9/No+MgQqohZZVdiA174PMp951N4bJfzPYbQ6Qd0PKmpx7JIDLqYq9WFLcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYw/cOFpb5BdEZxUkXxD8NWGXpGgZLJfAlMMdahsIoRmHA1ZPs
	EBmkbsniTwZi+AXNeav9hyVwRrmYMEUH0gFMOtYDc1++HMOeeclBVOxTRCjnu8PvdOwzf+z7aEq
	ICA==
X-Google-Smtp-Source: AGHT+IFVMsB5tx8I1N1PDe6JzPmP7ETj5yqTIg0h88wXUvfToK2FV0gvNiEbujOo7m5FKqPE+OemTN6yqzI=
X-Received: from pjuw3.prod.google.com ([2002:a17:90a:d603:b0:2fc:2b27:9d35])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5201:b0:2ee:c6c8:d89f
 with SMTP id 98e67ed59e1d1-2fce86af0b9mr35666029a91.14.1740523225599; Tue, 25
 Feb 2025 14:40:25 -0800 (PST)
Date: Tue, 25 Feb 2025 14:40:24 -0800
In-Reply-To: <59ea1984b2893be8a3a72855b022d16c67b857e9@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250219220826.2453186-1-yosry.ahmed@linux.dev>
 <20250219220826.2453186-5-yosry.ahmed@linux.dev> <Z74exImxJpQI9iyA@google.com>
 <59ea1984b2893be8a3a72855b022d16c67b857e9@linux.dev>
Message-ID: <Z75G2L6N1vR3DslT@google.com>
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

On Tue, Feb 25, 2025, Yosry Ahmed wrote:
> February 25, 2025 at 11:49 AM, "Sean Christopherson" <seanjc@google.com> wrote:
> >
> > On Wed, Feb 19, 2025, Yosry Ahmed wrote:
> > > 
> > > Instead of using X86_FEATURE_USE_IBPB to guard the IBPB execution in the
> > >  vCPU load path, introduce a static branch, similar to switch_mm_*_ibpb. 
> > > 
> > >  This makes it obvious in spectre_v2_user_select_mitigation() what
> > >  exactly is being toggled, instead of the unclear X86_FEATURE_USE_IBPB
> > >  (which will be shortly removed). It also provides more fine-grained
> > >  control, making it simpler to change/add paths that control the IBPB in
> > >  the vCPU load path without affecting other IBPBs.
> > > 
> > >  Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> > > 
> > >  ---
> > > 
> > >  arch/x86/include/asm/nospec-branch.h | 2 ++
> > >  arch/x86/kernel/cpu/bugs.c | 5 +++++
> > >  arch/x86/kvm/svm/svm.c | 2 +-
> > >  arch/x86/kvm/vmx/vmx.c | 2 +-
> > >  4 files changed, 9 insertions(+), 2 deletions(-)
> > > 
> > >  diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> > >  index 7cbb76a2434b9..a22836c5fb338 100644
> > >  --- a/arch/x86/include/asm/nospec-branch.h
> > >  +++ b/arch/x86/include/asm/nospec-branch.h
> > >  @@ -552,6 +552,8 @@ DECLARE_STATIC_KEY_FALSE(switch_to_cond_stibp);
> > >  DECLARE_STATIC_KEY_FALSE(switch_mm_cond_ibpb);
> > > 
> DECLARE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
> > >  
> +DECLARE_STATIC_KEY_FALSE(vcpu_load_ibpb);
> > > 
> > 
> > How about ibpb_on_vcpu_load? To make it easy for readers to understand exactly
> > what the knob controls.
> 
> I was trying to remain consistent with the existing static branches' names,
> but I am fine with ibpb_on_vcpu_load if others don't object.

I assumed as much :-)  I'm ok with vcpu_load_ibpb if that's what others prefer.

