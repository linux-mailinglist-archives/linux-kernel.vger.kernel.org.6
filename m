Return-Path: <linux-kernel+bounces-425194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3ED9DBEBC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 03:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ECADB2171F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 02:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9D013D518;
	Fri, 29 Nov 2024 02:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="apb8GmoI"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2182E79CD
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 02:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732848234; cv=none; b=tr85NJc7sncFxEPJi3Gu04PxxodIPdWRKA/+c2UrnnL54ioK6VQw7ICSeKAM6RpesS3McbCKk3HxA9ECnuPhxF6IhAm5cp0mgVYcaIKqzv8BdkwvJZLI5dH/cLhKiP6Z2NhtoFJg9A1Ru8ANfavqQQ7Aow01KHelxPSq59syf5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732848234; c=relaxed/simple;
	bh=KSa24GVGbn2egYPrnqDd/PxTajlOXHtut5rD72P4dCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUqCXRYRXF6+QiAFYjIKaBz1ibfdvIKy4xe5QDhosrAP0bqdPlX6xR7c1bIk+7GkPJrXE68m7njmf4SaCxVfaNxyQrjUwPRRuZ/MxHCOHa2YBhroGRpEo/g0BkfFxN1UPDuJJS2QDanPAWSvqz0Gx2xbUvDtJ5fd5sK4TciF6/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=apb8GmoI; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cfa90e04c2so1508951a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 18:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732848230; x=1733453030; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SoAsme5g6ySWuKOhjPK2e/rWd2oyZH8OFUS2gV20JX8=;
        b=apb8GmoIWnD+hbp/cOn3x3QZg0UCoe/1JVk15nJ3gLjxbQVQRYfv5TZ1ZRJ/ULhoaw
         0z93wVUnklzvfrVwgWoZ57D8+G91zM/SH2LPEZIrkQVN5rzmpDnaYE703JMLx+TtuZUS
         KELUlx3XQKCmPIrgt3OZ13LF38r4GWcchZKe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732848230; x=1733453030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SoAsme5g6ySWuKOhjPK2e/rWd2oyZH8OFUS2gV20JX8=;
        b=g/2BgHMcHh/g6njUwyrj0xAEx6hte2JaV5LueiYvD41G23UsyhyQqMO9GXKvq8Yh2M
         g0QFwMQe0nsztWLG6f38TV2fv3GaCRXONJMwdQO9tUtHIdoROXFneYkjtR2T26whEhR5
         ZiC5leku2Lt8PkM5WRnrdyoWL46slCS2IdGdg9+LuOJj5/A/EHplxyAknTqGrFvQYPJq
         VFnsfyTYiWiVc2yunoVQXMLEH4sc1t4A88oGSEYByZddgFTdLnfTiaWFZVoM7fdDev6q
         MhTsgLGv4iZ7wuPsjfI2A2gexIYs3nMxEawh9PLTj+e5Ovny7HdX2t4VYS8scDKd2TEv
         2V5A==
X-Forwarded-Encrypted: i=1; AJvYcCXCnpvHM4hSfcfcJtn3VRBQtT1rqbEqopxgXZU10Zmxr8a7dFc4CujGm9rYkQoiAGC1gOELgSqAFpZ8u9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJGjhEBtU6U5yulCDkmTVuhJ12Im+pQVc/QsjGt5BBjLhE/Imh
	hfYM/G87/abkPerZYSonAa0j7RGyTQryNUVbT6klHPDRNY5xwyoxRNuIO2k5xMw16Hgni7eX4aT
	9B+wbFA==
X-Gm-Gg: ASbGncsdelvI1T1df1U/G5AkMqukQ/dbZGdL4AdvlTpun6ZWp0fkFvQL5Atr121iQEC
	E6XQ8+ipSE62KrGg90q43yl9dpl+2LQ337eOQSVbHEYDvOQy5PUvZ51kDfEXg13m56Pz/khE9nf
	7ir6nB49xyeDGoGEtRB7M3S0y99ho6aMtJi16Le5pIrJ/9QbEj2xZgpyqG0ewpKeZgQWSJjiNoG
	Ee/MNOFi7HnyPubkNBblvU6xogCsrkUfFh9o+V5aADiA4E6EzKnGhI1kAyxCOKrOAW/7MvDOqgR
	iwxuilQBXve0lB2QheEZab4o
X-Google-Smtp-Source: AGHT+IEk+uBDc5olcItn/gN9Ujb5mOOWHcXisiLXPbNkJaGZjvGSZE1okAzuP609rljRk9uNE+vFeA==
X-Received: by 2002:a05:6402:40c6:b0:5cf:dc64:90aa with SMTP id 4fb4d7f45d1cf-5d080b8aff1mr8020609a12.1.1732848230181;
        Thu, 28 Nov 2024 18:43:50 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097dd5d80sm1388051a12.41.2024.11.28.18.43.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 18:43:48 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa5302a0901so158005266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 18:43:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVV/xCXOARFVyriuqFKcVG5I84t+/xWgFBuKr/j2R82BPtPDhqhn6I1l7q+N0jcQ0H/skDuCVb74u1rsrs=@vger.kernel.org
X-Received: by 2002:a17:906:3d29:b0:aa5:1699:e25a with SMTP id
 a640c23a62f3a-aa580ee98eamr661113666b.10.1732848227621; Thu, 28 Nov 2024
 18:43:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411210651.CD8B5A3B98@keescook> <CAHk-=wjMagH_5-_8KhAOJ+YSjXUR5FELYxFgqtWBHOhKyUzGxA@mail.gmail.com>
 <05F133C4-DB2D-4186-9243-E9E18FCBF745@kernel.org> <CAHk-=wgEjs8bwSMSpoyFRiUT=_NEFzF8BXFEvYzVQCu8RD=WmA@mail.gmail.com>
 <202411271645.04C3508@keescook> <CAHk-=wi+_a9Y8DtEp2P9RnDCjn=gd4ym_5ddSTEAadAyzy1rkw@mail.gmail.com>
 <20241128020558.GF3387508@ZenIV> <CAHk-=whb+V5UC0kuJkBByeEkeRGyLhTupBvpF-z57Hvmn7kszA@mail.gmail.com>
 <13223528-74FF-4B68-B0CF-25DCC995D0A0@kernel.org>
In-Reply-To: <13223528-74FF-4B68-B0CF-25DCC995D0A0@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Nov 2024 18:43:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgKgi5eqo6oW0bBS2-Cr+d4jraoKfVq6wbmdiWWsZbMLw@mail.gmail.com>
Message-ID: <CAHk-=wgKgi5eqo6oW0bBS2-Cr+d4jraoKfVq6wbmdiWWsZbMLw@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1 (take 2)
To: Kees Cook <kees@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	Nir Lichtman <nir@lichtman.org>, Tycho Andersen <tandersen@netflix.com>, 
	Vegard Nossum <vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 18:08, Kees Cook <kees@kernel.org> wrote:
>
> Okay, so, that last thing I can see here as an option is to add an exec-specific AT flag, and if that isn't workable I don't see a way to make this happen with execveat.

So Kees, ask yourself WHY you want to do this idiotic thing in the first place.

You say "isn't workable" and "I don't see a way to make this happen
with execveat".

But be HONEST now. Really - take a step back, and ask yourself what
are actually sane semantics.

And do NOT think about the insane semantics that you have been
spoon-fed by some insane and broken argument where somebody told you
what they wanted and said "this is what systemd needs". A project that
is *famous* for doing things wrong?

Instead, ask yourself that the *sane* semantics are, when you DON'T
come from them from "somebody crazy told me what they want".

Look at regular "execve()". Really. What is "comm[]" when you do an execveat?

It's THE NAME OF THE EXECUTABLE.

It's not "some different thing that was passed in separately".

It wasn't argv[0] for regular execve(), was it? Even though regular
execve() very much also has an argv[0].

So if it wasn't argv[0] for regular execve(), what *is* it, really?

And what is the equivalent for execveat(fd, "", AT_EMPTY_PATH)?

Can you ask yourself that WITHOUT the spoon-fed answer - hint, it was
wrong - that you have been arguing for.

Here's a hint: it's the name of the executable you are running.

That's it. Really.

It clearly was NEVER "argv[0]". That has nothing to do with the name
of the executable, has nothing to do with what regular execve() does,
and clearly has no relationship with what you are executing.

IO tried to tell you. Then I tried to *show* you how even in the
kernel sources we had very real examples of "execveat()" that had a
argv[0] that was entirely unrelated to the executable. You seem to not
have figured it out.

Here's another hint: it's not "", and it's not "some other string I
pass in with a separate flag to give that string meaning".

It's also not the name of the symlink that was dereferenced in an
earlier system call and that resulted in that 'fd' file descriptor.

That symlink is gone. It might literally not exist any more by the
time you do the execveat(), but even if it did, the very act of
opening it made it irrelevant. The open followed the symlink, the
symlink is done with. That's how symlinks work, and it's literally the
difference between a symlink and a hardlink.

And I claim that if you are actually honest about it, you'll come up
with the name that I told you about originally. Because that
dentry->d_name really *IS* the name of the file that is associated
with the 'fd'.

So here's the deal: stop making excuses. Stop ignoring reality. Stop
this idiocy of trying to impose some new meaning on 'comm[]' that
makes no sense, and has *NOTHING* to do with a regular 'execve()'.

And furthermore, start looking at your own motivations. Why are you
taking at face value the word of somebody who claims that "this is
what systemd wants, and the symlink name is magical"?

Face the fact that maybe systemd is famous for bad decisions, and this
is just another example of it.

A sane setup has lots of options

 - just use execve() with the actual name of the executable

 - use hardlinks and use execveat()

 - use open() on a symlink and then execveat() of that file, and get
the actual name of the executable behind the symlink

 - disagree about comm[] being relevant at all, and don't use it, and
don't use tools that do

and none of those are wrong decisions.

But what *is* wrong is to argue for something insane because you
didn't accept the sane end result.

Spend your time trying to convince the systemd people to do the sane
thing instead of trying to make the kernel do something stupid, ok?

Because I'm done with this argument.

If I get more stupid emails on this, I will just block you. Because my
time isn't worth arguing with flat-earthers. Learn to accept reality.
In the kernel we have some taste.

                 Linus

