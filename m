Return-Path: <linux-kernel+bounces-573232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D225A6D48C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E27D07A5036
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564212500DA;
	Mon, 24 Mar 2025 07:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O7IVSesG"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B91D27442
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742799832; cv=none; b=Sa/A3XKwuCffXX051DiviOPwvMeK1zjl/BirJGVi6Buy2CpWAvz/kk/nQXZfISyoTl8PPkPle8ENduxQvZ0vRjKiQfg4JhD3h552S4jq/9d58h6f699SrgZgPVWwtss4TZtTIgnk5i3X/EwcmyInKEWG6oq3zuaPeqrF9MQWfWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742799832; c=relaxed/simple;
	bh=8v6DXp8VVOZAcngvnmztj2dWVJSSmculyyNSAPiBw8c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JAS9mju8aw+1nLaKMnH8xPZyGNk7zuo/6yfhBC42S8jJSSKa4qa7j5nA5aYZQbBEMOy3T1pEE3IAfJb0xIl+HYjlsE/Jm3R/kq9HiHveI4jk/U4xArGX7lK3tI1GxnrifkQNRVlpd2XasOJRq61ShPEpi98UJEL5zh6Hxa0kLG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O7IVSesG; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3995ff6b066so2240865f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 00:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742799829; x=1743404629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=evKoye4qr3e2esDEjAClgjzYt25iik3YDkZA93sVcVQ=;
        b=O7IVSesGqV4yJQfbE6gPZ9GAgCnNEcr5vsWiA00HOvgqKm9fyzz0g45q87gzJjCA+o
         dotSwfVv7JZ/0rKU3kau29eW+3Xg+w4Tm3jjtbFqFvgYd/oWsg4XGyfsq+nIwVJ/cWUS
         e/RQXeUO30/WKdjqz+Qz19O7gAtLRdhCYi0XPBg0Z3U8CEAX+AHgdOo8MVo9Pr0eMwFb
         DKTmqvanIKC9nVv9CiQIEDwD6oYxyRljSiQ3n7r67Gcf8KzON1YIwNqSCAuUjn4JVbix
         alTtlrqF+Wp+NbErEt2SeavINe7pt8FqnMPKIZcO87uWaxgDSRrrsuvLyBescd99NHx5
         mZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742799829; x=1743404629;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=evKoye4qr3e2esDEjAClgjzYt25iik3YDkZA93sVcVQ=;
        b=EHwL9Fm2xRj92pxBRIXxjfZmdqiWfxUm4HEQAklxje2siXIMxbyrcs3x3xpOSuS+Is
         v3L9qNNaMrNTD9cim0hI5at00cmHTsDPSm8mgukUrDZHrTwDx75EV/SbkFVTfGI/7HW+
         cbBG/x3WIBQBlLxX9DfvF+GbR6HBLHQczZbtnIml1pdNuhpM2iBhCaPG/9yN1DK2l/vs
         v/00C3xOHmI7iF+NEM+07YITZvo7Jyv8TSLtAMCYGCGy7+TFVAroN7yrGXjudLMWx+89
         Zumsof2PZmu0eT40kj78kJbI0yBq3QIgd4EMq2Zo3GXZV8XgYITOryGepi+FHpw5Ztu5
         C6NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSvgtjZ43sfaIEYPShxn1Y+nO74MFl0aVm+8m3Vs/fVOiMf+HgVHsf+li3vGl3AyjSnQeZsqgZ+9GudTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9g+fd8MwrONIrRFO6HxiJTBLkOmly1gqONLOgGt1RP8vqLAxt
	E/acFNe6F6SNvGaQa7P9QTAVZJYLYbtzZR58SM0gTcXIEDSxor+b3UEgTu+kvYg=
X-Gm-Gg: ASbGncta8PHzjvZiPMIvRQZyli+obcQzZF/YCKzAkPZiJ3v3d9Z3aCqVvZ+ohd3zebK
	MKbn/OXg8IA7XuY3kv6IenWTCR5j1EaFjQr9ct3XHLBLAXA6zmunU1xE29JmU5o0cYN73qOIRpF
	P0Mu/og5SjOxVhLlb70JomoyuL1bavL8RXuspwHOUU0UGlcwBfDO6nbHo4WSv2Fj8KMmSn05OGt
	3f6fp9Z+QHw4DS0EKz0Jh+WF0E98Yh7B86380OaU8PHrRBSOZpAWQdorlCQnnJ8V+GwOozD7TUD
	r6ruxbMGq/VSYy5ijA90mKI1Z/qYirsWY0u+DIcNYfgE1AQvJt3o+e67wfICLKGPMsWmOJSTRYu
	ql9QF4gBXeFgGnjo7
X-Google-Smtp-Source: AGHT+IFrItb54fv7OtyWO3JUfvqB/p+6ybKUl5+PzXmwRlD5DkQF8OviAn1ax7qXq3VcP+u5iINy8A==
X-Received: by 2002:a5d:5f96:0:b0:391:2fe3:24ec with SMTP id ffacd0b85a97d-3997f91072amr9832062f8f.14.1742799829315;
        Mon, 24 Mar 2025 00:03:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:a356:8d0:d4d:bb5f? ([2a01:e0a:3d9:2080:a356:8d0:d4d:bb5f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b5939sm10243311f8f.60.2025.03.24.00.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 00:03:48 -0700 (PDT)
Message-ID: <88dbbf6e-7886-4261-ac46-55738156a5fb@linaro.org>
Date: Mon, 24 Mar 2025 08:03:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 2/2] arm64: dts: amlogic: add support for
 xiaomi-aquaman/Mi TV Stick
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Ferass El Hafidi <funderscore@postmarketos.org>
Cc: Kevin Hilman <khilman@baylibre.com>, Jerome Brunet
 <jbrunet@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 Artur Weber <aweber.kernel@gmail.com>, Karl Chan <exxxxkc@getgoogleoff.me>,
 Christian Hewitt <christianshewitt@gmail.com>
References: <20250319190150.31529-2-funderscore@postmarketos.org>
 <20250319190150.31529-4-funderscore@postmarketos.org>
 <CAFBinCArRO-F59tOv9m27f+DV+qhy69OGUunGOAbDdfOdd5_Xg@mail.gmail.com>
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
In-Reply-To: <CAFBinCArRO-F59tOv9m27f+DV+qhy69OGUunGOAbDdfOdd5_Xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/03/2025 23:36, Martin Blumenstingl wrote:
> Hello,
> 
> thanks for your contribution and sorry for the late reply!
> 
> On Wed, Mar 19, 2025 at 8:02 PM Ferass El Hafidi
> <funderscore@postmarketos.org> wrote:
> [...]
>> +       au2: analog-amplifier {
>> +               compatible = "simple-audio-amplifier";
>> +               sound-name-prefix = "AU2";
>> +               VCC-supply = <&vcc_5v>;
>> +               enable-gpios = <&gpio GPIOH_5 GPIO_ACTIVE_HIGH>;
>> +       };
> I couldn't find any pictures online that show an analog audio output
> (typically a 3.5mm socket).
> Can you confirm that this is really present?
> 
> [...]
>> +       sound {
>> +               compatible = "amlogic,gx-sound-card";
>> +               model = "XIAOMI-AQUAMAN";
>> +               audio-aux-devs = <&au2>;
>> +               audio-widgets = "Line", "Lineout";
>> +               audio-routing = "AU2 INL", "ACODEC LOLN",
>> +                               "AU2 INR", "ACODEC LORN",
>> +                               "Lineout", "AU2 OUTL",
>> +                               "Lineout", "AU2 OUTR";
> If there's no analog audio in/out then this section can be cleaned up
> as well - together with the references to acodec in the dai-links
> below.
> 
> [...]
>> +/* Wireless SDIO Module (Amlogic W155S1 / Realtek RTL8821CS) */
>> +&sd_emmc_b {
> question to Neil: since we know that there's two board variants out
> there (with different wifi chipsets) - are dt overlays down the road
> enough (to enable Bluetooth / wifi - depending on the chipset or board
> revision) or do we need to split the whole .dts?

Perhaps yes

Neil

> 
> 
> Best regards,
> Martin


