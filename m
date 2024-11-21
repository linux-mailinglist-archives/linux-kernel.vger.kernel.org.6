Return-Path: <linux-kernel+bounces-417328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 855269D529A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44298281D33
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97401AAE1B;
	Thu, 21 Nov 2024 18:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="riv6zpD6"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE83B67F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732214116; cv=none; b=mMNORBuJnuljba0QKo44V3vEFK0rWimnE554la8qz+m9x+2R+ecv9U2TIon3ZYrWxpDnoZrvbuTod6FWBqqylin+MP24D2p6dPcN6Syi+1px6WCzZtB1FT7J8vWvXmFPo76Em0DKkXR7eAdPfT0eb2VlsVZlUu6J9A5nPQIMSto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732214116; c=relaxed/simple;
	bh=sxEt5QHQVWebuJzi/ZocdkWCv5jV6t5UCOUoxd5WEPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/t7yYo6q09wX/A3+9sL1CFk2vAlFFrxiq3SIUzf4GNaE7neyekGuYFjOyIVxjQR+CVjy5C0Cr+NdX6//Q6TNUVP/UG0PUnQeGHCoMjmgZ3cQyx3O2jQXql75WEzWval+m/ksyAthrkLA5wmjk98cQdX5Aw9nqsyS6TJPzwX1D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=riv6zpD6; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-296c237a121so843081fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732214113; x=1732818913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mbqhQuLd+DrrA6T8L2Ps3K6JSpl7CQfQrjhLlkd4Ce8=;
        b=riv6zpD6gKoahr9CvmQFTmST+QAMwSYFLMwaQsEgTVOGBMNidnBQMiPwwp0yJDBzSw
         Z9AI7AtV7wV3TO6Z9iYwlNVHhth2gkvTHr/wmDzQTM5Jv0Ge2Qc23S3YG4BjXCeNLbNI
         5g/h8/lF7ZhQ1vxYAAJWNcLELLfgupR8idnFSKZBm8NRE0p2Mh4CcKXFriWORjbeG8kZ
         Fs4d/Qo54oWRxwZyb1a3bnQucfc9q19ThmnzMjb6R3Qd9ObuhMixUAje/zbHfX0+cFSC
         PnTVQ9LG6qhIV1U27+vJGGpV/4o5kP2Qq6DqeosRpMQikmZewa45q5SHGcPHU+Dz5Bnb
         dyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732214113; x=1732818913;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mbqhQuLd+DrrA6T8L2Ps3K6JSpl7CQfQrjhLlkd4Ce8=;
        b=EHso4UgcxlQKKvptbJ5izE2y9TKY08grqFw3G/WsZbevAs5vrBsyTpMThd/NZ3U0x+
         /wzIHrfnqePfLEZjsxapmy/7ImoQ+xH8aOYwuiOHUjOliVbAihMm2AFLbaEuFCqZD1Rv
         q2uIWM33Sh5kvTFWXrywVCvUxPQrP1Z3ykTtrPnb4yAKXiUvHsB5m8eNf4WuM59qbJfG
         GA5o0tVAY2DFM1hefM2IDDk7F+KdiHwR8AIclV6jfZAFD2RcQ1vor21dGuCGriGA+6uy
         cKG1Vq8ZooCVex5xOn1PbjA+d51zsW1+2TtSjXoWRT+ALBayiWWJTbnkqFq3EQTm38k8
         vOdg==
X-Forwarded-Encrypted: i=1; AJvYcCWHO1LEB3u0B7FpQXtw2R1qIpePb2YIFcqs1P80qXKQo8XcjrLgeIx78l/mqHvD4pqPpjQiPf/W29KTE3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiYYbaaAxnYTE427siYei/UmuTSIbR9XObHpzDMICr84picO1W
	vQ97FUw2C4rrrJi5PYplfX3jWCZnlr/NElgKJdQhBMtluprUFSl2fk9NusT4W2o=
X-Gm-Gg: ASbGnctPrxsv2Evyscdj4CgyQ19oaBiYhNpm+omPIOaiASQ/I3tg/NYCvOAoEq+FHv9
	CGonUP4O27618oP69D5Jp1zIfQohkLYMcv2pts5MhZlSkq1g4shKvvCRu7ucu6BYjFzrr9HLnHD
	M/TnjzNiTVuPJDOIxaY/VewALgSrRNivRo3nLGapeYL1UU2bnavJKJIOSCZsb4+0+Nh1jwcOx15
	dABtD7i6GgDj9SWVoH5PdsqaUtvWopbAi79yNUQkLM06A==
X-Google-Smtp-Source: AGHT+IGQ9k8wS2TS60qT8IVjc3fnuFCoLgHqv0GNMp58Q1HLV2LNWsVqKRLFgpF9Cw9p6ZAQqUdenA==
X-Received: by 2002:a05:6870:9619:b0:296:b0d8:9025 with SMTP id 586e51a60fabf-296d9bcedd8mr8467428fac.20.1732214113009;
        Thu, 21 Nov 2024 10:35:13 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2971d87e96dsm52987fac.45.2024.11.21.10.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 10:35:12 -0800 (PST)
Message-ID: <3fe55eba-1a8c-464f-8598-6068ce03f296@kernel.dk>
Date: Thu, 21 Nov 2024 11:35:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slab: Fix too strict alignment check in create_cache()
To: Guenter Roeck <linux@roeck-us.net>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Vlastimil Babka <vbabka@suse.cz>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Mike Rapoport <rppt@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>,
 Jann Horn <jannh@google.com>, linux-mm@kvack.org, io-uring@vger.kernel.org,
 linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
References: <80c767a5d5927c099aea5178fbf2c897b459fa90.1732106544.git.geert@linux-m68k.org>
 <4f70f8d3-4ba5-43dc-af1c-f8e207d27e9f@suse.cz>
 <2e704ffc-2e79-27f7-159e-8fe167d5a450@gentwo.org>
 <CAMuHMdWQisrjqaPPd0xLgtSAxRwnxCPdsqnWSncMiPYLnre2MA@mail.gmail.com>
 <693a6243-b2bd-7f2b-2b69-c7e2308d0f58@gentwo.org>
 <f602e322-af21-4bb3-86d4-52795a581354@roeck-us.net>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <f602e322-af21-4bb3-86d4-52795a581354@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/24 11:30 AM, Guenter Roeck wrote:
> On Thu, Nov 21, 2024 at 09:23:28AM -0800, Christoph Lameter (Ampere) wrote:
>> On Thu, 21 Nov 2024, Geert Uytterhoeven wrote:
>>
>>> Linux has supported m68k since last century.
>>
>> Yeah I fondly remember the 80s where 68K systems were always out of reach
>> for me to have. The dream system that I never could get my hands on. The
>> creme de la creme du jour. I just had to be content with the 6800 and
>> 6502 processors. Then IBM started the sick road down the 8088, 8086
>> that led from crap to more crap. Sigh.
>>
>>> Any new such assumptions are fixed quickly (at least in the kernel).
>>> If you need a specific alignment, make sure to use __aligned and/or
>>> appropriate padding in structures.
>>> And yes, the compiler knows, and provides __alignof__.
>>>
>>>> How do you deal with torn reads/writes in such a scenario? Is this UP
>>>> only?
>>>
>>> Linux does not support (rate) SMP m68k machines.
>>
>> Ah. Ok that explains it.
>>
>> Do we really need to maintain support for a platform that has been
>> obsolete for decade and does not even support SMP?

I asked that earlier in this thread too...

> Since this keeps coming up, I think there is a much more important
> question to ask:
> 
> Do we really need to continue supporting nommu machines ? Is anyone
> but me even boot testing those ?

Getting rid of nommu would be nice for sure in terms of maintenance,
it's one of those things that pop up as a build breaking thing because
nobody is using/testing them.

I'm all for axing relics from the codebase. Doesn't mean they can't be
maintained out-of-tree, but that is where they belong imho.

-- 
Jens Axboe

