Return-Path: <linux-kernel+bounces-526466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7068A3FF01
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40EC163FF9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A8F25332F;
	Fri, 21 Feb 2025 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nxCAVyD6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5220F24CEEB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 18:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740163372; cv=none; b=V72egGwKzQIM+4XvobK+xQiJ9bbaDZRfBC9hHcvD1sG41wRS0EBbSnX9amzmuRJBJiPSemAq8kfL7Gjcdv7o7hXCuhjUxnhoxgEUVIXZ1USJhwwjq0qeNujJq5zr99HoiuxAwzMUo9rgOwmFTteKWmvBnriVPpldoORuz537x4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740163372; c=relaxed/simple;
	bh=1bmbRUwk+BNNq6gA9Bpe7TPnHF/oaA/NQmpJ9nLPe3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hd0K16X/NmZwOv0vLg+fAdHMaw6m9JJACuEcqocAKQ7Q/iwKTwzOVpZ4iSGbI9FCkq3UFocOPZYO8eecOMNkeS73tPUssuNvMVnPxXdGIdALLS5ySBPe0LAnjNMRN9yk3f0btLMglY1JpLhNBTGRr9pIh5ZqjP7gku8ceQ6cE0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nxCAVyD6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LD0fYr014973
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 18:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qTPvB+ML5+rJwIEK58ICt4gImdH4pwy2IL/fBgWr1SA=; b=nxCAVyD6rvRK7Hjd
	Vi49z7faK9MdnpvKQcgAszbWY0X4GnrlAGnZ4TZ66glYyB4MvLHrD6wQc2Wk93wk
	cEdQnkqlrVjW3+KO7Y1agbDERVmc9v9t3DTuAyXggy9FFKrThEB3XwUlBDZtz70/
	8ejV+cIthIRrf8yF6sVFjaius9t1JS7K/p3185A6xTxNFXrTlaoVN9nDMfnGaypE
	c6MzuzzYbPliwNl4osgjc+F7vLcp/sociuDTe9dvTrUXUYpWDKzgnIFpW2RQPiNW
	qKkyMwZncyb70cdikeuBQUXS1F31CVHE7sdz6CDtysR9m5MoU5l2TIUepRfgb74B
	Kdog8A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy1awrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 18:42:50 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-471ef402246so5420751cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:42:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740163369; x=1740768169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qTPvB+ML5+rJwIEK58ICt4gImdH4pwy2IL/fBgWr1SA=;
        b=sXBz8EGsO4bsID/eBUw75dcdS0MUbgOX0/snaeuAFyz3DHL1NVUZvq6nHcBgcq04zd
         hZhSbLHcAeWXbOjOv8Db2r2wdwNoqmvt1rUZBVqR6WT/RA1qyLV7sfhL9rPdTayE239E
         e1Aed+QE3Yhy7+tg95CB5fSUNPF39mOmt9ni7wfqMNVgAqpgTA+KXq5Eai/KXFd1ZKlL
         hsRqhV+kJNhiSEut1dzOK1/cCbh5p1iXHEXjZVoeRkSGR+hXS4NrczARoC9cWTAwd44e
         OGY6bnH5dOP5CfWQ/YgYBpSXQxEAwuCu0e2f1cut+z3Ml+6bm3Tga9pWPT9xE0dPx1Sa
         RCSA==
X-Forwarded-Encrypted: i=1; AJvYcCW5Xiym6BOZQDTVjEDpKNSV/4j90R22Vscijy0oOJ8Z6UXt5h6H4tHYwjbVdHsIsXencRbaoz0P5JGqTec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Al/0pBxO2uG6XeVznYIM3IYJkpOKWbIyG0NDwfBS1/pWCpcN
	DAkEkxgULFPjf2aYaqelKuiMO/ayshU3t2NEQ4gev4Gm90oWpCCufmahyedYBaXXGEHA1SEOlJ0
	Ypv3TbVTLKQ5VcR7Umbf5Mcqy83GLt4SIHOxltkFblso59ofSZKziaMUNvRUkWhKg6WlA6Hw=
X-Gm-Gg: ASbGncsm+HmmKeXBJXfbuAm7pXjwG+pOaBMdGTdayfUyPVAzf8MF5VnwjQ0L3N1OPny
	5uxfiEqFCZNB5NX45m1CDbFcr0CNz2YxqkedmJOdXQKpizOLFwLmaDUQIW968/KcNOXzx2sVgjk
	IummX4JUsm3R5G8jhXUgvUMkQbn2rEb3YVBegnf2PB8Ni6roHHfWobLTcxPdVH3reElbCxlibJn
	QGRpGLLFFtrBMiDZp4EmL1w5BPZVbGTaaGJ6jor+XaqhTSrNLRixFW51316AU80TCIqAl5rwYxp
	74DzXW3a6sF2qfPE3G8TDkhM7yXMUdVlg1YCE1GtezxhM1QKKOyJO0SrYLCImxzt7eBLVQ==
X-Received: by 2002:ac8:7fc6:0:b0:472:c7f:a978 with SMTP id d75a77b69052e-472229762c7mr18992311cf.12.1740163368943;
        Fri, 21 Feb 2025 10:42:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+yBJIomD8Ov549FRkPq+6wQGUS9vVvqGnim53nFKLCag4DBYC4EeexHxtY+4Cb7py38j4iQ==
X-Received: by 2002:ac8:7fc6:0:b0:472:c7f:a978 with SMTP id d75a77b69052e-472229762c7mr18992111cf.12.1740163368623;
        Fri, 21 Feb 2025 10:42:48 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbc9ff4fcdsm645841266b.87.2025.02.21.10.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 10:42:48 -0800 (PST)
Message-ID: <5ecc0d40-f2bd-4ad4-a4da-9b5e85274746@oss.qualcomm.com>
Date: Fri, 21 Feb 2025 19:42:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 3/3] arm64: dts: qcom: sm8750-qrd: Enable modem
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250221-b4-sm8750-modem-v3-0-462dae7303c7@linaro.org>
 <20250221-b4-sm8750-modem-v3-3-462dae7303c7@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250221-b4-sm8750-modem-v3-3-462dae7303c7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: XK89ZdHTwhhFuol3fXPkh22h87GsqytF
X-Proofpoint-ORIG-GUID: XK89ZdHTwhhFuol3fXPkh22h87GsqytF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 suspectscore=0 spamscore=0 mlxlogscore=662 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502210129

On 21.02.2025 5:33 PM, Krzysztof Kozlowski wrote:
> Enable the modem (MPSS) on QRD8750 board.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

