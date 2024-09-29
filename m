Return-Path: <linux-kernel+bounces-342776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939DA9892E6
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 05:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54940B23744
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 03:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2521F60A;
	Sun, 29 Sep 2024 03:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VX4d+Sog"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911DC1CA9C
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 03:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727580160; cv=none; b=ZLsacuDQzg9LrQxCHkFPSajd/i5v9f9A3JnarBVXyPVrKDS74tLj7F2wsv+Nk680opaoKOf92mmiERtmpsWA8KN4JK+5tv2t27usz7+W6RDAsTdxoeYH1AeUU2KTSJlaABzecIo3wQog82Zk93KJEbHSeiCIxZI/dfgAxSTZX2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727580160; c=relaxed/simple;
	bh=/qQHGXMBRxgD7tarft35dDgtu+LcjaHMvPGofCY382Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=taXnsZDx/F0lfAOXnqll+20aNavEaR3/oqp3HSbxLZH6VzNrHjvX5XJgMyHOkbG5ofVuVAvsFpJaaCV5GkudJJbbsI/fKn+nEg7lZUCxbYbImoTGorDQlLcc+iMXB+ozcy8uY27KoMaLqHYk3R36teXH7aIXZhJz6Biu9hSEIpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VX4d+Sog; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20afdad26f5so42961265ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 20:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727580159; x=1728184959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w5EeJS2SxN3wIbrIH/sFxTdvIsyXyr2jHCxWfXzSPIo=;
        b=VX4d+SogcYAuTct7qYIpum17wd+qgVN7MGhweotbO5pjsAub9Fv/vk+a8Lf3Mov1m8
         OU+u1sAC/P7Xc/t6DG7Dav/3OHLh8y0xFKgTTMSni8r/YuUSphFjIBzatxPNCPmrSLB2
         X71TX1tpG1pXU7oY67QHyetvBqbaLWEm+wCezyfrEUNG10Y8a1pHRZyEyBbONQLBQdeS
         WAjZFT2v1Xetzsj2RLwOPCe1ujLD5tBIWF+p60RcNbNoEip36xeyt16/nJf7UU0X+8zF
         aw7W+Vs0wlGJi/TkNdQ/zCguh7MZjf8umNu4tsCE+JKdKvZhfbVKX3SeC6QGZbI32/Wv
         x8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727580159; x=1728184959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w5EeJS2SxN3wIbrIH/sFxTdvIsyXyr2jHCxWfXzSPIo=;
        b=QyPi0sFMZKwyxRx1pW3Lq/Eh9+Pj2JPRbn6ToeCjDqcMyOLWphFjfAFwWEekjIwnuO
         0FLnIpxnW755zD8Wx8se62rsdNt4Z1AO9o7i6sks7IdgzgR1q0Bc1x6Mu3kNDpVRbBVZ
         IM8/rQP1cQxImaf6VY9TnyLTkB7z9xYaHcN1gc0zPT1uqfkjlqdZ2GFDKRyPvPyi/XT6
         ZcK45/RJNeCInJT00KZFptulDZkONPsIUm3EVooZyhe5LSH8OiljNCcQC/Nl7Lm4nXbC
         /FjdYVD5pyiIn3NmuSZ5SA40sg6fV2Hxrd2L04vwqn2dk04+JaYXwk+pTwVsOju66MUY
         garA==
X-Forwarded-Encrypted: i=1; AJvYcCWHAlm5jVfoyBzuvzAozLgIVXVcL7sS3heFQYiGYI8aRbDERiVmvlgxdeYuAZH6WkNxPcIaCk/hnwqex1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwITp2wXvJLryeBYIEsQDjGgJvcRkKo6++x1wMuuBGmU/0QqjPt
	ExgSSDVt1OpzmmCZ9Rl82Xm7/DLWcxTt/ekLfIIHbuovBrTlfJGmaeUagnFS
X-Google-Smtp-Source: AGHT+IE7b+rwBfa27XQUdsSyohOCJKsfDLEH3mlcEmTkt+HCivROF5x9rGMCzXvW5uTxaU6z6y6p9A==
X-Received: by 2002:a17:902:fac7:b0:205:810a:190a with SMTP id d9443c01a7336-20b367d5b4amr93678665ad.2.1727580158756;
        Sat, 28 Sep 2024 20:22:38 -0700 (PDT)
Received: from [0.0.0.0] (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d5ef69sm33586005ad.6.2024.09.28.20.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Sep 2024 20:22:38 -0700 (PDT)
Message-ID: <008faf5a-a377-4b9f-81b0-94fa992f0035@gmail.com>
Date: Sun, 29 Sep 2024 11:22:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] rslib: Bug fixes and improvements for Reed-Solomon
 library
To: Kees Cook <kees@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20240924123141.16962-1-zhangboyang.id@gmail.com>
 <6a92d261-8cc4-459a-a44f-365f9d41f289@infradead.org>
 <CAHk-=wgs70xZ_F=3+52cuhXNsK3eDWVp3PJtExbCAQrUdhcRwg@mail.gmail.com>
 <202409281410.FBD093EAB@keescook>
Content-Language: en-US
From: Zhang Boyang <zhangboyang.id@gmail.com>
In-Reply-To: <202409281410.FBD093EAB@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/29 05:11, Kees Cook wrote:
> On Thu, Sep 26, 2024 at 10:12:39AM -0700, Linus Torvalds wrote:
>> On Thu, 26 Sept 2024 at 10:03, Randy Dunlap <rdunlap@infradead.org> wrote:
>>>
>>>
>>> If I were making this patch series, I would send it to Andrew Morton,
>>> but if Linus takes it, I'm certainly OK with that.
>>
>> I don't feel like I have the expertise of something like rslib, and
>> would actually suggest it go through one of the (very very few) users.
>>
>> It's just pstore and some NAND chip drivers, afaik.
> 
> I can review this soon and can take it via pstore; I'll probably go poke
> tglx though, since IIRC, he was the original author.
> 

Wow, that's great. Thanks for reviewing.

Zhang Boyang

