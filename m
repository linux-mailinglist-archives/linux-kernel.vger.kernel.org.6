Return-Path: <linux-kernel+bounces-382317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C3D9B0C46
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44E7B1C22160
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F60A1FB89E;
	Fri, 25 Oct 2024 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Bz95PAG/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F5A1FB899
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729878921; cv=none; b=XMp+facdUpY8g+TVfrAob1riaLq0R7mErpR3E0Oc8tkQVtxGmp6kJfIiSn5o/oRIde9AJkZ8gLpmKpPwBf1hf3dP0r4W2wwksg4xR14g6mKg8q8/ES+axLRrGnUqoaaqC+izXMjpFSiPt/LEzH39fsmbce+Ka6V0YVp9nTqfwsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729878921; c=relaxed/simple;
	bh=r01ITRl0d4pSUkV5jGF5hrON/0gVGGKrMIrQTPsgSQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ag2ipizPGYZBHBM0mMGfl/185CNG7zVqeQ+0SjXSpyhWtKL7mrg0oxYFPnANcjmIYMECTcesDogmE6uZJUavRh/3gCGOvYIr0TphxQGyix+hALKwp8nVcJRpUlLR1/UGg8aV+cCKcxHVTQsSRCNK8q59kE0dNRIa54Zazy1AMxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Bz95PAG/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PFf0Ag019959;
	Fri, 25 Oct 2024 17:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A5YxzI/nMdCg215EEiGFIDBSrUTiMFKif/BJ6ubo9j4=; b=Bz95PAG/Nqy1HV6T
	wkv8+S7KWRlNDOp6gpM2vRvix1ZijRHpYxHPCUEsppUtIq1FFTN4+uSSn8ScHxyh
	X7ndwuzIk7DujEt7QhZlQxcMVKRql9FS0agWiieyBn89dBeMqGwdQeposARbWgY3
	G+9eIeW6GBjki/zsDCloaviidpuaS4gRwg91Ifx0orBrn2majr1+RZvY1p4fug90
	4HTaplppFesFC6IWroBR7tvvZKY0eIy2qLyOXHe0ouuEkXI5zrkvFw/FLVzIEvWb
	L1aXTbQR4jSeIk1jxiHSuMYR+m6tArYpScc79JTSAvSYZaIWR2VvqcVj9J+/ZCwY
	RCq4FA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42g6y91umf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 17:55:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49PHtE1h010171
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 17:55:14 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 25 Oct
 2024 10:55:13 -0700
Message-ID: <de895a18-e40f-4996-b799-0a957bd3ca48@quicinc.com>
Date: Fri, 25 Oct 2024 11:55:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V5 00/10] AMD XDNA driver
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>
References: <20241021161931.3701754-1-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20241021161931.3701754-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: w1Why7TjCE9xTvs7YbAdqVR81PmMSAnz
X-Proofpoint-ORIG-GUID: w1Why7TjCE9xTvs7YbAdqVR81PmMSAnz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250136

On 10/21/2024 10:19 AM, Lizhi Hou wrote:
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
> 
> The firmware for the NPU is distributed as a closed source binary, and has
> already been pushed to the DRM firmware repository [4].
> 
> [1]https://www.amd.com/en/technologies/xdna.html
> [2]https://github.com/Xilinx/XRT
> [3]https://github.com/nod-ai/iree-amd-aie
> [4]https://gitlab.freedesktop.org/drm/firmware/-/tree/amd-ipu-staging/amdnpu
> 
> Changes since v4:
> - Fix lockdep errors
> - Use __u* structure for struct aie_error

One nit, when you send the next version would you please either To: or 
Cc: me on the entire series?  I only get pieces in my inbox which is 
mildly annoying on my end.

Looks like we are getting close here.  One procedural question I have, 
do you have commit permissions to drm-misc?

I applied the series to drm-misc-next and tried to build.  Got the 
following errors -

   CC [M]  drivers/accel/amdxdna/aie2_ctx.o
   CC [M]  drivers/accel/amdxdna/aie2_error.o
   CC [M]  drivers/accel/amdxdna/aie2_message.o
   CC [M]  drivers/accel/amdxdna/aie2_pci.o
   CC [M]  drivers/accel/amdxdna/aie2_psp.o
   CC [M]  drivers/accel/amdxdna/aie2_smu.o
   CC [M]  drivers/accel/amdxdna/aie2_solver.o
   CC [M]  drivers/accel/amdxdna/amdxdna_ctx.o
   CC [M]  drivers/accel/amdxdna/amdxdna_gem.o
   CC [M]  drivers/accel/amdxdna/amdxdna_mailbox.o
   CC [M]  drivers/accel/amdxdna/amdxdna_mailbox_helper.o
   CC [M]  drivers/accel/amdxdna/amdxdna_pci_drv.o
   CC [M]  drivers/accel/amdxdna/amdxdna_sysfs.o
   CC [M]  drivers/accel/amdxdna/npu1_regs.o
   CC [M]  drivers/accel/amdxdna/npu2_regs.o
   CC [M]  drivers/accel/amdxdna/npu4_regs.o
   CC [M]  drivers/accel/amdxdna/npu5_regs.o
   AR      drivers/base/firmware_loader/built-in.a
   AR      drivers/base/built-in.a
In file included from drivers/accel/amdxdna/aie2_message.c:19:
drivers/accel/amdxdna/amdxdna_ctx.h: In function ‘amdxdna_cmd_get_op’:
drivers/accel/amdxdna/amdxdna_ctx.h:112:16: error: implicit declaration 
of function ‘FIELD_GET’ [-Werror=implicit-function-declaration]
   112 |         return FIELD_GET(AMDXDNA_CMD_OPCODE, cmd->header);
       |                ^~~~~~~~~
In file included from drivers/accel/amdxdna/amdxdna_gem.c:15:
drivers/accel/amdxdna/amdxdna_ctx.h: In function ‘amdxdna_cmd_get_op’:
drivers/accel/amdxdna/amdxdna_ctx.h:112:16: error: implicit declaration 
of function ‘FIELD_GET’ [-Werror=implicit-function-declaration]
   112 |         return FIELD_GET(AMDXDNA_CMD_OPCODE, cmd->header);
       |                ^~~~~~~~~
In file included from drivers/accel/amdxdna/aie2_psp.c:11:
drivers/accel/amdxdna/aie2_psp.c: In function ‘psp_exec’:
drivers/accel/amdxdna/aie2_psp.c:62:34: error: implicit declaration of 
function ‘FIELD_GET’ [-Werror=implicit-function-declaration]
    62 |                                  FIELD_GET(PSP_STATUS_READY, 
ready),
       |                                  ^~~~~~~~~
./include/linux/iopoll.h:47:21: note: in definition of macro 
‘read_poll_timeout’
    47 |                 if (cond) \
       |                     ^~~~
drivers/accel/amdxdna/aie2_psp.c:61:15: note: in expansion of macro 
‘readx_poll_timeout’
    61 |         ret = readx_poll_timeout(readl, PSP_REG(psp, 
PSP_STATUS_REG), ready,
       |               ^~~~~~~~~~~~~~~~~~
drivers/accel/amdxdna/amdxdna_ctx.h: In function ‘amdxdna_cmd_set_state’:
drivers/accel/amdxdna/amdxdna_ctx.h:121:24: error: implicit declaration 
of function ‘FIELD_PREP’ [-Werror=implicit-function-declaration]
   121 |         cmd->header |= FIELD_PREP(AMDXDNA_CMD_STATE, s);
       |                        ^~~~~~~~~~
drivers/accel/amdxdna/amdxdna_ctx.h: In function ‘amdxdna_cmd_set_state’:
drivers/accel/amdxdna/amdxdna_ctx.h:121:24: error: implicit declaration 
of function ‘FIELD_PREP’ [-Werror=implicit-function-declaration]
   121 |         cmd->header |= FIELD_PREP(AMDXDNA_CMD_STATE, s);
       |                        ^~~~~~~~~~
In file included from drivers/accel/amdxdna/aie2_pci.c:22:
drivers/accel/amdxdna/amdxdna_ctx.h: In function ‘amdxdna_cmd_get_op’:
drivers/accel/amdxdna/amdxdna_ctx.h:112:16: error: implicit declaration 
of function ‘FIELD_GET’ [-Werror=implicit-function-declaration]
   112 |         return FIELD_GET(AMDXDNA_CMD_OPCODE, cmd->header);
       |                ^~~~~~~~~
In file included from drivers/accel/amdxdna/aie2_ctx.c:18:
drivers/accel/amdxdna/amdxdna_ctx.h: In function ‘amdxdna_cmd_get_op’:
drivers/accel/amdxdna/amdxdna_ctx.h:112:16: error: implicit declaration 
of function ‘FIELD_GET’ [-Werror=implicit-function-declaration]
   112 |         return FIELD_GET(AMDXDNA_CMD_OPCODE, cmd->header);
       |                ^~~~~~~~~
drivers/accel/amdxdna/amdxdna_ctx.h: In function ‘amdxdna_cmd_set_state’:
drivers/accel/amdxdna/amdxdna_ctx.h:121:24: error: implicit declaration 
of function ‘FIELD_PREP’ [-Werror=implicit-function-declaration]
   121 |         cmd->header |= FIELD_PREP(AMDXDNA_CMD_STATE, s);
       |                        ^~~~~~~~~~
In file included from drivers/accel/amdxdna/amdxdna_ctx.c:16:
drivers/accel/amdxdna/amdxdna_ctx.h: In function ‘amdxdna_cmd_get_op’:
drivers/accel/amdxdna/amdxdna_ctx.h:112:16: error: implicit declaration 
of function ‘FIELD_GET’ [-Werror=implicit-function-declaration]
   112 |         return FIELD_GET(AMDXDNA_CMD_OPCODE, cmd->header);
       |                ^~~~~~~~~
cc1: all warnings being treated as errors
drivers/accel/amdxdna/amdxdna_ctx.h: In function ‘amdxdna_cmd_set_state’:
drivers/accel/amdxdna/amdxdna_ctx.h:121:24: error: implicit declaration 
of function ‘FIELD_PREP’ [-Werror=implicit-function-declaration]
   121 |         cmd->header |= FIELD_PREP(AMDXDNA_CMD_STATE, s);
       |                        ^~~~~~~~~~
drivers/accel/amdxdna/aie2_ctx.c: In function ‘aie2_hwctx_restart’:
drivers/accel/amdxdna/aie2_ctx.c:114:9: error: too few arguments to 
function ‘drm_sched_start’
   114 |         drm_sched_start(&hwctx->priv->sched);
       |         ^~~~~~~~~~~~~~~
In file included from ./include/trace/events/amdxdna.h:12,
                  from drivers/accel/amdxdna/aie2_ctx.c:13:
./include/drm/gpu_scheduler.h:593:6: note: declared here
   593 | void drm_sched_start(struct drm_gpu_scheduler *sched, int errno);
       |      ^~~~~~~~~~~~~~~
make[5]: *** [scripts/Makefile.build:229: 
drivers/accel/amdxdna/aie2_psp.o] Error 1
make[5]: *** Waiting for unfinished jobs....
drivers/accel/amdxdna/amdxdna_ctx.h: In function ‘amdxdna_cmd_set_state’:
drivers/accel/amdxdna/amdxdna_ctx.h:121:24: error: implicit declaration 
of function ‘FIELD_PREP’ [-Werror=implicit-function-declaration]
   121 |         cmd->header |= FIELD_PREP(AMDXDNA_CMD_STATE, s);
       |                        ^~~~~~~~~~
In file included from drivers/accel/amdxdna/amdxdna_pci_drv.c:18:
drivers/accel/amdxdna/amdxdna_ctx.h: In function ‘amdxdna_cmd_get_op’:
drivers/accel/amdxdna/amdxdna_ctx.h:112:16: error: implicit declaration 
of function ‘FIELD_GET’ [-Werror=implicit-function-declaration]
   112 |         return FIELD_GET(AMDXDNA_CMD_OPCODE, cmd->header);
       |                ^~~~~~~~~
cc1: all warnings being treated as errors
make[5]: *** [scripts/Makefile.build:229: 
drivers/accel/amdxdna/aie2_ctx.o] Error 1
drivers/accel/amdxdna/amdxdna_ctx.h: In function ‘amdxdna_cmd_set_state’:
drivers/accel/amdxdna/amdxdna_ctx.h:121:24: error: implicit declaration 
of function ‘FIELD_PREP’ [-Werror=implicit-function-declaration]
   121 |         cmd->header |= FIELD_PREP(AMDXDNA_CMD_STATE, s);
       |                        ^~~~~~~~~~
drivers/accel/amdxdna/amdxdna_mailbox.c: In function 
‘xdna_mailbox_send_msg’:
drivers/accel/amdxdna/amdxdna_mailbox.c:444:26: error: implicit 
declaration of function ‘FIELD_PREP’ [-Werror=implicit-function-declaration]
   444 |         header->sz_ver = FIELD_PREP(MSG_BODY_SZ, msg->send_size) |
       |                          ^~~~~~~~~~


You also have the following checkpatch issues -


WARNING: 'Disalbe' may be misspelled - perhaps 'Disable'?
#1646: FILE: drivers/accel/amdxdna/amdxdna_mailbox.c:553:
+       /* Disalbe an irq and wait. This might sleep. */
            ^^^^^^^

WARNING: 'splite' may be misspelled - perhaps 'split'?
#1695: FILE: drivers/accel/amdxdna/amdxdna_mailbox.h:21:
+ * The mailbox will splite the sending data in to multiple firmware 
message if
                      ^^^^^^

WARNING: 'miliseconds' may be misspelled - perhaps 'milliseconds'?
#1875: FILE: drivers/accel/amdxdna/amdxdna_mailbox_helper.h:9:
+#define TX_TIMEOUT 2000 /* miliseconds */
                             ^^^^^^^^^^^

WARNING: 'miliseconds' may be misspelled - perhaps 'milliseconds'?
#1876: FILE: drivers/accel/amdxdna/amdxdna_mailbox_helper.h:10:
+#define RX_TIMEOUT 5000 /* miliseconds */
                             ^^^^^^^^^^^

total: 0 errors, 4 warnings, 0 checks, 1916 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or 
--fix-inplace.

0003-accel-amdxdna-Support-hardware-mailbox.patch has style problems, 
please review.



0007-accel-amdxdna-Add-command-execution.patch
----------------------------------------------
WARNING: 'miliseconds' may be misspelled - perhaps 'milliseconds'?
#59: FILE: drivers/accel/amdxdna/aie2_ctx.c:27:
+#define HWCTX_MAX_TIMEOUT      60000 /* miliseconds */
                                          ^^^^^^^^^^^

WARNING: 'reverve' may be misspelled - perhaps 'reserve'?
#612: FILE: drivers/accel/amdxdna/aie2_ctx.c:779:
+               XDNA_WARN(xdna, "Failed to reverve fence, ret %d", ret);
                                            ^^^^^^^

WARNING: 'Exectuion' may be misspelled - perhaps 'Execution'?
#1899: FILE: drivers/accel/amdxdna/amdxdna_pci_drv.c:139:
+       /* Exectuion */
            ^^^^^^^^^

WARNING: 'exectuion' may be misspelled - perhaps 'execution'?
#2113: FILE: include/uapi/drm/amdxdna_accel.h:239:
+ * struct amdxdna_drm_wait_cmd - Wait exectuion command.
                                        ^^^^^^^^^

total: 0 errors, 10 warnings, 0 checks, 1983 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or 
--fix-inplace.

0007-accel-amdxdna-Add-command-execution.patch has style problems, 
please review.


0008-accel-amdxdna-Add-suspend-and-resume.patch
-----------------------------------------------
WARNING: 'miliseconds' may be misspelled - perhaps 'milliseconds'?
#163: FILE: drivers/accel/amdxdna/amdxdna_pci_drv.c:22:
+#define AMDXDNA_AUTOSUSPEND_DELAY      5000 /* miliseconds */
                                                 ^^^^^^^^^^^

total: 0 errors, 1 warnings, 0 checks, 302 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or 
--fix-inplace.

0008-accel-amdxdna-Add-suspend-and-resume.patch has style problems, 
please review.


-Jeff

