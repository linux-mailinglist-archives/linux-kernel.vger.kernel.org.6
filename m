Return-Path: <linux-kernel+bounces-408033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6909C9C7936
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C18C1F24FE4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF93614F114;
	Wed, 13 Nov 2024 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TAYt8T/V"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A59816A94A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 16:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516370; cv=none; b=ErOHsFuIP+JprZO00SQWQnCA0fdb2JYGzmknBvr2spyMH+WwpVI3N2UKeK73MesnNTWEPNYEYRqy+3W46Sk0JmQuEIs6qnSkhT39aXfn5ugU5ZH7EZEVTtQpOV+2NhBEEHhV/+kEQVo9MxJO4pa9NUtHdZGM3eQZa6n4yAcvc9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516370; c=relaxed/simple;
	bh=Vwy1oSriyT+MIYawWcOFKmv9oUnxvII3WvkoO2ynRdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gdhHFw4kicdVhMb8/UMJmRLba/PBFyxh7XkNiMTI1EUuWmMS/PhgKiPkWq0eDuxHLoSFOYNlxD7xF2nzaxWQ/Q8W4pH9f3Yz982wYCCroDGgH5SLEV++mLnRi23WzzrE0M8yOklU5vN1sUCXVm4NIzz1ERjkbzBnXuYkoe3qHIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TAYt8T/V; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d533b5412so4945994f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731516366; x=1732121166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zmkd5V8HB7Q4sGbZtrxWGBf5+TlXsok1y0ywIIUCx9M=;
        b=TAYt8T/VBfmVwMCjba5GcN4v2jybXER9dVX/mahXo99h1DFmIfuXjyx6P9cyIY0F2J
         RLz+SVI16yoTq/JY+y3VN1TEp2jjnH/fsfA3BeJ85oSIRq0NhNWEEFeFj/7lGamjTabm
         mXmWCHsNg4FFrcvtHkPi69VS3cSGVOZ6AmoD4RnMVc+xmSqxZ1VwkVieZLRSahbYkmJ8
         KPEUArxU/wUl6R9xi9whVIvuzS/lCa/e2MpQq0fPHcb13M7wSnpkQodWxvlChQqYRW6j
         BsU2g6zfiocV3Sl8gyAGorRTtyWF8zjhe2a0xvwA349SUTof2+R5tB/tBWH25hBqNbKo
         cSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731516366; x=1732121166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zmkd5V8HB7Q4sGbZtrxWGBf5+TlXsok1y0ywIIUCx9M=;
        b=qOLQLG1u2mIQryg8/aHXS/UOT8rkGL1QWXyAVzWtR/Jz9kL83xqBo8/CAILZKknpj3
         jzLoCKtg85H5b+CGMP/7Uy8mzwpkdoMZWPVRqYXCQUMhJlgsfA8pVF9YNkOI//hkE8es
         FNi5zX1yOJXn+WRD/8KniJ3l3m8A45ZEZl4IpCJhtapiYN/CZQkUvGGA+vKPE23kjuBU
         LwI38hjmKg7FnM3+7BRoAUZPuoxqGXHeFH8LvXVMx/ZVl7IYhtVE8/Iab52z9V+oitBi
         DBdg3DU+LWoaFiGLPMJKgHnG26q4J9kWm8WsgIrv0WMnjlPFof5Gb0fkI9fQ+fj3ARIi
         SgGw==
X-Forwarded-Encrypted: i=1; AJvYcCXC5wsyLMa9SsvnxtKLopoTtJXN3QC1zDXDdHad7pRn2xh3LLmLr8Hn0984dNoEwvb138FtJRdgh1WtCUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBKZ1SW+T1NSnwtvhHbQl3EpsnLD0G2xDIQZYqXdeJ70X7aUiT
	jKo/IjegtjnMiyykJs9J21y/D2Auu8pa1EiD0GHz+de44Rnst1kLFH7QxonHoJA=
X-Google-Smtp-Source: AGHT+IEPY0tVNdb8C+tYsDxL66F1F1lB+tkHPAObFKOXietn9feaRfTNcNYc2AdjkSxoREK/g4zzqw==
X-Received: by 2002:a5d:5f81:0:b0:37d:4e74:684 with SMTP id ffacd0b85a97d-381f1888c09mr17565241f8f.52.1731516365863;
        Wed, 13 Nov 2024 08:46:05 -0800 (PST)
Received: from [192.168.0.48] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda0517csm18751675f8f.96.2024.11.13.08.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 08:46:05 -0800 (PST)
Message-ID: <16d1f749-03e2-47fc-a7ff-d77ae0f30af9@linaro.org>
Date: Wed, 13 Nov 2024 16:46:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: qcs615-ride: enable venus node
To: Renjiang Han <quic_renjiang@quicinc.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241112-add-venus-for-qcs615-v2-0-e67947f957af@quicinc.com>
 <20241112-add-venus-for-qcs615-v2-4-e67947f957af@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241112-add-venus-for-qcs615-v2-4-e67947f957af@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/2024 11:48, Renjiang Han wrote:
> Enable the venus node so that the video codec will start working.
> 
> Signed-off-by: Renjiang Han <quic_renjiang@quicinc.com>

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

