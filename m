Return-Path: <linux-kernel+bounces-441678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6269ED24A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96AB6165C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4141DDC11;
	Wed, 11 Dec 2024 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="a+OAi4pB";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="a+OAi4pB"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2047.outbound.protection.outlook.com [40.107.247.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA229748A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.47
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935272; cv=fail; b=M+YGSGdd7yrLqQxTm/j5Cy4pya3ih/mtSUItEDDdpmFLAZmBS8leRT4z+r7W+XsyTaAS7yDspHpHcrY6aaQ5wjj9TpwYbs4i3jzaZg+XnWcpO92E8Qa4pSJCAUZnJzcj7w8Wtub8+dZchnTu6Gw087jJhoIqgLOZVmU1eCz0/UE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935272; c=relaxed/simple;
	bh=NseJEVGiXVdSwlqGzy76taC2yQC+DTpKxcKL83qLkB4=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pvE8HA4762k4ZwwiIv1dXGRQEVvbhuSXDt7J9yRftoO/NWTXDL9t2tVSX1ybY7aD0HSRa7dNUBNDTML9SkcE+rSW0J3Ob75WLCDZhwsG2Bljj1EIWgFjZWobr4ziX/hjVJ7n2yKLanNOCjzZVmTw6IKhs5cppv12mlbxSN6Rl94=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=a+OAi4pB; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=a+OAi4pB; arc=fail smtp.client-ip=40.107.247.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=FXOIdZYKdgJOA8JZg0R+z5TGt/Rx0/ihS4U/Wl++/OqVJVlC80UEQXlTIPcwO2kMDfjSl6oEI8UNUBafNdspeg5DK/g2IhHJLQ8Cx70DF7vR9LcBRdIFF2FSl+V93CJIIi92Lnw6LDoxcRhMlz9YGHggj28OJAd4qYIFGm3iKjWT2UGg/TInW5gnwd+X9KfCmO8NA4aa+3yXOfhjp47SzPhUmAgChvvl91xCNn6MqG7m9D+atPqzkT9uZdjAB3SstYSna25jbZR3F4XfpdR5AtIFT8Y+qIKgL6UdKGQiAiasg4iXOlZxjMCj7Mn1+Poq7dL3oh3J22W0UEF5POjKDA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMcPW/PW41mSF0ipfeQSiR5086zQU755QYsBd5D2Y2w=;
 b=Zcn6xammpUyxsAAKIc/OuUMydS0bQqb5B4sEQJflmBOsLty2K7pD35BN7+Q/upaxA9yoQIomPW6cqA0h6tKKHYowhivAM8F9tdNODYtp0lvmyrrQbBaKbS4mYdtxVmbwaL277sOAlbEYa52qQ8LUSRrRdTdZmRrzkZuP2eU4IxU753jyMq1YnziRGt8MxwEe+oqi9vaJvltG9izdIV//DfSIXX4BY8nC+KUn1VyibsDxGxQWtKidZkM0E8uch6QWppTwcGKpB4+5ggBNMMtZ/Omn20a29nim1a8AViywC9JkMZVXisYp0ya9MZsIDDnc+URkbKW4CIEG1ucrVTqngA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMcPW/PW41mSF0ipfeQSiR5086zQU755QYsBd5D2Y2w=;
 b=a+OAi4pBFxQFhIGDxrnT+dwwjuLL6iSEQqNWIq41nh4WVg3dBPnyb/S+7aw0t0IWesUhvTVcEYG979PQstact1qw6veyeWXuF+slEqzejizvMWu+NvU76wL5eELPzOUApAZyRPEVIHuL/zQx+D7wq7Ozcfnq0muWc76YYc1B4qk=
Received: from AS4PR10CA0006.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5dc::6)
 by PA6PR08MB10814.eurprd08.prod.outlook.com (2603:10a6:102:3d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 16:41:04 +0000
Received: from AM4PEPF00025F96.EURPRD83.prod.outlook.com
 (2603:10a6:20b:5dc:cafe::e8) by AS4PR10CA0006.outlook.office365.com
 (2603:10a6:20b:5dc::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Wed,
 11 Dec 2024 16:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00025F96.mail.protection.outlook.com (10.167.16.5) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.0 via
 Frontend Transport; Wed, 11 Dec 2024 16:41:03 +0000
Received: ("Tessian outbound b1586bb311c4:v524"); Wed, 11 Dec 2024 16:41:03 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 36646008b8be89d1
X-TessianGatewayMetadata: mLSsDC93NdeDNN1l8krgpfpSNm719b+h0VM4pKv7nc63nyqpil5fT32+nFXkUbP45sr1X8ju1qVX3elirXWntaOmAqBM5L1Ge1ytce5IuG6SRlvGdHhzae4dCSCTxzpxEIP0e6AjWyeAiNzRgZdj4LFOQPVbjOvxKNLyRN4Y9RI=
X-CR-MTA-TID: 64aa7808
Received: from Lc95972ae26a8.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id C55067DE-A161-4BF8-B8F0-3547A4E5CE23.1;
	Wed, 11 Dec 2024 16:40:52 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lc95972ae26a8.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Wed, 11 Dec 2024 16:40:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZIqMx8y61KsVKTKzhWxxKK8vWCV0YZSKxcf5aYufwIpBm02mP0WYYFthQ0BGZCH89FEeWW2BU+hdow8T8ZLxFDhBE8CGHlKr2ki2Ku5+pbAHTXbpwQJvoI8Oo1VsJge+WhkcGi4VTKBEvqloiLyF/neVALigfrwM32h0Oy3EmShyCavi6QaCjgMJ92RBht5e2AQL5u/IUXr5cE++jpc8BYKWNZOJPNM/DVdo3fzE9Ev24UpdQjuL/nXRJhHl1Jh3XK/1ikkmtZMT62p2ehvQ9uL7KdFjGsp7aLRkK7cBTaz0q8dWSenuVp/3CbUJtX5JhynNvRWA2ROiPoIySuRFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMcPW/PW41mSF0ipfeQSiR5086zQU755QYsBd5D2Y2w=;
 b=dXtIsworbnNr3OOVobsiM3i7bkVaGT4IqUDLMR/Gd1qpuUTEZYo/6Mv2f0XCT/RQRvxNoSjJSdqrlwMikDrTJfbfAkRWBbdyq8Gbc9Bw+aqeYOPYB4lLJ7iXS6U6pmyMg83yH7QRV7ygL+BKkdwZQgNc5Spk4y8KB1Hr86GVfSH7AV8QkOxIUtPmMfotFR7UCrZcbPxDH6nerRuqPfjMC01B+6OLJoCyT8UzvVTjFNb1V/5BBEe8dDT4K0rDu3nLL+rAvnzb+eWCBSBziBI8CdROZoKmW+ekGQEI8znr6a9G957Wu3kAOi4L1yydKIhcLouvowZ55wLtz7oP30lQzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMcPW/PW41mSF0ipfeQSiR5086zQU755QYsBd5D2Y2w=;
 b=a+OAi4pBFxQFhIGDxrnT+dwwjuLL6iSEQqNWIq41nh4WVg3dBPnyb/S+7aw0t0IWesUhvTVcEYG979PQstact1qw6veyeWXuF+slEqzejizvMWu+NvU76wL5eELPzOUApAZyRPEVIHuL/zQx+D7wq7Ozcfnq0muWc76YYc1B4qk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com (2603:10a6:20b:290::9)
 by PAVPR08MB9014.eurprd08.prod.outlook.com (2603:10a6:102:326::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 16:40:48 +0000
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c]) by AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 16:40:48 +0000
Message-ID: <85010ca7-0c34-4be6-9dfa-5be742ded25d@arm.com>
Date: Wed, 11 Dec 2024 16:40:47 +0000
User-Agent: Mozilla Thunderbird
Cc: nd@arm.com, kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Boris Brezillon
 <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v4 2/2] Documentation/gpu: Add fdinfo meanings of
 drm-*-internal memory tags
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
References: <20241211163436.381069-1-adrian.larumbe@collabora.com>
 <20241211163436.381069-3-adrian.larumbe@collabora.com>
Content-Language: en-US
From: Mihail Atanassov <mihail.atanassov@arm.com>
In-Reply-To: <20241211163436.381069-3-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0386.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::14) To AS8PR08MB6263.eurprd08.prod.outlook.com
 (2603:10a6:20b:290::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR08MB6263:EE_|PAVPR08MB9014:EE_|AM4PEPF00025F96:EE_|PA6PR08MB10814:EE_
X-MS-Office365-Filtering-Correlation-Id: 97908185-556d-49fb-490a-08dd1a029a5c
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?R2NnZlFBLzJwYXh5SmVJRHMxdzV3dU1iSGZRcUNEV0g3aTR3VDNKbWhYb0ht?=
 =?utf-8?B?bGdZa3UrQzNmV1dlZ2tiVEE0T0tra0lURzNiTXZGQkpRTXN4bVRKd2QwM2dE?=
 =?utf-8?B?MHpxU3pSL1RYQ3lHdFF1Vk5jU2xyQTFnS0hWZ3BYb1c4SGVBak02bVhreUNh?=
 =?utf-8?B?dU9KQnR2dERvOHI3UFlnTG9UK2RlWDN6SnVmYS85WFArRG5NWkRVeStEU1J4?=
 =?utf-8?B?K2VRSG11aWVBRTdldDA4NXhvbjE4R2RlcHNUeCtNWTdwTkxZL1NmQzFYSmJN?=
 =?utf-8?B?RldRaWh4ZnA0Z3VuNEZjM21CVnJzSFZmeTZHOUw3c2xQZjNGNmVGMlRmNEp1?=
 =?utf-8?B?WG1RakdxSVh0SU1mK3lRcTFVQWxxM2NWbHE4OEU2dGVwOHlSZTFpZnFkOFNk?=
 =?utf-8?B?RVpsbHF4TmhPZGdFRkR4bW0vaGkreW1TNTk3SHZsMXdKQzZCRFppR2c5N0o1?=
 =?utf-8?B?Uk1FcVdIQzNnNFNZaHRFRWlvMSsyZ2llWnpDMW5nTFFmOXMxdjd5WWVqUVIr?=
 =?utf-8?B?OWxjWTNGUHUzeU9NbWY0ZTlueE9RTDdtT0FBUWsyVnpqT0NpdVp4OVNjYzhz?=
 =?utf-8?B?eGlEZGlvbUROditNTDF6YzV6RlZueU16eWt1UTdPZ1hOWVlwRDJJUXlqN3Vt?=
 =?utf-8?B?bXhZMnlLVDUvWTZBakxlVGlieUlsQXdjWEppSjdJN1k1SFNZYnZ6NytOMVBp?=
 =?utf-8?B?Y3JTeFhnTm9pSnJiaTR6c0tzU0pOVnhsUG4zdW1pN3BsemhnQkVhTE9mdW1i?=
 =?utf-8?B?cTVsYTVTOStRZmJQdmVEYTRRRlcyWnV3VDhQSFEvUlBjUE52RndUY1ljNzlE?=
 =?utf-8?B?Z1JJM3NuQ0ZRaTdJTm5tcXFsMEt4cjV4bnl3ektLRFM0NVhwWkRoejJ5ZVU5?=
 =?utf-8?B?ZDN2alpHSCtZMG5oK1gxN0tDaFNOczVrNUpDR2Q2a2JsUUVQVnBsRk5XRWdM?=
 =?utf-8?B?bmNrM3FZNUZNbElRM0NoeUFWQm9YVDRVOTBiaUNCbmRWTEw2M0VJNW5ITWMv?=
 =?utf-8?B?SVRUZUlMUDJkQ0lyQnJzWDVTc0pPaHBFS3VZbWU5OHFBUnk4RXN3eXhQQVF3?=
 =?utf-8?B?c2tMMjNFZ3Z0UkxveWQzVmhjam4rUWhVMkJlQW81SkxoRm1LWnJpMjlLN3Zx?=
 =?utf-8?B?TU90MFJtRVNLTFVMaFFqaTg5cDMwdGRiL3BvRUNiMVg0d3hUSis0dFFqV0Za?=
 =?utf-8?B?YTNwc1Y3emp1SFMxNGdROVN5enRyM3M1YzFGOG43bkt6OERjRUdVVEYybDlF?=
 =?utf-8?B?Z2ErTGkwY1Z3Z05SS2lqbFNhTUV3R24wc1F0b0hXVTFLUm5TcENWb2hnTmd0?=
 =?utf-8?B?ZVArdzhLY2VSYy9JUnpKaG50bTRvRXRuc3ZlaUtuK0JLUDcxdjdoTjlTejEv?=
 =?utf-8?B?SndvckEwd2YxSkZPREE5Ynhwb0wybncvaEgwUnpUUVpBYlhTb1BSY0MvQytx?=
 =?utf-8?B?RktYNithaER6RnBCR2QwR2gwdWU3LzdDeE9MajFnTktWWk1CdnZ5M0Ezektn?=
 =?utf-8?B?OTYyTDByYXhHMlEwcjUrTFZNY3YrVjdOaG9xL2ZTZnBBWTBacWpkWXl6ZHV2?=
 =?utf-8?B?UytBTzczbUdPK0lEeVlhdFkyeVRZVG00VUlWYU51bzA1RFBsMmRkNmxLOUtl?=
 =?utf-8?B?YW92TWVlS056NGZRcGYvM0ZTQlFJc2hjR05NUm1RMDZ4SkV1b1cxbEFGeDZQ?=
 =?utf-8?B?ZGVydTl1emxhQXA0QS9Gd0pteDVqcS9sSFUrdThIZ1VWbXRseUxLWVVzVXBU?=
 =?utf-8?B?M0ZRYm50VDBBb3FqUWtzQmlrV3MyUXM0aGlkbWFVQTQ1dkIwQm9nN1IyWHho?=
 =?utf-8?B?QmZHazNDSEs0SmNQbWpUUT09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6263.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9014
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:290::9];domain=AS8PR08MB6263.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	01135f8d-a026-43f0-8808-08dd1a02911f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|1800799024|14060799003|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0grS2x1MjlhdHdCNWZ6RUhRYXhMeC9rVy90WWFHczNCeWpickZOMGdVRjhL?=
 =?utf-8?B?aldkSlErOVhac0YwWmRUWVFFR2FJcFhpV1Q1TExsY25kaEwvamRIemxFNVR5?=
 =?utf-8?B?VlpMWkFWY1hQTEJ3bnJlWTJ5cS9IZTkyUGs3MHpYU0h6WWJmZUlBWjBLKzE4?=
 =?utf-8?B?R01YMnRvSkx5UUxLMFovWEtNWUdrSFpuTkRQM0RtSUpqa2dPTHZIUXdEUE1W?=
 =?utf-8?B?NlEwM1QxMzczSzNYVGxNeUl5Z2ZtOG5ZbUpBMWU5U0U0K0dpdVdjR2dJNFBL?=
 =?utf-8?B?ZzNjVlRNN0FuZzl1YkxRbUQ1ZXJBSk12ZTFlS2dnMm5tdWRVS25jYmgrQVBr?=
 =?utf-8?B?VndQWkR3MkEyODBNeGRxYjZ2c1dXSEJYYUsxM3VDRDJJYi9WUFY4bHg4VC9B?=
 =?utf-8?B?YTZKMGRPUDRFUmx3K0pmWUFBaGpTemFPeUxxSTZTT2hPQjhoYzJ4OUtHeVpz?=
 =?utf-8?B?aXZXNUY0YkxTTUlmcXhyNkhGWGxtSXh3dkhHcG1yUW1BbVNlR05SMmRPUEcy?=
 =?utf-8?B?OGdtRzB2b2RsaHFxZlNSRThScURmVE9tT0pCY0JXQWJWckZEVnROQ2FFS1NE?=
 =?utf-8?B?V2F3VzVQdEVGdFdKZk1lbzVaK2hKSkQ0byswTGhIeXBLamx1aFlydXptb2tq?=
 =?utf-8?B?QmU0ZEFNalcyeEJyUktCZzNGQjUwMkh3RUZBajhjdlZmOVVab0dqUGVRcXh1?=
 =?utf-8?B?YzQyVkdpTzErcDFmaW9JY0VhMm0wNVJBaEhLUXFjMmIvYWRvNzFZeEp2T2Qy?=
 =?utf-8?B?a0MrSFM5N2pMcVVuN3VnMXV4RitRRkFYVjcvaGJIaGhxeC82Q3B4cEVuMDlB?=
 =?utf-8?B?azB5Q0xKTE5WUEc1TEFqdWJueEdLdTdCQURrZGgzclhyc0JCTzh1Qko1T29G?=
 =?utf-8?B?dnlUNERvdzV6aFRMYjkyVEhpNU9SNHUwQmdoNGJBd25wNFFTSUtaaSs2bFQ3?=
 =?utf-8?B?WmcySjZCbWZzdHNzY1M3SklhZmMvcDBKMjlpTytod0xvK01ITWZwdnd4NHBa?=
 =?utf-8?B?cUg3cGRoYVhXTjRPMW9vNllaVDNOWWxNN3BzdHV1Z2VnZWlSTnk4dmo4U3pE?=
 =?utf-8?B?QXlMSlBPMEFuYkxXN2IraXJucU5sREJzcDBwZzhrbnQ5NE9EZXArODBKekNX?=
 =?utf-8?B?Mjc2c2lRQmZFbDQ3WVNBdlF3UkpYUXBTc3NsYWt5Zm9XVCtqWW1Kdng4YUJn?=
 =?utf-8?B?Vk85TmxUaWVhcWxWVUFLQ3BZWEFsLys1dHA2TVhxdStVQ1EyaHdKbGFwbGdu?=
 =?utf-8?B?UnVSWjl0R2ZhUXB6RVNxeGorbmc3cjZkcFd2dFZpN3RydWMwN0tCanh0UWNs?=
 =?utf-8?B?Zk0yWVpiSXZ4VnBUOFRxSkxOVHlTL3czWUh1Y0Q2L1BOOW00SjRzQmxuUENV?=
 =?utf-8?B?bTdDNFN1MHUzWXpzSjViaUJ3WUJxaDlneHJYK1FFRG9aMlErQ241cElVd2F2?=
 =?utf-8?B?NE1VNXN4UmlGNy9LeXZCS0thUHVsNGVLTXBscHcvTUJTSk9ERDlJSktCRDVL?=
 =?utf-8?B?ZmwvRnliVHUvN1ZncHZWZGVpVGxUZEFGYkFZRVkrbnFKTHFheklrekJHRHNr?=
 =?utf-8?B?eU5HYWFzV3Erd0dBNFV0TS9tenVpMzJRZVRPTDFFQ1VEYzdnOGxjQ2xZdTlM?=
 =?utf-8?B?Q2hiQVVKK2NpSXY0UmtvYTREbUFwMWJKR20xem9oZWU0aTY3bFovdk5PcDBs?=
 =?utf-8?B?U2IycmpjUE1KV3ErMzl1SFZRNys1ZUlVMVhHRnErWmdNT2t4eUUrVVZLVmVr?=
 =?utf-8?B?ZHgzd0UzVktrZzF2WVZvY0R2c21MUlV0TnREeXhRV2pFNzJOODh2MHVzTmNV?=
 =?utf-8?B?elpEV09KcHAwWnNKa1hLMjJ1ODBwcXh6czBjUUkydm5peGJnS2wvSThYcmsv?=
 =?utf-8?B?L3cyWisyNnUzejBpVUhQNWtQSVc0b2pvY09BV3lydzBwQk8rcTE0RStrK3JE?=
 =?utf-8?B?TkJpUld2aktXSDZpNjl6MldIdkQ3MHhPUmJaYy9iaUhBN3IvRGgvTlNxdVN2?=
 =?utf-8?B?LzNXb2NQUHZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(14060799003)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 16:41:03.8005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97908185-556d-49fb-490a-08dd1a029a5c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10814

Hi Adrián,

On 11/12/2024 16:34, Adrián Larumbe wrote:
> A previous commit enabled display of driver-internal kernel BO sizes
> through the device file's fdinfo interface.
> 
> Expand the description of the relevant driver-specific key:value pairs
> with the definitions of the new drm-*-internal ones.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> ---
>   Documentation/gpu/panthor.rst | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/gpu/panthor.rst b/Documentation/gpu/panthor.rst
> index 3f8979fa2b86..c6d8236e3665 100644
> --- a/Documentation/gpu/panthor.rst
> +++ b/Documentation/gpu/panthor.rst
> @@ -26,6 +26,10 @@ the currently possible format options:
>        drm-cycles-panthor:     94439687187
>        drm-maxfreq-panthor:    1000000000 Hz
>        drm-curfreq-panthor:    1000000000 Hz
> +     drm-total-internal:     10396 KiB
> +     drm-shared-internal:    0

You give an example of `drm-shared-internal`...

> +     drm-active-internal:    10396 KiB
> +     drm-resident-internal:  10396 KiB
>        drm-total-memory:       16480 KiB
>        drm-shared-memory:      0
>        drm-active-memory:      16200 KiB
> @@ -44,3 +48,13 @@ driver by writing into the appropriate sysfs node::
>   
>   Where `N` is a bit mask where cycle and timestamp sampling are respectively
>   enabled by the first and second bits.
> +
> +Possible `drm-*-internal` key names are: `total`, `active` and `resident`.

... but don't list it as a valid key name here.

> +These values convey the sizes of the internal driver-owned shmem BO's that
> +aren't exposed to user-space through a DRM handle, like queue ring buffers,
> +sync object arrays and heap chunks. Because they are all allocated and pinned
> +at creation time, `drm-resident-internal` and `drm-total-internal` should always
> +be equal. `drm-active-internal` shows the size of kernel BO's associated with
> +VM's and groups currently being scheduled for execution by the GPU.
> +`drm-shared-memory` is unused at present, but in the future it might stand for
> +the size of the Firmware regions, since they do not belong to an open file context.

-- 
Mihail Atanassov <mihail.atanassov@arm.com>


