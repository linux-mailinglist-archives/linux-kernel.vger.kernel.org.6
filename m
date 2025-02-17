Return-Path: <linux-kernel+bounces-518305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BA7A38CFE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84923B4019
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C68C237163;
	Mon, 17 Feb 2025 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Bcyjgwk6"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021107.outbound.protection.outlook.com [40.107.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A31227BAA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822616; cv=fail; b=rPvcdHghMHyfCuxomXhmCpm7YWIHarNWSFXsTw3c9NR0TrDTPcY+w0P9l4PbT531eAhGkmHS2V0VOaosVJMk42Ugta4a810Ex1m7VGwo3802XyOIEhTCHDsfQQUKAUWRNKutX/CYNuNa4F9sd0F+YlaQo1779eF8YGtENDvTSM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822616; c=relaxed/simple;
	bh=S8ops/72whfHMqqKkgNxIYPx86RpExZLz4s26GlN8Rg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=igihWFAX7j7f1BQ22E3XsT4pvgoxKNK3LIJt8xlSzxY25pMY/KMt6z7XSXGyNnaH9KQl12Hl/D7b1H5JnWN03Fx5reIRsvFzsU2+b34pEkDdBPijR5w2IBHvcv76pxCx0qzRNROqoVtAJwdvwO1gaxw57goHwzmxi4jGl0Vu35E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Bcyjgwk6; arc=fail smtp.client-ip=40.107.192.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MdLJXVx9mT5O0Tcy5O0zF23qEwS8Z6brcxQNZJ5pilYnhT83fKnFAs2YFPQBK86JHY5Vv5B0pG+whgM6hPVcg6LGMrC7RJ5qnVcWq6+hblIm6dtpJgiXXpQ9OkNSrQVIaa/wDtCwvNZ/NhYfOW3rSTt1xyUvnzdGlmCSOo1cfAcOpTuhORJ69hLayKcf7m214q7UnVc2QytqBJ1eRWJ/BOSOqx2W+NIBqgDYY4POG4fMeX8VWc9Z9rDu3u2nh184slw48zDCcMNPIegZm/nzFmkkOm4OeJ7YqUKfUAMaMe7imC30P34RLLw/gpiCNCr7QJt5LntbSa/IH0A5DvyqjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXWthmnQOykSCfE/y5sZAdqWhdPfXUWtHfzrjrIdP/c=;
 b=hhr/Axn0pVfBkjbE0TXhozSFJQcPN4v2RxuXxiTYSyHzZZsNK0y4Ye9HBkxSojtwTOemGQuejglKtAjCtQ5Ht4srVvLQOAzfGeh2lOj39Xkhlh5ildgWyrOpSs6Q37mhEvK8urR8mj2Iz6sxvpbZuzfk15OWFI3MSbSFSuEWKQr62hE1YsF9+yRUvGJc1elfFMzxyjKt7EarG6CV8zjCKAGUUZHPqnzwpNPnkm5BodaK4yjnkNxJSHqTFe2t+j5XPW+A/o1MbOhVcrHthhIV3USxPU5vm/SZ7FhE1tvktkBIrkP/nGZj/OemxT5lXSuavf0oc9NQPHsWMHIkwdQNlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXWthmnQOykSCfE/y5sZAdqWhdPfXUWtHfzrjrIdP/c=;
 b=Bcyjgwk6h1sNOAvhxuA51ZBHU74fQAOgVpTNX3MgeFdYfgk8ATPd8Vw9Ck3/Q/D/k6fpp/SNW+NTrbsE9D4/ZgA+3NNRaZjWdWf39u7bCQ2nCCVzokDMogvNqJlqJgPUGdR4ytePI82rn0G3lCs7Utd2yutntAwTXJ/zJwmg9aowzqV4KnWhO2tyOkpq0sVLgvoGOpgiogEqZfFMSOBDKDe5qqkTAaeuPcFb+qyKNzBJN1TZjepPMsnIuJlVv5kBwdwvjaPa9Z/QqqfraG71aayr7Etf0Rlx5a30EA1PBhWdAvdmYVRqpgt1+Enap/x9ejrVDYKyI30XEbjFy0A1eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PPF5D0F05300.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::445) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Mon, 17 Feb
 2025 20:03:31 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 20:03:31 +0000
Message-ID: <71668213-3630-4a03-9951-fa1c672b11d5@efficios.com>
Date: Mon, 17 Feb 2025 15:03:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] pkeys: add API to switch to permissive pkey register
To: Dmitry Vyukov <dvyukov@google.com>, peterz@infradead.org,
 boqun.feng@gmail.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com,
 elver@google.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1739790300.git.dvyukov@google.com>
 <ffd123bb0c73df5cdd3a5807b360bd390983150b.1739790300.git.dvyukov@google.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <ffd123bb0c73df5cdd3a5807b360bd390983150b.1739790300.git.dvyukov@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::21) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PPF5D0F05300:EE_
X-MS-Office365-Filtering-Correlation-Id: ea56bb33-e3a5-418e-7f77-08dd4f8e2719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzVJbE1lMUNwRWRuVVo5SUo5OWlsWEprN3ROMjJIdDNwQ0dtYnl2ZGlINmdQ?=
 =?utf-8?B?MVB6ZWF5VjRXU1VhaW8rbjVqSDE3K21TNmNsRkpVbjBXUWlId2pMSVR0MDR3?=
 =?utf-8?B?MWlIZW51VGlocUpWKzN5bzAvU0haMHQrY3FHelVOWDdNM3JYS3lNMWhqalFt?=
 =?utf-8?B?VFQzVDNmU28rZlhmWTU2ZXVzSVJtazZhdU9DS0R3TE5jdTFEM1VjR1Fpa20x?=
 =?utf-8?B?b3dZditST1FsbzRZZEtCYXBwaUZEb0huY2NwWjNFc1lqdzZNMFd2bDc3Qk0x?=
 =?utf-8?B?TVZnZjBtcForK3E2WWJoTnVVMFFsYkN2Z093dC9maUwwVFBSMGJOMGh5cFU3?=
 =?utf-8?B?QithbXVBSVdOUkZpSHFjYU11amdhZWxOQzBxbnJneHFsaTNBMCtsc0xkdlA0?=
 =?utf-8?B?MzdsZjByakt3c3VUdk11SDFyQzZZTlIvcDR1TkNzdHBXa0E3ZEJGb3ltU2oy?=
 =?utf-8?B?Q0hHaFRENCs2RGFVSkZQL2dVVElqdVNFY29XdXdWWnN4cjc3WjJ4c04veWh4?=
 =?utf-8?B?TUR2c0Z2aXlTR1FycTM1OG15ZGpqNDV4SXJDKzByTldJN1JCVkJwYWljR05r?=
 =?utf-8?B?dGRTMUtZaFNzSDRjUFFwelp2RWROTDhzalA5WUxZWU1ncmx3R1E3TVlWR0Fu?=
 =?utf-8?B?enNhYUIrcHRXNHZBN2VBSjZ5ZWw2WHE3MitpUEoxdkVhZnVuYTFuNHpWbklG?=
 =?utf-8?B?NXdsUFAyZlRjcERjTWQrd05sakZmY0RHSE5uZXdqNlJmaU00L2RaRndPOHFn?=
 =?utf-8?B?aHBVVXZQZWJ3eEhncVJMYU5NU1EwRi8vMllnWDRqclhsQW1yMG10NzVUZFB1?=
 =?utf-8?B?UHF3eEtGaDliQzV2MW1vV1Jxblg0U1Zmb1hOcUVHWXdZSWtXckhLU3J5NjY0?=
 =?utf-8?B?L3ZUTDg3TXVuMUFBWmx5MXNFMUtxTnZqZk90WUFBWG5ZMHAyQ0R6UU9Ycy8z?=
 =?utf-8?B?RnVWS1loVXFUMmNhVkFyWkFPdXMxVkNEaVhDWmc0MmlCYjNBRy9DVlJXV3gw?=
 =?utf-8?B?R3BUUWlUUCtEOXpVWVFXZmFjVFJMVktjbk5TODN0Z204c3NXMlFob1kxaU5n?=
 =?utf-8?B?VnVpc3ZISVM0NU80ZVl6SGpldGRlb3UrSlUrOUczSkYvL1psUm4veXZabmJ1?=
 =?utf-8?B?NDhmOW5lWVVKR1NYQi9wUVFLL2sxUEJiS3Fha2ZPUlM4NWxuZnpLQ1FhbmZG?=
 =?utf-8?B?TU84MDdVQnJxT2VJN2EzM2JyMlAwMnMxdXliNEdsdUNHZllYNjBWYklOVzRj?=
 =?utf-8?B?OWVCR2M1dEt6bERoZ04vazlvZ1NTeUhoQ1pOTjc1SjhuOGh2WXpRUjhzL09J?=
 =?utf-8?B?ckhUcEkySXFEVUJldTE1VjVVRDJPdUdpUmQyVWpxMzZoVlVuY0hKYWtvdzZX?=
 =?utf-8?B?NDNwQW1LV0U5ckFjRXRGWkRML2EwczRyUzk0eTB4M2JlRjZuc2MzMHlUNnZx?=
 =?utf-8?B?UmJ4N0VPUVdiVkU2OWVMejJzMHhwT1dvdlRERkR5anhsb2JUMGwvY3RaeGpy?=
 =?utf-8?B?M1VTdHV4MlRITTZSdGZPVlJJYnpzaVVxaFlNZEZNcFBaVTRMK0VTMXIrcVRW?=
 =?utf-8?B?OUhrcWZrSEFOdGVPd1lOdkJaSnF1czEyOG1vaEtWOTJ0N21GTFBueHdMSith?=
 =?utf-8?B?aVdyZnFobTc0SUNRTXRFOUZPMFlReWFoSGc3TmpEZ041Z09Jb2d0NjdIYk1X?=
 =?utf-8?B?ZTNneGhoTFB0c1BPWUlMeEVJTVFOWm1aS0Vpd2VxSkVEWUp6NWU3Qm15ckY3?=
 =?utf-8?B?ODNoNFo3NExwRENMbEhqbWlaazkxL0FpZDlkaDY4QSt4MzZuN1dYOUdJaDVu?=
 =?utf-8?B?MHVCVFozOG9FeU95UXYvY2ovTkRTaGpDTy9TSUNzeGRIUy9Oc3BVV1NRRmlh?=
 =?utf-8?Q?oVGm2pEE1Rxaj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVhFVWZVU0loQ3YxVWlTUDFMYUU2TDd3SUwrbGZ2WUx5ZzIxVHEyMjBPQU5C?=
 =?utf-8?B?NWU4M2MvZUVMQlZwWnY1b2laSVQ3dXRFWjBTamZhTHpVZ3liQ2FLdFBESnhY?=
 =?utf-8?B?anRPenNObWxsOVRFN05NNGtOd0FTenVjRk1tRHhSVEkzLy9ES0phS3lxTXVD?=
 =?utf-8?B?UWZ3N2tPeHlrY2FvbzJUR1dEVUdUUTU0dCtNNTErNVJaUTVBdjQyWUh2WFpC?=
 =?utf-8?B?MEFJc1d5bWtYRlozNUIybzNlZFpEMWhNREpSRkxGM0NyUSs3YzZqd096SXF1?=
 =?utf-8?B?OG1hM3Fzalg2a2RsR2JPd0k2RlF5L254YVdKV09EbWYyY1g4U253dHRuRDdw?=
 =?utf-8?B?Q1p0ZlhNcGhnUHo0eWtSWHcvV1VORXpnZ0MzamNZOHFIYnVOVkxXRUt2TDd4?=
 =?utf-8?B?T1NNS3lEZFRYQ0I2UFovZW9nSFg1VmhKVDNnYnVVVVFNdkhhSmQrSmUzQWRH?=
 =?utf-8?B?YTdhT2dYdGtzRkZDQVk0Q0g1Q0t3aG4rNFp6R2R3TWZVZXZvNTU3aGp0dFhz?=
 =?utf-8?B?TVJLLzF6SktjeTJyREhOeTl5M1c5VlBQNTJUWXU2VXNMUEpuNC9mekt6N3Rh?=
 =?utf-8?B?VngycHdSTEFwUmFTNFczRDNLdFQzcHdUbnN3RDV4ZlVGWXJ1SWhzWHh6NUZX?=
 =?utf-8?B?SG8rUmtuWFRETElna2RQaEw3UEs5OVdoNzlLMnlxS1ZwYkpnTW1laTA1TmxL?=
 =?utf-8?B?Vkk2enphRjAyNkdwSWlPVk9UYlgvd3hiZ2hKaXRFd3RQd3FyT2hBWkN2OGJK?=
 =?utf-8?B?bGJUdGlPbUtBMjBPSmFlbWo0aFQ3OVJ0cFVaSVFUdEViNnZ2MHFaYkt2a3Fy?=
 =?utf-8?B?THUyQVplZlRqcDdxRTZ5WlhWdUFEekZoOFVpQk1jWExpSXJBdGFIdG9VanhT?=
 =?utf-8?B?RVRuWmt2eEdxWExoRjZzUi9OWjZsTkRzSkZySC9KREFxVDlnZW5kTjB5NHN1?=
 =?utf-8?B?SWgxck1UYmo3aDA0RHpGa2l3VldqaUlCQWJYbHlVVDI3QnBZS0hBVnB2U0tP?=
 =?utf-8?B?U1NLdGNua0tpd2E5QnE5dEd4SzRBejRHd3RtWlNtWWlFZjZHVlBBQTk2dVVo?=
 =?utf-8?B?eDh1amo5SDRpZGJQWEQvY0RacUR0SURVZFB5MGFWa2xFRmNJeWhBb0F6MEhU?=
 =?utf-8?B?bVJSRnFwWnlFNStud3VIUnJyM2xoRzF2eVpvaUVZZmpSVnhLL2tkNkFENnhR?=
 =?utf-8?B?bGRlaHpqZUtrNzVZVVU2OEZPTWt1K2hQOGFYVDN1ZFpTU1V2ZFR2SzN1UGRS?=
 =?utf-8?B?cEVvMnV1OUNGMXpCZmlhR3BGbWc1MFJPUlExcXpKMDdaUHljRVMwb1VVVmho?=
 =?utf-8?B?bHZqQkN1QzRlby85Zjh4bTFpc0tJM0hUZFdOYk84RVlsZHVCeWppMTM5dWgw?=
 =?utf-8?B?aUduUVJlUkRwTFdKZytkcXp3dGVHVW1XT0JwRmxrN3U0RHprV2RVVG0ycEFL?=
 =?utf-8?B?Mi91WFRMdXhTRmh4SkZ4SHBJaWxlSjlRbUxFVzB1WGw3dXNzL05HbWozZUFJ?=
 =?utf-8?B?bjdTRFl4Uk1DWlVpOGZLRTRXWnpuYnFmTEdFdHR3eDFCbktJbmRTRk9ueFpN?=
 =?utf-8?B?WGZxQ2NwaERWQnRxUFpvRWkwSnVKTHFvSWlsTXB1b1pVSmJHWmQ1c1hySmFP?=
 =?utf-8?B?b3BkaHdFOW5WK0xFR0JQSS9hdndLeWxRUjdPWmo1RTMxZTA3ZjdHMW9weEU5?=
 =?utf-8?B?YVJvejdreFVzZXpsUkJpRnBKb3FqRzBNQUx0Q2ZqT0FQTVdQaHRTWGdkZkw4?=
 =?utf-8?B?OXFxTm55MnF3WS83QnRXMW9yUVhzMGd5eXpIc1d5N2dQZnY3bzl6S1g3dkJq?=
 =?utf-8?B?VkZxVTFsKzB0SEF1RDdwZ1k3QXgzdVJzekl5M3plK3E0UU9zbG9XRitLWXZ2?=
 =?utf-8?B?aVNlSUo0VWRXM1JSV1BHOE5mQUdsLzhYOWxncmZtZkJURTRnMWhKUUxRMEgr?=
 =?utf-8?B?VzVaWHJSMmRIUkZRc3JpNUtWODJDdmdTdHJMUUp0bVIxU3NMWWRXMm1xRFAr?=
 =?utf-8?B?V2pJQ05HYW51SEhuVXNlUFdIK0VFelhUSjE4UDF0dW1DR242RitLSk9YNG5C?=
 =?utf-8?B?c1ZTbWo2QnExZmRhNjlnUm14ejVvR0FQdlZuT0NkcWE3UFNyNENoZ0lhSmw4?=
 =?utf-8?B?MEl3OCtKLzB2Uzg1VERweVlkeWgyNFNYdExYK2pKRFNoak11SEZJZDFIbkZp?=
 =?utf-8?Q?2pvzQSqb9zKAH6YoQtFheLA=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea56bb33-e3a5-418e-7f77-08dd4f8e2719
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 20:03:31.7456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eh/yzKcfwMoPm6yb8E7bQ51yJs3HCJJd78qpxrqQiOJgkoJyp5xMpqXOjPqEKp2tzI+c6X07m3iCQazOBab48YdjTfICkSvUrJrbg5t2nLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PPF5D0F05300

On 2025-02-17 06:07, Dmitry Vyukov wrote:
> The API allows to switch to permissive pkey register that allows accesses
> to all PKEYs. This is functionality is already used in x86 signal delivery,

"This functionality"

Other than that,

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu

> and will be needed for rseq.
> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   arch/x86/Kconfig             |  1 +
>   arch/x86/include/asm/pkeys.h | 14 ++++++++++++++
>   arch/x86/include/asm/pkru.h  | 10 +++++++---
>   include/linux/pkeys.h        | 22 ++++++++++++++++++++++
>   mm/Kconfig                   |  2 ++
>   5 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index be2c311f5118d..43af2840d098f 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1881,6 +1881,7 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
>   	depends on X86_64 && (CPU_SUP_INTEL || CPU_SUP_AMD)
>   	select ARCH_USES_HIGH_VMA_FLAGS
>   	select ARCH_HAS_PKEYS
> +	select ARCH_HAS_PERMISSIVE_PKEY
>   	help
>   	  Memory Protection Keys provides a mechanism for enforcing
>   	  page-based protections, but without requiring modification of the
> diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
> index 2e6c04d8a45b4..1cacfe184b9d4 100644
> --- a/arch/x86/include/asm/pkeys.h
> +++ b/arch/x86/include/asm/pkeys.h
> @@ -2,6 +2,8 @@
>   #ifndef _ASM_X86_PKEYS_H
>   #define _ASM_X86_PKEYS_H
>   
> +#include "pkru.h"
> +
>   /*
>    * If more than 16 keys are ever supported, a thorough audit
>    * will be necessary to ensure that the types that store key
> @@ -123,4 +125,16 @@ static inline int vma_pkey(struct vm_area_struct *vma)
>   	return (vma->vm_flags & vma_pkey_mask) >> VM_PKEY_SHIFT;
>   }
>   
> +typedef u32 pkey_reg_t;
> +
> +static inline pkey_reg_t switch_to_permissive_pkey_reg(void)
> +{
> +	return write_pkru(0);
> +}
> +
> +static inline void write_pkey_reg(pkey_reg_t val)
> +{
> +	write_pkru(val);
> +}
> +
>   #endif /*_ASM_X86_PKEYS_H */
> diff --git a/arch/x86/include/asm/pkru.h b/arch/x86/include/asm/pkru.h
> index 74f0a2d34ffdd..b9bf9b7f2753b 100644
> --- a/arch/x86/include/asm/pkru.h
> +++ b/arch/x86/include/asm/pkru.h
> @@ -39,16 +39,20 @@ static inline u32 read_pkru(void)
>   	return 0;
>   }
>   
> -static inline void write_pkru(u32 pkru)
> +static inline u32 write_pkru(u32 pkru)
>   {
> +	u32 old_pkru;
> +
>   	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
> -		return;
> +		return 0;
>   	/*
>   	 * WRPKRU is relatively expensive compared to RDPKRU.
>   	 * Avoid WRPKRU when it would not change the value.
>   	 */
> -	if (pkru != rdpkru())
> +	old_pkru = rdpkru();
> +	if (pkru != old_pkru)
>   		wrpkru(pkru);
> +	return old_pkru;
>   }
>   
>   static inline void pkru_write_default(void)
> diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
> index 86be8bf27b41b..d94a0ae7a784b 100644
> --- a/include/linux/pkeys.h
> +++ b/include/linux/pkeys.h
> @@ -48,4 +48,26 @@ static inline bool arch_pkeys_enabled(void)
>   
>   #endif /* ! CONFIG_ARCH_HAS_PKEYS */
>   
> +#ifndef CONFIG_ARCH_HAS_PERMISSIVE_PKEY
> +
> +/*
> + * Common name for value of the register that controls access to PKEYs
> + * (called differently on different arches: PKRU, POR, AMR).
> + */
> +typedef int pkey_reg_t;
> +
> +/*
> + * Sets PKEY access register to the most permissive value that allows
> + * accesses to all PKEYs. Returns the current value of PKEY register.
> + * Code should generally arrange switching back to the old value
> + * using write_pkey_reg(old_value).
> + */
> +static inline pkey_reg_t switch_to_permissive_pkey_reg(void)
> +{
> +	return 0;
> +}
> +
> +static inline void write_pkey_reg(pkey_reg_t val) {}
> +#endif /* ! CONFIG_ARCH_HAS_PERMISSIVE_PKEY */
> +
>   #endif /* _LINUX_PKEYS_H */
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 1b501db064172..9e874f7713a2b 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1147,6 +1147,8 @@ config ARCH_USES_HIGH_VMA_FLAGS
>   	bool
>   config ARCH_HAS_PKEYS
>   	bool
> +config ARCH_HAS_PERMISSIVE_PKEY
> +	bool
>   
>   config ARCH_USES_PG_ARCH_2
>   	bool


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

