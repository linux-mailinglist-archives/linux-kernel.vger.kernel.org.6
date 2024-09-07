Return-Path: <linux-kernel+bounces-319711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9387970113
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 10:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EFED1C2220F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 08:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742801547E4;
	Sat,  7 Sep 2024 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nivLdFxM"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17001BC23
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725699266; cv=none; b=fEctdFa1rAHNrTUrpniill0SbVjK+odwCuRdk1n2k3TxkfBEBVBQs74dhrW8UtQGChA5lJRZNyMaznHyLeEy1XUI0J5HmB1wnnKtQ/2QmihymhJD+Ktds/fEs2fVrqA2lja5Co6u6SP2p5egvq+SKiJW30qoJ7yBny5ORqDCoPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725699266; c=relaxed/simple;
	bh=a6pJONfJGvBNxR8MyjuzKMNkEE7YdWSGZefnIHzlpaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DUxsotzmUpWyQx2Oe6vdsGsUds3wimj/XkneBy8FkPRF9INZJGS/y9QmhXD7iwhef6A5xoV5uht4wXRiT4zCUQo57FrNdYmvP/e1rUZ+ibSPbooOAB45/pE2gII31Bjorsyo2E1YLpa0bsrjCZzVsar+2uMiY49VDk/7SJC8EOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nivLdFxM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso29490465e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 01:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725699262; x=1726304062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i1kYMYhXIaxZ1UKI4/jT/jysE/ndF5y3r2DmM2ouiIY=;
        b=nivLdFxM/IutpEikZJw42L9eCjNKWVsD3IZ/qQigWUczNOBbVmfL/9KY82fiCSaTFQ
         wPTgDoq+ywlozXQwioxgHW7soQvO5lHhELXdHZ6eM/7QYBHJGFcSK5F9GaJYhUjsV5ss
         p4koxy4bEJPnMvIb6T014BAdxt+KSErhXQid84PPNuyDWNZvcNOJorIg54bHmE03f5Nx
         q5PhAzYGp2dBQn/igSC5CfOcJnn/6ObGenIzln1gGu+++/OqOlVQ7CFA3EUowYD50rdc
         RrMyPu6sGwNI1dPQ3kQHzQNE8yhwRtNFdpnZQ89xg6rA8U0MPi4kkJlWw5K0FlwHMpfa
         C8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725699262; x=1726304062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1kYMYhXIaxZ1UKI4/jT/jysE/ndF5y3r2DmM2ouiIY=;
        b=oci5I2V0uM9clAfam8jwUj5j5gPeIloD0ztP6ZAuKMAOxiuxanKqbWYNATT2MUPTHu
         pI+sJ+0kebEYcZRnMsA0CRWQjCT0HOhnNYLSJ4cY9Nyp5xIcbkmqHnAJiBEOEBI/28rj
         zGiHMGWx6nidLI2u69W94ERhdgqNpQNDnjOA4FU66Ofb33TlvqAv763WUFnaM1sWCrgH
         0XdUys1Wb3MXxXIhhCANttZQnl+mAbSUNqp8vMtYrzSlnMjOE4EGi4uCJCHN/BjOgIlC
         rh578eA6lNDGnlwFvytdAmWTRHuK4KstCjCcfI0/KTLVk8Sod7HdK+HMnPzy5hJ3CNE0
         4Nnw==
X-Forwarded-Encrypted: i=1; AJvYcCVnGbL3jlS8DTnlVYnTvWkdjK4MAnQFDoV9cqX1/EDFwUTUaQdAEu7wVWvf11raisnrQS89vYy9dZy7BMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc0aXfrKh2lA50Kq2QSEJ6kJ0Kvb4+9TSpHv98FJ/2NRyT6MaR
	q6xRgf865MsRk+sB//tcGL49kBy02JeAWtq9ZEUie5Cl22DsA4weaSttt0UPOQc=
X-Google-Smtp-Source: AGHT+IEYzHzAPiQDjbqnJcEyDcTI29w4xLLiNKjFf/V/WGugYC4z6kN5aEqT3UYrzZho9sB09mSFuA==
X-Received: by 2002:a05:600c:1d22:b0:426:6b14:1839 with SMTP id 5b1f17b1804b1-42c9f8ef48fmr46790255e9.0.1725699261910;
        Sat, 07 Sep 2024 01:54:21 -0700 (PDT)
Received: from [192.168.0.2] (host-79-54-235-146.retail.telecomitalia.it. [79.54.235.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956de3d4sm891822f8f.108.2024.09.07.01.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Sep 2024 01:54:21 -0700 (PDT)
Message-ID: <f60ea1cd-ac24-4640-86be-71d636c1818e@baylibre.com>
Date: Sat, 7 Sep 2024 10:53:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/8] dt-bindings: iio: dac: add adi axi-dac bus
 property
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Conor Dooley <conor@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dlechner@baylibre.com
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
 <20240829-wip-bl-ad3552r-axi-v0-v1-4-b6da6015327a@baylibre.com>
 <20240829-stopwatch-morality-a933abb4d688@spud>
 <d4eddc24-9192-4a4a-ac67-4cfbd429a6a9@baylibre.com>
 <20240830-quilt-appointee-4a7947e84988@spud>
 <9015bc26-1a3a-49df-8728-12ceb8993035@baylibre.com>
 <20240906-venomous-candle-8348b00640ca@squawk>
 <5fd8374285d7dadd68777efabad753b981d29f40.camel@gmail.com>
Content-Language: en-US
From: Angelo Dureghello <adureghello@baylibre.com>
In-Reply-To: <5fd8374285d7dadd68777efabad753b981d29f40.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 06/09/24 1:32 PM, Nuno Sá wrote:
> On Fri, 2024-09-06 at 10:04 +0100, Conor Dooley wrote:
>> On Mon, Sep 02, 2024 at 11:32:37AM +0200, Angelo Dureghello wrote:
>>> Hi Conor,
>>>
>>>
>>> On 30/08/24 5:33 PM, Conor Dooley wrote:
>>>> On Fri, Aug 30, 2024 at 10:19:49AM +0200, Angelo Dureghello wrote:
>>>>> Hi Conor,
>>>>>
>>>>> On 29/08/24 5:46 PM, Conor Dooley wrote:
>>>>>> On Thu, Aug 29, 2024 at 02:32:02PM +0200, Angelo Dureghello wrote:
>>>>>>> From: Angelo Dureghello <adureghello@baylibre.com>
>>>>>>>
>>>>>>> Add bus property.
>>>>>> RFC it may be, but you do need to explain what this bus-type actually
>>>>>> describes for commenting on the suitability of the method to be
>>>>>> meaningful.
>>>>> thanks for the feedbacks,
>>>>>
>>>>> a "bus" is intended as a generic interface connected to the target,
>>>>> may be used from a custom IP (fpga) to communicate with the target
>>>>> device (by read/write(reg and value)) using a special custom interface.
>>>>>
>>>>> The bus could also be physically the same of some well-known existing
>>>>> interfaces (as parallel, lvds or other uncommon interfaces), but using
>>>>> an uncommon/custom protocol over it.
>>>>>
>>>>> In concrete, actually bus-type is added to the backend since the
>>>>> ad3552r DAC chip can be connected (for maximum speed) by a 5 lanes DDR
>>>>> parallel bus (interface that i named QSPI, but it's not exactly a QSPI
>>>>> as a protocol), so it's a device-specific interface.
>>>>>
>>>>> With additions in this patchset, other frontends, of course not only
>>>>> DACs, will be able to add specific busses and read/wrtie to the bus
>>>>> as needed.
>>>>>
>>>>>>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
>>>>>>> ---
>>>>>>>     Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml | 9
>>>>>>> +++++++++
>>>>>>>     1 file changed, 9 insertions(+)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
>>>>>>> b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
>>>>>>> index a55e9bfc66d7..a7ce72e1cd81 100644
>>>>>>> --- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
>>>>>>> @@ -38,6 +38,15 @@ properties:
>>>>>>>       clocks:
>>>>>>>         maxItems: 1
>>>>>> You mentioned about new compatible strings, does the one currently
>>>>>> listed in this binding support both bus types?
>>>> You didn't answer this, and there's insufficient explanation of the
>>>> "hardware" in this RFC, but I found this which is supposedly the
>>>> backend:
>>>> https://github.com/analogdevicesinc/hdl/tree/main/library/axi_ad3552r
>>>> adi,axi-dac.yaml has a single compatible, and that compatible has
>>>> nothing to do with "axi_ad3552r" as it is "adi,axi-dac-9.1.b". I would
>>>> expect either justification for reuse of the compatible, or a brand new
>>>> compatible for this backend, even if the driver can mostly be reused.
>>>>
>>>> Could you please link to whatever ADI wiki has detailed information on
>>>> how this stuff works so that I can look at it to better understand the
>>>> axes of configuration here?
>>> https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
>>>
>>> that has same structure and register set of the generic ADI AXI-DAC IP:
>>> https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
>>>
>>>
>>>>>> Making the bus type decision based on compatible only really makes sense
>>>>>> if they're different versions of the IP, but not if they're different
>>>>>> configuration options for a given version.
>>>>>>
>>>>>>> +  bus-type:
>>>>> DAC IP on fpga actually respects same structure and register set, except
>>>>> for a named "custom" register that may use specific bitfields depending
>>>>> on the application of the IP.
>>>> To paraphrase:
>>>> "The register map is the same, except for the bit that is different".
>>>> If ADI is shipping several different configurations of this IP for
>>>> different DACs, I'd be expecting different compatibles for each backend
>>>> to be honest
>>> i am still quite new to this fpga-based implementations, at least for how
>>> such IPs are actually interfacing to the linux subsystem, so i may miss
>>> some point.
>>>
>>> About the "adi,axi-dac-9.1.b" compatible, the generic DAC IP register set
>>> is mostly the same structure of this ad3552r IP (links above), except for
>>> bitfields in the DAC_CUSTOM_CTRL register.
>>>
>>> My choice for now was to add a bus-type property.
>>>
>>> Not an HDL expert, but i think a different bus means, from an hardware point
>>> of
>>> view, a different IP in terms of internal fpga circuitry, even if not as a
>>> register-set.
>> Depending on whether or not the unmodified driver can be used with this
>> IP (so the QSPI bus stuff would need to be optional) then a fallback
>> should be used given the degree of similarity. It, however, seems likely
>> that is not the case, and without the QSPI bus there'd be no way to
>> communicate with the device. Is there any reason to use this IP as a
>> backend, without connecting the QSPI bus at all, leaving the ADC/DAC on
>> a regular SPI bus?
>>
> Somewhere in my replies, I'm doing the exact same question to myself. We probably
> need to speak with the FPGA folks but I guess (hope) they had a good reason for this.
>
> - Nuno Sá

to clarify a bit the custom (fpga-based) QSPI need, i did some checks in the
datasheets:

1. ADI is actually supporting ad3552r by eval-ad3552r-fmcx eval boards,
with specific fmc connector for the ZedBoard (zynq7000). This is the
current focused hardware for this job.

2. Zynq7000 std non-fpga controller is designed to control flash memories,
but can operate in "raw I/O" mode, so it may work with ad3552r, but is not
supporting DDR, even if it may reach 100Mhz clock.

3. ad3552r accepts a maximum clock of 66Mhz. So for ZedBoard maximum speed
of 33MUPS cannot be reached without DDR.

4. ad3552r requires DDR only in the data part, and in DDR mode we
may also send some "non-loop" reg read/write, so requiring also the
address to be sent in SDR. Not sure how many QSPI controllers in the 
market are
working this way, even if it seems quite standard, looks like not many 
are actually
supporting DDR. There may be, but not actually in the priority of my 
customer
right now. And in that case, we could extend the generic spi ad3552r.c.

Regards,

-- 
  ,,,      Angelo Dureghello
:: :.     BayLibre -runtime team- Developer
:`___:
  `____:


