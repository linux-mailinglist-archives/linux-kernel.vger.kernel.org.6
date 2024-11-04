Return-Path: <linux-kernel+bounces-394705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096739BB30A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C177E284996
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520101D47D2;
	Mon,  4 Nov 2024 11:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nfRDemp9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53FB1C68AA
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718714; cv=none; b=rD3PLwAGDMNQutsbRHYSiwKN/PKYA27mTIpoH3HnmD+VdTxbXLiaaHMN1oU3bTp5OaX3dYH0K+fjXO/6gBrwvQCGvLQ8HUhXwM9YOcPTqZ9U9Lm9tBpTehiNPCCLKjvamakZcSh42jqhdGu8d23EITVIXg/Mj1qtQetVb13d52o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718714; c=relaxed/simple;
	bh=QF5qeqPKv1tyCvIMTbga0xwDQ0otiI62wU1788A6G4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0My7plgew4KJdjPozS3yoQDTG500S3AR2ZyKh5qXoE+pTOXFFXg8IFBjPYdtTyw/1TgF77EWxwPnkGyBVTTFxGm5oRtUFGGxe+l+O4EIaioXVo7eoWonKIOOvbHjhM6gDZC+5sM5GnRD7+M2Gllc56PqPJBdplELn3VXhNtz6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nfRDemp9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3NO0qZ015176
	for <linux-kernel@vger.kernel.org>; Mon, 4 Nov 2024 11:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FnLOBHCGGtHyCjziPaoUnh3eyHhBuYonYqV3aXjJRbw=; b=nfRDemp9yCbyjxxm
	sJEPwdHKuno8l4+TcI1JntZ/pZL78aWE+QPPhK6oUOyslqJWEeH3X3p8DHDgXkNp
	ZdUABjrVfAlfatS80imq4hmQNr3CgL6q63gi14eI1gR/TJtez7Jz8nL8AnJd/o3v
	J3wlB66R3sYf9EpOHCeCmqE4dtRjoOCPHbmPbDaSz0BsRRm6tI9pSOspQdbi+o0p
	DbnRmBMcEOdspcss16d83esFb2nrVZXREPAoEU8sAu+mlMQAdKPCaISoQibY6x4s
	Hm9431xz1Lrk2uZEpqBtLZRHCAzta/49lXaqhgfNP6JeqxHnpViuXRwYRcSib3Vd
	cBeekQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd11uxxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 11:11:50 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d37d9868b8so117006d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 03:11:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730718710; x=1731323510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FnLOBHCGGtHyCjziPaoUnh3eyHhBuYonYqV3aXjJRbw=;
        b=Me0JDgZobZ7Me3USuu6JaxhI5wZnDzfDivxcOlWtPO0i+TF/aNgG1No4jR4CV/sDHu
         YrwQoxujU5zNefM29m+aDEtFehKYQVWG6bdvMsvO3PA7FzvfP0xoU5D8iUtpvHb6x/Hx
         dGzA+dcpXGWkW4OhHf/pHWLCrFTvv1OtstSiFb1FplUJcW02iHCV9OLMHMM+hL5gDup/
         L0lTfC+gYc8Ds+/y7QQFkPrJNbokSPzla+qo/Qnu6IWfCchNFtWNoDgmM2VGOsx8bk6v
         reIQnBsr2mEC+hX6fCaYqZ0G8lIldcZqM+tqkoygGVY3MrhXfiiqLEFT7ZMSkbVs3KgW
         lCKw==
X-Forwarded-Encrypted: i=1; AJvYcCVH76mdr4ena7huXuJP+OjpmXQf8UpFUabgxux4VgPc/sDtJIYq0WMh30E0WamZM3StmdJti6/3YIKDJ40=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV1j7rFF1B5Be4au0F1WdTl32XntkGbUV0r3Nyjnq+eOAF8i/S
	M5rRZcZYvNcpuMECPiJiMp3/tdIIzVEBFZHRjH9CBKt9cDS+zz1mkITULiSgMWMr5XTYYydEO2h
	640cIfeTZ56aSPh/T6oqPOCZXvP/1sL2Ev4DBg1X+kE1bAh/Ou3mkHdEAV6wK4cw=
X-Received: by 2002:a05:6214:234d:b0:6c5:3338:2503 with SMTP id 6a1803df08f44-6d1858886d8mr235370776d6.11.1730718709863;
        Mon, 04 Nov 2024 03:11:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEthW7hWd0uAwrn8o30FFKo+68/sUmkTx97LA8okPZrmjtw/NrlKbGtAzwGCR1uo9lHM4+CfQ==
X-Received: by 2002:a05:6214:234d:b0:6c5:3338:2503 with SMTP id 6a1803df08f44-6d1858886d8mr235370556d6.11.1730718709555;
        Mon, 04 Nov 2024 03:11:49 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e565dfa8bsm541905066b.103.2024.11.04.03.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 03:11:49 -0800 (PST)
Message-ID: <350c6332-e6c3-4d8c-b147-36fba68b3190@oss.qualcomm.com>
Date: Mon, 4 Nov 2024 12:11:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: qcs8300: Add PMU support for QCS8300
To: Jingyi Wang <quic_jingyw@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: quic_tengfan@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241101-qcs8300_pmu-v1-1-3f3d744a3482@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241101-qcs8300_pmu-v1-1-3f3d744a3482@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Tk8BWrh5g6cZqvEDiAWYpk5CD7ciu5ET
X-Proofpoint-ORIG-GUID: Tk8BWrh5g6cZqvEDiAWYpk5CD7ciu5ET
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=803
 mlxscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040098

On 1.11.2024 7:44 AM, Jingyi Wang wrote:
> Add Performance Monitoring Unit(PMU) nodes on the QCS8300 platform.
> 
> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

