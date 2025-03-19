Return-Path: <linux-kernel+bounces-567854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CC7A68B32
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFAB8169CCB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7C62561AD;
	Wed, 19 Mar 2025 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a+2BTofQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A310B257426
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382530; cv=none; b=e3CkO5YTTbfHhg1D/UDupOELrhNIy3b9hfCuYrHTQmWdz142RMOogIhUn97aK2htyNJUkz2S81IVs7y7anhdcaOD6SvqbKhfA1RNYetrWwG2NPfzWmL5w8GNGFEORWr/FmB9dz1EsdItOgKzXk9/uvkhNJd52MxYHMs3zEURj3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382530; c=relaxed/simple;
	bh=7kVuE2yalymm0zGrNn2VhxNQO2hWeUQJHMGJHJYEtkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJK9HQxPvCMPPPukePbYP7+0qpQVvymr1/6O3O27kNC2ft9MacvYhumClmnsGi9ygnTDl0kY01un7rF1pVF5khFQVywLq5g4CPM4NKe0pz0B2FI5aOX6yy5q2/hB8G5PvFSPlZQbufPPn8LK5x+zoN0rO1TAtuhK6ipwHuWZFgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a+2BTofQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J4lipW011997
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WzyptaVYzzRiiqOe580gou9y
	L5Xd/cRhnh+9PDrH8JE=; b=a+2BTofQxHcdNpEBdZY25rpiValaCN5Ck0hEsoDN
	7Sp9HN/LZYdY3nxuL9e9qiQ3dTFCh3eRiUyvjMQnlknVkikcOrOId0Jeng7OHVYG
	TZgx15kJvxNXIFVh7t3a1qPsepi2b3jV4aa6dQQa5SDt2k7X2TjxCcZF2rWtfSa+
	n1G644PvPuqe0AgbIVdio2W4kt7vRpAau/DnpkLGiKa/aYlcn21GFkJQ4pzaMb4z
	c8vrrK9RRelTkYLkgFAsbEJWZY/01y/PZbScZ/gVTb12/kh9A4pYtlCbu64CB4ed
	yfWlYtiR+EtpCnGsIn19tdDmWiytNvFgPnBn26ERnvEbMQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45f010mwqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:08:47 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c0b0cf53f3so1077308985a.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742382526; x=1742987326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzyptaVYzzRiiqOe580gou9yL5Xd/cRhnh+9PDrH8JE=;
        b=h5Y1wVtQmIvoi/H0E3Oua6XzS2qrfmMN7utCdjcQOMEaI7r6QijbqQHuIFjG1nBEr8
         /bm4de/g7Yu6H9egxXz0hR8lsRSQuG5miA8yKwy+9OqKgRGjS1Z+ra7L3iQ4gXw4WOIy
         ImUQk7eozFgxxaqgaDR6Rf6d74rtbYLxhywF2RYjFm1VNGyRBTY/zhOdM46GlrJWEmvE
         sR1Q/gUcyfeJ3vxPXVCIi7AzsoqSe9H8jsfwUyNmaTEREQytnIJWolyaG87MIintrPuH
         tml3NQpxR9Nr5py4S0M5FUK28eUbz4u3csl+lbU1W13LaO1ppMnks2lRPErlozTuvOAy
         v9Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVeOvPyFC9XyjLFik99iEIcmIZLksD4ZB9WJ+OJkiwHkcBFcn/doayuLYYBG+9atEqlVDv1RvNZy99zWDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5JAROL3gtTRKsM51odk0h/fZ/fLjtOF/9IHuMTM6ht+UdJ2VI
	jzbaJRJJWBpW74mTbBzhDNB4w6Y9fEUQ2/6YGmye3D+OQGV39XdUtfrN9y/zliNWT7TIa7Fvava
	EfEvBZU2g4mdFzxNf/SlfSdvnYLFyEgBcMBky4fknqtcZuRhhlyFss/TvDNcjo4g=
X-Gm-Gg: ASbGncvzJ5dfE8uftt/cveLipYuYq5gVbRjHO2cHhR0GfrMCAopIbTlSrA93X8CK2pB
	SpoBAf24Uvn+xzK0uL2+XH1o25DyrBLsg31f5ndG3R5lMOI8iMQ1tzjorq+rqYLi5sZ33OODZ4E
	LeSEwzJaavhieANP5Vpod5YM/ksgw2RiBbXUS9LfKTXOXBCDM7Q34I8ZGyxzQXAmTdjHqdBQNWG
	cAiYi6LO74Htmm9wOYhRX1UBnybniq03c7M2bN9NYilItfvdPB1dqZhL2YVsOz4mMCG9N/wByIk
	U8NrgL8mEuzcdOvw1+VkrPyU7+EM1rM5JhEA0mGb2WqSyDmVPCYuK8rPEsFQWUQdU4Om31D9/z+
	Kxuo=
X-Received: by 2002:a05:620a:2a02:b0:7c5:5cc4:ca5c with SMTP id af79cd13be357-7c5a838ec42mr250546385a.14.1742382526273;
        Wed, 19 Mar 2025 04:08:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZcIi2ghP6ESmSAMRKD4aGrSgNmlI2K/vEMqdFO+ac+ilM5F3UbWyPluESd1UDuKYaE54d9w==
X-Received: by 2002:a05:620a:2a02:b0:7c5:5cc4:ca5c with SMTP id af79cd13be357-7c5a838ec42mr250541485a.14.1742382525800;
        Wed, 19 Mar 2025 04:08:45 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864c12sm1988818e87.157.2025.03.19.04.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:08:43 -0700 (PDT)
Date: Wed, 19 Mar 2025 13:08:40 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] phy: phy-snps-eusb2: make repeater optional
Message-ID: <sxrae5pmykx6ul2y7uc24fss2kdeezkkom7ev7mavt3fbc6ckv@tghyp3whuxnu>
References: <20250223122227.725233-1-ivo.ivanov.ivanov1@gmail.com>
 <20250223122227.725233-6-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250223122227.725233-6-ivo.ivanov.ivanov1@gmail.com>
X-Proofpoint-ORIG-GUID: JuwxQN8dnWLXu-JdH1SkFYtF3CJpI0Us
X-Proofpoint-GUID: JuwxQN8dnWLXu-JdH1SkFYtF3CJpI0Us
X-Authority-Analysis: v=2.4 cv=G50cE8k5 c=1 sm=1 tr=0 ts=67daa5bf cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=pGLkceISAAAA:8 a=XJ2MQsQTle-X_OudA-YA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=818 phishscore=0 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503190077

On Sun, Feb 23, 2025 at 02:22:24PM +0200, Ivaylo Ivanov wrote:
> Some platforms initialize their eUSB2 to USB repeater in the previous
> stage bootloader and leave it in a working state for linux. Make the
> repeater optional in order to allow for reusing that state until
> proper repeater drivers are introduced.

Generally "works as it is setup by the bootloader" is a very invalid
justification. Please don't do that. We should not be depending on the
way the bootlader sets up the devices, unless that _really_ makes sense.

> 
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> ---
>  drivers/phy/phy-snps-eusb2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/phy-snps-eusb2.c b/drivers/phy/phy-snps-eusb2.c
> index 4e5914a76..dcc69c00a 100644
> --- a/drivers/phy/phy-snps-eusb2.c
> +++ b/drivers/phy/phy-snps-eusb2.c
> @@ -461,7 +461,7 @@ static int snps_eusb2_hsphy_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, ret,
>  				     "failed to get regulator supplies\n");
>  
> -	phy->repeater = devm_of_phy_get_by_index(dev, np, 0);
> +	phy->repeater = devm_of_phy_optional_get(dev, np, 0);
>  	if (IS_ERR(phy->repeater))
>  		return dev_err_probe(dev, PTR_ERR(phy->repeater),
>  				     "failed to get repeater\n");
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

