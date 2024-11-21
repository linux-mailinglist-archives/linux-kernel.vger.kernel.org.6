Return-Path: <linux-kernel+bounces-417541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAF09D555E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BADF1F239E9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAF01D14E4;
	Thu, 21 Nov 2024 22:24:42 +0000 (UTC)
Received: from kawka3.in.waw.pl (kawka3.in.waw.pl [68.183.222.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECBC1D89FD
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.183.222.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732227882; cv=none; b=o6KsuOYvPsHbUAZo8IqGVTR5cfeGbqCDhINDuemYwkL3UYV+C5sm9FochSIsP07kWUHaA0POpzVGdQ5COSuZluRn3+lzFwbPCgLJvZlhs/m8dhMWngm+OIEViDEZbUTW3pc2F6qLQpQ2oXOuH0K5RXYHQ1wpw/tKHrT/16jy3a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732227882; c=relaxed/simple;
	bh=pLEKCJlW9evfOBzZED/OId9HyOO/uw60Fy4y0PHTyFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWtlsEmWtocz2NJVDralktxAneTl/prWktsejyeW78B4M7bvXPSyDQsOQNO9pgLWu1HvnXjqeZ/l70V4LF2GYJJTN56AGZZHO2PpFdCtcyW0kKrdp1kQ00Mau4YSin0EoiQOa471XIohcv8QDO3OikViK+sIll++/2nbOsAeNFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=in.waw.pl; spf=pass smtp.mailfrom=in.waw.pl; arc=none smtp.client-ip=68.183.222.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=in.waw.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in.waw.pl
Received: by kawka3.in.waw.pl (Postfix, from userid 1000)
	id D622A5A3D20; Thu, 21 Nov 2024 22:24:38 +0000 (UTC)
Date: Thu, 21 Nov 2024 22:24:38 +0000
From: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>,
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
Message-ID: <Zz-zJr4_qMED8ned@kawka3.in.waw.pl>
References: <87jzcxv227.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wifNC+AAGVDN-B1gGNhKGqhnkoqWKCknAo6107oD0zGWA@mail.gmail.com>
 <Zz9sTFBQQSe1P8AI@kawka3.in.waw.pl>
 <CAHk-=wiJZDxO+Wgmg8f=Cio9AgmJ85V7do4kxroKejHNsS80hQ@mail.gmail.com>
 <Zz91LyHzxxOLEma_@kawka3.in.waw.pl>
 <CAHk-=whv4q-RBXmc9G7NZ4GiATqE_ORU05f=9g00HkQXbV7vqw@mail.gmail.com>
 <202411211011.C2E3ABEAB@keescook>
 <CAHk-=wgfX4dvvKo8PrPZj76Z2ULMMK2RvaF+O7QhLnwOSBYdhQ@mail.gmail.com>
 <Zz-mmg9tEj7EbPlm@kawka3.in.waw.pl>
 <CAHk-=whF03ueoCM7M0vbcTy7fRvv+g9h_rnafurNJ1OEj71cEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whF03ueoCM7M0vbcTy7fRvv+g9h_rnafurNJ1OEj71cEA@mail.gmail.com>

On Thu, Nov 21, 2024 at 01:48:59PM -0800, Linus Torvalds wrote:
> On Thu, 21 Nov 2024 at 13:31, Zbigniew Jędrzejewski-Szmek
> <zbyszek@in.waw.pl> wrote:
> >
> > The point is that comm _is_ used in many places that matter. I'm not
> > sure what you're trying to say really, since in the second half of
> > your mail you actually showed an example where this is true.
> 
> Really, let me say this one more time: if you don't like the dentry
> name, don't give execveat() a bare file descriptor that has no other
> name, and claim that you want to use some completely unrelated third
> thing that has nothing to do with it except in your little
> dream-world.
> 
> The dentry name is not just fine, it's THE TRUTH. It's fundamentally
> what you are executing.

It may be THE TRUTH, but this is not what userspace expects.
A user calls e.g. /usr/bin/wget and they really expect 'pgrep wget'
to return a PID. They don't care that the dentry name is actually
'wget2', even if the exec is realized through fexecve.

> It's better than - and fundamentally different from - argv[0], which
> is something entirely different and is defined to be available
> elsewhere.

Kees explained this really well, please check his mail. Everybody
knows that argv[0] is (or rather can be) different.

What people expect is for /proc//comm to be the basename of the path
that was passed to execve(2). Give me an interface that allows the
caller to use fexecve() instead and set comm. I don't really care how
that interface looks, as long as it's possible to set comm to
mimick previous behaviour.

The patch uses argv[0] because in a great majority of cases in normal
use basename(argv[0]) is the same as comm. So it provides a good
fallback. _Better_ than the dentry name, as far as the userspace is
concerned.

> If you have done an open() that followed a symlink, the name *behind*
> the symlink is the *CORRECT* name. So when you then do an execveat(),
> it's literally the thing *behind* the symlink that you are executing.
> 
> You are trying to claim that people want argv[0]. No they don't. If
> they wanted argv[0], they'd use /proc/*/cmdline, which already give
> you that, and more.

That's not what I said. What was said is that argv[0] can be used
to set comm in a way that _the userspace expects_.

To be clear: the dentry name goes 95% of the way. It certainly
is better than the current "3" or whatever. If we cannot fix the
remaining 5%, we'll need to adjust some userspace and possibly
have some annoyed users. So I'd prefer that the kernel merges a
patch that uses the dentry name, but it'd be better to use
argv[0] which solves the problem 99+% of the way.

> And if they don't want argv[0], then they get the name that the
> executable was started with. Which is the name *behind* the symlink
> that was resolved by the (preceding) 'open()'.
> 
> I'm trying to explain to you that comm[] IS NOT, AND HAS NEVER BEEN,
> argv[0]. The two have *never* matched up and been the same thing. It's
> simply not how execve() works.

Yes, this is exactly what Kees wrote in his mail. Nobody is disputing
that.

> I don't even understand why you care about the symlink thing. You did
> an open, you followed the symlink, the file no longer points to the
> symlink, trying to claim that it does is simply not *true* in any
> shape or form.

I have a generic execution engine (systemd). Userspace uses it to call
arbitrary programs. That userspace expects that comm/pgrep/top/htop/etc/etc/etc
show the "name of the program". The _name by which it was called_.
For decades, this has been the symlink name, not target.

Zbyszek

