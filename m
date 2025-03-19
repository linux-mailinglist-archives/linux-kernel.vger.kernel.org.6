Return-Path: <linux-kernel+bounces-567851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544D7A68B25
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAAB1162C25
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F1525744B;
	Wed, 19 Mar 2025 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eZniLK5S"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC203257421
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382434; cv=none; b=fr7LjXysANw6W79Bq/9A1R5S11r824fCW1RyFjobjUq3qYwAxlNOQbqOjKvnS7FkIWpqO81itx5r2n/JAC7WHZFpuzo5ktC9a8plYOUd7rTCt3jlaF75ulcTuJq86l1h4IcqaV7sk1odpLTvmMEu5Zd7bP6DSNMxlnhpt8xW5mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382434; c=relaxed/simple;
	bh=eRtnfq5G7aZdIB6cxpkvIozQYT4hqFMByiFRG+lqLIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+jLKtRgytwl5sCPYrIY3JqhjC+zOB7WGq2vp6UF4QkaOAqjnUjn/7S8Fussn6qYoJSXdQibIdapdAgLlD9aSxswZ7XmEvNywshRzySYsbp85/TW1iv5G0SafrvBacqRzQLbm1pYkhh3lWmk6Exz6axMLJ0HezAddkeeK7wcIkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eZniLK5S; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J4lovk010005
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WkINzj//g4AQWdN5I6oKqNP0
	5nghNa/+qfEoInV2+gI=; b=eZniLK5SeHPdTvju6T3aKB2c0c6Syu4fMPc6Dihp
	8/cJYZetO3r43AHF0amnNeTPKbL3lfmbkYsgikWs+ZykfoB30G6Fz8pr8ROku2rd
	hEMPZSJ+CMB6zdwj5RiaxX7OCnVX2iPduLtdBOwpeTQHrPPFFNy0WpLCRweAUcgi
	iWyUX8ZmgRS6cg3oJ9aCxHiRPSWIZ3pA4FZ3nV+mLhNKuABQBeTlWIa/RUPWLPeW
	xRTXtqF5lDsm4WTOcLBS3vQI8JmKcZzCm49UDaDSOaRjHGfNlgc1AetqqCflMC9u
	g1nKyZodPkNI/b69c2pnkT3kqrq5BPNKS/eWUFrGTbTzLA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45fdvxj77u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:07:11 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c0b0cf53f3so1077149285a.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742382431; x=1742987231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkINzj//g4AQWdN5I6oKqNP05nghNa/+qfEoInV2+gI=;
        b=Qt65VbB01LIl6EF7tsGzLjlhBKqnf4Xzh7tpND1ENXwx8kaATv1t9l0mMGH0qd1WJu
         FflEde6ougewlhjx5f5XglX6hMq88IzV5OEM1GZ9drsmZD1ezKT0HhNMXbxnXf4D07jH
         pmWgtUtgzPkaOPa8hHEazVjn7gFpawHAp5lxbNfnW05uFdQXak1sbfodqIqIrVSY3ity
         EXKqAj5RnoxZjz0b9/Y1Mu9lwmybISjwQLtPO4SBAfHgb5rq/BNekeEa/1OeJVBCTCYP
         dG2OM32boa1vHWGJvD0OgT2nsG9ONejh1Gxtd1F6Dk4v5dMjnO4yoqVA2Pxia1s3DSVk
         QmCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkOud+zGXCkVkokvddbVvP/SsY75JwvfM3ha9qK5Id8+2YRkrQqzc7VySrtW+n6yosZ0IoWMx8e0A5Pv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTJUsBofv+eLmxQXR1raoA6bqfYrq9uLWnBGrUmvmjwsHXafTN
	SNp6sElpGY3vNjkujJ7qRj+X+xLjBsgKVvtEEsHdq2lXEU443uElTUwn0jEuIreFTuS6hm6j5y7
	cG2+ZrHSuLdA1NNbGRKZV0rdU5L5jGDdTfgeaaXHQJsDPPA0ZC3fB7rIsimXxdUc=
X-Gm-Gg: ASbGncv/MdciXU8lcH8ignUBhwApeeNHnsnLd/ECPH9CmvhBjD6TOudKShcSv50R9xR
	M29ZiYa4tGWg+Qa8UCd8YpcoNqkajr50ZlvgPOm1s4YX9VK65CyPBgbJ2CiFUVmCHwLf29OjZWt
	2qFoS+T3YHvXyOvyzsnbsv9irJx9jC0gOVwqTq+xIGg+lsDAFLfyUoKaHXUI5zmzvs7isQexe+G
	LyNRkqC9hvk0zULJlpDGwOdncS92h3MMpgQ/wQY2ABFwml8rGWVBd6qEBflhsIx3ooTnZzX4OYC
	R3lQlAhmTyyOE96HrjOE8ELZ+dWcDQCykIsnn2ZNqCmLenEwldyGH74bN+unf1TwwgjMCGfQkrE
	5XTw=
X-Received: by 2002:a05:620a:198b:b0:7c5:50dd:5071 with SMTP id af79cd13be357-7c5a8391431mr236546685a.22.1742382430948;
        Wed, 19 Mar 2025 04:07:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsG7eg8axClVP5k4HD+jCjL+jQM+Gse5YAXQd3q6Rvpx7WSfCpRzKGGy/Ceh+qmk8FKSjMxA==
X-Received: by 2002:a05:620a:198b:b0:7c5:50dd:5071 with SMTP id af79cd13be357-7c5a8391431mr236544085a.22.1742382430628;
        Wed, 19 Mar 2025 04:07:10 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0ea756sm22581321fa.35.2025.03.19.04.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:07:09 -0700 (PDT)
Date: Wed, 19 Mar 2025 13:07:06 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
        bjorn.andersson@oss.qualcomm.com, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] phy: qcom: phy-qcom-snps-eusb2: Make repeater
 optional
Message-ID: <tbmte6hnuhafextazzyplec5xjuv3q365hqtvwcozhugb2loij@dtwfpyotnew4>
References: <20250318-xps13-fingerprint-v1-0-fbb02d5a34a7@oss.qualcomm.com>
 <20250318-xps13-fingerprint-v1-1-fbb02d5a34a7@oss.qualcomm.com>
 <6yykvszzbhonc3dkwhva55arsdvp4hv4p2fo2vv6ftwr46httm@wnofgs4jaqaa>
 <Z9qd1GJ1418CbaOt@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9qd1GJ1418CbaOt@linaro.org>
X-Authority-Analysis: v=2.4 cv=SKhCVPvH c=1 sm=1 tr=0 ts=67daa55f cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=opzT4eU6cpc3XRIv2nIA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: A7wiX-V3YqiD6unR0apASDuM-E9BfsuJ
X-Proofpoint-GUID: A7wiX-V3YqiD6unR0apASDuM-E9BfsuJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=699 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 mlxscore=0 suspectscore=0 phishscore=0
 impostorscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503190077

On Wed, Mar 19, 2025 at 11:35:00AM +0100, Stephan Gerhold wrote:
> On Wed, Mar 19, 2025 at 12:20:07PM +0200, Dmitry Baryshkov wrote:
> > On Tue, Mar 18, 2025 at 10:22:56PM -0500, Bjorn Andersson via B4 Relay wrote:
> > > From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> > > 
> > > In a multiport configuration based on the SNPS eUSB2 PHY it's not
> > > necessary that all ports are connected to something.
> > > 
> > > While this is allowed by the Devicetree binding, the implementation
> > > current fails probing for such PHYs, which also prevents the multiport
> > > controller from probing.
> > > 
> > > The lack of repeater does not alter the fact that the PHY is there and
> > > attempts at describing only the used PHYs in Devicetree results in
> > > failures to initialize the USB controller.
> > > 
> > > Make the repeater optional, to allow the these PHYs to be described in
> > > the DeviceTree and for the associated multiport controller to operate
> > > the other ports.
> > > 
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> > > ---
> > >  drivers/phy/qualcomm/phy-qcom-snps-eusb2.c | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c b/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
> > > index 1484691a41d59a7eaf257ef44300827c668bf7e0..8897d2072ccfcaa5b4a510c17761dcdeed5bad0f 100644
> > > --- a/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
> > > +++ b/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
> > > @@ -401,9 +401,13 @@ static int qcom_snps_eusb2_hsphy_probe(struct platform_device *pdev)
> > >  				     "failed to get regulator supplies\n");
> > >  
> > >  	phy->repeater = devm_of_phy_get_by_index(dev, np, 0);
> > > -	if (IS_ERR(phy->repeater))
> > > -		return dev_err_probe(dev, PTR_ERR(phy->repeater),
> > > -				     "failed to get repeater\n");
> > > +	if (IS_ERR(phy->repeater)) {
> > > +		if (PTR_ERR(phy->repeater) == -ENODEV)
> > > +			phy->repeater = NULL;
> > > +		else
> > > +			return dev_err_probe(dev, PTR_ERR(phy->repeater),
> > > +					     "failed to get repeater\n");
> > 
> > Can you use devm_of_phy_optional_get() or devm_phy_optional_get()
> > instead?
> > 
> 
> There is such a patch from Ivaylo already [1].

I will respond there.

> 
> @Ivaylo: Are you planning to re-spin that patch set? Might be even worth
> putting that patch first / sending it separately, since Neil pointed out
> there that the bindings already have the repeater as non-required.
> 
> Thanks,
> Stephan
> 
> [1]: https://lore.kernel.org/linux-arm-msm/20250223122227.725233-6-ivo.ivanov.ivanov1@gmail.com/

-- 
With best wishes
Dmitry

