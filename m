Return-Path: <linux-kernel+bounces-441692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18159ED2B1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997CA1674BA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B211DDC3B;
	Wed, 11 Dec 2024 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RH2HkpD5";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RH2HkpD5"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011038.outbound.protection.outlook.com [52.101.70.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE51E1DDC1C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.38
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935868; cv=fail; b=FZm5+r7CgWz7WtVKU5jgkNzrYEeESupFGiPOG/PucsM1vvDoIFhPBJid2xH4OXI/MjQuHomJTKn4jNR9CSBblG8YQH7lWFm/JhuvNE2KnNok/EcGJ5VlS+6ZXC7tL7U5/xbZd4mV53CG+yDkolEp1tRZpWAx4lw5sc5ulxLbwpE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935868; c=relaxed/simple;
	bh=wRyxED6a5CEF9LHl0UZPtzX0q9AyV9Rmg9dOTYkrz5c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bpxg/litV4FDjUb6Jm0Wv7DrE9aKvZJLZAeTn4fUkMJbWe7Mq0T1lz3PXuxNlgXE594D7KmHKDSo+xMdK1W4f2LkU3RHA/xSGiSDgr2aa+ZgsDmIo0tOcEeNCMNS8jYCfpMPH8zrXrr6RS6gbvtmvLdNzYfIv2avvJXqje0XoAk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RH2HkpD5; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RH2HkpD5; arc=fail smtp.client-ip=52.101.70.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=JiFSglEKJce0pTd9WYukAlqzFwjchyYqHszeJVbrhR03DXIclkbD8td46qmgRr7oEzW/AvBmd+q5nthM7WuDRxiLoY+oKPnbjCvMZsLOVhPIIt7Ye34110DbuLtFv2rs/xWAcb6UtTM9Zp/6eifcRYWVU28HaxnZVnRIMQBvuVCpL8vM9A7+vy0l2Py/LdWDESPmaCuKPIICapUfxlzY/lI/xOFb1MSVI8rSMOvAdJbnY582SP3fGiyTtecFPJf5rfrlj8pLVKBnMZLyX5OhKfU3jS3GalA6fegLiE40JoQ2UPLdZDt66PTfnFTxjM6RBwI5LsSw52lvuk1qazIjyQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ayApdt7pFmAAU/+0KjMja4H3DAGhYFLXVanPs5Gsk8=;
 b=vonbfuz4GHdeCo2cLOk920lCBitBdqE8ntoTEAtl6GJV7C1jBWguMde0FfhEM3awCFiV3qLfkrBvu546Di0uyQjPos44zLbzmVlQ+EJBAq3IW6VocSwqiC4FyydMP+ZhOt9qM9XJCT/gPx2G29tOlWWQJrg6JlF4YpCBNoscvRCHt6fe9S6nVaJ+O+PY4VfMSUs+o3p2cnHJ0xJn/HxyUOZ9Hkf2LEVrB04tW+bsZCla+kLmnQXoCCLvlrhlaQ4O0vzpbC1d+HQbfZDwkkTzOQBfdcp8x5bhMgMejCSBaxEb+NiLVy6e3AVdFkri+vpjWYDK5Q2BkrUUqp/mehruOQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ayApdt7pFmAAU/+0KjMja4H3DAGhYFLXVanPs5Gsk8=;
 b=RH2HkpD5/lYZy097Neb+M5ZxK/nuOVWGp4ST/VMEPc1O3CcjLAbh2q3rnsrPLCNvIvNG10CtrlEqw//XkLKCezpGYXwKkrfAvAjawFDtweEgMNxlWXaw1rfUdAftkVkVCqw3SmZREe+UP075P1a3epx8/MiWeoO7wTbvc0haEbo=
Received: from AM0PR04CA0050.eurprd04.prod.outlook.com (2603:10a6:208:1::27)
 by PAXPR08MB6719.eurprd08.prod.outlook.com (2603:10a6:102:137::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 16:50:58 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:208:1:cafe::10) by AM0PR04CA0050.outlook.office365.com
 (2603:10a6:208:1::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Wed,
 11 Dec 2024 16:50:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Wed, 11 Dec 2024 16:50:58 +0000
Received: ("Tessian outbound 3df7a8fbf509:v524"); Wed, 11 Dec 2024 16:50:57 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 42a7f1a433c56572
X-TessianGatewayMetadata: r2NuGx4gX34veOs4T8DOdHNbgv+r1W8HjCKLciDUHmXtf5DstOCT1Qu3fGvHDfPLAtkJZnjEikQD+KM07i32tOP0Ki7yEbD/IV6d1LiccBvuxNYdHP+yU2w5HznLyh0FXHPhpAhQ04hxIQyCT17ejz8spC4dl3moQhQ4+hmEo+U=
X-CR-MTA-TID: 64aa7808
Received: from Lf5fe2988448c.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id CD584AF0-00F3-43EB-BC7A-6B5260494457.1;
	Wed, 11 Dec 2024 16:50:51 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lf5fe2988448c.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Wed, 11 Dec 2024 16:50:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhHSuEyLgAWEyn8Rsd7Tx54KS2+NwwPou24juz3fi2HDhG2JTi3lzpO6pweyUvQ3kDu/bX9Zt45bbQyN3qDzjhiPpV1jt2jn2pnk0mtEG7EceszSnnLyzdktQ9n7hGDqJ01cIDyDdxnlh+MxtGSrH+hgYfUadSsSBZgesmmUBY3Gdl/meyyvrk6stll6L5d0lLOibDskIgOIYMp4iBFZjp6vxMc07r7mB3Xms9NdWsoGhjMWdVkjKAjgpf4F8oN29pOBvw+GWb9gwt/axepGuTe4hdhwTXfa+biG21i7aDFvVYTYOM0mSHHPGN+bxaR3LR19SNMqay/HsAbLFpfYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ayApdt7pFmAAU/+0KjMja4H3DAGhYFLXVanPs5Gsk8=;
 b=Qh9HStLCeze+0PqjnC/l2iYKLb6DeISaXbWlQ6gAt2yjBGmnx1KHKhyR5otDPRHrhJduv7TZhpsoBgtr7ZQWjkb9lRFcRBwF1atYGWfjfV1SV8hdTJhBodhmuelp2yoE3sIoJxhgAujRAlI9FIEkULimafkhSvepG4DD7Otn6vFz5CwQ2cXwtSfqGYZL4fhVI4hFqCy+0LoaEgHp4OseAo2KatwUFD9/lWlpfqEFfZLHTyCKLjgKJgkU1UlRvSMcmZpodhLuU9hZsXOXvyijmwgGpuzyiGM2u0FGpbSrBH3j+0ZJ347RO+SiR6li5YRmC4cBAwgf4znh/bDTqlYEeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ayApdt7pFmAAU/+0KjMja4H3DAGhYFLXVanPs5Gsk8=;
 b=RH2HkpD5/lYZy097Neb+M5ZxK/nuOVWGp4ST/VMEPc1O3CcjLAbh2q3rnsrPLCNvIvNG10CtrlEqw//XkLKCezpGYXwKkrfAvAjawFDtweEgMNxlWXaw1rfUdAftkVkVCqw3SmZREe+UP075P1a3epx8/MiWeoO7wTbvc0haEbo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3317.eurprd08.prod.outlook.com (2603:10a6:209:42::28)
 by DU0PR08MB8422.eurprd08.prod.outlook.com (2603:10a6:10:406::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 16:50:48 +0000
Received: from AM6PR08MB3317.eurprd08.prod.outlook.com
 ([fe80::e42a:494c:6581:1897]) by AM6PR08MB3317.eurprd08.prod.outlook.com
 ([fe80::e42a:494c:6581:1897%7]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 16:50:48 +0000
From: Lukas Zapolskas <lukas.zapolskas@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Mihail Atanassov <mihail.atanassov@arm.com>,
	nd@arm.com,
	Lukas Zapolskas <lukas.zapolskas@arm.com>
Subject: [RFC v2 0/8] drm/panthor: Add performance counters with manual sampling mode
Date: Wed, 11 Dec 2024 16:50:16 +0000
Message-Id: <20241211165024.490748-1-lukas.zapolskas@arm.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0563.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::11) To AM6PR08MB3317.eurprd08.prod.outlook.com
 (2603:10a6:209:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM6PR08MB3317:EE_|DU0PR08MB8422:EE_|AMS0EPF000001A5:EE_|PAXPR08MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de38015-0c42-45de-3bd6-08dd1a03fca8
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?T0s3YjZsdlZTaGVlNFB5QUJUN3VIRjdyNjZMN2VqcUY0U1hRM1p3UmlXQkY4?=
 =?utf-8?B?bDgyV1QvTThyd1FEK2JyNWFUUWxGNTlkdlY3cGNYM1Z4ZWVSakhzeHJ5QURz?=
 =?utf-8?B?YWVJVEtIdC9iWE51N09CUkwwWWRYS05DY0Y0Z3ZMZDQ3byswTTJ3Ri9jMkNn?=
 =?utf-8?B?YVVQSWJuUHRUMGU3cEhQVHhkK01Bb29BNWlCUzAwanhML0RXZXQ1bi9JSjNs?=
 =?utf-8?B?UXZjR3lMTWtleUxmb0VXOUEwQlVPWDQ1Rk83UWRJVkFNWUNxNDBBdnp0Nlhi?=
 =?utf-8?B?K1huOTU3T2YwVFBEWnpEQ1puMWt4Nkd1SzhLTXpwNVV6TytFSjhsRG5wMmdk?=
 =?utf-8?B?cDRuSVJaREFJQXBHSElaUDRmRm5ySjdHd2NPZzlsbGsyTkEyQnVtWmMzNUZY?=
 =?utf-8?B?cVNQZjZaeXBUSlZxSzVPcG5ZTDJRRUxRMGNxVG5RaUltS2FrTTR6N1BlRVJY?=
 =?utf-8?B?TGxrT1lReXdMMko5bGw2UFRxdkNVUTdReUJJOXE4NXdwUVdEQm5BUmZiM2dK?=
 =?utf-8?B?TUUyZ0FyV2IyelhHb0s3SVR4VGt0bjdKNXRObTgwbVVQSHFVOEsxUEdvdFBT?=
 =?utf-8?B?dWZpaHFMZUtMOFlRbXJZNWphSTR0clBNREVudlhqRW9EZkQzaXhLb3pUbTlV?=
 =?utf-8?B?MHAxMDNURWRhVS8vM3JpRyswWkxHcE9qdXBYRmdRK0g3eWlUcWtRTFdVYmpJ?=
 =?utf-8?B?c01Ham9mWk1LU25JeXBNWEh4VGxYR2tXOE1FdFNVTEFyRlJxZTRoZmRZTjZu?=
 =?utf-8?B?YUhnU0hoNUJVOUVTWnlmZW1CdVhsa25KUWs2cE1VZU90L3E2WWhDZkl4czAz?=
 =?utf-8?B?OHFNelRNOHBYYVhqTkFjZERFV3FBSjJrNVJid1lERDJQMU84SzNkd214ZU9Q?=
 =?utf-8?B?RU1GZ1lPL0M3ZjliNjJ5Y2dobExvOVNoamJkVGtWc0ltTzVSbUtJbTlUYW5W?=
 =?utf-8?B?Vm5mYmlFSFduVnZJU1R0VVdZcThndEtUazVvRVNKc054djJMbHdFZ0QveXg0?=
 =?utf-8?B?MGY3emFQcmgvemFRMVlQSXJ3TE9jVnpFZzI4bGwzYlRXeXFKamtOc1d2MWRt?=
 =?utf-8?B?TW1KRnpCeDNIZlVoVkdjdVdPeG54THZVMTBJVFdqTWZpeGkzK2tnVTJrNVlB?=
 =?utf-8?B?SDY4YS96L1ZsYm5oMi9lRUYwdEtlR2RNNlFnNEx4NzBacnVrcU93SkdHQmhU?=
 =?utf-8?B?SGd5K2lmeng1UHBsaWJVM05GcWc4VDkvenJUa0w5TXpvU3BTRGk1NkNoRTk5?=
 =?utf-8?B?bEVCUXpKRW9BMS82blZiOHlWZVVTWmRhdUtKdzgvaEpSdUl3YWRYWGw3MjFM?=
 =?utf-8?B?eHhGTXRvMUlPRENLR2pEV2x2dlpvVU43ZU8wWjBJMzBQUS96Wmt0cFV6b0s1?=
 =?utf-8?B?T3JvWU9aNmoxUFFyeks4Z2tYZTZJbFpGclRENmtsQWluSnRwc1h1aGVCNnJR?=
 =?utf-8?B?S2pvYy9YWFhVRlgrakFNZTVabHZ5NlVYTFM1clB3WEFsRm5RSE5GMXV2R0JF?=
 =?utf-8?B?MWJSZ3pvaFFaeVYvTXhBTFBaRlhHcmRSZFNJdGhqQTNjcjl1bG1KeTRvQjBD?=
 =?utf-8?B?cmhMRHJ3OUJJSU5PeTZPTFQrSlAwdUlyeTVtQVh4VlVhNUxxemVnN25uOWJz?=
 =?utf-8?B?UDA2YWlxazhoWEJ4ejR6QW5KUm9VYWJLcEdJV2tZRDJSZVA2VlgvYzc4TndJ?=
 =?utf-8?B?eHBTeHpSRmR0Ni9aUGRCUXY3SGtxL0NndXpqNFZ0RHNzL3ZIUjVadlVjR2xv?=
 =?utf-8?Q?TqrWxaoqWOlAbdhzNQ=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3317.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8422
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:209:42::28];domain=AM6PR08MB3317.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0b089aa2-e535-4122-d3d3-08dd1a03f6f0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|14060799003|376014|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2h6cjkrclhwQmxBYVlscURXcHhORXV5RnRJcUVKTWNleUJXY1ZHcXFmUDhl?=
 =?utf-8?B?VzlKUFNNM3IxcUo3RTR1ZjUwMEc3TEFjMVd6MVpFcGpDbDJ2VTNneVhUbE1n?=
 =?utf-8?B?OEk0djhHTmlrZXdVVThzdkVtUVNZOStMQXg1U1RrWmR4YTJCTDd6dnZjOHJM?=
 =?utf-8?B?aE9yT0VjbmRxNVJ5cmJhSXVlS0tGTENEVElldnpua1RZMTdjQ3dBK2dWcWxB?=
 =?utf-8?B?STlpZGM4VUROVEo2Wit0MVFRWjdkZGxodTFTZzF1MFZ2dnZNWFZhUWRla01u?=
 =?utf-8?B?eFBMRENQWllrNDF1VVk2Qnl5Q1FZMmM0VlhJSEloejNrdzM5YmFQTDBzRDBB?=
 =?utf-8?B?dktKeDZ1ZU4yUGxGZHllZmlieGV1NSt0Tkx3dXlSMGdCZnN0Q3BsYzlaSi90?=
 =?utf-8?B?Y215RDhEMHJLQ2ZzNDVRQklBaTdFa2pEbk14Zm90R3lwK2VvY3Z3bENuQVND?=
 =?utf-8?B?ak9TbmRVWGRPUDg1YkZ1S3d6dlNTY0Uxd3hYVlNCSnVHaG9Bd2o0Z0NEN0lv?=
 =?utf-8?B?TGJYa1dUL2FPQjFRcDJHMDROYnhndytya05CSnpQVHF2bVlZdWlwYnI0VXRF?=
 =?utf-8?B?ZHpieG01VUJCZnRZNnFBZ1dUcWptYkl2NEJxRDNzdmVWd0xvRDdLcGMyUm11?=
 =?utf-8?B?UzFLeHpyZ0ZCUGxtUVNIQTE1OEZaa3JMV0diWkR2ZUlmMXRJa0R0L1NWalFk?=
 =?utf-8?B?UHNHbE9YSlJjMncrYXdTY1piYXdIR1ZhdzdEd3h2MkNwa0E0M3Q2MXlSeTVF?=
 =?utf-8?B?WFdpSGZGWXhWSEhxaUJMOGpUZ05pQWpORkhqeldoTllSN2s2S1BSbVB6NEVp?=
 =?utf-8?B?TWVaTkh6d3JIRDdqQXg3RFhLTVk2MUpObXpjcGVRNlRoUFNqeTcvZXRJaEpI?=
 =?utf-8?B?WmJGcDRSWTgyNmFYNElUZTlUNGRRSG9DS0tGY2lYbEZSMDZFQXRVd2djV2RP?=
 =?utf-8?B?VzFmV0tIY1J5dWl5b1ZuUlpjdWhSOEhLQXBYZFAvaHc3eDRCRXFkV0hLQU9H?=
 =?utf-8?B?YmQ2b3oyN29vSXhtV01jTkljeU56L3FJVnA4L0lmeDdrZTlaTnZyZWdQYmk4?=
 =?utf-8?B?cWF4K3lmMnB2ejR3cng2eHVWYXczQURhZkJXOE96NTQzNVo2NU9RaXo4b3RT?=
 =?utf-8?B?UVRkUDIybnRDZHJRR2tMREZLdjZiTEJMNW5XclJQd2lLcVpjWUVKTVptTXY5?=
 =?utf-8?B?QTJ5dVZjdHZ6K1FVUU9YTWUzTE1RTXRyYlNodmVEL3YxWkJFbFdPaExkcjRS?=
 =?utf-8?B?R1Zrc2hYeEllOGIvRHVEazRrMitBcHNUSGc2QUd2Y2FBeUVDck96VE9DNWpL?=
 =?utf-8?B?dnNWRkh3WlRaY1BUSkdUZmh4MitSZ1hjN2ZtT1c2UVJtQUpSdXFyeVdFb2R1?=
 =?utf-8?B?bG15dkF5N2ZPNTNka1hRU29raDh2eEh5dnJOY2RuNU5SZndxVFdLa29pR1pm?=
 =?utf-8?B?S3EvVTVhRit6Rk13ZTgvMmlqMEZFVnlWZStrWkZSS09mTWZxWWI5V3p6VmI4?=
 =?utf-8?B?OUY1M3ZFekE0RWl0eWU3SDlDcDNxc3RpS2liU2RNeTRvODZ6RDl1TEVqM1lp?=
 =?utf-8?B?eS9QelQ1Rm1qLzM1eXNBOWRwTUVXeDRzUGtRbUY4bVBLb3NIc3lveGI0a0tI?=
 =?utf-8?B?bVZ4T1hLY0ZPSHZsOC8xS1laVCtxQmIxWjFLY2tmeFgzWnpBN2Q1Vk9qanFi?=
 =?utf-8?B?TUNFVkNFcGtDcmFwaEV1N2ZPaWV0VkNMeXovVE5Jc1Q5ZUpuZWNrOEJnRnV4?=
 =?utf-8?B?Mis4V3dqcGF0bHpvRWhldjFhcmxoSG03ckNodytCQ0pQdU82MmV5WTBUZDdN?=
 =?utf-8?B?RkdydVZFTThrY0NHaXlIWXBPcllEY1dYZjRJaWora1pOc1FqZzRlMnNERXdT?=
 =?utf-8?B?WDlCZ01nN1pGcmN6UjhSYk1xVWd5bU82MUZIb09hSW9qK0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(14060799003)(376014)(82310400026)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 16:50:58.1023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de38015-0c42-45de-3bd6-08dd1a03fca8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6719

Hello,

This patch set implements initial support for performance counter
sampling in Panthor, as a follow-up for Adrián Larumbe's patch
set [1].

Existing performance counter workflows, such as those in game
engines, and user-space power models/governor implementations
require the ability to simultaneously obtain counter data. The
hardware and firmware interfaces support a single global
configuration, meaning the kernel must allow for the multiplexing.
It is also in the best position to supplement the counter data
with contextual information about elapsed sampling periods,
information on the power state transitions undergone during
the sampling period, and cycles elapsed on specific clocks chosen
by the integrator.

Each userspace client creates a session, providing an enable
mask of counter values it requires, a BO for a ring buffer,
and a separate BO for the insert and extract indices, along with
an eventfd to signal counter capture, all of which are kept fixed
for the lifetime of the session. When emitting a sample for a
session, counters that were not requested are stripped out,
and non-counter information needed to interpret counter values
is added to either the sample header, or the block header,
which are stored in-line with the counter values in the sample.

The proposed uAPI specifies two major sources of supplemental
information:
- coarse-grained block state transitions are provided on newer
  FW versions which support the metadata block, a FW-provided
  counter block which indicates the reason a sample was taken
  when entering or existing a non-counting region, or when a
  shader core has powered down.
- the clock assignments to individual blocks is done by
  integrators, and in order to normalize counter values
  which count cycles, userspace must know both the clock
  cycles elapsed over the sampling period, and which
  of the clocks that particular block is associated
  with.

All of the sessions are then aggregated by the sampler, which
handles the programming of the FW interface and subsequent
handling of the samples coming from FW.

[1]: https://lore.kernel.org/lkml/20240305165820.585245-1-adrian.larumbe@collabora.com/T/#m67d1f89614fe35dc0560e8304d6731eb1a6942b6

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Co-developed-by: Mihail Atanassov <mihail.atanassov@arm.com>
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
Co-developed-by: Lukas Zapolskas <lukas.zapolskas@arm.com>
Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>

Adrián Larumbe (1):
  drm/panthor: Implement the counter sampler and sample handling

Lukas Zapolskas (7):
  drm/panthor: Add performance counter uAPI
  drm/panthor: Add DEV_QUERY.PERF_INFO handling for Gx10
  drm/panthor: Add panthor_perf_init and panthor_perf_unplug
  drm/panthor: Add panthor perf ioctls
  drm/panthor: Introduce sampling sessions to handle userspace clients
  drm/panthor: Add suspend/resume handling for the performance counters
  drm/panthor: Expose the panthor perf ioctls

 drivers/gpu/drm/panthor/Makefile         |    1 +
 drivers/gpu/drm/panthor/panthor_device.c |   10 +
 drivers/gpu/drm/panthor/panthor_device.h |   11 +-
 drivers/gpu/drm/panthor/panthor_drv.c    |  167 +-
 drivers/gpu/drm/panthor/panthor_fw.c     |    9 +
 drivers/gpu/drm/panthor/panthor_fw.h     |   11 +-
 drivers/gpu/drm/panthor/panthor_perf.c   | 1773 ++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_perf.h   |   38 +
 include/uapi/drm/panthor_drm.h           |  538 +++++++
 9 files changed, 2553 insertions(+), 5 deletions(-)
 create mode 100644 drivers/gpu/drm/panthor/panthor_perf.c
 create mode 100644 drivers/gpu/drm/panthor/panthor_perf.h

--
2.25.1


