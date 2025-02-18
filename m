Return-Path: <linux-kernel+bounces-519733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24505A3A129
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF8416D070
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66C226D5A5;
	Tue, 18 Feb 2025 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="P5tYtLBj"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020118.outbound.protection.outlook.com [52.101.191.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F406A211499
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 15:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892450; cv=fail; b=QsuGzCUTUhWhl6erBrp70uNxg0dJ1L73zW0g4i0FTG68hTpFNuVY7OvGAtKAwNOJ7Krb+FVzSmCelOhK3giZ9Kam8rnZ1bkhJY/tueuE7AYE7guPs4gXN8mG8wQR1UrGJhbEZwO/6wGwVEyTRvymazxusd7NeqJ1FohcP05W4Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892450; c=relaxed/simple;
	bh=C3EUod7O9gkYgUbS1//WILKxpaiPEx+xuPHIAxmnZGY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tauFMUnqPBCq5zOk7RBOIk3uClMrnBtshwgPvgaK3h836P57DhTWZfIxMuOKHwhkXG2FKJRGmPCU9zLrO9Qaenfiv34k+o5mkaVI3yvOiqh/vasXPjJnaU+FYP3aH+L6DXl7MVogcLTgF1jHPvCRYzyVFdPMP4sZCJavNpHRSsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=P5tYtLBj; arc=fail smtp.client-ip=52.101.191.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSrb/JDwHgXJ/n3TT0nEJUD8+IN6+YR1XAqwPRf24o0zSesDYRTUPz/+x+FLV6MiBY0PYL5hxsppeaZhb07by3AGefw81ItnnOaOA51ggm23yJMVfDPIz2GjaxCFOykxJxsyPF1+k9GuTySkL1N1Fps8RCLhzUGXLJngOL45Vei1maYv4CZPZknlXzjMsDy97+pHC2q1roFaAmT5q+TB3ekuxszx8WPoS3wERNh6DIyldba6u4H0XVYJuRP+7mhucMWjTEpSAWhuanbcRGK3M2ZXJPMrrJ4Ub1oW1wrqq+d6GYlgDYeON2J0R7YhyP39FV4NJgp1j9Fx2mfuvFCm1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSvSn1hbRWpc0bsCPHPoWNBryk0vI6keQYgiqeVqWvY=;
 b=jFPCXpYyYhJObzaAE/dqdxOkwYVsPV25bPETpc6ncXkcKtoOWtz2kVikB8n9qi072PNBpTEWprbl+4HrdtyMhv30y3OrWnxyW8WdYj5qzzoi2CjLUv+FW4f5hbOD7s3bCGqieLINQE8S+WQDdruXeAnrwPkomck1t24lCZtIEVuO/mr+259Bpi2/0ozDVP8cI91yQZcQ6BZgDRiyDDb3lUwYSp0Pc1W5QKAkM6jvbgXPjf6d2s5Y4nIwhFyIu9CqyDFEyL90LTlHVP9IycNomChv3dyqfqMG/CP3nvbasR90TfU7JEajPpubNcixOBQNQS9PQTzSqJzPU5XSGaJexQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSvSn1hbRWpc0bsCPHPoWNBryk0vI6keQYgiqeVqWvY=;
 b=P5tYtLBjB02H0cSTPpV3g96j2srclbGRrpetayKvW6PB4TdpCvZRk38yh6j9MxnfDYwEgUiiWYQ6MhplpAvZ08FLxBxO9IN1hC0iZw7KzgP90uBaNXQaJYSjPv7DTdyWFtJMHUNWmGCjTEbl1h+clJAjLYGu1X9kC4yzl0xzHVWsOxXQGu/RxpB+CLpDbbeNhJXyYV3Qnj+VOFHNulgYLd7UGkINPcx7/nCp/pMIPKi3L2Mj9mORv+/uykorebGiXP2LneqLn+dfrujtxtox8haZwU6IPeDH1uare3E9WVIvbYBz31j6t+Owwtxl7UBNIFguuSpPvo4BVp5NaU4Rkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by TO1PPF7729A8A4A.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::659) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 15:27:26 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 15:27:26 +0000
Message-ID: <2bcfeb11-74a1-497b-b271-06dfb51eace3@efficios.com>
Date: Tue, 18 Feb 2025 10:27:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] rseq: Make rseq work with protection keys
To: Dmitry Vyukov <dvyukov@google.com>
Cc: peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 aruna.ramakrishna@oracle.com, elver@google.com,
 "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1739790300.git.dvyukov@google.com>
 <0d0e0a0a7136d49af9a8d6a849e1aa4bf086c472.1739790300.git.dvyukov@google.com>
 <f68741e0-0cc8-4faa-8144-e1786b9591f1@efficios.com>
 <CACT4Y+Ym7=9mLS8b=Rq6cyHMgyboMqh15nqkRfgru-qFVTx_0A@mail.gmail.com>
 <cf7af2a8-c004-481b-ad2e-6aa991aacb67@efficios.com>
 <CACT4Y+Z3PCBWDdR5PifXoMBSYJ-cdUmzLRdgbjTUG+A2S8Qq1g@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CACT4Y+Z3PCBWDdR5PifXoMBSYJ-cdUmzLRdgbjTUG+A2S8Qq1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0239.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::22) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|TO1PPF7729A8A4A:EE_
X-MS-Office365-Filtering-Correlation-Id: c5ce11a7-4cc2-4b10-ae5c-08dd5030bf92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGZPTkVxZnN3bFUxR0h4QVhJL2NneHpZMDlNY3h1a3Y1dHU3ZTlrQjJTV0w1?=
 =?utf-8?B?SnBTY0FsSGRVN2E0OHdEOVN4MjhoU1FabDIzUHUwbm02Zk5pbDAyYkw0UFd5?=
 =?utf-8?B?WjVUb253aTNnU2E1L3BGRnE4bWs1OU54cDE0ZE1SUWNyc2VYRXNVMXM5OGZ3?=
 =?utf-8?B?NFd0a0Jpd3lheS9tRmN1QUFHMFR1dVdQVmIvK3BqQmFQS05YQWNFVUZWUFBz?=
 =?utf-8?B?c0R4M0dTOEx2SnpnOHh4azNEWFhhVnljYVNjVlZqRG1JNjRnMWZmOXRUNGl5?=
 =?utf-8?B?SWV3dWF0SkM1OXpaWGt0QTZWREF0T3R3azBaMk50bC9zTDRGSzBrdlNZU1Zn?=
 =?utf-8?B?c3U5c3RaaG4vTUdFUXA3dVl0cGZyanp6Q3R6SncrMWNkZnBUczZuMlJucU9y?=
 =?utf-8?B?dlRCVHJWQy9NU2htRThEOUdLNERyeHQ0OFRURE1qK1RwR3c4MUxsSnpoblh2?=
 =?utf-8?B?cG9selBFKzZiaGRyRkhHT2tzLzN3WjlKbklqbE9CQTUySjFBaGZmYVB2dVJD?=
 =?utf-8?B?V3NDbXJRcGM1M3hHZFdzQW5PVVh3U08wOTI3UnVkanN3SHhEVHNlOTllbGNr?=
 =?utf-8?B?a09hYVRjdjVmVmhlSldQamFRLzM2cHhMcndyK3E5SWZWS3dZcUFtdnBmenlz?=
 =?utf-8?B?NlRBSjUrZXFNdHVIVHIzYldHU0tVY2h1VVZFLzNsSnBoNjNJUUYxK1hDL3Nh?=
 =?utf-8?B?NUMzdHZwdk9SVEdRY2N0U1NDV25zVWRQZnVFZmJoWmUyS3k1L3lCU1NiU1BZ?=
 =?utf-8?B?WHR6M2hlSFRldGorbXlnZklmd0NFZHdQZ3BITXEreXFIb01RamlHQ0dnTE4r?=
 =?utf-8?B?M1g1MnRMdWM2RHIrejRyU1VXT3RIancrTVlFU2R1WkppdFpSeXJnVlk1Z1dp?=
 =?utf-8?B?Z0dZTStTRit4bXRDeUJHVUFES3dCbFhTTi9WWDI1U2hnWXRXell0azdmSG53?=
 =?utf-8?B?dXlqbWJKU0dZbWJSejNrL281YWpGZ1JzVkxjVWpuVnozMjlUa3QyV1NocHMz?=
 =?utf-8?B?S1JIVkJTeERCMlh3Vk43OFBFMGZoZmFDdVhUczFxSWVrNVJyME1hQUlqZzc0?=
 =?utf-8?B?bmJUNVFqUTZMMmtSWm5yT2o2QmhmRE5qdGdXT0JIMWE0VG1wdDJZVHVSOUdB?=
 =?utf-8?B?eDJLNEYyaXJiS2Z2eU9pQVp5WjMrM2hubkhad1FieWJpcGgwK0dxdHVHVU5Y?=
 =?utf-8?B?TG9ESDgwNUNiMDhEQnU0Nk05WkdIR01rTXBoUmIxdE9qZmlsM2liRlJIQ1Rw?=
 =?utf-8?B?a29TNGVoUHY4T1J0UlRhU0VaN0ZnMFNkMU5zc1NBYjRPUmpMaHBtV0hxZ2lJ?=
 =?utf-8?B?U3cwMW11ZU1wYVhPWnc2Z0FOSFpleHZkZjV4MXpyeEFzNWlva3hEY2tNYVlP?=
 =?utf-8?B?emFWbWYvbll6V3RyLzVSSm1BcXNMK2JNZElPZ3g1c3k1WjNSM1pHVS9RcjdC?=
 =?utf-8?B?UGRlV2kxbVZvK3FpQXZiL1NHVldRT3VicHlGTmQxditqSTlPMjFoeXNmR0pv?=
 =?utf-8?B?R2hHaFpVYTcxNTlDR1RzbzU0ay9oMGZ6ZVpzcHZ3YjdXZE1hc3Q2M2lKaHE0?=
 =?utf-8?B?dnRWN0dmTFFBaWtKOFBNeG5UUHVLVis4MmZxMFRkREhDYVVVZTBrSXpaSG1P?=
 =?utf-8?B?MEMzaldleCtHWlJxa1J1V09BT0VpTzFNMjVIMzkrNGNNT0oyZERRSURHbjR4?=
 =?utf-8?B?eWtpRmFEQ0ExYmFEeVNJQ2VnWCtPSjF1eE1icWN1b1dmMnFqSkNZaThKdzQ5?=
 =?utf-8?Q?wm4DV2bTvJoY2Yznd4jMSaXrLMYc/4LflDF5qjU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjZWbVYyTjhYeCs2ZC9QNFpnRVYyY0VaMnpZM294ODZrc0RUVXFTMStUdGNO?=
 =?utf-8?B?OGE3c01sN0RSTkhodTA0aVpSYkh2bzU1UERFWlROZDZlL2xyeTJyZjZNNjVn?=
 =?utf-8?B?Q3QyRXBiRVk3N0pwWDVKRW9pd1FiUE9tb0hibktOK0t4VmdBbXA4VTk0MGpI?=
 =?utf-8?B?MkI5WTRvbG9WQ05LZ0FaRmtoTG5aQmJrMzU3TW1pNTJxdzhmN2tXcmVVNDl3?=
 =?utf-8?B?RmVjb2lvVStFMzBqbUJvN1B0eWdZeGxKcnJpSG9YQmY0YlhRaHdzM0F4MU1n?=
 =?utf-8?B?WDhjektFTFRveWczZGhaNFhEeGpzRzVFWmV1RFVwQ0tVN1R6b0RVZ25vdDIx?=
 =?utf-8?B?RjVrdFl4TTcyMlliTlFTQ1pqZ0N1V1Fwd1lBeExsY25tdk9qazVHNndiV2V4?=
 =?utf-8?B?aWNmbENZVHZYcVc0RUNWczZpNVA3VldQZlVuSEFlT3dKQVNuc1ZTUFBscFVJ?=
 =?utf-8?B?aU53YU1uTUR1YmxwbnZmYVFNcGJzUjY2dXFTSjdreFlvZ1Z0L2Uwbmh2T0VH?=
 =?utf-8?B?NEgyeVZiMzdRNks3RHpQVGVIQW1vekhpby94K0pmTi9iZTB6TjM4cjN0ckRI?=
 =?utf-8?B?WWtZc2pYZU5XZkpaR0dTanlobFFBc1A4Y1ZYeldDdk5NbFR0cnNuTWJNRHNL?=
 =?utf-8?B?SjZYanU1dm1YYjgzbUZ5dkZ3MzhIUUxlREw5b0V2dHFRYk1xZ1NQRDRKVDh1?=
 =?utf-8?B?MzdLL2VRcHhjeCtINW9DRTJKSXpSY1FPdUJWaXVxdGhWS0ZaTlpQMHpUS2Na?=
 =?utf-8?B?MlJEeGIrUXpqeGw0Q21YQW1ZVVlpeW1XWndXRmdKR0RiUTRGUGh4UU81K0hG?=
 =?utf-8?B?SEhQZmJPVnpVRTMrVExqaERsNVdhREY1S1ZsaFpQdUhhRUltQWx0b3c1TkJr?=
 =?utf-8?B?OEhPTjhycVpNcjhYbEJoc0dGWUxscHBJbnlzYzY0ZnpOV283UDYvWHlyU2Nh?=
 =?utf-8?B?OFVGVkRtdzd3WFdDRC9OY2hwWElhR29mcTEvZDZYOUJBdzRwT08rTFFYYVNh?=
 =?utf-8?B?QmFqNHVsa210Ry9PQWVZOW84OENFTHMzd3Vpbm5MTStiYUQ3d3FUcGgyM2tK?=
 =?utf-8?B?eVU3d2FDNVo0RDdITFVRcDVRUDBuUTRhUTl1ZHN4ZU9EQUI0NkxkaEMxc0Mr?=
 =?utf-8?B?d3lHU3VGYkZ1dUZnUm1UU1VNbFlLNDVlUnJGRDBOYzlFeStla3BuWThIaDR6?=
 =?utf-8?B?NWk1T2UxcmsyT0tSOVhTS29VdlFWQWREclhjWjBaVjlYQ0QyZXVkUjQ5NzQ4?=
 =?utf-8?B?ejlVRHlKNkwrMUVmY2xGWVUrcTRwVm4yQjdwU2ZhT2oxYWZzeXFQT1pzU1RH?=
 =?utf-8?B?djJlVmdhSHF1VndsVXVKYTlZclRqdHdIbGVpYk54Y2V5YjBhYUhYRC94dWsz?=
 =?utf-8?B?UGlQVWNQdHROWFJ4TksyVE9sUzFYeXJkWjFYU3gwTldzc0JPYzNGd3FnbVEv?=
 =?utf-8?B?TDNQQXZqc0JGQndjcEIya2pnMXgvN09KWlRDbFd4eHBxVVN5aHBaVFB0T3Rw?=
 =?utf-8?B?eDUvRjRkeUFyRUpETDdtWVY3dTJOQm9sWXBUY1gwRW1pajdSQ3R1aHl5U3lQ?=
 =?utf-8?B?ajNrZnVUZzk1ZkNUejBYUmgvUWZsb3JoMW5ad0U4eVNlbVQ4UnNUUHZtcmVy?=
 =?utf-8?B?a2dnRXBDN3BNOU94RDJRelNGRGNYdUNrbkI1S2ZOMTF0Z0tDOWI2MmdidlBr?=
 =?utf-8?B?RXRLa25SVm80blQ3UG9nVWlxN3dzTTFBdkcweFhUMXZSOG9McWxjTlk1K3Rz?=
 =?utf-8?B?WGw1ejZ6OXBMdEIweDZVWTZaaFJ3NDh4OCtvY3N0VDZTRjc1c1gyaGJoT2Mr?=
 =?utf-8?B?RW5OMzJTYU14U1N4N05IRFZqbEp0dUlJSHF4WU84aUIzVFBvcVZ1VXlqVjRj?=
 =?utf-8?B?VzcxNWZKM1BFdXV6eEszNjhkckFSZDFoajJHZkdPams4WWs4SjI4UEhtVGx4?=
 =?utf-8?B?c3QwQXlneEZlN0I4cCtCT1NGMHlwMlJNSnBxMjlXME1scjFGdlFGRmxYbndW?=
 =?utf-8?B?ZkpGd2ZpenEzcUdrN05jUVRvdlhzU2dWM2trSTlycWdDUTYySEp5KzBKWk94?=
 =?utf-8?B?YjFDOTJWQktsNDhDdjgwVWRvYmI5NzgzTU1UOUkrMU1na0Q2WmIrdkJLWnBS?=
 =?utf-8?B?cko4OFlxajhHK2FVL3UwOHFVcEFiekFZdVJLTFB3blhFVm83Q1RKd2FwNjNP?=
 =?utf-8?Q?RjPrW5k9B5oAvwXaKvIZ6Ho=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ce11a7-4cc2-4b10-ae5c-08dd5030bf92
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 15:27:26.0361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3F6H47ylBGLYYVj23d01NGtsGrg/2i/3s2RZsup1A6UYnucBoxYaeLbMiXiDeAch5vfFP4AiFqh4sPS6NyfjDX6WfanlrBJIo7G84GuNCE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TO1PPF7729A8A4A

On 2025-02-18 10:10, Dmitry Vyukov wrote:
> On Tue, 18 Feb 2025 at 15:57, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> On 2025-02-18 02:55, Dmitry Vyukov wrote:
>>> On Mon, 17 Feb 2025 at 21:21, Mathieu Desnoyers
>> [...]
>>>>
>>>>     we still let this function read the rseq_cs.
>>>>> +      * It's unclear what benefits the resticted code gets by doing this
>>>>
>>>> restricted
>>>>
>>>>> +      * (it probably already hijacked control flow at this point), and
>>>>> +      * presumably any sane sandbox should prohibit restricted code
>>>>> +      * from accessing struct rseq, and this is still better than
>>>>> +      * terminating the app unconditionally (it always has a choice
>>>>> +      * of not using rseq and pkeys together).
>>>>
>>>> Note that because userspace can complete an rseq critical section
>>>> without clearing the rseq_cs pointer, this could happen simply because
>>>> the kernel is preempting the task after it has:
>>>>
>>>> 1) completed an rseq critical section, without clearing rseq_cs,
>>>> 2) changed pkey.
>>>>
>>>> So allowing this is important, and I would remove the comment about
>>>> hijacked control flow and such. This can happen with normal use of the
>>>> ABI.
>>>
>>> Thanks for the review!
>>>
>>> I've addressed all comments in the series in v2.
>>>
>>> I've reworded this paragraph to simplify sentences, but I still kept
>>> the note aboud malicious rseq_cs.
>>>
>>> If we would not be circumventing normal protection, then, yes, these
>>> cases would be the same. But since we are circumventing protection
>>> that otherwise exists, I think it's important to think about
>>> potentially malicious cases. In this context inaccessible rseq_cs
>>> values that resulted from normal execution are very different from
>>> malicious onces. Normal ones will point to a fixed set of real
>>> well-formed rseq_cs objects, while malicious ones may point to
>>> god-knows-where in an attempt of an attacker to do things we can't
>>> even imagine right now (e.g. rseq_cs overlapping with protected crypto
>>> keys).
>>>
>>> It's as if a particular instance of copy_to_user would allow
>>> user-space to write arbitrary kernel memory, and memory of other
>>> processes circumventing all normal protections. In that context we
>>> would need to be very careful regarding what we actually allow.
>>
>> I'm considering that we should clear the rseq_cs pointer whenever
>> userspace issues pkey_mprotect.
>>
>> This would ensure that no legitimate scenario can trigger a load
>> from a rseq_cs area which has the wrong pkey, and therefore we
>> could accept read/write from/to a struct rseq which has the wrong
>> pkey, but kill the process if trying to read/write from a
>> struct rseq_cs with the wrong key. This would prevent userspace
>> from making the kernel read/write from/to memory with the wrong
>> pkey through a pointer it controls (rseq_cs pointer).
>>
>> Thoughts ?
> 
> I am not following.
> 
> There are pkey_mprotect calls, then independently installs on rseq_cs
> pointers that happen concurrently and after pkey_mprotect, and
> independent set of pkey_set calls that happens concurrently and after
> the previous 2.
> I don't see how doing something at the pkey_mprotect call for the
> single thread avoids any scenarios.

Hrm. Sorry, I mixed up pkey_set() vs pkey_mprotect(). What I had in mind
was actually pkey_set(). And that would need to clear rseq_cs for all
threads belonging to the process, which may not be straightforward
because those could legitimately be inside a rseq critical section.

OK, let's try another approach: rather than kill the process if
read/write of the rseq_cs area with the wrong key fails, could we simply
clear the rseq_cs pointer in that case ? Technically there would be no
legitimate use of this except for the case where it is meant to be lazily
cleared.

Thanks,

Mathieu

> Moreover, pkey 0 is preinstalled for all pages, but access to it can
> be revoked in future.


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

