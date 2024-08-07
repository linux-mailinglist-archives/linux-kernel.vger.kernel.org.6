Return-Path: <linux-kernel+bounces-277526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E9494A289
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE841F212FA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9749E1C9DFB;
	Wed,  7 Aug 2024 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bKvTSdV4"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216781C9DEE
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723018600; cv=none; b=nm9YpBBd0vIXNxUhswgGRbwXU4qm8zJ4AKH5yIO5BcnxT9ocRxuBK8vaXVPdZZhhe1+0WzPVs1oucBPO9QgxNrJw8a07DocfL4RvkR8XoFlGMTx4SXrB8mqbq7be6Z4b3KHsaXF5R06h02T/OApeYOAajnlKnadSXq0GXpDSrHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723018600; c=relaxed/simple;
	bh=mzZXu2jWV+RfZoT5Fv0aw/gAWZ/PvUE0Dsu4r5sXNFY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CKJmO7v1EWJuNhgeaUMmcpX3dLPmfyqvbpJXpmRC1jC9c3lEMSQ5dQX+b8IXvVPKFzD6nXugKybB8PkpdCsOJ5hMQHy6VTxNyMvdheByVmINFd+BUlHW2oAOS74jvNnRHcGXyjhhlyIAP3zM3UWQus3t3t/vBcSiotIWw4Wnepo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bKvTSdV4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso10127645e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 01:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723018597; x=1723623397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=atrldA10a8BjdnqCSyT4rg1kRxNV4bSf6HQY87NgbYQ=;
        b=bKvTSdV4W1ZiBvtSJIgWDT2w56JVReqGtZxqoo9D8xoEYx4Ltyg2hcPUcpaPiwzFu/
         OpO4TchMjPSZYT6fviJQ7y3tz8GQGbbG9Hq3opoFGllZbS9rgN2kWyRvVLDVXBLC7qHc
         lTiakhASUnix+GwemYORN1gH7nHUYDNWKZkIrbzbzb0OBA8F/AFFfNrzjMOvCJAuIURg
         casOlgbTbFJY6b+zR3AzL9kstUxtaHAIUFKcuf7FRj/RwbyP2zIn7BSZHSr38kuEboqb
         6qJ8UsdoP5tbijeKoSipwoq3hj/Jfewi4bZTJW0eIaH1E0vsYkCqvIsdzAH5T4H5iyRi
         Es/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723018597; x=1723623397;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=atrldA10a8BjdnqCSyT4rg1kRxNV4bSf6HQY87NgbYQ=;
        b=VKy/tH7MnKzJnx83sD21PDWh2UFSghnLLdWrWeCDLUGq7H/AtW6zp9sRBegiY1mMhm
         LaPGQV4ZU91VcoWDAueaLfJy3D/PoMoJoT/TK3eQvuL7QzwlxFgDCAtUi1HWWhaaG+8n
         NdeoUYnlD9ugxZD1rXtOcNsE5s0leu3o9+lSdBCjbG796i5vWibLMPEh8Frd536T/hEa
         V8xe01uQZeSbvYw7EkRA/npWtLxS0/cuFTK43vVwgIr4VHDpw4KHflL6pn1IVLv+pUKD
         EejbghK/6yx/uZiOb/oGLQHGmaNW3MUqApSgaM7Yf6BgLVxUjG7WJHLYGUJJINnNbd/v
         r8uw==
X-Forwarded-Encrypted: i=1; AJvYcCWkhPrDcK56ePiQiQTj0Z1AucDlJc6xumFSMlJRtPNDBU+Sh2OI30zWxr1kilq5U/N9KIpSzJQP0ax60cl6MMGq9brzW/HEwGvLkfQv
X-Gm-Message-State: AOJu0YyCdDrxlWscT4U3RNR9MLXeYlSJNOVbtgLwWsBcXYCPUPejcv82
	s7ymIVf+oES4+sVoP8Iw1V2N+tMKOJZcOlMWggo/ibsdOyQgq5mX/u4MdzClHxg=
X-Google-Smtp-Source: AGHT+IFjqtDCS0Dx/9VE7etgCP4QLEUEZ1oMSQjKj6FFNdEDqqzaD0VqMPLHzQgWFZecHT6ES0xtoQ==
X-Received: by 2002:a05:600c:4f06:b0:426:6d1a:d497 with SMTP id 5b1f17b1804b1-428e6af9d21mr120499525e9.12.1723018597366;
        Wed, 07 Aug 2024 01:16:37 -0700 (PDT)
Received: from [192.168.0.25] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429059719f6sm17545175e9.15.2024.08.07.01.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 01:16:36 -0700 (PDT)
Message-ID: <bc9f87c4-d14b-46c8-8545-826c0a1ab6f6@linaro.org>
Date: Wed, 7 Aug 2024 09:16:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] media: camss: Increase the maximum frame size
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To: Jordan Crouse <jorcrous@amazon.com>, linux-media@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Foss
 <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240802152435.35796-1-jorcrous@amazon.com>
 <20240802152435.35796-2-jorcrous@amazon.com>
 <021856e4-f48a-4cde-884a-0eaa42fcf82b@linaro.org>
Content-Language: en-US
In-Reply-To: <021856e4-f48a-4cde-884a-0eaa42fcf82b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/08/2024 00:09, Bryan O'Donoghue wrote:
>>
>> Also increase the maximum size checks at each point in the pipeline so
>> the increased sizes are allowed all the way down to the sensor.
> 
> So, I think this should be a Fixes: also.


TL;DR we don't need a Fixes: for your v2.

Pardon me, not a Fixes: the sizeof(sensor) that can be supported is SoC 
specific - camera IP specific really - so 8192 is a blunt descriptor, 
raising to 16384 makes some kind of sense.

A long term fix for this would be for each camss descriptor to declare 
the maximum sizeof(sensor) it supports. For sm8250, sc8280xp that's 64 
megapixels - for older SoCs its going to be smaller.

---
bod

