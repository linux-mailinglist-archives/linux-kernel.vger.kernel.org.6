Return-Path: <linux-kernel+bounces-417335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE3C9D52C1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34CF1282068
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066DE1B5325;
	Thu, 21 Nov 2024 18:47:56 +0000 (UTC)
Received: from kawka3.in.waw.pl (kawka3.in.waw.pl [68.183.222.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBFC200A3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.183.222.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732214875; cv=none; b=pn4o4VZJU+KYi/mu0INJ3FTV79Hfda+S2tgLSePSf+rAlcFP9ktfuESUx5KQ7YP5sJYWWyLH3Vlv1QO90rj7pvKye+L0hB/tO8kyAUkqQ6GbHiCl+vqMo3TXgo/0edvTRN5SVPH1Yhbh7DZl4Av6CnNLo7MX6TJ+glwZCzwGy10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732214875; c=relaxed/simple;
	bh=StK1fRRg9mkVIYTAO9W1gWXDHbSBfvy3dC3+3gjAtxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuYQ98vAqsuhv1iPFre+2nKuUBaTa+RCycf8yw8At/OqfDk7vheIPbQSwIc2S96FPnAuirGe5zgadHeBq6nHiRaj5cgb/f/C6s/E67UyNLW2FyoZNlhHPRZxxZfGToZcT6fuiysJsW++00VoCIc7qANylNz7+ap3eIS6BWe2a5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=in.waw.pl; spf=pass smtp.mailfrom=in.waw.pl; arc=none smtp.client-ip=68.183.222.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=in.waw.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in.waw.pl
Received: by kawka3.in.waw.pl (Postfix, from userid 1000)
	id 6FB1B5A3A64; Thu, 21 Nov 2024 18:47:50 +0000 (UTC)
Date: Thu, 21 Nov 2024 18:47:50 +0000
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
Message-ID: <Zz-AVoa7Ra22LJ5L@kawka3.in.waw.pl>
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

You brought up argv to say that it's "garbage". I was replying to that
part of your message.

With execve, the initial values of comm and argv are under full
control of the caller, e.g. comm can be set as
'ln -s /bin/sleep /tmp/whatever && /tmp/whatever'.
So comm doesn't have to match the "actual executable name" and
if one is "garbage" then so is the other one.

I very much understand the difference between comm and argv[0].
Once again: the goal is to be able to use fexecve in a way that
doesn't cause a visible change to the called programs. Comm was
previously set to the basename of the path, and if it's set based on
argv[0] with fexecve, we get the behaviour that we want (*) and the
rest of userspace is happy. If we set it to f_path.dentry, userspace
is unhappy.

(*) The exception is when a program is called with an argv[0] that
has some special value. But it's such a niche case that nobody
cares about it. There were some cups printer plugins which passed
something important via argv[0], but that was at least a decade
ago. I'm not aware of anybody trying to do that. In the worst case,
we can fall back to execve for those cases if absolutely necessary.

> I'd suggest you just not use fexecve().

Pffff. That's not helpful. The patch to use fexecve/execveat
in systemd was merged in 2020, but we can't make this the default
behaviour because of the comm blocker.

Zbyszek


