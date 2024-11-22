Return-Path: <linux-kernel+bounces-417883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7464F9D5A33
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC571F2277D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 07:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2936116F0EB;
	Fri, 22 Nov 2024 07:47:35 +0000 (UTC)
Received: from kawka3.in.waw.pl (kawka3.in.waw.pl [68.183.222.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70AF1531C8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.183.222.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732261654; cv=none; b=jUms5Aws+MgM2ZLcSyYPPvatPWd3WZwRLNsJdI0tGlpsrduiRA+ZUmbMXKQJs/hy75KBw4M4jAP3gBbUbeFwWt7QJ9SUOpWvskAawuyojVDRO3LTMtGAlYq9N46MegTKQ88JLfgzRFcmUfvy87BV5dnE0jv4ABC1B9vytRJOV7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732261654; c=relaxed/simple;
	bh=au0BsQuRyF+qQkfLCM+mXhHc6K5HiLohtpBETlpVkd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAOCkYtn0GERVCFXENTxBEck4DeNxXKcLWULfn7Wxu2bAic+gyLAC/+vuI4lf8m58hSdx+Z+vo9m7eEfaxEXOp4NmnS4MWf+xdtzaU915nWh3w040cjjXZJusAMd8CfERr8ZFM+YoWcgCG1lTyy+KeUWhDk790a+GCzVAYnWK3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=in.waw.pl; spf=pass smtp.mailfrom=in.waw.pl; arc=none smtp.client-ip=68.183.222.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=in.waw.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in.waw.pl
Received: by kawka3.in.waw.pl (Postfix, from userid 1000)
	id BABA55A4402; Fri, 22 Nov 2024 07:47:30 +0000 (UTC)
Date: Fri, 22 Nov 2024 07:47:30 +0000
From: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Nir Lichtman <nir@lichtman.org>,
	syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com,
	Tycho Andersen <tandersen@netflix.com>,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1
Message-ID: <Z0A3EkxZZg19Dp9Q@kawka3.in.waw.pl>
References: <202411190900.FE40FA5@keescook>
 <CAHk-=wgB1L75+C89AU62n4jBEiwKs=e4dvBDOoLQ13rUwJLFXQ@mail.gmail.com>
 <87jzcxv227.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wifNC+AAGVDN-B1gGNhKGqhnkoqWKCknAo6107oD0zGWA@mail.gmail.com>
 <Zz9sTFBQQSe1P8AI@kawka3.in.waw.pl>
 <87zflrsw1c.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zflrsw1c.fsf@email.froward.int.ebiederm.org>

On Thu, Nov 21, 2024 at 10:59:59PM -0600, Eric W. Biederman wrote:
> Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl> writes:
> 
> > On Wed, Nov 20, 2024 at 06:23:55PM -0800, Linus Torvalds wrote:
> >> On Wed, 20 Nov 2024 at 16:55, Eric W. Biederman <ebiederm@xmission.com> wrote:
> >> >
> >> > __set_task_comm cannot be called with bprm->file->f_dentry
> >> > unconditionally.
> >> 
> >> No, no. Only for the "no path" case.
> >> 
> >> > The reason bprm->file->f_dentry.dentry was abandoned were concerns
> >> > about breaking userspace.
> >> 
> >> There's no way it can break user space considering that right now
> >> comm[] ends up being just garbage.
> >
> > It'll "break userspace" in the sense the the resulting program name
> > visible in /proc/self/{comm,stat,status} would be different than the
> > expected value.
> 
> This actually has not been shown.
> 
> In the general case of programs on linux it is indeed the case
> we have multi-call binaries and symlinks to binaries.
> 
> Limiting things to just fexecve reduces the scope,
> I didn't think about the scope reduction when you made this argument the
> first time.
> 
> I do not see any evidence that there are daemons started by systemd
> where systemd follows the name in /etc/alternatives on debian, or winds
> up following a symlink on a multicall binary.  The way I understand
> /etc/alternatives I don't think you would ever want to use it for the
> name of a daemon that is put in a unit file.

systemd-udevd is one example that ~everybody has installed.
(Though it doesn't use comm, it uses argv[0] to decide behaviour.)

We can certainly find more, on my Fedora system, 337/2252 files
in /usr/sbin/ are symlinks, quite a few candidates.
But even if we went through every one of those, it's not enough,
because people have custom unit files and there's also systemd-run
and run0.

> All of these cases where you get a task->comm that would be different
> with fexecve are rare oddball cases today.  I think it is quite likely
> nothing systemd wants to start with fexecve will have this problem.
> 
> Further you can detect this problem before you get as far as starting
> the application.  Just pass O_NOFOLLOW to open and you can refuse to
> follow the potentially confusing symlinks.

We'd have two choices: refuse the command, which is not really a great
option, or fall back to execve(), an approach which I find really
unappealing.

> So short of finding real programs in the real world that actually care
> it seems perfectly reasonable to do the cheap and easy thing.
>
> Right now it feels like you are adopting a very cautious approach and
> arguing for an expensive implementation simply because it is a lot of
> work to figure out what programs you actually care about and see what
> those programs are actually doing.

So it's not really "programs" per se. For example, systemd itself
doesn't care at all, because it uses cgroups to manage processes. I've
been using systemd-with-fexecve for two years and apart from strange 'ps'
listings, it's all fine. But we have administrators and scripts.
For example, 'pgrep systemd-udevd' and 'pkill -HUP httpd' and a
bazillion other calls that we cannot ever find or change.

> On the system I am writing this on right now there are about 300
> processes running and only about 17 whose parent is pid 1.  Most of
> those process whose parent is pid 1 run as root.  Which means extra care
> needs to be taken with them anyway.

This would also affect user process started by 'systemd --user',
i.e. most of the graphical user session nowadays (under GNOME, KDE,
etc.)

> > Even if we end up copying a string from userspace unnecessarilly,
> > does this matter? execve is a heavyweight operation and copying a
> > a dozen bytes extra hardly matters.
> 
> Generally it is on the person arguing for making the kernel more
> expensive to find a compelling case.  In this instance my imagination
> fails me in finding a binary that systemd will start that will be
> affected.  So I simply don't see the point in making the code
> more expensive.
> 
> I was really hoping we could use the cheap bprm->file->f_dentry
> to set task->comm in all cases as that would make the kernel
> simpler and faster.
> 
> To me using bprm->file->f_dentry still seems to make more sense than a
> field whose value (in the case of login shells) is documented as being
> different from what you are looking for.
> 
> There is no solution that doesn't have down sides.  As such the kernel
> might as well use a solution that is cheap and as close to how
> task->comm has been calculated historically as possible.

Right. It comes down to judgement / guesswork about the downsides of
each approach.

As I wrote before, the approach with bprm->file->f_dentry is _much_
better than what we have now. So I'll take that over status quo.
But from the POV of a distro maintainer, it's not ideal. Basically,
with the patch that uses argv[0], I expect almost no user-visible
change, so I can rebuild systemd with -Dfexecve=true in Fedora and
maybe send a mail to fedora-devel with "hey, watch out, the way
systemd starts processes has been changed, selinux could be affected,
please report any errors".

With the f_dentry version, we'll still do the transition, but we'll
need to make an effort to warn users and do it much more visibly, and
based on past experience with such things, there'll still inevitably
be users who report that their favourite backup script that they call
from the git checkout now doesn't terminate properly and stuff like
that. Every kernel maintainer knows that any aspect of behaviour that
is visibile to users starts being relied on…

I think fexecve is a nice feature (as all the fd-based syscalls
in general), but it need to be drop-in replacement if it's supposed
to be adopted quickly.

Zbyszek

