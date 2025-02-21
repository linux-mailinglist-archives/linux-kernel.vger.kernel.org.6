Return-Path: <linux-kernel+bounces-526673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6579DA401DE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5614E3B45B3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FA4253F06;
	Fri, 21 Feb 2025 21:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="iBviRBCX"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022141.outbound.protection.outlook.com [40.107.193.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9F82505BD
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 21:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740172280; cv=fail; b=TR86LbGvNe2PAf4oxVeOuy3AUAWleAXY2CwmqdwX0Zqy4zVgp6ibEEmTjLV6/8PNXifE92p5AS2Cw5pbloMFqDpMC+HgYLcLikblT6UGSp2V52DriRyn6LE/ryNjDqKz51neuvfPVv1muVuj+WO/IqY/b6B5e6J60bEQjH8CrXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740172280; c=relaxed/simple;
	bh=6SiYhmkCIe6Nqd7b46KIGOjh40tYlPe9MyNiz97ltxo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BAptmk808zKIvA8xaJy+sxECaVTdpBWUaP9HrwsTRzhSENaZAAnpoPZdjn38JruD2I8F/yWjbwyOTeAmIsH++MjO5BmyYICkYkZoYRYL3FxDleAOCBCiVwaAjziX+cozx5MVWXXPjtuNbzk4/6eaDdOZB5oQPU0JgAqO+e9RQsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=iBviRBCX; arc=fail smtp.client-ip=40.107.193.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5N0B3wc2ytWozK7xutQOHru25NmG7zeFUI9vgdRnsvNZmCCuEIgHTTBZcQP4nSCCha7NEZyiXBzYIW3mOA0kSqreM2aF7WDCnrHtPFUiuKjsFeewTMCHKAo/87RdMcUvVuLQsF4bv4luxDtiz1j9DyfOObxbYiURgaViKESkteYxLIVvDA3XH9Aw9s/b1X9dAJi87neNNF35qDfQ//HtsjiztEY6cIn0Z1PCcgOcP5PCBcAy5d1kGSi34akcGTnB/nSpFuluJjPS/XNq44rjje4RiTl4gQ3ia3z48VZzEH7icbqxhQao3xqKwpyIWCjquqL6UkZDMIuHZdHXWAnmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OPLqh96y4/WHhsJdqrT53ETerxhQZqqiSUZCfDWIDM=;
 b=HRl8tGGU9redSwS7Y7j7ThCzNbE0yEqPW0WJIHEBh4rkxS2vslRV2qmKsSP898nr6TjMFIV2khf7Jw8pOaOQAEWPHjxx3RL247Pw/cqOFbClQB97SHd7plo0psr9UGo5hyz7vf4sAtTzGx8XuHQKkbSmg+dNBRxR0fcoXPgnbFB5zBlPsc8O5erdMcjFSW/alm2w41BAsM2x88ycPEGjqEQfwPxX8b8Q41e50XSTb+hOB1hkTxo2+yxUHX19S2uQQx45TpP1LEmCi03Iu6Aw95DsFk/F+ebrWjM4hPFpH8CnUv4D+CR9cuyGxHa7bVFgtF5yoJ+BnskfdTAigPZODw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OPLqh96y4/WHhsJdqrT53ETerxhQZqqiSUZCfDWIDM=;
 b=iBviRBCXzZIjlMLIrehiSh0PuIizz4lGjFCZev3Oz2PKxgBrTsdDAOZD2mNPnnylIj2Dt53nqYd269B5oTNq9tDOi8w4z4WSArrMlLnr8PN0GR5na0lTf9Vnxmyj3xr98E2tG1mXqGsaf2uKVQU6RRzG6pqXgNhXB8q7JphI2TlfNqS6xdMh7EjUePBODRv2TtPkiainnXFF7sMcsNh0JJc/aUDmDTECtjn0/HRjDnL561DM5gWTx2Md+y7XEQS0lDxSgsHVZqlcO+4J+Hmi790xER7XGXnsRYyabMs1Ad3+uylI7/smtENvmCD1Y5txKV1IAHcm9zO0ZMypbp+Wnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB8759.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 21:11:15 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 21:11:15 +0000
Message-ID: <eb087edd-4ff5-40f8-afcb-e4d94fb2a7ba@efficios.com>
Date: Fri, 21 Feb 2025 16:11:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] rseq: Make rseq work with protection keys
To: Dave Hansen <dave.hansen@intel.com>, Dmitry Vyukov <dvyukov@google.com>,
 peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 aruna.ramakrishna@oracle.com, elver@google.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1739790300.git.dvyukov@google.com>
 <0d0e0a0a7136d49af9a8d6a849e1aa4bf086c472.1739790300.git.dvyukov@google.com>
 <81d94ec3-16af-45a7-87c6-ef76570953f8@intel.com>
 <6ada635e-973d-4e32-ab47-1fda12ee7ce7@efficios.com>
 <90a36a64-8ea5-4ea1-965f-bcec604c7d5b@intel.com>
 <6ad30642-c3b5-4ab8-9ed6-1fa8c56a8995@efficios.com>
 <c793e1d0-e508-4cf5-a18b-29d30d5e401f@intel.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <c793e1d0-e508-4cf5-a18b-29d30d5e401f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::44) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: 34adb5d6-2de5-4f50-2aa3-08dd52bc4702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFliQTViM0RkU0kyUGJ1SmlnK0d2RVU3WHJEMW5GVkdjempwYjZ3TkJaaW16?=
 =?utf-8?B?UHJpRzcwMy92bVUyV1N5ZkU1MHpLMDJvT29IUjdqeG9vbDZnS2JyTysxT2Z1?=
 =?utf-8?B?T1k3UG5vVVVwaitsQWtwd2VQZzNZMnJnM3ovcGlmUDFCeGh2Y29FdFhHeG9Q?=
 =?utf-8?B?QmxXSVNDd1FPNml2clMrd1V6aGVCN3Y0bXVLSVg4MGdvUVdlZjZWdUI3SGVp?=
 =?utf-8?B?TjlzbUIxWlpEYTNHVHlabFRGVm12K3NXZTBLaW5lK1ZDZmY2QU9JRG8rQjlV?=
 =?utf-8?B?SjN2VWE4T3pHNWdUQ1BNRDc4ejkvd3l0Y1YvVjFXeWhsSEpXNExyQnd6c3VE?=
 =?utf-8?B?TG9EbmFzbmVkS3pQWXJxTXVia1pxemFyV3VWNWtVNUhPOWJtaFRnWW45TDlY?=
 =?utf-8?B?dUxUd1RRVWxvK3FMNSthQTBhc2FxZHJCaEcyZk80amdDOWNlV25KOXZQT2dZ?=
 =?utf-8?B?V2ZlVHpDc0tVdlhUY09YRlhacHhmcFNhemFYVUF2OHIwaHdSbHNlOG5PT0ow?=
 =?utf-8?B?WEdqc3VvNTdWNGcvR0FwTENXVGE4L1ZZWGZvKzEzdWxhZnhUSy84RkhSNGlo?=
 =?utf-8?B?V2dJcDZYUzc5Nm1PSlUzN3Z4S2dUYkVkenJVVTJ0eGVFdnVOeXJ6a0JpRVVq?=
 =?utf-8?B?UkR1VHlyd08vZWhFbDFmVWtEL1NNbjIxWnVPKy9pUjVKVEwxY1lYM0JoMVd1?=
 =?utf-8?B?U3BkUEJQZmhOaHlNbTh4U0VkTGFMSDlBaFN0Rlk2YjY5OUFTM1pwMUdrWE01?=
 =?utf-8?B?Nmg5NjJpcDRnamNiRGJHaTFEQkJobFN2R0hmM1JnaFF4ZmdxSEhBdmkrTUhm?=
 =?utf-8?B?VDdVVTBKdElMdUcyazNHMUhPaGs5MnZwNDUyU2xmZ2NMYkE4Zi85cVNibzJR?=
 =?utf-8?B?S1ZKWkN2ODZTV3UyWGd1ZWtrak9DVE1VdjJvSzRIblhuaW5FUU5RNXFDaDhD?=
 =?utf-8?B?ZEUzWHY1dVZEYk9DRytHallXTlF4S0p2WHNhYUhUaFl1U3Fjcmh2MGVkaDJL?=
 =?utf-8?B?V0ZuV2xpeEV4eGVvaytPMUpzYlAvM1NFY3luVzVoZWNjVmxaNGExUGdKSWFJ?=
 =?utf-8?B?aW9qUXlCMStSaEliM2ovN0NtNDkySS8rSlgzc0lFb1ZZUGwvSWQxczdQOVNU?=
 =?utf-8?B?UmV1cUVCY3FnZWtJQ3VCekx3cHhPUmpiLzIzQUprclpBTTRqRVJqYjYwbTc0?=
 =?utf-8?B?VEUzOFkzT0JicStQTTdmL3JoZW9HRWd3aXpoellHcnUxaEVodlV3d0p4VTRO?=
 =?utf-8?B?R3pXZXY4bnF1U24rcFk4OVhMR0R0RU54eS9MOVBqRUhTM3pyTHZwYWYvT2xB?=
 =?utf-8?B?K3dheFd3Z0t2aWw3dEZGYkpOL2o0MHlsSUtEZWpTMEJiSkEvNnkzY01xNHlz?=
 =?utf-8?B?d0ZiYXhZdXV4U3lFUkFFTUQ0UU1nUk1oMG1WYUtaYkVVMFlxTjI0R1FiMUdU?=
 =?utf-8?B?ZGVCaTErck9nZE5oZDh5U3lVYlZhZzl1YXpVVEhUWVpVTHRNVDlrL2FESXR2?=
 =?utf-8?B?KzZMMW51TTVuTWt3aGpWSE5OUElWMFV3aERjV3VyM2pibXJ6aERtTEt4cUFj?=
 =?utf-8?B?cThCbHRFWW5tWitWOFNzRTJYNEFYR3kwTDV1eTUvR0RVQnN1U1djRUx1eXdz?=
 =?utf-8?B?MGJFRzNkbXBFRXdJWDVwZXlQSHczT204bHFlcW1XeUpDUXFaRG5FU01tLytr?=
 =?utf-8?B?QjZjeFVHWFlraG1scm01ZkNzZFdqK0p0NGNUMlhsYUlkczdFeHhaVDc5ZkJM?=
 =?utf-8?B?VkxOMzN6cHpUTndSVnk3cGdoaFEwZ3N5U3lHZG1xWnhJenFEcUlEMy9yKy9Z?=
 =?utf-8?B?dVM2L284cXM3anQrUkQxTG0waXBTTGl0bTRtWm5remsrNnErSW1JWEFZdDNw?=
 =?utf-8?Q?B221LRwzR0uJQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1prYTAwdklsclhNTFV1MXg1OU02bDJDbWJzUGNPamcvc1ZFd1A2MHJZUXh3?=
 =?utf-8?B?SS94WEtBRENyTWFoazE2MlpaWmlYRDdGaG1IY0VSaTdzWVRrL0lxbzJuQ3RQ?=
 =?utf-8?B?ZTBQT0xYaXhHMmJ1dFF2YWJ0Qk5MZG5sVFBqcGlxV2dXc2pLa0VkU2Nhd3dY?=
 =?utf-8?B?NFNieXJUd29VZmpOQlNIbUhVNStPZ2htTjM2ZXNvaFg2Q1ZxdTBxOVBBczk2?=
 =?utf-8?B?QjJONGtIOGlsYkhndEhQcGpad3YzL0V2cVhZb1dxRVgyMytCZCsvajErZW0r?=
 =?utf-8?B?bWZQVS9YT1RQKzBFRlB3cTBJdkdTNUJwMUpSN0gzM01sZjlxSkJneGk4YXdV?=
 =?utf-8?B?eU11WDJUTWxNeFFjdmFzbXY0RHFyUFJJOExyYmNXVCtmSjRxQlVjYVU5ZElT?=
 =?utf-8?B?aEs3WlllcVNTMVJWY0JRV2R5Q2pJWGZ6TytJenRFTU0rOGxsL2dncDVQc292?=
 =?utf-8?B?YTFHUkJGOHhmMzZmQVYrZ2UzZXQyQTVtVlVseStiZVRrU2dvNDZoNFpKOEJm?=
 =?utf-8?B?ODhJQUkwWkpzQkFaOGpWUUVVYVplUHBibkJzOWExSjZpc2pYMTNMZXlVYklE?=
 =?utf-8?B?eGt1c0FDTkdEd0s0NU1OMHZqb3NBb3hBcURHVkhWa3IwSjFHRVQzbU1ON1Rw?=
 =?utf-8?B?clhlOTZPcjNrd00zMmVvSEtpUm01WENNTkVVeis0Zm1zNllRN2Z5eXRXd2Zq?=
 =?utf-8?B?S1p4Y1Z4K05ibEtjN2VCL3BoeVBNTzl0czBhSW04SXh0YnJIMjhlTUF5REx3?=
 =?utf-8?B?WDJvTi9vbmlNTGdMa2dnSmsvbzJIWjFuQUUyOU95UElXZXFXaVYzY2xERmZY?=
 =?utf-8?B?TnQxSE5TbE9Wa2VDdTVyZkduMjhIZFM0SXRUck54b1o0YlA1ZTNOYytVbHFM?=
 =?utf-8?B?dE1TSHF0cnNybXBGb2tDTWlKUmx2R2F3WXU0dlZBNkVxWjA3WWYxeHlCVlkw?=
 =?utf-8?B?Q2ptM1lPa2VYL2NVS1gxTDNuQ1hRTXgyWktwamw4OFNaaTNpWXAybDJSNlR5?=
 =?utf-8?B?M0ZUOTVRNDRWeTd3V0ZaQnB1WVljdCt0L2RnaXl6Z3V3ZzMxcDFRc0Joc2Y3?=
 =?utf-8?B?OWJkMGs4MDA4ZW1vMUlVRDNJbWVmMkRXc1dkTkFUSkRERzRHRGRlQmlWQytU?=
 =?utf-8?B?MnJiYjU2T3ZNVEE1QWVPMUpQaW9YU1JQaGlJN0lOL2Y1Zm1uUFFhZGtPWUhH?=
 =?utf-8?B?b3k0U2pZNXpQOCtqekdsOEQ3eEo3TjV1cWNKZ2wzeW9HbHcxNmFiUTliMmV2?=
 =?utf-8?B?SGpBMmdxL29SWFlpWXBmeGdCT1YzKzRWRWwvc2l5VHA0UnVyc0lSOU05WVIr?=
 =?utf-8?B?MW95WXpqTVJsRVVtQTlwNWpNd3Z5VzZiWXBkZ0xsSEc2REJZbzAwUkJpVUVk?=
 =?utf-8?B?L0tKUkVzUC9Fay81Y0ZLWDZGVTR5SzdmQTM5b283ZlpjR3FOV2ttQ3BYL0VI?=
 =?utf-8?B?di92Y08zUml0d25iNFFDaVdWZjZRV1BoMlhYQTlyNmtZL25kaTB5dzFmb3hh?=
 =?utf-8?B?UFJkdXFFeFBVZ0tGWFFMdkxwQTlzNWozcjJtb01OQ0FUNXRvN2lwVnBjdHRS?=
 =?utf-8?B?TXlremV5QW5TOUVkSXRPZTZDMk5PWUJmUGtwRU5vcWU3QVZ1TVdtdS9SSVY1?=
 =?utf-8?B?bGtGSTBjREwwNVkySE9rRzhuUjFuUGpHMk9uNUVzQmpSOVE3dWZXYkVoSUll?=
 =?utf-8?B?YlFhMzduMXNQL0RuaytuN1g0SW5HVmJNVXpzY29KTlcvK094Wjl5NGlnN0RB?=
 =?utf-8?B?THFreFpLeDIwNG44WFZVZGFMT093Smh5cHdGRlBVdUZaV1R3MVJRR3FPdUpt?=
 =?utf-8?B?Zzg2R09YT2ZobmRLYlpqOGxyTHdlRVkyaUZ5aTNOeFdwS2ZoQjVvL1BXdG4y?=
 =?utf-8?B?SzdxRHN1enMwalBUdkU4NEYvQUdwYi9Rai9CMWdNUWpKMW1rRlBBZVJTSFBp?=
 =?utf-8?B?cXB6ZXBkcUFOTHlXQS92RTBrUE9TY0tQT01mVUZiODBiMVhWZ29ZYVhPS3g1?=
 =?utf-8?B?RUZUUmRTaVdkRklUbjFnQWE4UjhaTGNQZ2lhTTRMQ1E0dUpXRE5KaXg0NnRM?=
 =?utf-8?B?cDFtL1pQKyt3TTVsWkMyWUlYTFE2SmtMcVRQRXlZK3liUGw5UmtPbEpyUmEr?=
 =?utf-8?B?TEhVQlRYQXBPSDdkVmhzWUxYdHVtaFNJcWZibGx3SU04YXdQK0pybmNjcEda?=
 =?utf-8?Q?/3VSd3Po2mrEj6a5aCjf90Q=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34adb5d6-2de5-4f50-2aa3-08dd52bc4702
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 21:11:15.6389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4dZtfV72UiHcaydDrZgJzVBFunZNutXN42oOeVWBWvKNUl42mTNkwRg79tB6jkIFfeDtN1bzMviddGy8ccrKwkpEvi0Pvadn4WZox5v8aRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8759

On 2025-02-21 15:50, Dave Hansen wrote:
> On 2/21/25 12:05, Mathieu Desnoyers wrote:
>> On 2025-02-21 14:48, Dave Hansen wrote:
>>> On 2/21/25 11:38, Mathieu Desnoyers wrote:
>>>> I agree that switching to permissive key in the fast path would be
>>>> simpler. AFAIU, the switch_to_permissive_pkey_reg() is only a pkey
>>>> read when the key is already permissive.
>>>
>>> Unfortunately, on x86, PKRU is almost never in its permissive state. We
>>> chose a policy (stored in the global init_pkru_value variable) that
>>> allows R/W access to pkey 0, but disables access to everything else.
>>> It's 0xfffffff5, IIRC.
>>>
>>> This ensures deny-by-default behavior and ensures that threads cloned
>>> off long ago don't have a dangerous PKRU value for newly-allocated and
>>> pkey-protected memory.
>>>
>>> If I had a time machine, it'd be interesting to go back and try to make
>>> PKRU's default value be all 0's and also represent the logically most
>>> restrictive value.
>>
>> Can we assume (or require) that struct rseq and struct rseq_cs reside in
>> pkey-0 memory ?
> 
> Maybe. Signal stacks are _practically_ only able to use pkey-0. You can
> technically protect them with anything you want and then WRPKRU as the
> first instruction once you hop into the signal handler (since
> instruction fetches aren't affected by x86 pkeys), but I seriously doubt
> anybody would go to the trouble.

And that would not work on arm64, AFAIU arm64 POR_EL0 also applies to
instruction fetches, which somewhat prevents what can be done for signal
handlers if the code intends to be portable.

> 
>> In that case, we could add something to the pkey API that switches to a
>> permissive state only if pkey 0 cannot be accessed.
>>
>> Therefore it would only trigger a pkey read in the common case, and
>> issue a pkey write only if pkey 0 is not accessible.
> I think that's a sane policy. An rseq access can happen at any time
> (from the app's perspective) so the access would theoretically be done
> with a random PKRU value from a random point in the thread's lifetime.
> 
> But it is a different policy that we've chosen with signals and "remote"
> accesses, which is to just ignore pkeys entirely.
> 
> I don't have a strong opinion. It's hard to balance performance and
> consistency with the other ABI here.

Because the rseq return to userspace handler is called on every return
to userspace after a task is scheduled back after preemption, I am
concerned about the overhead that would be added by a WRPKRU on the
fast-path, given that it acts as as barrier against speculation. Issuing
WRPKRU only after checking that pkey-0 is not accessible appears to be
moving the overhead to a much less common case.

And perhaps if we end up observing that for some reasons either the
sigframe and/or "remote" pkey accesses really must use pkey-0 as well
to work in real-life, then we could make them require pkey-0. That's
of course assuming it would cause no observable ABI breakage.
Once advantage here would be to speed up signal handler delivery.

I have no clue what a "remote" pkey access is. Is this the io_uring
use-case ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

