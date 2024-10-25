Return-Path: <linux-kernel+bounces-382269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8BA9B0BA5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5E51F28973
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B44216E11;
	Fri, 25 Oct 2024 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="laH1Psab"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC302216DE0
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729877034; cv=none; b=J0VbuM7pHHv0MKyZdhx6J7PDgV+ATyhh4EK3Vtd99nlkzOvgYlXxpjUcBNmqEdT18A/MfAc70Kdpt1gM5ciO17GqPsMMtDf2t8Eaewy8NB44dW8aiJMW83zSJq3w56DRHo2fIHVCok9iVEMDvp6qg5C5vRAxstyoSirJFRYmQvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729877034; c=relaxed/simple;
	bh=tVjMxkeuoLbNCiz5dienRRdA3e+jQoW27GPSNdliseI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJNFF/1EPzFTGaWDlVOb0Lwyx/qs7hhTPVHbSxvDhwJeNiSTUrch19WbkRjv9Kw5VFtN3V6FHvKELYaxHIC7iUcZOQ9GuqRjkSaOm5CVi/HHgpxjfZFL6JWkDaZ83RzOuuTSr0WvyMWGzhJ0YKMzm9IbSlVfaHFj4shr8ntWPzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=laH1Psab; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PAn2b2019397
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GGGNwzfw/zAdzm6vw+C/U7FiUNzebOvXXpb5oeva9SA=; b=laH1Psab+pd3c+Is
	GjA3b8PJlx5Er7rrp2hfX0czFl40XQ+JB48hwxHL//i+CwwLJ0WNJ9VGvhY27moD
	CqVgcF51dp/WWSJx2f6mB5X/TcQY7OF4py3/t6gbpF9M3/mfkUgn7v/UpIw9IvkU
	crtQHDD9jAcWtEmHdX1Wi3mKWKzRF/R66bhg/9mmTJhYTHlm8azZ89MP5Ch/VooT
	Ac3dTTKCv1sZq65nor5kM3GOoouhK21auwz2tGXX5hMPKj+9tcM6w3CVV+3X8tKZ
	k9gzosK7kBnzr+R+g2L4xt6ZdqwKfldUWhZxj932rhRjlAlW4roY7dd9Yin2c+h1
	aGefnw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3wj0gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:23:51 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbccc4fa08so4034016d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729877031; x=1730481831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GGGNwzfw/zAdzm6vw+C/U7FiUNzebOvXXpb5oeva9SA=;
        b=Ly7OztkJ8nCm6VMgmIYuKMhNA/2N2POja0LbvLyZhAa/vEl4EYEu3yE8t4D7l5QBlB
         CnMZsFIT0+A0khRqEB3yVj6wDxiexHD3tb+FetvW54OrTZsGlAZz4Ta/qreiml9LUuXj
         FYjmZ0unUs+56ZoS+aNrAB3s1GEzmoj/o5pE5zpqya+50ynRFYHdJ6kVTPztqlf2kkN/
         VUIAHK10IgTvDBCq5sfc9jk/jtp+NJjY8K4h3tXODjQxVmzCvzPaO//R2dZ2l/Nv+a5v
         TBo1keY/owlQGZcF6kIUAVS3hbsuT++/TbMx11yVklbYC2/UmpGo23tUhbgWWMLjcLQx
         CoJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+Vj2Kpp/IkCmLFM9nNJ1DXYQq0o+LglzzcRuowAgVFTU0X2EZpCgKroGrCq4NEnuJ0H7dPsuHis2o9eM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Oy88oW1Pa1Jvrx43MxHcN18FBM0xmQF7sOVAa7oTte5Onm5p
	6Ue4Fdo9tmaftsDMlr/LeoAphuSbadAb9dc71a05K909dQLC0vmgUhwvFOqS95sBRGJUjxF3J5+
	uDLRFIvZLAx+rlzZ6GKTM0XYHOte8KvHBwP5Cw7UeKbP59DiXcw7dP94bHjPwDk0=
X-Received: by 2002:ad4:5aa8:0:b0:6cb:fabd:b12 with SMTP id 6a1803df08f44-6d18558937fmr1708526d6.0.1729877030740;
        Fri, 25 Oct 2024 10:23:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHJ1YuapeN8DAQSsD35vOkggkedO7s53T5L+XAzO7S8IU6jnNiaULiNK0DQhzH4JNwso1Sfw==
X-Received: by 2002:ad4:5aa8:0:b0:6cb:fabd:b12 with SMTP id 6a1803df08f44-6d18558937fmr1708376d6.0.1729877030371;
        Fri, 25 Oct 2024 10:23:50 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dec818bsm93040666b.17.2024.10.25.10.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 10:23:50 -0700 (PDT)
Message-ID: <7620b929-dbf0-47f1-bedc-1ce87bf6e988@oss.qualcomm.com>
Date: Fri, 25 Oct 2024 19:23:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] arm64: dts: qcom: sc8280xp-x13s: Drop redundant
 clock-lanes from camera@10
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Depeng Shao <quic_depengs@quicinc.com>,
        Vikram Sharma <quic_vikramsa@quicinc.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241025-b4-linux-next-24-10-25-camss-dts-fixups-v1-0-cdff2f1a5792@linaro.org>
 <20241025-b4-linux-next-24-10-25-camss-dts-fixups-v1-3-cdff2f1a5792@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241025-b4-linux-next-24-10-25-camss-dts-fixups-v1-3-cdff2f1a5792@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: cc8Qp2ymsiyh7Vjv6JuLeYu91Emu-M8Y
X-Proofpoint-ORIG-GUID: cc8Qp2ymsiyh7Vjv6JuLeYu91Emu-M8Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=866 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410250133

On 25.10.2024 5:43 PM, Bryan O'Donoghue wrote:
> clock-lanes does nothing here - the sensor doesn't care about this
> property, remove it.
> 
> Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # x13s
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---

drivers/media/platform/qcom/camss/camss.c : camss_of_parse_endpoint_node()

seems to reference it and pass it on to the PHY drivers

Konrad

