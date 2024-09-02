Return-Path: <linux-kernel+bounces-311211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7A596861D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF941F23B40
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D7218455B;
	Mon,  2 Sep 2024 11:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DCLSVYGR"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACBD183CB7
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 11:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725276194; cv=none; b=CB/vf+/xk2WgZTtTdpCqbMLt51X3qBEiRFMIKm/1lQu3f/2P3jj7ojeNYfH7EVudE8urIVYwZkQo5JT52lkaYrv6NHh0iWkl4EDq4EMPeC37m03RM1BuuyMF1/RO0uCJLaaVEcXzGe6wkUV6ROYO4Qr6LLiqqbYkv7twbBNsnwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725276194; c=relaxed/simple;
	bh=Ie/943GTb1SgXq1257UVGaSTpxiBzcYcTMR/6/Y7a1s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sN8/RvJtnvIhhLBG43Fgzfx2FsY+ry0wQLPt2XGaIK40gcCntfex/yWhLKNfitAHejEy1GpNGMGPjJaUl+FM89UkNKPLyRXgYXHdP85UvSma+OFmoM1H82vebwmM3G3P/x/AzGOkcB5VdU4YRDdUbtXTuWB6UgImNEy6fu8clbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DCLSVYGR; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-371ba7e46easo2734207f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 04:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725276191; x=1725880991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=waKQFxwjFd+XzD3jq2Y4F+AkwNTHxMuKGYVGHmUxWwI=;
        b=DCLSVYGRr26RQsYsLEOr2Yqg4hr5iauwNMqJeh3/ijv3PSvAaMLN8cmDPVZIFbASNw
         euPgmbzibGtxGQNxLj/rz5m4kHKEpGgQgNakSjmLsN7tvkKVFKncTarb8wbX3BDTPEMe
         CC0IYlMkTS8BpRh5v8pejedUqRNwHBtMhJYqTSB7boLX9Koz0Qhz001fxby0f5EHXds1
         7J+49eWcSyQQAiAcYcDQeJWk5+xAhk7JDZ3X1fUqLxibjzxFWKFn5r9nj/Bh41Gwb4BO
         iXv8JgQWbxXv1iKPxSojlgegYcPkjEqgEOAQnbIDJYhpc5TwxTGA3caMN+OD0eNg2c3A
         BDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725276191; x=1725880991;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=waKQFxwjFd+XzD3jq2Y4F+AkwNTHxMuKGYVGHmUxWwI=;
        b=qeGBAv9r9wM2j8IwPoIcuqJKHrEJForShT6msND+k/dQrLmhAn5ZcaMNhqw296RJ0e
         hhITSY4dwEJkeuIZblVRsQ14T0jfPmuxZdYMmmcs1TB/Gql0IBkwX8wUedRc03Bpe3Bh
         8i0c/JbIjDroX3Sx+7TSILhGgZfExBEbf3YVnkJ+kfJR8IF0fs2fBwutSSvQNcLZdCL2
         BXAH+R1n7xZdlmSkiHoekJ6fA0wSC3QL+1NW1NWSrNMTFngs6yLbFNb94g+M6xPpQ6ZY
         MRZCu73l2r4vTWYxXBG4pch/MqP+h9lA70r6YXe2MXE7Cc2op/QQe8/Onl9TQVYluqBM
         AJug==
X-Forwarded-Encrypted: i=1; AJvYcCUrh5P/r6k0w7m7gk9rLvhgQTtKTD7cDWsoz+xGhrcUV1MHl+ADnM4RS6ZiSX3cZWIZgLlslZrfMleCS64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5bt0TWVpnUDop9JVTPk3piCkT03LLQB16qxMUqelQIgDyJTeI
	hShrtY/p6X1D9BdfJsxpKrxtOKnNbc2MfMkx5RdCxFpjplUvr+1MOHmzx9kl79Y=
X-Google-Smtp-Source: AGHT+IEpDNmYXrpdpf10EomzDiJNq0Gvm63STkduz8MpJgaoCh/B3DWwulrMva9nsI/EQHJe1qmbCQ==
X-Received: by 2002:a5d:55ca:0:b0:371:8750:419e with SMTP id ffacd0b85a97d-374bcfe5ea4mr4340412f8f.47.1725276190283;
        Mon, 02 Sep 2024 04:23:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7dba:3cd0:a1f4:e3fa? ([2a01:e0a:982:cbb0:7dba:3cd0:a1f4:e3fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e2737dsm134290575e9.29.2024.09.02.04.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 04:23:09 -0700 (PDT)
Message-ID: <f526b786-e9d0-4004-a4c5-d158a0824587@linaro.org>
Date: Mon, 2 Sep 2024 13:23:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 0/3] Add support for Amlogic T7 reset controller
To: Philipp Zabel <p.zabel@pengutronix.de>, kelvin.zhang@amlogic.com,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 Zelong Dong <zelong.dong@amlogic.com>
References: <20240422-t7-reset-v2-0-cb82271d3296@amlogic.com>
 <d00b9c940d5b6156c846b8e513adff1eba0993aa.camel@pengutronix.de>
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
In-Reply-To: <d00b9c940d5b6156c846b8e513adff1eba0993aa.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/09/2024 12:10, Philipp Zabel wrote:
> On Mo, 2024-04-22 at 19:11 +0800, Kelvin Zhang via B4 Relay wrote:
>> Add a new compatible and device node for Amlogic T7 reset controller.
>> And modify the driver accordingly.
>>
>> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
>> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
> 
> Thank you, applied patches 1-2 to reset/next.

Thanks!

Neil

> 
> regards
> Philipp


