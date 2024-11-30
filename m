Return-Path: <linux-kernel+bounces-426292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640059DF152
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 15:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282B3162B47
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 14:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746C519EED2;
	Sat, 30 Nov 2024 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RJgJy92+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958F54087C
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732978317; cv=none; b=qJQ45HJ9e8T4grzfiLPxDS6ay4KYvfG3bYmZu4qoy41aQT/czD1YekWUvUZPOHO5417o2WRnFNpFOv8TbNS0gQObOXJp9YcstjzxzHb9lX7UtvNDAmODWESxrNi8qBaPyt4YTdLZfY1OtwVGZluZjVXOQsWH97WffUdKsmudJ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732978317; c=relaxed/simple;
	bh=MfaGnELOaQ5gOsaPvyuhIsLmNcOCwrCezmTYb1mno9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P1J5G+G+x/gISWlqxQsCgdHWgw7DgEIjGaYJ0TreC6DLoqoeoSiZUynqKYeBFi/gZoMGB5Rdi3B2tFFQHcktn7tHx5G1Ci7K2xHrYXuHJ6c/7EWuMC4IMoHPyUI/OdchD/cjiLqDqtaaYRPfpL5M6+MZTFNnL5VWI3oRYgqtIJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RJgJy92+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AUC0lUb030874
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 14:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WwdVUV3H85bPaeLC5AvA5iZ5iMUqfV8KmmDWPe0AejQ=; b=RJgJy92+HLpqVydl
	Jnc7cTYnPCxiQ6X26t0WKagFa9pZd+oJwAIrpqLji5jgZM5oG+UHd5FnbDvbh8Vu
	JD2nc+nZ2sDGxWGXfsoDXDIqdYF+IOGwbqqPdnNc76XW8kw4ZXb1Q4dZu2pXG031
	1i+18TgIr0qY8bOsyjShCLCyeU3icKDs0HxpK/g0OvEOhCxzR70kAlVx+6Uhj1GY
	hC03s2WtUYTjr+c1Qm885yZTkpUzw/bv5aoCmnJDbfYGHn9m0ANfqOlWp5W2/cl/
	M+rT3ojW8e3uHMN/TlfOTqAXpLebljCHkfi6VC4icur2jh63chKHRuyv21DD720J
	8AqXLQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 437rde92w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 14:51:55 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-466d3ec228bso2406071cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 06:51:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732978314; x=1733583114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WwdVUV3H85bPaeLC5AvA5iZ5iMUqfV8KmmDWPe0AejQ=;
        b=tnFCBZqOhjuc9en24BkmXQhkYxbaa9begwgJDrx9pjKc7b4Wfpe/7qhX1tbbErvhdR
         w5ken5oG87yVK8q28W7mBkFHzR5QmuoJHd9IzklwSKUdjYTpK8dQUIrFPII2E6i9w4st
         pieTwbBZVDOOl4ot9tmt5Xoj1L61MsynmamRgLVQGZgc6gdKRFCEbAJh7XY/5x/aha0l
         U4PRVdK6O5+ouyB7z4XWx6NTacIz6hTu0gRzi/thA4ZsQ2sIYXW+5JLDjMbfauH+u+EQ
         vBOI+yHAduZsYUOltTrPxmOWDzlARWDtrZ9GlUBqboXtoNpZlUut5ruLCEQfA9Z8Y/ec
         GuoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCftshY/anKHgcKuArDMvWP1G3aVLWc7Up2BirL1WZyoRE/hAlYXIwo2xJwgtJweiY/7Hn05N8Q5lMsNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfB4WeH+vIZ5FInKPlNsf6tihh0scezhrVZTZt8cAHe/x5h23N
	SVxKFwKPfq2POMUm3U7/0NrwPzPgnYW+ezmpp2QsdC/u2mAfw9GyjgbJL2yf+a3xXQ8/OlIP+Ak
	2352VjhURsr7hQ6HRa2L5U5ksDSzOx2erjPGzL1GdGhRqtVAC3pqBzj/vQs21Zok=
X-Gm-Gg: ASbGncuB3XWR5oCIa2e17kmTIfYVmVKW6NdowjkWVPFy0jEkXXmFdvZ5krCRPVSxQie
	BEIDuHlIEDnMJNvrHzA1+Z8uh5sGDDnpgg1rc5bbR2HQZB3/hn5DxAWVWs9q0Y5uIIZgHyUBmnv
	OGNPyByQteBDg7ubBb2Ir2XpBpMba1FcCmei+cHwDK9NUw9iizcy8IoEWQ/9MbfgpBB5ua396CW
	Aa3VG1Pbhwj+pzzJXoUjG9nWRK0w5iFJHTpqTfcKE+cZzsJvgS4yVUc2WDFNh1rvqepXKUSeHt6
	MnCO938HSd8vG5FvYH0E4PI7YZ8ijWw=
X-Received: by 2002:a05:622a:54b:b0:464:888f:aeaf with SMTP id d75a77b69052e-466b34b7946mr105027401cf.3.1732978314389;
        Sat, 30 Nov 2024 06:51:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdstzmdIicxiEtW5GhGF02zRwFODG+w6QXwP6kxFCd68zCj4hbtp4yiYHjjDbGlXKe/BYeyA==
X-Received: by 2002:a05:622a:54b:b0:464:888f:aeaf with SMTP id d75a77b69052e-466b34b7946mr105027271cf.3.1732978313957;
        Sat, 30 Nov 2024 06:51:53 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59991f0ebsm284508766b.159.2024.11.30.06.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 06:51:53 -0800 (PST)
Message-ID: <206e1dd4-7e71-4e84-af80-19a0d448b469@oss.qualcomm.com>
Date: Sat, 30 Nov 2024 15:51:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] arm64: dts: qcom: ipq6018: add LDOA2 regulator
To: Chukun Pan <amadeus@jmu.edu.cn>, Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Robert Marko <robimarko@gmail.com>
References: <20241110140019.3426181-1-amadeus@jmu.edu.cn>
 <20241110140019.3426181-5-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241110140019.3426181-5-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ctk3sCXDPS08SLlaht4qnFWiy_s3Oa-f
X-Proofpoint-GUID: ctk3sCXDPS08SLlaht4qnFWiy_s3Oa-f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 adultscore=0 malwarescore=0 mlxlogscore=968 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411300123

On 10.11.2024 3:00 PM, Chukun Pan wrote:
> Add LDOA2 regulator from MP5496 to support SDCC voltage scaling.
> 
> Suggested-by: Robert Marko <robimarko@gmail.com>
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  arch/arm64/boot/dts/qcom/ipq6018-mp5496.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018-mp5496.dtsi b/arch/arm64/boot/dts/qcom/ipq6018-mp5496.dtsi
> index fe2152df69f4..0a57e1afe218 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018-mp5496.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018-mp5496.dtsi
> @@ -31,5 +31,14 @@ ipq6018_s2: s2 {
>  			regulator-max-microvolt = <1062500>;
>  			regulator-always-on;
>  		};
> +
> +		ipq6018_l2: l2 {

s/ipq6018/mp5496

Konrad

