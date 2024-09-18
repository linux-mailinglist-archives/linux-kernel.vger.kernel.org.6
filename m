Return-Path: <linux-kernel+bounces-332706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DE097BD6A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FDC11F24D6F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 13:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DA518B464;
	Wed, 18 Sep 2024 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QGdI/Vgl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dhWCbYBH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC03718A6BE
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726667701; cv=none; b=hLvanm4Mg7BS8BMi1ytp3AByEOPrL7LWQC/Z5l20hrUzMMIngoo35LzwVCJkYwmn66zq3BA/GTT1P5aCjxND99a0ua8lGyJJNJRDfhNwvsl6ig0Unb4n9uSS0YMk1hE0FWKJoOaANO5DVRCq8ANDT9nTKr3QWMv/uoHRQNtxu+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726667701; c=relaxed/simple;
	bh=4BiH2WSnNWrVvXUzGBq4cludUNmSdM2fBU8FODDQxK4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y/zAR6hWNz9ec9J1pM5PT3/PrUkRx/RIw4uT0s4zLMwXTaewqwOHrLVw5toAh2jFWngbYMMw4cjwAdXdQf0SDHDT57gGsAMAFLQmSZSfblm8XIqY0svUZNIDdxs47DocY+k7a2Cdt6StlRxggrf/f8vkZYhzOzDQqFyVlDrXHjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QGdI/Vgl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dhWCbYBH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726667363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n+ryrZ6mh1g8NEbQJQ7CU06rybmREAahYSmXN/YU9Wg=;
	b=QGdI/VglpbjvOb6Q4iPm4bgnbd0LwW8G+3hT4bQXigfqTqhLLE/x9UouIgvHoogANcnL7V
	UpSiL0PI4kUTti9wLfsaBBw426NNuRAKPv2e/NhditRRskNRbEYQsUCjd4YLK6ZSvl+7Dp
	5G4qMx2tSunaaDvCHZxRE5kMrfHAh4fyjZOlCam05MNLAM05nLLwki/ZgyfHwHhjPy6N4H
	B5AylG5hgoDWz3CzGs3UGuQENJyXNPKqk4ojUcBMvPBwxBKlTNI0tB5SndkKOiamCggN2u
	SnHViK+LcPBNfOmT5Cb5ZY2Orzy1tRefUjevWnH9fUlH6gWd6A2a2NRjR1KQVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726667363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n+ryrZ6mh1g8NEbQJQ7CU06rybmREAahYSmXN/YU9Wg=;
	b=dhWCbYBHTefstsCNis6uTgPRVJnjDnl6oWVbkrTg2R9Y8H+J1UDwXPmv/7UL8mRrOvKXM+
	9p7DfKk8b6Cx9cAg==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [GIT pull] irq/domain for v6.12-rc1
In-Reply-To: <CAHk-=wi3MKD9_FQaKijkFLJhUmZCzat+uuswoWeG-NMemjdsVg@mail.gmail.com>
References: <172656366281.2473758.10766953231775492818.tglx@xen13>
 <CAHk-=wi3MKD9_FQaKijkFLJhUmZCzat+uuswoWeG-NMemjdsVg@mail.gmail.com>
Date: Wed, 18 Sep 2024 15:49:22 +0200
Message-ID: <87ikut138d.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 17 2024 at 15:33, Linus Torvalds wrote:
> On Tue, 17 Sept 2024 at 11:01, Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Two small updates for interrupt domains:
>>
>>   - Remove a stray '-' in the domain name
>>
>>   - Consolidate and clarify the bus token checks so they explicitely check
>>     for DOMAIN_BUS_ANY instead of unspecified checks for zero.
>
> Both of these were in my tree with other commit IDs (and both came in from you):
>
>   7b9414cb2d37 irqdomain: Remove stray '-' in the domain name
>   c0ece6449799 irqdomain: Clarify checks for bus_token
>
> so you should just drop this branch.

Clearly my scripts scanning the branches went sideways.

Sorry for the noise.

