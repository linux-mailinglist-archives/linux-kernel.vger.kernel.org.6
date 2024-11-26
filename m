Return-Path: <linux-kernel+bounces-422006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 859469D932A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441D5282846
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC891A2C04;
	Tue, 26 Nov 2024 08:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="EqPRWj4z"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0ED13CF82
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 08:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732609012; cv=none; b=iGLqL05kxiN8teMlRYuvhu3Aqs0dO6HTgdwbkNOQuPzxD19+1/C54RjtwPZSgawAbrlHn9s9w3gtlPQ8vICBkAliI8hcpdmoX4Iu0W/dNWvtxMWmaJ1GhTa2lz5lQgaVmKcShmUY0E9ftF1aUEfnoJgsU5w6wGFcgBdRxJOcsBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732609012; c=relaxed/simple;
	bh=2lGrkcAVUqZc/slWNGDVQpJ9O2RangXQHo5AZXT8VvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M91/lVV/DSut0DyW+eLyha3O4QuAMPd2OwWjcv8z6AQ6I5wR2kf1Y1iUqo+EqEntDLyaIOh05RUOsoQPzEZPPQmha6fKsbY7eNtfGyuw/MfNqPBHRXgULGlb91D7f6+86bVn3VWGjrZOVaSktzJ82JougMutZ4WRfB82S9SN8Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=EqPRWj4z; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa55da18f89so202981366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 00:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1732609009; x=1733213809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dzoPr4u+qeyZ0Bm8j1iWC2K6TD4OyphvxGwnAxVtaeI=;
        b=EqPRWj4z+3NL/rVmBeebofeHkSRAQUZCVjK7U8BIEy66WKYNxQtScetccFrzIXoQLt
         xw/DuvxQJj3fyboINq45ZtcD8KE6AsLrlOYH1hbcCOlZhQBrxvweVdK5c7an6vw5vqhh
         V07zLKeWoWr+fTFChb2+tpdmIvMVRzK8UW7p6V0MjG/EJk3F4/44WryA8UY45WmrZgxJ
         QHe0Y1yTu4WScZXGJD3TLzLhGo96UQBN6+nG+fdFQB8gvgzNjpWKOyq+/j83YFtH4RYj
         oZcYyEutRmp9Aka7vFyBrG7bzo8tly1na03QNUvBVCSIijwsjH7S13HK+phcXWTpyX+n
         WLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732609009; x=1733213809;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzoPr4u+qeyZ0Bm8j1iWC2K6TD4OyphvxGwnAxVtaeI=;
        b=IgwbpeU3Dtptqv/fLDZ3tgM/gFNn1ERHoRajGb6mvTJTfuimvrqgsvscxvqhAKOdxg
         kz6ys/SUyqd2xUhcnRgHYID0JwHC11LFnY6v8t0LFkTPmhwC5fHqaQORMPaAXrEcQXRk
         oSc3v7rnnmKP1vWp4DcGRuQy9DlN7tYaa9Hnt4nun3qr3nG3OVkWHNsbVAZX59yB1UJR
         sc13WC74x6luQZw6SUfFZuZ5HkLvFoP+oZwil9Kypw063Y5xxCif4BSca1NB1xOK9bWS
         HFEcXzRGxCOGtq6fo90dRtt1Pxt9Hbe9bVRip9XFNzAklqM0dLn76CUfvNLLy3uslWr6
         macA==
X-Forwarded-Encrypted: i=1; AJvYcCX4uaoZPxsqeiNWvrxT8G/bCVsYpsJT8rWYQ6RgmTjUiKAP3ZmehItVpf2mY8Ag9+NAgqmjTZnfQME5vc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YySWZMkCDZ3s0gkmXZg3F+VSey209ENPdEp7aQq/+83V95NrkWV
	tpRAUdOaYur0WeCiWEMR3RYbBRunQNpjC+BFITNCQ/oancLtmAOp2f02fbUcBNIwXS9/3wV0yud
	f
X-Gm-Gg: ASbGncvLQSbonRaCASTWDg7ebiyi6oojWToyLwQw7dsO7OkYx5jdqUEKRXAqi6I8MvW
	H581wEtPIKxJKN44D0x4/nYR6PKws4vQFXfZzn9IQsRwedMLlhD5VAIPXfrCyurUpOozqrQnBNa
	dKg8ES5JkaooQXeO/jFqpGeNJVdKh9q3Qw/mH82uK9DTZjxLJuQCUiYqrpM2wmELXsBy8DxKavg
	yAtDIVXR2xc6wZSDWJS9F6YrWWRzw+8tOWiRPE7CS+I0iNbmOKixFJchw9LLcSNF4+7qNWo/P0U
	c3mFSzKqC48g
X-Google-Smtp-Source: AGHT+IFMkkabM7WpifT51EgTY9Exgvdq9dyGPg411S/fyI+GIdNLWPLXL556MMxkQg9VYWYGEcjqNg==
X-Received: by 2002:a17:906:9c1:b0:a9e:4b88:e03b with SMTP id a640c23a62f3a-aa5096a1e31mr1257695366b.0.1732609008977;
        Tue, 26 Nov 2024 00:16:48 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:9421:3351:41c6:fc75? ([2001:67c:2fbc:1:9421:3351:41c6:fc75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5464f16b3sm314160266b.133.2024.11.26.00.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 00:16:48 -0800 (PST)
Message-ID: <55d91682-762e-411e-8abc-0790a9d81102@openvpn.net>
Date: Tue, 26 Nov 2024 09:17:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 05/23] ovpn: keep carrier always on
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 sd@queasysnail.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-5-de4698c73a25@openvpn.net>
 <6a171cc9-a052-452e-8b3d-273e5b46dae5@gmail.com>
 <89ae26a2-0a09-4758-989e-8f45a707a41b@openvpn.net>
 <e2caab8a-343e-4728-b5a7-b167f05c9bb9@gmail.com>
 <c933e2bf-b19c-4f8b-b2c0-44de50eb4141@openvpn.net>
 <1cf97615-a38d-48c3-9e23-4ba82012b32d@gmail.com>
 <c9185b5b-942d-4927-8171-f3460619aed1@openvpn.net>
 <c62208a4-5396-4116-add1-4ffbc254a09d@gmail.com>
 <cdbeecb8-e468-4925-9ab4-c77accf806b9@openvpn.net>
 <debdfbda-36f8-4c83-bb54-3b48af77e7bd@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <debdfbda-36f8-4c83-bb54-3b48af77e7bd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/11/2024 22:32, Sergey Ryazanov wrote:
[...]
>> FTR, here is the text in the manpage:
>>
>>         --persist-tun
>>                Don't close and reopen TUN/TAP device or run up/down 
>> scripts across SIGUSR1 or --ping-restart restarts.
>>
>>                SIGUSR1 is a restart signal similar to SIGHUP, but 
>> which offers finer-grained control over reset options.
>>
>>
>> SIGUSR1 is a session reconnection, not a process restart.
>> The manpage just indicates what happens at the low level when this 
>> option is provided.
> 
> Still no mentions of the traffic leaking prevention. Is it?

Like I said, the manpage only mentions the low level bits.
I have already proposed a patch to further extend this text.

[...]
>> Having userspace configure a blackhole route is something that can be 
>> considered by whoeever decides to implement the "kill switch" feature.
>>
>> OpenVPN does not. It just implements --persist-tun.
>>
>> So all in all, the conclusion is that in this case it's usersapce to 
>> decide when the interface should go up and down, depending on the 
>> configuration. I'd like to keep it as it is to avoid the ovpn 
>> interface to make decisions on its own.
>>
>> I can spell this out in the comment (I think it definitely makes 
>> sense), to clarify that the netcarrier is expected to be driven by 
>> userspace (where the control plane is) rather than having the device 
>> make decisions without having the full picture.
>>
>> What do you think?
> 
> It wasn't suggested to destroy the interface in case of interface 
> becoming non-operational. I apologize if something I wrote earlier 
> sounded like that. The interface existence stays unquestionable. It's 
> going to be solid persistent.
> 
> Back to the proposed rephrasing. If the 'full picture' means forcing the 
> running state indication even when the netdev is not capable to deliver 
> packets, then it looks like an attempt to hide the control knob of the 
> misguiding feature somewhere else.
> 
> And since the concept of on-purpose false indication is still here, many 
> words regarding the control plane and a full picture do not sound good 
> either.

Can you please point out the code where other virtual drivers are doing 
what you are suggesting so I can have a look?

Wireguard is the closest module in terms of concept and I couldn't see 
anything like that. Neither in ipsec.
But I may have overlooked something.

Please let me know.

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


