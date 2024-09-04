Return-Path: <linux-kernel+bounces-314883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F11C96BA85
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6081F23C6D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8351D0495;
	Wed,  4 Sep 2024 11:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eMEKJ+po"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE101D0489
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448973; cv=none; b=fkavz0vW6hWQNuJOq8AS1IvXxT/z5TjD+Ba4OUAAOayEv6dj8C4zK8bu5GyBGuwX72S4mnsQbQuk3STu6gdCkDBQ3EYRp1sKh0BaBLnu6yDRZ61QJIJZgc+nwYlKN53XjunHWpuly6cWM/kvgqY2k1Lc+05A1wI6BQSvmeyAZ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448973; c=relaxed/simple;
	bh=PcrFgpDkn50Q165eUFY8BrJ1SaOyvBQGLSKOHPiZ39k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XgWVLVd9x5jDH7jqv/NWTcsWX4YsgpdlsKxHXZ5p4GXfbSHrttBwtuOoBgLyjUs0vFTxPfUbyS9O5kLxrriti2scWdaVAhpVPHgvuHPcJIB1T7u1cMUjkd+S++ngPvqT7s/7d3DJlpD1BqcEIXybAVpoSZGK210n8OzaXlar6QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eMEKJ+po; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c245c62362so4194215a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 04:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725448971; x=1726053771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mXcgyount9FIa988qWiuGCSNSad2TY4cycGUqv4MAcE=;
        b=eMEKJ+poMaUoMLaoQl4/MJ8qmYejIDtE6TGRb55KL06o/G1nVVAwDOvv76xA6CDMZC
         kE/1j0/gUfrTfAGbNXBVRA/5jEyKulRyPU3vwbbwR9TyN1x+ZR17KCs2o/uogY2dpD/n
         H8eqYeMk0+KOulPbvRsq947GzQF3QHGeAVbOwh0vW2AxQ+iCt1wM+k06uHntEim/UNJw
         J/RcOmAaWsAqRaniwcfXLqpOoQ2SoqxFKdDDQ/ZtfF+TEp9gfDU5Tv1NCCTTfPvKOTh/
         TzLS8XEhK4bcbu9D3BlNFtY3p8V3Dn8m1JCb9BfM4tVO5CHE2JEkxQHZz0yKwJJBPQzP
         KB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725448971; x=1726053771;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXcgyount9FIa988qWiuGCSNSad2TY4cycGUqv4MAcE=;
        b=w8iPT2Ae0ab2vrYIrtKleJ3O9xoSWMEjm3lEUk4zsbvIHpUds5FOp8cakmdy7grOko
         +bWpuVHjVbAYVvWtKHWarJA6rk64LSeZw4M8lqCYbti81tf3tgeqsCXMPaIq4NSGPYL0
         ft4mTKbZ+MrFimu7hi75U+H0aVYDmnTqfD8TAYvWTCi36k4zqiOany5tM6i050M3qaMM
         jmZ0PioF3az0TKg65GSZVDc7FQABicqB98/LGewSVXmJIBHznkkbZqsRvOy7/ovpEOyN
         oYFaPrruVx8Zg4nOZoxB00FNXKZlj10QaXHWgL/7lE6F71IbCO9y9R2vVioNMwOosx2+
         iP4g==
X-Forwarded-Encrypted: i=1; AJvYcCWZrhPyHquCRxmg16Xj0agyrLadqMTFSx88f10jrtxBqnFv1GC0Sq4wAUVpbei6ZawzAmAWk+zblRVVA3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqKWzHhZVUr9lHum0MQRv6Sv9sEvpyYTKuygK0LiTTX93E84dh
	CJ3CamcWGNic9DgUtAh1QcRzZWFMGN7ypNcbwtLcbMFIWTpyXW9CSpHfpjnUNk8=
X-Google-Smtp-Source: AGHT+IGABy8yJ6gIVqPxqOGLJAZPBvqQIMiwgmXxYJH0VAwdvLE5ifagcTmvrdZkt3pAKO8bdRK9WA==
X-Received: by 2002:a05:6402:354e:b0:5c2:43a0:47e3 with SMTP id 4fb4d7f45d1cf-5c27584b805mr2244804a12.36.1725448970452;
        Wed, 04 Sep 2024 04:22:50 -0700 (PDT)
Received: from [192.168.0.25] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226cd20basm7459660a12.65.2024.09.04.04.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 04:22:50 -0700 (PDT)
Message-ID: <5fb85de5-9162-4c63-9b49-96c7d22ed999@linaro.org>
Date: Wed, 4 Sep 2024 12:22:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] (no cover subject)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To: Vikram Sharma <quic_vikramsa@quicinc.com>, Robert Foss
 <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kapatrala Syed <akapatra@quicinc.com>,
 Hariram Purushothaman <hariramp@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 cros-qcom-dts-watchers@chromium.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Suresh Vankadara <quic_svankada@quicinc.com>,
 Trishansh Bhardwaj <quic_tbhardwa@quicinc.com>, stable@vger.kernel.org,
 Hariram Purushothaman <quic_hariramp@quicinc.com>
References: <20240904-camss_on_sc7280_rb3gen2_vision_v2_patches-v1-0-b18ddcd7d9df@quicinc.com>
 <4e0529d2-0277-4a41-8d4d-915e4ec0baa1@linaro.org>
Content-Language: en-US
In-Reply-To: <4e0529d2-0277-4a41-8d4d-915e4ec0baa1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/09/2024 12:21, Bryan O'Donoghue wrote:
> On 04/09/2024 12:10, Vikram Sharma wrote:
>> SC7280 is a Qualcomm SoC. This series adds support to
>> bring up the CSIPHY, CSID, VFE/RDI interfaces in SC7280.
>>
>> SC7280 provides
> 
> Please RESEND with a subject !
> 

And don't forget to include the V number V3 ? perhaps.

---
bod

