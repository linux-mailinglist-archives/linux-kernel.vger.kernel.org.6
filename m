Return-Path: <linux-kernel+bounces-528454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C39AA417D4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16C1718943AD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797F523F43C;
	Mon, 24 Feb 2025 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JA0A1X3X"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97C223C8A5
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387131; cv=none; b=EogBMHur1x82JoWjDpwmt5aBrcwo0pXXHpu+YyrXjFnoYfycRsGBs1jXKp4EG9kw2u2sRo+jEtj9NAwNYIaJWIACAAkORZQKDYL6ChCdlmrJ6y74XEZozPxXNrI6pqb1LGCJRPWOeFG1EV/FrhmisIPCiuj4o1ANc3Nh42bgdqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387131; c=relaxed/simple;
	bh=XSOuVzEV5wJ+2xG/f2+O7fTZAE71MI8CljYtG0w/leE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KydiUBj4WZ4MN2T2KPMHoRaHZ9cWbIvpvnNFWvklq+UoFHlT6dYZmWL9MT1sPb/BHF6kyQ2wiuytq1dDXI4iIFJrvgBwqICwD0m3jXEi5p4CUb36fObtBnWAnff16u3R+Rcfc8LssovORoG2ps5sWD9+Kbpyp5aURaufFDJENsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JA0A1X3X; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43996e95114so25877545e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740387128; x=1740991928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfttPucZes4uslCtilxnixZCmYMBBrCsgPvpifvl92U=;
        b=JA0A1X3XSWZZfCF80jVpzYG7pCMzeGCD6InnvVrwhuXpdv+EFOt5XdBFrVy5ivqgVQ
         nYbCOcWups9ry2WBk/P4UrHZblGRL+3MuT+scjntrejCNEq45FGnX8+vBbAOzEbemybl
         EvTxNmxBBvmB9ypwgmpUhZQ1jP1CQb0v+L8T0wFIT3zyYlVvmUX6J6V1I2VJLvgX4dHw
         pUBicmJuNcCgdWYNE+zFMGrg+Y32EHWrk+42xIHE5MrcVAA46nfNpaLaASH1lCAjfJGX
         xtHZNmD4GPBlrKNAnTHIdOqZ/N+fhZYH5HjSJj/USSUHd0D0pwnIkt7eKKGSBFRoYJ96
         NL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740387128; x=1740991928;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rfttPucZes4uslCtilxnixZCmYMBBrCsgPvpifvl92U=;
        b=UurBAbphnrj154FG/h+RfD6XlsSCwnvwsGFaFM8aTLM07LPaH2LRA5lbekXKIY3AUe
         JdeFNtgicNiD8lSMjEBnSJkM52n5qiCxn3PciWeqSAT7f75uYFFUiDWmtdyXNG0hXAei
         gFO8UYdodSkSVq1gd6IK5PMlnqj7+6fqBupop6P4Onq5tVQYSF5uDks7bHTc3d4YVGQK
         jQZgKglSJoF6HziOxbulVdmo3A4nl4xhyS0r6gf4BuzpfxRBL3lCcNgE6frBNSB20K65
         04slr9Mx0JAywwdgpJR98S/V0D8u72p2rrmMKtwHKQChepa0jxGgsAV/PC01m9R/+Sn8
         oS+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW02RAJ9HQS0QP54vGjJhp4/+LHNKb2+1zjy49s7WMMys098FJZv+7G6TeTLK33hhJogO1hMtHzSvYkpa4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Sm2dzFIA2pAdjTXeJyidugGHrsm18NX4zGrD+XcqpE0ShpOi
	ZBZ68hbtE7QtIfUXXVI0jtLjz1DuYMrsWZUrEeqK8DxJfWgu6ljUI+HC5rd+M/E=
X-Gm-Gg: ASbGnctQosOmyIp1Uw+U899EMBEhb/VRJnUwZv8nfLWbLed2z4osvD9iFy0uuJrG0xN
	QkLPqWvu19hGZtdDOC1b4ZiQiwg05VYtaXyI1Cd/Nv4V0RdlOaNFUaN5g0AYhHgtn7ucTd0Yak2
	xYuUsokzZ9hABtA8dC7S1GzYp1nf47wHBDW0/U2ooyQuIjyK2wpyu3VrbclEed+ANTOIzHER3of
	OQeRBhcPto7k8qELvaBUOjbblrJxxLhNAINVy13Rgm7/IqJ24SphUjjSPf6uRicGZ2ifL4gzICH
	EchBuv7H8draEdjs67LHvIiOPaGg0vpOemw/uQ3aSprueDrYnd0Bf/sXp0P8gdvtADVGYLj3kvj
	iAq4=
X-Google-Smtp-Source: AGHT+IGc4DlL71WulAAnKcQ9CzF1y/33BchgEuu9bZ5o2bSiiIB3/0bTM2b5M5+480mvGS24HXxp7w==
X-Received: by 2002:a05:600c:19ce:b0:439:a1c7:7b2d with SMTP id 5b1f17b1804b1-439aeae05fbmr98203575e9.4.1740387128219;
        Mon, 24 Feb 2025 00:52:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:825b:5392:ef70:cc0b? ([2a01:e0a:982:cbb0:825b:5392:ef70:cc0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce65dsm99552155e9.1.2025.02.24.00.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 00:52:07 -0800 (PST)
Message-ID: <794bf229-df4a-41f3-a8a4-8b1362eb7f04@linaro.org>
Date: Mon, 24 Feb 2025 09:52:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] drm/meson: vclk: fix precision in vclk calculations
To: kernel test robot <lkp@intel.com>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
References: <20250110074458.3624094-3-christianshewitt@gmail.com>
 <202501210513.GCec6kts-lkp@intel.com>
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
In-Reply-To: <202501210513.GCec6kts-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 20/01/2025 22:56, kernel test robot wrote:
> Hi Christian,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.13 next-20250120]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Hewitt/Revert-drm-meson-vclk-fix-calculation-of-59-94-fractional-rates/20250110-154701
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20250110074458.3624094-3-christianshewitt%40gmail.com
> patch subject: [PATCH 2/2] drm/meson: vclk: fix precision in vclk calculations
> config: arm-randconfig-r072-20250118 (https://download.01.org/0day-ci/archive/20250121/202501210513.GCec6kts-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project c23f2417dc5f6dc371afb07af5627ec2a9d373a0)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250121/202501210513.GCec6kts-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202501210513.GCec6kts-lkp@intel.com/
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/arm/probes/kprobes/test-kprobes.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/slub_kunit.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/gpib/fmh_gpib/fmh_gpib.o
>>> ERROR: modpost: "__aeabi_uldivmod" [drivers/gpu/drm/meson/meson-drm.ko] undefined!
> 

Please use do_div() when dividing 64bit numbers to please 32-bit platforms.

Neil

