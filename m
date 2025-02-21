Return-Path: <linux-kernel+bounces-526698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6954AA40224
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CDC83BB56F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA6C255E2B;
	Fri, 21 Feb 2025 21:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U5e14kld"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AE7254B02
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 21:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740173930; cv=none; b=ekPcGxbGByVSPKclVma6EOZe+lN4XmGc+YhvxaBzJ9dZUabUVcGEpkdinEGGhLQkV8IT+TK3rx9HOcpSfUybfHcaAMuZy1c9t3Gn73eMMrPpYQfEdoUfGl/takQ28Agu/KKbwnFp/ddezcQ/FDyBsjGnUMRctq18sCPAO++o/G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740173930; c=relaxed/simple;
	bh=4ygCX+BlAc5yHgLuL83+bGU6HjWO3YrRUAIp22PE1Xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qlE2XCpcnCZlBsOHmSrfqh6uZJLpWb/OEYNCDrS9dRSd7BY2mDvJermm3BHj9xvRWLel+FJIPfEdU/Mx+Zoui0RYOLxPJflLF5rbr3xQHc/z0jYH82CuWr7AGNgpmUTWHvoAOXr1y5y5NMAQ8kaPGPSJ0GubdySAx5whDC0+agg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U5e14kld; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LDDK1f031918
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 21:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SQKkyFpJsq0/fkBHSwHXcQmdiJaguo6VpRU5m0ktNdg=; b=U5e14kld8aRYrbsU
	hGjuh3RLE5I0lkL6IyIwFK4QryDka+4Ujsg597s2g4Qc0IMO326k/v8nXdgvWwrP
	LPB1gowUls2lNhjt9MFluFfY/AESBgo8kdype4YuS9X0vcBZ9ATs6CjaBRwINpQi
	8UdxTGZPP3zuML7+YyypMQ8vxlfL+SSvoICqp8VYkCNlEy+vgswijWRHjkpunaVs
	jgzpm5inWkB7CRrbBITE6fRxMe7aOBgr0bmVNAprBhT/PAixOeZDOEPG/MGDd7dO
	7L1kE4/3LTpVSOvJ/znNfqPo1QXkfdsn7Mo7hAxxYgGEoe28R1FxYPOLlcJxJIJF
	UBfP2g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy5k747-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 21:38:48 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e65bc4f2d8so3913536d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:38:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740173927; x=1740778727;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQKkyFpJsq0/fkBHSwHXcQmdiJaguo6VpRU5m0ktNdg=;
        b=l8iVYPDJWmlyvOcqf2lisqFM9Bg85vo5I17bfDz93FXKBrwQqxqn3BmWmSzxVgx0B2
         E0Ipp3NjSOGElZZzpafalOzSusHlYBH60mmZ73O7/hMOIJJc1VaLonSW5EHIEAOGoBtb
         4HrwZ3XbAo5KPg0eG+qc1hT+7NoPMxAX98vDr7Wi/j3oozsJR/6sSn9I6NFxIsbXPGPt
         AyJOlDOkxnn8Sq2gpO+LwQT2lXk9BdLXoA4mC1P6aXvpG6LyIDJqUyCpT0JGOf0Iuov8
         5fPAGYp89c/lKSI5k/0aIhYfKGKoToUyTQGK7e86AD5HAo+6C+87O6c6Tum2EeZSaNyg
         BwoA==
X-Forwarded-Encrypted: i=1; AJvYcCUceAcpA9oyg/R1uKQ0+89zl/22ORu6RBK3xESdlL8XVhuZkvRZ3zkP3Ga9qs77ZTpxPiwTX0Ko09pSA6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzUl99wCAnK+88RkoasdtN1mD+uEY34pTRh5oaNgEi85K9kiu5
	FJfmFPtHiObXlU/9cIR2wL8bn4MtIynhyfZDNqEV7uX39J2FmmfzuH++wXn30QXztu7LMF1tQgB
	rwfRMmZQe9svzmUZW8Xee41P0LMEnl8niT5emzKo4QEC0+j7RN2kPBqNNAqCeWH0=
X-Gm-Gg: ASbGncv5OniIs6WJcpEQyxP9LYs6jNndrb984YCG6UH+SY23FYxfoTNAc4oNQgMszBV
	kiq/kR7RuA/iIzts3bk8Pz1Vrwi0QBdDvEuw7xWSxm8DoLKnd6MSwsH/LYe2GxgR7oMK5Q5Bip3
	Zlq33nLGbfBEWJGzhatQw2kAqw+W6NBWMQb16uZafiBwmb9KUJQrgnfpLcmcCldkSQOGfnC7hRT
	iutw2MMtA+O3h5eYPYLZOMQIUd2bmws0FtBd+7ghQmAi8P7fbeLRtPlT1WxT/4d/tHgycwT5dUf
	mONuP1v2bosOHBi19cdrF17GtYh3zMT48KJWB7LvnsC5bnIeJsDe+8UhysHTvPJ//xYQ1A==
X-Received: by 2002:a05:6214:2a8a:b0:6e4:2e03:c54c with SMTP id 6a1803df08f44-6e6aea324e1mr22692966d6.10.1740173927467;
        Fri, 21 Feb 2025 13:38:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHH7bR1yTZ+s3Pcg5KBoLzFiK/8eGo0r93T0qBxtQINa0jSC0PQxR2KObfPhPcHklFloCVexQ==
X-Received: by 2002:a05:6214:2a8a:b0:6e4:2e03:c54c with SMTP id 6a1803df08f44-6e6aea324e1mr22692816d6.10.1740173927166;
        Fri, 21 Feb 2025 13:38:47 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb98ed07afsm1067043066b.102.2025.02.21.13.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 13:38:46 -0800 (PST)
Message-ID: <626ee5de-ab07-478f-bf10-983a9a321570@oss.qualcomm.com>
Date: Fri, 21 Feb 2025 22:38:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: sm8750-mtp: Enable ADSP
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Melody Olvera <quic_molvera@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20250220-sm8750-audio-v2-0-fbe243c4afc3@linaro.org>
 <20250220-sm8750-audio-v2-3-fbe243c4afc3@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250220-sm8750-audio-v2-3-fbe243c4afc3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Imy-TVoxgoYpcF_gbnJRYvGH5GAR0rtu
X-Proofpoint-GUID: Imy-TVoxgoYpcF_gbnJRYvGH5GAR0rtu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_08,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=573 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210147

On 20.02.2025 9:49 AM, Krzysztof Kozlowski wrote:
> Enable ADSP on MTP8750 board.
> 
> Reviewed-by: Melody Olvera <quic_molvera@quicinc.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

