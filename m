Return-Path: <linux-kernel+bounces-443689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC099EFAB3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71AF1717D7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041BE22F386;
	Thu, 12 Dec 2024 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FSm+w1dk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07E722FAF8
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734027024; cv=none; b=W6LvBbUhiCX33W0UWlULBtC+qTgpCwAin863Bs0PR6MNU5zJ7ZIiZDnx7OFQb04JsKZjMp711vrtSOiB2RaeOV5BhKsz/EGjszwL+0KYgHLLEid+4UUMVtHz28VJ/p1dnpJqDr7eT62b9jhwnkgckQr+dv6u7yGl5cQOtHIJiNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734027024; c=relaxed/simple;
	bh=GKTTcjBEeSZeiJ8bhEH8F3E/pS+49HFcXCQMFH/dT18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yk3KN6vAvwM6gSssG8evOrY/CbJIlID2NksTGBKn8qx3W2GhrE5VEGGtQsrWWcJaqJF0ZYaDydhZDinQBYh46/PUj6hwZnn9L1TBkpfkpQRrJaO/0b4+fHfaOMsN5pi1BbX5nHimJNp4z+kNBiBGE4MuRhneGsXKmvdpuTPGBz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FSm+w1dk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCHfH4t032215
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1FUj4soR9AUdQNld/bQSRsXn0FXdGtEai1ID/hsXUIs=; b=FSm+w1dkopBbf24N
	Usx1iuGq1pEPIzeeGMOJy+2WVucPFNPCy4ADjB722Yge2kZ1wtJ97zmCaBKGJ73d
	3D/9cZ1q3JKcUwPtZcAYqLdEimB6KQV5RE0ZHQeKLcoCgrdM/oanQTQweZe7eb1v
	LzTLgHgSlbMBqoYvYEuHiJPlk1v4mffZEZey8XtkzIVnX7bK7k8K23XuhNo+bREj
	FXvgCsIOHBIGqD9BCht4IqIvxDl8Y8+cJpA6ETaj8akLsZicjDdG02xMGsXI0GNi
	fi+x6xoaX+cJLvDiBCAKFSvWjezuL+lz4ZGlYD5YblFCDmesETeK5khEU+oc2HM0
	kv82fg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f6tfd3f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:10:22 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4678aa83043so2235291cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:10:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734027020; x=1734631820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1FUj4soR9AUdQNld/bQSRsXn0FXdGtEai1ID/hsXUIs=;
        b=Cd4ekI5j0DaIWJI3EvkionBoYbvQmZAc0Dms/1tL1wfhoS9TrSJFIGLcNjQ9qYZrb8
         6BN3OGv/LOTCshebK9i+ST2GDKR6WbUUI19LSMbl4nWGEwNGSBj7PruYhlNfV4PfVe0w
         +lHxo8mFcV8rF3XMvY6bTniHTQX0yVd66s3WWVXZt4R+AS/qxjchZgLCYGMXKLK907Zt
         iamkgI0WWW8WIDVlUi17XmlmY+H45n3q1X6pSUOiUbk/x953H484Sq0v5miKL7CJ112t
         +Ck8oHO9WwXIA0TVX9CnN77V9kr5AHm68EcgvJ6toP4dOiFEhTK5SGHDXq1dxF+x3wRm
         qztw==
X-Forwarded-Encrypted: i=1; AJvYcCWyvbAztw7Xl3r4WoC/kU9+qRcc0QGy2F9cAWUhEzbyyjlLJtg36r2ol+UWhiao7cuCemiBh9BCueqqCr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDSRNJM0aMgL54bnpOT+A9Tw9uKMpV8loZ2lqBBZRsQdHM7XSO
	sSSWH/A9L22CBaxgM5khh+Oq1N2K36icyEQGsezXjabNmT2C6Udgbn6szPtjM8cdExQ4sz3is4V
	t98yPA/hbXfesI+zxZTbUGnTL/LScIzA6NstKfvYBQcmdkATL5lEeENSlErubF2g=
X-Gm-Gg: ASbGncsG8BCHuVMt2lGyM8FJuEbgm9Fs4b3lGNPMoUa6XZyyKdOTFL6M9/xCnySM1FJ
	SDwNA9aRmOlPIAFmpQz5l/2XTTnHE7OhUxVssb/YQ3rBcCg2Ntboq+E764bZNI+aRoMveS74Yye
	SVPNrvdTUE25usbWkHES1etIfgJmSUrYGSQSupaTFLXviXWzyM8CH/InN2GdWWdP9CZWNSQCD7K
	rSW0XxviqBLc4B8B7YW4J05qAs7r9G2118kesw2giBlhJVksSx0NPh55JwSxatW/RE4PMczlh18
	Qjl4BfC8a1HDksa23olfCQpqylUEMI6rb4y4zw==
X-Received: by 2002:a05:622a:4d43:b0:466:8e17:cd1f with SMTP id d75a77b69052e-467a14eee88mr8694391cf.3.1734027020465;
        Thu, 12 Dec 2024 10:10:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAT0Dd8qrNs4/u/0d7kMCEBVCHLFMIYx3vhDAgJhWDhv8pg0Ug+v3gzjuOU/R0oQ+mXU1aQQ==
X-Received: by 2002:a05:622a:4d43:b0:466:8e17:cd1f with SMTP id d75a77b69052e-467a14eee88mr8694141cf.3.1734027020014;
        Thu, 12 Dec 2024 10:10:20 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa66b96a249sm771327866b.159.2024.12.12.10.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 10:10:19 -0800 (PST)
Message-ID: <5943f27b-1123-44b3-b93d-56fc45512d3b@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 19:10:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: Add support for secondary USB
 node on QCS615
To: Song Xue <quic_songxue@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
References: <20241211-add_usb_host_mode_for_qcs615-v2-0-2c4abdf67635@quicinc.com>
 <20241211-add_usb_host_mode_for_qcs615-v2-1-2c4abdf67635@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241211-add_usb_host_mode_for_qcs615-v2-1-2c4abdf67635@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bHhPAmTTvHJKFZwqFXg3AL2n_gQcJ0Pg
X-Proofpoint-ORIG-GUID: bHhPAmTTvHJKFZwqFXg3AL2n_gQcJ0Pg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120129

On 11.12.2024 9:26 AM, Song Xue wrote:
> From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> 
> Add support for secondary USB controller and its high-speed phy
> on QCS615.
> 
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> Co-developed-by: Song Xue <quic_songxue@quicinc.com>
> Signed-off-by: Song Xue <quic_songxue@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 76 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> index b8388dcca94cd8f4e6f1360305d5f6c7fff4eec3..651c6c8b8bc40886139fa235874e834928e14e77 100644
> --- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> @@ -3079,6 +3079,20 @@ usb_1_hsphy: phy@88e2000 {
>  			status = "disabled";
>  		};
>  
> +		usb_hsphy_2: phy@88e3000 {
> +			compatible = "qcom,qcs615-qusb2-phy";
> +			reg = <0x0 0x088e3000 0x0 0x180>;
> +
> +			clocks = <&gcc GCC_AHB2PHY_WEST_CLK>, <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "cfg_ahb", "ref";

Having this be a vertical list would be nice

Nonetheless, this looks good and the magic numbers all line
up with what the computer tells me. You may want to check
with Krishna Kurapati whether snps,parkmode-disable-ss-quirk
here as well.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

