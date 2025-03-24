Return-Path: <linux-kernel+bounces-574006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A94A6DF7E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF513B2F14
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447F7263C69;
	Mon, 24 Mar 2025 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p2y3ZJRw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B352638A6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833310; cv=none; b=tl/lSrfsCK7KWhIQsvmlHhw+AqRHRVWXKCvARnXP1Bd+QIMXzU8PubfRIPKL4qbzci5+P8Yam0oqlZd274vPa8ry0PodWHUjnPCFcbvGWWvX4A2Cz8xcfLdPz6YabPQ9NiBFSFsC+h5TVoze1w4zYRbUK8hV9fwdP+KQhL/MU2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833310; c=relaxed/simple;
	bh=G3ch8p16B56/OMBcoTpt+rlRb5rlx2rMrdh8cjqUYTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=br76xX1SwmVP3UDtFaRQvXS2X4yY03FI0jkI4ArBSdhytGRigvFfAc+zW24Zq49aVuTfSOwQh8tTTBOkxLAlE7kQn2gjMm4HtcXi7T6C8+NxGbjIDxbTb/V+4qiZjjfeN1quz15j5c0g8+DRWCAvlvtt/LPRA618vKjEpXuxcFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p2y3ZJRw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O9PQ2l018136
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=L0t9otsKr/6SRlUjYfCBbvls
	lpbDLOmF4pALHvMgpW0=; b=p2y3ZJRwdWX23ECOlNVeXX/jl+BaY5RAQJXWAsKn
	mFTJxQbqX6NWIpFD3eim276CE4gPVCUfir0AUbCOVsfd8xhQPnnkvUNuWqIc2SV+
	G1A07yWQnKEeXF+lOFBcZT3y8VvcOR6RRzlmdq2smR9vFPXVpiaCNSoeGmDzTP6i
	LFJfiwL0oV2cMkn4Y7AJyV5Qx56a5IAt4tIypw98d1LiX8CC8xjHAoiyEow4X2bh
	Lb1CWazYkSMaHevBi5bF/7GPsqne71+Rvf4IICS3G09gJ1QgahDF9nP/x5JoXzAH
	t/d4fAYQHFlNnPXyJBqQcZmyo92kw5VUUnI9vLOcY1umGA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hne5vx4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:21:48 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5c9abdbd3so139251485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 09:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742833307; x=1743438107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0t9otsKr/6SRlUjYfCBbvlslpbDLOmF4pALHvMgpW0=;
        b=A+qpFIwAR1vvVIGSHZ9gmEtUqwy72+AmoosQy+UlVHap9jJJRmYUnUJvR6mHM6u8j0
         D/dhQwoRujlLEYFwvIHy79SN5qUBMeXQYECVMtwjemV6y9PintfaKs1oskgbd2w39jPo
         6aLL51un+btkUM83ZINWk1Be7kQ440AsynXvFOH1N7btuv8xix332RfkB31ERNiK01RA
         rBaYeOws/uNAuf7SISlPW3TSVIBh2VuERcTZeex6gH2miT8eIfc2G7GzTUSQp4obBsyU
         3CynLcZ0zVxGX5IAGu4pXrsRxrhlE4EIUQEzitYg69Yg0bw4wPT7I8jvrtR6cRr/eSlr
         gDew==
X-Forwarded-Encrypted: i=1; AJvYcCWhRPiQQtV9mRh2PtHBqQNH6g7xNRkxA/8/I9xzlNVFpmHmlFWDp95xtn+mrgoT/I3LR0etSIvbwu/VXQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWhDPoM00UmydSmlLpGBboWZS4Kcsc6W9O0dQWoURPnRiFo/mf
	E+RONo31LfnH4C3pqgLEopKm71F1rO5fUA4JSqpsehNsksfzvxZiCqugxhHv76tMrBlM0eTQems
	+ZWzGeRLroXc7vlxA/YSgkKdwq9Hk2h2vXZ+oIzEZBm/sLOH0rGdiaEDTnRiyBJI=
X-Gm-Gg: ASbGnctcI5bcB80dDMLRImMv6b6g4uOb4kciQ7opPt1xT0kc1QRRvrldDG7zEBnC23r
	EE+9XaBZQqpc0Kk1JlwaJJW5+kLPQcanVorQK0PXkJfwCxqrvb9YTHjnZ0ZkaDC3SPP39h1FcDH
	4+8zF5WAKPIkVrENPoWr188L77ao6iVX3aUT+jPn3eIQfi/NXkPjV4uWYA1ADBjur+8/R/lONnG
	qXNlgW5cJJTf6Lin2UA+zTri5C3qmNUh0IeJhEJA/T2mMoIFCLr15Butod++I0C9DAH1S9jqWo4
	95BTzTUuquv4NcbzaWIqPc9lxFMdvpkXQ9G8UzP1beAZ4l6wD9Qbok48w7WTUFd0gqfqyZOOWm8
	TcmM=
X-Received: by 2002:a05:620a:2943:b0:7c5:b909:fde1 with SMTP id af79cd13be357-7c5ba184669mr1763344385a.25.1742833306758;
        Mon, 24 Mar 2025 09:21:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqPuV+DjbubvDGus9CrUSechSUZmqelOcYU26WWWKdtMe4ZBYTMFrpi13dRZOvosPr+OQhKA==
X-Received: by 2002:a05:620a:2943:b0:7c5:b909:fde1 with SMTP id af79cd13be357-7c5ba184669mr1763339585a.25.1742833306260;
        Mon, 24 Mar 2025 09:21:46 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad647b629sm1199719e87.55.2025.03.24.09.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 09:21:45 -0700 (PDT)
Date: Mon, 24 Mar 2025 18:21:42 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: x1e001de-devkit: Enable support for
 both Type-A USB ports
Message-ID: <vefncygcuho2ga4aoatuq76er5c7euysndfdsreqrdvpk762tf@b7x6cu2frgbz>
References: <20250324-x1e001de-devkit-dts-enable-usb-a-ports-v1-1-81153b2d1edf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324-x1e001de-devkit-dts-enable-usb-a-ports-v1-1-81153b2d1edf@linaro.org>
X-Proofpoint-GUID: 2cYihSIdT0IEKSKeE57S_IgxWSX8cuWl
X-Proofpoint-ORIG-GUID: 2cYihSIdT0IEKSKeE57S_IgxWSX8cuWl
X-Authority-Analysis: v=2.4 cv=JvPxrN4C c=1 sm=1 tr=0 ts=67e1869c cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=-ogRkZ1lWjz2smMNko0A:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=373
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 mlxscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240118

On Mon, Mar 24, 2025 at 04:08:19PM +0200, Abel Vesa wrote:
> The Qualcomm X Elite Devkit has 2 USB-A ports, both connected to the USB
> multiport controller, each one via a separate NXP PTN3222 eUSB2-to-USB2
> redriver to the eUSB2 PHY for High-Speed support, with a dedicated QMP
> PHY for SuperSpeed support.
> 
> Describe each redriver and then enable each pair of PHYs and the
> USB controller itself, in order to enable support for the 2 USB-A ports.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/x1e001de-devkit.dts | 86 ++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

