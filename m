Return-Path: <linux-kernel+bounces-382433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE78F9B0D97
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1DBC1C22BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F2520D4F9;
	Fri, 25 Oct 2024 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f+3JH4aM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAFB2064E6
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881729; cv=none; b=hXOMhBw08UKNf4oopIQakJrcGK/0qFIcRmiF3knsI3XV3bur6KjlodfdCSgbi8TDfQ4nVRCtV3ygpavE8TlCM79vaA+kahdORwSNrsn4N8Cz5CkESPbRGysUQTbjycbitqSiCaUgldC6nS9gqIRRJgQvC+sm9LVCFoySG6juLsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881729; c=relaxed/simple;
	bh=M5VYWMFQeK8U6JBb1z+bQr4mOznC2Me9nRhBWVcbFuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvd8bIQQiyGuH8D1dCFNvoQn5RCHnJzjy2jHXx932Jz5qK7K3HQdSxY47ISS5LVGJWFhbxnjF4XQV1206rej+QRjUZFGVurntXdrixjuCmXh4ZfkFU3+A+UwzO2jI5POMRJ2hABF1000zjsa2C75V7cDxriZcAjF2hveF+lqwO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f+3JH4aM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PBT7mg003677
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DQ3FRvP1Zh0KKe4wQOOkZ4FJneCOv5bCiWn6Di39QG0=; b=f+3JH4aM4W4xqfUU
	NkL3e1UnUsJxQAz799JKKH4VU38vbdDeCGYdluoH/jsL2jvW6CivWzqQkjGTIRAu
	6H5JxgcFtbqJpVwALbd7yns4eZpl/R0YQuu0utUxYsOoy3L07+Z/yki+ADYOWSqu
	jnkiU+39UlSwNKSaFaMhrzwkuGyIba70Jv4SaU6Kw+Y8cyLCU7IUtSzp5ItI+54c
	F52wyIDvAk48m4yIQ3MbBw2dbQ67MDcFN2KcHyMraVlDNPaWJ8Q1RHMTbPOsCpfC
	QMWlK1miyKsSa0JaYNcLyBT7/xeXOCMVl+Bb7gb01LtrYUAqwQBK5Je+O+FxyCDh
	UcYsjA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em68a3jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:42:06 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-20c69f3e765so3257305ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729881725; x=1730486525;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DQ3FRvP1Zh0KKe4wQOOkZ4FJneCOv5bCiWn6Di39QG0=;
        b=jsXIcG2TEuFr6CKw7nOj4taPvRnEvFwHa05XJqQif52Lym0jYR1ffqWVJGXb1+lpre
         Urve956QkwTz6ZDHjGwNiPYxzHobVH9L/8iBz01XAMZhBFLqAC0mlFhyDcZigMO27NqA
         HgWguGrYV5DH0NmX4uJm9Kk8bR0ux6HFsnIN28x/KjDbmHSVgRNdE8Anw3W01geuMzZW
         57L/481aSbFmzFm0FzfmHUHfT8fkQWdkQ2aLK6TZcuEIN+IjELBsYg7fxq01StpcP7yH
         S/7kj+sGEqebN8+6n7uZe+cMqpplFmbeF6wS+siQIupnk8+ZV/4Kxh4d7sk/ez6bay1/
         eTQw==
X-Forwarded-Encrypted: i=1; AJvYcCVBETm6I3ub+bA9f6Jv70Oc7oLH+PjR7SRedUqMXqmul1R5MLUYLqrnVB6XF0hge7sJBebq9sWRXIGu1y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTOliuFenkuj48NPhfC9EutiLfUc4TE4/2qZoduFydePzpeqS8
	+iC2a+fu45Qqyb+ZJSVqMpfCfMQCIGBFsYuL67LG/yjjCxpjREUAhw5FiPVpp4dpyI5cYc5mkyi
	84Fa/uA4vCMbWR0mPj2WcAtPsFGXVEVmYPkarogHfYt7IRx27Lt9O9Lob7MQ0Q/k=
X-Received: by 2002:a17:903:234c:b0:20b:80e6:bce6 with SMTP id d9443c01a7336-210c6892c0fmr702375ad.4.1729881724867;
        Fri, 25 Oct 2024 11:42:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP+EmOV5oTrcfqt2RNx6qYSpSQtYrLfew1alsayN6FOtidh3t+LdPrNE1o9vsl++499tZU5w==
X-Received: by 2002:a17:903:234c:b0:20b:80e6:bce6 with SMTP id d9443c01a7336-210c6892c0fmr702195ad.4.1729881724520;
        Fri, 25 Oct 2024 11:42:04 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f2982c4sm96514366b.102.2024.10.25.11.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 11:42:03 -0700 (PDT)
Message-ID: <e810ab3d-a225-4c85-a755-3aa18c311cc5@oss.qualcomm.com>
Date: Fri, 25 Oct 2024 20:42:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] arm64: dts: qcom: sa8775p: Add support for clock
 controllers
To: Taniya Das <quic_tdas@quicinc.com>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, quic_imrashai@quicinc.com,
        quic_jkona@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20241025-sa8775p-mm-v4-resend-patches-v6-0-329a2cac09ae@quicinc.com>
 <20241025-sa8775p-mm-v4-resend-patches-v6-2-329a2cac09ae@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241025-sa8775p-mm-v4-resend-patches-v6-2-329a2cac09ae@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rMGZLm55t4NFsoSDhFb5XyMKiG8yaFNZ
X-Proofpoint-GUID: rMGZLm55t4NFsoSDhFb5XyMKiG8yaFNZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=831 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250142

On 25.10.2024 10:52 AM, Taniya Das wrote:
> Add support for video, camera, display0 and display1 clock controllers
> on SA8775P. The dispcc1 will be enabled based on board requirements.
> 
> Reviewed-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

