Return-Path: <linux-kernel+bounces-218869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD2790C734
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3B1BB246B0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCC11527A8;
	Tue, 18 Jun 2024 08:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b="fNfv5I9Q"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86DA14EC64
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718699853; cv=none; b=T1hCxvzTS5SS8DKpTiV4HOey+OGk6Olu9tZrpvOtNKQPgw6QaPThoU5eZdo/so64Cdb4WC6exK/jUHzxE1H/GAax3loUvjUKYVnNjk3ox9gTwdQNOSd6TC57YVmWvvLBisb5JqHNTzzAXdVWB6tovIav88SqZNnhBVvI1TWSzC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718699853; c=relaxed/simple;
	bh=EZrrEdTGR3wfSwj9GagNuZDUkq9I2ZUD5+n1beC7TYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNkfzrYdjkZO8yp8EbZ+CpCJ68UKaaNZ0ivhvTP3jheAZ3ou4OAHaDnh+wXrtkIWUGaij7HrLfrIlmJhBTMD2oyxZ6YClkivJNUTLckyMHlVBbNvSiFCCBY6Zs/nPL14PVxFjUPi7SUfj4xvR/H1nTEmYAO/rLs9+7cCKTLZ5Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b=fNfv5I9Q; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f95be3d4c4so2003854a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 01:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.com; s=cloud; t=1718699851; x=1719304651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eb0RXj6kXsdM0uSSP81X1dIWEztXTh0vf9AdUTcavuo=;
        b=fNfv5I9Q8Gk8KkYVKrxJ6XfFj1mODMUy0nCZooHr8SL08g/Ae5Wo0gC7Zco4UwP0vs
         zwk6MmMm4KGGVkmRH3ZQZxjvypP0NpZt7DeCjjtD5kIufHf08OvNORCc1nui7W9E9be8
         /RUtbT4TziAKL1G0Z+EApb7Tza64CB3KZfLE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718699851; x=1719304651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eb0RXj6kXsdM0uSSP81X1dIWEztXTh0vf9AdUTcavuo=;
        b=Rkjf06f5ZiJV9H7Wuw0Wa4WhaskLANOYSMefPTmbeUv/Ry12CSjcXIzUi/Ke3ddceW
         Zau2pRWQ4cZTX68ChvnDmf8tqteBguPtH8py/iwPZs2kjCHgAd5kA96WJ3pczplZWao2
         jDtogjMR8MdtbPDDXIr5uw0w7pMCPCPKPM3yZYQ7wO9ThxKUQ8pC0ifDZcPw+ZDPnEih
         gTARMHopQDV1oe6+vdSwQBaLql1oYDSJcI0oZ0xWO47vhRmAZMQ8IYC7VrJ7N8jiVqXJ
         aX3mbQab3eeXj0c+6xpWgc1UBXSzVMm7bu/fp6MpTu+MSIhu8SiPa/amPNSiBs/jlxbS
         QHXA==
X-Forwarded-Encrypted: i=1; AJvYcCUjG+Km/FaCNPAIpdeMh1SnBJw5QrjoK+mKjSvY+Ns9zM4ooLBcbsLJlOtuvF0Gq0DDTL+kJ3q28G0quGn7869Q+FEwTrXS3lQZ1XFV
X-Gm-Message-State: AOJu0YwjEmyNkU3HLSUIu5Ud6TQQLCPDhK1ojavsNdAOR9+nITOZ/U03
	rMpWll66KXudemCFNC7OvV1XaiKqP++NS0q70jIS34jm+t8PvZr8FAuHsRfDDWGSUBBQMqVZqnM
	nIJ3EsjC46jBwl/3g3A/JLAaE5NWHDxDKF8L5sRiO1d7HZXuoe9ZrdUOI
X-Google-Smtp-Source: AGHT+IEWkf5j2W5kw2iqzjVXFFr/KNj2UxQ6QnKHSgfx22Hyq9qpLr4BXiXOgbfkFgo2DeJ1XRr/iFXuaj+25RD/LPA=
X-Received: by 2002:a05:6870:b011:b0:254:a89e:acca with SMTP id
 586e51a60fabf-2584258a3d9mr12682841fac.0.1718699850938; Tue, 18 Jun 2024
 01:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617141303.53857-1-frediano.ziglio@cloud.com>
 <2fe6ef97-84f2-4bf4-870b-b0bb580fa38f@suse.com> <ZnBKDRWi_2cO6WbA@macbook>
In-Reply-To: <ZnBKDRWi_2cO6WbA@macbook>
From: Frediano Ziglio <frediano.ziglio@cloud.com>
Date: Tue, 18 Jun 2024 09:37:08 +0100
Message-ID: <CACHz=Zg4Zoyr4KNeig4yDDNUxvV325beJEyT-L-K0a+FHp7oDg@mail.gmail.com>
Subject: Re: [PATCH] x86/xen/time: Reduce Xen timer tick
To: =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Cc: Jan Beulich <jbeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>, 
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, 
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 3:37=E2=80=AFPM Roger Pau Monn=C3=A9 <roger.pau@cit=
rix.com> wrote:
>
> On Mon, Jun 17, 2024 at 04:22:21PM +0200, Jan Beulich wrote:
> > On 17.06.2024 16:13, Frediano Ziglio wrote:
> > > Current timer tick is causing some deadline to fail.
> > > The current high value constant was probably due to an old
> > > bug in the Xen timer implementation causing errors if the
> > > deadline was in the future.
> > > This was fixed in Xen commit:
> > > 19c6cbd90965 xen/vcpu: ignore VCPU_SSHOTTMR_future
> >
> > And then newer kernels are no longer reliably usable on Xen older than
> > this?
>
> I think this should reference the Linux commit that removed the usage
> of VCPU_SSHOTTMR_future on Linux itself, not the change that makes Xen
> ignore the flag.
>

Yes, Linux kernel stopped using this flag since 2016 with commit
c06b6d70feb32d28f04ba37aa3df17973fd37b6b, "xen/x86: don't lose event
interrupts", I'll add it in the commit message.

> > > --- a/arch/x86/xen/time.c
> > > +++ b/arch/x86/xen/time.c
> > > @@ -30,7 +30,7 @@
> > >  #include "xen-ops.h"
> > >
> > >  /* Minimum amount of time until next clock event fires */
> > > -#define TIMER_SLOP 100000
> > > +#define TIMER_SLOP 1000
> >
> > It may be just the lack of knowledge of mine towards noadays's Linux'es
> > time handling, but the change of a value with this name and thus
> > commented doesn't directly relate to "timer tick" rate. Could you maybe
> > help me see the connection?
>
> The TIMER_SLOP define is used in min_delta_{ns,ticks} field, and I
> think this is wrong.
>
> The min_delta_ns for the Xen timer is 1ns.  If Linux needs some
> greater min delta than what the timer interface supports it should be
> handled in the generic timer code, not open coded at the definition of
> possibly each timer implementation.
>

I think this is done to reduce potential event handling frequency, in
some other part of timer code (in kernel/time/clockevents.c) there's a
comment "Deltas less than 1usec are pointless noise".
I think it's hard for a software to get a frequency so high so I
didn't propose 1ns.
What are you suggesting? To put 1ns and see what happens? Is there any
proper test code for this?

> Thanks, Roger.

Frediano

