Return-Path: <linux-kernel+bounces-372742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6363D9A4C8B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 11:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0DE1B22B65
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 09:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E811D1DE4F2;
	Sat, 19 Oct 2024 09:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VznYs3u7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECD018D645
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729329942; cv=none; b=CnlSqtiez0EzZ6GZFrAaZIXuXYjpHQ86UxNQ9X1FvLCtdGu0shrRx2f6+0Rhlo2OqRqFf2QPznPz59aiUtkO06aIQNUNpBucmM7EIOGfUn5rl2NxNbZasD9YKZbrFyMDsugGrxktCztcFSt6Q7Yi7OmrrxZrtRNaQ9Mj/tYV+so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729329942; c=relaxed/simple;
	bh=i0fR3kovI1j8669XAP0ejV5MvppAs/IucPsKP2nqvfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oj+67y2xibZah4TUlrdh+omYy8th1ISWvgLxmFeLVxdVXQakM+EqUNG7G+bR8zuJtEGL60pxNfNs+Fbjjgd2COtCVetWf+zRxLbKr8sjeUZQdgdX6Waolq84nHRAe3d/iczMVYsxsE8yepSM2epqp4jz3H4VNKDhk/tDiWEl02E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VznYs3u7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49J6R1bP032474
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 09:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+ri+83Yu4ZXb1/js5f/3dc6wHAHC3KvCprDKA8rk/2c=; b=VznYs3u7IKxt1wsB
	zX9m+YafNkaZaNn77DwHVbLQttF3/dwGmmTilc01NQEDWBXtS472E40EDNAzxKEJ
	9nJnI4adL0MqX/faCDfGf/znpi9XoH25BDTw1RnHIYLHb2EvEMiD4VB4DzoS0NCR
	q7LpQXfGBCx9C/FqNPRSyY6kg8osZH6SCo2voug8V7AWaSondoOZy1vDEKpiaWVt
	iyN+t+FnV/5eQ6/oI3x16j3cdnRtsHbSGgZ50GMzxuPxeXVA1K4qLlc3muZBKk65
	7xG72+IOHP/8pzg0bW38wR9WkLDSlfpCa+GPboXygT7PPzvx6ohePcXWe0C8aoxW
	0alWvA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6rj0anm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 09:25:39 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6cbf5a3192aso8850796d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 02:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729329939; x=1729934739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ri+83Yu4ZXb1/js5f/3dc6wHAHC3KvCprDKA8rk/2c=;
        b=fb9ocajKHSLEh9F+la3EcyALr6td8Z3nyhuBvJiD4lGKb1OntnFCYUnKoj/bb2H2/m
         HLsaT3+dfuR9ybdhrPjNlz15fRBN9q++3+qcEm9WWHBnQpGdHAbzwcPpQqA6fccc1Ceq
         SV4e9pu7+kF3mXN8V5xj9fStfAFvrxVc09YL5Q/9Fi2g+FaWos4ZNXP4HvxCOGcYpKgV
         vp0Q/8LP5fvdeo7L0GSdCD/ttmJa5Skz7JdlI59r7kxrtI+TYNc3Hff1MNpgKKWKPMA4
         fUrc1BcO1GrFwTZg6wQ8kW8BGW1Q/SAi/ishA4eWETJpsLsLZzegVzYqR+Pbfnob4dHY
         Zcpg==
X-Forwarded-Encrypted: i=1; AJvYcCW9Z6xb297FNpFxRAqe9m4LRFWzj7AZRVvvDyDjYXMEH6oUytgilqUDgEzVTsp7MlWcwNPhikW4V2JdHq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx55ER9MpY18A3VulSv+JQ354FT7qfdIzW3yj0F6BRx0M0dCoHZ
	a85samKs8aIx52tFzrvlrBlhCqyjj4z79+3e8yQjcMCQ+Egm5KsjEIqw9qtOWtOxMJmjeBspyUN
	IbL2/VCfcsTquOwg0vlWIuqWCgWX48h9SvKiYgorx7cSKrnZcVL5wcRHyKeaAhv8=
X-Received: by 2002:a05:6214:c48:b0:6cb:6e29:bad4 with SMTP id 6a1803df08f44-6cde1608419mr33897126d6.11.1729329938604;
        Sat, 19 Oct 2024 02:25:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHo97/Ubq2Cj/vhLVuZ991o9JQ0HdC0i8f/KYoL1rOT218sW7MZ/fq/TieusFevpWQBzqRjuQ==
X-Received: by 2002:a05:6214:c48:b0:6cb:6e29:bad4 with SMTP id 6a1803df08f44-6cde1608419mr33897006d6.11.1729329938291;
        Sat, 19 Oct 2024 02:25:38 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68c2e62fsm194944566b.220.2024.10.19.02.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 02:25:37 -0700 (PDT)
Message-ID: <0bde12c0-0c36-4d7c-9538-25d1b55d2fa9@oss.qualcomm.com>
Date: Sat, 19 Oct 2024 11:25:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 8/8] arm64: dts: qcom: ipq9574: Disable eMMC node
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        manivannan.sadhasivam@linaro.org, arnd@arndb.de, esben@geanix.com,
        nikita.shubin@maquefel.me, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20241010070510.1504250-1-quic_mdalam@quicinc.com>
 <20241010070510.1504250-9-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241010070510.1504250-9-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0EbBZYk2VpLnj1MQxI_aFAsz5rGeiQ4G
X-Proofpoint-ORIG-GUID: 0EbBZYk2VpLnj1MQxI_aFAsz5rGeiQ4G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=459 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410190067

On 10.10.2024 9:05 AM, Md Sadre Alam wrote:
> Disable eMMC node for rdp433, since rdp433
> default boot mode is norplusnand
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

If eMMC is absent on this board, remove the whole &sdhc_1{} section

Konrad

