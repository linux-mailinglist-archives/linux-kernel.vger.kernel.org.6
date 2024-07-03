Return-Path: <linux-kernel+bounces-239408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1533C925F58
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387C81C2246E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54783172777;
	Wed,  3 Jul 2024 11:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="mQLb73QS"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AB3944D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720007865; cv=none; b=imrHK6k7pdye91aHBCy2rl8VGXHb2MTk0q08wz1SQEldh6nf9jTH57V9h5ieD34O9F1Utpv35NFfC9r8g2wki8wtI9e33BvhakY4SMTxVY0MgD5g+JhDWMiWR2kfGu2NyRkBfFd+5Ky/7stPQjNH1e7R2UNKENzQQd8GwjKacSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720007865; c=relaxed/simple;
	bh=rKV38DTKe44owKlSJKgilDF63JZgHdfEW79Spi8tgRE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X8UYk21Hmg1BTIP2atti38B6LH+5HZ5JpSJ82r98BF7ijSGumC+6ZBgSoJXjD/DLPOmmfv/kiPkUSiE0PX3FowuChKWWzQ4czwP+Pr57m/rpnN7G/nMpD4S8IHsmwCTNNYDIECuGqkrKGBgyPokc0WGoxXT4Q3dTFljfsGvbdB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=mQLb73QS; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1720007841; x=1720612641; i=efault@gmx.de;
	bh=SQRSK4a08DTy1RMTibP027PFWUlxi+GRikrcCxsT88w=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mQLb73QS928NmijNLr/rwtHD5r+z4Mqdv/cVS8qfsUOYgRAYzM+S8TgXxfInKAlu
	 3wHVn2uJcMDYqmVI4b0MyUIkyDX23JZmTqQpIgA3b7warVohsSk0OaJIs9QgavT6G
	 UoDRN2/KNePCGAHlu49HE6HFLSZfwyUxIqH0tkX+zMO43KMwmW2Yz9ufzGKr0SyEv
	 0buidByWo4t8OkMR47QIXWGhDsLk9fm5Fkg0ccM8iK+Ue/0bY+4xVh2PtMlf8zPDl
	 bBjEvnqeLpXyLYRFMOy9fTyAe27a4LF3bJFJyCEqsM8QW5VI0Zs+PP2sdYPuzFpRd
	 FIddCxhOd6pTveh5Lg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.49.228]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mirng-1rtC6P2zmG-00klSH; Wed, 03
 Jul 2024 13:57:21 +0200
Message-ID: <4e28fd17d7a2f7146aae10a76982f0e58b22befb.camel@gmx.de>
Subject: Re: [PATCH 1/2] sched/fair: Record the average duration of a task
From: Mike Galbraith <efault@gmx.de>
To: Raghavendra K T <raghavendra.kt@amd.com>, Chen Yu <yu.c.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Tim Chen <tim.c.chen@intel.com>, Yujie Liu
 <yujie.liu@intel.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Gautham R
 . Shenoy" <gautham.shenoy@amd.com>,  Chen Yu <yu.chen.surf@gmail.com>,
 linux-kernel@vger.kernel.org
Date: Wed, 03 Jul 2024 13:57:19 +0200
In-Reply-To: <683663e3-cef0-bb45-e1c7-5bf1cf44209c@amd.com>
References: <cover.1719295669.git.yu.c.chen@intel.com>
	 <338ec61022d4b5242e4af6d156beac53f20eacf2.1719295669.git.yu.c.chen@intel.com>
	 <d922f7bf3965f4eaef5028177b886e2e1861742d.camel@gmx.de>
	 <ZoFY/n2S7rMp6ypn@chenyu5-mobl2>
	 <db81ba7fba622e2a1b7186e66471cfb9ad8490fd.camel@gmx.de>
	 <ZoLDxQlTR7fxoXWs@chenyu5-mobl2>
	 <683663e3-cef0-bb45-e1c7-5bf1cf44209c@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CtQ/l1TksDKUoYM5X2hpLTu42SJe7Sq/7yDsfwUmYIHnqAX1KUb
 8TKr10nZriZbVaRYan5sgzkLzqqErNfQ3jdKM3V0oJf3SeFt4KGAJO3RcKYpxjMVj//mb0i
 mWaVQ0hg99tzbmJwUiyUqAwuCQtefjxl0deaM7IliipxQEYeHRg0PBCKd+eK2okzxzcXcuy
 glRB2jAea6NzAGqsdcC2Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:v/67zEkirsc=;HpScUQuYcf5o+tBNG1kYwgUICng
 DOm1rpKZcAG8UTlnIpXJkRcfyz5p+fE2Z9OUUDjVfIPs1aNydAI9t3qX4KvP5G9AOnpThSv87
 iLsb12tKy9Y1fx1sP7bceUfNWwIboDIZbqGxKZKUNQutZ61UMU1oq+cV/M7V8NhZKZ03RLNHG
 8mE4+gruBLHg2iDq13VhYHXPieXAsEozCLg2onSiJizEg32uVmoBcA8aOdo/baMnUaKTtAF7R
 LOROvcJ7uoUR7aCRScMpgVaS9GO+ImjzD2tOhumdwcachncxBPDXppRFAwrEZKjR4ZwBLy798
 wsLQziDmai5fcoNcAA11/9+NrEOrEK40pvT4yR0XgiohmiLUh2SK5YLZAMK2/P1TFS6khVaTy
 k6OTu9AYxUqjcWUcx+JNOUX2ItxBDLa5YlFUecYajuMZgZvL6L2mZr/dui2GyoQ1z5AD07iRk
 E0SYS1lV0oQJr2K2LZZkLyB4dNtw+U9w/4YqxFNclgoVd2AqG4Dh2f3y1SdRpn3PMG5/voEGN
 Y65Km7yhXRim3TEIzqWMK0aH+UHaFBVPi0KRphxWzjhtAr8OYg8JeNL/Vd/wRp7rtGjyxr/aX
 /cWOc/hwFQ9CE09Su4NWr2X3Ju+qKTmtDCt7i9r/QAXU34qrqnvFIgONkcbtaWCHFy8Ky3bYQ
 hzgYeTIGrDTwZEwLS+I6YB9w6FvEogSsb+3WED8grS4naMg3b42fWISzSwCdOCYwSXzpw1Y7l
 klU8UbgVrIizfR5kEvuj+0plTuLnNjLONIDjPnwtZkhMK+a4fyxQgj4Ve+34FpgJWs0Bt2mSS
 FptoRFwk+JCzluFoEZpUm/oxRPu38n3mfQF/lrHSoVCkg=

On Wed, 2024-07-03 at 14:04 +0530, Raghavendra K T wrote:
>
>
> On 7/1/2024 8:27 PM, Chen Yu wrote:
> >
> > A thought occurred to me that one possible method to determine if the =
waker
> > and wakee share data could be to leverage the NUMA balance's numa_grou=
p data structure.
> > As numa balance periodically scans the task's VMA space and groups tas=
ks accessing
> > the same physical page into one numa_group, we can infer that if the w=
aker and wakee
> > are within the same numa_group, they are likely to share data, and it =
might be
> > appropriate to place the wakee on top of the waker.
> >
> > CC Raghavendra here in case he has any insights.
> >
>
> Agree with your thought here,
>
> So I imagine two possible things to explore here.
>
> 1) Use task1, task2 numa_group and check if they belong to same
> numa_group, also check if there is a possibility of M:N relationship
> by checking if t1/t2->numa_group->nr_tasks > 1 etc
>
> 2) Given a VMA we can use vma_numab_state pids_active[] if task1, task2
> (threads) possibly interested in same VMA.
> Latter one looks to be practically difficult because we don't want to
> sweep across VMAs perhaps..

Oooh dear.. as soon as you mention threads, the question of who's
wheelhouse is this in springs to mind, ie should the kernel be
overriding userspace by targeting bits of threaded programs for forced
serialization?

Bah, think I'll just bugger off and let you guys have a go at making
this stacking business do less harm than good.

	-Mike

