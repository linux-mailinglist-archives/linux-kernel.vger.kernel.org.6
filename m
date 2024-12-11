Return-Path: <linux-kernel+bounces-442063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8753B9ED77D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1CA283B7C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1582211A0B;
	Wed, 11 Dec 2024 20:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="mKagP3WL"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809CD1C5F3E
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 20:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950220; cv=none; b=KUj+R61jzlotQ61SfXg/6YTwazOx6NntoDBkIdHXiyAXZ9Cy2FHPzufrYwtq2GpwXrERo12HC8kxuGPJuYMZBkWcaa3f2nCLWQO0mMuyF6Buuv6SJzopusLCA7e10plneIa5nmT2sPfu+vdWzvhJtoX+47ZHUVJMtXH7ZH12aWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950220; c=relaxed/simple;
	bh=X8nvJTluo6uk2H7YxahoIaxyxmYHdFAYALCQzsrX9bw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QG+NuiZZWx8p+DcU6FqkzOV9Ac5+m9/Le+ICdRMFUgi+mXL7VzKWj/pe5BAD11ZeEbpwWuk3Ypr5vvURSkqh8XmHr+kxVlaYMbZPCxZUhwnaA87Pwuw2RdSIMlUPyab/fMULLSIN6r1fdAZKYrhTe3wxg65e2jYgUsViqRHL+sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=mKagP3WL; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1733950206; x=1734555006; i=spasswolf@web.de;
	bh=s6aRqvWR7cMPmGQkf3er6O+rOmb0o0ITThts5lu/wtY=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mKagP3WL0iFzz8je2AfNb0zHnclJ6JGkB4jAoYVgGNupd0qPklT3DvW8As03HxVV
	 wmePKKXVzxXbuhT1D+r534yXxQelbxYLqN9V8eiuk2MuKXhSRvyTpdu6i11XR5A/H
	 d1kDSN4SDKxHwqMR9kG2WefedFkPF1bo+QcphZ0lMyJxHTZKX6bM3GiLcpBNmwKRW
	 rfyNQbQQnX9rRKuVA1SiDnsgTI+oUB/TGxYxA2yzPW1x6+p22z76twjzRS1jHghNv
	 OcCoLgYJmsCl9QW8hCzpUQKdKOXpXgE5puTiUCvBWcA7icMb7J7RxCZxK9dJ4/Z2w
	 yHehcAjsLhMv3CB+/g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqZQY-1tysrX3J20-00l3b3; Wed, 11
 Dec 2024 21:43:59 +0100
Message-ID: <1d0d23600f87a95ce15998eaae8600ebe1d87ce6.camel@web.de>
Subject: Re: commit 894d1b3db41c leads to frequent hangs when booting
From: Bert Karwatzki <spasswolf@web.de>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Metin.Kaya@arm.com, boqun.feng@gmail.com, bsegall@google.com, 
	daniel.lezcano@linaro.org, dave@stgolabs.net, dietmar.eggemann@arm.com, 
	joelaf@google.com, juri.lelli@redhat.com, kernel-team@android.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, longman@redhat.com, 
	mgorman@suse.de, mingo@redhat.com, paulmck@kernel.org,
 peterz@infradead.org, 	qyousef@layalina.io, rostedt@goodmis.org,
 vincent.guittot@linaro.org, 	vschneid@redhat.com, will@kernel.org,
 xuewen.yan94@gmail.com, zezeozue@google.com, 	spasswolf@web.de
Date: Wed, 11 Dec 2024 21:43:57 +0100
In-Reply-To: <CANDhNCpUWk_7Ocp0fvvjsLgZavcxvFcr3ac6psaZOa0xySfxZw@mail.gmail.com>
References: <20241211182502.2915-1-spasswolf@web.de> <87wmg69gex.ffs@tglx>
	 <CANDhNCpUWk_7Ocp0fvvjsLgZavcxvFcr3ac6psaZOa0xySfxZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B+5xmvtyq5mLRUwWr7J2J4xdgbRxd1YBa4LmjRzFUJhwrnxkKOh
 4aJ3QpXDD8CqYJWnwLLCldmigp9NZBBZ5ESirGyFY+B9BqHF0BXmTyOHBX48thrYfawo0eY
 ygZQI1YQQDL7PdXBo/KvdutL0JHGMoaIYK2tFQgrT1FVoPiYILgxVQZCrIsveoiermlyNnx
 lJeuHJunGxlDh1MRfB+eA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:O5sJu2AVxzY=;4CINgXqDv7MEA7RCiFNThA1dYmj
 MLcDqpKmNl/OzqKPHCfMgpJvwcbyc8dNLABelMJH8+w5DHDZwgtlfHbZtNdTlfDOmzQ1BgHp3
 mvlVPUYzLWXX2Ulqy92p+2Wn2cUbNpSM4sr3vBoqqslJjhVkOfXCqCh1c4rt4obkAUHq/oP8S
 swJw3gCIVbEJ/EC6gnHXJOxvbj5oxqoP/fhr2cMYtddJAQkuHbw2E5/L64UbQGLcWEqzyVoWm
 StMD9wSH4RrDSoerQGbG5YXnH5TRbE17mZvSPhCvDkVmgJXyZlyVj0rVjkav5SCY7QPJhpB+h
 KgqgnlmfMVBvXaoleO3V6+svI4DA/3gCzddZX8cBqWUipRgP5nrMw9ZgQxN5nhuW4WSPpQ4z+
 8OuTnMtRpcJAQ/rleqGntpRBnsfvidyzGy0iBm24BxrTHpQ40/azs9H2q2rdy1Lva4sPEC6Ic
 0ESj+pnyc6PNx4Raw/EG1OXmoyjGohDqzUUNBp8szFdx4S6RpMyrfyLTFTejlp9qv9fwtKuLM
 DJPa0HenvU9L+s0wSeMMpwQ3rNwUCIuzh9NIonlF5kJ6I0wZFi1B1xYpco8YOPeLyOjL3GvZ/
 gVLcw+uDlqBSci6+ZhVuAlMidVWuTc5yo8JYCVTtajs/eDH2dxv2NzvkYzOoihEJHIc7oa1bX
 axErX5CkD0ZPU/u87TfA8XAJUyYV4bL3Wwkt6epkQG8vAfgP71kdfCjP1ofoFRzjigxUjvtOX
 jc4mYQn5SbGq43OTHxZ8MTak3hmUpPcl/1jE3Gn+o3TnvOTmB5xyinQ5NQaqBq61zEFWqT7Py
 DYctYyxNvxhWe+gUriPfNE4fZ1OjTjNH3gxkr6CeIJ3ZWmkhXh1zbt1LCIsVD/lApjymiHRbX
 I4VkSjgQQjrLXVttAJ+dAkRUyL3lAKALzuGSYP8fjcdYPP3qRbUa58C/x4HI846SoWtZdr3cc
 K+45H1vmM6E9XDH6Gb0v15LD2uzHj+nx/ITXRJ3wumhEObjfKpF6HxpojM/u9KouFeauWCX9v
 X3yn4Frg8QE+DhgIkps/eRQvbq22pY0xIjvM+HP55yC/vt53kisxuaDhs4cx+lgJGMGqylmPV
 b8CRzU1vMBYn9eZ00GiW5DsYmUyNl4

Am Mittwoch, dem 11.12.2024 um 12:27 -0800 schrieb John Stultz:
> On Wed, Dec 11, 2024 at 11:19=E2=80=AFAM Thomas Gleixner <tglx@linutroni=
x.de> wrote:
> >
> > On Wed, Dec 11 2024 at 19:25, Bert Karwatzki wrote:
> > > I tried to debug this with CONFIG_LOCKDEP=3Dy in v6.13-rc2, but usin=
g CONFIG_LOCKDEP=3Dy
> > > makes the hangs disappear or far less likely, and I get this warning
> > > (2 examples from two boots):
> > >
> > > [   17.203857] [   T1337] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
> >
> > config LOCKDEP_CHAINS_BITS
> >         int "Bitsize for MAX_LOCKDEP_CHAINS"
> >         depends on LOCKDEP && !LOCKDEP_SMALL
> >         range 10 21
> >         default 16
> >         help
> >           Try increasing this value if you hit "BUG: MAX_LOCKDEP_CHAIN=
S too low!" message.
> >
> > Can you increase the chain bits config and try again?
> >
>
> Thanks for the report and bisecting this down!
>
> Can you double check that the following commit is in your tree? I
> think it has landed just in the last few days upstream:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D82f9cc094975240885c93effbca7f4603f5de1bf
>
> thanks
> -john

v6.13-rc2 does not contain commit 82f9cc094975, but linux-next-20241210 do=
es
contain it and shows the same buggy behaviour as v6.13-rc2, I'm currently
testing if linux-next-20241010 can be fixed by the same revert as v6.12-rc=
2.
 I didn't bisect this in the linux-next tree to avoid an overlapping bug w=
hich
also caused a hang on boot (this has already been fixed):
https://lore.kernel.org/linux-mm/CAOQ4uxgVNGmLqURdO0wf3vo=3DK-a2C--ZLKFzXw=
-22PJdkBjEdA@mail.gmail.com/T/#t

Bert Karwatzki

