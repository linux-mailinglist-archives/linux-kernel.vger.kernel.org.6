Return-Path: <linux-kernel+bounces-566943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5854A67EA3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA68119C55BF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEFA1DF240;
	Tue, 18 Mar 2025 21:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JteMI0cC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5639C2046B0
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742333470; cv=none; b=XgImd5SlkiwYO04A8PasZBpZ6EnYjYEpeytwcAIfXt9JurA/ho8QQgdqx0u1VDZUYZSy4ze4xHU4rOPVSE87kgJm4Xoyq9A/tNDRaCobcte/2s7Z+adTjc6x0Mt7FGgr1a5EQ3g5SOa6hjuL4KDR5hJNteQrar9ZC+Q3fLspInQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742333470; c=relaxed/simple;
	bh=Zd/lGl/BaQMtgrwusxIKB5Meuc/2YqaPnAXi1aEbN8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyKYmtZT9FdBl4/5nQWOGIFbNtliJklU9JeZ/0Y1ufMFBgwIfLlOAmiSSdc0M1GCzQoBl1xcBhZMyje2ks3V/uJ7mHgqcjR2V6amE32Yh0EZhcmD5azXnedOw/4ChwKiZ1BIgAr+vjllUHkn7ETgjJvCujnzjMGlWpRftrwlgjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JteMI0cC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IL2n77001597
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=IQTJa6d8+0ZScV+dRXZRs3BL
	e3aq9v8gckH15Oziank=; b=JteMI0cC1LGurfgg8iX/kFljxkj+HOpm+Gtr7Bcn
	KOVKs3CEVRGQzWqnWXbCuq8Hz9yCC/JD8jdUjrjsRgK1JUdSzGEiZc6aMzejh3yU
	tz98SjYKrzAkF+TZN3RimFDqTiB0IsoGKm///teI8xF5JksGQxI6TxhicdD4K2fI
	kpavG3kRYevLyH8dxeJj5Od1Mlk5nywbFJlOiTiORDNk1ETzDH0HBqQtS8t2zekC
	Tcwvr78K1i8moDbuubPiEsyK15Oq+fWOAeIuv02Rko0orvMpxjeGJWoGYs+ai4lL
	O+HmbOOHGOHqBBQH8OFA1SYmdGHT6I48b6NjX/6PjwyEMQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1uu1jb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:31:06 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e917965e3eso92165676d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742333465; x=1742938265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQTJa6d8+0ZScV+dRXZRs3BLe3aq9v8gckH15Oziank=;
        b=QeIZiVDQunSpSUgJnBi4G7DJbM3FwHPggSkxe0u5ScgD/dQUcsF5Ut23hsfTzlk30o
         +FE96NJym4ze17z7QYjudGYOvtHWXIIuY/0xO70orAwMQhTyWJqyyiVHEvpBLS76sujV
         pnc5w8kt0z/DsojRH5CE4/d8zk7hevXRA7R5e+EPQXaIrVjN1LEwDJW/YDoqxpsjXbRf
         Qau3IXzM3M1Vty6QGC/f7Fk7hMKDHlAWB6fxLgaSMIzj7nngsPUmU95TKzZRUXrsiTkM
         Wv+hn1zUhyZJTM+mLBkmFyl9DOmyWsmudVkqPIDEkYw+gMyGYe655DkeSPswxPxgD12q
         vU0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1YRkdJuZ2X3hJGwCWNfwYOvGaGVRtd4/ZUNWnryrHiEZgltPAmfI9ddTTKDqGresgIKyB5hLeik8zo1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+8CPRi/is0fDdNmJdAhFNJId76o/Mxd6TsVWj6hzUZBUBTD8f
	ifJnTYEqvKnnaCTq+VeFc9ThakoH+IZqWjj3obsIuKidBoBg9rmJRhFsLDA4vuKKZir8hR0c/Rz
	c9xoLld1kYc0GGtELYfsA68IP7XPf0ZwHVZ6mrrSnUYkHDGj8s8VGVMSwpc7HBi/I2Jfnfds=
X-Gm-Gg: ASbGnctV0Fd1P7PvV0Zccoa8SW/xThc2vSQirKsxilMSN4Za7hKQLXMVA5y0gm9upBt
	hKmu5l+iN7/c1otkTTyPdOSQ88U+3sYodDojUrViFqWFJaNR/9bLHBQIQO11eqTTt/9F7zO1g8l
	941kv1mscs+gnEpoVjDnBCHq1AH6X1evWMMj6zne9lVTX6K2FZTABmrIWHcEu01kICeYyeB1Sr4
	2JBVi9C1QnpW5kiF5JkVEzQu/a26Ap9rx8JWYJ+wi3i3sbNt0yKgCUjifMT3LPRV6Hi4Q/Xi5J8
	hCx13mqulvwAI2a1VEPV85wpUzfkDtqFUDPXH1ivUguhpZfbiLUvoJZJxSFoOvUhvh7qVtFG6my
	5CkI=
X-Received: by 2002:a05:6214:528b:b0:6e8:e8dd:3088 with SMTP id 6a1803df08f44-6eb29446070mr6520736d6.37.1742333464905;
        Tue, 18 Mar 2025 14:31:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtisToGRKCmJFjH4vKYE/SGOWUhXgszmo1Rlg9h7fGB2i+kjzy+nYhwmqQf8jUAfjw09SVFA==
X-Received: by 2002:a05:6214:528b:b0:6e8:e8dd:3088 with SMTP id 6a1803df08f44-6eb29446070mr6520426d6.37.1742333464612;
        Tue, 18 Mar 2025 14:31:04 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f117161sm20969381fa.53.2025.03.18.14.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 14:31:02 -0700 (PDT)
Date: Tue, 18 Mar 2025 23:30:59 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Marc Gonzalez <mgonzalez@freebox.fr>,
        Dmitry Baryshkov <lumag@kernel.org>, Arnaud Vrac <avrac@freebox.fr>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 2/8] arm64: dts: qcom: sc7180: Add specific APPS RSC
 compatible
Message-ID: <l4vd2xmrowmmtefieb4cbirq6ntkvnwbhtpxcyzwdeok2vgtt7@zqgqndumgecv>
References: <20250318-topic-more_dt_bindings_fixes-v1-0-cb36882ea9cc@oss.qualcomm.com>
 <20250318-topic-more_dt_bindings_fixes-v1-2-cb36882ea9cc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-topic-more_dt_bindings_fixes-v1-2-cb36882ea9cc@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=H8Pbw/Yi c=1 sm=1 tr=0 ts=67d9e61a cx=c_pps a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=rdcbQ1PDIldBRSA5hMAA:9 a=CjuIK1q_8ugA:10 a=Kpf3sWjDsCJUBp_pRoBA:22
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: oPW_9HblohpJwa-dIcWp8CKvJlK0uGva
X-Proofpoint-ORIG-GUID: oPW_9HblohpJwa-dIcWp8CKvJlK0uGva
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=875
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180155

On Tue, Mar 18, 2025 at 07:35:15PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> SC7180 comes in a couple firmware flavors, some of which don't support
> PSCI in OSI mode. That prevents the power domain exepcted by the RSC
> node from providing useful information on system power collapse.

Is this behaviour specific to SC7180 or only to ChromeBooks? For example
TCL Book 14 Go or ECS Liva QC710, would they also use this compat?

> 
> Use the platform-specific compatible to allow not passing one.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 87c432c12a240f8035753ad10ce8662584a3f1f3..c79b256690fee8a20853e1662503e1f4250611af 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -3720,7 +3720,7 @@ frame@17c2d000 {
>  		};
>  
>  		apps_rsc: rsc@18200000 {
> -			compatible = "qcom,rpmh-rsc";
> +			compatible = "qcom,sc7180-rpmh-apps-rsc", "qcom,rpmh-rsc";
>  			reg = <0 0x18200000 0 0x10000>,
>  			      <0 0x18210000 0 0x10000>,
>  			      <0 0x18220000 0 0x10000>;
> 
> -- 
> 2.48.1
> 

-- 
With best wishes
Dmitry

