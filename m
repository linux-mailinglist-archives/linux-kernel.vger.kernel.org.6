Return-Path: <linux-kernel+bounces-239552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D05992620B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3BB1C2183E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E7C171679;
	Wed,  3 Jul 2024 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="Y0wOjUJy"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839093BBEA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014342; cv=none; b=V5lg8nFq0Jr7i4l6+ExVBQ73JJ5fft6km8aM5qu9zPx4OQtSAA98P8wFldDRrFMUDSzqTsCe6bhswbi/eq5RJ0KKg78HeWh72qiV1SBZrhHHDxEXJZKIq4PEZp1YRozI7X6sNIAIIyen1bM3l1zjjHLNvECN7Ac//0A1hKdlnkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014342; c=relaxed/simple;
	bh=8tA7B8QLastRGbA7MeBQsihKnyFlqwm/jcWdR5LFPYI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bIJu03AcqpWCKk6ii3VfcrzpgtkgijX9mNxKXMie87lr48/hYUG1tyxHQeLiKiQXpjyswYS+pW6V2U4cm6+1sD12ogROhomhuhKNvO02nEmW3BfWj5yuj4TliHI35GGfj13WfpzODHA94IRHQQoIxoH07BF4GuBJX1ASuMlLC2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=Y0wOjUJy; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1720014316; x=1720619116; i=efault@gmx.de;
	bh=xu/SnLB/Fljhm4ChiQGySOZFvBpo/HmJl/ceRfBF5lk=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Y0wOjUJyezvuvNnBR0hM1drkrs0snD/2cclcc3n05TT4naD4WwZKo8BQfzv17xbO
	 5V4KsGhK9PGWgJJrpcn8or3bgd+od/xWoIg930Zhio3vWcQhf7Jp2rSo6kWlfqgcn
	 jmWoEV1gxj6jn/7s8kU53BQU//j22dpDl30NbVJxxP3N8QMSYI9f1U/SZ7VX5tqhg
	 8p+EFl4kA85OQNCLZd3YXRWJg86GSxDorCxLCQ2SrYkSUt+U2nrlQ9Hs46IZ+wosC
	 RH8CZMRKTaGiWZrO1pnxCHAR7RupCb67IYeYPl+79xH/Ki3Ik4csSxyPDxMzReiY/
	 RrKGsk6sNFy9HNweQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.49.228]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGhyS-1sclw60mA6-002DUJ; Wed, 03
 Jul 2024 15:45:16 +0200
Message-ID: <e90c75a2e4e3f529c8d42edabcb103885449de3e.camel@gmx.de>
Subject: Re: [PATCH 1/2] sched/fair: Record the average duration of a task
From: Mike Galbraith <efault@gmx.de>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Raghavendra K T <raghavendra.kt@amd.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Tim
 Chen <tim.c.chen@intel.com>, Yujie Liu <yujie.liu@intel.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>, "Gautham R . Shenoy"
 <gautham.shenoy@amd.com>,  Chen Yu <yu.chen.surf@gmail.com>,
 linux-kernel@vger.kernel.org
Date: Wed, 03 Jul 2024 15:45:13 +0200
In-Reply-To: <ZoVQvDEme3CBonHI@chenyu5-mobl2>
References: <cover.1719295669.git.yu.c.chen@intel.com>
	 <338ec61022d4b5242e4af6d156beac53f20eacf2.1719295669.git.yu.c.chen@intel.com>
	 <d922f7bf3965f4eaef5028177b886e2e1861742d.camel@gmx.de>
	 <ZoFY/n2S7rMp6ypn@chenyu5-mobl2>
	 <db81ba7fba622e2a1b7186e66471cfb9ad8490fd.camel@gmx.de>
	 <ZoLDxQlTR7fxoXWs@chenyu5-mobl2>
	 <683663e3-cef0-bb45-e1c7-5bf1cf44209c@amd.com>
	 <4e28fd17d7a2f7146aae10a76982f0e58b22befb.camel@gmx.de>
	 <ZoVQvDEme3CBonHI@chenyu5-mobl2>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p0uamndQAjL4e7FwOMZ7TOF2MxJK5kuYW1n/tXa8UjF/5cQDwl2
 qzNnzVhqd9PVCrut7fyYO6wWYKXGH71WlQ78nqfVG7wKiJIfD0C728id3rUMiSH0ohCzvGL
 iasFd84AUFp/N6wsYhp5HfKhB1CTmnyJ5BIOK8N0Jg5l9bERhuUEMcGNxd6pv+mHkA+hkzM
 kpgHfVCLTNa1kEVSTnF3Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2ddTCT/aiA0=;sq2II4r3/R26cAeM+jAJ97f8R2P
 ht1lviK94sWWv5dqh7POUNaWnS+Mc68qysCsn66x+06W2Te5RaoNDuE5XPsYZwXuLoWUGe6HZ
 BIdkge1N6iJlHuWUyK90j3cyxWl+FE5UsLkBaUkbfYcu/EuTN/7+/rrPZ9hSEp4IbjTaEU6ZK
 pO4PM887XKN4TghsZNYLVbMwiq3oUbkI/OVK3L2avB4W1CrTHyGui4h8U2rP7zJGmVvqdSj6U
 GVG1DBENHCb+QanxH/203YqdtL1ldwWduTjD/39KGEpZJtBfIK0AOiGNA9LkZ2q3RMpgxJw25
 K8tGT6GWGDqJESCpVaaPYBMgAsYymBW/yWGLdoU+/xRrwa8Y0OOXB1OJ2EJ9L3FNbbWFOZZkX
 TmY6N3bDR2hqxq9yPNM50nGfTUp0URPd5jBoJlt1YrEbo2GJZsWRX4aTM6cdiJ7b0vRpEF6jK
 WrVfJDw4wRVy80Qjwh61L4oR6aWnoSAM3BllumiJh03eu22OPCPfiKLsYm3eNE29M81U0Ie25
 5aFd/iN5xHdU0jdSDiDBQQWpyi9mxMewju8tA9TshFpv1ohtb5zNqLQUYbgmO1q1/TPzGs/05
 2HQosVumamzztNsJfiHZNJED7ga12TW0slwOh94jKgDm82ucmjLweg+YjGzd+U7J4CJoynx/i
 tYvcaujkwNTD968fhI+U0ujNUVgk5EblD7TOWnEXNvvl+Q4uM5JeSkSlrkP4RktoxvE6r/JWn
 Kc1BQbJMDDcTHyaaXbuel5n8N18VD3nZZ9a0VDpycEsHxbiq/bZXoGuaLDUsKtFEjp0A6K0J6
 YGr1ZuohATV2ggaq+4LwXSfgCdJg/KHbZJ4DUOehH0+EY=

On Wed, 2024-07-03 at 21:23 +0800, Chen Yu wrote:
> On 2024-07-03 at 13:57:19 +0200, Mike Galbraith wrote:
> >
> > Oooh dear.. as soon as you mention threads, the question of who's
> > wheelhouse is this in springs to mind, ie should the kernel be
> > overriding userspace by targeting bits of threaded programs for forced
> > serialization?
>
> Do you mean the threads within the same process should run in parallel
> as much as possible, regardless of sharing the same data, because the th=
read
> is designed to do so? If so then we should probably skip the 1:1 task st=
acking
> if the waker and the wakee are in the same process.

That's seems like the obviously correct answer.. except for that
leaving virtually the entire issue you're squabbling with lying on the
floor.  Grr, how annoying.

	-Mike

