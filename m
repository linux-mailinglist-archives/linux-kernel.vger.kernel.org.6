Return-Path: <linux-kernel+bounces-382998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B69589B1602
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 09:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76871C213AC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 07:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045664436A;
	Sat, 26 Oct 2024 07:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yNfObSIT"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FA7179204
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 07:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729928261; cv=none; b=n3C2TBUXxsygwMJNFZr/Pji1xZ5tmW6T2Lp/fKsyR3CbibML16dgAs4vh+HYuFr5vjBMf7fPoQhAi8PQaRq3V7RwQhsqTOO4AN537tFLRc6fYSBfCzvtXpuixmCtSWe2V89H2w2sX7k+XWvlq8yMMW1NGqd9ut4Eh7wizc+DWDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729928261; c=relaxed/simple;
	bh=Vkh7FYATlBI/x/Res7N1td0hIFERoSoPheQ/N/7+y28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+bayqy+60O7H6Htz3BorP3S5h2Sze7t5sRnKGEIMbwrz4Gi5SUaHqksR3MQBHMV1WOq+F9Enpkq1jhZUPIJ0lT43o+KD8YV5kLDh0CmsC0Srs73slJq6G7zyok/A7FrgwdtdGsNKG1KfRwE3T5ET5mUBAHVA2qH8OAMrt9qn6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yNfObSIT; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so2168584a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 00:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729928258; x=1730533058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tXmrMOa7TitxvUQIL4JyiCngtLrU5ZWLyPgw6lGiJw=;
        b=yNfObSITuXqTEyY661kJIWL9qv6xtOOTeKZsK9+VZTJSZiSPGYsFpc+qpY2dpYFIQ3
         XHPPwX3zYLJp4sZkC3Vo6AGJszRxI6oE/y3bWDzsue/zgeXlY82y+uyXl4hgduqrfv3b
         GNtPGfHyoiFZXC61FxS/00WswfZFTqDO0YaLZSZnb2A7JooL4G7tSze/GhWL9DS92AZv
         A0tqmsilZHz9h+JW7i+KDZLyy/ZXHbLOWdPhuAbMEpxsT7sR7sFtiusWxsah6GTiPLMW
         aJTv4bTzrscabtcd+QTSvvMWPJshlzkuFbkmTLCGIlH4R4lPj1t2+2J0DRWxltiNCzAq
         8oNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729928258; x=1730533058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tXmrMOa7TitxvUQIL4JyiCngtLrU5ZWLyPgw6lGiJw=;
        b=na6c+Zo3pZOZemNUQB1HljuYmKl1k5LhAJGwa0pQxbDn2+ySIP419fBQGTJWDXMjnP
         8c654ZUbLWwMTMSVOOzWTAoWk2waQqDxQJHjr5+JV0y0kTtj9S0sEsqL6peyhyZ65jE2
         AY+Oigc0z7pjfe8DCVX05ZjH8GYf9I4WYJVCYqPh66vGJhjCyaHw97dOeCUhEebe+qyX
         UNUFaRqrZagHdhVHjxcBU+P/aldlnjEJm0OdE34ZxnTwfRxnvlePOYfMpbxNktfrD2TT
         93uEw562/zbnbUP1Zm7AF81Zj/0zcb6asDyYH6ZUyBij6RLIManUNS/Cg+O+iOcg313Y
         TgwA==
X-Forwarded-Encrypted: i=1; AJvYcCXrx5rEgONY1GTGZ4btTdYKYxlIBQuJgLAYOdFNwacll9xS/R6NJz0febXd/5+5b1RffHowMcZEFb5xA9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwbihjHZwqiWDwzVEnPFLI8ERAeXOymi/n3ZKRXT4d3ClZks4u
	N12uDWO2dOzgWUwLauhhGEC5UYAvbbw8ODwXq3jTYuiyILIGejqI4OZfS21cQdAPvWuuFzwvmDH
	mlr24IERQv4TeiCyuVv3hD13Ubr2bwQVIoBpR
X-Google-Smtp-Source: AGHT+IGXJtKk6fKVsHOtSfNiQ+W9GYfpTZ015GX3CaWs3NQf7jyDqACJSDhdEXberiKFab9yUiMY9MImYX0BR0xt218=
X-Received: by 2002:a05:6a21:3a41:b0:1d9:237a:2d56 with SMTP id
 adf61e73a8af0-1d9a8512cedmr2260655637.48.1729928258086; Sat, 26 Oct 2024
 00:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <MW5PR13MB5632321E93B031C0E107DB38FD4F2@MW5PR13MB5632.namprd13.prod.outlook.com>
In-Reply-To: <MW5PR13MB5632321E93B031C0E107DB38FD4F2@MW5PR13MB5632.namprd13.prod.outlook.com>
From: Saravana Kannan <saravanak@google.com>
Date: Sat, 26 Oct 2024 00:36:59 -0700
Message-ID: <CAGETcx_c2nfFQ++-FcsdUdLUo3e-oe07MkLgbuyrnq2FPrcsXQ@mail.gmail.com>
Subject: Re: Boot-time initiative (SIG) thoughts and next steps
To: "Bird, Tim" <Tim.Bird@sony.com>
Cc: "linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 11:18=E2=80=AFAM Bird, Tim <Tim.Bird@sony.com> wrot=
e:
>
> Hey Linux developers,
>
> The response to my request to form a Special Interest Group for boot-time=
 reduction
> for Linux has been really great.  Many people contacted me by e-mail and =
on LinkedIn.

Hi Tim,

Thanks for organizing this and moving it forward! I'd be interested in
contributing to this effort as a lot of work I have done aligns with
the goals of this effort and boot time is of obvious value to Android.

> I had hoped to push out a script today to start to gather data on boot-ti=
me on different
> platforms, for people to run who had expressed interest in helping with t=
his effort. But
> I got overwhelmed with other tasks, and I may not get it done today.  I'l=
l be in Tokyo next
> week for Open Source Summit Japan.  If you are there, please try to catch=
 me and say hi.
> Given that, I'll see how soon I can provide the script I'm talking about,=
 and we can
> discuss the goals and design of the script.
>
> A couple of quick things:
> There are lots of things to discuss, but here are a few things to get sta=
rted with...
>
> =3D wiki account =3D
> The wiki where we'll be maintaining information about
> boot time, and about activities of the boot time SIG, is the elinux wiki.
> The page we'll be focusing on is: https://elinux.org/Boot_Time.
> If you are interested in helping update and maintain the information ther=
e
> (which I hope almost everyone is), then please make sure you have a user
> account on the wiki.
> If you don't have one, please go here:
> https://elinux.org/Special:RequestAccount
> I have to manually approve accounts in order to fight spambots.  It might
> take a few days for me to get to your request.  It's very helpful if you
> put a comment in one of the request fields about this being related to
> the boot-time initiative or SIG, so I can distinguish your request from
> spam requests.

Can we instead keep this all a part of the kernel docs instead of the
wiki? Couple of reasons for that:
- Since the instructions can be kernel version specific (as things
change), it makes sense to have the document synced with the kernel.
- It's one less account to maintain and less chores for you.
- One less business approval to get in terms of contributing to
external sources.
- Less chance of bit rot. As people make changes, the docs are right
there to go fix.

Thanks,
Saravana

> =3D support for new developers =3D
> A number of developers have asked me if they can participate and contribu=
te,
> even if they are not seasoned Linux kernel developers.  The answer is "Ye=
s"!
> I hope to provide a range of activities for people to provide data, help =
update
> the wiki, implement and run tests and perform research - even if they don=
't have
> any previous Linux development experience.  I hope it will be fun to part=
icipate,
> and very educational.
>
> If you are new to Linux and have just joined this group, please review so=
me
> of the material on the Boot_Time page mentioned above.  We will be coveri=
ng
> more than just the kernel in the project, but one place to get started wi=
ll be
> to look at the kernel source file init/main.c, particularly the function =
start_kernel()
> (which is where a lot of the "magic" happens at kernel startup time.)
> Don't be afraid to ask questions.  Please ask them on this list so that o=
thers benefit
> from any answers provided.
>
> =3D short-term plans =3D
> I am building out the "membership" of the SIG over the very short term.  =
I have
> some more individuals and companies to contact to see who wants to be inv=
olved.
>
> Other things I'd like to do are:
>  * start gathering boot timing data for different systems (using the scri=
pt I described above)
>  * start pruning obsolete information and refactoring the boot-time mater=
ial on the elinux wiki
>     * (Yes - some of the material there is quite dated, so be sure to che=
ck it out before you try to
>        use some tool or technique - if something doesn't work, please sen=
d an e-mail or mark it in the wiki)
>  * discuss planning for SIG video conference calls and meetings
>      * I know I'm interested in having a boot-time micro-conference at Em=
bedded Linux
>      Conference next year - but we need to discuss if we want regular cal=
ls or other face-to-face
>       meetings
>  * perform a survey of existing boot-time reduction techniques, and see w=
here they are
>     in the pipeline of upstreaming or deployment in actual products
>  * finally (for this list), brainstorm what activities the SIG should do,=
 and how we can
>     collaborate on those.  I've started a list at: https://elinux.org/Boo=
t_Time_Project_Ideas
>     that you can look at and comment on (either on this list, or on the w=
iki).
>
> I'll be busy with business travel and Sony work next week, but I hope I s=
till
> find some time to follow up on this .  I look forward to working with man=
y of you
> reading this, on improving this area of Linux.
>  -- Tim
>
>

