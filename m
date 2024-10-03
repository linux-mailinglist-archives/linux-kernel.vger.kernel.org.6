Return-Path: <linux-kernel+bounces-349015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1109598EF6A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328991C21437
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3298199956;
	Thu,  3 Oct 2024 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="divFBXRn"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5E91990AA
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 12:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727959239; cv=none; b=fuXb1zd9LsEhystXaEbBVe7JaymZUNicYw1ehYvmjCLwfO6XdYGpfIoMqECbQg1CXkHaBzhttu6M20igZClWxRxI2AiFFpWyhJYsONaZlmtzI/90pOOrNR6Ji3iJr1pBaSY2CqWR0wHK20VguXQA+DarC7q9Kyb56KYRsRzfHTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727959239; c=relaxed/simple;
	bh=KbnXjaNAtIzfFWvoHNklhDpIKSAZrkDbY3GlT7dESdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MYywbpIR5iFnFxOnR77Uth1reSm0nPoTi0buLPBZqANAjbV1xLdSrFi7iiZaCvKWxkM/TkdRtLHrxRyrAq3U72CzPZJFHm+KichX/i6sXdQWsb/bP6LTk34QVg8ijlZZJxo7t3/luTv8z3xHgAP+grTMokITzn2tsXBCIuVQK9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=divFBXRn; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c87853df28so1158721a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 05:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727959236; x=1728564036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EjdOUYxIDIsj1NDRnGS+ZQrnSUI8iTKovLZIcuAuKFk=;
        b=divFBXRnTx6HyO55/VOCia1qoLgQrkQO9tKSNva5T9/oWxTRC+U28DJVqleDRmz2QX
         sYBnUR/Sloq/0s7PP9aiVMWOgt0HT2pwjBBuXAMqOKjw4hdzAzNOewfqp3/VSkQmT94J
         lNn7BdXqJW9hHm1uBxi5WhiOUhp1lRDvc2xv3mzpFbPKvuxg/pDCPzh9JYsy4Kbolom8
         i4C6VcqvhQ5r4YeP/1mz6Vqy1ufKbXkMQS8izq01CiCHuJwHepmGfQcPzZYVws2+JPWd
         Xmo/EodZtUqGElpLt0l1Sii/ifADsA1Vx2yn1xtA0CMEyR1OAnGx3INJ7/x+1P2dxkBB
         iKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727959236; x=1728564036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EjdOUYxIDIsj1NDRnGS+ZQrnSUI8iTKovLZIcuAuKFk=;
        b=AyfgO/xT7bYiOq7fSFU3qeF0gsuwkkKC8lD8ZB3Tx/UepsSLe5lhxZNHO5CQBCroG0
         kF0JYt+J1mpPvDmO6fhAJLcM1sg3DaEJZ3I88LiYWlRyBJdBiU8vZQAE55ujn/+B5JFO
         z9y/Xeei/kQrfQ/mXK8CafLgbw2nsJ/nBgfLNTkhT+/U+e91eQOluixaF+cgBb+lpaSA
         tZRlfSIWCBnFOuy78kDunkNQ0Ui+XEdSX+MXXCtlHsCq+GVYGExs0xZozWAUAV7/osys
         FA4ojggvoEFJm6Q319Xxd1aed3o+9OYohjQtBwm3LryPR/Bdahkd8mBmkrgCckTzFDj0
         +W2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWO2INHOSjzPoPgsnzRdhFytuNym0LoDVc8BONWiDsT/pIDNN1CDDb/bTh1gfdal39TaHlrIgOSYiQ0XA=@vger.kernel.org
X-Gm-Message-State: AOJu0YypmgLO0XzzIKHHBEyn5l0HWY0yYfuWrtVyw74m+p+NU9gMtxaV
	07Fsmq57lj2Ii9NN1Nm5DwcymEs7E3kyov4g2U5yEYpJRuF4L+G+cuyPL8QtLmM=
X-Google-Smtp-Source: AGHT+IGc68GqlUNmZdNXyxO0stgBEI2Pd11nTmeLyVYUb8/fBGwA4BWwL9fMF7mhaHIq0dtMPFVzJA==
X-Received: by 2002:a17:907:3f9b:b0:a8d:2ab2:c99e with SMTP id a640c23a62f3a-a98f83875bbmr585224066b.55.1727959235759;
        Thu, 03 Oct 2024 05:40:35 -0700 (PDT)
Received: from [192.168.0.15] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99104d0058sm81033066b.216.2024.10.03.05.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 05:40:35 -0700 (PDT)
Message-ID: <7ab7a7f0-c035-4210-b4d0-9e08291be475@linaro.org>
Date: Thu, 3 Oct 2024 13:40:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] media: dt-bindings: Add OmniVision OV08X40
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Jason Chen <jason.z.chen@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20241002-b4-master-24-11-25-ov08x40-v3-0-483bcdcf8886@linaro.org>
 <20241002-b4-master-24-11-25-ov08x40-v3-2-483bcdcf8886@linaro.org>
 <t4fajppdqagkl7wr2krcucsga4zocz6liar64odk2mnasdyfms@5fp7bfwalson>
 <a86d05c3-5151-4161-8612-58894b1d0203@linaro.org>
 <8554d372-18cb-4351-a5ab-894be09c613b@linaro.org>
 <e8142566-aef5-498e-9d2d-8ac187ce8524@kernel.org>
 <c86f695f-28e2-406d-9f46-c291fca282e4@linaro.org>
 <Zv6LQ0q2XVHgUohh@kekkonen.localdomain>
 <1a4e5aa6-2308-41de-94e7-0077cb265b6d@kernel.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1a4e5aa6-2308-41de-94e7-0077cb265b6d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/10/2024 13:31, Krzysztof Kozlowski wrote:
>>> Ah I understand you.
>>>
>>> You're saying the link-frequencies we have in
>>> Documentation/devicetree/bindings/media/i2c/* are redundant absent hardware
>>> specific link frequencies being enumerated.
>>>
>>> I'll either enumerate the acceptable set or drop this.
>> link-frequencies should remain mandatory in bindings, whether there are
>> hardware specific limits in bindings or not.
>> <URL:https://hverkuil.home.xs4all.nl/spec/driver-api/camera- 
>> sensor.html#handling-clocks>
> Yep and my comment was not under required field. Why all this discussion
> is taken out of context? No wonder everyone interprets it differently.
> 
> Best regards,

Just so I'm 100% clear.

required:
     link-frequencies

is required but

properties:
     link-frequencies: true

is not, and presumably should be dropped from other yaml descriptions 
upstream.

---
bod

