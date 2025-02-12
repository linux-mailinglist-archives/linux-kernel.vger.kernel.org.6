Return-Path: <linux-kernel+bounces-511311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA76A3293D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E09E3A13FE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09C1210F6D;
	Wed, 12 Feb 2025 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mNbYHnKc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA03B20DD4E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739372150; cv=none; b=bVv9KWBP+XiGvZxLqtcXHNKpBGpwIC18bR0sdKpDHPGzrzSK976UKfWdlHwBw2qDDNgjZuRmsVxejE/8dS9d/e/27eJU5MC7Fqq7LTfKuzfHAWVpfnBC/EWjj1gWjXiKxptlXrGrvxNQ9wPdQgpjL86gnzUeVYMnpG8Ffba1XJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739372150; c=relaxed/simple;
	bh=sSNGGMrE8T93VSmrATsF+z40Eu00MXY5OytJCnZR0Bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hCOhA8WXievZ7gzIMyi2s48q2wC05EtdYQGHpT0N/4kkssuq4yQkRDPSITvpgluqtCWFVURa9zz+XfaM5idTFKoIsuGoURb8ULpls9bp0K12HhJ20a1S2llNG8y8iGjHytt3nT2P4ShqxLa3296wc9Kcg7AwftadN5PD+OIUhF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mNbYHnKc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C92U2u002612
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	916SG1gUix3A397XCQBzpFRlo+xOPFmr9pt67nE8rRw=; b=mNbYHnKcBEapiMyo
	OgQ00QSK00iEYIFe1gA9+kkY4g+oBVPCAeKMN1AY6x2CkFUdyV1LpYOIe2oz9DXB
	VWLERufiieWfXEEwjAGVRPF7u64DZRcYii/+7nPXreSwXmT2VG5z0H0We4ZLSCgQ
	X62zBeiwXvOGsakEJZHrX89TeKKQmskTdsSleL0HUKb35q3eDr5xORgaVs/sqe5b
	17eLhrY6LlwhzEskYeEPxzTviaHOyDCvPZkhknRugy10EAuxHXAtJOwKbuS7Xq+g
	sPn5cTF4KhOmtgzovuUlqyrHup/sjJ3kpegxgOn+86wMm4RDPPMxS99DNKbo7l3R
	Al8U7g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44rrnfrwqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:55:47 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-471921f2436so4193231cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:55:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739372146; x=1739976946;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=916SG1gUix3A397XCQBzpFRlo+xOPFmr9pt67nE8rRw=;
        b=PdeYeBWaPPb/5xMKyxNECBxuFHziXbmbczPNuYVvaloc5X1zk160QTadOzoMVjsFQU
         PWwLh7Cd6bBELuNg+SownWidFWvnx2VxKj7GyDohWAfKKr4NyuKFYZG/98VZBRZWAs4L
         yWJlSVd0JhB078yHbsgCbDirSxPWZGz2/QWZuxtEhp+hDXsj3EZ4jCv8P3rPQzyGRyY2
         NUW/faMaepWPffkws/5zmwrFnXwbu/UyKs8j/BvRWzOgJDXnP+2mMCsNTzBNFHJ21QO2
         Y+fsPYCtv8sh/yaf7yYb6I+/a6meCsWE3LumjRSQtIMAaCIeG3lydsF9W7d6kjl9LRxv
         20DQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0rpOAAVsIdxV55M1v6JyMwsLQ2ullppAQxi/lg4xPp3GXXshTgK30r772MR0oKbRvwva4WKqHxOb/0eQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/CGBm7JHL6S0Dm/xHVv15nZCC0yH3RSchRtPhPU5637kr8NaO
	HgY2DUTz6H25gtrrbnq5cs/sRZU+w65pvmwrdG/3NqLsXe3So4cBGG27FBVfLdJXxxrzymJjPss
	/OkfwAzUSQmlUqqMRIVVJG70wLHhgtVx++XT2JqerQ9MhRFtbuY0DBTVOW7T51aM=
X-Gm-Gg: ASbGncuMckxZp8LvwkyaK3jHYTKtqCfjmx4aORu31zNK5UYjR3pDpmqZDDreXU6TDhW
	eogvxQBkTKchaXhyzHI7sAbfvQoenDD5SVSE/x0rwoEES8AnCph9+B8/GP5tYzpMStaneVHmBKl
	ufzjx5c3ImO9k0aUXsGUmQx+bvYoHlvvYFT2Dlauh9yCr+D8uLOuQOzy/4oq7S7LwwyM6eIhyB0
	lEVcYhLqkMayu4c/NGs2yJKWteK7NZAuHA3R/NLpN+Acl8ULafhOTpPO/3rNbJ6JdV8fsXaoH+s
	ld05XEG+w5bXduy5s743yMZHoHHVwMFP9AAqVB0UVPGTo7tGKkIIGW/fDOI=
X-Received: by 2002:ac8:5dd2:0:b0:467:5d7f:c684 with SMTP id d75a77b69052e-471afed5648mr18796651cf.12.1739372146452;
        Wed, 12 Feb 2025 06:55:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzLBeiKZSyJ9lZh2Y7PO+RFQ3dmGp7ZGFUJgrbKrEQTQdh86uIFfhpBmJIWx0PHK0HA9YHAg==
X-Received: by 2002:ac8:5dd2:0:b0:467:5d7f:c684 with SMTP id d75a77b69052e-471afed5648mr18796541cf.12.1739372146109;
        Wed, 12 Feb 2025 06:55:46 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab772f49361sm1279167166b.33.2025.02.12.06.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 06:55:45 -0800 (PST)
Message-ID: <f7a220d5-6866-4770-93a0-66e6d7b49491@oss.qualcomm.com>
Date: Wed, 12 Feb 2025 15:55:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] phy: qcom: qmp-pcie: Add PHY register retention
 support
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Wenbin Yao (Consultant)" <quic_wenbyao@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, p.zabel@pengutronix.de,
        abel.vesa@linaro.org, quic_qianyu@quicinc.com,
        neil.armstrong@linaro.org, manivannan.sadhasivam@linaro.org,
        quic_devipriy@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250211094231.1813558-1-quic_wenbyao@quicinc.com>
 <20250211094231.1813558-3-quic_wenbyao@quicinc.com>
 <7deghiadmomrz7w7vq3v7nkzq2kabq4xbhkouswjrexif7pip3@tvjlpvuulxvp>
 <791fa29e-a2b5-d5f6-3cbc-0f499b463262@quicinc.com>
 <fwfxhy535nm7227wzlwlojxyxrr3ond5hmc3njqbcje3usfh5t@hqrnbpmdqweg>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <fwfxhy535nm7227wzlwlojxyxrr3ond5hmc3njqbcje3usfh5t@hqrnbpmdqweg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LtXFC3Ocr57xobosk7yJXlJCuIeg1iAf
X-Proofpoint-ORIG-GUID: LtXFC3Ocr57xobosk7yJXlJCuIeg1iAf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_04,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502120113

On 12.02.2025 12:07 PM, Dmitry Baryshkov wrote:
> On Wed, Feb 12, 2025 at 04:31:21PM +0800, Wenbin Yao (Consultant) wrote:
>> On 2/12/2025 8:13 AM, Dmitry Baryshkov wrote:
>>> On Tue, Feb 11, 2025 at 05:42:31PM +0800, Wenbin Yao wrote:
>>>> From: Qiang Yu <quic_qianyu@quicinc.com>
>>>>
>>>> Some QCOM PCIe PHYs support no_csr reset. Unlike BCR reset which resets the
>>>> whole PHY (hardware and register), no_csr reset only resets PHY hardware
>>>> but retains register values, which means PHY setting can be skipped during
>>>> PHY init if PCIe link is enabled in booltloader and only no_csr is toggled
>>>> after that.
>>>>
>>>> Hence, determine whether the PHY has been enabled in bootloader by
>>>> verifying QPHY_START_CTRL register. If it's programmed and no_csr reset is
>>>> available, skip BCR reset and PHY register setting to establish the PCIe
>>>> link with bootloader - programmed PHY settings.
>>>>
>>>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>>>> Signed-off-by: Wenbin Yao <quic_wenbyao@quicinc.com>
>>>> ---
>>>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 91 +++++++++++++++---------
>>>>   1 file changed, 58 insertions(+), 33 deletions(-)
>>>>
> 
>>>> @@ -4042,16 +4057,22 @@ static int qmp_pcie_power_on(struct phy *phy)
>>>>   	unsigned int mask, val;
>>>>   	int ret;
>>>> -	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
>>>> -			cfg->pwrdn_ctrl);
>>>> +	/*
>>>> +	 * Write CSR register for phy that doesn't support no_csr
>>> what is CSR register?
>> The registers of PHY.
> 
> So 'CSR registers for phy' means 'registers of PHY for phy'? that seems
> incorrect.

"Control and Status Registers"

Konrad

