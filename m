Return-Path: <linux-kernel+bounces-528931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DCCA41E23
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99202169BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA95124888F;
	Mon, 24 Feb 2025 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DDTg2Vxl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7729724887C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397612; cv=none; b=iTI+1T4HcAwHcNdA+sVmyoRLBg9gAxB6iS2UfKF3vYH4LIAeCZ3TvbkVI1SmXShhRIi+H4ThHD/HVEymLuATVJQjnwpkOC+9l6qNzcsJdutisP2stHodBd3ZDHyNG2r74Jt5XRgZAy7vVp44cvNTs0vKR5OZwvVOY/zisEF7n7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397612; c=relaxed/simple;
	bh=XBF0vElKHwv9izTK+ZHX3O5WdWZ3wV+1ORfUCZnBmCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzVpTVnKEwrxjx3MWifQXsxviVQQJDbuK6qbkIAwZb2R+FLrAcm3yEwq8hIpJqwUAChqLFwSLuYPzN5q44lw7pkWzBekLqf3pQyteJ7TRGAmNdca0USFzAHE5zPix1eHUR4sCgVywH6ZI0foG5GXRNCFDscQ9rN5IRRtJt+uvq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DDTg2Vxl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O76se3024811
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xa3GHQtmXXvUkIsS5ubfpH9d30YWI2ILON8s0tgJN8A=; b=DDTg2VxlH5n0g0p4
	EtdCiksujrsoUdTC21uB1k6cHMu0rB5cGagKQn9dknbgSWfaGpX6xBKTKfw2+D8Y
	Ichq3PMP8c+YiJvJOVdVmmuQtuisV0djPd3Bph7Qhel+oejA6qPBQQDtZLPsBlwy
	5CHISj7r5Wdmlue8a0itnCXCIVucqzJTekbYgq4ddu0E9hgMUAK3McwGSESqPyjC
	t1pRtesBp+EBQ7jEbsKYt/B54vwcj3XP05gPWJ2VfKYTKgyGNQrVsC1SjO8fHvj8
	EaMzxOM3J1hkPcrG6u3W/596tXyxa5CwRMu/aCy5m9Wa0P5tR0NJ/BGMPx2S9anp
	W3teAQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 450m3d91dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:46:49 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-471f691c847so13069041cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 03:46:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740397608; x=1741002408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xa3GHQtmXXvUkIsS5ubfpH9d30YWI2ILON8s0tgJN8A=;
        b=PpPxO7/2/MJ4QloveGYJT9wYanqdtK0oSuLRf07qGsRIjrtmnr32g++iD2G6c+olTg
         FUl0fy5Ub9htDtZgHIkwdcd2zYSvyTp9wtDne9NU6oxINeGBOjiDKSJhDsPvPmyFLKl4
         kZW6mAd1qJId2NdAeUoBbFTqJMn+5h2joDvjT21gLRg3HM9GKePLcr4Gzs2jOnPSjLGc
         /hc4mLZxlVpRScdANjK3LYt5k594kJPVm/mo7fMnnzR6zafTNdps+nHD+NjoxxgjoVx1
         uSjz3AxwV2t7DkfcKZTNZzFx0cZLD+1EGZLEbjOaAng21U10GHEm77MgFvLpdzLdNkWD
         uJWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM/BOfaMG+z1shWZgoEwbGis/ddZM1XHgCj/mfUTyrn0hcb6dtc2bX5ezrVawAvQ0uji3edGeo5XmO+40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWx7fHZCoCbjMaCi80w1i+EHBr/ebaDoSmuF2e06xAg3/WvTRz
	9ulzpswbcypTCRYp4n9TqVfPN/dmxpdWPkH6b4qxVFAmAYU377eJb2NLqls+NzUz4OP8ZjdKr9N
	Px0QMoAoFOsDW/jicJFiCxQOZLA2fWFdJSzrcaZ1bRQiaLX2E/TzZ0GhTgCpZeZE=
X-Gm-Gg: ASbGncvV9aKMbqtk4vqSime8h/l0q3DIoQTg+lViUMbxEQk1e6j5ETxfMO5ea89YQf2
	cIYWn+eVZWfI94gmOOdwSccOLO8wzVQ7vk3k3oW+yGzj+a/laQB9tiB/wpiUZa5mXUtWpFpSzIu
	wnUCjZFBRS1YYjiJcMBH7L3sL5c8h3lp5++JbLOTaIxQz1GMmYOxyxGDAkAo1SVU610eHlsynC7
	/78gNXDevmFQPiiVbLbnEGXRFyfI2dZZBgT20887TTdUa4JqsnQsph4R/t9VUONhcIgqPXkvGMF
	Ala/20vi4I/1x6Pb0XaYY9FOqfBVE0pmJ3kojApRGaq9AnxVfEl9p+gMn1aZorI5gm9G7w==
X-Received: by 2002:a05:6214:5190:b0:6d8:967a:1a60 with SMTP id 6a1803df08f44-6e6ae7d9a09mr65659866d6.2.1740397608193;
        Mon, 24 Feb 2025 03:46:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+5WWCtb4qyPi6Hdk7FQSLpQ7/kRF6GbZ4urrGS273dUwCcdOpWH2AW2Megucz8XI5EO8lng==
X-Received: by 2002:a05:6214:5190:b0:6d8:967a:1a60 with SMTP id 6a1803df08f44-6e6ae7d9a09mr65659726d6.2.1740397607829;
        Mon, 24 Feb 2025 03:46:47 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abba9bd6e22sm1409071066b.121.2025.02.24.03.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 03:46:47 -0800 (PST)
Message-ID: <ea5de507-1252-4ff3-9b18-40981624afea@oss.qualcomm.com>
Date: Mon, 24 Feb 2025 12:46:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] phy: qcom: qmp-pcie: Add PHY register retention
 support
To: "Wenbin Yao (Consultant)" <quic_wenbyao@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: vkoul@kernel.org, kishon@kernel.org, p.zabel@pengutronix.de,
        dmitry.baryshkov@linaro.org, abel.vesa@linaro.org,
        quic_qianyu@quicinc.com, neil.armstrong@linaro.org,
        quic_devipriy@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250220102253.755116-1-quic_wenbyao@quicinc.com>
 <20250220102253.755116-3-quic_wenbyao@quicinc.com>
 <20250224073301.aqbw3gxjnupbejfy@thinkpad>
 <7ffb09cd-9c77-4407-9087-3e789cd8bf44@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <7ffb09cd-9c77-4407-9087-3e789cd8bf44@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Av8E--Hb1DuKbim8vTgm9deyhZSRFB9D
X-Proofpoint-ORIG-GUID: Av8E--Hb1DuKbim8vTgm9deyhZSRFB9D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_05,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240086

On 24.02.2025 9:46 AM, Wenbin Yao (Consultant) wrote:
> On 2/24/2025 3:33 PM, Manivannan Sadhasivam wrote:
>> On Thu, Feb 20, 2025 at 06:22:53PM +0800, Wenbin Yao wrote:
>>> From: Qiang Yu <quic_qianyu@quicinc.com>
>>>
>>> Some QCOM PCIe PHYs support no_csr reset. Unlike BCR reset which resets the
>>> whole PHY (hardware and register), no_csr reset only resets PHY hardware
>>> but retains register values, which means PHY setting can be skipped during
>>> PHY init if PCIe link is enabled in booltloader and only no_csr is toggled
>>> after that.
>>>
>>> Hence, determine whether the PHY has been enabled in bootloader by
>>> verifying QPHY_START_CTRL register. If it's programmed and no_csr reset is
>>> available, skip BCR reset and PHY register setting to establish the PCIe
>>> link with bootloader - programmed PHY settings.
>>>
>>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>>> Signed-off-by: Wenbin Yao <quic_wenbyao@quicinc.com>
>> Some nitpicks below.
>>
>>> ---

[...]

>>
>>> +     * In this way, no matter whether the PHY settings were initially
>>> +     * programmed by bootloader or PHY driver itself, we can reuse them
>> It is really possible to have bootloader not programming the init sequence for
>> no_csr reset platforms? The comment sounds like it is possible. But I heard the
>> opposite.
> 
> PCIe3 on X1E80100 QCP is disabled by default in UEFI. We need to enable it
> manually in UEFI shell if we want.

IIUC this will not be a concern going forward, and this is a special case

Konrad

