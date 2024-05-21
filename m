Return-Path: <linux-kernel+bounces-185130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC198CB0ED
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A47A1F2248F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E3B7F7C1;
	Tue, 21 May 2024 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="vzoyxWOS"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EACD39AF9
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716303744; cv=none; b=ScQ9a9vbw/9UL8eKpMJuWEystTTb5heXfycrHYAouJlOZi6eiJqYSxGYB38AjSE86Wkpc3cmLFfywZqHFoj84nUhgxmD7GQfZu7PnFHuLDLyVLQekJA0olSdOjDyS5qd1i5HVhFFbrs56fX/yF48iFMzXaOB9WpoMaIRXwuCPkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716303744; c=relaxed/simple;
	bh=2gdPp9oYLqQf/RP21Dj3aRzPOWXXvW43KLiglLnZLhA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nh4n3N/GtFHpKUyC1uQetP/OJfbAmhk8G/OCbGSeomVSBK5zDXJgqzINghVfZ20Vpz5OkQYgzyWJgjaPanhvhcqcBd5x/rCffDh/ixN0u1GYZ0A7l8HL+kt/webdtr6KRHq0B+PZviGY+fvxnxTdse4hh3oHv0BdT4MbS2gv6nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vzoyxWOS; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de59e612376so18738003276.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 08:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716303741; x=1716908541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rA84hVBnpCIrwTsdUfOtT5LNCN3IxRZXsCw7UuzC1H8=;
        b=vzoyxWOS2lPdCvgfCJJ3IMJxDJzAgiTgHqsw5KWQHKRmgEAjm4r4jU5L2d7WnuR727
         617jRsiyr+xh2yAw3t+YeDxpQqUrcO7BRuadxd1R6jZbSqo2kjBbbX8tcqPhFH1Mc4Tx
         0TRs4uoxpp9VHQlx+diyhdCDKJCHWjEebOXsoA4S/BeBv+UYivAWhMjP/D3S1JVdMCQ1
         uPAsBDerLmR1NO4celzW18KeXP3u7liU3GodfxphC45XK8gU2zQhyGnuw4johzr7HvTx
         K/tI+VDb+8uYAlwnXwCU8F36tEhk35v9WRUQnxDzMxz5UmkIAg8XAVA2+WpuI9la1bRU
         q2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716303741; x=1716908541;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rA84hVBnpCIrwTsdUfOtT5LNCN3IxRZXsCw7UuzC1H8=;
        b=JrikIxP2U3pByhOhsuAgONkbX9xWCYkzHsIw+GH4BgiYEujUEeZivgbXN806SWULEF
         zo1+wIuSS3ZZQj0pjMz5DsN4fS07i6ontKv5cRW/pk7waeEX10e7tz0wlTBFvMi7Ek7J
         6jZ3xltxFMjYj3ioS5ysQoqMl+9Yalt+KIdqluuzIM9/WtZsmaCQkGgipAwHJoas31zR
         6DHtFpjP3AicFXEaQOxPBvuNEIgu8HjKBKnt10N0/Qy+85NecRqZiaVnuDaKbYfird/v
         EhSryRe6p8jImRkWuLBl/y1kF2HoSyGwqJlrFsrqkxlShJ8JbzytfCG7rU8ZBcx83bAU
         S0sw==
X-Forwarded-Encrypted: i=1; AJvYcCVJwG8bHET3xRarxv4dUsVvazGTEccQyisAKT13s/F7xS80mLQLBItm+fJIWWyhkQm8thsKmgor0NpOQT7zui1jVwjLtMJpdg7I/3PM
X-Gm-Message-State: AOJu0YyOLxETl5etdVWWhDP2ByWXyu1BMI7ufIaFx+DnZwk1jz/iNUYS
	zOiuRYoNeo/EoUDkVq5cDWLzCc+UbBBhY2Xt9COt37vhgtG7Xw2vum4q8y7of7yGn0KIO6Dnvut
	ENQ==
X-Google-Smtp-Source: AGHT+IG6HYZ26nAMqxybqcYqauiCVba2xS61d5ebnHm0QJwNQYKpaO1QKV845PfyQA5Qs6SlU48zpoy8n/0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1142:b0:df1:d00c:130c with SMTP id
 3f1490d57ef6-df1d00c1507mr1678473276.5.1716303741597; Tue, 21 May 2024
 08:02:21 -0700 (PDT)
Date: Tue, 21 May 2024 08:02:20 -0700
In-Reply-To: <36b8df1d-593e-44c0-b34d-eb158e5ebabe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240520115334.852510-1-zhoushuling@huawei.com>
 <Zktd8QHU84_EdaNb@google.com> <36b8df1d-593e-44c0-b34d-eb158e5ebabe@huawei.com>
Message-ID: <Zky3fJPiOi8cpPSI@google.com>
Subject: Re: [PATCH] KVM: LAPIC: Fix an inversion error when a negative value
 assigned to lapic_timer.timer_advance_ns
From: Sean Christopherson <seanjc@google.com>
To: zhoushuling <zhoushuling@huawei.com>
Cc: pbonzini@redhat.com, weiqi4@huawei.com, wanpengli@tencent.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024, zhoushuling wrote:
> > On Mon, May 20, 2024, zhoushuling@huawei.com wrote:
> > diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
> > index 0a0ea4b5dd8c..6fb3b16a2754 100644
> > --- a/arch/x86/kvm/lapic.h
> > +++ b/arch/x86/kvm/lapic.h
> > @@ -54,6 +54,7 @@ struct kvm_timer {
> >          u32 timer_advance_ns;
> >          atomic_t pending;                       /* accumulated trigger=
ed timers */
> >          bool hv_timer_in_use;
> > +       bool timer_advance_dynamic;
> >   };
>=20
>=20
> However=EF=BC=8CI do not understand why the global function switch
> 'lapic_timer_advance_dynamic' > is changed to a local variable in the 'st=
ruct
> kvm_timer'.  On a host, the adaptive tuning of timer advancement is globa=
l
> function, and each=C2=A0vcpu->apic->lapic_timer.timer_advance_dynamic of =
each VM
> is the same, different VMs cannot be configured with different switches.

..

> =C2=A0static int __read_mostly lapic_timer_advance_ns =3D -1;
> =C2=A0module_param(lapic_timer_advance_ns, int, 0644);

The module param is writable, i.e. can be modified while KVM is running.  E=
g. if
the admin changes lapic_timer_advance_ns from a negative to a postive value=
, then
vCPUs that were created while lapic_timer_advance_ns<0 will have a timer_ad=
vance_ns
that was dynamically calculated, but is now static.  I doubt there's a use =
case
that actually does anything like that, and in practice it probably doesn't =
cause
real problems, but it makes for bizarre and unpredictable behavior.

Hmm, alternativately, we could make lapic_timer_advance_ns a read-only bool=
ean.
The param is wrtiable primarily because dynamic/adaptive tuning was added m=
uch
later, i.e. getting a usable value required modifying the advancement time =
while
VMs were running.  But I would be very surprised if there are use cases tha=
t still
*need* to hand tune the advancement, as it's practically impossible for use=
rspace
to do better than KVM.

The only argument I can think of for taking a raw value from userspace is i=
f there
is an absurd delay that exceeds KVM's max advancement of 5us.  But I'm not =
sure
KVM should even support such values.

Let me post a patch to convert lapic_timer_advance_ns to a read-only bool. =
 If
there is pushback on that idea, then we can circle back to this patch, but =
I'm
hoping we can simplify all of this instead of hardening KVM against edge ca=
ses
that no one likely cares about.

Side topic, if we keep the module param as-is, it really should be wrapped =
with
READ_ONCE().

