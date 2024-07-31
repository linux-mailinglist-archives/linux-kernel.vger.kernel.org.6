Return-Path: <linux-kernel+bounces-269880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25706943805
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90EB21F229A0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBAA16C6AE;
	Wed, 31 Jul 2024 21:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EQecaB5e"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7E33A1A8
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 21:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722461592; cv=none; b=caODnt88XKREBtiGkkDmvtCtvv7KG2F4KoxdAUSxC2ITKiEXk28y7cWNtrMGeTg7AuPf669CSdE4qi7cfqgakL7BUr/3oPZxvHp5geSpsxH4AQnNaFfJiu0G3OwaXjwpGXvJrSeiLouRAVx4S4gTzPyd77KCjyCCNtyXoUi34yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722461592; c=relaxed/simple;
	bh=/ks9JRMMnDvphqXUqsmokZE6QY/FSp7LG0iS22XaAzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jK8SrTPPVHLTgF9YQISCbY5pNull5hiSvRvSIkCUk7GTKo9UGSg1LfBocjVwReirX6DrLujczw5Lq6EcvsKZNxBU0Kt/BWz1PzYtn5KjfTjybmgr4FtD/KyhmEkTKMP8PkHouehEoqlle5qojPSxHssoGEtz1213vrdsg83zoRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EQecaB5e; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-825809a4decso2045168241.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722461589; x=1723066389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dREKhEuZ+QTDPptJNWWM+egDyVC/sMlwDDn5nj0/gbQ=;
        b=EQecaB5ebMpJu/diAKGhXz/DvUHqdiR8rldsq1lEpHeXJebFP2DDVltbIy11nH4aZz
         NcJkqhFRJ7AZc7Zb07lvyX/1ZSlHQ0wKfvnPeoSvQEEygtoJXB0rLinsju+0la4MG7If
         rARs7bePtYmxs7WLbSZ6UDbuRuZDnGz1RsTFQWOanp2qm2+kNWanqsYGJS4uxHoDxN1T
         fbA4+d+/DRiQVBAGF8S2XdyKOHJdToxbZ9x0kbzpnfRnOOu9P2T3xbyJ15tgaJozaoJf
         XR1pR7CRvkVWwTAbg9gmD/SWhUGZsuP2FPk44kdrHqgQHKDt2ojOSLYGlWMwIP1M3lAV
         8PRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722461589; x=1723066389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dREKhEuZ+QTDPptJNWWM+egDyVC/sMlwDDn5nj0/gbQ=;
        b=EG5mlHr2ClTtuikp4yX1NGtK2B8mrKYxMv0Uwp8AsYCR6lwEdoqMLIQbclIhQ7hZVg
         +0VlcxPw1xmAdOkMOahQh7H85PVXHIlheWgCENmzF3TgqS7IrALLa7dV16vce3j8cIIV
         04CBxiT2tw8TgUiEyMxxD8CZgGMDZhEfbQyEvwA+j5eh7iJejy2pnlMvP4u3byODWK5f
         Dy0sMZIblgh+VCV1XrbeWHFmACE8zj8QLX0S9lik998+I0szBR45Cd2zF6hM8PJVdzSr
         U72J92cRZvc/NhVJXVmPeq2riRP9vR9Pt7DjiFOm9DsP+sWRyRvZ51wBqH61nqjdHp6h
         z4kQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8mfDKFjwA2EvSWs7UTwJltnPCE8kwRkkRylDcJSLqWXHCPbprKqZzBaeG9vgVLxohnUzOjrrdy1YvhFl4UR+JePDaIf1ayqtVr9NJ
X-Gm-Message-State: AOJu0YzWwXG8OLbEPNjZq+wn9EueDQ9zMtUi4pzDiPGpsaVoKOOZx4KA
	TFr3bHu2ybr6DwMtCpaF4/vVhLx439uie2cZa/ffZCMFLhtSFy48c9D+qkgkrU7p3o5x7UxhGYq
	siUtSYjYg7929UONazOuXo8L5Z9kF3nHl/DH4
X-Google-Smtp-Source: AGHT+IGzRIYcjWpVOooTnwdmT8UVl9DoOQY068XBNlB0HObnodh9BUjeFnRlX6rdpnVyqqHVV9gVh1G33vYQOpy9HWk=
X-Received: by 2002:a05:6102:5129:b0:492:a6fb:23e5 with SMTP id
 ada2fe7eead31-494506c65b3mr743308137.3.1722461589519; Wed, 31 Jul 2024
 14:33:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730113419.GBZqjPu6SdAt5qZKnh@fat_crate.local>
 <CAHC9VhRnq81v=DYC3SC=oD2onittYTQbZqp5uoeU2MWuCh0-SA@mail.gmail.com>
 <CACYkzJ6TUki=14-gPBCQL3wcFGvZF2STTzDzZ_Hfd-G_2V5sEw@mail.gmail.com> <CAHC9VhSx96-KL-8u5FCa1Bb1H5J6bn89Zv1gfPL9Hxo0kZOKLQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSx96-KL-8u5FCa1Bb1H5J6bn89Zv1gfPL9Hxo0kZOKLQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 31 Jul 2024 17:32:58 -0400
Message-ID: <CAHC9VhSVTkxC9GfYkMm5LRx6MzeD-Lk=ffTnJAvg-=XdiZB=fQ@mail.gmail.com>
Subject: Re: static_key_enable_cpuslocked(): static key 'security_hook_active_locked_down_0+0x0/0x10'
 used before call to jump_label_init()
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Narasimhan V <Narasimhan.V@amd.com>, 
	lkml <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 4:36=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Tue, Jul 30, 2024 at 1:40=E2=80=AFPM KP Singh <kpsingh@kernel.org> wro=
te:
> > On Tue, Jul 30, 2024 at 5:03=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Tue, Jul 30, 2024 at 7:34=E2=80=AFAM Borislav Petkov <bp@alien8.de=
> wrote:
> > > >
> > > > Hi,
> > > >
> > > > this is with today's linux-next:
> > > >
> > > > ...
> > > >
> > > > 09:44:13  [console-expect]#kexec -e
> > > > 09:44:13  kexec -e
> > > > 09:44:16  ^[[?2004l^M[    0.000000] Linux version 6.11.0-rc1-next-2=
0240730-1722324631886 (gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0, GNU ld (G=
NU Binutils for Ubuntu) 2.38) #1 SMP PREEMPT_DYNAMIC Tue Jul 30 07:40:55 UT=
C 2024
> > > > 09:44:16  [    0.000000] ------------[ cut here ]------------
> > > > 09:44:16  [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/static_ca=
ll_inline.c:153 __static_call_update+0x1c6/0x220
>
> ...
>
> > > KP, please take a look at this as soon as you can (lore link below fo=
r
> > > those who aren't on the list).  One obvious first thing to look at is
> > > simply moving the call to early_security_init(), but that requires
> > > some code audit to make sure it is safe and doesn't break something
> > > else.  Of course, if we can do something with how we setup/use static
> > > calls that is even better.  I'll take a look at it myself later today=
,
> > > but I'm busy with meetings for the next several hours.
> > >
> > > If we can't resolve this in the next day or two I'm going to
> >
> > Thanks for the ping.
> >
> > Taking a look, yeah it's possible that we need to move jump_label_init
> > before early_security_init / inside it.
> >
> > I will do a repro and test my change and reply back.
>
> I'm pretty sure we don't want to move jump_label_init() inside
> early_security_init(), we likely want to keep those as distinct calls
> in start_kernel().  Shuffling the ordering around seems like a better
> solution if we can't solve this some other way.
>
> Regardless, thanks for looking into this, I'll hold off on digging
> into this and wait for your patch.

Since I don't want to leave linux-next broken any longer, I'm going to
yank the static-call patches from the lsm/next branch but I'll leave
them in lsm/dev so you can continue to use that as a basis for your
fix.  If we don't have a fix in hand by the first half of next week,
I'll drop the patches from lsm/dev too and we can revisit the patchset
when you have a fix ready.

For casual observers, the lsm/next is normally an automatically
composed branch made up of the latest lsm/stable-X.Y and lsm/dev
branches however in this particular case I'm going to manually update
the lsm/next branch.  The normal process is described here:

* https://github.com/LinuxSecurityModule/kernel/blob/main/README.md

--=20
paul-moore.com

