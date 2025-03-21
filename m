Return-Path: <linux-kernel+bounces-571717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 482D9A6C123
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9897C176F3E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE33B22D7B3;
	Fri, 21 Mar 2025 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a3QsaeIi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E2122D7AD
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577591; cv=none; b=IbFTB8mmdMq5pGJ3XKxedbsPNGNQTkLgToIIXyblYDHqfCQpi5pfESZcvlUDA9Hmbw5EyzWP4W1RyjiQ0WhRd2oB+fzjiTX6GizHz54yIU0RBf185qnYdawmEEZXn8lMsvGOQM83YaOu5JqhEM2806j3vLD24goAjg/0o2YifV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577591; c=relaxed/simple;
	bh=RxFtN8yGAxrNqy4cbQSeY+rnG/poLgToWB9oUm6qL54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNCF+O/Kyx0KcVKWTejddfzLFtjfXK7s61Thx9EC8lLsbV2OewVojc2RVoQbV/q4PAFvnSpbfH6sNVOlo6Cjql4XpcQ1snuFtpBZ+3VFdA40rhSsgiKI41CfnnKPf7PV5L6rT/6dCpgTQa2Z3bodErN/lX+IXU9QkBRC4KKl/tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a3QsaeIi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LATDcM003104
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:19:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8uqUXv0r/8O3QLVh8vDMkagG
	kjjokeiI2xDdN6b6W64=; b=a3QsaeIiEM9t7Qtuc+WZurmqy0+WO9wpbCDREBb4
	FsQAJGFS96YtJgPsMW9+iufBUrK5AtDvSwuIhvUGw/DyPdevDEcFq/wEWRk7vra+
	QgMaxVSfY0mBRNMwAbjKYPtxyhZSAEUbAJ8Fb0ObOzSTzLERuQVGkF+z98WCB50m
	T4pn3/IfV63vVMzeRgUtNpvsYv85TdtmdocNVnsUYCS8WnTYz0hA6mqQ8E9Ih+Lu
	ggZ4OkkUaneyDM5iPE4d/zJNXXpOMrss4EIBeqwqFrVcBOXz7GUuW7NJqIqUsion
	IITHSQ/nTxI0cOG0TbpqPfylJze671pdaHwI77Z56e3A7w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45h4p11fn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:19:48 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-476870bad3bso36996161cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:19:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742577587; x=1743182387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uqUXv0r/8O3QLVh8vDMkagGkjjokeiI2xDdN6b6W64=;
        b=sqLV64QLCWDoteAHHl6AfnR4r+p8UuozUIYByPHy/IkzwBu7GOXwYQpqin+N8h9ywT
         sFJFPKBwE/8JaVSLC49QLhJIDTiQpfUO2EssvREEEyLNZhJTZqyKe9QxAfmavuyAT0qy
         QOgOKEydlWA3rlEIc3YeiIqEwYU2b+x9dx5wAP8bms92uYb1CNnhPt5xCrxKDI96dhfx
         UKDHvtFit2VNaHbtFPjquApfm2bM/IGNWfZDk97RYDtssofr+CDaVYlowfzsXdIx0IXJ
         cqiQJRQ6bu/9wJQZIKeK3zn94322Rh4z51ItSOJJ/DkRc+0GePRf5XEaPQtNBiIJtN0e
         ToXg==
X-Forwarded-Encrypted: i=1; AJvYcCWpDwCNQx3tz6njCWAsDRd0AoSzeOxJWcViQOEvyD6TnxdUvvL/e1D80XZtOt4MOy2urmTfZSfMzGJRTlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0MdDOjHAVv4i7X7rrkJA44IwmD0QrbYuYugU/i7eUgLCqJ8qh
	oF7qshWb4RHqyxqLwgrrkyfxy33ec6C5MY9kruIfyFYXhLa+IQuEY9dXYrB3q1gCNEFYYGU4YCy
	xZk1yVuYrHUBOirFPKvUYwGC+fLVMWd2e0JTKXPBkNhpR4xSphrXXcsdy4nBIdFo=
X-Gm-Gg: ASbGncvcaQQlPSJWtGMgJkdwORCRW/sLkPe9/o8Af2VArByEuDsfIyTZYsXa1Gb0WLF
	crcvm5lWIGtGC82f5x0E3io2A2lRsDORRSbnJy9lNVvUUXGfoM3szNlkXwX0o1L4WvVlmPA31w/
	DJcwTNRkbAbd8AsriAk7/38hnbPk9+hr4Ckzxvt5XJ9wmzW+xY42M1K8GlBgeQw8krq7fU5sbs8
	4jhBwbpJqHQ++Huz6ca02J1Bo0j/ReGIyXir2W9ZId0hcjq0nuD6p/xQfMG99dplr+TtJneYD1E
	XtEfZeRp/hlz62Sl8uP/htNzu2RHzhqapOfPiyqyB9oETprNnCVm/9nJKKNwRjyaJVQUeQnOAUr
	XWcY=
X-Received: by 2002:a05:622a:989:b0:474:eff7:a478 with SMTP id d75a77b69052e-4771de6458fmr49666201cf.46.1742577587095;
        Fri, 21 Mar 2025 10:19:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER60Phq8nLZh+XeCU4Jt2MqK+yrUa3O0K5NTXyK+Z44YiEZ4OyV6O67mgxGbNT2KMwFFn7dw==
X-Received: by 2002:a05:622a:989:b0:474:eff7:a478 with SMTP id d75a77b69052e-4771de6458fmr49665781cf.46.1742577586679;
        Fri, 21 Mar 2025 10:19:46 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad646893dsm226011e87.44.2025.03.21.10.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 10:19:44 -0700 (PDT)
Date: Fri, 21 Mar 2025 19:19:41 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wenbin Yao <quic_wenbyao@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, quic_qianyu@quicinc.com,
        sfr@canb.auug.org.au, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 2/3] arm64: dts: qcom: x1e80100: add bus topology for
 PCIe domain 3
Message-ID: <hgvfxxjvquh3tn543ae44o3lie3pwld5snbewy2lxcrtgd4raa@eyfm57omt3ge>
References: <20250320055502.274849-1-quic_wenbyao@quicinc.com>
 <20250320055502.274849-3-quic_wenbyao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320055502.274849-3-quic_wenbyao@quicinc.com>
X-Proofpoint-GUID: 1p3YlqHV8xgQ8O7b4AUvmn3v96IqbNmf
X-Proofpoint-ORIG-GUID: 1p3YlqHV8xgQ8O7b4AUvmn3v96IqbNmf
X-Authority-Analysis: v=2.4 cv=NZjm13D4 c=1 sm=1 tr=0 ts=67dd9fb4 cx=c_pps a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=ICgkrN6sfqZrQ0pjF_MA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210127

On Thu, Mar 20, 2025 at 01:55:01PM +0800, Wenbin Yao wrote:
> From: Qiang Yu <quic_qianyu@quicinc.com>
> 
> Add pcie3port node to represent the PCIe bridge of PCIe3 so that PCI slot
> voltage rails can be described under this node in the board's dts.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> Signed-off-by: Wenbin Yao <quic_wenbyao@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index 46b79fce9..32e8d400a 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -3287,6 +3287,16 @@ opp-128000000 {
>  					opp-peak-kBps = <15753000 1>;
>  				};
>  			};
> +			pcie3port: pcie@0 {

Empty line between nodes, please.

> +				device_type = "pci";
> +				compatible = "pciclass,0604";
> +				reg = <0x0 0x0 0x0 0x0 0x0>;
> +				bus-range = <0x01 0xff>;
> +
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				ranges;
> +			};
>  		};
>  
>  		pcie3_phy: phy@1be0000 {
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

