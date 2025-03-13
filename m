Return-Path: <linux-kernel+bounces-559728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A863A5F898
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48DB1421790
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A457267F4D;
	Thu, 13 Mar 2025 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ni0N1Vw0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B12D267F7E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876645; cv=none; b=sIS8pKRncdFbns3ScCI6kZq1uMXDENxIvYkGjD2zGvO7T9QZ5DGiSRsfvOxzi2Cl6zB6T96d9Pg2/fIQKygmBEZedlM2exIri6mqNyyn8qolOtZ7BFXVT4JQPeEb8Ny5KawmvFyNiXxuaFw0pFMbmihBxobA8GoSlFXt5umwujA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876645; c=relaxed/simple;
	bh=+Vnc2/Hj3w94rTEXms9/i3AzD/T69fJGDMl8Wba0QFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZPy92Q1dP582nA4w2JMLRHKjCUSUhSTqqZFCdY+nrzeV7HttOvkj2anD1Y/vWv3t+zJjv7S91YNo6+qo4Voo4YHECc3P5f8MiVd3s98d9VTSLTUR/CzCy7OE9XMobu9ZShw3LkoBEZOle0WHcDB40uGYq8h1x29lUDgTL8TKyjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ni0N1Vw0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DAVHD9016430
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sihxzLONHjt8Oh4C9n2BqWvtteMvgUGVMwmPo7YJzWU=; b=Ni0N1Vw0FEkaNeqa
	01t5SuczAihq+8ElIa2m22gvmbHoIov0DCEr815mL99SpHG0hxy5xjZjmjfmGTTk
	QUd050uMF333VpBgysp8FrU0L1HxbAjwdFi43wTd1e5ntdJI+YdSz3Rppd4ovdHX
	rBxjhw21Mv0oudq3n/ycSSUtHi8zlYyYJEcdx/yl06eNDfqaxHyceakJAU1hwLUu
	gbVy0tnpmQ9bJYZdxysZW8ntpimTpxZ4vSaapzBN5PpkYNoQdM3dLo2KF90/Bxif
	9vC0N3Gk0+QyNTpn2ZzseZev6Zcujil4jepN/1+T8jP8dQkfMvjr8HM2q2lx7iAh
	QYgoLg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2nx6ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:37:23 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8fd4ef023so3102946d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741876642; x=1742481442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sihxzLONHjt8Oh4C9n2BqWvtteMvgUGVMwmPo7YJzWU=;
        b=Ky1m4BvX7EAySEVW+k129UN8QT+XfWV2KmiMm2BQxaPuOMyixIIG9GYoy/5a2Tm0CN
         qFoLkq1tLS5vi5cl1tiqQpcrLVOst+IBX9UiCODJm33hVPkKxAfHPlhzJJOpxcg+2aZc
         52f+5WabF//DRzbWUR2KJSd6OeLyt2mYILnFcCYy6gHhNmcYLmvtc8Zf5x5RMX/fjB7/
         R6YpTZrLqXqWbep0D4KPq2M8oxB+jL9P75xzuUjSsPwA4KpyHJ/S+s9Sx6RGwCPyW7vg
         5JN3BN3TAkUIryrc2iNDrK6UbkQL+uXJYVfM9xLAvuJWy5NaFrtG1OqO5ytyzhopmi26
         UyRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXinbHzL3Jg8yJ7okhYNJ5CC9RFcnxT7s1mhHAasSxuuazLYue2u5nOG2f/xetSoPTI3JDpu/a/qklxs3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIrmmD5ekw5L9KpU1SQA2tGLNs943JcAdBmrUo/D2FNyQVYb+V
	dnCxx/F+sQCVtClK+VUWvHz22G/X0kmq350AyQirX5Ag7MEHHDtU0Jgp2IM/dW6Ui9hxSgpxLiv
	SniTLQuFZPHCf8kMwoQeKFJleFL8GutWQuxbN+bd2XKK8S4Gj1Ds4lQjaTuQ6Y6U=
X-Gm-Gg: ASbGncsdGEUTnfdKs8ooNlGKZkeIp++PzZbssgIpnc2VMHS+jWoLgByGf0RuKLEZQxX
	AwZ0X7apueKCdttsKXcWDjfGtiRm3DbkaZ9qNbsEnako3ZD+4zEY8rkJOfltV88lLdrYmWPsmHb
	mBhKyEVuvuPCGSHJBNEkZ2cc/3N3IWcY8kgz5bNRgOtuqb1yzMtMT+d/iBsWi6yg36BASEPDdHk
	IUWh7DeMSyMZwSOsAQOM/rwkE1VC5f445ox1IBFtzglSdvaA6c5dyn7+2wWAhJh3q+kf9xsfq/X
	SkYNZRtBEs0tYVkDvf2uLtjp1XvCuJpmSrDTfMiSJqeEYgSbZL4KxOj7d1FgdsAbJ3frpg==
X-Received: by 2002:a05:620a:2443:b0:7c0:b7ca:70f6 with SMTP id af79cd13be357-7c55e90cbc0mr638897585a.12.1741876641978;
        Thu, 13 Mar 2025 07:37:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERjH7r/ky+QJSZhtuQ428edqrYv/ARSPOHHVI70rPypcSuf+ECqANAAhYxQXbXX/WsiqH7zA==
X-Received: by 2002:a05:620a:2443:b0:7c0:b7ca:70f6 with SMTP id af79cd13be357-7c55e90cbc0mr638895685a.12.1741876641593;
        Thu, 13 Mar 2025 07:37:21 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149cf219sm85801266b.88.2025.03.13.07.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 07:37:21 -0700 (PDT)
Message-ID: <d964117a-6e74-42a9-a7fb-c08e3ab84217@oss.qualcomm.com>
Date: Thu, 13 Mar 2025 15:37:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] ARM: dts: qcom: sdx75-idp: Enable QPIC BAM support
To: Kaushal Kumar <quic_kaushalk@quicinc.com>, vkoul@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        manivannan.sadhasivam@linaro.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, andersson@kernel.org,
        konradybcio@kernel.org, agross@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
References: <20250313130918.4238-1-quic_kaushalk@quicinc.com>
 <20250313130918.4238-6-quic_kaushalk@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250313130918.4238-6-quic_kaushalk@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6HLBiBccgWTDzf2Nc_YsDzAXI3hB5hQp
X-Authority-Analysis: v=2.4 cv=ZObXmW7b c=1 sm=1 tr=0 ts=67d2eda3 cx=c_pps a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=eg4k1RuA93h8uGKq0ecA:9 a=QEXdDO2ut3YA:10 a=-9l76b1btMQA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 6HLBiBccgWTDzf2Nc_YsDzAXI3hB5hQp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=727 mlxscore=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130114

On 3/13/25 2:09 PM, Kaushal Kumar wrote:
> Enable QPIC BAM devicetree node for Qualcomm SDX75-IDP board.
> 
> Signed-off-by: Kaushal Kumar <quic_kaushalk@quicinc.com>
> ---

There's not reason for this to be a separate commit

Konrad

