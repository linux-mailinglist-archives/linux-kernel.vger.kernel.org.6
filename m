Return-Path: <linux-kernel+bounces-545638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD17FA4EF7C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009EB188F930
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC554259CB9;
	Tue,  4 Mar 2025 21:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="FvjEFl00"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FCC1FCFCE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 21:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741124536; cv=none; b=XwEVv6wBh7fUMHYPqZ0ITIlgNme5ZRrBsco3xoqUBFZ2sKeULBLq6tatmJj7KHwFAajIRZOqoqqUw5nCQhbrnlFOw2uuenR/wPIXSNQ3sorLGlid9y/O5AKPkdgS7CjAldokgQUG9WXE74HTXO5CCUg2sNSTNPz1TGlS22pUJbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741124536; c=relaxed/simple;
	bh=4CRSOAJ0gTn/7mjqwmYQXOsQ3hSz83eHPlTTQZL7/Zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZWTad4q/XDJOlgaRPYs44VwchlA2d6J48dO8249NP+jJCKNV8rnBeNww5//YttC1S0W4/ItuTgF3Do2m++Mf4HPK5TW0rkJ/I9W5gGgdUkKe5l2rU5PEQNY878lbwvZDVMiFgYXvYg4+oQgt93/4eNy/nKVbYR2y4JP8ak7VAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=FvjEFl00; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab78e6edb99so851479866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 13:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741124532; x=1741729332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+JNQBuyB9+ss+3yPkCUqp7xWY3oo2h8qm9la8wSwFco=;
        b=FvjEFl00PT1pEiM/7I7cISibRq6nroTG9Gh4j236Ge64jWBXg72uQ7WAnTSSNzvikk
         UHpSN7B+cjyesVCnfy4wjbCj5dtcP07aKAx9lfM4pdtK9pTH7TdoM7aC/BZl1gzkupPD
         7TUn8Maj1z1kcamzB4WvO818NEYA/DMP0JBhFqmHbKuCsridNlnUt4kX4+pr2liju6xw
         GaZVSK2zV8BpvWtkeXfLz7mD2cuOoWEruwLnf1UFoGHe4AVaLqFWiwkWFaOZ8fhxi8En
         XqAHFRjUvrOtbLgjIv6PNXLHqXCTFT6Av+9t7ZfmI5PHjUCSnkjGeOm3CEvgxh5fUl1w
         r7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741124532; x=1741729332;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JNQBuyB9+ss+3yPkCUqp7xWY3oo2h8qm9la8wSwFco=;
        b=WoPObCpnqz1NfRvAPg/BMxtVmk/2Oq0dWFJ1yjhTkAEkN3F+t2b0FVOgv0Es9mw3kI
         j4HFyJQlnN5Tgg+sboqnfDOQ2Gy1yrftSbQbRLaTRORVRvqucpsfDuusLb4F/3yX9Ci6
         wOVrQ6HXQWsmMh3ppFXjMG3DUlY36qIjpQQOpXOvrpWkadE7FZPcTAaR1bX2TMah2Vhz
         SSNPzXAZjiiDbxlul+hNFYo5K0UE34kDjbvEuVI3hMVqnNiRsfr4NevL843+4Q/bkuZS
         sLQDkr+Fzy35M2zu6a0t4jXbrKUZhx6oijYOvro9PTt7xbVTBYjaJwGZmHmaJsAH/cDH
         gmFw==
X-Forwarded-Encrypted: i=1; AJvYcCURdBquI0m1K28igWyW0DEI4XT4uar3gkwjHX0xwuOSBSNZnhWVjidnngONQXt3/v9Mjtl7SqF6AUKkfYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZLWJm0LL1n2ZoNUFWk42DDrUUtvNYW2ZKUZf/HtAntNeubb+1
	TDNuTn/3kUiTpOOnDq/yWJcyqR3ZENhgVPpwwfvlOIA/4wj2yNHZS3I9wszjanc=
X-Gm-Gg: ASbGncuJxO2kBhgCrtda7VnSsMcSZzQvjmSQJNubOPaIeD0J0FhOUJmdJyHOClvhjAP
	VN3lVCx/4N/ychD5jCEVk3d1Mve0CSac3F+HfOf0/xhQgSlKBLdHqsaku5DDdCfY7ZoGdfCSF+M
	uTcT0T/GCMYfuhXA5ya+gp2w0OvCljlk7SaiJdbHGDf2h6xZn2cbocn5I7bpDh0TKaxup5llLeg
	1eMrSgh0rY5kJ50TWqUQMnbzrWdkUbPLuy5HAOpPSb5Ee5LLRzRqogsUU9yg+h0b2OBjZYBDx85
	f4/h54lnAlFUplk9Qw6c7QHS6hRFVZhUeUH7BPb0MIGU1SVXoBnBC+92OQU84iObUWCIL8VOn6N
	GD1tEM3g=
X-Google-Smtp-Source: AGHT+IFyJS9WlYqoKoL9AhIu0Jh0V3BWo+f0XG6mWUONLmq4b1Lqj3zqrGGEIRlwppC5DAbGooky7A==
X-Received: by 2002:a17:907:940b:b0:abf:457e:cef1 with SMTP id a640c23a62f3a-ac20da94c53mr73309666b.40.1741124532015;
        Tue, 04 Mar 2025 13:42:12 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:2107:3d4f:958a:fa5f? ([2001:67c:2fbc:1:2107:3d4f:958a:fa5f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1e9576fb3sm234172066b.48.2025.03.04.13.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 13:42:11 -0800 (PST)
Message-ID: <202f2906-a5d5-4bac-aab0-25223bfa7051@openvpn.net>
Date: Tue, 4 Mar 2025 22:42:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 19/24] ovpn: implement peer add/get/dump/delete via
 netlink
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
 <20250304-b4-ovpn-tmp-v21-19-d3cbb74bb581@openvpn.net> <Z8cPrYs0TuQfLlKX@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z8cPrYs0TuQfLlKX@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/03/2025 15:35, Sabrina Dubroca wrote:
> 2025-03-04, 01:33:49 +0100, Antonio Quartulli wrote:
>> @@ -1317,11 +1336,16 @@ void ovpn_peer_keepalive_work(struct work_struct *work)
>>   
>>   	/* prevent rearming if the interface is being destroyed */
>>   	if (next_run > 0 && ovpn->registered) {
>> +		time64_t delta = next_run - now;
>> +
>>   		netdev_dbg(ovpn->dev,
>>   			   "scheduling keepalive work: now=%llu next_run=%llu delta=%llu\n",
>> -			   next_run, now, next_run - now);
>> +			   next_run, now, delta > 0 ? delta : 0);
>> +		/* due to the waiting above, the next_run deadline may have
>> +		 * passed: in this case we reschedule the worker immediately
>> +		 */
> 
> I don't understand this bit. I don't see what waiting you're refering
> to (in particular within this patch), and I don't see how we could get
> next_run < now based on how next_run is computed in
> ovpn_peer_keepalive_work_single (next_run1/next_run2 is always set to
> now + X or something that we just tested to be > now).
> 
> Am I missing something?

Sorry - this is just noise.
Before getting to this final solution, I went for an intermediate 
implementation where I was calling wait_for_completion() on a list of 
removed peers (this is "the waiting above" the comment refers to).

Since I had no clue how long I waited, I had to update 'now'.
But at that point there was a chance that we had passed the deadline for 
the next run, hence ending up with a negative delta.

This said, all this logic was thrown away, but I accidentally kept the 
check on delta (that I even argued about in a previous email when you 
saw the bogus ternary-op)

so yeah, the ternary-op can go away.

Thanks for double/triple checking with me.

Cheers,

> 
>>   		schedule_delayed_work(&ovpn->keepalive_work,
>> -				      (next_run - now) * HZ);
>> +				      delta * HZ > 0 ? delta * HZ : 0);
>>   	}
>>   	unlock_ovpn(ovpn, &release_list);
>>   }
> 

-- 
Antonio Quartulli
OpenVPN Inc.


