Return-Path: <linux-kernel+bounces-243733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 657259299C3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 22:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62951F213EB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 20:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC12143AC3;
	Sun,  7 Jul 2024 20:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WS2l3vHf"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D18355C29
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 20:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720385871; cv=none; b=cBXwTcgvU+LOfOJTbpMfm3HG5nXPnQ+SlufSSjhriLsiWzqrS4jO/lz0iHPeuQVORnrSHQY7to8p6JBg97D/xcJwt6kYIeyOALO7dN0UqqwYTSW0CoMXNru+w6dWSAXWiG06dcFtRPuO/pZ1tZNyp3DdzuGbQE7PTU0As3lVYqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720385871; c=relaxed/simple;
	bh=1EpURj7eKctL0k8goe0TWYUri6wGvwSx78f7ule8K10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o6MmgtUE4nhYKpznT1AuJ9jF6hqhKt0pRyCaP2iOTXOef6EHv8EGrGcw9jrPk8oY6RXuZKVJRQeBKMg1DGZhrGbQvcx5ZQV+EbKoMvhUfwtKhMSrciMAeZIivxSSbaK0dk70PkpUNFXmz/RGCxySMxcXByryjXsv0B6QKMl3PG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WS2l3vHf; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b5da2730efso21108306d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 13:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720385868; x=1720990668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pmidXgihv1jjKguPN7S7rCVXUq02hBfkbSjdBG/f3vo=;
        b=WS2l3vHfFu0/RgYBJrJg7eB6DaqQf/uV2V+9/8ZlJwaYFgdNUfUd5qBDxlJnBrNVp+
         LGWVMG3mQS5LYVvQVTfzjIefUcFA+6ikXudu6FEXd5PHUYY27BD/8DdYJx/0qJKHOf2b
         V8ZCdvPNfhtnoqCn6moJ8GKUTdinz/xYA9itGnQ83eKpRxbuk/OZta7KZFjBedEW3pVl
         YKOY4AltOFPfUUemWuV1LI6idmQSeZARlDfeUBPucdmwjKhSAjVUmQmgyQ30HaDrnmNA
         tyFTV/M4h+dITiLho3LCTWAVS7x2aMiS6B7W/3Y0KpH6yG3SKuLC2/FzkXEYXIAzOz4J
         WWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720385868; x=1720990668;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmidXgihv1jjKguPN7S7rCVXUq02hBfkbSjdBG/f3vo=;
        b=WNrRtZ8RBwlcuNXj1EaH+kCS1vaYjSIlpw3RxhwOHnOCfOYwd3qQNYNq5szxm2amgK
         /CNKTpTTHtAk3Vq5oI5i0jpItDSFjCnrS60/qkfF08k/cVXImBmAwpmEjkOYXastsEim
         y5FTXy/pTpSEywsfJyGNlEFm45+doWVJDzY009lWKv4lezSO4Mcxggk41bWIZbH7TyKu
         e41E8HhtyNBFKw86OvMEZoMv+UJ6WNgsbsobCZ/qfgsYOxIwAqT0yBBZ30udh170svM7
         DVnN4sPXlmA/JaFAxmH6hCjuFRKL+mdDxrrMhFHjR9P7hYEX7/yO6VUw/Cm+dXgszfB7
         u82g==
X-Forwarded-Encrypted: i=1; AJvYcCXKI0xiiKO0CBelIkSCvSYX+ovZ6JwdMK6imF2lPSH0q3Fm24K9PZePKACR4EC+rIF3PkP9GfoZYC54QTzH6SY0WqeeMjWr9TsELn8m
X-Gm-Message-State: AOJu0YxmGvvvmrnzkq2CgQjsGQmccMfHJ2lGlDpD4SeApmspMzvLehg3
	3ndQE0nLfxvKG3k1Ho4arjmDxzQtGDSvSeZKvWlMUWNbRFHAYYgJKppJjFtu1o4=
X-Google-Smtp-Source: AGHT+IFt0GV3SqYWzURRJo3rZopPB7sj8oee+kKDucgUe+a4EoidCcT7G9pZ3xLzUFRqY7eKGrw7iQ==
X-Received: by 2002:a05:6214:d6d:b0:6b2:da7e:5cb7 with SMTP id 6a1803df08f44-6b5ecf8eef1mr138919816d6.5.1720385868238;
        Sun, 07 Jul 2024 13:57:48 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c2:7751:d024:65a5:58de:cd2e? ([2804:1b3:a7c2:7751:d024:65a5:58de:cd2e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b0d368d7csm5054543b3a.49.2024.07.07.13.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 13:57:47 -0700 (PDT)
Message-ID: <36c5b88a-fcc0-41b4-8638-964e13edb0b0@linaro.org>
Date: Sun, 7 Jul 2024 17:57:42 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: deconflicting new syscall numbers for 6.11
To: Florian Weimer <fweimer@redhat.com>, Zack Weinberg <zack@owlfolio.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, jolsa@kernel.org,
 mhiramat@kernel.org, cgzones@googlemail.com, brauner@kernel.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 =?UTF-8?Q?Cristian_Rodr=C3=ADguez?= <cristian@rodriguez.im>,
 Wilco Dijkstra <Wilco.Dijkstra@arm.com>
References: <ZobXdDCYBi8OM-Fo@zx2c4.com>
 <CAHk-=wiGk+1eNy4Vk6QsEgM=Ru3jE40qrDwgq_CSKgqwLgMdRg@mail.gmail.com>
 <ZoiaWz9mG9rb0QND@localhost.localdomain>
 <87sewmzvn1.fsf@oldenburg.str.redhat.com>
 <a9724690-98f4-4ddb-841d-fcc9150e54c7@app.fastmail.com>
 <875xtibksl.fsf@oldenburg.str.redhat.com>
Content-Language: en-US
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <875xtibksl.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06/07/24 12:30, Florian Weimer wrote:
> * Zack Weinberg:
> 
>> Without commenting on the rest of this...
>>
>> On Sat, Jul 6, 2024, at 6:01 AM, Florian Weimer wrote:
>>> The arc4random implementation in glibc was never intended to displace
>>> randomness generation for cryptographic purposes.
>>
>> ...arc4random on the BSDs (particularly on OpenBSD) *is* intended to be
>> suitable for cryptographic purposes, and, simultaneously, intended to be
>> fast enough that user space programs should never hesitate to use it.
>> Therefore, Linux+glibc needs to be prepared for user space programs to
>> use it that way -- expecting both speed and cryptographic strength --
>> or else we shouldn't have added it at all.
> 
> None of the major cryptographic libraries (OpenSSL, NSS, nettle,
> libgcrypt, OpenJDK, Go, GNUTLS) use arc4random in their upstream
> version.  If the BSDs use arc4random rather than the bundled generators,F
> they must have downstream-only patches.  I also don't see why someone
> writing a new library from scratch would use arc4random because its
> addition to glibc is still quite recent, and it provides no performance
> advantage over going to the kernel interfaces directly.

The BSD seems to use use it extensively, specially in the base system for
tools like smtpd/relayd/etc. as alternative to rand/random and to avoid 
pulling a RNG from cryptographic library. But I agree that for glibc, 
arc4random being just a shim over getrandom is only helpful as a way to
avoid a biased implementation of arc4random_uniform (which is quite 
common if you check on the internet about it...).

Also, this vDSO proposal and they way the now is up to kernel to manage
the RNG state would adds some extra considerations for libc getrandom 
implementation.  The libc symbol now is fully async-signal and thread-safe
due being just a syscall wrapper, and to sane manage the way the vDSO 
buffer is designed (either by vgetrandom_alloc or mmap), the runtime 
will need a way to allocate and manage this threads states with a block 
allocator (assuming runtime would like to keep a per-thread state).

For arc4random, the libbsd way or the old way glibc used to do (prior
Jason refactor), would be simple because it was never intended to be
async-signal.  But for getrandom it would require to either have a
async-signal-safe malloc implementation (to keep track of the extra
states) or a block allocation over mmap (which adds some extra memory 
usage). So getrandom now will potentially uses 2 more pages, which is 
not the end of world since interface is designed to allow failure, but 
it is something to consider.

