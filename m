Return-Path: <linux-kernel+bounces-336167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D57E97F003
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3053A1C21524
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABA819F42E;
	Mon, 23 Sep 2024 17:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HWxb+sdZ"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAD319F13F
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727113986; cv=none; b=NCesDP7WDnjdYTXIDEWy1avj688oNgszg+hZ3i3wGc58z2W06lalBcF+WQdOWtCCCqaOp6i69txD1g/Jd/b1YGhcjYmX5kiIMTy5a36btTNW/H8MtnkM05A5HpDjcR+paFen1MciURFkTj79lTZwCosXJbAnzSin6i+AJ6+NY80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727113986; c=relaxed/simple;
	bh=Q7jVHwjaDWY0Wb1yzKoDfLQ1VTl090Y/IZDvdrzQd/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFFWnjkX95DBSLHgsDUWBHbObi6LHjBr+0AcppjtEdOT7JW2p0uKT+M9D1KFeQGy7OEczBSYAFexzoUvnu9mJW0rW8fSt2c2NWJReYQDsZEf+KAOhU7pPFWljqCold0uj7Xlq87k0t+WW8YLoxv116boekAm7XR4rTd0UAM00aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HWxb+sdZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cbbb1727eso42306115e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 10:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727113983; x=1727718783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uACufje9ISH13oK3Ox0whD6Xv8lAcOfXb4WXjw+PZus=;
        b=HWxb+sdZnTk+1z2WKZZ6onClUNltWj0dD/DegwfPxPIYYI+6QKlFOL9KqjcuPkQN2+
         EBoqTL+fGVKfr2HiU2awkJ7JoqyVfoILExmep6yHNimB7ckC8jrVHEpEWEMUie+raQhw
         KgMUcy0ac0xOb28euCWwU5zDxYFkcY4x2HG0z4W+XFXod36N1QJiWxOIuq0LeDC8mJAG
         M6zosqCb71FtlG2U5nVPNqgY415Bt+KF42pGfgNvn16RP0RBbtKIqoIA3z6H2iF9Mq/t
         +d+H4BEKyrHhEQO3QeM0KVrQR9ZsOfHRRgtjABos66A5+gJcNaJnsAElt1MS5kkuLnyl
         u/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727113983; x=1727718783;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uACufje9ISH13oK3Ox0whD6Xv8lAcOfXb4WXjw+PZus=;
        b=DyX4k1c9CXNF0MBQA6iawjuZxFIzEOosuxvMcFsfWYyRLotcC3kd+AuDEBGI8gA1Mn
         giOCnw+RjyvqINIaVquQ5AURYNkRchWQs++d9bM9bihr4pUap6YSdabt8m9905n5yVM4
         ICzAa0rQF4cDdTTpWAGMWSBZis69j5UGAFnwnwvFjNAYRZ4y7+A6CoO1JPbvciw1O+9J
         qYDPueuzZGvCHg590jx3i0dCHThKValmP6fs3b9QqgVKIMhOAdRcI73WM5dkIc7l/dP/
         3ra6JWMzZw6PIqP09cNghU5p3A+9XfT0Qfz3QMT2MVaTo/fwQDW7/Gpy1au1S8heQ1yx
         p5Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWAR0v420DeHj3PHP3E9XfFolebvqI/UEOixE0SCUx6/6ArFmwXGGM5oROlRpsIAqafEkk5Mk2uexEpg3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnXghqr5qx9LvrPSbswX5s8mGfdiHyB5D2u38jGT7XnOaCDusD
	SQ1ihG5Z2wufyGqnWdJpgIQubTLik9uPbg6g6KZENArh6Xt6F2Fmj+7etGi4nLQ=
X-Google-Smtp-Source: AGHT+IHbteRKjUljv6qRO/hBCEdt2P47TUBo0rr7mSfx/GJswetlbmFmfajX1p09Zu4GovmhkJrC+Q==
X-Received: by 2002:a05:600c:6b18:b0:42c:cd7c:a196 with SMTP id 5b1f17b1804b1-42e7d5c8614mr102349705e9.17.1727113982531;
        Mon, 23 Sep 2024 10:53:02 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7ae60addsm108811575e9.2.2024.09.23.10.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 10:53:01 -0700 (PDT)
Message-ID: <ca2c03f7-0769-4b2a-b743-3ebda9e29755@linaro.org>
Date: Mon, 23 Sep 2024 18:52:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] mtd: spi-nor: core: add manufacturer flags
To: Erez <erezgeva2@gmail.com>
Cc: Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Esben Haabendal <esben@geanix.com>
References: <20240920181231.20542-1-erezgeva@nwtime.org>
 <20240920181231.20542-2-erezgeva@nwtime.org>
 <4e0cf43c-4843-451c-ac6f-86775dbccb2b@linaro.org>
 <CANeKEMOmhAPM1j1_ihzcC2wL6jKsWXPCGfZs+euS8mRvtqgE5A@mail.gmail.com>
 <2c87568d-3caa-4162-91de-094684f1b268@linaro.org>
 <CANeKEMO4ckeJZHKEOKHVeamPzR045jpwkXWfJS9S6rBiMTayuQ@mail.gmail.com>
 <688d3e68-c339-4a44-b6b5-366dd5f12965@linaro.org>
 <CANeKEMNKF5WtVgzxbMnLFsqRHNOz=+gD-if8aBqsWwjgDvz3GA@mail.gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CANeKEMNKF5WtVgzxbMnLFsqRHNOz=+gD-if8aBqsWwjgDvz3GA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/23/24 3:51 PM, Erez wrote:
> On Mon, 23 Sept 2024 at 16:18, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:

cut

>>> After reading a lot of Mactronix datasheets, I suggest also reading
>>> all SFDP to all  Mactronix chips.
>>
>> Why? It seems too invasive. Generally it is not recommended to issue
>> unsupported commands to flashes. Change just the flash that you use and
>> can test.
> 
> It is not, All Mactronix chips in the last 15 years have SFDP.

This is false. I worked with an octal macronix flash that didn't define
SFDP tables, mx66something.

> The chips in the manufacturer compatibility table are all obsolete.
> Mactronix reuse the JEDEC IDs. There is no point pretending these are
> the same chips.
> 

If macronix doesn't care about backward compatibility, we/I do, and we
can't break it.

>> cut
>>
>>>> Which flash do you have at hand, both, none, just one of them?
>>>
>>> When I started working on the OTP code, I used MX25L12833F.
>>> But later I left the company.
>>> So I use my beaglebone black and connect it to a MX25L3233F.
>>
>> I understand mx25l12805d and mx25l12833f share the same ID. How is
>> mx25l3233f related, does it share the same ID as the previous two?
> 
> They are not. I just replaced the company hardware with a different one.
> You ask me to report the hardware I use for testing.

So MX25L3233F does not share the same ID as MX25L12833F and mx25l12805d?
Then why do we talk about ID reuse?
> 
> The patch covers the one I use with beaglebone black.
> I just mentioned the OTP callbacks are per manufacturer.
> But if a new chip in the future would require different callbacks,
> then just add them.
> My patch is using a single chip, the one I send the testing with.
> beaglebone black + MX25L3233F.

Sounds good.

cut

>> I said new compatibility will be introduced as a last resort only if we
>> can't differentiate the flashes at run-time. You haven't proved me yet
>> that this is the case.
> 
> Then you do not read my explanation.

What explanation? I've read your cover letter, commit message and I
didn't understood what you're trying to achieve.

> Do you wish me to send the Macronix datasheet of the 4 chips?

No, I need just a paragraph where you explain what are the challenges
and how you want to address them.
> 
>>
>>> You ask if it is possible to deduce it from JEDEC ID and SFDP,
>>> I answer that this is not possible, at least in some cases..
>>
>> I'm interested just about your case, not all the possible cases.
> 
> Actually it is the MX25L3233F and its previous chips.

Which previous chips? Do you have any such chip at hand? If not, why are
we talking about collisions?

> Anyway, I will not submit a broken solution.
> Whether you like the idea or not.
> 

Fine by me.

cut

>>>>> I told you we can not "guess" OTP settings based on JEDEC ID and SFDP existence.
>>>>
>>>> When? And more importantly, why?
>>>
>>> I send you example of 3/4 chips that using JEDEC ID and SFDP existence
>>> is not enough.
>>
>> Why? Do they have the exact SFDP tables? Prove me, drop them all.
>> Any bit that differs in the SFDP tables is enough to differentiate the
>> flavors of flashes. Vendor tables included ;)
> 
> Because the SFDP is not related to OTP in any way.
> You are planning to decide OTP parameters on non relevant information.
> If you wish to implement such a broken feature, you are welcomed.
> I'll pass.

Ideally we have a single jedec,spi-nor compatible. If there are flash ID
collisions we try very hard to differentiate the flashes at run-time.
New compatibles are introduced only if we can't differentiate the flavor
at runtime (be it by parsing SFDP or some other way).

cut

>>>> And I think I already said that you can differentiate between the two
>>>> based on SFDP presence. mx25l12833f has SFDP, thus when SFDP present use
>>>> the mx25l12833f-OTP configuration. When SFDP is not presence one may add
>>>> support for the mx25l12805d-OTP configuration.
>>>
>>> No, we have 3 chips.
>>> 2 are using the same JEDEC ID and both using SFDP, yet they use a different OTP.
>>
>> Which ones are these?
>>
>> I guess mx25l12805d is non-SFDP. Then mx25l12833f and mx25l3233f define
>> some SFDP tables. Do mx25l12833f and mx25l3233f have the same OTP
>> organization?
> 
> No, that is the point.
> 
? Do you care to explain?

cut

> 
>>>
>>>>
>>>> Is there any case that I miss?
>>>
>>> According to your reply, I would say pretty much most.
>>
>> This is again inappropriate ... I will read your next email as well, but
>> I'm not going to tolerate such replies anymore.
> 
> I agree on this one.
> Seems you are looking for something I do not agree on.

Michael disagrees with OTP being specified in DT too. We both already
suggested how to deal with flash ID collisions but you keep ignoring us ...

> This is not because I oppose probing,
>  this is because you ask for indirect probing, against Macronix own
> recommendation.

What did macronix exactly recommend? Did they say that we shouldn't
interrogate the SFDP data in order to differentiate the flashes at
run-time? If yes, why is that?

