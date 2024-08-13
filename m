Return-Path: <linux-kernel+bounces-284546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A3C95022E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47FDE1C21EA2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDEB189BB7;
	Tue, 13 Aug 2024 10:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3xyU/5Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC56B17E44F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723544035; cv=none; b=EHjyiLp1BRivzylvVFxxd9mXH3HWCu77GI9zaLIcT6Fkl4YNAwMj5V/pBU6BC4AaZPbaguOuSlnRBFTb1CrXymfKG1GKfV30hoxFIjC1D+OhYuPx2+uPQEUaRKrJO+wOO8XAJjh8yC9UO4LKGPMGz7HVi2EsyDt3nXjh0uE35Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723544035; c=relaxed/simple;
	bh=i23cSBjTRCx2DYjW98ZXQg7EkcSv5syeBHCgTC/WV2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SLB7wMvKwRojaad6UNX+Rejv+6Yu+GOVVzqzLO7lq4mnNbrN3q3oXmIW2vTU7PHUffADbGDdULhKQbYJ0gt2NWKf6IZYMNsBOcspoD/hxATh5QLnSWoZkLh7uBYueFfFxr1uCYvXo0DkVj2dP5I1mxdkk+Fh2PQNW/gtYiWXA+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P3xyU/5Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723544032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CjxtblCOPxJsxE8QSN1nSCIRTwIX6dCJwCctJwZakNQ=;
	b=P3xyU/5QKdS1pGLKiPSI7zq1llfGb4WVyXLc1H46/bPhccb9DjqflENVroWT4rbX4PvHjF
	VoKmn7fpE8YFN8YR2CLoBJZ6EJ1+nzg4Xs1Fwc8UDZkva8kM0XnHLjOmQcEJCOjKTYfjZ2
	h9cjVTAYNxiEp7oc67GJA5dzdpyTO/M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110--Ab2-on2MoKN5FxUWjBypQ-1; Tue, 13 Aug 2024 06:13:51 -0400
X-MC-Unique: -Ab2-on2MoKN5FxUWjBypQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-429d7db5e22so930335e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723544030; x=1724148830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CjxtblCOPxJsxE8QSN1nSCIRTwIX6dCJwCctJwZakNQ=;
        b=QW1P9VFLNvdYYE8zAhusIrfkzXOZmQ7lwTdEHdiJkBmOVCrs4ws8gAY3523D+1v5J0
         +Sdt35PZbf7kL3MlZExf486cXqHleF2PZJPJxUZ10Vi4AQxm1qPE+8Pu3O919l2a3QmV
         MQgxmVYegeAwCF2C4Wr8Rl4oVn4356sldXtelfzGW2g8orBzxvi4o9l4pJYiSHLklK4T
         8UVIynGxAtCUw+uScPQZVW8+jgbjiPhmH70e8eHT0dk3oYnV0YWU/xvAIHJXZOSHBNvZ
         WY+C/0FsY6cSGQciUK14vcaIxE0N3H2p7N6BTUY6GgWJd6PCZ14hswMKK7RxSw50+r3e
         vZJA==
X-Forwarded-Encrypted: i=1; AJvYcCVWc+2kyWySRMXKRJOxbs/yT32RZdKRnWWYuh4q9DpU69l53Wo+DSVEMrHU1Q2FL4RWgeAJDc6iInfQWBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo5SKy9+ADfprPWt17Aab7YoK0llXz/4W+IYUMV/Dscihqffkd
	iMOmEGRS8IUx/Asjyc1tw9zg5+i5lmO3kWhqznMdUFyOBjQZLwHgeEXO4qk1Le2+/ninhqr2EWL
	0XBI5phlN/M1FRNLCnOr2OCf9qSs7SmpucX+4or1B3zhocz85iUGUO4XRyIfQFw==
X-Received: by 2002:a05:600c:4712:b0:426:6ecc:e5c4 with SMTP id 5b1f17b1804b1-429d7619f4dmr7553985e9.4.1723544029695;
        Tue, 13 Aug 2024 03:13:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqKGCmEd3E72HlIMCCLzO9yIZXGf4hnVNLCFjZgr4b0FiM9ubmfosiMeYXlwopTLvzvU2kow==
X-Received: by 2002:a05:600c:4712:b0:426:6ecc:e5c4 with SMTP id 5b1f17b1804b1-429d7619f4dmr7553775e9.4.1723544029163;
        Tue, 13 Aug 2024 03:13:49 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1708:9110:151e:7458:b92f:3067? ([2a0d:3344:1708:9110:151e:7458:b92f:3067])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c7bc8c3sm222711985e9.47.2024.08.13.03.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 03:13:48 -0700 (PDT)
Message-ID: <cc843b12-da3d-46b7-8ba8-fd4bc4cf153d@redhat.com>
Date: Tue, 13 Aug 2024 12:13:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tcp: limit wake-up for crossed SYN cases with
 SYN-ACK
To: Matthieu Baerts <matttbe@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kuniyuki Iwashima <kuniyu@amazon.com>
References: <20240801-upstream-net-next-20240801-tcp-limit-wake-up-x-syn-v1-1-3a87f977ad5f@kernel.org>
 <CANn89iK6PxVuPu_nwTBiHy8JLuX+RTvnNGC3m64nBN7j1eENxQ@mail.gmail.com>
 <79e327c5-f87f-4295-b461-81c09a699af6@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <79e327c5-f87f-4295-b461-81c09a699af6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/2/24 10:48, Matthieu Baerts wrote:
> On 01/08/2024 19:52, Eric Dumazet wrote:
>> On Thu, Aug 1, 2024 at 6:39 PM Matthieu Baerts (NGI0)
>> <matttbe@kernel.org> wrote:
>>>
>>> In TCP_SYN_RECV states, sk->sk_socket will be assigned in case of
>>> marginal crossed SYN, but also in other cases, e.g.
>>>
>>>   - With TCP Fast Open, if the connection got accept()'ed before
>>>     receiving the 3rd ACK ;
>>>
>>>   - With MPTCP, when accepting additional subflows to an existing MPTCP
>>>     connection.
>>>
>>> In these cases, the switch to TCP_ESTABLISHED is done when receiving the
>>> 3rd ACK, without the SYN flag then.
>>>
>>> To properly restrict the wake-up to crossed SYN cases as expected there,
>>> it is then required to also limit the check to packets containing the
>>> SYN-ACK flags.
>>>
>>> Without this modification, it looks like the wake-up was not causing any
>>> visible issue with TFO and MPTCP, apart from not being needed. That's
>>> why this patch doesn't contain a Cc to stable, and a Fixes tag.
>>>
>>> While at it, the attached comment has also been updated: sk->sk_sleep
>>> has been removed in 2010, and replaced by sk->sk_wq in commit
>>> 43815482370c ("net: sock_def_readable() and friends RCU conversion").
>>>
>>> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>> ---
>>> Notes:
>>>    - This is the same patch as the one suggested earlier in -net as part
>>>      of another series, but targeting net-next (Eric), and with an
>>>      updated commit message. The previous version was visible there:
>>>      https://lore.kernel.org/20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-2-d653f85639f6@kernel.org/
>>> ---
>>
>> Note: I am not aware of any tests using FASYNC
>>
>> sock_wake_async() / kill_fasync() are sending signals, not traditional wakeups.
> 
> Thank you for the review and the explanation!
> 
>> Do we really want to potentially break some applications still using
>> pre-multi-thread era async io ?
> 
> They are potentially already broken if we don't test them :-D
> 
>> Not that I really care, but I wonder why you care :)
> 
> More seriously, I sent this patch, because in previous discussions about
> the crossed SYN case, Kuniyuki mentioned that he used the same condition
> as the one I modified here. I didn't see why it is needed to send such
> signal there for TFO and MPTCP cases, so I sent this patch. On the other
> hand, I suppose such old apps relying on FASYNC will not natively use
> TFO or MPTCP (except if they are forced externally).
> 
> In other words, I'm not fixing a problem I saw here, I'm only
> restricting the condition to crossed SYN case, as mentioned in the
> linked comment, then excluding TFO and MPTCP cases that don't seem to
> require this signal at that moment. But then it's fine for me to drop
> this patch if you think it is not needed :)

AFAICS this patch makes the code consistent with the associated comment, 
but does not address any specific/real issue, right?

If I read correctly, with the patch applied the stack will skip  wakeup 
signals for some TFO and MPTCP edge cases. Such signals are not 
duplicates, and existing (legacy) application could rely on them for 
correct functionality.

I think that risk of a the potential regression offsets the (unclear to 
me) benefit. I'm dropping this patch.

Thanks,

Paolo


