Return-Path: <linux-kernel+bounces-334032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F9F97D199
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32611284C6D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 07:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5173BBC1;
	Fri, 20 Sep 2024 07:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DMv9Qe2D"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04311EA6F
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 07:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726816910; cv=none; b=hjnOyw6QxgRQpcpGjDYhn/YsrBRuSTmmtTQ4rKiGcMW8YmDgp8/Co6Ym1FZT+3bqc49p7HG0d07+ZkEBwwSV2semjC2xTw6EG9Jbiu7/hOO7czPhZ7+Gms0S+saxjY4BkpcvLIYyLxLpc1ejsNMkSw8iAlv681n+GJrx7TphXMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726816910; c=relaxed/simple;
	bh=/z2PL87Zyz6wUJwzYNESE+EZ7Z16eIksy3GRm+GgLKQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OmQ7f54p6HZM1mJJ0nF41yGdTlgifwZRIsEm2y0nW2hhGLSG1sK/WS3IKMbRoFCMguox6Lc/edAiQuCW4+f7s8oGBUX6J8AV5RmsVMI3m42ZsuEfElLmL6VExNuDYb0NnmM9Wf+o7H/QUSxB32GiQx3HexqjL9YcI2VBs/G/TLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DMv9Qe2D; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-718d5737df6so2541552b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 00:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726816908; x=1727421708; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NnfbKRWvN0a/568A66Zr0OiGbYHltEU225ojHprn0fw=;
        b=DMv9Qe2Dmnwj9eJLpm4R/envoLor40tVSX54m8+pkc+9e1coUHuts295US6Ier5EOn
         unARn74k48de2YQ0mqn1B2WBd1kKk/Ze5YZYOL7KrgrQ8bhGvtD9mdpe/XCkTGxiaKov
         WgdDrQAAH17Hokbv28LKlfbCgIS3swXNRykir8nu/ENyzN41zOTcQ/W6nrQtjifiK0QN
         iYit93oBjrFFz3T65zTbrRggaIFUzWONC5MGP+oR+ldIjhPP4LPf+kJumlmceTdF2Q82
         NLHpEQDK6Ym117D1lu8xMo8Lc5bH+EMA0F9QS8gsoYCFL7kT5sXgR0e02BrK1y9KpWZ1
         cHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726816908; x=1727421708;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NnfbKRWvN0a/568A66Zr0OiGbYHltEU225ojHprn0fw=;
        b=JaQsSCgyeFepv+2dEuPJFQYTyn0UTC+2WF+G3BVqrG1d8Md1lQ4I9A53htPG+xmK3C
         b3yRnK0CPxmyG8DGqKjY5V9fkrOM+MNkNAtek0ON8OX/y6yqwpeNmdVSIPuGS4uGsONo
         X9uiC/Zi9oa6kGsSWOrTeJRK3euYoLg/tq4bLG1gRjaLLtmFY6hy/OHF8PMgoi9VWluP
         NX3NKT9dL+hyUQnxQiv4F01gXBheLEANYcZEd7RNWUzWmsmcYbWX2UF+lMBF4JUuPAlA
         mFyXWKzRo1iU0dVe6ZUgj/gKDuGC4qh5J34pXnj3uztzRGqQxHA8sp4JNkpQLJ6E+RHZ
         fDaQ==
X-Gm-Message-State: AOJu0YxCyS9SRbAuLeukjQITIED7gfxQxwcl5QsRJwVv5AiRStXALkpQ
	3xtz8OEGStvbZv1wcS0H1sm+WTO8xFTFnJwaqjKOeBko/ue1N733lC+mSCi9MYf45Le4l9NM+b7
	9KQ==
X-Google-Smtp-Source: AGHT+IF+cZ3qQDIUPUJjda6t0NIyLH931bQSKRLjVP01MldxalG66O82xxUpOptu1XOzVsuyZ4lb1kFMApY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:8d44:b0:719:1111:1977 with SMTP id
 d2e1a72fcca58-7199cad7263mr1858b3a.6.1726816907727; Fri, 20 Sep 2024 00:21:47
 -0700 (PDT)
Date: Fri, 20 Sep 2024 00:21:44 -0700
In-Reply-To: <2870c470-06c8-aa9c-0257-3f9652a4ccd8@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240731150811.156771-1-nikunj@amd.com> <20240731150811.156771-20-nikunj@amd.com>
 <ZuR2t1QrBpPc1Sz2@google.com> <9a218564-b011-4222-187d-cba9e9268e93@amd.com>
 <ZurCbP7MesWXQbqZ@google.com> <2870c470-06c8-aa9c-0257-3f9652a4ccd8@amd.com>
Message-ID: <Zu0iiMoLJprb4nUP@google.com>
Subject: Re: [PATCH v11 19/20] x86/kvmclock: Skip kvmclock when Secure TSC is available
From: Sean Christopherson <seanjc@google.com>
To: "Nikunj A. Dadhania" <nikunj@amd.com>
Cc: linux-kernel@vger.kernel.org, thomas.lendacky@amd.com, bp@alien8.de, 
	x86@kernel.org, kvm@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, 
	dave.hansen@linux.intel.com, pgonda@google.com, pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 20, 2024, Nikunj A. Dadhania wrote:
> On 9/18/2024 5:37 PM, Sean Christopherson wrote:
> > On Mon, Sep 16, 2024, Nikunj A. Dadhania wrote:
> >> On 9/13/2024 11:00 PM, Sean Christopherson wrote:
> >>>> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> >>>> Tested-by: Peter Gonda <pgonda@google.com>
> >>>> ---
> >>>>  arch/x86/kernel/kvmclock.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> >>>> index 5b2c15214a6b..3d03b4c937b9 100644
> >>>> --- a/arch/x86/kernel/kvmclock.c
> >>>> +++ b/arch/x86/kernel/kvmclock.c
> >>>> @@ -289,7 +289,7 @@ void __init kvmclock_init(void)
> >>>>  {
> >>>>  	u8 flags;
> >>>>  
> >>>> -	if (!kvm_para_available() || !kvmclock)
> >>>> +	if (!kvm_para_available() || !kvmclock || cc_platform_has(CC_ATTR_GUEST_SECURE_TSC))
> >>>
> >>> I would much prefer we solve the kvmclock vs. TSC fight in a generic way.  Unless
> >>> I've missed something, the fact that the TSC is more trusted in the SNP/TDX world
> >>> is simply what's forcing the issue, but it's not actually the reason why Linux
> >>> should prefer the TSC over kvmclock.  The underlying reason is that platforms that
> >>> support SNP/TDX are guaranteed to have a stable, always running TSC, i.e. that the
> >>> TSC is a superior timesource purely from a functionality perspective.  That it's
> >>> more secure is icing on the cake.
> >>
> >> Are you suggesting that whenever the guest is either SNP or TDX, kvmclock
> >> should be disabled assuming that timesource is stable and always running?
> > 
> > No, I'm saying that the guest should prefer the raw TSC over kvmclock if the TSC
> > is stable, irrespective of SNP or TDX.  This is effectively already done for the
> > timekeeping base (see commit 7539b174aef4 ("x86: kvmguest: use TSC clocksource if
> > invariant TSC is exposed")), but the scheduler still uses kvmclock thanks to the
> > kvm_sched_clock_init() code.
> 
> The kvm-clock and tsc-early both are having the rating of 299. As they are of
> same rating, kvm-clock is being picked up first.
> 
> Is it fine to drop the clock rating of kvmclock to 298 ? With this tsc-early will
> be picked up instead.

IMO, it's ugly, but that's a problem with the rating system inasmuch as anything.

But the kernel will still be using kvmclock for the scheduler clock, which is
undesirable.

