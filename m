Return-Path: <linux-kernel+bounces-293929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CEB9586A3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1034B2401D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96AA18FC89;
	Tue, 20 Aug 2024 12:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrDwFzcy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3543118F2D5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155995; cv=none; b=sWRv+nB+JxcmbZP4/g8LwrLsQlAOo2DL/2yJiJxk3OTGaiqcxThHVbIwjMkGRM5i4iiXE1U8BEda+WfLjhJ9z04YoclLoYn+aiyMG1UNkqlJIXD4oHLzE64UJhyWPQaJMJeC4sOd4GkKYWB8MJio8S1n6c9PhB+oMk4AL9DYC28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155995; c=relaxed/simple;
	bh=CoUJSJEOY+AD70nQdwXhTuAMdIpi3c3yBUXbO52Nu8w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uEKR7ie97+uT2LwrqdP5ipO4ingY8fkdH/BaBOguED3/hnnWHQSa98pibXnSPJQclByPMzqRCrDlyTA4mQ5KqcP6JClOYiEiRCfVQzl/bURmL1uT+RfiqRWn5TlQmmOEI4xqADfEUxOU3JohSSRIYJ/9qOiEata4CAAEpx1dBrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MrDwFzcy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724155992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vb++bCC8FYQ7kr3j17L2pvrqNCN0LH413bDrfxJr0Ms=;
	b=MrDwFzcymNTdb2BSMT6OlJ6XO9EbLWlzs5IjTR1/loe9D3wGzuKzquPSg3FpS9SDdsJxWR
	oPExZhUxzG8j98sat0vLieReZ5tyV2R51b7NT5KmXamooMbic+yE+QhFU5df0hGVtKug+9
	WxFVFJkwjJVOv+RZXCLSkcNmeCvLARU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-WSPDPLtYNZa8cjMLRw9EQw-1; Tue, 20 Aug 2024 08:13:08 -0400
X-MC-Unique: WSPDPLtYNZa8cjMLRw9EQw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4280e1852f3so47266115e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 05:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724155987; x=1724760787;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vb++bCC8FYQ7kr3j17L2pvrqNCN0LH413bDrfxJr0Ms=;
        b=heWSgCDbPfe8XFLFUjAoLb7c8D4Pts+Z+kEI2wsE+VzldaY8LBgb6S1JrJ3oHiRn97
         0o+0HVNmbePkHN1YlxcOGmCXTEwxaQpNiJQyXJyv9nsj1d+V8YatAdvYvZNUEOJO9H6U
         eW6lAD5QUPBrlB4Zg2hDLRa0a3ITolS5I51twQNJkSTX3t4rt50xv6fYEwFcx2Ig04Hd
         kRZVsioliNORbIfTuTKgcU4ur/clp/QS9prwOvRsQJV+zj4hf/wEeUVaTD7BKGBjOnMi
         s+HO1Ktzm2b0iObVxk569ZNyVEsDf9w6cbGtYsASbcmaRG/ckc0PKMAyPNsfDcAlgTUb
         76nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY+FtJGkznFb/Sa9PIs5nyc2F90XLWH2+OuUd86tBU4zm1zxi/K7ZJxME2LulXq6bveo6K/gHYHw+n+NO5a55kViSo9ZwJjgLkb/77
X-Gm-Message-State: AOJu0YwVn6ysxfIQM3gBXhYKR/o9GPia16Hq3FT78njyRYb9xv4BoBYa
	qUo9jj3nghMufhvFeoWpEYPnTUXoAqr/FFzhLJ48ecYoJ8+1/2bOHXQlIHqC5gkqC8spSjRcpGu
	yjSAfWE881zK1bgcvU0q/MjV6Jg7AliW+hDGhLrJ3qpYA8MFVNahdW9Zvbn//uLhX/xgLLA==
X-Received: by 2002:a05:600c:3047:b0:426:8884:2c54 with SMTP id 5b1f17b1804b1-42a6e08e134mr71252295e9.35.1724155987443;
        Tue, 20 Aug 2024 05:13:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiA+dVXDpiOyzS3SSDsVNVQZAM6GV5dwzSOz0YEVlKtnCtAG9mpX45+Hon7C9AbLlil0KY3w==
X-Received: by 2002:a05:600c:3047:b0:426:8884:2c54 with SMTP id 5b1f17b1804b1-42a6e08e134mr71252105e9.35.1724155986893;
        Tue, 20 Aug 2024 05:13:06 -0700 (PDT)
Received: from intellaptop.lan ([2a06:c701:77ab:3101:d6e6:2b8f:46b:7344])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed649004sm141914785e9.4.2024.08.20.05.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 05:13:06 -0700 (PDT)
Message-ID: <fa69866979cdb8ad445d0dffe98d6158288af339.camel@redhat.com>
Subject: Re: [PATCH v3 1/4] KVM: x86: relax canonical check for some x86
 architectural msrs
From: mlevitsk@redhat.com
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>, 
 linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Chao Gao
 <chao.gao@intel.com>
Date: Tue, 20 Aug 2024 15:13:04 +0300
In-Reply-To: <Zr_JX1z8xWNAxHmz@google.com>
References: <20240815123349.729017-1-mlevitsk@redhat.com>
	 <20240815123349.729017-2-mlevitsk@redhat.com> <Zr_JX1z8xWNAxHmz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

=D0=A3 =D0=BF=D1=82, 2024-08-16 =D1=83 14:49 -0700, Sean Christopherson =D0=
=BF=D0=B8=D1=88=D0=B5:
> > > > On Thu, Aug 15, 2024, Maxim Levitsky wrote:
> > > > > > > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > > > > > > index ce7c00894f32..2e83f7d74591 100644
> > > > > > > > --- a/arch/x86/kvm/x86.c
> > > > > > > > +++ b/arch/x86/kvm/x86.c
> > > > > > > > @@ -302,6 +302,31 @@ const struct kvm_stats_header kvm_vcpu=
_stats_header =3D {
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 sizeof(kvm_vcpu_stats_desc),
> > > > > > > > =C2=A0};
> > > > > > > > =C2=A0
> > > > > > > > +
> > > > > > > > +/*
> > > > > > > > + * Most x86 arch MSR values which contain linear addresses=
 like
> > > >=20
> > > > Is it most, or all?=C2=A0 I'm guessing all?

I can't be sure that all of them are like that - there could be some outlie=
rs that behave differently.

One of the things my work at Intel taught me is that there is nothing consi=
stent
in x86 spec, anything is possible and nothing can be assumed.

I dealt only with those msrs, that KVM checks for canonicality, therefore I=
 use the word=C2=A0
'most'. There could be other msrs that are not known to me and/or to KVM.

I can write 'some' if you prefer.

> > > >=20
> > > > > > > > + * segment bases, addresses that are used in instructions =
(e.g SYSENTER),
> > > > > > > > + * have static canonicality checks,
> > > >=20
> > > > Weird and early line breaks.
> > > >=20
> > > > How about this?
> > > >=20
> > > > /*
> > > > =C2=A0* The canonicality checks for MSRs that hold linear addresses=
, e.g. segment
> > > > =C2=A0* bases, SYSENTER targets, etc., are static, in the sense tha=
t they are based
> > > > =C2=A0* on CPU _support_ for 5-level paging, not the state of CR4.L=
A57.
> > > >=20
> > > > > > > > + * size of whose depends only on CPU's support for 5-level
> > > > > > > > + * paging, rather than state of CR4.LA57.
> > > > > > > > + *
> > > > > > > > + * In addition to that, some of these MSRS are directly pa=
ssed
> > > > > > > > + * to the guest (e.g MSR_KERNEL_GS_BASE) thus even if the =
guest
> > > > > > > > + * doen't have LA57 enabled in its CPUID, for consistency =
with
> > > > > > > > + * CPUs' ucode, it is better to pivot the check around hos=
t
> > > > > > > > + * support for 5 level paging.
> > > >=20
> > > > I think we should elaborate on why it's better.=C2=A0 It only takes=
 another line or
> > > > two, and that way we don't forget the edge cases that make properly=
 emulating
> > > > guest CPUID a bad idea.

OK, will do.

> > > >=20
> > > > =C2=A0* This creates a virtualization hole where a guest writes to =
passthrough MSRs
> > > > =C2=A0* may incorrectly succeed if the CPU supports LA57, but the v=
CPU does not
> > > > =C2=A0* (because hardware has no awareness of guest CPUID).=C2=A0 D=
o not try to plug this
> > > > =C2=A0* hole, i.e. emulate the behavior for intercepted accesses, a=
s injecting #GP
> > > > =C2=A0* depending on whether or not KVM happens to emulate a WRMSR =
would result in
> > > > =C2=A0* non-deterministic behavior, and could even allow L2 to cras=
h L1, e.g. if L1
> > > > =C2=A0* passes through an MSR to L2, and then tries to save+restore=
 L2's value.
> > > > =C2=A0*/
> > > >=20
> > > > > > > > +
> > > > > > > > +static u8=C2=A0 max_host_supported_virt_addr_bits(void)
> > > >=20
> > > > Any objection to dropping the "supported", i.e. going with max_host=
_virt_addr_bits()?
> > > > Mostly to shorten the name, but also because "supported" suggests t=
here's software
> > > > involvement, e.g. the max supported by the kernel/KVM, which isn't =
the case.

Doesn't matter to me.

> > > >=20
> > > > If you're ok with the above, I'll fixup when applying.
> > > >=20

Best regards,
   Maxim Levitsky


