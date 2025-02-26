Return-Path: <linux-kernel+bounces-533663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE179A45D6B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17751683BE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305B62153F5;
	Wed, 26 Feb 2025 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="gHldOx0q"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013064.outbound.protection.outlook.com [40.107.159.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0E92153C8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570227; cv=fail; b=WUOQASu7lt+LA20nXcX+jIeTtbY3UAAFPUJga1vvfsz1k8SX4GPU5KBGR/Yd9YTd9oPekntWcDq554aztvDs6hmXZQ4DJddMQJu7a3py+293qdy6BiqgdzG3c16PZcXvC7r3s0EzMyxpB2sVdEVMnVVFa82wVXhYX2xxqhlj3Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570227; c=relaxed/simple;
	bh=tmcv+BwmUsvpD8sGWNFEisOYeTvXtl+yni1um+EEajU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fdEiPurvjIC/TB7mjq5lCpq8r/n4b78wiaHVkAEAcjWC77JbgXQ5YD2ZeI55xdjWCc8gDlwKVcf7Ub46o+HQXcj5QeG4Smw/kSKYWM1TYyn9/Q4Eixj5QqxfpEVb/fkHVUOBvfRxXKDkjPUssSGOxNwiDF/2rx9lt5t/rjjL/pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=gHldOx0q; arc=fail smtp.client-ip=40.107.159.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaK6DN87anPx+lz6MwABnSi9UJMqD/w0rcy/wno5aFUrXPhs9OXP2Y2QV70DWbTKXdmhMPTDwfZ4X2qz3Qf9AlmYdG4hUL34KJdNLJ1UoLS6pvoaI/9NOWVG6pYAV7CCuTUw1VfpfaIjPBtmblp403BH7AZ2DhrfiokkMEthHwPtIgf/69iiL+Z3kSLRrfMu8RLvt7GrxoJozzT2QQx4aTe6xLvk8fG6hddIjNwMdDNwGnAKSejsF33fNHEPZEXN+uqHngmhDm0uanNDSsNVa9W1WrZ9pllNPQV7SxPa1S+dgmD2QZMNC6i3fPaVpbH3DctLmWCqJIWj03UYsS4QOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARlc+xcri0AhBumXNBXSoRsvaYTls3eVdJeFZXsDum4=;
 b=bz311Kx2rRCnheIgepASD8UxXKdN17Q2+Ov5kzu6l7h/lBji2Ih8F8HYgTucs6Qb8u/VD3bSVqIeP8hLya1P3varbOepf1chAct//zbN4KuxTyeorP0WK7KQ10kfdXnAUsQfjE9nn0e3zDgZ8FwGDsbeCXLdn5y27CPw7jrXuBQR2m6jopyBxpyB5Ueheq6nqt6RnsDe6C3IVJqDO76msLalbDWGmUcseIv7DhxdJC2Akk4txc+sfowwQT2GKi3K96nUCcTzMhxExy1FKi0Zw5lc8/9yabK3Z+KhbXZnrpEh4LUaC4vSTDb/fjimK2tZnzbyU0dWf+MxUt1/Pyxsew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARlc+xcri0AhBumXNBXSoRsvaYTls3eVdJeFZXsDum4=;
 b=gHldOx0q0+0YIhA50USfm+OUmObD34eCWm4G6E394No5AId0lwawe1wc9xRMSNONj2gVKi5lRoyJRILDgecEanKNQIfj3TknONY2DbbGOTqv1s4023hDuFgbLjS1vDq4o5MDHSJcHWE+3u0DPXWoamvO20eqSsOFaXr9oFJ8l1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB8PR04MB6860.eurprd04.prod.outlook.com (2603:10a6:10:112::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 11:43:40 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 11:43:40 +0000
Message-ID: <05f16054-13f1-4826-a2a7-2533e2a5943e@cherry.de>
Date: Wed, 26 Feb 2025 12:43:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] phy: rockchip: usbdp: move type-orientation-switch
 further down
To: Heiko Stuebner <heiko@sntech.de>, vkoul@kernel.org, kishon@kernel.org
Cc: linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 sebastian.reichel@collabora.com, christophe.jaillet@wanadoo.fr,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20250226103810.3746018-1-heiko@sntech.de>
 <20250226103810.3746018-2-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250226103810.3746018-2-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0361.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB8PR04MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: e3007c19-4260-4479-59bc-08dd565ad097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tm1Ba2d0YkNGTThHbkR2aDRHQnVlSmNNS2EwWWVUNitBMHVUSTNraDNubmlK?=
 =?utf-8?B?S3Z4QVRFT2IzZlB6d3MyT2FreHJlU2RNa0lMWUkvL0pEdDlQN2JYbTJ2QXBq?=
 =?utf-8?B?T1hMcWxLckdUN1dVVURGZzdMMG0rNTRyTlhkb0M2c211Ry9yZTF5L1ZiNGVu?=
 =?utf-8?B?NU9zZm90YWJscjVNOXRNU3g3bUU0aTk2Q2dSVnBHYndKNUEwODVsYnBJS3RD?=
 =?utf-8?B?M2g5bnpvRVRtZkFOampXeWRRdCtDYURPUzJTWWxHVUQ5YWhzZEZTczlHbEFi?=
 =?utf-8?B?WmtadzBGTzJsK1gvMUVUM0ExSDVkZEl3STE1TTBJK0s5NEp1UEV3bURqVmho?=
 =?utf-8?B?ajAvSUdQZUxQR25CWHp2cS9qdGwyMXFML1l3QzRvb0RvYkVGUSs5WklnbzR5?=
 =?utf-8?B?Mm5RQXdwdUxYNUZuRndZZXB0d3dDb2pob2MvcDU0cjJWT2NPc2dmWHlCdDVT?=
 =?utf-8?B?T1pZT2thTGRTYUxtWUoyZUpLUk5QTUlXYjRjK09pdTlNWDNIdzRwU0oySkd6?=
 =?utf-8?B?Qjc0SjJDcEpHN0MvbGVrcThDM0kvaDlTZmMwUkVibnZLVWQ5MDhxWnFsWU5a?=
 =?utf-8?B?QkxBNWhOcloyZG0wbHZqakZNclI2YmtTampoSlkxMnJySzlkNk9ObDN0Vmwy?=
 =?utf-8?B?cmJyOEhOUm5XRHJBSHorZ0JhM2dRUjhOb0h6MTd6Wk90TG5iTExOcGc2TVpM?=
 =?utf-8?B?UTdXTmJjck1iWDNCeGJwWGo5TGt6OFhtS1Z1TmljUDJTRGR1dENGcDFLR0Fl?=
 =?utf-8?B?M1p1MVY4OWZ4MXZsRTNrRWZMSU9ZVlR5U2x5allaV0x4bmpkcWJpaUltOWZX?=
 =?utf-8?B?S05YSzRpQVRTUkc4MmI5bGJPZVZKaWtkZktpVHlCeHlhYW1jTGcwTnNwbUdw?=
 =?utf-8?B?c1V0MzI1MjVpWi9PanVaak1nR0hnWlZqUkE0OXN5TTQ0M2hJSzZRa3puaVRk?=
 =?utf-8?B?d3FPd1ZrNHlFek5hdCs4NjE5YjcxK0VhM2lHb3B2OTV0SW1KWDdzY0VkVmRS?=
 =?utf-8?B?c090bTZBdTN0ajFRWmMzZzJVcFRBeWNCTTNHVmc4UzFqcy9VbG15L2tTUHJl?=
 =?utf-8?B?QW9rUXhZRVRlMk1zL3lsTi8xa3N2bVhZbU1IK2VzenNuK3M3bVUxYXVWWXoy?=
 =?utf-8?B?R1BFcUJGZzlvMmpSbzRuYXBBMVFXQ3I2NzVrYTZRUldJeDZUWTBtWlhPQWhN?=
 =?utf-8?B?c3ZqbU9RYU9IUWNMS0xFWTFQeGh2TFRBYjlOMHFWOG1tV0xzZTNHVkIwOXgx?=
 =?utf-8?B?WkpINGtvZ1FnVEhXcWxlbEpqYk5keTRRVkhINVhKZngxYXlCeUt2anphSGlJ?=
 =?utf-8?B?am41L1Vtd0Z6eEpNWGpOMnhBQ2IzTkd1NXVPdTE1UEo3QlpITklGemJxTWdQ?=
 =?utf-8?B?dEplTlZSS0p5d20zcktndmtCTUJsNDhvM2RiMWswYXVBVkNjNjhBblphUFFq?=
 =?utf-8?B?c0Vua0lrVWpiT3ZXVHVqN3hTODRlVmttbE84c3Zsa1lGQmxhUnFWRFkzalEr?=
 =?utf-8?B?Y3p3dG5FdzNYZUlRd0lacFdWYXhQQmpHc0J3RXBiNklHQjRNcXpaaVRLN3hj?=
 =?utf-8?B?cEhTUmJvZEdsVlNGS0tNNG1oNlZBNmI3S2t3SG5TYmFyMk5ycTg2Q092UGJJ?=
 =?utf-8?B?T3FtdzJ4ZUxvWmdoSkF0RDdUYUQ4QlRkNDNmQXM2eWQwYjRVVExFSVNRNjh4?=
 =?utf-8?B?M2N5ajJLRkFHSjQybEJlRENtTUxPcEsvcURvelRsbWt5TmhHeCtGODd1b2RX?=
 =?utf-8?B?MDdzcTdQanVyb1Jhd2tUUG4xS09kL0tRWGRhTHNZZWlOMnNtcVJqU1ZxYk9I?=
 =?utf-8?B?UTJWTndGNmZWbW9rVTBpVVJtWHgybGRmbFJyRGZ6eUZFYnVQUEVUcUphREQ5?=
 =?utf-8?Q?gxx5EUr08s79x?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDNRVVRIQ21HVTR1MzZlWTNGdTMwMkE5OURpazZWZ0l5N2ZCYjdZK3lVL2ho?=
 =?utf-8?B?REpIQzN3ejVadkw2eDBzR0NFV0xLRXQrOWdOdHREODUvc2hnUFRNdXdoU1Z4?=
 =?utf-8?B?ZXdrMmdaaktscXF0RW03RzdDb3hvNWtKcTdnL3BXV3NCZU1qMVdPQit0U0lT?=
 =?utf-8?B?QmwrdkJ1bjMvblBFclZZZWp1WXJybmVrMXIreTBNRzlHOTJkMWdJYlVLVlUx?=
 =?utf-8?B?UW95ZlJxanhnNnZ6cms5VWIrVEcwUDR1eldQNEtPT1JIRDZjc0tGNHBVeWZI?=
 =?utf-8?B?N3hmUEtCK0xCZTMyM256WkJNTWJXQm9Tb2JwdDBhY1MwZXNsdnRiQ3NXeDlP?=
 =?utf-8?B?dFJjZ1IyZy8yMnp4czhiZzc0L0tuZDdCNG4vdFZpZXdlc1JkcmpWMlBRRUI0?=
 =?utf-8?B?MjdTV3JOaXNGS1RYTElmSThpRHA3Zmd1VTJMdkducFp1N0Zaa0ZRUzNkWDZC?=
 =?utf-8?B?ckdNdHd6Z3JtMklYN3J3M3ZyT3IwMzIxWWdiQlhjYmpwNXBqQkxyMWdyT3hQ?=
 =?utf-8?B?L1V6d2t5Nm5oUUhCRU9pUTNKVkk2VEZZU2ozYzBuZ0FxZmJTVmQycXhFUHJC?=
 =?utf-8?B?ZEV5QWdVREcraE40bERNNFdmTXhUODBWeDFNTmVVUzlxZStXOWVNa0tVMURP?=
 =?utf-8?B?bVhtSWtoM3pjV2NITmo4SFVnOWJwWnJpU1ZIZ0RkM2cwaEc2cjZFK3E5dEh5?=
 =?utf-8?B?cDQrQ0dPQVg0MzlQQktXYjV6N0ZvVHZUdlc3UHlHWXhEQzlEZ1BFTlJmTGhq?=
 =?utf-8?B?b3pGdjg1bVVEQzIvUDlZWE5acHNKUjV2MjBQN3VRZ01nVDcrdDR0dG9sbVBE?=
 =?utf-8?B?bjk4dEFHanYwT0xxNTFkb20rd05Vd1RvaWVZZ3ZtOXVzQmY4ZG1iNWJ4eVdY?=
 =?utf-8?B?TGowOC80cC9NMW84SkNmL0w2Y2FTTWxvelBIbWQva1VTczFaT0xnRHJZQmRu?=
 =?utf-8?B?U3BhcmJLVFpiOTZabjB0akNJVndLMXhMdGQxY3RmbW5LU29jRTFoQkxhSGVw?=
 =?utf-8?B?S21BZGhwKzBKVXdNVTBxTTJkeWNjK2dOY1dGcDgwdmx3aHZhWjQvLzVNYWJo?=
 =?utf-8?B?WnQ0UEU3ZmJzR2k3RFozckREZDNvY3B0b21FSWlGY2NIb1RadjBrYVRBcDlN?=
 =?utf-8?B?K3N6OG41VS9palRKSytNalM4RHRuVC9TTXVJbmNsK1JURExVaThYZnlEN3Zv?=
 =?utf-8?B?RkVrc2VFbkc1Y3NLQ0dzTGdjWDRHc0I2UmQrL3RDejZQM1MwNWYrVzR3b29k?=
 =?utf-8?B?OHp6VlhJaHVxeDRkUTdjSWkvcDZqeDdhckhvQ3NJVG5RK3hFa2ZvOUFrbXl2?=
 =?utf-8?B?SkRXYllZSDQrQ2g3Z2x6YXlIc1JaM0lGcU9UdEJldW5YZFcreGxZdmZDc0xW?=
 =?utf-8?B?UUovaUk1bEFQN1lsczFuOXlsT1AyT1pwamhOZmVHMWZBRWdFNWZRVVlEQWlS?=
 =?utf-8?B?Z2pIdXlJbTgwcC9keEtyeTIxQUdLZHdpKzJWWWNYRlN1OWo2aitPWWh2KzI2?=
 =?utf-8?B?aFlzSnErbkVXOGowTm1TS1pvd011RGFuamNqTXdpVU1HdklvcU95cC82ZGdz?=
 =?utf-8?B?aytNUCtUU1VJSTkwNUk2ZXpIKzlMU1k3UnBnbjI3b0dVRXIyeDhrL20zajh3?=
 =?utf-8?B?K3RXaHJhS2xuWWFsRW96ODZXdkhlMUF6ejhGejlFajlJcE9YRWgrTFA4SHBi?=
 =?utf-8?B?TjVhME9Ka2J4cCtxSDY3bnBtcklSZUVTcmpGV1MwNGlRa1Mwc2Y5alZjWTNV?=
 =?utf-8?B?b01wTzNna083UHNLdGJhcWE2TTEvY0x2YkZGTWtaa0xkeDVETk9mbytBd3hE?=
 =?utf-8?B?NHJVWENoQ3FNQ3M0RDRUU2ttcnVBeUlBYXpzWXRyN3kxMEliV1ZjdStWbEZj?=
 =?utf-8?B?aW1tZGdkd2NkR3VGNFdWbW80MlVPUkRocmoxSU9wRFhQR1FUVTd1dWpnSnlk?=
 =?utf-8?B?dDFhQ0VCY240Q2RBWS9NbUViNThUa3d1ZThsTWtBWFAvemZvTGdPMm1wMnV4?=
 =?utf-8?B?M0dVK2FWUGdOMDRZekhoYVlrQzFnY2tRTWg2RFBPR053dGZJWWdJdUZaTEhk?=
 =?utf-8?B?bFhZVGFMcnJqRjZpeHIxbTJqbnlJZnY4N2lyMnpkTDhWdEtVTk5DWHF2QjBE?=
 =?utf-8?B?WkhwdmRnbVp0aFhHbWlwcWtaZEtRVmlCR0FxbGNSSElpazNhQ3BscWR1MFl4?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e3007c19-4260-4479-59bc-08dd565ad097
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 11:43:40.4666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmS4T2u+kZRutd+eQ9HhZ9EcReaVtVPj0WTSJll8JmEAptzdIET6MGzROefy1Ag6xs3TpJeKIJ6tSilBpGtZJhvJdq3lLqPsfqWa50CgZJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6860

Hi Heiko,

On 2/26/25 11:38 AM, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> Move the typec-orientation-switch functionality further down, next to
> the typec-mux code. Not only brings this the typec-related functionality
> closer together, but also the following change needs access to other
> driver functions, that are below the current position.
> 
> No functional change.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

Checked with `meld`, the - and + diff are identical.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

