Return-Path: <linux-kernel+bounces-236649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E405B91E55D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128971C21883
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E316A16D9CB;
	Mon,  1 Jul 2024 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="kYKgqfFw"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2092.outbound.protection.outlook.com [40.107.22.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB8B16D320;
	Mon,  1 Jul 2024 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719851351; cv=fail; b=OPdQLd1yZl9sQTkBsl9EwxJSqxSbQ+RxsEcwDs/nnFQgvhF3as0My3oE2XAbLAha/QX0J0HnBjFBDMMlHzs50vU1wJlrPo9/kOCI35bfr3+R5Gu1j3FAJZIjdjCpQY2pk4/Jgh2dhM8ZcqMyUERACNyiF9JYPLKiCNSpBxjAE8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719851351; c=relaxed/simple;
	bh=WWC0SMG0GxRPfg3zEfAuctSwPC9DEubzgcMdxOLGNQc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RshpljC6/jg0IDw5weW4VB/BaeQ/2FHmJkV+Sun+UFIYVwgn3In0iCGi3QwwC92p6cSvnpo4jeTwGK/qMakojg036r6bsBR+KewfsWy+hP1hKrw0I/wIfc7JCWqUqicGl7MN4purNi+NLxhAH1ZlGaPZmoDGFXjdSfYQr9mrGnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=kYKgqfFw; arc=fail smtp.client-ip=40.107.22.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSoXzGMF34NfjmlFFkauAUbdjUfUQ3QxxxJ7z7Skc7xd951B38QKQU6WDWkuh6KXoS/2x3B6640Z3i28DHu5er1mwVVLipRfmwgnAilSe3q0XfhuUYCFWBohOVCA2o9SSX9b0johvRUgd07+9R3w4mp0CIU9EtdyEMWLGqikhCu4EmtwDICl8KWTXNiX+33bdEqjpmSuujxBWNcQC48p1YVRQv3biCOmyV6ZcheZ0Hb4bEoGbVSiEtCv6MBOSafI1F8V4hkOni1248ohVJfvNpMGfzPytM1nNqLCWZ98Vj1nWBOckqZe5CeYWw+xx2daF0drnHmobPG1qHM7bjZb9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BK12HntA1nN1Z23bIxTKZ3XnVnZCMdX0KyESr8gGNME=;
 b=aPamDZHk/lhsRwKDLpWXOMew50wGbyrpYKAmtR7sqUqdGrkMsYf3hxphnZp45tSn3MBpNqrFWXKLf/Eint8KHoQYAhzPsK/e4JR1fSOdz6/6uAA4ntowm6KAtszYXSwu5E/a/RGhxH7r5nOlxW7gJ6OaGePjbNEYv2ZUQjpkue2sDQ1EgQVG3J2h4BN9gpasUWd1I9HLopqAQSGrk4rc/9JySoralW0S5OKhPHQyOuMMcET9gOHYsAg7NXZjW38RgJHvVUm5+o/23PI76iGE4+aLqT2MixhIZe2wNrlJIasi40BWCCTh3PGdxQ0vcaRPERfE5s8sNJZxBCHE4Ba2Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BK12HntA1nN1Z23bIxTKZ3XnVnZCMdX0KyESr8gGNME=;
 b=kYKgqfFwcQAaYXXD/M7EZtCTMSHg5oSRVTTm1vxPpBOKv/buq+KxW2hy9sJNDb2WVhSVS9lovu06MK0vrOfXw3K7IwF6kEfa4wjEQoi4ClRr5ZREeSBef7g829xfXdYAI5GfN7hnN16iROMirwgw4ge68aD3Z/Ds51VVVhKyAVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by VI0PR04MB10175.eurprd04.prod.outlook.com (2603:10a6:800:242::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 16:29:03 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 16:29:03 +0000
Message-ID: <86df2f79-c201-4e80-9e28-dfe13b674258@cherry.de>
Date: Mon, 1 Jul 2024 18:29:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] hwmon: (amc6821) Add support for fan1_target and
 pwm1_enable mode 4
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240628151346.1152838-1-linux@roeck-us.net>
 <20240628151346.1152838-5-linux@roeck-us.net>
 <e1933ae1-af38-4c17-b36e-33d43e90f057@cherry.de>
 <31eb2d27-fd00-4284-93f8-23504e14b47f@roeck-us.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <31eb2d27-fd00-4284-93f8-23504e14b47f@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0243.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::16) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|VI0PR04MB10175:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f29c7cc-321f-499f-5157-08dc99eaebb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjIzS2plRktFOEdzZDNOWEVBMllzb1MrQ24xdmxhSUUzK0s4Y2RMUys1ZVdQ?=
 =?utf-8?B?cTBSUE9NUXE4VVV5Vys1ZFVoRFpsTlRERlVEcjNGMDNNM3ErMCtOYW1LYUxE?=
 =?utf-8?B?ajBWbmFVTjFyQ3BWSDBsS2thWjNDeUpobXhlYXllZ1FHV2cxUjZ2TmlXam8w?=
 =?utf-8?B?ZnZVYkl5aXI3d29FSDRUU2pRUUpkUVJNejRjOC95L1l2UG93UWNtZU9tUThT?=
 =?utf-8?B?VGRoaHNGZGlnZWZIV0ZwdWVkOElCVGpYQTBjZVJKeDFSU24xV1pHTXBFZFdW?=
 =?utf-8?B?YmYza0RCbXg1WjlrSkxoa0l2ZFV6d0I0ZHRjdHJ0Z21Ib0hiOWV3MDg2Mmpj?=
 =?utf-8?B?V05HVjNpZUNsOXA3WVFibFlqcG9uNGZZN1gySU5wQXB4MHAvcXdHemFJbmJE?=
 =?utf-8?B?SzU5UkVIR2llTHhmQzY1NFFyV21jZTNQWERsTEVkcTFiRE9MQjBQMVkzZ3ZK?=
 =?utf-8?B?L0dNODdPQldYNzFhUWJGREl0Wkd2eVJzem9qTW1UWjZnMXEyTWN1ZlUvVklJ?=
 =?utf-8?B?L1oydnhDMFRSZEVXL2lLY0duT0p0SVdhZnAxZDZoU1JHYmJUdXk2SWM3QUd2?=
 =?utf-8?B?Rkc2THJNWkdsd0hsRnpMSFRKQWZod2pWSEg2K3dRN29GYkxyM2w2bE5nb3V2?=
 =?utf-8?B?ZGJXYlhVUFJKNXBwelBzNXQ2M2pzSjIvV212MWtPM3VKcTdVVDVNUHIxU1pl?=
 =?utf-8?B?by9ZQ1FWRnpSWnRkdUp4WUk2NUF5ZEVsV2dtS0hqTXhJdjRHK3R6cnFNNWcr?=
 =?utf-8?B?NkQzdlVJamVTU2dvUEVTNnJkemhmRmJrZGhRTVJNd1RBUjRERk05dHBBY2dK?=
 =?utf-8?B?a01oRzloNFhyKyt6d1Rya2Q3L3pLVFlFRXZKUzVJemxScndMY2NETFR0Qk9u?=
 =?utf-8?B?alAwZXhScjV0a29waE5kTzgzblhGaTZoTHd6dE56OVZLWHM4MFBZbndtUDVT?=
 =?utf-8?B?djMzWFRyRWlnb0ZSQ2NvTTF1VTFtVkhTdU04T1VXRmx6SHR5MnVZQS96Q3Zv?=
 =?utf-8?B?K1c2cnQ0V3RTay9YOURBY1JTazRPTUdxK2pSZHpMWlRFbWYySnZFSjR2ZWpy?=
 =?utf-8?B?OFgraU5nWjhDRHBPdGppWTRtdDBrRkppdmZvTkhycUN0MXhId2xKMFlyaCtJ?=
 =?utf-8?B?QTREdTE0WEo2TUNFK1EyR1ZRUXhHL2orOThhTjE3V2NTVHh1bVVGK3VnOTlW?=
 =?utf-8?B?NkYxNmM3V2NiV2dXNUlXcHFvb29yVWhSZ1hsUmlQV1FsWlVQazFGRFFiN0dp?=
 =?utf-8?B?djdPbmtWSGgrK0ZaN0wzcG1UNjVQdGdLTFpkcnNVbk9xSHYxZk1EYitpRzlL?=
 =?utf-8?B?VFJ4bkpjWEsyeC9uZ3FMRU80QnFIZFJieGNEa3JHSmRuamQ4MFplbUdWWXU0?=
 =?utf-8?B?d3BLQmdlbDh2RzZORkRFZ0todGRxelVvS0VDdnpGR2FwT2p5WXdQc3VkWEto?=
 =?utf-8?B?dVNEUVMrWEVXRjVxWUdXdUE4elp2b3dRUVBRcDR2UlFjNFRIc2hZSFZRbGNl?=
 =?utf-8?B?bWx1a3VnR3dIUWhBcWwwTFBWN1l6ci9tMWF6SG4vekFLNU9SM2RZWEdLQndE?=
 =?utf-8?B?SVlPNmpqQmJaMWswUU5WbFpvaTlxRlFpZFdzZ0p0OXppQjRHMVN4L0ZSWXFS?=
 =?utf-8?B?QlJYSDVxeUNhQjhYOHZxRjdsd2VKZkcvUjBPMU5tVXhJdEV3MHVxZzR3RTFh?=
 =?utf-8?B?aUMrV1dKWUxoN3ZSejdJZ0pmSkpHZy9GUjlKWkNhMU9qaFhudmE5TXhLaHJx?=
 =?utf-8?B?RFVrdmgwSHBNNEVzZFJVZUNPc1ZGdUtJUlcwVm5BR2p1V3NUbm9jNGd3bVVy?=
 =?utf-8?B?Um1Td2kyMC9wWkxsejhudz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REdWeDlia1JrbnYxYnlCRGN3ZTVtQ0Q0aDRwakE3T2ZKZjdWMThUV0piVHo1?=
 =?utf-8?B?UklPSzgyMXpSWE92WkF4bzNCcnE3WlBXekhHMkRwUlcyQ09DK2syQXRYeDZJ?=
 =?utf-8?B?bXRaaFVSU3RZQnczdGJ6MkJjQlBaY0l4R3djUVYzTVZtcEE4bWZ5OUgrdm1w?=
 =?utf-8?B?RTJscS9pNFFoa3l1SUVUNkJsU1pDc24rYmhDL2J6ZFhnQkxxQ2cwT3BFZnR4?=
 =?utf-8?B?eW45NnBERjF4VE9lWEp6TEpQUHpCcjFWRDJDS2FuSi9ac0VLakY5Ym13Tms2?=
 =?utf-8?B?bG9GampLR2JrSlBielFmemNPV1ZvVjIyK2Zmbmc4MDZUbHM4L2hFbk5ZT0hV?=
 =?utf-8?B?elVKQmJrL2VPaXlpNTdIVDc1akw4Qkx0bllrUVBaWGRaQmRzVFY4VEREb0cx?=
 =?utf-8?B?WS92L2YwUlQramNzUjBsQVhSNDkvd1BaRGdzaTdaRzZxSFQzK1pBRGIvVTRX?=
 =?utf-8?B?NUwwRldzMkgvTytRWWxBM3dKZ3J3TG1LOGs2UUN3ekdxcldZU1B0ckR3bmNS?=
 =?utf-8?B?UTdBNG1KK1duV0V3N1VlUE9pWFJVRUpXdUFXUGxSTjZOZXMxVy9GZjZFLzI5?=
 =?utf-8?B?UHpzY3E0SFFsOTVTZEoxYkZScmF0c3NBU3ExRjg4bGVPbm43R2lENS90d3NO?=
 =?utf-8?B?SzltdkNBYVNSSnVLam40U3FPcS9nNi9ycVlHTk1mZWk5RDNwNldjUGFqcXpq?=
 =?utf-8?B?U2hPMU9oOUhwRnNzMXd4ZUlsMjA1cnY3dVVhOW5yZVkySUI2amlldTQvS1R4?=
 =?utf-8?B?cDBTOUlMajFXSkdnOStUWmRBWGFCSjdSZHJsWGtlTTlnVkFRZGVwQUk3VFRj?=
 =?utf-8?B?QUxhclA5MHZXcWpTTVlacGppaVRyK1Uxc0FrbGRVcFdKQXFPbm0xV0Y4TXJx?=
 =?utf-8?B?Y2NWbzBTVEdUbGNmTExIdVNUV1lVKzZxNmtaeGloMEFjaXNUNUxVSExGRW9w?=
 =?utf-8?B?MnBlRjRWRFdpNXZCMWJBeE9QQkIwanhBL2JVN3FsZlgyakM5L3NYWmY2RUZs?=
 =?utf-8?B?eU9QNU9IZ0FhYmt0Um5lbFdrUytQLzJsNU0rMExQZGlwV0xxeVVUWElGenU1?=
 =?utf-8?B?TCs1OWxEUm1KL1lmOVJsUUVuYnJkM1RlNEtja2g2bHdjZWhnOFNZQnh3TEUy?=
 =?utf-8?B?RlRuUmZsbUlOZWsyNWZNWDhESmtFbWkwTnVtbGJwTUNOSkR1VjduOGdLM0Z5?=
 =?utf-8?B?endERWxydGYrdnpFLzNrdlI4SEd5SHVzSXFxa2RrUE12cXBvQ250cjR5MmpE?=
 =?utf-8?B?M3FNNndhblVRdzEzc2dXVXRXVUo0TWllVkxwQmdISFRCOXZJYUJoYkFFOG5o?=
 =?utf-8?B?QlJTSEtPdm9pYkI0OXVRSERhTDhZaDFsM1dPVmhmMnE0R2t0SmdSbTVIYXpa?=
 =?utf-8?B?ZlVWd2hPS05VWWxNNTVaTld0bmJId0hJZEs3N05sQVJ5c3cwVlNhZHdZV2xT?=
 =?utf-8?B?U0x4SGpxZ2lYUSt1UThUSXE4MlJzejhFK0Q4TUN4OVkvU2JNejN1UmZnQVRF?=
 =?utf-8?B?MjBPK3hqV0NyODZUNzVpb3FQWlEwQjdsZk80ZnRSdU1zSWsyenFJSW1tR2FU?=
 =?utf-8?B?WkFsUCtLQnRGZzFwK3RweFBvV1p4Mk9GUVczWEZSakhlYzRyTURIelV6OWo4?=
 =?utf-8?B?RTlObk9JaC90eGJmMVpHcWI3d0ovbWY4a3N0SGpjRXFxNGZjT1FRV2lyMlpn?=
 =?utf-8?B?WGVpUkMvTzFjZUJYWnRpZ1ZaYzNzb2F2b2JkTHFFZDh2YXRDVWVaSTFJYkN1?=
 =?utf-8?B?ODVlOURLMnlubFdIRXFhdmNKTUhPMkhiRVVKSWxGbDFmWis5ZkVtSGVabXNU?=
 =?utf-8?B?a0NRaWkwVUM2M21tbi84OVRUY1Z5NklQdWgzdHMwRnAyczhZYmswVE9yZzND?=
 =?utf-8?B?ZDd0SWNBU1RMeTVObkp4RGtpYUZaZGZWK1ZEZFU2TmRvUGJVdWROaDdIbzdh?=
 =?utf-8?B?WXdaUlVZSk8ydnc4WjJSZFVUbHo1SUY2NGsyTjRPZDkzYS9IS2dIdVVobDdw?=
 =?utf-8?B?SVZCWGdHa1ZxTG53ZS9LRmpUVS9Na0JpZC9jUkRVa1NaajVsVEE4QnpMRlZj?=
 =?utf-8?B?djl5U0ZHR2h6b3hxc29kM1Fqb2FLZG56N0hyTFZHTTdRSERSUzRlK3QyZDN6?=
 =?utf-8?B?eXRSUEoxT2w0c0dYNmdnY0Zjak1xZmdNYU5ud1d2ZXZpcktLcHdPVnVKeFpz?=
 =?utf-8?Q?2PjW9ty3S13p27Y4HWWT71c=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f29c7cc-321f-499f-5157-08dc99eaebb6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 16:29:03.6696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GjZJ7vDV3SP+yNTP+nMe9ZklV1L2L2o7yHyQLfEMLvNHH73fOClCUlgUrapyjY3Dp2E5eylAai9PVC82Oqb4patQpu6eH5MdCLfGMiMsNGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10175

Guenter,

On 7/1/24 5:26 PM, Guenter Roeck wrote:
> Quentin,
> 
> On 7/1/24 04:23, Quentin Schulz wrote:
>> Hi Guenter,
>>
>> On 6/28/24 5:13 PM, Guenter Roeck wrote:
>>> After setting fan1_target and setting pwm1_enable to 4,
>>> the fan controller tries to achieve the requested fan speed.
>>>
>>
>> There's something in the docs (section `Software-RPM Control Mode (Fan 
>> Speed Regulator`) that rubs me the wrong way though.
>>
>> """
>> When the TACH-MODE bit (bit 1 of
>> 0x02) is cleared ('0'), the duty cycle of PWM-Out is forced to 30% 
>> when the calculated desired value of duty
>> cycle is less than 30%. Therefore, the TACH setting must be not 
>> greater than the value corresponding to the
>> RPM for 30% duty cycle.
>> """
>>
> 
> It turns out that the tach-mode bit is in reality the DC vs. pwm selector,
> and defaults to DC. For pwm fans (4-bit fans), the bit should be set to 1.
> That means that pwm1_mode should be supported to set the mode. I'll add 
> a patch
> for that.
> 
>> TACH-MODE is never modified in the driver, so its default value 
>> prevails: 0.
>>
>> I'm wondering if there isn't something we need to do to make sure 
>> we're not under those 30% for 
>> TACH-Low-Limit/TACH-High-Limit/TACH-SETTING? Forbid the user to write 
>> (or clamp instead) <30% duty cycle. Forbid the user to select mode 4 
>> if current values are <30% duty cycle, or update them to be >=30%?
>>
> 
> It also says that the "the selected target speed must not be too low
> to operate the fan", which makes sense. It also says that the requested
> fan speed should not be below the speed translating to 30% duty cycle.
> However, that is not a fixed value; it depends on the fan. Some fans may
> operate at 500 rpm with a duty cycle of 30%, others at 3,000 rpm.
> Looking at Figure 26, I don't think the value written into the pwm
> register makes any difference in Software-RPM control mode.
> 
> With that in mind, the only thing we could do is to ensure that the
> requested fan speed is within the configured low and high limits,
> or in other words require the user to set the limits before writing
> the target fan speed. That is a bit circular, though - the user
> could still write the target speed and _then_ update the limits
> to a value outside the requested limit. The best we could do would be
> to sanitize settings when the mode is set to 4 and any of the limits
> is changed, and return an error if an obviously wrong limit or target
> speed is requested (target speed outside limit, or low limit >= high
> limit). Do you think that would be worth the effort ?
> 

It depends how far we want to go to prevent the user shooting themself 
in the foot. I think the kernel's stance on that is "let them"?

The "benefit" of forcing the user to enter a value in a user-modifiable 
range is that they wouldn't unknowingly trigger a too-low or too-high 
logic within the IC.

As an example, my bank has a limit on how much I can pay by card per 
day. However, I can instantly change the value through an app and retry 
the payment again right after if it's been refused.

Would that be something interesting for this speed limit.... who knows.

Another thing we could do is modify the min and max values if they are 
higher and lower than the requested speed. But this is trying to be 
smart, which I think isn't something the kernel is aiming for (as little 
logic/algorithm as possible)?

So... I guess, the answer is "no, not worth the effort"?

Cheers,
Quentin

