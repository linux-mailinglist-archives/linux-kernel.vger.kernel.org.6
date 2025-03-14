Return-Path: <linux-kernel+bounces-560641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED570A6079F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 03:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A6FA3BCA6E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 02:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6317081A;
	Fri, 14 Mar 2025 02:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="j7LHc71v"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022091.outbound.protection.outlook.com [40.107.200.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D76617548
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741920825; cv=fail; b=HWzOHezqLCnsIBXiljtgk4hKABvHcrCzaepAntRW2npcWUHdY/CGA5v871YikLTRtJsghZrBu/7VGUWpqQ2cOQcIyiDoYEmpGmkudFfdz8cS1Rd496nsJcDezavfR4RX98am62QL97TuqdYvLjbc4uLmCR9E5PraMv4Gl1NQuWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741920825; c=relaxed/simple;
	bh=ezqBok1n1EFMzAv8l7LOKtBjP6KLmMXXknB3/qu2YM4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ob654lvQD8DDAdq+DYbBZDzH/ZjF2Ahm/+Ca2Acicji+Dlq42YE2RXD+ElHfg4CeWk+ZMEgTmqZvRfcn1ZQz5T6H8hm5WZEu/1oE8hsR9iiwYJYOyB87rRjvxB7B89B1Pro3sYO2t+oaf18lsvD9lHBGxNObw0sA21WTmIGC/Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=j7LHc71v; arc=fail smtp.client-ip=40.107.200.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gu82uYKCo+3CN48WThZL684/wzzWf36R4Oi42hKosLdrmXpAf5x5KLeValCuWsuso1dQJ/Afq9XZHTFQoOOHvKwy+pDYgRZQP2xdHIG7p4zuV8PIYTdy/k2scJxdYpPjpEPvzqzp/W35KtcDc3nMj7ksDUuaxNd6Ja3DUQ+l4/nbPqvgfubtHDJE2s9fUy5R9/stqj3oVrY925yKGOf6rtuaz3Nwb6ATC0FmH5vsmJQeQTHr2ZK0MpHyFhGvsed1C9NBsBz8piakvpkD87N3a8C6ePt9lCOxx5SveAtVqjezyJ9Zq9uhi64wWRhLjUOxmrnNetlD1cy+9oO09375QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUFOnhf9ePLlAomWtumBfYAznjjKsTe1Q5Dm0T0gUS4=;
 b=Tsz+BLCxY7B1Up7RzghufAYBwoTCgpPMymLawW3ZTHj57c9eXdkO6bA7lJrs/nuGpuQLwUY+d4Vj/hgjxzQIDbrq9fOhYusB8rOzotslx3Ru2bu7u0Njzz83GBC3h1l2j5Z2+DnDIfpOTpGlaSvn9NXrbUnmnjdKyU0AcSoSu7UDmr/alDVNVPIyZzffIcFV4gOJDHWpvxNLUOOuhKpO69X4rxgqL2giMVACQmL2WxoRV1o2TPvAQ7JOv7b05KWaHayFtGKNwh3YJXI3SL8VYSl+6LfLbaxTQ0FtorAmDV9Ykg4WqgxtgNf3KTrBZFOJqNh+2XtHajqaw4g7cCqYow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUFOnhf9ePLlAomWtumBfYAznjjKsTe1Q5Dm0T0gUS4=;
 b=j7LHc71vuwvXWN9Ey6FkeODSwn4CDxLRLd+RKxb6RfnRszphps0fp8Idq2V6/irbTO9fFNpEVJrjUCdLCEe97s1HrPsEnznmno06YPc9pdjKTsNzM4iMsKQXOYXfVR+0eqCWu8orsCmiMvv/yK6Tis2f0CcoyssDsSxJBbfjcIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8322.prod.exchangelabs.com (2603:10b6:a03:536::6) by
 IA3PR01MB8751.prod.exchangelabs.com (2603:10b6:208:534::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Fri, 14 Mar 2025 02:53:37 +0000
Received: from SJ2PR01MB8322.prod.exchangelabs.com
 ([fe80::679e:c00e:2773:f43d]) by SJ2PR01MB8322.prod.exchangelabs.com
 ([fe80::679e:c00e:2773:f43d%5]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 02:53:36 +0000
Message-ID: <3ae07476-27b5-4d59-90ff-cb0bd70a491c@os.amperecomputing.com>
Date: Fri, 14 Mar 2025 10:53:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] sched/fair: Update comments regarding last and
 skip buddy
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 linux-kernel@vger.kernel.org, patches@amperecomputing.com, cl@linux.com,
 christian.loehle@arm.com
References: <20241127055610.7076-1-adamli@os.amperecomputing.com>
 <20241127055610.7076-4-adamli@os.amperecomputing.com>
 <3e31e4b7-d4de-4e23-a208-50effb4894a5@linux.ibm.com>
Content-Language: en-US
From: Adam Li <adamli@os.amperecomputing.com>
In-Reply-To: <3e31e4b7-d4de-4e23-a208-50effb4894a5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To SJ2PR01MB8322.prod.exchangelabs.com
 (2603:10b6:a03:536::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8322:EE_|IA3PR01MB8751:EE_
X-MS-Office365-Filtering-Correlation-Id: 64a70f88-b03a-4729-d393-08dd62a36a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGdPVVI4bDc3ZkJQclBsQ1BLdlhQUHllTEtOWTZpR2xHWDFaR292Mkd2KzI1?=
 =?utf-8?B?Y25ERlB1Qm5rdHhoOUxoalVJaHoyZk1TU3FZOVRhYkFWTjFPVjd0cGp3aXZa?=
 =?utf-8?B?OXdMRkRNbSttL3VYdDJyck51Nis5S296L1A3NHJnRnEyV1NUVXE1ZkIvWVVS?=
 =?utf-8?B?N21SdWV0bmM1UTJMWFBKUExLYm1DOHJMMEY5cFRESTQ3c21hMDllN1NSTkRB?=
 =?utf-8?B?NnRhZ2NOYXVBRGs3LzE2alZWd1hUVFhJaUFseDlGODVZK2hJZkRFL09nM09W?=
 =?utf-8?B?Y1JCYXNEblowMUVDM1hXMVoxbWd4Y05ndXg2Ykc5Z0JyaWQ3MnVxQmE3S3p1?=
 =?utf-8?B?N0dMT3ZLczFqbGVyZDkvQkl3c3pnYTR3Q1dWemRHdkJsTVJWeUtseFB3MzN5?=
 =?utf-8?B?aUNlcURLVWV0aVJEditBeXdHYmdlK01ZQXZkK29MQTZnYWppWWk5a1BjcFRQ?=
 =?utf-8?B?NHhXUUJLYVVpQW1LeGNWd1BRQk5WamoxMmNoNnIrSW9SRWlhS2pOUGRFYVVS?=
 =?utf-8?B?UGJ4QmVlR2R4NW9mRG5vQ1ZFUHI2dTFPVjc2b3I3Q3BYemZEQURReXM4My9T?=
 =?utf-8?B?bm0vM3BYYWVybktBL05PczZQdUdzNkpuMjlOdGJ6ZkRLeThPcWtibWZLMDh2?=
 =?utf-8?B?V2swWW03TzlqN3M4eHBwaVNzTkRmTnVZSEhTMDBBM1BYb0JDV21IQjQxajdl?=
 =?utf-8?B?Y1B6OVNCeENuTHk3R1MwSjRwak5SMWdoWjVIZ1dMS05EaVMrYjFaSlJPSU10?=
 =?utf-8?B?U0lzU0s1bVNYZ1ZXeDFNaXhsT1N3d0w4SFl0dE1rT1MxVTZwdktzaG1oamRR?=
 =?utf-8?B?NEpYN3dHM1VNSXh2RGlWY2p2Z1NhUE5UV3RJRlBPazVrczBMNERVQUtNdEla?=
 =?utf-8?B?TUsvTGNpOGttdzVhQW15M3NGMWRBZ1FsZTc2Y0V2U25LNWlxUlkyQU5wOHI1?=
 =?utf-8?B?Vm5qbktFcXFQWUU5VWZGbEptNW5SNjNtNXo3UjR6M2pJVCt0RncwWkpZcDV4?=
 =?utf-8?B?eFdHcW8zQWh0bERXVGR5QmgyNE1xTnRxMnJSR3JrekR1b0p1T0tFLzZlK2dO?=
 =?utf-8?B?ZU1rZ1owL01NblgrRVhIc2tUaW4yMG0wZmF6ejZqNEEyYW4xN1laWVBSMzRY?=
 =?utf-8?B?bEFVYlZEY09BTzV2c3dndXh5NVVpYTZiUTNEWGl0a2JDUEdFejNVdHdwSStL?=
 =?utf-8?B?STErRW5Zd1Q5eVJubDQ1ZXRXR205MWZFNzhVM2ZrOXZSaFFxM3dvclVEMFZN?=
 =?utf-8?B?bnR3TVJzMVlzMEFlR3BnVVhvQlJ5aXhFUldSRWJBLzltOE9HL2FxZkRtR0FD?=
 =?utf-8?B?aStqb1daUEZnY0gwdy8yRWh3VlUvakE1RXpMZkJyWklCZGsxMmJGTERLMy9h?=
 =?utf-8?B?RHBnRUI5S0JtbklQZlpSb2oyYlFMc1lPYTFQc1ZSWWhyVEpHMHJpNUtrT1Rk?=
 =?utf-8?B?NW14ME1HbnZvNkhYU1NXZHZGQUN6c2ZaQWpQdlgzdnVFeWhnVUdwYWhEMkdl?=
 =?utf-8?B?TnFZNDIwMmZCcUZucXpUSUNNa09BZFZjNE5FTXN0S1IzeVg2WjhJTlVEL1BF?=
 =?utf-8?B?bFR4OW8xdkI5VzUvRC9SQUI4ajA5Y0VNWElwMVEwanppV1BHN2h5anZRK2Fu?=
 =?utf-8?B?RTRSNFEwVU1qQ1pKZVk4RUFuQ3VBWDMvZUlnZ1pFT2x3K1hNUHlIeVFMK1hj?=
 =?utf-8?B?a0lIUGdwb0orRDU4dHg4NTJRYXhNVC9LV0pGWExpM2EzLzVwNlZndFpmZTBu?=
 =?utf-8?B?cjJPdjBZQUJ1YnMyL0djUWlsdnI4cVJnYitkVTB6ejFXRGFQYWxsSzdiQjNu?=
 =?utf-8?B?UytTNzRER21SbXZiNEI3cUloZFNzTjJtWW1RbDEzQzh6TjdPVkxWaXRrUnpP?=
 =?utf-8?Q?mI130+Y+Hvptd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8322.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUc5bE1ZTXBtMjJUSmtZME5KVTNLaUxjRzloMWlNOVBVOWZpV2VSSHVYUHhU?=
 =?utf-8?B?RmtEVW5vT1ZENjhLU05nTXNuMGJsQm91MnkxUUZ3cVlyanJoU2VFL0hRR1Uv?=
 =?utf-8?B?U1VqTkRVemVIVlJJT2hDYXV5anY5RzJTOUZzMzgzakZJQ1RuREx2UWRtemVx?=
 =?utf-8?B?bTJFM2t1V1BvTWpsLzdoSWg3bU45TUNHRWV4Q3BkY2VZVVM4UnRuNGJaWk1l?=
 =?utf-8?B?NSsxSnFRN3pKS1MySjhTWEVkakdUOVBDN0kvdmk2UVVVRUU1MDdDY0ZLNytC?=
 =?utf-8?B?bGdPYzR2dTZOZmJuWWU2LzMvT21VbVJJVVE5MzJkYU9PN0w0ZHliNmRkRnht?=
 =?utf-8?B?clFoRUI3SXZ4OTlWZGVad1JtYTE3eUdpL0htY0Q3RHBRaitBdktXMWp1SlE1?=
 =?utf-8?B?VWVmUTFZOGxHdEZCNWtWNlVXTzRaUXhndU55ZEk0NitMVnFtZHJxMW1lRlRU?=
 =?utf-8?B?NWQ3c1lCaFpYZDBaTFNGVUFkckVQZHBpUmRHMEthTzBOYjlvY0NTNytXMXpY?=
 =?utf-8?B?Sy94S0FwK216QTZTWE5QQXdtNExRWWoyQnpoWmRNRzFua29EaGVWZzNFeHc0?=
 =?utf-8?B?SVk0YlpMVlAzd1dKNDRzcFFPVktLckhyalB5YmJkVXNXVDFKWTkrVXpQemUy?=
 =?utf-8?B?YzRTL0Z0WWRpeWZiNGwwdXFxTXhyNXVrS1dQOS9mVGNmMzdzbkhtMkk4ZnUv?=
 =?utf-8?B?UmxrSkh0cGFmRnQ4c1djbWt0S3dhVUlvbkQ5YTJ3RmFKSDJqZE9jVUVIdysz?=
 =?utf-8?B?NWFjcEp1TDZUNmlaVkIwdk1QLzJTQTZoSjQzYlRDQnc4bGxIVnE2NlgxK2s3?=
 =?utf-8?B?bkh4VW9oYXlrZStHZEJTckdOZitqaFZ4bG1GbWRJWXJIbnh2c2xDY1VLdlVG?=
 =?utf-8?B?bXZYQjRCWXEwYUVyVXA0WUlhNVpLUEJKOWg4QXZOS2g5bEZpUmJ4ZDZSVDRC?=
 =?utf-8?B?amo3VmovTG16NEhlWXRGL0VxNFpoR3F0dG9GckhFUFNWbnJCNHYrYkxtcU82?=
 =?utf-8?B?WjZmN0I0RjlNenBxQnpWVmNJdUc5UnRZa1huaGZhek9KdWVaZkRkV2p0eU1x?=
 =?utf-8?B?emd1d3hKbjlqck1hTnA2Q1g5R0lFdURBcXJTVlA4K3BMSkRscmxhZmZ6UmZR?=
 =?utf-8?B?NmszSGk1a0ttbnZEZDI3Z1ZxTGRSaWRjc2U5YzZkcVZ5dndqbmU5dFo5bWQ4?=
 =?utf-8?B?N1pTSmlrY21HRDdTNzZRMm52VzlMMVVEdmFXUlJQRTZkaEdsaGlmbDlwNlV3?=
 =?utf-8?B?VlEvVzZpaUNydmYranhIS0lvOXVzdlkrREhKeEpCYi9QL3B2V0p3VWVJV3gy?=
 =?utf-8?B?YWdHbFRGeFhPb2c5a2J2c1RrOFVqM21ha0tMZHZ2M2o1QXVnNmhwTm0xMWEr?=
 =?utf-8?B?dkNBcHBiNk9VcjIyRXM1bjErSTlzY0cxUkc2a2h1bjlMc2tJdnFwYUZVS0JK?=
 =?utf-8?B?Ynd0YWtDK1duenZrVW5LYmlKMFhUcG52eHBNQ2JoRldaelRrbHB6L2NET0Qx?=
 =?utf-8?B?dnVPTkI2anl4aGxqeitEbWtNaFFMRWVHMDN4anBST2IwZGhab1FvYzFaYWN5?=
 =?utf-8?B?N3BYNkFNalc5RHJndTVQdjdXUFJrZXArTUpOSVQxdTI5YTRLOENGTW44TXJo?=
 =?utf-8?B?b0tzMEVERFJwNVJ6V1JSUWRMNGdNMzVOZ0Z5VDYwVzBEZ1hQbEREQnR5elNG?=
 =?utf-8?B?Z25hNG9kdkJTRzQ3eXAwODRuQXpITUs5akt1S0pHa2VaT0Q3U2NaK1M0OHh5?=
 =?utf-8?B?NDErSTQ4RCtqaDhZckFRa3V0dG1UeHRwOUhlK3VTeWN6OUptWWVXOTJ0S3FU?=
 =?utf-8?B?Wi9XQk82dEFTb01DeFNHMXRwOUw3Q25BTW54NXUvd3JFN3hma1lxWDhMZzhw?=
 =?utf-8?B?RGdETjFHM0JCemd4Y2JrSzhraDNxVjZjaE15NGZ1blluVTI4bHIwVVZHQno5?=
 =?utf-8?B?dnNlek1wUGVJM1E0ck5UYkFnK0l3eVpqQUd0MmdJaFpNQlQvalAwVmRlSmlh?=
 =?utf-8?B?Q0o3b01Ba3pmcnptTVZ6cXM2SHlRZ284V2RsZnpQNGovRUdlNFdpekN6d2hj?=
 =?utf-8?B?dWZsZWFvOTJxcXIvYjhaeG5BMXJ1b3V4K1lwV2djeGgzaTdaM2JUMzQ5WEZW?=
 =?utf-8?B?QndqdDBBc1RPb21VZVJFU04vTVFYVWNqT1dMNkw1ODgxMXo2ZU4zUkxWWFk4?=
 =?utf-8?Q?GDppBshjn9F18DEZrheCZUk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a70f88-b03a-4729-d393-08dd62a36a9e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8322.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 02:53:36.8004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Iasm/C14dlOC+BynzeMenPkl0OJ/IGYYfKBYHeI96eMHDhThKszCUp2n5qTSujHH9pf+m1WlFswOXTWrA+/GTq5fmT/JFO7xnCcDfVUq1hwhhOmQSQipDIe590Sl6eL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR01MB8751

Reviewed-by: Adam Li <adamli@os.amperecomputing.com>

Thanks,
-adam
On 3/13/2025 4:30 PM, Madadi Vineeth Reddy wrote:
> Hi Adam,
> 
> On 27/11/24 11:26, Adam Li wrote:
>> Commit 5e963f2bd465 ("sched/fair: Commit to EEVDF") removed the "last"
>> and "skip" buddy. Update comments in pick_next_entity().
>>
>> Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
>> Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
>> ---
>>  kernel/sched/fair.c | 8 +-------
>>  1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index d5a3b5589e4e..259c56dcdff6 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5602,17 +5602,11 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>  
>>  static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags);
>>  
>> -/*
>> - * Pick the next process, keeping these things in mind, in this order:
>> - * 1) keep things fair between processes/task groups
>> - * 2) pick the "next" process, since someone really wants that to run
>> - * 3) pick the "last" process, for cache locality
>> - * 4) do not run the "skip" process, if something else is available
>> - */
>>  static struct sched_entity *
>>  pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
>>  {
>>  	/*
>> +	 * Pick the "next" buddy, since someone really wants that to run.
>>  	 * Enabling NEXT_BUDDY will affect latency but not fairness.
>>  	 */
>>  	if (sched_feat(NEXT_BUDDY) &&
> 
> There is one more reference to LAST_BUDDY in check_preempt_wakeup_fair.
> 
> Regarding pick_next_entity, the first two points are still valid, so only
> points 3 and 4 could be removed?
> 
> Something like below
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9dafb374d76d..379dbcbb24e9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5578,8 +5578,6 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags);
>   * Pick the next process, keeping these things in mind, in this order:
>   * 1) keep things fair between processes/task groups
>   * 2) pick the "next" process, since someone really wants that to run
> - * 3) pick the "last" process, for cache locality
> - * 4) do not run the "skip" process, if something else is available
>   */
>  static struct sched_entity *
>  pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
> @@ -8780,9 +8778,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>          *
>          * Note: this also catches the edge-case of curr being in a throttled
>          * group (e.g. via set_curr_task), since update_curr() (in the
> -        * enqueue of curr) will have resulted in resched being set.  This
> -        * prevents us from potentially nominating it as a false LAST_BUDDY
> -        * below.
> +        * enqueue of curr) will have resulted in resched being set.
>          */
>         if (test_tsk_need_resched(rq->curr))
>                 return;
> 
> Thanks,
> Madadi Vineeth Reddy


