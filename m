Return-Path: <linux-kernel+bounces-434982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6129E6DE3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D485A2837D3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA50C1FA246;
	Fri,  6 Dec 2024 12:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Oap3SO36"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7C51CEE97
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 12:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733487330; cv=none; b=n62VmG6WsjieQjkqFE3OWqv551v3+0l/Bx6mO5fKA9KdtFzGeRmz3GIkXXP04jz7+8DuQwdWPvRd5nMfVawqyAs4v05rKwMb1/deR8HMqe9Eybk5OW9wzbECAcEtgvcBTrQ6/Lnyh0w+eoh72Y7/piUFbBQ+KTXER7p+7yG7LGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733487330; c=relaxed/simple;
	bh=69qXwDohScIWAfOVSletqrNr7qyRi4Q8ER4mXTXso78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDBtVB6ZGhx24tNLPvdlsTZOe7s8JrFXeCwwh1l+cdJR0b+WfldFLnoPQCDVGx3vZQzWD+N0cTkEj6S58Tjckx2u1YlbokEpN5SO/KwY8tGURXTLqYYiQ7uXlrS06vyhi+gaVWCEFUnHaqL/b+Z2xZpoIsU5BcQ7DNx+AqvFjKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Oap3SO36; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6AIAfF029110
	for <linux-kernel@vger.kernel.org>; Fri, 6 Dec 2024 12:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5OKC0p2yYzG/HSgY9TWkAGbxInJSraSIIykvrnmj30I=; b=Oap3SO36aA4Bmimg
	qevVSJjCqQQTEUcGqcUyOEzB/MJuptREbOcmAN6RHC0k/00TGx1uG7vBUyGotksR
	7iSY2PYclrQ/78NrrQqnWSQjYblGrRNfysHHoHM/pwvPH/bICbAt9knU0gSmsC1B
	Ulx/oZojWyFzXoqzC3a2++ETIWGtKd048uNVT6HBLvWqjy5lbr34R83qCRGQYma2
	qYOXE0LmsyxQ9z4bk4OhfibHxNSehyjftnzPJxoClDKMgu2uM3qZl8YWYfPVDaOI
	BdVuMmcL2Q0eN7bCREcql9/1+VlxLhJ7FG851dEF7mO5zSRKJbqwdqeqmIlSL7GH
	uCtR8A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43byd809gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 12:15:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4668f02aeebso4504301cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 04:15:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733487326; x=1734092126;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5OKC0p2yYzG/HSgY9TWkAGbxInJSraSIIykvrnmj30I=;
        b=NUZB3BT2DQu2ZczufeS9EbEBB4VrXftUafc+yeUSntOUZ1C0t2x84sF6Yof2SgUlU6
         sJUSp7DajR0sjqLXzZwZl/HoUi8DyQA/vWSvuthOiOtngxEz0BUoSfnf/WxH9VnyPzmk
         ozqgGkjRLaLL5UbmnEdQtrIiCpKM7AQ1TFFoRG06ynwVqsMSA+4v4jzy3vXSROxQM2Es
         +naixDT+OtRxXrfE2VKwXj1Oy3aX0ypU8ssFYu8cX90lt62CLgl7CEw+1Mkdj2dpzqRF
         oYpFwJ9EhewRlN89kbqUQThqhpDYeAQRPG+o01i+i5fzTw/UiTFbyJ32Sqric+EzlcBX
         Gj5w==
X-Forwarded-Encrypted: i=1; AJvYcCX28kNsjrcvgDXd5yiDTaedEWWRMAY1uAMnzxZimrX1zaK2txVWmcaMS2tAfsbGnX6IzEdPdZeUxUeCVkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJEpYR1q6DpJFyMH+ww0rrX0SqpfkYCFs3ECTH0SmHKIj9Cdm8
	Na9+3Vcp/25LrdHFZZP9E1a9TNX5lmNn39RmtjtLeIcSPdZSf7vI0vs6lpIB61M9nGAyb5IUxEC
	c5Xz4a+wgcSh69fmOuSjxYemH9VyJh71l5HClM/KNEr3+sMtOm2kkCVTNQCbqC2E=
X-Gm-Gg: ASbGncs4+HWvrycHI6SXQ9YwBGj63L4L/ZE5zy9t0VCH4n/H27PAguIDqKzm4NKh6UR
	Zy6LkF8Q98ItemFAfKiptRLiGX9R5qq0vRmn2Wwg2ZhNuXvmF8BXia+2YfwN5UeKxxjSIaqrLJT
	8MKRJZ6d6RrudzfQiv07rmcWStDPSAFBbFYzb2cCm0GZwIPtRVBzp0XSVpKZfOXOVlTiShkahsE
	vPmrS2LYSFju51M0h+enabFWTay44YX0XMzZ80XQbh5FMY7WAGqjgt+ts8P94vwosTTgyAWajEC
	DVQ3nyvrGIxW+wyCNUXuaB3wNmuzNPw=
X-Received: by 2002:a05:620a:40d1:b0:7b3:2107:2eef with SMTP id af79cd13be357-7b6bcbb4a89mr152023385a.16.1733487326572;
        Fri, 06 Dec 2024 04:15:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFP4i0WvzvqwHWvWzwD583pgEuYU7s1i/4a3MUxHVC4hDHUnMnNWl+iRwgty6HfmN9rqe918g==
X-Received: by 2002:a05:620a:40d1:b0:7b3:2107:2eef with SMTP id af79cd13be357-7b6bcbb4a89mr152022585a.16.1733487326129;
        Fri, 06 Dec 2024 04:15:26 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c798fbasm2096012a12.59.2024.12.06.04.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 04:15:25 -0800 (PST)
Message-ID: <f948da90-91d0-43e2-aa3c-27e15e1cc7a3@oss.qualcomm.com>
Date: Fri, 6 Dec 2024 13:15:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: qcs8300: Add capacity and DPC
 properties
To: Jingyi Wang <quic_jingyw@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: quic_anshar@quicinc.com, quic_tengfan@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241206-qcs8300_dpc-v1-1-af2e8e6d3da9@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241206-qcs8300_dpc-v1-1-af2e8e6d3da9@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2Z5f85jQQi9nPyTeIYBtGSeEydANnk4E
X-Proofpoint-ORIG-GUID: 2Z5f85jQQi9nPyTeIYBtGSeEydANnk4E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 mlxlogscore=867 mlxscore=0 suspectscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060091

On 6.12.2024 7:41 AM, Jingyi Wang wrote:
> The "capacity-dmips-mhz" and "dynamic-power-coefficient" are used to
> build Energy Model which in turn is used by EAS to take placement
> decisions. So add it to QCS8300 SoC.
> 
> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
> ---

I'm willing to believe these numbers for a78c vs a55

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


