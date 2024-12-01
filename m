Return-Path: <linux-kernel+bounces-426626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 509B89DF5CF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 14:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D19D162F14
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 13:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401651CEE91;
	Sun,  1 Dec 2024 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="APfCIZod"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53371CEACA
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733059833; cv=none; b=P3QeUMTpMp8WVeTh4pcE1LHfZLSk1TML7bcyDmMWXN9xgygS2fNcMJrYfQwIM0vNGiD0NkesneiwizotMtAfi1oyj5NBhJJT33hvBjGg9VMRFax+D4NhGafXHwylkb1CfQsqaebGiaxtjZPzzPTnYvLGr/mjndQw8ZNP1jAX4oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733059833; c=relaxed/simple;
	bh=QVUTFHvGZh8CGYQLwGt+BR63WYTrM7H8z8im58kCPAg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=em+2gEseb/eaVAkUdFK/nh/AwEho8/uyO4EoM1Rhw1On+iC7aq1eJY1E3LhoeIIAFYQPxPmo6mTJ4Px/wV17yhOrfwh4p95Hrw6pWwRxdB9qts5hRYR84wXAyisPzgHh9C89p1aaMgYwSlkHJiMJwL+UsM0PIk1sd2HGctj+U0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=APfCIZod; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733059808; x=1733664608; i=efault@gmx.de;
	bh=BoMtv3zxb8PWhy7i2qOYQNapd6ybaAS3FvNvE/khAuc=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=APfCIZodsEvTflQflBEkOc9eJdtvCHcZfpakYvyAhD+h1iLDY95seefUw7OofCTG
	 cDi5mx5kOGZ6Nu7CPVb1tPNUr1Q+crogC1ZiwBGXo31xD02PyXNCs4S8pHSh8RRMq
	 2I+B4LttuiYz9EwRjZUUeen5CJBdzKqt+F7VQ4+AfEN7XbogNeKHVxRfHpw7GFKN6
	 XQI/3OxLrs54PX0tu+R8yrA/5W1Vnpf6hufE409HYD9dyEjIrH6HZV2tKcXcto8E8
	 QkMLqGVtVwSOXtYT+MTaAFjOMUXOpCfIBsO8q20r1YC2BFt5yBFQ09OMj+Cdu7duh
	 gaWwde8LoooAFZRY1g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.84]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiJZE-1tuwOk2vmY-00j7bm; Sun, 01
 Dec 2024 14:30:08 +0100
Message-ID: <227863d758551e75cd0807a5f1f31916d695205b.camel@gmx.de>
Subject: Re: [PATCH 0/10 v2] sched/fair: Fix statistics with delayed dequeue
From: Mike Galbraith <efault@gmx.de>
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com, 
 peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com,  linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com, pauld@redhat.com, luis.machado@arm.com
Date: Sun, 01 Dec 2024 14:30:05 +0100
In-Reply-To: <20241129161756.3081386-1-vincent.guittot@linaro.org>
References: <20241129161756.3081386-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:enPXpd43l7w1xpaZ2RO2umpezVa441Xkgg6JrNa3XQJyvQxobYP
 BuY4e1ntQBs/+LX641TorMR6Z1teP9v4beh25Al7GGdHiHDeFnzvzplu4TSqQtYHjXvm3fK
 uXU2xoszWlR6oH3BytKqLjz+SAOar5FQRRmWT1XR4mUjNeJUF4vtBR4QsqkKHX2cFebXMSG
 pA1nK+S6MpP2qNMHVJGKg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NI5jxck7yAw=;JaZrvhw5f9WAphxQwF1tnbOA9OF
 sBwv0eqyfjq3w9TpZLO0v0ZqebWt3ojTBSFW3+VWAqKP3a++Lqr+NNxHQhTg9JGKpQyjDnN3o
 SMaQysTNsKanLnD9Zt8mXR3qiIoyfhKxRyTSY1sr9PM2A1/DCjk0SSE8Mc1twU8XXGXA5BjWH
 5wR4pCKsi5XxtkukA08SV4Ozy/Qb+WlWln9GW18WVL8z3N1jIrXW+vBqVnOHpP7QCP9W4zIk4
 wKSpcFo7DdlHA6UDPnNO3+6ydyEDP+9AnpZaDQJh11sbqSuGmhNDt3vHhQkhusScnRt9DCtXO
 utrSq5pNwyEgEBhWHkzERuvEni/+beUj13kmtAFKmEb1SOvNrgD/bqmfA3lYz9A9U1ECUopwh
 KQ1yWALhffKzmjxwwiGRchjL5hk18ELMUasXlw8ZTjWUVH6dZyxtyElqC3oYx0IQ1exmuPFGP
 uUS5WfXehlCFsUz7CDvx2fnV6mkeT6AFxaArBOapIRldmG6X6+npct1rHXp19WumwKFq1UfsL
 5yrbMy2Vp94XyJ3XZktgT51Ht6DL/lCany1rRKWzcvOKdzj+RRVPhe1dIFH6d8RwvxjFdoaz7
 qXBq7OSlopFmbfIuDcQdXC5ZOmM94HBmfRCy59yGcK8ybEIs33Uida3I3Kr97lx062qkQwJPx
 Ful2PKXiuZ+J+WIDDinmC0aMr9YeOGO4n1PjyCxIcWbcuX/Lzr1xSLZNRvADLP3hLPnpoINuy
 ewCZ7bvgnCkuNOZJ8i/bkO20ufvntmF4tgF5Ail8YEen8i5G+mA0kCk5LYrWUWf/2P18SBT0U
 DYS5KyzB8hSFW4vXK4HCkiINcR/RIxZIbdEzej2kxcipBbW/UT07CXqirOOulm+RzmrA59b7z
 nNxWg1/FSsfQmgeIyCLl92Rf0knZb3bnW9seA78S+3x5irgYe8FxZWD1jFPwB5MmE0fFCC27O
 Z6MpaS61NewYw19EGuOQgWadN1CP1pOp3HGZR0pYubfKw7KQlewj3JRsze6JX7afy/PB8dayR
 Q7tAoSWBQ7ye39Nio98rNqXP61SDCxDjEoWRMLBgEoA8XVXhd0rpWybFaKB2gN4EP9h0/yFcz
 Lof2gILlRCySJPiEEAsBDTIHXucBFJ

Greetings,

On Fri, 2024-11-29 at 17:17 +0100, Vincent Guittot wrote:
> Delayed dequeued feature keeps a sleeping sched_entitiy enqueued until i=
ts
> lag has elapsed. As a result, it stays also visible in the statistics th=
at
> are used to balance the system and in particular the field h_nr_running.
>
> This serie fixes those metrics by creating a new h_nr_queued that tracks
> all queued tasks. It renames h_nr_running into h_nr_runnable and restore=
s
> the behavior of h_nr_running i.e. tracking the number of fair tasks that
> =C2=A0want to run.
>
> h_nr_runnable is used in several places to make decision on load balance=
:
> =C2=A0 - PELT runnable_avg
> =C2=A0 - deciding if a group is overloaded or has spare capacity
> =C2=A0 - numa stats
> =C2=A0 - reduced capacity management
> =C2=A0 - load balance between groups

I took the series for a spin in tip v6.12-10334-gb1b238fba309, but
runnable seems to have an off-by-one issue, causing it to wander ever
further south.

patches 1-3 applied.
  .h_nr_runnable                 : -3046
  .runnable_avg                  : 450189777126

full set applied.
  .h_nr_runnable                 : -5707
  .runnable_avg                  : 4391793519526

	-Mike

