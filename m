Return-Path: <linux-kernel+bounces-420131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5287C9D7558
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 16:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EDD6168CAE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 15:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6381B218E;
	Sun, 24 Nov 2024 15:22:06 +0000 (UTC)
Received: from kawka3.in.waw.pl (kawka3.in.waw.pl [68.183.222.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A04186E40
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.183.222.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732461725; cv=none; b=nNVAI7+vrXPSl6CabUvJTV2OHtmAiITSWWCaakr4IgRfQiw1oNocNdkKZa8wdgKdudtl7GsysaekKxjAP/9aMlLyzR+lqLorNTYYjM03Qr63CFmjRhzLAPh+iPmD20LcSDR+xnaZ7QHK3XAHmpRdIm0ukFEDKF6MaYEfctpnx6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732461725; c=relaxed/simple;
	bh=om5sJbYoxsg/SMZqkKbwlS2LdwKnxO4yP322tUo7DfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=im9pCTW3FRALgqyBjFjyhWK6QtcuxCE7eabYHCVTT9RA3U9oS7veO2E/D8Sprzdf9AGuAwQ+8faRur+YpusIJ+NflqK/vCuBgMmmCxq39P/LgIQ4rZOIZxpGg3kT3WkzA/zXUNWTedCK/l00TgbZGEglrO+dVlAF7jBTlLzJuKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=in.waw.pl; spf=pass smtp.mailfrom=in.waw.pl; arc=none smtp.client-ip=68.183.222.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=in.waw.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in.waw.pl
Received: by kawka3.in.waw.pl (Postfix, from userid 1000)
	id 7DD485A949B; Sun, 24 Nov 2024 15:21:55 +0000 (UTC)
Date: Sun, 24 Nov 2024 15:21:55 +0000
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
Message-ID: <Z0NEk3M8zqXilFRm@kawka3.in.waw.pl>
References: <202411190900.FE40FA5@keescook>
 <CAHk-=wgB1L75+C89AU62n4jBEiwKs=e4dvBDOoLQ13rUwJLFXQ@mail.gmail.com>
 <87jzcxv227.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wifNC+AAGVDN-B1gGNhKGqhnkoqWKCknAo6107oD0zGWA@mail.gmail.com>
 <Zz9sTFBQQSe1P8AI@kawka3.in.waw.pl>
 <87zflrsw1c.fsf@email.froward.int.ebiederm.org>
 <Z0A3EkxZZg19Dp9Q@kawka3.in.waw.pl>
 <87frnjqqh6.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87frnjqqh6.fsf@email.froward.int.ebiederm.org>

On Fri, Nov 22, 2024 at 08:43:01AM -0600, Eric W. Biederman wrote:
> Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl> writes:
> 
> > On Thu, Nov 21, 2024 at 10:59:59PM -0600, Eric W. Biederman wrote:
> >> Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl> writes:
> >> 
> >> > On Wed, Nov 20, 2024 at 06:23:55PM -0800, Linus Torvalds wrote:
> >> >> On Wed, 20 Nov 2024 at 16:55, Eric W. Biederman <ebiederm@xmission.com> wrote:
> >> >> >
> >> >> > __set_task_comm cannot be called with bprm->file->f_dentry
> >> >> > unconditionally.
> >> >> 
> >> >> No, no. Only for the "no path" case.
> >> >> 
> >> >> > The reason bprm->file->f_dentry.dentry was abandoned were concerns
> >> >> > about breaking userspace.
> >> >> 
> >> >> There's no way it can break user space considering that right now
> >> >> comm[] ends up being just garbage.
> >> >
> >> > It'll "break userspace" in the sense the the resulting program name
> >> > visible in /proc/self/{comm,stat,status} would be different than the
> >> > expected value.
> >> 
> >> This actually has not been shown.
> >> 
> >> In the general case of programs on linux it is indeed the case
> >> we have multi-call binaries and symlinks to binaries.
> >> 
> >> Limiting things to just fexecve reduces the scope,
> >> I didn't think about the scope reduction when you made this argument the
> >> first time.
> >> 
> >> I do not see any evidence that there are daemons started by systemd
> >> where systemd follows the name in /etc/alternatives on debian, or winds
> >> up following a symlink on a multicall binary.  The way I understand
> >> /etc/alternatives I don't think you would ever want to use it for the
> >> name of a daemon that is put in a unit file.
> >
> > systemd-udevd is one example that ~everybody has installed.
> > (Though it doesn't use comm, it uses argv[0] to decide behaviour.)
> 
> As far as I can tell using task->comm is a bug.
> argv[0] is cheaper and the unix convention for deciding program
> behavior.

I don't understand what you mean by "a bug". As I wrote, systemd-udevd
does NOT use comm. And in other places, no matter what you or I might
wish, comm definitely IS used. Any place with pgrep or pkill is doing
exactly that. So an assertion that it's against a "unix convention" 
is unjustified.

[snip part about udev]

> It is worth remembering that hardlinks are going to be cheaper all
> around for this sort of thing.  The only reason I see for using
> symlinks is that you can see that something is an alias.

Yes. Symlinks are used so that that aliasing is visible.
The second reason is that symlinks can be used across devices,
so for example a symlink can be made from /etc/aliases to /usr,
which are sometimes on different devices.
The third reason is that when things are split between different
packages (in the sense of distro packages), a package can contain
multiple files that are hardlinked, and a package can contain a
symlink to a file in a different package (or even something that
is not packaged), but a package cannot natively provide a hardlink
to a file in a different package. (A post-install scriptlet could
make a hardlink, but that's much more work and preferrably avoided,
even if technically possible.)

> > We can certainly find more, on my Fedora system, 337/2252 files
> > in /usr/sbin/ are symlinks, quite a few candidates.
> > But even if we went through every one of those, it's not enough,
> > because people have custom unit files and there's also systemd-run
> > and run0.
> 
> >> All of these cases where you get a task->comm that would be different
> >> with fexecve are rare oddball cases today.  I think it is quite likely
> >> nothing systemd wants to start with fexecve will have this problem.
> >> 
> >> Further you can detect this problem before you get as far as starting
> >> the application.  Just pass O_NOFOLLOW to open and you can refuse to
> >> follow the potentially confusing symlinks.
> >
> > We'd have two choices: refuse the command, which is not really a great
> > option, or fall back to execve(), an approach which I find really
> > unappealing.
> 
> It also allows you to report the program and quickly find which cases
> might be a problem.



> >> So short of finding real programs in the real world that actually care
> >> it seems perfectly reasonable to do the cheap and easy thing.
> >>
> >> Right now it feels like you are adopting a very cautious approach and
> >> arguing for an expensive implementation simply because it is a lot of
> >> work to figure out what programs you actually care about and see what
> >> those programs are actually doing.
> >
> > So it's not really "programs" per se. For example, systemd itself
> > doesn't care at all, because it uses cgroups to manage processes. I've
> > been using systemd-with-fexecve for two years and apart from strange 'ps'
> > listings, it's all fine. But we have administrators and scripts.
> > For example, 'pgrep systemd-udevd' and 'pkill -HUP httpd' and a
> > bazillion other calls that we cannot ever find or change.
> 
> Hmm.
> 
> Not even my system where I run apache has a file named httpd
> so I don't have enough context to understand that reference.

It's a long-standing Red Hat vs. Debian naming war. Some want
"apache httpd" to be called "apache" and others "httpd". In the
Fedora package, we have '/usr/sbin/httpd'.

Apache/httpd was (is?) deployed in a few major versions, so it was
common to have httpd-2.2 and httpd-2.4 installed, and in those
situations one would create a symlink to "decide" which version
is the main one. This is the situation I was alluding to.

Another common example that comes to mind is python: distros provide
/usr/bin/python, /usr/bin/python2, and /usr/bin/python3 as symlinks
to specific versions. On my Fedora system, 
python-unversioned-command.rpm provides the /usr/bin/python → python3
symlink, and python3.13.rpm provides /usr/bin/python3.13 binary
and a /usr/bin/python3 → python3.13 symlink. So this is
an example of a cross-package "alias" that pretty much must
be a symlink.

> >> To me using bprm->file->f_dentry still seems to make more sense than a
> >> field whose value (in the case of login shells) is documented as being
> >> different from what you are looking for.
> >> 
> >> There is no solution that doesn't have down sides.  As such the kernel
> >> might as well use a solution that is cheap and as close to how
> >> task->comm has been calculated historically as possible.
> >
> > Right. It comes down to judgement / guesswork about the downsides of
> > each approach.
> >
> > As I wrote before, the approach with bprm->file->f_dentry is _much_
> > better than what we have now. So I'll take that over status quo.
> 
> I really think that is where the kernel should start.
> It is cheap, and it solves the issue that task->comm was set to
> something meaningless from a process standpoint.

Ack.

> > But from the POV of a distro maintainer, it's not ideal. Basically,
> > with the patch that uses argv[0], I expect almost no user-visible
> > change, so I can rebuild systemd with -Dfexecve=true in Fedora and
> > maybe send a mail to fedora-devel with "hey, watch out, the way
> > systemd starts processes has been changed, selinux could be affected,
> > please report any errors".
> 
> Huh?  If selinux depending upon filenames?  I think if any security
> module is somehow depending upon task->comm it should be fixed.
> Just because task->comm very much is not built so that it can
> be depended on that way.

I never said anything about selinux depending on comm.
Selinux is primarily based on syscalls, so changing execve() to
execveat() _could_ require a change to some policies. (I'm not saying
that it must. I didn't explore the topic. Just that it's something
that'd need to be checked.)

> > I think fexecve is a nice feature (as all the fd-based syscalls
> > in general), but it need to be drop-in replacement if it's supposed
> > to be adopted quickly.
> 
> I don't know why you want to use fexecve.  Using an fd based system
> call will typically be slower.  Using fd-based system calls is generally
> what you want if there are extra checks you want to add before
> performing an action.  Opening and file and then calling exec is going
> to be necessarily slower than letting execve handle it all.  Not to
> mention the cost of the added checks.

That's exactly the reason. We do various checks on the binary before
calling it, for example SMACK context setup. Another example is that
we've been working on adding a .note.package section [1] that uniquely
identifies the provenience of ELF files. I plan to add a feature where
we read the ELF note and log the specific version of the program being
launched. It's more elegant to open a file and use the same fd to do
all the preparatory steps without a change of TOCTOU race, for example
if packages are being upgraded and the file might be replaced in the
background.

[1] https://systemd.io/ELF_PACKAGE_METADATA/

> Depending on the checks you want to perform in userspace to the
> executing of a binary it is possible to use a dirfd with execveat
> instead of the fd of the actual binary.  That allows you to have enough
> of the full pathname that task->comm will be set the same.

Yeah, that's not what we want. A package upgrade will use an
atomic rename to replace files within the directory.

Zbyszek

