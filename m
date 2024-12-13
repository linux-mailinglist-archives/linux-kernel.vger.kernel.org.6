Return-Path: <linux-kernel+bounces-445243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 591F19F1332
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49931884065
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044FB1E377E;
	Fri, 13 Dec 2024 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l0hxUDtU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CDC1DF737
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734109630; cv=none; b=AI4f0D+LnFZ4gpyZ+MEXRMGCMv2tM8ZrszNNPNW8q4JKBuFAR89K8mi5uNvzaOL5kP/vvUh7grX/M5IQb9jEUt4EDytyEN+qVh+mhprDfUTEXoIwRRtdc12KtJzWiGNhWfHHJ7cOoC4tYbBbFXx16nBuxoRNBbiKB/kZMD3xe+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734109630; c=relaxed/simple;
	bh=jM1VuUsAvL5QaaPwbRKq8XIEup7wMzfjJsriExih+UU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kXHtq/Dy3DjoDGe0MIXW7K/oHZHR5XvsaQXJFrC6KfamflwRhYwSJfeAoKqy53ifXV5hY2aDHG0sFZtGhVFs50gkxldmBzlO8gMLh8gxAgXnzmhR3Av5KljCe81Xqg2JS25kRIWzKOsWTJeMwenca1BPQ57gmxfyj74xqNm5Pwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l0hxUDtU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDAPf5u024170;
	Fri, 13 Dec 2024 17:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	alFXy0ty0D/1n6X6CFmkqO3ZMBSqiEh8oPNESPe1Fzk=; b=l0hxUDtUe54+4VzD
	uP38gEAYcGCJs0bVgiaC4tqnwFAAHdXFvu7w04xvmhR15/tMtj2/yp2ciGt+kxFE
	7A1ale/LnVoxq/KQwcRopGieCiD+/oExysyFOZy8g0tZo/F3hdvka0fyqKiRuhRf
	2dGQXudogcF7AL/I5KC92kXcGG/ElczgV/rTN7jJkYyoRVPT7ZmIoWvVMmFGHPv2
	M0Rzaxup0eL2hm7OnsN/X6LIWdJVMvUdekSBMx1mGqz+30D1CLohPAtL5ZjBsm6o
	6JYzF+5JbuM+6Xo5OMXzOIk+4KJyhoKzZTXYkl+gwMPRxBCGm6EkEN0+Xga0a2ud
	XBlkwA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fd40q2m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 17:07:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BDH71f8004926
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 17:07:01 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 13 Dec
 2024 09:07:01 -0800
Message-ID: <828570ae-1ff6-4bef-4bb8-51da9237e63e@quicinc.com>
Date: Fri, 13 Dec 2024 10:07:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/2] accel/amdxdna: use modern PM helpers
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, Min Ma <min.ma@amd.com>,
        Lizhi Hou
	<lizhi.hou@amd.com>, Oded Gabbay <ogabbay@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>,
        Narendra Gutta
	<VenkataNarendraKumar.Gutta@amd.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20241213090259.68492-1-arnd@kernel.org>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20241213090259.68492-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 66rOj-dLyLPuJviDA4kCT2ERzYfke_Qb
X-Proofpoint-ORIG-GUID: 66rOj-dLyLPuJviDA4kCT2ERzYfke_Qb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 phishscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130121

On 12/13/2024 2:02 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The old SET_SYSTEM_SLEEP_PM_OPS and SET_RUNTIME_PM_OPS macros cause a build
> warning when CONFIG_PM is disabled:
> 
> drivers/accel/amdxdna/amdxdna_pci_drv.c:343:12: error: 'amdxdna_pmops_resume' defined but not used [-Werror=unused-function]
>    343 | static int amdxdna_pmops_resume(struct device *dev)
>        |            ^~~~~~~~~~~~~~~~~~~~
> drivers/accel/amdxdna/amdxdna_pci_drv.c:328:12: error: 'amdxdna_pmops_suspend' defined but not used [-Werror=unused-function]
>    328 | static int amdxdna_pmops_suspend(struct device *dev)
>        |            ^~~~~~~~~~~~~~~~~~~~~
> 
> Change these to the modern replacements.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks sane to me.

Lizhi, can you verify that this works as expected for you?  I'd hate to 
accidentally break something.

-Jeff


