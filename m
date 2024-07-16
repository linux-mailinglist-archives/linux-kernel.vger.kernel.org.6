Return-Path: <linux-kernel+bounces-254041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD42932BA3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06756280E75
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B9119F482;
	Tue, 16 Jul 2024 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4SGebI7i"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED44B19DFBF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 15:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144824; cv=none; b=Sjx+WRrXvQZwiHmrpAQuzfhUvtJHbAM1rtUS2nysxvG+Q1sSiigllVVA/PRdbBCGPTGcqeVyIIOjc0/nnAMnNo0JP7oYWD2FLIH5YiE0+dLfnQma7jcb/O4rmiPNF3Uso/g/lc0rVbyeOWZ5kUoMsxpN/y96WwVThmSHeSTi24g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144824; c=relaxed/simple;
	bh=YpEF0Q6yKkYxLuQtT2PJS/GZ92XHHf4x1MDsqSuwVCk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uJuztkWS1n+JEU1WCC7ScgdwUStOvRteZmufn9fieKlSfaiodthIJrh5sV9GkAZg42Tw/x06gmKUGoub9qJ24Do5F3vYS0skt2Vp5DPHJ683yvj1IAULtS7cIvrhCFa1dWeqv5eNZrzu/xDVIwE2YFcbncarDmMLxR3PT39CI+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4SGebI7i; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-70af58f79d1so4514861b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 08:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721144821; x=1721749621; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ETWgHgOd443GlHDheQNvvEwb46QHybHGr7wnanCFogo=;
        b=4SGebI7iw6V6jR9glZcEtxBZ6Ur5cF7+TLS51iaw7rfy0sRRBuLLrWsDgFXrGS93Qw
         jcep0fZPitNTZpnc+s7Qb4Y86j7W6aV2AYvOYVGpGKOBeHij7qJictFCKZt6EbbYMycs
         nwHXnxE4GY8q9XZ5ygUBn1Z2fWCXdMnToK0V8AVETHeMufQQRDIafzPgykUvqXedZ9WG
         VYNLCMreLZkHzHwWoJvEPw2mGILOHnmJMxeBCHLqByGsUd2AwR1OH88RWw9Ac82xm9X4
         c5kKddXLW0H4iHPyHGQYV5Kd3AAXtUa0pZRaxkuctu2CSa+sz+Qc97W/5nuqklCFbfX+
         oVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721144821; x=1721749621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ETWgHgOd443GlHDheQNvvEwb46QHybHGr7wnanCFogo=;
        b=kiRzK9Ac4wTdzoJf1XibR3iW2G5OV6i7sz63EVV4WNV0PWoifl6O2rmON9NqTV0yM+
         kYvdqWYBo6zUK6G3xV0y0KtVop6+Ags6VWkP1FzhXYvxY525qyVK3gJQ2YctL3z1SfZB
         I0Ylf4vH3oKnzxJ2Mcv6fAPUc9dn9TpckQWI9v6zeouiXLJ89zd4IU+uInTRkho9DCZ4
         FuE1CZFoi3jSmc0HhBS6nalvVjNIR7gdyEQ6PkJwwG0weh8FHL5ex1RpjHb0gcB003l2
         2TmQYl2GWaI81I3fEfXjqMHCI7aIyTvUVidaNOX0hjeSai3fhOHASqyyfsqtIOr1/uUO
         QxZw==
X-Forwarded-Encrypted: i=1; AJvYcCWYOMonZkb4RjctLNWf5WaSAOdHWohpxrf6017UFyJMh3HNkgRrR4/IHUvpWw2bUgOdBQak+MtuSgFNRbXa97oiDeyO6t3XpMbScc/s
X-Gm-Message-State: AOJu0Yxd0ECJApMsOkcpTCksg51aCjoLKg879jMO2+AbAoqKsruMquAb
	FLnVrseTEXFgdKrW4euzcJAAaIDzZFA30tQ2TsOfO3GFnjvI0VcP3E4gdIAlTCp4iAwjGn5tyqH
	b+w==
X-Google-Smtp-Source: AGHT+IGc/BULnIieuwv9+FBRnu1M5AufL70Ng4HgUceQ2bAiT7WRdGZZQ21V3+tP1L1LEbg35yWRxfFG4Ss=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1a93:b0:706:6b52:438c with SMTP id
 d2e1a72fcca58-70c14000242mr208338b3a.0.1721144821054; Tue, 16 Jul 2024
 08:47:01 -0700 (PDT)
Date: Tue, 16 Jul 2024 08:46:54 -0700
In-Reply-To: <0f60918d-bc46-4332-ad28-c155a1990e3d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712235701.1458888-1-seanjc@google.com> <20240712235701.1458888-9-seanjc@google.com>
 <0f60918d-bc46-4332-ad28-c155a1990e3d@redhat.com>
Message-ID: <ZpaV7kaVL1rj7MXj@google.com>
Subject: Re: [GIT PULL (sort of)] KVM: x86: Static call changes for 6.11
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 16, 2024, Paolo Bonzini wrote:
> On 7/13/24 01:56, Sean Christopherson wrote:
> > Here's a massage pull request for the static_call() changes, just in case you
> > want to go this route instead of applying patches directly after merging
> > everything else for 6.11 (it was easy to generate this).  If you want to go the
> > patches route, I'll post 'em next week.
> > 
> > The following changes since commit c1c8a908a5f4c372f8a8dca0501b56ffc8d260fe:
> > 
> >    Merge branch 'vmx' (2024-06-28 22:22:53 +0000)
> > 
> > are available in the Git repository at:
> > 
> >    https://github.com/kvm-x86/linux.git  tags/kvm-x86-static_calls-6.11
> > 
> > for you to fetch changes up to b528de209c858f61953023b405a4abbf9a9933da:
> > 
> >    KVM: x86/pmu: Add kvm_pmu_call() to simplify static calls of kvm_pmu_ops (2024-06-28 15:23:49 -0700)
> 
> Thanks, indeed there was no straggler static_call() after applying
> this.  However, there might be a problem: static_call_cond() is equal
> to static_call() only if CONFIG_HAVE_STATIC_CALL_INLINE,

No, I think you misread the #if-#elif-#else.  It's only the !HAVE_STATIC_CALL
case that requires use of static_call_cond().  From include/linux/static_call.h:

  #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
  #define static_call_cond(name)	(void)__static_call(name)

  #elif defined(CONFIG_HAVE_STATIC_CALL)
  #define static_call_cond(name)	(void)__static_call(name)

  #else
  #define static_call_cond(name)	(void)__static_call_cond(name)

  #endif

And per Josh, from an old RFC[*] to yank out static_call_cond():

 : Static calling a NULL pointer is a NOP, unless you're one of those poor
 : souls running on an arch (or backported x86 monstrosity) with
 : CONFIG_HAVE_STATIC_CALL=n, then it's a panic.

I double checked that 32-bit KVM works on Intel (which is guaranteed to have a
NULL guest_memory_reclaimed()).  I also verified that the generated code is
identical for both static_call() and static_call_cond(), i.e. the READ_ONCE() of
the func at runtime that's present in __static_call_cond() isn't showing up.

Dump of assembler code for function kvm_arch_guest_memory_reclaimed:
   0xc1042094 <+0>:	call   0xc10ce650 <__fentry__>
   0xc1042099 <+5>:	push   %ebp
   0xc104209a <+6>:	mov    %esp,%ebp
   0xc104209c <+8>:	call   0xc1932d8c <__SCT__kvm_x86_guest_memory_reclaimed>
   0xc10420a1 <+13>:	pop    %ebp
   0xc10420a2 <+14>:	ret    
End of assembler dump.

Dump of assembler code for function __SCT__kvm_x86_guest_memory_reclaimed:
   0xc1932d8c <+0>:	ret    
   0xc1932d8d <+1>:	int3   
   0xc1932d8e <+2>:	nop
   0xc1932d8f <+3>:	nop
   0xc1932d90 <+4>:	nop
   0xc1932d91 <+5>:	ud1    %esp,%ecx
End of assembler dump.

[*] https://lore.kernel.org/all/cover.1678474914.git.jpoimboe@kernel.org

