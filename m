Return-Path: <linux-kernel+bounces-442037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A469ED73B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A761881EDD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDEE20B203;
	Wed, 11 Dec 2024 20:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="FD+5Ymnc"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E001FF1DC
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733948920; cv=none; b=HUbtipaIDjStuQ5mjAtwfik0C5j8QufLL6HWr1Pbjk1eXGgC2HXR8XUOJ5vjZ/AoiR8PXaxbslVmWRdAM3ETww5Km9qjCdUetZiktJrhronTBJgBWs+arTN/fxkHpH1H4ZvsJ4ggrhQJhzgRgz0GK10YfGZHvarjsegaZ4iWY3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733948920; c=relaxed/simple;
	bh=0ZsVRTRAwJIdibmn5ncB/CclNKPdnZacsijR7dYwtVw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B/+zEzQbG8vYO5/JpF18RXK3kIFpIfCkYLX/EPBy2bnByVRPlsZLXBa+gAJtHs2CAZ8SVy2hkewnFp6L25mzPdayKYlpaUOBiHoxPnIhFYmNhk39UCnBDQtT5lFdrDc55xUwmLdSE12eB93NnNGOi4mzP4ydfQFqT43YL6eWqYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=FD+5Ymnc; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1733948885; x=1734553685; i=spasswolf@web.de;
	bh=NcorENASmQyETChbQhAibSp5kq6U6UahXBEhepnvLbw=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FD+5Ymncf3zAw4bKrIO/22etZ7xv68AGJIAfRh6Oeo0u5JFqVCb9BeEiblibcGzp
	 wlWyBSGhfsL06xXByI/ucK3YGEd1RlfIXkchzNj0uwADFrY/ua7cKkj9YCkKIHGmd
	 onPrUkC26Tb89vcvNC7TeqEFu1HeXydv6YTnYnsgpvfkOjP0DzpA3sIj5SrUilkGn
	 lTEVH7K2VV3hRotCbxyBcHMthWWYdPF5agcG7G80KejKSkVVP71efWaiFN614PSxa
	 t0zgs15YwYENmgMXO2aztjf45tKY9lNF0Sd6nhVmiw6kyYsc9NUjM14uavm+G8U8F
	 GYp1t6df8H3fnaw9uw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mho04-1tq7AC2jaq-00dNvI; Wed, 11
 Dec 2024 21:28:04 +0100
Message-ID: <de7b03dea71547f995b204ddfe7ceb35710ec951.camel@web.de>
Subject: Re: commit 894d1b3db41c leads to frequent hangs when booting
From: Bert Karwatzki <spasswolf@web.de>
To: Thomas Gleixner <tglx@linutronix.de>, jstultz@google.com
Cc: Metin.Kaya@arm.com, boqun.feng@gmail.com, bsegall@google.com, 
	daniel.lezcano@linaro.org, dave@stgolabs.net, dietmar.eggemann@arm.com, 
	joelaf@google.com, juri.lelli@redhat.com, kernel-team@android.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, longman@redhat.com, 
	mgorman@suse.de, mingo@redhat.com, paulmck@kernel.org,
 peterz@infradead.org, 	qyousef@layalina.io, rostedt@goodmis.org,
 vincent.guittot@linaro.org, 	vschneid@redhat.com, will@kernel.org,
 xuewen.yan94@gmail.com, zezeozue@google.com
Date: Wed, 11 Dec 2024 21:28:02 +0100
In-Reply-To: <87wmg69gex.ffs@tglx>
References: <20241211182502.2915-1-spasswolf@web.de> <87wmg69gex.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M4cj1px65LGZtjXCG96uhWVTvDevU9n7Vu2juz14xPGg5b+J4yD
 CFcRZxIHI41uTTCIt+ZZIqyGbkaMBksEXPeqZuoRa5jF0VWRJwK8KTpGwggiU02rMWfCuIi
 cOfINEEhlMuAR1r+TaJN/nIEBvwRQFHzQOpnX6vYYDAiT4XdqkYzdSCmDMrSLVuaSPDufgE
 2eOv3Kxf26EgISWUVYqng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ExQNV2+LPNQ=;OWHQS2XmWMg1iW13KO1k2hRpbSE
 aO0bvw8p+vrwns1RZx0B+Y0pIshqEfoFyaKTsrxY68pZRO71WQO3YNIBBRT2UrhVgdOytF7K+
 R+8Axlj7HUpI7CONderMb8Fs2W5Vfbo9TxbJNq9fbuosbSXZXWvQHvBUdigl5Tq1igpHQz8TQ
 2SmomPRFSkTQ+wWqD2nsooKA/+xtSoaNuQNewFpMsz606yaV+UP5wNvdzhfQkZXP4nJGqKUZ9
 4EX2tzwz9anBzkdVG+wYjYZVqOs9Bioql4ZzPBLUtzM3wH8y4OQ9WdWgszpiN5qbGVCs8nE7c
 LGcJYUhJ4Y0KWvguvjfkNgABuAWt22crXmgcdx2p+wDUHxfF87wh+W2Tu+b6UolY1QZaSQMNJ
 YQsCveXO/VHRtXZUmyv0F/acEXKpXyNnKnyK+NCZhLExmnxi3Z3UY3inajMOHu0cByKqsXmr4
 mx0KvApYgz9KWkMJWU7nkXp2ckllaF9jMYgXKoz5V2n+yixxK7FQciTPq1BY82pjqp/g1QxAC
 512SfEceZO5dL2j2hLnrJBekBHrLdz+BRn1eNhhZrTFXGJZhGC//BaVX5lO/H2Hm4gdUWIBdB
 ISpvdiLv5xqZvifwXWCyt7+9k90U6yVsuLTyU2uFgCxgMdzvdnwlrpPze8U3tyQmZdH/F+cvd
 E6oTPfAPVxebsrSymGdGSLGVI8K3YHH4oYgp8/jsqQRz80g5acouAVswSbXmMbV9R2WB84+Ji
 JcDz17ZqezAiJCxvpw9pups0SMdlQZ9hcpJ24hhh3ePeCDOS0B8EC1P74wPziYWuOhwEFeG4H
 V5NYHxaCHGE5rd3u9sOvfsnSch+B6duRs0V/x39ecB9rc6JhzdMCTtWaYM5WNK1N3mm+gDNO9
 KRpLAnHxJJzD0Nmx9auBUEI1aGYdN7KTJOKw6YTRrytMRedWqgJ1X2xvAUDibu+qqmc+aboJO
 dbcMU4jp5LsA7Otu2cswi1dmkfI2JgkeFh7YScLmxT1XyqZYphADJPxFIaI6g3tXtKIk7nBkc
 7ynFnl6qKlnmxOsqBht3VglR2pna1X9IHujI4fyVRSq6Zmpnj2cA0Hpc5dUyhj+OnRF74dwDs
 RYPnyuHZc=

Am Mittwoch, dem 11.12.2024 um 20:19 +0100 schrieb Thomas Gleixner:
> On Wed, Dec 11 2024 at 19:25, Bert Karwatzki wrote:
> > I tried to debug this with CONFIG_LOCKDEP=3Dy in v6.13-rc2, but using =
CONFIG_LOCKDEP=3Dy
> > makes the hangs disappear or far less likely, and I get this warning
> > (2 examples from two boots):
> >
> > [   17.203857] [   T1337] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
>
> config LOCKDEP_CHAINS_BITS
>         int "Bitsize for MAX_LOCKDEP_CHAINS"
>         depends on LOCKDEP && !LOCKDEP_SMALL
>         range 10 21
>         default 16
>         help
>           Try increasing this value if you hit "BUG: MAX_LOCKDEP_CHAINS =
too low!" message.
>
> Can you increase the chain bits config and try again?
>
> Thanks,
>
>         tglx

With LOCKDEP_CHAINS_BITS=3D21 I just get and boot with no hang and no erro=
r
message from lockdep, CONFIG_LOCKDEP=3Dy yes seems to make the bug go away=
.

Bert Karwatzki

