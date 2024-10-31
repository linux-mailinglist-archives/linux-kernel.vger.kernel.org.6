Return-Path: <linux-kernel+bounces-391132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2039B8313
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 069B81C21A6F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17E61CB306;
	Thu, 31 Oct 2024 19:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b4Bt0LHJ"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B1C19D089
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 19:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730401696; cv=none; b=oKQuU/pPqW2Y4tP5exJCUXtRxJgoPGXrN7q+LcJwEhor1NAUwh1LxJbujPuquFxByu0vOyOqMK5Hmxo0sYXeW16+fU5S01RC22kWm6IwDj9QXw41v02qtd4MbeVIJ8+QL5k7A81EYJh/z7bB0zNqL6WEIH53bx5SRchRPnn7Phs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730401696; c=relaxed/simple;
	bh=InZBgv+kFX0M1o8Ll1iRSk/5sbqiSGMb3mGm8OERP94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OHsMjneZfDHQqYTFbL8DiixHASixbKiAFvMkBmzIQHpTk5qog4le+P9BPfYKWrVvg1fcUF9kUs0k6m/jI6TV9KTDRWCtbSqg7FG7Rf/dRkt8EOLn9X9DMQ2I+0lisO4tRD44gKt1tbJRRLGD1gQ5t28ZcsOzicD1VS4EJdxtxxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b4Bt0LHJ; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-83ac4dacaf9so46304139f.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730401693; x=1731006493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cbq/ZEWacRJdHkw1gGMFiFwPYAsuKPdwhjOfwE9lyNs=;
        b=b4Bt0LHJIea+pc3KO5H9Jzn3+PPW0w1xOib8HWjQEFBy1pM3kud/suslpLtBBlLuIF
         lKIpz9HKcMJBuhA0x0AN0hlHjeaiWb1T2yd6D2TUymTqXwuszkV04CgEca69Ko7cfabo
         XVhGVXi4J0Lw88GJ13GHnazFe3dRC019dHvxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730401693; x=1731006493;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cbq/ZEWacRJdHkw1gGMFiFwPYAsuKPdwhjOfwE9lyNs=;
        b=i59RPT5mm+41FTp1QFkZTPFYdh7Vtn/Zdh7/TBU/3CHq80zGlqqs1PWkdJ6JEu7FA/
         /FVf3fuKBL15dvrsR9NGdqhhWB91J/r2AYxdzWkKVLzUGKcF59qUERePOnTeROti2Ik0
         4/YEUO8/zYG8qpApVaDAVKiIIaaf72GTiN4VxgU7AKZ5jg7/7ycVlY/GQixcx/dGFEuZ
         sGuTTSMgCaEJDYhYVkbkHDq4eYJXvGLvSYfjtwSEPZ/sbrxSLp/BYl7LhZiOs/c1nk2k
         Jxn2xpYpH1WctZRGjdtFfinDhdUu6PSqZaH2Drre8fkH+q21b2Tjj6Vv2xn0wF5afQsY
         1O+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQL+mWtJXCU/I8yUCRD1R7vhYET2p0SlK0mYZLZiRUBF2Nu4csT+ZOMgMwbZlSVckZXH2il62/eyr213w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw9AJt4THgsE4SpLuGH8y3xhyAcjFR4dYemnbxC8LlivQxMw3+
	ojjTXuE02krrmzIM5HuouAZ89J1gJyOyro1g4KySxvoYHzSERmqLvYYDSyvlhHo=
X-Google-Smtp-Source: AGHT+IFJB6gk7rz/6qG7W/1JVxLTExwIHZPrU8sd4sVvWjmbAlGDJwlGUPH7LH6gUDcfZtyBoYurjw==
X-Received: by 2002:a05:6602:6d1b:b0:83a:9820:f26b with SMTP id ca18e2360f4ac-83b64f7309dmr534498639f.2.1730401693242;
        Thu, 31 Oct 2024 12:08:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de048c0150sm403742173.65.2024.10.31.12.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 12:08:12 -0700 (PDT)
Message-ID: <1cb27980-7679-43c7-92b5-48af6d711a1c@linuxfoundation.org>
Date: Thu, 31 Oct 2024 13:08:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
To: Steven Rostedt <rostedt@goodmis.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>,
 Sasha Levin <sashal@kernel.org>, torvalds@linux-foundation.org,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
 <20241022041243.7f2e53ad@rorschach.local.home>
 <ZxiN3aINYI4u8pRx@infradead.org>
 <20241023042004.405056f5@rorschach.local.home>
 <CAMuHMdUxrULbo=A77DFDE4ySbii3jSMuh8xVvUXaqyCnwEAU-w@mail.gmail.com>
 <20241023051914.7f8cf758@rorschach.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241023051914.7f8cf758@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/24 03:19, Steven Rostedt wrote:
> On Wed, 23 Oct 2024 10:36:20 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> 
>>> To put it this way. The bugs I'm fixing was for code in linux-next
>>> where the bugs were never found. They only appeared when they went into
>>> Linus's tree. So why put the fixes in linux-next, if it didn't catch
>>> the bugs I fixed in the first place?
>>
>> Hmmm...
>>
>> Your arguments sound very similar to those being used in recent
>> discussions about not posting patches for public review...
>>
>> Please follow the process! ;-)
> 
> What process?
> 
> Note, I probably post everything to mailing lists more than anyone
> else (besides stable). All my commits come from mailing lists. Even
> things I change myself. I always send out the change to a list. Then I
> use patchwork to pull it into my tree.
> 
> After the changes are tested, I send out the patches *again* with my
> [for-next] tags in the subject. If it's a fix for Linus, it goes out as
> a "[for-linus]" tag. These emails automatically update my patchwork
> status.
> 
> No change goes into Linus's tree from me that hasn't been sent out
> publicly.
> 
> But pushing to linux-next for a day or two, what does that give me?
> 

I don't send pull requests without soaking it in next for 2 to 3 days.
It helps me find problems related to things something breaking on an
architecture and/or config.

I find next very helpful in finding merge conflicts and build/test
breakages.

thanks,
-- Shuah


