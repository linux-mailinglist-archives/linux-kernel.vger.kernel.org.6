Return-Path: <linux-kernel+bounces-203738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 416A18FDFBD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65191F2307B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AAE13C67D;
	Thu,  6 Jun 2024 07:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rls46QLz"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BB013AA47
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 07:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717658972; cv=none; b=i0Cq+ma6oQk/oibz+XOnOytECToopCIN69eURmz+iHrCpSKGE+UY8LN6c/5sgCm6D7b/vuvPIV/OuNP03X1lor3T235BqDSXQLRgrY4zFn1ETWxrI76zYhzNTtjkD1YbimMD83VNJJYsRJwAaGSIZcHcX3pBcvhk72AdgaOlDXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717658972; c=relaxed/simple;
	bh=mvugkjV3h9RCu4RO3FAJtYNtn0G5I8hVr+TzUTOCXCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MpNTHZS/C4l5oFPyTYHq7jOR4F70Y4CAJ/+f/CBGKdW9jIYBDrGYSW6Ki5vHyfNxQt4qDvvAdI4fzIV0bK7TL4ypxJFEqT7KVzdn3nU2pK0BDUC8fGBfVHqGBNVDduaPGQo5gMyQfgITR0yu1PZ43L+5NZdcYiZJueBhgFEHrpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rls46QLz; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35dd0c06577so688127f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 00:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717658969; x=1718263769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t8efieOuxLOC4m4WQpfKYHK3Moyv5bSIBkNKefQTR50=;
        b=rls46QLzXlcVlB6WDcpUru5NsOMQSco2yCvGgpJ0Y0U4xxqaekqxIRGOfQJeI6GJJk
         5IJfAAHAZf9HNw3pjTDg9EPGHHmtMQ14sygt65+i67JKvqpqbtFHjuZfoIMvtDVwXg6C
         PnUKu83cCBiz0ZJuZjqs7RaY7m9YEF5qXvGLrngZnX0S43Ofv2hNjx9M3yM9RJxgXRvM
         ALL4YCxYMX7glssdh+wleQejhJWru/3EDKUSD2YeMEl2P/MkCyoDY8jbuSKuokubsXyE
         yA12zZwW2Ld1nYy/iGUsnOI2q4eaw/OQ3FpA/Cc4kGkbvd+kURozh1w/BLTwUof1qxCd
         lfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717658969; x=1718263769;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t8efieOuxLOC4m4WQpfKYHK3Moyv5bSIBkNKefQTR50=;
        b=ekmZmGS11BFYEXShLSbS+sZ4FFZcMjFUsmR3N0SCaFMKY6lwMYQV7/ItqtuKz2uSfX
         yuF60Uofim+/IJ8rpk7uUVvwEFlrlRXZVryt+l//MHbGW68jwYCffacSqKRS398Z8y7K
         BNlqbONU4tyuZG/GkOn7GoHl6R0znCAIQpI89dKM+zKuyOW8vSIBTBASqJ4oje1vbEMV
         c7Oc5lKioqPiFgLYd9XZyNsr89gR5ubULqBgSQaTR3QJwPHWUsV/wtteO6LTnnWJWnJJ
         THl1JDHGPDTK/REgnjEFnbzK6dqT1hJQV7GbLkrZf/TSyxEdXTU8wLo27y0JeYSwAkkD
         40XA==
X-Forwarded-Encrypted: i=1; AJvYcCUAtIP5ZCvJmAQbtvjXP/PPolRUeAcPkkXYIvgTuR+K3BjwhRk89gYHszpI4V72Kom5i9a2NLdPj3fOqftohjOZUUkWZgrK4diBgO9I
X-Gm-Message-State: AOJu0YxZsXzW7hE6J8RJf+JAnYNeKbtVRDjJ1KO/Xks1X2mVCrJbkzzM
	XLRYhYIN3DQ6Ra9hqbIRrIWAzpir5h4oNOFWvMSvDMyvLh7EtwjMKoXOxWRt7Tg=
X-Google-Smtp-Source: AGHT+IETOQHpQmaJnbdrwXqa+sTVxNSmnoSfXPg7tewRbQMQzP8hgL3GQV0b4Cr4hrNt8Rgp00jRAg==
X-Received: by 2002:a5d:4f05:0:b0:354:e4e0:21dd with SMTP id ffacd0b85a97d-35e8ef77b6bmr3502850f8f.50.1717658968951;
        Thu, 06 Jun 2024 00:29:28 -0700 (PDT)
Received: from [192.168.2.24] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d29c37sm797266f8f.24.2024.06.06.00.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 00:29:28 -0700 (PDT)
Message-ID: <17c9ef5c-068f-4ffa-a86f-1bacc75f2b78@linaro.org>
Date: Thu, 6 Jun 2024 09:29:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: dwc3: enable CCI support for AMD-xilinx DWC3
 controller
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, michal.simek@amd.com,
 robh+dt@kernel.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, git@amd.com
References: <1717657279-2631757-1-git-send-email-radhey.shyam.pandey@amd.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+FiEE
 m9B+DgxR+NWWd7dUG5NDfTtBYpsFAmI+BxMCGwMFCRRfreEFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQG5NDfTtBYptgbhAAjAGunRoOTduBeC7V6GGOQMYIT5n3OuDSzG1oZyM4kyvO
 XeodvvYv49/ng473E8ZFhXfrre+c1olbr1A8pnz9vKVQs9JGVa6wwr/6ddH7/yvcaCQnHRPK
 mnXyP2BViBlyDWQ71UC3N12YCoHE2cVmfrn4JeyK/gHCvcW3hUW4i5rMd5M5WZAeiJj3rvYh
 v8WMKDJOtZFXxwaYGbvFJNDdvdTHc2x2fGaWwmXMJn2xs1ZyFAeHQvrp49mS6PBQZzcx0XL5
 cU9ZjhzOZDn6Apv45/C/lUJvPc3lo/pr5cmlOvPq1AsP6/xRXsEFX/SdvdxJ8w9KtGaxdJuf
 rpzLQ8Ht+H0lY2On1duYhmro8WglOypHy+TusYrDEry2qDNlc/bApQKtd9uqyDZ+rx8bGxyY
 qBP6bvsQx5YACI4p8R0J43tSqWwJTP/R5oPRQW2O1Ye1DEcdeyzZfifrQz58aoZrVQq+innR
 aDwu8qDB5UgmMQ7cjDSeAQABdghq7pqrA4P8lkA7qTG+aw8Z21OoAyZdUNm8NWJoQy8m4nUP
 gmeeQPRc0vjp5JkYPgTqwf08cluqO6vQuYL2YmwVBIbO7cE7LNGkPDA3RYMu+zPY9UUi/ln5
 dcKuEStFZ5eqVyqVoZ9eu3RTCGIXAHe1NcfcMT9HT0DPp3+ieTxFx6RjY3kYTGLOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCYDzvagUJFF+UtgAKCRAbk0N9O0Fim9JzD/0auoGtUu4mgnna
 oEEpQEOjgT7l9TVuO3Qa/SeH+E0m55y5Fjpp6ZToc481za3xAcxK/BtIX5Wn1mQ6+szfrJQ6
 59y2io437BeuWIRjQniSxHz1kgtFECiV30yHRgOoQlzUea7FgsnuWdstgfWi6LxstswEzxLZ
 Sj1EqpXYZE4uLjh6dW292sO+j4LEqPYr53hyV4I2LPmptPE9Rb9yCTAbSUlzgjiyyjuXhcwM
 qf3lzsm02y7Ooq+ERVKiJzlvLd9tSe4jRx6Z6LMXhB21fa5DGs/tHAcUF35hSJrvMJzPT/+u
 /oVmYDFZkbLlqs2XpWaVCo2jv8+iHxZZ9FL7F6AHFzqEFdqGnJQqmEApiRqH6b4jRBOgJ+cY
 qc+rJggwMQcJL9F+oDm3wX47nr6jIsEB5ZftdybIzpMZ5V9v45lUwmdnMrSzZVgC4jRGXzsU
 EViBQt2CopXtHtYfPAO5nAkIvKSNp3jmGxZw4aTc5xoAZBLo0OV+Ezo71pg3AYvq0a3/oGRG
 KQ06ztUMRrj8eVtpImjsWCd0bDWRaaR4vqhCHvAG9iWXZu4qh3ipie2Y0oSJygcZT7H3UZxq
 fyYKiqEmRuqsvv6dcbblD8ZLkz1EVZL6djImH5zc5x8qpVxlA0A0i23v5QvN00m6G9NFF0Le
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1717657279-2631757-1-git-send-email-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/06/2024 09:01, Radhey Shyam Pandey wrote:
> The GSBUSCFG0 register bits [31:16] are used to configure the cache type
> settings of the descriptor and data write/read transfers (Cacheable,
> Bufferable/Posted). When CCI is enabled in the design, DWC3 core GSBUSCFG0
> cache bits must be updated to support CCI enabled transfers in USB.
> 
> To program GSBUSCFG0 cache bits create a software node property
> in AMD-xilinx dwc3 glue driver and pass it to dwc3 core. The core
> then reads this property value and configures it in dwc3_core_init()
> sequence.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
> Changes for v3:
> In v2 review as suggested by Thinh Nguyen, switch to swnode implementation
> for passing GSBUSCFG0 cache bits from AMD-xilinx dwc3 glue driver to
> core driver.
> 
> Changes for v2:
> Make GSBUSCFG0 configuration specific to AMD-xilinx platform.
> Taken reference from existing commit ec5eb43813a4 ("usb: dwc3: core:
> add support for realtek SoCs custom's global register start address")
> 
> v1 link:
> https://lore.kernel.org/all/20231013053448.11056-1-piyush.mehta@amd.com
> ---
>  drivers/usb/dwc3/core.c        | 24 ++++++++++++++++++++++++
>  drivers/usb/dwc3/core.h        |  8 ++++++++
>  drivers/usb/dwc3/dwc3-xilinx.c | 18 +++++++++++++++++-
>  3 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 7ee61a89520b..159d21b25629 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -23,6 +23,7 @@
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/of_graph.h>
>  #include <linux/acpi.h>
>  #include <linux/pinctrl/consumer.h>
> @@ -599,6 +600,19 @@ static void dwc3_cache_hwparams(struct dwc3 *dwc)
>  		parms->hwparams9 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS9);
>  }
>  
> +static void dwc3_config_soc_bus(struct dwc3 *dwc)
> +{
> +	if (of_dma_is_coherent(dwc->dev->of_node)) {
> +		u32 reg;
> +
> +		reg = dwc3_readl(dwc->regs, DWC3_GSBUSCFG0);
> +		reg &= ~DWC3_GSBUSCFG0_DAT_DES_RD_WR_REQINFO_MASK;
> +		reg |= (dwc->acache_data_rd_wr_info <<
> +			DWC3_GSBUSCFG0_DAT_DES_RD_WR_REQINFO_SHIFT);
> +		dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, reg);
> +	}
> +}
> +
>  static int dwc3_core_ulpi_init(struct dwc3 *dwc)
>  {
>  	int intf;
> @@ -1320,6 +1334,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
>  
>  	dwc3_set_incr_burst_type(dwc);
>  
> +	dwc3_config_soc_bus(dwc);
> +
>  	ret = dwc3_phy_power_on(dwc);
>  	if (ret)
>  		goto err_exit_phy;
> @@ -1574,6 +1590,7 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>  	u8			tx_max_burst_prd = 0;
>  	u8			tx_fifo_resize_max_num;
>  	const char		*usb_psy_name;
> +	struct device		*tmpdev;
>  	int			ret;
>  
>  	/* default to highest possible threshold */
> @@ -1716,6 +1733,13 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>  	dwc->dis_split_quirk = device_property_read_bool(dev,
>  				"snps,dis-split-quirk");
>  
> +	/* Iterate over all parent nodes for finding swnode properties */

And:
/* non-DT (non-ABI) properties */

so someone will not try to make it ABI post-factum.



Best regards,
Krzysztof


