Return-Path: <linux-kernel+bounces-428418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 566C09E0E13
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240D8164F7D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2781DF721;
	Mon,  2 Dec 2024 21:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zIeECHel";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7Q6qNHax"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AD54C85
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 21:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733176007; cv=none; b=VAZYyb5dwsW0HW8b1M2YTyiHyTML7ePD2AIcZZ4eyfTV9+qKVsERTHwoLAk+K6dnWWXjUcLe0D2e89mxrvc4wf/flGMc3eKWTfOIU23cpOFRaB8/E9lVVo0Qy4zxN0tnPln8JVBY4+SpYDNm+SyXou5DIqjS64VkSMrwZbBkXu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733176007; c=relaxed/simple;
	bh=yQG2Sg5703h0n3JejUEhVbUR3bprJNlHNNBXGOGFK0Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u39EDHoX4w0Enc9zPNrGGGA0LugS4nKpJXwl5c+i9Ugyal5Zbo6+EGYRXKEJLtzFYFoQtnNQwakcKUJJJqm9WHIqXZew+sInMud7o3F+y/bA95iUA/Ryz3QsdVUTv4LHy7nv2QnFrXb7FuuUvc1CPRePs2gqhwl41rROZXNJ7sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zIeECHel; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7Q6qNHax; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733176003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=35GisWaJvrtxAVImYYMcHXq2BvA4mlbmJE0+tBMsC0o=;
	b=zIeECHelud0Gc0/H9WR4EbbTdxcXqgRkl8RqKGXkgtdTNBa0NmDdlreJh3qVodRH/qUH+S
	AxZ29X46pBxMpNBnJEz1D6qLW8vZdTGgKUOPvB7/b0WYeI0UW1PkNO6L1DJxrwC+l54Fxi
	T7S1W7lhrexnl7C+26BRX9rLJ0GS5hHaTv9lx94bKKVeHw5J5TjTgro6+2t0l5hOXZHxgm
	s15Hgq13rHg9JiFEzeTDqHz4QjQh/iZogw8jvohM6sy+i22GlHFTIafWZ/+79sIthCi6K4
	KrQydIVx/HffK3FzWNOwEBSNqDJNl9t3iWPzEswWJNPXxR90MnSHuvZ+iXUHRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733176003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=35GisWaJvrtxAVImYYMcHXq2BvA4mlbmJE0+tBMsC0o=;
	b=7Q6qNHax5FnJEqsh4wgHQIa0lxyFPdjoBrQFc16FguBPsrH8IIHOxDqFQqvp8Gi+rNtszg
	h8eeMFxcp8MHbMBw==
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Richard Henderson
 <richard.henderson@linaro.org>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH] posix-timers: Fix a race with __exit_signal()
In-Reply-To: <20241202155547.8214-1-iii@linux.ibm.com>
References: <20241202155547.8214-1-iii@linux.ibm.com>
Date: Mon, 02 Dec 2024 22:46:42 +0100
Message-ID: <87frn5vjul.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Dec 02 2024 at 16:54, Ilya Leoshkevich wrote:
> If a thread exit happens simultaneously with a POSIX timer signal, this
> POSIX timer may end up being erroneously stopped. This problem may be
> reproduced with a small C program that creates a POSIX timer and
> constantly respawns threads, e.g. [1].

AFAICT this has been fixed with commit:

  63dffecfba3e ("posix-timers: Target group sigqueue to current task only if not exiting")

Are you sure, that you have this commit in your testing? It's in rc1.

Thanks,

        tglx

