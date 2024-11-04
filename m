Return-Path: <linux-kernel+bounces-395656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B0D9BC13D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 00:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EE1C1F22AC6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6471FCC78;
	Mon,  4 Nov 2024 23:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bz6OXLDZ"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D6D16087B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 23:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730761409; cv=none; b=VUgUk78/aJxHCbLKPHrwEmLTUP3k5OBa+xptL5XGUA9KOzM5xlhp1y/M6iIKwBGdBGJ5CI9chfUqHETmglMetIrsbyzw8fpLEXF8Jq4B99EWDVReXI27nkO73s/N63M+SrXCA+HtQ/OkZ9bRnZJ2Amnx7TUClKh5wSJsJAFBiW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730761409; c=relaxed/simple;
	bh=OFCzxIW1aRKuCDP4ZBg+/guooKUHjyfQX+U386WCXbc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CZFuO7Rnhe2Cwg33AL5e9HsxsA5syeNIzXhOFrjttXcBSrAaFHqHMXKZMOD+8zxaNRoAJFI7yUxB9O1WoN3Od/4Tao3LmlNuLZCDhctdpx+I3KJDdQyzPC7nsqABYDZm21JO4qHXPaJKTBZDdPclY+wjh6k+q6K/KfFu/4OxOMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bz6OXLDZ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-71e55c9d23cso3735263b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 15:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730761407; x=1731366207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T1Mz/8fwbax6GoRK0U2Dm3yySugCYydj6rxxh10aGxM=;
        b=Bz6OXLDZEseLIvsiRlfZJuI8lBOS9roFCaoPn5qHjwo1Jg1QcnvyGFsYKpo1FPffOt
         +Sjn2oXDL/1e87LGmTU9/lFAlAvoC4QvMpeO+Oe7YYHs68MoDVtAm3XNxT4rBIGPUWSP
         FuoFFJMLvoJK3bHoKAhe4liPeZXDQ8pnciapeescrJ7dGhmWRq1Ou6yLwZ0e0vhP8qSg
         BVvriDRLWghECn+wd2fNGskYLrsBDuyOaWE51LMc5bVJ+iKZ/WP1un1UJpy2nmncVEGs
         WwSDjBg/kTYPsoa2MuAemAoKFZ8YlhC0de1YK4OEdVO7tdllPGJFfiYnot3tEfWgXKRc
         8Ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730761407; x=1731366207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1Mz/8fwbax6GoRK0U2Dm3yySugCYydj6rxxh10aGxM=;
        b=FN3/nkRbw+Xcme5mMzYiAoPimQN+y8vZntOf99ng+k81EbzhK28sSCsO+6z4A1pfaV
         X/Mkoy7RuvU0AzoUA41FJjnK0keHqjYH/z2+eej6a6XRw+YsC26dPYfooJ07xhVqIfVb
         Dio4JOmg+9unvAZ4Q8XI9gVTREGgiM9ez2xEi/Ewod5zCk9ThwrOwXTQFN2B02/DtIKI
         /LjNAN4Ht9YBLPpGhkFsgf6zlfP+bd2SJzR6upFJuMPKLUqiTGUENmdiNfpu0bsKBUFn
         6DdAhMJMEuk8p82OFczsfBGJeDwGZaSvBdlG08B4cKBxjsfDh08fGRQ3FlcmeC//VBsT
         VtsQ==
X-Forwarded-Encrypted: i=1; AJvYcCURD++p12ftuhSkJgZbdp2iBCJROeT0ubKOBUO9pYVQ0NuH0jfuDLSQHuHdK7E9N9Yf68iJDjeO9t/htmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9sdN6pzwJBi6pEqf+S5Y2ST99kX0bRPwOpPlv4RhOUuRIFLaH
	1OB9ciijn08tccR95A3TXDeNYwU2DPJI7zo/E/w8pmFpzXflHZr/Y9rhzY7Lj0QQhZjEBTD2YjO
	gDA==
X-Google-Smtp-Source: AGHT+IEdrKErOUUlhVXttDB5QpU41vsiU/X3Aqyy8XyYnWrl10UXd7jO5Q2He9ErNzBvvYkhA7HYe8lJf1M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2790:b0:71e:6b3b:9f2d with SMTP id
 d2e1a72fcca58-720bc83e022mr67436b3a.1.1730761407408; Mon, 04 Nov 2024
 15:03:27 -0800 (PST)
Date: Mon, 4 Nov 2024 15:03:25 -0800
In-Reply-To: <004816c9b56ac5b9a56592578caa3a5941045788.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241101183555.1794700-1-seanjc@google.com> <20241101183555.1794700-10-seanjc@google.com>
 <004816c9b56ac5b9a56592578caa3a5941045788.camel@intel.com>
Message-ID: <ZylSvX4yjYyhVJxC@google.com>
Subject: Re: [PATCH v2 9/9] KVM: x86: Short-circuit all of kvm_apic_set_base()
 if MSR value is unchanged
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 04, 2024, Kai Huang wrote:
> On Fri, 2024-11-01 at 11:35 -0700, Sean Christopherson wrote:
> > Do nothing in from kvm_apic_set_base() if the incoming MSR value is the
> > same as the current value, as validating the mode transitions is obviously
> > unnecessary, and rejecting the write is pointless if the vCPU already has
> > an invalid value, e.g. if userspace is doing weird things and modified
> > guest CPUID after setting MSR_IA32_APICBASE.
> > 
> > Bailing early avoids kvm_recalculate_apic_map()'s slow path in the rare
> > scenario where the map is DIRTY due to some other vCPU dirtying the map,
> > in which case it's the other vCPU/task's responsibility to recalculate the
> > map.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/lapic.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> > index 7b2342e40e4e..59a64b703aad 100644
> > --- a/arch/x86/kvm/lapic.c
> > +++ b/arch/x86/kvm/lapic.c
> > @@ -2582,9 +2582,6 @@ static void __kvm_apic_set_base(struct kvm_vcpu *vcpu, u64 value)
> >  	u64 old_value = vcpu->arch.apic_base;
> >  	struct kvm_lapic *apic = vcpu->arch.apic;
> >  
> > -	if (old_value == value)
> > -		return;
> > -
> 
> Could you clarify why this is removed?  AFAICT kvm_lapic_reset() still calls
> directly.

It does, but in that case, @old_value is guaranteed to be zero, and @value is
guaranteed to be non-zero, i.e. the check is unnecesary.  At that point, the
check in __kvm_apic_set_base() is 100% dead code, and I think it would do more
harm than good, e.g. might confuse readers.

I thought about adding a WARN, but that seems excessive.

That said, the changelog definitely needs to explain why the check is moved from
__kvm_apic_set_base(), as opposed to another check being added.  How about this?

--
Do nothing in all of kvm_apic_set_base(), not just __kvm_apic_set_base(),
if the incoming MSR value is the same as the current value.  Validating
the mode transitions is obviously unnecessary, and rejecting the write is
pointless if the vCPU already has an invalid value, e.g. if userspace is
doing weird things and modified guest CPUID after setting MSR_IA32_APICBASE.

Bailing early avoids kvm_recalculate_apic_map()'s slow path in the rare
scenario where the map is DIRTY due to some other vCPU dirtying the map,
in which case it's the other vCPU/task's responsibility to recalculate the
map.

Note, kvm_lapic_reset() calls __kvm_apic_set_base() only when emulating
RESET, in which case the old value is guaranteed to be zero, and the new
value is guaranteed to be non-zero.  I.e. all callers of
__kvm_apic_set_base() effectively pre-check for the MSR value actually
changing.  Don't bother keeping the check in __kvm_apic_set_base(), as no
additional callers are expected, and implying that the MSR might already
be non-zero at the time of kvm_lapic_reset() could confuse readers.
--

