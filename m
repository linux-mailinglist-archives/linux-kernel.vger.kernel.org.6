Return-Path: <linux-kernel+bounces-421337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 814BF9D8A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0D59B45520
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFA71B4137;
	Mon, 25 Nov 2024 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N0kwbz3y"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35101B4F09
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732550126; cv=none; b=UlHZ3BE3JPH5tqEvvI9a+aNH6C9zODs5t5ECd0guatrTgcUPFNNgYZl4Zm7In7gF2fb7ypwfPJaiQypRznf8bOxja68CRZLz7c0d5Xrvi1W9i1yS7dqKORpSeVVK2RzeRZz2Cy4mDMNfdklRkyigVpZtDpOzjNefqJb3vYw/3DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732550126; c=relaxed/simple;
	bh=iw+rPfggrY5VC4rUJfukTlhjBi05xw7ms9YCcpumBQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFgX6ebJ8IogKxHMf4mqJHiFaN5/TkwYErBOlUla5+dTJCX+3U/Muy+JjgyePsT5qzd+4Lv7vQk1d3NaVAl4kkP/UXR0Dhjt3cY9f5Z5MuTtd5JWC3k53nxle96HE1mNcpDz90z/8rwfIM3mR0LC/iYYOz1Wp6zwOKB8xqbmYGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N0kwbz3y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APEAVIi000847
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 15:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wOGRZpFoHgxved77btthetZSo7CITcrNrmZpFVCz+PY=; b=N0kwbz3yQa0D5wBe
	Y1XY3mLBumti9Np4GsU6E1NKNxq+pvlHnfHb2ur17ld8kMeivjf8XK8e/F31bl8b
	lJTiZWOJpJ+mK5BzvPDhIUPTSiu+TzsPRNgHN0UHFWNC/uQiQOY5z3OdMbAh2YrH
	eDegIpTTx01YR29o/u6ori3Qh6QbYgOI+QvQ5+QM9tkJ43HixzkkPB4fCtQtFSEY
	q/t9T/K3I9U5rLtkxPNmpUFCtWUjOp6DMVYe0E7eweCUhV2rL2uMKkghvA7U3p+W
	LraoWnc06DEsbkmQFBZWcECs8YT/JYYShviDW966JtyY3KcBZb3c06CC5Qhk+CWm
	hcDaFw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 434ts1g9dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 15:55:23 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-460b5727217so6924971cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 07:55:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732550122; x=1733154922;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wOGRZpFoHgxved77btthetZSo7CITcrNrmZpFVCz+PY=;
        b=WWKaoyUN/q2fRSadNgc0GCJzw87erWdDrzYju6JKaiLJRLyLTynwuPR3Ei4Tl+uXmf
         REBUkuygQ8Uu1+1P2CfxJ80D3FC59swqxldgEvdY6HNdYyIcRy2GpCF/6UH7lnA37/qJ
         MZM5BWxEkMxre4G/U6O+NhqGOuGMb0fKftzAixWfWq/J11Jtj1u/WSSFWMQQWRh39icq
         BLwi6Kd1m5zs1hFyDVEVkeWgqVr0v2MxaV1pfd2K0vwnF2B/Tdq4c6QkxssJ0X7cHydD
         JhMkGmr6nRJ6ysBZ+HyMBP8HDOMySjnX9qocACrGUgRpN98GUkUohkYX4nCR0+YaZhVp
         iYrg==
X-Gm-Message-State: AOJu0Yz8k4T3rAryV6CCWbrYSLvTngRSL5hl6Zpu3m2kc4sL0XbS1kpe
	WAAtkWcDpPzJjjubxweO9Jgil2RwKEEdT1V5lRwoEjl/8+S/qSNfO3Rg6/DGLftGWiGHxDStNVl
	9nLzWcE/wZ6qeRIu9cNqZjJswJZJf4ZraG0s9nnoORp4g8+TO4wkvLu6lbJfWPB8=
X-Gm-Gg: ASbGncvGIBnpeCW1bcIEWjMTajL3Uldic6SfguGHMd9oA/3/2KdqXXvxbDUEFu+RSXP
	tp8gRo/6zK2L9XNBTXjgBMGRFqzzgGwmnYVj/nEcwjuOVLWV3MhSeJ0ZnCLryPRhbz/+4TpP7Ie
	6HMzfBwicW2VuBw5bROV3yzBPkxfnUv1yFZbYuJ5Vuvo53wK57+bLjhm/rXhFIb6sYphs8BV6pG
	0dwtzkpjozSOwSk7Oh7JQYOKnm3EH8jNGvMpKspMNhkpdwgYawEtyzMNYDF9GTQ2JewL3/3Xoqa
	QBJlT+XSXb5c5UQDQs5Jk3GTdNG1b2I=
X-Received: by 2002:a05:622a:5a88:b0:463:648d:56 with SMTP id d75a77b69052e-466a1631b99mr3846471cf.5.1732550122517;
        Mon, 25 Nov 2024 07:55:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvYEgygVYS4qX3kr5MvnR4AXZaywoeI2KXLjKEA9NYyrbjDttFDrc2jND/pxdsEt55oFzgcQ==
X-Received: by 2002:a05:622a:5a88:b0:463:648d:56 with SMTP id d75a77b69052e-466a1631b99mr3846321cf.5.1732550121992;
        Mon, 25 Nov 2024 07:55:21 -0800 (PST)
Received: from [192.168.212.126] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b2f5322sm479277166b.70.2024.11.25.07.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 07:55:21 -0800 (PST)
Message-ID: <71ff8a13-843a-434c-b5ac-3ad6171eb7bb@oss.qualcomm.com>
Date: Mon, 25 Nov 2024 16:55:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: Enable USB controllers for
 QCS8300
To: Krishna Kurapati <quic_kriskura@quicinc.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com
References: <20241114055152.1562116-1-quic_kriskura@quicinc.com>
 <20241114055152.1562116-3-quic_kriskura@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241114055152.1562116-3-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: iztCuUacDtt6ksx4G62n7DK-RL4ZUuWm
X-Proofpoint-ORIG-GUID: iztCuUacDtt6ksx4G62n7DK-RL4ZUuWm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=629 spamscore=0 adultscore=0 malwarescore=0
 impostorscore=0 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411250133

On 14.11.2024 6:51 AM, Krishna Kurapati wrote:

subject:
"arm64: dts: qcom: qcs8300-ride: Enable USB controllers"

> Enable primary USB controller on QCS8300 Ride platform. The primary USB
> controller is made "peripheral", as this is intended to be connected to
> a host for debugging use cases.
> 
> For using the controller in host mode, changing the dr_mode and adding
> appropriate pinctrl nodes to provide vbus would be sufficient.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---

With that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

