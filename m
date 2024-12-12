Return-Path: <linux-kernel+bounces-443087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0DE9EE6E8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B87D18860EE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2962135B9;
	Thu, 12 Dec 2024 12:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KwHOg104"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68006213238
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734007273; cv=none; b=LPGMrjOl4ZD0PVjE0q4IltJ32vgaydear5GH6R823PPjMkFagx4X7MnDOmhIyNJxO8WbvQUMhVoEOzLMWNrjh0Zm/VmeOmnz4M0i/GyNORnP8K5mM3yBCPkdazGBATFKMNIGSiSTwI658WHS6u0ZBn5cxi+g5co04AvMMrFFhjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734007273; c=relaxed/simple;
	bh=Tu/dFKzeet27GmDqbtWEt4iGTBlq3wEZqSveNunZQyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pCMULXyeEMLa80+gH7UiiM0nnAUnmXs53fRdPSMTaPjvr+q6jJsahFIZmcrqio3J5ZqW7Qm8SIRZr44+YQsATgyn7NbtoKOEjodTnRhBtx6IOvZNIcq1mP1hEHOF9d0lac0OYGF6qfiVIigBo6qOReM4tgX0/r7fMZOtrXDcZXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KwHOg104; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so1017336a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 04:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734007270; x=1734612070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8bkw8aLWhg4IdC3Iyd2UGPgLYgTX4eLLSzr6WZhm6c4=;
        b=KwHOg104tECUeLCic1AROAit2IBxU/WGSotQgXtsXdvytz1q/epPlaZQVKNnQCIheK
         FsfkCXS6s6trGXfAChurRlz7DDJcbKH6yemZgn8f8kIFq9+DvnsAHNT4ZuZhlTFy+GG/
         jJcxoIXrphCH1gr+fiUDjbT9aQaVHqdw3Ldf97Am+c99blwgiZCJjT5aDkuJ6tXY6XUe
         ChMMrimbnQcMTBxkOazSjqS3dvkS/fpLFzlPbloC7LdnutPsmP033JNyqtoKUj//UZLs
         2MGqAdkEMMoAx6txP4aon8iGMdpbv+THKqc6Al9RJcEzZNXN1R4427ZNXoTPJxieFEjj
         mMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734007270; x=1734612070;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8bkw8aLWhg4IdC3Iyd2UGPgLYgTX4eLLSzr6WZhm6c4=;
        b=O94kTuLC2U91K2HV2G007utB+hj6dOZJLCAyMG3F3HtGD2mKth6fODRNndBYQejOun
         c4YdFLjDjBaVi5zUxHJlgWyM9van5jXzCbuA5mp/xb84kemtxBnanmV/idjnJYS+CkUE
         9Omnh0WH5SWqH64P76JtwmyGHnLUOhOEf3DPXvzhCYGSZFVQNot+D0F7zOqUxdj/laLL
         /YsU/zapIeDA9xGvA0yJRfBDeD3hXHD/JSy5QrcVGAPFi3Pml5RevonIwmVmBCAgp2fO
         R4kSKkLlRnVOlzzcheGucI1vlU+DAfLCpiOkd/wT0idnH70xmr1aLb57UFmQMKGy15pK
         WwnA==
X-Forwarded-Encrypted: i=1; AJvYcCXy2ZKjEO7KRmRaeOMOQdOkHeF02e/+fRt2x0upcQkOBRraOhjCF+oCyq0kKn4v3mpXExnnkSsPTx6hyTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz55Fb8gpQtBjhXtHImlBOcMGOL0j4A4FyF5BhPtLa46h/U8GZx
	lkb51ru5t+ArZg2J6msD5ytV4jdANTtUE2fpOhmYbFPBCeW2GiCxdS1Ft/AiRew=
X-Gm-Gg: ASbGncs/8NAUdZYOnTD0AVBTbshOHvJggMWAsw6XyUJrwfauv8gsneaO5zbD+1Hpbk9
	fPG4dbSbIuICWOpiZ64/5FmBMQD6ueOg7RaMHfP7VdNoPjpyou0sAp5FtBMHkEj23SWAmO5neBh
	IYyHISFgydUw50mzPjMmJxyp3u2lrm8dEa51ylI13WRkhUvEWaDuAulrG1/t3hLqL4/n5yXUlwk
	mLsBsrvbRSPZJzcUBK8kCB3DhaPtflnqDP6fvt8xo8CfcMRaxuC+HOEWpGq5pfdYFzicg==
X-Google-Smtp-Source: AGHT+IFur+anvIPrRfunzJYLh6wEtqp7DK5VjkUBpxyuQDBjTbkTiH5jVNJtu8OGD0/LBKO7AI5Oow==
X-Received: by 2002:a05:6402:2396:b0:5d3:e766:6140 with SMTP id 4fb4d7f45d1cf-5d6337e00a8mr76871a12.24.1734007269761;
        Thu, 12 Dec 2024 04:41:09 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d42a754cb0sm3172232a12.88.2024.12.12.04.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 04:41:09 -0800 (PST)
Message-ID: <b4afb2ea-eb5e-404b-9df8-3e11d08a6bff@linaro.org>
Date: Thu, 12 Dec 2024 12:41:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] media: qcom: camss: Add CSID 780 support
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, vladimir.zapolskiy@linaro.org
Cc: quic_eberman@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com,
 Yongsheng Li <quic_yon@quicinc.com>
References: <20241211140738.3835588-1-quic_depengs@quicinc.com>
 <20241211140738.3835588-16-quic_depengs@quicinc.com>
 <138cc2e5-6b31-49d9-b70e-400a3f3c3bfa@linaro.org>
 <28b1c828-f338-4d57-bcb7-b0a8652c82fb@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <28b1c828-f338-4d57-bcb7-b0a8652c82fb@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/2024 11:28, Depeng Shao wrote:
>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> 
> Vladimir suggested to add a dummy "return 0" function [1] for the 
> unsupported interface. So, I added this empty callback, will keep the 
> empty callback if no other concern. Thanks.
> 
> [1] https://lore.kernel.org/all/b1e1ff88-5bba-4424- 
> bc85-38caa85b831f@linaro.org/

Go ahead.

---
bod

