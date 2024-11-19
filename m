Return-Path: <linux-kernel+bounces-414244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D599D2529
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D241F23ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122441CBEA9;
	Tue, 19 Nov 2024 11:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="iLAPfKp7"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2081CB32B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732017119; cv=none; b=D9DM/1qaAoo3FaYc84DpjbwLHEixgfhbxV6rod1fhDGegCOoth4SRxcHm2f8spGqdF8uAYTLQvxaJtL58hDhj7hj6SndPgjY1YuaejE8d9BEAW9V0buV3Ika6b0mj5nvuxawVgmiSUw91wBcKwgrPbAM7ffqP4v0vtW0yliL5XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732017119; c=relaxed/simple;
	bh=3Dh4bOrE/Er1w/SGOef0TIt6NWRzUzYdbL8NnBlQSio=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=famCbhE5ZyE4kji+fS20LqfF817qxiiFMS7/Cpl7H/sc0wiWOPUin+6wnQB9nAaSuALHe5gd6i0FtHgwBAdU+ZgzK0L1TVmD4YB5HCsqCSlRdddYhW5CrROtjCXa3HFCB673OMIj79zzmoN95XKh16vHZqCuQ9jNml/sBPDRiLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=iLAPfKp7; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732017073; x=1732621873; i=efault@gmx.de;
	bh=hN+TcjYGIr/qU8EZpP2DC8LWRpwz+eJlqA0L8VkJOZk=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iLAPfKp7QZlFeV8UAHBwnsEWKJb+UstLbWOywbSg/X6wodJVFmnOKKGnDo0PY6dA
	 nN6cNeclFuQh9knqQAkJK6PbIMYERGrHZk7ur5vAjCsxBRWT1VOsYvdTZr1DTj1f2
	 PMm/7mdMuaY8xMep7w+m9aEv45BBrfUI82/1aw8QgfSMkgKxDMFm6919AME++U4gW
	 zzw2QFC64JTnwOTjaJM/To8G8ufr7+O5oEexVlKVCkrG3E5ZlhMX6lML6uq+H6GUs
	 tqvrHHr3U4YNKYn0Gw4VpqA0skyzIhWITokzUCylNdpfgTmZvyDyos4RpvyWfCy30
	 w6gCDiZxO/DqrgHUrg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.176]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfpSl-1tgLii272H-00k79Y; Tue, 19
 Nov 2024 12:51:13 +0100
Message-ID: <bede25619ef6767bcd38546e236d35b7dadd8bd4.camel@gmx.de>
Subject: Re: [PATCH] sched/fair: Dequeue sched_delayed tasks when waking to
 a busy CPU
From: Mike Galbraith <efault@gmx.de>
To: Phil Auld <pauld@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,  rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com,  linux-kernel@vger.kernel.org,
 kprateek.nayak@amd.com, wuyun.abel@bytedance.com, 
 youssefesmat@chromium.org, tglx@linutronix.de
Date: Tue, 19 Nov 2024 12:51:11 +0100
In-Reply-To: <20241119113016.GB66918@pauld.westford.csb>
References: <5280774bce7343c43904ae3df4403942092f5562.camel@gmx.de>
	 <20241107140945.GA34695@noisy.programming.kicks-ass.net>
	 <750542452c4f852831e601e1b8de40df4b108d9a.camel@gmx.de>
	 <5a4cb3e4ab698fe2d8419e28d61e292dcd0c8fad.camel@gmx.de>
	 <20241112124117.GA336451@pauld.westford.csb>
	 <0befc9ed8979594d790a8d4fe7ff5c5534c61c3c.camel@gmx.de>
	 <20241112154140.GC336451@pauld.westford.csb>
	 <81de2f710d8922a47364632335ff5ba1a45625b3.camel@gmx.de>
	 <95ff75cacab4720bbbecd54e881bb94d97087b45.camel@gmx.de>
	 <20241114112854.GA471026@pauld.westford.csb>
	 <20241119113016.GB66918@pauld.westford.csb>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f/r1rb3NmJ/uJpYC3SuivMtiJht5tqMGrqBnbOskDcFE7hnDL0j
 wTCZ4+97zfo621Jll2iiL+mF9WG9gHOhsEPw08PHS28OSCEbg0pF1jVdUPmPmiK/7pURx8q
 oFOc/yTmkCbJ5v6h3j2ATfknUQaJ4oh/fhq3ut3vICcXmHGCukwrqPYrpzRq+3SahAAQrnF
 QUtU7osh/taCQtJTGf9PA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6jRpUcu8PEQ=;GaMYL2F4DhO81stnFZqgn2D4UGr
 gVbYkfP60qhQcA/liupxPxfwrToMWdo75YwlQ8zrNN/If9tsfpzQiRo9MGEytLy53VfV2BhQT
 dFgijDpg/dLCJEQlExTTs8OdpC/x+HRniJ4TlDgeEcn6B4r1MuWcKZ5ZmaJD58dzQc4hpoI7r
 C1yS7MLD+/rbWsaQwmcK1tT78tbHvCSOm2i3u3nEpBKSNYZZ1zR+G/2W4IVQYk1FZ58ee/DIH
 UMW5dEHXDL1My4c0KAwoRTttZbYSTgE//KxJs+PmeblaCgOWy+QCGdN5/WxVOM+VC+WsMDGDO
 lSC9sI4dTrUG92EvRPXqLOQMgJG6f0eC9/OKnsd2WLeJTzwVXY6Kgz/sigy5sfc7HT7hE4vqQ
 1S99TUZ5T4GpTp2dBwk/BpJyQF+Vvhe8q1N7Hqbd1P04LOCAaPIHcls9lOaoA399/hE6fs/yS
 N49ajOzcl8QaNhDJknUKVUeKSQh2CqrCm5kpQ4ipDatez9kOZUimvVa+s6q3KzLEaEUOT/ivz
 aW6v+gEBqJPhDXS4UPn04ykZJEG64Sgg8s0zs+mtXfy2ZRG1ItqcxxuOw3EGXPfHj3HdFm6sk
 iNszF7V0RttjFysTp2XBJ9iWJaOcjzSA04ye1I7s1DUAHw+1X8SB8hOUFWEr3Qe6x+t+B//dv
 nQsN78r/MTTiLqGcIVPwVzKVT2+jJiy/mR7QVJiBYNNwrZbbT0YOKLtAtiSB5ywkrU7cJeDDk
 www1jClFPqJ0koT2CIwzQO+bJ47r9VKfB+cO3l2JqD2Ql8+oKk1ju9rzPSmHGsMCUojnt7W3j
 Be0QsqCO4V0hEATLlDrv/jZyjHWjgaoi8GH0zc7izLJuJX5Cc5H3YbekgTrc0ZNEiSqKjNlyl
 TDknOCX6OZBhUwGjf0WLEkkm5gKXHjCNwvbSkbKUuW37mWCOY0TkX51R2

On Tue, 2024-11-19 at 06:30 -0500, Phil Auld wrote:
>
> This, below, by itself, did not do help and caused a small slowdown on s=
ome
> other tests.=C2=A0 Did this need to be on top of the wakeup change?

No, that made a mess.  The numbers said it was quite a reach, no
surprise it fell flat.

	-Mike

