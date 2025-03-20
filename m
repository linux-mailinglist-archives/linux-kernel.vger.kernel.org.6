Return-Path: <linux-kernel+bounces-569561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C30DA6A4A4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9525980D84
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825E821CC71;
	Thu, 20 Mar 2025 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J5ClOE2t"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7547321A457
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469341; cv=none; b=aebuBMPbd9Slgvr2QO71cpcl3Svg8idMrECpNS6nw3HBo7VjBv5Qhw1aW/oTaX0+ey6ZF2xTI1qMIqkcYSCAiLHjEf7CcKvW+EMtQN0kcZtVHb9Ftana6/6G8rJ1vIXXf+CyaFWTVYvlS62oWbzJ1RXqEO73ffirDzWunoD6rKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469341; c=relaxed/simple;
	bh=8GeddQRYrZDi8Hn6C7CMbCI6u8Xy1d2P5T0zSy+S/Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRC+VxpBGLc6ceMAqJ3zzVUhpLl/peCIpkd3t/bxAGU3rmIccBccH+GH50ISpMFOfg9cDzpVVw9RjlprOIFO5M8dC5II96WFQHk84y4ohl0HrOWARxr6Dr4OIvSkSYbcSAsI/TEy+iLycDdG1oLOoV3jnMutbBM5tRF7vNCzqEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J5ClOE2t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K6Z7OV025403
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LViJEFSHQu4fEUHOMYV1gGdK
	UV6iZNYeAAORu+bVxSE=; b=J5ClOE2t2ddKY023LTxHu18K77h2+x0Rswoxb8AT
	TlFGt1I66/OuHvUm8rZDxGUr2Qnny6x6Bcr4WksTEWIRF1bqwXEkUta6TLunoEXh
	Wb1wVaTh0NZWbzVs0nLn9CDhpHcLrGNjuPA9V/7McGRP0emEhUgmMc9PmkdWlTMu
	rfFwp90ApRaNLXHZ68tbVWWlZ/IHOhWAE7Y5nrIEd19w7+QFVbiLkrKTqI9jPK6O
	zpp4Rfpqq/UJK2FKtZs29izAxNJgrVrM+K+MkCRTI6DZ8r4o0qXQLkhP1VKDXH2z
	ciix8C+vEkDchmYhF0osyuRgHyIr0J5aANK3TH6WWdywEA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45g15y2q7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:15:39 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c0c1025adbso157514285a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 04:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742469338; x=1743074138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LViJEFSHQu4fEUHOMYV1gGdKUV6iZNYeAAORu+bVxSE=;
        b=E+PHgC8DTiwFlcqSqcZdIgvh9AUpgJE9aBoPB2zYsnB2uEDSBBwh4xf8AmBYZe3hCN
         zYOHgAeu046CeLZXRWBkYPaO6wtmrrRFyaRyudXcD94QT+BUUvR23OCKSQ5H3MJL/iNV
         FS3HpxarI0feNEkFDme13tOpaFm34fIrAX8X7otjrH+N95vkMLeD3J3IUUAf7z9LQgrm
         gx3w6bVUXg0Tby2v7Q76uDj/gb5M7jxyn8dRdY4ULg1xvRHNK26rTVlYxxR/bmq4MvTU
         u7dk0bAtMl8vjy2YLaIlCW//fzVIVAaS5nSI5sA7ER8qDMIjI5RG7Y+9yxomcgZYy+H5
         31dw==
X-Forwarded-Encrypted: i=1; AJvYcCXZS06rEG2GsnhHnSnFwrzrkanvU8TR9KPgFs6nWDz8vLfIGao/zrlvnmYftgjFoMRjSInmQ8EOe+RqRiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+rqY6GepsckE1Y1zWGpbXix1vQ0l/vg0t727i3DSP2x/WdP7V
	qCukkFMu0D69nTUIZk1dCWEyQ8ExJDdRDmPPG0zsDL8fflCJkzuCN3BkwYkk1f84cl1r0uKdZIm
	IDp5nYBA+xJ36QpIr3i06uYJ5bjNSwJ63vsc5g87itB7io8wGBVbRUP4/fmdA7VU=
X-Gm-Gg: ASbGncufvdLMaUkBDuRR5gbJ7W8cZs4wKC1j/+s+tnk8UBlNHEE8mAQorm+FEI5QUOb
	y0cCa3onJEp0CfHlq4+mlcD7vfEJEwhxlr7DcL0RdvEuWTfjGZOMWAxdkVD6EpJjm7TKg9Xw1oB
	jiJEjzsNVPoxeQmTjKBVVvSiPtfJZk0xvZPPFl0ydWRxSQPwy0lD23rHFnhFoT4HdGPucjSqMHv
	L6RGdfmix8suMkblycRlbV35/xpfEILIC4ppBF5Ik6w4zYGJN7kDMhjuGk/Pf2wmkd4KF9Efn6f
	e7AG79hQJ8HUyHkdU7PDcCcrLP5v17b4f/l+s42wYZhDTO4FEyPfj5u0QVhFlGtpZf9hBtVPiQC
	GMAo=
X-Received: by 2002:a05:620a:4409:b0:7c5:562d:ccfa with SMTP id af79cd13be357-7c5a8469324mr1058963385a.36.1742469338407;
        Thu, 20 Mar 2025 04:15:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB1D9oYjTuzcj8GT6lqyA6rvN2jK+uWXGS3E204rCKsZ1C8vP4wn7sMsblG886rNS9kUJl/A==
X-Received: by 2002:a05:620a:4409:b0:7c5:562d:ccfa with SMTP id af79cd13be357-7c5a8469324mr1058959385a.36.1742469338088;
        Thu, 20 Mar 2025 04:15:38 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f1c253dsm26168511fa.80.2025.03.20.04.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 04:15:36 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:15:34 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sumit.garg@oss.qualcomm.com
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sa8775p-ride: enable video
Message-ID: <js4dmf3it42mhiqvjk46fxo5nbxfqzqlmkaqmnqqvgbbi3p5rg@myaillyf5evh>
References: <20250320-dtbinding-v2-0-8d8eaa4e76cc@quicinc.com>
 <20250320-dtbinding-v2-3-8d8eaa4e76cc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320-dtbinding-v2-3-8d8eaa4e76cc@quicinc.com>
X-Proofpoint-GUID: gcPD7obZ6eLaLeL8lkmEij3sMX4Bnuf6
X-Proofpoint-ORIG-GUID: gcPD7obZ6eLaLeL8lkmEij3sMX4Bnuf6
X-Authority-Analysis: v=2.4 cv=VaD3PEp9 c=1 sm=1 tr=0 ts=67dbf8db cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=zU-VzGr7wih_uMZSifcA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200068

On Thu, Mar 20, 2025 at 08:24:31AM +0530, Vikash Garodia wrote:
> Enable video nodes on the sa8775p-ride board and point to the
> appropriate firmware files.
> 
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> index 175f8b1e3b2ded15fc3265ac8c26b14473b618f6..2b3d0876dc7f270dbd24081b698ce80e2c27a174 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> @@ -1038,3 +1038,8 @@ &usb_2_hsphy {
>  &xo_board_clk {
>  	clock-frequency = <38400000>;
>  };
> +
> +&iris {
> +	firmware-name = "qcom/vpu/vpu30_p4_s6.mbn";
> +	status = "okay";

Nit: please add empty line before status line. With that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> +};
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

