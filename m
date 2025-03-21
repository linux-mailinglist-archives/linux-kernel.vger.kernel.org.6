Return-Path: <linux-kernel+bounces-571736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E5AA6C162
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A63517300A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4740822FDE2;
	Fri, 21 Mar 2025 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i87AR01m"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1966722FDE4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577873; cv=none; b=JhzK3v95qKrqG0C934p/TR49Ar/rxYcxzqQpJBo60WmEdPGApC2Z8OsKpsq8yY5NRtOoDo/3SYDC2kGzgcxxoPFtTv3+CuiyGN6wLOTPj61Zn7DIWLVMaXRiKmsTzYdBZj3iCsTdbqtILyNZk2GG2YS6Vwe/EQ1pyBVmjxXsDgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577873; c=relaxed/simple;
	bh=wmgWDqUJvlikxwYSBQGbNkTJck+p4wsSLylUsigCs9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIHSTQgkiv1yDgwuHutsPro+W8huIbj20iIpSuzx/FhAcq6fJfPT9dcsj5ilEEDi/4EDweENqQgGFzEVCfIq9sLKUEe43MDnbSj2gdBymr0zqPnM/RNky/E4RLD3ED76Y7PDusxzTtVrWQuMMSJl2LRsowsAmRc/jsXyOun8U8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i87AR01m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LATBTY016514
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fmyEdbwSj/HfKYKw0u3nOMsS
	tnOViYSt8oyx8TwW7b8=; b=i87AR01mow3m5gEH55ckDnJpAaZZ9lHk5FbD2AR7
	EE2nqJ/KQXV21AcN8xGx7FtunGIgNEyalQdKUGgb0RgnD3PW6JrmlzPU9E84hrZy
	XomY/qV5A/MfVWn6bJz8O7LFG8Zks6wN/SuZwyQXzBCC8VPCx66w77HekUCX5Yvx
	yOU8WzLYBJh6qgJkVXCl7VEcHbK59Qpa74GiatPXjOS7vwhYs6cmhWn5i6SizOpI
	Ai4Ytx8H26+jXrR9AezXHFlEczRqqwIpPvbo+qOFgZEGvlZPklOymDq7c+9SP1Md
	bWxT6A1esgHoiTbkORG9jsg7dL+yxdq3bq/TSayQKY3/5Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45gcd1dk82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:24:30 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8fb5a7183so38634026d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742577869; x=1743182669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmyEdbwSj/HfKYKw0u3nOMsStnOViYSt8oyx8TwW7b8=;
        b=XoyRfcj+SQXQyGlD+C7UNFtftoY5/10UOe191G0rO69+V8ZyYj26jJy+VfWgXwZ8mI
         gVCeZDWhZgrqx/SfeiwcZA6nHqdrUnsY+mVn7BQgCvFY8iaGD3GM4uE4L5cDqKX0MT0+
         Mm2ytkC8bXgpKBwkpE6dWoOykgVCks5gZeEsDYxPcu+jaiKt/RMSufMVXIxUIrE15goh
         PYF0iEzDhFnzGkVn8tH5QaNcK/yAhLquULj8G5cPYCuAWRmzS+Xnyz2ObQAJXRhyQRbF
         wGwf2znrofUCmF4GqzeJb99t2xW23cCSBQDG5cEa1v+XWhQxMqgR21RyS22Vuy9Dlq/I
         wtXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUGAZi5WqPhnySZ5m5DtkbgRxuj1aKepwur1mi85/Xy1F7CHtiXpx2Ao9TO0RWo019smjoybJoVAbuUuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+NxxGk7BVEqsnNKXjp1gC/dNP3LZ1bjHJE1Saq/qKZBWtakpc
	151fDulGxPS0+CDs9dTX6FDaSJ9IbsKgvw25hr/+Kg5o+sb1wb7Yumf0MYViHYXwpZo5rL8g7TV
	4/pi44XPh62hgYzrqwCCSMYUvNoCa9RrZmoIEzGT+pGx9Zbv4QpxcOsZQA0LkoOs=
X-Gm-Gg: ASbGncv3s8yCIJVTfzaveG6aEoGLZGYOK1erWPgeY4e/vuN/tltcGQWjtV5gESZZKl1
	IuAnwzWEwzsE4WxTXvDykCumTupSIzXsOLcYDcV9u58u7zBafYzIneU9wh/4biweXq4JmSViB63
	IQfJix8x4woibU6b7GB5ow0usuBDrYKbwvlEKrGrgE9PdaVpviyLD9ZbfVSNSkkJ5YF41NZHxPR
	pcJDvZUF29OF8bKf5kP/tdebGExcOzK5fM17EPFrTN1ObewqTLEqcBT9iBDv4EiLVyDaMNUOYJG
	QAD6Q/JPsI+rI1wS4axvXR23B01gm+xWRx8Xii+F22DWvFGZuNpdRQVmB5Tn7pON+qaXPYjNcDH
	sOZA=
X-Received: by 2002:a05:6214:d64:b0:6e8:9e8f:cfb with SMTP id 6a1803df08f44-6eb3f2e309bmr41689836d6.24.1742577869133;
        Fri, 21 Mar 2025 10:24:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYPBMkBWN8m5K5k3xpn/3XXm87TYAnHC/7fY88pVAc/I3QngrdnmwHHeW81kaD1vdN8OD9hw==
X-Received: by 2002:a05:6214:d64:b0:6e8:9e8f:cfb with SMTP id 6a1803df08f44-6eb3f2e309bmr41689466d6.24.1742577868651;
        Fri, 21 Mar 2025 10:24:28 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d8f38b1sm2966901fa.84.2025.03.21.10.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 10:24:27 -0700 (PDT)
Date: Fri, 21 Mar 2025 19:24:26 +0200
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
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sa8775p: add support for video
 node
Message-ID: <cp2uisloxbt3kxe2pnogyqwblp6cjg6srao6mzxozmwn2zmrlr@5vjgfeyosmza>
References: <20250320-dtbinding-v3-0-2a16fced51d5@quicinc.com>
 <20250320-dtbinding-v3-2-2a16fced51d5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320-dtbinding-v3-2-2a16fced51d5@quicinc.com>
X-Authority-Analysis: v=2.4 cv=bfFrUPPB c=1 sm=1 tr=0 ts=67dda0ce cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=MV23zIJfk3Kbbaa4CC4A:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 3Sn98UdzVNx3l4ZeoxSwIdj0fzNbhqtk
X-Proofpoint-ORIG-GUID: 3Sn98UdzVNx3l4ZeoxSwIdj0fzNbhqtk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=822
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210127

On Thu, Mar 20, 2025 at 11:36:51PM +0530, Vikash Garodia wrote:
> Video node enables video on Qualcomm SA8775P platform.
> 
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 71 +++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

