Return-Path: <linux-kernel+bounces-321283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE279716E9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B10B1C227FE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5B6176AD4;
	Mon,  9 Sep 2024 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="YFWZ1WLA"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2042.outbound.protection.outlook.com [40.107.103.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423D142A81
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 11:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725881475; cv=fail; b=TLJLiYn4+HGc5pwGo2au8IxxXtxjRclS2R4adkg5a8Oe5kdaUKXXxirW1DlD1FBs2oX4/ON/p9PRCzoeamOatzASZhMbmMavO0lIxDPFmSRjKuU1AGa7zQ353LiOfDgOUtGKxSL7+e/jf4d1yGo9f9udv2H0b0l3eKU9RqDhBjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725881475; c=relaxed/simple;
	bh=9IQN3/oANajqHDUQJKkey7WGDnVNtfkrxch7NnERBDo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l0XodLaFuMPRoHlSPLfGnuZoEktjqzLLuF2ZJzT1+7scIL/UZiYXTTtYebtWWq5jnVntDZT26caNHVeHnpWH6Z4nIG6UDt7LTisxAR8DuvWD+EhFTBJ3W+Ehvidabu/viUq1l0pThlcclKHGsJ8pl5TaO8keo0/WiTfYH4a74/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=YFWZ1WLA; arc=fail smtp.client-ip=40.107.103.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0S1BvRqTgy5o7OjpubofvDGxuboe8Uwq7lgekjn5wmV+Iw2AmvoAdIu+2hxe495beg01B/MH8GQWX7Rit+tWSY/8oaHTImPaoeDvUWPCJOjby2HGt8NAz6j2n2Dj8GdqZCE2Znsp5HgBmfGh8MIWMzlwnjzKJm1tr1dJ7V9ZUc5eDrg+8JqPFxxEQ3DDH4j5A8Eh0Czp2HVGeeqd+P/P9gouhzEaG3L5sW6/hdeGtu8W5ItXocOkG7Ix6al7EWvBOsELnIVOwa7xoaddCj1VaWFN6z1/Ki2qxljpoRm0+hHRyJEQfUIHEB1UBAEvevlAWas3oYM+71YNqsW5CdzxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yo0qjp63B2tBZp6cwVYzqKp/jHSLG7wSkz2hrYf6wxM=;
 b=GutqG8clzx3i5LDErid+yEbcKMQE2IbizAbZX899yo8eqjj11hUBenUJCWBAQZSpi3U8BSMQnXaEH0N4oW5qjM8OQ8NAHJRHbgZR0KMYwy1m5TM1gspEXwc7dG6EG2oc4ogAlHX4aH50Shr6+6gKiE/5IBNl/CaF6OoA/ootHcgTYf0xOqDwB0wwQWUGF+3lRbuzt3y7H+Aro7nHeMx47azYDMvXFPW6nAc6eYHtUHGhSVNWXnFmzQXps1B910qKjmI+zhLd3xwY2VNxCoIRWT0fMoioWPPQpzdr/NPl/4pIxMRSMPsGTNu9B2FHlloaEYRfYTFjW0GlP0tJP0+BJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yo0qjp63B2tBZp6cwVYzqKp/jHSLG7wSkz2hrYf6wxM=;
 b=YFWZ1WLAEqQiz83iYQx7YZLMhd8uqZ0cqHg3N1blaqexQUaUT/WEw9PAtmKQECUXoTtco/7pwexg4FILnUiKBfE5Sf3Cc/srs0+dYErUNBFD8qxBo1wB/1h+zAcSLxpFktOGam7BgIa07TJYtOqIO5tGOLWOIM4/mrT8/GUVb3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from AS8PR02MB9529.eurprd02.prod.outlook.com (2603:10a6:20b:5a5::16)
 by AM7PR02MB6339.eurprd02.prod.outlook.com (2603:10a6:20b:1bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Mon, 9 Sep
 2024 11:31:07 +0000
Received: from AS8PR02MB9529.eurprd02.prod.outlook.com
 ([fe80::8927:53fe:9d2:cc22]) by AS8PR02MB9529.eurprd02.prod.outlook.com
 ([fe80::8927:53fe:9d2:cc22%7]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 11:31:07 +0000
Message-ID: <9bf76f5d-12a4-46ff-90d4-4a7f0f47c381@axis.com>
Date: Mon, 9 Sep 2024 13:31:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ubi: wl: Close down wear-leveling before nand is
 suspended
Content-Language: en-US
To: Zhihao Cheng <chengzhihao1@huawei.com>,
 =?UTF-8?Q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>,
 Richard Weinberger <richard@nod.at>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@axis.com
References: <20240907-ubi-wl-race-v1-1-6f7f5e0aea7b@axis.com>
 <10beabdf-17e2-8232-0ce9-1b3d1136f6bb@huawei.com>
From: =?UTF-8?Q?M=C3=A5rten_Lindahl?= <martenli@axis.com>
In-Reply-To: <10beabdf-17e2-8232-0ce9-1b3d1136f6bb@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7a::17) To AS8PR02MB9529.eurprd02.prod.outlook.com
 (2603:10a6:20b:5a5::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9529:EE_|AM7PR02MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: aa69c170-5d03-41ec-4e61-08dcd0c2e543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjFaeERsMlBNU09aUUZuTjFRSUhoUldkK2ZaempZeklBL0VEam5Ia3ZleWR1?=
 =?utf-8?B?TFRuY1R5RHhoeEVTQWcramszMktzR0JHNTZWekcrK3FpTUZjZUlUd1dIT1Vt?=
 =?utf-8?B?R01aWlZsaHR1azhIYjYzc3FUdG5kOU5ub01IS1RXOE1xMGtMd0dWdzUrMHRS?=
 =?utf-8?B?cEFDVldodzVSRFVKc3FYRk42cE5xOVo3bWZzV01xRHc1RkNCYnJSY0VSZXp2?=
 =?utf-8?B?cXN6eVZlM2Y0Qkx5amk5Mlprb0Y0YXl5L2hUQlNPZmtUTDlHaHNwcVR1d1hY?=
 =?utf-8?B?S3pjUFIwaXpVUkRRQVhrUkVKZ2FsZzIyRHRhL1hYcEtzSnc3dk5HdXRkSlRk?=
 =?utf-8?B?SWtjLzJPZGhpUGxPNTV1c1lLQnVxb3hrRkhwaHJmTFZkTnZGZEdMRm52MHc0?=
 =?utf-8?B?QnhRNDY2ZGpzbjJsN0NDdzlPMXl2RjYyOG50NGQvd0lYUnRHdjIwNUtBWkd0?=
 =?utf-8?B?V2l5TEVUUTZUVWwzMlZiWmplamRONFhLMi9YaU0rMElQVnN5b3FKVndhd1JC?=
 =?utf-8?B?a050cFkyNnJlclNzdURkNDByYWZ0VTI3ZWMvVEx6MzdnUFdaOWw3eFJrekFF?=
 =?utf-8?B?am5XSDZpZFJrL21MRS9kd1FWdXc4VExTSzlESnZWZlk3d2V1VDRpdkpWbmM2?=
 =?utf-8?B?YUgyaHhEaDhBNFVhVXQ3VEptcEJ2UWcrZWgxMjRpWWRRRmRGL2xkT1NPNWcw?=
 =?utf-8?B?NjBCeWVmTTF2bWxDSk1vaFd2UzBwOWNUWnVxQTNBZWl2VUFOdEVCK1BSQnlq?=
 =?utf-8?B?Q1NBOXlQbGtySEI1T1p5bkFVRHlreUN6Qi9uUFF6NHhNVFBuV3RCZlZuRTFu?=
 =?utf-8?B?bWZIalhVb2VyWFVBeXI5UEpNQUgxdnlXc01RdzhFSm1KZkhtSXRMMFIzVzIx?=
 =?utf-8?B?MEUyQkxlVVRyemtQbUwrK29YeFlhN25BOHQwVjFBK2ZjOGxwcytFS2FSQjJX?=
 =?utf-8?B?aUcxKzZKVGl0MFV1UVNoWitUcnY0UnJkY0dNd3c4eUZKVGJ3OUcrNS9PUlNL?=
 =?utf-8?B?bWptdjhXQXVBSWcyMTNQMVNnYnlzVFI5dWRrOWtUUnNCdDI4ZmtXWXh5WUJM?=
 =?utf-8?B?ZzNyL1g0RzZNMVdxV2h1N2V5aHFwR1c1VGZTREVMNGNrdGNzQllwcWQvZW5m?=
 =?utf-8?B?MzM3NndKRjNiakp1MDE1THB4Ymkwd3FDR2hENlVTMHBrUGRETFVLV2czamJ1?=
 =?utf-8?B?cGVTYkwvUE05NE1xVWJ0VmF0dGtYQ0NlSENSWkhjYjVvMGpmTE9JUDMvVFJV?=
 =?utf-8?B?dU9RZTN5bjM1b1UySnk1aTRGZ01DZUlON3hML3M5ZGFieWlVYklTWW1TanBp?=
 =?utf-8?B?QXVjS2k4MDBaWlJEWXNDTTFweGdsZDlETnZkbFlQZm0xUVBSYzhFbzBkR0RZ?=
 =?utf-8?B?REM1d0d0cE9leTRodVZ5bDZQdlhicVp6cXpsV1NKdFhJQmhHdDlqVFUrWHRs?=
 =?utf-8?B?QUdoSFdkVnFIMkZMOHcveUZycUg1bVh4MWNhVEJUVi93WDNadDM0TDdydWFY?=
 =?utf-8?B?R3ZYRk90U2xjakZWY2hseTUvOFBCWWwwRDZDek91Y0xDV29PZ1lFR043dmg0?=
 =?utf-8?B?UFpoTVhkQTNHWm9jdDRWdHc0TDhRbHcxbE5JdG1TTEx2QzFycDVFK1lsV2NE?=
 =?utf-8?B?WDNPMGJ1SVpacTJGMGFGZEF6SDZVYWN1M0ZoMnQzZFdpS2ZRRDl6QkMrNHFP?=
 =?utf-8?B?LzZtYm8zZmtXRm11eEhyVEhEcll1SER5K3luREZDMXhsVUsxYzg3dVZOc2sw?=
 =?utf-8?B?SHExa1BOYi9Nd3dPRHpBWGxVQWtDNXliQXRTTklXQ2FFWWpacG5vVTNydjM3?=
 =?utf-8?B?VnArL2sxZnNRcHl6UmhXUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9529.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDBydXRNNTZUY05nQVdNVWF6Uy8vQ1lyYXpJUit1SWREdTJXeTlqUk5kTnBj?=
 =?utf-8?B?QWVUc3ZqL0M3WG83MnE2OUYvSE9oMlRHZU5QSHFUbW5YNUN1N3h3UmZMZkU5?=
 =?utf-8?B?MllEZm1rQ3R3elhXT3lmeXM1S1JGUHNkM2FjbWFpZTZCWlgyRjF2TEFwM25n?=
 =?utf-8?B?WGg3Wnh3OTlGMDhLTFkxanFHK1FnTURzcEs1SFRlZUFEalR4OFU3R2Y0d1Vo?=
 =?utf-8?B?Z1pTYm9iVVBONGZFMXNrdkFybXZPREovQWxTUTM1TFV6M1duc1Y1ODRsSlRD?=
 =?utf-8?B?dGdJNE50VFdyc2NMVU9Zckc1Q3J2aHJjMTlnelVKOXRBZHF4WEtvN2QwM2xk?=
 =?utf-8?B?ci9WMElscHNmcVF4VlFrZVgyaW9yZmtmUHBWejhxY0tHZG9NSVNYamg1NlRj?=
 =?utf-8?B?NW9aK2lsUHd5cUZSNW1FUWNjOUVEYzAveGE2QS9mOEgyNy94Q2VZa01Ga2Ny?=
 =?utf-8?B?cDN4djVxb1FzUGo0WXRjcWFEOWo5aURpQVd0bDhlRVBSTkJHYXZ4MW9nbHV1?=
 =?utf-8?B?Q2l3Y25lRllWZkMzejhkd3pVTGMyek0rWmVqY2hNczhTZmJRRS9zWWpZUzls?=
 =?utf-8?B?UmNTZkY2ZHhnQlIrZk8rWTVkUHFTd0EzVVlTODFKZTB3bllLcmp1UXNsK242?=
 =?utf-8?B?a0dLakxDMHcydGtYMFJ2eU5Na09OYldJQTg0L3drY3R5OG94cS9UbnRzcGZW?=
 =?utf-8?B?WTdZQlN5TWdObmt0MXlnbHdzM3E1aEhFYTc2UVhIN0k3cGIrZWRzYjVuNk5n?=
 =?utf-8?B?czJVaE1CKzlRQ0VRN3haR2N2by8yZFROU21LVWtqdU9wMW5kcGNCTmQvTnVy?=
 =?utf-8?B?eEJQTGkzaTBYd1o1WnF4QWQwRTJzTVZDY3pTOHVIaUtaKzF3ZUVGNjZRZVRH?=
 =?utf-8?B?eEtyeWpYTm5xSWVrZElFYzdGSGVPU0tLK1ROSHExZFVFWDRPRnM4S0JoYWgr?=
 =?utf-8?B?MEp5eEpnUVZqUUo3QWNNZ0k0RTJ0dTVsQzZvWXNBMkh2UXEzMWFhMkQzTThP?=
 =?utf-8?B?Y3I3cVlOVm10ZWNyaHA2WmhjTXRsTy9GeDNRdGZ6N3dTb0tPb2ZsSTZKQlo5?=
 =?utf-8?B?Q05ycnBLOG9tNUEyQWtWejFmWGJUZ3dMcjQwWXFnOTY3UytZN3E0SmNOT2g1?=
 =?utf-8?B?Vk1nNUxmYjJZc21RYUJzS0FtV2dKWW5hcDJ6cjgrY2JQc21yRXRUczdIY0dH?=
 =?utf-8?B?UThPREpwam9BS3YwNFk4NlY1bFd4aUswMWY5UHp4eEJzUWRJUjdyQnJINWRP?=
 =?utf-8?B?UXo4T3RkVHhkU2UrcnlnY0s5VG1SOHdzMCtDc3I1VEZUM0pZblNuRmVMM08z?=
 =?utf-8?B?RksxYnZSaEtqcktUY0tjdWdlbnlzOTUxM2NWMC9EWnZPQytVYXdmOHpTQUZz?=
 =?utf-8?B?TUZ3RzhQamRMUVZWWVFublBua0JXZGdJRGRIWnF5bmFzN1JPOHFETUZhQjZm?=
 =?utf-8?B?a2RCYkNJaEpZdUpmbExCWjBKQmFTeWp2alF4T0dhNXM0UmlyRGZORUI5OEU1?=
 =?utf-8?B?RUhzeHUvcFJTZ2NQeVkzL2JZYksvMDl6Z1BRc0ZkUVZZZjlXaEZaRWtDbzha?=
 =?utf-8?B?RDJuRmpzRjZRRkg1NnZmeStKY1ZXaFYwQzZ0TXJ3aDczMkhmTmVBMDBOd28x?=
 =?utf-8?B?cEdOWUFRNFNZRlZqcUNUN0FTbEliTTh4NUNHbFpJZ3VvUG1ldmhBS0dnOUNq?=
 =?utf-8?B?REVDZDVvaW4zR05CL1JUTm0wOE4wWEFTUGZOalVEVHZnYjVma2ZFdmpmRnhX?=
 =?utf-8?B?aWM1OFZOdnNLbjgxN3NOdmNGa0lwWFhVQk1GakZXWkVSZmFaclhvcVNWRTdv?=
 =?utf-8?B?K1RmbE50WVdWdHRBeW0vTno3NUhSNElKMU9vYVFSVHVZZzhoamkrQmRNOFVQ?=
 =?utf-8?B?RzJZU2Eyb1M0ZGJKRjdOK2dYOEd1VytVOWw1MXJvaDd6MDl2bDdDNzkrM0N0?=
 =?utf-8?B?REhSUmtxbTZ2cjcwMHpwYjNQaHUzQTcxYkhERG1kQWE5UUFlc1Z0M1NYQzIz?=
 =?utf-8?B?OTJzdVlDM1FwaGQza3ZzcW5JVS83N3N0SUF2MlZvbjZxc2x5Z0lmeEJDVzRY?=
 =?utf-8?B?UDdjUUc1VUxIeHRWRGFFMXUzRUVhZllFLzN2YWRmQmRGSllKR2h1Sk1IaHNj?=
 =?utf-8?Q?qQ/vUX6kcbWkpRTrZp3PofoF7?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa69c170-5d03-41ec-4e61-08dcd0c2e543
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 11:31:07.1188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfkohwkNNkR0wgDrRAFvLV1c2Isx2kuAUWU7CrYZ0U+tJET+zd8HflFcZlOHrY76Gg4Qu7toHLq2N3vrGN82sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6339


On 9/9/24 05:20, Zhihao Cheng wrote:
> 在 2024/9/8 3:28, Mårten Lindahl 写道:
>> If a reboot/shutdown signal with double force (-ff) is triggered when
>> the erase worker or wear-leveling worker function runs we may end up in
>> a race condition since the MTD device gets a reboot notification and
>> suspends the nand flash before the erase or wear-leveling is done. This
>> will reject all accesses to the flash with -EBUSY.
>>
>> Sequence for the erase worker function:
>>
>>     systemctl reboot -ff           ubi_thread
>>
>>                                  do_work
>>   __do_sys_reboot
>>     blocking_notifier_call_chain
>>       mtd_reboot_notifier
>>         nand_shutdown
>>           nand_suspend
>>                                    __erase_worker
>>                                      ubi_sync_erase
>>                                        mtd_erase
>>                                          nand_erase_nand
>>
>>                                            # Blocked by suspended chip
>>                                            nand_get_device
>>                                              => EBUSY
>>
>> Similar sequence for the wear-leveling function:
>>
>>     systemctl reboot -ff           ubi_thread
>>
>>                                  do_work
>>   __do_sys_reboot
>>     blocking_notifier_call_chain
>>       mtd_reboot_notifier
>>         nand_shutdown
>>           nand_suspend
>>                                    wear_leveling_worker
>>                                      ubi_eba_copy_leb
>>                                        ubi_io_write
>>                                          mtd_write
>>                                            nand_write_oob
>>
>>                                              # Blocked by suspended chip
>>                                              nand_get_device
>>                                                => EBUSY
>>
>>   systemd-shutdown[1]: Rebooting.
>>   ubi0 error: ubi_io_write: error -16 while writing 2048 bytes to PEB
>>   CPU: 1 PID: 82 Comm: ubi_bgt0d Kdump: loaded Tainted: G           O
>>   (unwind_backtrace) from [<80107b9f>] (show_stack+0xb/0xc)
>>   (show_stack) from [<8033641f>] (dump_stack_lvl+0x2b/0x34)
>>   (dump_stack_lvl) from [<803b7f3f>] (ubi_io_write+0x3ab/0x4a8)
>>   (ubi_io_write) from [<803b817d>] (ubi_io_write_vid_hdr+0x71/0xb4)
>>   (ubi_io_write_vid_hdr) from [<803b6971>] 
>> (ubi_eba_copy_leb+0x195/0x2f0)
>>   (ubi_eba_copy_leb) from [<803b939b>] 
>> (wear_leveling_worker+0x2ff/0x738)
>>   (wear_leveling_worker) from [<803b86ef>] (do_work+0x5b/0xb0)
>>   (do_work) from [<803b9ee1>] (ubi_thread+0xb1/0x11c)
>>   (ubi_thread) from [<8012c113>] (kthread+0x11b/0x134)
>>   (kthread) from [<80100139>] (ret_from_fork+0x11/0x38)
>>   Exception stack(0x80c43fb0 to 0x80c43ff8)
>>   ...
>>   ubi0 error: ubi_dump_flash: err -16 while reading 2048 bytes from PEB
>>   ubi0 error: wear_leveling_worker: error -16 while moving PEB 246 to 
>> PEB
>>   ubi0 warning: ubi_ro_mode.part.0: switch to read-only mode
>>   ...
>>   ubi0 error: do_work: work failed with error code -16
>>   ubi0 error: ubi_thread: ubi_bgt0d: work failed with error code -16
>
Hi Zhihao Cheng!
> Yes, I noticed these types of messages too before kernel v5.18. Since 
> commit 013e6292aaf5e4b0("mtd: rawnand: Simplify the locking"), the 
> behavior of nand_get_device() is changed. A process who is invoking 
> nand_get_device() during rebooting won't be stucked, it will get an 
> EBUSY error code, that's why we see the above messages from UBI module.
> After commit 8cba323437a49a4("mtd: rawnand: protect access to rawnand 
> devices while in suspend"), the behavior of nand_get_device() is 
> changed back. A process who is invoking nand_get_device() during 
> rebooting will be stucked again, so there should be no error messages 
> in UBI layer.
> So, is your kernel version lower than v5.18?
>
Thanks for identifying this! Yes, the device I'm testing runs v5.15. I 
can't upgrade it to newer kernels so I backported a lot of ubi patches 
from mainline, but it seems I missed commit 8cba323437a49a4 which indeed 
seems to solve the problem.

Again, thank you very much!

Kind regards

Mårten


