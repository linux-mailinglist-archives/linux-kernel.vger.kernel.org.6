Return-Path: <linux-kernel+bounces-233562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B789391B985
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B4EB28313A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 08:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC07B145FEF;
	Fri, 28 Jun 2024 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nEuFO3UF"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42C0143881
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 08:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719562229; cv=none; b=OnKXWba36jMco5t65TEz1AERRUpdCCNJxhVI5gm5dZP5VBYPKXjWdCr+aT0LwtZMc/3KjQpTYQ1A1+wxIg1OYEYbaknMsM94BNa6bjltBXeB8CCWtmZ4Ac1a2JGLjASQeUXK/Ap1o8HKkyYsM8Lf6u/Pllwn4oWa1Iwo/ELvMiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719562229; c=relaxed/simple;
	bh=Lu06sykTGqIRcI8RMkVT9f/KiqOzh8P3mPtNhTs1gI0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XmIt9aCxAj43myOlnrergGWmi81DIO8hHoBNoquPL0ZoValv0mceA+FSbToM+FWHjP0ofUzUqcApgJ+NvaPtefFpDCqqCDk49Ep9iGLlqBg/CYRaIdPO5yV//nGCfwGH76WclUld3gbGo++19/tYXXZ0q8iqHQMGFacvJj6ZWk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nEuFO3UF; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52e764bb3fbso398914e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719562225; x=1720167025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wx6Kfw8qVkhu43FPigNKkiagy9yQK+KD3/V0XMmuLoQ=;
        b=nEuFO3UF3748dWAn//wloGFLic9Ikz5ybnzMIjF382VGBhQXDVvoMKasA8GXkyCq9/
         14PPzzYkOagA7R0V08nnTcAKp0UrIcjZ9IRZBpxYApfPidyy4EyqSblwbjgrIeNQs33p
         AfNxJtkCGVENwxCTLSXdVCyB23eXEQ2lNkNrVR0JBa3JowNhzIOxshTUEsQ88KO4MNR5
         7xdg/1tSUYx5iLUddeJR1Fhr2/qXKBdLYRozbi9VLCiqQjq1GUj8dLugAseAbniv1GJl
         De6RbCEqKJzPfENFjiYFSLSvbVhe6o9rQ/34IrDR3EZENQc9xuWbe+DyYVhj0cEKd1rP
         M9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719562225; x=1720167025;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wx6Kfw8qVkhu43FPigNKkiagy9yQK+KD3/V0XMmuLoQ=;
        b=KmlDQONTrjP9uYHEMS34R33UeAmKOuOsh1D2ZF+/+J13MMDMpRR5vgY24HKm+YelpV
         5gINsHjFJYPtMjuUhJOHC5i8HnCd0Z5yM2Jsd2ippq6beSkqYMnapvKTMUVBH6COXIaa
         ypOiH6NnwEftp0F7v1ubqbghkeO+0iBaFr8sK6i3AWbNTCbJq1PSQePEdYUBwRv9RnHk
         trlCYC/A6SyuJgE/yJ54FAl00fpudob5RXdMYSC3KRQ4Odd+KkZRM1VAqgXuioAdypOL
         6AuSo3hlrXq4d4QZ4lTprVO8GStMp837aMHuulC5w4KRUbQuJQ8rdaBP62lANcwps2o+
         2tZg==
X-Forwarded-Encrypted: i=1; AJvYcCXcRAe4OKWsmVbttYQjYHul36hcMFnyx2rQpvd8GL1Hj60p6T1RoxY4Rxc64enpzN3GIJZqAIm6c/eZ6sxk4cRGK7pBatWhYNFrVNts
X-Gm-Message-State: AOJu0Yz7kZR9FAEgSGmC1gd8HaXvLq3tZkMivt53BRLZEfg54BprjuUe
	LIipz/Etztje8Vx6/qsXEIfcK4j9haR1GOvpuBWM1GGFyVj9c6PWfyKziho9sqM=
X-Google-Smtp-Source: AGHT+IGTO9W7Boht9fioCYhTcSmnpjcrLoWd1bSV6nEc8wC/5NmPCAVlrVj69S7MOt078ZRE7j0ZSA==
X-Received: by 2002:ac2:43cd:0:b0:52c:cc46:d59 with SMTP id 2adb3069b0e04-52ce1834575mr9162934e87.18.1719562224200;
        Fri, 28 Jun 2024 01:10:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b17d:324d:ca1:ab31? ([2a01:e0a:982:cbb0:b17d:324d:ca1:ab31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd60dsm1489067f8f.2.2024.06.28.01.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 01:10:23 -0700 (PDT)
Message-ID: <16ec9c9a-badb-4626-9227-fb03f0ee3ee6@linaro.org>
Date: Fri, 28 Jun 2024 10:10:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/2] arm64: dts: amlogic: handle hdmi system clock
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20240626152733.1350376-1-jbrunet@baylibre.com>
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
In-Reply-To: <20240626152733.1350376-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 26/06/2024 17:27, Jerome Brunet wrote:
> This patchset adds the setup of the HDMI system clock for HDMI Tx.
> 
> This is another step in cleaning HDMI Tx and its direct usage of HHI
> register space. Eventually, this will help remove component usage from
> the Amlogic display drivers.

Thanks,

Beware we will need to keep old DT with new kernel functional for a while,
do removal of component & HHI in meson_dw_hdmi would need to wait for multiple
kernel releases.

A migration step would be to add a phandle to hhi right now, so we can drop
components earlier, then in a second time add a proper PHY and then mark
the hhi reg as deprecated.

Neil

> 
> Jerome Brunet (2):
>    arm64: dts: amlogic: gx: correct hdmi clocks
>    arm64: dts: amlogic: setup hdmi system clock
> 
>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 5 +++++
>   arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi       | 9 +++++++--
>   arch/arm64/boot/dts/amlogic/meson-gxl.dtsi        | 9 +++++++--
>   3 files changed, 19 insertions(+), 4 deletions(-)
> 


