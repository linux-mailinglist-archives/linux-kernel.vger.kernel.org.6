Return-Path: <linux-kernel+bounces-516007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90580A36BE0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 04:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F9517217D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 03:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE0F1624CD;
	Sat, 15 Feb 2025 03:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PP9SbYVn"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBFF7485
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 03:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739591790; cv=none; b=pPG2nkmKcNZuldWjgOvjFQ0TORguI3x1tOuOWaDih07lTTyWcRgMuaKnI22iJqbexbZhOFrUDrPbx4xbWLkD1s1WSTKBU3gv6ZwFL0I0qEYGR/3nU+vy1j7axhBSprygbcR9z/2Wrsa/pFBoGZ2TqV9kEyR0BNs2A5lMjeApTy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739591790; c=relaxed/simple;
	bh=yJp7BPNfQIazGdC1yOWpiBzIVSEmoSrRGANHi7CZX8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBXON73GWmax75IrDanFgklZ9XntpQkwAbqTv3rgZ2b9R+Myfew+hKKDkGzm0mccgedS7Z0CbQMj2h/RVGtb7KZ/eIuN87Bm/IFLvy5+z3cIsjoIrbdESHMeBJP44lvmICWhPPO34+McL8slv61tSnhYG2NS3yYpI5BZK6Jf1DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PP9SbYVn; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dcdb56c9d3so3958475a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 19:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1739591784; x=1740196584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GANQm4Z6h2KgQfFF68pKPk2LmN7J9Jka5tbFJd26Nuo=;
        b=PP9SbYVnIEQxc3McqMZHukV5I25tD1iA4TpFjOLwRTK1FQx75jJz/DuaxCNc9VfDKM
         uYi5gPzY0ojgwZ4AcDta1SB4wD63JlW8XSrCZR1+x+YnZ0tXzj7jjlhSqJmuKSpeVvJm
         FXxlf1Dm6DMZ3KGswS1Vf23fOOX3xvNHc2JEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739591784; x=1740196584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GANQm4Z6h2KgQfFF68pKPk2LmN7J9Jka5tbFJd26Nuo=;
        b=BWYnUmXeNe2Qo7/twh2/jVMNoJuF7ZN9FW8FvPMbo9qi+OjZbonaV61m5PoQqbGJ0n
         AfALHoBxeZoHtrgbcudTxkO+iML+2864vcqC+ms/dg7sLlxgH0uT0IsavQl/c5kv+afy
         V/5bRRdFEhlnxeyito/t/roeiFdoRunbqRr2vWWuAGODJmp556OsVUshFy1q/LdQ8gtD
         OwoBipn8iy5EGOndAAGcHxNNVuWjRnnrWzoT0Sb2iEecpJvjCWM80CdyH3SJzlQt68Iw
         0YEyODLktPYSx3eBZn4PEKB1y+Y0BXCQ2Kb/qUu0XXEba3ZW8wLMk4e3OelG1gYBRYly
         pXZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlF758l6zBNMv7fZ53JRUVieip3wsJxdGPuqg0K8DjMbPMPkSjTD4VU5HyUyJ0ARJUkI++UMyzN9ErZTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySbvFzL0iLY9b+6DPVlUeK+eAG7rwZZQzXsMn6Z43zx4k6N9rF
	uNKJw0Lmi1aGH4/O0TdQCNCrXDT4CjQTMtj+SgqoCvRUUI1Minmi0Nw9FoeBZv997C11PufHvdA
	sODk=
X-Gm-Gg: ASbGncujMeXBy56qaTeevGJjj6K/ggprjISBjG9YoRr1TMJ9Dt9gnUQpVW/1RgkuOhC
	k3j79TWJ0HobrhLaxEpvGZoFVVtuIAB6vdjmvAYTkv4HCnqe9NDstcikxBzSKzpbIvHkMJrUFVo
	iEYjWxPM73/KcAbVlSPN5pVebJaeJ0YrIBT4GqYvKoGgInqHdUA4QccaxRRt2GxE0Ecc1qk2tQy
	4/42HnBHp7JcGT8tErUVVfA2xLzziGY4EYxBYbst91LdmAHjSwoK3fZtMy617/HaxNLwSeilowN
	6AEsE9O4Jf8zi1Yq/cnUArg6X1RwkW0Gu1eGKeuU9uYgDj6n9tK3ywFNtrMzeryKHQ==
X-Google-Smtp-Source: AGHT+IHRcdHG8jheG09OllE2p69PKv792i8g7Hoiqqr/NgTWlZ/rB6i/f73SCDHLR1m7xhur9A3ygg==
X-Received: by 2002:a05:6402:234f:b0:5de:a6a8:5ec6 with SMTP id 4fb4d7f45d1cf-5e03602e275mr4892117a12.10.1739591784512;
        Fri, 14 Feb 2025 19:56:24 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb72b519c5sm63361966b.173.2025.02.14.19.56.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 19:56:23 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so938485a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 19:56:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXYRItOY7sRQAvXLP+fRUy8Epwvdm8nKEHuAe4lDqKSdKTS/rkH/I27W1dDoyU/lNLCyAnXdf/ri75u8Ag=@vger.kernel.org
X-Received: by 2002:a05:6402:2114:b0:5dc:71f6:9725 with SMTP id
 4fb4d7f45d1cf-5e036172eadmr3577540a12.27.1739591781841; Fri, 14 Feb 2025
 19:56:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <w3rw6n4cbgmlcylf5gbzzocqhyxjoyjy3qiedb7fzvd7jdwgap@44d323cbjljd>
 <CAEdQ38F6ts1qXj2xb+PN=O_byGwZAp1mvF8aRdTEq2zrzLBFSA@mail.gmail.com>
 <173956921724.2112695.11506562234571397782.pr-tracker-bot@kernel.org> <CAEdQ38E7nHFf96BWDEB_15jiRLepg=_dmaoFvO1JgiL6GxPpUQ@mail.gmail.com>
In-Reply-To: <CAEdQ38E7nHFf96BWDEB_15jiRLepg=_dmaoFvO1JgiL6GxPpUQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 14 Feb 2025 19:56:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg0Gdt61Wgnoho=7q17A_5TX-WUPWE__R90J19_d-DMxA@mail.gmail.com>
X-Gm-Features: AWEUYZlsqUSGTvKb4WLhxKD3VxwMq6I4z3ImsxBGnmXD3LnHBV1CDJ43qzxVFug
Message-ID: <CAHk-=wg0Gdt61Wgnoho=7q17A_5TX-WUPWE__R90J19_d-DMxA@mail.gmail.com>
Subject: Re: Re: [PULL] alpha.git
To: Matt Turner <mattst88@gmail.com>
Cc: pr-tracker-bot@kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"

On Fri, 14 Feb 2025 at 18:30, Matt Turner <mattst88@gmail.com> wrote:
>
> On Fri, Feb 14, 2025 at 4:39=E2=80=AFPM <pr-tracker-bot@kernel.org> wrote=
:
> >
> > The pull request you sent on Fri, 14 Feb 2025 16:36:43 -0500:
> >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git re=
fs/heads/master
> >
> > has been merged into torvalds/linux.git:
> > https://git.kernel.org/torvalds/c/3447d220155bd9f4b5435ea6e9d58b536c7e9=
4dd
> >
> > Thank you!
>
> This doesn't look right, and I don't see the commits from the
> alpha-fixes-v6.14-rc2 tag in master.
>
> Did I screw something up in my pull request?

See what pr-tracker-bot is saying: I'm not sure *why*, but
pr-tracker-bot clearly says that it thought you asked me to pull
"refs/heads/master"

And that master is some really old state from 2017, so it's very much
in my tree, and pr-tracker-bot thus thinks it has been merged.

[ Time passes ]

Oh, I have a clue: pr-tracker-bot also says

  "The pull request you sent on Fri, 14 Feb 2025 16:36:43 -0500"

but that's not the date of your pull request, it's actually the date
of your message to Stephen.

So I think pr-tracker-bot triggered on the subject line of that email
having that "[PULL]" on it too, and then when it tried to parse the
pull request, it didn't find a branch at all, and picked the master
branch as the default.

Anyway, I hadn't pulled your real pull request yet, but I bet that
when I do and push it out, you'll get another notification from the
bot. This time for the real thing.

           Linus

