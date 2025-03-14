Return-Path: <linux-kernel+bounces-561908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59604A61862
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33C11899EDC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E132046A3;
	Fri, 14 Mar 2025 17:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJE9vxU4"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437171FDE35
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974231; cv=none; b=LyH1YgOVldYUTQF+vFX4IMBB4ep8kAbxm4j59OAqNwc0nIURlVAGebiggj+XxBZRNqcxnA1DOEgjaajkhOgEOpHGXfKVFei+hf2vOGS8vb5/im6cwQTtbdU4zMs3hQ71XJxGKfcE1tX+bFah+u1LwLjRaqOHgJJx/8RbqYBVoFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974231; c=relaxed/simple;
	bh=XhaNcmuE10l6/S8CyJvJkk8I/TByojuWNMX/6aPcKDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UYAoOGm/kxp4mnJ9VUx7BgFIqadBuNzbOxiTXwYgcj0uka3YZ/At1VA8HzG16H3ceqzv28cQN3jNPlcjRQsN+Nkbur1E1XkcPuBKjWorWcks6fT6LaD3FVG8QYTHA4slcurvG51EdKTezIpotVd/BXFOU151qbXJXFk1IdnI92Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJE9vxU4; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54957f0c657so2349206e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741974227; x=1742579027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJhDWLJWS7HSLIfh1hXMJW28ZH0jFcLf2vud/VxBH9Q=;
        b=dJE9vxU4UOYYzO3Wm54pW2p+dRxsqwLQPPSeyV8bz3WCntJKJpdUcUkPhlkEySRDWR
         lfc7flgcgJsFF4TTjtlicY0PAh/YZsp6nM/1NFTG2thJJptVAwHBlGX2cleu8wvJtkBS
         7/wfsF14TIXSP6jY4CUoTNFRgOz1GuzdTj4sItv5jAP5Wjn+Oj7V23+kQQLD0vEb5Bt0
         0JK4BdyI3GqVH5VsNuaS8IhtjNtnwYyVX1IlTRWJuocvB7IRsel7gj5/V/Ia6OS2YvKl
         aHA0iIf8sfyVYsbp3eqKhtMl6E8T8wz4kHjZ7U/61MD0bphRes2e3arJ4w5TYWJ7YWwy
         lnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741974227; x=1742579027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJhDWLJWS7HSLIfh1hXMJW28ZH0jFcLf2vud/VxBH9Q=;
        b=fcCWn5ljd8nondoL87JYjCYSNovq3+Mb97isIKKg+YZsuhCWjq8sdhCmFicmZX7/Xc
         D0JxEZVxTaMYFgy5+ndIKRgCB5Axe5U+qdow2slzvMoJv8hxkbCRbeNH0IN51apZ1Dny
         MGM9tqO/ndqwK6RsinrRictSJ7Obx2bgU7zxgYX0ukSV5/SroIr3Hwm7ZVdbEk5HfdHQ
         d82PgmGZea3ICs0qV4HuAC0pQcG9AtabIL0vW/I7WagnQmg0hT1VyYVGRVW5+cGr0I5z
         d0xySc8Mnx1SPc0LE1s4e6CVXyhFPS7s1u8MRuHV7rU1GbSUz8yhPcZQNnhd3DmZAE/a
         lR8w==
X-Forwarded-Encrypted: i=1; AJvYcCUS2giIRi7hXZ3t9H49F+Idvd13jvBgT/HlH8Z2Pwa9EzCqI5CRTnzXA0G09JQhIfh51dJewOmhGa5qvuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJNw7lHC1fIOz8XeEp4wNKoAIZUhVKkrr8vIon9o+dBw3AFNN1
	wHguFMds8oagMXv2BIpuYq4WQqi0L2NCgDrtrRaDR5KXTqeWCZb7Le3LfR1++Yl0Akwgn5xTI3p
	rG9INH/LyIubFsHm5ATjYvhC2dQ==
X-Gm-Gg: ASbGnct+T5L7T7jABkBm9RLysXxwthPBMgFB86dRbF27y6szAWfbWxDMr1IT9MeW1/f
	D1aDuomfxgJiqRp/Iudg0rvMawTf5gHADRWVEtpxoTdDJP9fKYDg7Ly2M54VUNTeqnAt4sZ/fRF
	vO6uSaXbKt7jOtPBuY58QI0GNSnBjdZX3GxszceKOCEQ3apUof3yE=
X-Google-Smtp-Source: AGHT+IGtA7V24EIFtA+RGqQ7J7Kkssu+V4zti2eYn4iMiUBI56+6d/tDPu9+kejKHl6mj/uFGowEilLk9W0nE5qsBlI=
X-Received: by 2002:a05:6512:1109:b0:549:90ac:cca2 with SMTP id
 2adb3069b0e04-549c3ef8526mr1346905e87.1.1741974226739; Fri, 14 Mar 2025
 10:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314151220.862768-1-brgerst@gmail.com> <20250314151220.862768-8-brgerst@gmail.com>
 <b72d0040-99a3-4f20-9557-099d00b1b3ae@intel.com>
In-Reply-To: <b72d0040-99a3-4f20-9557-099d00b1b3ae@intel.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Fri, 14 Mar 2025 13:43:34 -0400
X-Gm-Features: AQ5f1JolAfyPUsOGnvN88TmRPovgH1cFvG1sz_b2M_KHi6PMFA4ODzn_QHwu2Hg
Message-ID: <CAMzpN2gTiPKKsQsg48MEx_OawX60nAbhxRxqkwXa3NGHfBhfHQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] x86/syscall/32: Add comment to conditional
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	X86-kernel <x86@kernel.org>, LKML Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 1:19=E2=80=AFPM Sohil Mehta <sohil.mehta@intel.com>=
 wrote:
>
> On 3/14/2025 8:12 AM, Brian Gerst wrote:
> > Add a CONFIG_X86_FRED comment, since this conditional is nested.
> >
> > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > Suggested-by: Sohil Mehta <sohil.mehta@intel.com>
> > ---
> >  arch/x86/entry/syscall_32.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
> > index 993d72504fc5..2b15ea17bb7c 100644
> > --- a/arch/x86/entry/syscall_32.c
> > +++ b/arch/x86/entry/syscall_32.c
> > @@ -238,7 +238,8 @@ DEFINE_FREDENTRY_RAW(int80_emulation)
> >       instrumentation_end();
> >       syscall_exit_to_user_mode(regs);
> >  }
> > -#endif
> > +#endif /* CONFIG_X86_FRED */
> > +
> >  #else /* CONFIG_IA32_EMULATION */
> >
> >  /* Handles int $0x80 on a 32bit kernel */
>
> Also, there seem to be a couple of adjacent CONFIG_IA32_EMULATION
> sections in the file. It might be better to bring them together under
> one section in this patch or a follow-up. Something like below:
>
> > diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
> > index 2b15ea17bb7c..a84f9d3c1695 100644
> > --- a/arch/x86/entry/syscall_32.c
> > +++ b/arch/x86/entry/syscall_32.c
> > @@ -57,16 +57,6 @@ static __always_inline int syscall_32_enter(struct p=
t_regs *regs)
> >         return (int)regs->orig_ax;
> >  }
> >
> > -#ifdef CONFIG_IA32_EMULATION
> > -bool __ia32_enabled __ro_after_init =3D !IS_ENABLED(CONFIG_IA32_EMULAT=
ION_DEFAULT_DISABLED);
> > -
> > -static int __init ia32_emulation_override_cmdline(char *arg)
> > -{
> > -       return kstrtobool(arg, &__ia32_enabled);
> > -}
> > -early_param("ia32_emulation", ia32_emulation_override_cmdline);
> > -#endif
> > -
> >  /*
> >   * Invoke a 32-bit syscall.  Called with IRQs on in CT_STATE_KERNEL.
> >   */
> > @@ -87,6 +77,14 @@ static __always_inline void do_syscall_32_irqs_on(st=
ruct pt_regs *regs, int nr)
> >  }
> >
> >  #ifdef CONFIG_IA32_EMULATION
> > +bool __ia32_enabled __ro_after_init =3D !IS_ENABLED(CONFIG_IA32_EMULAT=
ION_DEFAULT_DISABLED);
> > +
> > +static int __init ia32_emulation_override_cmdline(char *arg)
> > +{
> > +       return kstrtobool(arg, &__ia32_enabled);
> > +}
> > +early_param("ia32_emulation", ia32_emulation_override_cmdline);
> > +
> >  static __always_inline bool int80_is_external(void)
> >  {
> >         const unsigned int offs =3D (0x80 / 32) * 0x10;

The 32-bit syscall code is a bit of a mess right now, and it was hard
to see its state while it was lumped in with everything else in
common.c.  I'd like to see the INT80 code merged back into one
function, but that will probably have to wait until the dust settles
with FRED.


Brian Gerst

