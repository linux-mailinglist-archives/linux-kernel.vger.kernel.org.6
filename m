Return-Path: <linux-kernel+bounces-538678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD38FA49BC8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813721895513
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718F826FA5E;
	Fri, 28 Feb 2025 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="IFrfcr39"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D40053363
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740752480; cv=none; b=JND5why9T36u8kTvGasB1FnBcKEmdyBpEoSD3LNch1kciqTHTtFbmGF2cHUrO7rpsO60C8wuF3LMab4tcJ7FiRFpbCcmm/+wA9RM8bH8RD4SbF1ty9y+HuGEWW9O28IsVI/4yE6aYjZ9Yw507Is46s8ymHaz/fSGS34ew7kekPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740752480; c=relaxed/simple;
	bh=RI6mieHVmJ+2T7KWGP6DaYCVSIovyx1OV8K5vLZ1IYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5udaZB4qUnBoMdKeD5LHZRADfQdPOl8mxhOAUQGnyQ0f/1Bqy+3MBkiGiCzMcMFTlyEh1AG51PsAjuuW0u/zigDmDxJ7vJkeH26new3Cp9mo9+OEjdXugf1C2Imu0izv3mg50fFuD3YDtGAUZzh1EogbW1A9waGf+HLTg1EnN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=IFrfcr39; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-390dd35c78dso1717430f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 06:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1740752476; x=1741357276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Lsm7zHaYH2jIwvMQk5vbbkkvVtAbnIssNnslsMzrf2w=;
        b=IFrfcr39JClGsgpS65l5EPvRmJQp4/brfFE1PHDHX2Va9UVDVWqX3ZHjgf/Gbxy5gN
         DOFzVmd1zQa4gGI1l/fL2YpR4jzg2mPb9DQosMPDgy9dH2rTFV6WbP041NkONZQT2wwH
         0lf9AiJ9zTdon9TNQVoPp7l0iAhV6j13E/C0Hh9QgJbJdqO0fZyeLDhc4fkCARQdNPHf
         xUxO086hOQWvDXQ0o47IYJTQuAIB8q4ZNddBRu0zusg0scda7Zgc1MMON8w2iOC5a2VP
         CzPKY3n5xSIRxRcm4ikgpTVtz6M95o01ECfS2/t8372jv2pKGGCg3wX/hjeZRC9KM2+2
         ViOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740752476; x=1741357276;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lsm7zHaYH2jIwvMQk5vbbkkvVtAbnIssNnslsMzrf2w=;
        b=tDzTq2ZMfdJ01L5J05OEzdD7Ab+lLx2E6oGOaSvJAlR9cKMX9+ZCibfWF0qAreCEvV
         ZrHzay4vaf7bpfaVuZatZsxrEBtWxXOwVR6grGjyYbA4FxEvBthaq9tC8te17WBurKKJ
         CYm+lC0hqc1Kefj+q2hFQwZC1EV9/+8Ikj7C+Shb1UrbL9VKUKmNyuVbB+hPGFitGwHY
         tLpENcwrVuiU6GxpJrSy8LBK0bN04qDmPIx+I3761LKvJ8gwo3HKldKJJB2CLo0Pwi3B
         OP1YEigUlrMOd33FA0ruRElM6CF4an3AUzmsySIZcxE++VR0mUJ/ahD4FZTgVy4+juk8
         euZw==
X-Forwarded-Encrypted: i=1; AJvYcCVFBTGQj+D8lES93aBBgVYl0MZRergvbokI9gGjnvi+pT1jQOizrJQgngHWwz5SgLvhVvja0Y9133h1p64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt+d1tYqdsNGJw9/R/mNJTKOwzOpleiZDmo0WNOUY644hnyHNG
	jHvuQExJ8ir1G5Qpi04Vd0B8IAmcXLq0Y20cuHGC0s3RU/EL5xp4M6SiCbG7f7E=
X-Gm-Gg: ASbGncuVbp8dWocCNNoNE2sQdPdheAZU4nN3zyLRd64V7aYEjCsRT3FuzO+Oo84uN3k
	NWJU18x7fvIWTtEj9JBHGW7lCn2LnO0fF3MNg+vwDvHW5rd4FphvvcYZwT06ru2rmrl26nt+bMj
	EfTS5N0Etd1i1A2/4O3Omwr5KqQFyrLni+9TDienBJrfdoH39wE1d/CvIX5Dcvcyuckpfb9fFGj
	BP7qds+GfH+INUpAwvcnbyD6BK6HVuyu1zIaVJRKJ+/Df/zsMcpIVBmZIA3gWNNkKqvd0mmaVDq
	D20t74L2vCMLfH4ttkTYXa0r3edYKFAJ1mINYtSCfMjY/xpAlhLCR5pMkaegjajP
X-Google-Smtp-Source: AGHT+IG0ioEwXDlYS7sa6bw1K9Hhx8cMRAwN8lNnfokMsiHC+FK0+y3Hs9ldHBe+DVrWXZW+FTL8dA==
X-Received: by 2002:a05:6000:1787:b0:38d:df15:2770 with SMTP id ffacd0b85a97d-390e15da77amr6810295f8f.0.1740752475677;
        Fri, 28 Feb 2025 06:21:15 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:73ee:d580:e499:4244? ([2001:67c:2fbc:1:73ee:d580:e499:4244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5327f0sm89954975e9.9.2025.02.28.06.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 06:21:15 -0800 (PST)
Message-ID: <8c55efe1-f771-479a-a334-372b03c97054@openvpn.net>
Date: Fri, 28 Feb 2025 15:21:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 00/25] Introducing OpenVPN Data Channel
 Offload
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Xiao Liang <shaw.leon@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 steffen.klassert@secunet.com, antony.antony@secunet.com,
 willemdebruijn.kernel@gmail.com, David Ahern <dsahern@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
 <20250227082141.3513de3d@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20250227082141.3513de3d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/25 5:21 PM, Jakub Kicinski wrote:
> On Thu, 27 Feb 2025 02:21:25 +0100 Antonio Quartulli wrote:
>> After some time of struggle trying to fix all hidden bugs that Sabrina
>> has found...here is v20!
> 
>> Please note that some patches were already reviewed/tested by a few
>> people. These patches have retained the tags as they have hardly been
>> touched.
>> (Due to the amount of changes applied to the kselftest scripts, I dropped
>> the Reviewed-by Shuah Khan tag on that specific patch)
>>
>> The latest code can also be found at:
>>
>> https://github.com/OpenVPN/ovpn-net-next
> 
> coccicheck has a new nitpick:
> 
> drivers/net/ovpn/netlink.c:439:11-59: WARNING avoid newline at end of message in NL_SET_ERR_MSG_FMT_MOD

Thanks for the report. I'll get this fixed in v21.

Cheers,

-- 
Antonio Quartulli
OpenVPN Inc.


