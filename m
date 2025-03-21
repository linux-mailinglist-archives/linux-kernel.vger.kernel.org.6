Return-Path: <linux-kernel+bounces-571399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A2BA6BCB3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0982716A9DD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD73D12D758;
	Fri, 21 Mar 2025 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FPVlj4zz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5E713635C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566422; cv=none; b=SvVqzQ71mjJn37liW0j9KQKb0O4UDDLwqmQj7pHOZiQUeS1qCFJAzw38+O9yec7+FmJY14eQ31EaAXKONu4/yttnt2KIrMFtDXpFhQ3s+l4YvrLHNWgMn5QGYJkhglXKKiEgu85qO5hhfc/QTjUPQNd4CJbBOrqm85vnrnBxYq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566422; c=relaxed/simple;
	bh=uBUiccQ0E1+lDOw4b+8JHHFhusVeUfHW2gI08CvcdIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cs6nKA7NVLhqF3RyvDqWq+dTydFBOBINg3ZnDJFN5Tl+IC/7QvrcOotFW9/L64gmtp4TfqK1fY5ROx2tX8YjxI8tuVHT3znney5fYqNXxJLjXvGJUDT8B1GRIZyjUEYKXQWtbn3KHZ5ykycIhOT10Qpleqjjmz9mmzYwyAWbHQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FPVlj4zz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LCSHMQ025701
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/OpsejO/nFX3sSiWvHtSM8e/
	VQXv7bXmKGj+8glzoBM=; b=FPVlj4zzrVAJVgRA0tFAUrVa2rWZvCfOke+pU7tr
	Hpu3XPD8rb8vPqIY3TTEBf50hszdjHgJDzd+tg8X/+H++klmbMvOY0ehw99aCSa7
	uq2dQ+4QA4QKRvUXCxsYOrv+eyLW6cigopp0orb8wcW7LxFYs7RjfMmfFxHMedhc
	4V7HSUn1rEfmnK9dz8P1aCLCRmbluP+r90Y3sb2Z3yjN1e0IsJk0z0D2l1iUI5n7
	rxDbBJERCAAltD+oclMWWZiR9XON8zcIPDBpn7VOjRwnEAJ4ivxEX+tVmhfQ439U
	YGgE87sWNhZuCBD00bqsTaO45IlZH4rzKMoBbEXlCmRSZQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45h854g9u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:13:40 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c0b3cd4cbcso212161385a.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742566419; x=1743171219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OpsejO/nFX3sSiWvHtSM8e/VQXv7bXmKGj+8glzoBM=;
        b=A/2o6VM3DxHWhnAJGXb7j1rOOVHNaFWUt4poM+vBSWwMNMGkFm8Yp8hRfxhbdalq4g
         /UW7rVCHqHqlUrcpbFL+39ZzK1eQsL+qG8ZXq3SWyYmxqKxF38cvM0rLvsm6D3gyoMMJ
         H+yYI+GZx9d6ShnPWf7b9Z8F/PUkRHfQF+7rIl/cFQhUmoRjd+hzOH348bxnKNUpwcV4
         uE6/q8noVdwKOytoLGYVE51WbgtVIByG2Q/oHvae9iWZzkgpQFeW0dYhzQEWWp7KOhU3
         KpGM8mvR/A5z5IBE5CVZlf4kM++QUh6ftfIYABmqpqvUCiOOgsICzszu3YfrY2bOnK0f
         Em7A==
X-Forwarded-Encrypted: i=1; AJvYcCUpAPLECpNyC5CXbqhCoZThRfjBB+nMex9grZ1q9YOEna4TzkRDqIaR3/2hNYOREV9wwUNnd+vn6TdZBD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwktn4d0nHTvugB2wyBa9LsI514vY83Wcymrpm1t82C/NZRz9A
	LVEpAhNSJ5qpIKdWte8fwUIjOlzyQEXq8p+3+Ki8dy7mNb1ZAbK7Bg1WhIZz6zEtgFYh4PtpEJE
	uQJ7c5scCtqW6VT0Q+tejzsMehyYJUqXHWbpK51Aj93Xs0147nTTSxqsPr61lSvE=
X-Gm-Gg: ASbGncsSf7e4zmyTGrFEuDqFom7PQd65kgDF5WrXjfRYFata66sGCva4iOInnwqzQWa
	Vg8ux1FYQ1Ku/OX1JVwknTohUGVxwF+a+2/a0mm4l25BqsYAQ9lCPUlFMw2FF04vbwzsONe8AVL
	oGQEklwvGhI79lKOJXfMrs8pvRAucqlRnTtidDkbknH2himbfRqAS1ovgyvOeZXujSp9oHn5kkY
	lr2RbeeBodMkqJBMlovpC4Xm6qeYssFk8vWIPFJn8OuJpGcLmnHPmH+MT+rPNF7wm8tTfldPb3i
	+o0tfPyqb7JTatG58s0Ff2y/vk7tHDCRilv47nzDRfU/7BZp++rUr+OfsQqUEwE3VMktYjI/jll
	LdFA=
X-Received: by 2002:a05:622a:1896:b0:476:8225:dacc with SMTP id d75a77b69052e-4771de6129amr63272391cf.49.1742566418628;
        Fri, 21 Mar 2025 07:13:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcpv7lxv7hq3U7s9ctlOYQCQmLNU4dbw+zXD/Ekb+GQhj36pTR5y+EtUBwPhZ6EX2Ma2zidw==
X-Received: by 2002:a05:622a:1896:b0:476:8225:dacc with SMTP id d75a77b69052e-4771de6129amr63271671cf.49.1742566418102;
        Fri, 21 Mar 2025 07:13:38 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad64805c8sm194189e87.90.2025.03.21.07.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:13:37 -0700 (PDT)
Date: Fri, 21 Mar 2025 16:13:34 +0200
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
Subject: Re: [PATCH v6 6/6] arm64: dts: qcom: ipq5018: Enable PCIe
Message-ID: <5seajsw64e7mber5yga3ezcnvip3e4o2wylg3uhvaiu5pob47i@ea3rnxqrigcx>
References: <20250321-ipq5018-pcie-v6-0-b7d659a76205@outlook.com>
 <20250321-ipq5018-pcie-v6-6-b7d659a76205@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-ipq5018-pcie-v6-6-b7d659a76205@outlook.com>
X-Proofpoint-ORIG-GUID: rxfoaEYNRoqzA_uKF_RRDkQ1VXb8BHpF
X-Authority-Analysis: v=2.4 cv=ZtHtK87G c=1 sm=1 tr=0 ts=67dd7414 cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8 a=zzgNwz6f6jWhJtTWXysA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: rxfoaEYNRoqzA_uKF_RRDkQ1VXb8BHpF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=501 spamscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210103

On Fri, Mar 21, 2025 at 04:14:44PM +0400, George Moussalem via B4 Relay wrote:
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> Enable the PCIe controller and PHY nodes for RDP 432-c2.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts | 40 ++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Minor question below.

> +
> +&pcie0_phy {
> +	status = "okay";

If you have schematics, are you sure that there are no supplies for the
PCIe PHY / PCIe PLLs on this board?

> +};
> +
>  &sdhc_1 {
>  	pinctrl-0 = <&sdc_default_state>;
>  	pinctrl-names = "default";

-- 
With best wishes
Dmitry

