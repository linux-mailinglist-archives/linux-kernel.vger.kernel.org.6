Return-Path: <linux-kernel+bounces-545633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA158A4EF71
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF313A9F15
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BD22780E1;
	Tue,  4 Mar 2025 21:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWhg11WU"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D51F278102;
	Tue,  4 Mar 2025 21:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741124167; cv=none; b=CWjsTn6aYlW3xAt8Yv1EYgoW5LP09KcMVImY0w/TewDAHOwzhnuRlq3Z7Blx1nGZULt34Q8+vAHvBosAXuVuifgxUi611w5wXs6A3MbA1u8V2r2wdpH/I4o4K6znWclHO6xOpc/cnJdIG+TxG9TgHXYw1ToZiZa17beUWhhu+Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741124167; c=relaxed/simple;
	bh=wiD8xusbEKsu2Iali+v+Ym0NExRAdbZb3/jT8bMVl0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CRlGzYdEIkJsqz85CwxlGBTDwNWYHsIYeB8jiR0kVEfsh5jry4sOiI4jW0nzZtAFol4q5mq0T/YsdKI0zQSEmVG7vTOcObuZjkGBlf+RQ5PG9/OELdSKkQVMspyBf4UEsOa9mnDpzMwIu+OVKz7Zl6qVwHTTxsM9JrEvi10zK/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWhg11WU; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e4b410e48bso9258271a12.0;
        Tue, 04 Mar 2025 13:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741124163; x=1741728963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Aul07l9GfhwCjHtjGDfD/NfsZREfo2EqSgSJg3nuUF8=;
        b=YWhg11WUZoYQngX/tfkU5NYVHk/dQvxBGFvfiAxhGeQXUeKTxaIcfldCe1dP7oja0B
         X9b2z+EsuQBdhcwyR7P3Vp5GeEHIJIbANUl/XKS6HZlN9r83+Jys3fwsj2oTY/kcBv10
         dqmLqShPMdx1E3dRs0UkTB5Wd/VYw8qLvev1x2aYaWzd0ko9/CN/r7duvEdZif1jfNnf
         WSnhagj2/zh00G7xu8f0OQcOa5ErXRWjwmHY+pX7ymy++SEw3iX5oktQNjjhV7xATjDL
         SoG93gMGwq8gSXB0Dx9dJgxaZ4QtGbVblQdZ14M1Me8eV/TsZed8hdoZ3OksGXVJzG/Z
         K3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741124163; x=1741728963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aul07l9GfhwCjHtjGDfD/NfsZREfo2EqSgSJg3nuUF8=;
        b=e/9xU7qpai/82mDQqCgDdQ7Q2Up8OCXJsxIh7qeJ1VzB8ASB+BedKghMMXtHptPIn9
         sbhk1poJohBgIU88fobXQM4jCVOMZ4XYD2qnx86i2Q4TA3SEYpRzlJ5fBvC8vT3Pr/Uw
         QsEUlmJf/0NPBrxSUzJC8JaAmmG4sxrudBN1QV2dhWQA2b9svedzHB9AV4U+I5IbZJL9
         u6CUTxf9dPFdmFXXZVSJvmSb66FTaMiZiVcdWWj+zwOEgjQlhA/VXI2b7EHmwGXz84IM
         RfI+THnkRUwCNj7gDMXFU4sIvr0LgSaUeYish6gIGqkcbPDnI1xm4GkXp81ddlRySM4j
         9YGA==
X-Forwarded-Encrypted: i=1; AJvYcCUfqob5h5bz+e/CVFdty4aqwuPzoOul7+OpQSGZENb9U2++rci1PhfCxOoYSvFzEK7XNqZYMaEK7ITZtUA=@vger.kernel.org, AJvYcCW/JStkaKj1vS6s1/BwHB6lviIPFIc6XFvla/s4HD8ovWA6Su49UvROgRSRWau6vXHnzWpKCpKaBZm9@vger.kernel.org, AJvYcCWYRb5q42de59b7So+PbPM+APD+BBt42VfJ9ENhkLjHOhY/edvrWqRcU2FqW7umnO8utSEhJBTZ1ieOJLD3@vger.kernel.org
X-Gm-Message-State: AOJu0YxQFul2yi2Nf4lZlDHCpWAT5r7cDrwZhS/S+KJleB8ets9OVBQx
	sEzRRXHuj9zdOPK0hJfPjDg9XdAjtKmjBwnf2KWOZ2dONaonyV2K
X-Gm-Gg: ASbGncungN7CmwufQFQTC3Q+z9YkCCPruI+SEpnkKnry0ns//y61JdF1+YvfVJbkTqI
	jPEuLBMujZbatPV8wk4sdrI8I5AduNTH4XWPfbIogoi4wk2dAWfA5CCBf4fpM+rrRKMbdQcvoyb
	E4J0runIBkWF8XX4pfh3VXrbcnTzQmDVgjmPCC57JKK0wRnJsN59qNmNl0c6C7S+BCh3U+vLL8a
	tTmzCnCilhBV8rEs8+MKDDHhf3pVMvRQV3BJhsYRjIzI682jSYzGXkAmyz5i7F9nZQs8ehSvArt
	MJy93PbfZqyWSsxETu1P6uyooDu/5Sv1tNKwgMYqBJXJloKDdnUTNnR8jXilch6eYyiEdrNRgQ=
	=
X-Google-Smtp-Source: AGHT+IHs7d8BBwbkw8DJDPW9i5mIaZ+Eha2Wmv+f6E90nzjq8XUloML3x2a6rJ4eSQ3DcQCiw+551Q==
X-Received: by 2002:a05:6402:1e93:b0:5e4:9348:72c3 with SMTP id 4fb4d7f45d1cf-5e59f384ad5mr490926a12.10.1741124163230;
        Tue, 04 Mar 2025 13:36:03 -0800 (PST)
Received: from [192.168.1.132] ([82.79.237.110])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3bc8800sm8943647a12.48.2025.03.04.13.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 13:36:02 -0800 (PST)
Message-ID: <88584d8f-e1cd-4b56-8906-461e1e6d9cc9@gmail.com>
Date: Tue, 4 Mar 2025 23:35:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] ASoC: dt-bindings: support imx95's CM7 core
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, Daniel Baluta <daniel.baluta@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, Pengutronix Kernel Team
 <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org
References: <20250211225808.3050-1-laurentiumihalcea111@gmail.com>
 <20250211225808.3050-2-laurentiumihalcea111@gmail.com>
 <20250212093610.x4ixrackmn3u2xrf@pengutronix.de>
 <CAEnQRZBeQdnC+K92+Udb5awTmom10YHHNt7Ld-pYK4A1i8sr3Q@mail.gmail.com>
 <d66996eb-f49b-448b-9743-d19a3c3eba52@sirena.org.uk>
 <e45411df-1b8b-4f21-878d-d52e1112e62d@gmail.com>
 <20250213064724.kbmxsk5szpxwclj6@pengutronix.de>
Content-Language: en-US
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <20250213064724.kbmxsk5szpxwclj6@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/13/2025 8:47 AM, Marco Felsch wrote:
> Hi Laurentiu, Daniel,
>
> On 25-02-12, Laurentiu Mihalcea wrote:
>> On 2/12/2025 2:38 PM, Mark Brown wrote:
>>> On Wed, Feb 12, 2025 at 12:11:49PM +0200, Daniel Baluta wrote:
>>>> On Wed, Feb 12, 2025 at 11:38 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
>>>>> On 25-02-11, Laurentiu Mihalcea wrote:
>>>>>> +    const: fsl,imx95-cm7-sof
>>>>> Albeit Krzysztof already add his Reviewed-by, can I ask why we need to
>>>>> add the -sof suffix instead of -audio or so? SOF is a software project
>>>>> but you can clearly run different software on the audio-copro as well.
>>>> Sure you can run a different software project on the audio DSP but
>>>> you will need a way to distinguish between the different projects.
>>>> There might be different mailbox, memory configurations. So you will  need
>>>> to invent another suffix specific to the new project.
>>>> We can make  const: fsl,imx95-cm7-audio as the one used with SOF
>>>> and think about a different name later for when another project will
>>>> want to use the DSP.
>>> I think the point here was that the DT should stay the same even if the
>>> DSP firwmare changes, just as how changing the main OS shouldn't affect
>>> the DT.
>> It's rather unfortunate but based on the experience from the 8 series
>> (imx8qm, imx8qxp, imx8mp), the programming model can differ quite
>> a bit (e.g: remoteproc vs SOF) even if the core is the same (i.e: DSP core).
>>
>> The different programming models also required different DT configurations
>> (e.g: dif. mboxes as Daniel mentioned, some extra properties (i.e: reg-names), etc...)
>>
>> The "-sof" suffix was chosen here instead of the more generic "-audio" (or whatever else
>> alternative) because the DT configuration is specific to SOF's programming model. Other
>> audio applications running on the same core may have dif. configurations (e.g: use
>> DTCM/ITCM for memory instead of DDR, dif. mbox count, etc...). I suppose this kind of thing
>> is bound to happen to some degree since the DT node doesn't just describe the CM7 core
>> (but, rather, it also encompasses information on the memory, mboxes, etc. used)
>> but perhaps I'm wrong?
> Time will tell if there will be any other user except for SOF for the
> DSP but and this is what I wanted to point out: the DTS should abstract
> the HW. IMHO The CM7-Audio node should contain all properties required
> to turn power and reset the core (e.g. clocks, reset, pm-domains). I get
> your point regarding different configs but please have a look at
> mt8183-kukui.dtsi. Here the rpmsg config is a subnode of the actual
> system-control-proc. This makes much more sense to me since the HW part
> is part of the generic core-node and all the software config goes into a
> separate subnode.
>
> Regards,
>   Marco

I understand your point but we're dealing with 2 different programming
models here: SOF and remoteproc as opposed to just remoteproc as it's
the case for Mediatek.

Going for a similar approach would also mean quite a bit of software
changes as we'd need to factor out the common bits (most importantly here:
core operations like start/stop) and placing them in a common driver. This is not
trivial and I'm not sure it's worth the effort right now given that:

    1) The current way we model the hardware inside the DT is not exactly inaccurate.
    The core does physically use those memory regions, mailboxes, etc.

    2) Whatever we do, the information in the DT will still depend on the programming model.
    It's just that you're placing it in a child node, instead of the parent, which is arguably not that
    big of an improvement?

