Return-Path: <linux-kernel+bounces-519267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E41DA39AAD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8D01893622
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E590234989;
	Tue, 18 Feb 2025 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="RGKyiD8i"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013058.outbound.protection.outlook.com [40.107.162.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94A21A841C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877887; cv=fail; b=aIP7ZY75NeSFGXFaG6EpS8+9zwd82OtZu+poZZP198X2z5oKEiZEmkq62p4U3eENZm5+senM6ZGDRZxL748PucIB6KoCTy+QKbjf/UgFvONOlxQzaybIoJYv0fx0+qpJHVssiB+RIN02bl0GWGYsyBUuPV38dhMniJoEnWJ2a7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877887; c=relaxed/simple;
	bh=3j5mn5LZvrYfsT6MlqH92WCMNrFQRAAaRAo7sZAeE/Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sRlj6wmYzLsqKp1uTieY1VhqPpOYgLjV/Pue/zP8OaTJs5BeDsMfc7N6lXpzGvP6yxAeFgFpBewa8J0UKIYVShfPQr8ykFrabq42nb0xHi57QnXUgDDTvvcLfCgDgdcxP8sL3f2qB+f3iNqIJWmfpAedisWZd6QlD/HweTIDpL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=RGKyiD8i; arc=fail smtp.client-ip=40.107.162.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdOfiDm9IkyfihSYQ3O9+mNHaoAV7ID4lcj6TGNNYevVLAVY9hi+5eW2qrLOE4LFYyFtjxYMlXd40ATXhxwv4C/Fi8+FoBrEKvfsz3WCwRauUBzIDwaMvuaq7SHW/NkdvmtCJ3Xmi5LtsDPBd3CkY7PST1gm1/oWL/uP6rA2vkBqojffHGljafw4w40NwrqGFygQA3Q8Jd0/0M95sOKpjB4IbMcbWO9DQUqkIKgMmFSP5Sr3t8L6UWVjqBCxFtq1Z8ASkIfHcQf1s0fWjuRyBjPFibJ4g18DAjoyHc6XyGxWrxkcnn1hr437PlNdlSOVMMRnhq2NsqYYDv/Of9wdmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTDk8bCKNwh3ddNA4q5rvPFoDnOSbLGiIfQ+3VuSKEM=;
 b=rfHh27qfhAv6d4OBzDAKA/jIXAMXlhvDIulrOEB+GG+QyFPAvWoLWljIJS0SYg90/e0yd9IrJvbTKE9xigmMQ7luQe1Kw9ZWErM8VrYPhcCfUZZRCIx9hCHOvmvBa3Q+cQEHArld8tSaMUBsqJ4ZJsBAcdieM3iDY/VqTxNsxu2aQzmb1uSaRhA06+/xoZh2HuVBnSBotyi4b40GK7i7EqRQl8OEghhHKz911lw324wC3PcAaKHi+xyDVmDku0gkq6MTiSX9+pDwZxua0792p53W6k5T4HDj8u2/RQCFV76cYWU+FkXLarE2PyLKkTXIpbfjSFE8hfDUn4Vh3mUFyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTDk8bCKNwh3ddNA4q5rvPFoDnOSbLGiIfQ+3VuSKEM=;
 b=RGKyiD8iw29a5W0f/pcCqpzqHQVnX3CC3Rpe2RXFcuMCjNN+oR3OAo9DEmgTVO1qWols52BPb6g9ydAvbQSypJmlOxH4o1ZsBX/Z+BpqtnfeqWL+RA+syAm6NE0oAybB9u6FkJIb7XBo+yVFb5dq1SfOvs9f3Bhv6khnz8SSPWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB8PR04MB7115.eurprd04.prod.outlook.com (2603:10a6:10:128::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 11:24:39 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8445.016; Tue, 18 Feb 2025
 11:24:39 +0000
Message-ID: <6cac5ab1-0b76-4f28-b8e1-72760464b3d1@cherry.de>
Date: Tue, 18 Feb 2025 12:24:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: add usb typec host support to
 rk3588-jaguar
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20250213163013.1616467-1-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250213163013.1616467-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB8PR04MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: f240a84e-b818-41e8-c911-08dd500ed531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUhZbUxyTjhMbEl4SkI4Zm5IYkRxQThYeHhzQjY1ZkIrWnpnVXBMVytCM0Vw?=
 =?utf-8?B?Y0lCcmNId0FUaE9MZWh5YXNMWUJYMTRtOU9RVmd2TnhFd1REZTgrVWtYcEYr?=
 =?utf-8?B?Zzkyem1SY0RBWHJSOU9GaTY0VDc5N0RtSUc0OWplVDJqRHVoVEpHeUdKUUZi?=
 =?utf-8?B?elJwbTEwOWpiUGJXQ2xWMjNqZE9jMmdlaWdlV3p2ak40bVAzMkk5MnhHWVlp?=
 =?utf-8?B?bVBSb1BLNmpEYVJaRVM1RUxtK0tDRDN6VXhiUXpkYVFDNEJZdkRma09Kc0NJ?=
 =?utf-8?B?Wk9iNks4SjhWQ0VPSTVuRXQ0M3dWR3ZraW93Slg1MjhURGMxT1ZiZHdpYjN2?=
 =?utf-8?B?VjZTV0xWY1VCTjVRbzJqYnhraWV4dWxWb21TeUpRSjZ0cXJURGhHQWRUQjVj?=
 =?utf-8?B?dFF1VmRwNHFKOUlFQzhvVnZucEQ2ZzZ3MVpiYWYxV2QwSFBWWDNTUThXbkRk?=
 =?utf-8?B?RzRxQU5tdXN0KzV1VXZyV2RXT3BCTlhFSVplV1hNam5xNlpQTEFGNE1uQVBH?=
 =?utf-8?B?SG9LZ1IvUzk2Q3NVOFI0Q2d5RFg0TFlkcFUxcnBvRHVKcmZpQWdmZEkyVlJj?=
 =?utf-8?B?RHo5RU5DVzU4dG13cFhKN2daZHJKRU9SNTJPSWVlUWw3cEtaQVNHY2FZQ0Nq?=
 =?utf-8?B?cGQ4anhNTlJSd0VmbURYdGU1OURYWHFEd1hwRzJDazJSaHRWbk0vNk85a29q?=
 =?utf-8?B?Qmd4aFVrdzBzWHRwM09SOGVzZ1BzTDdEVGhWSzV5dE8rYlFKYlkwZnpQUFZq?=
 =?utf-8?B?Q0RyZVRYQm1WaW55bnpIUWxyMUJ6a1VIZlhjeTVDdEZHZXhxcmZsTldqK28x?=
 =?utf-8?B?aThXUHl0TmdqZ2g4VHZva01oVHNxMHI2M3ZBQlBXZFhqZ3B2RXJwWEJlUHps?=
 =?utf-8?B?eXlsMXRpalRRS3NTSXBRWmxQTmRlUFBoRUZzYkVkYzRGM1BzY3hmWUxoY1ZF?=
 =?utf-8?B?djFaUUc0SUxzUUs2d0JUaTJOWlJwQmcxdTR6b3dsNU5ZNkVCQ0MrQWthdnFO?=
 =?utf-8?B?QUtXa1FLeDJ1TTlGeFNYcVg3V21MdWpuOE02MDkvYUhNR2l5cGgwMXVIMUkr?=
 =?utf-8?B?ZmNxNkJhTXY1K3Q5YWRnZjJtS1RENG9IMzNWNUYvVWVYQlk0ZzVaZmNySEZF?=
 =?utf-8?B?RFRISXRpZTN6cStwYjVQblFxMkt6czhwUlpDR1VBeis0U2xOdDRXdTlEWjJP?=
 =?utf-8?B?YndyaSt4alhXcENucTJPSFUzNXJ6NzhlK1kxblZzNUF4bmZ5ampRNERjeGM1?=
 =?utf-8?B?dlF0bzFQMFBRWU5yVWdNQ1l2WElGQVZRbGZlSDZ6Sll3ZXU0UTlObVNMR2lL?=
 =?utf-8?B?WFd5WUdUWW5WR0EzdEU4ZTVpclNhNXhndVJCcDNMaGpHVGE2d3V2ZE1Xcm45?=
 =?utf-8?B?M09xZ3JOWTh5VjgvUVRuVnhybHJiNzVReUhZSFNUUWJnWEJ5QXd6SzJVSmpW?=
 =?utf-8?B?OHl1bEtKVGRXUU13WnFJVG4rNXE5K20yQ29yaitvVGYwbkxXSHZKVnZQNDc0?=
 =?utf-8?B?Qmw4bzFtVXFiY2c5L29saDVicWc0UXhYaW12ZHI2U0NmTnhuTjRTb1YvUUFz?=
 =?utf-8?B?a0tGN1NGTjIwNkJMTHh5Y2R4SE9QSkpMWTdYaWswOEVCSEdaR211czdybE13?=
 =?utf-8?B?L2pTa0RwSHZYQTFDVzNBc0JqN2c5NUI2NG9PcjRwN0VZVmN3c2xPSFBlaHJI?=
 =?utf-8?B?N0R4R0tWNGliNXJkdGp1cXY2bHoyR1R2L3FlRFplTDJ1MFNqajZWRVJZWHdS?=
 =?utf-8?B?R2R2Vzl3VGttTjhLdytUbld1d1BybXJrRWF3LzMzczVnQTZPa1h0alhZV3NB?=
 =?utf-8?B?T0ZUUi9jbUhhTGl5cFd2Z1RGTHlWL2tVbllXZ0NrSWlTdmV4a0Z4K0VJTWpP?=
 =?utf-8?Q?8Xkq1Q/eBIvlS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVQ3bndhSktnSHFGMG53WDJtQnFFSjBJK2ZuZVhLQy90MXJpaXQ1UlJ5QXM3?=
 =?utf-8?B?Z1dzakRXa2YwSVRDNE9LUlAxRG1PK0xoZDhPODRyZEVyNTF6bkJhU3d2b21Q?=
 =?utf-8?B?Z0pCNVB5R2l3YXJsZmhtQ2tqb3ZIUk8yd1FBZDJSMFRzeVNzRUtIQ0ZReFVM?=
 =?utf-8?B?M0cyRnpUN2pqZUhJU0hVck13ZFk4Y2VHUENQaUpmcU51anlqQ0ZDcE5HSG02?=
 =?utf-8?B?TDEvZlprWUNobGhzV2czaGM5a2l4UTR2ZCsyVkJPWkkrUnZNWTdSeUQ3dUR5?=
 =?utf-8?B?RmMyYTlKeDh5QVV3OFl0b0Y3OE9wTG5rUU44aXlWVkd2ZW01ZGgySFpYMzQx?=
 =?utf-8?B?TjVocG1JY2lkVVkyVkpUeVVULzFFa3R3WDRJbXpETmllL3RDRDd2VllzUXBR?=
 =?utf-8?B?dkp3VWYya1Jtd0xPaHZZQlpwb1BxWG12VmxSMllsVDkwZFFGdFdVVUhzMlRB?=
 =?utf-8?B?QUtzcHdYb0JnQVdyaG9CRmZNWmNqM01heGtTa0NSaS9pc2FJV3F1MGcvM1Ns?=
 =?utf-8?B?RWw4cnFIRGRhTm1xUmM3aFJpbU9kTVJDaEJxOHlMeFowU0IwaXU4ZHJvNWVn?=
 =?utf-8?B?L1kzbXJvdThscDNLR1ltTFhmOHRDNGdKclU0UmEyTGQ5QW5HUVRKZkdXdTF5?=
 =?utf-8?B?blgzSTJoWnNnTFV5bGFDR1dJcG5YTmwvNXdEdGRWYitFdjY1VFB0YzJYd1py?=
 =?utf-8?B?ZU93Vno0RzR3Uk5MMlpHeGtnTHNRZEdYOUYyc2lVT2M1Z1BGUExmMjBmZ3hH?=
 =?utf-8?B?WUpsWjBhRmYzQSs5UWdubVQ5VEhCYm9tYjloVkFXRTJVOXBVbFNOdUhLYU80?=
 =?utf-8?B?REJ0NXZ2UkdReS9qMW04Sk95R3o2UDJqNVllaGtoRTU0S3dDYUpaM1VNa0kz?=
 =?utf-8?B?K05uR3BUNEdyNU1SSUNSb05WOTQxdnplRzYxRVBGNG1aU1hUSVRxT0l4aDlI?=
 =?utf-8?B?Y0hiV2RlOFlmT3BGUC9UbGZaeVdqS1BhUU0wSGxIdVZvSzNvQkJFVjFJR091?=
 =?utf-8?B?SnBKRkdhTlplWFJFUld2ZEFZTFExUU12KytUWThUTFdZdm16YWwrSEtib3lm?=
 =?utf-8?B?RFF0Szd5ZnVaUGw0WjNRU2oxeTBEUEpRVnAwcmQ3RmhScjBXbmhpZHI0ZTdM?=
 =?utf-8?B?VFdxaUlmck9tVTBYd1I2UWt5elk1Y2JPR053MUJldlRKS2FCUTRVTndiTGI3?=
 =?utf-8?B?STBqR3lBamFFeW5oTjkrd2FpdkZ3Z0NISGtCYndHUnJ6SHJOVVFaR0o2K21Q?=
 =?utf-8?B?emE3Z1FFVW45dU5BRGFOUnFOdEZjdkZGRzRDcW83OUhmd2JMaitiajJMQlVt?=
 =?utf-8?B?YmlyTEVZaWxNLzd1bzBXSFlaTkZ2ZXRDdG1SdDRxVzJqYWpCREw3bUlQZk83?=
 =?utf-8?B?VjNrZkJKRGd5UWpCdzMvZDM5aGFJRlU4ZUhTSnpoaDQzVm1JNFdPa1ZPc0Fi?=
 =?utf-8?B?OHAxWDQyTGlYVXM0TmdvWENQMGtWa3hQTDNXdXU3aWpqbWR2bTh3NjN4SlBG?=
 =?utf-8?B?d0s5QUJqL1ZzSFZER3BtM0p4YkxRWm5FcjBaM3YxWnVaY0Vyd3F2ZHNjUm1v?=
 =?utf-8?B?T0JIeU5xWlRFRUtDM2xpMEdtUVh0dkRUOXZwUEUvOWV3VWxQTjhsaXJsNDZx?=
 =?utf-8?B?c1RoNHN2aWVOelJJRmgyc0tveEROOWVNWVd3a3NXOVl1Ym80bEVkWTdlcEwv?=
 =?utf-8?B?NkJYaXpVeHArSHp2V2dZVmw5NitkRzNUVEp4aVJDOFNLemJxZHE5Q1RSMElH?=
 =?utf-8?B?WHpNbmNWR0RkN3ZlaWcvOTlYUWZDRFVHY1dKMDBIcUFyM2VFd0xEMndMR3pE?=
 =?utf-8?B?WDJpZHJnVFUyY1N3eGxhNGFXeXk0MEtDb1FSclNSUlhPek1YMlBvM0tvMlor?=
 =?utf-8?B?bzJHWndUZGl2VkxiUXRnaFBuVkFXU0syd2VnVm9CR1RJS0VWWW1xdWlxV3hV?=
 =?utf-8?B?Sk9pMFVkRisrYXlrekZTcnJERzZXN0RjNk5ITy9MQUdIK3o3L0cwOTFOSEJa?=
 =?utf-8?B?czZvWksrNkdFT3BEQlBNOUJtUHR3MUpKSGV4Qnp6Q0tZVS9LaUpqdnhtQjh2?=
 =?utf-8?B?Z2kySWxWN3FDSUViQ05sMWhnL1Jldi9yL25wZkE1bkltOWN5d0JzWWhOSE5B?=
 =?utf-8?B?THdlak9hWTBUOUwxbkVkVVdDSFZENFkvKzlEV3RGUXNVVlBYWGxxVVR5YWll?=
 =?utf-8?B?TUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f240a84e-b818-41e8-c911-08dd500ed531
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 11:24:39.6785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VlV58xiMoq6dMkTJ9nI7Sw+7FQiyfWSqAPDgfLcnKSKj45DqVMJTjzNZoG9hszL6DTRKDDmAbQOyAGFT8gI/pQk1lFcHTzT5aZqkmc1FSwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7115

Hi Heiko,

On 2/13/25 5:30 PM, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> Jaguar has two type-c ports connected to fusb302 controllers that can
> work both in host and device mode and can also run in display-port
> altmode.
> 
> While these ports can work in dual-role data mode, they do not support
> powering the device itself as power-sink. This causes issues because
> the current infrastructure does not cope well with dual-role data
> without dual-role power.
> 
> So add the necessary nodes for the type-c controllers as well
> as enable the relevant core usb nodes, but limit the mode to host-mode
> for now until we figure out device mode.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>   .../arm64/boot/dts/rockchip/rk3588-jaguar.dts | 178 ++++++++++++++++++
>   1 file changed, 178 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
> index 90f823b2c219..329d98011c60 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
> @@ -333,6 +333,52 @@ rtc_twi: rtc@6f {
>   		};
>   	};
>   
> +	usb-typec@22 {

We have a mix of node names in the Rockchip tree, some call it usb-typec 
some call it typec-portc, including the device tree binding.

> +		compatible = "fcs,fusb302";
> +		reg = <0x22>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;

Should we have a pinmux for the interrupt line in GPIO mode maybe?

> +		vbus-supply = <&vcc_5v0_usb_c1>;
> +
> +		connector {
> +			compatible = "usb-c-connector";

Reading the binding, I'm wondering if we shouldn't set self-powered 
property in there as well? Jaguar cannot be powered (or at least wasn't 
designed for being powered) via USB-C and I think self-powered means 
that? Not sure to be honest.

> +			data-role = "dual";
> +			label = "USBC-1 P11";
> +			power-role = "source";
> +			source-pdos =
> +				<PDO_FIXED(5000, 1500, PDO_FIXED_DATA_SWAP | PDO_FIXED_USB_COMM)>;
> +

Should we have vbus-supply = <&vcc_5v0_usb_c1>; here too?

> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					usbc0_hs: endpoint {
> +						remote-endpoint = <&usb_host0_xhci_drd_sw>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					usbc0_ss: endpoint {
> +						remote-endpoint = <&usbdp_phy0_typec_ss>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +
> +					usbc0_sbu: endpoint {
> +						remote-endpoint = <&usbdp_phy0_typec_sbu>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
>   	vdd_npu_s0: regulator@42 {
>   		compatible = "rockchip,rk8602";
>   		reg = <0x42>;
> @@ -394,6 +440,52 @@ &i2c8 {
>   	pinctrl-0 = <&i2c8m2_xfer>;
>   	status = "okay";
>   
> +	usb-typec@22 {

All the same remarks as for P11 above.

> +		compatible = "fcs,fusb302";
> +		reg = <0x22>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <RK_PA4 IRQ_TYPE_LEVEL_LOW>;
> +		vbus-supply = <&vcc_5v0_usb_c2>;
> +
> +		connector {
> +			compatible = "usb-c-connector";
> +			data-role = "dual";
> +			label = "USBC-2 P12";
> +			power-role = "source";
> +			source-pdos =
> +				<PDO_FIXED(5000, 1500, PDO_FIXED_DATA_SWAP | PDO_FIXED_USB_COMM)>;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					usbc1_hs: endpoint {
> +						remote-endpoint = <&usb_host1_xhci_drd_sw>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					usbc1_ss: endpoint {
> +						remote-endpoint = <&usbdp_phy1_typec_ss>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +
> +					usbc1_sbu: endpoint {
> +						remote-endpoint = <&usbdp_phy1_typec_sbu>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
>   	vdd_cpu_big0_s0: regulator@42 {
>   		compatible = "rockchip,rk8602";
>   		reg = <0x42>;
> @@ -851,6 +943,24 @@ &tsadc {
>   	status = "okay";
>   };
>   

Please add a comment here that this is for USB-C P11 connector so it 
gets easier to figure out what's for what.

> +&u2phy0 {
> +	status = "okay";
> +};
> +
> +&u2phy0_otg {
> +	phy-supply = <&vcc_5v0_usb_c1>;

This is a bit confusing at we have the OTG port needing to specify the 
VBUS supply on the port, while the FUSB also specifies it and the 
usb-c-connector node can as well.

> +	status = "okay";
> +};
> +

Comment for USB-C P12 connector.

> +&u2phy1 {
> +	status = "okay";
> +};
> +
> +&u2phy1_otg {
> +	phy-supply = <&vcc_5v0_usb_c2>;
> +	status = "okay";
> +};
> +
>   &u2phy2 {
>   	status = "okay";
>   };
> @@ -893,6 +1003,46 @@ &uart7 {
>   	status = "okay";
>   };
>   

Comment for USB-C P11 connector.

> +&usbdp_phy0 {
> +	orientation-switch;

It seems like we have SBU1 and SBU2 GPIOs as well. So I guess we want 
something like:

sbu1-dc-gpios = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>; /* Q7_USB_C0_SBU1_DC */
sbu2-dc-gpios = <&gpio1 RK_PC3 GPIO_ACTIVE_HIGH>; /* Q7_USB_C0_SBU2_DC */

> +	status = "okay";
> +
> +	port {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		usbdp_phy0_typec_ss: endpoint@0 {
> +			reg = <0>;
> +			remote-endpoint = <&usbc0_ss>;
> +		};
> +
> +		usbdp_phy0_typec_sbu: endpoint@1 {
> +			reg = <1>;
> +			remote-endpoint = <&usbc0_sbu>;
> +		};

Something's wrong with the dt-binding here as it only lists one possible 
port, for the orientation.

> +	};
> +};
> +
> +&usbdp_phy1 {
> +	orientation-switch;

It seems like we have SBU1 and SBU2 GPIOs as well. So I guess we want 
something like:

sbu1-dc-gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>; /* Q7_USB_C1_SBU1_DC */
sbu2-dc-gpios = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>; /* Q7_USB_C1_SBU2_DC */

> +	status = "okay";
> +
> +	port {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		usbdp_phy1_typec_ss: endpoint@0 {
> +			reg = <0>;
> +			remote-endpoint = <&usbc1_ss>;
> +		};
> +
> +		usbdp_phy1_typec_sbu: endpoint@1 {
> +			reg = <1>;
> +			remote-endpoint = <&usbc1_sbu>;
> +		};

Something's wrong with the dt-binding here as it only lists one possible 
port, for the orientation.

> +	};
> +};
> +
>   /* host0 on P10 USB-A */
>   &usb_host0_ehci {
>   	status = "okay";
> @@ -903,6 +1053,34 @@ &usb_host0_ohci {
>   	status = "okay";
>   };
>   

Comment for USB-C P11 connector.

> +&usb_host0_xhci {

Add a comment for highlighting it supports DRD, just that we aren't 
ready to support it just yet.

> +	dr_mode = "host";
> +	status = "okay";
> +
> +	port {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		usb_host0_xhci_drd_sw: endpoint {
> +			remote-endpoint = <&usbc0_hs>;
> +		};

Does this actually make sense without usb-role-switch; set? The binding 
seems to indicate port is only useful when that is set.

> +	};
> +};
> +

Comment for USB-C P12 connector.

> +&usb_host1_xhci {

Add a comment for highlighting it supports DRD, just that we aren't 
ready to support it just yet.

> +	dr_mode = "host";
> +	status = "okay";
> +
> +	port {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		usb_host1_xhci_drd_sw: endpoint {
> +			remote-endpoint = <&usbc1_hs>;
> +		};

Does this actually make sense without usb-role-switch; set? The binding 
seems to indicate port is only useful when that is set.

Cheers,
Quentin

