Return-Path: <linux-kernel+bounces-406460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D96A9C611B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B5BBB34DD7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EDC214422;
	Tue, 12 Nov 2024 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NfnSOfX1"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4391B2141A1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 17:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731433474; cv=none; b=t3/S+WIXhxuUySArXfinYMfomiEpIJLb7amxpPDPIISulw7yWSXxp6/H0P/9yG2k97uEeursiFJV7gVPc+vI5Kpqciix4gicSSOqzYLeV6S1ZWJ3wHtHkgotnHUtM6PaRzM1hsExPk577E2Lfqh1yO78xAKj6DuMPdvjPcd4Unw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731433474; c=relaxed/simple;
	bh=y4lqmUbMc1YD6SObguGdeCheozLDWGjBcGm+iitzX+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+q4t06siDBKFesxYDbiTVuRLUUpxz7soiLpRwPk8rULmykX6LcpCkv//FOmfF778KzFTPYXRNRrKCGceEyi7Vi4YTnL1TRUXMpYoqye1wvI2XO0GPVKnXLDki75OSlTxeZkAP4UrJ1Hm3+QPRlTmDR1RRBi9CgsgOzx+DMKrFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NfnSOfX1; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a3b4663e40so22085665ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1731433471; x=1732038271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6CO66k8vdkf1/7W/1z4gXCToQvhnpm1AaGiCOH2Lt4I=;
        b=NfnSOfX1DbC0/j0XDzmcXmQycvkUhOlDpseuM6hjn8bp4GwKCDEaRk0KdTKLF+jfON
         tQ6tMsn36JKFVu29d9fu5SyKnytDsoR06NKuNgSVkNuhDTLw2TbjWbBxQM1gIjAvygWu
         jaWzXNhPhR9+lakXb8K1VNLTZQr4mhs2HJKFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731433471; x=1732038271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6CO66k8vdkf1/7W/1z4gXCToQvhnpm1AaGiCOH2Lt4I=;
        b=XJ6LHmawV5NzXpj9lBKqbIGNizKfSyL5B9nQjLCH++pRAt0FqPkulLAzSjnvpNrhBl
         mtUTCD2Max8EFnyt0M8JxWmBU28Lj/civSX+vcwoKuFI7XmLGuHzS21ZI+/nPPcecx6x
         NChvxcIe8fspLdWQOpJwbQRNoX7Tvt3loI9TlK9W33xal+EsQ5iEKzAFwdf6JZqpCCGh
         RWj1EIJEZhvzXQGIQIZrSninKntkxo5rYSkzZSp3S+z0zQOxxFaZH0QfwKnfDTCg2sx4
         2Lwnl2cUVCJYDt/lROIN/C64p7bBjcml8FpjPpuvSe2mz6RbjacWmbnUdRHEROVODxWG
         KedA==
X-Forwarded-Encrypted: i=1; AJvYcCU6fyFhK3FNQy+zVxnvPhCb0Wl5Y14jSkhFxp/ivBua34JGGdaQ/2WdLiEMO3ysoEdXVu9d7Vcrsj1R1cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzVs1Zd7HKTV79+43H1twZHSqsK6ZmiAd3eE3hUlipnG9bFyWT
	thkgidi2FI+KpVMeNrRnF8KZmdPA04p37lUkLnegoiVKf4F5p8Wx57OGzxEM/Q4=
X-Google-Smtp-Source: AGHT+IECbH3zWN1YuCJheg/fgVRxjKKKOBSvEmpjxoBY/JlifdtX6pbym1LtHeex/CjxSfjeXuUQAQ==
X-Received: by 2002:a05:6e02:214e:b0:3a2:f7b1:2f70 with SMTP id e9e14a558f8ab-3a6f1a759aamr171429245ab.21.1731433471302;
        Tue, 12 Nov 2024 09:44:31 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6f984cc0fsm23324225ab.48.2024.11.12.09.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 09:44:30 -0800 (PST)
Message-ID: <ec850949-7987-41ec-ba1f-a0c90b465661@linuxfoundation.org>
Date: Tue, 12 Nov 2024 10:44:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/CoC: spell out enforcement for unacceptable
 behaviors
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: gregkh@linuxfoundation.org, corbet@lwn.net, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Miguel Ojeda <ojeda@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Steven Rostedt <rostedt@goodmis.org>, Dan Williams
 <dan.j.williams@intel.com>, Dave Airlie <airlied@gmail.com>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241108161853.12325-1-skhan@linuxfoundation.org>
 <ZzJkAJEjKidV8Fiz@phenom.ffwll.local>
 <ba3d5492-e774-452f-9fe0-e68b743c6b0d@linuxfoundation.org>
 <20241111223538.GD17916@pendragon.ideasonboard.com>
 <7d14de47-119a-42e4-a911-f8accae4abf1@linuxfoundation.org>
 <20241112051836.GF17916@pendragon.ideasonboard.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241112051836.GF17916@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/24 22:18, Laurent Pinchart wrote:
> On Mon, Nov 11, 2024 at 05:35:11PM -0700, Shuah Khan wrote:
>> On 11/11/24 15:35, Laurent Pinchart wrote:
>>> On Mon, Nov 11, 2024 at 02:50:45PM -0700, Shuah Khan wrote:
>>>> On 11/11/24 13:07, Simona Vetter wrote:
>>>>> On Fri, Nov 08, 2024 at 09:18:53AM -0700, Shuah Khan wrote:
>>>>>> The Code of Conduct committee's goal first and foremost is to bring about
>>>>>> change to ensure our community continues to foster respectful discussions.
>>>>>>
>>>>>> In the interest of transparency, the CoC enforcement policy is formalized
>>>>>> for unacceptable behaviors.
>>>>>>
>>>>>> Update the Code of Conduct Interpretation document with the enforcement
>>>>>> information.
>>>>>>
>>>>>> Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
>>>>>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>>> Acked-by: Miguel Ojeda <ojeda@kernel.org>
>>>>>> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
>>>>>> Acked-by: Jonathan Corbet <corbet@lwn.net>
>>>>>> Acked-by: Steven Rostedt <rostedt@goodmis.org>
>>>>>> Acked-by: Dan Williams <dan.j.williams@intel.com>
>>>>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>>>>
>>>>> I think it's really good to document these details. The freedesktop coc
>>>>> team is going through the same process, we've also done a talk at XDC
>>>>> about all these changes, and I think this helps a lot in transparency and
>>>>> accountability in practice. With that, some thoughts below.
>>>
>>> I've been thinking about replying to this patch for a few days now. I
>>> think I managed to sleep over it enough to make that possible.
>>>
>>> I share Sima's opinion here. There is FUD around the CoC and its
>>> enforcement process due to lack of transparency, so I believe
>>> documenting the goals and means is important and will help.
>>
>> Thank you for your feedback.
>>
>>>> Thank you Simona for your review and feedback.
>>>>
>>>>>> ---
>>>>>>     .../code-of-conduct-interpretation.rst        | 52 +++++++++++++++++++
>>>>>>     1 file changed, 52 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/process/code-of-conduct-interpretation.rst b/Documentation/process/code-of-conduct-interpretation.rst
>>>>>> index 66b07f14714c..21dd1cd871d2 100644
>>>>>> --- a/Documentation/process/code-of-conduct-interpretation.rst
>>>>>> +++ b/Documentation/process/code-of-conduct-interpretation.rst
>>>>>> @@ -156,3 +156,55 @@ overridden decisions including complete and identifiable voting details.
>>>>>>     Because how we interpret and enforce the Code of Conduct will evolve over
>>>>>>     time, this document will be updated when necessary to reflect any
>>>>>>     changes.
>>>>>> +
>>>>>> +Enforcement for Unacceptable Behavior Code of Conduct Violations
>>>>>> +----------------------------------------------------------------
>>>>>> +
>>>>>> +The Code of Conduct committee works to ensure that our community continues
>>>>>> +to be inclusive and fosters diverse discussions and viewpoints, and works
>>>>>> +to improve those characteristics over time. The Code of Conduct committee
>>>>>> +takes measures to restore productive and respectful collaboration when an
>>>>>> +unacceptable behavior has negatively impacted that relationship.
>>>>>> +
>>>>>> +Seek public apology for the violation
>>>>>> +*************************************
>>>>>> +
>>>>>> +The Code of Conduct Committee publicly calls out the behavior in the
>>>>>> +setting in which the violation has taken place, seeking public apology
>>>>>> +for the violation.
>>>>>> +
>>>>>> +A public apology for the violation is the first step towards rebuilding
>>>>>> +the trust. Trust is essential for the continued success and health of the
>>>>>> +community which operates on trust and respect.
>>>>>
>>>>> Personal take, but I think a forced public apology as the primary or at
>>>>> least initial coc enforcement approach is one of the worst.
>>>>
>>>> Seeking public apology is in response to unacceptable behaviors which are
>>>> serious in nature. These incidents are exceedingly rare. When these incidents
>>>> happen, they usually resolve when another developer/community member points
>>>> out the behavior. The individual responds with a voluntary apology to
>>>> mend fences and repair harm.
>>>>
>>>> The CoC  gets involved only when it receives a report which is the case
>>>> when normal paths such as peers pointing out the behavior to repair the
>>>> harm haven't been successful.
>>>>
>>>> This document isn't intended to be a complete summary of all actions the
>>>> CoC takes in response to reports. There is a lot of back and forth with
>>>> the individuals to bring about change before the CoC asks for an apology.
>>
>> See below clarification on above use of "actions"
>>
>>>> The CoC seeks public apology only when it is essential to repair the harm.
>>>
>>> Limiting the CoC committee to seeking public apology, due to what it
>>> means in terms of both process and goal, would deprive the committee
>>> from many useful courses of action. I was expecting you were not limited
>>> to this, and I appreciate that you are stating it clearly here. It is
>>> not however clear from this patch, and I believe it would benefit the
>>> whole community if this was explained better in the document. A more
>>> detailed description of the different means of action and outcomes would
>>> help balance the fact that the proceedings of the CoC committe are not
>>> public.
>>
>> The actions CoC takes prior asking for a public apology are working
>> with the individual to bring about change in their understanding the
>> importance to repair damage caused by the behavior.
>>
>> Since these are measures to bring about change, the document doesn't
>> go into the details about the logistics.
> 
> I think that's where it falls short. The private proceedings policy that
> governs the CoC committee (I'm not interested here to debate whether
> that is good or not, the question is out of scope) needs in my opinion
> to be offset by more transparency in the procedures documentation to
> avoid the "secret court" image that many attach to the CoC committee. I
> do understand this is not a trivial exercise, as any policy documented
> in writing can have a limiting impact on the actions the CoC committee
> can take, but I believe that this patch, as it stands, gives a wrong and
> possibly damaging impression of the committee's work.
> 

Thank you Laurent.

Bulk of the Code of Conduct Committee work involves listening, talking,
and discussing the best outcomes for all involved parties.

I will add more content to the document distilling the discussion on
this thread in the interest of transparency.

thanks,
-- Shuah




