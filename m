Return-Path: <linux-kernel+bounces-370703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EF89A3107
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A31285D77
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A941D7E57;
	Thu, 17 Oct 2024 22:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VOLSO6oK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="acxZB9Yw"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FDB1D7986
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729205481; cv=fail; b=ioz3reHFGbyENx3D+cdbxRgwu7ILGOhSZ5XrMQ517Ye/osxnhn/1iEZ/aq2BXXUWQxDYyJVTcciMIIRshHCjvXcICMl9jT88WVwnLIjdy1seanhV6BsFVrw2V9pgefH21PU+GrzyaV8RJrjNBVcTvFRdevFZ/bMXKBW5s7FTzEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729205481; c=relaxed/simple;
	bh=i7des8h+YT4VgqdXgAe/dIdlOVOiIFs0Ds63D22tbGQ=;
	h=References:From:To:Cc:Subject:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=tg47LeC+PUIMdnrwQtQ7l3RATSsynCg+hXhwwGcdYT8XDmPdT7JRcGYhLMTe7VxbpsgS27DdnJ9vusgaiajZpkUixoaGNnYzUE/Y5JcWq7Fa4AT+KtV8ICwsHMxLsq0Utort44Bl41khYtqZWi8N+eeRpxMmBeNH671CphbBc+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VOLSO6oK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=acxZB9Yw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HKtkv3002305;
	Thu, 17 Oct 2024 22:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=yi5erH85auhx3fB3ovyxcX+PRIblRjKS3JdzSfMY/hA=; b=
	VOLSO6oKUFXbOdRHSyLtWVCeoNNlSyXAkbFhMCa4ZFT90gHhLHtWxY9Efp1XbApg
	gPCWwpR+grqmr7LXCFnRh2V5yZNfwg8nIeYzukOhK3eu2hJO3/b5pfzLATVt7hmA
	F98zClkPN2LxxMLWhkm/zC1Ft794xdXncnD34LV5T2VfXfSQnN8p2xeaY76Oc62c
	cKBxGviTIWJlaDkWXpkDOn3LpTRmU5yZCdIKIwh4pNal9klhnzTgU7AaSnIdHYIG
	OWHpPgRwOpqHjsBtcW8ZoX8BKNGKcMwoY4Zb8dpgrM9haTsUwKX6Ci1Yb0iOPEY7
	t70CNbJM+tQUjMCyVwa7CA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gq7qkkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 22:50:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HLRmUD036017;
	Thu, 17 Oct 2024 22:50:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjhd1cf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 22:50:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsTj+49xb1j4h+awpFwZf2hdtdTeDpPFh2bfv5MEZI1xlFV9TETxWUhR5wahyC77eEZOL/daofSQkescAnaIPFEk4PMHQl6uZVZ+MRv0/sDWkRcwCsKHmSXACHnlSAaj8XG6P6Kq8NsQG6EG9HujtJVrXwpcD1HGFmOfjGZulsc8qaqO1mMEjq85Da0FAADl2VzKS8b0mnQ/7iY7WoknXXhI68xFQCVA8EzidNYH9E2Yh1bp3VLgO9zjIY1QphQn0CfGoDXlU5KC3sfIrzz87Sx6e8Fdyl0EqlEL0rQP8ixAQaIvDFlp/Sjs/w3Kj8kyM/xnnRn7c6FR2hiW4OXoNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yi5erH85auhx3fB3ovyxcX+PRIblRjKS3JdzSfMY/hA=;
 b=OhlPfsm31FiGkaW4ue7ZhCwMinZZpgAGoueR5+gDhVQkcuaQFOZGuABt0ROLo7TtHVM0TzvTY1OmJzb/W3Vyu2dZo043Cny198ltj6Y9+Yukd9QXWkQel2ibXhlr2GGdWC5A+wRM14m61F9DH4bOMJ6+rl92EwWAqenSkp9Q4te0xIDLhcg8G/S/4zbQl9Ym2q7ZURYv2V13K/q1q3tF98r+gqlzbSyZ9PKxgBL4Rb7GAcVZXwWIxun8abq8IK0F0RoQAfDBnB2ZKFtzeez7hILS5QJW1JrszSXrs4F6MFl0zcm5JUgNOpwttRQpi7gQUV1LcufFM3i9hzny6trIUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yi5erH85auhx3fB3ovyxcX+PRIblRjKS3JdzSfMY/hA=;
 b=acxZB9Yw4mfvCI1eArcxy87eY4sQm+mOvgqNGl+N4/xznTLuu2f6Egnctf9DmhwVhSbjhogKeopV26oiTOOCp0j9o8SVYRq4iaErjViLmPhlPJQvsQ0cbIvQ3UESUVrwIScN+pnxigtW1K0NqfKUkZO0LAIU2M/gi9erOkVkr7I=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5126.namprd10.prod.outlook.com (2603:10b6:408:129::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 22:50:48 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8069.019; Thu, 17 Oct 2024
 22:50:47 +0000
References: <20241010100308.GE17263@noisy.programming.kicks-ass.net>
 <20241010102657.H7HpIbVp@linutronix.de>
 <20241010104438.GJ14587@noisy.programming.kicks-ass.net>
 <c6cbc343-01c3-4a38-8723-cc44e83dedf7@paulmck-laptop>
 <20241011081847.r2x73XIr@linutronix.de>
 <db3b0a4b-bec6-4b2b-bb22-d02179779cf9@paulmck-laptop>
 <20241011144341.mQKXkGkm@linutronix.de>
 <dcffa722-986a-437b-abb9-af9f4de852df@paulmck-laptop>
 <20241015112224.KdvzKo80@linutronix.de> <87ed4hrp45.fsf@oracle.com>
 <20241017080439.9od9eoBO@linutronix.de>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
        "Paul E. McKenney"
 <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, efault@gmx.de
Subject: Re: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
In-reply-to: <20241017080439.9od9eoBO@linutronix.de>
Message-ID: <871q0emji1.fsf@oracle.com>
Date: Thu, 17 Oct 2024 15:50:46 -0700
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW4PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:303:8e::26) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5126:EE_
X-MS-Office365-Filtering-Correlation-Id: d3edc9ec-3415-441e-3bba-08dceefe2441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VklvLzR4NUg0V1JkblFqZ0RBWUlYVW4zWXdtUGhVcDRxTGFIM2NhSTd6Mkth?=
 =?utf-8?B?VkRmTHZmcjlsYXRKd2RvanlyalVRNm96QncxUnFvYjZSSnhyVGpidy83NGhU?=
 =?utf-8?B?QnRGNDFUVlJ4VVJPb1ptSWR3RFo2RytIS1hNNWJ3Q2JjM0VtbHJJTzUxS01D?=
 =?utf-8?B?VW1PM1EvU0ZHeVk4bzdRSEFQUHBGeEpkS2xwWlMxMEhSRnRRaS91a1FOUWsw?=
 =?utf-8?B?bnNUUm5ienYzTEJXWWxPYkJrUWZ6eGc0ZjBFVmdBTlQ2LzNxZnk2M3N5VGo5?=
 =?utf-8?B?TVV5VU9TNWJyN0srK283d0hqU3FUckNWTGZCY21ZRGhSR2dMaitMcnNnU3lw?=
 =?utf-8?B?WkZBRUZtd0FHU2tUdXVHRFlQejFvR1k3Vm9mRTU3NCtFMmpMTlZYOWxaSTBR?=
 =?utf-8?B?R2NpYUljQ0xQTisybUNXMml1M2xkMDRGbmNIVXU1ZENKQmZLMGw0UGVDREJt?=
 =?utf-8?B?b2dDODJNVnQzaEFhZ2ovelVqcTBaa3NBdWR2WXFEQkNyMnZYclhjZHhybHBL?=
 =?utf-8?B?REdrQkp3a2RISm13NjFwbkJaUkQ4SmpqYm5GSzFxbVlaRTczRVF0YVdUKzVJ?=
 =?utf-8?B?ZGZEMjJkR0NwS0kxWWdOZVJKcU5JeXhQSC9DNjd1NzJ5Z0VZenA5VklxVTN4?=
 =?utf-8?B?czJjMDhWRzNrQWErYlJpV3JjeFE5NC9MZnU4NTF2NkhtQm9TaVpHSXJRRXJW?=
 =?utf-8?B?Z1VLT2VrOE94OVh6cTBLM3RZKzY5V3BiSkFZYmc0bzZ4aTV1ME9NdU16c2lI?=
 =?utf-8?B?YXJ3dUt6Qk14Z0M2UVJjVVpSMmRoVDY1Yk0rY0pEVDJKa1VzWUU4OXA3WXlR?=
 =?utf-8?B?eWlkL1hTQTkwT2hYaGRPaHNhaitpVXRwd2g2N1Mvc0pVN09pSDZNMXJyemtp?=
 =?utf-8?B?UXhFMnVvU3ZtemhCZkNqWGNGcHA4YXJBa2lFZWRnSWIwRXl1WUxUdHNLckxj?=
 =?utf-8?B?aVdnaUtBRGp1Q0FIZ1BVTkxaSWM0RE5kWXovNm1tZFZsKzdhbG5wbWhaOWlu?=
 =?utf-8?B?NUx0MjFBTENOTUdGdlR5dzhCbGJaWFkvdUkwazQ1dGQ5NExMZEhhZFNuUU02?=
 =?utf-8?B?Q1UwTlFqYWIwMUJpUHBVUG1Vc0I4WjlpOW1xTmJpbythNnNXVlpEaEhQaUww?=
 =?utf-8?B?dlFNYVNyVWREY0pSS0I4WGRwUk1NcUNranppYW02SzY2cy9qMGhJUHNJVDZL?=
 =?utf-8?B?aVM1aHJ5TC9ZQytUSGNBZWhsaHYrNkRtUUdqSldTZDZaTVZDelQ3SVEzeFov?=
 =?utf-8?B?MVdKMmlVNnRKSVFWYk5mVkMxNWRHSHNjdlN4QTdQTHhOUWdhNWVQZ2MySmI4?=
 =?utf-8?B?N1R3YmNpYUxacXY4eElSWVVwSmRHU1BSTm9zTFRMK29QRDkxYnUwSmVTdm83?=
 =?utf-8?B?ZFZ5OExsVWNJNGM4RnRLaExmR2dlS3dFOTRYaXRkVXpaY0VTS2hpOHAxYm9N?=
 =?utf-8?B?RGovM1VKMEk0bm1MQmhtNWJlL05NT25pUVZmMzY3TVMreS84WDZmU29HK3A5?=
 =?utf-8?B?VE1ZREdqYkVnYXRYS2NUM1ZYL1Q5ODEweTh4OEVNVU5wRGtTVnBXMmJzUEp5?=
 =?utf-8?B?YVVDL3lNSGdJdHk5K213bkpFR2dHR0hZbHM3enFzUit6Ri90TC90MEhCYURr?=
 =?utf-8?B?T29TQ2lMRlY3dDhGRnBsbzZBdlhQSGUxTndhZ1pKZFMzTUd2TmtPTFRQTnhQ?=
 =?utf-8?B?UElPQXl5NlJ0blJ4eVZCVkVoVVJVZFRoaWZUT1dpM0VxaktUVmlUWDJoODQ1?=
 =?utf-8?Q?Atu3atXFPiLcfEIQL7KsC+pjZ0US19IiuOTBgZg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXlRalZ0T29WTHhoMWJOZXpJUlJWaVFrbUFTekpJbitkMjdtZDZBZFd1dGw5?=
 =?utf-8?B?ZkhTb2pid0lCNFZhVFBJSWdtaVNvdHlPNXBxZFFYVlY2bDd3dVlmR0xFK21W?=
 =?utf-8?B?UU83UTJhYWZHNHRTQ3FYQ2piMmZkbmFRMnhZKzE1WkZHamFOZUpDcUVXRmNz?=
 =?utf-8?B?eFFnWEtKQTJkV0wwWmdKcmFEdEVId3J5WUlHYWx6M2dqU29qbnk4aFFlNG9p?=
 =?utf-8?B?b0Z3dDZjZE1zMS9YeHZFQTJmL1phdEgzbnlKTElXWXdKSExrL3E0dkJ6OCtN?=
 =?utf-8?B?Nmt2eDh2SmN4K2ZzTjFzWG9UcjlkVzRzTUNLenlmYkdheEE2a2lSNDlYZ3ps?=
 =?utf-8?B?YUNQOE8rZmRNd2xnWUkvQm1ENTZyMXpmYlJJT2JzM2tYS00xWDY0NnQ0WUhU?=
 =?utf-8?B?SXJGMDBsb3ZIbS9hampicUpkMm9XQ3FobGxiVWNWbHZkVjlyZHVKUFg1d3Mv?=
 =?utf-8?B?VTR0c083aS9ZbG5ZbllTTUh4NHlTcXZ2UlhXOUVydmlqRjFxRVNkcmMzVXZJ?=
 =?utf-8?B?WkJYSCtjaG92NG81aENaZ0Q2UkF2a0F3dzJGSS80a09jMU9DSmVXYjY4aFZB?=
 =?utf-8?B?NHZuektNRmw0VDVhTndJTXAwNkZnczF1VHJmdUI3TURDL2dZTjd6a2VNbVVL?=
 =?utf-8?B?SGhTK1YrRVd6M1hIZHBtZVFLSVdXQXk5OVJEdHZ0d1hHQnlzcFEzNmpsM252?=
 =?utf-8?B?Ykk2VFJyakxVZ25nRnIzYjN2dWY4d1hFZWlHb1dsYmNudWlGNzU5VkpFTTRo?=
 =?utf-8?B?c1crM3MrQzZNNEh3dGVDUzZTTDhVNWNRNUlEb09XdENQU2xQbUJiWlZhMjgr?=
 =?utf-8?B?TVdjTG1SbmxEL05hSmIvZXBZZzFpUGZvREJMZkxTTEtYYk1QL1JnU3pxcXBM?=
 =?utf-8?B?YUhURzM0RUVUMVJWK3VzbmpGL1dmVFY2OExLcjRPRTBaeTc0ZGtyV2Z5ZlR3?=
 =?utf-8?B?TkFSM1I4QTFlTzduRmNDdGs0SVU3bm5WQUdDbHo1YktvWk55eE00bk5hVTJu?=
 =?utf-8?B?ZUpucXMxR3dWQzE5UXJlRXViOUY5L0x5Qi9vcmJuV0xpUmcyZWx3NlRGWlk2?=
 =?utf-8?B?TmFKWXZKL3lTZ1ltcUhkSVI3WTMxeWVWYjhaM0pyVlB3MGl2UnE2YWhwTVRU?=
 =?utf-8?B?ZW5uaFM4eUw3dHlCN0JNdkorNU9WYVJZVkdzU29GWTZwclphazN0NUxHTjJq?=
 =?utf-8?B?N1FYRDN0Zk9GbWd5S1RHYkpSZVBhZkJ2dTR1QTdlZTRHdWYzYWtPazVWSk8v?=
 =?utf-8?B?VWhkTG44Z1h0YmpTQm1jNGxRbDBZd2U0YVo3dlFGSFprUW1adWlFRS83WTl0?=
 =?utf-8?B?ZHNMNGVWYmNia3BwZ1J6SkViN1RhVm9FR2grSVFHUklLa0QvbWxnZzNBeHJZ?=
 =?utf-8?B?eVRNU0o4ZUJMTmE2MWhIWDlvcVVNVC9yaUxOSjZDdC9sVlpNVGhCckg3cVoz?=
 =?utf-8?B?QzVIN2FpbmNISnU3WndyOVRYQS9FSDAxN2VDK1RoUlJJY09BRFpIZ1puZVVs?=
 =?utf-8?B?UVFLTWhMUW5uYVhRSWZZbE9jNkJMeUFWQUxLazE0aU1PTVNCQWVHOWQ2TmY5?=
 =?utf-8?B?cWl4TzdFMVhlcUQ0UU92SFA5c2JraG0rYXFkVUtaN0lmZnB6MjBsWXpjc2E1?=
 =?utf-8?B?Vklqcloyei84amJGUnZVK010N1hPZWlxN0NCeXlSVjk3TVljZG9Xa0pJeC9K?=
 =?utf-8?B?UHllbzMzbDlSYUI4c1BDWEZpQXUyK1ozQVo1VmMxTUthRzFaTGdNYXFYV0ht?=
 =?utf-8?B?cFpTK1JBSU56TU1pblZ6RnZnaWxxaUtJTnR5dUxadytHR1R0ZWNHZVo2RXZ6?=
 =?utf-8?B?MjllVE1BOE4yRFlKSFBsOVVaL2ZHdGRYL3E0bU1iTFg3clljZ3JtKytic3Nu?=
 =?utf-8?B?NWlJR1ZuK2EzMlRiRUo1OFRvRlZxRXFncFNhdDBxcjl6NDlIb0NWL05kQjUr?=
 =?utf-8?B?aStucTErd0wweVVxSy9oNlc1UWpoOXNhajlrRW14YjNsNmxaeFJRN0FsWlJj?=
 =?utf-8?B?RStQWno4TzE1RGYycWEvUmlIaU9DaFJkb1BKeFJ0Y2MybGZxRWhYbW5UaG9T?=
 =?utf-8?B?emMrZk9xTjZNQlVsOHVjbFdOZnk0QU1WTHdBVHpKcDdYTVdTQlZxcVVtcTBq?=
 =?utf-8?B?SVBHUnEzdjNveU1uczhwc1ZGYlptL2ZXQjg2YkFqWVRKZGxFbnkyMUsxKzhj?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6JgoJf7xNc0gJkC71rIwQWd8x7XNA0yqPcUEWMZLsQawDHZNde9YGYBzIEF86voaZPA6OMJ00MFs0nM0YVTTdpAxFILT7vLdXzV3+IcLjzNilQ6QL++k7rAlASgkX/qc3ZW0yOL5ve4kRxEqfQTOVoRa6t3ujKApJ8rRbosptJxEo74q0aFBvZl3ikARMv2fjT89XfU5l0vR133gqKyyVhKO9VSv3Lj/uyL4rqeQYnQGLKevdN36mxCuuXkWD14GTSikFDbt4QJNUVBoueiQuRCbDatn1TfXx2BFtsz4E+jErY16pwkul/P72DgEgbCw6qG31ckJYLt+17wMHyU8yNRAsnFfwYJIFI+3H3sfUoT8iHAkN8HLywC+NVKkYB4jUNcwyKoyOTqhu2Et9WP8oLxuZ7Adts8ZOD2ZY+W6w4SWarS+M7FVJaJ3B3akcQ9ykCpzL01E78/4LPEAVmjhy1lzt3NcX4En/v2/qYwf8jRAkmCnPBZirb/rVE7iRd7ndvL0Q1p8waXqUkxBXaApYNtui1455lQuvJFX1OiOv0CvUR/tKywKL+j14EAi6WE4xHVAqT+xHTmK9BhaV1E0MWMT0ZgvtQY4uROPx8mGEVI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3edc9ec-3415-441e-3bba-08dceefe2441
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 22:50:47.9140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Zg1fUhiEZ//vEk4DAzfUypjVYn6Z2/SiXw1X1BDDjHwnU2F7ybkShdUVnErH8yYuusG/A0BRtJzBJWHzG8Bg/AttJTGAgKET1ZVNkvi/8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5126
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_25,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=988 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170154
X-Proofpoint-ORIG-GUID: ClXt-X_rnYMFhb-fFPsvmpb1LrhfHMk5
X-Proofpoint-GUID: ClXt-X_rnYMFhb-fFPsvmpb1LrhfHMk5


Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2024-10-15 15:13:46 [-0700], Ankur Arora wrote:
>> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>>
>> >>
>> >> As for PREEMPT_LAZY, you seem to be suggesting a more intrusive chang=
e
>> >> than just keeping non-preemptible RCU when the Kconfig options are
>> >> consistent with this being expected.  If this is the case, what are t=
he
>> >> benefits of this more-intrusive change?
>> >
>> > As far as I understand you are only concerned about PREEMPT_LAZY and
>> > everything else (PREEMPT_LAZY + PREEMPT_DYNAMIC or PREEMPT_DYNAMIC
>> > without PREEMPT_LAZY) is fine.
>> > In the PREEMPT_LAZY + !PREEMPT_DYNAMIC the suggested change
>> >
>> > | config PREEMPT_RCU
>> > | 	bool
>> > | 	default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
>> > | 	select TREE_RCU
>> > | 	help
>> >
>> > would disable PREEMPT_RCU while the default model is PREEMPT. You argu=
e
>>
>> With PREEMPT_LAZY=3Dy, PREEMPT_DYNAMIC=3Dn, isn't the default model
>> PREEMPT_LAZY, which has PREEMPTION=3Dy, but PREEMPT=3Dn?
>
> Correct.
>
>> > that only people on small embedded would do such a thing and they woul=
d
>> > like to safe additional memory.
>> >
>> > I don't think this is always the case because the "preemptible" users
>> > would also get this and this is an unexpected change for them.
>>
>> Can you clarify this? The intent with lazy is to be preemptible but
>> preempt less often. In that it is meant to be quite different from
>> CONFIG_PREEMPT.
>
> A wake up with PREEMPT may not always lead to a preemption but will lead
> to preemption once the time slice is up. With LAZY this changes to the
> point that a preemption point will be delayed to the sched tick. Tasks
> which are not based on the fail class (SCHED_DL, FIFO, =E2=80=A6) will re=
ceive a
> wake up right away.

>> > I don't think this is always the case because the "preemptible" users
>> > would also get this and this is an unexpected change for them.

Yes. My point was that "preemptible" is a mechanism.

The policy about how often preemption happens is determined by the
chosen model PREEMPT_NONE/PREEMPT_VOLUNTARY/PREEMPT_LAZY/PREEMPT/
PREEMPT_RT.

> If in the long term NONE and VOL goes away you could argue that everyone
> using LAZY + !DYNAMIC is one of those.

> If additionally PREEMPT goes away then you can not.

Sure. But, that's just begging the question.

We want _NONE and _VOLUNTARY to go away because keeping cond_resched()
around incurs a cost.

> Therefore I would prefer to have the RCU model to be
> selectable rather than forced. While !PREEMPT_RCU may save memory, it
> also disable preemption for the read section.

When a user chooses one of PREEMPT_NONE/_VOLUNTARY/_LAZY, the implication
is that on the throughput -- latency axis, they care about optimizing
for throughput.

PREEMPT_RCU=3Dn is clearly oriented towards that.

That said, I'm agnostic about making the RCU model selectable. Paul
is the best judge of that.

--
ankur

