Return-Path: <linux-kernel+bounces-571393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D803A6BCA0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E47293AA69B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D44713774D;
	Fri, 21 Mar 2025 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lO/PJpCl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2139413635C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566217; cv=none; b=kE/S/Z+qrwgeYeS6ZGfnrRIb8p0sKmVrvdqkdpxuhPq5QBVkfH92z80zTQ9QUZf6CKkxRqLKNjzRRvfKaEiHHaWA0Q8L94ZiF+ja0sz2wJRaVSUADkKjkR11YQkAu2M/YbKxGAK4fcgXLQjxd14678p1JIzhxoWEmRrSFT4s0nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566217; c=relaxed/simple;
	bh=ne4NB3gZ6I1uUrWFR8M4TAie5xGzGfHf5c25p2bb9fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhi4//cvkXQt6CtsnaaGqj6XjueSt6Zlc2kddTz3ywBwW0vKDpMuoQoizghAfMg/qns19f9QIuQ3It0A4nErC0aMvrqMOl5WwCyreZWPbw0qNMxh8uocUUe2OINkIEFevhYtYNERP7YGUafxBzcPHRGJDR/q2mg9FUtbgudnQgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lO/PJpCl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LCTHvg011389
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rABlXrO/d+EA/FemZvTG4T8Y
	szCxU8QYVwj9/zb8Fxg=; b=lO/PJpClRKjsCCzvlj+u5eNER+cRh1Cj6kCZY9r7
	X5a3SMYE/apIkt0wf6i1Zoaiuz1RuQYaguqLI/dOTTobkjx7PXdEFNLx8ieJ3XQe
	4KiMFpgjse3rzo9Rw/pFz3GDhNVwp4C1uybWSC4PmnUFKaS2ZT3d2FrmaFSp2hv5
	0zacoC8bwVY5mN82bN9Nv/ORT9/PTgnZqcignIQYh05bO5ADTOpB/qv5eZjIDkSm
	RiRSFJfwAnvJibzTxlY26J26TCyid8kY2HQxlzIynacl36ddqJCfSEVrjxdo3Ptj
	EserzgTJosPCUxjuR+0K77EE0kdVPyh8Qe+mV13EKkXH5Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45h85e08v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:10:13 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c5b9333642so177338885a.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742566213; x=1743171013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rABlXrO/d+EA/FemZvTG4T8YszCxU8QYVwj9/zb8Fxg=;
        b=omvFgnry3N5VN1Ght4QEtofm6A/WfN35V+z/HWuLVmpwyzpn8kIop2H1ncgGBaWpQV
         bfjG/xjkJB8n0I0golucgvSYE6IlbZEe36/cVAMWZXMw02K/Obi93CW/4HkFJvSvNdBG
         6agszKMJEiXrHOoFqcKhgNjlOPfQZIzNWctgzor/8VawNlKPuO/4jiSAD/g97HJupJx/
         ltZcPoGRYk76fCCLUmgE/jS1T2ltRlWczt6S7eAJ2RFmzNcW5T45aViwOPjHb4GHNGZ8
         7R9CtUOjbVeia3FIBiU07hzvpa0dcGRagzhhl8KVM7baOODwbMwbmqkWJzmhVZFT8qa5
         AG9w==
X-Forwarded-Encrypted: i=1; AJvYcCW3MAYibceMArsH8VcLvZmzJBDcdjDujdOYEZ3fNISlhO9Zvq7lal7snaUKUqdlUA/r4+udF0Et1drdoHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF1NdqSanLV22EvQOe+1uNiXOGtfuI2XjHwpyxoGu9MMg9OoJx
	FRMfJyz4VvVle418LWizGLDA80PKN66oQ3KQFYB4am4a1zRQ/xCgvFPUZw0ai8PvBkPMlJbtp52
	hZeH1hCUYmW25w7pWXENzadYsKkxMnH49VzNTaOPWJa8WHcQFNE3WuTHGU7RQUKQ=
X-Gm-Gg: ASbGnctTuKVzhxFlxcBaxrVqqLTZL4KUx0KRgtq/zQglGJx4EUs6sqSOKCvxnkhIl2o
	r/Oqj/SmC/shFhyb7MeGLjPVE858RSEfeQet2vQmlIdYdYKzHaBHbOEu2z4UL1nftIwAKBVqaMm
	KvbM7MkFUC0uIfTmx50jKjMdAjqBxFYI/JqXK9aHgyXAc2BoZgyOAMdWEp7vfysG2tDp3Czx6Ph
	oSkDiSFRgBfZ8KOYNaMsF2FoBczOjiQKKhXd7XfkeaZjM8y1+8BUjvL+KSvms6133d1cPbIGGo1
	E8Ok9BkGpAtNJPhRRPhjJCvx+FNkFYxF9ycBPdK9U671jJMBNDbz2olGXw/XUD5ONgObuLzuxDL
	6l8E=
X-Received: by 2002:a05:620a:d8c:b0:7c5:467f:d131 with SMTP id af79cd13be357-7c5ba20fdcamr622376585a.36.1742566213079;
        Fri, 21 Mar 2025 07:10:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEawjUzzoOOPdXrB4GX6jW7PuG5YFKtC8HWJqSmrI1KdldomofdQxJXVLISONgTpppCxQmwwQ==
X-Received: by 2002:a05:620a:d8c:b0:7c5:467f:d131 with SMTP id af79cd13be357-7c5ba20fdcamr622370685a.36.1742566212608;
        Fri, 21 Mar 2025 07:10:12 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad6510635sm188980e87.211.2025.03.21.07.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:10:10 -0700 (PDT)
Date: Fri, 21 Mar 2025 16:10:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: george.moussalem@outlook.com
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nitheesh Sekar <quic_nsekar@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        20250317100029.881286-2-quic_varada@quicinc.com,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>
Subject: Re: [PATCH v6 2/6] phy: qualcomm: qcom-uniphy-pcie 28LP add support
 for IPQ5018
Message-ID: <ch7lwxgenn6hkvkvejns4buignew7k3fzpxx4zjtqcdrmvsahb@pkg53i5mqke7>
References: <20250321-ipq5018-pcie-v6-0-b7d659a76205@outlook.com>
 <20250321-ipq5018-pcie-v6-2-b7d659a76205@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-ipq5018-pcie-v6-2-b7d659a76205@outlook.com>
X-Proofpoint-GUID: 64Ef91439YiEd_Cb7r5CvI4oPJxxNrLg
X-Proofpoint-ORIG-GUID: 64Ef91439YiEd_Cb7r5CvI4oPJxxNrLg
X-Authority-Analysis: v=2.4 cv=LKpmQIW9 c=1 sm=1 tr=0 ts=67dd7345 cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8 a=rOOs_Go3RH9W65nELVkA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=793 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210103

On Fri, Mar 21, 2025 at 04:14:40PM +0400, George Moussalem via B4 Relay wrote:
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> The Qualcomm UNIPHY PCIe PHY 28LP is found on both IPQ5332 and IPQ5018.
> Adding the PHY init sequence, pipe clock rate, and compatible for IPQ5018.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c | 45 ++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

