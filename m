Return-Path: <linux-kernel+bounces-380981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56139AF87D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 05:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E901C20C8C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0D718C025;
	Fri, 25 Oct 2024 03:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vd/orv3h"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B692218A6D8
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 03:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729828364; cv=none; b=Pz8TgoiWesSbhX4w8TM1BjQXOoa4gmumBcP0Uagp0OegcI+e9uL8jRsu6XPCEKGLiJLyxyr5h1Z8QYFMXeHSZLW24pZKKhRKKFXd9T/zbf63YKusTn+tqUY49nklsRmkTABJ7Py/UNI3QQ3pgsn+WSCmyMRe5wDWubYKGus0p6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729828364; c=relaxed/simple;
	bh=2UNn5jyU2otPKAJ2cXStJVUYlOP97PBZeAYjCzVr2mA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvogLNCn1Ag8BJdLWB18ScacqdC7vvfbosit9ZZaLyNdHoetBCxzBw/27w1eS1QFAhbsfmxMbh9hcFasmKEt2tm83Cs1wJymGIPaPYDya2e+LtJygkoB+aKpt85LMDN6hmX9XA+H7E9WqYkvqoPiAms18cQRkV+WvfUcgQ2/wBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vd/orv3h; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c8b557f91so13136985ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 20:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729828362; x=1730433162; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RNZmEQpIpwXvLvJfZCVCIAUPdo00hn08DC54EJXAJpw=;
        b=Vd/orv3hVHfAtUdaAcTfLvzyMgSe0ponbJCgiJgbbLAa2wZBGFhpzZy3MVCSQHGEZA
         7XuXhEYPn+dT34O5ubgf+XfzzXTxwXM4AgoZNca0qDr2ZUNlljtsqrGQPDqL/uH8NNbt
         biDCIv3M5axtzjXS5y2SLP6vIlemZE1anSH8jjSNkEGrjlP4mkSAeu62Od1WptoTsBzm
         sJGtAFeYjykPKcoxV2ql5ZxvqXfFCwIeeGEs++u6EOpCllKHqgyfZ3yABE4ciCqFHpFo
         7y0etg8hz/77/Vzphy8SMIqWdKaX+P87iDnxHAOfDY/3+yMbWN5il6VpRc9J3OgG5AEP
         01kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729828362; x=1730433162;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNZmEQpIpwXvLvJfZCVCIAUPdo00hn08DC54EJXAJpw=;
        b=UDBc4Kc8/vUzq+WvkNb9UHyuVeWIyLAoxiwXxkLsraBbpc0EkIvxctN60P/YuyCXgq
         Chwl5vNmF3pw4C4YHdcaz13RVjOf6x17ELXtk3tYNAjz0lOKg4ANXaNqqiE2B1LPzZpw
         pAbTdMo27nNCMBo7KipV0zdUHGRhYAOjWIYLPTfZyNUoHQrZLVqBMv2Zu/dzx7k3wm60
         727Y9Ib0RIpqcCz4o75JHhN30B/+08/LRmev8peg6/gJxwJoWBITQ5blRNaiuOFbFcUR
         C1h1QxzyrxKCjhQ34p9KnrNxj6AKQoHTIm8ZjgHDK/YMfyruz3ZMqht/nbrotPKpH5VF
         Bz0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIsJ4QR72WnziobB8FVIqY6Z1ORwgJkfyHOvx32blq+rSoGRMbeGXxtsIRuYKDkJb4peGW8IV6awGaW74=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXMODyA8bj0foyYocCg8wsqekacY1icaFbesmF8ktiUdCUGYzE
	bLS1lN7JIKjKpvnDZ+JaNS5n6ye2cfqklQ0iP6jWw7gWiPQhfMkn
X-Google-Smtp-Source: AGHT+IFGYWscCOjLupQNjiVZMoBTs9hRowki/mED6jGzpXm332rJ3yLFGN9KEJJ/yrQjRvTDWLv2DA==
X-Received: by 2002:a17:903:41cf:b0:20b:9062:7b08 with SMTP id d9443c01a7336-20fb99ebd1fmr58353495ad.45.1729828361815;
        Thu, 24 Oct 2024 20:52:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc013387sm1732845ad.127.2024.10.24.20.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 20:52:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8e83a3bc-458b-46c0-a3a0-2d6543587fe7@roeck-us.net>
Date: Thu, 24 Oct 2024 20:52:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>,
 Sasha Levin <sashal@kernel.org>, torvalds@linux-foundation.org,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
 <20241022041243.7f2e53ad@rorschach.local.home>
 <ZxiN3aINYI4u8pRx@infradead.org>
 <20241023042004.405056f5@rorschach.local.home>
 <CAMuHMdUxrULbo=A77DFDE4ySbii3jSMuh8xVvUXaqyCnwEAU-w@mail.gmail.com>
 <20241023051914.7f8cf758@rorschach.local.home> <8734km2lt7.fsf@mail.lhotse>
 <20241024010103.238ef40b@rorschach.local.home>
 <07422710-19b2-412b-b8d5-7ec51b708693@roeck-us.net>
 <20241024024928.6fb9d892@rorschach.local.home>
 <82eecf18-0a71-4c16-8511-bc52fb61f421@roeck-us.net>
 <20241024211149.4f0b6138@rorschach.local.home>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241024211149.4f0b6138@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/24 18:11, Steven Rostedt wrote:
> On Thu, 24 Oct 2024 07:39:00 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>>>
>>> Now I have to ask. What's the benefit of pushing to linux-next over
>>> waiting for the zero-day bot?
>>>    
>>
>> I push my changes into the same branches that are checked by 0-day
>> and pulled into linux-next. linux-next shows interference with other
>> branches. Once in a while I do get a notification telling me that
>> one or more of the patches interfere with other patches, so I know that
>> something happened, and I can prepare for that for the next commit window.
> 
> Remember, this is about pushing to linux-next before sending fixes
> after -rc1. Not for things that are going to land in the next merge
> window. My fixes seldom ever interfere with others work as it's usually
> much more focused on code that is already in Linus's tree. Like adding
> a missing mutex_unlock() from an error path. How is it helpful to push
> something like that to linux-next?
> 

I still try to have my patches rest in -next for a few days before sending
a pull request to Linus. At the very least this gives others a chance to
pick up those patches if they encounter a problem fixed by them. Also,
sometimes bug fixes do introduce new problems, so, yes, I think it is
very useful to have as many eyes (or test systems) as possible look
at them before sending a pull request.

>>
>> Testing-wise, I do run build and boot tests on linux-next (the same tests
>> as those running on release candidates), so I do know what is wrong there
>> and (which did happen a couple of times) if a patch in one of my trees
>> is responsible.
>>
>> Yes, that means that in many cases I do know ahead of time which problems
>> are going to pop up in the mainline kernel. But I don't have the time
>> tracking those down when seen in linux-next - there are just too many
>> and, as already mentioned, that would be a full-time job on its own.
>> Also, it happens a lot that they have been reported but the report was
>> ignored or missed. On top of that I found that _if_ I am reporting them,
>> the receiving side is at least sometimes either not responsive to almost
>> abusive, so for the most part I gave up on it (and frankly I found that
>> people tend to be _much_ more responsive if one Linus Torvalds is listed
>> in Cc:).
>>
>> Note that I do collect known fixes in my 'fixes' and 'testing' branches,
>> primarily to have something clean available to keep testing. Linus even
>> pulled my fixes branch once directly because the responsible maintainers
>> didn't send pull requests to him for weeks.
> 
> Or are you saying that it's helpful to "fix" linux-next before fixing
> Linus's tree? That way others will have the fixes too?
> 

My fixes and testing branches apply on top of mainline. All patches in the fixes
branch have been sent to maintainers, and they _should_ be (and for the most
part are) available in linux-next. If they are not, the maintainers did not
respond to the patch e-mails or push them out to any branch that is used to
generate -next. The only exception is if I needed to revert some patch to work
around a problem, but even then I make sure that the responsible maintainer
knows about the problem (if they read their email).

Guenter


