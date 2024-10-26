Return-Path: <linux-kernel+bounces-383063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516929B16F7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 12:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0666F1F21945
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 10:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7301D04A9;
	Sat, 26 Oct 2024 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RbqzqQbc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFED18F2F6
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729938052; cv=none; b=AQhv7on9x+sQs3lCHZjqwOoZbaqwI7myE19O2Lj24XLDk8oovHsYJBZDP5v2B0OFRVevQxNSxJpHj3iMfG8PrsuafWQB4Gi/I+vn5zuYFy55oNzl39os5vI3jK2/jRfhc/f4J53JfybAEcCtX3OEC9BJjkrr3QwAp1ifMnF4TO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729938052; c=relaxed/simple;
	bh=Rgaq7ReqIAQTm40Lwr7SvibuzkW5wbR9WU+yEHhQ5gU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5FiLfNZDWW0J5obavC70/ka6DYhFq7Y9220FWOlZhEcb8IPM47g6lNi7Cv6/9OtaSmsARyhpaIdq4kMHx8hF6o5FWbAo+Jj7ERbdet0ii8m8cKvx/CaZUlTBl1Qbcdn2F22KXst18O3oG55ot0B5UPGZaSlj2/tq8+HbIB9PRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RbqzqQbc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q4ElAv018738
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UdsYLf/p3CQkr1b4rIZAdrrJ1e3MWxNTEnsDId7lgG8=; b=RbqzqQbcLBbtqQTF
	iwlHy/k1/epo0FYSmFHRN+JzNUdLMqsZE+BsTRAD9phq4vzjMRWlMgwIcGv7uAk5
	AW0nNS34AALofTfEYcw/MowVI170NwoKnVjXzxFQxQAsa9Z7ceePB/ZvReffoXcJ
	Go7XAJ6kb8Dm6BP9RE7ciQrrRoD/HmQ6vJVlRB+QOqmMIWu3HECJocjBysumWadd
	PJ1wVtZ1w3kalTmNM29kgSpVFnu1pc0lUc/DWoaxkSdpQA/0kF0xohRo5SHwb++h
	wqQa8wgJN/ycsS807EdaOMu7Q5xLUkBQCVXjLyY5y8M29NyPR933utwkeXybkMKf
	XqTKOQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gp4drwf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:20:49 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6cb9afcecb9so8904696d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 03:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729938048; x=1730542848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UdsYLf/p3CQkr1b4rIZAdrrJ1e3MWxNTEnsDId7lgG8=;
        b=wbmhOnI1QuIEsjvQmPQ3tIuWx62qhP56s2fAN+SbBVwhO8ujUEIQVi6CIP2ShaVyJb
         wuvEHwILASsdgUQnFeLsZWzrDeni1gZYeMWyZA2HsW/MM6jy9A0j/cuxIU87DfztIInY
         uqDm5BZuTpRn+4LgINjDcUlqcdOS2TKF5x1RkOm3PozwaF6vsK8D+cvsy20xpNccxOPI
         K9HkIOU+TDfPs5peaqBtPr5uYOuhbFjyZdh/GGihejumc/Gq/CbvDOtd0Fve0Qk6KTB/
         pTia1zeG+jshlrs9vvzOW33ohV0iWX1B8cYYZn4DNcZWsuBG9GbeabUah63DiWA7UONK
         X/8w==
X-Forwarded-Encrypted: i=1; AJvYcCVmxifTgzkuGb0yIleuAV/M1XsSu0gSQmpiKrKVoA5TxaFxamR9pnKl6H6ma1ynuZ+wKGESdnjTMH6nhkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAFfOfOUcf+BqONbf2rw55NeKaBID3PnHh3hbVYRrE8Uct29MJ
	BYtxKl/T5gnBZ2h05kPqVKPZG0tmzg2R74RDqO9YfJyTBu1uYD7rOV43vmNOsZbqvnTsUs+2YYO
	v8RESYNMzF3a78ghZGpi9rF9qAMUooVQhSQFBQ30AdLKwVsrmeY3yYaSZ1G9uJRe0JTcTjDQ=
X-Received: by 2002:ad4:4ee2:0:b0:6cb:31b8:43d4 with SMTP id 6a1803df08f44-6d18558d937mr17693136d6.0.1729938048109;
        Sat, 26 Oct 2024 03:20:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvq6DKxhjnd3S8AuLNtEgeBFkxylZ29k9JSPOQ/x2U1+UIqTqjZ8WzJSCKHMD/gnZHKKfXaw==
X-Received: by 2002:ad4:4ee2:0:b0:6cb:31b8:43d4 with SMTP id 6a1803df08f44-6d18558d937mr17692956d6.0.1729938047700;
        Sat, 26 Oct 2024 03:20:47 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b2f965d90sm160642666b.154.2024.10.26.03.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 03:20:47 -0700 (PDT)
Message-ID: <3bbbb028-83ab-4096-a67c-4d7f0bd73420@oss.qualcomm.com>
Date: Sat, 26 Oct 2024 12:20:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/12] arm64: dts: qcom: sdm845: enable gmu
To: Dzmitry Sankouski <dsankouski@gmail.com>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241008-starqltechn_integration_upstream-v6-0-5445365d3052@gmail.com>
 <20241008-starqltechn_integration_upstream-v6-1-5445365d3052@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241008-starqltechn_integration_upstream-v6-1-5445365d3052@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Lm8RieyDa3T0dnKCLqkVDTTm16Rb7viG
X-Proofpoint-GUID: Lm8RieyDa3T0dnKCLqkVDTTm16Rb7viG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxlogscore=621 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410260086

On 8.10.2024 6:51 PM, Dzmitry Sankouski wrote:
> Leave gmu enabled, because it's only probed when
> GPU is.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

