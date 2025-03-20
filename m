Return-Path: <linux-kernel+bounces-569672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35067A6A5DF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35CAD48458A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C92921E0A2;
	Thu, 20 Mar 2025 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vo6d9R3x"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC1C2206BB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742472289; cv=none; b=r/q2G4S8wUPPswM6qrAn44Z/ciCB1ru1+3nhPYucPRupvcnIaPC2jqlC6Khqb7ieiwIN72rMlrLiF8EdQN5rYOSAcBlBmqt2xpRMVSJwoQI3pPMlpsXqYJR2je2SxEcGILGoWgvcHdZIyLX2zoj6pOyggw5ZQUfrt/Ih++8b2V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742472289; c=relaxed/simple;
	bh=77R0+WDK+CiW222m2j6nCq925OkrZbkqCqIG552WaqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3CMrT0EHIYTwI0DOhaHq+ssjlL1o5HpGNYYbPWdKS6GcjNqVXHG5IUmPzIHr7xAtCniZ87LFjhAbiAYCXJm3MaTajQlvWlLBh6DNLdYbolqdof1TtXg6LaQOsx09+mn5h9oxajGOMPn547lXGjl1k426OIdXp7gN7AMaJeacH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vo6d9R3x; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39149bccb69so613614f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 05:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742472286; x=1743077086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PrGy4VeD8Ex7ajU9H0HLnGoiP3RQMZA4og2eM86qR5I=;
        b=vo6d9R3xMjGQrG5/uA5N752ONexv2ELy0nNHJTLVLUPB+2rm5UCSXG1Q1/gS9Sx8DR
         YdiWXpxKjfO8a9SreMbHwmZdsMlJTdEy7MCD25Jav+0tEMf9/GjSz8TQZxc596jOyID1
         /AwhLf/YFME2UtS7X3vQy+Mkpw2C2Y3K+KmCWhiUb4Mv0X7WVImgXuUPiu8gIBTDXqWJ
         RXK811oqqNcIeUBQHo9OhFA+ICi+j1XUc6SY1Hkdt4JEM5DowouufLEuXqa+6yWrosY4
         GLlcjZKkhnwQhMu5mU61Z4OVluS8fp3oI4+j+6aOqFctwjWasiSL6khQtzWL2uNgWOrf
         Nyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742472286; x=1743077086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PrGy4VeD8Ex7ajU9H0HLnGoiP3RQMZA4og2eM86qR5I=;
        b=oD/39mLOUnd/jmaCMIVRd+otUEvseX5v+zE2TIqzHC06nnV8NoRlOkyK0Gt7Bh8pQn
         KCWdLuGc/rixBC5G08REDcQodD5NGIbpsj5rQQ4SjRPt/7YqkHA0RjNObQ46ND+TbMJE
         Gx4RK2M+PO3LqJOakuFtBcx2ExJfcUaAa0MsqUG4EeFaA9p/a7WEeTIdrbj3/U00V/t4
         vl/2+Igpi3GdudkYoL7Q4tCDaB6LYzAhf9qt3IbZd/QcOm64X35HDHWkHbBzzwr1Pm/L
         o30rMDbBTmUHHOLGy2Mu0ekBp6hyErwZhrEoidIdBsAvojbk7P3752mrcgLSna4HJuyl
         NV/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVu4tD1RKaCDCbHGW23YS/MIc6Ep4UzA+aRR3vqJvkURiCO9tGcJmITcFIlvvW2CEBkCX99XjKJANcGYTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN9VLCj81fqQNXl3iybhmDC2liZ3daTLjcaNX9QM/dLmQPL4Z6
	gLPjgFX4M8xJD+Aqlu3KaBWATda8VlEr3UbnxGmOzZGHt5njk7nzFR4x+Z9PL9I=
X-Gm-Gg: ASbGncsrVMXcl4MU7VGRjeEryr03nREBMVgaQjpMDF3A1evfnLFuIOcc0VdcWAPQcUw
	kOQ/5L75qZzKDk2Gl8Egdpqgs5KLQQe4b86WEtiSHP0gMdlP715Xz7fybTJmx/Hie5c4O9xyax+
	LtD+E/1gJEt7YUnWN7nuU4mN/wRFNcxGm3dWFuwIM+TA2AULfmWh7rK33CGGPt8iehN/K6LMaDK
	fxg0WbSAhRIC8lILTB8ybnN8pr8jQ3Y1nBpBNNKAEp6cUeEvBiicT03Ke4Zm0UmFdImbE4tClp9
	U7MnfSJFd/HCcK88QFru7fGgbly5UvtKIje5/UT3Doo1g9KWCL8pIN7zekHOkSg=
X-Google-Smtp-Source: AGHT+IE9QxB+sJbY4sWMGNKOVwFQciuFplHZH1WkT8GnCUzXiGRLWi85+F6Q8dQwagRFnJerA8H6wg==
X-Received: by 2002:a05:6000:2a6:b0:390:e8e4:7e3e with SMTP id ffacd0b85a97d-399739b484emr5671406f8f.6.1742472285604;
        Thu, 20 Mar 2025 05:04:45 -0700 (PDT)
Received: from [192.168.68.117] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-395c8975d65sm23981874f8f.56.2025.03.20.05.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 05:04:45 -0700 (PDT)
Message-ID: <647536bd-9c0e-41fa-9a63-86f290f49421@linaro.org>
Date: Thu, 20 Mar 2025 12:04:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100-tuxedo-14: add sound support
To: Maud Spierings <maud_spierings@hotmail.com>
Cc: andersson@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 ettore.chimenti@linaro.org, ggo@tuxedocomputers.com, konradybcio@kernel.org,
 krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org
References: <20250319143613.11177-1-srinivas.kandagatla@linaro.org>
 <AM7P189MB1009C6144E943460E1388832E3D82@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <AM7P189MB1009C6144E943460E1388832E3D82@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 20/03/2025 07:13, Maud Spierings wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch adds sound support for this platform,
>> support includes
>>     - 2x Speakers.
>>     - 2x dmic
>>     - Headset
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>
>> This patch depends on
>> "arm64: dts: qcom: Add device tree for TUXEDO Elite 14 Gen1" patch
>>  https://lkml.org/lkml/2025/3/6/867
>>
>> ucm changes:
>> https://github.com/Srinivas-Kandagatla/alsa-ucm-conf/tree/x1e80100-tuxedo
>>
>> tplg changes:
>> https://github.com/Srinivas-Kandagatla/audioreach-topology/tree/tuxedo-elite-14
>>
>>  .../qcom/x1e80100-tuxedo-elite-14-gen1.dts    | 190 ++++++++++++++++++
>>  1 file changed, 190 insertions(+)
> 
> <snip>
> 
>> +&smb2360_1_eusb2_repeater {
>> +    vdd18-supply = <&vreg_l3d_1p8>;
>> +    vdd3-supply = <&vreg_l14b_3p0>;
>> +};
> 
> This seems like it should be part of a different patch? Or should be 
> mentioned in the commit message.
> 
True, i thought I got rid of this before sending.
Thanks for spotting, will fix in next version.

--srini
>> +&swr0 {
>> +    status = "okay";
>> +
>> +    pinctrl-0 = <&wsa_swr_active>, <&spkr_01_sd_n_active>;
>> +    pinctrl-names = "default";
>> +
>> +    /* WSA8845, Left Speaker */
>> +    left_spkr: speaker@0,0 {
>> +        compatible = "sdw20217020400";
>> +        reg = <0 0>;
>> +        reset-gpios = <&lpass_tlmm 12 GPIO_ACTIVE_LOW>;
>> +        #sound-dai-cells = <0>;
>> +        sound-name-prefix = "SpkrLeft";
>> +        vdd-1p8-supply = <&vreg_l15b_1p8>;
>> +        vdd-io-supply = <&vreg_l12b_1p2>;
>> +        qcom,port-mapping = <1 2 3 7 10 13>;
>> +    };
>> +
>> +    /* WSA8845, Right Speaker */
>> +    right_spkr: speaker@0,1 {
>> +        compatible = "sdw20217020400";
>> +        reg = <0 1>;
>> +        reset-gpios = <&lpass_tlmm 12 GPIO_ACTIVE_LOW>;
>> +        #sound-dai-cells = <0>;
>> +        sound-name-prefix = "SpkrRight";
>> +        vdd-1p8-supply = <&vreg_l15b_1p8>;
>> +        vdd-io-supply = <&vreg_l12b_1p2>;
>> +        qcom,port-mapping = <4 5 6 7 11 13>;
>> +    };
>> +};
>> +
>> +&swr1 {
>> +    status = "okay";
>> +
>> +    /* WCD9385 RX */
>> +    wcd_rx: codec@0,4 {
>> +        compatible = "sdw20217010d00";
>> +        reg = <0 4>;
>> +        qcom,rx-port-mapping = <1 2 3 4 5>;
>> +    };
>> +};
>> +
>> +&swr2 {
>> +    status = "okay";
>> +
>> +    /* WCD9385 TX */
>> +    wcd_tx: codec@0,3 {
>> +        compatible = "sdw20217010d00";
>> +        reg = <0 3>;
>> +        qcom,tx-port-mapping = <2 2 3 4>;
>> +    };
>> +};
>> +
>>  &tlmm {
>>      gpio-reserved-ranges = <28 4>, /* Unused */
>>                     <44 4>, /* SPI (TPM) */
>> -- 
>> 2.39.5
> 
> Kind regards,
> Maud Spierings

