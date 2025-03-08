Return-Path: <linux-kernel+bounces-552555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3F1A57B3B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 15:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30C61895297
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 14:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A8B1BD03F;
	Sat,  8 Mar 2025 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I61oHrDf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CA6140E30
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741445306; cv=none; b=J3piBUubnXhWoxi2bnXX1dwjzFJ048jF74C7BahJCiSFO9nLzyS5g1AuV1CrrDl3Daj0ocA8UCzEtDgeZi7yKbfiICdyksv5MnrkQvI0to+SIjPqSLTwrrUtbeWApwXjomA5fwmK9uWkSVoE1VdndM+1wnUIPXU+w2VTAH10ilo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741445306; c=relaxed/simple;
	bh=YGBj8gADwPSMC1i2BlpYA5xPWm5tF3yekbYYKM1u4w0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ceh1M/+et3D0aiT6b3UYcR0R+aOYesq5b8FQ7DyeyiWokiFAxAeh8YvZdhX2IQs92mpywo2/FlG5RW+uhGClLNCpN0e44SjvGi5lVDzGauOPp95Z/jdb4SD3IByk885Ck83Rl8Anw88d1JNX895iVApcB2fMq1znmeJgIfbgrIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I61oHrDf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 528DaEYs021252
	for <linux-kernel@vger.kernel.org>; Sat, 8 Mar 2025 14:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nvBeg08yOEUzQZPQ/Skfesh4RlnvXCh+5wTrJqrA+Yo=; b=I61oHrDfgmzrjF2R
	0z1RHS5HVx2em9h/9ioO+otVoh3cppQP5lpwFbBuoQn2JlecVnsEQqSRXws9GgGF
	5JxJdaP333l5oKmd0qEpGjLnmXi6JCYHa6cp60iZf02CWSnJUp27dMChMmNmknV+
	GSxWCiJUG5g2tmKLb6eZWpNvQPCrwnma/LM38s6Reh9EbeiWO+jQEiYeVuoAmYOK
	qAIoLh7/K+VBPU0VtRlqlufq5Ko5dMft8EKf+WBDaBCGIWC55yfBN/ewSUUKP5mr
	GCJxC+DCcDArCRpwPGL/WKho0rxe0Gk87wgvGiCbs6FMHt60cYXgov0ImC1oI77N
	sAg4GQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458ex0rqp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 14:48:23 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-476695e930bso584711cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 06:48:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741445303; x=1742050103;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nvBeg08yOEUzQZPQ/Skfesh4RlnvXCh+5wTrJqrA+Yo=;
        b=epMuF0zqc/ogmm23u1k7WpCUMXhvml3pJjyOnEiXT+blsz2+bOdHocwkYYgTyaW8JU
         2nBW04RR1UPYZnrnyHZ5QDE2+4Brs5I7mEX6tvCPb3xlljaNysD5WccRFC9ecvXfAShn
         IqjMcBWYFWflmJdGYAtOoBjiKaiXoPuAPTFr5VGOF/ECW1tUV0QGxE+3lzbFr3mDzs5e
         mbx5LzsYPqE/sJg/IfceNUau/0FSa2L8xuDzuYhWdD5IYWjJJpCgsIoYRHlLhktxUzlq
         romLVrcO0pT2KjTuqVVBXq1eULRcBfoxUDv25BZySi7jqiHryTo2DZmc+byKtqEGSs1N
         Evyw==
X-Forwarded-Encrypted: i=1; AJvYcCXBEYz1Pwa7rEXFi+TMpg4LPQgI352cyhofBVuNiDt6a8O4pfl88TovOBxI35tFboDnuqkF1koe9TSJOjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSjchVaiaAK3qJCk/xOO0RfhmbZlCwNK/O27r+VejKaoqDbtvt
	lUVQlk4ZfHI3/S+7GQvgIPXkkGq3CD1xzf+04fa4LHWIUHbginJpccy6RWZz9IXTdU9bE0Ht2ax
	KFmifOiNXWS7/p4aF8ruV5CQjIbl1nFWiJzW/nhaidMrFLNXuhTTW9Ktu/QLVGFs=
X-Gm-Gg: ASbGncv3yLB/HqwCoGW9tbcG1uC2ZWOL1ib/fPrZcKbqeSTCqpythOms9S5FaebwBT/
	t/NN1/AIjzW+bPefiTgrjaT7xnvNJJfxCuMzMT6DFFqVULP412ZaxjiSWaa26gDmATqqDpq48NO
	wwbiwBeHN7Z3ps8u7yGJ1dpVwHufP8dmDhSJEfueJGx9At/4QB1+oSvQ3JLUIXNsfNSR9vxvwCk
	6NP9YbMSXnBlQHSN7XKizc0Rb3+UV1fE6NjoNgjHtNzvsS8P3+mHlAww6BLUvEqJ3K90PXgKcLS
	s2fSPIYPPad9/7drjdczI1zeQhjec6ha/mvoBqVKUOh+wlCK3XbLFc4ESJWZXDuefAdwuA==
X-Received: by 2002:a05:622a:540e:b0:471:f5a4:546 with SMTP id d75a77b69052e-4766653779amr14369181cf.3.1741445303017;
        Sat, 08 Mar 2025 06:48:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVEKwI6weP/5KnlgKGURTMqm6ik4LTTk+t8W4K4EzR8nGDc4m9OO5FuyU5n7+r29SlCOPGsQ==
X-Received: by 2002:a05:622a:540e:b0:471:f5a4:546 with SMTP id d75a77b69052e-4766653779amr14369061cf.3.1741445302741;
        Sat, 08 Mar 2025 06:48:22 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2390fe76csm444120566b.0.2025.03.08.06.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Mar 2025 06:48:22 -0800 (PST)
Message-ID: <458625dd-25ea-4eb2-9a04-10a173608cac@oss.qualcomm.com>
Date: Sat, 8 Mar 2025 15:48:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/23] arm64: dts: qcom: msm8998: Add missing MSI and
 'global' IRQs
To: manivannan.sadhasivam@linaro.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
 <20250227-pcie-global-irq-v1-15-2b70a7819d1e@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250227-pcie-global-irq-v1-15-2b70a7819d1e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: DFrqyWXRcbEM6UdJYmvU0WqGkWLPdVBs
X-Authority-Analysis: v=2.4 cv=f/qyBPyM c=1 sm=1 tr=0 ts=67cc58b7 cx=c_pps a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=x0-Ntm4DP0gVEan9CnAA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: DFrqyWXRcbEM6UdJYmvU0WqGkWLPdVBs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_05,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=635 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503080111

On 27.02.2025 2:40 PM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> MSM8998 has 8 MSI SPI interrupts and one 'global' interrupt.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

