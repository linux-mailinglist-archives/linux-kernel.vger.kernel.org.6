Return-Path: <linux-kernel+bounces-430407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5564B9E3092
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F5D28347D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19122DF59;
	Wed,  4 Dec 2024 00:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BQj0VArR"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8C48F6E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 00:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733273808; cv=none; b=GnlDrp+nkFMm/uUAQPisWhSapdC66J8lMaWHc4v5jt27rjuu7+bwMsRUWLis5IvoAEIdaUSlC9sxf/RVtqpGU/QxxfICvPXXHg7sqpf4PjRAM1wgsdsH5GbiwRWrH5OdaEoJaQPCyKrG2gbikGgrj5xSXnDCSlfj0E4B/1JjWgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733273808; c=relaxed/simple;
	bh=njeG8iD6mfq353aOT/B6XJHoA7kAILspGLzemTxfWk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NBC1Pstq4DIxWI6szEsCML2vLiuANNvZ5/sVyGyuMzgTxPNgjC95MSVtjsTFeeqNu15SPJgfbw2PUKj4LOhVN/Ik7qmKsdwcggJiq0q2zAqLJLKdeX+isyhYff5SLGU4hGTLOH37DiZ9KRnzd/AEGY2NwyRQeT6k0VaRvqVCw0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BQj0VArR; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-843df3c4390so213141239f.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 16:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733273806; x=1733878606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=00R01WB09ikJ7TfGUNEYyTuGf2VppHlK5EcxdhhTed0=;
        b=BQj0VArRpjvx6EMIW4Xx0q2SI1Od9gsesH3sNiUA3ZpEZ+s+W7jl/NxATj54ZzNx/2
         uU41sHaCfLhKWbiukYDeihhIKypLZ79AevVB4VWpy3Hbgqg4NLK1pUEH8KbVSq07njs9
         j6vIrEs88gi3GKF3ASAB7+DkoiJLZxMU2igIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733273806; x=1733878606;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00R01WB09ikJ7TfGUNEYyTuGf2VppHlK5EcxdhhTed0=;
        b=XC8Lkii5Pt2QG93AuR0dtz0hnekDqye9Zz8jC2H9U8dbyaOoEIhrAywU/pJmUf+6bi
         XgL0dPAjiV7813YKi9Ndgt7hIIwh/8DhsMYlGljapRVmhWPJ5m+hErDvllvCssS8P/6E
         TZsY1BZEGJUnu8MFefXdSSpLI/w+0DCVBUskxXOr0iPJTQeO40ShMw5HV5t9A0aZWwCR
         tXoFjFLycyru55ZtgVaEhCgaP/YHzTqU7FWEN6UC51cZ4/tlFaj5Wo02HQgRXTUMkJMo
         X3BAE5tbYJv/kdfyTkTiruUwey0ENDT1whDeEGBPsE1tizAA0M1ROG+c80WJ5lwCHxov
         EeGA==
X-Forwarded-Encrypted: i=1; AJvYcCV9UtO9i5GChRkfEcQpuGVegVx4LAqOxgaVCcyLVBrI7KDv+nwmT6ug45dTiV7XiUd+/ybk84025xvqKYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0geXDZtSnQ5fwgxH7hZklKoI6fP49egpYM9yi+xNZkC8BxqRZ
	pEFSzZQ1sX3Cp2VXyIyXfMT4CQtzTCsng9nBhjI+New6tchaHImraRvOJnuDVtI=
X-Gm-Gg: ASbGncuyC/ruZNjHHS9GjXHOYLIatFaPcOKLH2q8F0HNYRh2hG33nFlFo8WRT4prp6d
	9NvP1ekNlalTfl6/yBTs8oakO/Hqc8/ih4l/r8EHcjGvtnoWtxX0caofw9jkDQ2uc1TsBcbltDg
	epSDo0b6ySlKI0U983gtK3BiEQdKaPLlt55yMNPd33JCkNNLxpmeXRfFQ/nt+YXb99vOIo1r0Wh
	z+3u1UKNv3u1QFr0MJE8g5nNC+PAGTGk5XIX4v6ePrFxEjY0SyJUFIx27lTLg==
X-Google-Smtp-Source: AGHT+IH+PqwQh1gs7efqVjznnXTs3fzgoxUSDkb9HL2ZMsz1+TCwuZ+tPfsuHqLHTOq0KW/t/IoH4A==
X-Received: by 2002:a05:6602:3405:b0:841:a1c0:c058 with SMTP id ca18e2360f4ac-8445b577d49mr667540039f.9.1733273805753;
        Tue, 03 Dec 2024 16:56:45 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-84405f11824sm273367739f.30.2024.12.03.16.56.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 16:56:45 -0800 (PST)
Message-ID: <6288979d-3024-45fb-ba8c-f4c22149ae9a@linuxfoundation.org>
Date: Tue, 3 Dec 2024 17:56:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Make Helped-by tag supported
To: Matthew Wilcox <willy@infradead.org>, Dragan Simic <dsimic@manjaro.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Jonathan Corbet
 <corbet@lwn.net>, apw@canonical.com, joe@perches.com,
 dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, workflows@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, wens@csie.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1730874296.git.dsimic@manjaro.org>
 <87h68k4esb.fsf@trenco.lwn.net>
 <cabfa180845df30bfb7a541a701a57e9@manjaro.org>
 <672e628111eb0_10bc629436@dwillia2-xfh.jf.intel.com.notmuch>
 <28c0a0ecc2e2880e4cb98449767e2842@manjaro.org>
 <9ae99d14dcd8867333fceacfaaa4430a@manjaro.org>
 <Z03qJKpjBqJ9vAhY@casper.infradead.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <Z03qJKpjBqJ9vAhY@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/2/24 10:11, Matthew Wilcox wrote:
> On Mon, Dec 02, 2024 at 04:00:47PM +0100, Dragan Simic wrote:
>> On 2024-11-09 04:10, Dragan Simic wrote:
>>> On 2024-11-08 20:12, Dan Williams wrote:
>>>> Dragan Simic wrote:
>>>>> I'm fully aware that we may be reluctant to supporting
>>>>> additional tags,
>>>>> because we may then end up with a whole bunch of strange tags
>>>>> that might
>>>>> be a bit hard to understand and use properly, but I think that adding
>>>>> Helped-by to the supported tag list may actually be a good thing
>>>>> to do.
>>>>> As described above, Helped-by fits very well between the Suggested-by
>>>>> tag and the Co-developed-by + Signed-off-by pair of tags, and I think
>>>>> that providing the right level of attribution may be beneficial.
>>>>
>>>> Patch attribution is separate from giving thanks. I would much rather
>>>> someone take the time to say "Thanks" in the changelog with some
>>>> supporting text rather than boil down all the myriad ways to be
>>>> thankful
>>>> into a generic tag. "git log --grep=Thanks" often yields valuable
>>>> details, beyond just attribution, on how people have helped each other
>>>> develop this global project of ours. If the introduction of Helped-by
>>>> would replace even one authentic "Thank you" note with a generic tag
>>>> then it is a net loss for the community.
>>>
>>> I do agree that writing "Thanks John for helping with..." in a patch
>>> description would be nice, but unfortunately I've seen multiple times
>>> that people don't enjoy writing their patch descriptions at all, and
>>> just want to "get them out the door" as quickly as possible.
>>>
>>> With that in mind, making Helped-by tags supported would allow such
>>> people to at least quickly mention someone they're thankful to, which
>>> actually wouldn't prevent anyone from saying the same more verbosely
>>> in a patch description.
>>
>> Just checking, are there any further thoughts on this patch?
> 
> I agree with Dan & Jon; we don't need this tag.  And if someone's doing
> a poor job of writing commit messages, they need to be helped to write
> better ones.
> 

+1 on this. I don't think we need yet another tag.

thanks,
-- Shuah

