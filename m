Return-Path: <linux-kernel+bounces-569494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452B5A6A3AE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3798A0EBC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F79224254;
	Thu, 20 Mar 2025 10:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4a3gN06"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFF01E231F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742466619; cv=none; b=P6+9nQa2hHwGYrtUMXi6t5bdMKrIYe+/hQRqtQA42fGyZ3ruVBkyzzT65i3QqwB4TvwCLDJqKtW4O81Ifw646PuZZSsJph52XRd2Mh9wvJ4dvsPLIqTkE+gBiK6+Nzn26baH2/ZzAp60LKGmE+PBZje8Tb0N0Hras8zicbBtNCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742466619; c=relaxed/simple;
	bh=QEcVLOrybX9veWH2QWEzGvEcx2Yh4oGQyodaSAZ1Yqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5aUnMYzG66BGta5Swlq5oUhEvKy9q8EDIvD5jLiNjr0ApEw+6tWjvBL2TNMJ/Xs0989wagIJf3k/beyPneu3Yxty+D7LqKN7rcfjAmUjcGejls8bfLV0eE6bdwCc15u62xEwmsWLv14ngD2u4ISV9n/KpTbJD+9N2S7/vYq3+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4a3gN06; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30795988ebeso6116911fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 03:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742466616; x=1743071416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBoD8P0IJhjSl0p0g5lSdkN0D0kbyrVmDP9Fb2cdiRA=;
        b=S4a3gN065rS9W5ubiZdnd/at5L3bACSuFqiJxOVk2spCCyxOBz6issst6PeJPT3Ruq
         f1E9lxC0Qt3zCoKuWh9l/6gKwX6apKOv3P3aoTGbwvnuq8tu+l4MdNo8kepnap+pPWxy
         QcMLlFVNNgWgMzQPJw0RS8bNU2WLonseoPV+TKnPlTWbq3xdZMX7+C4s8nq7qQQmCDgO
         2pvs3ucJGjzDjixNAmcvhISZ8qxss1UdCIqcYEfPSzR/WO+MIBgMf4Mu+almnv4aPvWZ
         zlf4KhYAKnrmXIKuryP52VAQef0QQh4xANctgpC4QkuGWxhEdUPhRv+iyol8R2M1cVJL
         6dQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742466616; x=1743071416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBoD8P0IJhjSl0p0g5lSdkN0D0kbyrVmDP9Fb2cdiRA=;
        b=h4YHmby4PnnO4B2FS/vrl/hFrj2yU/mJP7Y60/1rhhvjNqWOzqwSimeedpAM38c5Fk
         TLdshXN5J1Bvo/4EDlmE8Gp4PmJoOHL0pTB1AYUOpYJ9AGu1KmIK+997+z1hTHzV1JyY
         TvVhe5bL3Tans7UdfxCnrh1LvLRtyQYjj+G8HBSJztx7pTMtpIYw1E7lhFD7HVa9Sm70
         V8zDROp2iWc6BdXXecmWU072jZgP6MvRHH+oTs7DhC60sl94Q0IZcz6s+y7s71YBRH53
         xvJoqV6/g/GV59R0brODkVScYJEwLnVURaUAqQWuUI3UVjLQhBuEAittLTJoWLZeYg67
         xPPA==
X-Forwarded-Encrypted: i=1; AJvYcCWqISn0aiEOhqsG1Sq08pN3ALhYDA4a55Tn+Larks/WLDeH/HJmbtpzOrUSQwqEwSLZ4wAz0SwJekqveUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBJUPQAeqesF7AUkV8jUb3LN5rIVSiUi8p5WQQpwwmFaOPucGw
	FF+Zdzt4kao2vRQbMKJ5Rnr+RgYWkQhg2FFgBpden6Q26CO91VTpLPo3d47Mw+W7bXNiIdwWOP8
	LuJYNvriZRq2Pk/iO719qxirUW6A=
X-Gm-Gg: ASbGncuG4UquspPzxyA8TSxE3BfCeWP5EbELN/MOQwhy4/9YCMiY09jk5N/ECdvHhQY
	ZADtyP2xa/gphxhSY6huK407VbAj6nZp+/JiDNMVITL+D7bOvqzwUcPmQR0Nc/PpLTvvahC3RS4
	q4PlGBD1L+zF338PcxSxt11uNS+VphwzdjAfCO
X-Google-Smtp-Source: AGHT+IG1pxrCPicgmF56C4o9zOaP1o1MypdnxKIq8dagms2ek9IqztzJ34n2T26QUUoKU5JvUSK0VuyA/OB5So85qIw=
X-Received: by 2002:a2e:8015:0:b0:30b:f2d6:8aab with SMTP id
 38308e7fff4ca-30d6a464949mr22406921fa.32.1742466615360; Thu, 20 Mar 2025
 03:30:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317221824.3738853-1-mingo@kernel.org> <5A417EE0-8DF3-4C6E-A7E9-9EE6705282F1@zytor.com>
 <Z9m1rtmlk1PxGIQA@gmail.com> <CAHk-=whAUHyXM29_9w_T26=15D1KZnuR3R+f4MT9f-C89oukvA@mail.gmail.com>
 <Z9m_kUqxqMPfU8Fl@gmail.com> <Z9nTfFiPv0-Lxm-_@gmail.com> <CAFULd4aFUun7+1izxbDM8nTEEta5PApysyTGsn1hjvQND=2UtQ@mail.gmail.com>
 <Z9tGh0Fa96gACmpQ@gmail.com> <CAFULd4bxUOiPLQ9aaZFx2jsLUwEPH0h=XiCOtxYn+Z8JEAeHUw@mail.gmail.com>
 <Z9vY8Bm1Wv1vkqNO@gmail.com>
In-Reply-To: <Z9vY8Bm1Wv1vkqNO@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 20 Mar 2025 11:30:04 +0100
X-Gm-Features: AQ5f1Jr5bKkMPyT3ml3M5WeR4ItKcjbgJYUCv_5BAGZ96XyLSXPlMikKeEJmj_0
Message-ID: <CAFULd4ZZ6rjG=LTQX6hsrqp6BQ5XcRW7kQ_rzHKrOxKCu51=sw@mail.gmail.com>
Subject: Re: [PATCH] compiler/gcc: Make asm() templates asm __inline__() by default
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, "Ahmed S . Darwish" <darwi@linutronix.de>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, John Ogness <john.ogness@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 9:59=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > > > > I haven't looked at code generation much yet, but text size chang=
es are
> > > > > minimal:
> > > > >
> > > > >       text         data     bss      dec            hex filename
> > > > >   29429076      7931870 1401196 38762142        24f769e vmlinux.b=
efore
> > > > >   29429631      7931870 1401200 38762701        24f78cd vmlinux.a=
fter
> > > > >
> > > > > Which is promising, assuming I haven't messed up anywhere.
> > > >
> > > > Please use bloat-o-meter, it is more precise.
> > >
> > > Here's the bloat-o-meter output between vanilla and patched vmlinux:
> >
> > [...]
> >
> > > A lot fewer functions are affected than I expected from such a
> > > large-scope change.
> >
> > Interestingly, I got *many* more changes just from converting atomic
> > locking functions to asm_inline, as reported in [1].
> >
> > [1] https://lore.kernel.org/lkml/CAFULd4YBcG45bigHBox2pu+To+Y5BzbRxG+pU=
r42AVOWSnfKsg@mail.gmail.com/
>
> Have you used a pristine x86-64 defconfig for your build tests?

Yes, it was vanilla x86-64 defconfig, but in -tip tree.

> Could you perhaps check my patch against your patch in your build
> environment and figure out why there's such unexpected differences?
>
> As you noted my patch should be a blunt-instrument superset of your
> changes so if then it should affect *more* functions, not fewer.

Yes, I'll try this experiment.

Thanks,
Uros.

