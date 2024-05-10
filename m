Return-Path: <linux-kernel+bounces-176098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DE08C29E0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 20:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D5BFB25F92
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CE93D982;
	Fri, 10 May 2024 18:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kOASB9/O"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DF04437A
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 18:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715365735; cv=none; b=iIxfaNJJs4lk31KKUhmmqNpaWeDwYf43YmAAUAdQbV3AjEibHXZNYN2K4VgLaT0kSgOcjj+ws+gxZ7mGlfV2bPDPYX3SYoDqhTUQPTGpKTxOtBe4ZX3ptXNOl4+9++1uGtFuzVeq6FxTuQ6EwAIWlBVRprbEnuQt28vmJq43jW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715365735; c=relaxed/simple;
	bh=epoXW1waP+MwH99xf6rC682FICComy7UfCT9VhplzdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X5XwYcOnYQXG9qKuLrvEWmzrRhjaqWT5H0vi3DhexgESxnM6ujyBcWtXlicpd10fil/58eTUTEImQEHdF6C2c5rFsWS+436IANxmNnSiq/wwt5NeFbl92rGs1DXxBWyUYAAktVOJnb3JCqe4HTPQb8Uy3eEwAjEElF2We6XKsdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kOASB9/O; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51f174e316eso2818792e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715365731; x=1715970531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BFg4ayAexiWKOzOXFoyc3idLGyKV44tIY5d5O3liHs0=;
        b=kOASB9/OV8cpiKeoCrqdZop/lZXYUfjcOQfuCDvv04nwcjeltsiR6gdZFSCRp87LSc
         Wmi4ZXkKiu0/42CP1MAr64Tj/MbeY85pdse4Nrv0YaWJjYCR/J8H6NDICHeZlXXtXAN3
         accFAiD7vhU37gaHjUkCq4eyRzWtlnAUBxb8xAiVG45s2viMAXYscusFKSNo2ZR5TXOO
         jx6uErkIpy8iSb4DKOaKymoApFj6PmftfhDFaqDiERfre56fWoEhXmbQ3yAeykEL8oGl
         ccgG/Y2bnPOAWXjvD3NnUSDg/PAm1zuNAn232FJuf/8X9LeIVNDQ5K7WLbBxQ/KOD6J1
         7S5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715365731; x=1715970531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BFg4ayAexiWKOzOXFoyc3idLGyKV44tIY5d5O3liHs0=;
        b=liglYobDVNPvLetA7p+veomIZUnRMpstu6XDlG3YEfsXOxd1AWIr9nz9paDQCVCxvx
         vGDSe+iwZjwT9oMW+y/w1jar9njB0ZjVU6JO2T3MEN0wuDe2H8DcYNG07rmJKwlubmWC
         yoVeS6I81XBAiJXus254kvzzsRLSThvXlQpwjiur9t3aQp8smPrvh9OUGArQ+oCp69AM
         XubtyS3DU5xPWe+sSsxRJMBPCNMdpx3sEasgz/0I5Ya1unSsH68tIPoi3t3y23b3uWHV
         Jw3ONTJOXnYZDcCNVhys0JisBaAuMMoSPKgqz/QgXGNslzkNGHMsuWvmpJqTfMtWW7ns
         ciIA==
X-Forwarded-Encrypted: i=1; AJvYcCVX1mvSMalSQVa/BqPOEfym+jwFv5j+pMDEd2V5Ge6jPcdPIU1GAhInOfLYIDDX9YSxa3zRnwtgub5JPNR/tM2kvNfq49VzxrN7BnCy
X-Gm-Message-State: AOJu0YyOvaDhI7j5oGJrpgK17bJBVsEyne8u+NdA2iyDCQixvoTd9nKq
	mpqyG34BF/vtpu3XMw3yfyCjEVV2kAgScvkp0fAWYibENeeRVC1/UF6QknoxThw=
X-Google-Smtp-Source: AGHT+IFTTIXd6P+2xpMOVHOVAj9yA/GxgU12mKxNlNuyXL9J+PwnVML97iLnokLxyBdelRuQZ25D3Q==
X-Received: by 2002:a19:6b0b:0:b0:51d:97e8:d2ea with SMTP id 2adb3069b0e04-5220fb77411mr2139996e87.30.1715365730768;
        Fri, 10 May 2024 11:28:50 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad02csm5148688f8f.67.2024.05.10.11.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 11:28:50 -0700 (PDT)
Message-ID: <be76c36a-2233-4fcb-87be-d6a5fe5b0c93@linaro.org>
Date: Fri, 10 May 2024 19:28:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] media: qcom: camss: Split testgen, RDI and RX for
 CSID 170
To: Gjorgji Rosikopulos <quic_grosikop@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, andersson@kernel.org, konrad.dybcio@linaro.org,
 mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com,
 hverkuil-cisco@xs4all.nl, quic_hariramp@quicinc.com
References: <20240411124543.199-1-quic_grosikop@quicinc.com>
 <20240411124543.199-7-quic_grosikop@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240411124543.199-7-quic_grosikop@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/04/2024 13:45, Gjorgji Rosikopulos wrote:
> From: Milen Mitkov <quic_mmitkov@quicinc.com>
> 
> Split the RAW interface (RDI), the CSID receiver (RX)
> and test pattern generator (testgen), configurations
> for CSID on Titan 170
> 
> Signed-off-by: Milen Mitkov <quic_mmitkov@quicinc.com>
> Signed-off-by: Gjorgji Rosikopulos <quic_grosikop@quicinc.com>
> ---

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # 
sc8280xp/sm8250/sdm845/apq8016


