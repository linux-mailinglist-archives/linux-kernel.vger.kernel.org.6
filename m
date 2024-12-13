Return-Path: <linux-kernel+bounces-445093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 445CB9F112B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05AEE282A3E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD0A1E2843;
	Fri, 13 Dec 2024 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ZAKo/ny0"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3061E00BF;
	Fri, 13 Dec 2024 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734104475; cv=none; b=PN00EbIB80jr5UYs6eKbpVRPvopQ0KF+WzMRly8jb/6Z6spg5oCnL14mAGvBSpn0UO6OLrqQoEWLHS92OKNsJBbI1AnepohNdzLcMKtyNbQ9H2vhbPb8GkBwbo6gfydkRtP1DKu5YftbZ3ZhLJYJ6HmjDVmJ3jgkp43aIiDDIUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734104475; c=relaxed/simple;
	bh=Fyx86ZlyOPMekbEYgW+tidan7ck3xWLUNXZ/km5/+5I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JSXg7CdUkQKvO7YrkT38TXhl/MysTi+1b7nHa7Kr5KJjCchjlt0/IDa69+ZzduS4h5tg642qOnz238CjRH2q7C1wjhzhcAItKc1LzeTVo6FNBB73OLSDIYKAtzqgIx+vHNCo31w/ZKNolXTYskUWvWpTfQOhfBZ600SidgiTS9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ZAKo/ny0; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7490B403FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1734104469; bh=TgcF1Tz9pfDypsI277BHt7RQitQHZYdaYgACeg0Zt7M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZAKo/ny0JoLbrS4hSL78zNjL/1AiW2HI2bEGt3VwNPwvxXIFp+jHNg35cQLp0qF97
	 Nr8QE22mz6Vjy7iTPYOnh8m0ZAK2KCNEgUruDII5N1BECvNg0RkNAHn9AsTOrwhBUP
	 FtQU/atp2RX1MHZ0yuB410966w+1iHr+T1kEd3ntHjY0md8kiQQuUoOORpgPhwC0gl
	 dRbX+JWYgXIEQQCTRXum7toLZHdc6CvJcxQWWRcZvzsTBBDGAozWLvLMlpvUPtM3pC
	 LIkN5O2B82iETCROrkMPJCPKUBHmGkovzcURf9plWUKLYzV217zSFUI0dCf716IRe0
	 +MLGIu0KdKTVA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7490B403FA;
	Fri, 13 Dec 2024 15:41:09 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>, Michal =?utf-8?Q?Koutn=C3=BD?=
 <mkoutny@suse.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Christian Loehle <christian.loehle@arm.com>,
 Frederic Weisbecker <fweisbecker@suse.com>
Subject: Re: [PATCH] Documentation: sched/RT: Update paragraphs about RT
 bandwidth control
In-Reply-To: <20241211170052.2449581-1-mkoutny@suse.com>
References: <20241211170052.2449581-1-mkoutny@suse.com>
Date: Fri, 13 Dec 2024 08:41:08 -0700
Message-ID: <87cyhvy4iz.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Michal Koutn=C3=BD <mkoutny@suse.com> writes:

> This has slightly changed with the introduction of fair_server.
> Update the most relevant parts.
>
> Link: https://lore.kernel.org/r/Z0c8S8i3qt7SEU14@jlelli-thinkpadt14gen4.r=
emote.csb/
> Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>
> ---
>  Documentation/scheduler/sched-deadline.rst | 13 +++++++------
>  Documentation/scheduler/sched-rt-group.rst |  8 ++++----
>  2 files changed, 11 insertions(+), 10 deletions(-)

Applied, thanks.

jon

