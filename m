Return-Path: <linux-kernel+bounces-424600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A7B9DB69F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8F8616431F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0204198E6D;
	Thu, 28 Nov 2024 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="F0J4u+ST"
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC1B13A865
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732793849; cv=none; b=DjsqmUKjsTrJQx/OKoyPRKibya5BaG+PTDxQHVq+W+oL1lgEE7h6Zk2o/2YbpetKHv2vhqMuAvwvxtbGartnZTY7wulWTgXslQBmZxVGJh/hMoN64IGgoF/qyr05b5hZG6wZ/Ugydbs3eRSXAHESi3R0m/jg/MBQuRmt4kHbykM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732793849; c=relaxed/simple;
	bh=Bk/q63YNO6vk8LPeNc5DF66JpN9+NjvjCiTy37BBpPw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rhCr6jWMAGC41u7Uiv9MeFjLKXGphe/5QVeHn1yZn6Smtqp5uSKNhlE9jAHusJXR1ed4krApIS71E3dnV63I9rL8dmHDnrBCrLrNHjC3C84s+NjO1y+L9pvbTYUVGt3Na63ZzX7XSNeHTHoHYpwMErY5w4m2dIM7pJPkCZtQJV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=F0J4u+ST; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Bk/q63YNO6vk8LPeNc5DF66JpN9+NjvjCiTy37BBpPw=; b=F0J4u+STQ1D9wRJ4krNs3k2YoU
	s9oNNu73dHBvRa7VW1jZzndMjMD7d3JTYhAqPvVRyBzl6MPI4vKktWjyfrYywKDW3CejxAJfAeCmR
	dIT+V0nLD+A70oiZUsLY/oGMmVLruoNjm4hJdDICAJOC4l/6HiYkXWqDDdWkIkdNs3xPcn3bIfka2
	dzy7lp3CedwBk9+LtfE9NpylMRPsBpAFXOQ1/9ZI0OQdZDRqjw9WTZXCVLhUBk2Ped89d/UNp+sC+
	ffJ6d1M0ripYwx8DPpubAiLsy1NAS8jZwLbBb42sdIGi8tEuO0uNVvyk+nGgmTSvSOlfFEjmzeE9p
	bshqGjEg==;
Received: from [167.98.27.226] (helo=[10.35.5.98])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1tGcpe-00CMKL-1f; Thu, 28 Nov 2024 11:37:14 +0000
Message-ID: <4052c4e7ed0e02d11c2219915b08928677c88ab8.camel@codethink.co.uk>
Subject: Re: [REGRESSION] Re: [PATCH 00/24] Complete EEVDF
From: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, 	vschneid@redhat.com, linux-kernel@vger.kernel.org,
 kprateek.nayak@amd.com, 	wuyun.abel@bytedance.com,
 youssefesmat@chromium.org, tglx@linutronix.de, 	efault@gmx.de
Date: Thu, 28 Nov 2024 12:37:14 +0100
In-Reply-To: <20241128105817.GC35539@noisy.programming.kicks-ass.net>
References: <20240727102732.960974693@infradead.org>
	 <16f96a109bec0b5849793c8fb90bd6b63a2eb62f.camel@codethink.co.uk>
	 <20241128105817.GC35539@noisy.programming.kicks-ass.net>
Organization: Codethink
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: marcel.ziswiler@codethink.co.uk

On Thu, 2024-11-28 at 11:58 +0100, Peter Zijlstra wrote:
> On Thu, Nov 28, 2024 at 11:32:10AM +0100, Marcel Ziswiler wrote:
>=20
> > Resulting in the following crash dump (this is running v6.12.1):

[snip]

> > It looks like it is trying to enqueue an already queued deadline task. =
Full serial console log available
> > [1].
>=20
> Right, I've had a number of these reports, but so far we've not yet
> managed to figure out how it's all happening.
>=20
> > We are running the exact same scheduler stress test both on Intel NUCs
> > as well as RADXA ROCK 5B board farms.=C2=A0 While so far we have not se=
en
> > this on amd64 it crashes consistently/reproducible on aarch64.
>=20
> Oooh, that's something. So far the few reports have not been (easily)
> reproducible. If this is readily reproducible on arm64 that would
> help a lot. Juri, do you have access to an arm64 test box?

As mentioned above, so far our scheduler stress test is not yet open source=
 but Codethink is eager to share
anything which helps in resolving this.

> A very long shot:
>=20
> =C2=A0https://lkml.kernel.org/r/20241127063740.8278-1-juri.lelli@redhat.c=
om
>=20
> doesn't help, does it?

No, still the same with this on top of today's -next.

Thanks!

Cheers

Marcel

