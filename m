Return-Path: <linux-kernel+bounces-375757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA509A9A6F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AD831C21C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E305514EC51;
	Tue, 22 Oct 2024 07:02:44 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763271494BF
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729580564; cv=none; b=W4o6URf8Lw9bC4W/7kNR3HnUxC8q55ICTi0iqX4ByNaVYvzXRxv3pUt3RC56vIL8Z62sdO4CKvSYdUC7/eE73FBp+UrfHNN3n7Ntae3tzsv2kCE/sYiEaGCaE7YGro5+cuit5lMpmxDAg4nV0sGftMj5hOe7Utjh8Fn2+WQlQdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729580564; c=relaxed/simple;
	bh=bQxg+7CWgByU55ZsjSqw/LyVBrMSQrwOKSgUZspO9yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBMxXUaG21GDQmruJNWz3bADznZslSdlFEwol0cFCtnMHD4o5ExK1v2dt73It8DEVceGW1vzrjwnWEI6WmLBXOvF+Uz5MMXnxTtIy4HWdaTG4BGi1LYmhVGd3j4p0oHkfhlJcjPfF3i8SHDAcalJhpK8v90cBedYa/BE/xKnHzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e2e427b07dso44155537b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 00:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729580561; x=1730185361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctRRa+ldOzC4pbypyT6zXnt+163N2KDNV7TcqDdAlP4=;
        b=bzafl2J5KyleM0SZnDKKDM3+rrjw4sGO+2aeFMA4c6MFU9b21/xsWfcoZJeyssrXJM
         ZVPfKYQJXP19n6Q7wuSd+T4PGbtzespoNygO5WVY3L4XzinOVenoVdVXl9TVQJhC+Soh
         rW9tZVpezzZvTrqKELv26QVvd+z1mFmjfC45LeRT4EXWFfUeSizhbVuTL1SkQIV/m1QJ
         ar0OQ+Z55O6JCHwEtysmHtcK6wG0oyOGN1KWb/GcwaA94va4yupSVsab6UNhMt/p3kRc
         YYKYC7ywsRjQlMWT70EiIgjDAQj7UzM4kyEvaSndnVtTvPMb9RN6mk8bH4VIxlLWYJ40
         naQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa8lwUJKO3LGS3Ls9ThwcCxAHkxCnCjtdH/yiCpiUQ8EmzVzD/WcR7q7LiW8dq9V/7/8ABjeUTRk7D1Vo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0NnemGmMb4uAWS2+nBoNsgVtChrg6cjlYALhTQQXlm6XNem7x
	GAj8UFKGfha+1ORketzAHKyT3CoWSR1hEYyhIzBiM8cuMTk7TFQV1o7Ejzob
X-Google-Smtp-Source: AGHT+IEtxRL2p2rDlWsAUFQoNy7DlbFrxEPWK++w2xpC5fZ+iQvsvJWa+z/pnS853r3jloUzzjy6ug==
X-Received: by 2002:a05:690c:640c:b0:6e3:ed8:7f17 with SMTP id 00721157ae682-6e5bf9a5c5fmr139888687b3.16.1729580560699;
        Tue, 22 Oct 2024 00:02:40 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5d2a43fsm9788067b3.130.2024.10.22.00.02.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 00:02:39 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e2e41bd08bso60505747b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 00:02:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1jB7cQgLBC1ypJyypUFhp3z4kemElQlATqTW55hMYKovzbt0WE0mvBdltJka1eApcCiHkkXEcT70Qeps=@vger.kernel.org
X-Received: by 2002:a05:690c:f12:b0:6e5:e6e8:d546 with SMTP id
 00721157ae682-6e5e6e8d889mr90834957b3.2.1729580559446; Tue, 22 Oct 2024
 00:02:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZxZ8MStt4e8JXeJb@sashalap> <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
In-Reply-To: <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 Oct 2024 09:02:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWueY8BJKpYrPTh-LKOvBnyyN4k+nHN9u9E9OnGWbVNvA@mail.gmail.com>
Message-ID: <CAMuHMdWueY8BJKpYrPTh-LKOvBnyyN4k+nHN9u9E9OnGWbVNvA@mail.gmail.com>
Subject: Re: linus-next: improving functional testing for to-be-merged pull requests
To: Kees Cook <kees@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, torvalds@linux-foundation.org, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 6:55=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
> On October 21, 2024 9:07:13 AM PDT, Sasha Levin <sashal@kernel.org> wrote=
:
> >In an attempt to address the concerns, we're trying out a new "linus-nex=
t"
> >tree is being created and maintained with the following characteristics:
> >
> >       1. Composed of pull requests sent directly to Linus
> >
> >       2. Contains branches destined for imminent inclusion by Linus
>
> But this means hours or a day or 2 at most.
>
> >       3. Higher code quality expectation (these are pull requests that
> >       maintainers expect Linus to pull)
>
> Are people putting things in linux-next that they don't expect to send to=
 Linus? That seems like the greater problem.

Exactly.

> >       4. Continuous tree (not daily tags like in linux-next),
> >       facilitating easier bisection
>
> I'm not sure how useful that is given the very small time window to find =
bugs.
>
> >The linus-next tree aims to provide a more stable and testable
> >integration point compared to linux-next,
>
> Why not just use linux-next? I don't understand how this is any different=
 except that it provides very little time to do testing and will need manua=
l conflict resolutions that have already been done in linux-next.

And many actual issues have been seen/worked around in linux-next
a few weeks before.  In addition, this might make people laxer
w.r.t. linux-next, thus increasing Stephen's work load, and making
linux-next worse for actual testing.

> How about this, instead: no one sends -rc1 PRs to Linus that didn't go th=
rough -next. Just have a bot that replies to all PRs with a health check, a=
nd Linus can pull it if he thinks it looks good.
>
> For example, for a given PR, the bot can report:
>
> - Were the patches CCed to a mailing list?

This check would be good to have for linux-next, too.

> - A histogram of how long the patches were in next (to show bake times)
> - Are any patches associated with test failures? (0day and many other CIs=
 are already running tests against -next; parse those reports)
>
> We could have a real pre-submit checker! :)

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

