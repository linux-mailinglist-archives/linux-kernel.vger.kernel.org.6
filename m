Return-Path: <linux-kernel+bounces-433674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F1F9E5B7D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 521E1168A90
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F3C1D4332;
	Thu,  5 Dec 2024 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CjfHJBMF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690ED14A8B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416309; cv=none; b=ivBf/8LHrjzadVOYeqF3xXyR4EQPwMMzNL7LN/E+wJmVKaKPIzVQG6f0QbjQRRBvy5lTG64J3cbCItS2lKlyIvmjyKbPVu3ozA7RfPcpwz0bzkG2KJ6Gn5C34p9mmpXoD4thyXaqy28xBgbujiUF9O6EK8E1KcNLiejtSep3Lhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416309; c=relaxed/simple;
	bh=J3ESyanQrh2f4eFh3WJ4pYGGoFIoFUQGqxlSoVenKuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i4YxnRwIB4gEsaV7FtnhMMcr9+c3TosTcA3Nq1094B1WBjjuyX7Ly0Jnca7jHvNjSc6x/weiLrncBNUDLLPAseRI5ocNuGhC4HDneH2h5g7hy/8yQwrNO2KxKCAdS/AwFB+M5k3IycMgAsDgjdIY9OVJJCPsp2Iit0KtfHfG+EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CjfHJBMF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B59vkNx026596
	for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2024 16:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OO3PETOsyEKUmVhcQ82jscTslmU61XklmW+TguqESPQ=; b=CjfHJBMFUQDYgcWu
	dbdvJhA6QcbkojJBpqdlxbcG+BycUGL7rRj43yoUCi6vDh00vJKL9XRAOee2eC10
	BPJR2HAqaKPhTs7frhroVh9U6rj1WjLex2T2JIEU/pHHb9xd10swNo5Ad2yb1dzN
	NPbEH23Ea8Im7ne+nGwkMTIQlLQwU1rZiB+veQPTFP8MLgGxtHZ1habswNJPInHm
	D7d6QPcey63fWlyzxpEsWEZFu7CoVzFxyUGF2VhEWW059Fsht55IlffnqDyTVrld
	n/C13IbvcNqzEFZjKDRzZ1jQvtReP8odynHXyYnt3zqtZTTsSiW+ahJ/DUrRLLEk
	bfIXmw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ba0kh309-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:31:47 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-466c4b8cab2so2854401cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 08:31:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733416306; x=1734021106;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OO3PETOsyEKUmVhcQ82jscTslmU61XklmW+TguqESPQ=;
        b=vUUiL9EDuX6MYTYTdIyTgfWhOoL9GB2w/AAEOFp7Ojt8fjuHndAnZsx/sza7MjtovR
         icauqZXFagh97jkmLjbVqFBom0AjsLX9ndMgAAZDUAQEOZPggKT+3GWAnLHNE6IEaWnv
         cJP5QeJvK2OF76cSc9l+TAkCIOZnbS/cVPz5wzxf+otmHsyzmNxbRRu5DjTc7uEj9f9d
         wqvOU52YT4nfpYN29UbloFFQlG+eekyPTnO2YsX3DwYdn4mTdHwOdCoAHib/fkao00zN
         JW5PCLw750IPpb4uejqr5rHWj0XpXm+bhA6tVQko4rojO41bqXsa1DJV0urepbEXcb2O
         KomA==
X-Forwarded-Encrypted: i=1; AJvYcCW1/tZsQisAFIGVJvvyyLH/WfPUq6nW7AJMIHtkbbgPBjVpsHqYiTaoW58R+5Gz9r7uh0z0WqNQYqE8DpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDtpPF7+cqDw9YA8g6w51HL++1dthv1sfzaK6/8/37BhlpEIPU
	qaij9WxCYqSOdE/TylzUcbaObPqlWwIwGclHCzaFgEDKomjmryU6ZDJqWwo6+eLtUaAUBiS1lq2
	1mRmQfCPKsLs6c0p5DB0DxDP3Q6gBOUW04MaplAhJzEhwe9ox1lPNRQv+QA8BAfQ=
X-Gm-Gg: ASbGncsw9b3AcJVpFQtwEUFBJD76sOA92TMBBaj4NZj7K558sdt4hxKMehxO0Tx7ppb
	7V+JxvJ5Uz+LG1Mx8s1nfWDhVO4ynP062PxXb2b7Bv5/P1uubDeyYgUtWx4VvQvpH85SpDTQvQl
	+dGK+LqnIQrzeeu9/Kz+XeujVUpNPrCO8VQaWYOgexneiilGvFAwNDwON7SIP6afFUKNNS8+TgS
	hbLUoARmUHEiQ2WZ8Chd/n61C8pks/rKtr6YvVVBhBkoJ0VJjpSl6wYr3eOUnntWuC2/W0Zqjdq
	vQpwzDEVzh6oANnZdk1rA4sCsmDzm8I=
X-Received: by 2002:a05:620a:46aa:b0:7af:cd2f:fc16 with SMTP id af79cd13be357-7b6a6ac4315mr640243285a.0.1733416306261;
        Thu, 05 Dec 2024 08:31:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHn4mO82urP0n6y4ICtJcZOXowWIRkawjXqvzOlQIsjvcyJPdkawu57/eeRUH0GNZ13RwBadA==
X-Received: by 2002:a05:620a:46aa:b0:7af:cd2f:fc16 with SMTP id af79cd13be357-7b6a6ac4315mr640240785a.0.1733416305903;
        Thu, 05 Dec 2024 08:31:45 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e4dc68sm115325466b.23.2024.12.05.08.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 08:31:45 -0800 (PST)
Message-ID: <783bda0f-5d51-43e2-8923-a01577a4296d@oss.qualcomm.com>
Date: Thu, 5 Dec 2024 17:31:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] phy: qcom: qmp-pcie: add current load vote/devote for
 PCIe PHY
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>, vkoul@kernel.org,
        kishon@kernel.org, dmitry.baryshkov@linaro.org, abel.vesa@linaro.org,
        neil.armstrong@linaro.org, manivannan.sadhasivam@linaro.org,
        andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20241204105249.3544114-1-quic_ziyuzhan@quicinc.com>
 <20241204105249.3544114-3-quic_ziyuzhan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241204105249.3544114-3-quic_ziyuzhan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: eFA6j38vJfBxP-D4C0JFgqkFUrekfYhu
X-Proofpoint-GUID: eFA6j38vJfBxP-D4C0JFgqkFUrekfYhu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050120

On 4.12.2024 11:52 AM, Ziyue Zhang wrote:
> On some platform (eg.qcs615), the current that phy consumes will exceed
> the maximum current the regulator can provide in LPM mode, leading to
> over current protection and system boot up stuck. Fix this issue by
> setting regulator load to an expected value getting from phy device tree
> node during init so that the regulator can scale up to HPM to allow a
> larger current load.
> This change will also set load to zero during deinit to let regulator
> scale down to LPM mode to reduce itself's power consumptionif PCIe
> suspend.
> 
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 35 ++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index c8e39c147ba4..782d51ab5cf1 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -39,6 +39,7 @@
>  #include "phy-qcom-qmp-pcie-qhp.h"
>  
>  #define PHY_INIT_COMPLETE_TIMEOUT		10000
> +#define MAX_PROP_SIZE		   32
>  
>  /* set of registers with offsets different per-PHY */
>  enum qphy_reg_layout {
> @@ -2905,6 +2906,7 @@ struct qmp_pcie {
>  	struct reset_control_bulk_data *resets;
>  	struct reset_control *nocsr_reset;
>  	struct regulator_bulk_data *vregs;
> +	u32 *max_current_load;
>  
>  	struct phy *phy;
>  	int mode;
> @@ -4087,6 +4089,17 @@ static int qmp_pcie_init(struct phy *phy)
>  	const struct qmp_phy_cfg *cfg = qmp->cfg;
>  	int ret;
>  
> +	for (int i = 0; i < cfg->num_vregs; i++) {
> +		if (qmp->max_current_load[i]) {
> +			ret = regulator_set_load(qmp->vregs[i].consumer, qmp->max_current_load[i]);

I think it's better if we just put this info in the driver, like with
e.g. the DSI PHY

Konrad

