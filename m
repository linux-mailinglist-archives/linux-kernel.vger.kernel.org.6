Return-Path: <linux-kernel+bounces-561966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D470DA6196D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A1AC3BCF41
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881DC1FDE24;
	Fri, 14 Mar 2025 18:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LjyHB1Iy"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ABD13B58C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 18:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741977112; cv=none; b=OGwZIoCjtI8Q1Ub1HmkHphG/8UbMCPBLMj1vot5Kf/X5R5MJsg44JpD2O4V01PPLZ100XJe7qsy5CJJoey/HTzdP8xOX3u1wvWIsjl8aNMg2nw4FBm0jCsIUCFVvcKSb6k9qQquGYVzYUoh6zfLePXFSWCEXWmnh0N+nKzzc1pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741977112; c=relaxed/simple;
	bh=LDo6tgFE6ng2Xs7rmFo3YOMemK0yiRXvtdSp1EU3nTI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=jNEyERRDUmgGOi83bqexN+3EFnbQvy5fe85Xn0/rfwopcEhngORFoDZM+Z/rR12zE++Vg7X0ZJaywqopLdgkIHQj79g6pgbHzqzpCGbNtZ4GqpYS0l+SsaSwjTX8OJs+qKSEtyxQvalllHqSIykcykP5YLKxIOiY7bL+qmAOXJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=LjyHB1Iy; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52EIUwr53541154
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 14 Mar 2025 11:30:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52EIUwr53541154
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741977060;
	bh=D4ZjoF3/WATIOxYoD6EqELaiflEFI655lCsuoTaKuRw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=LjyHB1Iy+RjbLgGYTYpAepbnMvzXz5VmcbOIQLjBmEpOW/fM1SI/jWJTC4QvWaqQq
	 zEG/ghCzNllC7Jj1rjopTjx7k7/xujf5r8KgWbpKgjlsaAbIcun7EosZubjrkE7+bF
	 ymjOrNPUD1hlSyrlvj2IdhGyFhvISDZeHuJUbEoc9RG+BcB3HA37zeFmAMAdwbQqDM
	 1VfiaF+kmWCIKBDI+IPqH3vUWpek0GgIPi/B97Xv18EwCz6BmDarbppvmcU5pKODK4
	 8pSAsasC+ZZpGG/Y+sjpfA7uIOXZUIdRG+ylKIq7SC7QjEaVyqcq+KQFeNO7uZCnrX
	 0t2iKonfocQuw==
Date: Fri, 14 Mar 2025 11:30:57 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Brian Gerst <brgerst@gmail.com>, Sohil Mehta <sohil.mehta@intel.com>
CC: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/7] x86/syscall/32: Add comment to conditional
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMzpN2gTiPKKsQsg48MEx_OawX60nAbhxRxqkwXa3NGHfBhfHQ@mail.gmail.com>
References: <20250314151220.862768-1-brgerst@gmail.com> <20250314151220.862768-8-brgerst@gmail.com> <b72d0040-99a3-4f20-9557-099d00b1b3ae@intel.com> <CAMzpN2gTiPKKsQsg48MEx_OawX60nAbhxRxqkwXa3NGHfBhfHQ@mail.gmail.com>
Message-ID: <B6BD4B23-1EF8-48CD-A668-BA1D5BA7489E@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 14, 2025 10:43:34 AM PDT, Brian Gerst <brgerst@gmail=2Ecom> wrote:
>On Fri, Mar 14, 2025 at 1:19=E2=80=AFPM Sohil Mehta <sohil=2Emehta@intel=
=2Ecom> wrote:
>>
>> On 3/14/2025 8:12 AM, Brian Gerst wrote:
>> > Add a CONFIG_X86_FRED comment, since this conditional is nested=2E
>> >
>> > Signed-off-by: Brian Gerst <brgerst@gmail=2Ecom>
>> > Suggested-by: Sohil Mehta <sohil=2Emehta@intel=2Ecom>
>> > ---
>> >  arch/x86/entry/syscall_32=2Ec | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/arch/x86/entry/syscall_32=2Ec b/arch/x86/entry/syscall_3=
2=2Ec
>> > index 993d72504fc5=2E=2E2b15ea17bb7c 100644
>> > --- a/arch/x86/entry/syscall_32=2Ec
>> > +++ b/arch/x86/entry/syscall_32=2Ec
>> > @@ -238,7 +238,8 @@ DEFINE_FREDENTRY_RAW(int80_emulation)
>> >       instrumentation_end();
>> >       syscall_exit_to_user_mode(regs);
>> >  }
>> > -#endif
>> > +#endif /* CONFIG_X86_FRED */
>> > +
>> >  #else /* CONFIG_IA32_EMULATION */
>> >
>> >  /* Handles int $0x80 on a 32bit kernel */
>>
>> Also, there seem to be a couple of adjacent CONFIG_IA32_EMULATION
>> sections in the file=2E It might be better to bring them together under
>> one section in this patch or a follow-up=2E Something like below:
>>
>> > diff --git a/arch/x86/entry/syscall_32=2Ec b/arch/x86/entry/syscall_3=
2=2Ec
>> > index 2b15ea17bb7c=2E=2Ea84f9d3c1695 100644
>> > --- a/arch/x86/entry/syscall_32=2Ec
>> > +++ b/arch/x86/entry/syscall_32=2Ec
>> > @@ -57,16 +57,6 @@ static __always_inline int syscall_32_enter(struct=
 pt_regs *regs)
>> >         return (int)regs->orig_ax;
>> >  }
>> >
>> > -#ifdef CONFIG_IA32_EMULATION
>> > -bool __ia32_enabled __ro_after_init =3D !IS_ENABLED(CONFIG_IA32_EMUL=
ATION_DEFAULT_DISABLED);
>> > -
>> > -static int __init ia32_emulation_override_cmdline(char *arg)
>> > -{
>> > -       return kstrtobool(arg, &__ia32_enabled);
>> > -}
>> > -early_param("ia32_emulation", ia32_emulation_override_cmdline);
>> > -#endif
>> > -
>> >  /*
>> >   * Invoke a 32-bit syscall=2E  Called with IRQs on in CT_STATE_KERNE=
L=2E
>> >   */
>> > @@ -87,6 +77,14 @@ static __always_inline void do_syscall_32_irqs_on(=
struct pt_regs *regs, int nr)
>> >  }
>> >
>> >  #ifdef CONFIG_IA32_EMULATION
>> > +bool __ia32_enabled __ro_after_init =3D !IS_ENABLED(CONFIG_IA32_EMUL=
ATION_DEFAULT_DISABLED);
>> > +
>> > +static int __init ia32_emulation_override_cmdline(char *arg)
>> > +{
>> > +       return kstrtobool(arg, &__ia32_enabled);
>> > +}
>> > +early_param("ia32_emulation", ia32_emulation_override_cmdline);
>> > +
>> >  static __always_inline bool int80_is_external(void)
>> >  {
>> >         const unsigned int offs =3D (0x80 / 32) * 0x10;
>
>The 32-bit syscall code is a bit of a mess right now, and it was hard
>to see its state while it was lumped in with everything else in
>common=2Ec=2E  I'd like to see the INT80 code merged back into one
>function, but that will probably have to wait until the dust settles
>with FRED=2E
>
>
>Brian Gerst
>

That function gets really, really ugly=2E The reason we factored out the F=
RED code is that the number of conditionals ended up grotesque, *and* that =
they are part of completely separate flows =E2=80=93 they should have separ=
ate every points, not dynamic conditionals=2E

