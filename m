Return-Path: <linux-kernel+bounces-417527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B5E9D552A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 603F5B225D1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A34D1DC054;
	Thu, 21 Nov 2024 22:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2Cf1gP5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93121176AC7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732226763; cv=none; b=RYnArnDB74Mcqg3rzs1yU0cQ3shNyebItf8XpEd8bAowNlWVcQpMnnMaChReSECmjnXl2uv/KSBT4emH4JcBwrJeHMqtE70j3OA8hiYjxzXixowHdo8NKtrXZJJswPC73opltMQcE058vIJat3fR1t1syV6fhRanq2gVydEbi5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732226763; c=relaxed/simple;
	bh=+5feOPw/FgR2n5SUw0ttWi09RQYbsgXOgGG63d1u/OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMfNbgBoJFYO982l6t+f6kVQrjhRpBCiTYwdjyfZwOYzgFPZ0akzmMWdLB0V1bZQMToWnkaGDQKwPkw3gBruSBD18h6ADoQfVzwGEsnqCSYtqifYqfThUpor37bqv0nqmoFSFCsWXG61RcuQwYb/ecpCRfHMUjZFP3qZG+81jCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2Cf1gP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177A3C4CECC;
	Thu, 21 Nov 2024 22:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732226763;
	bh=+5feOPw/FgR2n5SUw0ttWi09RQYbsgXOgGG63d1u/OE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k2Cf1gP5M2qTFU7nfQYFhlunQ8t/Jl2aihHfZmgycjRL3CRl6uc4Ibtgt6jnHIyCt
	 sSz8P+cFv8ttxlfCkxZc1wtfblglkHr4bpTFTBcxovVtyLBGB/RgEtL+pAn/ZqFVVt
	 PKiCw7YeMpyKDJVW2tGuiGkK9iUOhfhpxYw+79sugz3VZX7TGHPQws5oh9w5HvpKTn
	 tPG7TbQpL1CnIhmfP5HizYFthzoQOj+12gCEBJrZ9Xs0RaCf61+ZAtLyhKHkIJ+5xq
	 BcZwM2nTCSn/0qpATrpieVBPICMjA52uzwmar+kwlqEyXg0ZJb/d20+B9WRhCVky5L
	 yOs36/GLTnAGg==
Date: Thu, 21 Nov 2024 14:06:00 -0800
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Nir Lichtman <nir@lichtman.org>,
	syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com,
	Tycho Andersen <tandersen@netflix.com>,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1
Message-ID: <202411211302.08EEE6D395@keescook>
References: <202411190900.FE40FA5@keescook>
 <CAHk-=wgB1L75+C89AU62n4jBEiwKs=e4dvBDOoLQ13rUwJLFXQ@mail.gmail.com>
 <87jzcxv227.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wifNC+AAGVDN-B1gGNhKGqhnkoqWKCknAo6107oD0zGWA@mail.gmail.com>
 <Zz9sTFBQQSe1P8AI@kawka3.in.waw.pl>
 <CAHk-=wiJZDxO+Wgmg8f=Cio9AgmJ85V7do4kxroKejHNsS80hQ@mail.gmail.com>
 <Zz91LyHzxxOLEma_@kawka3.in.waw.pl>
 <CAHk-=whv4q-RBXmc9G7NZ4GiATqE_ORU05f=9g00HkQXbV7vqw@mail.gmail.com>
 <202411211011.C2E3ABEAB@keescook>
 <CAHk-=wgfX4dvvKo8PrPZj76Z2ULMMK2RvaF+O7QhLnwOSBYdhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgfX4dvvKo8PrPZj76Z2ULMMK2RvaF+O7QhLnwOSBYdhQ@mail.gmail.com>

On Thu, Nov 21, 2024 at 11:23:46AM -0800, Linus Torvalds wrote:
> I'm done with this discussion that apparently was brought on by people
> not knowing what the hell they were doing.

This is disrespectful. If you're frustrated you can just say so. I'm
certainly frustrated.

> For user space, comm[] is basically the fallback for when cmdline
> fails for some reason (for example, /proc/*/cmdline will be empty for
> kworkers, but there are other situations too)
> 
> The reason? comm[] has *always* been much too limited for 'ps' output. ALWAYS.
> 
> Yes, you can literally *force* ps to not do that (eg "ps -eo comm")
> but if you do that, you get the very limited comm[] output that nobody
> has ever wanted ps to give exactly because it's so limited.

I think I finally figured out why you keep saying this. I think you mean
to imply "ps -e" (or similar), not "ps". Asking for more process details
("ps a", "ps -f", "ps -e", etc) uses cmdline. Without options that turn
on more details, the default is comm. If you run just "ps", it shows comm:

$ strace ps 2>&1 | grep /cmdline | wc -l
0

If you run with detail options it shows cmdline:

$ strace ps a 2>&1 | grep /cmdline | wc -l
1266
$ strace ps -f 2>&1 | grep /cmdline | wc -l
1266

This is procps-ng found on all Debian and Ubuntu systems. AFAICT
procps-ng is used on Fedora too.

Note I'm not saying comm is GOOD or anything. I'm just saying that it
IS regularly visible.

> And yes, 'top' will give comm[] output because it's so much faster.

Exactly. By default, top and ps both show comm, which in the vast
majority of cases is identical to argv[0]. I don't understand why this
is causing such angst -- it's just the observable facts: many things in
userspace expose comm and many also expose cmdline. Having them be
mismatched due to fexecve() is the whole issue.

Nobody blinks at:

    $ ps
        PID TTY          TIME CMD
    4125309 pts/1    00:00:47 bash
    4171960 pts/1    00:00:00 bash
    4171962 pts/1    00:00:00 vim
    4171997 pts/1    00:00:00 ps

vs

    $ ps -f
    UID          PID    PPID  C STIME TTY          TIME CMD
    kees     4125309    3947  0 Jul11 pts/1    00:00:47 -bash
    kees     4171960 4125309  0 13:30 pts/1    00:00:00 -bash
    kees     4171962 4171960  0 13:30 pts/1    00:00:00 vim
    kees     4172004 4125309  0 13:30 pts/1    00:00:00 ps -f

But if fexecve() were used now, "ps" would show:

    $ ps
        PID TTY          TIME CMD
    4125309 pts/1    00:00:47 3
    4171960 pts/1    00:00:00 3
    4171962 pts/1    00:00:00 3
    4171997 pts/1    00:00:00 3

This is obviously horrible.

Using f_path, we'd get close, but symlink destinations (or weird stuff
like "memfd:name-here") are shown:

    $ realpath $(which vim)
    /usr/bin/vim.basic

    $ ps
        PID TTY          TIME CMD
    4125309 pts/1    00:00:47 bash
    4171960 pts/1    00:00:00 bash
    4171962 pts/1    00:00:00 vim.basic
    4171997 pts/1    00:00:00 ps

Using argv[0], we'd get the original output:

    $ ps
        PID TTY          TIME CMD
    4125309 pts/1    00:00:47 bash
    4171960 pts/1    00:00:00 bash
    4171962 pts/1    00:00:00 vim
    4171997 pts/1    00:00:00 ps

IMO, switching to fexecve() shouldn't regress this basic piece of
information.

Now, I think we have three choices:

1) Leave it as-is. (comm is useless)

2) Use argv[0]. (comm matches what would show with execve() in most cases)

3) Use f_path (comm exposes f_path dentry name, which matches
   basename(readlink(/proc/*/exe)), but doesn't always match what execve()
   would show).

I think everyone agrees "1" should go away.

So it comes down to trying to stay looking more like execve()'s comm, or
more like /proc/*/exe's value.

Since comm is mutable anyway, I feel like the "friendlier" default for
userspace would be option 2.

If you still conclude differently, I guess the discussion is over, and
we go with 3:

diff --git a/fs/exec.c b/fs/exec.c
index e0435b31a811..8688bbbaf4af 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1347,7 +1347,21 @@ int begin_new_exec(struct linux_binprm * bprm)
 		set_dumpable(current->mm, SUID_DUMP_USER);
 
 	perf_event_exec();
-	__set_task_comm(me, kbasename(bprm->filename), true);
+
+	/*
+	 * If fdpath was set, alloc_bprm() made up a path that will
+	 * probably not be useful to admins running ps or similar.
+	 * Let's fix it up to be something reasonable.
+	 */
+	if (bprm->fdpath) {
+		rcu_read_lock();
+		__set_task_comm(me, smp_load_acquire(&bprm->file->f_path.dentry->d_name.name),
+				true);
+		rcu_read_unlock();
+	}
+	else {
+		__set_task_comm(me, kbasename(bprm->filename), true);
+	}
 
 	/* An exec changes our domain. We are no longer part of the thread
 	   group */


I've minimally tested this.

-Kees

-- 
Kees Cook

