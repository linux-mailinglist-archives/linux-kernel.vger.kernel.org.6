Return-Path: <linux-kernel+bounces-531487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72464A4412F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C27317733F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D08126AAA7;
	Tue, 25 Feb 2025 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xw0Hvceg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2B126AAAF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490739; cv=none; b=N+UFadkgXZwfMRF7CSvTkQ19JOqSZvYcuu+VkIiGrRAIss+KQgfXHeR0tZCHbE6Y/XpwFkKhEislbL5b8b4xhUnjEvV6nwqgczcTNanHQ3iY+xBXgo+l3yyxHRYKVFZkcINE4q/mc1qdg9nEYvvfTkKwKDRgEkPQB4wv2SfxYVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490739; c=relaxed/simple;
	bh=v0bj/zqw+24ErI/9iNiFwIBMrJ6F00qOqAwC3m6PJmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EFme/gJcYcOBxgVcf/uaCAyxX/ubd0YQdVyN8f6V8ue3uOZZq9Nr7yuRdy12y47D0z5B5dmrODbAyKxaLW3TtGTpvCRVQHwhE3E6C6pz4IKccxOHeW29JBZQQbE90D5dpn2h9UNpqk+kYNZBQAA15OVmLsBqDwKZeG5BDQuBSUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xw0Hvceg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P9E5RV016201
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	woumc9GjD8qeeQzGa6RZ11jkdHts493OKWZQDEqYj3c=; b=Xw0Hvceg5hBS9mkI
	eGRpBipCHpFRWz179D8DzpEGhAi6LUzQwsAxurvqMxR2r9Hv1lCpoe5uMY99Q5KM
	nWp1FZdkjxGYQ70829sTBB3VXn2LNGzzbI84U21I9P0rOE32FCBWfmGRtezdmlTv
	yixKlxybdY6emzQtjuiw8WwMbRT/G0nqQ0PWaBkTjGAGviROsK43N18QOFC15VOq
	5NOIX1Q+TS+1oDi3CL6+uUKMiCet5bZHAN/ugn8TSiolUC+vOulrFooEOex9wiGO
	8Iq2VKs8dDe6em1z8ynxN5GlNPPhl1E0tI6z3WRDMNfj2oCY8XYY4aTi9QxzVJPD
	3S4nAw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y7rk0u1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:38:57 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-471f4687399so12349561cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:38:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740490736; x=1741095536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=woumc9GjD8qeeQzGa6RZ11jkdHts493OKWZQDEqYj3c=;
        b=oBYej6KYfRy7W8L25mPaMJWeCxx+YrnOdmkcj8yBKSXYll2mE4pmWCK7gSl3yg6/Ql
         JcZTyZt4aNGx6SVdd5Lgtuk+Su2glDTSwxv3inniRV0bXaA6TcJrOOSs7tOULjRRcRvg
         FOUuzWd6Qv9g8KUwU4ULqWxHfEsgjw6JuMl8VaJ92Fz5Zljg2BdlQweoavyMe3NDKIDZ
         TdamsQeh9FKez8Tb7T1vRo//O4FN7f7uY5r5wVYkNh/0c1KtHMJXsjGBkoDEE1HRIedy
         BoBs6DASrPgBth/FVViaCsHx75kgkHJyqu+F64sak+bhoVfKJmBpYJ8xOAneVJ7g2jdj
         kYyg==
X-Forwarded-Encrypted: i=1; AJvYcCVE4tAB6ybb+ll3v4WDtyW6+93UiZhKnqQ1TPS/DOpJ99LUSHJXdLj5e5s3c25OqUvHDVNc1hgZS57Oqj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUw13FF4DEvO/FTZgBtpZeeaxntBFDXs2uZyLbOsovRXUQ0ZkJ
	rlMizD+U2YkOZfHv4EV5ghbagOzzwWVo+a0w5Kn5EPZ2nKf1gl7h2uGodOzto6WekBhi0Yvwzhf
	i+OvkBb9QpdtgTWXZ0klSVQ9wyO80n7iNbdOmZUBLPq+l5mQstnx3YTMTN9lcX44=
X-Gm-Gg: ASbGncsGXcF0josjHAXifbKLQOcqx2Ifp1wLev1lUIYXtfmFr1FqJtqyHpW9o0Of20K
	jFsloCCyQgsvpAOnAysaBCjS/tUxCEE16Hcwr3L76HOcqP3urRRbGKnzG1KbA3F2gAlQsM7NBBG
	XbZpGIjX5bWoAhOebNg9+h32/fUN3KiiOVzS24+C8F3db9IJNAOK5SIlsBPq8tk4uZ4uI39zc3K
	1rmtZFN8k0/ODhv+qGBMZ7zUSsioOo67IHw14J6SqdjdUjS9OZcxMLu7NSboDF8A5TmCyTKOMOU
	Zjb6b/CeyvcoJBTwvJqUwvEe7DAFt3ZPnyDDGCejnPSb4aXBrjEbhzz9gaBz2PsYEh85ZQ==
X-Received: by 2002:a05:622a:5595:b0:472:1d00:1fce with SMTP id d75a77b69052e-472228abedamr101174451cf.3.1740490736234;
        Tue, 25 Feb 2025 05:38:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjOXuBD+5u6McaA71MsHpTumzGjAxp/BpGHbEliPe5AFBeQouuQ+C3kOjYUnIrWHRb3ZXhjQ==
X-Received: by 2002:a05:622a:5595:b0:472:1d00:1fce with SMTP id d75a77b69052e-472228abedamr101174241cf.3.1740490735850;
        Tue, 25 Feb 2025 05:38:55 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d6b153sm143635766b.73.2025.02.25.05.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 05:38:55 -0800 (PST)
Message-ID: <3956606b-71de-4c71-afb0-c4918888db19@oss.qualcomm.com>
Date: Tue, 25 Feb 2025 14:38:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sdm850-lenovo-yoga-c630: make SMMU
 non-DMA-coherent
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Konrad Dybcio <quic_kdybcio@quicinc.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20250215-yoga-dma-coherent-v1-1-2419ee184a81@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250215-yoga-dma-coherent-v1-1-2419ee184a81@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: FHf7hTXtFgAXYby5ntnH6XJj74KfKZqQ
X-Proofpoint-ORIG-GUID: FHf7hTXtFgAXYby5ntnH6XJj74KfKZqQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=766 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250094

On 15.02.2025 3:43 AM, Dmitry Baryshkov wrote:
> The commit 6b31a9744b87 ("arm64: dts: qcom: sdm845: Affirm IDR0.CCTW on
> apps_smmu") enabled dma-coherent property for the IOMMU device. This
> works for some devices, like Qualcomm RB3 platform, but at the same time
> it breaks booting on Lenovo Yoga C630 (most likely because of some TZ
> differences). Disable DMA coherency for IOMMU on Lenove Yoga C630.
> 
> Fixes: 6b31a9744b87 ("arm64: dts: qcom: sdm845: Affirm IDR0.CCTW on apps_smmu")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Let's revert the offending commit instead, this must have been some
sort of fw development fluke..

Konrad

