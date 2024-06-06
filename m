Return-Path: <linux-kernel+bounces-203767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 494998FE037
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B950328573C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6258513AD38;
	Thu,  6 Jun 2024 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ommvAfEc"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A72113AA32
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 07:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660467; cv=none; b=bU4BI0Xpc7PKEgdEKr9MaHdXC/32+Gi+goAucv1LY+RNc8JLN7YidHI4jlsCEC0A/rcTUq7XbYc05VZb5UmCVHzWsvNcGCgtCi/gPVp7onJ7UIrNU6XiamwOqpY6ptEXkKJJVTOND5lNxRC8aVxpFxQt9Mq2cY4kYVl1wHghP3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660467; c=relaxed/simple;
	bh=kFiTBzr+9uxPDhZuEKTHcAxsHLjfIkq43/MvTdE9Rt0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MdAZfdph/yfdgr+86qpiaK5206biZ9LLJ9nqJes8PLBQDS1GQTThzCF/qCtoWeTd3ZMTRVCjqH5R0mrNoHgsUsXy4Bv0ZeTUEn7oHlm0M5SMpl1i2m/sojb5SL3jN8Gn2Y/HXr047cDCPXUIKcZg1jq8M/SV5ID9RVaDIIYre8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ommvAfEc; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-35e5604abdcso1094171f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 00:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717660464; x=1718265264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmYn9rMjzNzeNgtppFDQy4tGwULHDIGKKfhkuKp/Fsc=;
        b=ommvAfEcOVsmnOspMTkmBpha+KqSfEOBUGVS9KSVckx6ndmlC9l7fDeW2Eq3zH5nnI
         OQCoyh/KwvdgTsNt76aZmfobW04vWAbDnmNH9Wk3BnbnYWLalxJw2S3s0ATkM2bQkY89
         ADn9V3wX1UW+YUm5JJhq22sldW1SRCjzTM5aAWccqanrFB91/E6upo72yhGsy/1n8lgO
         VhmbJAk6oKhPpFhinqfOTNqDQPD1HPWdUymWpDVEjEOnQoIhFSIWjdqQMMuPhglaqOMC
         eYI3oh/4Bewe2QG6cGp9/Snq3Y8LPgQki0E1qsKC2gKCt0sp/ztOTqFDZ79Z/HAbetwg
         Rckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717660464; x=1718265264;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kmYn9rMjzNzeNgtppFDQy4tGwULHDIGKKfhkuKp/Fsc=;
        b=GDbK/yTevPEDQeJjuTxR7VPGOgw/KlvtYkJ/HBD7nJ/c5Ae7yTFg2WL/Z3HfGbaxi1
         DgN1wQdTqMMe3egv/ZP6U3DwMn1Clj9ilYlCJqGyQARwWKuPItu4vAag7NqPBWNaGstr
         IZw/bxRceixIfURGrh4xibpFQrtzlzIGuoW2QCNgBbzvaXWsmp0y4+DwouixF8aHvhdh
         ZuFy+v6iIzeGyxBHQoCfPWiAu2B4zb3GRutGu79FR08bBe3Gd1vfUCK6G8bwF6lRWbRU
         koaBgGwTsN0n5sS1JFp/j14ov2mHYEoIBSTyH8R/zi9mDRKmHG0oRyibq/1YBUPE1gr6
         9jrA==
X-Forwarded-Encrypted: i=1; AJvYcCVV6KvQ27BNc4k+UqNC7NiENGRiAtu1Nl/DPaLAEDM6oX3/xkRMZw0dkApT5COxIAzpWqKiWkv2PERWtHJjt5dZdHcDz29OVit8ZrFN
X-Gm-Message-State: AOJu0Yy4Hoabjwv9U8Pdmr3KgEB3l8J2xSI++tdLAHVPOsW9Grz7HyKo
	fc/xskokSE5CD1ct+KRZdRMirCBP75SQhSihWD/BymW6YPV5W2koBKkUDY74l6c=
X-Google-Smtp-Source: AGHT+IH4KWb4XVK34xYY5tEiXvzfkgFMx11vnQnrD9YBFyNgpHbpBdy+mWtj8PG7uu3umEeRvRNHwQ==
X-Received: by 2002:a5d:6a44:0:b0:357:16f6:71dc with SMTP id ffacd0b85a97d-35ef0d7a2e0mr1635823f8f.13.1717660464551;
        Thu, 06 Jun 2024 00:54:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:22fd:4ae6:287f:17f2? ([2a01:e0a:982:cbb0:22fd:4ae6:287f:17f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158148f66sm47781085e9.32.2024.06.06.00.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 00:54:24 -0700 (PDT)
Message-ID: <1a82eeb8-bb95-4fad-acce-798ba0cda170@linaro.org>
Date: Thu, 6 Jun 2024 09:54:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] dt-bindings: iio: adc: amlogic,meson-saradc: add optional
 power-domains
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240605-topic-amlogic-upstream-bindings-fixes-power-domains-sardac-v1-1-40a8de6baa59@linaro.org>
 <20240605-abdomen-starch-4fd4d7ead431@spud>
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
In-Reply-To: <20240605-abdomen-starch-4fd4d7ead431@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/06/2024 18:58, Conor Dooley wrote:
> On Wed, Jun 05, 2024 at 11:37:08AM +0200, Neil Armstrong wrote:
>> On newer SoCs, the SAR ADC hardware can require a power-domain to operate,
>> add it as optional.
> 
> What about the older socs that don't have power domains, the property is
> now usable there?

Old SoCs doesn't necessarily have an associated power domain, or was handled
by firmware, does it harm if we make it optional for older ones as well ?

Neil

