Return-Path: <linux-kernel+bounces-194565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC54A8D3E45
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427C91F23599
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 18:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3764515CD64;
	Wed, 29 May 2024 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dj46En84"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB21DDDA1
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717006975; cv=fail; b=WZ9ANz/yzzYOJrdl6JlhitRlSkzpnzf4syVxVif0yTfYXgiaPmdY7FX/UMZfIcWAKCgwUN+R2lQZMDFJR5mmqt4W7OcPv5/yvyozqhDmrshF8lC57JxwJh6iZ4lj6OwllbJA8K5Ou3MmXVe6GHu6MLBjpqMDuXqpoZAvmfBxJTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717006975; c=relaxed/simple;
	bh=ntudmTr0f0KUp+6FCK0g5TA8csrP3Q4WvtZlhuq8biA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eAnDfFO5o6fL/vaJvHp573b/wrbwEY5lu3cpB/FtSs0ErXSpPQyNIu/PkZmRUQxGzkFwPvYrC348yK5ScdwPE6IgqIrIOdQpC9VsrLr4xMOTQmtlq3ULSYbCx5r/Tj5C058Tm+22x3PIJtFCZRmQK6MwZCQTXSHff3OAq4Pyc6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dj46En84; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJ6Bpsn6RJ5bZNmnetGoA+F9ZP/bH5fYqUE2ggZnAqKECitRtZkKP0e7W/FZVRIR/NpxErMCrb03jB1qC07tBsmHxRFV267/xnbd0p5bwV7mNlhZmY8PFZAhkL3lAzk5fdhv629QsuyHqBeAbsWLgRqtgVlXgvPXpc9OnWU//R/3HPcBB+UVD4R4V/zInLi2nCYD6FtWIYIC9bYV9zlBGz3QUOcUUVKyVHbo95zh1Xtd5AZlzyOTUQioXomZnCPO5EG9HUkRVzzq/VbFJjDHx5NewwGnnYfiGcrpaD4gLag1TkJ658rnck/JG00NlzjtPDF0Zg0rxI0FdiuvYuva4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPFBf2m9En90utHjWIEh30mYb6xq4feGJ/pDEgc+VHs=;
 b=mbq96CE/Hp7xFnq1GIgXtGAfwUJYMSHc7MtFyN+tuV6Bt7axfoBMzoKXBnIva1rBGoa1BweZB3ytj16C0XnRxbeRDdBOlFzqBs+oR036q/qUdLQXZFEiNLwRQBXiKBHebwP7jPDzkDygPClGiQdbgaJB/Aipk8yZ7YmdjRj2IzXTIeYa9pIyALKelq1UmBuKzqjf9fprrw6mUA8FRc5ss46HpRuDqbUlNrpu+Ag3JOa3vGwjVxQnAIVXBJdwscLKA0nDosJsm7WMTb1cRKLV2ZO7V7XQqlfPb5Txt8FAtsHtT39n1EqyIsnypcHcx5jhDq3Q4ZOT/ijuPrsYr5HLBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPFBf2m9En90utHjWIEh30mYb6xq4feGJ/pDEgc+VHs=;
 b=Dj46En84iWvLrT58JvHiHB0LEE1+IPPI6fXMmF0vYjtxPzHWUmevK44PFo8LvMLvMSb4n2IU2V8bYo5zpPcDUxSz7n7HvUD79MBh108bQ8zJwecz7fhCYh6b7PbYa2gYLHLrewWUjvc57BAtU6OhfaEN3NQVDYFj7iZxQfHvOec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by CH3PR12MB7665.namprd12.prod.outlook.com (2603:10b6:610:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 29 May
 2024 18:22:51 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::5a16:a4db:8bed:1f5d]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::5a16:a4db:8bed:1f5d%5]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 18:22:51 +0000
Message-ID: <f3474dd2-170b-4471-84ae-de3e9f1cf8ba@amd.com>
Date: Wed, 29 May 2024 13:22:48 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] mailbox: zynqmp-ipi: drop irq_to_desc() call
To: Arnd Bergmann <arnd@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Saeed Nowshadi <saeed.nowshadi@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ben Levinsky <ben.levinsky@amd.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Rob Herring
 <robh@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240528120246.3313723-1-arnd@kernel.org>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <20240528120246.3313723-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR07CA0025.namprd07.prod.outlook.com
 (2603:10b6:408:ac::38) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|CH3PR12MB7665:EE_
X-MS-Office365-Filtering-Correlation-Id: b1bb09f2-4a8e-4ed9-d2a5-08dc800c597d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjFsUHhYSGdIL21kTVlvemQ4bFBMYVFxWi81QnM4WElHUlcxNXB4MDhsTW5C?=
 =?utf-8?B?ZkdjRDJ0b1k1ckw0ODZITXIzVnFmZEM0S2FpTlMzbUVEaW9NRGZvT1hwa0E2?=
 =?utf-8?B?RFM2K3dFYk1HVUNERGgvZEsxNmdDSGNwS3hzUDBDSzU1aS9sVXoxWFk2ZWJq?=
 =?utf-8?B?SEJVZzh4YTMwSElPbDd3TW11SC9DMDJxVUNKNzNNblplcEo5eWpYMyt5WTA5?=
 =?utf-8?B?cHphU2thWHNKeEtua1VxMFphMFhFSUt3cW5wU2pnYVFXUGtEQUlmRTBvTlBn?=
 =?utf-8?B?UG03ejFpbkl5UlVLeFJqNUZuRDhUOEJ4Nm9rREEycGxDR2s0QlByWFZMN0tq?=
 =?utf-8?B?cm82bXV1dGJTZkJVUlVwZ0paVjA2VVNPNTlpc2p0MjkrMEVRYXNTaGxzVHBG?=
 =?utf-8?B?dDMreWw4cUhsK0pseHc5WUdNVWsxSW1wRkhNYVNqYUFlVTQ5VUlSYjQrMy9B?=
 =?utf-8?B?dkpnRUxIL2l6TE1QbGkwNElXTVl4alA4RG5QTnEzdnVvM1ptakFkYitMcHZZ?=
 =?utf-8?B?NkMrMnJDLzgyLzJCWG1ORlRPY0RxdHpNdmNGYlIyZHdZbHhIbG9qK0tDNm5t?=
 =?utf-8?B?Y2xvK3NaZ2FwalJUdU55Y2hxQmh3SDNVbEg3UVFYZXBadmxlciswZFFkYy95?=
 =?utf-8?B?My9GZTU0WktQbWlBdWI1dlVLczdYcE82THBOQVZ3OHBPWitRaDRXSFE4WDFC?=
 =?utf-8?B?Zjcwb1RDNzNGUG9XQk9HSThOakk2NURhaS8yQXdFbzZBNTNHdHE4UW03Y1ZC?=
 =?utf-8?B?R294ZllnMW1abUxnSW1oZEVkUFlPNDBWcGJYRXk1emU2TFo5b2FTZlBJRG9i?=
 =?utf-8?B?VGJOUW5TVUNHNm82d2pjNmZHQU9uejNBdG05NFdPMjN1bHc5cWp3M1FtbytD?=
 =?utf-8?B?cUNWZTdWOXFmSjFIa1dyVy9DM2oyaEIwMis2Vkwxd0cyR1NEZXlkZGNFV3Fk?=
 =?utf-8?B?Qzc2UitYMGwxRWdpaTJIYllmRUtiYUhrUzR6L2xldGM3YTkwajVtNmFJd1E3?=
 =?utf-8?B?dk1wSGFaZitiYUo2eGxoaDZEdklCMHpZTGo4dG54WHVjNXRQVGdQUXdOYUNw?=
 =?utf-8?B?U0ZnZjVsZmdsYW85dVd4VjFwRGF3TkVYRmlFS0d3Q2VMdnQxRHlxQ2VRNDdo?=
 =?utf-8?B?Yy9vNzkrSDE1d1FHaW9ITzRqUVhDQlJvQXdTdVViU1l6RUNjY3BaeHBTaFBQ?=
 =?utf-8?B?d3JZUmRrcG1NT2w1Vi85SGc0Lzg1UEFyVDdXaXIzK05xamYvR1puVTB2YVdq?=
 =?utf-8?B?ZjFFSHBIeVU1dXBDeThIS01mSkY3Q2p3UlJnaFd1eEQ1bmRXQjZ5am5sR0Fa?=
 =?utf-8?B?QWpLQ21XZVEycFhpRE1hNXc3ZHlBRWxhQ096MHM4aWI0K0xTWGpndzFkS0Fh?=
 =?utf-8?B?aHl5WWJ2ZzlBemE1VExjRFlvNWdTN2N6MjZBd25Ydy84T2hTNmQ4V3pyT1pt?=
 =?utf-8?B?b2VHZlVtYzhWekovend5ZHQ4U3ZYTW9Ya1c1dFBVckFtMXEvbkdibFlsdFRz?=
 =?utf-8?B?bWd2MmN1VHpibjlORDBsTGEvWStZakxRc1lwNXVBcXJDcW9TVk03RmIySzNq?=
 =?utf-8?B?T3pJb1YxckNkMVZuOVlDOW1YamlaTGZkaENDT0VYNW8zM3VIMmJBOUFNVU02?=
 =?utf-8?B?TzVqdzhWVkpqaUxRbndaQ01HT2FXTVFiU0ljN3FOR2ptLzdiVDNabVd5cEpO?=
 =?utf-8?B?RmpWY3JFZk92WFl5VWRzOE41WWRkb2syTHo1Wjg3NFpCbW5YOTVFVmhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUJsTDA5NUZSc1g5b2pBbkJBai9FbkdaOVBEalMvcHkxb3pINUV3T2wvTDAx?=
 =?utf-8?B?SjZBRVplVG5wU3NXdllEUStvK2VJWURiaXRPTldpbTJpeW5ETWY1cWdyaW9w?=
 =?utf-8?B?dmQ2MFZqZGNWU21nOWk4TmdyeEVYS0wvQU1oUlZVUGtEMCt4aGIzTXRmejk3?=
 =?utf-8?B?Z21hR0VPQytmR3dtOENTTXk3MW1DM0o0Y0FOeXRhaldrNVVHZjBKblQ2MkN5?=
 =?utf-8?B?TFViQ3dxd0dyVG1abVE5K05sQWlwQWdFM1QybG5qd0lzUWtQL2VTUlRRYWNm?=
 =?utf-8?B?WUlsVG0vT0JtQktVSWE3RTdxZVlHZU55MUkySWFNYWptU1lDS09OSUFNQm1Q?=
 =?utf-8?B?ZzRtWDQ1bCtwVXQ0ZWNoUUdkK2h1M2cvOVd1VVl2Smx4UzZZREhmcXozTWdt?=
 =?utf-8?B?dWxFaTI2QUdDQ2xiNmE3UDhuNVpRT25CMmlGZWpKZCtham4vZC9hcnpoRXBl?=
 =?utf-8?B?WHQzeDY0KzdXR21rZDdPemxRcU9IVVBpVFBzYysyRDhnQWRka0lHN1l2ZjNx?=
 =?utf-8?B?UGlXdTB2U001OVBZT2dsZDBWUE1vY0F6MzNSUTZ2c3lNczlVbUtWUEl1RXRV?=
 =?utf-8?B?M3NMS3Zobnk3bTFWZG5HY1c0cEkySngrTWZ1UE9PUjdWZlJCaUFiSkY4ei92?=
 =?utf-8?B?NlVTVlJ0cldudXJWQ0xjNDh6S1lZVWxhbDdNNms0cVVvTDUrSjFNdS9SZ2s4?=
 =?utf-8?B?NkNrOCtlMDFLbFZYWklBenVBTENiRFFoNkZsOExEekJ5NlJkN2FJWjFMY2lF?=
 =?utf-8?B?QktHOHBVZndyUHd2ek1ZSXNsY05nT3dKdzFrbWwzcENENXlLdzh5QVp0R1ov?=
 =?utf-8?B?bVBvRFNTcWZ3bGtGbnp3UWQxT3E3bkZUUzc1Zlg0bTBUK0lMbm83cmFZc2Vn?=
 =?utf-8?B?RjQ5OWJwYXpvYkdzU3JhWWpMQXc0VmVUbGtDSTY0a0wvTDZnMk9OeC90Qk15?=
 =?utf-8?B?azUzRUIxKzRPTE9sT2VXcXdFVUFwR2NuK0tCR1NQM1VOd1VHN2o5T1pEYm85?=
 =?utf-8?B?U2dIc2JwR1liZTlLYTZyWWhkbEFNc25wN0FBMTlGamlsWXB5KzFkSHVvM0I4?=
 =?utf-8?B?S0J0U2grMC9FQ3VINGhseTc0UVM1c0NwU2E2MlY3bGRhZGczc1dLZmhvN3dr?=
 =?utf-8?B?YWxuSjYrZFgrekFyR2N3a05iZW9rNkozZlRNYmtmNFBwS1djVm11ZDBtS28x?=
 =?utf-8?B?TXBZeDJxRU9KV0RxdXM3UjlZN1c4L0JyUzh4aTd1dTNucEx2K3FzWUF0VktK?=
 =?utf-8?B?c015S2twOWoxZ1VqeGpST1RFQ1BSdTBuVHo0MWIrZVhzOXVCVWJLUjBseFdu?=
 =?utf-8?B?eDlka09KZUtkRU02Y2VaN1JMRW5VcHF3anBPUC9zcTE4Vmh3eDhKUy9NZDdT?=
 =?utf-8?B?ay9ROVdVNGZsTnBPTkJtNFJrMmN3RDI0U3Jka3BldWZNY0tMYUdKbFc5T0N2?=
 =?utf-8?B?eklJQzl5WGVjZU1VNmVWcW5lUzlObXdNMUxvMVk3dXRzMnBzbXlpSTNDdU95?=
 =?utf-8?B?OGdNSndGWlNKRGNzSHhSa1VXVTJmYmtCM0I0NmxXWS9SK04ycU1qN09iM2lO?=
 =?utf-8?B?dGNsL2JlY0NWYXl2bkp1dWsvU1ZMeDU2THJhYkZFTjFxRmt1NGo2anhlWFZN?=
 =?utf-8?B?Q3hHVENob1pET2dieTJMVDYrUURHM1VZREw3S21CZ0dLU216ZEVSZmptMTRS?=
 =?utf-8?B?YnFPcjFFNVUrZ3NlNTl4VG1zVnJhR1h4aElsaFZIMG1Rd2xIMk1tRUpENTBu?=
 =?utf-8?B?QVJCNGltaU1UcTBrRXZ5QTNjaDlKaDF5ampFdS8zZU9IU3dhQURwN21wQk81?=
 =?utf-8?B?UEE3VTZaRGkzYVdQMjI1RDVWeVU4dXl6Vk1CZTlNZTc3M29LVC84K011T0RM?=
 =?utf-8?B?VDZCM2RsNmptc2VWTVhlNm03eUlUMlFGWGRlNHo2NkY1ODBsNkdISUVDNEww?=
 =?utf-8?B?d01mcHMwVThUZ2Q2U1FNYUVBR2tuRFMzUzRnNTVEYkVIbDFuTFJzc0lIKzAy?=
 =?utf-8?B?TitrTVlmVDF3NDUrYWUzMGpCQmxGdVA2b0FQZUQ3MGhNL2FRZ085d3Ewd0tK?=
 =?utf-8?B?TmVUQkpieHZYT2czcnFoc3M0OEUyenl6NFc3ZXZVM1g2SkVaVzdsNktvRjVR?=
 =?utf-8?Q?uMp+ORN8jKULgvu56t7MJYSli?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1bb09f2-4a8e-4ed9-d2a5-08dc800c597d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 18:22:51.0477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yz1mdzqOxNz5NK+QmK3XZy/36c69UvGZmGMrfDYuxfj1Z1s5J4BmQSusZQTtH6uV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7665

Hello Arnd,

Thanks for your patch.
I am okay to remove it. I will test this and provide TB.

Thanks,
Tanmay

On 5/28/24 7:02 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> irq_to_desc() is not exported to loadable modules, so this driver now
> fails to link in some configurations:
> 
> ERROR: modpost: "irq_to_desc" [drivers/mailbox/zynqmp-ipi-mailbox.ko] undefined!
> 
> I can't see a purpose for this call, since the return value is unused
> and probably left over from some code refactoring.
> 
> Address the link failure by just removing the line.
> 
> Fixes: 6ffb1635341b ("mailbox: zynqmp: handle SGI for shared IPI")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mailbox/zynqmp-ipi-mailbox.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
> index 7c90bac3de21..4acf5612487c 100644
> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
> @@ -850,7 +850,6 @@ static int xlnx_mbox_init_sgi(struct platform_device *pdev,
>  		return ret;
>  	}
>  
> -	irq_to_desc(pdata->virq_sgi);
>  	irq_set_status_flags(pdata->virq_sgi, IRQ_PER_CPU);
>  
>  	/* Setup function for the CPU hot-plug cases */


