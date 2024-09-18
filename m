Return-Path: <linux-kernel+bounces-332611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0139097BBE2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1845B1C21409
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1150F1898FA;
	Wed, 18 Sep 2024 12:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bB5W6fBS"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C2017C98C
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 12:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726661242; cv=none; b=QtiaBO+gTVAkMWq61aq8P0A5mrbB50mXqzZT06QJbunemAvsUE1QBHSW1ZOB8mW6upIXKGsxWzgWC7iW/zV9Gu230fH7wc//V2L7TUBY3sidj6aveXSEC+PM1bOhcry/1D3nG8PV97clChf8MoRQ0EjaWcyCPUvSLaxIASO3f0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726661242; c=relaxed/simple;
	bh=RAtPKAtbfcHHjMKyv+VNhXNev6NWhjeu9m3hwq3CJK0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HmTEjWX2xkRG5BtQiWWVOgiFFLpwjUlQGaQ7fV6FCsM02tAX5wepYoXA4ShJrnA+6G1QzAloxqso73K2dXq7TAvtXaAeBzDL32xuTU+w2QKgX9ObW8g/o9WUPa7jdNx4dkkkw2U0wiPCu5oAxzBCUvRTQBgYP/ufXhqlOsTTfkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bB5W6fBS; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-69a0536b23aso156639997b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 05:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726661240; x=1727266040; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NkmtIxU+FppdMB18S8izokek2BhBOE8zhRXe1yQJeLw=;
        b=bB5W6fBSmtQ+in+jZzmfr5YPVmv5lF9cFFN8eo0JV2paYPyZVkJq6rU82Xc27hf8Zm
         +DrIMdhStamkYGkhBu5ak9dauP+X2QLBp67CxK9gGj3qUNUHzLoJlZZJgksXuhjbm+gM
         XlCpI7POU+3qaha2yG+UReWq108iVQtvoqAportDckuoFYCae2VffotbCpY2RI1xb8xS
         nWCQ13SA5Ugn9hYEMn2JYtuz8EaT79+m2HO50dfWYWIiJD/7UKI0gfwc25YbYVaNvKy/
         ICbxQCtzdg9YQo6cmGkZeZ3sOKYOXqYI6I6WbOt9Lf649S0QA5HPrv6kvqKWC8f4UC/y
         BZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726661240; x=1727266040;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NkmtIxU+FppdMB18S8izokek2BhBOE8zhRXe1yQJeLw=;
        b=eQncssHxiA1aGmS75yj6NDpa/47k4/+0WQpEaZdZZANzxOPP3XHCzz04KqBKW0tjBA
         /FXdSH+w1LJBlvp9gUsBU3EjwHTcaa+Q9ak04mRXEsIFe7Gx2Jw51heIpVIWaI5uj7OS
         oqd16BwMXix7YS2A7qmUOldvPyAg0pAsZZbrB14MeoqngsutZN8WCdpxI9Dki6kslSje
         JJvESsIRSFSHpJsLt79pV340t5TT648baaeLy/i+ouu4T8Vzb7fRgGvGBCmR8mp4riEv
         LXDFnVThnRQslrCxivjl2+yeqnQiHxuARjNyHbbwC4FpLN6ETo3XstSbQRUhj864jDDH
         MdaA==
X-Gm-Message-State: AOJu0Yx30rOpGvGOzFaY6aVEcBVBysEczH3sl4R+QrSYUOPxcExTzI7e
	FHuYLYWWAASs4OR6QfeMBAxIf4T1xd061ahlbDtoGwYK3PbNdTR3e7EIhSBg3eYWM+s/tP7mDLR
	dpA==
X-Google-Smtp-Source: AGHT+IHZ41Pb/w7FjZAic6hb0I389ImtsrHjzH0O4hHAsYPrz3KeyzZ/jgKEqyYx+PKdvUkEgUm9YDzMTBE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:c78c:0:b0:e0b:f93:fe8c with SMTP id
 3f1490d57ef6-e1d9daa135fmr66936276.0.1726661239692; Wed, 18 Sep 2024 05:07:19
 -0700 (PDT)
Date: Wed, 18 Sep 2024 05:07:08 -0700
In-Reply-To: <9a218564-b011-4222-187d-cba9e9268e93@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240731150811.156771-1-nikunj@amd.com> <20240731150811.156771-20-nikunj@amd.com>
 <ZuR2t1QrBpPc1Sz2@google.com> <9a218564-b011-4222-187d-cba9e9268e93@amd.com>
Message-ID: <ZurCbP7MesWXQbqZ@google.com>
Subject: Re: [PATCH v11 19/20] x86/kvmclock: Skip kvmclock when Secure TSC is available
From: Sean Christopherson <seanjc@google.com>
To: "Nikunj A. Dadhania" <nikunj@amd.com>
Cc: linux-kernel@vger.kernel.org, thomas.lendacky@amd.com, bp@alien8.de, 
	x86@kernel.org, kvm@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, 
	dave.hansen@linux.intel.com, pgonda@google.com, pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 16, 2024, Nikunj A. Dadhania wrote:
> On 9/13/2024 11:00 PM, Sean Christopherson wrote:
> >> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> >> Tested-by: Peter Gonda <pgonda@google.com>
> >> ---
> >>  arch/x86/kernel/kvmclock.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> >> index 5b2c15214a6b..3d03b4c937b9 100644
> >> --- a/arch/x86/kernel/kvmclock.c
> >> +++ b/arch/x86/kernel/kvmclock.c
> >> @@ -289,7 +289,7 @@ void __init kvmclock_init(void)
> >>  {
> >>  	u8 flags;
> >>  
> >> -	if (!kvm_para_available() || !kvmclock)
> >> +	if (!kvm_para_available() || !kvmclock || cc_platform_has(CC_ATTR_GUEST_SECURE_TSC))
> > 
> > I would much prefer we solve the kvmclock vs. TSC fight in a generic way.  Unless
> > I've missed something, the fact that the TSC is more trusted in the SNP/TDX world
> > is simply what's forcing the issue, but it's not actually the reason why Linux
> > should prefer the TSC over kvmclock.  The underlying reason is that platforms that
> > support SNP/TDX are guaranteed to have a stable, always running TSC, i.e. that the
> > TSC is a superior timesource purely from a functionality perspective.  That it's
> > more secure is icing on the cake.
> 
> Are you suggesting that whenever the guest is either SNP or TDX, kvmclock
> should be disabled assuming that timesource is stable and always running?

No, I'm saying that the guest should prefer the raw TSC over kvmclock if the TSC
is stable, irrespective of SNP or TDX.  This is effectively already done for the
timekeeping base (see commit 7539b174aef4 ("x86: kvmguest: use TSC clocksource if
invariant TSC is exposed")), but the scheduler still uses kvmclock thanks to the
kvm_sched_clock_init() code.

The other aspect of this to consider is wallclock.  If I'm reading the code
correctly, _completely_ disabling kvmclock will case the kernel to keep using the
RTC for wallclock.  Using the RTC is an amusingly bad decision for SNP and TDX
(and regular VMs), as the RTC is a slooow emulation path and it's still very much
controlled by the untrusted host.

Unless you have a better idea for what to do with wallclock, I think the right
approach is to come up a cleaner way to prefer TSC over kvmclock for timekeeping
and the scheduler, but leave wallclock as-is.  And then for SNP and TDX, "assert"
that the TSC is being used instead of kvmclock.  Presumably, all SNP and TDX
hosts provide a stable TSC, so there's probably no reason for the guest to even
care if the TSC is "secure".

Note, past me missed the wallclock side of things[*], so I don't think hiding
kvmclock entirely is the best solution.

[*] https://lore.kernel.org/all/ZOjF2DMBgW%2FzVvL3@google.com

