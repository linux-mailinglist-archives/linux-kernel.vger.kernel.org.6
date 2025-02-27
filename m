Return-Path: <linux-kernel+bounces-535239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220E3A47077
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 222D03A8F94
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C309E18AFC;
	Thu, 27 Feb 2025 00:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PzZt9R+f"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14203A1B6
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740617170; cv=none; b=bPoEhXoaIAS3K0W+utrTq6o4NKZI72eaCT67h2LHJH+OY3ijGLz0wpPT7ssBNZWXIkeM6lREQUHjG/jJZHESExzZc9FV3VKn63KszdM4RNyX0/TTbVE7DjEinNXfYQWRlJ1+qUMAyzIE3jSibCrG9SOKdOJJY+clPJPOTuXDvAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740617170; c=relaxed/simple;
	bh=GsbplUyiPzK2RcL3j5EFMOXrQypLBGL/7X0N4yL3uTU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VPQ7j0er/FeM7pwu0UX3cnEtTLVChuclQ7Iu30GlXMFFPnCL60qS/gkpMr9zvcAoUFK163tf1IUWbZYAR2Rf/0fwOmUzPPgDUXFaUOAqE2nZjCjhQdxOM2wVtClAgEJM46Q3izwOlKVtWdsdOoy8p7csh7LtcPaQq3wM1kuYxf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PzZt9R+f; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22112e86501so6003615ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740617168; x=1741221968; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hn0Pk7DdXD560KhFHLztox3NbezGKbjUTRJg0LOXoPE=;
        b=PzZt9R+f6xxBf/dMwTjShxK5wSWpB1JgMRIs7Pg0nRFDx26CVNwrs2P+8Ght4SjjHj
         GYIwjZ5uWCC3v/0qtMWvrdAz3X3GTrrhC4OSfXyLuK5d/RZn5Gh4qxpFJwkW59gXhk3D
         5MQiCL0EAYfKGRADs2QTsBBGPnOOlGB3cYOiv6hY9TYrDKq6+ygTqWulCvsUjtOeXAkT
         KqBEkcRLdgcV2bs7Xinm18k4qZ+1BbuxAad7nCZtjgZMX3nWh14tqXDp2v1a/rTvnudN
         EYWyKVmZE7Ov41rG+mb+M26OHgWMJWmV8lGCacZ3Kuj6YBxSrBOmnacLLncBMnH1kiGH
         0hyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740617168; x=1741221968;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hn0Pk7DdXD560KhFHLztox3NbezGKbjUTRJg0LOXoPE=;
        b=NHGTsPKaaX8l9SzIGX16kXCqGkihoc7vGuqctAlaPNZU+pKibG2mv0chyIsjoHawfc
         g0NvrN6G6+u2IZjnMXkdhq+DTRtZSnHM5eBKGg3bjExacplUlZ0tFIRdgOWqsz/iplf7
         +HeH/tMxDI2eVAuv3zOmnyoo3dvoSciOHn7Z6v/VGhq9pzawSMG9TIYHWKCZfUfYAkmo
         WakkInSOn4kGs6KIyy97wSSwoLgHIZNXeE4s9fr669I1XXjVX9R9LhYpKT1dSsOL5xy1
         T4TJgDp+5V7iqMMMNa96g8QdTF7b6iJXq51CO4Szt2kmT8sJ0yFuaG9fmDkdGC0EsQ4N
         WRWg==
X-Forwarded-Encrypted: i=1; AJvYcCVoIEQ9xefH6OAFGzOzsJFGFMQXM6xegnCFr+rUOdeXaYla8QOlaFvco+bBCs+JRnjRREMdqCHFqrjsg2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNkiOca2LVQQVa38muf14wNRum4nl6/zR2V4Vu8wYuz+MA16bv
	lJk4kxmH7HVKosySa4YAijguW3dgxCdI5Q9Nx87yNVzs0kWCkz3JRMONxseCER3BIL24x0j/xgr
	Jiw==
X-Google-Smtp-Source: AGHT+IH2WM4xX/I/9Cf4I8pfwJJDfsSS1+XA6ioOiO3B1DczWxFPo2dPJfXNJSjcedJwObmWHzjhXzfgUGI=
X-Received: from pjbnc5.prod.google.com ([2002:a17:90b:37c5:b0:2fc:11a0:c54d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:983:b0:21f:14c1:d58e
 with SMTP id d9443c01a7336-2219ff8279dmr394871355ad.1.1740617168076; Wed, 26
 Feb 2025 16:46:08 -0800 (PST)
Date: Wed, 26 Feb 2025 16:46:06 -0800
In-Reply-To: <Z76BTqmAJPV7lBbA@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250219220826.2453186-1-yosry.ahmed@linux.dev>
 <20250219220826.2453186-5-yosry.ahmed@linux.dev> <Z74exImxJpQI9iyA@google.com>
 <59ea1984b2893be8a3a72855b022d16c67b857e9@linux.dev> <Z75G2L6N1vR3DslT@google.com>
 <Z76BTqmAJPV7lBbA@google.com>
Message-ID: <Z7-1zv3Pb659rTj6@google.com>
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

On Wed, Feb 26, 2025, Yosry Ahmed wrote:
> On Tue, Feb 25, 2025 at 02:40:24PM -0800, Sean Christopherson wrote:
> > On Tue, Feb 25, 2025, Yosry Ahmed wrote:
> > > February 25, 2025 at 11:49 AM, "Sean Christopherson" <seanjc@google.com> wrote:
> > > >
> > > > On Wed, Feb 19, 2025, Yosry Ahmed wrote:
> > > > > 
> > > > > Instead of using X86_FEATURE_USE_IBPB to guard the IBPB execution in the
> > > > >  vCPU load path, introduce a static branch, similar to switch_mm_*_ibpb. 
> > > > > 
> > > > >  This makes it obvious in spectre_v2_user_select_mitigation() what
> > > > >  exactly is being toggled, instead of the unclear X86_FEATURE_USE_IBPB
> > > > >  (which will be shortly removed). It also provides more fine-grained
> > > > >  control, making it simpler to change/add paths that control the IBPB in
> > > > >  the vCPU load path without affecting other IBPBs.
> > > > > 
> > > > >  Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> > > > > 
> > > > >  ---
> > > > > 
> > > > >  arch/x86/include/asm/nospec-branch.h | 2 ++
> > > > >  arch/x86/kernel/cpu/bugs.c | 5 +++++
> > > > >  arch/x86/kvm/svm/svm.c | 2 +-
> > > > >  arch/x86/kvm/vmx/vmx.c | 2 +-
> > > > >  4 files changed, 9 insertions(+), 2 deletions(-)
> > > > > 
> > > > >  diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> > > > >  index 7cbb76a2434b9..a22836c5fb338 100644
> > > > >  --- a/arch/x86/include/asm/nospec-branch.h
> > > > >  +++ b/arch/x86/include/asm/nospec-branch.h
> > > > >  @@ -552,6 +552,8 @@ DECLARE_STATIC_KEY_FALSE(switch_to_cond_stibp);
> > > > >  DECLARE_STATIC_KEY_FALSE(switch_mm_cond_ibpb);
> > > > > 
> > > DECLARE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
> > > > >  
> > > +DECLARE_STATIC_KEY_FALSE(vcpu_load_ibpb);
> > > > > 
> > > > 
> > > > How about ibpb_on_vcpu_load? To make it easy for readers to understand exactly
> > > > what the knob controls.
> > > 
> > > I was trying to remain consistent with the existing static branches' names,
> > > but I am fine with ibpb_on_vcpu_load if others don't object.
> > 
> > I assumed as much :-)  I'm ok with vcpu_load_ibpb if that's what others prefer.
> 
> To be honest looking at this again I think I prefer consistency, so if
> you don't mind and others don't chime in I'd rather keep it as-is.

Works for me.

Actually, looking at the names again, wouldn't "switch_vcpu_ibpb" be better?
KVM doesn't do IBPB on every vCPU load or even every VMCS load, only when a
different vCPU is being loaded.

> Alternatively I can rename all the static branches (e.g.
> ibpb_always_on_switch_mm) :P

LOL, also works for me.

