Return-Path: <linux-kernel+bounces-252089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8368B930E36
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA84C1C21064
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 06:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FF31836C3;
	Mon, 15 Jul 2024 06:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a16TP1SG"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E6E13A89C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 06:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721025872; cv=none; b=lFvo2EyAzlHj7EwYid3yV8niRJ8S5K4X5YbvdFPzEqBZXQ4do3AOLo6P4OCC/WNT5WMObEwjfmmXVShx9mqGDgEPeZLTlGCiATDMRDzwrGDBkMpVNtMIwZGO/8PtcyjH22yMjEWzdcsNy5xrxxLj70dfai/ze+vOw+ogcsJo9ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721025872; c=relaxed/simple;
	bh=SIpGoSfSG/s2RvfkNkjaKi3NpWVzTcigZAp5NnPpxKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sx9XYSE7KDyCWN09p8LR8G7kS/ns4JHJvHhJgvZVqSju6AA0wA9dKaMBDRxcwQAxA80yOaBwoDxXpL2oxEqrAy8GBJvPCfmpeSVzvQc6zkO3riYDx8J9DRTe+ft0ipCkc0PLHOjcnYJyrTAT05wvRYR77PUGeqpoAYVa/1h/6Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a16TP1SG; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eecd2c6432so53278071fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 23:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721025868; x=1721630668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qhNlqzcdWExyhzplzNE00UFBpNxCYIJNzbRZyeya2F4=;
        b=a16TP1SGYVM8N6Q6TQcAR9GrMKtEePkmlgE9aF4CgXi62HVvM5VnSspyZ2EhsL7frV
         gaePT2Rg+Dp7uEIPmdet0I+Y0Y8HbnhiNkik6HdhZGoJHFgv4skzOh3M+xPAUcM6on/E
         v0w0uWoN7Q0JygifvCCB7QhmX06fWgmj8+pEUCU7e/wZWqYDivCCLc2znmsbwn0FOHit
         S8pNedFOdYQ+CpSWu9TP/fFKMr7mdYSadM1hDRdsWgeNpwQO3b17RBTYjU+IQZeGrfjd
         WNI/EK0y2BSGucAN3/SAQOC0Gl8kZeZbwsmDZJPeG2xftf9Hfq7o9fk6tLgHfRYf2CmN
         tByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721025868; x=1721630668;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qhNlqzcdWExyhzplzNE00UFBpNxCYIJNzbRZyeya2F4=;
        b=IoKZcSR7sjLJ/Dos+ScHmlnzw1kJL4uOvMKyuYos9vRKG+qIwHNRmR62Gqv0U9wIly
         8HTwig71NggQ7MdjTi0Mon/pkPzrCmj5ALj5ZJWk6CwqLSfTvaByNydayKQ3CuzRgHtF
         YubaGhAin/SHKvk3QUjBNCpxWhxvgcOG62E+8XdoYWCdnHv7VAgUW2R4XskOxPMiXO5m
         V/vLKC0bI6VDViynMuqfIUOY+yKClsNLm2pW5eZ72J8Anhh+3/j+guniTxNgccvw4wRJ
         zRPvJzlwLgMe9+pkbu2SXr5gSoTgMkxKnO8a0FnhZy7Jsq+Lmu1M1Tqu0J8RMwcq2iAU
         QpcA==
X-Forwarded-Encrypted: i=1; AJvYcCUpPJLIHcpbrkxlEHJdYDKlEVYx/jJK0+fQ6F2l3dvMawEjRG402jd7y6ENH7UFORxYwPQg+RMG7OUYzQepmJK1e1Gu4WPfS0vdn0RE
X-Gm-Message-State: AOJu0YzoahQ7y/L8xk+W+3DStIUzYI/Ur5u+qnJ2DMI/0z8sCzikMAuV
	SwEvPAyMwlaFwqexS9spCbrdiqRaQK6mxoli0eo8fCY9BmqdhoEO7iV3Ms5ZUNc=
X-Google-Smtp-Source: AGHT+IFGvOvCumZZy0CLigPez+vhyb+DpIdvXUJbXVYu3i0ze0twdJqy/GtPIdkTGP44+SMko+4gTw==
X-Received: by 2002:a05:6512:3b9d:b0:52b:be6b:d16a with SMTP id 2adb3069b0e04-52eb99a3526mr16061303e87.31.1721025868541;
        Sun, 14 Jul 2024 23:44:28 -0700 (PDT)
Received: from [10.20.4.146] (212-5-158-53.ip.btc-net.bg. [212.5.158.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5a38acsm184800966b.38.2024.07.14.23.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 23:44:28 -0700 (PDT)
Message-ID: <e0de0183-00d1-46a5-ba2b-6df431b58743@suse.com>
Date: Mon, 15 Jul 2024 09:44:25 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] x86/fred: Parse cmdline param "fred=" in
 cpu_parse_early_param()
To: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org
Cc: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
 andrew.cooper3@citrix.com, houwenlong.hwl@antgroup.com
References: <20240709154048.3543361-1-xin@zytor.com>
 <20240709154048.3543361-2-xin@zytor.com>
 <98b2d56f-767f-4074-a9f2-4d993880e2a5@suse.com>
 <7fad52e6-83cf-4c17-9b3f-4dfa087f8fc4@zytor.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <7fad52e6-83cf-4c17-9b3f-4dfa087f8fc4@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12.07.24 г. 20:40 ч., Xin Li wrote:
> On 7/10/2024 11:53 AM, Nikolay Borisov wrote:
>> On 9.07.24 г. 18:40 ч., Xin Li (Intel) wrote:
> 
>>> @@ -1510,6 +1510,11 @@ static void __init cpu_parse_early_param(void)
>>>       if (cmdline_find_option_bool(boot_command_line, "nousershstk"))
>>>           setup_clear_cpu_cap(X86_FEATURE_USER_SHSTK);
>>> +    /* Minimize the gap between FRED is available and available but 
>>> disabled. */
>>> +    arglen = cmdline_find_option(boot_command_line, "fred", arg, 
>>> sizeof(arg));
>>> +    if (arglen != 2 || strncmp(arg, "on", 2))
>>
>> I'm confused why you keep perverting the calling convention of 
>> cmdline_find_option. The doc clearly states:
>>
>>      * Returns the position of that @option (starts counting with 1)
>>      * or 0 on not found.  @option will only be found if it is found
>>      * as an entire word in @cmdline.  For instance, if @option="car"
>>      * then a cmdline which contains "cart" will not match.
>>
>> You should only care if arglen is non 0, which if it is you check if 
>> its value equal 'on', why bother with its starting position?
>>


Actually, I have quoted the wrong doc, the correct one is:

"
Returns the length of the argument (regardless of if it was
truncated to fit in the buffer), or -1 on not found.
"

> 
> Well, just look at how it is used in match_option() in
> arch/x86/kernel/cpu/bugs.c and arch/x86/kernel/cpu/intel.c.

Exactly, in bugs.c it's used as I've suggested:

In spectre_v2_parse_user_cmdline it checks if spectre_v2_user is present 
(if a negative value is returned) and if not it returns some default.

In spectre_v2_parse_cmdline it's used exactly the same way - return some 
default if that function returns a negative value (spectre_v2 check) or 
return some specific value if it found nospectre_v2.

And in sld_state_setup the code just checks for a non-negative value i.e 
the argument has been found.

Otoh, I see what you are trying to say if I look at the usage of this 
function in arch/x86/boot/compressed/acpi.c


Still I find this convention a bit counter-intuitive, but given it's not 
a precedent I'm fine with leaving it as is.




> 
> This is a short version and it will be expanded once we have more
> option strings well defined (match_option() should be a common lib
> function then).
> 

