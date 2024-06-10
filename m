Return-Path: <linux-kernel+bounces-208241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CD09022C1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 970C5B2277C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2918248B;
	Mon, 10 Jun 2024 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="YZfXVTZA"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1974F5FA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718026719; cv=none; b=hiOEkRelmB0taApplAC+gh7hKd4rFRcfYqe0n1zSYoRcmqNFKQTX8A3hlM7gXqq5cgh5iWWzU+dNaf0JC+vTuacf8gPv/uKwCVGNw0gTwvlUbh75vyP0aHS20Lvxyqv2KAe9eWjdoP0V6uMEhwok6VuEkC4i3XBly+IC6gq9kuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718026719; c=relaxed/simple;
	bh=nNiMFN3UUVyLRK8hNS+Knebs+73HcK7zuHQH11+IUf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AddwhGRmOTpnHiF7CPInXsF+FDRUZVg3ZkpH+UdoVw9go6xEz2wKMZ+AUpIvj0d34afK1fjDekBos3oOZAckBYQak/AOGUxkjg3CmiqGRw9VgK1A41qAO+ghirqyRKM0cwimJ8pDLdQViGwkA4vdjDmfzZ/tlwj0ypD6rX6L6KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=YZfXVTZA; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52c89d6b4adso1062336e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 06:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1718026716; x=1718631516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6MVOT7ev6J5lLl/iba6yrd0EhvDJDU0eNfpHSBAIuOY=;
        b=YZfXVTZAALZBsckulSZUV7g14E6MmT8NndgV0d2sZnmqeHlfdH/7H+gpxNtIH/E1gI
         GmsnAniYZlJuJZPjObXzgHCDpm2n/97HZQjJAaarmsAHVOoN/iKVTNhyjVoulTRmpCWF
         X2a8EGWQwyRDxzqkJtEzaeMmgJegKGZeBM5Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718026716; x=1718631516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6MVOT7ev6J5lLl/iba6yrd0EhvDJDU0eNfpHSBAIuOY=;
        b=c6ARL7Ep5KjD3YG2gpKSBd13HhbXl9gdSTVXViqz4THNTXmpwiNxqb6NCfukNiTeEq
         2de6eP3XnuPwBDwZBHxvYsYFheKsLQ3GeHeNQN/hfm0GSgnV5koo+hZMQPM7lDQ94YjT
         2T7k4NKCCrDi0I0QN/4muwnSAitFvvJw2vMl1v7ecoyjdg4o/RW/0e1VZIjicCftMOnv
         cvZljTdo4yz0ChnRX2bz5ISf1uzyzo5lSjFiacS1658FhX6n8mY2AnTO2/Uc5JxcPwUU
         UaOaYF+950BSm+ES4HZGqzIzy7sG8Nnz4XfVf+zsG4GQHixOQwKfHNsePA5zJ61vnNPb
         OU3A==
X-Forwarded-Encrypted: i=1; AJvYcCU3wO8qJxG/UzsF25IP3XmqSf9HCgDFNCnjFR2X5W1+yHgUu/7wALynHMRYZdlPHXlT7J5v7Z35w3GuhiJNlMC/d4vv0we8GbXMc7sZ
X-Gm-Message-State: AOJu0Ywr62iII6zkKNxkS8dtbR3iO8muhYabKNLdnSLgnAELAxZPZFKd
	kL9rZQv6NikgWt2K7Cz9Klh9FvbCGgmoiKMVJIx+1L4sWz2gFtEZwxH8WBgzWZ8=
X-Google-Smtp-Source: AGHT+IH951ow2F1ZsFqXx5A89eENuF5pKIETipiyl7d5mCQzoHtS+0ARN21s6WcTQmJex2EIY9cvBw==
X-Received: by 2002:a19:641a:0:b0:52b:797d:efd4 with SMTP id 2adb3069b0e04-52bb9f6deafmr5369729e87.16.1718026716105;
        Mon, 10 Jun 2024 06:38:36 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb41e1bd6sm1668882e87.48.2024.06.10.06.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 06:38:35 -0700 (PDT)
Message-ID: <f967d835-d26e-47af-af35-c3c79746f7d9@rasmusvillemoes.dk>
Date: Mon, 10 Jun 2024 15:38:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: add 'runtime constant' infrastructure
To: Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>
References: <20240608193504.429644-2-torvalds@linux-foundation.org>
 <20240610104352.GT8774@noisy.programming.kicks-ass.net>
Content-Language: en-US, da
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20240610104352.GT8774@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/06/2024 12.43, Peter Zijlstra wrote:
> On Sat, Jun 08, 2024 at 12:35:05PM -0700, Linus Torvalds wrote:

>> Comments?
> 
> It obviously has the constraint of never running the code before the
> corresponding runtime_const_init() has been done, otherwise things will
> go sideways in a hurry, but this also makes the whole thing a *lot*
> simpler.
> 
> The only thing I'm not sure about is it having a section per symbol,
> given how jump_label and static_call took off, this might not be
> scalable.
> 
> Yes, the approach is super simple and straight forward, but imagine
> there being like a 100 symbols soon :/
> 
> The below hackery -- it very much needs cleanup and is only compiled on
> x86_64 and does not support modules, boots for me.

As can be seen in my other reply, yes, I'm also worried about the
scalability and would like to see this applied to more stuff.

But if we do this, surely that's what scripts/sorttable is for, right?

Alternatively, if we just keep emitting to per-symbol
__runtime_const_##sym sections but collect them in one __runtime_const,
just using __runtime_const { *(SORT_BY_NAME(__runtime_const_*)) } in the
linker script should already be enough to allow that binary search to
work (with whatever : AT(ADDR() ... ) magic is also required), with no
post-processing at build or runtime required.

Rasmus


