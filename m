Return-Path: <linux-kernel+bounces-341412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2414D987FB7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60D1284741
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C6C18800E;
	Fri, 27 Sep 2024 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AmSAQ1yo"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A1A178376
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727423325; cv=none; b=kemTbYL9uxqnudAIGG6umXpzGZMxaRgM4iyv86tWsVBY3oUFny1hQZqu6LnxwV+jDpd5o4HiYzsM8+OYFY0IwTzKzkjl3tDUnLJxcEn1depzCT3USgk/Z6YLISTQzZSSVDzlk7JGhOySZHmDKyyYvPY3+0B9pMGh7aSQl0cpk/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727423325; c=relaxed/simple;
	bh=C+0z+9oD+EvuG+OzPQefzmEH2PUteYyKJn06IpQOBpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kE6lvzeWhd03VnUfWqdq6NPO49Q8ghBce2o9NDepjxbW8qmq0FIwnjYMKKjbF0xA2ZaAym53BauxSnQgBqxEump9y5axj6nyHDONGtBN5+n7ACFhkSwF3gsEYrhMIFeBHuLUBB3B/8JkeNjvPR1JQg99/PpIq4maJAQ8jlSr9Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AmSAQ1yo; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c884bc72e9so24160a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 00:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727423321; x=1728028121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3pCqHS8QCjF3AyE7Hlns+lS+1rNia1GoqF6RaOHTvFo=;
        b=AmSAQ1yo+g9a4mJjNdlgPaFq8eyMu+Sc4XdZkAtmNBEDK+BFhX3/2jWmtpL/JF5ePP
         EQ8tIKaXCijKG9x5jkB+/QrAChSyrYnfQJS7W9FE6u4bYIsokghwpKqUx8annkCw5NNM
         jV77g5jUD+TcqU3zq5+6PZ+Ij1wUXYEMFjpOuc80Vrzyx0Ih600jJChKC6NcyzZZr3kF
         G+K3SjxhdU+NMy32wYvp7jPvy2O0+OFoI0jm3N3gjRzcW1alnTqVA+u2GPBzFwqlmFj5
         Ccgbcg906U0FoJtCeHGizdw4fs2+NNngS3sck6GGV/jlrNq1myNakVmNQG3kuimMUwLl
         tHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727423321; x=1728028121;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3pCqHS8QCjF3AyE7Hlns+lS+1rNia1GoqF6RaOHTvFo=;
        b=YI/ZppcRB3jJOMwLltxcYgvEv2dD7QaNX28S1fM+Yu76q2jTm6819eR7GI5Gmm/6Uh
         yJwD8ufyaDdbmJdU4z6MbQGINiPk/u90J3Fz02XyHaH9w9vuAOnxe5vSMol2wCsUPC7g
         jNGtKPmEH2x0luzAu5R2yYEYB65Ec++zadO5Uom+7Vb9SkYNtzKXOch+0cin88m0t5+M
         sgu5e0StDZzpYRiQ4k/MKMMBU4/nGFxF2iFaBe08OV5MERSSlmsdPNyeGLlbpHBHoUiT
         EQpWomPgN4vBvb6P0nFdISH76yRto9R2w8E4xBZDApPuWwGUqirMdP1mAQRef0vrnFLb
         r/tA==
X-Gm-Message-State: AOJu0Yy+1SKCrZ2de5KO/NOHq8gVirCWCu9Q9t/PJ8g3+Nr0njjaQGYJ
	oKkz6hGUWsSlQGH2wfQSXtcP6ptD2+L+dYjy2/bP2yzaD32v67FyJD69na51iGA=
X-Google-Smtp-Source: AGHT+IG0ESOAAQflviCqGeX6WfN4wPdulS4UlAVTKzxCL3NXbTuIiTYdKxoRYwbi5RWXhNYBGjy/5w==
X-Received: by 2002:a17:907:3f19:b0:a80:f54c:ad68 with SMTP id a640c23a62f3a-a93c48f001amr89324866b.2.1727423321482;
        Fri, 27 Sep 2024 00:48:41 -0700 (PDT)
Received: from [192.168.0.18] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2948355sm97339666b.142.2024.09.27.00.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 00:48:40 -0700 (PDT)
Message-ID: <ce64e869-4a52-4da3-b95e-d60a0247006a@linaro.org>
Date: Fri, 27 Sep 2024 09:48:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] dt-bindings: connector: Add property to set pd timer
 values
To: Amit Sunil Dhamne <amitsd@google.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, kyletso@google.com, rdbabiera@google.com,
 Badhri Jagan Sridharan <badhri@google.com>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240911000715.554184-1-amitsd@google.com>
 <20240911000715.554184-2-amitsd@google.com>
 <ae520641-38a4-405e-89d0-e0921dfc7cff@linaro.org>
 <2dab1111-49fd-43b7-8624-2d61b3d546b1@google.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <2dab1111-49fd-43b7-8624-2d61b3d546b1@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/09/2024 03:59, Amit Sunil Dhamne wrote:
> Hi Krzysztof,
> 
> Thanks for the review!
> 
> On 9/16/24 9:05 AM, Krzysztof Kozlowski wrote:
>> On 11/09/2024 02:07, Amit Sunil Dhamne wrote:
>>> This commit adds a new property "pd-timers" to enable setting of
>>> platform/board specific pd timer values for timers that have a range of
>>> acceptable values.
>>>
>>> Cc: Badhri Jagan Sridharan <badhri@google.com>
>>> Cc: linux-usb@vger.kernel.org
>>> Cc: devicetree@vger.kernel.org
>>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>> Please work on mainline, not ancient tree. You cannot get my CC address
>> like that from mainline.
> I was working off gregkh's tree on usb-next branch as that's suggested 
> for USB development.
> 
> 
>> It's not possible. So either you don't develop
>> on mainline or you don't use get_maintainers.pl/b4/patman.
>>
> The above branch and even the tree on Linus' master branch has you
> listed as a maintainer
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/MAINTAINERS#n17181).
> I guess that's why the get_maintainers script probably returned your
> email id when I ran it. Please let me know if I missed something :).

You really just skimmed over my email... I know how maintainers work.

So I REPEAT: You cannot get this email address you Cced. Point me to the
line in your tree having such email. The one here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/MAINTAINERS#n17181

does not have it.

> 
> 
>>> ---
>>>   .../bindings/connector/usb-connector.yaml     | 23 +++++++++++++++++++
>>>   include/dt-bindings/usb/pd.h                  |  8 +++++++
>>>   2 files changed, 31 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>> index fb216ce68bb3..9be4ed12f13c 100644
>>> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>>> @@ -253,6 +253,16 @@ properties:
>>>   
>>>       additionalProperties: false
>>>   
>>> +  pd-timers:
>>> +    description: An array of u32 integers, where an even index (i) is the timer (referenced in
>>> +      dt-bindings/usb/pd.h) and the odd index (i+1) is the timer value in ms (refer
>> timer of what? OS behavior?
> In the context of USB Type C Power Delivery (PD), timers are run on the 
> typec protocol driver
> (usb/typec/tcpm/tcpm.c).
> These are used to keep track of min/max or range of time required to 
> enter a PD state with the
> goal of a successful USB typec capabilities negotiation.  Eg., the timer 
> PD_TIMER_SINK_WAIT_CAP (referred to as SinkWaitCapTimer in spec)would be 
> responsible to keep track of whether a power source sent us (as sink) PD 
> source capabilities pkts within 600ms (say), if yes, then we would 
> transition to the next state or do a state machine reset. USB PD 3.1 
> spec refers to these elements as timers and therefore referred to as 
> such here.
> 
> 
>>> +      "Table 6-68 Time Values" of "USB Power Delivery Specification Revision 3.0, Version 1.2 " for
>>> +      the appropriate value). For certain timers the PD spec defines a range rather than a fixed
>>> +      value. The timers may need to be tuned based on the platform. This dt property allows the user
>> Do not describe what DT is. We all know what DT properties allow.
>> Instead describe how this relates to hardware or boards.
>>
>> All this is wrongly wrapped. See Coding style (and I am not telling you
>> the value on purpose, so you will read the coding style) .
> 
> 
> Ack. Thanks for pointing it out, I will fix both the above in the next 
> revision.
> 
> 
>>
>>> +      to assign specific values based on the platform. If these values are not explicitly defined,
>>> +      TCPM will use a valid default value for such timers.
>> And what is the default?
> 
> Defaults are given in (include/linux/usb/pd.h). But I guess I should 
> have probably mentioned
> that here.
> 
> 
>>
>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> I guess you want matrix here.
> 
> Yes, I should have. Though, I will be re-implementing this such that 
> each timer is represented
> as a separate property based on Rob and Dmitry's suggestion in
> https://lore.kernel.org/lkml/20240916163328.GA394032-robh@kernel.org/ .
> 
>>> +
>>>   dependencies:
>>>     sink-vdos-v1: [ sink-vdos ]
>>>     sink-vdos: [ sink-vdos-v1 ]
>>> @@ -478,3 +488,16 @@ examples:
>>>               };
>>>           };
>>>       };
>>> +
>>> +  # USB-C connector with PD timers
>>> +  - |
>>> +    #include <dt-bindings/usb/pd.h>
>>> +    usb {
>>> +        connector {
>>> +            compatible = "usb-c-connector";
>>> +            label = "USB-C";
>>> +            pd-timers =
>>> +                <PD_TIMER_SINK_WAIT_CAP 600>,
>>> +                <PD_TIMER_CC_DEBOUNCE 170>;
>> Incorporate it into existing example.
>>
> Ack.
> 
> 
>>> +        };
>>> +    };
>>> diff --git a/include/dt-bindings/usb/pd.h b/include/dt-bindings/usb/pd.h
>>> index e6526b138174..6c58c30f3f39 100644
>>> --- a/include/dt-bindings/usb/pd.h
>>> +++ b/include/dt-bindings/usb/pd.h
>>> @@ -465,4 +465,12 @@
>>>   	 | ((vbm) & 0x3) << 15 | (curr) << 14 | ((vbi) & 0x3f) << 7	\
>>>   	 | ((gi) & 0x3f) << 1 | (ct))
>>>   
>>> +/* PD Timer definitions */
>>> +/* tTypeCSinkWaitCap (Table 6-68 Time Values, USB PD3.1 Spec) */
>> Please expand this a bit, so we won't have to reach to external sources.
> 
> Ack.
> 
> I will incorporate all of your review comments.
> 
> Since you are no longer maintaining the
> "OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" component, please let 

Who said that? You CC wrong emails because either you work on ancient
tree or you do not use tools like get_maintainers.pl or b4. You cannot
get this email from proper process. It is not physically possible
because that email is nowhere mentioned.

> me know
> if you'd still like to be CC'ed in the subsequent revisions.


Damn, just use standard tools. You are not supposed to invent maintainers.

<form letter>
Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC (and consider --no-git-fallback argument). It might
happen, that command when run on an older kernel, gives you outdated
entries. Therefore please be sure you base your patches on recent Linux
kernel.

Tools like b4 or scripts/get_maintainer.pl provide you proper list of
people, so fix your workflow. Tools might also fail if you work on some
ancient tree (don't, instead use mainline) or work on fork of kernel
(don't, instead use mainline). Just use b4 and everything should be
fine, although remember about `b4 prep --auto-to-cc` if you added new
patches to the patchset.
</form letter>

Best regards,
Krzysztof


