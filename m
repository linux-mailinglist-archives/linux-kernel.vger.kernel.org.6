Return-Path: <linux-kernel+bounces-408513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 055019C7FC1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50321F22546
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB411CCEF5;
	Thu, 14 Nov 2024 01:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="InB1Xjjt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D233216DEB4;
	Thu, 14 Nov 2024 01:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731546642; cv=none; b=SOzleXCZdJrl3NRwYWP0Lo9TfqeqcdKXBJaqDKPp8QMmWHtAXfzPunpBkbFirvqJj6dnf5RsBIX72NXnm58B6Gb9JICI5yIV738Sc9BCq0GzkHPbagf5O6M1u30+C3RMbcvuJfwOFuYofXVVtxbidbflXv+5KYZRSOpEz3dTyew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731546642; c=relaxed/simple;
	bh=O2zq1glSZr9LPjsRIQxa61fxxsHgRs0Nh/0fNCe6oRI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O58QRYX5xWeUFkLrm6+00fqAEhjSowehuqUfVCuo5M+bWPw4CSGkof0cXINKU6BiEBb0guAY6LsjI4tPSwLk3OvEYkZdYfhhSB8z+sDeadqlbJjREGLqayYiCtkNlzVuGMqUYhE4oCBjpN3+PpCvwnddV9vQV+sl8PF3n30r3Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=InB1Xjjt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADH1QHt015403;
	Thu, 14 Nov 2024 01:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=obuIBdB2NoaG6KPGEovIWmvn
	S4F0qNHmuyEWMF7tCV0=; b=InB1XjjteKgpdjXLYnvUB21rnx0QXPw+XxlDbETw
	14igKMWkZcgDrzUXVDCJh5nZWiQmJ35R1hqsDjaridlIC1Wkk/f7W/7L53uVDmJb
	ewICNqtUp1UKLvD1neHsK7n3d79dLCNfCi+oitFx3zk5+Sym75BCaUCUKn4mfTa0
	z4QZVXzi4ZKamabKtzQvDqtR3ko7ruX+6fko0BroqkSisPzxjkNj4ckVqZC8PucH
	ogvyS1yEfkMHU2qdG3jT5jXdP6hX9+f1vzAOaPFlu0ipBDySQ9nFIjIWM8asOket
	0tBe5AnTi4J+qOsHZTTfux6fMVxN9yWynoNBkCzfAd0C9g==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42vsf329ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 01:10:25 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AE1APhQ026065
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 01:10:25 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 13 Nov 2024 17:10:24 -0800
Date: Wed, 13 Nov 2024 17:10:24 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
To: Konrad Dybcio <konradybcio@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Bjorn Andersson" <bjorn.andersson@oss.qualcomm.com>,
        Konrad Dybcio
	<konrad.dybcio@oss.qualcomm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 0/3] Allow specifying an S2RAM sleep on
 pre-SYSTEM_SUSPEND PSCI impls
Message-ID: <20241113165329590-0800.eberman@hu-eberman-lv.qualcomm.com>
References: <20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UgSLmlzclwyVXv8aYsOX0I0nUglVNwrA
X-Proofpoint-GUID: UgSLmlzclwyVXv8aYsOX0I0nUglVNwrA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 clxscore=1011 mlxscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411140006

On Mon, Oct 28, 2024 at 03:22:56PM +0100, Konrad Dybcio wrote:
> Certain firmwares expose exactly what PSCI_SYSTEM_SUSPEND does through
> CPU_SUSPEND instead. Inform Linux about that.
> Please see the commit messages for a more detailed explanation.
> 
> This is effectively a more educated follow-up to [1].
> 
> The ultimate goal is to stop making Linux think that certain states
> only concern cores/clusters, and consequently setting
> pm_set_suspend/resume_via_firmware(), so that client drivers (such as
> NVMe, see related discussion over at [2]) can make informed decisions
> about assuming the power state of the device they govern.
> 
> If this series gets green light, I'll push a follow-up one that wires
> up said sleep state on Qualcomm SoCs across the board.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20231227-topic-psci_fw_sus-v1-0-6910add70bf3@linaro.org/
> [2] https://lore.kernel.org/linux-nvme/20241024-topic-nvmequirk-v1-1-51249999d409@oss.qualcomm.com/
> 

I got a bit confused, but I think I might've pieced it together. Konrad
wants to support s2ram (not clear why) on Qualcomm SoCs from 2015-2023.
On these SoCs, PSCI_SYSTEM_SUSPEND (s2ram) isn't supported but doing
s2idle gets you the same effect. You'd like s2ram to work, so you
provide a way to replace the PSCI_SYSTEM_SUSPEND param with
(effectively) the CPU_SUSPEND command. If this is the wrong
understanding, please correct me.

Could patch 2 be sent separately? I think it seems fine without the
rest of the series.

I'm not sure why you'd like to support s2ram. Is it *only* that you'd
like to be able to set pm_set_supend/resume_via_firmware()? I hope this
doesn't sound silly: what if you register a platform_s2idle_ops for the
relevant SoCs which calls pm_set_suspend/resume_via_firwmare()?

- Elliot


