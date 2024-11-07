Return-Path: <linux-kernel+bounces-399694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EE49C02F9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94AC41C21B46
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3003B1EF94F;
	Thu,  7 Nov 2024 10:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQB5I/7w"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1911EE007
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730976719; cv=none; b=V4xmK58QGOiKSnw/ATTTnuiLEn4OAmvJYs/gmB359XcKVwTeSzF7M9J6CJYlEEtUNq51ADUWvqopw86KjPNTFSMfwFHmWcxguYkmyC6Nc+/ip6+OG+2rMSOJj/uuesJevabXozGFGoUk9e4lpEIABlc9VRjHrhUiE8xmhMbWfqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730976719; c=relaxed/simple;
	bh=iTraXoQlMnsFBf3dXybH+eULUrZ728/il/5KZ7LOXnY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=C3+afJmEo/WUU7n8Jtkq7OTR6WLgIX2Yk2cSxyyZ66+SDwcB8+g1Xmfxcp+bvo5KVT1txhpMrqNgl+cRyoB8vyKroyaKjxnFSC6Q+YyBe71My6SveygT8ajMMeLwxRtZcr9Zx9SmAnj8ozZyhlZHSz9CMki9fifO2SHIpYKyPMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQB5I/7w; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7f3da2c2cb5so706469a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 02:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730976717; x=1731581517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UuY4SpJUbO4AJrmSD57YV+liJgSVrcOzU9NY1Rw92r0=;
        b=mQB5I/7we9PtXR6C8VnWwknAH0dS/39N/88bzvrH4VCMsiz0Dr+q1pQwgXebGGTUeo
         OfbhdFH5/fVqDrsGuJY9UBrhvs9MmWRErt84fn5Cc7GRjV5jskv1QvWKTt84C7eAyQll
         f1hB1428XFKMTihSxRWJVR+8Xy7y/2nO+Dxpx+g6Vee7t0mMrkZ7KCA0sOyA8OR9KPKc
         CatW9bjdRTZ6YIAgqcbvhvb78Il1w/YUkeTo0kbebdAoOh2uZxOXfkpX+282ZRr/ccDG
         rDbwZ0ktbZLzLmodP7ypLw0pDqT3MVH3XS3h8WBYReAAros9wmSgTs5K9sSvlZVydpie
         Vx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730976717; x=1731581517;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UuY4SpJUbO4AJrmSD57YV+liJgSVrcOzU9NY1Rw92r0=;
        b=NApMn4X/+zpL6tqm3kiPx8pNQDd4PJp0Gkt4yvPi0FGM8BMClkdbx+AaMOINsPaoH3
         5NsegmUD8Ou5S5JFquZ3jTFAHDQXgRtn0xKjUo5vRo2V+WAooA4K4DE2goj0e94xhxYz
         e8KomuoPtRt/G47ooV2pC8TQBGOGNgsqa4iLXBsyXSeQH9OB/JFUm3zQ/cf0JDBJt2hP
         Rxsl0P/W9axka3+/d66mRnBGA/9zAFP1A5dS72UmxVO5iKaXX8mPQZSQEJY+o9940KTV
         pkWxFM9oyydvGU9nwGpdWtLwOc+MalRqycqunP78UAEKf+vMw9JH3wXUPbjTTpbuVK2T
         OWpw==
X-Forwarded-Encrypted: i=1; AJvYcCUgKZSngJ8/xUeE1wCluiin7hAT5DAclt9xOlj1sj5lOhWuLrBhHB/2gNvQL7Gw7qBufihn3JGOmh9Lecg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkvcZwjf8SnTtYYwXdACCmNqBkJC4oLW7yhyMsn4ojCfqLgzdu
	KPJuYGZQhK4etD3HM8TyQ6yLUoAl/zlfbh0VH3HT0flUEFzRqtUa
X-Google-Smtp-Source: AGHT+IF1IWFmBnHTSCycGILlrZMmwZUdqmEcXMZt+Qm0+FNaaUgLuV4TZnIKVHuPWEXKHaTVK7WAgw==
X-Received: by 2002:a05:6a21:9999:b0:1db:f89a:c6fe with SMTP id adf61e73a8af0-1dbf89ac713mr11476967637.32.1730976717526;
        Thu, 07 Nov 2024 02:51:57 -0800 (PST)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a5ea27sm1178054b3a.177.2024.11.07.02.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 02:51:57 -0800 (PST)
Message-ID: <46d291da-ddb9-43b9-bd93-b81aacd5e29c@gmail.com>
Date: Thu, 7 Nov 2024 19:51:52 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: jonas.oberhauser@huaweicloud.com
Cc: akiyks@gmail.com, boqun.feng@gmail.com, dhowells@redhat.com,
 dlustig@nvidia.com, frederic@kernel.org, hernan.poncedeleon@huaweicloud.com,
 j.alglave@ucl.ac.uk, joel@joelfernandes.org, linux-kernel@vger.kernel.org,
 lkmm@lists.linux.dev, luc.maranget@inria.fr, npiggin@gmail.com,
 parri.andrea@gmail.com, paulmck@kernel.org, peterz@infradead.org,
 quic_neeraju@quicinc.com, stern@rowland.harvard.edu, urezki@gmail.com,
 will@kernel.org
References: <3d72b92a-4935-425c-abd5-ec4631baef2c@huaweicloud.com>
Subject: Re: [PATCH v4 5/5] tools/memory-model: Distinguish between syntactic
 and semantic tags
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <3d72b92a-4935-425c-abd5-ec4631baef2c@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Jonas, despite the CC, your message has not made my gmail mbox, not even
the spam folder.
I'm replying using lore's reply link.

On Thu, 7 Nov 2024 10:05:18 +0100, Jonas Oberhauser wrote:
> Am 11/6/2024 um 7:00 PM schrieb Paul E. McKenney:
>> Never mind, I found your patch in my spam folder. 
> Glad that got cleared up. I had gotten very confused because you had 
> also responded to the thread with the patch.
> 
>  > check this commit on -rcu
> 
> For future reference, where can I find the -rcu repository? I couldn't 
> find the commit on paulmckrcu/linux, but maybe I looked incorrectly.

You can find your patches at:

    [v4] https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=c53d54ed7e40255ea0ea66dd121672fd22423326
    [v5] https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=9b13bea0966c498629e221c3022a591cc88d4c57

and

    [v4] https://github.com/paulmckrcu/linux/commit/c53d54ed7e40255ea0ea66dd121672fd22423326
    [v5] https://github.com/paulmckrcu/linux/commit/9b13bea0966c498629e221c3022a591cc88d4c57

As Paul mentioned elsewhere, the [v5] patch misses tags from Boqun at the moment.

HTH, Akira

> 
> 
> Have fun,
>     jonas

