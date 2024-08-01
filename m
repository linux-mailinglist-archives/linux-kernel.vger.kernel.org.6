Return-Path: <linux-kernel+bounces-271759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B329452F6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 724A0B2121E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E20148837;
	Thu,  1 Aug 2024 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E1vt6eke"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14B3143883;
	Thu,  1 Aug 2024 18:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722537745; cv=none; b=Xmve9q9cbeL25FSVYd7+Y9JG0UlTJYySa/H/1Dv+VaEBKEES0oa9mjFfpna3nDpDqqEhirbbtIar1SxvzsxyV6d2Uvy8NJchOzOdk/TJAbqrDiiO+pVK5GdOinCrBqGmVh0sskirQvdfxhnS7RAnmt/rT4UCQdc8zY0+y1UdY0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722537745; c=relaxed/simple;
	bh=jVlOlCmSaSAGO/EJCM/LCvEEZ4yFurUr9PhrrwdIeB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ng+vFWpLRseK5qTCGlDpXF8kCfIi1Pj1Cvbkcny3ml06pYfoutsOkawRjnkjCPx5NUJH8oQvBpWPXJZqhu+l43pg5DwfQVt0xS8rD4Oiy/9MsgNKPN+doH/AJvnC2G4peBTmpX7S8AFq2p/VEkVfQU1LfgJX7jMDNPJB4j3jyK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E1vt6eke; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471DaVv1004279;
	Thu, 1 Aug 2024 18:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NnQhhummXQw0pjwgVy3C2cdxx2zT1ep2SSYSxtgDMfA=; b=E1vt6ekecymYDnS/
	HIy6038MQ+YEXoOFFzRhREbBP4VBXo1Kdh5ZlDjUGr9uI2Cnm86KOOCx/JB/jWM9
	Ju3NuzmgURaYsMW4kNxKLS5IUs25imdxgfsBQoymuifnSqXheWhMKGhkKQt1QJ4/
	7U1BH5CxfJUn9GrcyRY1mDaZmuLU+Z/xuWX/yPs6dSQVo1wLn4cyqxgIG0v51xMg
	3BirKNosJUk6DBP6pUcdCh5PhdGf9GyiUy8NZOutb1Mo9c5kZUs2loyPRmoSa1+p
	1xAT8CLhKxeOVOm6altYDO3jjTtddwoh4LT8WJDy6byX77a1vh0KsxbVinbELnRP
	pm+RcQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40q23309x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 18:41:54 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 471IfrOK031992
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Aug 2024 18:41:53 GMT
Received: from [10.110.73.139] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 1 Aug 2024
 11:41:53 -0700
Message-ID: <2e1e24d5-b52e-401f-b533-e64584df1d50@quicinc.com>
Date: Thu, 1 Aug 2024 11:41:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] Make SCMI transport as standalone drivers
To: Cristian Marussi <cristian.marussi@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <arm-scmi@vger.kernel.org>
CC: <sudeep.holla@arm.com>, <james.quinlan@broadcom.com>,
        <f.fainelli@gmail.com>, <vincent.guittot@linaro.org>,
        <etienne.carriere@st.com>, <peng.fan@oss.nxp.com>,
        <michal.simek@amd.com>, <quic_sibis@quicinc.com>, <ptosi@google.com>,
        <dan.carpenter@linaro.org>, <souvik.chakravarty@arm.com>
References: <20240730133318.1573765-1-cristian.marussi@arm.com>
Content-Language: en-US
From: Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <20240730133318.1573765-1-cristian.marussi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2Yt_Noce85_qF6ZhKWIdBXp3wIKwUFPh
X-Proofpoint-ORIG-GUID: 2Yt_Noce85_qF6ZhKWIdBXp3wIKwUFPh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_17,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1011 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408010123


On 7/30/2024 6:33 AM, Cristian Marussi wrote:
> Hi all,
>
> Till now the SCMI transport layer was being built embedded into in the core
> SCMI stack.
>
> Some of these transports, despite being currently part of the main SCMI
> module, are indeed also registered with different subsystems like optee or
> virtio, and actively probed also by those: this led to a few awkward and
> convoluted tricks to properly handle such interactions at boot time in the
> SCMI stack.
>
> Moreover some partner expressed the desire to be able to fully modularize
> the transports components.
>
> This series aim to make all such transports as standalone drivers that can
> be optionally loaded as modules.
>
> In order to do this, at first some new mechanism is introduced to support
> this new capability while maintaining, in parallel, the old legacy embedded
> transports; then each transport, one by one, is transitioned to be a
> standalone driver and finally the old legacy support for embedded transport
> is removed.
>
> Patch [1/9] is a fix around the chan_free method for OPTEE transport; it is
> really unrelated to this series, but included to avoid conflicts.
>
> Patch [2/9] is a mostly unrelated (but much needed) clean-up from Peng,
> which I included in this series to avoid conflicts at merge.
>
> Patch [3/9] simply collects the existing datagram manipulation helpers in a
> pair of function pointers structures, in preparation for later reworks.
>
> Patch [4/9] adds the bulk of the new logic to the core SCMI stack and then
> each existing transport is transitioned to be a standalone driver in
> patches 5,6,7,8 while shuffling around the compatibles. (no DT change is
> needed of curse for backward compatibility)
> While doing this I kept the module authorship in line with the main
> author(S) as spitted out by git-blame.
>
> Finally patch [9/9] removes all the legacy dead code from the core SCMI
> stack.
>
> No new symbol EXPORT has been added.
>
> The new transport drivers have been tested, as built-in and LKM, as
> follows:
>
> - mailbox on JUNO
> - virtio on emulation
> - optee on QEMU/optee using Linaro setup
>
> Exercised using the regular SCMI drivers stack and the SCMI ACS suite,
> testing commands, replies, delayed responses and notification.
>
> Multiple virtual SCMI instances support has been tested too.
>
> SMC has NOT been tested/exercised at run-time, only compile-tested.
> (due to lack of hardware)

Hi Christian,

I have validated this series on Qualcomm SA8255p(to be upstreamed) Ride
platform that uses Qualcomm SMC transport for SCMI.

Thanks,

-Nikunj

> Note that in this new setup, all the probe deferral and retries between the
> SCMI core stack and the transports has been removed, since no more needed.
>
> Moreover the new drivers have been tested also with a fully modularized
> SCMI stack, i.e.:
>
>   scmi-core.ko + scmi-module.ko + scmi_transport_*.ko [ + vendor modules ]
>
> Based on v6.11-rc1
>
> Any feedback, and especially testing (:D) is welcome.
>
> Thanks,
> Cristian
>
> ---
> v2 --> v3
> - rebased on v6.11-rc1
> - fixed spacing in Kconfig
> - fixed Copyrights all over
> - fixed platform_driver_register callsite in OPTEE transport
> - refactored DEFINE_SCMI_TRANSPORT_DRIVER() to:
>   + use alloc + add_data + add platform drivers methods so as to implictly
>     use a standard default device_release method.
>   + drop .remove method in favour of devres_add_action_or_reset
>   + use explicit parameter passing (no more concatenation)
> - renamed scmi_transport_lookup() to scmi_transport_setup()
> - use IOMEM_ERR_PTR to avoid sparse issues
>
> v1 --> v2
> - fixed setup_shmem_iomap to address also SMC needs (QC/nikunj)
>   (silencing also warnings by kernel test robot <lkp@intel.com>)
> - using __free OF cleanup.h magic in setup_shmme_iomap
> - properly handle platform_driver_register() failures (Dan)
> - fixed a few commit message style
> - added a few missing static in scmi_desc
>   (addresses warnings by kernel test robot <lkp@intel.com>)
>
>
> Cristian Marussi (8):
>   firmware: arm_scmi: Fix double free in OPTEE transport
>   firmware: arm_scmi: Introduce packet handling helpers
>   firmware: arm_scmi: Add support for standalone transport drivers
>   firmware: arm_scmi: Make MBOX transport a standalone driver
>   firmware: arm_scmi: Make SMC transport a standalone driver
>   firmware: arm_scmi: Make OPTEE transport a standalone driver
>   firmware: arm_scmi: Make VirtIO transport a standalone driver
>   firmware: arm_scmi: Remove legacy transport-layer code
>
> Peng Fan (1):
>   firmware: arm_scmi: Introduce setup_shmem_iomap
>
>  drivers/firmware/arm_scmi/Kconfig             |  20 +-
>  drivers/firmware/arm_scmi/Makefile            |   9 +-
>  drivers/firmware/arm_scmi/common.h            | 184 +++++++++++++-----
>  drivers/firmware/arm_scmi/driver.c            | 142 +++++---------
>  drivers/firmware/arm_scmi/msg.c               |  32 ++-
>  .../{mailbox.c => scmi_transport_mailbox.c}   |  72 +++----
>  .../{optee.c => scmi_transport_optee.c}       | 130 ++++++-------
>  .../arm_scmi/{smc.c => scmi_transport_smc.c}  |  57 +++---
>  .../{virtio.c => scmi_transport_virtio.c}     | 102 +++++-----
>  drivers/firmware/arm_scmi/shmem.c             |  85 ++++++--
>  10 files changed, 477 insertions(+), 356 deletions(-)
>  rename drivers/firmware/arm_scmi/{mailbox.c => scmi_transport_mailbox.c} (86%)
>  rename drivers/firmware/arm_scmi/{optee.c => scmi_transport_optee.c} (89%)
>  rename drivers/firmware/arm_scmi/{smc.c => scmi_transport_smc.c} (87%)
>  rename drivers/firmware/arm_scmi/{virtio.c => scmi_transport_virtio.c} (94%)
>

