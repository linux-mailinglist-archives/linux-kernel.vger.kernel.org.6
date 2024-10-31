Return-Path: <linux-kernel+bounces-391155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4D09B834A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5856CB22F62
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374401CB335;
	Thu, 31 Oct 2024 19:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IkLuRVtH"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF351CB32B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 19:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730402554; cv=none; b=Csb9PbBHfiCvQposIaQhidNC23jCEID8aZ9Nio+Zq9YV9Tfy5UY+5pqm14iM2dbLR7Red4GA7iPxRQcwpTmLyL3xWQlunCk9iGu6N7/vHIfRNZ3UPtL3BKNd5N9ek4If9/yRxBflkXeN4vTQVbkYgGgaADa6fVfhxhsiWBQzCek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730402554; c=relaxed/simple;
	bh=USu9utoOUDjF9pGXsZgvak+zLkm8GncKJ4y8O8eezOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aLE9ghuhdOKUTpZdXKTP+u55qvRn7AmG9n0KhSCdo/9GhPyXsYDoH+FI4yAB4EaBIOyTc9Fhgq/sHAFxpNUa6Xg1ZZW1rWh7Fzx0xQVriZ+kqsCTMYHtKOjunq7GRR08H5JyXcTYzKHUpeA5UMb2BMxgS2aOdAUg2VLtLsq6DRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IkLuRVtH; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-83ac05206c9so46647239f.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730402551; x=1731007351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eAP/bAcV3XycEinBatq5XdsCa8IJPkmp6YdIv9sxUp4=;
        b=IkLuRVtHhkoyRrL4Hou51z+ny3ihZ7h38Pr+w206N02350y7BRy618Fk5geKdIqUbc
         LpJRx9BFxA5nX6nDwxMj5xyDlD6SkxKnvd+q4NEqNPhh5wSZPC0+gLMTeYGdg73Kon42
         WysP4KKJBmMj9VRXqZ3zysgV8Ad08cC26s4A8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730402551; x=1731007351;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eAP/bAcV3XycEinBatq5XdsCa8IJPkmp6YdIv9sxUp4=;
        b=QZtzsu+O0RPzOw9DTxiQ7LxOidbfbatQIlbBnxJfZmXJftBVjMa3d3LDuxzhKPu1uK
         hL4mFggwoI+VIIrOecwo+SEkbewt765fuycrR04nEqqw+C/qmefzcFwTAnlR9SlUCrZp
         i3TwiuyBnO/GLIaPXDUO+we5b5vXsOSJq+cq9XPFqjToXmtpg9C0EeZ8NgE3R6+sUXlV
         D2PMfP5zyS/bgX1FoK5kPX7DDFsxH3U19OoLqjuLg0a0ykHAFTYxLC3bMrI4FcU7cACa
         tMkL2usHoXU++wq/oZVgr7jfaIgF2RLP/EqnlIsAB1fAAPvrYy8sp9ti78P6O3wQvRAb
         Whtw==
X-Forwarded-Encrypted: i=1; AJvYcCXri9nMfve+i+rteNfApS7GcLq+dNm85MxrM9MnspOTa30jhpwFXaR2/QBGbrQlIQPt3eUAIso2lX8Uyyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFlJSak3AJ1pHjCFdcofnz1cK01ho+/y879PHvxnWURnUhwha9
	jM44rQ+F4Wq2CWH9yUGPLKxs/bXfkC8SHgwIBk4a/XwSjYU96G8KP8dwX2FLcExKlerEbgP3dbH
	v
X-Google-Smtp-Source: AGHT+IGHYwu7LubJxPhGnVJYDPgVe7Q8KaU4aEUk4n8hC7hyzO6sNgIWfF8p8HCYVRIjvyvx62mx6A==
X-Received: by 2002:a05:6602:1508:b0:83a:b33a:5e08 with SMTP id ca18e2360f4ac-83b719f3db1mr102629339f.10.1730402551341;
        Thu, 31 Oct 2024 12:22:31 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de04977a96sm399294173.110.2024.10.31.12.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 12:22:30 -0700 (PDT)
Message-ID: <3f71da6a-ab96-42c6-9c61-c73f2b6dceb0@linuxfoundation.org>
Date: Thu, 31 Oct 2024 13:22:30 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
To: Thorsten Leemhuis <linux@leemhuis.info>, Mark Brown <broonie@kernel.org>
Cc: torvalds@linux-foundation.org, ksummit@lists.linux.dev,
 linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <6dbbc85e-5a87-4605-8db6-92b191878d97@sirena.org.uk>
 <bae547a8-0a16-4173-9aa3-5c31e0a0b1e1@leemhuis.info>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <bae547a8-0a16-4173-9aa3-5c31e0a0b1e1@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/24 03:10, Thorsten Leemhuis wrote:
> On 21.10.24 23:41, Mark Brown wrote:
>> On Mon, Oct 21, 2024 at 12:07:13PM -0400, Sasha Levin wrote:
>>
>>> In an attempt to address the concerns, we're trying out a new "linus-next"
>>> tree is being created and maintained with the following characteristics:
> 
> BTW, in case anyone cares: I fully agree with what Kees wrote earlier
> today elsewhere in this thread, e.g. things like "improve -next instead"
> and "pre-merge bot":
> http://lore.kernel.org/all/792F4759-EA33-48B8-9AD0-FA14FA69E86E%40kernel.org\

I am catching up on this thread. I agree with Kees and others on improve
next instead. Adding one more next-like-thing will add to the confusion.

> 
> Regarding that bot: a few of the CI folks and a developer or two told me
> they want regzbot to react to PRs for Linus as well, so it can send
> mails like "hey Linus, just so you know, this PR contains changes that
> cause the following regressions not yet fixed". I think I like the idea,
> but well, quite a few other improvements around regzbot and its use have
> a much higher priority currently.
> 
>>> 	4. Continuous tree (not daily tags like in linux-next),
>>> 	facilitating easier bisection
>>
>> Is this a pressing problem?  I routinely bisect -next, you have to base
>> things on Linus' tree (or pending-fixes) but otherwise it's not
>> especially problematic.
> 
> I wonder if part of this is a "don't know how to do that" aka "lack of
> documentation" problem. I've recently seen some good guide or mailing
> list post how to bisect -next somewhere, but I think it wasn't in our
> Documentation/ directory. I need to search where that was (Mark, I might
> misremember, but wasn't it you who posted it somewhere?) and could work
> towards upstreaming that or some other guide. And don't worry, due to
> the different target audience it would be much shorter text than other
> documents I contributed. ;-)
> 

Documentation could help. Tailoring the workflow to linux-next could help.
All my branches are in linux-next. I don't send my PRs without keeping
the content in linux-next for 3 days to week after rc1 - it is usually
longer for merge-window content.

This helps me find conflicts if any between all the tree selftest go
through and mine. It helps work out conflicts in linux-next prior to
sending pull request.

My vote is for improving next instead of re-inventing next-like-thing.

thanks,
-- Shuah


