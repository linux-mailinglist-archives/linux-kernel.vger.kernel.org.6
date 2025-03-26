Return-Path: <linux-kernel+bounces-577030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A2BA7177E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 276F6179E2E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B99D1EB5F4;
	Wed, 26 Mar 2025 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ODkgmpkj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920B81EB5DD
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742995544; cv=none; b=UCP1UtX1ZwI6AGUQk2+qMZjiDiZ90m58W56lmco2jRktgCYD2GvlPJHtbcXtbgm5UQylmPNQzXm3ZqY2sVn+IYNAtcn88kKp8N1m/vvq9sKoQeZmS+KQFKXIBEY/02N2fCQ70+AmOka5WO8s16k9s9OLG0+2vV7kPNnT7bqFblE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742995544; c=relaxed/simple;
	bh=Ec0Xu4PjqUjd3h3Ibtjw0z8jjglSCJ/HQleUwNbwRrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FjzZHAkmzlzRuJJnq9jhK/YrjcbdEyDpjXiS77Fd6jET0ezfMSj7Dws57SxDQtHEXZ7InmXSZAm8xNuGQbcOG+O9u/OGSilryqr6LznBR9FWpRnuASYOfROzmFISctW1Z0ZKIXkMz9OkOovQhB+mwz8xO6o+N5/yYAawIEYTkd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ODkgmpkj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q73Ec9009017
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Mn+Gs2SyQz1iQ9gjKD3hboP/p+jh4/gpnc6d4YClDFI=; b=ODkgmpkjWML3lzo/
	B/vFlkL016Pi7Js5wrT//WRkX5MlqM3zEGJ7Uu3JJ73ipuV4+OLJypWd7kOgj8uX
	1ulgPLFlj4Ukfa4MfAMwOuGLXKbd/G+QBLTeDw2RkCYY/PULTpFboiwVs9piE1Qv
	lDAOGlFAxEk51GIlj5HkQQcqpgW05/QSAnK24Uzcl6TCz8HKXRjq5lfWKMC9pJjw
	LMSSY/pl+vhX/WH2f8ujDuQQdcq0ivMfJprO6Oyjpma6PzlraW8irvBRsfhnBO+H
	igIWXfaU9zGCDQoVq+9hAol8hVwPwRSlbpijwqhlb4mLsrJYA2oNMuq7DIVPTQmS
	9KJU/g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kmd4n3mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:25:39 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c545ac340aso127261585a.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 06:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742995538; x=1743600338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mn+Gs2SyQz1iQ9gjKD3hboP/p+jh4/gpnc6d4YClDFI=;
        b=EtmnFuUGNuxmfVYrNrhcxvLozTenRGNODbB1CP2CPd9DWAP1uZTl2xARJjrQpzBLcH
         CA2Opd9HW8Pz3WQyg8vw45nyDZZBWRanJUHaBDlwi/mvVehfWVvmFWAENdDzFVn58Swu
         BsCL4isqR6UoR5mryp50rmAxA03GqawBIrQSy9a3+6N2C80pHTFW7IM58TWZUn/A3DH5
         +jPET9p0Kl4YlsxYbDO/Kg9z6Cae9oX0VhFh4z0TU7EaBGd8tiPRMAtGsvqtAStOppaw
         84I7cQ8K0FXn87eb6aPEI0uVaU+YgS3Pw0m7A0u4W3Ou+UMWXMjWzu30RiVIBalzqwch
         VZ7g==
X-Forwarded-Encrypted: i=1; AJvYcCUNhFzVA3aoNWog53fOHlsNZoa49a9EtMmVdc0G76GofjmFNxcIVKSt0rW/oECUsrRSkiZTx+A1oknqDAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIY5ZMJsnKKuubhuCl9mghkBTzaqPDU36VbaL1WjK6FIZQTKNb
	mTsjLXOxLbUd+Hqb4J3aClIdR/b95MdBh/oY+c0J2UT+aqlG2pdQJuYa1aQbSew58dhsTEqaIBd
	+yHL+mR1LROFUKWKYWZ+efAmy7Hg00dsc6PKT1gzLUNvJ449wjq4JG9qWIudSnAg=
X-Gm-Gg: ASbGncvDtbf9UTq4dyGIPbIwXuqCm2aWn+RDg6f7vqLfxwW1p2HB2GFjPkWjI7obgTD
	BsEaZF6VJRiSKuwjJtDtLw0opL64PYfj+RKcY3ZkTkq/mh3hFmPgA+qljiF2P3LufyZKtzcwCH+
	mW/thK5fMg/bPG3SCs4Gq7x8ZkpAvlvX7Bcpj4BcLObcpSBSHIi5C4oOC48ssFTBs3mPOMQxsvR
	XoM6ZTdyHVvmxSsh1MujMdWHoMTZ6gYQHUFifPvZ0Tjf2av3qV4PWmdCChB1btbfA+WSSjTmDLE
	rrY349+qhe+Ct+S/ZRg6UwmPlgsh7yS4HVn0/7POdFnxvSkyxHD3LEpwRfhNcu6EAApYbQ==
X-Received: by 2002:a05:620a:31a5:b0:7c3:d1b9:e667 with SMTP id af79cd13be357-7c5ba1845a9mr1263113085a.5.1742995538124;
        Wed, 26 Mar 2025 06:25:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP6KqkuwA9cDhKcWVVuPPt8YQPIOz8vB2xkumwy0+ixdBejLE2t0tCRCxjlesEThechUVNkQ==
X-Received: by 2002:a05:620a:31a5:b0:7c3:d1b9:e667 with SMTP id af79cd13be357-7c5ba1845a9mr1263111385a.5.1742995537640;
        Wed, 26 Mar 2025 06:25:37 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef21a99asm1033442566b.0.2025.03.26.06.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 06:25:37 -0700 (PDT)
Message-ID: <776fcb22-260e-4c60-81dc-9632d76a85dd@oss.qualcomm.com>
Date: Wed, 26 Mar 2025 14:25:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: pmic_glink: enable UCSI on sc8280xp
To: Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20250326124944.6338-1-johan+linaro@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250326124944.6338-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: BUCBLzPjbVRhLYlunRpB9ELTC0rozrv2
X-Proofpoint-GUID: BUCBLzPjbVRhLYlunRpB9ELTC0rozrv2
X-Authority-Analysis: v=2.4 cv=QLZoRhLL c=1 sm=1 tr=0 ts=67e40053 cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=R4_Tb_Y2wpFPbI5QzzAA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_06,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260081

On 3/26/25 1:49 PM, Johan Hovold wrote:
> Commit ad3dd9592b2a ("soc: qcom: pmic_glink: disable UCSI on sc8280xp")
> disabled UCSI shortly after it had been enabled to fix a regression that
> was observed on the Lenovo ThinkPad X13s.
> 
> Specifically, disconnecting an external display would trigger a system
> error and hypervisor reset but no one cared enough to track down the bug
> at the time.
> 
> The same issue was recently observed on X Elite machines, and commit
> f47eba045e6c ("usb: typec: ucsi: Set orientation as none when connector
> is unplugged") worked around the underlying issue by setting the
> connector orientation to 'none' on disconnect events to avoid having the
> PHY driver crash the machine in one orientation.
> 
> Enable UCSI support also on sc8280xp now that the DisplayPort disconnect
> crashes are gone.
> 
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

