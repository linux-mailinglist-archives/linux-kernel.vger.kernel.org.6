Return-Path: <linux-kernel+bounces-445452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACBA9F169F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654541887CEB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87B71F2375;
	Fri, 13 Dec 2024 19:41:34 +0000 (UTC)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481511EF0B6;
	Fri, 13 Dec 2024 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118894; cv=none; b=MHGsFD7CeZI11pSPKxbH0F0hcE3lKXPfb7QBnCYTcc7Fsnu8MfL+dg7dUd8+lW5Ve0Nyq/NvyZS+lArxiHHEOZCt2jvpfP9oXVVaV0JGfUmDbG8sEcn5454NLNyTGUEBeJSYUBQ5ZWSAU5V5HNInRhm94I2TC8uSEuqWoh8FAEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118894; c=relaxed/simple;
	bh=WcmpwK8L+1rdyFXu6+ygLABocvmTT9mSI/qvmMxq1vM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZ0L3IOTlDbNgI4TxvuM9UdLXD+3wBmubqxq4xp3YXCtGGD1GX9lnQfI/PgPMED2/G8WWcQydFvi/wfHWYlh0wUJ0mQyfx8JZAWdZAcAMyxMN8KMRxUXZCk1ZzIMvdDvUCukkSGZbw5djrW4k//x200n4LP7I9UvzPD8PJQnovI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4afe7429d37so566307137.2;
        Fri, 13 Dec 2024 11:41:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734118890; x=1734723690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+NNjRUZHM5uucEv6fy+3ktXfQNKuRR8mDXFkC5X+CBM=;
        b=RFnmQNynqw2NkXPjp2Oxh1PFKpHWp4l5XbMt9oNEqlFGAKRMCmjKvp0x74wC8iU4TY
         8I+wTmdvLuRg/anGQroRUDd/QVpod4Sk/9cYQG/hcUS55WWfjjCAr+CIJoo2o8VLiPbv
         ikuuZaFGyeG025b/4TGDyJq9JOUYCVkRLcWxwsW9jRCX7mUnb46o6a63BXLFtZyzrW66
         Zr0GM+6q01glgeR8BQ/hmo396+Ch/6dD3YcaSqxFs+hEACZHOOqWleGruFIqcZOw9hdn
         sFOT9xgqnNwvijaHuHwbYbqxWEXIrjcj+shQZJgImvE30AocBDrruVWGvjEFkZB2FQHZ
         mY7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVU5OmT03P4fKTcllopWB6R+ywd4bLrVFPdhFo5n8ssO8DC32Oq0sI0dPxz61Gmm4m/lHyfObV0K1s=@vger.kernel.org, AJvYcCXJvhrbkvALItaYbFrPhAVbFZQYxWLZkVdd+xAG1reqV8ciuMweZUPNvrgE2SLqEowwAR0eq/IbvmiNJ2tG@vger.kernel.org, AJvYcCXM/5sp5xsWOt6/g+MfTGQEyiH/RfqVR6HhFAoD9sVq/TKAeHGAvaiRtdGjF38LKOqnJmT8AJGJ8o27@vger.kernel.org
X-Gm-Message-State: AOJu0YzyO+l9R4zlpoQXXFujI97DqHq/LLT+d6D8Jg/LyQ+63xUoDpct
	HHbk8ZxskbLfs5S67FuX3KNkAdTfUm7eGIKk3jopC+jA55QEPJi7EPZa9t5H
X-Gm-Gg: ASbGncvqFJZR4Dm5mVDoiXroNppDDsWJC0NMoZ2jzmyXD5VwhuzalT5ORxqeVtT7O4r
	shw/17bjpy3Rt+YUc0QYdHpoZC6L12jxDep+cbz8jYqbSHYcNxre3hgH7W/sxDU3e/EkEBHkIP6
	XcQMjwwGW4taFBmXwD+hzjyUe6y9RxjUwjYoJRSFbRhc6XPqyC3FIl4rDylv8c6zWsjtrx1mhHB
	1Ep47kq7ihsnn/GWGxHvK2IB32GaUTN6TYc1Dap/F1Q8jnVl6CE/tkA11Db8uQlwcYBQV6rKFCe
	ch8hhbp1I5abJDcIB/wwBUA=
X-Google-Smtp-Source: AGHT+IE3FUP7NwkHryvGs8lB8qPl/CWB38xrqMRXss3js+pZWDS09s6TBZKB8TtM0W2KSNW6VLFQug==
X-Received: by 2002:a05:6102:2082:b0:4b2:5de5:faea with SMTP id ada2fe7eead31-4b25de60878mr4448666137.0.1734118890041;
        Fri, 13 Dec 2024 11:41:30 -0800 (PST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-860ab71683csm9134241.34.2024.12.13.11.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 11:41:29 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5187f6f7bcaso568486e0c.3;
        Fri, 13 Dec 2024 11:41:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVdrqF02k7dB2jqHrlU6h4Y3Wh5Sj/DkJc8XEfmdH/IsA30Kt/AVAVgR9mnM3uTIrNANp67Rzl6AJU=@vger.kernel.org, AJvYcCVxeJf3PpGKIQrecpYuQZ911/cXI8KXUwLFE7tWXsF41oSla6bGX0yGJmYEJi6Yufcfk01k+huH8KUi@vger.kernel.org, AJvYcCX4+/fbcBQNy+KUnXD9xzyOgo+tEojo6ONUC18DiCxJ7Uomx/STtC9OG2xuAg/B9wAIJNDs4uPixwIzh7YL@vger.kernel.org
X-Received: by 2002:a05:6122:3290:b0:517:4fb0:74bc with SMTP id
 71dfb90a1353d-518ca369a45mr5040949e0c.3.1734118889186; Fri, 13 Dec 2024
 11:41:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733421037.git.geert+renesas@glider.be> <46b320b91b8d86fade3c1b1c72ef94da85b45d0d.1733421037.git.geert+renesas@glider.be>
 <CAHk-=wiwAz3UgPOWK3RdGXDnTRHcwVbxpuxCQt_0SoAJC-oGXQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiwAz3UgPOWK3RdGXDnTRHcwVbxpuxCQt_0SoAJC-oGXQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 13 Dec 2024 20:41:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXxqRRePJ_HHo---6ayjRnQcDRE--mx0kUDg0ceDELG9g@mail.gmail.com>
Message-ID: <CAMuHMdXxqRRePJ_HHo---6ayjRnQcDRE--mx0kUDg0ceDELG9g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Increase minimum git commit ID abbreviation to 16 characters
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thorsten Leemhuis <linux@leemhuis.info>, Andy Whitcroft <apw@canonical.com>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@corigine.com>, 
	Simon Horman <horms@kernel.org>, Conor Dooley <conor@kernel.org>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Thu, Dec 5, 2024 at 8:19=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, 5 Dec 2024 at 10:16, Geert Uytterhoeven <geert+renesas@glider.be>=
 wrote:
> > Hence according to the Birthday Paradox, collisions of 12-chararacter
> > git commit IDs are imminent, or already happening.
>
> Note that ambiguous commit IDs are not even remotely as scary as this imp=
lies.
>
> Yes, the current kernel tree has over ten million objects, and when
> you look at stable trees etc, you can easily see more.
>
> But commits are only a fraction (about 1/8th) of the total objects. My
> tree is at about 1.3M commits, so we're basically an order of
> magnitude off the point where collisions start being an issue wrt
> commit IDs.
>
> Can you find collisions by looking at all objects? Yes. Git will do
> that for you, and tell you their types. But to take one recent
> example, let's do the 6.12 commit:
> adc218676eef25575469234709c2d87185ca223a. To get an ambiguous ID, you
> have to go down to 6 characters, and even then git will tell you
> there's only one object that is a commit, ie
>
>    $ git show adc218
>
> results in
>
>   error: short object ID adc218 is ambiguous
>   hint: The candidates are:
>   hint:   adc218676eef commit 2024-11-17 - Linux 6.12
>   hint:   adc2184009c5 blob
>
> so right now you have a collision in six digits for that commit, but
> even then it's actually still entirely unambiguous once you know
> you're talking about a commit.

That's true for the basic command line tools...

> Make the tools deal with the cases we already have, and you'll find
> that the shortening is a complete non-issue.

FTR, cgit can use some improvements, as
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dadc218
just tells you "Bad object id: adc218".

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

