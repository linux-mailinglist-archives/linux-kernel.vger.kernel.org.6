Return-Path: <linux-kernel+bounces-552552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5CAA57B31
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 15:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272E116F7D9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 14:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F62B140E30;
	Sat,  8 Mar 2025 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TkV8Zhyd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5651FC8
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741445238; cv=none; b=VXzyesl1qLSw+/zoX2klZjDEvonsFu4uJlyTKTNYv96pHAM1UIs1JKDAEZ+wNMb0Gj5gj0b8NsVab/w7mCd8xnaF4eubSt0arnZ5HXFS3Bc4csJs0V9urHScyGC7gBWvt/C3sFvB2TpMzzgTKzS2ZjIB+nzzys3RBQuTluNqr6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741445238; c=relaxed/simple;
	bh=gsN/xsqpsRkBhcOfZ/prflDYdB4FOnDB1TF1bw9c3H4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c9XMaAtImRqKwuxpzBePm/1+RFhipXxfEjHicNufxVhg4tdo5sA6knFLfcWDYQqMCrFNDkN2uG6tKSVBie1lfrCLa/TF6ulu/Edj2CY1MMOqQI2xH1V1qE7dBQoFAhjBRWPQaPZVpyVpKgC5xSHzDE9c8xRsg2UyfQpLDMeUBqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TkV8Zhyd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5285MvTS018425
	for <linux-kernel@vger.kernel.org>; Sat, 8 Mar 2025 14:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+BjdVXwyw/fx70+++HEMnV+f86rTMIrdIRjlKOij6gc=; b=TkV8ZhydYX/0vKp6
	2i13ngNHI/RqR3PJXemn+VGAks872GbzKvLDZGqthPVU17MNjxWkQ1c9gFzxuhjw
	52Wop2wH9I8H3fakluV4B/dlX+VH208lCgvtRqWxFFJ9iUegJuWFu8+yFUHfs4s7
	xTod/CWH6VGRTHmFKCcgb5AEjXtLerSSX9d59aRroCzwgr6emM4URcXoTdhraEaM
	m5HVR5Ykn1yiN5OdGQyI/4XyUaw4a/aEQAwgr8aZKpGZYX7te6sfBRxRe5uuEz+Y
	CQH8t37yIx8I9tpsYDVpE45cWxS0lHUpm5I10UHvy1Rc+iRggesmsI7UNN4Y7NSv
	7gSNzg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f6a8pxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 14:47:16 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8fec7ab4dso5688676d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 06:47:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741445235; x=1742050035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+BjdVXwyw/fx70+++HEMnV+f86rTMIrdIRjlKOij6gc=;
        b=kcFMentw8HYuKdc/cZ7qrOhmQl5/Gb7/A+450bxvDRStf5cooCDnQmEVv33r5UOxtB
         xK3Mw4qOKTzjBR2qxj6fweUtg37kkpH015dmLLeCQ0jgctOm+lFvhn96BLAAfKqgSjNV
         /f3RlvPk+3OK6Ihq+qHTppgivEMBF9G+g0CBp4+hthcVD/16WriSsCV7QIOUb+aXc+Ay
         DwlfErNpuFyNmEQK5jnXgl59PC4QG2FL1cH9Bwd6dNa7FV9CKtkTZORqEMU1vre18rDH
         tai6tDFc/E0WTDupvhtf+pGqHPEKWZnOW6x9UZCDV6Cta11h6SYJRMXNYUVlwT7zPnHl
         t9Xg==
X-Forwarded-Encrypted: i=1; AJvYcCV32/6T/no0wV8M9G6HvrVd7Xe5TA1CEB5TDHy4wf58IoBvUgMzPe0NJor5PaM9iXbuefFeoV7NXMY1Du8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfjzLmJK5DR/xSmyac51XzrJvtwFEMkBIf3toiWWW+tIX3wA5h
	72iXcnfA/ME5s9nwhwsy77Uur0OIB90/aUS+k5kltFYMZZqqjzzYg0d7wnRg78Nv840uFOej2dD
	NfF1TefEh/v+IK/nwn80CWfG6rRwzzAxQ/6SZkEyLgh54c2YukTAJcIsTzzXqI0I=
X-Gm-Gg: ASbGncv/RcfqQs3hRRBHGTzOdCaXlyaXefggTti5AlFL+fEHXEXFw/k6uizU2cd/3bB
	vSm2drCCg0FTJglcsxPY3JbzmPUPzh6xraxriQGpZcORK1CCbbIcMPxj+PKhGdMT1tlsxsRxvTS
	htD6r1UbItAHgAOcDloYoA3JHcyiJrStweuFHlEJL5PfjjJ6CYSbMy7+YG/7QJnufNm07/t1hqC
	tIOvitAhFyg7WMJiIPIrHiE+rUI/TSeAh7ZcWvDUtE/7C5rcHKmVWpR6X9BJKXMxoa58lPxQY11
	HUd89sz9VccyQR60+ZRruB36YLYdbPELAj2O5olqMqFp2EP6U2vsXfOfPZ8xJEZWshKbSA==
X-Received: by 2002:a05:6214:f02:b0:6e8:9f7e:8116 with SMTP id 6a1803df08f44-6e908cccf88mr16721236d6.5.1741445235263;
        Sat, 08 Mar 2025 06:47:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZfKBeScoYu9shl6LicoB1RqH+nVX7JCyGGylHAdSlW54oABC5nDoOkt3k5yZn9WprsBe79A==
X-Received: by 2002:a05:6214:f02:b0:6e8:9f7e:8116 with SMTP id 6a1803df08f44-6e908cccf88mr16721106d6.5.1741445234947;
        Sat, 08 Mar 2025 06:47:14 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25ab328b6sm269547966b.124.2025.03.08.06.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Mar 2025 06:47:14 -0800 (PST)
Message-ID: <7ffa630c-bc1f-4979-9320-5cda611203e4@oss.qualcomm.com>
Date: Sat, 8 Mar 2025 15:47:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/23] arm64: dts: qcom: msm8996: Add missing MSI SPI
 interrupts
To: manivannan.sadhasivam@linaro.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
 <20250227-pcie-global-irq-v1-13-2b70a7819d1e@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250227-pcie-global-irq-v1-13-2b70a7819d1e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=WsDRMcfv c=1 sm=1 tr=0 ts=67cc5874 cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=x0-Ntm4DP0gVEan9CnAA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 2fhUEj7_978d21_AcrYxL_huIcnL-iYc
X-Proofpoint-ORIG-GUID: 2fhUEj7_978d21_AcrYxL_huIcnL-iYc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_05,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=720 clxscore=1015
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503080111

On 27.02.2025 2:40 PM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> MSM8996 has 8 MSI SPI interrupts per controller instance.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

