Return-Path: <linux-kernel+bounces-566946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F73A67EAD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3A5F424F47
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8B7204F8B;
	Tue, 18 Mar 2025 21:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TtaGPfEg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE491C6FF4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742333579; cv=none; b=Bb73r89BV7qIIV72WHALukGtQarpyJjYYjaumdchB5K1F40OcmsRC8kQecuBK8R/KKIB46CpdCaZhi5v01AyHksjcWJsCpeJPJrm+MjLxWyBKkluK6EBo3bBghSg1YTSHLNubzeOLBpSf5yBDUGnPbwM0tlHXzx3zrXJZGghqdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742333579; c=relaxed/simple;
	bh=2BUZe4B/ElR/wC9+24hQAHoUB3oeoZhKkoDplUsbO8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSqYi7NGZwXtlPzN3RcApJp8hpA20NAHHf+w+V6mh3VzrynpGb1I7Lu5ikZrRWyk3Fap2jZkYSnhGhIOLclh/xMieDchp6UhKv+JClGAmJDQqDNKNhFX3pmEVBfAZ8VapSlQeU7B0aUJGPoopl/XHkWq0aumbgq5ulR3xPnISJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TtaGPfEg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IIlb7R011322
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:32:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NwMN89YxaLKyCKOYp8/emJaN
	ov+ScqMrpVh61CIHIsc=; b=TtaGPfEgwfFb5Qb2aHdwxxm8+l3WHBOYxIaDJHZ2
	YLSqai35F1H7C4paGqSk23ERnfP4CujUj+Z2nytGIiQ5htKNoeMRBlZaZeEoI7x5
	s7FGSrQH0DI0+8HPAatulSSQGBYMQMdjB7C+hdJKSPrXRpM3iQ2jMPOGS3sGyeJd
	2bHaD4WQU5uinN0bsK6eglIh6Rj29bzHUFF9RSEj/Ep2v3usfH5Iw03ZxWX69knn
	gFe9KLK3J88Qi/qJgW3VrMB6cUK4CG4lMbYjeRWjJmBiL0UGkceavDJ/R7/TUNZA
	iO9AjDMa9a3jL9Vb9GEJAIrFZEyN0h8aaYNEdhmTIQIgZA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exx3397s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:32:57 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c54e8ad9b3so13495585a.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742333576; x=1742938376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwMN89YxaLKyCKOYp8/emJaNov+ScqMrpVh61CIHIsc=;
        b=peErI5KWpqqURtH44QwV78ZhL0XWUVkl6DlMMzvjXgjcT+CwdHH2anqj2xS1Gw6Bku
         avu0l3F4W5/WylUwAKjdWQkiMRpDgmq3CV2GTrbjTdodkbs9XlD0Rd28CquFncVJdhAk
         apJ7rifw0TPjy663lZw4ZyyBJLR1Kvey1kh222TatIZr0qRdgQbBfdgbhcUTqyaPu8EU
         iDzPLQ7vphW9c5/u96JlkxtVWf/VZQwVJuacBOPf7F2v4ZNiyBD6GAGytiSY7zc7atE+
         8RRx9EJOUjY0mqOL0gFYLtWxlWHXYk9fGldTLfAG1x7stYoGHVee3qzmyjhyyCHrTZdi
         e5bg==
X-Forwarded-Encrypted: i=1; AJvYcCVqIkW5EdGGQaK96r/M34UD/PfMWghzs8eBPT2o2ccoP3YvBF+lyXIEPJ3k6XqZtPpfzNcqs7MFGfhfNLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV8dd/VQ8j6s1797vAGhtchrUmnDQ0LF1W16a1APGUhXaU92S8
	0C6SapYxSp4vN7HSrCFfjvfpYxSqTxR10PRlA+otlVXe+YNBKZQXnqsF9rlepcTYc3ULOxa5vPC
	hmK9nZ3Q/GpZU05BtjVBBM9SsIYRczjoc/nAdc/y7bOx0K2SfxJumK9LfrhlENQw=
X-Gm-Gg: ASbGncvQ8iFV6vNOxrxibwpbVG/ItilsiSQJ7/7gfaNGAZHzG1vIkdrpx3n2mpv+ET4
	3SToUx+I5sIdVwvgWr7RlRbFX3k1KE/1d2q8QHGs2Cx+XQQ84YAsFL6XTg1BCnjZlkI3qTSG2x6
	ORCTb6uDwK/q1gIbBliHL0JfXIr+D7ek8w2QzL81+N81ls2nTx+VJ+I+zO5szVS+8kpQskQ76cf
	TwiffMyjVTwFKpQxa6rgmC3MnoMaCHbpTYAkG4k5KKeByHjJhc0CtY7YVMrZc2nj8/g9dciLFk1
	WfarcvPfUFJXeRClTXQcaSCBsy7wA2aitQH5gaMuUjX42855fDdMnC0b9BocWxEAQoIp+ob+eUL
	xd1U=
X-Received: by 2002:a05:620a:f0f:b0:7c5:3b8d:9f2f with SMTP id af79cd13be357-7c59b731738mr798311785a.17.1742333576417;
        Tue, 18 Mar 2025 14:32:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFq5F/JLPAaQXrDSOw1XgilhJCzh+nKCxh1TSKH8fBgE4Opu3wA/GQDPb5L32TGJRmeu7EEA==
X-Received: by 2002:a05:620a:f0f:b0:7c5:3b8d:9f2f with SMTP id af79cd13be357-7c59b731738mr798307885a.17.1742333576089;
        Tue, 18 Mar 2025 14:32:56 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a8c68sm1774546e87.248.2025.03.18.14.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 14:32:53 -0700 (PDT)
Date: Tue, 18 Mar 2025 23:32:51 +0200
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
Subject: Re: [PATCH 5/8] arm64: dts: qcom: qcs615: Remove disallowed property
 from AOSS_QMP node
Message-ID: <uftjklj7xsgruwyodttj6oo63cswa7xmojr7chiylz5siwfhfc@yb6rflzsxtfm>
References: <20250318-topic-more_dt_bindings_fixes-v1-0-cb36882ea9cc@oss.qualcomm.com>
 <20250318-topic-more_dt_bindings_fixes-v1-5-cb36882ea9cc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-topic-more_dt_bindings_fixes-v1-5-cb36882ea9cc@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=b+uy4sGx c=1 sm=1 tr=0 ts=67d9e689 cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=MuFgdvjdNmmiJytiEo4A:9 a=CjuIK1q_8ugA:10 a=PkAOt9_mmfBkvtOLxIEI:22
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 3UvZXJJtp65IubCu78pEBu10PUl_pRXB
X-Proofpoint-GUID: 3UvZXJJtp65IubCu78pEBu10PUl_pRXB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=643 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180155

On Tue, Mar 18, 2025 at 07:35:18PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> AOSS_QMP is not allowed to be a power domain provider, remove the
> associated -cells property.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

