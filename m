Return-Path: <linux-kernel+bounces-417302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056359D5238
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78053B25A7E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A38A1BDAA5;
	Thu, 21 Nov 2024 18:00:20 +0000 (UTC)
Received: from kawka3.in.waw.pl (kawka3.in.waw.pl [68.183.222.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F261BC9ED
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.183.222.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732212019; cv=none; b=ktu99q+YVZ+O5m4ivASz2KT/UPEtij/08yAQL/dzLAYn+8dblhi2HB+BiCExYOGZ9c6fCHfdpM/VEKzP8iGi/HEBoNEXOV2UHncVSDM4IATa3WuSbwvvhdgwFIKLV7GYp2Hxdgi0h2n/RBfCAwRGaPdrEFdY1BCM1cl/R7I/V78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732212019; c=relaxed/simple;
	bh=OknCLb0NUSx8T5vgw3iBhAt0qP+8nRZAKtKKWDq5Vnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asbXZ7w2F+gAqDXjmICE4tdA8EH+Ultriy1aDMb+pStZEPZpmMJfGrnznBGOWHgmU59qXVkTnwsJihEsrEvssZeAwkFE3ykk9q3tT06UEGCuOfxK+SjDbPclEtC10ol/mtttyGUsY0v7BGtf2Rl6NxVneqLMTLgl9TafeC+2Qz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=in.waw.pl; spf=pass smtp.mailfrom=in.waw.pl; arc=none smtp.client-ip=68.183.222.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=in.waw.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in.waw.pl
Received: by kawka3.in.waw.pl (Postfix, from userid 1000)
	id EF5075A39D2; Thu, 21 Nov 2024 18:00:15 +0000 (UTC)
Date: Thu, 21 Nov 2024 18:00:15 +0000
From: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Nir Lichtman <nir@lichtman.org>,
	syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com,
	Tycho Andersen <tandersen@netflix.com>,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1
Message-ID: <Zz91LyHzxxOLEma_@kawka3.in.waw.pl>
References: <202411190900.FE40FA5@keescook>
 <CAHk-=wgB1L75+C89AU62n4jBEiwKs=e4dvBDOoLQ13rUwJLFXQ@mail.gmail.com>
 <87jzcxv227.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wifNC+AAGVDN-B1gGNhKGqhnkoqWKCknAo6107oD0zGWA@mail.gmail.com>
 <Zz9sTFBQQSe1P8AI@kawka3.in.waw.pl>
 <CAHk-=wiJZDxO+Wgmg8f=Cio9AgmJ85V7do4kxroKejHNsS80hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiJZDxO+Wgmg8f=Cio9AgmJ85V7do4kxroKejHNsS80hQ@mail.gmail.com>

On Thu, Nov 21, 2024 at 09:28:09AM -0800, Linus Torvalds wrote:
> On Thu, 21 Nov 2024 at 09:22, Zbigniew Jędrzejewski-Szmek
> <zbyszek@in.waw.pl> wrote:
> >
> > It'll "break userspace" in the sense the the resulting program name
> > visible in /proc/self/{comm,stat,status} would be different than the
> > expected value. Currently userspace is not using fexecve because this
> > string is "just garbage". We'd very much like to start using fexecve,
> > but we cannot do this (in the general case) if that'll result in a
> > changed program name. If we change the value from the current
> > (garbage) value to something that doesn't provide identical behaviour
> > between execve and fexecve, fexecve will unused.
> 
> Well, then you had better not use fexecve(), because that "identical
> behavior" is fundamentally impossible.

Identical — as far as the callee is concerned.
Basically, we'd like to switch the execve() that we use in systemd
to start everything with fexecve(), but this should be invisible to
both the programs that are started and users who call ps/pgrep/….

> The thing is, "argv[0]" can - and will be - complete garbage. Yes,
> it's *often* the same as the filename, but there is actually zero
> guarantee of that. It can be any random thing - it's literally just a
> user space argument.

Eh, no. I think you're trying to say that argv[0] is user-controlled.
Sure, this is a feature. Systemd even exposes this as
  ExecStart=@program argv0 argv1 argv2…
It can be overridden, but it's not "garbage".

> And the dentry name *will* be the name of the underlying executable.
> Again, it is *often* the same as the filename, but symlinks have
> already been brought up as an example when it isn't.
Exactly. This is the crux of the problem. We think that fd-based
syscalls are great, and would like to use fexecve as a drop-in
replacement, but currently can't. I would love to tell the rest
of the userspace to stop ever looking at COMM, but, as you very
well know, once an API is made public and widely used, it's very
hard to redefine it.

> See? There is no single solution, but at least the dentry name is a
> *reliable* thing, not a random garbage thing passed in by user space.

Reliable – yes. Useful – no.

Zbyszek

