Return-Path: <linux-kernel+bounces-340361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C42098720A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E486289BF6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F3B1AD5D7;
	Thu, 26 Sep 2024 10:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Whx2l67e"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21CC1ACE03
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347952; cv=none; b=ekvZzht79ZEvIVuomcRsTAmrbQTSXdml4sDvgBoV7vV74pS4NljvbLs40IrfI8VgWoQ4JD9i1wpwS3pTgEqCYhCQAp5SaH3j6ZJbzyOyftE0h+W2WwMwDvmntFW+88KD0aazTdVTtFZFA49lAyKjkc01jwggqGF1DhvZJgs4riU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347952; c=relaxed/simple;
	bh=jc6WaqxvmP5VbH2bakowRUyH2tKYaT2YUN/mffZUmdA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rEIgw4S6X4Jigs4BFJJWL1ebsczvP3WptgV/iTSJ5aeuGVWjNLblfdnxuhDMSrbPVnWpDOSAmQi7Q52rXnvyd/uXAwZEkmztFknCt6BLG13c3F+JYo2Im7IcERhDkTswcIJ23TH7SYfN128VdwDU8amJrhJJSWnuxnzx81tWlSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Whx2l67e; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c5c3a1f474so825622a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 03:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727347948; x=1727952748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rJu6mYblkqkVcXR8JB08LsUmO1kDyu1sUwLdCteDGqk=;
        b=Whx2l67evl7Cz9iA53YsP6XxIPf7D0V/E+n699fmomvbvlb/GlSsuqaXtZO4CJKikb
         SCVvU5vYaaSjsLGFD6xQF+Nn//Z5zijDCXk7YTcDODKqfm7aWOg7iAv7pA468s13tlmz
         RHwFljG0gDnNbI6trVKbcIVOFduoL3qMainmAXmOfoj+hTq7lbzZfQJPuUebPYnByuba
         takh16z53JICHLy8AKthQ/MaquCwHP9WW9kQERCxpd1WjjpAuJBAAfKnDs2sYeg1wVNn
         Kh4sE7euXFrsc5t6TbnOEdDYwb2n5cMszx2D4CmrolcRBYulmA4D9RCBNCXe7oAb8iXd
         5sjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727347948; x=1727952748;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJu6mYblkqkVcXR8JB08LsUmO1kDyu1sUwLdCteDGqk=;
        b=LKkRiJvcwA5KLHhJdSpOTFVVXAHtRRQIj2K2kc0WXyAzHEs2eCJsKRrx5oJ4ku3uoU
         KTsRVqsVv/uWsaqJf9FXvBpfpNpyoCIrIvcLfAsqwyhz7FDqU8GMYrRMwMEDOTZuyosw
         EO8mEFJSU+0C/yHfO/V6AoxGUGXYrSpUFYa1rDflOgUINnV3IJQXbdlO7ZPchB9vyVYI
         gUOq9JXyrTNlpZJtmKzFZBnlvBQSz0uONnaonILU3/gXHHWjBxQH6iuPfhW/zK9s8V/l
         R4vcapFSeTJtEbcS++Aivmmpv4KGqJMripQFrnL/nmwvpIlpEPe4kndUgO5FUjODursd
         pIuw==
X-Forwarded-Encrypted: i=1; AJvYcCUnCEMY7mngW1r7+JapWmX97s6pOB1+vw6mYkgj3NpfhvpWJUNOvXUZSyQSTVeCojJaUm6DSm5PHyk10go=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU8bneKCW7dN+V5NSrpsobXrLvnsg37Sz6844w3PUUIGY85ohd
	WPLol8Rpx7dsXXFcHJO3HWo+1HCZFnnba2iqZcCkf04xRC7pF5Fv0LyiOUa9DTg=
X-Google-Smtp-Source: AGHT+IHqh7l0ziaE7Iee4IWJbL+JOqnqbMeKHuaoZ2CaR0fOIf16vkoIFCf4nL/NIj3W3r4REhw/AA==
X-Received: by 2002:a17:907:f78e:b0:a8a:3ece:d073 with SMTP id a640c23a62f3a-a93a0320106mr457384266b.10.1727347947978;
        Thu, 26 Sep 2024 03:52:27 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9393134bd2sm334386766b.214.2024.09.26.03.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 03:52:27 -0700 (PDT)
Message-ID: <2a38f567-8734-4295-95bd-c3ea65c0754b@linaro.org>
Date: Thu, 26 Sep 2024 11:52:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] mtd: spi-nor: macronix: workaround for device id
 re-use
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: Esben Haabendal <esben@geanix.com>, Michael Walle <mwalle@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 linux-arm-kernel@lists.infradead.org
References: <20240711-macronix-mx25l3205d-fixups-v3-0-99353461dd2d@geanix.com>
 <D2NGXHZ2VTK0.M0AOB4CM7MHM@kernel.org> <87tte2hmq0.fsf@geanix.com>
 <2196b4e8-2c93-4a73-a717-28448d4668ab@linaro.org>
Content-Language: en-US
In-Reply-To: <2196b4e8-2c93-4a73-a717-28448d4668ab@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/26/24 11:47 AM, Tudor Ambarus wrote:
> Hi, Esben,
> 
> Thank you for the perseverance :D
> 
> On 9/26/24 8:56 AM, Esben Haabendal wrote:
>> "Michael Walle" <mwalle@kernel.org> writes:
>>
>>> Hi,
>>>
>>> On Thu Jul 11, 2024 at 3:00 PM CEST, Esben Haabendal wrote:
>>>> As a consequence, the SPI_NOR_SKIP_SFDP flag is no more, and all
>>>> drivers that have been doing optional SFDP is now marked explicitly to
>>>> do that using the SPI_NOR_TRY_SFDP.
>>>
>>> First, I haven't looked at your patchset at the moment. But I'd like
>>> to take the opportunity to discuss the following (and excuse me that
>>> I didn't had this idea before all your work on this).
>>>
>>> First, I'd like to see it the other way around, that is, doing SFDP
>>> by default and let the driver opt-out instead of opt-in. This will
>>> also align with the current "SFDP only driver", i.e. if a flash is
>>> not known we try SFDP anyway. Going forward, I'd say this is also
>>> the sane behavior and we don't have to add any flags if someone want
>>> to add support for an (older) flash with the same ID but without
>>> SFDP. With the current approach, we'd have to add the TRY_SFDP flag.
>>>
>>> Now we might play it safe and add that SPI_NOR_SKIP_SFDP to any
>>> flash which doesn't do the SFDP parsing (because it has size != 0
>>> and not any of the magic flags set) - or we might just go ahead and
>>> do the probing first for *any* flashes. Yes we might issue an
>>> unsupported opcode, but we already do that with the generic SFDP
>>> flash driver. So no big deal maybe (?). Vendors where we know for a
>>> fact that they don't have any SFDP (Everspin I'm looking at you),
>>> would of course set the SKIP_SFDP flag.
> 
> Issuing RDSFDP for flashes that don't support it shouldn't be too bad
> indeed, it's not recommended, but it shall be fine. What I'm worried
> about is flashes with wrong SFDP data (see all the SFDP fixup hooks that
> we have). So my suggestion is to play it safe unless one of you guys
> step up and commit that will fix or help fix each bug that results from
> this.
> 
> I'd like you to also consider the SFDP versions and how many parameters
> they are exposing. I can't tell exactly, but if I remember correctly,
> rev A had 9 dwords for BFPT, revB 16, and revC and other more. If we
> consider static init folowed by SFDP with rollback option, point 3/ in
> your cover letter, are we sure that all the parameters that are
> initialized before parsing SFDP are overwritten at SFDP parsing time? If
> yes, we shall be fine.
> 
> Esben, to speed up the things on both ends, I recommend you for v4 to
> draft just a core patch if you care, then you can handle the vendor
> drivers. Or send us some pseudocode and we can talk on that.
> 

To summarize, I like the idea too, as far as we can keep backward
compatibility.

