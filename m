Return-Path: <linux-kernel+bounces-312482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E6D969736
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880CF1C234F2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E281C62A5;
	Tue,  3 Sep 2024 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nmXbsryS"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12092101AA
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352538; cv=none; b=r1+yLWKZXt2+/XWnKcYSTdDU2ZJ+RndsGCsW/VE3GIryhnbbrJt/NMZ3K9Rx8N8+vRLKOP7rPWSbhQD0RjzfeAwVrb9ySCTQuZdvqjFJLILBCD3lgqaO5taDahhmGd40BziqpRawrg8QNRkoVsmYGmQPuq2n5HgArCwep4ndbE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352538; c=relaxed/simple;
	bh=vDruR9yYHZ4E/pMK6RHtOT6QZ6Qy06aISwTWoxzFQYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEXNA5l0zgI4gQsMvyylL4gFwuyEFmi32kts8WPTqb143WHUlh82MMur09TZoPEsiZytzHc23uWixU20E/xkrHTktcK/UHqtc3Vsr9OkdIs/+F0K8jnHKyhQqCYpCjQrXoryvAACO1EPXDbCvfDxyr7YgcH1dGdY1EJurL1Pw3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nmXbsryS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42c7bc97423so28573955e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 01:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725352532; x=1725957332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=md6s8G8C9mdJXYr2CoaZc2M8clQ85CZMXUIryBk1rl8=;
        b=nmXbsrySQfIpT/F6/LfscXNzAFNJAWxeRXIKOcOCfPO1Dp9c2JFScJ6w5raEn1XmMK
         DMST13gTbYJ5Okuzz6dnGCz1RAWpgiEihU/qjhalBPHVq6Cd4xGt5lBjnS4JUkeD667Y
         Q1wh+tbRR4dbTsqBMTnUuaTGhA0q5ga54bKQzV3QlXy/8BkE3Jf0e81pf27yOfLIbvJ0
         9UdyofmU7jvU+ea+TFhgsmd/CEY7dHOkZBOkYt6w+inoPBIUgnHF3Ev4sI/miG+pueYz
         SyYPI1pffGAr+9VRKB+rs/wZBS9OllrkLf3QeXZShX0xgcaHnEznwramknqkVop0CDAg
         /K8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725352532; x=1725957332;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=md6s8G8C9mdJXYr2CoaZc2M8clQ85CZMXUIryBk1rl8=;
        b=IijiyIJvr0ajsZkgj6z7U97FIIAX14gY0kzoSA2vVZDycgpUueXrRNOclY2r1/LQLu
         DFIZFRakZNZEZJadmzHh/mj8J+Gyr5iczp54ysIqE5eEckHXhi/sj8DqbDcWOvsEhm5Y
         o6FOjFklSbPdeKSNYGVVOvwfnwcMkCb4Rjo+oWj6YHvD/OmcQbpxPS6WiismWbDN2MvY
         MT2Xx2Er8Od+xgLbO24pSRhdkOu1JoEbWHLYBUauqnVWJQ4/vkVR47aBRLl3+o3CQCJP
         POIiapvNfWPEe+U7G99u/CNHYTXM7uZ+45VLydWjdlCfg5IUlGfbLwC5nvksg1GIPABt
         qfmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5KdNyc/6DCL9TAmBx3Io0jpfzf/oYc4WIrmo5fD+S2eB+HP3qBt1gPN85NHWSuZPtTwK7bnNfUhqa3CE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8EmVkfP9qFQXxgZjq/dDafYIJM3wYM0SBb0rT54gmTi7EsHDz
	m6rmJrWHCg8jCXkoU5y+D7PBDGvQ0Hb9cy6QwMjMDNm4RMOxVTWpBrPLC0y4wCw=
X-Google-Smtp-Source: AGHT+IGqTkPeHnw0K6DNl2GwTI/tllz6wlOzjd2DGrrc1enepzliOhoZCW1Tx35v63kPs58Q4Pffbg==
X-Received: by 2002:a05:600c:5102:b0:426:690d:d5b7 with SMTP id 5b1f17b1804b1-42bb01ee5b3mr147075495e9.25.1725352532154;
        Tue, 03 Sep 2024 01:35:32 -0700 (PDT)
Received: from [192.168.0.2] (host-95-233-232-76.retail.telecomitalia.it. [95.233.232.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e273eesm162754585e9.32.2024.09.03.01.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 01:35:31 -0700 (PDT)
Message-ID: <74e0b200-d4c0-4aa3-9ee6-f49ac3f1467d@baylibre.com>
Date: Tue, 3 Sep 2024 10:34:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/8] iio: dac: introducing ad3552r-axi
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
 <20240831123837.26a1070a@jic23-huawei>
Content-Language: en-US
From: Angelo Dureghello <adureghello@baylibre.com>
In-Reply-To: <20240831123837.26a1070a@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jonathan and all,


On 31/08/24 1:38 PM, Jonathan Cameron wrote:
> On Thu, 29 Aug 2024 14:31:58 +0200
> Angelo Dureghello <adureghello@baylibre.com> wrote:
>
>> Hi, asking for comments for this patchset, that is mostly
>> ready, at least feature-complete and functionally tested.
>>
>> I am introducing ad3552r-axi variant, controlled from a fpga-based
>> AXI IP, as a platform driver, using the DAC backend. The patchset is
>> actually based on linux-iio, since some needed DAC backend features
>> was already there on that repo only, still to be merged in mainline.
>>
>> Comments i would like to ask are:
>>
>> - i added some devicetree bindings inside current ad3552r yaml,
>>    device is the same, so i wouldn't create a different yaml file.
> Agreed. If same device, it's usually better to keep it in one file.
>
>> - if it's ok adding the bus-type property in the DAC backend:
>>    actually, this platform driver uses a 4 lanes parallel bus, plus
>>    a clock line, similar to a qspi. This to read an write registers
>>    and as well to send samples at double data rate. Other DAC may
>>    need "parallel" or "lvds" in the future.
> If it is for register read + write as well, sounds to me like you need
> to treat this as a new bus type, possibly then combined with a
> backend, or something similar to spi offload?
>
> What bus does this currently sit on in your DT bindings?
> (add an example)


&amba {

     ref_clk: clk@44B00000 {
         compatible = "adi,axi-clkgen-2.00.a";
         reg = <0x44B00000 0x10000>;
         #clock-cells = <0>;
         clocks = <&clkc 15>, <&clkc 15>;
         clock-names = "s_axi_aclk", "clkin1";
         clock-output-names = "ref_clk";
     };

     dac_tx_dma: dma-controller@0x44a30000 {
         compatible = "adi,axi-dmac-1.00.a";
         reg = <0x44a30000 0x10000>;
         #dma-cells = <1>;
         interrupt-parent = <&intc>;
         interrupts = <0 57 IRQ_TYPE_LEVEL_HIGH>;
         clocks = <&clkc 15>;

         adi,channels {
             #size-cells = <0>;
             #address-cells = <1>;

             dma-channel@0 {
                 reg = <0>;
                 adi,source-bus-width = <32>;
                 adi,source-bus-type = <0>;
                 adi,destination-bus-width = <32>;
                 adi,destination-bus-type = <1>;
             };
         };
     };

     backend: controller@44a70000 {
         compatible = "adi,axi-dac-9.1.b";
         reg = <0x44a70000 0x1000>;
         dmas = <&dac_tx_dma 0>;
         dma-names = "tx";
         #io-backend-cells = <0>;
         clocks = <&ref_clk>;
         bus-type = <1>;  /* IIO QSPI */
     };

     axi-ad3552r {
         compatible = "adi,ad3552r";
         reset-gpios = <&gpio0 92 GPIO_ACTIVE_LOW>;
         io-backends = <&backend>;
         #address-cells = <1>;
         #size-cells = <0>;
         channel@0 {
             reg = <0>;
             adi,output-range-microvolt = <(-10000000) (10000000)>;
         };
     };
};

>
>> - adding the bus-type property vs. a boolean property vs. adding
>>    a new compatible string.
>>
>> - how external synchronization should be handled. Actually, i added
>>    2 backend calls to enable or disable this external trigger.
> That seems more or less fine.  Is there any control over the external
> trigger?  This feels a bit like some of the complex stm32 hardware
> triggers in that a 'hidden' trigger is being enabled.
> If it is controllable or selectable (between say a PWM or an external
> pin) then you may need to be careful how to expose that control.
>
Actually this synchronization is needed since ADI is going to use this
IP also in a a dual layout, so the 2 IPs needs to have an external
synchronization by a signal. But as default synch is not enabled.
Yes, it looks like a trigger. I can check if i can do this in a different
way.


>> - is a read-only sampling-frequency useful ?
> Yes. If it is easy to provide, it can be useful to userspace to
> allow it to figure out how much data to expect.
>
> Jonathan

So this is the last RFC mail i am handling,
trying to wrap up the open points:

- about DAC backend or spi offload, if possible i would not change approach
at this stage, i worked on the provided HDL.
- about reg_read/write, let me know if the void * can stay
- about external synch, i am trying to see if i can do this by a trigger.

Just as a note, Nuno and David was involved helping me on this,
so will add them as co-developers.

Thanks a lot,

Regards,
Angelo


>> Thanks a lot for your feedbacks.
>>
>> To: Lars-Peter Clausen <lars@metafoo.de>
>> To: Michael Hennerich <Michael.Hennerich@analog.com>
>> To: Nuno Sá <nuno.sa@analog.com>
>> To: Jonathan Cameron <jic23@kernel.org>
>> To: Rob Herring <robh@kernel.org>
>> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
>> To: Conor Dooley <conor+dt@kernel.org>
>> To: Olivier Moysan <olivier.moysan@foss.st.com>
>> Cc: linux-iio@vger.kernel.org
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: dlechner@baylibre.com
>>
>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
>> ---
>> Angelo Dureghello (8):
>>        dt-bindings: iio: dac: ad3552r: add io-backend property
>>        iio: backend: extend features
>>        iio: backend adi-axi-dac: backend features
>>        dt-bindings: iio: dac: add adi axi-dac bus property
>>        iio: dac: ad3552r: changes to use FIELD_PREP
>>        iio: dac: ad3552r: extract common code (no changes in behavior intended)
>>        iio: dac: ad3552r: add axi platform driver
>>        iio: ABI: add DAC sysfs synchronous_mode parameter
>>
>>   Documentation/ABI/testing/sysfs-bus-iio-dac        |   7 +
>>   .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   |  39 +-
>>   .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   |   9 +
>>   drivers/iio/dac/Kconfig                            |  11 +
>>   drivers/iio/dac/Makefile                           |   3 +-
>>   drivers/iio/dac/ad3552r-axi.c                      | 572 +++++++++++++++++++++
>>   drivers/iio/dac/ad3552r-common.c                   | 163 ++++++
>>   drivers/iio/dac/ad3552r.c                          | 394 +++-----------
>>   drivers/iio/dac/ad3552r.h                          | 199 +++++++
>>   drivers/iio/dac/adi-axi-dac.c                      | 250 ++++++++-
>>   drivers/iio/industrialio-backend.c                 | 151 ++++++
>>   include/linux/iio/backend.h                        |  24 +
>>   12 files changed, 1494 insertions(+), 328 deletions(-)
>> ---
>> base-commit: 7ccb2c2db44572deadb795c4637273cdabbe8b66
>> change-id: 20240829-wip-bl-ad3552r-axi-v0-b1e379c986d3
>>
>> Best regards,

-- 
  ,,,      Angelo Dureghello
:: :.     BayLibre -runtime team- Developer
:`___:
  `____:


