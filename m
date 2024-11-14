Return-Path: <linux-kernel+bounces-408482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0A19C7F59
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329AA1F232DD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 00:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736A4A94A;
	Thu, 14 Nov 2024 00:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HQuY6qJV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uBdpRzvK"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A53257D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 00:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731543828; cv=fail; b=PW/7d0lG64/bOmtHyEttWEq5g4P7gjRCNnpbgV31/eoajgwdLJvYqfQbuWdLZ8c/Gr5evwNiJFhWEoqpgjYSlpXGO98tLL5cQTno4nWmQTINcQqipC1arDbcw2/XTAd0GPObuMsI3VCx7wL7p5VY4uYvZ1SqShF76cL5/jX962M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731543828; c=relaxed/simple;
	bh=RCq79FCylTIkjo8mCJHfBDZR5PzhjHbOi0xpJFz8cGU=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=Blg5EkOGS/nMMr/i2zClniouL/tT5dOUvWcbjfgR55FRPbRrB/Oz8CyqKXP1w4WPOoghu3wv0fEQEQlW1JUmJh5+TtmP+gSRqIGSQvI1juBYxHRuDqUanfhfBmruPiZ3SvfWm4HbBJ7Zv+PZwUvKwjXen2bbVSrIKgl/l6dnpBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HQuY6qJV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uBdpRzvK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADNBlwH008043;
	Thu, 14 Nov 2024 00:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=snTKt949doWOIJKe06j7Ks++mn0dkKbiLh4T9fIGnPc=; b=
	HQuY6qJVjR8IWDzxd6Qcfjy7Fig8TdUtZrSyWKSyGM6dDOvFQ/RFs9DB6S993YFh
	ncUoWMlPcDlK1DjPhaoIKsNScE0FxSsqnefbgaagDnyW+zZDIawCU+/vEHzDBxny
	Yo49zVn1WysZgl3fG7DzH294gKG9MPbo1PZQcAGh+qsHzA2KRP7Aqstn8A2bu+ui
	eti8hSyIFKz4Y8150hQjAw1IjGrqhM+HbBV5uaxwR2LzFrzPcvzTOhlANkZVFEMV
	Z1WUcJQTteV6l4R9iXPSzvigLYOK/FYrjBNk1BjZY0HnGe+pOvFgsIK604GU4Ct4
	u4m89VTVU4/H7lFQNlE1Pg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0her16v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 00:23:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADNLl1K005686;
	Thu, 14 Nov 2024 00:23:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6adf6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 00:23:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+TTIqxP0x849ciTE2j5bIhYm/gSzcIxhLajtwZD4TG41OFAkPXMZPMcPp2ygGUzcDez/snatodswuj3POXj6b2pGqcDInE6kriZAjI7eGGNb9lLxA2Bm3Dllme8ZaJxqhPDluUYXxRGVwhJTL08twMIcoR4u5YYi/uZXVahW3zO5RrxSjLFqFCntK4q+iRWaW2Fn5CPCoSlIqMF4emPSjPvkiynMVhwlWNoXJvOB701UyjheCp5UdApX4tdFq1k3TG62W99wgAOUEbCYPhqLb/sxumelYxtmf0MCp1XQKXLRG5mX/4T4I7XpnwyV1XjeTf7YeWJDduuts1EwgmYuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snTKt949doWOIJKe06j7Ks++mn0dkKbiLh4T9fIGnPc=;
 b=PUZywX85us18mzCo+41btiW4phwyMeqF1X/H09725dh71kjs6Hq7uzbIpcGnSPARmW9ivUXqpwo84fnV47ZdC07/stVG4Fn/LGMeRVOcYeCRRhzSbJRQ0skyYiCfyuXjk4bkkJIikeI6Fs54az75jO63iZEvzQSbo6nbxD/GyDVXWyeoLKUf39SYmTUU8epCQF3KV3gEKe/u5rRjGZsWaWPxDrXFh18BmiHrkVBF90RNkp78GSObIMOn4FueDLWUSKB0UmYWY1dXtzephHq0ZzyhH40GvdeMUNG2phzlzKFs9VwbLziCslz+9z7C2mr3AifUGKEeDE13nzNGJb+jRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snTKt949doWOIJKe06j7Ks++mn0dkKbiLh4T9fIGnPc=;
 b=uBdpRzvKDVvroBQNdiaJbsNSkfAi+PmTRPju75dXS6SnehtthtISVG0CAqqzO+uHs4omIb8CLVAgU1YirEI7neSb9G/1iQS11N+bMP3nfzQfSanHakDH16yuafruy1kDCwmjdywIJobtkjl4goiH2Ch3vh++GONRWEak2AOjgJA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB7530.namprd10.prod.outlook.com (2603:10b6:610:155::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 00:23:05 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 00:23:05 +0000
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
 <20241106201758.428310-4-ankur.a.arora@oracle.com>
 <ZzTGQ_zTS8NrxjW9@localhost.localdomain>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
        paulmck@kernel.org, mingo@kernel.org, bigeasy@linutronix.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, efault@gmx.de,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v2 3/6] rcu: limit PREEMPT_RCU configurations
In-reply-to: <ZzTGQ_zTS8NrxjW9@localhost.localdomain>
Date: Wed, 13 Nov 2024 16:23:03 -0800
Message-ID: <87bjyir7dk.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW4PR04CA0277.namprd04.prod.outlook.com
 (2603:10b6:303:89::12) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: 615aef46-3426-4919-deb2-08dd044281ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmNKVFBaQ2tnUDJIYWdXeGlValVuQlVsTzJnQlNRZ3lMZWp1MW01TC9FWlIy?=
 =?utf-8?B?VEZrRHdYb1prREtKWkZEdWJINEtxbXF1cVE5MzY0cWNMRlpod25peVkxQU5Q?=
 =?utf-8?B?dkhLVmVxMlZqbWUzTlZLVUxZUm9xZUhRYXI3K0dZVTRHYlNtMFoxUnA5SkQz?=
 =?utf-8?B?OXlWZXc4cHkraUxWZVg5akcvc2JONEZPOW9DaGwrVzZpMlJvaUVSemNBM1U1?=
 =?utf-8?B?VEVybEdWR09YY1hoZi9YRzM0Q3N3cmdnbGtwdEZiU0FYMzRCRlNabU9wcmha?=
 =?utf-8?B?ajdWekRodE1jemtiRjRCekFJS0VCUjVFOWlZYy9Mdmd1T3BFcEZxNUtERVhu?=
 =?utf-8?B?TWF2alpxUTh4Tkd0Qk9DemdhMmRNeXh1RFNOb1lxckw2TThkanZFOU81RkRt?=
 =?utf-8?B?bUZWam5GSzltTEFrTmJlV3A5WURoNjhrS0FWa3dpbDJOODVKZm50NEF5bVl5?=
 =?utf-8?B?YTU2RjhyR3JxVmFRTGhLV1ZZSnMwbVRqczhvdTJ0WVpYVzFPamNkKzRuQzhj?=
 =?utf-8?B?VlM0b3RCcHFBcWcwYUlYVnhWSGlGaUZNS2tpM0dBRzl6THV4T3hVR3liVlNl?=
 =?utf-8?B?TDZVYWc4b1ZIdWI4SkMrdTI0eDFkVGlJTk9iRGhqM0psZno3UjJKc3ZUZFpu?=
 =?utf-8?B?MGUzRlFYdy96TjhFMndBaFlzZUFsbWdBUHFhZWN2RVhZR1p6K0VSNFd2emZ5?=
 =?utf-8?B?cGpSc2c2MFRUcXE3M1dPUXNjSVdLb1ArVlpwNUUwWFhNT0xEZWNOWGpoVmZh?=
 =?utf-8?B?bkN6R0h3RUNsNmpVb3krZng2Q1MyR2JubFd2dnNmR3ZaR1R6dTBjT2RmZTUz?=
 =?utf-8?B?K3FpWmdFQjlXd3ZUZ2VFcmFOK3pSL1diaXhmL1dlM3pRUnpmVnBKWDZRMkNT?=
 =?utf-8?B?Ni9lSEdTdVV4eHI1cTJCM0UzY1hIZ3d6UXpUZlRQNTdKUWZFY1NXUU0rRVox?=
 =?utf-8?B?ODY1NlBwaGxiOWw2My9KbmhTWTg3akgrOWJiWnh1Q2VxWlI0SGZESUJRQXB2?=
 =?utf-8?B?WVovQiswVVpHTmNobnVxSnJTblliV1hWaUtaMTZQcTkwUWM5eHBmM3paY2M3?=
 =?utf-8?B?OFNLbW9ST2xxTHlnMEdnTkhNdy8zVkZnNFdsUXBDWHpoNXJJYjZLZFBlQkZw?=
 =?utf-8?B?TFRNZVBpUEp0UlhLOXVLdEFwclRIV3dmNzNCOW9OUDA5b3E3akkrU0duZmtQ?=
 =?utf-8?B?MVhuSmxMcFRBQmluZDZWSnlkM2tETVNDbU8zSlVBM09nMWZ0alpJUFdXQzdz?=
 =?utf-8?B?d0U2b3d5N2VuVlZodjhRMm5TZ1hQVVppY0FhZTM1b2FZQnYvRVhuTldkM0VW?=
 =?utf-8?B?UmdLdXVqeHpkQmRkbUJ0M3lFajNrU01zcmNNQ1Z2YS9HYkZXVzBPdTVSVkY2?=
 =?utf-8?B?ZjR0TFVRVnZndEVsL1JKVWtSbjVHWFllZ3hBRlpqMGtiTElua3lZbmZrcG5z?=
 =?utf-8?B?bmFWeFZXU0cva3Uyc0RjcUsva0FHWnEwOHFFTHlvZG83ckFwOWp0TDNuYk1y?=
 =?utf-8?B?SDRJNlpWeFIxdGtpOVZseW5aSEQ1MWJqbGsvSjNEY0NHVGxOWEkrVm9lOTJB?=
 =?utf-8?B?UjdlSlJvSDhQVTlkUzZQdzJlNWE4N0NCZVBLMkpwWnJ0OTlnWnlNYVoyUCs5?=
 =?utf-8?B?VGc2WjVpMW5rcHZnaUprL1VtWmpRZTJmU3l2amI2TUQ5SndST0M1UW1NSkdW?=
 =?utf-8?B?bnFRYXdVZFJZT2hZWDBqbWcxY2NNSlJuamEwVE1jaXJ2Mmp6TFgvZzZLL2Ux?=
 =?utf-8?Q?NnD21ea3a0Iwt120qjeUP3/jMQSgyYg5dHJB/fS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnJEL1NIdUdQN0VneXNxWnZyb3dKVURJKzRrN2dPUksyZzlOZUFpOFZ3RGFW?=
 =?utf-8?B?TW9wUU5Mb0ZjYlZucTdpNk45ZE9NK2daVnNUdy9SNWgzRnNVMzgzdzRIZFB2?=
 =?utf-8?B?anVLN0pWMGMxNHRSOS9xSmhBeEwxZzFLdUVjRVJaM0VrMEZpWU9EZUhQVVlR?=
 =?utf-8?B?eGRTZEx2VWE5Qnc0UUVzMkIvTktUNkR1NVA2Rm43V1FHWGl1QWxNRTBlOUdj?=
 =?utf-8?B?N3JtN25LQk9pTXY3WWZpK2dnamhGTWVyZkxVVTRTNVM5TnZnUDBxWVo0NGNn?=
 =?utf-8?B?UzJBbVQ5VUttcmkrSlk0T0p2Y09MRG84anFnREtMNUJyYnVPWm5pZ0o1Sjk2?=
 =?utf-8?B?aGhUN0l1dUxwWEJxQUF5OHNPMGVVQStySkJlQ01mUWNaeGZJdjkrQUVqbUZO?=
 =?utf-8?B?QTFOUVZLMGp1cUVwYUZlcDNMb3kyT0V2UkZIeG9CS0d5VWxjUlFmaEd1VWNF?=
 =?utf-8?B?aW5NZHk2aVZDVmFydDFJRTVoSHZKRVZERkMzTnJyN2NPYk1sVCtDTWJqRDg4?=
 =?utf-8?B?aGgwT2xHNml6cGFGMHdtaC8vdk1PeUIxYVZyTXlwOWw1L3dHUmM2YTRGeTNI?=
 =?utf-8?B?cVIrS0o3dUdtbStKdzlOalZUd2diVVI2SnVKa05XWm1nMXJhbnBSYTFxZUI3?=
 =?utf-8?B?ZFppNmxpOGVpVTIvTnVGcmU5UWJiQU1LL3F4cHUwbGdVQ2R3MHMwSTN2T0N4?=
 =?utf-8?B?K1pTMFRzL2x0NDlyZkdtVzFTWWpQeUcvZUVCNlZnMXRDTDh5V1VLcGhFbGlU?=
 =?utf-8?B?a3d4RHd4OGk0Zkw0Q0RwemQybit0a2d6Wjd4Q09QTXl4SXFJd09hTmdVbHBT?=
 =?utf-8?B?MEpJdFJKd0J6Q2R0K1pTeTBOOEVtV21wMGloZ1Nna2lqYjBEa0NTY0NiRFNF?=
 =?utf-8?B?Mk1sNHF5TmZxdEhIWE41UG9hTjc2Q3p6UXlWWDlYWFRIV2FCK1NxQW5jZEo2?=
 =?utf-8?B?dEFpTzBXcUlBOE41Smd6TllIVEYwbmtZbGltT0xZdlQyM0d0ZUM1blFCL1Iz?=
 =?utf-8?B?V0VpeXQ2TVVYSjVuQU5FWGpxSzd3NXRpblVYWXlISUQ1WEZjWUxxRzRLSHhN?=
 =?utf-8?B?V3VjeHl2VUxVa3pwaW00cmxkUW0zU2I4UzRVVUZtV1RpSG00SFd1VEx6WEpL?=
 =?utf-8?B?VG9lK1dxMC9ObWtqVVZxUkl4TkFnNXlwYlp4bWlpREpRZDc5NEl0VkFHc2I2?=
 =?utf-8?B?dzViaFd3bFc3ejR3Vk5ycWJ5NDBWSnFBMzQxN1dxeDEzVW5rUjAvcE9GeGtM?=
 =?utf-8?B?bjdlZmR0VE0wT0d2V1hxZHhPbUhHNFhvY3h2VHpldk1VdGo1d2NNQUlPeDVM?=
 =?utf-8?B?QW54K2hQWEdtV2gyUG91cnEwMlRIYWl0Snd0MXAyWUFXSWVvNWVrMjRxb1Iv?=
 =?utf-8?B?NzBzSVJQRm8yUFI4NlQvZW1NeHcvYzlFeEZ2eU4rbGRrU280d1M1RlZ3Nmhu?=
 =?utf-8?B?a1NHaG5pQUVNK0FxeWZPUVVISVNTUUNZMER0eWZXMlFLMDRtYllUYlVGYzc2?=
 =?utf-8?B?bDNyb09DZWloYUdZaEZDdVEreU1sQ2ZWT3ZOOUZIajh3dEZiMjN1RlFRSVQ0?=
 =?utf-8?B?UkJPeDllOUF0RC9CTmUxS0ZuOXg5SVNFTDJyYlg5ODlSUjBrMXcwNHlpektE?=
 =?utf-8?B?MVVMZ1RpeU5lOUZjUTFMS0ZWMGxOcldPa0x3K0dHYWF5d2pxQmNNU2lnQmt3?=
 =?utf-8?B?S2hxSTI4S3VrQ2ZScVJrV2VNdWZXUm4zTXo0clM5WnhWUGEzMG1idGVNRzZ0?=
 =?utf-8?B?dWZ5dWE0aUlUVENYa251ZnIyc2tGL0VTbDArUWV0S3pzVmd5Tm5tNEtzc2hB?=
 =?utf-8?B?dUxrUDVDZmNVaC95WDZ1ZHVNQmh2cVluaHlkYzRPNk5MbXRrSHhhZ3hMRGN5?=
 =?utf-8?B?SUwreVExUmUwNE1zK3VXZmdsWmQ3TzkzUHNtMVNnWnVPRnZheFgyZG1HdTdw?=
 =?utf-8?B?cmxPcVNFM1pWMUJBU1hReC8ra2hYQVZLOUhOVmE4ckExUDJpS09vc3Z6Ry8z?=
 =?utf-8?B?a3E4S0NLOFF5Y3lNbTVpRzlwTmhwa2tRcUVoVEJXUjlHYkN3WDVqSE9qTjlZ?=
 =?utf-8?B?b1RucmQwZEl0K0o1SklUVit2TG5uZlROL29TcjRFVHUyQXQ4bFlva1dRckdX?=
 =?utf-8?B?THZCL2R2T2w1UGMwSmJETEFIY1UvK0U5QkMyVytrVGczR1ZONlByeXp4UUFW?=
 =?utf-8?B?SGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8kn55kCOpLqIIwPlwuyUkaD3vetvMzjRgpEmmSC6+1DDXb+5fU9BaNuw0lluy5yewHviskDfCbCQeW/ug1NtUg+driRlh4yC/K5fbaJB+z4HZqbfEwjElOhWSTjFE4JfADnDt+W9in4ZoiVRAIzGbi1f6paCxKR/u8CF5fBK+nY5r+34vD0AHRdDKBsesQouoIVOqPckqrrswF2Z2g0foc2s1W2lF2+wffMnANuy7LZy4ohryxGBeQyKf0mKzWWwpwG+/nsXwhZOtLsRBFyB9PsoFz11PC3gobrvnoqs1K3A5hlLTKYNg3pP/FZtXdwbZxdIZzHdWQyMZDYbIIm4TU3k/iKbntd5vk0nj++E8msZHyo9Mrccb0sAy1DPuXMpwWzY8FbOW50jhAfax2T4g2zOFy4ck0B7RDWYxRYemydwSb+2JdIwolHTiJPeF6F1++w8PkgxRW22xX8u2leksXmnEnGA9URAY/JMqsPITkKusFfF1266dpOIc4tJagCZriCNl0rC/t2nNj0DWyjA7Lenvv1HLUu0V+kFOTZ7FBqs/ROQ/zz3a5UqTD1Mh+Av9AAIy5TPT17uXDnIY8q86OB9Ds5KemZH26Mx5y/pudo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615aef46-3426-4919-deb2-08dd044281ea
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 00:23:05.2132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OAE1p0qTSeRVFnSRxediC4ErHxPhF0jtIOMgQa2lNBkAqRe10/QXHcrWbGHyGgOkNk+FZHi3YNE0NSQqjLEBAx2Af/yyHGDw+ahQnp5zPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7530
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_16,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411140000
X-Proofpoint-ORIG-GUID: kSE_nZXqCO5miBAMXlmjNbXQ6OUD4oUc
X-Proofpoint-GUID: kSE_nZXqCO5miBAMXlmjNbXQ6OUD4oUc


Frederic Weisbecker <frederic@kernel.org> writes:

> Le Wed, Nov 06, 2024 at 12:17:55PM -0800, Ankur Arora a =C3=A9crit :
>> PREEMPT_LAZY can be enabled stand-alone or alongside PREEMPT_DYNAMIC
>> which allows for dynamic switching of preemption models.
>>
>> The choice of PREEMPT_RCU or not, however, is fixed at compile time.
>>
>> Given that PREEMPT_RCU makes some trade-offs to optimize for latency
>> as opposed to throughput, configurations with limited preemption
>> might prefer the stronger forward-progress guarantees of PREEMPT_RCU=3Dn=
.
>>
>> Accordingly, explicitly limit PREEMPT_RCU=3Dy to the latency oriented
>> preemption models: PREEMPT, PREEMPT_RT, and the runtime configurable
>> model PREEMPT_DYNAMIC.
>>
>> This means the throughput oriented models, PREEMPT_NONE,
>> PREEMPT_VOLUNTARY and PREEMPT_LAZY will run with PREEMPT_RCU=3Dn.
>>
>> Cc: Paul E. McKenney <paulmck@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  kernel/rcu/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
>> index 5a7ff5e1cdcb..9d52f87fac27 100644
>> --- a/kernel/rcu/Kconfig
>> +++ b/kernel/rcu/Kconfig
>> @@ -18,7 +18,7 @@ config TREE_RCU
>>
>>  config PREEMPT_RCU
>>  	bool
>> -	default y if PREEMPTION
>> +	default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
>>  	select TREE_RCU
>>  	help
>>  	  This option selects the RCU implementation that is
>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!

> But looking at !CONFIG_PREEMPT_RCU code on tree_plugin.h, I see
> some issues now that the code can be preemptible. Well I think
> it has always been preemptible but PREEMPTION && !PREEMPT_RCU
> has seldom been exerciced (or was it even possible?).
>
> For example rcu_read_unlock_strict() can be called with preemption
> enabled so we need the following otherwise the rdp is unstable, the
> norm value becomes racy

I think I see your point about rdp being racy, but given that
rcu_read_unlock_strict() would always be called with a non-zero
preemption count (with CONFIG_PREEMPTION), wouldn't the preempt_count()
check defeat any calls to rcu_read_unlock_strict()?

    void rcu_read_unlock_strict(void)
    {
            struct rcu_data *rdp;

            if (irqs_disabled() || preempt_count() || !rcu_state.gp_kthread=
)
                    return;

Or am I missing something?

Ankur

> (though automagically fixed in rcu_report_qs_rdp())
> and rcu_report_qs_rdp() might warn.
>
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 58d84c59f3dd..368f00267d4e 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -95,9 +95,9 @@ static inline void __rcu_read_lock(void)
>
>  static inline void __rcu_read_unlock(void)
>  {
> -	preempt_enable();
>  	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
>  		rcu_read_unlock_strict();
> +	preempt_enable();
>  }
>
>  static inline int rcu_preempt_depth(void)
>
>
> Let me audit further if we missed something else...
>
> Thanks.
>
>> --
>> 2.43.5
>>

