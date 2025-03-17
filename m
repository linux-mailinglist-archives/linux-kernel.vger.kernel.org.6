Return-Path: <linux-kernel+bounces-564321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF028A652A3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DAB3168120
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F54D23FC6B;
	Mon, 17 Mar 2025 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pMzVn8/d"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6437D1DFCB
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742221036; cv=none; b=qZdDKwBgJB8UBr189hfFVXJgpcsiFaH+BdC/ybgjzwLI2n1iTowNL1x5A/nNdzEN/qCF1Nl6k6dd5n7xIPHMnCHF2TPmVYj/qmHpMMhHZE8mgOvNVmjF2YHsXcS08vmRoFqF76gV7JpR0ZCxZNK7Ag39IgGnzLP5Rr+CY6fCv1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742221036; c=relaxed/simple;
	bh=ohiCRF2x3tHxLhT7PBC7mSuAfBj8jed4k4b81XgIkyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8aQag2rHuIDe9cH1zty3qqt/JzCvAl3zNb07NKcKYuC3Qm1x+L3FYk8kwXybPE3NGofZHsEsq0eoVM4t4myeyFZDzDjIlc+BrggB+3tgTOt6VLMd+hY9pve/pVxJsWgM5CDhTJz+p3E1F57JXh6l8qDPakTTbqYiquotu9x2qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pMzVn8/d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HAjPGV026060
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dHzEvf4fI2IHIcn3utQgPXJS
	us3uTGB7Q5bFT3oEIbA=; b=pMzVn8/dEL9s/x5XFfE9jXBqtyi5HZyemHl9NUWr
	juHTFzQGt5HE0e3kzJlVzRQO2azI1oswBzfIzHi7DFf4yosaNfsfIOl/KroMyMwy
	cLzqYY+NA/b/J7nwXoCDegipuKufUZFFfMuipNogFdhKP+dtvX1gootaeZA1EW2c
	pHFUCTrHRXEVdJgs3BLIAjpMvIukiwbc4x/rkS7qmz2SW8DDhLR7cu3GtfVVDfg2
	GeqrVn85ytTToMQDliE0L7xKssuRqbr94phK83xoClgy8W65OHRwSID5N9HRAumb
	LpVwU3y0L+XtzdZXyDEV4lCnnLJMOU7lv3C4YpKa9NttYw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1sxvwxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:17:14 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6ead629f6c6so97516856d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 07:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742221033; x=1742825833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHzEvf4fI2IHIcn3utQgPXJSus3uTGB7Q5bFT3oEIbA=;
        b=gf3g0Tatu9GVUvE5e38VgBUfrwKrZgy+5R9t15lmy4ymAs9Yy6BceRDBxLTqqh9dP4
         j0II/iHRRqgGjy1B4GZURcxo29qoWAN57PIKKA34xv4w1LUEUoZZ60cC4SxJaBizyl6+
         SXiAWM5lB6136Nxz+isl6qfQV4JxRhBBjYNg42HMl1508l2AOu8xVV7xCwISkizJHBIp
         kdhZ7+ET2AOTUrnxKq7bkytg50Dx+8923iybBbehXwDo3ebQ5odq/X+2fnBq6ArcEAz7
         zaTbjlcBgoaO//SMKclD0NL50xzd1kTBB6A/kFKRFO5/Yj6Tlsvt9wJ2oc+BB31PlduF
         oTLw==
X-Forwarded-Encrypted: i=1; AJvYcCWij8UqoL75abjWNb+Q2C8eW6hRMWQVnATMO33kb/K0w6g0iwsGjvW0Z8g1ekK0enhew3+sQBS5V5ucdJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSno47B+KxhlFBfckVuOyqSNFv5/v+Zl+T91Cq8CadTVSW/Bai
	DXSAsX8joYrlahdRekW1WhkcFUXFkupz/4CEBsefEwNl3nuBA8PauqPZrsJbZ709as99LwzR8Gm
	ncMMvgnnrh22GLrwnzBroAivGfvyHHjTZ9vcLrsNHMNoAGiPu89RPUiiv4Qxz6hg=
X-Gm-Gg: ASbGncvctzAzD5zeH/vvzlTLImGdFPVt59fCKdE93OYGFRXD3kHABrCfJVFxI2YNjC6
	13JFKBzikGakmjPWsElym8aaaqFnrUF/04g4udS9z42Cz1zBHlYU0I7gpiI9BZPwPjMf+OiTW3m
	UZ8tE/r4XJGIW/KXyaf2jtKH6kwT5SEogbjnkWwm9g3/yix7UN987UmywrVizogqb3jMmYQV8ZP
	P3eAkdtwaxAYiWy/sSZ/t99kkLAdUVh08E4H+ff4AqvYM1UYtkhUsCDZ34QHXgDNsHdnRCZra6u
	RIF9r182/TE63tn8a4Ag2mZHO4NF2o/KHpXfsxy7tk8cu0FuHac+Q2XdO2pDUPnwuNCD2LC04na
	pQEc=
X-Received: by 2002:a05:620a:1a0b:b0:7c3:cfec:39ed with SMTP id af79cd13be357-7c57c930d34mr1948977485a.58.1742221033296;
        Mon, 17 Mar 2025 07:17:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSqQBlxeJyM61KMz5SPmsfpFKro5+Daa5VE8BmqtspssWBndACnzyHtiQlOgipSrJ6+Q+MiQ==
X-Received: by 2002:a05:620a:1a0b:b0:7c3:cfec:39ed with SMTP id af79cd13be357-7c57c930d34mr1948973285a.58.1742221032975;
        Mon, 17 Mar 2025 07:17:12 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f1da681sm16091911fa.93.2025.03.17.07.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 07:17:11 -0700 (PDT)
Date: Mon, 17 Mar 2025 16:17:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maulik Shah <maulik.shah@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qcs8300: Add RPMh sleep stats
Message-ID: <7mpqh3ggkjwrw4amfyycmcy7wwbh445scnmimdu7dcatovrmaq@wu34owyddfc7>
References: <20250317-add_qcom_stats-v1-1-016ae05ac4b0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317-add_qcom_stats-v1-1-016ae05ac4b0@oss.qualcomm.com>
X-Proofpoint-GUID: VDdvKFJ_WkVT-7zu7aiGsoQDrc5oimmN
X-Proofpoint-ORIG-GUID: VDdvKFJ_WkVT-7zu7aiGsoQDrc5oimmN
X-Authority-Analysis: v=2.4 cv=XKcwSRhE c=1 sm=1 tr=0 ts=67d82eea cx=c_pps a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=u0qyRW6OvflAnhphvWgA:9 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_05,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=832 priorityscore=1501 clxscore=1015 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170103

On Mon, Mar 17, 2025 at 06:08:41PM +0530, Maulik Shah wrote:
> Add RPMh stats to read low power statistics for various subsystem
> and SoC sleep modes.
> 
> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

