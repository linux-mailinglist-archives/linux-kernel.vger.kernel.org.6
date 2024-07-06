Return-Path: <linux-kernel+bounces-243140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBF7929260
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 12:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 620B52829BE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 10:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4DE73176;
	Sat,  6 Jul 2024 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQNvQSmq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC0E6F2F4
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720260133; cv=none; b=DestgSvofnLK33SEgCmNMvzif9kNVTnaqmbnksRPT9eqRseJ4N3y3fajnOm6Wbdn4haV1sc/MzBNOn1xZ/G8NO8y0JFa/uLqvswwMeagakw1OgnpIIGfBOWXQFSJsPIz9Bf6UVzCrP8i00WEm/MpXRciCwEIV8YTqNWWe6qMpW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720260133; c=relaxed/simple;
	bh=H4v5aWPyuH8ogtzPr7Pb37HiaZAqzeG70v2kVeFCsKQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bjDEE9eG1XfdAO2RlDkbCmk/nw3hn/igknjLqLuUA8hBIR9d5hKyfHEhuMnFxrQRaw2JN03+geVs1zcHPWpidguN7V5YNlzjJITtCSAB5cQk1E90EmqLqY43v0LQq1e2gfkCw8qSIHINEN7oXKmB/DXjh63a+zd4HaqjcItxRI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GQNvQSmq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720260130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+yL7+Ipb2CRJAiVuN9+PK4t3/NV6AMkm+gY+mr3QzGs=;
	b=GQNvQSmqOVykLeadiZ9nHmsACfyCGjRTDwTFlECFVOmdKnbyKXXnkLPm+fk3Q0AKSqwSOH
	2zG/qsq0OfX83QcEwdUoJDb0HSQcTlR+qpsT171N4ZqHKkcUlvQjw9avTWo5H2nVv/Z+M7
	/IAWu/mOb8lVqBpiYPr6ZAd8aTMXo0Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275--zNuANeIN3-oRlGgYTbcyg-1; Sat,
 06 Jul 2024 06:02:06 -0400
X-MC-Unique: -zNuANeIN3-oRlGgYTbcyg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD42D196CDEF;
	Sat,  6 Jul 2024 10:02:03 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.45.224.38])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D2021955F3B;
	Sat,  6 Jul 2024 10:01:57 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,  "Jason A. Donenfeld"
 <Jason@zx2c4.com>,  jolsa@kernel.org,  mhiramat@kernel.org,
  cgzones@googlemail.com,  brauner@kernel.org,
  linux-kernel@vger.kernel.org,  arnd@arndb.de,  Adhemerval Zanella Netto
 <adhemerval.zanella@linaro.org>,  Zack Weinberg <zack@owlfolio.org>,
  Cristian =?utf-8?Q?Rodr=C3=ADguez?= <cristian@rodriguez.im>,  Wilco
 Dijkstra
 <Wilco.Dijkstra@arm.com>
Subject: Re: deconflicting new syscall numbers for 6.11
In-Reply-To: <ZoiaWz9mG9rb0QND@localhost.localdomain> (Mathieu Desnoyers's
	message of "Fri, 5 Jul 2024 21:14:03 -0400")
References: <ZobXdDCYBi8OM-Fo@zx2c4.com>
	<CAHk-=wiGk+1eNy4Vk6QsEgM=Ru3jE40qrDwgq_CSKgqwLgMdRg@mail.gmail.com>
	<ZoiaWz9mG9rb0QND@localhost.localdomain>
Date: Sat, 06 Jul 2024 12:01:54 +0200
Message-ID: <87sewmzvn1.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

* Mathieu Desnoyers:

> From an absolutely-not-security-expert perspective, here is how I see
> the desiderata breakdown:
>
> - There appears to be a need to make sure the random seed is not exposed
>   across fork, core dump and other similar scenarios. This can be
>   achieved by simply letting userspace use the appropriate madvise(2)
>   advices on a memory mapping created through mmap(2). I don't see why
>   there would be any need to create any RNG-centric ABI for this. If
>   new madvise(2) advices are needed, they can simply be added there.

I don't think there's consensus about protecting coredumps and VM-level
forks (migration where multiple clones continue executing).

Personally, I'm not convinced either that it's sufficient to protect
just the RNG from VM-level forks if nonce-reliant ciphers are involved.
It needs careful condiseration how these ciphers are used, and I'm not
sure that VM-level fork protection for the RNG itself is even a critical
part of that.  (The ciphers are still deterministic, and the forks will
compute the same result if the operations are ordered correctly,
resulting in no information leak.  Anyway, I don't understand why
cryptographers prefer algorithms where nonces are so critical to avoid
long-term key leaks.)

> - There appears to be interest in having a RNG faster than a system call
>   for various reasons I'm not familiar with. A vDSO appears to be one
>   way to do this. Another way would be to let userspace implement it
>   all, which raises the following question: what is the minimal state
>   known only by the kernel currently unknown from userspace ? This
>   brings the following point.

The history here is that we had a reasonable fast userspace
implementation that could deal with the process fork case (which is
quite easier within glibc).  It could not deal with VM-level forks.  The
goal was to provide something that is unpredictable in practice and
about as fast as random() (or even rand()), so that programmers could
just use arc4random() if they do not need a reproducible sequence and
not worry about performance.  We removed this implementation from glibc
and replaced it with something that makes a system call on every
arc4random call.  The promise at the time was that we'll soon get a vDSO
call to accelerate this, without the need for some sort of stream cipher
in glibc.  That hasn't happened so far.

Meanwhile, it's been reported that if chrony uses arc4random from glibc,
NTP server performance drops by 25%:

  Bug 29437 - arc4random is too slow
  <https://sourceware.org/bugzilla/show_bug.cgi?id=29437.

Obviously, we need to fix this eventually.

The arc4random implementation in glibc was never intended to displace
randomness generation for cryptographic purposes.  AndIt doesn't have
to: none of the major cryptographic libraries will give up their RNG in
favor of glibc's, so if you are doing cryptography, you already have a
RNG recommended by the cryptographers that is ready to use.  The
arc4random implementation had a different use case, replacing random()
and rand() calls, but it was somehow repurposed.

Thanks,
Florian


