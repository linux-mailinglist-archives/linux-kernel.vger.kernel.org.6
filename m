Return-Path: <linux-kernel+bounces-569468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE48A6A35D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73D2E3B6848
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558052236F3;
	Thu, 20 Mar 2025 10:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z9knasg0"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030B421B909
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742465638; cv=none; b=Ah09FFykB1sdkFK6y7pDPK63e1Y6BnvFlNqGVsEt2vCHWbriWBzCQmdeP/4PFBkaw4ASR/jDEjKOwHlNbHFMuzNxy0vG65rb2P8gtW3ESMnaVh8qk3l60BkuNQ1RqtHZ8cpsrLMKjWWGRG7Pk5AhISGO64XlDc8Nkj28eZhszyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742465638; c=relaxed/simple;
	bh=S11fedHhosY54Bc91quv/K0qTQ/kq6TxJKQcDVOrQ+c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cM2/oxpjeJ3OPcv1mPOilisK6oFOQ+298rkKnd4VLC0jwTovLnxcqB7Rc94/IAnbKJC3YQR//D4B9oWh0dLY+RCUjF5JFt1NypiCd/GuR98kd8zC6Y4DMQdvswaiiTP/IRvS2CjQwbx8tpnlmvO1DhZAgZ/WfeIFrzzPqgECSaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z9knasg0; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3913d129c1aso379901f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 03:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742465635; x=1743070435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bV66V/p60Wk+2XhxvPR3Nk3GpUu5hUuAdEAB2IaMLaM=;
        b=Z9knasg0OvvJHOwLlGFqxauzyM/yr95xpRLZhMWd7CgSRpVgHKNlCsrekZgBdVdfO7
         KfshRtyt+7lA2cWmUoUd41ZUFFT3X0ejSTaC9jHuf6Vzattrkk6cZmjqGY2SovlymQvQ
         MTTHcm6x2EyB9D08xAYgzIYNagM/Eq+c+C+fA4wN5K0FUSdwpP458Fg1SVZs2Vvx18DH
         dNJDXfjbgaK4svCsr2xXWdPgqSGu7ebNLnpn49ZqwQ6OExM5mVphMMZvD69pHrQcpT6d
         kdxyoSj99lLZBkKEDYKo8mjA/MvcHAdbtRu96nAgyvC4aeslBdGrLnQ4lmx0/dlyLhvT
         YBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742465635; x=1743070435;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bV66V/p60Wk+2XhxvPR3Nk3GpUu5hUuAdEAB2IaMLaM=;
        b=R31RyS6wYhie5qTa78HKbdsO8bCUIZlkkHVmquaqHkJx7C+cKo94RTwTSc+Xyj1iVe
         tc/9y+3LHtwi11pJgy9ewRTyLDnHm4LCJ3estbvAmjFD+AhTtXdKeBRKzzJug8xbGQst
         /tL+urdQy8Z32lsaOslfYYFftaSRmhc5dzG0Ya8qNcy+sqgdpdQgRsZu5s0Gki9V+Gm6
         3ik7WY4iqx4eBDeFBZ5w0ja7p0jV2H254yIp9fpEX0iW+Z7Zikg5VX3HdaCHjJL/mMmx
         m5Ovy8hXwqiKmyN0hGXUzBQAspgyGbFdiNg4p0CdGND+yEtYtmg/1VEBakx/QoUkecKQ
         Q0lg==
X-Gm-Message-State: AOJu0Yw0qLJHvNPkWg5fVu0H/41kLo96Ldu2+Ik/7+pmdYcxc38lJj7U
	royl0C534oFw5eLRCgLAtDfnwZ5OIeachpGoyclYGKAINPI9f8JqJ3SmXWtq4yY=
X-Gm-Gg: ASbGncu+I6xS3+v9wLoCUvEP+qt6A9u4ts8izRzgsT3gyoEZf6wlkf5M1iH6mhLvcjZ
	Qrp8rEp5DU1Eslm9y3nge7NmuW0IqhjmzJakmUJgq2T5XzrUdeGMH2MYJ4l4dpwcZbNtdq2UrDw
	mFI/G5NaCtZxHstRWZqD6vigdr2orHE/ADWnhIKJNy4ZSvNC8NtIqUDbCIvGzL5I5Nymr0UywRd
	dvKO/Yxke6Oj5ieFtCRFeOrbD26317EyB3PVqV1xw9OcsCwOAXJ7wCBJFd9gTZJaS6nbfB9SChb
	5rM96nprSuMVfaDJ+s8+VvZw8smZ4pyKdVGFzb3bQtOg8qJt1K8iVWuvWVsMxBqIv4hjSWaez1l
	7FbrKhQ3Rdy3xDnXretKbubs8W/A=
X-Google-Smtp-Source: AGHT+IH8USMlxcvWw3brdBxbL20R/qbI2aQmWJLGCZnD+dGhlJtalJjKJ2p9WsroJVe2qodDZtR+cg==
X-Received: by 2002:a5d:64ce:0:b0:38d:dc03:a3d6 with SMTP id ffacd0b85a97d-399795567f7mr2513425f8f.4.1742465635222;
        Thu, 20 Mar 2025 03:13:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3bd:568:f697:d1a2? ([2a01:e0a:3d9:2080:3bd:568:f697:d1a2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6a5esm22990493f8f.27.2025.03.20.03.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 03:13:54 -0700 (PDT)
Message-ID: <6f1470ee-4807-40be-8f22-d093700a575a@linaro.org>
Date: Thu, 20 Mar 2025 11:13:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: linux-next: Signed-off-by missing for commit in the amlogic tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Kevin Hilman <khilman@baylibre.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20250320211150.3d09eb46@canb.auug.org.au>
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
In-Reply-To: <20250320211150.3d09eb46@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 20/03/2025 11:11, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>    5ed591a0d5dd ("MAINTAINERS: Add an entry for Amlogic pinctrl driver")
>    7c17ddbb050e ("pinctrl: Add driver support for Amlogic SoCs")
>    793d454f91e7 ("pinctrl: pinconf-generic: Add API for pinmux propertity in DTS file")
>    f2ecac49778e ("dt-bindings: pinctrl: Add support for Amlogic A4 SoC")
> 
> are missing a Signed-off-by from their committers.
> 

My bad, bad rebase, thanks for reporting.

Neil

