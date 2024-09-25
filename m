Return-Path: <linux-kernel+bounces-338007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F58D985234
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162072856EC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4C114C58C;
	Wed, 25 Sep 2024 05:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="mZaLUSvX"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB251B85D5
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 05:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727241332; cv=none; b=GP+Heo9voBvN4GpGpy6y0a/pfM6dGJoo6S/HwjIGOzubYHqFnFduav25LfFhnb8+Y3gn2RW0UW09AiD37SdYLcUdgYsqt1mc8e+By4Y49hh0/dGL3N/DIou0BYvbxKuLQPLOLRVQnHsel277OkJr3F2YVkkwksZLunUR+YSG1cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727241332; c=relaxed/simple;
	bh=yQzbdmOEhwdwMJJRyuCjIEbgHVFmVwhhzYE1YAuj1Wk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GlIxR9DaWJ15rTEWHaekyvvX9Uyo88S5JRAaTqalPNEBNn6z5uxTp5sq4y3MYnHUAdjaROuppcOfDjkAbg/Nyo3XRuPcVKmW9PJmvFG3iAbMOKV9eG2NvUy9uXEAPp+eNVVtb8Dcba4wovaOjFqPJcPDojUU0X2IAgCUHcngv+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=mZaLUSvX; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727241281; x=1727846081; i=efault@gmx.de;
	bh=ExO2a8If8BXrRgtnsicajh/E2SAMbgdKa0rEy+wVXfg=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mZaLUSvXFta3n97fDW9SE02vRD7Iata2CN05sD5HH4fUrTKpXg4s+Az1UwdtDWUF
	 JwhTzlTReXxAxzcncsGObNIQBTWEnn/wzgH9g0GmBwaZ+iHg6hgmPweyT7CJqqram
	 9CgA2fmitws1AdN8G64VclOxtrGg4+ep4fKIm7OXBIBOYzNIhBvpkmCvEM5T2baZE
	 RGgtPowsJNS8vTP3IAKW6+Pb/WED+o1021zvEHH1i7jHTITklX2WMrJhRFdlnc0pQ
	 9H2gNCSrCK69eiFlE/bGiWKnFCgPg6liJooej0G7RrllE0kZ3c5cjCxxh6nIc7SBC
	 oIDoAZ5EBgYqtdYpBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.98]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdNcG-1sJzbl2u6y-00lc2m; Wed, 25
 Sep 2024 07:14:41 +0200
Message-ID: <a2c60338c82fa77e82def64c95134df9b8a5626e.camel@gmx.de>
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
From: Mike Galbraith <efault@gmx.de>
To: Luis Machado <luis.machado@arm.com>, Peter Zijlstra
 <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Hongyan Xia <hongyan.xia2@arm.com>, 
 mingo@redhat.com, juri.lelli@redhat.com, rostedt@goodmis.org,
 bsegall@google.com,  mgorman@suse.de, vschneid@redhat.com,
 linux-kernel@vger.kernel.org,  kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, youssefesmat@chromium.org,  tglx@linutronix.de
Date: Wed, 25 Sep 2024 07:14:39 +0200
In-Reply-To: <cd0002841126d8a42db94c3624ccf2ce8dc1ad10.camel@gmx.de>
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
	 <2030b198180259eede6384cc6a6bc9bc9f64f874.camel@gmx.de>
	 <a96858374fb06ba38dd5eea5561cc7542220416e.camel@gmx.de>
	 <627e37090198cee91bf79c41b1cd8c20c2e2d71f.camel@gmx.de>
	 <1e89e5bcbd43934c65f8da23e7fbd59da950a0a3.camel@gmx.de>
	 <c001e3ec-bbc7-4de3-a9bc-cc324d366fbe@arm.com>
	 <cd0002841126d8a42db94c3624ccf2ce8dc1ad10.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G7d7fKw8GXHdj+6ObhIWZuAYYPDyomyg6tl75e6yLlsrbnAMEGE
 v5Vr9l8JyYL80qVNw4/0f1+Gm3hm6yzArU5Lii5DTnWX2i2knOobefYzicowyttsMBzjnRL
 ElIOdn4oua4Bkq/DRho+pfvHa8ZgGUq9toM5jZQneYuIJ3Y078pjYml8w2oP+L61X3w1oVD
 mVp1LcqyBw+TMsfmeEzwQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kJ+b91tePTI=;RBcq5O6mN0s0aWHbv3S79iRms5U
 eRVmJwt/OTEW9vQmhQ2H96SVTrs+awsP5VAYo0C0OxFFnKl43jtyXIBqxPJz6CG4kNhyUBAdV
 8lNUSV5oe/4zcrywMy9W/9NScrMzv47yjy29Wgu1im3V+bM69i47brEiWnQjPK4gZsDlzPVSf
 fubb3sqVrFFTHxEp4O/GgMmJFNOXNwtBiSfaX82X6hjGXCCiHyaIzBVl9EGTpWcoW+i6MvHpL
 G2mkFjXYn1PSr90qmh5Bgv0mRb41zU4TicFdTBqxlWkteavxaAv1GR+IjkCLftGEX7vr53eQg
 7YWjidj62lo1CvbLR5og3eYhXaDvimKfpnGoHutF7vTmkBY7ZgjUEgaklQufEeJ5bPs2OL7hp
 zrECV5AswQLXr4llrwbwt+U5oSwyfCO/uf/uSq4V4UeV4QaIuNN68S5xQ9q2EuZwzyrpdTrlT
 eXJuETP8hiKHOlvRpoMuPg2l3w/VKVec4asjvSligegPKiKrn6SimvQyk6taBwyl71sUYKd4N
 Ux71yEYxh7NqdHF3fHQPCEGU8aSR8PQIN+YppGIT51NH9ZpYhpx9HGzz4bsLINvX/vGYc1034
 DJTLRNWbRhLw0Gr4iUrvOypgUcS+m2uyp5TnUg5fei7cz2CjDwcXYznG13nPmfbyF/ouz73PK
 pg53/I37F9T4wKC7y4MqOzOgaFNn5q0xu10/fjmdAfXnBDb4ibcWaW++XJu560JLPAZozg1l3
 xjdQzYIgDvfMQ4ccmWtwgcMDUZBHhZrejZp0iqFdVEW1CcGYuNe912Onprm6Jm7N4TpXatHt7
 U7KMj6D3ZrAiijUUIinJO7ig==

On Tue, 2024-09-24 at 19:35 +0200, Mike Galbraith wrote:
> On Tue, 2024-09-24 at 16:16 +0100, Luis Machado wrote:
> > On 9/14/24 04:40, Mike Galbraith wrote:
> > > On Fri, 2024-09-13 at 18:39 +0200, Mike Galbraith wrote:
> > > > tip 4c293d0fa315 (sans sched/eevdf: More PELT vs DELAYED_DEQUEUE)
> > > > seems
> > > > to be stable.
> > >
> > > Belay that, it went boom immediately this morning while trying to
> > > trigger a warning I met elsewhere.
> > >
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-Mike
> >
> > Are you still hitting this one?
> >
> > I was trying to reproduce this one on the Pixel 6 (manifests as
> > a boot crash) but couldn't so far. Something might've changed a bit.
>
> I'm also having no luck triggering it.

BTW, that includes hefty RT/!RT config beating sessions w/wo..

   sched/eevdf: More PELT vs DELAYED_DEQUEUE

..and w/wo your mod to same, with dequeue on unthrottle patchlet to
keep sched_delayed encounter there from interrupting the hunt.

	-Mike

