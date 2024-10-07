Return-Path: <linux-kernel+bounces-353110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 017159928C2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765161F24D6D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9559F1AFB39;
	Mon,  7 Oct 2024 10:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="OwfHSKDB"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B981231CA9
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728295466; cv=none; b=Ewhq36xRH0dLJB/lYJ7WrTUcNz5s7cCr+ekjM8+/FIeJZtYXtt/e04MzSgPva2V2NpMLkEhAWly+ODvtWg8q69rkAIsCQZBuWo4zUa9dP4XsuDISIGYZWliDDavI9ksR6Cc17Pg5UXIf0ljd5HXGLUUhWC2VTropxkhpeLhTd5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728295466; c=relaxed/simple;
	bh=ChnF36euALpyYjrslbFWg1ZKHmzg/57fTmXHPuGpKQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DY62ihtTiym4pvie2CQQcK33kWVOQ4AO3WcdeBFOOUu+pKBs1NrYWkr965DxcIACbJMyMV3bhYoAD3V2oWoa4f9g09DK8zUlYwp2OKVl55yRdf7OJvOIHJEgNJtnoggrixSHxn+9n1RnIz9sq6HLoFUzs6h28AVjK6BRJFmf0jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=OwfHSKDB; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37cca239886so2545239f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 03:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1728295462; x=1728900262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NuQVqhahf1Jz4tT/fjagwPK72T8/bE0LW699MmZGlaQ=;
        b=OwfHSKDBF/XoVENQojW5Vu2AudD++ZgFnzc21DmcsVCYf3LrwBLynRjiQ3iPunMNup
         mIqsu0891LnhvXcIl6AbMkPyQL3DWkeZGxJWGifdWjs9HZghL2ih8bIsICW80KeA4pTp
         fPoWlfFR7SlGA/Tyxo5j0HctC8MpoK0Jp9A1kTSER6haZnKzHMWqMGIhgEzzYUUAp9pH
         0Igm44L0srar4Hf7cekjKvVIBby5bXK8vUQGdgGGxJR8auarxxc1ENjMf3kowByiTVMK
         3YbV5xGio1sve5W+llxChySzTGTH0YXjNLJEJWhDajolQ4EN810CQvEBKRtneUXNuhEG
         9WDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728295462; x=1728900262;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuQVqhahf1Jz4tT/fjagwPK72T8/bE0LW699MmZGlaQ=;
        b=H8zGM5kewRpXrIArVQTo/Wg7ANLU8lqhea1W4Lqd8PcOuz4ywGJurAV2ORDBNFUZQW
         JKQIiQAFdQmrx3Wm1fSBd4rfaQEdid42hMdkIC/hEy2mzelOSJPgytPfu4RqtpC3AV/l
         KeH2R88U3m96IYLnD9nMyPK2jdIcOQarHI1FVpTrgntYHvX+78/OnK2DXRasTKZbFpDW
         jpD0LKhdfrQmhUolR4yhddXXxBo+vXIUTGX2MYOzAb5250J+XekeLaR1Nqs6kEBbfQnB
         TDN2Y3OeoTEMELjwfR2YK87T8+NON/K7mSAH0XVPuxukBxECxRRnjiMxwJ3ms8QBjviW
         mFIg==
X-Forwarded-Encrypted: i=1; AJvYcCWC1ERniwTOuC9/tNip3zdLN/A2MmDZEXPs6FzMxnl0uk1Jqxhv0q9MOF4wIZpUJa54hqGbACg/tSMy3XA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyESIlC1bQBofI3CXVFsw8n7xFOHyPfE3hXE6rkYLdO5VYXMtHj
	9EriU+VVZNaxa1uIM7h4+IDlkA21JmLmpZcewHo8snXKMMCMmSZPw9H7LCa46OE=
X-Google-Smtp-Source: AGHT+IFiOMOtDWrPLesR2YJI+T+TdB6ghsVgNuyfeGu7LKXq2EfNxD4KWjWvAly9Tu54tUuOs/JPVw==
X-Received: by 2002:a5d:598c:0:b0:374:fa0a:773c with SMTP id ffacd0b85a97d-37d0eafa3admr7113034f8f.47.1728295461909;
        Mon, 07 Oct 2024 03:04:21 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:efc3:b0c0:f886:97ea? ([2001:67c:2fbc:1:efc3:b0c0:f886:97ea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f25asm5354842f8f.11.2024.10.07.03.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 03:04:21 -0700 (PDT)
Message-ID: <e09ea6b5-fe0c-4f90-8943-83aa410ccc1f@openvpn.net>
Date: Mon, 7 Oct 2024 12:04:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 01/24] netlink: add NLA_POLICY_MAX_LEN macro
To: Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 sd@queasysnail.net, ryazanov.s.a@gmail.com
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
 <20241002-b4-ovpn-v8-1-37ceffcffbde@openvpn.net> <m2msjkf2jn.fsf@gmail.com>
 <20241004063855.1a693dd1@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20241004063855.1a693dd1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 04/10/2024 15:38, Jakub Kicinski wrote:
> On Fri, 04 Oct 2024 13:58:04 +0100 Donald Hunter wrote:
>>> @@ -466,6 +466,8 @@ class TypeBinary(Type):
>>>       def _attr_policy(self, policy):
>>>           if 'exact-len' in self.checks:
>>>               mem = 'NLA_POLICY_EXACT_LEN(' + str(self.get_limit('exact-len')) + ')'
>>> +        elif 'max-len' in self.checks:
>>> +            mem = 'NLA_POLICY_MAX_LEN(' + str(self.get_limit('max-len')) + ')'
>>
>> This takes precedence over min-length. What if both are set? The logic
>> should probably check and use NLA_POLICY_RANGE
> 
> Or we could check if len(self.checks) <= 1 early and throw our hands up
> if there is more, for now?

We already perform the same check in the 'else' branch below.
It'd be about moving it at the beginning of the function and bail out if 
true, right?

Should I modify this patch and move the check above?


Cheers,

> 
>>>           else:
>>>               mem = '{ '
>>>               if len(self.checks) == 1 and 'min-len' in self.checks:
>>
>> Perhaps this should use NLA_POLICY_MIN_LEN ? In fact the current code
>> looks broken to me because the NLA_BINARY len check in validate_nla() is
>> a max length check, right?
>>
>> https://elixir.bootlin.com/linux/v6.11.1/source/lib/nlattr.c#L499
>>
>> The alternative is you emit an explicit initializer that includes the
>> correct NLA_VALIDATE_* type and sets type, min and/or max.
> 
> Yeah, this code leads to endless confusion. We use NLA_UNSPEC (0)
> if min-len is set (IOW we don't set .type to NLA_BINARY). NLA_UNSPEC
> has different semantics for len.
> 
> Agreed that we should probably clean this up, but no bug AFAICT.

-- 
Antonio Quartulli
OpenVPN Inc.

