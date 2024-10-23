Return-Path: <linux-kernel+bounces-377648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E7F9AC1D5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668061F22307
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A054B15AAC1;
	Wed, 23 Oct 2024 08:36:37 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FFD155A4E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729672597; cv=none; b=eIQflSMn4c+Yjmiz8a4aWCcA6T9h+uPZIP4kFLELgq7Mdw2uGRXuOe9HqqmTN1AFFJlP7YjY8XjDUWSfyFkwK5x6eAr6ORLsvkqoNShKNAzj0AAVKVUtlv3RIVxPcRVggU5t3Zz/nLYj/CuPe4Em6zu6iON//N8la1izZWY5OaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729672597; c=relaxed/simple;
	bh=WoszXx2jVWnLZANPTXKiGpUlWzGprmlyNf1SgZ2h6/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGTgJq7+suuoRDmUnkJQVqYgUyAFDgBByhL8pCTWnMNeqlvMzB3TQMXHgd2Bp9MTWI+DdGij2vov3zDZ+vqwTgsjWRA2lxzyhbGs0DX4iC455icwt1tDhxTVNJfD/jy0IqI2rbbJi1WeDfXFBbiC2jIlt/+UVOjLQnXc4qJXPmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e38fc62b9fso64653457b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 01:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729672594; x=1730277394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9mLvo2WeXjPwcQq/5DwDt0k4XI3pjJ/l1xXIcYug8o=;
        b=m4FW+KQVF2oqnBul6lwsG7Yx/h/zzjMUnc6JLuU4LL1KrwAvx1PiUysBp/jY48lJuc
         a+iZGEm51+3JuZGL5Vk/ju3qTPoc0LsLX36x11qRgk1KVlEYN4zeF/8cswstNTmSycE+
         ii+2qYikBxn1UIzwgP9imTPUPXvkEDsurznrfjKZsSpT+RUWIVPfV2jHIRBL2Ta2QKJk
         NCBkmhBcTxTIZD4I9rPyDIMrz19ShlBITey8oVDAiq6Dht42Qzq0VOBs9Z23CRenOsz5
         UTBjFeqMYrA85iZFq7Y2PfzWBi4rn2U4KL61RwmD1KHtBn3msSAlplrL91Af6fPLD0Eh
         N4NQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+cPrtnWHV9u2pKju4SgirPhkaIe29Zh7RHO6j8Wm8JE98Z6jnKCWq8vMN2a7voFFsiY28bpFW0DXVQaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxavcYzfhpe2gD1roK9Ni06JMeUJWKsy1KmvLSF6QZ4YBEFQaly
	CZ8TE9bNHB1XHSoJbr9/3RWBaqYGemUFfsplK3QOFelppG3YEaKP4fzeSXoS
X-Google-Smtp-Source: AGHT+IEaUaSLaq3QZRMxNMCmHPd62i+YmUxWsjcM1fn7P+ZmtwMbYw0NCwXERfJcnAEEPXJ6/aV1kw==
X-Received: by 2002:a05:690c:94:b0:6e3:4630:e190 with SMTP id 00721157ae682-6e7f0fc27edmr18093897b3.42.1729672594153;
        Wed, 23 Oct 2024 01:36:34 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f59f7b5asm14145317b3.29.2024.10.23.01.36.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 01:36:33 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e38fc62b9fso64653157b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 01:36:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX4BCGYBqpAMfOA2EXkCCjd9TnYIkupaCha4D4x/NiMZpa+ody9HovIRr1VzZzgNmb/vxMF+E2NLuRv7VY=@vger.kernel.org
X-Received: by 2002:a05:690c:4b06:b0:6e3:2e20:a03c with SMTP id
 00721157ae682-6e7f0e49ef0mr20466497b3.26.1729672593282; Wed, 23 Oct 2024
 01:36:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZxZ8MStt4e8JXeJb@sashalap> <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org> <20241022041243.7f2e53ad@rorschach.local.home>
 <ZxiN3aINYI4u8pRx@infradead.org> <20241023042004.405056f5@rorschach.local.home>
In-Reply-To: <20241023042004.405056f5@rorschach.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 Oct 2024 10:36:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUxrULbo=A77DFDE4ySbii3jSMuh8xVvUXaqyCnwEAU-w@mail.gmail.com>
Message-ID: <CAMuHMdUxrULbo=A77DFDE4ySbii3jSMuh8xVvUXaqyCnwEAU-w@mail.gmail.com>
Subject: Re: linus-next: improving functional testing for to-be-merged pull requests
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>, Sasha Levin <sashal@kernel.org>, 
	torvalds@linux-foundation.org, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven,

On Wed, Oct 23, 2024 at 10:20=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
> On Tue, 22 Oct 2024 22:47:09 -0700
> Christoph Hellwig <hch@infradead.org> wrote:
> > On Tue, Oct 22, 2024 at 04:12:43AM -0400, Steven Rostedt wrote:
> > > You mean have everything go into linux-next before going to Linus aft=
er -rc1?
> > >
> > > I'm one that doesn't do this. That's because my code in linux-next
> > > after -rc1 is for the next merge window, and the code I send to Linus
> > > is only fixes for code I sent before -rc1. I tend to keep an "urgent"
> > > and "core" branch. My "core" branch is everything I plan to send in t=
he
> > > next merge window and goes into linux-next (via being pulled into my
> > > for-next branch). After I send my pull request to Linus, and he pulls
> > > it in the merge window, that "core" branch becomes my "urgent" branch=
.
> >
> > You can easily have two branches in linux-next.  Many trees do that.
> > It is also a really nice warning about self-conflicts.
>
> I actually do have several branches in linux-next. But they are all
> topic branches. My urgent branches usually mirror them (by naming
> convention). My scripts pull my for-next branches together and then I
> push them up.
>
> I did push urgent branches to linux-next some time back, but never
> found any advantage in doing so, so I stopped doing it. As the code in
> my urgent branches are just fixing the stuff already in Linus's tree,
> they seldom ever have any effect on other subsystems. My new work does
> benefit from being in linux-next. But since I don't find more testing
> in linux-next for things that are already in Linus's tree, I still
> don't see how its worth the time to put my urgent work there.
>
> To put it this way. The bugs I'm fixing was for code in linux-next
> where the bugs were never found. They only appeared when they went into
> Linus's tree. So why put the fixes in linux-next, if it didn't catch
> the bugs I fixed in the first place?

Hmmm...

Your arguments sound very similar to those being used in recent
discussions about not posting patches for public review...

Please follow the process! ;-)

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

