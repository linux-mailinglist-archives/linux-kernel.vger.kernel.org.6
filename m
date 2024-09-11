Return-Path: <linux-kernel+bounces-324577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64350974E7C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5A83B2490D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C11F181310;
	Wed, 11 Sep 2024 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="XuBPzTLA"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C27617838C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726046888; cv=none; b=dyHPpdwKCWv9okUsHiNxN9Qh5yr9F7GUPGWbY2U3GDBaH5jMJJT8vpAHCaeYM9tR6iHPN0N5HTi/CpofYl8tcN3WzZunLcGNiZo7pO5VFWP59s3UxYpzYBXfTV3KTtmXocLeQlSDvAuIjgxKmgNMfKJa9I8J5Zz0/HwMFelMoCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726046888; c=relaxed/simple;
	bh=usq5gC7KRrekM/t/ciRgPeCKfsb7C5xbGO8CmN8kXTQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nFAMyBB1DZHkD5L/0pbMlKfwX29jALEAYJdn5MVnN+boSl0jTXhVJK2CBd6s9vO3x0Js670tdPldJvQ4bIoYDIaIAd15M5shxC+aJEluDqaCIXb1242kw/XJdPMjclefGPw4F6tV9DTS9yhA4e71P1woxJ7pHRMHUx0nctvydfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=XuBPzTLA; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726046843; x=1726651643; i=efault@gmx.de;
	bh=jJ6ZmF7GHjcZQwhP8KGndsydcfEtcrgKKwbv2CudMc8=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XuBPzTLAYkNWo3D8p6psFZmNkcdTgX4nNynruJ4w9P00kM+O49lUQg46Pjtz9Gqf
	 MhIT7yzqC/kXItAeSm+jIlwJhz08eev6c6ex2DeIm+tAbcw7aY+ifyXFheJFbpfs2
	 yrs8n3hX9SYh9JDa9Q8ngNL/NapAPf+zVJK5qcSRCuXsm2Z+UKbRROmMES3Nsqblo
	 niDN4lAqX7TIXEkBahepR4ps2gcABpTf1r1WPMyLA4tweJe6lWenexVQ9lub97Pa1
	 7aTuUQyMm8mrrwAh5y8Z4cCW4EuTPkBq7nh7ndgETEsBsnkFd8ieGm42NyvxhJM4A
	 6cYSK2ZNmPuC3LG+hQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.25]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7K3i-1sw2rP1zXo-00EfbW; Wed, 11
 Sep 2024 11:27:23 +0200
Message-ID: <2030b198180259eede6384cc6a6bc9bc9f64f874.camel@gmx.de>
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
From: Mike Galbraith <efault@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Luis Machado <luis.machado@arm.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
 Hongyan Xia <hongyan.xia2@arm.com>, mingo@redhat.com,
 juri.lelli@redhat.com, rostedt@goodmis.org,  bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com,  linux-kernel@vger.kernel.org,
 kprateek.nayak@amd.com, wuyun.abel@bytedance.com, 
 youssefesmat@chromium.org, tglx@linutronix.de
Date: Wed, 11 Sep 2024 11:27:21 +0200
In-Reply-To: <20240911091328.GM4723@noisy.programming.kicks-ass.net>
References: <c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com>
	 <CAKfTPtCNUvWE_GX5LyvTF-WdxUT=ZgvZZv-4t=eWntg5uOFqiQ@mail.gmail.com>
	 <a9a45193-d0c6-4ba2-a822-464ad30b550e@arm.com>
	 <20240905145354.GP4723@noisy.programming.kicks-ass.net>
	 <20240906104525.GG4928@noisy.programming.kicks-ass.net>
	 <8d0d01b9-a430-49cc-93a5-67b4d68aa35c@arm.com>
	 <20240910140524.GH4723@noisy.programming.kicks-ass.net>
	 <52ca4cea-8f65-434e-af17-e4bf664d9488@arm.com>
	 <20240911084528.GJ4723@noisy.programming.kicks-ass.net>
	 <4fde8f26a9aeaeafda15b81bbb17b0ffc96941f0.camel@gmx.de>
	 <20240911091328.GM4723@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wtCvNU56qiin3jK6OcG7SOIU1EQXsFT9HQwF6G+VssbR9pagfCB
 0srjz3AgawCVGUrnEzb7j3H/WNRl5qvBnPrd+0qoDl+ty/xBt9DnSutLe/09NtoByeSpfju
 k7UFYSFy4tL/I0fXm7HrfjXM344IM7B+gYl3G0e9z4M0c527QJeOaxMiO8Sm7s1zaeLGnJa
 uZEjOgBVjFgedIrZN6vFw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+m9ink4RUVc=;dr5e9QOOm9634wpaa9U+KFN8O9j
 NFoSjoevjAYg44ej0VPdUKrXvsBs4P4q88efxdXzO471neA67C1QBdH8AJkfFtv6CfPc9vcxe
 MVMQdzofFmXMxehgIiRUJ8CJMDX6f6ZRRoH3kdHqfcCpWAbuI6suuc55ueLvv/4UPjCsoiOFz
 7ebzEqhLsDlJwG4pSgt1HrlQDqQfB5AsSGGrR0nNFAKaCyZ/knot3HMdNwcX2WLB+PtSWsURx
 AGzjUF5gM7nBJ+xUqvI0YnPjouz6LZResVG9OjCUAAVXTdRK+EO3rfg+6IGsVZil3gDUL04yJ
 5RSs0BxXryd7iK9i6MDhlaNXo1ZqAQaiQul59F24PFFncOCt2SC9nCuhm1HxfSoM06Rloc4uz
 FP3gxrug7osNkrfuPyYseG9QO1ETCyVjM4w20wag5TZFveN0s5Tuk8bWNFkfQquSCXjrIg6Aq
 4+qT8yA2FxvijSi7ogq0PQZjA/MOaTdt4ZcPyy/acymKRyfnoDmtuJ3COhIQbu5yn6oJfyCNa
 Mo5v8g7DxNyEiuPlP6W8yv5ojF3o22Af3D+bvtdmZ53ycgukmFCld0xoPRz0Oj+ZSW0mgFTb8
 aEMyO6mqe9UKUZu+RW8/DF4YFhWRjCWWqjKpvQbmkwIlj5DkJSNP8MFh2omKauohn0Sn+Tlk5
 Z3t+6fR2raVBcPOpzjW+i3G2o2opwXHJJUAPw7ifRSsmukm5ndo7cOX5hrgE6ve30xmYpyTFs
 U2noHfPbddpoF2rETvUQUiZf91OlwvJYYTc1QnxR5zxXX4ozAkYuviSFHg/xpPtyalWj6/Kg8
 29LmralJxAjTBA44h+8hp+0w==

On Wed, 2024-09-11 at 11:13 +0200, Peter Zijlstra wrote:
> On Wed, Sep 11, 2024 at 11:10:26AM +0200, Mike Galbraith wrote:
> >
> > Hm, would be interesting to know how the heck he's triggering that.
> >
> > My x86_64 box refuses to produce any such artifacts with anything I've
> > tossed at it, including full LTP with enterprise RT and !RT configs,
> > both in master and my local SLE15-SP7 branch.=C2=A0 Hohum.
>
> Yeah, my hackbench runs also didn't show that. Perhaps something funny
> with cgroups. I didn't test cgroup bandwidth for exanple.

That's all on in enterprise configs tested with LTP, so hypothetically
got some testing.  I also turned on AUTOGROUP in !RT configs so cgroups
would get some exercise no matter what I'm mucking about with.

	-Mike


