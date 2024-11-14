Return-Path: <linux-kernel+bounces-409330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AAC9C8B5B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33371F24F10
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0052D1FAEE3;
	Thu, 14 Nov 2024 13:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pUK75waX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF201F76C9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731589434; cv=none; b=ggWGCDPuVKfkIflcecs8JR8IgdzBZ34rX5MhbzkX/WUVNK5ddW2VkaHk5YdJePg+zo9pPwCGbg3dXJsg+ek9LFYrPxuc1xwl8tHS8OfQ2S+YqUyhZG5EjRGybMa/8QTMvdqYF2jN8kPDFasGAla/5oiyn5Tyh3iXChST1gxfAvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731589434; c=relaxed/simple;
	bh=2G6eM658ZFvz8hDEvgoZG78f6jBsleiI6GiFLOinTmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DfouzluxSQ4r1UbQuaqZ2u+gfxtjWvN2XcxRqiSRAhzOLH/1RBk9l7VvsL9N272dmiJXioXFK83w4dQYhTS4WVuzOQFNtyekloL+fa/jT72+y88CHtWDvAE+2YZyHNrsjJzAKbylNMxk0erRhgBBrcMI+a2elRzT7NwTMqCH23g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pUK75waX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE6MrVi015461
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3ZZcWhAmp0MwkK8bK9XV2sb1z1aD0pNV4AZR5fU3yro=; b=pUK75waX+UOkWlhU
	JvLfW/zTEDxs2oUt4liFkL9LPh78Jm9smXkn2uSzeErZ8dpTZvwhbSO3ff2BLI0m
	eP7/smIQNqJfnr1uO5jNvoWjNwWdtFQXylUoMP0194F1IgAyThwoP2DWhCgmQLpJ
	s2Oq/bCkLAzCtgKmrLN9GN4beL6K5QdHOP1tOTwu6ufx463Ud6lkOac3KpdfdhqE
	U2QrLMh47x7B7FOW/SsjJGKAFgrJz/LnHK0VI0LfL0HN8OdW8ExmaywYibJpkl86
	caIVBZt0LIHsI3aDLmmZPH7VqcIuft9TU4vLD2+g/HPyEliupKfNFL8jlL/EJFNx
	F4Nnfg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42vsf3526t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:03:52 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-460903fc1a1so733181cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 05:03:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731589431; x=1732194231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZZcWhAmp0MwkK8bK9XV2sb1z1aD0pNV4AZR5fU3yro=;
        b=ZRtqap9ePAkvn5122qYGpcAMoxbJzEY1gTDHaBlrT3NDZfos09P9yrH+WfbUnZVtwF
         IfliS3eb7LHBFV/vsmAUYBBRLkNcsYZScC6nj0GRf9h6iPoIowUeem0TpGOxB6mk0Wmh
         F2sL84eB7biLwC+jgY5CJ1uDEQUoHkUSVAVXafLb4TO4tDWhb7E47zWhqznwrRMmWqVo
         8rJTflbw0Xn+CoDEpbhn+d7QG7iGaBxHegMZXVDOFipBZosSookdnwT5xcuxivuJ1rxI
         6IsTjaRrRcySeugs+1f+ExJhZreDGIFUTi50EPCnlz9bPhxBy9PJ4ohuaWkEutVAdjHj
         POEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEhLlN8jLBECWVHI8eWqStt4RA2WV7VHet/KLprjwq3fjjQkx0KhnstzWF6Rfs5OPg7CmjO69nA/1P4hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS3XyaJEj0WbSo/pHfMfv9B5n4Ddu7FSY8QH5irxakhBXg7Mc7
	7zzSF2PGluNvlQxT16lvd46xfHNQOcyCn9UjlU7T5Xkhf3L/hHpgB+ou+W0e5Ggi8KKHawhE+v+
	kB8rHKJIaQzZ6ZecxGhud5TLAt9eyUhuPU0H/YXx8KwJiliYVP6Q+Te0n7iu5ql8=
X-Received: by 2002:a05:622a:2d5:b0:460:e4a7:a5cc with SMTP id d75a77b69052e-4630932138fmr142890171cf.3.1731589430701;
        Thu, 14 Nov 2024 05:03:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEP3QaPpWVWBZ3W8LyJufqB+7ivCzeohYgjPf36PLkK5kVzR9ipztbc4QUkkkBD2kaZQk5ryQ==
X-Received: by 2002:a05:622a:2d5:b0:460:e4a7:a5cc with SMTP id d75a77b69052e-4630932138fmr142889771cf.3.1731589430119;
        Thu, 14 Nov 2024 05:03:50 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dfffcbasm61006866b.111.2024.11.14.05.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 05:03:49 -0800 (PST)
Message-ID: <0509452b-586b-4e06-b344-6f68af4593f0@oss.qualcomm.com>
Date: Thu, 14 Nov 2024 14:03:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: qcs8300: enable pcie1 for QCS8300
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com, kw@linux.com,
        lpieralisi@kernel.org, quic_qianyu@quicinc.com, conor+dt@kernel.org,
        neil.armstrong@linaro.org, andersson@kernel.org,
        konradybcio@kernel.org
Cc: quic_shashim@quicinc.com, quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com, kernel@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
References: <20241114095409.2682558-1-quic_ziyuzhan@quicinc.com>
 <20241114095409.2682558-6-quic_ziyuzhan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241114095409.2682558-6-quic_ziyuzhan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: hMXoaMG39_SFZkAS1LcBnbMeOIar80PX
X-Proofpoint-GUID: hMXoaMG39_SFZkAS1LcBnbMeOIar80PX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=543
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411140102

On 14.11.2024 10:54 AM, Ziyue Zhang wrote:
> Add configurations in devicetree for PCIe1, including registers, clocks,
> interrupts and phy setting sequence.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---

Pretty much identical comments as for patch 4

Konrad

