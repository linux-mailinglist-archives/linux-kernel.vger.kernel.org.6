Return-Path: <linux-kernel+bounces-278247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FDD94ADE6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63DF11F21138
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE07136671;
	Wed,  7 Aug 2024 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="O8UXSK/4"
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021113.outbound.protection.outlook.com [52.101.57.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BDE132117
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047531; cv=fail; b=pE8ubmoGouESgdh/s1slKHtkQ6Au4kjtHzzVxiw8BRyPgI4U2E3t//hTO86BOkHG2ltGADkNMn345Xpk3FX87B2APTS45j63sQ2dbAE50Xv+YfCI8wBRahCPTvvp5jyQXE0o1m53a2qYczFkvjl/CG5of431H3PBS5RIQ0muME4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047531; c=relaxed/simple;
	bh=DmKGhamT10sON9Pu4MqanquAuiQ9PfDs8+3cga/UuvI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZOpidiT8Uf17zT85kEKtIa9x7sNwdExnOce3g+yeWBV1bYy3/xtQ/v5F7QSWNsvFRuOFuUfayWrtqdCvmMMRvfTrvaNcaKbG38N12cfhZDS0JMxPcHLcOpeYR4ZKYPyHnTzW/9EO+vL7wZDRk3uSr6Jsbwfm/vF4cLXLaEMd8xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=O8UXSK/4; arc=fail smtp.client-ip=52.101.57.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/G9LwUY/GYJhd2e3tZffAGIIHDUdQgy2SZr1sMdT+s/5hoP6hLkmRWyj87W937bNi8H0j7kDn3hFbqoZLujAor6KkF0/MtmnDKkFL1/6TFVBG8JYNa8+3nZaujaDKWWz748uTf6AQK8E0p/9gYKq3dFvIoUWbgWm0Nm6aPqJlOXS0/FMzs+hg2DpKW4aLozyVT68fkYg+eA2/+OmsmgBjC0AyHDxcNq9498wDOp19XvdcEU7CFvcCeCXfjrQQ8rOjQtrjV+aWhcsFJ4IMCBJaXHhKLnTqJ9T1JmOJ00iCOj8TzqKD/SpQ94aWg2uACdJ6JC/9DN5nW3sqW3xXvLHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uMB8x5E8hvXyZpl5DyTebZGpAxBEFWwvJvx6bz5ow4=;
 b=SpvXD2r8HO1Qeha06nWLr906UA92GieVePXFdk1sUuzF7XzpH1BrSHkKwdNpv6GgIS7r3Z8s3CEoSnkc2ZOfLxQ+YdVN9N3VRIXicsD7o9Ii8nfdikmZADJxe1CGUeiNFdw4qe0IBZNt0vm138R9OYaVj3jjUx5n3JkVcjDf05Cc+WDmSARqaqSIkdBC8IQyo4+3Tgn7c9VZM0b+XLvfkGDPyqdCyNuLsORXmqLRmEaHClLubcgxQWFc7RYndoQIwHVcr+nZwAi37wtb5DHO3doeRzsKAzScjSf1irCTQvAO7EvWO2JVC1kpB0eqgm8DuiIBdLGVaYXbLwHDWWVokA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uMB8x5E8hvXyZpl5DyTebZGpAxBEFWwvJvx6bz5ow4=;
 b=O8UXSK/4jo9Y60QHh69HAuPe0XrPE/t3fEyBSAzDseV9880c0iRm4z7g37iLHU0J+3+c9mTnpJUkeS0lG1HPHro5qqNtsQOGVm80SBY3GnCj2ejcQftwTnK81T2Sg6h8Vr/LOtNhLm8sm5uqBsunT2CV3+KpEAL1m+W4Hx9qzXs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 SJ0PR01MB7510.prod.exchangelabs.com (2603:10b6:a03:3dc::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.22; Wed, 7 Aug 2024 16:18:42 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%3]) with mapi id 15.20.7828.021; Wed, 7 Aug 2024
 16:18:41 +0000
Message-ID: <4ba157c2-4a56-4d77-9a15-071e46adc33b@os.amperecomputing.com>
Date: Wed, 7 Aug 2024 21:48:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf scripts python arm-cs-trace-disasm.py: Skip disasm
 if address continuity is broken
To: James Clark <james.clark@linaro.org>, scclevenger@os.amperecomputing.com
Cc: acme@redhat.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 darren@os.amperecomputing.com, james.clark@arm.com, suzuki.poulose@arm.com,
 Leo Yan <leo.yan@arm.com>, Al.Grant@arm.com,
 Mike Leach <mike.leach@linaro.org>
References: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
 <6920de94-a9c8-47f4-840f-391d1ec85c0c@os.amperecomputing.com>
 <8f6f221b-4c9a-42e1-b8ce-1f492caee184@linaro.org>
 <0a697a54-5dd8-4351-a651-991724690db2@os.amperecomputing.com>
 <ce4af204-874f-404c-a7aa-42dc6693d072@linaro.org>
 <a197123a-be59-4052-9615-cac79ffa357a@os.amperecomputing.com>
 <543813f6-cb1f-4759-b26f-75246750814d@linaro.org>
 <f72038a0-c6b5-4245-8515-3b735ca38cbb@linaro.org>
 <ae1b2d8c-588a-4f0a-b3c9-c869f8dd0f25@os.amperecomputing.com>
 <00fac24c-d664-4ebb-8c60-f4697b7f76c1@linaro.org>
 <8b53a424-19f7-4042-a2db-e1c5d051f9cc@os.amperecomputing.com>
 <6adf84fa-b755-4d7a-957a-9bf01e442238@linaro.org>
 <d71dff17-6f1e-4a67-89c6-7ecc86af0f3a@linaro.org>
 <6f535bb6-2cee-48e6-93f1-ea19887bae74@os.amperecomputing.com>
 <027c76a9-9bd4-43e9-a170-8391a0037291@linaro.org>
 <3d7a6f93-0555-48fa-99cb-bf26b53c2da5@os.amperecomputing.com>
 <d6170beb-754e-4be3-8ff7-18acddccf077@linaro.org>
Content-Language: en-US
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <d6170beb-754e-4be3-8ff7-18acddccf077@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0176.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::11) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|SJ0PR01MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: 9702b0ca-f03d-431c-84de-08dcb6fc9a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aThidlMwSVRITjYvTnZ1ZW5LbmZ2cWR2NHo3b0cwSmFES0swb3p1aHcza1pW?=
 =?utf-8?B?WVVMZzFXRGdrRzdnb2tFd2FSZ0wzQ2ZhbmhmbnQ5V3pZM3RaemxZN2h0STBQ?=
 =?utf-8?B?UGwrbnJSWHFPNHFCSmRRWTBrNXNpUG5Zd0pLVjhKRERCSkp3K2FLY0hSM291?=
 =?utf-8?B?bWZabWJ6VU5QUVVubkZYbmlZNHpBckY5dXlzNitGTUZMZllwb01BOGZveXBm?=
 =?utf-8?B?Q2ZaVWVZTFZmK285QktYUkNtcGlkL25VNFpSRnpqb3U1S0FzYkdBWE9IRVRU?=
 =?utf-8?B?UUVjZllQek01R0YwUnhIVFJ5QkVocTkzOElZcWIyV3J4MVJFdTU5aTFGNDJa?=
 =?utf-8?B?ai9hdXUyeW5YMTVuV3ppRWtMN2s1VW9nM0dUMnlycHBKMU9UMFoyQmVhYStW?=
 =?utf-8?B?VC9EcmZZK2owNnRKbVBMTUJMUCs1UHBuNitXa01vdFMxbkRRMDRIMXB6RXVu?=
 =?utf-8?B?dXpXSGtLWjQzS0tyeWhaaXlmV0NHeTFZTGpEZXRpbUpKNXFnTXZOdk5FL3pv?=
 =?utf-8?B?cGF5VForVUhRQTI4c3Y1V0ZqOW5vS3d5VkpiSDZHUTh1enV2ejdBeG91b1VP?=
 =?utf-8?B?NTNMR21zeFI5VW1TYWlLeEdQMCtVNTZ1Ui9uVHQ2NWRaa3hiMGZudUJYVVpF?=
 =?utf-8?B?VUNHMFJsRVBKYVdSYkhxNVBaWGNCZGc4aHh2c1NzYTcvMGRlLzNLTFU3NkZj?=
 =?utf-8?B?UXErZ294UTJSSTY5Z1FLdDNIQ3c3M0VYd1VndFRSbEZudTFjbVl3SjQ5MTZz?=
 =?utf-8?B?b0RSVXZNTmJjQUc4UURveVhROFozNTcvUjZrU2MvTng0cFZSTDNaSmxkL2Mv?=
 =?utf-8?B?YklxN0JtQXF2NWkyUCtzQXpLVWZQQmYrUWpwSjd0amkrMmhxeTkyWHlTVjNH?=
 =?utf-8?B?ZHNqdysrNk8rZ0wxb2p0WEwrTnowU25BejJvYk5CbHhWalJvTks3YlBjNlpW?=
 =?utf-8?B?UkJkWWwrenhYbk5xV1BaRGZTTGt5djZJY01xZW41TVR2cEhzVmduNTNWUnl4?=
 =?utf-8?B?TGc1YjlZVVkrM3h1Z09OT1ZtT3ZsczQ2eks2TzZBdzJ2UVMyRTVLeTNIZ1N0?=
 =?utf-8?B?bXEzSXBMNnowZ0NpZDhCZUdYVmdRcTk0MlRlcU1uSWhsNDFuZnljcXF3c3F2?=
 =?utf-8?B?Tm9NRDJiL0pVUVpNN2xDbjFOZVhPcHRzYm1oblZ1NHQyWk1KSzRjV3U0aGRq?=
 =?utf-8?B?TlVaT3ZTT3VDQWdqRlhralhhZEhSUUowSS9sU2JFci9qd3RVVWwvTGd5emU4?=
 =?utf-8?B?ekdlT0xsU1c2bTNEN3ZLUnZBTnhmVWVTRUdqSmRWdWJBT0dpZDgrUDNocjZ2?=
 =?utf-8?B?bjYxblBRbGFZNFJTOXJSRWxQY0dXNnUxRWt2N29tTG5HR1BLd1h1bWtsRWlN?=
 =?utf-8?B?Kys3cVlGcHBUV2EvZFRwUmtJeVU1aEhWMHF2ZTFCYzZBVy9xci9LL2txUFlv?=
 =?utf-8?B?V1Zpbmgvd3U3NmF5bXF2UVdjbVYrNFZiZGxCUisyVDFJVFZNUzdlZjcwNy9W?=
 =?utf-8?B?U3VRMzlaK2Y0eGtlaUVuV01LMHVXV0lPV0ZjL1VzU2VGc3I3bENINTZ4b0RV?=
 =?utf-8?B?N1BYMVVIajVuRHlrUVhLNkpKUFhjNzJaZ0JIdGZMM3lIblkwUGNYQk1IM2dz?=
 =?utf-8?B?R3Q2VDRMTkhtNTM4a3A5MlpZUnBqSmVscU4veCtMY1ZQdHlLeE9uVVlxbGc3?=
 =?utf-8?B?cWhrVnIyYlg0QWgxbGt4ZFdBME5jaEpJaERUN3NvQjZ6V1R2WXMvUFVRWTlJ?=
 =?utf-8?Q?YJ0puhbMZC6oAikAGg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFRsYkVkaUd0MWF2a3NyeWFkcHdBNGoyekFZdG9RSkEwMU1aWVJ0VmtGUGUx?=
 =?utf-8?B?dGhBRDByRlRnWkJYNnBPSCtDcnBmN0graEVCb1dvcWJMVEJiZ2hiYmEyeXFw?=
 =?utf-8?B?Tmlja292SnVFL1pXaHpOMzVtNDBVZmMwdUVaclp4RkdEVFlYSCtHWmlrSy9a?=
 =?utf-8?B?YTFPTjRQL2YvYWtwRXlWMEc4UGtjdFJ5QkE5STM2VUQvbmdSMnNTakZyZDlp?=
 =?utf-8?B?RE5SKzRnM0U1bDd5RlczWDBTZy91SXFSSVJvQ2pwcXpZaVZDeGhWejd4UmVr?=
 =?utf-8?B?N2poSTZhN3BPbU5tU3FQY21kbkZvL2kxU0IvYm9CUS92ai9zMkRSbDJONGxR?=
 =?utf-8?B?TVB5QlIrY0F5YlJHakwrKzZIdEcweGtISmNYcWdtNVdmcnNQTXhIMlBjenV1?=
 =?utf-8?B?UWdubGZIbGorVm5jaENiNmV2RzF2WmtJWUFuVGpDSi81Y01WUTY2a1FMcFA4?=
 =?utf-8?B?c1lqQXFjUnY2L2w2SUJSMFFMYUJBV2R2emJHVzVjdVdRaDlIQVNwYmVwRVR6?=
 =?utf-8?B?bitVM29yaUtNRXo4aFJ1dDV6UEM1V2ExOU15NEs1MkhWOGFibWRla3RWeC9G?=
 =?utf-8?B?cHJCMlFXQVlkSm5rZTYwcThJdjJNV29MV2ZEanZDcG1STmk3QzM3SnVKWnZt?=
 =?utf-8?B?a2wwTTVoWXQ1MWIyZmhKVTl6YmdrUkdmWmVJUStCOWVEb0FXamhHaVp4Qit1?=
 =?utf-8?B?NHlHeWF6djU1eWhNWCt5dFRaSS9PK1RKSDA5UFRHcStoYWJLbU94SVIwQzRr?=
 =?utf-8?B?QnFMb2Z3VzNZeWtuY09lN29odFRxTVhYTjN5YWZSM1ptZ3dhT1FQNmt4ZTd4?=
 =?utf-8?B?VVJ1RVJDdmxRcy9RT2JaMGh1KzExN0Q5L24zYlVndll1RGU3MzBCU3dJWW11?=
 =?utf-8?B?blo5U0g2bEdGVm9zUlRtcUZmdUZ3UCtmY20zU1Z2ajJrNEx3b2h2Mlo3RXly?=
 =?utf-8?B?bXRpd3NWVlFnZGJMbjd1TmdubkdJbVlkRnMxTE1NeW5PcHVWVEQ0OVdpV2xy?=
 =?utf-8?B?WDZ6NXQ4QTZZMEtMTG1DUEV6K1hJMGljZFVNb3MvVU1sV0NkREliWFp1N3RS?=
 =?utf-8?B?cnlIWmlmSGhoT1JWU1pJc3NwRUR1Z05HV2ppT2dGelhyMzVjRXNJTzlmdTZ4?=
 =?utf-8?B?UTU0cll1VmFCK1J3VTZ6YTlHY1ZvQXMxZ1FYTy85WHlKb0lMKzJtMXZmQXp6?=
 =?utf-8?B?eFRnU1R2aHI3NEd0bHpmZ2NvVndQTUFmRU5vN2R2YVBwWWp5cWhqWnpadGRj?=
 =?utf-8?B?R2RQTHVvWERTQUZxYUQ5Q0ZFNUM5S29PYy9MTzhIblNPalhmcFdpc0ZYTmZp?=
 =?utf-8?B?RUlzaCs3MHFONzZWc01hdkQ0K093TG1icllsSlBmbjl0SjgyVXNOWDBRSmZ0?=
 =?utf-8?B?SElPVWdZMWdCS0NBei9QMWJOVVNRRTdEN0hhVlZqc2x3c3M4eE9oMVIvalh1?=
 =?utf-8?B?Q2pPYkhsdXNLd1BZaVN1ZU9CUGhPdU9PK0djY0RVRlZpVWlyaVM3bVN4cUow?=
 =?utf-8?B?d1hyMUNTVGlvM1ozWjErRERrazdDOU1yRDNWaVd5dVoxSUtRdVc1UXZpbkJX?=
 =?utf-8?B?Nm1lbTlCZncxWmdBK1J5REp4eVZ6UzFNcjh1cjFHVm1rbm5OVHRveGUvZXdy?=
 =?utf-8?B?dGNQbVc2UEg2K280SGVWVllrQmVHUC9mQm9lRGpublY1VWNoL1BrQ0JkeGgv?=
 =?utf-8?B?YzVzb05qSndWSXo1N1dwNHNxMzNtTHdvQWtGUDArTy8vSGpBaTVQcFZ6Y0I1?=
 =?utf-8?B?NmFwcktES3FvaXNyZGlPbi90TG9XQWZ4YWU2SkJld0pOekJueXFiTkxCM3FS?=
 =?utf-8?B?bFg4WWNJU29TcXpZZFFVZGc5R1JwM1FCOG5CbzFGa29ocm0weE55NW1vZXVm?=
 =?utf-8?B?WVpra1VnMzhzRlNvNWZiNmZ3OGs2ZC9PNmtHR2o1Q2E3QnByS084T09LdzVS?=
 =?utf-8?B?M1lwTTRlNHA1SHhSZXYvdkI4aTdaZndEL1dQZS9qZUh6aDd3UEh3anlvTzBz?=
 =?utf-8?B?MDBWOEg3VlNLTTcza2RZQjNiL0Y3M1FaV3VRSEN6UmMzdExIYjJlQW0rT0l3?=
 =?utf-8?B?SE5NdkJ3ZzgwYVA2dVR5MDdTdFoxYXY5TEEvVDBtOFZXZzhOZ2VNeWdiMlVM?=
 =?utf-8?B?SENPN1l4MlFZT045d0hzbmh4NzRpWU9MUlVJbjNBdjlweCtTcEIvY0R5RHRq?=
 =?utf-8?Q?FlnkFRQ9hVrhxeyfWieMGhM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9702b0ca-f03d-431c-84de-08dcb6fc9a19
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 16:18:41.7390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VSUwxOiYJxjLl561wCfjzJomDE1Rqh9aX/6yHEJj7bWQJZv/gbvDz8E1bP8CzZYJxUwdALYPVNhbUQjl83C6kh/Dobc8Rk8zdT+cNAsqwATILErXAWwdgOcaQHexBQF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7510



On 07-08-2024 08:23 pm, James Clark wrote:
> 
> 
> On 07/08/2024 1:17 pm, Ganapatrao Kulkarni wrote:
>>
>>
>> On 06-08-2024 09:44 pm, James Clark wrote:
>>>
>>>
>>> On 06/08/2024 4:02 pm, Steve Clevenger wrote:
>>>>
>>>>
>>>> On 8/6/2024 2:57 AM, James Clark wrote:
>>>>>
>>>>>
>>>>> On 06/08/2024 10:47 am, James Clark wrote:
>>>>>>
>>>>>>
>>>>>> On 06/08/2024 8:02 am, Ganapatrao Kulkarni wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 05-08-2024 07:29 pm, James Clark wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 05/08/2024 1:22 pm, Ganapatrao Kulkarni wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 01-08-2024 03:30 pm, James Clark wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 24/07/2024 3:45 pm, James Clark wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On 24/07/2024 7:38 am, Ganapatrao Kulkarni wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> On 23-07-2024 09:16 pm, James Clark wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 23/07/2024 4:26 pm, Ganapatrao Kulkarni wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On 23-07-2024 06:40 pm, James Clark wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On 22/07/2024 11:02 am, Ganapatrao Kulkarni wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Hi James,
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On 19-07-2024 08:09 pm, James Clark wrote:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> On 19/07/2024 10:26 am, Ganapatrao Kulkarni wrote:
>>>>>>>>>>>>>>>>>> To generate the instruction tracing, script uses 2
>>>>>>>>>>>>>>>>>> contiguous packets
>>>>>>>>>>>>>>>>>> address range. If there a continuity brake due to
>>>>>>>>>>>>>>>>>> discontiguous branch
>>>>>>>>>>>>>>>>>> address, it is required to reset the tracing and start
>>>>>>>>>>>>>>>>>> tracing with the
>>>>>>>>>>>>>>>>>> new set of contiguous packets.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Adding change to identify the break and complete the
>>>>>>>>>>>>>>>>>> remaining tracing
>>>>>>>>>>>>>>>>>> of current packets and restart tracing from new set of
>>>>>>>>>>>>>>>>>> packets, if
>>>>>>>>>>>>>>>>>> continuity is established.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Hi Ganapatrao,
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Can you add a before and after example of what's 
>>>>>>>>>>>>>>>>> changed to
>>>>>>>>>>>>>>>>> the commit message? It wasn't immediately obvious to me if
>>>>>>>>>>>>>>>>> this is adding missing output, or it was correcting the
>>>>>>>>>>>>>>>>> tail end of the output that was previously wrong.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> It is adding tail end of the trace as well avoiding the
>>>>>>>>>>>>>>>> segfault of the perf application. With out this change the
>>>>>>>>>>>>>>>> perf segfaults with as below log
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> ./perf script
>>>>>>>>>>>>>>>> --script=python:./scripts/python/arm-cs-trace-disasm.py --
>>>>>>>>>>>>>>>> -d objdump -k ../../vmlinux -v $* > dump
>>>>>>>>>>>>>>>> objdump: error: the stop address should be after the start
>>>>>>>>>>>>>>>> address
>>>>>>>>>>>>>>>> Traceback (most recent call last):
>>>>>>>>>>>>>>>>     File "./scripts/python/arm-cs-trace-disasm.py", line 
>>>>>>>>>>>>>>>> 271,
>>>>>>>>>>>>>>>> in process_event
>>>>>>>>>>>>>>>>       print_disam(dso_fname, dso_vm_start, start_addr,
>>>>>>>>>>>>>>>> stop_addr)
>>>>>>>>>>>>>>>>     File "./scripts/python/arm-cs-trace-disasm.py", line 
>>>>>>>>>>>>>>>> 105,
>>>>>>>>>>>>>>>> in print_disam
>>>>>>>>>>>>>>>>       for line in read_disam(dso_fname, dso_start,
>>>>>>>>>>>>>>>> start_addr, stop_addr):
>>>>>>>>>>>>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>>>>>>>>     File "./scripts/python/arm-cs-trace-disasm.py", line 
>>>>>>>>>>>>>>>> 99,
>>>>>>>>>>>>>>>> in read_disam
>>>>>>>>>>>>>>>>       disasm_output =
>>>>>>>>>>>>>>>> check_output(disasm).decode('utf-8').split('\n')
>>>>>>>>>>>>>>>>                       ^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>>>>>>>>     File "/usr/lib64/python3.12/subprocess.py", line 
>>>>>>>>>>>>>>>> 466, in
>>>>>>>>>>>>>>>> check_output
>>>>>>>>>>>>>>>>       return run(*popenargs, stdout=PIPE, timeout=timeout,
>>>>>>>>>>>>>>>> check=True,
>>>>>>>>>>>>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>>>>>>>>     File "/usr/lib64/python3.12/subprocess.py", line 
>>>>>>>>>>>>>>>> 571, in run
>>>>>>>>>>>>>>>>       raise CalledProcessError(retcode, process.args,
>>>>>>>>>>>>>>>> subprocess.CalledProcessError: Command '['objdump', '-d',
>>>>>>>>>>>>>>>> '-z', '--start-address=0xffff80008125b758',
>>>>>>>>>>>>>>>> '--stop-address=0xffff80008125a934', '../../vmlinux']'
>>>>>>>>>>>>>>>> returned non-zero exit status 1.
>>>>>>>>>>>>>>>> Fatal Python error: handler_call_die: problem in Python
>>>>>>>>>>>>>>>> trace event handler
>>>>>>>>>>>>>>>> Python runtime state: initialized
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Current thread 0x0000ffffb05054e0 (most recent call first):
>>>>>>>>>>>>>>>>     <no Python frame>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Extension modules: perf_trace_context, systemd._journal,
>>>>>>>>>>>>>>>> systemd._reader, systemd.id128, report._py3report,
>>>>>>>>>>>>>>>> _dbus_bindings, problem._py3abrt (total: 7)
>>>>>>>>>>>>>>>> Aborted (core dumped)
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Signed-off-by: Ganapatrao Kulkarni
>>>>>>>>>>>>>>>>>> <gankulkarni@os.amperecomputing.com>
>>>>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>>>>    tools/perf/scripts/python/arm-cs-trace-disasm.py | 10
>>>>>>>>>>>>>>>>>> ++++++++++
>>>>>>>>>>>>>>>>>>    1 file changed, 10 insertions(+)
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> diff --git
>>>>>>>>>>>>>>>>>> a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>>>>>>>>> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>>>>>>>>> index d973c2baed1c..ad10cee2c35e 100755
>>>>>>>>>>>>>>>>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>>>>>>>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>>>>>>>>> @@ -198,6 +198,10 @@ def process_event(param_dict):
>>>>>>>>>>>>>>>>>>            cpu_data[str(cpu) + 'addr'] = addr
>>>>>>>>>>>>>>>>>>            return
>>>>>>>>>>>>>>>>>> +    if (cpu_data.get(str(cpu) + 'ip') == None):
>>>>>>>>>>>>>>>>>> +        cpu_data[str(cpu) + 'ip'] = ip
>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Do you need to write into the global cpu_data here? 
>>>>>>>>>>>>>>>>> Doesn't
>>>>>>>>>>>>>>>>> it get overwritten after you load it back into 'prev_ip'
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> No, the logic is same as holding the addr of previous 
>>>>>>>>>>>>>>>> packet.
>>>>>>>>>>>>>>>> Saving the previous packet saved ip in to prev_ip before
>>>>>>>>>>>>>>>> overwriting with the current packet.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> It's not exactly the same logic as holding the addr of the
>>>>>>>>>>>>>>> previous sample. For addr, we return on the first None, with
>>>>>>>>>>>>>>> your change we now "pretend" that the second one is also the
>>>>>>>>>>>>>>> previous one:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>     if (cpu_data.get(str(cpu) + 'addr') == None):
>>>>>>>>>>>>>>>       cpu_data[str(cpu) + 'addr'] = addr
>>>>>>>>>>>>>>>       return  <----------------------------sample 0 return
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>     if (cpu_data.get(str(cpu) + 'ip') == None):
>>>>>>>>>>>>>>>         cpu_data[str(cpu) + 'ip'] = ip <---- sample 1 
>>>>>>>>>>>>>>> save but
>>>>>>>>>>>>>>> no return
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Then for sample 1 'prev_ip' is actually now the 'current' 
>>>>>>>>>>>>>>> IP:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Yes, it is dummy for first packet. Added anticipating that we
>>>>>>>>>>>>>> wont hit the discontinuity for the first packet itself.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Can this be changed to more intuitive like below?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>>>>> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>>>>> index d973c2baed1c..d49f5090059f 100755
>>>>>>>>>>>>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>>>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>>>>>>> @@ -198,6 +198,8 @@ def process_event(param_dict):
>>>>>>>>>>>>>>                   cpu_data[str(cpu) + 'addr'] = addr
>>>>>>>>>>>>>>                   return
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> +       if (cpu_data.get(str(cpu) + 'ip') != None):
>>>>>>>>>>>>>> +               prev_ip = cpu_data[str(cpu) + 'ip']
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>           if (options.verbose == True):
>>>>>>>>>>>>>>                   print("Event type: %s" % name)
>>>>>>>>>>>>>> @@ -243,12 +245,18 @@ def process_event(param_dict):
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>           # Record for previous sample packet
>>>>>>>>>>>>>>           cpu_data[str(cpu) + 'addr'] = addr
>>>>>>>>>>>>>> +       cpu_data[str(cpu) + 'ip'] = stop_addr
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>           # Handle CS_ETM_TRACE_ON packet if start_addr=0 and
>>>>>>>>>>>>>> stop_addr=4
>>>>>>>>>>>>>>           if (start_addr == 0 and stop_addr == 4):
>>>>>>>>>>>>>>                   print("CPU%d: CS_ETM_TRACE_ON packet is
>>>>>>>>>>>>>> inserted" % cpu)
>>>>>>>>>>>>>>                   return
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> +       if (stop_addr < start_addr and prev_ip != 0):
>>>>>>>>>>>>>> +               # Continuity of the Packets broken, set
>>>>>>>>>>>>>> start_addr to previous
>>>>>>>>>>>>>> +               # packet ip to complete the remaining tracing
>>>>>>>>>>>>>> of the address range.
>>>>>>>>>>>>>> +               start_addr = prev_ip
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>           if (start_addr < int(dso_start) or start_addr >
>>>>>>>>>>>>>> int(dso_end)):
>>>>>>>>>>>>>>                   print("Start address 0x%x is out of range [
>>>>>>>>>>>>>> 0x%x .. 0x%x ] for dso %s" % (start_addr, int(dso_start),
>>>>>>>>>>>>>> int(dso_end), dso))
>>>>>>>>>>>>>>                   return
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Without this patch below is the failure log(with segfault) 
>>>>>>>>>>>>>> for
>>>>>>>>>>>>>> reference.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> [root@sut01sys-r214 perf]# timeout 4s ./perf record -e
>>>>>>>>>>>>>> cs_etm// -C 1 dd if=/dev/zero of=/dev/null
>>>>>>>>>>>>>> [ perf record: Woken up 1 times to write data ]
>>>>>>>>>>>>>> [ perf record: Captured and wrote 1.087 MB perf.data ]
>>>>>>>>>>>>>> [root@sut01sys-r214 perf]# ./perf script
>>>>>>>>>>>>>> --script=python:./scripts/python/arm-cs-trace-disasm.py -- -d
>>>>>>>>>>>>>> objdump -k ../../vmlinux -v $* > dump
>>>>>>>>>>>>>> objdump: error: the stop address should be after the start
>>>>>>>>>>>>>> address
>>>>>>>>>>>>>> Traceback (most recent call last):
>>>>>>>>>>>>>>     File "./scripts/python/arm-cs-trace-disasm.py", line 271,
>>>>>>>>>>>>>> in process_event
>>>>>>>>>>>>>>       print_disam(dso_fname, dso_vm_start, start_addr, 
>>>>>>>>>>>>>> stop_addr)
>>>>>>>>>>>>>>     File "./scripts/python/arm-cs-trace-disasm.py", line 105,
>>>>>>>>>>>>>> in print_disam
>>>>>>>>>>>>>>       for line in read_disam(dso_fname, dso_start, 
>>>>>>>>>>>>>> start_addr,
>>>>>>>>>>>>>> stop_addr):
>>>>>>>>>>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>>>>>>     File "./scripts/python/arm-cs-trace-disasm.py", line 
>>>>>>>>>>>>>> 99, in
>>>>>>>>>>>>>> read_disam
>>>>>>>>>>>>>>       disasm_output =
>>>>>>>>>>>>>> check_output(disasm).decode('utf-8').split('\n')
>>>>>>>>>>>>>>                       ^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>>>>>>     File "/usr/lib64/python3.12/subprocess.py", line 466, in
>>>>>>>>>>>>>> check_output
>>>>>>>>>>>>>>       return run(*popenargs, stdout=PIPE, timeout=timeout,
>>>>>>>>>>>>>> check=True,
>>>>>>>>>>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>>>>>>     File "/usr/lib64/python3.12/subprocess.py", line 571, 
>>>>>>>>>>>>>> in run
>>>>>>>>>>>>>>       raise CalledProcessError(retcode, process.args,
>>>>>>>>>>>>>> subprocess.CalledProcessError: Command '['objdump', '-d',
>>>>>>>>>>>>>> '-z', '--start-address=0xffff80008125b758',
>>>>>>>>>>>>>> '--stop-address=0xffff80008125a934', '../../vmlinux']'
>>>>>>>>>>>>>> returned non-zero exit status 1.
>>>>>>>>>>>>>> Fatal Python error: handler_call_die: problem in Python trace
>>>>>>>>>>>>>> event handler
>>>>>>>>>>>>>> Python runtime state: initialized
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Current thread 0x0000ffffb90d54e0 (most recent call first):
>>>>>>>>>>>>>>     <no Python frame>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Extension modules: perf_trace_context, systemd._journal,
>>>>>>>>>>>>>> systemd._reader, systemd.id128, report._py3report,
>>>>>>>>>>>>>> _dbus_bindings, problem._py3abrt (total: 7)
>>>>>>>>>>>>>> Aborted (core dumped)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> dump snippet:
>>>>>>>>>>>>>> ============
>>>>>>>>>>>>>> Event type: branches
>>>>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008030cb00 phys_addr:
>>>>>>>>>>>>>> 0x0000000000000000 ip: 0xffff800080313f0c pid: 12720 tid:
>>>>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>>>>           ffff800080313f04 
>>>>>>>>>>>>>> <__perf_event_header__init_id+0x4c>:
>>>>>>>>>>>>>>           ffff800080313f04:       36100094        tbz     
>>>>>>>>>>>>>> w20,
>>>>>>>>>>>>>> #2, ffff800080313f14 <__perf_event_header__init_id+0x5c>
>>>>>>>>>>>>>>           ffff800080313f08:       f941e6a0        ldr     x0,
>>>>>>>>>>>>>> [x21, #968]
>>>>>>>>>>>>>>           ffff800080313f0c:       d63f0000        blr     x0
>>>>>>>>>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>>>>>> __perf_event_header__init_id+0x54
>>>>>>>>>>>>>> .../coresight/linux/kernel/events/core.c  586         return
>>>>>>>>>>>>>> event->clock();
>>>>>>>>>>>>>> Event type: branches
>>>>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff8000801bb4a8 phys_addr:
>>>>>>>>>>>>>> 0x0000000000000000 ip: 0xffff80008030cb0c pid: 12720 tid:
>>>>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>>>>           ffff80008030cb00 <local_clock>:
>>>>>>>>>>>>>>           ffff80008030cb00:       d503233f        paciasp
>>>>>>>>>>>>>>           ffff80008030cb04:       a9bf7bfd        stp     
>>>>>>>>>>>>>> x29,
>>>>>>>>>>>>>> x30, [sp, #-16]!
>>>>>>>>>>>>>>           ffff80008030cb08:       910003fd        mov x29, sp
>>>>>>>>>>>>>>           ffff80008030cb0c:       97faba67        bl
>>>>>>>>>>>>>> ffff8000801bb4a8 <sched_clock>
>>>>>>>>>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>>>>>> local_clock+0xc ...t/linux/./include/linux/sched/clock.h   64
>>>>>>>>>>>>>> return sched_clock();
>>>>>>>>>>>>>> Event type: branches
>>>>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008125a8a8 phys_addr:
>>>>>>>>>>>>>> 0x0000000000000000 ip: 0xffff8000801bb4c8 pid: 12720 tid:
>>>>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>>>>           ffff8000801bb4a8 <sched_clock>:
>>>>>>>>>>>>>>           ffff8000801bb4a8:       d503233f        paciasp
>>>>>>>>>>>>>>           ffff8000801bb4ac:       a9be7bfd        stp     
>>>>>>>>>>>>>> x29,
>>>>>>>>>>>>>> x30, [sp, #-32]!
>>>>>>>>>>>>>>           ffff8000801bb4b0:       910003fd        mov x29, sp
>>>>>>>>>>>>>>           ffff8000801bb4b4:       a90153f3        stp     
>>>>>>>>>>>>>> x19,
>>>>>>>>>>>>>> x20, [sp, #16]
>>>>>>>>>>>>>>           ffff8000801bb4b8:       d5384113        mrs     
>>>>>>>>>>>>>> x19,
>>>>>>>>>>>>>> sp_el0
>>>>>>>>>>>>>>           ffff8000801bb4bc:       b9401260        ldr     w0,
>>>>>>>>>>>>>> [x19, #16]
>>>>>>>>>>>>>>           ffff8000801bb4c0:       11000400        add     w0,
>>>>>>>>>>>>>> w0, #0x1
>>>>>>>>>>>>>>           ffff8000801bb4c4:       b9001260        str     w0,
>>>>>>>>>>>>>> [x19, #16]
>>>>>>>>>>>>>>           ffff8000801bb4c8:       94427cf8        bl
>>>>>>>>>>>>>> ffff80008125a8a8 <sched_clock_noinstr>
>>>>>>>>>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>>>>>> sched_clock+0x20 ...sight/linux/kernel/time/sched_clock.c  
>>>>>>>>>>>>>> 105
>>>>>>>>>>>>>> ns = sched_clock_noinstr();
>>>>>>>>>>>>>> Event type: branches
>>>>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008125b758 phys_addr:
>>>>>>>>>>>>>> 0x0000000000000000 ip: 0xffff80008125a8e4 pid: 12720 tid:
>>>>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>>>>           ffff80008125a8a8 <sched_clock_noinstr>:
>>>>>>>>>>>>>>           ffff80008125a8a8:       d503233f        paciasp
>>>>>>>>>>>>>>           ffff80008125a8ac:       a9bc7bfd        stp     
>>>>>>>>>>>>>> x29,
>>>>>>>>>>>>>> x30, [sp, #-64]!
>>>>>>>>>>>>>>           ffff80008125a8b0:       910003fd        mov x29, sp
>>>>>>>>>>>>>>           ffff80008125a8b4:       a90153f3        stp     
>>>>>>>>>>>>>> x19,
>>>>>>>>>>>>>> x20, [sp, #16]
>>>>>>>>>>>>>>           ffff80008125a8b8:       b000e354        adrp    
>>>>>>>>>>>>>> x20,
>>>>>>>>>>>>>> ffff800082ec3000 <tick_bc_dev+0x140>
>>>>>>>>>>>>>>           ffff80008125a8bc:       910d0294        add     
>>>>>>>>>>>>>> x20,
>>>>>>>>>>>>>> x20, #0x340
>>>>>>>>>>>>>>           ffff80008125a8c0:       a90363f7        stp     
>>>>>>>>>>>>>> x23,
>>>>>>>>>>>>>> x24, [sp, #48]
>>>>>>>>>>>>>>           ffff80008125a8c4:       91002297        add     
>>>>>>>>>>>>>> x23,
>>>>>>>>>>>>>> x20, #0x8
>>>>>>>>>>>>>>           ffff80008125a8c8:       52800518        mov     
>>>>>>>>>>>>>> w24,
>>>>>>>>>>>>>> #0x28                  // #40
>>>>>>>>>>>>>>           ffff80008125a8cc:       a9025bf5        stp     
>>>>>>>>>>>>>> x21,
>>>>>>>>>>>>>> x22, [sp, #32]
>>>>>>>>>>>>>>           ffff80008125a8d0:       b9400296        ldr     
>>>>>>>>>>>>>> w22,
>>>>>>>>>>>>>> [x20]
>>>>>>>>>>>>>>           ffff80008125a8d4:       120002d5        and     
>>>>>>>>>>>>>> w21,
>>>>>>>>>>>>>> w22, #0x1
>>>>>>>>>>>>>>           ffff80008125a8d8:       9bb87eb5        umull   
>>>>>>>>>>>>>> x21,
>>>>>>>>>>>>>> w21, w24
>>>>>>>>>>>>>>           ffff80008125a8dc:       8b1502f3        add     
>>>>>>>>>>>>>> x19,
>>>>>>>>>>>>>> x23, x21
>>>>>>>>>>>>>>           ffff80008125a8e0:       f9400e60        ldr     x0,
>>>>>>>>>>>>>> [x19, #24]
>>>>>>>>>>>>>>           ffff80008125a8e4:       d63f0000        blr     x0
>>>>>>>>>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>>>>>> sched_clock_noinstr+0x3c
>>>>>>>>>>>>>> ...sight/linux/kernel/time/sched_clock.c 93
>>>>>>>>>>>>>> cyc = (rd->read_sched_clock() - rd->epoch_cyc) &
>>>>>>>>>>>>>> Event type: branches
>>>>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff8000801bb4cc phys_addr:
>>>>>>>>>>>>>> 0x0000000000000000 ip: 0xffff80008125a930 pid: 12720 tid:
>>>>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> With fix:
>>>>>>>>>>>>>> =========
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Event type: branches
>>>>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008030cb00 phys_addr:
>>>>>>>>>>>>>> 0x0000000000000000 ip: 0xffff800080313f0c pid: 12720 tid:
>>>>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>>>>           ffff800080313f04 
>>>>>>>>>>>>>> <__perf_event_header__init_id+0x4c>:
>>>>>>>>>>>>>>           ffff800080313f04:       36100094        tbz     
>>>>>>>>>>>>>> w20,
>>>>>>>>>>>>>> #2, ffff800080313f14 <__perf_event_header__init_id+0x5c>
>>>>>>>>>>>>>>           ffff800080313f08:       f941e6a0        ldr     x0,
>>>>>>>>>>>>>> [x21, #968]
>>>>>>>>>>>>>>           ffff800080313f0c:       d63f0000        blr     x0
>>>>>>>>>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>>>>>> __perf_event_header__init_id+0x54
>>>>>>>>>>>>>> .../coresight/linux/kernel/events/core.c  586         return
>>>>>>>>>>>>>> event->clock();
>>>>>>>>>>>>>> Event type: branches
>>>>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff8000801bb4a8 phys_addr:
>>>>>>>>>>>>>> 0x0000000000000000 ip: 0xffff80008030cb0c pid: 12720 tid:
>>>>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>>>>           ffff80008030cb00 <local_clock>:
>>>>>>>>>>>>>>           ffff80008030cb00:       d503233f        paciasp
>>>>>>>>>>>>>>           ffff80008030cb04:       a9bf7bfd        stp     
>>>>>>>>>>>>>> x29,
>>>>>>>>>>>>>> x30, [sp, #-16]!
>>>>>>>>>>>>>>           ffff80008030cb08:       910003fd        mov x29, sp
>>>>>>>>>>>>>>           ffff80008030cb0c:       97faba67        bl
>>>>>>>>>>>>>> ffff8000801bb4a8 <sched_clock>
>>>>>>>>>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>>>>>> local_clock+0xc ...t/linux/./include/linux/sched/clock.h   64
>>>>>>>>>>>>>> return sched_clock();
>>>>>>>>>>>>>> Event type: branches
>>>>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008125a8a8 phys_addr:
>>>>>>>>>>>>>> 0x0000000000000000 ip: 0xffff8000801bb4c8 pid: 12720 tid:
>>>>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>>>>           ffff8000801bb4a8 <sched_clock>:
>>>>>>>>>>>>>>           ffff8000801bb4a8:       d503233f        paciasp
>>>>>>>>>>>>>>           ffff8000801bb4ac:       a9be7bfd        stp     
>>>>>>>>>>>>>> x29,
>>>>>>>>>>>>>> x30, [sp, #-32]!
>>>>>>>>>>>>>>           ffff8000801bb4b0:       910003fd        mov x29, sp
>>>>>>>>>>>>>>           ffff8000801bb4b4:       a90153f3        stp     
>>>>>>>>>>>>>> x19,
>>>>>>>>>>>>>> x20, [sp, #16]
>>>>>>>>>>>>>>           ffff8000801bb4b8:       d5384113        mrs     
>>>>>>>>>>>>>> x19,
>>>>>>>>>>>>>> sp_el0
>>>>>>>>>>>>>>           ffff8000801bb4bc:       b9401260        ldr     w0,
>>>>>>>>>>>>>> [x19, #16]
>>>>>>>>>>>>>>           ffff8000801bb4c0:       11000400        add     w0,
>>>>>>>>>>>>>> w0, #0x1
>>>>>>>>>>>>>>           ffff8000801bb4c4:       b9001260        str     w0,
>>>>>>>>>>>>>> [x19, #16]
>>>>>>>>>>>>>>           ffff8000801bb4c8:       94427cf8        bl
>>>>>>>>>>>>>> ffff80008125a8a8 <sched_clock_noinstr>
>>>>>>>>>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>>>>>> sched_clock+0x20 ...sight/linux/kernel/time/sched_clock.c  
>>>>>>>>>>>>>> 105
>>>>>>>>>>>>>> ns = sched_clock_noinstr();
>>>>>>>>>>>>>> Event type: branches
>>>>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff80008125b758 phys_addr:
>>>>>>>>>>>>>> 0x0000000000000000 ip: 0xffff80008125a8e4 pid: 12720 tid:
>>>>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>>>>           ffff80008125a8a8 <sched_clock_noinstr>:
>>>>>>>>>>>>>>           ffff80008125a8a8:       d503233f        paciasp
>>>>>>>>>>>>>>           ffff80008125a8ac:       a9bc7bfd        stp     
>>>>>>>>>>>>>> x29,
>>>>>>>>>>>>>> x30, [sp, #-64]!
>>>>>>>>>>>>>>           ffff80008125a8b0:       910003fd        mov x29, sp
>>>>>>>>>>>>>>           ffff80008125a8b4:       a90153f3        stp     
>>>>>>>>>>>>>> x19,
>>>>>>>>>>>>>> x20, [sp, #16]
>>>>>>>>>>>>>>           ffff80008125a8b8:       b000e354        adrp    
>>>>>>>>>>>>>> x20,
>>>>>>>>>>>>>> ffff800082ec3000 <tick_bc_dev+0x140>
>>>>>>>>>>>>>>           ffff80008125a8bc:       910d0294        add     
>>>>>>>>>>>>>> x20,
>>>>>>>>>>>>>> x20, #0x340
>>>>>>>>>>>>>>           ffff80008125a8c0:       a90363f7        stp     
>>>>>>>>>>>>>> x23,
>>>>>>>>>>>>>> x24, [sp, #48]
>>>>>>>>>>>>>>           ffff80008125a8c4:       91002297        add     
>>>>>>>>>>>>>> x23,
>>>>>>>>>>>>>> x20, #0x8
>>>>>>>>>>>>>>           ffff80008125a8c8:       52800518        mov     
>>>>>>>>>>>>>> w24,
>>>>>>>>>>>>>> #0x28                  // #40
>>>>>>>>>>>>>>           ffff80008125a8cc:       a9025bf5        stp     
>>>>>>>>>>>>>> x21,
>>>>>>>>>>>>>> x22, [sp, #32]
>>>>>>>>>>>>>>           ffff80008125a8d0:       b9400296        ldr     
>>>>>>>>>>>>>> w22,
>>>>>>>>>>>>>> [x20]
>>>>>>>>>>>>>>           ffff80008125a8d4:       120002d5        and     
>>>>>>>>>>>>>> w21,
>>>>>>>>>>>>>> w22, #0x1
>>>>>>>>>>>>>>           ffff80008125a8d8:       9bb87eb5        umull   
>>>>>>>>>>>>>> x21,
>>>>>>>>>>>>>> w21, w24
>>>>>>>>>>>>>>           ffff80008125a8dc:       8b1502f3        add     
>>>>>>>>>>>>>> x19,
>>>>>>>>>>>>>> x23, x21
>>>>>>>>>>>>>>           ffff80008125a8e0:       f9400e60        ldr     x0,
>>>>>>>>>>>>>> [x19, #24]
>>>>>>>>>>>>>>           ffff80008125a8e4:       d63f0000        blr     x0
>>>>>>>>>>>>>
>>>>>>>>>>>>> It looks like the disassembly now assumes this BLR wasn't
>>>>>>>>>>>>> taken. We go from ffff80008125a8e4 straight through to ...
>>>>>>>>>>>>>
>>>>>>>>>>>>>>               perf 12720/12720 [0001]      5986.372298040
>>>>>>>>>>>>>> sched_clock_noinstr+0x3c
>>>>>>>>>>>>>> ...sight/linux/kernel/time/sched_clock.c 93
>>>>>>>>>>>>>> cyc = (rd->read_sched_clock() - rd->epoch_cyc) &
>>>>>>>>>>>>>> Event type: branches
>>>>>>>>>>>>>> Sample = { cpu: 0001 addr: 0xffff8000801bb4cc phys_addr:
>>>>>>>>>>>>>> 0x0000000000000000 ip: 0xffff80008125a930 pid: 12720 tid:
>>>>>>>>>>>>>> 12720 period: 1 time: 5986372298040 }
>>>>>>>>>>>>>>           ffff80008125a8e8 <sched_clock_noinstr+0x40>:
>>>>>>>>>>>>>>           ffff80008125a8e8:       f8756ae3        ldr     x3,
>>>>>>>>>>>>>> [x23, x21]
>>>>>>>>>>>>>
>>>>>>>>>>>>> ffff80008125a8e4 which is just the previous one +4. Isn't your
>>>>>>>>>>>>> issue actually a decode issue in Perf itself? Why is there a
>>>>>>>>>>>>> discontinuity without branch samples being generated where
>>>>>>>>>>>>> either the source or destination address is 0?
>>>>>>>>>>>>>
>>>>>>>>>>>>> What are your record options to create this issue? As I
>>>>>>>>>>>>> mentioned in the previous reply I haven't been able to
>>>>>>>>>>>>> reproduce it.
>>>>>>>>>>>>
>>>>>>>>>>>> I am using below perf record command.
>>>>>>>>>>>>
>>>>>>>>>>>> timeout 4s ./perf record -e cs_etm// -C 1 dd if=/dev/zero
>>>>>>>>>>>> of=/dev/null
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Thanks I managed to reproduce it. I'll take a look to see if I
>>>>>>>>>>> think the issue is somewhere else.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> At least for the failures I encountered, the issue is due to the
>>>>>>>>>> alternatives runtime instruction patching mechanism. vmlinux ends
>>>>>>>>>> up being the wrong image to decode with because a load of 
>>>>>>>>>> branches
>>>>>>>>>> are actually turned into nops.
>>>>>>>>>>
>>>>>>>>>> Can you confirm if you use --kcore instead of vmlinux that you
>>>>>>>>>> still get failures:
>>>>>>>>>>
>>>>>>>>>>     sudo perf record -e cs_etm// -C 1 --kcore -o
>>>>>>>>>> <output-folder.data> -- \
>>>>>>>>>>       dd if=/dev/zero of=/dev/null
>>>>>>>>>>
>>>>>>>>>>      perf script -i <output-folder.data> \
>>>>>>>>>>       tools/perf/scripts/python/arm-cs-trace-disasm.py -d
>>>>>>>>>> llvm-objdump \
>>>>>>>>>>       -k <output-folder.data>/kcore_dir/kcore
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> With below command combination with kcore also the issue is seen,
>>>>>>>>> as reported in this email chain.
>>>>>>>>>
>>>>>>>>> timeout 8s ./perf record -e cs_etm// -C 1 --kcore -o kcore \
>>>>>>>>> dd if=/dev/zero of=/dev/null
>>>>>>>>>
>>>>>>>>> ./perf script -i kcore/data \
>>>>>>>>> --script=python:./scripts/python/arm-cs-trace-disasm.py -- \
>>>>>>>>> -d objdump -k kcore/kcore_dir/kcore
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> However, with below sequence(same as your command) the issue is
>>>>>>>>> *not* seen.
>>>>>>>>>
>>>>>>>>> timeout 8s ./perf record -e cs_etm// -C 1 --kcore -o kcore \
>>>>>>>>> dd if=/dev/zero of=/dev/null
>>>>>>>>>
>>>>>>>>> ./perf script -i kcore/data 
>>>>>>>>> ./scripts/python/arm-cs-trace-disasm.py \
>>>>>>>>> -- -d objdump -k kcore/kcore_dir/kcore
>>>>>>>>>
>>>>>>>>> Do you see any issue with the command, which is showing the 
>>>>>>>>> problem?
>>>>>>>>> Also the output log produced by these both commands is different.
>>>>>>>>>
>>>>>>
>>>>>> BTW are you running this on the target or somewhere else? It's
>>>>>> suspicious that "-i kcore/data" works at all because there is no
>>>>>> kernel image given to Perf. Unless you are running on the target and
>>>>>> then I think it will just open the one from /proc. Or maybe it uses
>>>>>> /boot/vmlinux by default which also wouldn't work.
>>>>>>
>>
>> Yes All tests are done natively on Ampere's ARM64 platform.
>> some more combination of commands which are also failing.
>>
>> ./perf script -i ./kcore -s scripts/python/arm-cs-trace-disasm.py -- 
>> -d objdump -k kcore/kcore_dir/kcore
>>
>> ./perf script -i ./kcore -s scripts/python/arm-cs-trace-disasm.py -F 
>> cpu,event,ip,addr,sym -- -d objdump -k kcore/kcore_dir/kcore
>>
>>   ./perf script -i ./kcore scripts/python/arm-cs-trace-disasm.py -d 
>> objdump -k kcore/kcore_dir/kcore
>>
>>>>>> Also the difference between "--script=python:" and just giving the
>>>>>> script name is in the parsing of the arguments following " -- ".
>>>>>> Sometimes they're also parsed as Perf arguments (like the -v becomes
>>>>>> perf verbose and -k becomes the Perf vmlinux rather than the script).
>>>>>>
>>>>>> I _think_ you want the " -- " when "--script" is used, and no "--"
>>>>>> when it's not. But there are some other combinations and you'll have
>>>>>> to debug it to compare your two exact scenarios to see why they're
>>>>>> different.
>>>>>>
>>>>>> But ignoring that issue with the argument format, you mentioned you
>>>>>> didn't see the issue any more with one version of --kcore. So I'm
>>>>>> assuming that confirms the issue is just a decode image issue, so we
>>>>>> shouldn't try to patch this script?
>>>>>>
>>>>>
>>>>> Although one change we should make to the script is change the example
>>>>> to use kcore. We can leave in one vmlinux one as an example if kcore
>>>>> isn't available, but add a note that it will fail if any patched 
>>>>> code is
>>>>> traced (which is almost always).
>>>>
>>>> James, you may recall the year old thread
>>>> https://lore.kernel.org/all/ed8cea4c-a261-60ca-f4e1-333ec73cca8f@os.amperecomputing.com.
>>>> I described there an awkward workaround Ampere has used to solve the
>>>> patched code problem. At the time, it sounded like the maintainers were
>>>> interested in getting away from using the python script, mostly for
>>>> speed purposes. I didn't see the discussion go any further.
>>>>
>>>
>>> Oh yes thanks for the reminder. I wasn't thinking about the source 
>>> code lines and debug symbols in this thread. I suppose your merging 
>>> of kcore and vmlinux gives both the correct image and the symbols, 
>>> but I was only focused on the image being correct, so only kcore was 
>>> enough.
>>>
>>> It looks like everything we want to do from your previous thread is 
>>> in addition to the fixes from this one. Even if we auto merge kcore + 
>>> symbols and move the disassembly into Perf, we still want to detect 
>>> decode issues earlier and not have IPs jumping backwards. Whether 
>>> it's the script or Perf doing that the behavior should be the same.
>>>
>>
>> Since it is breaking the decode, can we please add as a fix to drop 
>> the packets from decode when the discontinuity is seen (with warning 
>> message in verbose mode)? like below diff?
>>
>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>> @@ -257,6 +257,11 @@ def process_event(param_dict):
>>                  print("Stop address 0x%x is out of range [ 0x%x .. 
>> 0x%x ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
>>                  return
>>
>> +       if (stop_addr < start_addr):
>> +               if (options.verbose == True):
>> +                       print("Packet Dropped, Discontinuity detected 
>> [stop_add:0x%x start_addr:0x%x ] for dso %s" % (stop_addr, start_addr, 
>> dso))
>> +               return
>> +
> 
> I suppose my only concern with this is that it hides real errors and 
> Perf shouldn't be outputting samples that go backwards. Considering that 
> fixing this in OpenCSD and Perf has a much wider benefit I think that 
> should be the ultimate goal. I'm putting this on my todo list for now 
> (including Steve's merging idea).
> 
> But in the mean time what about having a force option?
> 
>  > +       if (stop_addr < start_addr):
>  > +               if (options.verbose == True or not options.force):
>  > +                       print("Packet Dropped, Discontinuity detected
>  > [stop_add:0x%x start_addr:0x%x ] for dso %s" % (stop_addr, start_addr,
>  > dso))
>  > +               if (not options.force):
>  > +                       return
>  > +
> 
> That way in the future we'll still get reports if something new goes wrong.

Sure, Makes sense.
Is below diff with force option looks good?

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py 
b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index d973c2baed1c..efe34f308beb 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -36,7 +36,10 @@ option_list = [
                     help="Set path to objdump executable file"),
         make_option("-v", "--verbose", dest="verbose",
                     action="store_true", default=False,
-                   help="Enable debugging log")
+                   help="Enable debugging log"),
+       make_option("-f", "--force", dest="force",
+                   action="store_true", default=False,
+                   help="Force decoder to continue")
  ]

  parser = OptionParser(option_list=option_list)
@@ -257,6 +260,12 @@ def process_event(param_dict):
                 print("Stop address 0x%x is out of range [ 0x%x .. 0x%x 
] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
                 return

+       if (stop_addr < start_addr):
+               if (options.verbose == True or options.force):
+                       print("Packet Discontinuity detected 
[stop_add:0x%x start_addr:0x%x ] for dso %s" % (stop_addr, start_addr, dso))
+               if (options.force):
+                       return
+
         if (options.objdump_name != None):
                 # It doesn't need to decrease virtual memory offset for 
disassembly
                 # for kernel dso and executable file dso, so in this 
case we set


> 
>>          if (options.objdump_name != None):
>>                  # It doesn't need to decrease virtual memory offset 
>> for disassembly
>>                  # for kernel dso and executable file dso, so in this 
>> case we set
>>
>>
>>> To summarise I think these are the changes to make:
>>>
>>>    * Improve bad decode detection in OpenCSD
>>>    * Get the script to auto merge kcore and vmlinux
>>>      * Maybe we could get Perf to do this if both a kcore folder and -k
>>>        vmlinux are used?
>>>    * Improve the performance, either in the script or move more
>>>      functionality into Perf
>>

Thanks,
Ganapat

