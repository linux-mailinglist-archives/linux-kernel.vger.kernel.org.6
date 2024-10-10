Return-Path: <linux-kernel+bounces-359636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8D5998E66
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25881C255EB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA3E19CCF9;
	Thu, 10 Oct 2024 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZkQH5C8s";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iwq00Mh2"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8E919CC3F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 17:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728581770; cv=fail; b=Yx7/jjJq+eaNdGSq4S9oYLWJEDlxnDoNQphhndlI66x/IgWaVEx9pB0+Ejg5Qa3978n4b3byYZaXn3AOW2/FfB0dUlES7pmHm8TCJg9sO4j/CKD1XxZl50Jvovka3/+BoSBDFLQ5HzF1IrFho2efu3B6PHMbCERAznkLP48Hr/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728581770; c=relaxed/simple;
	bh=wx2ZzPMm0Cu0BkUN8N+oypwgQz0Fgh2YxFCB9ie8js8=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=aZaiqAOsW/LtsBQrut/vGoWUpIaYcmIqK+iPJqsIQhtKtZk768dk7+SrPZSJUMRrGXUgGxz/qxDsfknix5+NpBGoEohUOKOsVMoGHzxOKn8FWm+Fygk6QJgnlV/kS9Hh956f5VvRQakqgGxgbl3wX8Mf2UwND0sdO9VWuuYy5YI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZkQH5C8s; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iwq00Mh2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ABMcxT021740;
	Thu, 10 Oct 2024 17:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=j7qCt6Fz3Ilx1T9SOvcJ/BfEoxJjtu9Yt8gjX36jIV0=; b=
	ZkQH5C8sLHtQlgKi31XC4Yg+i1xlCBOVJy113ame3wCt26giw2CqvyuKb4X4HC6G
	gpcJ/lMd/NhaWJ2FYpNHRJqtr+b146FeqdGbefsgmwmWd6KU/TNvznvwfop/nsqE
	OojCSsluj9hhD1zwqi+XmUeGdeTccEZuu2XrLhl1k824XnhNee/c/OY7zpDoVJmC
	MNcz2ehBuOpzwAotp5w03jCCF931R4WQ+dRYuPuloAIoKSITHlNFtFNNnSFeF/PE
	ekdSoM4K0j7u/r/kdODyGleGHuHnn+Y/7kT3lX+7qeM6S+piOxxl+p2EkDaZyl2E
	C9MDHFXndz1MEogkwNHrhA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302pk62y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 17:35:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49AHG4xA005797;
	Thu, 10 Oct 2024 17:35:29 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwgnvrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 17:35:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4vLkHYgfrZJzhxx9fiTvbsvZDEBHJVSTSX76qENOHB70D/DklrZ8UcCH9LSZznQXSepgGIcT4JeC5gplKXkyDV/V0fKh3rb6V9cUmW5GhcYxi/ZwD+qXLtOMtqRPLcEazjcZX93mOMgbd6rRrG9EynPhv1vo3cZzFwWVaYYHcHekf1+D2b6/vCt+fuViJg6jTGct7UUr94Baz/5uXM3HzwREwjG534EmENJPnqJZIB3qq9Y9J+hA31ze572wZVx19ZBNIKNYY8subqt68FyM2a3GycK1Vb88y5iK1qHaO/GpGVaSWXkYN3QV0U3PODU7V0D9FnJ7SVeoJ2GJq8/Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7qCt6Fz3Ilx1T9SOvcJ/BfEoxJjtu9Yt8gjX36jIV0=;
 b=dXDn+lgw0cFrC93ke6Awc9pNvuw0vzkPeJqo9r7E+jkM0520CXQVDN15UwUuyS8VVRloFGZkj+hvHEQ8FVpSdehSdPQ3laMPv6Ip/72REv4yOMGfiS6H6jVK09/jHHDRDgoxu97KrO3YYtRiGNCQyCD5dS1jlx7+AZPUoQOXYE0J5XMF1aWXemtgtPF4JhSKBPOEOIws7HVahGG35oKK9Vr3S8njhvZpcqsN6HNEDmlitbroBeaJr3ixFci6qB6AlND8Saypyjy371Z7Y3Wum3NhJR04Y74iVho2RU8elwgcP5CPTWetP2HTFRjHI85YzknJ9Cu85GYarlwhLAUXXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7qCt6Fz3Ilx1T9SOvcJ/BfEoxJjtu9Yt8gjX36jIV0=;
 b=iwq00Mh2yhmSYztkAKzLdlv06ea17He9eju+lEz9YzR+YJ0LDBBJJXaHLnvfiEcmJrmqCTVna78NRrLEuB/ctCxUVSLYQ1aO+Dq33ltL7gSRsDDoS9/mun31k4hwQQcD2eHZE/kaARneqKuBZhJYT4qw1JIy9CexT+spLkpc9zA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DM3PR10MB7909.namprd10.prod.outlook.com (2603:10b6:0:45::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 17:35:27 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 17:35:26 +0000
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-3-ankur.a.arora@oracle.com>
 <20241009180117.GS17263@noisy.programming.kicks-ass.net>
 <37af80bd-a54f-4ee4-9175-6f0f27b685a0@paulmck-laptop>
 <20241010063207.xIrynIqO@linutronix.de>
 <20241010081032.GA17263@noisy.programming.kicks-ass.net>
 <20241010091326.nK71dG4b@linutronix.de>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney"
 <paulmck@kernel.org>,
        Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, efault@gmx.de
Subject: Re: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
In-reply-to: <20241010091326.nK71dG4b@linutronix.de>
Date: Thu, 10 Oct 2024 10:35:25 -0700
Message-ID: <878quvamjm.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW4PR04CA0292.namprd04.prod.outlook.com
 (2603:10b6:303:89::27) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DM3PR10MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f4e40a6-6076-4fc7-5bae-08dce951ed9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1IxcFRBazU3Z3pQRGdBOFFvQk1xcUlVdnd5ZGxGRlJjU05ZdEcrTWdEaDEr?=
 =?utf-8?B?Y1I4WUIzOGxZUFFxV0I2VjVxVUtKemJkNGk1RHNNb2d4dTE3Z3grM1E5Sld6?=
 =?utf-8?B?UjJwWnhWN0JlSkZoc0dWeFY0SGNkbVdRREhLajdDaEVXQjFIZ2dBTENZamNI?=
 =?utf-8?B?bjQyNFVqMnZZeTZZY0pON0hraWg2Q1NSakZteU5JWXZPTnVkQnJNY3FWbzIx?=
 =?utf-8?B?b0RHd3FBdEg4VFJQQUZHSm8xQWkvL1pZa01xRHZXb0FxdmRiUlZ5THg3VGdj?=
 =?utf-8?B?UDlzOTFNZytBSmlSVmM3TVFjRzNJOExrRDRQVjg3NXFJWlNHK1dvQWRwTXQ0?=
 =?utf-8?B?QUdzRmN1VXRjVlFDZlQ5aEYrMFRid1lhTWNOMjBuMU5Sb21Ka0NwcGJDWU15?=
 =?utf-8?B?cUlHM0FxZGpLVUlBZ0lTMWluOVJJYjl6Q2Vlb053Z0t6Y2NOQWdQWDByRkRR?=
 =?utf-8?B?MGFRdXJDTjNIK1hianR2T0tCVDVDVk9GMkI4Nkp6UzBRZERHbjliQzNNSkxN?=
 =?utf-8?B?T1l0RmNUeS9UREprWWNZcVRENFlFd3RsN0hOcGFMZ08zWUwrR05pRCtrczZ1?=
 =?utf-8?B?RVNhTGZuai92SjJ2YWpZeURnc0ZCbStOaGVEZzZNL25CVDc0YTVGakdyVDZH?=
 =?utf-8?B?RmRyOUxRaWZRZVVvcEtwamtSTUliYTJTSnZILzhNZDVwV2Fxak1zWDlETHQw?=
 =?utf-8?B?UzJxQXpMNHdTNnNCcHl3ZDBMNi9UNEE5VGtMbHNVa1RjOFVwbnhxL3JWUXFk?=
 =?utf-8?B?ekNuNk52ekdCRXl5WGdFdXgzQ1JHb0VWd0VqYzhpdTRlNTNoWSs3d0Z4ck82?=
 =?utf-8?B?UEYyYVpKQVpqYVpkTEF2NUw3SmJpRU1qL1dQU0dIN2pSdC9MMzdaT09EMGRJ?=
 =?utf-8?B?OGF2eGsvN3lXWDRZcTZxeklGNGxyaDZzb3plSkdOaTI0OCt4YkZBdTZTb25z?=
 =?utf-8?B?ZW9DOFVMVVRIeW10aXc0Y1dOMzB2ejB5U3dQMmNNUUFneHhyeG1TTkpqN3Vr?=
 =?utf-8?B?dTdsQVE4MStDREkxcVZMQmhXWDFvWVNiMWQ1b1dvVEZoTTBrTG0reTVvb3Bl?=
 =?utf-8?B?UEQ3TElWUlh4bGNjRjFjWC9KRVJEeVBSSmh4dGJVUEFEdkRpRDZNQWxzODVl?=
 =?utf-8?B?ZHNPcm9vSUpiZllqTE5VQ0NsRnhFQXhQNWFuZTRqaVpZR2svYzNud3NIRWJM?=
 =?utf-8?B?SEpMd25YSEQ0ZFNzc0VKS0xHVTBOeFN3L3lISFNKV2UybmtybDFTNEFUZno3?=
 =?utf-8?B?MjdhQklaeDdlZWNuaWJ0bFpvLzhwSy9UMmtWa05lMTZtaUxWcVVBakV1ajB5?=
 =?utf-8?B?end4dXJUUmFFdHRrV3pJYXozQ3lpNzdidGdqZFRhdEZFVWpjSm1Ic3pFd3JH?=
 =?utf-8?B?bXA0OWE2TTZ0bHVXVnBSTGl0MUU5R2J3eTJhN1dDK1lWS0EyNThFRFVyN0Fx?=
 =?utf-8?B?ZkR4MklqK3g3QnVzaGxFREVTWk0wTU9sMDlBQURaYUhaV3hZTHFRcW1iaFJm?=
 =?utf-8?B?NjJoMFUzcUFZMHcxMUZHTWlvdWlVQnNmSTQrcld0cFAwelJEdFZxczh0QlNX?=
 =?utf-8?B?ci9GMGRickMrdTZnYnpKV2RnSlh2cDQxckVvbjJ6ZWlRSi80KzJuejRoVHBw?=
 =?utf-8?B?YVBSREhUcis0QVNtUzlhc0xoZ1M1dndtZ1E1T1VSdW9WdWl1VENvQVhMcXdp?=
 =?utf-8?B?RWRnVGZHdk1NTVdPTTRNVlk2Rk93VFNTbmhtSTRwRXkzb01HdmlKUWF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVZMM3dEWXhrYjdrektkeGdmWHY0OHpLYXJPY1c1MVg5VlB0ZEdzRE9SQ0Rt?=
 =?utf-8?B?Wjkwd3V2bGdKblIxRStIOW9KMlV5NUwzVDdWUC9UT0dOR1lSWnpYb2tGaUdo?=
 =?utf-8?B?M3lSSnlFOVlUY3ZpQU5HR2xNckVFUVhCWFliR0FkWFNsQktsQ2k0dlVFMnY1?=
 =?utf-8?B?VkdURk1KOTlrbTJ5SUlaQjlqZ1RHaGJ1UldQa0NUbS9DbjY0dk9xaDVFOEZl?=
 =?utf-8?B?S2M3RDRlRnNPYzVXc2RMTmdvOUxhaHhpV0Y2RjFEUmNXWVJBdm9nc29wazdE?=
 =?utf-8?B?ZVF6VTlVZk9CQXk5cGdjb2NacTBiRnhVN3lxSGNOa1NETE5BWTN4Z2dGTlFp?=
 =?utf-8?B?N3pOK29QakF2QmpzN1JPR3dib1FqWU5QUkVheFBYZU1pelhrbXkwOUVqQ2FS?=
 =?utf-8?B?UlE1ZUZkT1VhOFFKTEhqSkpORnVjSFJIL0VmNkxVdWFOaFhxcFRRekprd213?=
 =?utf-8?B?eFRFb3FFWVB1aFF3SUFKckJ4Rk5pOTM1OG54dlc1eVljVVJiSzB4TExoVDdj?=
 =?utf-8?B?dTNpdlpuUWJHOUFEZlRMQ2ZSWHkrZmJNR0hRMEQrVit3K1pYQVZDOGZZZzVx?=
 =?utf-8?B?QjErVmlFeHdFSUJ1OUdBQXJvd1crNDdkV1diTDRzM09iOEhoR1lzSWFwVW81?=
 =?utf-8?B?aU9TNWYzMUR2MXBuazZrVC9tZnJ4L1NtS0I1VmhrZjN0aEdmQWpaR3l6Qkl6?=
 =?utf-8?B?dUszMlQwbHZiSXhkMDRnOFZjK0VHcUI0cmZPNzJBUVhBVUI0MmlkRHdxZGFh?=
 =?utf-8?B?UDJ5ZXBzQWtuUThpSjN3alRIK254djk4N2pVb0F5UXAvU1IwZzZpK0ladUhz?=
 =?utf-8?B?M0FZcThLM1A2WVVKb1E1SDBxOStOTEIxQ1UxdmY2aXA3OXpOU2tybVVKbCtF?=
 =?utf-8?B?R2VTMEVrVDEwMnZxdXZ2ejhBalVuMUN0bmxpNTRSd2Z5VWRDQlFBbFAwcXJL?=
 =?utf-8?B?L01WQzlrNkxtMG4ybVN5ZCt3cE9MZGhUME1MZlA2MVZyNld1Qmd3VkR2Z3Ry?=
 =?utf-8?B?Z0g0bDcvS1ZKSTFZNitYdTJLelFxbUhsdzRQRnRLT1d5UXdmQVZjVTkxaFdL?=
 =?utf-8?B?RDFBL0VQaVUvei94QUpDRUhQVEJxcTl1SWI1SzV5ajkyUjVnQ0p4Y2RTNTVx?=
 =?utf-8?B?amc1aW9XeExZc1U0OFhSNlg3dmpwYW1nTWVxSkxaeUJKN29EaVZnUGQ5Vjk4?=
 =?utf-8?B?WlQxVzQ4ME9yYXhQUHdOeXRKaW5YZ3VmZm11OFdScW5RRkJZVnhWT3lCcFRl?=
 =?utf-8?B?Szd5WStFRndKQUZOOHRpZHZta3cwWEZuRW9sZ0dhbk5mQXdLV3cremNFOEI2?=
 =?utf-8?B?YTZqTjFkUlhTdmc5amYreGlWRHFzNUVhR2k2c3JncVM1NkV6N0oyWGxXYnNH?=
 =?utf-8?B?R2ZyZ1dqQU56MnR0OXVhZk5SRUJVS0IvT1dpaE9pcVo0K2o5T0JGUFFrK0Rx?=
 =?utf-8?B?Rlp5M1cwbzM2ZGNnZHRDeVltVXZHVlZjS2Uyd3loVE01ZlEwajBqbjBLY3BO?=
 =?utf-8?B?Um0vc2MzZlVMUE1tVEtpMktHSEZmM1MxUExuakpRc0d4dTgxVTRyTlBwVlhM?=
 =?utf-8?B?V04wYlNnQlU3OUQwbk04TXhFNkgzYW9wVzZMOFBlWGJaVS8velJJNlpMN241?=
 =?utf-8?B?MFBNUkIweHJzRUZYT2ovYmJvS1k2a3pwaGtuNE5vdXJlZ0c4SWlqU1Nqa0VZ?=
 =?utf-8?B?c2VMYW5PTVVWc0h0NHdnSG92K3AraGdxalVRNTVhS3dCSi9GRm9WWGtYZ01S?=
 =?utf-8?B?NUVLcFJBbU1YbTFjMTBSOHdoRXhLSk45RmZTOC9HWldqRkJwZmN1QktqLy9J?=
 =?utf-8?B?TlJ0Zk93YTllTDRaMlNVOTRaVEFxdE40bzgybFNwZ1VoZlZrb3R0MC9adkUw?=
 =?utf-8?B?cmxBNlZLY0xTSnpTTURaNlBOZmZPQlp2TXhiREIzVVVRa2RkZmpEdUg3NXU1?=
 =?utf-8?B?a2Ura205enRxekZGSHZsVEgySmJzamdNQVF5OHh4OURwZ1F1NXVVcTd1Q2pQ?=
 =?utf-8?B?U21nVWhmY2RMVHhPODl6eGVUMmhlVGxHbG1rcVNYd1lrMGFMMEJrSmI1WHhk?=
 =?utf-8?B?dTVWQ1NyR3dMeE1YOWZ4eEhWRnd3N1RzQ0kraldVRC9MRTI1dTNKVVI4VU1U?=
 =?utf-8?Q?xmlL7wESAaEhvz2fIuvOMV/GY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7deXFo5qeuacbSJtlBspkWjbiDD+r8tHgTOmem+4VOX1v56By/iHLmkzjmQVfaEMCW1B5Lj3UcqJcqn/Y0RN0wlKwWIawxolvvvqJhokiUOHzy+JriYdAJ+fj4dRmEz+XdMshi2SqGzpDIEUF92OYqsrIhAZzovf7JIVzexVzvtEL8P3h9RPkr9PbNyVKDLQ0M/2Zq5OonJG9fe42v1QT8hcyF2ma6UirbmZKv2f2kGTzvwZB8CigoTZ8avb7Fsvc1D5hQWRWx6KgtECPNdw/uzLB+ImurXixYwi0OEzeefgruBnALv5QEsCyyBfyiNG1LmQXLBhuYSy5wsjKcGkA3HEBBX6fxF06ut8Fh6T6zn8+dcnFtykfFr1AlHzZu96N5xbTatgGOoJ504ywOLWzKm2PzXWMMMxsiR+t5UloMtb0ysDMWt5s/C5BPcI5q6FUr1mlr4eA8h8kV6I9q57A2KIY9b0YhSc7sZBjQTR3EIuy7D1DbOD8BAYNDmYsVW/n+FkYVxHlTJv0YDoUZpqsEKqS3YJ3A/jR483mAQKo0/gGNR+kBVSojDrmyk25DXFhdyM8kGRcGIA6Z+ibu/3wgKr/czYEYBs7SQZhXc93A8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4e40a6-6076-4fc7-5bae-08dce951ed9b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 17:35:26.9180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5WDticXG4bI4PEqrnuLGPj9slc0mLCv/GV6+6udXUoGcoGvIXvHA/5umvh68tm016SQqWk6zPU5fjYrGYgjuq89UTDcft2JJEKjHaruZWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_12,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410100116
X-Proofpoint-ORIG-GUID: XCZg63hEQ7osva4N_svbcDDROChWWD22
X-Proofpoint-GUID: XCZg63hEQ7osva4N_svbcDDROChWWD22


Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2024-10-10 10:10:32 [+0200], Peter Zijlstra wrote:
>> On Thu, Oct 10, 2024 at 08:32:07AM +0200, Sebastian Andrzej Siewior wrot=
e:
>> > On 2024-10-09 11:24:09 [-0700], Paul E. McKenney wrote:
>> > > In order to support systems that currently run CONFIG_PREEMPT=3Dn th=
at
>> > =E2=80=A6
>> > > Or am I once again missing your point?
>> >
>> > The change is:
>> > | config PREEMPT_RCU
>> > |        bool
>> > |-       default y if PREEMPTION
>> > |+       default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
>> >
>> > Now:
>> > - CONFIG_PREEMPT select PREEMPT_BUILD
>> > - PREEMPT_RT select CONFIG_PREEMPTION
>> > - PREEMPT_DYNAMIC selects PREEMPT_BUILD
>> >
>> > and PREEMPT_BUILD select CONFIG_PREEMPTION
>> >
>> > so in the end, this change is a nop, right?
>>
>> PREEMPT_RT selects PREEMPTION *and* has one of PREEMPT / PREEMPT_LAZY /
>> PREEMPT_DYNAMIC, all of which in turn select PREEMPT_BUILD, which
>> selects PREEMPTION.
>>
>> (arguably we can remove the select PREEMPTION from PREEMPT_RT)
>>
>> The proposed change is not a nop because the config: PREEMPT_LAZY=3Dy
>> PREEMPT_DYNAMIC=3Dn will result in false, while it will have PREEMPTION.
>
> I have a config with PREEMPT_LAZY=3Dy PREEMPT_DYNAMIC=3Dn  and
> CONFIG_PREEMPT_RCU=3Dy.
>
> I can't deselect CONFIG_PREEMPT_RCU=3Dy. This is because LAZY selects
> PREEMPT_BUILD and PREEMPT_RCU selects itself once PREEMPTION is on.

That's odd. I have that exact configuration (PREEMPT_DYANMIC=3Dn,
PREEMPT_LAZY=3Dy, PREEMPT_RCU=3Dn).

Can you share your .config?

Ankur

>> That said, I really do not agree with the change, it makes the condition
>> complicated for no reason.
>
> Sebastian


--
ankur

