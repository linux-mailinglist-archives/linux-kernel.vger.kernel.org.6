Return-Path: <linux-kernel+bounces-336065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3578897EEB8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576211C2139A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3293B19E969;
	Mon, 23 Sep 2024 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SN2hviSu"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D630A19CC3D
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107150; cv=none; b=jXRi0M4tZdZWDEBBWUef1ZmCgrwkONx0rwbT/bVLXUp6HfnkAbUQp/Nv4ZlYckjF+ZmhSvhjSE1CS8jO//owi+LkFQsbIalVI7VMvaZX2yfKzKXdW2kGHlt/ZSGxUMVZOKuulOXYabFnsPGMdXf3X0ssiddJNKZSOgXBwTqP4Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107150; c=relaxed/simple;
	bh=/GlkOidwdJOEopYgUf6eZw8pE3Bw68rcYwCXDT5xANA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ttV9a4Az5nj6itA2mEs0R0m1CmcwN3H+8L7/Q5HhbhGsd93Hp14AOFFIcdZAZ3BFebh9zrwzcwCkWLVeZbBuQqmgKD+E3uy6WQG1bUA9s8orcUzTzTtOV8cCoXbn5GnsL3GzWtwWEEiiFwopl5aKIHjsihepxCSMEWpQsALFvlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SN2hviSu; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a0cad8a0a5so17273745ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 08:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727107148; x=1727711948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ON/KYugrzpyLJZkkkpVr9k7hwbS6LTFgvWJRgJ+w6tE=;
        b=SN2hviSu3JeJSHMgRKq9j1R91Y/IKSRTzC5uX1S0W8uheJwzdpRas8Ha13xufEhH6L
         UGB6KaIA2x5zEnJcfbUITVIVkHYoO23UUXGPyCq484C+NgX3eymPcPRc1Kp89/Al+/97
         DEhl/HETU4aO/o98fV1i37JXDErla60a7fDoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727107148; x=1727711948;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ON/KYugrzpyLJZkkkpVr9k7hwbS6LTFgvWJRgJ+w6tE=;
        b=QJs+3P0RC0C3iO8gaD20ei4pTe+/lULxiMof65mRshTAvVorbZFelaG7sK+JghuaCr
         a1GBg5yPfDIRJP0j5ZHEsXUmxX8VKzsRPyBQksjh39pSD6s78GAdhKgSGcGho3ZI2nA3
         KpqiN4BJsxQEOrDNEkTEE+sAQuGTN8S9zBffXoDC9l1T7zeUdzCk1smTAarWKRJcd0MI
         yhKf7qDi0+Iwtsd2eYsnLaJX3fEJgGHlqwS6otxzCFfevppDSKs/DMVfdh00maaArhwx
         2W4ZDJdWGlpiftR2GtBkLvHA7Zt+lClQpBIblgFiQWz539MHIme6vYU0Pf7C/1rwhTAI
         4LTw==
X-Forwarded-Encrypted: i=1; AJvYcCXYWidm+1c4yBUoVoarEjs8dOKjIzYZrMOa5TgzO2bRI2uSEdJraHmPMLegTmKqWBpdqBRQl1TMSIoazTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT7xoB1+RvCwuA2X3FSDdYWbbIhHXatja6tXWmXSn1L/Alr5Sq
	bK/PakUhpRCvvSprPHDcn51ovZPFUU756GSaLG8AXETIyB4RKDimd5b3m2hg6zZteT0B60uETS8
	9
X-Google-Smtp-Source: AGHT+IGnHBN4o8JvSDpzM6HGewQhcrOG8h8dbNEU69nL5SqQwP6XjWpY6ODOv4sGxMEkdc+THAnf0A==
X-Received: by 2002:a05:6e02:1946:b0:3a0:a224:eb3a with SMTP id e9e14a558f8ab-3a0c8ca77ddmr94722165ab.6.1727107147974;
        Mon, 23 Sep 2024 08:59:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a092e1b608sm61878095ab.38.2024.09.23.08.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 08:59:07 -0700 (PDT)
Message-ID: <a4a6c672-ddcb-4f8a-ab5d-84de237129b5@linuxfoundation.org>
Date: Mon, 23 Sep 2024 09:59:06 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest: alsa: check if user has alsa installed
To: Abdul Rahim <abdul.rahim@myyahoo.com>, perex@perex.cz, tiwai@suse.com,
 broonie@kernel.org, shuah@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240922225824.18918-1-abdul.rahim.ref@myyahoo.com>
 <20240922225824.18918-1-abdul.rahim@myyahoo.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240922225824.18918-1-abdul.rahim@myyahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/24 16:58, Abdul Rahim wrote:
> Currently, if alsa development package is not installed on the user's
> system then the make command would print a `pagefull` of errors. In
> particular one error message is repeated 3 times. This error is returned
> by `pkg-config` and since it is not being handeled appropriately,
> repeated calls to `pkg-config` prints the same message again.
> 
> This patch adds check for alsa package installation. If alsa is not
> installed, a short and consize error is returned. Also, it does not
> affect the compilation of other tests.
> 
> Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
> ---
> 

[snip]

> ```
> 
>   tools/testing/selftests/alsa/Makefile | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
> index 25be68025290..944279160fed 100644
> --- a/tools/testing/selftests/alsa/Makefile
> +++ b/tools/testing/selftests/alsa/Makefile
> @@ -1,5 +1,9 @@
>   # SPDX-License-Identifier: GPL-2.0
>   #
> +ifneq ($(shell pkg-config --exists alsa && echo 0 || echo 1),0)
> +$(error Package alsa not found, please install alsa development package or \
> +	add directory containing `alsa.pc` in PKG_CONFIG_PATH)
> +endif
>   
>   CFLAGS += $(shell pkg-config --cflags alsa) $(KHDR_INCLUDES)
>   LDLIBS += $(shell pkg-config --libs alsa)


Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

