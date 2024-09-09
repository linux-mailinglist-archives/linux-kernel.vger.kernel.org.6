Return-Path: <linux-kernel+bounces-321660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699B6971DBD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1265B22E36
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615BD1CD23;
	Mon,  9 Sep 2024 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NGr5BBIH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3621CA80
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894884; cv=none; b=uOYr5yo9RCxOctktIbCY80k9ipSx7u47m9DqxoctkMtHp037C2F2Hd2NjHnvHp63K1SbJpb8SPdrI3z5d47o6BoX4LXI5pVrICbOzP52tVlhBB/Hx/QDeYCGi73aE7hjRtYG7ELNr3lUrfIrWtt/T/uxDnRP/92WguFkrjjp3YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894884; c=relaxed/simple;
	bh=47zb82jvGBUIvAioNO/qIvOsKV3MCQURbV9Cpmz41Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=W1GbX/lAc52Zu74ed8o4az0lTSU0STLNYyTlzdJptMxYnKFBdmbB/9FG2bZFavLCb0RlPbTGFpU3/rVH3QeQow0ZxvljZpHnyN5j0cedHjKyd8AYV96cU0ZA/mVA86/+DYy5pqiqZLlJ+jRzSnNyyaujtC+4TUs1CSHFOAXW6mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NGr5BBIH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 489DRR2M020308;
	Mon, 9 Sep 2024 15:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	47zb82jvGBUIvAioNO/qIvOsKV3MCQURbV9Cpmz41Gw=; b=NGr5BBIHcKTuLTm3
	aVcw0gEw2TAo00ftKE10pJg1DrYXkEIvEQ5yT2slv48nveV4/PBT+wmKrm04m888
	3rFNHpWQfHvnrUBHgf4KdU/hrn68sqKmeq2erl2ynBSJHCAhFmxeH2ihOznzw61j
	CeSIdIxKR862TDAqflxZgGcJ4AnYf9OK8J3U+5gD3t6x9GizBy52J/fJHC0ybhtC
	2dgNe+iEo/sKie/2/SCl+aOrlIx+BS9KFLNRjG0VWjLrxXjYAnOIXRjttaw86qrr
	q+vQtvGtzb2Ysy+bvqcwa+3jCTnWsDwgjNwnWPXU6Qnv/N7AsqpSGuSgkjao/XB0
	pmnIEg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41he5dtb3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 15:14:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 489FEY2v022286
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Sep 2024 15:14:34 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 9 Sep 2024
 08:14:34 -0700
Message-ID: <9c2483cf-d66b-438d-ae77-3c0d18704d03@quicinc.com>
Date: Mon, 9 Sep 2024 08:14:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] tsm: Add TVM Measurement Sample Code
To: Cedric Xing <cedric.xing@intel.com>,
        Dan Williams
	<dan.j.williams@intel.com>,
        Samuel Ortiz <sameo@rivosinc.com>,
        James
 Bottomley <James.Bottomley@HansenPartnership.com>,
        Lukas Wunner
	<lukas@wunner.de>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Qinkun Bao
	<qinkun@google.com>,
        Mikko Ylinen <mikko.ylinen@linux.intel.com>,
        Kuppuswamy
 Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>
References: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
 <20240907-tsm-rtmr-v1-3-12fc4d43d4e7@intel.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240907-tsm-rtmr-v1-3-12fc4d43d4e7@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 356Gj0fz9rUMR56KdY7xfbdWQAnTpDcn
X-Proofpoint-GUID: 356Gj0fz9rUMR56KdY7xfbdWQAnTpDcn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=974 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409090120

On 9/7/24 21:56, Cedric Xing wrote:
...
> +module_init(measurement_example_init);
> +module_exit(measurement_example_exit);
> +
> +MODULE_LICENSE("GPL");

Missing MODULE_DESCRIPTION()

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
description is missing"), a module without a MODULE_DESCRIPTION() will
result in a warning when built with make W=1. Recently, multiple
developers have been eradicating these warnings treewide, and very few
are left, so please don't introduce a new one :)


