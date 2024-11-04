Return-Path: <linux-kernel+bounces-394694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1FF9BB2ED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E40D3284C2E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1B91C3021;
	Mon,  4 Nov 2024 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L4fPlMFa"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E292D1C232D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718490; cv=none; b=DrcYoNsnWM42uFVch2Yx6yXOIvlj4vRhLEPTM17nZLYCEsOsSePYVn0wNC/rum8NcgntMb4ounHCxujDPlPrOWSBMFrrpXe2btAVQEvvmlFF1IrtAbdTKecuM5JHBspE4bjV1y8ynxe/XAJjb+fWVcM70s9NEz7YEeJN801M15k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718490; c=relaxed/simple;
	bh=TlWYsh/tWFexC/eaSPh4TES8aBRMPNL3l+Ql19A0KdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/dF7nqe6q2m09iTh/fY+7BhhfDCH+McQPCz1XN4NO4BZjqMVtmuykhb6zWt3rHge3Y8UcSlp0ZND71+ytjfPX+q21l3O0LGhRlht5/1RsgDzfVtiyhopbDnV58jh0WlAQGmHdsxncthAjaSr0l7sH3ikASyXhS4kkn7EXHkIUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L4fPlMFa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3NvIkp010819
	for <linux-kernel@vger.kernel.org>; Mon, 4 Nov 2024 11:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MHxDEh2fTvWYJLflbd4GMYSu1K2/F3475Vm6BDDWikI=; b=L4fPlMFaexiGZl52
	uE/Rxvyw+yrmT8zwY6Q6wgUtGfcAo7HGCmWBgeAP/key7BJuNlFD8B9/1QCuJr0R
	frIC9T6nIHnR0FP8JvvQigtL98I5wjx/UcnLdv8UWmQe0s4l5yLqbz6yn99VBM3C
	1SnoiHeFhwOVHdMr48ScD4Aj53XzsHKzIV47RMnobEyh5m3nVWtgKdUd9I+OfoMw
	NmNxYvZ4oxuttGFh2iZ27//N3l1WgbY6v7iJmqIkQPo+d5qRvqQ+KtVi9c43GoVx
	iC5+jT5br/DqyrwUpYzmurYdQ0MiywGwoRF6OV3CsK9U7csBZ6D6/OR5VBFAgFeC
	wkmujg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd8hbuaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 11:08:08 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbe6e6bcf2so11506356d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 03:08:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730718487; x=1731323287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MHxDEh2fTvWYJLflbd4GMYSu1K2/F3475Vm6BDDWikI=;
        b=fS85eENvruGKlqVSDsT4qCdB/UUxYWKzVfHY+a/kb0AT37Ru4JHJD4P26r8jipCZnY
         SWTzLqMMLKH3V8flAxoVdu2+UV1NTLmz2foBgJTr1DjT5779yBUjTfA1atf56aS1gyg0
         u3NPJiv5qWEYB5P0VIWwa0vwYt3qBo1sEPUva4tw4wBZvDJ/reKTwhanDfuk/3M4vT5U
         +Yj344rn0zn8koNaHbhLLkfjobjNiuQBuKQw2A+rKWpstOp8C5etJsRgWsNNAynmy200
         EwWlKfBzTq+nUoSDo3La8v2sAXX3iocjbOmU9AfXvcA/GPSFPQkVsxWoebgLIs/Xv8tt
         k2Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVK/owWl2CxIxBf9PDS0fTUutz/U6h3kOufrn8QUzGiPut+Hb7lFLUQHd6QSNvoq3r9OiAykgRedA7NpoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YywPaRLUch5E0cZs0k20SpKOKsH4LFaGLptQxlpLh16+dk3n20T
	RTHnhLFzzcAnV1ee9MsRT/0iyMmqNbPtzOWatqke0qRqv6dIj9raQtmbLchSSrlWsZFr1uMGeOP
	6dam9jFd724Jswz3KLeNCANtkGZAD6hPuJOhgRpV87eGSD3uwZwxR0zBkgb9TBxc=
X-Received: by 2002:a05:620a:4491:b0:7b1:4351:c344 with SMTP id af79cd13be357-7b193f5b0cfmr2082875785a.14.1730718486847;
        Mon, 04 Nov 2024 03:08:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+aCC2RzIzzCty1UQRivhxqMsi6YryphPrhekUj7zYXO36kDiESq+6rykwo0xBdVBUrO9BcA==
X-Received: by 2002:a05:620a:4491:b0:7b1:4351:c344 with SMTP id af79cd13be357-7b193f5b0cfmr2082874585a.14.1730718486551;
        Mon, 04 Nov 2024 03:08:06 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564c530esm537730166b.75.2024.11.04.03.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 03:08:06 -0800 (PST)
Message-ID: <993fc6d6-d135-4a31-96e7-3270ac287d82@oss.qualcomm.com>
Date: Mon, 4 Nov 2024 12:08:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] arm64: dts: qcom: qcs8300: Add watchdog node
To: Xin Liu <quic_liuxin@quicinc.com>, Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com,
        quic_jiegan@quicinc.com, quic_aiquny@quicinc.com,
        quic_tingweiz@quicinc.com
References: <20241029031222.1653123-1-quic_liuxin@quicinc.com>
 <20241029031222.1653123-3-quic_liuxin@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241029031222.1653123-3-quic_liuxin@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: w9M5lTQMFr4tOIjMG4cdCQBhhtNEunew
X-Proofpoint-GUID: w9M5lTQMFr4tOIjMG4cdCQBhhtNEunew
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=804 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411040098

On 29.10.2024 4:12 AM, Xin Liu wrote:
> Add the watchdog node for QCS8300 SoC.
> 
> Signed-off-by: Xin Liu <quic_liuxin@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

