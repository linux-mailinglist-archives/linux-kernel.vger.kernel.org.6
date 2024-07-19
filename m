Return-Path: <linux-kernel+bounces-257349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476229378E1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC888B210F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD831448DE;
	Fri, 19 Jul 2024 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LYyJO9nj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240EB39FF3;
	Fri, 19 Jul 2024 14:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721397702; cv=none; b=bxmYG7dihbuRJqrJ6TBwI87HCLzCFnb8syEN0nc7pH0WFPx4yR5k8OkWqopH94ctw9bi6mUvIDpODXpvwfzTQSOEmp09KBTTSljtvQ19sQEhhA08kEfsiwAGnA1cqxVDAufOzvNcYuIG62rAVN72sf0W2KVuUsU4gLWGndNVtTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721397702; c=relaxed/simple;
	bh=HDQU3FDX+hBa1O/Oib/v0VdziCMVN2qK+SSJPiYu710=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EKon3hoqSCVGPWx3Oj4PxuOGoAuM0F37xEIJMCEt24tXjoz3Lm2+9FGU+ucl4diFbibEh0hUwVJPnL/BJg8EBV0h0Ws0aLKetjMVLfOw3VCSSde7le3JDnkedbSqHRFsv/QA94pmRgtKDRVeLkbazpUE40RKXyEVB896ZwZ/yvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LYyJO9nj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JCVfr5002454;
	Fri, 19 Jul 2024 14:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0iOXd/KnUcqhuwFmJpV0aD60W+/rKAO1g0GIgi7G9dU=; b=LYyJO9njjal2idWQ
	pHOhc9v48Y3mFXXbo69osK52dhN/D2QEB1m6pC0VT4I8cWFE6izJVlgjMwNnXolR
	ukdcCv907hcFc3z5BaSFy2wnlJpSuGYRw4Zt5qMUJhnOF3k0Ds/1r/rAEu3sMBaR
	milE/AgVpodAQ976/mWxTO9CfzNtOrQiai5WaOGn08hjuBVDuDDa8bKhY6RgDjRz
	p0UGJ/xbZv/pSTN8VVHBMVXj7UhG3xtqyRdt6RhNvIdiwv66z5tvUIMNbRA+R7RN
	FdN5SwAgonLbrA6yAjkBbAsg38Q2rnC1O4iKS7dmylnlLecD8O8nA19F7zuFDW9u
	j62hpw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40fe94sm9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jul 2024 14:00:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46JE0J7r027068
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jul 2024 14:00:19 GMT
Received: from [10.48.247.102] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 19 Jul
 2024 07:00:18 -0700
Message-ID: <55341a0d-b07b-4f25-be45-dd0b352315aa@quicinc.com>
Date: Fri, 19 Jul 2024 07:00:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: MODULE_DESCRIPTION() patches with no maintainer action
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        "nouveau@lists.freedesktop.org"
	<nouveau@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stephen Boyd
	<sboyd@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
	<mhiramat@kernel.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen
	<ppaalanen@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy
 Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav
 Petkov <bp@alien8.de>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
References: <2d168cf9-e456-4262-b276-95e992b8eac7@quicinc.com>
 <bdac7f10-4c65-4be2-952b-aed1af04e2c9@app.fastmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <bdac7f10-4c65-4be2-952b-aed1af04e2c9@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sg1Ff6mAFYU0BUKqF12MoFAl9ng0bFVC
X-Proofpoint-ORIG-GUID: sg1Ff6mAFYU0BUKqF12MoFAl9ng0bFVC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 adultscore=0 malwarescore=0 clxscore=1011 phishscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407190107

On 7/19/2024 3:51 AM, Arnd Bergmann wrote:
> On Sun, Jul 14, 2024, at 23:46, Jeff Johnson wrote:
>> Andrew & Greg,
>>
>> I hate to bother you with such mundane patches, but the following have been
>> posted for a while without any maintainer or reviewer comment or action, and
>> they have not yet landed in linux-next.
>>
>> What is the path forward to have these MODULE_DESCRIPTION() warnings fixed?
>>
>> arch/arm/probes/kprobes/
>> https://lore.kernel.org/all/20240622-md-arm-arch-arm-probes-kprobes-v1-1-0832bd6e45db@quicinc.com/
>>
>> arch/x86/mm/
>> https://lore.kernel.org/all/20240515-testmmiotrace-md-v1-1-10919a8b2842@quicinc.com/
>>
>> drivers/spmi/
>> https://lore.kernel.org/all/20240609-md-drivers-spmi-v1-1-f1d5b24e7a66@quicinc.com/
>>
>> (note that beyond these 3 patches I still have an additional 13 patches which
>> need to land in order to fix these warnings tree-wide, but those 13 patches
>> have had recent maintainer or reviewer action so I'm not seeking your help at
>> this time).
> 
> Hi Jeff,
> 
> For completeness, this is a patch that I have in my local
> test tree now after I addressed the build issues for all
> randconfig builds on arm, arm64 and x86.
> 
> I assume you already a version of most of these,
> but please have a look in case there are some still
> missing.

You have found and fixed some that I didn't encounter with make allmodconfig
builds. I do have a list of ones for further analysis that I created by
looking for files with a MODULE_LICENSE but not a MODULE_DESCRIPTION, and the
ones I haven't yet fixed are on that list, but I'm very happy for you to
submit your fixes.

Details follow:

>  arch/arm/lib/xor-neon.c                         | 1 +
https://lore.kernel.org/all/20240711-md-arm-arch-arm-lib-v2-1-ab08653dc106@quicinc.com/

>  arch/x86/mm/testmmiotrace.c                     | 1 +
https://lore.kernel.org/all/20240515-testmmiotrace-md-v1-1-10919a8b2842@quicinc.com/

>  drivers/fpga/tests/fpga-bridge-test.c           | 1 +
>  drivers/fpga/tests/fpga-mgr-test.c              | 1 +
>  drivers/fpga/tests/fpga-region-test.c           | 1 +
I do not have a patch for these three

>  drivers/fsi/fsi-core.c                          | 1 +
>  drivers/fsi/fsi-master-aspeed.c                 | 2 ++
>  drivers/fsi/fsi-master-ast-cf.c                 | 1 +
>  drivers/fsi/fsi-master-gpio.c                   | 1 +
>  drivers/fsi/fsi-master-hub.c                    | 1 +
>  drivers/fsi/fsi-scom.c                          | 1 +
https://lore.kernel.org/all/20240605-md-drivers-fsi-v1-1-fefc82d81b12@quicinc.com/

>  drivers/xen/xenbus/xenbus_probe_frontend.c      | 1 +
I do not have a patch for this one

>  fs/adfs/super.c                                 | 2 ++
https://lore.kernel.org/all/20240523-md-adfs-v1-1-364268e38370@quicinc.com/

>  fs/exportfs/expfs.c                             | 1 +
I do not have a patch for this one

>  kernel/locking/test-ww_mutex.c                  | 1 +
https://lore.kernel.org/all/20240528-md-test-ww_mutex-v2-1-a2a19e920b12@quicinc.com/

>  lib/asn1_decoder.c                              | 1 +
>  lib/slub_kunit.c                                | 1 +
>  lib/ucs2_string.c                               | 1 +
>  lib/zlib_inflate/inflate_syms.c                 | 1 +
I do not have a patch for these four

>  mm/kasan/kasan_test.c                           | 1 +
>  mm/kasan/kasan_test_module.c                    | 1 +
I do not have a patch for these two

>  samples/livepatch/livepatch-callbacks-busymod.c | 1 +
>  samples/livepatch/livepatch-callbacks-demo.c    | 1 +
>  samples/livepatch/livepatch-callbacks-mod.c     | 1 +
>  samples/livepatch/livepatch-sample.c            | 1 +
>  samples/livepatch/livepatch-shadow-fix1.c       | 1 +
>  samples/livepatch/livepatch-shadow-fix2.c       | 1 +
I do not have a patch for these six

>  security/apparmor/policy_unpack_test.c          | 1 +
https://lore.kernel.org/all/20240529-md-apparmor_policy_unpack_test-v1-1-9efc582078c4@quicinc.com/



