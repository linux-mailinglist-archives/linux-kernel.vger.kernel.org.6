Return-Path: <linux-kernel+bounces-340352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF479871F2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD04D1C2133D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BCA1ACE12;
	Thu, 26 Sep 2024 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mCY5lnDC"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FF21F95C
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347659; cv=none; b=IGeU508P2d+eNqvYUUpT7RcItGmfktqRWhZwg9+HoVx+n+hIBZdCNgSqQr3/p3x2++N+0q6COXoUuNBCbNt7xxU1TQ5ODDhtq7xvkHTnhl34hlXitNJqBnP2TqVCQhRrY+ygk/v11FpXmh8/INgHTW2amr1zPcl+EL4A5JFvq5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347659; c=relaxed/simple;
	bh=bQCPZwpoTY/8/+7h4ocSMEULXca93gNkMpCjgXnuDk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PvnPMpWF0S/leqe4wTqtvoowmyZsWoJ1YzLn4xKaBzZNTNpiVe6tulFnWkBwTFqhea9F2Vq01RAfvU8V4Z5lFjkR15dohWSRHC3mGlILscI7p2Xt6efw+RWaZMqsrsATrN8I0RCnkmcdQReQmnyFwYj7YVkA4rNeL1gTU8ikKSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mCY5lnDC; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f77fe7ccc4so9403871fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 03:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727347656; x=1727952456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5pi8pEfIaEynAv552dYQhGkc5l0hAhf3yAx8dODUgo8=;
        b=mCY5lnDCYe4TsIUnyI7F4JBCSMQ5pnnA/8sRIbHwrQ3st5ezy8O16QAweCYeS8fr8g
         fGt8sOCK/Y4qOpmF5juwgNpK3SYLRU9Osth13MuSJhG+IywqOTR8TzhJd4IVVebitiD1
         fvagY6WcToE7FoFg0xElz+4sqhC/0xb1Jvmq1W+rK86LlE46+cqJKcXPAkoV4lElcE5A
         bQ9nlrH9qO9HwD92sSk9Gfx4CkoYiDuH1KgsYEhfuKIoQSzU8wCS+t/5ql5mOVkmUN33
         4FKHO0Xy7i0VPS2aWIOmYTHwi6oLNQYwAymhNNCnIfQb6pmFkGe2TDLwS9vmOdv85pIU
         jBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727347656; x=1727952456;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5pi8pEfIaEynAv552dYQhGkc5l0hAhf3yAx8dODUgo8=;
        b=ao0T/IjHhM+1emJSLb3jH3D9+vh8Xc+7TvTUjXHhPKIMGyemc4XyIH450HgGS8dD7S
         3Qk0+VbWyY4rnlw0ayBBWS0i2FqMe0hGpgOfxDLj5Z8Feetj+YxNe6E2LaOfdbI4bwDS
         b2UMuzB1dpVr53WoLFfe/wXHXO8XasBBt35u4agN1G6erHtv7yEWPm5GpLHToElNuAtb
         JslnmAWA/Xo77/m5nNXyPeQIvzStmgTgym9ioTknKwFDJ6mdPQB0vXiq/Y/MlzFfYogz
         shjgdeMaMUHfeG5UH/Gl3wV0HjE1hpGif+JdRm/4Ag5kICA51Ho77dwQomgQmZ9kmbXw
         juLA==
X-Forwarded-Encrypted: i=1; AJvYcCWyqcRerMC+X0gbvbZTxVCy8VWaQdTnI6cwMec3wTjvxX04gnLxNepPfn7PIYaBALuzvuMEO4LCglxWTVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUNMtiNYwX42veN03DnwMsl6iJMUFzOoxon+2jiPGpNiFJ51af
	DGsljDy1JWzwIGl1Vdlpxa8NLwNgCygHU7eKZCxpQEysFkWynGuTqzzegUKBrcwIFOChuowkPQS
	l
X-Google-Smtp-Source: AGHT+IEK/a97LCRTky6jikRpzB8dR3FiDVcnDCgWZC0RyedO6kP9Y3WatCkhxuOrHdfc0H5cUYCzog==
X-Received: by 2002:a05:6512:2355:b0:52c:c9ce:be8d with SMTP id 2adb3069b0e04-53877568ffemr3924628e87.57.1727347655839;
        Thu, 26 Sep 2024 03:47:35 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c80d239c38sm1320639a12.72.2024.09.26.03.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 03:47:35 -0700 (PDT)
Message-ID: <2196b4e8-2c93-4a73-a717-28448d4668ab@linaro.org>
Date: Thu, 26 Sep 2024 11:47:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] mtd: spi-nor: macronix: workaround for device id
 re-use
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
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <87tte2hmq0.fsf@geanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Esben,

Thank you for the perseverance :D

On 9/26/24 8:56 AM, Esben Haabendal wrote:
> "Michael Walle" <mwalle@kernel.org> writes:
> 
>> Hi,
>>
>> On Thu Jul 11, 2024 at 3:00 PM CEST, Esben Haabendal wrote:
>>> As a consequence, the SPI_NOR_SKIP_SFDP flag is no more, and all
>>> drivers that have been doing optional SFDP is now marked explicitly to
>>> do that using the SPI_NOR_TRY_SFDP.
>>
>> First, I haven't looked at your patchset at the moment. But I'd like
>> to take the opportunity to discuss the following (and excuse me that
>> I didn't had this idea before all your work on this).
>>
>> First, I'd like to see it the other way around, that is, doing SFDP
>> by default and let the driver opt-out instead of opt-in. This will
>> also align with the current "SFDP only driver", i.e. if a flash is
>> not known we try SFDP anyway. Going forward, I'd say this is also
>> the sane behavior and we don't have to add any flags if someone want
>> to add support for an (older) flash with the same ID but without
>> SFDP. With the current approach, we'd have to add the TRY_SFDP flag.
>>
>> Now we might play it safe and add that SPI_NOR_SKIP_SFDP to any
>> flash which doesn't do the SFDP parsing (because it has size != 0
>> and not any of the magic flags set) - or we might just go ahead and
>> do the probing first for *any* flashes. Yes we might issue an
>> unsupported opcode, but we already do that with the generic SFDP
>> flash driver. So no big deal maybe (?). Vendors where we know for a
>> fact that they don't have any SFDP (Everspin I'm looking at you),
>> would of course set the SKIP_SFDP flag.

Issuing RDSFDP for flashes that don't support it shouldn't be too bad
indeed, it's not recommended, but it shall be fine. What I'm worried
about is flashes with wrong SFDP data (see all the SFDP fixup hooks that
we have). So my suggestion is to play it safe unless one of you guys
step up and commit that will fix or help fix each bug that results from
this.

I'd like you to also consider the SFDP versions and how many parameters
they are exposing. I can't tell exactly, but if I remember correctly,
rev A had 9 dwords for BFPT, revB 16, and revC and other more. If we
consider static init folowed by SFDP with rollback option, point 3/ in
your cover letter, are we sure that all the parameters that are
initialized before parsing SFDP are overwritten at SFDP parsing time? If
yes, we shall be fine.

Esben, to speed up the things on both ends, I recommend you for v4 to
draft just a core patch if you care, then you can handle the vendor
drivers. Or send us some pseudocode and we can talk on that.

Thanks,
ta

