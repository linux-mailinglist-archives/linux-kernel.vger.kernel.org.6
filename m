Return-Path: <linux-kernel+bounces-286966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 353309520F1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 639A31C20B7E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380B21BBBE2;
	Wed, 14 Aug 2024 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="Oahb3T25"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5672111A1
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723655925; cv=none; b=kSGOouLf+j4LqGhPLFzA9aL0iB+MuDJeZ2fw8Sispt/4l31PVOa8TqYbOzWHjV2Q8sQfiEH5xpC3AyqMoE4KiNc37IQKpcRmiTB13TrNOFA3Hv8BesVwfAwuP1UakHXxI8BYYdBDJ9lYjPr53aDZcvSmfykqodPr97xhQ9I0ZPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723655925; c=relaxed/simple;
	bh=6mmYT3J4QwfeMniA6nvhnCYk9hKmHhhuuvwlFZWssw8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qxT+gtbi6mRFyPn2VW8Ki3F6AWverSGyGrMvLea/fhoZflQrZ+Ji76JCtUB1kTH2dqpbuZoI6tm1d8vsiNwILmA98+SR4rGYPJNMqa+Z9ubpA9qLy7szo18+VstLBhSwR0ZYZT9DyJdmvDofrgjQlS9kHB2YUhNtpch7sJ0O0YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=Oahb3T25; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1723655890; x=1724260690; i=efault@gmx.de;
	bh=5ibHj9AV3wDKWhb2rF9aNO9l1Q969wURFhpMFe3wYuE=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Oahb3T25cOvNe+TE9o5Bex8oUMv8kx3csVFLI9aUQ0G5HjpGow8QQqZleghJhrKu
	 oTrVR+QPm6YzEbTQjIbthG6xQFXrU2qjdTt01ib91d62bFqszri2UR6UVBP5y5oI+
	 U98UO947U2mKRVsoe4rTR/1EX5y9Be7s1SlJjd4JSf5Jda4fsknPIoEqtL/97vJHL
	 EpGL8JjMLMsP69ebh/01oyc1rGpF19SXGoxHhQIyz28Tg6DXe3pBY7VqxrRZQl8uX
	 WAFJx+C9rY32024y/UA5s68UkJASmxnisbZGtufGRjY3Xl/R5iuQA5aOUXpEGrEae
	 JqnzEtoFrEmHLAvvGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.61]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlf0K-1rwf5s1mao-00lyT2; Wed, 14
 Aug 2024 19:18:10 +0200
Message-ID: <9cc41a877aa2d263b47de698d3ebe724961f9e55.camel@gmx.de>
Subject: Re: [PATCH 00/24] Complete EEVDF
From: Mike Galbraith <efault@gmx.de>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
 juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
 linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com,  youssefesmat@chromium.org, tglx@linutronix.de
Date: Wed, 14 Aug 2024 19:18:08 +0200
In-Reply-To: <CAKfTPtAjXejbsGS+Wd0maiiUyCgSb2xPVZGUXUPCSw_kNLJRDA@mail.gmail.com>
References: <20240727102732.960974693@infradead.org>
	 <CAKfTPtALe942tjoyq1RqSYyM40PG+tfEY8skRDxRM1daWLSKUg@mail.gmail.com>
	 <1572d0f2646312767a3ef8b72f740c9033163bf3.camel@gmx.de>
	 <CAKfTPtAjXejbsGS+Wd0maiiUyCgSb2xPVZGUXUPCSw_kNLJRDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5YGAKM5g2hwyF31VY5oQGLv7nCzD1JLJfRdkUOMQO8s1wcgbSVU
 CLtlneyylI+QQMMzpvKdI/c6+VBi3PP4PdGd9jKs9c8Q1eentBnUchFQFbNEaPjZROnD0m9
 ZnTev0mbcNlats2vPzaZ7ETXi40xmPKIViaWZY9OovDKm3s+zQumDx9tNpwAih0ehUdKD13
 HH8jZqYK55SdHSelOCikw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vq1iCbiKo+k=;9HDfadfkAHE/RDL8YMdM/qKDhM1
 8omgIfw1UhMtJHokU5k9w+BRIahi9L5Pq5KJ6P3+fx5Hcy76WHTBxFKo82I0pY6XyflFRwo/m
 IHH01plvruu1jPVcvNFk94W4ajk8C4g+TRTa9AFMao+ta1FZDexy4eKMGPzHGsXoFzyo+x8z1
 Uc+9Zcmagc4hpphbvsK8a3K7Psd7bigAp+YTFcAl3CsX8VbW2PtKQOuoJxLMSG02IKMvb2zXo
 EVObS+VbN30cUZXCHX854Ta6rdS3IElq3hJtrgBEKbWLZuMJkymqSrQ4y9EPD35S4bk9uVhlh
 R6AnpQz6YS9lRoWI/R6esHue5ofUSd+rm7ftonNwcVu5QJSw/ziaa7pE+aym7Uk5AFs+wpN98
 Gdkvdb7mo7zdyCAv0kgbDJKNg/RcC2DiYZqFn3RbwERXLb2nI8T2Qd37iYwXFpccwe60Splst
 hGeEbIAMr+KNpaTC6KAHVFKOnuXWghxUKQu0a3ArXzyzeUslJg/hnXWsA451gy6pNUPE5vqYQ
 jS6hDQWiRsiq7nBiJy45yHf/6tzacvrQlHzKRXhqy9UWwhHJp/+Zmbi3iI+UwNonI3qqgQTvK
 HdFHEryy4Ljg2iS8MIc7QjnRohAigwop4QojEmthWPbocifpVfJMWaby3H2gbxZ85C097dblv
 /lBL5H+UyOXfODf8MJ9/oPtr4Pwz3dnQ7Atzn1uPadXbnNivri7pbPrVIr6CRS90Gq0l3KrPk
 XVpH6cK8Mj0DdKeZ5OVoPf6UwPmMmVxepo1BGyPcqa+pth3pNUTz4yLLnb7wWRi9HKICTUEin
 bM/fTiaWkXmCJMQM/Hvectlw==

On Wed, 2024-08-14 at 18:59 +0200, Vincent Guittot wrote:
> On Wed, 14 Aug 2024 at 18:46, Mike Galbraith <efault@gmx.de> wrote:
> >
> > On Wed, 2024-08-14 at 16:34 +0200, Vincent Guittot wrote:
> > >
> > > While trying to test what would be the impact of delayed dequeue on
> > > load_avg, I noticed something strange with the running slice. I have=
 a
> > > simple test with 2 always running threads on 1 CPU and the each thre=
ad
> > > runs around 100ms continuously before switching to the other one
> > > whereas I was expecting 3ms (the sysctl_sched_base_slice on my syste=
m)
> > > between 2 context swicthes
> > >
> > > I'm using your sched/core branch. Is it the correct one ?
> >
> > Hm, building that branch, I see the expected tick granularity (4ms).
>
> On my side tip/sched/core switches every 4ms but Peter's sched/core,
> which is delayed queued on top of tip/sched/core if I don't get it
> wrong, switches every 100ms.

FWIW, I checked my local master-rt tree as well, which has Peter's
latest eevdf series wedged in (plus 4cc290c20a98 now).. it also worked
as expected.

	-Mike

