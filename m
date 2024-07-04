Return-Path: <linux-kernel+bounces-241074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56949276CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB33286A30
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9901AED36;
	Thu,  4 Jul 2024 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErufTdfu"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030B91AED3B;
	Thu,  4 Jul 2024 13:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098295; cv=none; b=H22WDyJcmEeBxd3cCYE6mPH5kpbM6rknW9zhCPAUopHAmiQaFYzCLC0nnMTzOybd6605APhN93v1+6cJ1fL7GqWsN5myKyDi+DY6w8D5Vwoe5t3OGQMWAKPIuFLuiztDFh6nFNiMw6Jm78OPLV3kWGhG1FvCxEiNyUvsa843xlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098295; c=relaxed/simple;
	bh=LKgKk74S0lYEgrU1pNpB/tiD4Mcnke6T0foRtegJ9lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dcArzClRf26yEHOxPVv63/ITy9oePTmxV+B4WgvXM4521K0OMCsAcEyD7en/lrOj5CjUSTVZmM6DcVO3rvdLDefStjn47my+nekKbA14NlQAwImtEjKTwg0EHVZK1LHd5HMmtuiJsDXFMMrLN5XgeOAlsN7Voa/qXDpQ+PSunsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErufTdfu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a77b550128dso79401466b.0;
        Thu, 04 Jul 2024 06:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720098292; x=1720703092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2uPuMCUt+0PiW5wgXWRLYWMzfYRTfHb3fi4+BnRHVqA=;
        b=ErufTdfu2FJGcxLfQ9iECTyxSCfyDPayL6BcA2qWuJvZ4Mtcm8ieT3v5wUrfrUN92q
         Af3m7YcY495+rrmNfqcm7pttQDtZemo2CVW9cCcWB8jFTSF8laelyDndd31R1PfpN2vh
         mTLUZved2wR0HJi6I9qeijgR6tzGlC24SeqYmq/k54mtFiEAgAw4SEGbkneeDG0EzEzY
         iJdLcbLLO0sd1G4IlcTMHF5XbwoOloV2Pa1j9N9pQI0/g2oTuBM15IuoqGu7ZLZfoxIN
         +4/D58AlGQrlY1OwI6j4b6FiH6bW08rIOug/T+YxYUX29by8CKDILwLY19S/xCkaAQrM
         kmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720098292; x=1720703092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2uPuMCUt+0PiW5wgXWRLYWMzfYRTfHb3fi4+BnRHVqA=;
        b=wN1a/80G+f3ZdXpaBnWqAAM5rZ/E6ZiVamGNFLPzAu2BfM8KNEDmDaKAfVbnvjjAJz
         7jCmVygD2WJg/WowX2GcAmUaH9K2AJFILvQpj2fot7o34InlA5TaTXDZmnfTND6vnSPc
         28jMrgWbtjNimMqp3pHllhTKjwLSewI+c38YSNMy758Mfniwwoq0sZC9PcL/MazdSYX5
         7pZ1uVM2nuEH56fZM3dp4pA/zq9X0fpPZPwKgcMXNjt2zCdsD7mF1H/9cJ4FWDBduEBj
         lxwV2xjWjSUH4d0PdrFgR308mapgZB4Js6iCM58ivbHjpjYPEOerAqX80/SSo8nS0tq7
         Hbeg==
X-Forwarded-Encrypted: i=1; AJvYcCUZqQyw/1rgkBTokKs/IvgLy9nFv7COZui6LqztDHuMWbxjNGIeW7rJ4lBvRMFVMF5/y/tH8YZU8wvomFfHQ/5jmn4ZFLNYlWtOx4cjdfA+Y53II6hacEi25345QJ7oBrvOrPveVotRPg==
X-Gm-Message-State: AOJu0YwZiNAjuzpnw96p5s4UaD+J4GyFXJ8kUxIiB3LS41iv57aumCo+
	g+LAYxcx3eGvfk0kIHNDsMZDIiMGe7c46YVj0jp6QIiHwhicir+bJutJ
X-Google-Smtp-Source: AGHT+IFZIcyALDt43Fk8aUWhime9uuJbu6aaRpQ6g07IxAblZfpNL/zdJWjjDDngZz0vSZjneaXhtQ==
X-Received: by 2002:a17:906:1158:b0:a72:8d4f:6720 with SMTP id a640c23a62f3a-a77ba72b9dfmr113893666b.69.1720098291839;
        Thu, 04 Jul 2024 06:04:51 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:ec22:4ef6:28e0:c5f3? ([2a02:810b:f40:4600:ec22:4ef6:28e0:c5f3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf1bb6bsm595903366b.30.2024.07.04.06.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 06:04:51 -0700 (PDT)
Message-ID: <85e2ed16-47aa-498c-90a3-0910e5dd97f4@gmail.com>
Date: Thu, 4 Jul 2024 15:04:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: add rock5 itx board
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 linux-rockchip@lists.infradead.org, Diederik de Haas <didi.debian@cknow.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240703210524.776455-1-heiko@sntech.de>
 <4552794.8F6SAcFxjW@diego> <2c46dfb7-5ef3-494f-8cf1-413033e73412@gmail.com>
 <2004736.8hb0ThOEGa@diego>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <2004736.8hb0ThOEGa@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Am 04.07.24 um 14:05 schrieb Heiko Stübner:
> Am Donnerstag, 4. Juli 2024, 13:43:47 CEST schrieb Alex Bee:
>> Am 04.07.24 um 12:05 schrieb Heiko Stübner:
>>> Hi Diederik,
>>>
>>> Am Donnerstag, 4. Juli 2024, 11:38:51 CEST schrieb Diederik de Haas:
>>>> Thanks for submitting this. A quick scan indicates it should work with a
>>>> (recent) Debian kernel OOTB :-)
>>>>
>>>> On Wednesday, 3 July 2024 23:05:24 CEST Heiko Stuebner wrote:
>>>>> +&sdhci {
>>>>> +       bus-width = <8>;
>>>>> +       no-sdio;
>>>>> +       no-sd;
>>>>> +       non-removable;
>>>>> +       max-frequency = <200000000>;
>>>>> +       mmc-hs400-1_8v;
>>>>> +       mmc-hs400-enhanced-strobe;
>>>>> +       mmc-hs200-1_8v;
>>>>> +       status = "okay";
>>>>> +};
>>>>> +
>>>>> +&sdmmc {
>>>>> +       max-frequency = <200000000>;
>>>>> +       no-sdio;
>>>>> +       no-mmc;
>>>>> +       bus-width = <4>;
>>>>> +       cap-mmc-highspeed;
>>>>> +       cap-sd-highspeed;
>>>>> +       disable-wp;
>>>>> +       sd-uhs-sdr104;
>>>>> +       vmmc-supply = <&vcc_3v3_s3>;
>>>>> +       vqmmc-supply = <&vccio_sd_s0>;
>>>>> +       pinctrl-names = "default";
>>>>> +       pinctrl-0 = <&sdmmc_bus4 &sdmmc_clk &sdmmc_cmd &sdmmc_det>;
>>>>> +       status = "okay";
>>>>> +};
>>>>> +
>>>>> +/* M.2 E-KEY */
>>>>> +&sdio {
>>>>> +       broken-cd;
>>>>> +       bus-width = <4>;
>>>>> +       cap-sdio-irq;
>>>>> +       disable-wp;
>>>>> +       keep-power-in-suspend;
>>>>> +       max-frequency = <150000000>;
>>>>> +       mmc-pwrseq = <&sdio_pwrseq>;
>>>>> +       no-sd;
>>>>> +       no-mmc;
>>>>> +       non-removable;
>>>>> +       pinctrl-names = "default";
>>>>> +       pinctrl-0 = <&sdiom0_pins>;
>>>>> +       sd-uhs-sdr104;
>>>>> +       vmmc-supply = <&vcc3v3_ekey>;
>>>>> +       status = "okay";
>>>>> +};
>>>>> +
>>>>> +&sfc {
>>>>> +       pinctrl-names = "default";
>>>>> +       pinctrl-0 = <&fspim2_pins>;
>>>>> +       status = "okay";
>>>> Shouldn't those properties be sorted alphabetically? Or at least consistently?
>>>> Note that the same issue is present on other places too, but I believe the
>>>> above quoted part shows the issue enough.
>>> The main sorting is
>>> - compatible
>>> - reg
>>> [... alphabetically ...]
>>> - status
>>>
>> Yeah ... that's always the question when adding new board files. Do it like
>> "it's always been done" or re-sort the properties alphanumeric _everywhere_
>> which looks quite strange at times. If I'm getting the newly added dt
>> coding style correctly common (subsystem?) properties should also be placed
>> before vendor (driver?) specific ones. Yet I didn't see a board file which
>> places 'regulator-max-microvolt' before 'regulator-min-microvolt'. So I
>> guess it's fine if it's done consistently within the same file?
> I always see it as a best-effort thing. If all regulator-* stuff is grouped
> together it will be mostly fine. I'm not going to haggle over the sorting
> of the 10th character of property names ;-) .
>
> (and of course reading min before max, is sort of more intuitive)
>
> And of course leaf-things (board dts) are less "important" than the core
> nodes in soc devicetrees.
>
Great, thanks for sharing. Will (try) to follow in future.

Alex

>

