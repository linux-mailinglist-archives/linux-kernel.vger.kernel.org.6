Return-Path: <linux-kernel+bounces-353358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D79992CCD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0881F239E7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069DE1D3634;
	Mon,  7 Oct 2024 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rk7PlXyt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC3E18C015
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728306853; cv=none; b=VJY48ykmkctWm/g+v7Is9hdnsUiC35375++tXXhZOlR2Eu6/LmMRjt5frpLeeOs/JEZwG+y8mvRviZLnoVqR0T6g/FhrKb53Z1sGsKk/476Hkv88tnFjboWPEobNs791UpEKhvhpjkHIrz/4G7pIzlR0kfvjkhoJIIdgrzhY40Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728306853; c=relaxed/simple;
	bh=aoZ6Ab2vT/zv5gBysjB0k30FjuEJ24iQqrKlS0K2iTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFxL9tPGCdwgaS/KSsby0J8hTqvb2aps/oCOaB/krpkfpJjRSHaoVItFBABLLW2cGRW2aEHpOXtLvh0SmEohBsUTyJ0UaOmFvaDLUaadDBsmA7d3Kf7PR2ctF2eH6gY3EWgKnVccjbOxDen6DQ9XF0W2Pp+fEBwYCwLhtTccT0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rk7PlXyt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4974Ucpf023668
	for <linux-kernel@vger.kernel.org>; Mon, 7 Oct 2024 13:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lagPHIZttZDMUwYWdXVzJKUqDahMn43dORef7ZZpNvk=; b=Rk7PlXytr1YHYGI2
	foDnifwZQTqFUtnW+s3xpBvEczDraD02voigsUqk3CUbu2qBxoq3B8La7Zvwh8sp
	cYb4AzRYYPWY2gmbBKAid1ycLTzf36fFt2Y1Ik74L6X6TyWiMNyZ8rWzieRU4UV8
	ab2wn6VDw3nsloKKcHBc+LyfHDDEw14+dzGyvq0gVQdsOtTlx+AiOhCeX11zouIG
	SlPsAPugVkMCnXTDrKb9P4SeeG8E0ALvnGAMDp5PwaCTl37ltSgKkdehXvSsw9L+
	zMFkflejufD9edOD5YmpGoC5qWeArbhNBbNYvsFkznGwprXMFyyBsIwYaqmsEyrU
	43MFHg==
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xsn48jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 13:14:09 +0000 (GMT)
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5c884af74b5so467552a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 06:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728306848; x=1728911648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lagPHIZttZDMUwYWdXVzJKUqDahMn43dORef7ZZpNvk=;
        b=nm1GXm20QKyAbjFsnaeUkUVFXtEy/xfod4XmNc1TTlDMKRTUvd+Dpey8HukGl+vPZQ
         MqPatG7aZFCrJZgP9gaiKZv/VZo5EVSYSBgJGTS2FZ9B8+KD5PuNyl70uLOrCw8YkxGU
         ibzpr8/tTrjPhpzfVIm16QNOFaDnEnBwYNeqV2U7SAL1f/IQ9uXF78vBRQo2WxvdquJ7
         jmaPkEg2FGkFBb7IchObgy9fOr715wyGmCaWZeHJ+mTVhZ1jB+a9vVgmdlkrl838B/6K
         wgJHvf4rznabTEeKBwq43HXB+Anp84vPoF9upad3T1LfoqTl9Lh6Ela+otXt6Rq0ERvW
         XPSA==
X-Gm-Message-State: AOJu0YxHJt9OAumUqpBoAuR3Nhb4TBKuZTpAp/xnQcCHo1nFOD1WbYB7
	FAME/ly6JMbz/tFf5ojqincFEMkLTcIvH5WVg2Vfal1bAcQOT+ioR7qXDHlwlcbCcasKIFA6gZJ
	KALoVMmgC/QQeWmcLZEJU/uf1LYAxeAn7fgm2HoVP1yVJpkuMKZjNgZSDDmoaaHk=
X-Received: by 2002:a17:907:928c:b0:a7a:a33e:47cd with SMTP id a640c23a62f3a-a991bd427e1mr582896366b.8.1728306847964;
        Mon, 07 Oct 2024 06:14:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG99yzel8woEN3MfN94DmcG3qCsQPgg06GOvsb7ccyx/jB9qBtMungcx0dHjaKg7+ABpfb/Qg==
X-Received: by 2002:a17:907:928c:b0:a7a:a33e:47cd with SMTP id a640c23a62f3a-a991bd427e1mr582892166b.8.1728306847312;
        Mon, 07 Oct 2024 06:14:07 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99420bcc1esm287761166b.199.2024.10.07.06.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 06:14:07 -0700 (PDT)
Message-ID: <d1f12236-220a-43de-a69a-12831bc8a691@oss.qualcomm.com>
Date: Mon, 7 Oct 2024 15:14:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 4/4] mailbox: qcom-cpucp: Mark the irq with
 IRQF_NO_SUSPEND flag
To: Sibi Sankar <quic_sibis@quicinc.com>, sudeep.holla@arm.com,
        cristian.marussi@arm.com, ulf.hansson@linaro.org,
        jassisinghbrar@gmail.com
Cc: linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        johan@kernel.org, konradybcio@kernel.org, linux-pm@vger.kernel.org,
        tstrudel@google.com, rafael@kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
References: <20241007060642.1978049-1-quic_sibis@quicinc.com>
 <20241007060642.1978049-5-quic_sibis@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241007060642.1978049-5-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: uyh5a5yVPZZTRvgr-IwyrlH2cBR4rmL8
X-Proofpoint-GUID: uyh5a5yVPZZTRvgr-IwyrlH2cBR4rmL8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410070093

On 7.10.2024 8:06 AM, Sibi Sankar wrote:
> The qcom-cpucp mailbox irq is expected to function during suspend-resume
> cycle particularly when the scmi cpufreq driver can query the current
> frequency using the get_level message after the cpus are brought up during
> resume. Hence mark the irq with IRQF_NO_SUSPEND flag to fix the do_xfer
> failures we see during resume.
> 
> Err Logs:
> arm-scmi firmware:scmi: timed out in resp(caller:do_xfer+0x164/0x568)
> cpufreq: cpufreq_online: ->get() failed
> 
> Reported-by: Johan Hovold <johan+linaro@kernel.org>
> Closes: https://lore.kernel.org/lkml/ZtgFj1y5ggipgEOS@hovoldconsulting.com/
> Fixes: 0e2a9a03106c ("mailbox: Add support for QTI CPUCP mailbox controller")
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

