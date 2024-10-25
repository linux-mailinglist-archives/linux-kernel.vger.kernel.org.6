Return-Path: <linux-kernel+bounces-381640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE849B01E3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52BDD2837A0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F24220103F;
	Fri, 25 Oct 2024 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G2Q5qQrh"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27301D63D9
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 12:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729857999; cv=none; b=bC7nTsb2omx7IX5B2QYKeOFuHpf39rYJs63d02ACtAZ5vzy0psz8iTqt7xGydZrnZ5546Pz64Or8HHfZVtw71mJFvfPB9+/CQTSIH2NnB06nmlatrHjCTD0QSLxtz0+s2yoV087Sv2sz8FrWsan5wFqJMj9aCkhSW271dRS0IWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729857999; c=relaxed/simple;
	bh=yHxGn1FgTze473sMlb4L10Cjc+gww5KIznxNbwnUCjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Px9LzcKbFwX6yZ0XiK98FlbiMlFHTjTRzN8EKfkX7rxomEfVw/MYTPE/2Zq5aD1X3q5Gixk1ZWaWILUEtP9rdztGKB6lvJV5j+tHrJL9hko21X7vPc7XJLHUkvq+awAnLm+/EX/F6cyJ2U4h97L6DEXlB7jhu1sk/SOOpAfrWtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G2Q5qQrh; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a4031f69fso273619166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 05:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729857996; x=1730462796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LjMhfRloR5OEoW9abd4Ews9Mh5OTmcBwj2xC3WUGJko=;
        b=G2Q5qQrhq43H0utX1uRO04UkXcMi2ZLSRorc/AtnLfRVmwPgVABrAjU524z5RbOLbs
         QFvvzo/LRIl8Qc1nJmWAGoVB4pdByaipbklTj0l9DZkDwOhuMP6YJWbgQWmxu1MKck40
         /ecIRHZ55V8c+KPR/JMZ4qcgtQx/tGYzmDMfAG79xcDeImw0k0aUwJrHnrTPLnFkgjtm
         sEK0VaYlcXHA9/dYu9+tYoIMPJEHANcU/zInsTZFBYMZaTj7pmy/AIcWBi/+HLrDcFPb
         4NdVD1FftmTokhjn4O4KYen3duR3r8tPN9E23Mct7MTMXSTPP+jTntU0+iVJLeVT8gPv
         UawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729857996; x=1730462796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LjMhfRloR5OEoW9abd4Ews9Mh5OTmcBwj2xC3WUGJko=;
        b=FtPGzyeTV0eHdnyXaetkVquDNSm742zHlZhFTMl/Oz919y0WKT/HohC8s/sZqvm7Tu
         vIRQjh+wzz1KhJZfsx4A/KScexjz8bhfGXjYsS+YfoBlBrKTNuNeGbaLm9JHhpW9TAMe
         a4HORTEdzLKbxVscmE2L/v9YGaWTVC9UFgxQX/80HJrH1dcJgn6vNXfd8mpTtxuL+L78
         2l5DOexWUPM+6bK/vTUJzldkykEIvGiz+KEu8bEYL5AV9zl48LOpQ8VH34+5Ms3QZayy
         8C7xMT6B5NXyxE/dw6Uyuj6q9MqRkEroTrNgyZ6kLJm/W5O5cnh+jMTGxRvUVBZA3e3a
         r0Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUrfA2W8U3IWojPSdQFO0ZTcfBps0zv7FHcmTWQknV56rmXBkmbRub2G75CsAPAlFPQsjncfQC7H4D9nyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuef3TWj4M7BRYXKEaFCAFvREgfXdqmX75yxQ8CPqxSzZMggKL
	Ad32ZkjkgT02uBWiPQGHxR59VaXcLkv1ZuIoSk7SMXFpYjVRca+ANGjUs2jQ9HM=
X-Google-Smtp-Source: AGHT+IF8+yFn1XfjKbiftT0Zhl5TWbjjF6V4v6mo+nNQ6DxXzSAa5nQPJQtB8TdlKFyLuBFNoZaXBw==
X-Received: by 2002:a17:907:72d3:b0:a99:f779:adf9 with SMTP id a640c23a62f3a-a9ad2863046mr406619766b.63.1729857995954;
        Fri, 25 Oct 2024 05:06:35 -0700 (PDT)
Received: from [192.168.0.140] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dfbdfe2sm64056766b.36.2024.10.25.05.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 05:06:35 -0700 (PDT)
Message-ID: <a4c44b88-d106-4365-b405-ced561b9e526@linaro.org>
Date: Fri, 25 Oct 2024 15:06:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: Rework BCM_TCS_CMD macro
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20241025084823.475199-1-eugen.hristev@linaro.org>
 <c1d4c2b6-85a0-467a-930c-ac2797c72699@oss.qualcomm.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <c1d4c2b6-85a0-467a-930c-ac2797c72699@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/25/24 12:03, Konrad Dybcio wrote:
> On 25.10.2024 10:48 AM, Eugen Hristev wrote:
>> Reworked BCM_TCS_CMD macro in order to fix warnings from sparse:
>>
>> drivers/clk/qcom/clk-rpmh.c:270:28: warning: restricted __le32 degrades to integer
>> drivers/clk/qcom/clk-rpmh.c:270:28: warning: restricted __le32 degrades to integer
>>
>> While at it, used u32_encode_bits which made the code easier to
>> follow and removed unnecessary shift definitions.
>>
>> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
>> ---
>>   include/soc/qcom/tcs.h | 19 ++++++++-----------
>>   1 file changed, 8 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/soc/qcom/tcs.h b/include/soc/qcom/tcs.h
>> index 3acca067c72b..130ed2582f37 100644
>> --- a/include/soc/qcom/tcs.h
>> +++ b/include/soc/qcom/tcs.h
>> @@ -60,22 +60,19 @@ struct tcs_request {
>>   	struct tcs_cmd *cmds;
>>   };
>>   
>> -#define BCM_TCS_CMD_COMMIT_SHFT		30
>>   #define BCM_TCS_CMD_COMMIT_MASK		0x40000000
>> -#define BCM_TCS_CMD_VALID_SHFT		29
>>   #define BCM_TCS_CMD_VALID_MASK		0x20000000
>> -#define BCM_TCS_CMD_VOTE_X_SHFT		14
>>   #define BCM_TCS_CMD_VOTE_MASK		0x3fff
>> -#define BCM_TCS_CMD_VOTE_Y_SHFT		0
>> -#define BCM_TCS_CMD_VOTE_Y_MASK		0xfffc000
>> +#define BCM_TCS_CMD_VOTE_Y_MASK		0x3fff
>> +#define BCM_TCS_CMD_VOTE_X_MASK		0xfffc000
>>   
>>   /* Construct a Bus Clock Manager (BCM) specific TCS command */
>>   #define BCM_TCS_CMD(commit, valid, vote_x, vote_y)		\
>> -	(((commit) << BCM_TCS_CMD_COMMIT_SHFT) |		\
>> -	((valid) << BCM_TCS_CMD_VALID_SHFT) |			\
>> -	((cpu_to_le32(vote_x) &					\
>> -	BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_X_SHFT) |	\
>> -	((cpu_to_le32(vote_y) &					\
>> -	BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_Y_SHFT))
>> +	(u32_encode_bits(commit, BCM_TCS_CMD_COMMIT_MASK) |	\
>> +	u32_encode_bits(valid, BCM_TCS_CMD_VALID_MASK) |	\
>> +	u32_encode_bits((__force u32)cpu_to_le32(vote_x),	\
>> +			BCM_TCS_CMD_VOTE_X_MASK) |		\
>> +	u32_encode_bits((__force u32)cpu_to_le32(vote_y),	\
>> +			BCM_TCS_CMD_VOTE_Y_MASK))
> 
> FIELD_PREP/GET?
> 
> Konrad

What would be the difference/advantage in using FIELD_PREP/GET instead 
of u32_encode_bits ?

