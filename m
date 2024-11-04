Return-Path: <linux-kernel+bounces-394511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBC69BB04C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43CD91C21A06
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C2F1AF0C3;
	Mon,  4 Nov 2024 09:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LCiSwvcl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8791AC448
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730714038; cv=none; b=PJpWtNGsnIN+Mt3HS4MhEUkYTMvlUvedGXQXDKsmG7or8oI3z9VdoyKsMgcBgjYL46PQEIaS2oBrYA6UXc8q1etSeFEGrDuiMr9CmKku62LPWvdXbnzvoUj42FurxOJNMzAfrTk/yooTGVt/UyZTr1MKuMDQ0hOjlUpwLFglji4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730714038; c=relaxed/simple;
	bh=WkL6kYiCbgctHhWkW9RrQbGup7GAC4xAAedid0rKO70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NdY67CQxwq/hs3DkfSmCGl6pED50dvynJ+a3mouGyGv2hWWPBJ82pD5JRqJKalKpyLE4OifUsIZhmhe+pZ9hEzxHRZAhU0PcUEz9eFu0OHd315G9OpdU7UM0mhd0lc8NytkttFriLqVAjvkaSJDeVZHleMGplFjp+oSyr+opr40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LCiSwvcl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3Mq0eA021752
	for <linux-kernel@vger.kernel.org>; Mon, 4 Nov 2024 09:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	48BbhzMG6nJlrKXOIqS7msafjr/+9ztjQ+P//OS3fys=; b=LCiSwvcltpIsTr4J
	yevfNJVC/ZLqCrYRj0AKP/nrsvkIIrcChljyktNYe+TSomgSkFAXJP6H4PILuhcv
	HFxOtIcXnm08CXdeUD8+vJNNZozBIAY2Y9B+scea5HmYpDfGG9Nk3BkgN6jcghs0
	2wyy/cyl77dYrvYGGrW8ISDs1cXIsBzbv9N0awOBBL2V99Wgm2s7kPPe/fsOPhrC
	nYc0u+cUS8/XwI9LSK1X6E08wyIPjHDdAwwYlWrh/oQXwc+lCzma3cYPNVDBhhIN
	SqlcD9Avl/vqLSdVG0lGvlxpwbXThypxW7Ou2i9U28fGRYXjTKeITvPpoh26Zq65
	pZr4FA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd4ykmqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 09:53:56 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6cbe149b1cfso14433666d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 01:53:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730714035; x=1731318835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=48BbhzMG6nJlrKXOIqS7msafjr/+9ztjQ+P//OS3fys=;
        b=S53v4Dhp02KV4XCVftC9caMixM78p5I/y5sLebC3b/xsZpreWKfqygEVqbo1D9tNVl
         q5RrYyJKIpwXK3Km67uo6SQ+4tVxeZJGqtmrITeI1Snx4Fr02ZrCVhfzZnUv4ZJY40YJ
         PXzEVguVDTAJyfIoMrZlmTBSGOSBGFduV/w7V3DQNARUK56cCps6/9vQUTIYXqv3EwUl
         GCHSaAYT5JsTG3rAxzu4WmAv9h9g881XjyhpYI/ylZ9/yCGVxVAH+RuqgD+aYkGuKVbb
         /vQTsbvQSWeWjjSMN/3RZZywGcdfq+FmGA3QDz9VnrzcpiItgxMMUIE8W2LBzj9bPvky
         mgLA==
X-Forwarded-Encrypted: i=1; AJvYcCUd41A5HyiYPVaE+WhAnuuJJB/ulzmoIuZtgMKBA3mBbQ+1VSA0MhaXJAKO11Sfvjr8uTjBmO+2/0Pcufc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeexhvbqVPr2Q7HxHpPLx4VzdljQ38QfNdTNqsxh8+uk+79v0D
	BwV7MAkhBvZBzag4mAMfVFXahcKF99ehJM5hd/ekHyB4F5Zo0Z+QpbvByMEB8HzT8DgUsLKg/Ec
	vwNBoNhKfot1naDbdrrLOVNTyDeKFuLOpiUhXgYzQ6tK0+6NlyiHCm8NKHOHdrPw=
X-Received: by 2002:a05:620a:4443:b0:7b1:1313:cf42 with SMTP id af79cd13be357-7b193f73494mr2113114885a.14.1730714034906;
        Mon, 04 Nov 2024 01:53:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtxe5uqc7MvnqsqyGo/b1+j/YoMPpCIwglJ2JELVbc+hCFY6xRwAJFk2Rx8PoXnp6hGWQDww==
X-Received: by 2002:a05:620a:4443:b0:7b1:1313:cf42 with SMTP id af79cd13be357-7b193f73494mr2113113585a.14.1730714034624;
        Mon, 04 Nov 2024 01:53:54 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564940basm538280066b.17.2024.11.04.01.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 01:53:54 -0800 (PST)
Message-ID: <07c5dbf2-8ce7-42fa-a511-3dc22f525325@oss.qualcomm.com>
Date: Mon, 4 Nov 2024 10:53:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm: Check return value of of_dma_configure()
To: Sui Jingfeng <sui.jingfeng@linux.dev>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241104090738.529848-1-sui.jingfeng@linux.dev>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241104090738.529848-1-sui.jingfeng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: _ry_DMray1axku3EeMl3g4uc_pHyYhyS
X-Proofpoint-ORIG-GUID: _ry_DMray1axku3EeMl3g4uc_pHyYhyS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=933
 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 phishscore=0 clxscore=1015 adultscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040087

On 4.11.2024 10:07 AM, Sui Jingfeng wrote:
> Because the of_dma_configure() will returns '-EPROBE_DEFER' if the probe
> procedure of the specific platform IOMMU driver is not finished yet. It
> can also return other error code for various reasons.
> 
> Stop pretending that it will always suceess, quit if it fail.
> 
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

