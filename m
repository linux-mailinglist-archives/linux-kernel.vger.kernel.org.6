Return-Path: <linux-kernel+bounces-291026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7F7955C65
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 14:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B571F2154E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 12:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA6C1C6A5;
	Sun, 18 Aug 2024 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uv7sb+HB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0510BB666
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723983672; cv=none; b=cWCiTxys6WT2wHeSg/fGj+1W3x1hIPWcoINXwJBuyk1LjxDONJP0vwpop77uQpX3E3cg2KtTQyr8+cUZO3pRF0+IPFznRBmEBAMD4eyBx4je/8L5GrpTZ3bjpowVY+rJo4Asj2G6jY1IgknWh5bVG3ZwxsSHTgNfl1D3LSyLpNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723983672; c=relaxed/simple;
	bh=mCnl2sjWqxQLaHQgCuE74JIcs23mOo2LREXAbCdHSK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJvYkM+f8D3AnS76A9zFJ9pguobYlj+cbSO+oiMKr6tL2PBfSa3Tg+W05z9+ibBUZuME3TyDzXe8Qel/a1DMQ0+LhaZCBclE78CVsmsx6q2XsKGKK02kQOtTwB6z+pEwO/OqfAOnIU736zVcdsPY6yHbvvnYPYri/jIgkugvLn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uv7sb+HB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7388DC4AF13
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 12:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723983671;
	bh=mCnl2sjWqxQLaHQgCuE74JIcs23mOo2LREXAbCdHSK0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uv7sb+HB/Yiifmhg0iyZH61Bpn1T9/PJPicvTY5LMHjt4ZoHQXVpu3bwewG9CFQCB
	 M4Gg9RDr4NtfQWZ6h7Fk5USUJmsvclE7dOltIwZGU2jGfbqrIRVlAO+t+fck2qWIU/
	 26qZVbd4g3qSKS0uYaKnXnknOOx1jHABAfq66S68f2vKi5O2AoOcf6n3mQnAFVdNQ0
	 u1gi9/iBbF2ahlv2iKsgeNlswVTj9s5dVztCS/LjSfCSmnQCK5aen9p9+89i841fL6
	 t5xFbFPYP7dffkqUZJKZ5SsKD5gTvbvuLf5gixzkffqdcUEK9pObAC17YxGLkV9PVF
	 l+bPN8APlfsdQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5314c6dbaa5so4629096e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 05:21:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXr3OfBnN5Y38qUCzycKVn1qkYnVIoIK0Gsz6mquQ+Q9W/MO3xeUZJQX8+fF9VHm8sdv2C1ez32Y/HKbqtnVMRNchLIZwPLmh+0+bS9
X-Gm-Message-State: AOJu0YwTdEzVzjxCV4nIypP1FgY/TG56fCGOl4tIYEyXZbujMfFN3vxp
	hSBia57yyO48QToRK3f9tuO1Ss+RoxvJD5pG1fyr44d28DB1Cw3IV/4g/9TzWYnNIlLVv1gD7tC
	REVxZqUdUiTOBbjVFtz5vGEUNyh8=
X-Google-Smtp-Source: AGHT+IHManvMHZN6ER/GkDjqvh9nMEi5IZA41voVWxUL/OYfzoWmeuA2KR1e+na4JEzSCo3ZoKclEUNNlgVe0T3Y53g=
X-Received: by 2002:a05:6512:1110:b0:52c:d819:517e with SMTP id
 2adb3069b0e04-5331c6b050cmr6006961e87.30.1723983669994; Sun, 18 Aug 2024
 05:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729155738.29142-1-laurent.pinchart@ideasonboard.com>
 <20240801011120.GA1620143@thelio-3990X> <20240817193342.GA12234@pendragon.ideasonboard.com>
In-Reply-To: <20240817193342.GA12234@pendragon.ideasonboard.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 18 Aug 2024 21:20:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQDmPeJHRWsDsv=S=NTBfpCNALEmv1CRCMsypxhOYo+Nw@mail.gmail.com>
Message-ID: <CAK7LNAQDmPeJHRWsDsv=S=NTBfpCNALEmv1CRCMsypxhOYo+Nw@mail.gmail.com>
Subject: Re: [PATCH] Remove *.orig pattern from .gitignore
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Alexey Dobriyan <adobriyan@sw.ru>, =?UTF-8?B?Uy7Dh2HEn2xhciBPbnVy?= <caglar@pardus.org.tr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 4:34=E2=80=AFAM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, Jul 31, 2024 at 06:11:20PM -0700, Nathan Chancellor wrote:
> > On Mon, Jul 29, 2024 at 06:57:38PM +0300, Laurent Pinchart wrote:
> > > Commit 3f1b0e1f2875 (".gitignore update") added *.orig and *.rej
> > > patterns to .gitignore in v2.6.23. The commit message didn't give a
> > > rationale. Later on, commit 1f5d3a6b6532 ("Remove *.rej pattern from
> > > .gitignore") removed the *.rej pattern in v2.6.26, on the rationale t=
hat
> > > *.rej files indicated something went really wrong and should not be
> > > ignored.
> > >
> > > The *.rej files are now shown by `git status`, which helps located
> > > conflicts when applying patches and lowers the probability that they
> > > will go unnoticed. It is however still easy to overlook the *.orig fi=
les
> > > which slowly polute the source tree. That's not as big of a deal as n=
ot
> > > noticing a conflict, but it's still not nice.
> > >
> > > Drop the *.orig pattern from .gitignore to avoid this and help keep t=
he
> > > source tree clean.
> > >
> > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > ---
> > > As this has been in the tree for so long and appears not to have both=
erd
> > > anyone, I have a strong feeling I've overlooked something and this pa=
tch
> > > will be rejected. I've actually had that feeling for a few years
> > > already, and today I decided that maybe everybody else used the exact
> > > same reasoning, explaining why the annoying *.orig pattern is still i=
n
> > > .gitignore.
> >
> > I don't really have a strong opinion myself but it does seem reasonable
> > to be consistent. For what it's worth, Stephen Rothwell checks for
> > accidentally added .orig and .rej files in -next (and catches them
> > occasionally [1]), so I wouldn't expect removing this to matter much.
> >
> > [1]: https://lore.kernel.org/linux-next/?q=3D.rej
>
> I didn't know that, it's useful information, thanks. I wonder if
> checkpatch.pl could also check for that ? Although git-add already
> warns unless you specify -f, so people ignoring that may also ignore
> checkpatch.pl, I'm not sure.
>
> Who decides on whether this patch should be merged ?


This is kind of subjective, but so far, nobody has expressed
a strong opposition.

I do not have a strong opinion, because I can ignore
*.orig from my ~/.config/git/ignore anyway.

I tend to want to ignore '*.orig', so I already have
*.orig in my ~/.config/git/ignore.


I will pick up this with a little further rationale from me:




[masahiroy@kernel.org:
I do not have a strong opinion about this. Perhaps some people may have
a different opinion.

If you are someone who wants to ignore *.orig, it is likely you would
want to do so across all projects. Then, $XDG_CONFIG_HOME/git/ignore
would be more suitable for your needs. gitignore(5) suggests, "Patterns
which a user wants Git to ignore in all situations generally go into a
file specified by core.excludesFile in the user's ~/.gitconfig".

Please note that you cannot do the opposite; if *.orig is ignored by
the project's .gitignore, you cannot override the decision because
$XDG_CONFIG_HOME/git/ignore has a lower priority.

If *.orig is sitting on the fence, I'd leave it to the users. ]





--=20
Best Regards
Masahiro Yamada

