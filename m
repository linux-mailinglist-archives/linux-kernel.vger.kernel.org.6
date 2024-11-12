Return-Path: <linux-kernel+bounces-405236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 768A69C4EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 07:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BBEF281008
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 06:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0287C20822C;
	Tue, 12 Nov 2024 06:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ut0QpST8"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E49209F5A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 06:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731393912; cv=none; b=VpQnUMND1x1+FH5M/JXBZo25Pq/XL1nOXvpKMLEeP27kfd9EmlSTS12mIFOqQtopkD9VLcgOkQ/Dh+R+Sfy8/KJm3GG2BhfjGsBf5fg1w5kUrpNb1+n5jZAFsD8R+H2webdAehlw1NA0b5CC1ZYkwZBIbRe7haF9x0G2Pm6Ef4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731393912; c=relaxed/simple;
	bh=Bzl+nx/BiEcQkeCL+fSZeAoOkejbkZY8ryEBcRv+U7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kCTZlADWXT5ff9WK6yQr4xmjo/BtKnFTBKazXVNMyGb3R/25IkkvzDVdly2q2Y5qu2JXlI/qbrgau5199geVqcIsAwfjLS9mPv/3IUm+ix17FFD1chXOLOit61iVhLN9MOpUqcyM5jmYjs3OhQLQdzHdctQ844rSsiHtU1t2P3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ut0QpST8; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa1e633b829so13568866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 22:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731393909; x=1731998709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bk/qTs7SYONfqNiwKQpCo1FnKOOwDZ+GgHR/cbq4CIo=;
        b=Ut0QpST8dhPEf5gyWEDLZGNSOCgcLrp96zRTDjlfMosTbXZEhnq2zdSt8xQC0UfYl6
         2ASd4RRPeKWhP9NnAsrqWou7OVzdoYyplgUdy4EMxeiaBDtXd/nbkELiYqmuQPxAHMlo
         Bcov6Oy9B90P1q5nO2WbtdKHQO9dppy/dZyLrXL+7biSJyb/Xtpb9u1sRt7QFq+GVMry
         dgq+LxnCbDuZLWYZTOMuWdepsmSHMZzSyMMDSCaeAWGHz0NIYBSsEqAwRFrysNt/lO2e
         GvF8oim67V1/JhUHwMUyrXgrS7YvzDmuTuQIBZmoMxcOYHsMuqmNhygu/AbeRcqhS+QQ
         /lUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731393909; x=1731998709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bk/qTs7SYONfqNiwKQpCo1FnKOOwDZ+GgHR/cbq4CIo=;
        b=OmJtm5X3lUxLn9zDD84yJ4p8EHm+3vSGOdtSkldylhIQhHtfusMXTYD1aDAnMXA6Ya
         FJPtZq8K/nWvEIm87A4yjJvnN4PeTetd7yqSjDZ4xDCFRqwN0GspZYaqhD8fCPW8D0Vv
         C4ZNnSPrkBAsOVTo15bNtUDYeX3UJOJUQI7v/SKBv4OySuEuHe+60e1BqQxSynNTA6Wi
         i2TcesBLEs1djA3dqMzFJMBRiJD/mHYv5fRwu3VN2rHczdyemQssQtcUgqmHJFnUKwyu
         lbUrlnsN8P4/yd0unZsMHwfcyA9yQosOebhiDWodjvY3AqTYyx6Vs1tmuBe72xGRA2i0
         C/OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrrn/nX66dt0GNcMNpUC0pY21qfiygbqQ4MOwVinNBuULSWws82jpV5AOvMvKtO7UXQJCAWpFTS9V12m4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKs25mvyEkNODvS38dDYeaAaXRqv4koBhhSYj6BAkJQEhKM50Y
	bZYmL7SrxgULh9/EocA7skJVyPA3+BJR7ocgsNXkmRdsQwisWytCfaP1K7Mab5dYOzcyFx2T3Gb
	A
X-Google-Smtp-Source: AGHT+IHcjt49YmGjuMTP6l84E4tCJkuOLW8/54vo4S7Nxntsh06kftkO0W8XYBJzpKPMB1h8yxM1vQ==
X-Received: by 2002:a17:907:94c4:b0:a9e:8522:1bd8 with SMTP id a640c23a62f3a-a9eefebd13bmr1574005566b.6.1731393908945;
        Mon, 11 Nov 2024 22:45:08 -0800 (PST)
Received: from [192.168.0.157] ([79.115.63.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0defbdcsm676752366b.159.2024.11.11.22.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 22:45:08 -0800 (PST)
Message-ID: <01160386-a65f-44b0-ac57-ad77754f01cc@linaro.org>
Date: Tue, 12 Nov 2024 06:45:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: core: replace dummy buswidth from addr to
 data
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: pratyush@kernel.org, mwalle@kernel.org, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, alvinzhou@mxic.com.tw, leoyu@mxic.com.tw,
 Cheng Ming Lin <chengminglin@mxic.com.tw>
References: <20241107093016.151448-1-linchengming884@gmail.com>
 <437e9c87-fbae-4402-858c-ce6de0a992c7@linaro.org>
 <CAAyq3Sb-dmmF8YsOdTYxZqX8Wn4d=WiAXkS4bHp5FLn3S+ouXg@mail.gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAAyq3Sb-dmmF8YsOdTYxZqX8Wn4d=WiAXkS4bHp5FLn3S+ouXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/12/24 2:42 AM, Cheng Ming Lin wrote:
> Hi Tudor,
> 
> Tudor Ambarus <tudor.ambarus@linaro.org> 於 2024年11月11日 週一 下午6:18寫道：
>>
>>
>>
>> On 11/7/24 9:30 AM, Cheng Ming Lin wrote:
>>> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>>>
>>> The default dummy cycle for Macronix SPI NOR flash in Octal Output
>>> Read Mode(1-1-8) is 20.
>>>
>>> Currently, the dummy buswidth is set according to the address bus width.
>>> In the 1-1-8 mode, this means the dummy buswidth is 1. When converting
>>> dummy cycles to bytes, this results in 20 x 1 / 8 = 2 bytes, causing the
>>> host to read data 4 cycles too early.
>>>
>>> Since the protocol data buswidth is always greater than or equal to the
>>> address buswidth. Setting the dummy buswidth to match the data buswidth
>>> increases the likelihood that the dummy cycle-to-byte conversion will be
>>> divisible, preventing the host from reading data prematurely.
>>
>> This is still very wrong and the `fix` is working just by chance.
>> Consider what happens when one requires 10 dummy cycles. BTW, does this
>> fix a real problem, or it's just a theoretical fix?
> 
> In 1-1-8 mode, setting the dummy buswidth to match the data
> buswidth ensures a dummy buswidth of 8, which can accommodate
> all types of dummy cycles.
> 
> This patch resolves a significant issue in 1-1-8 mode, as described above.
> 

shall we add a fixes tag then, and a cc to stable?

