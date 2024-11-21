Return-Path: <linux-kernel+bounces-417338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A64E19D52C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D641F22516
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FF51C304F;
	Thu, 21 Nov 2024 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQBgzsXg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D40139597
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215024; cv=none; b=VGQECKS9jHKb51FIAhKM2YIxvhimtN+cLDsLE+XMPsJmFzi/vZUV6KwxTQpHoIuOXeW2q65O8xeW3hPxH1rdZvEOQ4UOCURgUhPtt8AdLFeXmmG/J7dmrPiL4gndY8+oSZBETJS/qfnuHDj4OCgSUNRRVezo+84yORmPHcq3uDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215024; c=relaxed/simple;
	bh=akCGe1zsFy6AECQ/VowNbM8JTVrfoNhO+i/XqA1MTk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDB0hL7F5CXEGD7CAu8Pv70dz0OyCUblatR19HV5CROuty3mQIw/TMkzBLV11nBaFoeld41hgipRticvoe+u86lZY3wBiiO7QEYxwQ2SSFylcsZNdwmZh/wCg1X3RAGN9ROQLdJxXaHanR0UBFhC8j58BDUvsgT8vHvxI6y5vpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQBgzsXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4F2C4CECC;
	Thu, 21 Nov 2024 18:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732215024;
	bh=akCGe1zsFy6AECQ/VowNbM8JTVrfoNhO+i/XqA1MTk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pQBgzsXgZ6gkvc+swEC1p6a+IXps8UPC8xAjCQqCB3a52VeaZkkaHl2S8v2xcYiyB
	 SyHxRpH/18VVApeLqVkhAe2A2BrWcP3OWxmuOPML+oSvgRPy28TqWJBTCg5ewEae4F
	 H7ZvEIbI7t+rMPDYMPsuYbM15y5AnwO4QRWh5EVb2DfJHhsgj78NEnaT0iHbneesAA
	 C1HJGdwRV/7F8NIQRoCHSwmHeWWL6/7pUZTRN0AiZFMoB4DVB9S2HPKMXmyfrAUn50
	 cDU7ZAfabJCWtMsW8sZoCdfRIwkkyuW2vbpDDy3zpZWyB7y5AhJp6iYcJjdqmnqocf
	 GBwgliG5M08+w==
Date: Thu, 21 Nov 2024 10:50:20 -0800
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
Message-ID: <202411211011.C2E3ABEAB@keescook>
References: <202411190900.FE40FA5@keescook>
 <CAHk-=wgB1L75+C89AU62n4jBEiwKs=e4dvBDOoLQ13rUwJLFXQ@mail.gmail.com>
 <87jzcxv227.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wifNC+AAGVDN-B1gGNhKGqhnkoqWKCknAo6107oD0zGWA@mail.gmail.com>
 <Zz9sTFBQQSe1P8AI@kawka3.in.waw.pl>
 <CAHk-=wiJZDxO+Wgmg8f=Cio9AgmJ85V7do4kxroKejHNsS80hQ@mail.gmail.com>
 <Zz91LyHzxxOLEma_@kawka3.in.waw.pl>
 <CAHk-=whv4q-RBXmc9G7NZ4GiATqE_ORU05f=9g00HkQXbV7vqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whv4q-RBXmc9G7NZ4GiATqE_ORU05f=9g00HkQXbV7vqw@mail.gmail.com>

On Thu, Nov 21, 2024 at 10:02:03AM -0800, Linus Torvalds wrote:
> On Thu, 21 Nov 2024 at 10:00, Zbigniew Jędrzejewski-Szmek
> <zbyszek@in.waw.pl> wrote:
> >
> > Identical — as far as the callee is concerned.
> > Basically, we'd like to switch the execve() that we use in systemd
> > to start everything with fexecve(), but this should be invisible to
> > both the programs that are started and users who call ps/pgrep/….
> 
> I'm not discussing this. If you cannot understand the difference
> between comm[] and argv[0], this discussion is entirely pointless.
> 
> I'd suggest you just not use fexecve().

I think you're talking past each other. Here's my thought process:

To Linus's point, comm[] is "garbage" in that a process can change it to
anything it wants (i.e. PR_SET_NAME). I think everyone understands this,
but that's not what what I see as the issue.

What commp[] does have, however, is a "default" (starting) value set by
execve(), which is that of the basename of the "pathname" argument of
the syscall (yes, not argv[0], but see below).

Most process list analysis tools (i.e. "ps") use /proc/*/comm for the
short name view of a process. Most process launchers (i.e. shells,
systemd), tend to use basename(pathname) as argv[0] when running
programs. Again, I think everyone understands these things too, but I
think it's worth calling out that while comm[] and argv[0] are obviously
different things, in most cases they start out with identical values
after execve().

The problem is fexecve(), where the pathname is lost since it was,
obviously, only passed to open(). Right now, we re-use bprm->fdpath since
it was already there for scripts, but that unhelpfully just shoves the
fd number into comm[], making "ps" output unreadable. Nobody likes
seeing basename(fdpath) in comm[] today.

I don't think it's unreasonable to want to retain the basename(pathname)
starting value of comm[] when switching from execve() to fexecve().

Using the f_path name is certainly better than basename(fdpath), but it
doesn't really give userspace what they'd like nor expect. Since comm[]
is mutable anyway, why not just copy argv[0] for this case, as that
would give userspace exactly what it was expecting and does no harm?
i.e. yes, comm[] is "garbage", but let's replicate in fexecve() as close
to the default behavior we have from execve() as we can. Why expose
f_path, which doesn't appear in comm[] nor cmdline currently?

The only flip side I can see is that "ps" etc, should just never use comm
at all, and instead use argv[0] from cmdline. That would get the same
behavior as described here, but it is much more expensive in that is takes
the mm lock and has to walk userspace memory. But then we don't need
to change anything on the kernel side and just leave basename(fdpath)
alone. I would note, of course, that cmdline can also be changed by the
process (PR_SET_MM_ARG_START), too, so it is also "garbage". Just more
expensive garbage than comm[].

I still think the original proposal is the most helpful to userspace.

-Kees

-- 
Kees Cook

