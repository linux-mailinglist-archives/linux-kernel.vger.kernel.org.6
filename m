Return-Path: <linux-kernel+bounces-417495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6E99D54BA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77FD9282C45
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298201D9350;
	Thu, 21 Nov 2024 21:31:11 +0000 (UTC)
Received: from kawka3.in.waw.pl (kawka3.in.waw.pl [68.183.222.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE99A1D89FE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 21:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.183.222.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732224670; cv=none; b=BUErRejTjdVxGRBtLgDmWnrJpKZwd+U48s8NNhUD1Dj7e5pvRrwZZaUgDDFT1/8VURAYUc5/DHjuzQdXLcUifDAtRg/icv+jyV1wm0egnEO4aykGhmKfNTgdW/8+w2HFcdf6B5drB4Edn4SSNWmno/IgfeaSR2JfRarSZcYi0wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732224670; c=relaxed/simple;
	bh=xStHEIS7G2wdO39+85O/1Mxu/q2ZdyHl+eelhE71Bu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KH12K5sA1v5Xz45eTK5hN+oYkN77IeKk302IpZi9+72rvRLk9V0cU1Vv5kvWz90lTfD15KdHyyoPVoTgvmkIttG3FlQYiANnY06cYd/I5eSnuL9DzFOThj6vRpn9+uFDfn8Sd17PwqoR+Sim8W7gmw8KM50ZtzuMClm4Aun31dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=in.waw.pl; spf=pass smtp.mailfrom=in.waw.pl; arc=none smtp.client-ip=68.183.222.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=in.waw.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in.waw.pl
Received: by kawka3.in.waw.pl (Postfix, from userid 1000)
	id 9C4BC5A3C9B; Thu, 21 Nov 2024 21:31:06 +0000 (UTC)
Date: Thu, 21 Nov 2024 21:31:06 +0000
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
Message-ID: <Zz-mmg9tEj7EbPlm@kawka3.in.waw.pl>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgfX4dvvKo8PrPZj76Z2ULMMK2RvaF+O7QhLnwOSBYdhQ@mail.gmail.com>

On Thu, Nov 21, 2024 at 11:23:46AM -0800, Linus Torvalds wrote:
> On Thu, 21 Nov 2024 at 10:50, Kees Cook <kees@kernel.org> wrote:
> >
> > The only flip side I can see is that "ps" etc, should just never use comm
> > at all, and instead use argv[0] from cmdline
> 
> Gods people, what are you all on about?
> 
> THIS IS WHAT PS ALREADY DOES.

Nope. 'ps' uses comm, for example in 'ps -C' which is documented as
"select by command name" and quite commonly used.

It does not use it in the default listing, because it shows "COMMAND",
incl. args, which obviously must use /proc//cmdline. But nobody said
that it does. Kees only mentioned that "ps uses comm for the short
name view of a process", which is true. _You_ wrote about ps and showed
an example with COMMAND which is … fine, but not really relevant.

If you wanted, you could ask where is comm used by the userspace?
The ones I'm aware of where it's directly visible:
- 'ps -C' or 'ps -o comm'
- pgrep
- top
- htop

Using sourcegraph.com I see mentions in moby, kubernetes, zsh and
ohmyzsh, earlyoom, vmtop, and pages of more obscure stuff. It's also
exposed via libsystemd's sd_bus_creds and journald's _COMM field.
The generic interfaces are the biggest problem. We could probably
update top/htop/pgrep to use argv[0], but we can't fix scripts
that are out there that either use 'ps -o comm' or look in /proc//comm
directly or filter journalctl output by field.

> Stop this completely inane discussion. It's literally like you don't
> even know what you are talking about.
>
> For user space, comm[] is basically the fallback for when cmdline
> fails for some reason (for example, /proc/*/cmdline will be empty for
> kworkers, but there are other situations too)

As mentioned, this is easily disproved by running e.g. top/htop/pgrep.

> The reason? comm[] has *always* been much too limited for 'ps' output. ALWAYS.
> 
> Yes, you can literally *force* ps to not do that (eg "ps -eo comm")
> but if you do that, you get the very limited comm[] output that nobody
> has ever wanted ps to give exactly because it's so limited.
> 
> People who want 'argv[0]' will typically want argv[1] etc too, because
> argv[0] simply IS NOT SPECIAL.
> 
> And yes, 'top' will give comm[] output because it's so much faster.

Exactly.

> I'm done with this discussion that apparently was brought on by people
> not knowing what the hell they were doing.

You keep disagreeing with things that nobody has said.

The point is that comm _is_ used in many places that matter. I'm not
sure what you're trying to say really, since in the second half of
your mail you actually showed an example where this is true.

Zbyszek

