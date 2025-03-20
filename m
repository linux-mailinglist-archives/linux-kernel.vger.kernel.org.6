Return-Path: <linux-kernel+bounces-569527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D311A6A433
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE80318918E4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C8C224AF0;
	Thu, 20 Mar 2025 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QTndezSm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8820C224248
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742468088; cv=none; b=bin7UPyHeoPIOf5r18LnKCUpLgYVzzq4e4TC5bjydBH0VWcY8n9B6ACzozr4vewQpTjeTM+y4ILuafQGbNhIMQyutHEzkYhGNzUHUk+ludRaW8AFkpfDdBkK7uIXY5eEi7H4/CH9sfZqc84xld4znb8CHOOK80rp7ANINuDuYck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742468088; c=relaxed/simple;
	bh=Gzl2OAOWftrG50OaeVh+6u3yuNfq2LInxjiLaVChIWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwpK5RkqG0nKfIBXnAJF0KB5JsnS8CsQvzNhR3AgmM/N9pSzk953BQTsZ3bB6uexqlYL5H3qHIQWg9hsjJCL4w8PRg4UlT8nXrVvhxC6eYEZb5hE76zjJIosEYcwUrUJfnisA2neKyEL4+bcq4Pt1FtyAm20cKQHWtb2fym9bYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QTndezSm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K6Zifi014684
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=9MSSpvRG+TcV9gNCepPHrW84
	i6zOiyJTCdB87QHlGkE=; b=QTndezSmxaQlMikf3B1wozAHStIREKiRVGk2iEnt
	qyPikNFdl/tDpwOfzEh/nbbo9eRkOMm5yIwYizDD67NSX7J0Hjm66O1bvQDO6NfA
	yUk1vZGxUZ2PgoY7XWE8cdNEcHIiG9KLOwIJPO7ZcUkZ0QHxqFvFTBZ3AUXbOPht
	wnLVrkt/FjAtymCeUpJk3Lmlba54awBkpaSpEK2pRj+QWvg8ZARjoGF6xy9OOOXx
	tg9E1zpV29QqyWeOLgXXU9gsGhr2WIeE6/Nnxdrmot7JnEIj5rMhLhBg5IUX+tVF
	XU0b+l7AfnkPlbvPkqip0KbIISOdMmb1oPuX7BRgl70bvA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45g09f2tnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:54:44 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c54a6b0c70so69200385a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 03:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742468083; x=1743072883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MSSpvRG+TcV9gNCepPHrW84i6zOiyJTCdB87QHlGkE=;
        b=s9CVusQWjtHwiZJfSdBdk3CUfmALjWJV9TimA8dmfDXufCESJ954HaE+r/hRtquTn8
         f3NFnaaOLWEJTF3LlU/BK2zzJy7VqSIBrSYVAU7pu0ZAlgrkYuzdov7WSrkAKkxW6Drm
         XkyqjI1AzHXPBKxYxdtje29e3dxDG/mFdA4jmRTJXYK80vy7vruYSdMivX4eC38xCfkG
         mSHv0iDqiDQ7UU2AQh9WBlDe4SpRIH7Cjol93YcNaruWwBalpT/+IeOJoow+n7aneXyk
         jMD8UVbaBA46hvDTVUNKW76ZS6uwg6krryZCMUrt9c/JAaUuhfU/0wkAJkzoq0wY3cQo
         nnJg==
X-Forwarded-Encrypted: i=1; AJvYcCX1Nhl3ld61laUKklq8q+Rw6WsYbz7kfVsYZ12nHWmeGYLc4wOGgEbv4mKIA0267NYSw1PrsPPyPfpXuYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo3sFO5Sadw9I+qRGKJgESUfSpH/Ctougpd579rRj7Fl5FvaWy
	iFX6Lb/TnqZTnAOO2lPPV27upc9yi98Hhy7xvWY2/yJ4D1CyIbrohalktipxvXEHkpdhw+0FEOD
	ejN0Fd1DQDJAtrSp8BRDFAp3H6kstVm4O6zgzpni8fB1ZvtcnZpF1PZNKr5YjNP4=
X-Gm-Gg: ASbGncu4mG+rCdkiFES8/5jVcA1UszWlg4tHsYxkNP6GCmCjGZTV0dGx8wgFahTEKQ2
	tmpuWGS/LQ24RHtg1ajXYtFmQN0RGdlw8agO9tQQLKS87fHT1qk/kYs4hIg9gR9BJq8AVhXSVxc
	YC1cz/jxRXhfMgmkyiitwx0bLNYQaVdvjjMJBQ4a17IqtEVKZ/uPC7brkhhBaci/w5GjM4nq58e
	XsSSnwCHu4fW/gOKwsGccO0Ns5z+e9BsBuySX9K3EPcsadhLbHpwyi7s2uVZG/unyLp+RjUqpu/
	OGrO+PUZPmwU1nTJEav3gC1lU/t3zMZ6BReSWRHZo5B+uSTGbP7WnCsc/+hcMOJb4euynn/GUyl
	hUAQ=
X-Received: by 2002:a05:620a:280d:b0:7c5:4463:29aa with SMTP id af79cd13be357-7c5b0d06405mr416387185a.40.1742468083410;
        Thu, 20 Mar 2025 03:54:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdFV9xVqcyjUuzTORF88R0q5+1pBPTL/vZj/baesC3onvB7C6vsCaH9ilw1XKWAk1ufOuWcQ==
X-Received: by 2002:a05:620a:280d:b0:7c5:4463:29aa with SMTP id af79cd13be357-7c5b0d06405mr416383885a.40.1742468083112;
        Thu, 20 Mar 2025 03:54:43 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7a8516sm2247703e87.31.2025.03.20.03.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 03:54:41 -0700 (PDT)
Date: Thu, 20 Mar 2025 12:54:38 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ling Xu <quic_lxu5@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org,
        srinivas.kandagatla@linaro.org, amahesh@qti.qualcomm.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, quic_kuiw@quicinc.com,
        quic_ekangupt@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: sa8775p: add GPDSP
 fastrpc-compute-cb nodes
Message-ID: <mgtqgzra5n4tihgyrvb26pyzfcsupliorc4hvrmh6j4l2zw2gv@ozfjoxdolle7>
References: <20250320091446.3647918-1-quic_lxu5@quicinc.com>
 <20250320091446.3647918-2-quic_lxu5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320091446.3647918-2-quic_lxu5@quicinc.com>
X-Authority-Analysis: v=2.4 cv=BvKdwZX5 c=1 sm=1 tr=0 ts=67dbf3f4 cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=X77NXM8zCmOlsI4LSM8A:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: a3sTVyi0-CiDSnakbmBUvri0cjtQTJYS
X-Proofpoint-GUID: a3sTVyi0-CiDSnakbmBUvri0cjtQTJYS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 mlxlogscore=633 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200067

On Thu, Mar 20, 2025 at 02:44:44PM +0530, Ling Xu wrote:
> Add GPDSP0 and GPDSP1 fastrpc compute-cb nodes for sa8775p SoC.
> 
> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 58 +++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

