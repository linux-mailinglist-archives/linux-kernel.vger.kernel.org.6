Return-Path: <linux-kernel+bounces-221162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C7090EFA7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B8EE1C21BA7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC6D14F10F;
	Wed, 19 Jun 2024 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p8Zx8E98"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FD41E520
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806019; cv=none; b=OMMQAL2SF6ZXW+/vSeqTKXg7lpzVhyyCTIpCNC96DtbgiVcBk6hu3HsVmMSCo/hQalNhxr6EPbCgbn6HQWAmY+Z3cjrpiq38Gfji4stDalvtCwg475f2Bu3uxpYn51MjA2L5nDq1OZBWRKksP5+wlNil0bBJ5h5rGkDv2c268s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806019; c=relaxed/simple;
	bh=4zrEjddbae3HIZuiTuoumTh2ZF1woXfdiz/FwqUp/iQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=irLDcB9G5pEeHQnC6n9KSttZNLE5McK+ut/z+qT6Ef+ulkXtQWjznQ/xHJlTFK2/eXutwdal5KMiFF27ApPVVItg2bQwOREK3tTQV0X1SHkiC2WtGtJY8638a63dI5ZUMjD9lK4EApwmWHjVnF7h7IXb2F1huhcMIBKDMApXxOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p8Zx8E98; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52c815e8e9eso6377838e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718806014; x=1719410814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOr4iu6teVpsHNPWQXbJiEP6o5tokwgekB7kWz6BuxI=;
        b=p8Zx8E98VFl3fyJWc+thfgmGktY9cXIQLV4HsLTkIZ8x4DcQrn3eVC7HViNEGHXedN
         htEurqDSjI0zyXzrfq3/k4MdGYVCkJjri+SwyfhICbr7REQ3PmjFUDij5mx7yHwGXYh7
         2Oz02AS9cr5uxvZhaBjy1Gdyn+MscWqclVSAYjUfNkrgtwpyEwElR6+0EgdBvdb4RR7O
         PI5Y6q/OSq30s8xq2g7M5yoS/hH34Bm2SfbZsJNa//XSDLJWV/V6CzL9u+BsReEdESCn
         HtlnlPydH9fvbHYf+mOvtu42fhwm7+nbzMvkRaJNCmpiIk9h9AOoqubrzD6BANkSdAaf
         H2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718806014; x=1719410814;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QOr4iu6teVpsHNPWQXbJiEP6o5tokwgekB7kWz6BuxI=;
        b=wwXs4Ai8C7PJf7l7m3o372IIVQbBysTjojUU98nEXVrNzeTxEUwttyU6SNTs1vxLfY
         Mo0L4rfzehQItZhHp2qP+bXwh3vFRXnEc5gcb1NHwNjpUI1oXkdu1jgxiT05reoyAveb
         hbMzw7pz8czwODhw0kOx+I+++H6G1SypfsTebw/B89Wh3kbmVluivDe5uhw6IOEH2tuQ
         ESplPE5SW99z6fH+ikR0gfKb/VEIfNEqty/XKCCzhPCvmTqSwFylM0bUUqwncpGO4WbK
         iirAs1LdSh7HWDJM7SETdIzxpo7GqlzTNvUVYMHrIsn0Nd/1xx3u88VJaeiuvu6RPnNo
         ulSw==
X-Forwarded-Encrypted: i=1; AJvYcCXEFCtrZUpTZ7KJAvCblaSgttsoHHRMqE26lRvNLR1zdpVn1QgBwSRDz+4F+Y2UR6jJnFINMPVW97rJvwcq/X/guc5p7l88suw8l7lc
X-Gm-Message-State: AOJu0YxVkmPRkSDthzIRnyFpcuauwrMjD8+zo2bu++YSaMgDq5gu094Y
	l28SxS4gIFipR1G6VEyO74oHlt2G1K5RXk8FY6m10mZgQXfpmZZ/ayUPdSujbF5l0RnXOSfxmRH
	9+Wo=
X-Google-Smtp-Source: AGHT+IGZzKxZqU0gSKtpTGhR7ZeeSkZb8RiSot2BWwH0rwzLtW6i8tLMVFpt5/T6tnzm3UjlTpvVAQ==
X-Received: by 2002:a19:f60b:0:b0:52c:dbc:643d with SMTP id 2adb3069b0e04-52ccaa343bbmr1485260e87.27.1718806013488;
        Wed, 19 Jun 2024 07:06:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ed45:cb25:b4fd:b1fa? ([2a01:e0a:982:cbb0:ed45:cb25:b4fd:b1fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e73b1sm269729675e9.45.2024.06.19.07.06.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 07:06:52 -0700 (PDT)
Message-ID: <39d1c5e1-e27b-4736-87e0-ca42ccf8885a@linaro.org>
Date: Wed, 19 Jun 2024 16:06:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/3] arm64: dts: meson: add initial support for Dreambox
 One/Two
To: Christian Hewitt <christianshewitt@gmail.com>,
 kernel test robot <lkp@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 devicetree <devicetree@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, AML
 <linux-amlogic@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 oe-kbuild-all@lists.linux.dev
References: <20240606094513.3949323-3-christianshewitt@gmail.com>
 <202406071527.fnfhnkUL-lkp@intel.com>
 <FB2C9481-FCA2-496D-B916-E429BB8C0C82@gmail.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <FB2C9481-FCA2-496D-B916-E429BB8C0C82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/06/2024 10:31, Christian Hewitt wrote:
>> On 7 Jun 2024, at 12:10 PM, kernel test robot <lkp@intel.com> wrote:
>>
>> Hi Christian,
>>
>> kernel test robot noticed the following build warnings:
>>
>> [auto build test WARNING on robh/for-next]
>> [also build test WARNING on krzk/for-next linus/master v6.10-rc2 next-20240606]
>> [cannot apply to krzk-dt/for-next krzk-mem-ctrl/for-next]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Hewitt/dt-bindings-arm-amlogic-add-support-for-Dreambox-One-Two/20240606-175427
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
>> patch link:    https://lore.kernel.org/r/20240606094513.3949323-3-christianshewitt%40gmail.com
>> patch subject: [PATCH 3/3] arm64: dts: meson: add initial support for Dreambox One/Two
>> compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
>> dtschema version: 2024.6.dev1+g833054f
>> reproduce: (https://download.01.org/0day-ci/archive/20240607/202406071527.fnfhnkUL-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202406071527.fnfhnkUL-lkp@intel.com/
>>
>> dtcheck warnings: (new ones prefixed by >>)
>>    arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7: Warning (unit_address_vs_reg): /soc/bus@ff600000/bus@34400/pinctrl@40: node has a unit name, but no reg or ranges property
>>      also defined at arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7
>>    arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7: Warning (simple_bus_reg): /soc/bus@ff600000/bus@34400/pinctrl@40: missing or empty reg/ranges property
>>      also defined at arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7
>>    arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:2220.23-2260.6: Warning (avoid_unnecessary_addr_size): /soc/bus@ffd00000/dsi@7000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>>      also defined at arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:2220.23-2260.6
>>>> arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-one.dtb: /soc/bus@ff600000/bus@42000/clock-controller@0: failed to match any schema with compatible: ['amlogic,g12a-audio-clkc']
>>    arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-one.dtb: /soc/bus@ff600000/bus@42000/audio-controller@744: failed to match any schema with compatible: ['amlogic,g12a-tohdmitx']
>>>> arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-one.dtb: sys-ctrl@0: '#address-cells', '#size-cells', 'ranges' do not match any of the regexes: 'pinctrl-[0-9]+'
>>     from schema $id: http://devicetree.org/schemas/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml#
>> --
>>    arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7: Warning (unit_address_vs_reg): /soc/bus@ff600000/bus@34400/pinctrl@40: node has a unit name, but no reg or ranges property
>>      also defined at arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7
>>    arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7: Warning (simple_bus_reg): /soc/bus@ff600000/bus@34400/pinctrl@40: missing or empty reg/ranges property
>>      also defined at arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7
>>    arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:2220.23-2260.6: Warning (avoid_unnecessary_addr_size): /soc/bus@ffd00000/dsi@7000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>>      also defined at arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:2220.23-2260.6
>>>> arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-two.dtb: /soc/bus@ff600000/bus@42000/clock-controller@0: failed to match any schema with compatible: ['amlogic,g12a-audio-clkc']
>>    arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-two.dtb: /soc/bus@ff600000/bus@42000/audio-controller@744: failed to match any schema with compatible: ['amlogic,g12a-tohdmitx']
>>>> arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-two.dtb: sys-ctrl@0: '#address-cells', '#size-cells', 'ranges' do not match any of the regexes: 'pinctrl-[0-9]+'
>>     from schema $id: http://devicetree.org/schemas/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml#
> 
> Nothing to fix. The patch just depends on Neil’s binding fixes here:
> 
> https://patchwork.kernel.org/project/linux-amlogic/cover/20240606-topic-amlogic-upstream-bindings-fixes-dts-v1-0-62e812729541@linaro.org/

Can you resent but keeping the assigned-clocks in the sound card node ?

BTW keep the reviewed-by.

Thanks,
Neil

> 
> Christian
> 


