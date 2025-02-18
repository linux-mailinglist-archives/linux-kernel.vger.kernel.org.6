Return-Path: <linux-kernel+bounces-520228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFCEA3A73C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AADB7164B09
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5AC17A30B;
	Tue, 18 Feb 2025 19:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="NfGQ9oh4"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3520821B9DF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 19:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739906469; cv=none; b=CZ189l2U1X/mnA5q4vDtu27heYyXKEWZ0FJTm7tbueKarS/YPqYip7VMRvNciuPxCIj8UIWKfrdZ060+ucg6Ej9zy2cZE5rMDswOlpGzWi38vUT/gZQ1ZXa3FGfD2aSEj+zUtBuYRG3GdSEdHDHaaNdoZ/h1VtweRrsUtKb03Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739906469; c=relaxed/simple;
	bh=ycHpgNXBROG4geZcA2CLnVbCmLIr1ttO94m1bwrYxR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D5KdgWm2dM2hkPJClMKtNo+YSfx7azCUPF8d9PC7A84MaZLeG+CmO5sTjXRW3fseyxN4eZ7o7aKDYOu1wNiia+6ZSTT6R4Hk5nAykCtKWdcFcp0W9SgaLRsfBaZGVpoUkyxbKQIhKH+SGn/lqaP9BdwiHfXAaeAhicOaEHtqobk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=NfGQ9oh4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-219f8263ae0so108389745ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 11:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1739906466; x=1740511266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=StJPYwiHJgYBwwR4mAHQTkJhRCTzPfRYD9Ve0/q5EKM=;
        b=NfGQ9oh4G2rrb4i+8BV0jibf/R2LBoks35U2wFnhPd+BoazsPTpUJ29YFnTVUGt2wx
         zf+rUtCMDIH2fXdq1F3TvgCh0gzjI+X3xN5DizVhOuZjAim0rjoM4oQXUaL0PBVM046S
         8/Xzvlewz5OgPCxueZ6RSoC5SOL51G6/seaXBXa8SFol7d0upRbmqYQ/ML6X4bHGSbKM
         Qut7rSRy9P12puBQEODd3fShO0FsXPu5MwzIlKRx3k1iGPDpSo8yFUUN2+vYATLmwZVH
         JvbNfhSGqjNxKWanYxm3XuUqx3M9ZtIVQjLYhyH0x9cORsJQFaXAobHFgl6BQ0FJQ0Ru
         xO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739906466; x=1740511266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=StJPYwiHJgYBwwR4mAHQTkJhRCTzPfRYD9Ve0/q5EKM=;
        b=sF1CkBMtbrbaqXqgLPyNgPXIyYcWQte7KXtOq/Unf0mkTA9mEjLz9TACVtdDfmv8px
         AFrwzF0yOFgkvS4QafHQbhytir5fHfMUyxq7x16tYZX9GMCcLQZIxjpL45TAbvFhHodl
         7GsjrK2Ymau1RsbDQnCV5g5r/CzPcZeVcrjWk/uJ66d9HFQyPQw7aWJG1bmCUEKQNKkz
         dNhAnoENma8YbylCINuYNBhcMz2ItdYBdPmVpyubcZpCc/durACtqyyDPoAiDHLpidoM
         gs1NgblT9ptY7ytumQD3OWlPxrxSIBzd0dwhok+pIyydGj30NlB6N8VaDXx/XHRkaKxQ
         1BAg==
X-Forwarded-Encrypted: i=1; AJvYcCXHhM2AwSITHryH2OULgifBCNE19ZkFNDBvae6LwDm8rK057YD1QDvyYxJNLxwyaRkm7gYpmGJ5G1OPSIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YziAp/qqlz/kj6CfL4mS/bgnrDRqCF8espLU2nni3cu20ZRIJdf
	OslSrkrFcQyJDiRQm2avzxJxsdCFVCAGmgfegGeyH0ElSmIFPKQqUvoxAKOt8g==
X-Gm-Gg: ASbGncv9y9jP56Gsz2ucuUSlSr6giuXFNZW1hS7D8zcUlUWbNuMpKc+3ffTbZZNqikU
	/z5H0DKFv7FyOEQo6xNaCF8sjenIvbzSymvN8aJjw+sNOBdApjar3cB6G8saJwsx172seIoOcm/
	i+n3ThCLIB13Kb1QtR99zBbjATaGDxnBJJ4CcQgAdH7CPKbZ7s/Rv/Z2BbYVwq0YoiXUV+uj6uO
	Oyd+1v+0DJbCySKeedO/AinpK3IC58AUxffcKpLG6t1g9BjiIpgd2tp4ESmCwB+yBRe5jIDCzUI
	zAueiTAN8yBg7sk20ROsLTO4eDXrgQLbPVU=
X-Google-Smtp-Source: AGHT+IFxUEDUhzAApZkHHX/oSC4gIXTNX1cKTIHtfqrqyFyEKSK0fwJXuNzMhtQUMc6tGwezwQKFLQ==
X-Received: by 2002:a05:6a00:124e:b0:732:23ed:9470 with SMTP id d2e1a72fcca58-73261901144mr21327160b3a.23.1739906466396;
        Tue, 18 Feb 2025 11:21:06 -0800 (PST)
Received: from [10.140.24.106] ([38.104.138.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732427801a8sm10451078b3a.167.2025.02.18.11.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 11:21:05 -0800 (PST)
Message-ID: <c85e1ddc-71b6-4537-a80f-cd37f61ab6dd@tenstorrent.com>
Date: Tue, 18 Feb 2025 11:21:04 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] riscv: implement user_access_begin and families
To: Ben Dooks <ben.dooks@codethink.co.uk>,
 Charlie Jenkins <charlie@rivosinc.com>
Cc: palmer@dabbelt.com, aou@eecs.berkeley.edu, paul.walmsley@sifive.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jisheng Zhang <jszhang@kernel.org>
References: <20241118230112.2872978-1-cyrilbur@tenstorrent.com>
 <20241118230112.2872978-2-cyrilbur@tenstorrent.com> <Z4rl8BgoV8tygCn9@ghost>
 <b45aab1e-6d37-4027-9a15-4fa917d806b9@codethink.co.uk>
 <e4a4c688-b78c-468b-8196-68d2df980167@tenstorrent.com>
 <a994e94c-3211-4bb4-ab41-71a2c1abebd4@codethink.co.uk>
Content-Language: en-US
From: Cyril Bur <cyrilbur@tenstorrent.com>
In-Reply-To: <a994e94c-3211-4bb4-ab41-71a2c1abebd4@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/2/2025 3:16 am, Ben Dooks wrote:
> On 13/02/2025 17:07, Cyril Bur wrote:
>>
>>
>> On 6/2/2025 1:08 am, Ben Dooks wrote:
>>> On 17/01/2025 23:21, Charlie Jenkins wrote:
>>>> On Mon, Nov 18, 2024 at 11:01:09PM +0000, Cyril Bur wrote:
>>>>> From: Jisheng Zhang <jszhang@kernel.org>
>>>>>
>>>>> Currently, when a function like strncpy_from_user() is called,
>>>>> the userspace access protection is disabled and enabled
>>>>> for every word read.
>>>>>
>>>>> By implementing user_access_begin and families, the protection
>>>>> is disabled at the beginning of the copy and enabled at the end.
>>>>>
>>>>> The __inttype macro is borrowed from x86 implementation.
>>>>>
>>>>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>>>>> Signed-off-by: Cyril Bur <cyrilbur@tenstorrent.com>
>>>
>>> If we're doing this, then saving the STATUS.SUM flag is going to
>>> be more important than before. We had this discussion when the
>>> initial user-access with syzbot stress testing turned up.
>>>
>>> We partially fixed this by rewriting the ordering in the __put_user
>>> function to stop the 'x' argument being evaluated inside the area
>>> where SUM is enabled, but this is going to make the window of
>>> opportunity of a thread switch much bigger and the bug will just
>>> come back and bite harder.
>>>
>>> If you want I can look at re-doing my original patch and resubmitting.
>>
>> Oh! Could you please link the patch? I haven't seen it and can't seem 
>> to find it now.
> 
> https://lore.kernel.org/linux-riscv/20210318151010.100966-1- 
> ben.dooks@codethink.co.uk/

I agree we want this patch. Or at least we want clarity around calling 
schedule inside SUM enabled sections.

Other arches are stricter about not calling schedule at all. I'm not 
really going to advocate for one way or the other right now but I 
believe your patch would solve the problem.

Cyril

> 
>> Thanks.
>>
>>>
>>>
>>
>>
> 
> 


