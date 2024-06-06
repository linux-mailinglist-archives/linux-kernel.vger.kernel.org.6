Return-Path: <linux-kernel+bounces-204006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AB88FE2D0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946661F24C8C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCFD14EC6E;
	Thu,  6 Jun 2024 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mHbpPO++"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D6813FD96
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666062; cv=none; b=sT/KyWkYxaPmv5H2ig8gzDpgK6uvR/2ixhsPMMWR+HhmaiXjhj8OufN6UjIvYbkaNe6i1KECWzTHygg3JMvJDGN0mMOHn2H/V0K9oebZBdPYplsmoYvZEOhX1Sti48oIXQrJ4OiTySPah6+NlLcC5Yccy4gIlH6jrAGPT+ii/tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666062; c=relaxed/simple;
	bh=rYnqU+2ou4u7Kaw4R/jgOa2YNlkFkEhv+b9vNxA6IfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8qQxIR92SosAP0Vt7Q3g3q62s1x/tgH/TMzybWX34QQUikVpwaUktS31NVbWbS5R/Ft2+BYLU5x8qaxbkHh9DIsH2JY/kSIDBTMHbb6QN4T99Re93k28U5kWQbt5eCnBcVNhHzYZA8ecHuFWumpo+R1RMbWRYN+2oBjYQNShOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mHbpPO++; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a526c6a2cso761969a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 02:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717666058; x=1718270858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4coGUS5rqVO/XkMEjgpDlue2Pr3XzDgvTCMJ1kTn61Y=;
        b=mHbpPO++Pj5BgKK7RI2OslzYmpyQe13GSZVmlCQvrgoAwdLYZVDRRI9UBvMJZVKyJH
         8RR9v1HbA4yn4JLqTcPyeutgJ3tA37Wo60zZiJHCXGte8Mhve3ZJoX08HjFMI6IVrnau
         f+HDCon7V188Do/dwnUWaqahv2ttTvwe/3gNXzztAdO5Nww4cph5DhkDAxzK7daZYza/
         UdaDaQ7SHXQTqS46zpsd6LzDEAvRIOFOOV0q6i1aL9b0G+4g2k5lc1YyphMFZcKA4oKV
         DJ80oUQHE8gxY99hzrahq9OFnjFJ0bym93hFQdGqrHooEAemF4O7fM7vV3rKmf6l2vWI
         b6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717666058; x=1718270858;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4coGUS5rqVO/XkMEjgpDlue2Pr3XzDgvTCMJ1kTn61Y=;
        b=lsWZJIFAFPXUojLjB+df2AsTdx+iYx+6Pzqr62MaMJCcprkdlX3ya4p+/OcE5ab/qt
         M/zHKp2PbrwwBpbUZhoYt5DK3hYPeoWVIvmlSOPiPP3grTD9WEcuUDgTJ9UNxb6FLT/1
         oDKnlIOS2eh5Q7fN/O7UUAuG4KvMWhdKqgNWVgTkcvgUyB7o3dHktNBNkQKVUI6S3du5
         pjVvSQGB7RoF1UnK/NGX5GpjlcUt5a+w5JQPG8JLJOuPJ+6w49CKsTV5Hl+dbxKLk/D+
         TMenZDVJmuqJYlk3gchZCcLT0MY4Ngrags9ElhX4WdV7xwLRVuRuPdTk5z/DgEyC98zG
         7tKA==
X-Forwarded-Encrypted: i=1; AJvYcCUIj9gNVsmxlhz6XF98cjK1ix9a9O4Ice4iVfiJQH0zo1EwbnJvMLmiLq2wy3tc3igw2YJslS8le9GRQQiPVuMebxh6ZmtOs9Tzw2yq
X-Gm-Message-State: AOJu0Yx0S1SN7C20csR5YhilP5ZjyKVBqDLxvYlGWkMYUQFq10X4v/Pd
	6m67/gznMKHRFpLJZyXRGKpEGg6QDCxkGGhMMKjEm6xIsTh8tODDnnF/vIwLA98=
X-Google-Smtp-Source: AGHT+IGqN8B1VWaFB5hpOX3x2j23zjabMi+w1OoZszVo5ULIhjp7d0F8Xv74HZa+5EdL58oQ+GHQ2A==
X-Received: by 2002:a50:d5c8:0:b0:574:ebf4:f78c with SMTP id 4fb4d7f45d1cf-57aaaf0eb41mr807201a12.7.1717666058529;
        Thu, 06 Jun 2024 02:27:38 -0700 (PDT)
Received: from [192.168.128.139] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae0ca5e3sm766761a12.25.2024.06.06.02.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 02:27:38 -0700 (PDT)
Message-ID: <fca5168d-9ea2-4fe9-a247-0d97ab175eb3@linaro.org>
Date: Thu, 6 Jun 2024 11:27:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] drm/msm/adreno: Add A702 support
To: Connor Abbott <cwabbott0@gmail.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20240219-topic-rb1_gpu-v2-0-2d3d6a0db040@linaro.org>
 <20240219-topic-rb1_gpu-v2-5-2d3d6a0db040@linaro.org>
 <CACu1E7FTN=kwaDJMNiTmFspALzj2+Q-nvsN5ugi=vz4RdUGvGw@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CACu1E7FTN=kwaDJMNiTmFspALzj2+Q-nvsN5ugi=vz4RdUGvGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23.05.2024 2:14 PM, Connor Abbott wrote:
> On Fri, Feb 23, 2024 at 9:28 PM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> The A702 is a weird mix of 600 and 700 series.. Perhaps even a
>> testing ground for some A7xx features with good ol' A6xx silicon.
>> It's basically A610 that's been beefed up with some new registers
>> and hw features (like APRIV!), that was then cut back in size,
>> memory bus and some other ways.
>>
>> Add support for it, tested with QCM2290 / RB1.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---

[...]

>> +
>> +       if (adreno_is_a702(gpu)) {
>> +               gpu->ubwc_config.highest_bank_bit = 14;
>> +               gpu->ubwc_config.min_acc_len = 1;
>> +               gpu->ubwc_config.ubwc_mode = 2;
> 
> I just noticed, but this is wrong. ubwc_mode is a 1 bit field and what
> this is actually doing is overwriting hbb_lo, making the highest bank
> bit 15 instead of 14.

You're right, this should be a 0. Thanks!

Konrad


