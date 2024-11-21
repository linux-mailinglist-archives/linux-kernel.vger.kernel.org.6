Return-Path: <linux-kernel+bounces-417263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B92A9D51B5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1A96B21CFC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE911A0704;
	Thu, 21 Nov 2024 17:27:57 +0000 (UTC)
Received: from kawka3.in.waw.pl (kawka3.in.waw.pl [68.183.222.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68B010A3E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.183.222.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732210076; cv=none; b=Q3bxnj+4wKj+w14nOHxM4bsd7+/J19l/k3cCK1Xspln6jGn4OIqldHDREZrNfxDxI45gLwgxRk6hszQGnrPQOIN28d8Cd1AYF4/o3sXTbiYu+vL2v4s7WvdFE2KkI8wkHQ6B5aHHMALmjANnWXMi58/lMiqcYvdgrh3mfb5zTqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732210076; c=relaxed/simple;
	bh=coLAmp4PA2TmGaKqMW8KKOMgz9UkZTFIV0rBEtNmMkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEX71uz4zzzL3LrDOq4uKZYmQxvFItwfqauGwDXdAcrKSo3Loepv3UQKhys/Ixf0C6xLmilZWBuXVoiV1h2YVoL1hN0kfffFdthMmCMUWVSx9CpTdemMAwMZwEdyeKjCtD8G8VZ7lm58lQElDoWw+7v9GqsM6k4A2cIXbXsFVAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=in.waw.pl; spf=pass smtp.mailfrom=in.waw.pl; arc=none smtp.client-ip=68.183.222.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=in.waw.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in.waw.pl
Received: by kawka3.in.waw.pl (Postfix, from userid 1000)
	id DD8375A38F9; Thu, 21 Nov 2024 17:22:20 +0000 (UTC)
Date: Thu, 21 Nov 2024 17:22:20 +0000
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
Message-ID: <Zz9sTFBQQSe1P8AI@kawka3.in.waw.pl>
References: <202411190900.FE40FA5@keescook>
 <CAHk-=wgB1L75+C89AU62n4jBEiwKs=e4dvBDOoLQ13rUwJLFXQ@mail.gmail.com>
 <87jzcxv227.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wifNC+AAGVDN-B1gGNhKGqhnkoqWKCknAo6107oD0zGWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wifNC+AAGVDN-B1gGNhKGqhnkoqWKCknAo6107oD0zGWA@mail.gmail.com>

On Wed, Nov 20, 2024 at 06:23:55PM -0800, Linus Torvalds wrote:
> On Wed, 20 Nov 2024 at 16:55, Eric W. Biederman <ebiederm@xmission.com> wrote:
> >
> > __set_task_comm cannot be called with bprm->file->f_dentry
> > unconditionally.
> 
> No, no. Only for the "no path" case.
> 
> > The reason bprm->file->f_dentry.dentry was abandoned were concerns
> > about breaking userspace.
> 
> There's no way it can break user space considering that right now
> comm[] ends up being just garbage.

It'll "break userspace" in the sense the the resulting program name
visible in /proc/self/{comm,stat,status} would be different than the
expected value. Currently userspace is not using fexecve because this
string is "just garbage". We'd very much like to start using fexecve,
but we cannot do this (in the general case) if that'll result in a
changed program name. If we change the value from the current
(garbage) value to something that doesn't provide identical behaviour
between execve and fexecve, fexecve will unused.

As Eric wrote, there are various programs which are symlinked.
/etc/alternatives is one group, but we also have "multicall binaries"
which present different behaviour depending on the name.
Some of those use argv[0], but other may use comm.
We really need the name that the user called the program as,
not the name after symlink chasing.

Even if we end up copying a string from userspace unnecessarilly,
does this matter? execve is a heavyweight operation and copying a
a dozen bytes extra hardly matters.

Zbyszek

