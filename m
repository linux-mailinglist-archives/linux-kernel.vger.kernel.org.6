Return-Path: <linux-kernel+bounces-258945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD8A938F08
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A551C21016
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E4B16D4CD;
	Mon, 22 Jul 2024 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Lgv1ChYo";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Lgv1ChYo"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2083.outbound.protection.outlook.com [40.107.104.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A181754B;
	Mon, 22 Jul 2024 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.83
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721650911; cv=fail; b=ok4yPuWHJEAT7ur9nuVTVUaoonSrAMy5TI4pFbd1h542482t+7AoBROn9YeCRQ6gV8nKXsDXuTUdCLELHyMmGICvPlz/sBqgHqTX87SOAkJLhAzMq9dTiMGd9VkMsehXHbxc0pM1C+6oTAwmhTrsTboMVA8FLoOlU2ne9z0JoHQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721650911; c=relaxed/simple;
	bh=r7tYAQInV4K7H3HdBvpBeiauP3FU0mIpEPXGOlkHKvI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BPtEzlE0vAz/IAnWTg9omxYbAWR1M6zuxNtDGkCrWWPigGPwnUsTaV8QG5+ZL9YdwYkdd2JyJbMZs22YPd22kX1FNDsHMuHk7EZuXIp/RjhAUM9Sv5ibLS6Zc1bV7ThB5JMIkrH6BeHwUGnDa1CWSXQp5M2TXX5GXR54DN3H3xQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Lgv1ChYo; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Lgv1ChYo; arc=fail smtp.client-ip=40.107.104.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=pga05ZkC0Dca+YZyEKWDmUvyzOvImdO6JuVkjwS7IQVkuQvInbBmOxCn8ZULj4DAUEMVa/LtgWENJdYQOkrQ93vkp6T+xSl/47hFjpdKv1Wz71b31TzkEzm/nDQSFsE0+kFBJ/umvkBlBnVKBKDqMkNklZpprBeKdYBlCx3a1DMv14GL2Xw6GP97l3yTNd9BQ+f/GQMsbnrnqzULB3sMW7MYRkpYT9Pe/HsqzXDbweOcOBPVN9XIyZlaJ3pFG8Q7alQkkrcR5vATuFDNuVKRX9+kuNd6imiSqz6+NnSCgpuHFEs2QNHa36hV2J8iHusUGlaUHdZva05AY8F0jWIkpw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7tYAQInV4K7H3HdBvpBeiauP3FU0mIpEPXGOlkHKvI=;
 b=acE9ryR0XuemxZhPUEcYQ9/+ioUmKMSV11xfuGEdNc0lxy/xMFbp3Mzz8Qta3lALqCx5YUAL/5GHS2t5yc+DEfiIsdrxtHCdQm5q4BZLATd0HxyyPOP9vl1MXwrTUXrGOqVN/WvaCKa5r43OUnx6fSeeLx2CC/fHP4WzE6TBm/HesnX40x7BAGzhA6pT++M4N/CLQ/D/Y1gACCAIfTL3VsOwYjsXLaNqeqC4fvnLYcp6odtaVZWiJIWTAfijcXIv9KFj8OVvfQlFUtrRwRbH5Qu98Q48My3GBVtTTpPh7FuEG9eLa+NR836tY0zd7TAIcucfSwTVhlPPjir2FAXVwA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7tYAQInV4K7H3HdBvpBeiauP3FU0mIpEPXGOlkHKvI=;
 b=Lgv1ChYo3bcasguo7zy0gz5dqpxxzAUwEDxsxuyozhbV5GtC4OLSfWXqXZ7fxwbviG42NwTtm75NBkwKVxJ9kmRarVzrqP0X9UpsxX6fz+ds3hYgmS7wEF3hVHuxkxLPYg6atsXIcmiKhrAZrC9rP758MtjuSchDT8+Iku0Agfs=
Received: from AM0PR02CA0104.eurprd02.prod.outlook.com (2603:10a6:208:154::45)
 by AS1PR08MB7657.eurprd08.prod.outlook.com (2603:10a6:20b:478::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Mon, 22 Jul
 2024 12:21:43 +0000
Received: from AMS1EPF00000047.eurprd04.prod.outlook.com
 (2603:10a6:208:154:cafe::5d) by AM0PR02CA0104.outlook.office365.com
 (2603:10a6:208:154::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Mon, 22 Jul 2024 12:21:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS1EPF00000047.mail.protection.outlook.com (10.167.16.135) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7784.11
 via Frontend Transport; Mon, 22 Jul 2024 12:21:43 +0000
Received: ("Tessian outbound ab09e808a502:v365"); Mon, 22 Jul 2024 12:21:42 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 9d4516523caafb55
X-CR-MTA-TID: 64aa7808
Received: from L06fd46c974fb.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 5CE515A2-C2AF-4ECD-A6E2-9D2C6F22FB71.1;
	Mon, 22 Jul 2024 12:21:35 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L06fd46c974fb.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 22 Jul 2024 12:21:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjlTPE4Tu/j2bgJJ59r6KV50gin4s8hE8zGSDZ1cLMmnFX0D9BFZL2aGUFBB7SA7/IABZA4FedvULQ46iLWxWD6A3MK+4z36mUreLC85vLLgirl8FB4TFHmrmLqrfcQVEt/8X1jt5EMoWAr1aDtUd0qQbFSfrdUopyXnUewT7iDoy/Mqv6q9Rkrf5cyow556srHyRuRjm/yTRVFQAI3YlKdH7DxHLJPGL8o37bzVlxHGZKmpJ2iUqrFh3381UYwfqRleX0wZWqSgmzB+BGEGhyChkQKd/hc6o88fWy+3Ad5YAju59/CKpUg7ARXAGf30RZsMcSlKgwguh1AbDFPPxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7tYAQInV4K7H3HdBvpBeiauP3FU0mIpEPXGOlkHKvI=;
 b=kYoPsYh7E/aIXdvLbAXWaCfjFb+9BfYpYHyS+eNQ2Ev3DUjXVFsX8LVpRohkeonkaX7sp5iFXhsUpDdPUAuOUSO5CVWkiyfCmQY0NPWr7OgohF6qnmaCm+zBQbK6r9oM9K96oy3BCDv5tfNuluseLhcg+L27BMovX3PGfncFbtrDQEOK+QrzTJh6u4mhRNNxn0OkzwgaDSb8PsXDVTV3O4FBoyonrvMuXNBrY6frZIMD6u053i020WbgO9VvVrLIOI74UoOH+wbBAWtv4Ho4iG2htEcB6ho7iScAYboLs8RajMYAtExJcctkpFDGj0xmWKU+tx4w3sihwQwFNpov0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7tYAQInV4K7H3HdBvpBeiauP3FU0mIpEPXGOlkHKvI=;
 b=Lgv1ChYo3bcasguo7zy0gz5dqpxxzAUwEDxsxuyozhbV5GtC4OLSfWXqXZ7fxwbviG42NwTtm75NBkwKVxJ9kmRarVzrqP0X9UpsxX6fz+ds3hYgmS7wEF3hVHuxkxLPYg6atsXIcmiKhrAZrC9rP758MtjuSchDT8+Iku0Agfs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU0PR08MB8639.eurprd08.prod.outlook.com (2603:10a6:10:401::11)
 by PA4PR08MB6176.eurprd08.prod.outlook.com (2603:10a6:102:ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Mon, 22 Jul
 2024 12:21:33 +0000
Received: from DU0PR08MB8639.eurprd08.prod.outlook.com
 ([fe80::253c:bc53:f4b8:3c7a]) by DU0PR08MB8639.eurprd08.prod.outlook.com
 ([fe80::253c:bc53:f4b8:3c7a%4]) with mapi id 15.20.7762.032; Mon, 22 Jul 2024
 12:21:33 +0000
Message-ID: <57e6bded-8d10-4db8-ad2e-11dfd126205f@arm.com>
Date: Mon, 22 Jul 2024 13:21:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] firmware: arm_scmi: Track basic SCMI statistics
Content-Language: en-GB
To: Peng Fan <peng.fan@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>
Cc: "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "cristian.marussi@arm.com" <cristian.marussi@arm.com>
References: <20240715133751.2877197-1-luke.parkin@arm.com>
 <20240715133751.2877197-4-luke.parkin@arm.com>
 <AS8PR04MB84500E870B3BBD1FD270609388A22@AS8PR04MB8450.eurprd04.prod.outlook.com>
From: Luke Parkin <luke.parkin@arm.com>
In-Reply-To: <AS8PR04MB84500E870B3BBD1FD270609388A22@AS8PR04MB8450.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0548.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::11) To DU0PR08MB8639.eurprd08.prod.outlook.com
 (2603:10a6:10:401::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DU0PR08MB8639:EE_|PA4PR08MB6176:EE_|AMS1EPF00000047:EE_|AS1PR08MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c55372-0a8d-4a57-8385-08dcaa48d8f2
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?bGxDTEFnZmZOTDhBYS9mYTIrQ1c3bEZRZDRINjRmWGc0OHkvNGcrTmdNUUxJ?=
 =?utf-8?B?dzhVaU5TOGduekdibGk4Y01VS1VPVnB3Z2MwYTgyRTN5R0QrcDlnQXNjU3VP?=
 =?utf-8?B?SXM0Y01XMmhlZWd3dUQ0YTYrL205RXRNQmo4SVZuempFbTFaYlYrK25XZjJY?=
 =?utf-8?B?MStLZENKZE5aeUxnZjNSMTRTZUlONUhkRDhSV0pxUUhwNTZyTTI5cDR3UmQz?=
 =?utf-8?B?ekZaV3RSSXRzaDUyYjJGVXh0NTFjcDFPcERNSmM4WFJPTHh6ci9ENnJrMWNt?=
 =?utf-8?B?RGN4aDdUVVY1ODJJMEFrYTNqRGdyMlorM0hZNWZHMzUva054UHpaSEpCM3Uy?=
 =?utf-8?B?dE5ja1Q0R0ZTZEw0YkRRaHFDZWk3dTcwRXJ3NDBkVCs4UnlYeHJkVFY4RzNB?=
 =?utf-8?B?bTR0dkk3RDkvR1dkWHVMdlNMbWJaUFBSZmRCcGtlRjFmTXhVUTQ4Z09TNVd0?=
 =?utf-8?B?NFZvdkZMaWNxbjBzQmJzS3NaS2JwN2JtSmE2bE9ka1RUV29WQVNHdXN4NzJw?=
 =?utf-8?B?ZGhGaDFNQ0MyYWpwWXN0bElqVzhtNE9tRWpvQStWa2M0c3hqNk84KzV1WWk3?=
 =?utf-8?B?eG4vVktNR2NROE1jODR4YWRJcE81RjZ2ZEdNcDY2bVYrMHhJalZNWERlL25v?=
 =?utf-8?B?QzhsOFNJRUdSczdaWG9JanZUeVJKaEF0akxvTFE2MzU3SFBHeHROWklKZlN2?=
 =?utf-8?B?c2tKVjFFZGFKQnphQjloa04zZkpJaVQxNHRoL1pFaWozRGhQZThHUkZQcW9w?=
 =?utf-8?B?dVRoRUVPQzNodXFoSTJKWlVvSTkzQnpxRVo0WkVoSVpVU0ZseGN1ZVl2aDRm?=
 =?utf-8?B?bGhYcEhUeXhuSGMrem90Y00vSzI2dVRGWWhXR3lIZzV4MGxmV3hqSTM1N3V1?=
 =?utf-8?B?RHpzTTNyWkJNUDR1bklaYzNYK0JLMXNEN2JsWURFRWczMkc1UjlNUlZqWDVx?=
 =?utf-8?B?M1hpNFl3Z2hrVGNNZTZGZStsejh0b213MkZ3ZFY4SkJLeDRtNEVDWVJ6dGZl?=
 =?utf-8?B?eXlERFFPb1BwNldBYWpianlRUEhWVE9jSEN4N1NHRjhOcHJDV2dUemtLc1Rh?=
 =?utf-8?B?anRGeGU3L3RQREx2YTBvWXJqcXBXdmVhdzZjeEp0WFVFRkRjdUxISHZuZ2xt?=
 =?utf-8?B?bVBLOCtKaUs0Y0lrc3pEREJkZXI5UTc0MER5WFZxZ3JpdjlnRk9idjhTZElF?=
 =?utf-8?B?dnlDSzFjNnVvZWdCY2FDWndud1VNWUliMENFUUhyMlZweU9MYVF4T05RcWhR?=
 =?utf-8?B?bkZTNHVnTHlUYmcwZzErRWNsOEVNdTl6c0l4bHkzamkzVldFaHJjTjBZa2xa?=
 =?utf-8?B?bU5UM0RrMWlHOUQySCtCWWxUSERNM1hRVktQdUZTNTNOd1Zxa2ZZSkllYnFx?=
 =?utf-8?B?L2lnNVJiNGFGbTAyQWx1WnUvc2JlNk0xTzU2WG9TOXNnb3ZnNC9ER0V3SWVF?=
 =?utf-8?B?b3ZrZEhiNnA2NlBWbTQ2QjhqTGJFN3ZwanYzTVgwNTVCOEs5d0s3VzhhSnBX?=
 =?utf-8?B?TVFpTENkL3lNUnBiVWRGOFlvYVh5VWRncEd4cjRFcXFRc25sOC9wSFRIVHk5?=
 =?utf-8?B?b21ZYmVYaU1IeG9Hb2FHWmllbUJLaGc2c013UEpBODBUMUh5TEg3WWlOWWpK?=
 =?utf-8?B?TzVXZjFlMkZjbjhxN3dhRklNRnVKZ0xyZmFLZUhtRkZKQ2dXVlE3ZlZqQzFH?=
 =?utf-8?B?cnJoL3VONURFeTBwZzdJZE5vVGFQK0l4R0xIdkRXWUFRRXJxSzljQVd2V08y?=
 =?utf-8?B?R2JQNWg0RGFsRHMwNWVEc2FRZWM2M1VUc3Rxald5dndZeElScmFWR0dDU09L?=
 =?utf-8?B?ZHN6M3c1Y2JKd21BdVVodz09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB8639.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6176
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:10:401::11];domain=DU0PR08MB8639.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000047.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ec13d401-79f7-41a0-7091-08dcaa48d2c2
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34020700016|36860700013|35042699022|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2RTai85eDlzYVFmQkxiY3JVMklBTk9QQW5Oem93R2NYNzA2MGZQa3IvUkVq?=
 =?utf-8?B?YXd4bnZ4TVVsZ2R1VHFJN2FxNThVLzgxTW9BMFVHWFAvRGozTVdVaDdHVlgx?=
 =?utf-8?B?SDdKdW95RzBqNDEyU2pudzFuV0Mvc0RLdFkyckgrcERaaXJHaGpSQkNkNzh5?=
 =?utf-8?B?b2V3QURwQjhDSVh2Y2VHOVRjd0pLc0NSdzhFYjMvK1FuQTBVNWRPb1NoOFpj?=
 =?utf-8?B?UTdzZzFuMGNscDBlRmJ2SmxYTEdUQnM1eTF0d0lBSkdPZVRqMUJuS2RCTDZW?=
 =?utf-8?B?Nnh5c1NicUg3TXVhZ0dWa2lFWGZRU2RFaHlIYU5kTVFGVUxGT1IvSWpQeVhI?=
 =?utf-8?B?d1FNdGxNWjR1ZnI5dGI3NnBRQmNSN09NTTZZSXdQbVhXV0d4TlNMS3Q3ZGI5?=
 =?utf-8?B?czVoWTJ2ZUd5UmkyejhUNU5RcGQ3Zy9QekRQNXM5U3dZaC9jT25MRXJrcFdr?=
 =?utf-8?B?TUtZd1k5WU5JQmg2aS9pZENUaEVJdGR2MG5uN2RjVW1Qdys4MTNDVXpsellH?=
 =?utf-8?B?OWhJM1VzVjhldXJ1bGpSVzlJWEZndXBTR1F3Y1NsY2hKeWJ4SDZsTVJGeG9J?=
 =?utf-8?B?eE42ckk4NU9idFpPSEIrSWxFbDhHK2JuaHU4c0cxT2hZWnZEUHJ3SXhqOVRB?=
 =?utf-8?B?REJ2SFBlQ0FKUGhZVUNmVzBScHoxcnVCTE9WUS9yZVF0QWUycjlsQ2JCYld4?=
 =?utf-8?B?aUluS2dCeEhGZks5K0RkSVFPUjRrMDhtc21ZWU56Rm1PekU5a1hoYzRMSVVX?=
 =?utf-8?B?aGVrSTVqcFNjVzB4UzdUSldOYmlzUk5pd0JFdkJpSXh0MTdTeElXZWdMUWZ0?=
 =?utf-8?B?UFYvUkVleTk2TktaM1JCckVGTVNMdWtRWUFWWEt3QlRRRTRWdlFzNkEzVXVK?=
 =?utf-8?B?bVZOS3BhdDFCR1BjZ0pGci81clBZNDZXWjBUMDVGMEJpbDVqZEZtd290MzVt?=
 =?utf-8?B?WUd1eUVKSm1Oa0l0Nm94VFg3cDFoUmozaUhRRUo1Tnh6dmk2U1h1Y3hOcE9y?=
 =?utf-8?B?T2tIaVlJRWNYWTZCZThRVmFaNis4bFZaRmZKMUNTamNjTU5XU00xOUVnKzBp?=
 =?utf-8?B?eGxTQWRId0pnV1FiN0RtRTBOOWRCSjBZdnNWVHM4SXlXVG90aXg5Qm1MeElG?=
 =?utf-8?B?bVB5N1JzU002UFM1MTZSbTR0cWIzQkNyNlNuMy9LOFIzMG0xVHpxVVdpY1NN?=
 =?utf-8?B?K0YvQ2dDNzZKc2N1NHJYWmpSRmNrZjVHVGRaeFlOMG9nRlJ6L0ZyMDU1N0Fq?=
 =?utf-8?B?MFNMcUZCWTc0ZmFnZktJRnR1YmxzekZXTnVWY3ZPR1dlcnh6bnd2a05XY1hu?=
 =?utf-8?B?Y293Z0o3eTF0bUlUOEplaFA5aU9NRzJkQWpWYXhCejYzQ2NQbGIzS2ppWmgv?=
 =?utf-8?B?bDhlODlLT0h4SGhaK09YMFcwZlNvV3YyR21ndkE3RHdZRjh4OS8rQnpBYUxW?=
 =?utf-8?B?OUpxTVpGRkpqWGsxYTN4aDdrV2gvV0tLWFlIVzhsSjdSNE1GVjczaDYwL0h6?=
 =?utf-8?B?R2IvM0JoVWZCdUhUWXI0cFlsVmgrQkFiWDRmNWJ2bkp5eDlqdWQ1cWtYN2x1?=
 =?utf-8?B?a3RFWWxuSTBGZStFMVM2S1lrRmQ5UjgwQmMvR09LTTNZNk1tbmtBWEpjK3pZ?=
 =?utf-8?B?c3o0R1BLalFDb0xtQWpKb25hWVhsdVByQlprM3FzcFVtVWFjSEdsRlV0VFhU?=
 =?utf-8?B?UnkwVGhSYVMzZHdLTnBvUExOQ3gvQUxHRmdybmVCOWNSVllPb2lnVnlnck9j?=
 =?utf-8?B?WlpSMmNaU3oyRHI2b1BxRWpzMzdUNElvMUhSMUdJNGlmWFZVQlNrZCtVRVIx?=
 =?utf-8?B?U3Boa1FKM0I5MGhoSjU0UFhlT2RtY1VURUVMN3MwUjFsVTBGc1BNUUlHOWh2?=
 =?utf-8?B?MFEvRlU3WG5Ybnp1eEFwYXA5TGtiMEFHNEtwNFQ3U3pNWE5NdFZqL0ZNZGxo?=
 =?utf-8?Q?BwAQQCtExrRnT77a5gg+eFC30Z1APugA?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(34020700016)(36860700013)(35042699022)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 12:21:43.3282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c55372-0a8d-4a57-8385-08dcaa48d8f2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000047.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7657

 > Just wonder that since ftrace is there, why need this?

Hi, this series aims to provide a useful debug aid for running tests on the SCMI
subsystem. As you mentioned, ftrace does report some of these statistics,
however DEBUG_STATISTICS will allow a programatic interface to access the count
of failures, successes and an extended variety of other specific
errors/statistics for automated (or manual) testing.

Hope this clears things up,
Luke

