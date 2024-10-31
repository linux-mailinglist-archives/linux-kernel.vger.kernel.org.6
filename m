Return-Path: <linux-kernel+bounces-390867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 860CA9B7F6E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E1D1C23126
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339FF1B07AE;
	Thu, 31 Oct 2024 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SVNi+pwm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8gIhr1Hs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6378E11CA0
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730390207; cv=none; b=mNHQuSnJ8QYDmQ/iDwH5WcCA9lNu0tOGM55QWWLlh4Ey7s2+2Gvl6tx15YuHDKyTPEmGSxtqO1XJLecmsIdX8uN3WkWaDnxtG7Yrs7wivEvr1CjP5LGuptZtGW2E4yjhcBM/KDCB/yXF9SPWK3+nFXAO3Hz4kkDOsg2Lm+DG8Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730390207; c=relaxed/simple;
	bh=KnXWc5cUHdGQsB4LosCgvpt3vJ4ggiQj57zILcpUb4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GI0kedLlvaF7I+1XRNHAuNLLDtdfcMWcg3k1NYkWi8iB/t5gwtu7s41yqkQMAVD/hfMIt6AntzCEajQK5A/Pj6mzK5RXN9lh99XWhL6CKy/WrKzCTG6mhnUF3WqJSXczjTq97m+gQNaLTCUsrGUQzqsFVdpSi8atTs0vlbCBxtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SVNi+pwm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8gIhr1Hs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 31 Oct 2024 16:56:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730390202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IO+2G+vAzlAKmBce/wSn4Wmwk3StibUx5w4IkYf98hI=;
	b=SVNi+pwmh++hd8t7MSpkcF4dWmduxt0LpZy0JkftQmXpJq8P++XmQKqw68B8FBOval6z9Z
	8W/dUF0d6Nm2BHsdE1qwqPN+9A3Dm7+ylfcy5oHwZyO9qVBZI7QkafWsU0HRZM0Merj5VM
	O+Kha0npacWG9T6bmSGfDJtDFMXG0WgDfN+Iy3/Youn+/2Fteia8Ut/O2ofYppdmN9WAgs
	g9xd1WbXOC1u1vMpG1fJ8zXNR0ICxzWO0H5Q3VuP5YbI66BVtpADfKAF64OenLuwriBcK1
	/mvTDNvFr9dIQ3id10KrEKBGzt6WRKNm1Qk8PEyGE0Tlsa8vQlb+JDDugwr5Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730390202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IO+2G+vAzlAKmBce/wSn4Wmwk3StibUx5w4IkYf98hI=;
	b=8gIhr1HszR94U2uxVLX7pzwKE3QGLa1u9aJOGGCIxG8DD6BBX30qsW4zjaRpVYNJKii1Ym
	lHwCmAa98Zk3QZAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [RFC v2 PATCH 0/4] futex: Add support task local hash maps.
Message-ID: <20241031155640.Fhtm3uFD@linutronix.de>
References: <20241028121921.1264150-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241028121921.1264150-1-bigeasy@linutronix.de>

On 2024-10-28 13:13:54 [+0100], To linux-kernel@vger.kernel.org wrote:
>                                                            Need to do
> more testing.

So there is "perf bench futex hash". On a 256 CPU NUMA box:
	perf bench futex hash -t 240 -m -s -b $hb
and hb 2 =E2=80=A6 131072 (moved the allocation to kvmalloc) I get the foll=
owing
(averaged over 3 three runs)

buckets op/sec
      2     9158.33  =20
      4    21665.66	+ ~136%
      8    44686.66	+ ~106
     16    84144.33	+ ~ 88
     32   139998.33	+ ~ 66
     64   279957.0	+ ~ 99
    128   509533.0	+ ~100
    256  1019846.0	+ ~100
    512  1634940.0	+ ~ 60
   1024  1834859.33	+ ~ 12
         1868129.33 (global hash, 65536 hash)
   2048  1912071.33	+ ~  4
   4096  1918686.66	+ ~  0
   8192  1922285.66	+ ~  0
  16384  1923017.0	+ ~  0
  32768  1923319.0	+ ~  0
  65536  1932906.0	+ ~  0
 131072  2042571.33	+ ~  5

By doubling the hash size the ops/sec almost double until 256 slots.
After 2048 slots the increase is almost noise (except for the last
entry).

Pinning the bench to individual CPUs belonging to a NUMA node and
running the same test with 110 threads only (avg over 5 runs):
          ops/sec global	ops/sec local
node 0		2278572.2	2534827.4
node 1		2229838.6	2437498.8
node 0+1	2542602.4	2535749.8

<--->
RAW numbers:

futex hash table entries: 65536 (order: 10, 4194304 bytes, vmalloc hugepage)
Run summary [PID 4541]: 240 threads, each operating on 1024 [private] futex=
es for 10 secs.
Averaged 1883542 operations/sec (+- 0,28%), total secs =3D 10
Averaged 1864680 operations/sec (+- 0,31%), total secs =3D 10
Averaged 1856166 operations/sec (+- 0,32%), total secs =3D 10
1868129.3333333333
=3D=3D=3D=3D

Run summary [PID 6247]: 240 threads, hash slots: 2 each operating on 1024 [=
private] futexes for 10 secs.
Averaged 9219 operations/sec (+- 0,19%), total secs =3D 10
Averaged 9185 operations/sec (+- 0,18%), total secs =3D 10
Averaged 9071 operations/sec (+- 0,20%), total secs =3D 10
9158.333333333334

Run summary [PID 6970]: 240 threads, hash slots: 4 each operating on 1024 [=
private] futexes for 10 secs.
Averaged 16911 operations/sec (+- 0,29%), total secs =3D 10
Averaged 24145 operations/sec (+- 0,17%), total secs =3D 10
Averaged 23941 operations/sec (+- 0,17%), total secs =3D 10
21665.666666666668

Run summary [PID 7693]: 240 threads, hash slots: 8 each operating on 1024 [=
private] futexes for 10 secs.
Averaged 45376 operations/sec (+- 0,25%), total secs =3D 10
Averaged 44587 operations/sec (+- 0,17%), total secs =3D 10
Averaged 44097 operations/sec (+- 0,26%), total secs =3D 10
44686.666666666664

Run summary [PID 8416]: 240 threads, hash slots: 16 each operating on 1024 =
[private] futexes for 10 secs.
Averaged 84547 operations/sec (+- 0,25%), total secs =3D 10
Averaged 84672 operations/sec (+- 0,18%), total secs =3D 10
Averaged 83214 operations/sec (+- 0,26%), total secs =3D 10
84144.33333333333

Run summary [PID 9139]: 240 threads, hash slots: 32 each operating on 1024 =
[private] futexes for 10 secs.
Averaged 163342 operations/sec (+- 0,55%), total secs =3D 10
Averaged 127630 operations/sec (+- 0,28%), total secs =3D 10
Averaged 129023 operations/sec (+- 0,27%), total secs =3D 10
139998.33333333334

Run summary [PID 9862]: 240 threads, hash slots: 64 each operating on 1024 =
[private] futexes for 10 secs.
Averaged 279627 operations/sec (+- 0,29%), total secs =3D 10
Averaged 279572 operations/sec (+- 0,21%), total secs =3D 10
Averaged 280672 operations/sec (+- 0,26%), total secs =3D 10
279957.0

Run summary [PID 10585]: 240 threads, hash slots: 128 each operating on 102=
4 [private] futexes for 10 secs.
Averaged 508759 operations/sec (+- 0,21%), total secs =3D 10
Averaged 511253 operations/sec (+- 0,22%), total secs =3D 10
Averaged 508587 operations/sec (+- 0,26%), total secs =3D 10
509533.0

Run summary [PID 11308]: 240 threads, hash slots: 256 each operating on 102=
4 [private] futexes for 10 secs.
Averaged 1023552 operations/sec (+- 0,10%), total secs =3D 10
Averaged 1034426 operations/sec (+- 0,11%), total secs =3D 10
Averaged 1001560 operations/sec (+- 0,10%), total secs =3D 10
1019846.0

Run summary [PID 12031]: 240 threads, hash slots: 512 each operating on 102=
4 [private] futexes for 10 secs.
Averaged 1636187 operations/sec (+- 0,22%), total secs =3D 10
Averaged 1607427 operations/sec (+- 0,23%), total secs =3D 10
Averaged 1661206 operations/sec (+- 0,24%), total secs =3D 10
1634940.0

Run summary [PID 12756]: 240 threads, hash slots: 1024 each operating on 10=
24 [private] futexes for 10 secs.
Averaged 1833474 operations/sec (+- 0,24%), total secs =3D 10
Averaged 1835817 operations/sec (+- 0,24%), total secs =3D 10
Averaged 1835287 operations/sec (+- 0,25%), total secs =3D 10
1834859.3333333333

Run summary [PID 13479]: 240 threads, hash slots: 2048 each operating on 10=
24 [private] futexes for 10 secs.
Averaged 1915836 operations/sec (+- 0,29%), total secs =3D 10
Averaged 1907866 operations/sec (+- 0,28%), total secs =3D 10
Averaged 1912512 operations/sec (+- 0,29%), total secs =3D 10
1912071.3333333333

Run summary [PID 14202]: 240 threads, hash slots: 4096 each operating on 10=
24 [private] futexes for 10 secs.
Averaged 1916947 operations/sec (+- 0,27%), total secs =3D 10
Averaged 1918102 operations/sec (+- 0,28%), total secs =3D 10
Averaged 1921011 operations/sec (+- 0,29%), total secs =3D 10
1918686.6666666667

Run summary [PID 14925]: 240 threads, hash slots: 8192 each operating on 10=
24 [private] futexes for 10 secs.
Averaged 1916001 operations/sec (+- 0,27%), total secs =3D 10
Averaged 1923156 operations/sec (+- 0,27%), total secs =3D 10
Averaged 1927700 operations/sec (+- 0,27%), total secs =3D 10
1922285.6666666667

Run summary [PID 15648]: 240 threads, hash slots: 16384 each operating on 1=
024 [private] futexes for 10 secs.
Averaged 1928497 operations/sec (+- 0,28%), total secs =3D 10
Averaged 1916906 operations/sec (+- 0,27%), total secs =3D 10
Averaged 1923648 operations/sec (+- 0,26%), total secs =3D 10
1923017.0

Run summary [PID 16371]: 240 threads, hash slots: 32768 each operating on 1=
024 [private] futexes for 10 secs.
Averaged 1920425 operations/sec (+- 0,27%), total secs =3D 10
Averaged 1923449 operations/sec (+- 0,27%), total secs =3D 10
Averaged 1926083 operations/sec (+- 0,29%), total secs =3D 10
1923319.0

Run summary [PID 17094]: 240 threads, hash slots: 65536 each operating on 1=
024 [private] futexes for 10 secs.
Averaged 1927007 operations/sec (+- 0,28%), total secs =3D 10
Averaged 1935182 operations/sec (+- 0,28%), total secs =3D 10
Averaged 1936529 operations/sec (+- 0,28%), total secs =3D 10
1932906.0

Run summary [PID 17817]: 240 threads, hash slots: 131072 each operating on =
1024 [private] futexes for 10 secs.
Averaged 2033664 operations/sec (+- 0,32%), total secs =3D 10
Averaged 2060081 operations/sec (+- 0,33%), total secs =3D 10
Averaged 2033969 operations/sec (+- 0,32%), total secs =3D 10
2042571.3333333333

----

bigeasy@z3:~$ taskset -pc $$; ./run-numa.sh
pid 7679's current affinity list: 64-127,192-255
=3D=3D=3D=3D
# Running 'futex/hash' benchmark:
Run summary [PID 23094]: 110 threads, hash slots: -65536 each operating on =
1024 [private] futexes for 10 secs.

Averaged 2180419 operations/sec (+- 0,77%), total secs =3D 10
# Running 'futex/hash' benchmark:
Run summary [PID 23205]: 110 threads, hash slots: -65536 each operating on =
1024 [private] futexes for 10 secs.

Averaged 2258612 operations/sec (+- 0,87%), total secs =3D 10
# Running 'futex/hash' benchmark:
Run summary [PID 23317]: 110 threads, hash slots: -65536 each operating on =
1024 [private] futexes for 10 secs.

Averaged 2245819 operations/sec (+- 0,80%), total secs =3D 10
# Running 'futex/hash' benchmark:
Run summary [PID 23428]: 110 threads, hash slots: -65536 each operating on =
1024 [private] futexes for 10 secs.

Averaged 2231469 operations/sec (+- 0,81%), total secs =3D 10
# Running 'futex/hash' benchmark:
Run summary [PID 23539]: 110 threads, hash slots: -65536 each operating on =
1024 [private] futexes for 10 secs.

Averaged 2232874 operations/sec (+- 0,78%), total secs =3D 10
=3D=3D=3D=3D
# Running 'futex/hash' benchmark:
Run summary [PID 23650]: 110 threads, hash slots: 65536 each operating on 1=
024 [private] futexes for 10 secs.

Averaged 2469636 operations/sec (+- 0,92%), total secs =3D 10
# Running 'futex/hash' benchmark:
Run summary [PID 23761]: 110 threads, hash slots: 65536 each operating on 1=
024 [private] futexes for 10 secs.

Averaged 2432942 operations/sec (+- 0,91%), total secs =3D 10
# Running 'futex/hash' benchmark:
Run summary [PID 23872]: 110 threads, hash slots: 65536 each operating on 1=
024 [private] futexes for 10 secs.

Averaged 2411433 operations/sec (+- 0,90%), total secs =3D 10
# Running 'futex/hash' benchmark:
Run summary [PID 23983]: 110 threads, hash slots: 65536 each operating on 1=
024 [private] futexes for 10 secs.

Averaged 2438380 operations/sec (+- 0,94%), total secs =3D 10
# Running 'futex/hash' benchmark:
Run summary [PID 24094]: 110 threads, hash slots: 65536 each operating on 1=
024 [private] futexes for 10 secs.

Averaged 2435103 operations/sec (+- 0,94%), total secs =3D 10
=3D=3D=3D=3D
bigeasy@z3:~$ taskset -pc $$; ./run-numa.sh
pid 9731's current affinity list: 0-63,128-191
=3D=3D=3D=3D
# Running 'futex/hash' benchmark:
Run summary [PID 24207]: 110 threads, hash slots: -65536 each operating on =
1024 [private] futexes for 10 secs.

Averaged 2206612 operations/sec (+- 0,75%), total secs =3D 10
# Running 'futex/hash' benchmark:
Run summary [PID 24318]: 110 threads, hash slots: -65536 each operating on =
1024 [private] futexes for 10 secs.

Averaged 2321819 operations/sec (+- 0,85%), total secs =3D 10
# Running 'futex/hash' benchmark:
Run summary [PID 24429]: 110 threads, hash slots: -65536 each operating on =
1024 [private] futexes for 10 secs.

Averaged 2238386 operations/sec (+- 0,77%), total secs =3D 10
# Running 'futex/hash' benchmark:
Run summary [PID 24541]: 110 threads, hash slots: -65536 each operating on =
1024 [private] futexes for 10 secs.

Averaged 2325869 operations/sec (+- 0,85%), total secs =3D 10
# Running 'futex/hash' benchmark:
Run summary [PID 24652]: 110 threads, hash slots: -65536 each operating on =
1024 [private] futexes for 10 secs.

Averaged 2300175 operations/sec (+- 0,82%), total secs =3D 10
=3D=3D=3D=3D
# Running 'futex/hash' benchmark:
Run summary [PID 24763]: 110 threads, hash slots: 65536 each operating on 1=
024 [private] futexes for 10 secs.

Averaged 2530561 operations/sec (+- 0,96%), total secs =3D 10
# Running 'futex/hash' benchmark:
Run summary [PID 24874]: 110 threads, hash slots: 65536 each operating on 1=
024 [private] futexes for 10 secs.

Averaged 2573315 operations/sec (+- 1,03%), total secs =3D 10
# Running 'futex/hash' benchmark:
Run summary [PID 24985]: 110 threads, hash slots: 65536 each operating on 1=
024 [private] futexes for 10 secs.

Averaged 2517479 operations/sec (+- 0,99%), total secs =3D 10
# Running 'futex/hash' benchmark:
Run summary [PID 25096]: 110 threads, hash slots: 65536 each operating on 1=
024 [private] futexes for 10 secs.

Averaged 2554631 operations/sec (+- 1,01%), total secs =3D 10
# Running 'futex/hash' benchmark:
Run summary [PID 25207]: 110 threads, hash slots: 65536 each operating on 1=
024 [private] futexes for 10 secs.

Averaged 2498151 operations/sec (+- 0,94%), total secs =3D 10
=3D=3D=3D=3D
bigeasy@z3:~$ taskset -pc $$; ./run-numa.sh
pid 10975's current affinity list: 0-255
=3D=3D=3D=3D
# Running 'futex/hash' benchmark:
Run summary [PID 25324]: 110 threads, hash slots: -65536 each operating on =
1024 [private] futexes for 10 secs.

Averaged 2561817 operations/sec (+- 0,14%), total secs =3D 10
# Running 'futex/hash' benchmark:
Run summary [PID 25435]: 110 threads, hash slots: -65536 each operating on =
1024 [private] futexes for 10 secs.

Averaged 2539522 operations/sec (+- 0,11%), total secs =3D 10
# Running 'futex/hash' benchmark:
Run summary [PID 25546]: 110 threads, hash slots: -65536 each operating on =
1024 [private] futexes for 10 secs.

Averaged 2532349 operations/sec (+- 0,11%), total secs =3D 10
# Running 'futex/hash' benchmark:
Run summary [PID 25657]: 110 threads, hash slots: -65536 each operating on =
1024 [private] futexes for 10 secs.

Averaged 2539481 operations/sec (+- 0,11%), total secs =3D 10
# Running 'futex/hash' benchmark:
Run summary [PID 25768]: 110 threads, hash slots: -65536 each operating on =
1024 [private] futexes for 10 secs.

Averaged 2539843 operations/sec (+- 0,13%), total secs =3D 10
=3D=3D=3D=3D
# Running 'futex/hash' benchmark:
Run summary [PID 25879]: 110 threads, hash slots: 65536 each operating on 1=
024 [private] futexes for 10 secs.

Averaged 2540858 operations/sec (+- 0,50%), total secs =3D 10
# Running 'futex/hash' benchmark:
Run summary [PID 25990]: 110 threads, hash slots: 65536 each operating on 1=
024 [private] futexes for 10 secs.

Averaged 2550342 operations/sec (+- 0,48%), total secs =3D 10
# Running 'futex/hash' benchmark:
Run summary [PID 26101]: 110 threads, hash slots: 65536 each operating on 1=
024 [private] futexes for 10 secs.

Averaged 2522785 operations/sec (+- 0,48%), total secs =3D 10
# Running 'futex/hash' benchmark:
Run summary [PID 26212]: 110 threads, hash slots: 65536 each operating on 1=
024 [private] futexes for 10 secs.

Averaged 2528686 operations/sec (+- 0,49%), total secs =3D 10
# Running 'futex/hash' benchmark:
Run summary [PID 26323]: 110 threads, hash slots: 65536 each operating on 1=
024 [private] futexes for 10 secs.

Averaged 2536078 operations/sec (+- 0,48%), total secs =3D 10
=3D=3D=3D=3D

Sebastian

