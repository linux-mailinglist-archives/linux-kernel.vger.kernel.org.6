Return-Path: <linux-kernel+bounces-297874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFB395BEC2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E54A1C22C83
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B311D04AD;
	Thu, 22 Aug 2024 19:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IqCVPIxP"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FE9101C8;
	Thu, 22 Aug 2024 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354481; cv=fail; b=ssK6za6zRL+p8YRa238er6+2Ec8j0QsMCrqnSP7WLrTtJ8ZrNEARPVOifrA6d8JT/6AYMB9Pzkv8E3p4P6/7f+ODRWL/zp/ex/9qp7hgZRTnI73K/Ea/KxKli4KHUEL26B7zDmPPdMta9PnBzu1/8QFYX/mCaR21aqeEO0aQRv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354481; c=relaxed/simple;
	bh=jDkITTGdUrZ894t0TRKXTmMJe7aEA44RGlSdMENoIpU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ihOjVHpxOC2BfiT1cmaSAeYIimYV/oEgW/NimDQCt7qW0ysKfdyNS0H68NT2IhQFsq+jQ1CSaxNOtGs4XrylGMYBa1LZOJfi+mrO6q9TkB84LP41S7HrbVzG1imbnJQV/FehYdk0+y0eiMwVDNGTIlp56/rzgObSUsoZz90D4fY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IqCVPIxP; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kp5gDh0YbyICubq6BfVaavIbMVQaU9BKjxr8OQ6bCu48IMyAFNV4SjpHsGKT03jeu6IgQq/aAgWXY3YkiQvP9dNiRXpk/UgEaxOpJSQrCRw9J680IsqKayNGzC62HIO5KKGGkRS169f+Dy7bK3w83WNfa6l9BAfE9LKGMsOOvwLQwvPRvVLsTgGWghFNyCMdS4hbCfTPz+PIimL9gZs48e6jVhDnBUbzL19KTPZPi1aeXQqW861NNmwIbHRlziDtpfeKwe5vZ4YHJah1rMI6vuVVKMft7hRu/yP9u+SJ5ejXieHD0qGs7KQlhycBjfrD4C2BxQs5xNEiiAHz5BI/0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1osRb+qfSbGntU01Au/S8nMz78hApQqSDLe/yaUWPak=;
 b=lT966eQibcf6JMISkSVK0/0G56DKI3Ull2S7JQ5/y4dh1pJNXwE9unYzxYO/6WxRPTGZIbsj/dEWaUWvHJiRkcddZ6vvTvDJ8M53dg1q4Y7BCN+/zVhzLnbhSB16jSSVq7fWCntG/yNm/UpY/mLCLCNkP2fZIEFAZk0drp9FWwOGQZcl7edZ8WPuvK3xFJxROIP9U+BST+yZwz4byVWCkb04m68th2ZiQDcA9Bt/Q+E8r5IMVEFYlla+cLi3ixbBZ3wzbyzizw/4ibqQ/Sz0ROfR4WlRjXScXPDy/6xK0lS65KxUdI6xToZrl7HLYKRkN/1aGKjsxSJwo4OwsBzeHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1osRb+qfSbGntU01Au/S8nMz78hApQqSDLe/yaUWPak=;
 b=IqCVPIxPQ6OKT34wjGvg/tp6T+mS6wsS+xYuekINGn9EkeD3nxcZ5knSGv7kijJ4Kd7CTu/wZDeYoi42BNgPxDkeag1A+GySd3sycHJbw9eU02nKCRmlr3ppVnl5HHqGV9Ik2ogfze/Yu1hZPTcURRZzxfjnMoXf+C7AHyoiCHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA3PR12MB9225.namprd12.prod.outlook.com (2603:10b6:806:39e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 19:21:17 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Thu, 22 Aug 2024
 19:21:16 +0000
Message-ID: <43594a1c-c0dd-4ae1-b2c4-f5198e3fe951@amd.com>
Date: Thu, 22 Aug 2024 14:21:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Put XHCI controllers into D3 at S4/S5
To: Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Mario Limonciello <superm1@kernel.org>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, mika.westerberg@linux.intel.com
References: <20240712185418.937087-1-superm1@kernel.org>
 <789f9bc0-45f4-4602-9f8c-c286fa7b922b@kernel.org>
 <CAAd53p67SR+FrdRro7kmZJbYRXZHw2PToyi6gSJv6+8=jZkyyA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAAd53p67SR+FrdRro7kmZJbYRXZHw2PToyi6gSJv6+8=jZkyyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0118.namprd13.prod.outlook.com
 (2603:10b6:806:24::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA3PR12MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: a940b12d-6e27-443a-b5d2-08dcc2df983b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUp0SWdiTUF3TlUxT2pXWUpFKzkvVVN2Y1FUcTlDR21xNEx3OGQyUlBpMncw?=
 =?utf-8?B?NzZSZEVzUEV3SGMrMC8yc0twRWhueFBhWlkxUEJQL3M0L0N1aFJBTFpXWUdw?=
 =?utf-8?B?THoxeThaenU4RGZmbytVU2psbDZFMVhvOEN2bUhDMXFpdTUwbFBIaEdCVERn?=
 =?utf-8?B?NitHalhlTmxqZ1EzQjJwUHlNZmVpdDlIcHBOS2l1NmllR21uM0tyZWEyejds?=
 =?utf-8?B?aHl4ZTRBcm14MXhiOWQ2Y0wrVUFDOS80WjV2R2ZUTnBDL3pHZk1mYVU1em5z?=
 =?utf-8?B?WnQwYmxJVUdrUldJSm85OXRFYU9wZUh1cElPTEdwWGJBdGJRUWUwdXdGU3hG?=
 =?utf-8?B?ZHUxYnd2WnZxS28ya2w1QlZUbTNnY0Mrd3cxbVNlM3lCYkUzd292RkJwVDZq?=
 =?utf-8?B?NnBpc1hQQm9oYkRXNHhrZXFNK3lBTXpSUmtESkF3b1MzbjNoRnJTWTgxY1hm?=
 =?utf-8?B?dTVYSFRkUnpoanlTNytHcFVMcnNtcGFxNkRyeEdlbzJaREY4M2J4NkhocHdu?=
 =?utf-8?B?dS9lZmZtUE14Y0lad1hzR2h3ZlhkQWxJMzZES09BOHZaUWxwQ3VKbmJMbDFJ?=
 =?utf-8?B?ZEUydnlwZGVpMGsrOVJSNTBQQ2ViS3RMajhTZ1FJazVzZW9SK0p3VWJGcU5t?=
 =?utf-8?B?bUtMSWJxN2NYTzRWZm5ubmVKTEQzSlN1Vk5FcmdELytjZEJRU3BEdGhtVkgy?=
 =?utf-8?B?ZFNNQ3FqYUtQUUhPeTMvYjhnN1BWMEdOSmJZazdUUm5uYVNNNWp4VzhvWGJz?=
 =?utf-8?B?bWU3SjBpWHEydDVCRm5GcGROUTBJRS9yZmxTNDAweGtZdXNuak95WFRXeTZ4?=
 =?utf-8?B?M1BNcXoyREJweFRNNFpqdW5VbkJ4Z3NlYkVCRzBOWjdFV3pnQUNWcnF6UTlt?=
 =?utf-8?B?eDYyaWlHL3hHTzBPQ0xOWHFTMmhTOVZ2UXRrcVl0OXB3QzZuNzFXN1VRY1F1?=
 =?utf-8?B?MUlQTHNod0FlUlhJQjJmZTBCZTdSRnB0dzM2K0loZTJkdjV1c1Y0R0dZN2Vk?=
 =?utf-8?B?UE84REZRTkwvUFhJZG5lUElVSjVJdVM5NDNWZmp1QlpwMkZkbzFSWE1kNTU5?=
 =?utf-8?B?S2RSY3ljc0NCZTRoc1NLVnkvaWdGYUthZTF0QXQxblNFcThRU0YxSnNvMUJG?=
 =?utf-8?B?Vm91WWxpaGFnSWlCWmowNVB0Zzh3RTBvYThwS1Jta1NlSkhkcXBMSWRKUG9q?=
 =?utf-8?B?V2Z2bmMwWlNVWW9xSENacVB2OVRCMVdGT21Xa096ZFkzNHZ4Ym5NRUFSdXpq?=
 =?utf-8?B?USsxbHZzYlFsT3N6enFzUHBPYjRURERaSFVoQjlZZ2tTSFlwSnhjaWJqaEpR?=
 =?utf-8?B?YnE2Z3puVjdzQWdlU2RuNjZpTVZiNGdnVGRJOWtGd1dmZHZlL2hSeXYvWkV0?=
 =?utf-8?B?NWhWUGtMMWJwRjBaekNRUWx5RmFuL0VQVy9Cb25od3hBUS9YRFJKNkF0VnJG?=
 =?utf-8?B?alFMQnMrYURpUUhyZmdYRWhSQ1ZCTEhLUlRHbVNIK0hhd1BYcVQ5UmZKMnpH?=
 =?utf-8?B?WW5KenkwbkkySktKV0hncmdJSmFmTXFyaU93UC9kYS9OV2YyNHJSUUpYaUNq?=
 =?utf-8?B?QU9lM2gyOWdJWjhDdXY2WnB2MFhIaC9neS9GWklFUE1aNWMrbGo2YnI2Uk9o?=
 =?utf-8?B?eUVHejAwcDEybVZ4enFiT0pQRzRzbWI2TlVCaUhlNXlXWjhlSEdiUXFHaHpa?=
 =?utf-8?B?ZDgwTm1tNVVzQVhaaThSRzZZRzVFbHE1UEZkYTRsWldYUURGVExhRk1MNGhC?=
 =?utf-8?Q?dziMjp067YDaR212wD+lysU0IndNF4LwZzxhTw+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTVoTVRKcEFiQUxDbitVYWcxTmY5MjhhaExJMU5oa1pkY1gxY3lON3VTVVVZ?=
 =?utf-8?B?V2l4M2xBVGg2V29rMHNJV3lsOVBUY2RoalNDblJRMmZkVGJ0Sm1xQUpOUmgx?=
 =?utf-8?B?MWMxajdkRVRLVDN5dVVtYWEzRFE3MG9lZUY5OUd3MVhTZUtXeDVzUFY4SGNT?=
 =?utf-8?B?RFdxdVBkbWRSRDg1MnFHV1lieTYzVUloQnd4QW5pcFkyMUhKejdDaTM4dEth?=
 =?utf-8?B?V2NubW81SUVJRmg2cnd6R24yRm43amhGRHBaQTZ2Ym1IVkxXR3A2SUk5VlVy?=
 =?utf-8?B?S1NTd2M2a2tabjZBT3czOTl2WDMwUHB2YnZYQ2ZJUm00WmFua2xTcnRkc2NY?=
 =?utf-8?B?NG1MVFNzQU5PV0Y1WTZwN1JlODV6MDlmQjhCYS9MVDNaM3hNSnZqVVc1OWQ4?=
 =?utf-8?B?SWp5VUJEcHN3REkya1NPc2ZlYStXQlFOc1pWb0NVVW1tOE1VRzArQUJ6RHlV?=
 =?utf-8?B?Y2hVbmhwYkdnVnN2dWhYT1IycDl0bnc3UGJKZ3pRb045RVgydUkxL0QzT2xw?=
 =?utf-8?B?RTFSWHRGankxUmlBWWVXSSt0Rko0cnZPMW43VTFHWkk4TC9QN2RDdmdBRCtX?=
 =?utf-8?B?RVJiQnkrYnZKWVBLZUJCa0VXWXVaVktSVDZXM05pWjJMWngyTnk3Yzk5QVFt?=
 =?utf-8?B?NXpaZjh0Tlg5MVlNTVEvZUtWaytsdE55N3E1SFI4UTFBK00wTVkwbW1EYTNn?=
 =?utf-8?B?STcrUElveUFLRklWY0oydEs1S2VrTmlhRWJXYm9KOS9wVlhWK0o2b3RqZzB4?=
 =?utf-8?B?ZTd1OGNFNForalVTNC94ZXQ2eXd3RElwT093M0ZiWFN1emZWYVVhN2xnU1g3?=
 =?utf-8?B?UnE0Zi93NzN6UmRJcXFxbXY1RE1rK0MxbkZub1FmVjI4NE1wbkFmUWUvWDZt?=
 =?utf-8?B?QmVGcWp2OUVaM0I3am1UWU90c25sUm5mZ05nZmNZamc0V2pYREIrSDY3bC9v?=
 =?utf-8?B?cFdRR1dyem85VUxydnlDbm9Xb0wxSG5RZ3pYRDV1SXNuMkdGQnR4U2NJZ09m?=
 =?utf-8?B?RjJaZy9xMFFycmVEa0IrOTlrZW4wb2Y4cE5DVXdUdlBHZ3VDSFF4bXZOQTk1?=
 =?utf-8?B?aGZTbGhGVldrQ2RzZVV5REdsZ2tudXpwTzBPMjcyYUNPNmZDVFM0L0dXZW90?=
 =?utf-8?B?ejRRaTVHQlA5OFNBejBVb2pZbnVKZE1hYURuTS9WYkFJUzZKQTNpWi9LSldq?=
 =?utf-8?B?bjcxWlAzd0dZQTlhbDBLVVIrY2t0ZEhFczVDdjc3RGNxMEQyVGROK3VRU2F4?=
 =?utf-8?B?NDY3K21yNjNTaWMzRXlDMGpVUVB4OEw2dloxV1JHRVY0eDBqRk9mR3FvSGs2?=
 =?utf-8?B?dGlDUk56QmNXanB5UDlYb3lWc1B4MzEzZi9vUmVzZFkySktKdTJ2cjVWQ1RP?=
 =?utf-8?B?RlpCVEpqV0ZNWmZjelBCdmdUTlBBYWdVNTFEZWZLRTVnRHFnL0NtYmlwRnJ6?=
 =?utf-8?B?dFA5L21JdExqclV4VGFqU2N4Mlh1Q1ZLVmV0anhkZ1hWOFdYLytHc2h6aVN4?=
 =?utf-8?B?eFd5NWR5ZVdwclpWbEFFWUM5MDR1M29FM2o4TWRnTHA4ejBMMXJJSTMvMVlX?=
 =?utf-8?B?U1RJeWRVdGtnOS9CNWJCVDhlUDJ5ODQ1SnhnUFdTcEZYZkVaeStOK0tRT1E0?=
 =?utf-8?B?b0tkS1d6Nm91eVlYeDB6bllUazE2ZWZqY0ZHdjRJbjYrcFNtZjVjS2hXUFJF?=
 =?utf-8?B?Q0ZQSnVnOEZKSzA1RVVyTkFkMHY2b1Y4d0pYVlhiU1dEZUN6cG8zQysweTB4?=
 =?utf-8?B?VmJMVDQvNTFseW1HSXZZSlhDWjlSb1Jmam5VaW45cnNkbTlJTXRhVXVBM2lG?=
 =?utf-8?B?WGREcTlwWWxQY1dnQkczWEJ3R0ozOWFiejd3bjBzSUZSNHZwYXR6eFF4NnhP?=
 =?utf-8?B?NitmbiswMjA4RFFFNDFMSm0zT2VxYTVOYTRhL2hmQXd5Umd3RkdqWXpOK0xL?=
 =?utf-8?B?RGFZRG95eHQzMTFpUUFlZGgrWDVsL0tnYTBFWGxpbEdNakxnYTFDNEI3MkJO?=
 =?utf-8?B?RE5LTjI0RWFSL2d1UWprZEtMQnUwUjVtSFBlS3hWekFrL0pYY1ZLT29HbTkx?=
 =?utf-8?B?SlFNb0pjRWNXNjMzM2hYOE1JczRlaUIxNVdJNnBLYzV3dDdhRXVrQ1lwUzhT?=
 =?utf-8?Q?Cs+TmXx5qinXJf30AvtCtO3zf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a940b12d-6e27-443a-b5d2-08dcc2df983b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:21:16.8830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rnLoe8jb2PyLmfMQzpiDMi6lYHixxsAmpOJ9j2Zp5VO2Gi416MQDPij2Pl/mRi7mDodonOxJCEk0wjHYHao9Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9225

On 8/22/2024 02:15, Kai-Heng Feng wrote:
> Hi Mario,
> 
> On Tue, Aug 20, 2024 at 10:06 AM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> On 7/12/24 13:54, superm1@kernel.org wrote:
>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> When the system is put into S4 or S5 XHCI controllers remain in D0.  This
>>> causes higher power consumption and may compromise energy certifications.
>>> Consequently some systems consume more power in S5 than s0i3.
>>>
>>> This affects all PCIe devices, but looking at breakdowns XHCI is the
>>> biggest offender for power consumption.
>>>
>>> This series checks if any wakeups are needed and puts controllers into D3
>>> if no wakeup necessary.
>>>
>>> This series is a spiritual successor to [1] which aimed to do this more
>>> generally in PCI.  It also accomplishes similar goals as [2], but aims for
>>> both S4 and S5.
>>>
>>> [1] https://lore.kernel.org/linux-pci/20231213182656.6165-1-mario.limonciello@amd.com/#t
>>> [2] https://lore.kernel.org/linux-pci/9d2f1619-1c61-4e8c-b28d-d4eddefa45c3@amd.com/T/
>>>
>>> Mario Limonciello (2):
>>>     xhci: pci: If no ports have wakeup enabled then disable PCI device at
>>>       S4
>>>     xhci: pci: Put XHCI controllers into D3hot at shutdown
>>>
>>>    drivers/usb/host/xhci-pci.c | 17 +++++++++++------
>>>    1 file changed, 11 insertions(+), 6 deletions(-)
>>>
>>
>> Hello,
>>
>> Any feedback for this series?
> 
> Does commit 0fab972eef49 ("drivers: core: Detach device from power
> domain on shutdown") work for your case?
> The commit was reverted because it regressed some DT based devices,
> but probably still worth doing for ACPI based systems.
> 
> Kai-Heng
> 
>>
>> Thanks,

Thanks for pointing that out and Mathias thanks for the comments.  I've 
spent some time today looking at the different permutations of patches 
to see what happens at shutdown to devices.

These are all the patches I tested (in various combinations)

Baseline: 6.11-rc4
FS: 6.11-rc4 + 0fab972eef49
ML: 6.11-rc4 + this series
KH: 6.11-rc4 + 
https://lore.kernel.org/linux-pci/9d2f1619-1c61-4e8c-b28d-d4eddefa45c3@amd.com/T/#md69ca96133ae0191eefb2f7f5003ce9cc180ec76

The results are available here (in markdown):
https://gist.github.com/superm1/f8f81e52f5b1d55b64493fdaec38e31c

It seems to me:
* FS didn't change anything
* ML only affects the XHCI controllers (into D3 at S5).
* KH in any combination is the best

Considering this I will scrap this patch series and I will leave a 
comment your patch KH.  Hope we can get that in, it's great.

Thanks!

