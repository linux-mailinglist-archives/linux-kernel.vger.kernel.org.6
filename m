Return-Path: <linux-kernel+bounces-521973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE203A3C47F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A57F3B50FD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D0F1FDA97;
	Wed, 19 Feb 2025 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="JX2PORYj"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461461FDE09
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981219; cv=fail; b=S59nqo6WqdLy8tSceuFpjDSJicv1rTaqmEgPbMwvbn4Mj5nocssr+zzMHKPA0L8bKduajuLcJiYYeFPVJVmGrNQnPu9KhjBe2nwQgWQsjUXgyjTYUhqqHx7VMsfeU+1Nw9xQEtqlTlS1gO53fghMK1pq1R8yhfDfQq/pwrmClyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981219; c=relaxed/simple;
	bh=wQAeUtGCr+MO9YsR317fJ5W/90iUzGi6Ae/2e5wQWxA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oQjrylcMXMXoETQayvAHiS9L62mvFLiwi4U8nuVD3ayA/MLAh4aaC6NO6UwutwvMd6wupU8yoeTs5evBOzoU8JNfqnOQtwokwQQz0pZM2uP/U6NpIEos7nLdcILlbzvUEclb1WU3WN+DVDAHI9b4HT6CbpgM31vk++9xbAHDcV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=JX2PORYj; arc=fail smtp.client-ip=40.107.20.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QcCMrw+Sh82WkfroVwQskHBv/0cKYMhwaM/7vitfTiRduR5aLHzZkdR4baCzF8A/UCfJ5bFumCU4EozzYJe+ogojm/ztL3ZagXKLS5LV1+Inix9s8zsO7dMD3HW/WMu6SvJT+nPBhj0w0VWfEBRvG5ARkyCHxx5CPxvbmrIk+H/aHUcumsBzx/D9ct9F9Gd0TioPfcm3pL3DOMoUp3n3fJGNBI7f6dVveFnvvAewtUHiUyWKOJujS31hzkr6DkN9fwsbiRCR4jJXfTHRi565kC4Tw0SZNu2BfmMmhHePyculHvS9CkzEkSWxf4uCtggYBpkcbNj9D87HoJ98Ek2zGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knGSu5MTmSN4EfsmX/6koJvMkiBdiSIDWRcnqC0OT8A=;
 b=IWtxWkYsOS+zq4SM/BwzqanQPnvevRES79cLMqU2DCbAKe0R77+mnPPtp9Ns1zY5ip6I2uGubZ+PUO+sNW8YdmWtOa78xToFKmj1InbpHKPOrFR+2ht3Rhldti95gVEKhTlzhsOZt/tLDubBzEydro3EAXvIPC47TIMxo1pJXpllPM8Moolj0HfPIrDEzTSeNOJkn/oB1RlP54/FzMT8UiRbuODZ7c38TlgzSaiQtAl43gRszC54bkekcLYRvQU079hrb1aQryZ6FKQJmHYlnNcFYQptmkXlrLpazbVNEKZr5WQuqjmyvgEBPJ+JSvl7nq6FWqMpGKtnSjhYr4GN3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knGSu5MTmSN4EfsmX/6koJvMkiBdiSIDWRcnqC0OT8A=;
 b=JX2PORYj513L2oHwe4vf/YtQpsxYayKO7HqWa0ZT0PgFWSRYDlf7wMaAvzjNc+eR29mb7CX1cgLU+2kz4BTUXTa3KhmRXIMDdaH7AIvcftOvxVSjEYVlFTaRFR9eQprqqAIST3ChBLAGa6+Oo8pDJW6dNmAqVhgul7R5nKmuLoM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM0PR04MB7075.eurprd04.prod.outlook.com (2603:10a6:208:19e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 16:06:53 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8445.016; Wed, 19 Feb 2025
 16:06:53 +0000
Message-ID: <da11da79-11f1-4251-8fb1-3079c3b0da64@cherry.de>
Date: Wed, 19 Feb 2025 17:06:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: remove supports-cqe from rk3588
 jaguar
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, lukasz.czechowski@thaumatec.com,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20250219093303.2320517-1-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250219093303.2320517-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM0PR04MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: 97508bf6-c940-48fe-3845-08dd50ff6d24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1Y1T01meFJpOEpSL3NHcDZ5amFvYlVuMC9ZZ2ZlOWMvV3BObWpaSmpBN1BF?=
 =?utf-8?B?VGxBamROM0ZVWFJGdDM5K3AwNitSZTlINDkxZGlYZnZ6NVJrMEcrTm40THUx?=
 =?utf-8?B?bGYyVnltZ2RLSDU0NEdxUjVDdFZnNmZ2aDdwSHVZSUF3TWhWUS9Vc0NweUFy?=
 =?utf-8?B?WFdlakpuS2c3VVNZQVVVMmJ0Z1BGZmhUUGtSMFcxeFdrSms2ajlMRFdDajhX?=
 =?utf-8?B?TE1xVGdmekRzTTVEMEMvTlJIRXk3TGk2LzBpN3JHNU55U0pZSkQrNzE0T2s2?=
 =?utf-8?B?WG5ZZCtyYlJzZlVSbElQaHUyUW5PbStVYVNqOFlxUktXcmVhR1dEcmhmSUZj?=
 =?utf-8?B?bzNhQnU5K3pmbzFVUUNtTExVTlhpSElWSVF4QWFtSFdDeVRPdlkzeFNiQSs0?=
 =?utf-8?B?ZXk2VUQvejcxak1YQ0xyWjJwQlF2TzhXN0tQeGNrTElqdy9rNUNCVS9vVDZ0?=
 =?utf-8?B?cVRsM1RCcHoyWXoxV0ZyWUxzS0wzVTF3cjUxbUp5amVSMDJHZHoySk9hUVJG?=
 =?utf-8?B?SGVNRjB4Tmx5enhyb2JzS3BseVVIQzVyZEovd0xiSm93SGpJRXFvN3BySGtU?=
 =?utf-8?B?N25vWEJpK3Jmb2tEWGNBbVBDek4yTWtEb1RuNW4xVk1xTVF2ZDdUUG1JSFFl?=
 =?utf-8?B?OEcvS3o1RDk5blZTNndDS1RHZHRUbk5HWkphWktMeUFuY0FpajQ3bm93MlFn?=
 =?utf-8?B?V0laN3lOcUd5ZERGSjlHYTlFUEg3c3BDR3JSZzRJcnhtZ09EVlJhYkREd2Zz?=
 =?utf-8?B?NEQ4RzhzSkp0ak94WEN3c0J0NWU0clkxZmUyemhuWnZDTW1yTzVPbjhDdEZh?=
 =?utf-8?B?QkdzS21FOVdKNVEzNTBtNG94VlZScHEzU1BSVk5WMWoycjZPQ2JDQkFUOWJl?=
 =?utf-8?B?MXVEcGY4TEdGSUU1TlhxSS9iTy9pd2dMNEdOcnUwZGNmU0lObkhzMGNKZ0Fr?=
 =?utf-8?B?NmZtMFJSMXFrN0x1dnp4Y0hwMzVXM1AxditGU2Y0Vm0wem9ZU1dmVmF6U05u?=
 =?utf-8?B?bkZ6MjcwY1RZRHNpQ0JhZ1lDWVpibFFkckFOaWs5K1Yra3kxL3drNGdZeEtL?=
 =?utf-8?B?SXhqbWEyMDhUeFhMMjdQSkQ5ZzVmU1RTZkl3RGQ0Um8zcDhzY29FUEhzOG5G?=
 =?utf-8?B?TTgwZTVIVGZqdXlKRU05bnJNK1hmUE9Mek9IeFlqYVJLUGdLcHhpbmZ5VFJR?=
 =?utf-8?B?ekRPZ284ZjZTYzVSYjFkVEpWNlJDYkF2dk9zRUhTRjVlR0w2M05OZEMxNlpn?=
 =?utf-8?B?V2RGVnJTOFdraXZNTS92c0pxMmF6bUFtSkVic0g3bkY4amhKTUZVWXBkQVlY?=
 =?utf-8?B?NFYyMEUrVGQyUTNsY0ZRMDhvZHdCc2NsMWFTT2llcDBVMldQUUZweXZvLzZX?=
 =?utf-8?B?SVdJUzY2N1dIdDNwYStaVjR4bS9MV1EyQ04zYUIwSGZnRmR0OVBVQ0Voc1hQ?=
 =?utf-8?B?YTUvSkcxRXphWnRUY29EU0U2VTAxRC9JenJwL1M4MkxjT2tDK0pOUzlsdUFq?=
 =?utf-8?B?MW1HSzNvQ2U5V0hLNitqZTFMdFJmd3RaQm56RUJVOUxPY3V3RStLL3NLaWNY?=
 =?utf-8?B?WjE3bjFMNXU0MlF3bDAxSGRZWGgybUhPTUtSbGd4L2c3N2pXTG9mR1RDQ2h4?=
 =?utf-8?B?dlpyczc3bUhYL29XZlhTV2lvbzRtNmVtalFnMVBkeVFCNUZXUWMrZmZHUUFp?=
 =?utf-8?B?TTJUakxQUjJXZVhzK1pmcEhtR2tHWnhjK2doenI2Zjc2ODZXRmwrcWUzZVph?=
 =?utf-8?B?dm0vY2VjYzJ2VXlTQ0F5RkxjSGh5WnNGY3F5UUJTSUk4c0tpbk1UdERCYU9z?=
 =?utf-8?B?ZmZGNUxoeDNjY3hnQjY5UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDJ4c1VnYzdQZGJrclA1QkVQYy9OS281bmpPRThkMFl0N0VFQ2taemtCbnA0?=
 =?utf-8?B?QWw5L0k4UGN0QzdqNTdjejZCTUhIQTBWRWFjbWgwSG03a1RKVmh0c2tsT3Zq?=
 =?utf-8?B?bjVRaU5zY2w1T3FDallZMkl0ODAyUGFSeFlQSkx1UlJMY011MkljWjYyc0Ez?=
 =?utf-8?B?OWxKSTdKa0UxZDF3ZWJxS2k5MEExN0wvYlRtcldmckhEd3pMZmxyNDZ5NE1W?=
 =?utf-8?B?eTlFU0RKNVh2VTBRWDdYcGxsMWtEZHJ3TFFYSE0rZjJWaVJzdlBYK2ZtdnVG?=
 =?utf-8?B?angzSFNpREQvaHZPdVh0WElwbVBxN1JrZWhBaXMreFN3QlRGNWQzRlBmNWNl?=
 =?utf-8?B?OFdFWTRzM0lHaE9tUEpVdFZoOHhFWE5GeHE0MkppVmlRdDhYTVNtbzEycG5w?=
 =?utf-8?B?N0J1VUtjU2RIZ2V3T2s2cnVaeEE5RXY3QWdKakVwenZpTUVuaGZJemZudFRn?=
 =?utf-8?B?blN5Qm5RYTBBYXBxbSt6cTE4b3ZvTG0wdjFUSmhZRVVjS05UeU5NSjJhM3hG?=
 =?utf-8?B?UXdBRG1Xd05ZZXhCbklHYzc0UXRhSUxjZjc3V1BvOHdHMmRVY2RrOU5FREUz?=
 =?utf-8?B?K1J1YjNYN0dKZ2QwbVEzaVVlaDB5dGZsbEZxOUFJMkc2ZXNHQmNhTXFQMXg2?=
 =?utf-8?B?TnkwamFwL1F0c0kweWtiUmZIR0Rqd1JpYVlGczI1U0xmdThVLzRuZWwydTVy?=
 =?utf-8?B?b2VZM0pCcHpyZUd5alZNQ28vNUxtRi9WN2JUKzBJVSsvMmlIcGZyblh6OUNn?=
 =?utf-8?B?NnVHWmxnLzlXN2dxUXFsSFJNaEFrR0VISWdGeWdPa25zUTBtS2s0djdySXFq?=
 =?utf-8?B?U0xlY2Q4R2JxNXVYR0R1ajY5N2VNZGhGMkVtdUJpYnNwV2FzanVoWmsrcml3?=
 =?utf-8?B?THNJQkd6STZLaWJLUWlSVjN3UXNoY3BJbWJ4ZTRmaWd5clV5QWhEZm5DZnJm?=
 =?utf-8?B?MTEwWE9SV1ozVlA2cUdaVnFOTlRKY2FEdmNQRjJqRGpBS1dJTW85U0tyaDBi?=
 =?utf-8?B?U09UcVpNS2ZzWGdPaGx2K3ZpV3ZlS0tlMWZKODFTNXlZbFREWVpVcnBYOTRX?=
 =?utf-8?B?R3JVb0NGVVQ1VEF3d3BOWVY1dFFPT1VWd2FicXVFNmlzd0ZlUmY2SzkzYm4r?=
 =?utf-8?B?VXNUTVhPRnE5WU1LaUlITUJkeXN1dmY2VFdBeGVZSUZEK1BRN3VaM1cxcE5N?=
 =?utf-8?B?MmpmdnlVVjB1SjhZMHJUK3J5QWZMbHovUkRyVkJ2U3RYSmZXZm1VdXRxMEJI?=
 =?utf-8?B?OWVHU1laeHlxbjhuT3pNQW9WTEpoYmZRY3k4aFRHNzZIQ202aDZHa1NBSnd4?=
 =?utf-8?B?UXcxOXVqTlZxZVNvSkQ5dWdqcWFlNmR1Wjc2OTQ2dGlPNG4yaHdYMWN6K2tI?=
 =?utf-8?B?MGpDbVVpYWxQa2JMb2RPTm9hWnN6eDVCUWlOWGo4OHBMT3RhTC95SWV5dmQ1?=
 =?utf-8?B?TWRTVXJyM3ZFejdMMXNPbEZvSXRjZ2lNbDZXd1JFQXJLTGVMT0tHbm9JVXJK?=
 =?utf-8?B?ektISmQrYU1Zb0dyaHZHb2hsT25FR1NzMTV5V1VURXdRZTVMRm5sRkxuQmtL?=
 =?utf-8?B?d0ZlZDBCVUt3UGozRGg5ZUlIUWwvT0Z2OTlwR1BGcDloTmFjT1lhSHBIbjFr?=
 =?utf-8?B?UCtEM1ZNcWFFaFhUcFd5VVA1WE1qMmxTYnU4U2lxSW5OR3NGNzQ0WnNqcWho?=
 =?utf-8?B?amxLT3hocjhqU0c0b2lqZk9HQnZjbDVHYzlJOXRMSTFkQXlHVHFJdmF1cnls?=
 =?utf-8?B?L280T2pDeGVrYmlseUhaZzh5bVl6cy9RdzZtMGt0enFCQW5vSGhNbk04MUhm?=
 =?utf-8?B?Vk1UWHA5a3IzUTQyZWFTUDNkUmNEeVFyRVBYcVhuT2FlNStkQ0orMjAwS1lt?=
 =?utf-8?B?QVExdFA5R0ttSSt4aCtwVy93YXVUSU00L01NeG5EaTZjS2tOc1pKNnp0M1dN?=
 =?utf-8?B?VEE5VHAvbU5hSW5mY2xzYStvYTlhRklFWlUwZjUyVHEwZEJwTmZzdHAyRXQv?=
 =?utf-8?B?UG5kNk9xaDVGOGFURGVKSHh3Y2VFM1JBUzhsbEtMUytDeDIxS3BVWFVsUjJs?=
 =?utf-8?B?WEc0aCt4T2o1V0dSY1E1SUdNWG5TQURWRWppaE9aSlBxNFQ0b0w4a09IVk1r?=
 =?utf-8?B?TDN4R1lmM29WS2YxLytqa3ZQeVNaVytnZnpyamp2aUJ1QlI4UlhPd0JYLzNn?=
 =?utf-8?B?dWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 97508bf6-c940-48fe-3845-08dd50ff6d24
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 16:06:53.5744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +S3MzsRc6ckF9GCjBx6KX4d7C8uRzfho5BGM9z8VTQN52IRkmlIpqPgv+OZwL273H33ERFKbz/TzmevwkpDCcUVwm/mt8qJEce0iz8ii4ho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7075

Hi Heiko,

On 2/19/25 10:33 AM, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The sdhci controller supports cqe it seems and necessary code also is in
> place - in theory.
> 
> At this point Jaguar and Tiger are the only boards enabling cqe support
> on the rk3588 and we are seeing reliability issues under load.
> 
> This can be caused by either a controller-, hw- or driver-issue and
> definitly needs more investigation to work properly it seems.
> 
> So disable cqe support on Jaguar for now.
> 

Seems more reasonable to me for the time being.

Aside from the reliability issues, I could also trigger a stack trace with:

$ mmc rpmb read-counter /dev/mmcblk0rpmb
[ 1119.647435] mmc0: Timeout waiting for hardware interrupt.
[ 1119.653480] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[ 1119.660676] mmc0: sdhci: Sys addr:  0x00000001 | Version:  0x00000005
[ 1119.667871] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000000
[ 1119.675066] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x0000002b
[ 1119.682261] mmc0: sdhci: Present:   0x03f701f6 | Host ctl: 0x00000035
[ 1119.689455] mmc0: sdhci: Power:     0x00000001 | Blk gap:  0x00000000
[ 1119.696649] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000407
[ 1119.703845] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
[ 1119.711039] mmc0: sdhci: Int enab:  0x03ff000b | Sig enab: 0x03ff000b
[ 1119.718235] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[ 1119.725429] mmc0: sdhci: Caps:      0x226dc881 | Caps_1:   0x08000007
[ 1119.732624] mmc0: sdhci: Cmd:       0x0000193a | Max curr: 0x00000000
[ 1119.739819] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000000
[ 1119.747014] mmc0: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x000007d9
[ 1119.754209] mmc0: sdhci: Host ctl2: 0x0000000f
[ 1119.759169] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x0057b200
[ 1119.766363] mmc0: sdhci: ============================================
[ 1119.773595] sdhci-dwcmshc fe2e0000.mmc: __mmc_blk_ioctl_cmd: data 
error -110

FWIW, the changes that Rockchip seems to have done on top of that driver 
in their 6.1 vendor fork are the following commits:

https://git.theobroma-systems.com/jaguar-linux.git/commit/drivers/mmc/host/sdhci-of-dwcmshc.c?id=2ef0767967138d333360ec0f399f1d68646741c3&h=linux-6.1-stan-rkr3.2-jaguar
https://git.theobroma-systems.com/jaguar-linux.git/commit/drivers/mmc/host/sdhci-of-dwcmshc.c?id=75dfde714bbe81e938190142d07307fa864fda34&h=linux-6.1-stan-rkr3.2-jaguar

Maybe something worth having a look at some time in the future.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

