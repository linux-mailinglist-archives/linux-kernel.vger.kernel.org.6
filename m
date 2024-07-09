Return-Path: <linux-kernel+bounces-245140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74E992AEE0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33971C210E0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5934487BF;
	Tue,  9 Jul 2024 03:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ea+9Z1ud"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D3D4A0C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 03:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720497318; cv=none; b=PBeGiA93Tl/4YUse3b9ZohtJjELT51GP7ehuLY3UnvfCP+sfjQy1kmp/t4z7BB8Ra/v+lNEIKMrgTGp9vfWeZsT8eKLnT8p1vl5DFv9VBqB7NK/1/4J6lNidXyopAI36sRlzIDCWa3AG0XgvjH8nIxDphv2bJ9jNIpo8SP7p7mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720497318; c=relaxed/simple;
	bh=O8irW42RvadE8r+wXPbl5Wsx3skZMveAA7LvsEbNT3Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=nKzpqmUHFtkZ+L5SEMduf5dKO8F+CJAJF2PnCGFMpLxmJV6tKHoAfcLrcVSzU2qSGfKTANtm4n9MION1/9tCnIup8a0foKv4OJmgFNrjQFUkU48A+fGf5OV0fCW86iITEZc/9+Rtewx1/vi74ZBc6LShtY1O4nS6g9t3O+aOrKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ea+9Z1ud; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4693c44x030713;
	Tue, 9 Jul 2024 03:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O8irW42RvadE8r+wXPbl5Wsx3skZMveAA7LvsEbNT3Q=; b=Ea+9Z1udYS2g81Z6
	cZ+vbym+Hs8hFgnmg0w3rpSLdPv0j9eCx20jcCxICMq06B9x64oYwXym6UYzhpPf
	xjd4caFN29VqAIrwz5Nti/CGo85/Nc7bpWEb9aIt9lzHdGuX4Ah7clBpTR2S5EMW
	EHOJhC4mydoaL0DlMEZqvL0afJ4gahqJ68yZOXPJqkOrSH8S6B67cUBx9HW4m2gH
	QcYvj9IFlKQ95io7MH6zwlT/OGIa4QGcuvcjmlUGqJx7qCPWOQL1E6bpdD7U+xDv
	OWbCH5VNniUY0I/LPgWhcAGXVtSUIETaJ/w0eqRUcsuHVXe8HqdDkbhM59VdfFOn
	5GX2Yw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406we8w738-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 03:55:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4693t89F027252
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 03:55:08 GMT
Received: from [10.48.245.228] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Jul 2024
 20:55:08 -0700
Message-ID: <837cd2e4-d231-411a-8af4-64b950c4066a@quicinc.com>
Date: Mon, 8 Jul 2024 20:55:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: crosstool: x86 kernel compiled with GCC 14.1 fails to boot
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-kernel@vger.kernel.org>, <ath12k@lists.infradead.org>
References: <87y16bbvgb.fsf@kernel.org>
 <917565ee-732a-4df0-a717-a71fbb34fd79@quicinc.com>
In-Reply-To: <917565ee-732a-4df0-a717-a71fbb34fd79@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -QpUbxONPt72TVycUvDZO8pk63ESEXhq
X-Proofpoint-GUID: -QpUbxONPt72TVycUvDZO8pk63ESEXhq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407090023

On 7/8/2024 6:57 PM, Jeff Johnson wrote:
> We tend to enable a lot of debug config options, so I'm wondering if one of
> them is contributing to the issue? Guess I'll turn off a bunch of those
> options and try again.

OK, with a bunch of debug turned off my image boots.

Now to find the culprit.

Current diff between original config and working config:

20d19
< CONFIG_CONSTRUCTORS=y
328d326
< CONFIG_GENERIC_CSUM=y
337d334
< CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
858a856
> CONFIG_VMAP_STACK=y
10938,10940d10935
< CONFIG_STACKDEPOT=y
< CONFIG_STACKDEPOT_ALWAYS_INIT=y
< CONFIG_STACKDEPOT_MAX_FRAMES=64
10996,10997d10990
< CONFIG_ARCH_WANT_FRAME_POINTERS=y
< CONFIG_FRAME_POINTER=y
10999d10991
< CONFIG_STACK_VALIDATION=y
11040a11033
> # CONFIG_KCSAN is not set
11056,11057c11049
< CONFIG_SLUB_DEBUG=y
< # CONFIG_SLUB_DEBUG_ON is not set
---
> # CONFIG_SLUB_DEBUG is not set
11060c11052
< CONFIG_PAGE_POISONING=y
---
> # CONFIG_PAGE_POISONING is not set
11064c11056
< CONFIG_DEBUG_WX=y
---
> # CONFIG_DEBUG_WX is not set
11066d11057
< CONFIG_PTDUMP_CORE=y
11069,11072c11060
< CONFIG_DEBUG_KMEMLEAK=y
< CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
< # CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
< CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
---
> # CONFIG_DEBUG_KMEMLEAK is not set
11074,11081c11062
< CONFIG_DEBUG_OBJECTS=y
< # CONFIG_DEBUG_OBJECTS_SELFTEST is not set
< # CONFIG_DEBUG_OBJECTS_FREE is not set
< CONFIG_DEBUG_OBJECTS_TIMERS=y
< CONFIG_DEBUG_OBJECTS_WORK=y
< CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
< CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
< CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
---
> # CONFIG_DEBUG_OBJECTS is not set
11084c11065
< CONFIG_SCHED_STACK_END_CHECK=y
---
> # CONFIG_SCHED_STACK_END_CHECK is not set
11091c11072
< CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
---
> # CONFIG_MEMORY_NOTIFIER_ERROR_INJECT is not set
11099,11107c11080
< CONFIG_KASAN=y
< CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=y
< CONFIG_KASAN_GENERIC=y
< # CONFIG_KASAN_OUTLINE is not set
< CONFIG_KASAN_INLINE=y
< CONFIG_KASAN_STACK=y
< # CONFIG_KASAN_VMALLOC is not set
< # CONFIG_KASAN_MODULE_TEST is not set
< # CONFIG_KASAN_EXTRA_INFO is not set
---
> # CONFIG_KASAN is not set
11109,11114c11082
< CONFIG_KFENCE=y
< CONFIG_KFENCE_SAMPLE_INTERVAL=0
< CONFIG_KFENCE_NUM_OBJECTS=255
< # CONFIG_KFENCE_DEFERRABLE is not set
< # CONFIG_KFENCE_STATIC_KEYS is not set
< CONFIG_KFENCE_STRESS_TEST_FAULTS=0
---
> # CONFIG_KFENCE is not set
11126,11128c11094
< CONFIG_LOCKUP_DETECTOR=y
< CONFIG_SOFTLOCKUP_DETECTOR=y
< # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
---
> # CONFIG_SOFTLOCKUP_DETECTOR is not set
11130,11135c11096
< CONFIG_HARDLOCKUP_DETECTOR=y
< # CONFIG_HARDLOCKUP_DETECTOR_PREFER_BUDDY is not set
< CONFIG_HARDLOCKUP_DETECTOR_PERF=y
< # CONFIG_HARDLOCKUP_DETECTOR_BUDDY is not set
< # CONFIG_HARDLOCKUP_DETECTOR_ARCH is not set
< CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER=y
---
> # CONFIG_HARDLOCKUP_DETECTOR is not set
11137,11140c11098
< # CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
< CONFIG_DETECT_HUNG_TASK=y
< CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
< # CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
---
> # CONFIG_DETECT_HUNG_TASK is not set
11149c11107
< CONFIG_SCHED_DEBUG=y
---
> # CONFIG_SCHED_DEBUG is not set
11151c11109
< CONFIG_SCHEDSTATS=y
---
> # CONFIG_SCHEDSTATS is not set
11161,11162c11119
< CONFIG_PROVE_LOCKING=y
< # CONFIG_PROVE_RAW_LOCK_NESTING is not set
---
> # CONFIG_PROVE_LOCKING is not set
11164,11176c11121,11126
< CONFIG_DEBUG_RT_MUTEXES=y
< CONFIG_DEBUG_SPINLOCK=y
< CONFIG_DEBUG_MUTEXES=y
< CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
< CONFIG_DEBUG_RWSEMS=y
< CONFIG_DEBUG_LOCK_ALLOC=y
< CONFIG_LOCKDEP=y
< CONFIG_LOCKDEP_BITS=15
< CONFIG_LOCKDEP_CHAINS_BITS=16
< CONFIG_LOCKDEP_STACK_TRACE_BITS=19
< CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
< CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
< # CONFIG_DEBUG_LOCKDEP is not set
---
> # CONFIG_DEBUG_RT_MUTEXES is not set
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_MUTEXES is not set
> # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> # CONFIG_DEBUG_RWSEMS is not set
> # CONFIG_DEBUG_LOCK_ALLOC is not set
11185,11186d11134
< CONFIG_TRACE_IRQFLAGS=y
< CONFIG_TRACE_IRQFLAGS_NMI=y
11192d11139
< # CONFIG_DEBUG_KOBJECT_RELEASE is not set
11208d11154
< CONFIG_PROVE_RCU=y
11248d11193
< CONFIG_PREEMPTIRQ_TRACEPOINTS=y
11327d11271
< # CONFIG_SAMPLE_KMEMLEAK is not set
11337d11280
< CONFIG_EARLY_PRINTK_USB=y
11339,11341c11282
< CONFIG_EARLY_PRINTK=y
< CONFIG_EARLY_PRINTK_DBGP=y
< CONFIG_EARLY_PRINTK_USB_XDBC=y
---
> # CONFIG_EARLY_PRINTK is not set
11347,11348c11288,11289
< # CONFIG_IO_DELAY_0X80 is not set
< CONFIG_IO_DELAY_0XED=y
---
> CONFIG_IO_DELAY_0X80=y
> # CONFIG_IO_DELAY_0XED is not set
11355,11358c11296,11300
< CONFIG_X86_DEBUG_FPU=y
< CONFIG_PUNIT_ATOM_DEBUG=m
< # CONFIG_UNWINDER_ORC is not set
< CONFIG_UNWINDER_FRAME_POINTER=y
---
> # CONFIG_X86_DEBUG_FPU is not set
> # CONFIG_PUNIT_ATOM_DEBUG is not set
> CONFIG_UNWINDER_ORC=y
> # CONFIG_UNWINDER_FRAME_POINTER is not set
> # CONFIG_UNWINDER_GUESS is not set


