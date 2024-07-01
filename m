Return-Path: <linux-kernel+bounces-235610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8F791D765
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC5ED1C22096
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 05:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439A437708;
	Mon,  1 Jul 2024 05:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GwM0KQAk"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D122A1C5
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 05:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719811434; cv=none; b=FQRL34wP5QaarCvT/CQtQOg+SnysvELMWS8Qj4+w5gY+YdUI9ta+KAQRMjwXbjFdpIqTJUTAW1z/aqxpqVC7s1m6j1btcfLUFOyCdQvmC0QM0mwfvZD4VFGBWj9hG7VyDYXLBj+Pixm1oyrmdSSLE9Yd04J5dbAsChFyt4VYPb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719811434; c=relaxed/simple;
	bh=GiOtOBj6pf0LX9H0g6927w2KpEVUW3DE8nPCm4R7vPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oSBwaNIzR4s6lz57zHuYc/V7Ou45Y55rDT3KSLdYB903rBvEJyfkQdUx7ShmG9L4I6O+4AMRnN8HsI2lCMGPUIPDuoaud/612EgRG1OsKgMizaLrwyA8+TUDd4EUN9QZY11hkH/HQ0CdDf3LZwf3o/449mUep0klmDJJ1sipUKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GwM0KQAk; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so14526345e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719811431; x=1720416231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ZPrvTX1LlCOARG8zADhUY6Yra+UeWC6LQybo1XCNjI=;
        b=GwM0KQAkEWxtGDr67FuD4oHwWdzIDKiICVkT+Y6Q8uyrQr4RpHW9e11537gHYFRJl/
         1pc0wA5tLzQqZGnsjVm43QevbRKSyZF+ofHGxSjLaJPB2p+wz2gRqY5lW9qBT7KgAern
         COsbS+hmhoAKCz+qkGcF9F0p5Q3xXbH0vq39Q+HiNwwYbryntdnQwcmhXUD+X8toWtgp
         eNEv3SCPfGbwN2el38p4YYFsYBtOoEtYN8T3xhY/UomBGeZjSyFXYJT1eHxQ/u679UEd
         suRbr4U8LDpRiy/yq1BjWj8HmxtUKlRk6rJt6/JHTEOp6cGcLWq+PVtcI3wgp+QxpnGd
         tq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719811431; x=1720416231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZPrvTX1LlCOARG8zADhUY6Yra+UeWC6LQybo1XCNjI=;
        b=q2yzrA6iZDsHXBwqUgyGOU1isfzqu7PibqLQZ1t3ZJfDpcUQRRYLzhKLBsfFaZvVme
         aU3qbyTDyPWipd5kZKeAt0pjzPrxoc3CYB5QD+E+dudU011M/B8CsW5J/S5RpgHVVybK
         lGa+d0DQxVb1VHU6o18c6aZpbtJ3nNs+BzH+EnAorwuvWBdEXOkb4jdRcuKBcMLmejX8
         ZENpSTcyfyUSDPB4a0RHiU0Y56oU8zBaYsvX8ihqIjbIxH2cE7qnU3x4dLbB3tcnhsJY
         iZBC+UbFIYM9vd7i/6gMZM/qDc6Crgni1B2JWVUr0xL0gQ5RXu3zKd+jGC/aJWZDmdSR
         DctA==
X-Gm-Message-State: AOJu0YwL3PaXucbz3lQTR1JlT/DQWJ0EmtxD9cU59SpGy102MfztSzR4
	5WsLlGwssnUbZ49uLy2H3hgRWjqqjtaJHyDWjmXsoKDwvleej3e/1IbgfYioiZc=
X-Google-Smtp-Source: AGHT+IF9MRIx1wSh67nqdVTfzQyiTLHhWk7kRj6SC+p6KSXYmfU40pPYzAfvgbGb4Ez6x7V9WMYD3Q==
X-Received: by 2002:a05:600c:48a2:b0:421:7ab8:59c with SMTP id 5b1f17b1804b1-42579862523mr43337155e9.10.1719811431050;
        Sun, 30 Jun 2024 22:23:51 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c18cfsm138130885e9.45.2024.06.30.22.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 22:23:50 -0700 (PDT)
Message-ID: <1c457520-07b7-4bde-b040-e8bca959a4f5@linaro.org>
Date: Mon, 1 Jul 2024 06:23:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] dt-bindings: mtd: macronix,mx25l12833f: add
 SPI-NOR chip
To: Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>
Cc: linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Erez Geva <ErezGeva2@gmail.com>
References: <20240629103914.161530-1-erezgeva@nwtime.org>
 <20240629103914.161530-4-erezgeva@nwtime.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240629103914.161530-4-erezgeva@nwtime.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/29/24 11:39 AM, Erez Geva wrote:
> From: Erez Geva <ErezGeva2@gmail.com>
> 
> Add Macronix SPI-NOR mx25l12833f.
> 
> mx25l12833f uses the same JEDEC ID as mx25l12805d.
> 
> Although mx25l12833f is a new chip that support read ID and SFDP,
>  users might want to specify it in the device tree,
>  to differ it from the old mx25l12805d chip.

As Michael said in a reply in v1, we try really hard to don't introduce
new compatibles and instead rely on the generic "jedec,spi-nor". In your
case you can differentiate between the two flavors of flashes based on
the SFDP presence. We won't apply this.

Cheers,
ta

