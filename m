Return-Path: <linux-kernel+bounces-219623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C105E90D5B0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60C41C2327B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B5516EB75;
	Tue, 18 Jun 2024 14:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OT+sZ6GX"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDFE16EB42
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720888; cv=none; b=YaTjy7srwy3rrLepDJhXXYlijiZXru1J369b1UxHWBDM6gwSoJ2AtshjfPviAvAb8L19vE8/Fu+1i0e6i1YXX+l8GldtbVO8EKwRqBcYro6xNHjZKdwgCftBLT6qBePxNJ3lJrp8p2OnK75a35aK/6oWqoIQhsasqxTNZ+Xx01k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720888; c=relaxed/simple;
	bh=NNNRuGLddPKeM9Yh5xEuTsi+jatuPGGFxwB3SSxir1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0lQEeeskNusa4ej6PJBFL6jAP3dD9U2twH8Q4oshFWtW4At+Sq6SWNXB/OcGQVHCqLlqZ78nfzsJZUAftVFI7BeIpBH2aBkIlHEvpF01hoOrAFYbSOEYhc2+aw2D+UnSD+/M0UVBBVCj8ARvVqVvsInYP3FjZBSt/mm21cft9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OT+sZ6GX; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52cc5d5179aso927978e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718720885; x=1719325685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K1oD9cAlhoFUpaJXK/MI3nR3DbJ14JaglZi8r1oHsa4=;
        b=OT+sZ6GXLh/YFfkUTPPlUwL3ecHLBl6M5/KK/e6H8qKr3rmBTRDf2S3oYfC+1wMK5U
         vmzs87hybPTaYLZKe2YlsCw/ruxlpyckz4v5j+htU+9usoI8xWilLt1rCY59eXOwjLKY
         id6kxEl3wcK18SLLPwiRyw8uGAs+6E0qI7loYtuW4A9UW72FF/o3kjYtP99y0/k14Rwl
         Qrcufqf38qbZIEOcHNGr5Pzyvjo5gUgH0TitLJR0XUtErQH3frninaBvCPNTQhLGUbbb
         uCdIf1hHVfvBKcHfm415V9swy1Wx2IHk1z/br8lIo3fIEIxKgpbDc5L7DirFK91LlaKV
         i8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718720885; x=1719325685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K1oD9cAlhoFUpaJXK/MI3nR3DbJ14JaglZi8r1oHsa4=;
        b=KHgf/qaTbQc2NYvBWPByvN7wEBXufpnz3kVPV5G6ElD7hOrFEdIb5bukyEf5MafcWH
         4/P2q2pdfBT+fi9mD17V3G8JWcGANdJDsTAXOnnLO5TNcpqeqCWOUdZ8X6BajGcWcz+f
         gaQFODejVylnBh+0yGCXA+L3SQcG/Vesol+/xHRuznCLwbrUYO4xmMu8loF3OEmumzu2
         y/P6yz5eJXmksjckeACz4KqsyWtbjaZa7GByXMI7Myq0d4VlGwq+Okjt5/SVC3+n1TMa
         1dj3kvJfCJufOho4maKLwB5wnIJUPf45miEH+Oxakqo1rIg3EMj9ge4Y647Zv/1cKndr
         TpjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVacETBlRxLfLa5ml1T6yF43I8BxLx5oaVYHgvZ/m7MN5R+tswIUNazjjGJGMl7LvVaYBZhtPnna9t8PwxkqgrPB8urDZLQZWgwazrW
X-Gm-Message-State: AOJu0YwJoAYA6QmeIxVrgDCrYbk1gNjtr+NgCaNQOTd7AgXhL9cpwcxf
	IUiKMTlQkqg3q268o8y9xA5XAWTVEZ9VV3NeX0bofVAZSWYS5tgCDlwc3Yj8TXE=
X-Google-Smtp-Source: AGHT+IHBx3GtM/7wDLLkUt6Vmc/LNvxwypfkaJ/S6LtCJfYKvIG2fRy62ZT2KiZrAciOWnz/Niy0CA==
X-Received: by 2002:a19:e041:0:b0:52c:842b:c276 with SMTP id 2adb3069b0e04-52ca6e9182fmr8918009e87.53.1718720884661;
        Tue, 18 Jun 2024 07:28:04 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4fb7:492b:2c94:7283? ([2a00:f41:9028:9df3:4fb7:492b:2c94:7283])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cc0f0285esm384783e87.184.2024.06.18.07.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 07:28:04 -0700 (PDT)
Message-ID: <4a1b5ad3-56a9-4b83-97db-0781d68bf507@linaro.org>
Date: Tue, 18 Jun 2024 16:27:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] interconnect: qcom: icc-rpm: Remodel how QoS settings
 are stored
To: Mike Tipton <quic_mdtipton@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Georgi Djakov
 <djakov@kernel.org>, Shawn Guo <shawn.guo@linaro.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
 quic_okukatla@quicinc.com
References: <20240326-topic-rpm_icc_qos_cleanup-v1-0-357e736792be@linaro.org>
 <20240326-topic-rpm_icc_qos_cleanup-v1-4-357e736792be@linaro.org>
 <20240508014530.GB25316@hu-mdtipton-lv.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240508014530.GB25316@hu-mdtipton-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/8/24 03:45, Mike Tipton wrote:
> Hi Konrad,
> 
> On Tue, Mar 26, 2024 at 08:42:35PM +0100, Konrad Dybcio wrote:
>> Currently, the QoS settings are stored in the node data, even though
>> they're a property of the bus/provider instead. Moreover, they are only
>> needed during the probe step, so they can be easily moved into struct
>> qcom_icc_desc.
> 
> The QoS settings *are* fundamentally a property of the node. The nodes
> are 1:1 with the NOC ports. And the QoS settings tune the priority of
> the data coming out of those ports. So, logically speaking, the QoS data
> does belong in the node structs along with the rest of the data for that
> node and port.
> 
> Only a subset of NOC ports support configurable QoS, but for those ports
> that do it's a property of the port itself. Those settings impact just
> that specific port and nothing else.
> 
> The current method of directly embedding the qcom_icc_qos_data struct
> into qcom_icc_node isn't optimal, since that data is irrelevant for
> ports that don't support it. So, the size could be optimized by
> converting qcom_icc_node::qos into a pointer instead. But I don't think
> we should separate the QoS settings from node struct entirely. It makes
> it very difficult to understand which QoS settings are impacting which
> port.

I think that would make more sense indeed

[...]

>>   
>> +static const struct qcom_icc_qos_data a0noc_qos_data[] = {
>> +	{
>> +		.qos_port = 0,
>> +		.qos_mode = NOC_QOS_MODE_FIXED,
>> +		.areq_prio = 1,
>> +		.prio_level = 1,
>> +		.urg_fwd_en = false,
>> +		.limit_commands = false,
>> +	}, {
> 
> How can I tell that these a0noc_qos_data[0] settings are for the
> mas_pcie_0 port? It's not possible from the code anymore. *We* could
> figure it out internally by looking at the NOC SWI to determine the
> qos_port index. But this should be obvious from the code itself.

Right

Konrad

