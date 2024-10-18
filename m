Return-Path: <linux-kernel+bounces-371349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FE09A39E4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F2F1C239E2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4188E1EF95A;
	Fri, 18 Oct 2024 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oJL72c3r"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11FC1EF94F;
	Fri, 18 Oct 2024 09:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243419; cv=fail; b=qwu4DjugKzWxxQS9TueVGk5A2qWtsYG3xX6cXSew9A+Oxx770uOosnRZriOHgadNfBO5CLEan+Iy5ToQoUPBRC50P5XB9W7QSMChQT6OIjBEdkZqreuxADXazmuo27gbWuHv5Wp2ZEHs84T1dmzjo169YyGQPWXKl7IKhrjQodI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243419; c=relaxed/simple;
	bh=krWVQsIsBLSIMZ6rNjGbQNcdIrNGf8Qm1mwM4LtynH4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dxSsOKf3L8bM/UY4sazJDxYhC81MyE2dHS0v7JrGV+V4a+7ES015yi5y2SVJARBBa9cjbdl4LsUq/oB0SfchfxpNh7mPE+BXjdJXeBEaq2C4AKGSalTPkiw2A6ZpQAyMthtmQVqmiqUnDtrlHsoASCTQEc1J71BLxcZ2dMV8eCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oJL72c3r; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VphIZsbDG9MXeiwshXs1VPaROyEZ87Jzboimu2RGFLke/Ksgr+gzSRDOAERnsKRwWacUctEDVeJQ0hquUtBByfMc9HXNoReCPyI5TsPodRH3d+NO35t8iA50Rye0gjf5F44zZJ/AjHSXcFbcoK7xXYkaNlGQD7m2BTZzMPbxYlY/SZW3uL5rrNbXi45bOSgoBMgX1bqSSJWvpQQJGaQTod/lSKcBIv60jNkv5OVDPTkcwnfPv1BD3xLycMKyIVcv+805itD4XD7aWWajAZPN2lwPtCNmmjkw45lx+tT19KzfBmoLt4nXioaGVxbPnhKRDqlpEbpmJZrVZ0QjcXkpjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ut8mYjpJPt9L5VFmrTOutLBMJ2NCxf4F+Jwr+zWrJwo=;
 b=V9o5ttDxuwp146dt3COzjKgKObqH9kbmo+BFqTcBxVgmAuxMU57iJ2TikRbXA8o2ZuUfVDPg65RrQGmTfYfXdVDLC4vF3DtZ7IEix1tpfjl3glpLrwA3+d30+EiYj/WBxkM+8WSpu2/1x+qyQ5CJdKKWkK8Qxd4IKCZrVfoJzUgzr+hbWJ7nml4UHH4rIVRfuM7GrkQYTnFvW75GSHSFKd5RjxZqoLXNMMQur5NkaSFhz9H3N5V37yVykmvoUZWAimVhOKcke5o2IcU0rqAswvVx+YRoxhDrv1x8KRJWzvzVJeC6ShuDyWqwUMwYYcrObNUCuXpRqlPzSIA/Zajlfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ut8mYjpJPt9L5VFmrTOutLBMJ2NCxf4F+Jwr+zWrJwo=;
 b=oJL72c3rZD7oQOtEVe3Ost8AYZLmnv7ycPtebE1P9crVyVDGgcb3ovT/TEzBEwncWTx/FHJLW8CnZXZwbxXguffVuSWajGQfHlIoh9+rCwzrmS3Ce2rMukOEsKI60AyiVDSYKeU58iCJXMLHAXaSXmQRQrGQ1j/YwYfjgrIHcXk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 by PH7PR12MB6587.namprd12.prod.outlook.com (2603:10b6:510:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 09:23:35 +0000
Received: from CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753]) by CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753%5]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 09:23:35 +0000
Message-ID: <420ab0bf-32cf-cd98-c711-0dacc8bcc161@amd.com>
Date: Fri, 18 Oct 2024 14:53:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 5/9] misc: amd-sbi: Add support for mailbox error codes
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@roeck-us.net, arnd@arndb.de, naveenkrishna.chatradhi@amd.com
References: <20240912070810.1644621-1-akshay.gupta@amd.com>
 <20240912070810.1644621-6-akshay.gupta@amd.com>
 <2024101351-hash-deflate-b339@gregkh>
 <27148cde-29db-dc77-18af-2fe56dce036e@amd.com>
 <2024101541-domestic-steadily-6451@gregkh>
Content-Language: en-US
From: "Gupta, Akshay" <Akshay.Gupta@amd.com>
In-Reply-To: <2024101541-domestic-steadily-6451@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::18) To CH3PR12MB8909.namprd12.prod.outlook.com
 (2603:10b6:610:179::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8909:EE_|PH7PR12MB6587:EE_
X-MS-Office365-Filtering-Correlation-Id: 5210dfbb-36f6-4a42-ae53-08dcef568a56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDE1dVFnYjNkVDc0dDNvNC9mclFJaFhnZHBBUExjYWUxUk5vM1Fycm10S0dI?=
 =?utf-8?B?MlE4U3dUU1VjMi9UUXUrVVRnVG1ZaVpFS0ZoMEpBOVBBUHZ0Qmg0aEZheVA1?=
 =?utf-8?B?aXFEcWQ0Mm52a2pJZWd4cUYyZVZacktsS3VRaUg4QktTb0w3WlR4TXlIU2lT?=
 =?utf-8?B?ZEdFRHMxWTA2NnZOSWpBTlUzc09WMnhFOHlGeXRDcE9QOE1FUmZxOWM4UExE?=
 =?utf-8?B?NlNSNnNvWFhIeDlTelozTzNXYzh6Y2J6VEZnUjl4V0ZOZUpTdkx6RUNZaUxH?=
 =?utf-8?B?U2dHWi9sSUJpQjIzYWhBejdqdEx4V05TOHRFMEd6NTBiQ0xEM0tlb0ZNcm52?=
 =?utf-8?B?TElaZ3VqbXhpVk91aEc1Vld0aFhBMnlxQUNuNnIvR0tEbG1sZklMdzllaWZ6?=
 =?utf-8?B?TTlacjJVYUM4ZzY3SnlKTlYxTzB0S2J1cExiUmZyekQ2VE0weS9oeE9seFZB?=
 =?utf-8?B?d2xkdnhSTktZQVE2bDZ6OHY4K0NrREw3KzFCUWRIUk5UV3ZHRzB6YVU4WTNO?=
 =?utf-8?B?aE9aN1R5UmtpN09Yczk1SVRvVTd3ZmFpU0VmelQyRE9MZUo0M1l0ay9KYXpD?=
 =?utf-8?B?MkxycmFJVU5JSzhFQ2g4MWlzQm1zQzNqb0VIYTkvTlBqa0REc0tuV0VUK2x4?=
 =?utf-8?B?b0FNTG4rS1pxSGQ0MTFacytDL1ZvaUVoV1U1c3RlaUpDZ3ByeU5mNHI5ZVF5?=
 =?utf-8?B?Rm5zK3FNT2UrVDhuSGdRNXJBa1JIajVVeDFhK2c2TmgrZDMyVjhvWVBYejBs?=
 =?utf-8?B?U0ZUZVVTemN0eUVlY0JON0RzeTRlb1dHU2JSZVNmS1NFalBIR3ZLWFk2dysr?=
 =?utf-8?B?Q2R2YlE0bHpFdXFEVCtUSkxKT29JRjdIdGhRSGVvSGFGcmVPQzVPcDkvVE1j?=
 =?utf-8?B?aWxycDRLTWFWaW5aQUJ4T0JsQnNQUE1haDRhQzNXZnJjd29nSmg1OTJqeHI1?=
 =?utf-8?B?UE9WeDExNStZNXdiY2VNVnpHTEZPSEtSZmQrSGJuRkQ0V1c2OTVSMHlRUkM3?=
 =?utf-8?B?bW8xd09XNHJJVlFkcHlSY1B0bW9tbE9GME1WcHpETU84Wk85RXJUM0o0V2N1?=
 =?utf-8?B?T1M0YzdCTDVSYzZGZms1SGdmLzZTbWZ2M2RRN1lxKzlCSUZDNTNQc0o0NXVv?=
 =?utf-8?B?WE9VcFIwd2x2R2VqeDRsQWFLYmdqN3RHNlMwWElvSWV4clVKVHZOU283NHl4?=
 =?utf-8?B?bjlCcW1aWXpCNjgzcExvSmRRU0pQekxXckF3MkV6MkJkUGFZNW1WaDQwVU9q?=
 =?utf-8?B?REgyV3RzVkFrSTg4dlVkUGUxU3RDR2dpV2d2K3MwcWRZK2lieFFjelBBRVo0?=
 =?utf-8?B?QlhSRjVoMzJEb01YbHpkMGJ6aU9aSWtMNjhMRmpxS1FUSTFRaDdRVThhVVhL?=
 =?utf-8?B?b1MzSmhjQmM0UnhNSVlLZEdHbmN6eUZFTDNhSHNpNS84OHducndrTEJiQThj?=
 =?utf-8?B?cFM3RVp5bk05a2FDdWFNMmtCTjJLV0ozZldaaDRBZ0VpYUJHZ0pMZE9OVlpY?=
 =?utf-8?B?Z3FlSkJTZGNKVUIvZWdDdVNFUUpYY3hSVFdPKzk4WU9JZVlMelV6UG9sSkpw?=
 =?utf-8?B?NHZQVkF6dnZlektsc0xMZFdDSndhRHM2cWNvdDArNmhnOTlLSVhhaUlteHFo?=
 =?utf-8?B?ZlcremRwblo0TTA5R3RPYlJRaTNYcXV4NmRpVXNDdGNGT0loeUdiMGphMUZx?=
 =?utf-8?B?WXQwM2JFUmFNQnRMNUFNYTkyVzdZZjFiS2ZwbjliZyt6K3lyN0V3dWROMmZT?=
 =?utf-8?Q?+WbKKGzaj1Z+i9G8At2d8T1L0F6P+byaV1XY1mX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8909.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emt6cmdQUlhtdGVkRlpFQXVPVDVQeCtPUHJHd2JVWlF0QWc0bVFMOENvNzAz?=
 =?utf-8?B?UzkyYVdqeGFEWktTbkE4NTNuNW93NTQrUnhkMjYwMnNyTWFidWxpaGtTMXlH?=
 =?utf-8?B?cjlWY1VmQURubC9DaDlvS0JpK0ZUVnNVcTdpZG9zWTZSV09PUndad3ByakZU?=
 =?utf-8?B?Tit2dm5wM0ljVXZXek9YQUJNVDZ2bHl1RCtEUEhidy9nOGhUTVFVMGZSNkQ4?=
 =?utf-8?B?dVF2dnVQTmx5N05kVTdRbXZYM3NwN01yVVBvaGZqeEZmQkU4YmNEV3MreDFu?=
 =?utf-8?B?K2hkcUFuWUFlMnIwaVV1aW9QUHQvOXczOHJJTDRjaFUrUk15blJJUTh3a0dh?=
 =?utf-8?B?TEk3UkJxOGFlSHhKMHJienZXUHhlL1RiV3pBdHBHY2tla0RlU2FTYkd4bEY1?=
 =?utf-8?B?bEZ3NWtVTGovV3ZnNUYyQU13aVJqRVc1dGlZZ0FadmhibnFEQlFzN3JYaTlO?=
 =?utf-8?B?NUZ6NWxrMkpGOUlrUXY0SS9RSGJpVEJSSW1lOERYNkYrcmkrczB3SnRMTjhF?=
 =?utf-8?B?NjZjVjBQRFlSS3gweXVSUU0wWFdLMk5PWFg5ZW9JWjRrajkyMFhOeVJjREhk?=
 =?utf-8?B?eW02dEQ2MWt6am12NHRHMXh3SFZBTzNaK3N1bXlxWUVoOHhCVFprMVpQMWs1?=
 =?utf-8?B?YWYzMjdneTJjMm8xOHIrMXlPYXg0M2owUmVVK0hoN0ZNNU5TSkRKT2o1Z0ln?=
 =?utf-8?B?bXJDRDk4SUllLzBwY0NUV2VLemJFVVNhZGpRS0ZPVnZpbzFDUDNIQURvRmND?=
 =?utf-8?B?UWdCRGF4c2lMb2VObzNaZU9hQ0JXdFFGa2VDTlpCVFZITGFsdEVMZkRhdDNm?=
 =?utf-8?B?Z0tKeGorQUhaejZhZkk5OG5vN2pPSmkxSEw3Tkc2UzZNSzNLaUdpRmUzTHY3?=
 =?utf-8?B?VG5mMkpJTlp6bHdveGh5REUvMGlyWVZZeHI5MVp2WkpoYkc0bUNsSlp1ME9D?=
 =?utf-8?B?UFJrblA0amtleENwc3hwblpMQTR5RDNsd2g2RXhHZ2oyUTZFR29uVDJWZE1Z?=
 =?utf-8?B?dVdIaEdMUlg2bmcvTzRxWnpkOUg0VU9WTTBVZkZqeWhzdVphSTlWb1dvMGVS?=
 =?utf-8?B?b2d4VXQ2elJYRGhxUFhNdFNSelhORGRJd0RoTjRObGJiL1luN1pRZjZiajVP?=
 =?utf-8?B?LzlnYVBuczhManBsamdKbjBqcFhIT2pNYjkwRlpIRlBwaEIyY1hYcnF2Rlh2?=
 =?utf-8?B?RzArdm90UWlhVlN5MmFBMFd4WFhTY2FyRHQvZUZxVTlYV0dzTDdZb0RiSVJt?=
 =?utf-8?B?SmZHdTFBWldIejhTanBHYkxoQ3diR1FCWlZUNEtxc2EwUmswVjczTkJZaUFw?=
 =?utf-8?B?bWNmZ1ZocFFzQVJzRGp3ZFY0SEx1aVBCOWwzZlliUTJRcG1BQlhEOVArR2ow?=
 =?utf-8?B?YjRVNmFIZU8wYjVUbFdkTHFENFlMWnpEc0dIVDhkSGVOQndpejh6QTMrTGRo?=
 =?utf-8?B?a05lS1BhZnlUQnBmemIraTVraFdmL3ZQalZFbjZvaW5uNHQ0TExUanErNFox?=
 =?utf-8?B?YUZkelBqQnoweVdhcVRydWN6am1ZRkFqeHhZNkcvcXF0Z3gzQ2szYUY5U3Vi?=
 =?utf-8?B?SDRUSXQ0eG9IU3FsVVRiNUN1MG9FVE5HQ2swZGZpS2tzRllxMkZvY1BJdVFZ?=
 =?utf-8?B?VFd4M1ZrRkp5ZE1Fb2plYmNSbERHNlJMYjlUVEYyeHpRd0V0SXRZM2IxRXU2?=
 =?utf-8?B?SmM2ZzhmVncwMXk4VzlaTDhCQ2Y0Y05XV044SWRPdyt2V0RZOGtKOUJlYTlJ?=
 =?utf-8?B?MGovR1hFSjlQaSs0ZG1pbGRsY1hOamowQS9HSWF3WWMvWXZnekx0aHJCWnc0?=
 =?utf-8?B?OEhQWlJxeHYzUHRpM3V4N1dCMk9kdTN4SXFaS0lGTlU4QXBnUTlSVXVBcEs1?=
 =?utf-8?B?RnlBTHJqckp2QnFOTmRHS3h3OFFlc1Z5MWp4U0o5ejhlL3REQUM1cUd3M3JF?=
 =?utf-8?B?NUNZaUMrZzlrdlBQQlZBMzZZS0F3bUdMZnQvYlE5OTh5Vm5jOEdYQ29RUGpj?=
 =?utf-8?B?OUVVZ0x0bDVWRG56eHhHR1JOR3VmUnFqaC9TSzdGRno3NlhwVDJ1ekpleUtw?=
 =?utf-8?B?Tjd0aDZsanBFOS9DNURIdllpdVN3dG0xeWhWemd3c0pyMm5GNjd2b243YXRT?=
 =?utf-8?Q?7glcC6Sx3fDrXty+R1NwxtYok?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5210dfbb-36f6-4a42-ae53-08dcef568a56
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 09:23:35.0122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E05FgvTNcN+O8fPu3r2degYRN8X3Wh24KSj3j4uqbjTWpuSVpAefvtCyY5M5wsvDu4k9bY/WxQ5GdVhCjAq6OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6587


On 10/15/2024 3:34 PM, Greg KH wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On Tue, Oct 15, 2024 at 02:42:08PM +0530, Gupta, Akshay wrote:
>> On 10/13/2024 8:49 PM, Greg KH wrote:
>>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>>
>>>
>>> On Thu, Sep 12, 2024 at 07:08:06AM +0000, Akshay Gupta wrote:
>>>> --- a/include/uapi/misc/amd-apml.h
>>>> +++ b/include/uapi/misc/amd-apml.h
>>>> @@ -38,6 +38,10 @@ struct apml_message {
>>>>                 __u32 mb_in[2];
>>>>                 __u8 reg_in[8];
>>>>         } data_in;
>>>> +     /*
>>>> +      * Error code is returned in case of soft mailbox
>>>> +      */
>>>> +     __u32 fw_ret_code;
>>>>    } __attribute__((packed));
>>> You can not just randomly change the size of a user/kernel structure
>>> like this, what just broke because of this?
>>>
>>> confused,
>> The changes are not because of anything is broken, we support 3 different
>> protocol under 1 IOCTL using the same structure. I split the patch to make
>> it easy to review.
>> Modification in patch 4, is only for the existing code. This patch (patch 5)
>> has additional functionality, so we do not want add multiple changes in
>> single patch (patch 4).
>>
>> The changes done in patches are as follows:
>>
>> Patch 4:
>>
>> - Adding basic structure as per current protocol in upstream kernel
> So what if we only take the first 4 patches?  Now any changes after that
> would change the user/kernel api and break things.

Yes, it will break. We need all the patches to go.

>
> Please don't write changes and then "fix them up" later on, that's not
> how to do stuff as it makes it very difficult to review.  What would you
> want to see if _you_ had to review this patch series?

We submitted a single patch in v1, later split the patch based on each 
functionality for ease of review.

I will squash and submit along with other review comments addressed.

>
> thanks,
>
> greg k-h

