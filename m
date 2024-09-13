Return-Path: <linux-kernel+bounces-328574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C1E9785F5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C2C1F2570F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB079768E7;
	Fri, 13 Sep 2024 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="pvA91mi8"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B137F78C92
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726245624; cv=none; b=UcJCaxl/BZNCxWl4CMoJk4ELRhwR/lXftt/NgpWXzrkyuF/SdsMB4yPpX4WucbvRvcboDc95EsBgibC3AOW/rOFeHwG5sTFNBO02IzD0ACNAXG+W+vn3cm3XDcuN0HqyWcr4eHFUORQD7JbD4wbZoMtjvFR+rViJLLEPzoKz2bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726245624; c=relaxed/simple;
	bh=2iDw3nFw/VrGGoszru6PNW6bV1DN/nFroWUYoHc0zyA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dhq7VCS1LN2g3ow7/48i3P6SxUzzUqhLY/Sbsr//0LdxlwBDvhmO3RNQ8fbpjBr0tQKnWrZqR/N/c4lyt+npO/bL7cFDbUNqW9Z+uULk5u8J7JF0okUxdrP0tW5pOfAGWnUccMflLC8BeCDaQK9s6rF9H0I8AFH0bG1fTOEtpRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=pvA91mi8; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726245574; x=1726850374; i=efault@gmx.de;
	bh=exb+FryQp3y5/5ZsGkGEp7ZG8bgqrhPLm9pu7NlFCrk=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pvA91mi8kWG2oXwduPyLiZZpS1PM8zIyQ9J0wF+JP+u83uAaaCXqqBMKRbeS4IiM
	 r3MdTIkH33xka6meKyREv09EhczpDyQpPqbm7Tf4ZOQ44p1dhn6SwmQcGQQcCi2uy
	 ojg/HYK4qjiEkZE4JqEqUlrm8EOKmlhcL3SNn76vrn5iFutmDKpiGJrk93dEGFins
	 Ln5l0Q6/ZogkHOj/Thcz1rqTMXyKjA+QovB951Q3rhePsEL0Zaa/qTwnIZ+VN85aX
	 BwYAXr+eWGEuzEYNcPEPhak+9e1Z++UuFcIQjzeZP1Zud155Im16uPSspQVUGF4AZ
	 Z4umd+P9aY0tPFqYNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.6]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQeA2-1sbLo82eeM-00Y5Hm; Fri, 13
 Sep 2024 18:39:34 +0200
Message-ID: <627e37090198cee91bf79c41b1cd8c20c2e2d71f.camel@gmx.de>
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
Date: Fri, 13 Sep 2024 18:39:30 +0200
In-Reply-To: <a96858374fb06ba38dd5eea5561cc7542220416e.camel@gmx.de>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2VNJmv6wX65Zijuz77me0RUg49CULHI191g+N4q91XuF0mv1fOe
 vo+DO+5T/OcKsXpNsYN1TTjp86Ks5ZI7t6jzMrBc9ODJaj9ZqwmLZIp57/zAQgGecfWs9us
 86KPjyQyMHI0m0x3mVEksyXmDl9vhJPCEX8Om9NG94Gqw8qkP5ZotuW6ItXSjRpkPR2asK6
 TV93k6imaDGf8mwam2NMw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mbdwMW34Apg=;MnRCBfnuaxNYZ9g3jvfviRlG4mF
 LUoLbaunQpT5KdxoGdoGen55Kn1hO0ksIcj+xt0KOIkLcKpbRQqxU4ouYOu+ld5mg270R7q/D
 9+2UmSuhOliUAyqI6GJneiB/PtIGRylsGXlT56PIBe26CTtuzM6YnGSuySgmMZ5nAICELPg3T
 28AvGbWNohGSVyjPtqnfHp63Qj2/CWhJwvTwWJdV/N32vFOPldDC3ipimte3sxpliMXkxKB5Y
 Ws1xmNcdwrCeXUZkt8zRiBEVnnCihDjlU8NiE5uqY2Vav5JQu2UPKf/+6eVginXJUcHdi8DYq
 yrmf+fxwaWaT+uw7p3so1eQvuvOQZSZSNZmR918ciuDEGpZMXcIYCiR8kwdTe/WAEVC2vKAMY
 v5SIVksC5Q0uUbXwp7Z0JKEMElkC6F4jhW4shpn8eD0RAoFjzlJBA7EKmsLwpKlfhv3E+4oD7
 +oh/xqIvsqmQaxH4YSgZ4quEiYXuhSGA/alhZ7S04H5H0WEFR1Ho2InnCJT7Sw5cfT7MG+gQZ
 +cbjxvCycqJluvR5sazwwG26NKt5uXM1J5Xa0ej0eKZXNXaaguOofWg0WxcCmHw0fKDHpIqwA
 SCjCrSmRkUNbhaEnxcDjZdJD6oN+NiP07FVhJLCXa4QmTLcwL9Fe+D3159Affky2PIuzCkoJ2
 UErRfg5UOPoiqoXXz3PgHqRs0cXydjyXvr49ATx47raJiDAoqWdBV9DHDEwQsuTCoRC5O5DPi
 1hRpoHURtCuTAAioe4kIWKAWCbV6n6NYW84Xw12XU0sA7EGbF/9lLXIZ8q1zygezBz2EXXLR5
 slO9/K4HSJOXKcwis16MGG/Q==

On Thu, 2024-09-12 at 16:00 +0200, Mike Galbraith wrote:
>
> Oho, I just hit a pick_eevdf() returns NULL in pick_next_entity() and
> we deref it bug in tip that I recall having seen someone else mention
> them having hit.=C2=A0 LTP was chugging away doing lord knows what when
> evolution apparently decided to check accounts, which didn't go well.

BTW, what LTP was up to was cfs_bandwidth01.  I reproduced the crash
using it on master with the full patch set pretty quickly, but rebased
tip 4c293d0fa315 (sans sched/eevdf: More PELT vs DELAYED_DEQUEUE) seems
to be stable.

	-Mike

