Return-Path: <linux-kernel+bounces-393232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF5D9B9E13
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 10:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D582820A6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 09:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4389915ADAF;
	Sat,  2 Nov 2024 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kOrVB6+f"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FC214AD20
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 09:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730538183; cv=none; b=AZDoNk7XsBemk07haCnO1YtFb3LAUB0W0OaHTGDJ5fhySmYk/pw2VFWOi8jST4mCjB6YUYPGljd6991HhH8fyrV+QZvYXwE07UQ0paQ7xR8gsyfGBb2YRBoaGrQufirYPdaTMLjit65I+jKkwW7cNEDF+jjxxEEyd9QHMKQ0ciY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730538183; c=relaxed/simple;
	bh=HzU1DeUPcUvBvjQi4CV2MnkDKLQA/sBx5H9IkMcRzLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GdwHXagXAelxqDrifd0iMWifVK342dzpx6iU5zmhflWowxoUEMY+KIS7crTEWhoxVr2DDdHvx2Rcfynmuv3sTrhgVzrA1pNtzK6BBkTvN6/s//pwzPBhh4VQYPw782fQCnqaZRGtMgpvP03GKTbJaU/IZN/6VXvoHlKwtqQsVS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kOrVB6+f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A24lmQt009357
	for <linux-kernel@vger.kernel.org>; Sat, 2 Nov 2024 09:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IemT58dH8wYV0G/gipvzCwLzxZFpLkW+tH4BM+i0Npo=; b=kOrVB6+f6wTeYFNJ
	CBKxDbNWryYEUMZ8AVqdbh3RuCps6THKbZJyhWKY8A35cEB3O0aR4VuiE9Jc/cvi
	/uHwXD6AC7Dt3hPca67I+GPmVlCRLFDXEgXQW0dp7KuHML3VPyNvyJzZnzzIDD4f
	iDVwqvAF2cfzzhTCTUdiXomYjONMPqPCOAjLHV1mdZH9STOymAbSoOv0+P0KAHgq
	/FyVyyEudsGHImyeEyTjWBihZIcZsEGKM7jG3/HlCshYHrPuUDPmt1GuexemXeFO
	kVsVZ7LsMb9CkIIEfW0ECMJB/dXRTDOR3AYqpXoB5+ujYAQ2Y7RlFgDRy3VTUo1i
	08/Y4g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ndc6rbtx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 09:03:00 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbf4770c18so9180096d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 02:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730538179; x=1731142979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IemT58dH8wYV0G/gipvzCwLzxZFpLkW+tH4BM+i0Npo=;
        b=kA3zYB7g1nP2MccKf7ewAkCmBah7z5uxxbK10M8X125g2ghfhkYp2njpb3A6x/JYyS
         eqKjCxiATGCdFhjpzi5zqBdcgGW3uXCYkk3ghXnM2syEpKLU0qv8SKW+bMF5kevGKhIf
         1PWF9bPgjxl3uMb+6dpkuUAglTacu2tHjteLSPEjyl8v13Ps4aKvbHqwsNIAKQ4s3UnT
         cO6R0xonQa4V7VVrXCIEuBwZA3D9ZMsJq3c/OJTuDiijNDXXgUTDI5dfZulNCWK4yQSy
         DUqdaqeXV3xDrmwOCkKqlXUkvAYr1rswnsOarOUpw4Z+bXq9ce6OP1sw2669dJnQ9PMv
         U8Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVLQEa6nfAR89s+SxHp4twxXDaxSUvQHPjLn58xPsQ9Pw1tJY1xK6cZiP0S4G9RMk+gP/7m31lxs8ltH5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVaiUAlP96Wt3XuDwz6D/aFmLuexCaVitHTEpoyYntqW3eKFDR
	TBMS/5b4P8IJCmrMd3vezJI2EVoK5xAvRH2BjDbJNZHUFuJILRgs7l1jJX8Isn0h6EXNXzI0iYF
	b1/a0ZApH+NKpoJTn/IzzyQEt7+e2Khu2HMXlNtodo5rbk/4Prt6anBT7danc6Hobte/WnSQ=
X-Received: by 2002:a05:620a:1aa0:b0:7b1:4371:8cec with SMTP id af79cd13be357-7b193f0a11emr1699720185a.7.1730538178732;
        Sat, 02 Nov 2024 02:02:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBQjVeCl8DXjUgVPPr41pa+vh6gteOB9jie80zysVXdyLkPBey/WmVIOyJ8VIhOyTxQj6Qdg==
X-Received: by 2002:a05:620a:1aa0:b0:7b1:4371:8cec with SMTP id af79cd13be357-7b193f0a11emr1699718885a.7.1730538178266;
        Sat, 02 Nov 2024 02:02:58 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56643823sm288208166b.167.2024.11.02.02.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 02:02:57 -0700 (PDT)
Message-ID: <463f6a3d-c9a0-4525-8150-8491d6b60d24@oss.qualcomm.com>
Date: Sat, 2 Nov 2024 10:02:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: sar2130p: add QAR2130P board
 file
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Krishna Kurapati <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241102-sar2130p-dt-v4-0-60b7220fd0dd@linaro.org>
 <20241102-sar2130p-dt-v4-3-60b7220fd0dd@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241102-sar2130p-dt-v4-3-60b7220fd0dd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: wG16219K7m0ljwmQOLbzEAeBMV8Sbom5
X-Proofpoint-GUID: wG16219K7m0ljwmQOLbzEAeBMV8Sbom5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=856 adultscore=0 clxscore=1015 mlxscore=0
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411020080

On 2.11.2024 4:03 AM, Dmitry Baryshkov wrote:
> Add board DT file for the Qualcomm Snapdragon AR2 Gen1 Smart Viewer
> Development Kit.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

