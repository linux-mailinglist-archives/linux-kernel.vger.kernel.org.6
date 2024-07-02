Return-Path: <linux-kernel+bounces-237265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0559591EE25
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 07:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36BD61C223D0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 05:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D9641C77;
	Tue,  2 Jul 2024 05:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="PQnu3d0J"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC7463D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 05:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719896944; cv=none; b=s0Q1UByns5cyc+askAc0FjiU8r0yyUE/bqcM/d353nhWKy30N8eD2R+YqkCS6UxjSXZsk6SuEq7ll3HkEv+oQuNDP5cVqbXHXWCeNmfbw6YquNnTJDSS9Ted9vEwCCdmQ6dxFZ/KaAejTbjRkhNMVjlNMLxrU8jbzImBHmjNe8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719896944; c=relaxed/simple;
	bh=UxVIG7dKLGkddBvGjq+qVPLrWDDwt88FhnbhsqxRO/8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ajom4BUdDE58OMdAIoVec1398ccCx8gdImX0AS4Xamj5EYu0ivyKX2HzyP7Z+jR9MrqJoJSNjNz+Q9asrxoWXgZfB8dEZ5SwaXHxSuiweMCYrZw79S/2NZKXhIwWyOhf8/wxSyzSZ2x/WhVT0ip7kD2DUChSNvnXqHe0eTT0sYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=PQnu3d0J; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719896917; x=1720501717; i=efault@gmx.de;
	bh=Dr4VuhNCo1a2b+BLo4JUUQejGlUxDbSoGc8IXOsOmas=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PQnu3d0J29PyvrWCY2CBR4+73Lzz0dyKYZLQnB/J42tBI+LlxSqQbway7kRXVOmT
	 bSasuVSXzRddWFBAXWV7nu3m4p5l0MoHD3upFe21QfPJGUgjQmgou02FMzmh3LEIu
	 b7obNhxVw7MP3fkzN0d9f8yRscA3OMU12ad8qQa9zpIaT0lhjU08Kr+BXEihzdy3F
	 BusgqPH5vUB+ZrVMXJGKqx9IlWi5GgP64YVCKVrOSOkHS50b/kGGjuvtTgbiNQ4+u
	 1uK39Kz+AtoYdj/zvzPK/l2mFvPRLll3+ccUJBEKbK8585H2bfIwc8Y4WOpv9sMUE
	 BCBgKAq5hL5OYu96XQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.49.228]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmKX-1si5sK1idl-00IPLu; Tue, 02
 Jul 2024 07:08:37 +0200
Message-ID: <d05abb37e19055d249b720c1ac448734fc6ea84f.camel@gmx.de>
Subject: Re: [PATCH 1/2] sched/fair: Record the average duration of a task
From: Mike Galbraith <efault@gmx.de>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Tim Chen <tim.c.chen@intel.com>, Yujie Liu
 <yujie.liu@intel.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Gautham R
 . Shenoy" <gautham.shenoy@amd.com>,  Chen Yu <yu.chen.surf@gmail.com>,
 linux-kernel@vger.kernel.org, Raghavendra K T <raghavendra.kt@amd.com>
Date: Tue, 02 Jul 2024 07:08:35 +0200
In-Reply-To: <ZoLDxQlTR7fxoXWs@chenyu5-mobl2>
References: <cover.1719295669.git.yu.c.chen@intel.com>
	 <338ec61022d4b5242e4af6d156beac53f20eacf2.1719295669.git.yu.c.chen@intel.com>
	 <d922f7bf3965f4eaef5028177b886e2e1861742d.camel@gmx.de>
	 <ZoFY/n2S7rMp6ypn@chenyu5-mobl2>
	 <db81ba7fba622e2a1b7186e66471cfb9ad8490fd.camel@gmx.de>
	 <ZoLDxQlTR7fxoXWs@chenyu5-mobl2>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0RyB7P1u8hBAYeXlz6MejoVA52KoVEH+ChBq93juWFP+bmBoui/
 IZkBpetKNvYCDZpjDVzsUevjW7LnuiBHyKVwzzCcSpOvWYEXBizasYexeUpRuTB56Qc+hjE
 fPnsJzCtkgkOApKiuPs84YERo8ijnxxXpZ5t+fVRMDaknu0s6X80raEQGv/rjivkLLZfuUx
 wWTUdeIcW6w4/FG29AmJw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zG3eWS3HmL0=;drbwvA4SLQw1b8XG0m1SAuOJTQ0
 eX7pNPY1YjxcCDl4JzPQk+0vobnpWif/FFLttB4F8YAcCwAi6orMFu6UC3CGW27HU4myxuR3+
 C31TVO6BVIRYJtcf1hkTUjuTeNOMcylPql5vCVNHnItS/RUp4p04odc8mcwZJ/qpXx8m1AgBr
 0a/RrCFPeWgX5nHwONmfv8KHaTwYQBHw44zyOOVwwkjNmOHIKfHGeZgqkrQ04hPax377p0bsG
 BF2Y0ng+G/u8G8s42BDm8tlSDdwmL3ZDCidb3TavvuPDg5LLxmgM/EmWmUR+hzDaqNBSPagnY
 ItJu6fj/f6VLyhKtwoQmzwllWSEU7XSaYcUK/yKNtclZ7LfVFglFdo8QsfDbpQY8WHFJ6Z6+O
 7GWu/f7IPYculRtDffORFFoUr5Z6O7ddXAwyygcZ316u7l9Kfg+X4ntarcCY2jCDexYgIs1+F
 06EnkoLpqTS2/pdopEUlFQxVFg/4Kdp9JryaZrTReaNUt8UMsdQwos1apouTYrg2/MCOKft4B
 EigDm0uQI5Fuh7fjBi4TTg0gMfJkrVP7nQ1QK4WYcFFKeBpuAMOdyeCt3RtaTruJgyLsb31YI
 FsHJUiN1+r3Zv5ELXT5gBI3Mbq7Hd2yCY54tbmsQBrPXP+zk8oYBhFy2GAr4JW4IKGmdUQHhE
 ZJboGT/qY96JzGt5ko8sqil+4BCPgmPUlD8tVAONvJ/QShgXXSblhtNPoLa/9HVGwoFSzDDH7
 KV2kUZXHE2HSsQ3QWEuVNxgKeIw+gpJHvPreq0pepd3cJ8/bWwCvhr3zvdV1v0o/pOg9Rb+xt
 DAdESdtawgliWaccExY1qy+T9ag8b4II5IHkV8pMEXnZQ=

On Mon, 2024-07-01 at 22:57 +0800, Chen Yu wrote:
> > Just take a look at the high speed ping-pong thing (not a benchmark,
> > that's a box full of tape measures, rather silly, but..).=C2=A0 TCP_RR=
 IS
> > 1:1, has as short a duration as network stack plus scheduler can
> > possibly make it, and is nearly synchronous to boot, two halves of a
> > whole, the ONLY thing you can certainly safely stack..
>
> I agree, this is a limited scenario.
>
> > but a shared L2 box still takes a wee hit when you do so.
>
> According to a test conducted last month on a system with 500+ CPUs wher=
e 4 CPUs
> share the same L2 cache, around 20% improvement was noticed (though not =
as much
> as on the non-L2 shared platform).

This dinky box doesn't have 500 cores, but it's.. aw, adorable :)

rpi4:/root # ONLY=3DTCP_RR netperf.sh
TCP_RR-1        unbound    Avg:  31754  Sum:    31754
TCP_RR-1        stacked    Avg:  26625  Sum:    26625
TCP_RR-1        cross-core Avg:  32325  Sum:    32325

rpi4:/root # tbench.sh 1 30 2>&1|grep Throughput
Throughput 139.024 MB/sec  1 clients  1 procs  max_latency=3D1.116 ms
rpi4:/root # taskset -c 3 tbench.sh 1 30 2>&1|grep Throughput
Throughput 116.765 MB/sec  1 clients  1 procs  max_latency=3D0.340 ms
rpi4:/root #

This little box running its stock 6.6.33 distro kernel pulls out a
cross-core win for both maximally synchronous TCP_RR and the a bit
lesser so but still pretty close tbench.  The numbers mean little
though, one propagation speed is lovely, but were there more, I'd be as
stuck with them as I am with rpi4's one-speed (all ahead slow) gearbox.

	-Mike

