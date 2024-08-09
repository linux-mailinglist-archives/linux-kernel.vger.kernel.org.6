Return-Path: <linux-kernel+bounces-281117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF5594D34A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AF03B21639
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B951B197A9E;
	Fri,  9 Aug 2024 15:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OShB5ktm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBBE1DFE1
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216877; cv=none; b=eSKbT8qLTlo/edNb1Ahnj9JJanDHqukXa8djtMrYfPZskVW3R9/3qAZ3fPZjES2RDFvXzkbGlLzsOP58VzqciUkLQoKQq8qOGyLzAwKA9PwZqTXm7bcI1+wWN1snofx8YawAniFevQiETcbNn90FG6qNtkE45YMUz0bAxF/26M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216877; c=relaxed/simple;
	bh=+e45tLYw96QzSx1JJxifNwQRkTEEc2NjzN/OrVccRR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nJXLA6kqvZSsHfzdl4AVeELQ4WD203umeW3t+I2E6HAuShB5qoSJZyy/DPHG88sqycKpOGyM83yFETH29keFBfPYGzNb9w0RU885gOVRhR5YploqlrUo2jnfMcqevhHnZQnGpyJ7wgsqAjrBgmjAqdGlA1OAPAHfMjX0t6lIdXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OShB5ktm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4799amt7022651;
	Fri, 9 Aug 2024 15:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eofYyZ1RqBF9U+H27nAEGGgxJ2PAI/2nNJ2a3PlEXos=; b=OShB5ktmWzsnCVTe
	qttsX08aOFdQ64lPQYwDDxDVyLaRkbg75Cn9vhx16RXZhhHeXpyEQyWxIn7dPJ1E
	YWC6D9o/XOLYrEyvg7DcQGG0eaMye7qsL95gBNQdlwg0XTNHkhPvANMaENwQ+81O
	Mh9wjbqafSeqX7INIkeK+5UtFGTAR77ol979IIpOt6bRjX/KTgOTKMJdAGLWcBXa
	qq9U0e4lFsi88RW7nziN+AE0gm/nLHaOz+wERBXy4+kRT9bkBtJpoPKG/m6dxDYJ
	SK4R3qRfSkwmjrTTCBDrwrKn968immUX6+lTG6Le8gahezraJD8vlWhDPFJiZb2C
	D7TRzA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40vtbcvbkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 15:21:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 479FL7CT019525
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Aug 2024 15:21:07 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 9 Aug 2024
 08:21:07 -0700
Message-ID: <292c06d0-b96a-b5b5-5d82-e74b82bbb6de@quicinc.com>
Date: Fri, 9 Aug 2024 09:21:06 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V2 00/10] AMD XDNA driver
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>
References: <20240805173959.3181199-1-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20240805173959.3181199-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NedW00QHtyXo4LBOQs5ju31uENv0icjD
X-Proofpoint-ORIG-GUID: NedW00QHtyXo4LBOQs5ju31uENv0icjD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_12,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1011 impostorscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408090111

On 8/5/2024 11:39 AM, Lizhi Hou wrote:
> This patchset introduces a new Linux Kernel Driver, amdxdna for AMD NPUs.
> The driver is based on Linux accel subsystem.
> 
> NPU (Neural Processing Unit) is an AI inference accelerator integrated
> into AMD client CPUs. NPU enables efficient execution of Machine Learning
> applications like CNNs, LLMs, etc.  NPU is based on AMD XDNA
> architecture [1].
> 
> AMD NPU consists of the following components:
> 
>    - Tiled array of AMD AI Engine processors.
>    - Micro Controller which runs the NPU Firmware responsible for
>      command processing, AIE array configuration, and execution management.
>    - PCI EP for host control of the NPU device.
>    - Interconnect for connecting the NPU components together.
>    - SRAM for use by the NPU Firmware.
>    - Address translation hardware for protected host memory access by the
>      NPU.
> 
> NPU supports multiple concurrent fully isolated contexts. Concurrent
> contexts may be bound to AI Engine array spatially and or temporarily.
> 
> The driver is licensed under GPL-2.0 except for UAPI header which is
> licensed GPL-2.0 WITH Linux-syscall-note.
> 
> User mode driver stack consists of XRT [2] and AMD AIE Plugin for IREE [3].

Is there a special branch with the code?  I don't see any of the uAPI in 
either project when searching for the ioctl codes or ioctl structures.

> 
> The firmware for the NPU is distributed as a closed source binary, and has
> already been pushed to the DRM firmware repository [4].
> 
> [1] https://www.amd.com/en/technologies/xdna.html
> [2] https://github.com/Xilinx/XRT
> [3] https://github.com/nod-ai/iree-amd-aie
> [4] https://gitlab.freedesktop.org/drm/firmware/-/tree/amd-ipu-staging/amdnpu
> 
> Changes since v1:
> - Remove some inline defines
> - Minor changes based code review comments
> 
> Lizhi Hou (10):
>    accel/amdxdna: Add a new driver for AMD AI Engine
>    accel/amdxdna: Support hardware mailbox
>    accel/amdxdna: Add hardware resource solver
>    accel/amdxdna: Add hardware context
>    accel/amdxdna: Add GEM buffer object management
>    accel/amdxdna: Add command execution
>    accel/amdxdna: Add suspend and resume
>    accel/amdxdna: Add error handling
>    accel/amdxdna: Add query functions
>    accel/amdxdna: Add firmware debug buffer support
> 
>   MAINTAINERS                                   |   9 +
>   drivers/accel/Kconfig                         |   1 +
>   drivers/accel/Makefile                        |   1 +
>   drivers/accel/amdxdna/Kconfig                 |  15 +
>   drivers/accel/amdxdna/Makefile                |  22 +
>   drivers/accel/amdxdna/TODO                    |   4 +
>   drivers/accel/amdxdna/aie2_ctx.c              | 949 ++++++++++++++++++
>   drivers/accel/amdxdna/aie2_error.c            | 349 +++++++
>   drivers/accel/amdxdna/aie2_message.c          | 775 ++++++++++++++
>   drivers/accel/amdxdna/aie2_msg_priv.h         | 372 +++++++
>   drivers/accel/amdxdna/aie2_pci.c              | 756 ++++++++++++++
>   drivers/accel/amdxdna/aie2_pci.h              | 264 +++++
>   drivers/accel/amdxdna/aie2_psp.c              | 137 +++
>   drivers/accel/amdxdna/aie2_smu.c              | 112 +++
>   drivers/accel/amdxdna/aie2_solver.c           | 329 ++++++
>   drivers/accel/amdxdna/aie2_solver.h           | 156 +++
>   drivers/accel/amdxdna/amdxdna_ctx.c           | 597 +++++++++++
>   drivers/accel/amdxdna/amdxdna_ctx.h           | 165 +++
>   drivers/accel/amdxdna/amdxdna_drm.c           | 172 ++++
>   drivers/accel/amdxdna/amdxdna_drm.h           | 114 +++
>   drivers/accel/amdxdna/amdxdna_gem.c           | 700 +++++++++++++
>   drivers/accel/amdxdna/amdxdna_gem.h           |  73 ++
>   drivers/accel/amdxdna/amdxdna_mailbox.c       | 582 +++++++++++
>   drivers/accel/amdxdna/amdxdna_mailbox.h       | 124 +++
>   .../accel/amdxdna/amdxdna_mailbox_helper.c    |  50 +
>   .../accel/amdxdna/amdxdna_mailbox_helper.h    |  43 +
>   drivers/accel/amdxdna/amdxdna_pci_drv.c       | 234 +++++
>   drivers/accel/amdxdna/amdxdna_pci_drv.h       |  31 +
>   drivers/accel/amdxdna/amdxdna_sysfs.c         |  58 ++
>   drivers/accel/amdxdna/npu1_regs.c             |  94 ++
>   drivers/accel/amdxdna/npu2_regs.c             | 111 ++
>   drivers/accel/amdxdna/npu4_regs.c             | 111 ++
>   drivers/accel/amdxdna/npu5_regs.c             | 111 ++
>   include/trace/events/amdxdna.h                | 101 ++
>   include/uapi/drm/amdxdna_accel.h              | 456 +++++++++
>   35 files changed, 8178 insertions(+)
>   create mode 100644 drivers/accel/amdxdna/Kconfig
>   create mode 100644 drivers/accel/amdxdna/Makefile
>   create mode 100644 drivers/accel/amdxdna/TODO
>   create mode 100644 drivers/accel/amdxdna/aie2_ctx.c
>   create mode 100644 drivers/accel/amdxdna/aie2_error.c
>   create mode 100644 drivers/accel/amdxdna/aie2_message.c
>   create mode 100644 drivers/accel/amdxdna/aie2_msg_priv.h
>   create mode 100644 drivers/accel/amdxdna/aie2_pci.c
>   create mode 100644 drivers/accel/amdxdna/aie2_pci.h
>   create mode 100644 drivers/accel/amdxdna/aie2_psp.c
>   create mode 100644 drivers/accel/amdxdna/aie2_smu.c
>   create mode 100644 drivers/accel/amdxdna/aie2_solver.c
>   create mode 100644 drivers/accel/amdxdna/aie2_solver.h
>   create mode 100644 drivers/accel/amdxdna/amdxdna_ctx.c
>   create mode 100644 drivers/accel/amdxdna/amdxdna_ctx.h
>   create mode 100644 drivers/accel/amdxdna/amdxdna_drm.c
>   create mode 100644 drivers/accel/amdxdna/amdxdna_drm.h
>   create mode 100644 drivers/accel/amdxdna/amdxdna_gem.c
>   create mode 100644 drivers/accel/amdxdna/amdxdna_gem.h
>   create mode 100644 drivers/accel/amdxdna/amdxdna_mailbox.c
>   create mode 100644 drivers/accel/amdxdna/amdxdna_mailbox.h
>   create mode 100644 drivers/accel/amdxdna/amdxdna_mailbox_helper.c
>   create mode 100644 drivers/accel/amdxdna/amdxdna_mailbox_helper.h
>   create mode 100644 drivers/accel/amdxdna/amdxdna_pci_drv.c
>   create mode 100644 drivers/accel/amdxdna/amdxdna_pci_drv.h
>   create mode 100644 drivers/accel/amdxdna/amdxdna_sysfs.c
>   create mode 100644 drivers/accel/amdxdna/npu1_regs.c
>   create mode 100644 drivers/accel/amdxdna/npu2_regs.c
>   create mode 100644 drivers/accel/amdxdna/npu4_regs.c
>   create mode 100644 drivers/accel/amdxdna/npu5_regs.c
>   create mode 100644 include/trace/events/amdxdna.h
>   create mode 100644 include/uapi/drm/amdxdna_accel.h
> 

No Documentation?

