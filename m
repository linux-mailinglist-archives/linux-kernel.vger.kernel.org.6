Return-Path: <linux-kernel+bounces-433912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDA29E5EAF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 20:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF50B169DC4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968E822D4C7;
	Thu,  5 Dec 2024 19:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FdVq//hM"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740CF229B1A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 19:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733426380; cv=none; b=Gp8Retjl+Ynp0YhDwxzuRGMOsaBCfpXYhFV8D8Hj/CpU8yx+OxNqdoRH1uhNLljZF+FP6ExVhkNXhKQkpkI3aCIkrqX/jS1xmFjaO3iWR4wLfmKprnM3S8s7KCqCJl2gJ04uy72kFcZI9t0W2fr9891IEq3xN1FDY6m41uXN3+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733426380; c=relaxed/simple;
	bh=N7Q2i/te3fJSR9GXmZAlQH1YXHaD/cG2+guiEYfirWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muH3t/f3zRUMTdrAUBA0Evr9ccBt7oNwjqrZbheP+86+v8/ozNccd7VaASwgDibByUOO7dIA9wmGgKKD39u+jqe+VNreuEQxdwpqbvD8TlcC+hcdGbzCzYOeH6h41paHYtqk4W+L+gBTOTmvFseCrSQq+F682qkAl/oPseTjcz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FdVq//hM; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa628d7046eso159010666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 11:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733426376; x=1734031176; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DuB4RBng6UYOUJZnydBy5hrATh6bqjUq7A/wd6mOafg=;
        b=FdVq//hM5UpBn7kbH7x9osHum3getUCzrgapLYCNwgl0u52inmhgsjRe/ZO9hTuL6S
         6bxykc0ArPlbugzu3Dj/My4ZrWJHfHodkHDoP9SUNRuc6q6jxykFQ3mBizwVDkPBvtR+
         dYk8y02YiaUx1y4BwMSthOR98UQAhY7QnCnC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733426376; x=1734031176;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DuB4RBng6UYOUJZnydBy5hrATh6bqjUq7A/wd6mOafg=;
        b=S3zkHklotFnPZ7sQd5SSCvje6NNyJW9xrDKWirndQKmpeB2sOXaoKFMyJlMObquHQp
         MSJl+jP62V92USbu36n7ekBkj1GTRYpi9nfLa59v2gG9efybiUSvpZdvkxejuc5s+wQG
         ZBwRfmhdZ34oDCUhUb7pJmlUtwgmyrAFVP0VukwyZv5vFLMQ5YjdW1XSXLtgzjaTllaq
         wUZIUSzZSXHOBvQdwKgp2RbMlhTKSHkyV61nBrdoPxk8ZYA/ebaEXJMA56pkKmaBX4bZ
         lt3X4BIgFhDCxWXi12tzLCbYbLaKKBAXMtE95P2NRQnd1Nvlfq9+M5Z9Lgch2QVJk8vb
         HgtA==
X-Forwarded-Encrypted: i=1; AJvYcCXsx8gOq/Tw25il7vYoAmQWjkHsEV9nUvW54JC9e5HDBt40jr87aqbt8cb4glHhrXohF+ckI8/BFWfIRZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF+9hWiuuK0JKqI8w6U0AHowlJNktC5PtgD6t8ZcTQ6zEQQRI2
	DKCN4H/sLI03BqtMxzaWtMxgEvJup/r1Dj/BErqYeIgDcRjt+g59o8KJZuFHQllKq4Blu3p/cqW
	hlWQHuw==
X-Gm-Gg: ASbGnctoxcfF5V3Fo6FsGfHhFK8NbOe5BhNu0p2CjTiFXvCeUMAM6TZ9wIuNfPAICgf
	kqaWFc5n7B/LSN98/BkQdRXLamDAD9gELtTPDJKxqq8xosOH5OdyO6R33lRLs7kWuPM2qzwTySs
	giiOcYJs/17Ktt7A48Kta2BQCuC4OTSlO7MhgNNVpYTQKwfhOdtAWlQTnSTUJdN50XGpctUFGrk
	c5UqC/6iOO7wZnqoLxB800U1Jxo5nTi5fymXTm2xpZZf+ubio9VRlecVqLE5kM6HLvVdNdTak5G
	tfkug6bGoonbzNxy3cz6ciiu
X-Google-Smtp-Source: AGHT+IFyD7trZxeQ1bNaA7XAObgXTPSJz0JTgRH6BMMKUIGUKUcEle+PEaDFAkx6GV+JJGQ1kiFo7g==
X-Received: by 2002:a17:906:9555:b0:aa6:21ce:cddf with SMTP id a640c23a62f3a-aa63a131011mr2903066b.36.1733426376487;
        Thu, 05 Dec 2024 11:19:36 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62602cff7sm130659566b.130.2024.12.05.11.19.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 11:19:35 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d2726c0d45so1386060a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 11:19:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX67oaO3usMJwod/0N+DHODNJPKdiC0Ye6fXpWQ9xut4/qB+0hybGJNG0dnQPkcb7gpUeVQjJQAx5RwZ4w=@vger.kernel.org
X-Received: by 2002:a17:906:18b2:b0:aa6:23ba:d8c5 with SMTP id
 a640c23a62f3a-aa639fbda5cmr3997966b.10.1733426374829; Thu, 05 Dec 2024
 11:19:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733421037.git.geert+renesas@glider.be> <46b320b91b8d86fade3c1b1c72ef94da85b45d0d.1733421037.git.geert+renesas@glider.be>
In-Reply-To: <46b320b91b8d86fade3c1b1c72ef94da85b45d0d.1733421037.git.geert+renesas@glider.be>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Dec 2024 11:19:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiwAz3UgPOWK3RdGXDnTRHcwVbxpuxCQt_0SoAJC-oGXQ@mail.gmail.com>
Message-ID: <CAHk-=wiwAz3UgPOWK3RdGXDnTRHcwVbxpuxCQt_0SoAJC-oGXQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Increase minimum git commit ID abbreviation to 16 characters
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thorsten Leemhuis <linux@leemhuis.info>, Andy Whitcroft <apw@canonical.com>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@corigine.com>, 
	Simon Horman <horms@kernel.org>, Conor Dooley <conor@kernel.org>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Dec 2024 at 10:16, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>
> Hence according to the Birthday Paradox, collisions of 12-chararacter
> git commit IDs are imminent, or already happening.

Note that ambiguous commit IDs are not even remotely as scary as this implies.

Yes, the current kernel tree has over ten million objects, and when
you look at stable trees etc, you can easily see more.

But commits are only a fraction (about 1/8th) of the total objects. My
tree is at about 1.3M commits, so we're basically an order of
magnitude off the point where collisions start being an issue wrt
commit IDs.

Can you find collisions by looking at all objects? Yes. Git will do
that for you, and tell you their types. But to take one recent
example, let's do the 6.12 commit:
adc218676eef25575469234709c2d87185ca223a. To get an ambiguous ID, you
have to go down to 6 characters, and even then git will tell you
there's only one object that is a commit, ie

   $ git show adc218

results in

  error: short object ID adc218 is ambiguous
  hint: The candidates are:
  hint:   adc218676eef commit 2024-11-17 - Linux 6.12
  hint:   adc2184009c5 blob

so right now you have a collision in six digits for that commit, but
even then it's actually still entirely unambiguous once you know
you're talking about a commit.

Are there worse cases? Yup. With just 7 characters, you get commits
like 95b861a that actually have three ambiguous commit IDs. And you
still get ambiguous results with 9 characters.

With 10 characters, there are no collisions. So the "we're an order of
magnitude off" seems about right - you get slightly more than one
order of magnitude for each two digits.

And remember: we're an order of magnitude off *AFTER 20 YEARS OF GIT HISTORY*.

Furthermore, the "in the future" argument is bogus. Yes, there will be
more commits in the future, but it's not going to suddenly make old
SHA ID's somehow more ambiguous, since you can also take history into
account - and when quoting the short format it should always be
accompanied by the first line of the commit message too.

Why do I care? Because long git commit IDs are actually detrimental to
legibility. I try to make commit messages legible, and that very much
is the *point* of the short format. It's for people, not machinery.

Yes, the basic git machinery doesn't do object type disambiguation
(and if you do "git show", you can give it blob IDs etc, so git itself
may not know about the proper type to use disambiguate at all). And
git also doesn't know about the whole "we also put the first line of
the commit message" thing.

But honestly, I'm claiming that something like

    Fixes: 48bcda684823 ("tracing: Remove definition of trace_*_rcuidle()")

(to pick a random recent commit) is completely unambiguous for the
intended audience, and will remain so forever within the context that
it is in.

And I think the "intended audience" here is important. 12 characters
is already line noise, and causes occasional odd line wrapping (you
don't see that in things like the "Fixes:" tags, but you do see it in
the better commit messages that refer to the commits they fix).

I think we should accept that it's not the full SHA1, and also accept
what that really means.

Final note: personally, I find that the SHA1 - shortened or not - is
often *less* descriptive than the shortlog, for the simple reason that
rebasing happens, and people refer to other commits with stale commit
IDs. That's an issue that I personally hit regularly, and it has a
fairly simple solution in the form of

    git log --grep="..one-liner goes here.."

and my point here is that if you rely too much on the SHA1, your
workflow is *ALREADY* broken, and it has nothing to do with the
shortening.

Put another way: if you have particular tooling that you worry about,
I think you should look at the tooling. You can find real examples of
much shorted commit IDs in the kernel, and real examples of the MUCH
MORE REAL issue of wrong commit ID's right now.

See for example:

   0a1336c8c935 ("IB/ipath: Fix IRQ for PCI Express HCAs")

which refers to commit 51f65ebc ("IB/ipath - program intconfig
register using new HT irq hook"), which is still perfectly unique, but
then look at

   2e61c646edfa ("mlx4_core: Use mmiowb() to avoid firmware commands
getting jumbled up")

which refers to commit 66547550 ("IB/mthca: Use mmiowb() to avoid
firmware commands getting jumbled up"). That commit doesn't exist at
all - it's not ambiguous due to being short, it's ambiguous due to
being *wrong* (presumably due to a rebase)(.

The real commit ID? 76d7cc0345a0. Easily found using the
human-readable shortlog,

So here's the meat of the argument: you are barking up the wrong tree.
We have real and present issues that have been going on since at least
2007, and they have *nothing* to do with the short SHA1s.

I don't want to make the short SHA1's worse, when the real and present
problems are elsewhere.

Make the tools deal with the cases we already have, and you'll find
that the shortening is a complete non-issue.

                Linus

