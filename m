Return-Path: <linux-kernel+bounces-555764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB49A5BC7D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 527DF7A631E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585D122DFB4;
	Tue, 11 Mar 2025 09:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R8JW6M/K"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86F122B590
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741686140; cv=none; b=us33nGYsvvYi/FQCd5/Az8DJ2R13m0jjTJZ/Ur1oly4u1p4bbtqfRin5fMzxuTRX4i6XX1YOizN1kMvSWHfA7VnnK/R+8EnlqFGKu0MYp3gma/8CrxhOTWgm58TD3YqQJMVMylv+dn59LL0hraqGCUHpDGrhx7fFtqpHgZfaZyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741686140; c=relaxed/simple;
	bh=6G6q9gJE+xvV3I97HSJ4wqR6R7EQnz4zmkCtLbU3u8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JwJKjN/3zZmPgn8bQGffKsrK8j5vYJTqrvLydOjoL4vO6t2mRJkuuAS/uOGA9tleF7C/UnsHoy1rNBLmEx0uETtq9gKuuLfGySYCxktotgb0NbqcPPXWDu9M8+c1Z8UDhw/r2T62S2mT2RweZ0U82RX8ySO1uGbDZjIxVySlPGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R8JW6M/K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B7iAjI029395
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jLmEFyG3LTIS/8bd0t7FZ5xsj2uzD9vnCxgeQMsx2zY=; b=R8JW6M/Km9+3D2yt
	U5m03KYMgJEVx+EdhRU/jwhD0Tq7GY20BnJjfEYNpPfJ1mPZ6T+Gox91keNRBQa3
	jbEAmgGnEGICxwSAkR4C4kk7ER0IGsr6jfDKlB4KtJ8fyZ9lEpZeo7K5AZhQlsG8
	EnC8BENpjx/3Nda8xExLwiiYbOj7NI+SHZ7p8YE/SNMYC+7teCz4Q3Kg83vrGkMz
	Gh33SQ6JNSCaxbbuFtCkxgVcagQy2JO9woK8u2+/mELTTX4cCDylpkwc+2q7ZPKi
	EdKuJ2zO4YMF3X0FG3h5Ivs33QrM2IcJLQ0DLk6uvXo6yCw8Cpbwb75sU1Eq31QS
	cT4cGQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ah1y8bnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:42:16 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e19bfc2025so13934066d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 02:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741686135; x=1742290935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLmEFyG3LTIS/8bd0t7FZ5xsj2uzD9vnCxgeQMsx2zY=;
        b=IY3wqPfJPQjtOQWnR8KtLO0BfGB+sxBWEPUWDdEqWLAV0bI/0D/2wBs2aqFmJUmfbw
         GlFUYnWf4wHpom5F7bQ3qrVzvYAEzh/xGv+Ua4j9DnMjpocgvN/+EbHw/lXkDu1fFccj
         SC5A6URVN9N3u9lZl2NbessAp0sRg7slMzlLXeK2bIFgc/8LY5GLG6y/mX1t52s0erZK
         JrJjRrcFdKc9VFfA7UyG4MRbhu6ZEAy2s7psx27CghDF+KxMkR2pJbWE7HbQvCM9tER8
         zpziOKFGZ39OTHdJM2jr4ucrQO+WFgXBsLjiT2K/VrRmJPioQa5WK7a4H1qp8zECLAwa
         c6aw==
X-Forwarded-Encrypted: i=1; AJvYcCUiNCDH9EQz19Qme9e0pc3S3844hX+mYoj5YBxWfA/ZxIA3itW4WUHLB6de5EbD1H9HAWD0QQH6egCyZTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx601KrjoIUY8dzldGUH95akpOVV5U56ti+A86tWV3Pgt/tUJT+
	ROBU+SWlUBLNpnYM9GNNwH+afy2Jq1MgAKakAb96qcH7mJ+cgDSNnc6PJU1jyDX8DOEmoxJzPLa
	NyBQmvn5mYBy5aNA4ZdIMgkAN7pnNkojQUMHY84ytndN2bMDVHu0h4gqTgei/c7g=
X-Gm-Gg: ASbGnctGPnw5jao1J3B+mpe8tqBymDg2yPiqBEDRrSSyp9CdKp/WKe2fVP6eDCTCABl
	uVfMsTBrUQOl5vD/ocVBJYdVWX5uNTlyMmoGDLRk3tGak79dDsVaKLRqqFeUVU1eKKqjw+NHQgU
	poR3FEIS4XHvzBTgCPg+ahzOXssKfgFBDikjNws3pL/6g5NhuJ67oahHsBSiEPK7xu1Spcu+p9j
	2O7knvVeTzg7M3lHxcXpE7dFh2FiqwPdDwP2yu1IxbEQ+C9fgkfo2Vh0PwZtWk+aR5v7CB6c6MI
	nWe0vQ41oFjXfYLATQTxkgEmkl8ZaLkwF9bWNaWEtsR4c+NWWu1JBKb+ufGAcl4fF7olYA==
X-Received: by 2002:ad4:5bcd:0:b0:6e8:fe16:4d42 with SMTP id 6a1803df08f44-6e908c726c7mr74383966d6.1.1741686135467;
        Tue, 11 Mar 2025 02:42:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGSytYD0gUExD8i7pJCZHGU18JQpmW4aJe9Ty5cJD0CL5USKGnlHQQ7o9cBjRcodkWS9b6EA==
X-Received: by 2002:ad4:5bcd:0:b0:6e8:fe16:4d42 with SMTP id 6a1803df08f44-6e908c726c7mr74383746d6.1.1741686135118;
        Tue, 11 Mar 2025 02:42:15 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239438117sm882353366b.26.2025.03.11.02.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 02:42:14 -0700 (PDT)
Message-ID: <e73b3666-9f1d-40c0-afd5-5c0c83771e37@oss.qualcomm.com>
Date: Tue, 11 Mar 2025 10:42:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: qcm6490-fairphone-fp5: Add touchscreen
 node
To: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jens Reidel <adrian@mainlining.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250311-fp5-touchscreen-v1-1-4d80ad3e4dfc@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250311-fp5-touchscreen-v1-1-4d80ad3e4dfc@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2I-BPvHXRfxEDYX7WzlAbE4tlWI6Wsm1
X-Authority-Analysis: v=2.4 cv=aptICTZV c=1 sm=1 tr=0 ts=67d00578 cx=c_pps a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=8DUqKY-xeV0tu31MSWsA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: 2I-BPvHXRfxEDYX7WzlAbE4tlWI6Wsm1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110065

On 3/11/25 9:23 AM, Luca Weiss wrote:
> Add a node for the GT9897 touchscreen found on this smartphone connected
> via SPI.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> The series adding support for this chip (incl. dt-bindings) has been
> applied on 2025-03-10 to the input tree:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/log/?h=next
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> index 356cee8aeba90e21c11f46df924ed180bfce3160..35ce9dfca6f092a88d8873673ff57b591e210b02 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> @@ -1069,7 +1069,18 @@ &sdhc_2 {
>  &spi13 {
>  	status = "okay";
>  
> -	/* Goodix touchscreen @ 0 */
> +	touchscreen@0 {
> +		compatible = "goodix,gt9897";
> +		reg = <0>;
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <81 IRQ_TYPE_LEVEL_LOW>;

interrupts-extended

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

