Return-Path: <linux-kernel+bounces-287992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC06952F42
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BADFE288E32
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFFE19DF9D;
	Thu, 15 Aug 2024 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o6G5TRgv"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9E917CA1D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728624; cv=none; b=fNYAgIHlMK4B3t8xpLcuenq2pGRCA8mYc8dw1hhnnuHTf6QdjXE0EDhL9GVcpZTCfaEelqjt4oxsxrAa4qwWiZUvbraAOhFO/o6OwxR2UXJM/qMIAFfg06dRgxhHeZ0Op78WiNYOxACj0Ioli/RUOEDV1O6TJH+CV77xmzSmid0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728624; c=relaxed/simple;
	bh=VqbjF+/JhAHEbj6VrPUiRUjcgUNexhlDFO2jPxvVf4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dGRWJBpA3IfpOow2kDRWR5cHCIEBiyrNbOkof3ESsF/LNj78RNddkG43rOfdGHvWlcz7uTQL5QN2xlXOehdWH2biLUiR/4ZUXqqDwkALP/CNGFJNEkjIMtCFXxDq11/BpJSmsRLpyIC/PFovnQHp9HsHCFTdF9+SEhOgqbENbwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o6G5TRgv; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso8405745e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 06:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723728621; x=1724333421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m4M6/sF5++gwHBVatWuh7PHYYyZziGbg1MVlu0kUywY=;
        b=o6G5TRgvv107ireI0SKUjvU1weUiYGk8pTdNRzfuDGk2P+lvplxPY9weHNPsqhr6fc
         pdDfyYV9vcUJ+/MCPoZuw2q/alHZX8ZWjzP+NqlQIqyvzahKwTrCIUbnbA1JtLGAkkG0
         6bFMGkcou5AQJa/w0XUnZ6o+02/qv7ob0+7qFXOujpBnHy1rUGTZXKxW3Q+/tS5gZfTN
         V3Tu1nfujmDsfNKpGBdYgN659LrA6rVzw7mZiF0IUNZoSCjI42MLHcphdbAHfx1BMzu5
         lnZRuEAThW9ZAC2J/KGjULQKbFEGzc6/5qAJQ9rBH91l0dHRVGV00uH1NcKS6LGHw9pb
         kdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723728621; x=1724333421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m4M6/sF5++gwHBVatWuh7PHYYyZziGbg1MVlu0kUywY=;
        b=PDdLFeyyjhgC3QLS0+cN0rsbkW+Wog97sDMA21/+eWSqpYIxXL10xlxls4SCV8dJhB
         2F7KbajZRrAcNkZ+eekqNahk46r3iiyG0GDtXgIYzI1ooO3rYhzl+qrG4y2+bW+f4pFt
         c908n3QlDVipYImfQpSpjvf8CbcYVyaexZoWzw41n7ekTR2Op+fRoGG6fOkxTeJwlVkN
         K2AaeZTqTnIoKLYl2R3JX/+LM6El5fPBaoR/i7eJRFt2KnezpsriEbBQ2Ls4TbXkqcWT
         1YPmIXNbK9UFAJnzy0Jgo/v3qFSOQ+fDtUW1jN/IoPeDwKkcrpPC6SRtG1vU050ie/Sz
         gtng==
X-Gm-Message-State: AOJu0YyNsCfKTY90pLpW3GLGFaC/ngGvDZazHdjmQr53EBeZ6TFCkuqy
	rcu75av7qTFoM1mhBGQol4E4nbzD3QAFmVROHpNVIGqfUqbQHPjeiexVs4JvvnQ=
X-Google-Smtp-Source: AGHT+IFxRMYQZ5/FGozj5bf/nvsc4fF0z+j6HTveT7P5nyCyRBZp7bMPqxKA4HuUUfOrq67yZa3J1g==
X-Received: by 2002:a5d:4fcf:0:b0:371:8c0b:4818 with SMTP id ffacd0b85a97d-3718c0b497dmr998758f8f.63.1723728620878;
        Thu, 15 Aug 2024 06:30:20 -0700 (PDT)
Received: from [192.168.68.116] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37189896be4sm1561633f8f.77.2024.08.15.06.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 06:30:20 -0700 (PDT)
Message-ID: <fde72c34-889a-4dd7-a1cb-fec1d1b3c6a3@linaro.org>
Date: Thu, 15 Aug 2024 14:30:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] misc: fastrpc: Restrict untrusted app to attach to
 privileged PD
To: "Selvaraj, Joel (MU-Student)" <jsbrq@missouri.edu>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ekansh Gupta <quic_ekangupt@quicinc.com>, stable <stable@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240628114501.14310-1-srinivas.kandagatla@linaro.org>
 <20240628114501.14310-7-srinivas.kandagatla@linaro.org>
 <9a9f5646-a554-4b65-8122-d212bb665c81@umsystem.edu>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <9a9f5646-a554-4b65-8122-d212bb665c81@umsystem.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/08/2024 03:34, Selvaraj, Joel (MU-Student) wrote:
> Hi Srinivas Kandagatla and Ekansh Gupta,
> 
> On 6/28/24 06:45, srinivas.kandagatla@linaro.org wrote:
>> From: Ekansh Gupta <quic_ekangupt@quicinc.com>
>>
>> Untrusted application with access to only non-secure fastrpc device
>> node can attach to root_pd or static PDs if it can make the respective
>> init request. This can cause problems as the untrusted application
>> can send bad requests to root_pd or static PDs. Add changes to reject
>> attach to privileged PDs if the request is being made using non-secure
>> fastrpc device node.
>>
>> Fixes: 0871561055e6 ("misc: fastrpc: Add support for audiopd")
>> Cc: stable <stable@kernel.org>
>> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>    drivers/misc/fastrpc.c      | 22 +++++++++++++++++++---
>>    include/uapi/misc/fastrpc.h |  3 +++
>>    2 files changed, 22 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index 5680856c0fb8..a7a2bcedb37e 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -2087,6 +2087,16 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
>>    	return err;
>>    }
>>    
>> +static int is_attach_rejected(struct fastrpc_user *fl)
>> +{
>> +	/* Check if the device node is non-secure */
>> +	if (!fl->is_secure_dev) {
>> +		dev_dbg(&fl->cctx->rpdev->dev, "untrusted app trying to attach to privileged DSP PD\n");
>> +		return -EACCES;
>> +	}
>> +	return 0;
>> +}
> 
> This broke userspace for us. Sensors stopped working in SDM845 and other
> qcom SoC devices running postmarketOS. Trying to communicate with the
> fastrpc device just ends up with a permission denied error. This was
> previously working. I am not sure if this is intended. Here are my two
> observations:
> 
> 1. if change the if condition to
> 
> `if (!fl->is_secure_dev && fl->cctx->secure)`
> 
> similar to how it's done in fastrpc's `is_session_rejected()` function,
> then it works. But I am not sure if this is an valid fix. But currently,
> fastrpc will simply deny access to all fastrpc device that contains the
> `qcom,non-secure-domain` dt property. Is that the intended change?
> Because I see a lot of adsp, cdsp and sdsp fastrpc nodes have that dt
> property.
> 
> 2. In the `fastrpc_rpmsg_probe()` function, it is commented that,
> 
> "Unsigned PD offloading is only supported on CDSP"
> 
> Does this mean adsp and sdsp shouldn't have the `qcom,non-secure-domain`
> dt property? In fact, it was reported that removing this dt property and
> using the `/dev/fastrpc-sdsp-secure` node instead works fine too. Is
> this the correct way to fix it?

Yes, this is the ideal way to fix this, Audio DSP and Sensor DSPs are by 
default secure DSP's.

usage of "qcom,non-secure-domain" has been abused on all the platforms 
as the device tree bindings are not enforcing this checks to any new 
device tree entries. This needs fixing properly.

Ideally this patch has to fix the existing dts and update bindings to 
reflect that.

Sorry this has been over looked!

On the library side that you are using consider non-secure node as 
fallback only when secure node is missing.

given the mess with the current state of patch, reverting sounds good 
for me to start with.

--srini

> 
> I don't know much about fastrpc, just reporting the issue and guessing
> here. It would be really if this can be fixed before the stable release.
> 
> Thank you,
> Joel Selvaraj
> 
> 

