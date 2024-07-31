Return-Path: <linux-kernel+bounces-269375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C76943229
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D86E280F5A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072111BC082;
	Wed, 31 Jul 2024 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMFuBQiT"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351811DDC9
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722436678; cv=none; b=qoopeUfgstMRiJP0qem8lgECrQWuuPaakDNCvXcAr4hI5T7CdlJdWJkSl2gtVjeML/CbRiEVeaAz+NTME/okzrvT2tN5iWwPv7LiGrjjc0tXgNRze38F/iJjoteDudvg442Ur92hRiIAIu125Cy+JX9dM67N2AkkRoYdtpNZV4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722436678; c=relaxed/simple;
	bh=3oEIcuqYu5PaRlL8/CiZm/Hol0j+tXZUF3ke2YSbDsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rbue081MkDCxbAaJa/QJof4kOQdp3HXWXK9JceGJa3yVTuPhMng/1z6veQoqap3PZ+9UuHtFoqvnTTIJvJzfZmjQC6yOKghKvVsNKgESrprS8Hl138+QJZUItEXePx2yYaCcgQeSeUW51lrIj/QZQTeXf8humWnIHmMIsaV9pfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMFuBQiT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc611a0f8cso41327255ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722436675; x=1723041475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6VPgNsrq1gshX5x5iwNOKKGYBvGWYfz+YJsPDb/2uA=;
        b=ZMFuBQiTshstQcPbJMCBTls+klojyvP6LxjZLsUW3pQOiGjhU1UVYOm/qdJeZW9WyB
         a3UDYr7Kv14G+TT+aA2lNGerdpZfDiQedAEeva8M6cZisNJZhAxZ0VZAx2o7x6tm/QUb
         4juSb0IHOpHJtA/p0Oil3LxyV2YRctJocGsn7KjfGkUb1xFjWRPcomqzUrox6XtdUQjk
         zyyp9U8R20UPt+VtohGVqpr8cPS7CcJidKxI5Yl5MpDBGqrI9DfWcFGX9eYvzIGvogiF
         CHa8DoYe74qIZJ2++i1MR1DSEn5m4q+0YquX3R1dAxdVJO6ZfY1Lb4cPh5cMujhlRrBT
         bVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722436675; x=1723041475;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6VPgNsrq1gshX5x5iwNOKKGYBvGWYfz+YJsPDb/2uA=;
        b=TaNaTtTK5jhCjmaFFIvg5mi4wmfI8MApz8WF1XOgTPKjrgzXsVrQlbiGtyyaeba/ZE
         fSiybcwewKi0YwncoZXilsDJEj4b0AqvEEPGG4KoJaccdFMDPwemjxZi7XQeAYCu8c88
         sfV9gBNodib8+cPuUoJz9cTy5XBRcxddpZuxtTaEQnApoW0vVTKzd0Y1tN5VN00tJQJc
         53GLL/wQGjRlqz1ZoYMEwIWY/7SYp+DOiHmvk0FVqcXF50OOosZg6UPiDVdH2aBImvQY
         NUfq7JX1HEdHGoguUUUZEPiNjv0Z8uzRxm0N9UHL9tj1rG6NGouCuA9yXJuEiwWAA/Sp
         mL6w==
X-Forwarded-Encrypted: i=1; AJvYcCVlOOa2jQB6DVjyXyFuDV8zGhLTo7dSzyyPwNR5iz7cLT42H3VjLoUbFsOo+6M0kNYRHVDMmMuKuqpJJC9VgpOoQCa46tVcE11q/v/b
X-Gm-Message-State: AOJu0Yz23vrQNgIHqtwH7bIqWfNJbUBiysXnRJGejc36ziFP9NMvwTLz
	9LFbglJ38ExeSu/QeOhqEoUi3VKhP1M4hb8QzPbcpaNFlHwd1XTFjxFxyQ==
X-Google-Smtp-Source: AGHT+IHgRe5kkHSKZbrQq3buX2bl9wMAxQVJHOhpY0iZhsKw4J2sHtFWnAuP8Yn+Qnc+Ju0QyzrBpw==
X-Received: by 2002:a17:902:ecd1:b0:1fd:a412:5ded with SMTP id d9443c01a7336-1ff0482c4b4mr135263785ad.26.1722436675326;
        Wed, 31 Jul 2024 07:37:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee1241sm121870305ad.172.2024.07.31.07.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 07:37:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ef47b1fe-5802-4d0b-a40f-88d1582b5200@roeck-us.net>
Date: Wed, 31 Jul 2024 07:37:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.11-rc1
To: Borislav Petkov <bp@alien8.de>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Jens Axboe <axboe@kernel.dk>,
 Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Anvin <hpa@zytor.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>
References: <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
 <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
 <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>
 <20240730192237.GR33588@noisy.programming.kicks-ass.net>
 <231e7a2e-7e2e-4b82-b084-8943b2236de0@kernel.dk>
 <20240730193841.GS33588@noisy.programming.kicks-ass.net>
 <f395b9d1-9515-434b-8ea5-c3bcaac10fd1@roeck-us.net>
 <20240730200947.GT33588@noisy.programming.kicks-ass.net>
 <e791c078-a821-4636-b44d-e02c22c046cc@roeck-us.net>
 <CAHk-=wgnmrbQhnXdpi=sY68m4OJff+qSiOUY-L8SF_u8JkHe8A@mail.gmail.com>
 <20240731082111.GAZqnz97mCll6rDyV-@fat_crate.local>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240731082111.GAZqnz97mCll6rDyV-@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 01:21, Borislav Petkov wrote:
> On Tue, Jul 30, 2024 at 04:54:43PM -0700, Linus Torvalds wrote:
>> You also seemed to say that it only happened with some CPU selections.
>> Maybe there's something wrong with the ALTERNATIVE() cleanups - I'm
>> looking at that new "nested alternatives macros" thing, and the odd
>> games we play with the origin and replacement lengths etc.
>>
>> That all looks entirely crazy. That file was hard to read before, now
>> it's just incomprehensible to me.
> 
> I'm sorry to hear that. The reason we did it is because it was starting to
> become really unwieldy to add a yet another alternative choice N in an
> ALTERNATIVE_N call...
> 
> Anyway, I'll try to reproduce here. In the meantime, can anyone who can
> reproduce - Guenter, Jens - boot that failing kernel with
> 
>    debug-alternative=-1
> 
> and copy dmesg and vmlinux somewhere for me?
> 
> It is a lot of output so make sure to catch it all.
> 
> Thx.
> 

See http://server.roeck-us.net/qemu/x86-nosmp/ for images; I copied
vmlinux there as well. Various logs are in
http://server.roeck-us.net/qemu/x86-nosmp/logs/; relevant

log-n270-good		boots
log-pentium2-bad	crashes
cpu-list		List of tested CPUs, with results
			Note that Opteron_G4 and Opteron_G5 are
			broken in upstream qemu since qemu v6.1.

Hope this helps,

Guenter


