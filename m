Return-Path: <linux-kernel+bounces-428037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54F39E0C06
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DA0AB309FA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768851D95A3;
	Mon,  2 Dec 2024 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="HPpsLATf"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8496D163A97
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158571; cv=none; b=XiOyuQGS8ELu7OhbVFRD1aPe5rVnf1UMmAK25ZaX1O0HkpACqDcYIWGxjF3k+fKNfOY+G1EFC2FEBJKLH4DFUpikOsKdm9tpnfvyCFdnPgCMXfBlpEPRcw7mE5k/kotJfxNYMAOu680xCNqq79Tu9/xWeopqSB5m7szmYpeewOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158571; c=relaxed/simple;
	bh=bGNjhYSu7+AOfKBGnhPVu3FS6pc82e4tfln9Qqn5dEk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BPCyhPhU2TDkKPtvPoXFuGokDdXGcGA2I4o3X6sGLR0NIMwGcT0qnn5nvnzYM7QATdRNY06kLsJc4C4tetyS3A6tWrEf//0bmyHb/RJR9R5D61UqLvkyVAidgwwN+XzM0ClM+3jIZApLYuum8/NamMOfKOEA9ktrRf9jT1Eyi+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=HPpsLATf; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733158531; x=1733763331; i=efault@gmx.de;
	bh=4mGgZph1Uze+qya64Yn0gVs4EdFTxaa8S7imLTdrXic=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HPpsLATfhO5Astp//TBTzMsbfnSHaRyYGmZFvXTs0oLnsX5z5kKzFE3VJChquEVK
	 m4xTquT7TroXsBpO0r9EIWKCl1RTTuKTBXc0lnaOqSS5d+iRchbL4FQ+FqqZyjczv
	 cHbC90ytVA96qzeq3nN0J5er0G1PQ/27cORSzQkqPiobeXqPf0DQwf64LKRVTSd2f
	 ycj0RJNN7TBNU68jE0ZjaE+wWYyAEgMVThtJFTQmxwWLYbJdcv3nyj8BbXmUzuHGy
	 lmTf70EY8MWgVyDRwEXmmtZy9wM/nYufSOxh7lMdea+73NTl25lanALm30VUw8RSi
	 8pLBw8QGM+HYI9/3HA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.84]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MatRT-1tpIXA0GYF-00dEuQ; Mon, 02
 Dec 2024 17:55:31 +0100
Message-ID: <9c78aebb3fdb8af68937a0301fabc3acb3e20c2d.camel@gmx.de>
Subject: Re: [PATCH V2] sched/fair: Dequeue sched_delayed tasks when waking
 to a busy CPU
From: Mike Galbraith <efault@gmx.de>
To: Phil Auld <pauld@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,  rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com,  linux-kernel@vger.kernel.org,
 kprateek.nayak@amd.com, wuyun.abel@bytedance.com, 
 youssefesmat@chromium.org, tglx@linutronix.de
Date: Mon, 02 Dec 2024 17:55:28 +0100
In-Reply-To: <20241202162427.GB1226982@pauld.westford.csb>
References: <0befc9ed8979594d790a8d4fe7ff5c5534c61c3c.camel@gmx.de>
	 <20241112154140.GC336451@pauld.westford.csb>
	 <81de2f710d8922a47364632335ff5ba1a45625b3.camel@gmx.de>
	 <95ff75cacab4720bbbecd54e881bb94d97087b45.camel@gmx.de>
	 <20241114112854.GA471026@pauld.westford.csb>
	 <20241119113016.GB66918@pauld.westford.csb>
	 <bede25619ef6767bcd38546e236d35b7dadd8bd4.camel@gmx.de>
	 <915eab00325f2bf608bcb2bd43665ccf663d4084.camel@gmx.de>
	 <20241121115628.GB394828@pauld.westford.csb>
	 <bf4f50886c462ee1f33cc404843944fea4817616.camel@gmx.de>
	 <20241202162427.GB1226982@pauld.westford.csb>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EqcxqgEYh4BKH4hYDeWjs+360ZQwyo02TKETRikHRsI6sYNtIfp
 wF8xchbfCHqtqbqKzUgPt8tOT3zqp1F4PIDBtpk+L+qg3UymLq5R9PINzV6qQddIXQosy1j
 xVlvzq/tNLvgrwwVRgeZsT2cosWXRub2gJq9laf7SIHc5CzFFL5TIkUyvlvZFmjBLx7F8Jc
 VoFhJcdgEr3UUXcCppoXw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NAJr8xofO3M=;V7H/Yze5YqFw8AzXa9bQxRk4JGP
 +T8Zu9onSf2eTuwtz1GH/PmyEQDRGM8HxsxZTL39kyUI5UucjS3Vl8o4LDBUwd6ogLN+o0HbT
 VmdCXrwEZdCGqhq6uqZL17tdyQl0lIfuRYqIweMsDxSfdbnZnqCfITlGW1b2dsXuefKXqInXz
 XH8cs1Ii/ieNmZDkxF4C+0efsVlFuQ9i5TxQDSVHp+LYfxafMHNBAGjNfmJNUu/ICApUjlas0
 DmVplvpBTwYftx5oIEqfz4hYTqPBBkxKv4g9S+WB0ZiBMpR4M3v8249kSnqH7HrOor5zXKNZd
 RnySUmfEAjOOywaD/uwp90cGGZRUvtHLJHI5izT2S+1Zzwd/BWoWVGvd+IUfMTwLsm88AaMbS
 QzBQm4Q2WKrtCKqR/Uc9j6de0glAozpbnh3zshUtmsM6uRaHShM48gDHVJF7GPY6ylVYnU8HG
 fAGaFwcJ83+mHl6dZhBMPlg9jsXcMUVY7LEmGFYYGdRz+23eEICJIaLTz7ZPt3KH+IBQvZNC1
 UcmuCZjv0V2C/ObDoaB8DS2kO84UncZO+FCy8nm8J08UHPxEnRVx+qrJHnK1qO9Syrj0BhGX7
 BByfv8tOZhAHe2GBOALtH/Zzrk9j9r8FnV7T39Jwo/Wx9iREQUrEwoBCtHt1hZxc5c8+9+naq
 itjtIekxaR84QPi31iwQXWuuNyEf7AvjVae0/0LQM116MH79rfR+9RMbb9IIUWxurnNe2Q2jf
 NiPHWimuvd66t4ZKwPC5sJs94H+sTWxkFtGciqWnfhn7Mp5nCeV6hK0hm8BBcHv349xrjXTpZ
 oFTrKhr2gEI4N6i+mndWV/51QR8cOx+p/cQBWNJUqlzFQqRCNKDyytvJNuKeLXd2VElr4ai3l
 LXt+/1DS98T6CSXZXk7C/OatjD8C2NmT2pdzxLL+rL6wapSmB/4ih2iDn62+E468tMQptUCjK
 ep6Wp4Eu10HhqLB9J6hOa3cIoAJkqMKUZgoQ8v5SERG9v05T7ejt8YJml8Bv+0H5G/mEPbW3u
 O1apsKWpbKlITGt4Nzzb2onPou4P5wvSQr34iyv7S/8ke3sIlxGlTC2taNtHIkTgAb3yj6Qq/
 us/q9EbDItry7ZkKaMrUJyCuVe5ilu

On Mon, 2024-12-02 at 11:24 -0500, Phil Auld wrote:
> On Sat, Nov 23, 2024 at 09:44:40AM +0100 Mike Galbraith wrote:
>
>
> > Question: did wiping off the evil leave any meaningful goodness behind=
?
>
> Is that for this patch?

Yeah.  Trying it on my box with your write command line didn't improve
the confidence level either.  My box has one CPU handling IRQs and
waking pinned workers to service 8 fio instances.  Patch was useless
for that.

	-Mike



