Return-Path: <linux-kernel+bounces-441981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DDD9ED649
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385542844FA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D875259496;
	Wed, 11 Dec 2024 19:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="d1OJ0zPc";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="d1OJ0zPc"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D32259495
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 19:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.75
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944605; cv=fail; b=WbMQms4O8SeuU1GBBommjIo4ukUZNUBMVGenOGpBy3OxfYdrvV6jvUIL979SKKrHjx6ZDZ34XVYLk6JSwsgg/zLjkcpI0zFNeEYarSIsUA8onUXYspYC+AxloL2cit0RB3iGqL7IsS/pvoJhCRA7RtCk90Y1EqrDUUHYD9LGO4I=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944605; c=relaxed/simple;
	bh=Fg6N9MSyxgPaNbC+Yj+HbfMvvENDxq50kDcqYXNJgAI=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bVcxeO4Z2BCmqpLHzxruDKyrZp4kdTXDA3tEIHXmvleZe7sWqeCrrYQbTeFR9aMxTOEBh7Oas8tUMmPK4gIyfErRy+wOtsoIUvbV7t2avMQsdvtB+d2U0GgJQd8LxRZ+XUmQ2yLxcCL9N5ViAiuAyti8uGUt3bMGF3KOwgcviNI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=d1OJ0zPc; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=d1OJ0zPc; arc=fail smtp.client-ip=40.107.21.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ZfvpvbmOB4Eded/X+X0iaVI2prPikupCQm3MsUGSip/7ab2u064F9ADMPVwNO+oGPkwId6iXxouUEkyaIkDIS1Caz9ZsAdEsKtzH639v9m1Rpx5XQxZSOpt/FXPs3PUZbl4oZuvpKO9wd8UbChYenODPqjRWmrExaHVWvEzynCNdmSQOdPQqaa6vqCpx2TKvdQJKKxdoaA3m/bNUPHEwliAXq7zgw1c61USMzc1BQIeS/ZNIgOLMKmeaHUvEDQCCFi5H2n+Sow/xRR3xSwQScOZrVk14A2AKAI3oEt0Eoyn8hezzcw+nnwlODCB/lJ2n9Hvu+APCCQNG+Z52rAK8nQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaLp+T6UXGcDqeiIiAgSBEsJxb/JaMVXmTLDemZQsNc=;
 b=boT4emV2RjATbK4R6KLdGra09fd5bX/0f5QvZ601igDgPakvUycftSyBK+hIkxsyF7DbxDMsW98cho+bLc01J+oLbRzxxp1J0+l0ANlTHO2iyI+m4jhpAUyoZWCXXVQk4DkZ/2Y9PBf0tXshR688egWMY8B3a31kfSYuGPN+08DBeBseJI5Lgc1939RCqjHr9Z9TDY58n4Nc/ziVOBa18ZFlclhCkNzgw1Cyu0X9KNVsZ7T29iai9236KErzMPUfAzYkYHtQe4eUm9qlCCDs6XPnOA/MX1oPla1MYPVF0IJzzo7mLRATjxWRGCa1uYqb9b4SOPD5QnfGdo9DzV/x7A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaLp+T6UXGcDqeiIiAgSBEsJxb/JaMVXmTLDemZQsNc=;
 b=d1OJ0zPc5lRv9/GMszKHDP3iVGKiFT8Gcgor9ePmACzuTnu3gIRdOewI8RWgg+yN6Zbig4qaFjcDccSyIPRRUR+ePWKy1J4J/r11gAZoC5kayAaWTRWonBLaEb1spcZKXOTzQa4+fOVe+e7F56XPKO8HuQI+AKIUGh5umG3hOLg=
Received: from AS9PR06CA0452.eurprd06.prod.outlook.com (2603:10a6:20b:49a::13)
 by AS8PR08MB5893.eurprd08.prod.outlook.com (2603:10a6:20b:23e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 19:16:36 +0000
Received: from AMS0EPF000001B7.eurprd05.prod.outlook.com
 (2603:10a6:20b:49a:cafe::d0) by AS9PR06CA0452.outlook.office365.com
 (2603:10a6:20b:49a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Wed,
 11 Dec 2024 19:16:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001B7.mail.protection.outlook.com (10.167.16.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Wed, 11 Dec 2024 19:16:35 +0000
Received: ("Tessian outbound 3df7a8fbf509:v524"); Wed, 11 Dec 2024 19:16:34 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a43be5dd880e9482
X-TessianGatewayMetadata: mO8I4cDAiicBjX3KTeiT/oexRV1ZJrxdTeZjltZlafvuUMZp4oParLdDNDCo3u9wiQWw2YlD4Zqy6GhPerQmcR5ODTx8t6wboguNT8XOTj9OxonOBOJRPAni6w2Q9AEjK+QBh8eMlOlHS/GwQHNkgeLxiCgGEThSU4nCbmNozQU=
X-CR-MTA-TID: 64aa7808
Received: from L0a122994beef.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 55C5A723-60D4-41CA-87CC-8895F81EEE65.1;
	Wed, 11 Dec 2024 19:16:28 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L0a122994beef.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Wed, 11 Dec 2024 19:16:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwHRrmCEfL2DjUDv9MKRHU1P2PgiZuhsvMOTZvZ7mWUSl3aVBwK7JvOW2zSNWEYKwicFR+XI+G38CYjluftei3ZfxQRwZ1DsAqs9LwHxDa2Qh2LaPZB+lEbbivV91cqgEQNbSZBqMm7EECZkg9Q+frrqNWPfer1An7PwleP4BFGM2ZurQzfJMlN4Qw/ov7u5dntEs4x9bqAL+0TkRiXOZHm3ZJ+gMOEr00nA0XZy1/AbgumE/2wzc1gIDsRl1GtqgQXrxYXxW9085/SSHQIltKDXeNMy5AV2Efo+aHu+323r2y+yz/Omx3QVQfSD0eV9VjDsX0Ox7Ow4TVXLijTGUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaLp+T6UXGcDqeiIiAgSBEsJxb/JaMVXmTLDemZQsNc=;
 b=fdq2LlIkbAGmtG9b+qmvr33Z3j3oxmkAROWTb6mdsPSUSmwJiFEKHBmjAGw7EbxlgiVSrD1PEn2b9KofQYyCHYsNEd58Qipj1dssH47zfZ+tyb+qB7f0t06KH4Zb9IrGl7Mj0pmeR41vAC+6AbHjdiLWlMBrsJ62dcR+KIo9jrzcEtkKemj+iXu+BQzXai06A5Mkvsqv+AainVz05pXindFXfOrqEpK2DT65bY/p2dTd2z4dKISmQOXBMV3pHST12/AWILdplg895U5UowpQrYWld6EGkepDL6ctKuCixqd6jueLrUZllktEfDfVXT1foANTygZ1lCoPEom+5Sernw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaLp+T6UXGcDqeiIiAgSBEsJxb/JaMVXmTLDemZQsNc=;
 b=d1OJ0zPc5lRv9/GMszKHDP3iVGKiFT8Gcgor9ePmACzuTnu3gIRdOewI8RWgg+yN6Zbig4qaFjcDccSyIPRRUR+ePWKy1J4J/r11gAZoC5kayAaWTRWonBLaEb1spcZKXOTzQa4+fOVe+e7F56XPKO8HuQI+AKIUGh5umG3hOLg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com (2603:10a6:20b:290::9)
 by PA6PR08MB10646.eurprd08.prod.outlook.com (2603:10a6:102:3ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 19:16:25 +0000
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c]) by AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 19:16:25 +0000
Message-ID: <b2f16572-34c1-417a-b973-9170ea05a91a@arm.com>
Date: Wed, 11 Dec 2024 19:16:23 +0000
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
 <85010ca7-0c34-4be6-9dfa-5be742ded25d@arm.com>
 <bvqjlomae7w34nawaqtrnthqvcypjui4cperriorzlv7uhngxb@4pqbagnew7in>
Content-Language: en-US
From: Mihail Atanassov <mihail.atanassov@arm.com>
In-Reply-To: <bvqjlomae7w34nawaqtrnthqvcypjui4cperriorzlv7uhngxb@4pqbagnew7in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0185.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::10) To AS8PR08MB6263.eurprd08.prod.outlook.com
 (2603:10a6:20b:290::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR08MB6263:EE_|PA6PR08MB10646:EE_|AMS0EPF000001B7:EE_|AS8PR08MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b8ed3c-7033-4fdd-102c-08dd1a18548c
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?ZmNWV3RBVThEQWt1UWRDUTN6aVBOek5vNzB1NjdKSW4xRGJLUnJqNStVd2M2?=
 =?utf-8?B?T1IzU1BaNmwrQnh3a0Fuc3FOOXQxWCtaNTJ2ZldTOFUzSHJOOUtYamduZVNR?=
 =?utf-8?B?cHFaZVVxL29CczVET256L0p4emZLdEFrdlhHNlNGSEhLTUxxU0VTQmErOVJo?=
 =?utf-8?B?WWljeVRsTEpiRzN4ekZKekJCSGVjWDU5V29xYUpFU1hnTGhiNnFMc2lVdGFI?=
 =?utf-8?B?T3d2NEc5cS8zelVsMzRnOTMvVUhHQkZ2b2dEcTh2QmZuQ3ZYRzFzWmJLb3B6?=
 =?utf-8?B?VVdLUlFiWmlHYWdIVXFZWUlTMG9hY1cwVXJQWXdUbU1mc0loVXNuQU5TdHlR?=
 =?utf-8?B?NWJDdkdIbFlaWTNKWElSdXVEck5Yc01TU0dxUFIzZHVLc05BcEVWMjB1Q2lt?=
 =?utf-8?B?WnU1YVQ4YTMwZm8weW4vR003NmdTNjM0UDJ2eVhod1dNRk93OGRnUlJtZGQ5?=
 =?utf-8?B?RkJWeWxDVDZ2VnlqVDIzWVpxOGxjaStzSDZHaktHMmNBa3BaUFJJUEtOZ25x?=
 =?utf-8?B?RjZIUFUxSmZZb2YzNGxDcjBlWGNsR2NZeUxnbldlQUxLVGdEVTRmc2FNM0Vs?=
 =?utf-8?B?MkY5OXdQMERCQ3lHb0lzY0dLWkt5a2R4cUFDUXVVaGpwdStxT0NoRkRZT1Mz?=
 =?utf-8?B?cVdJbmdJRlJPQkRFT0JPVWQ2VkxqWkZFWVBVanRMWkdrVkVHTlJwQytpM0F3?=
 =?utf-8?B?Nmx0MnFEVnVqOHQ1NEltdjFISStaWlBYM2s5aFR5WmRJRmtuSVpGWjQ3bUFH?=
 =?utf-8?B?eGxnUXhvbFdPUFp4QzJkd0gyVTI3aXlScHYzaGpDd0twN2hxaUZ5YVNVT3Rl?=
 =?utf-8?B?b20vazMvNDlvZWlxQmo1WkJxZkovcmFPUDR5a3o2UmhwMVY4Tm1yNHJ3bUtn?=
 =?utf-8?B?blMyeGw3c1FDUy9HYVdiMEtZWk5SSW9XUjRIUGRQNHFsckQ3Rjh6bzh5NWRw?=
 =?utf-8?B?czlXVXVpT3Z2UkVlbVlxdndxZ3hKSGJWdmNkUmdRSjYyS3FRZHQvYmdrSkMr?=
 =?utf-8?B?TkJQTm9sZEJCVDBXWDVqaktvdEZwbk52azI5MXZyK2FSc01qVlZabnZGbWth?=
 =?utf-8?B?VFJIbUdWMzVmYWNJRElxT3dxWFVvdjY2dFVrYjdwODFQUFF4STBiL2d2eFdn?=
 =?utf-8?B?SUt4V3gzV1lxdGZmbElsYWEzSVFvUktleWhQWStOZjByUzE4S052NkpvVVRG?=
 =?utf-8?B?WmJ6VjlQc1gxUmgwQ3M3Wnp3bUVZbWNTVzZBMzV3U2lKWkxLeGR3MVptRGo1?=
 =?utf-8?B?TXUzdDRuRlprbXEyeXIxd1RjUXZOS3c5UHVuZklYTW5rN2czQmZQNXVkL2Jh?=
 =?utf-8?B?RlY0S1gzZ2Y2c2NQZytQUjVZUlpYZldoOGVLRDdXV3lwb1NtM29Nb3h1WWw5?=
 =?utf-8?B?U0dWVzNielk3Uk5zN2U5UmxVWnNZVVcwSDZ4cUh6ekZMeWF1UldDSWFjWm93?=
 =?utf-8?B?bjJIbVpqOE1ndGszYnJKTnFZYVdkNVBMWW1ZWWsyS2hodUx4M1VMeUpNM1kv?=
 =?utf-8?B?RTA2WDVNWDNmOHNuRGVlMVhBTEJKN09RNVpxOEJTclJSbzFxMTFTNlNJbXk2?=
 =?utf-8?B?SzdMYklKbXl4YWIzRkVTREdvVUNSbnBENk9XdVlzcVEzUnZRM1grbGVXSWhw?=
 =?utf-8?B?c2habk1vVVhtUmQvZjhNd25wMDhTRnpsbDhFdGc0cHJKb1UyZ3pwQ1N0bnll?=
 =?utf-8?B?blhFSEJuRXZJQU42Z1NhV2N4UXVkUHVMTzRQQmU1TnNreVAzbm5LOWpVK0dG?=
 =?utf-8?B?UUJhU1NpQURqd0tpRGs2dEQ2bFlEbXIwOGU5OTBUZ0pCbTU1aDVIVGpFZkdv?=
 =?utf-8?B?dThRUlovT1MyYmdEWlJsZz09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6263.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10646
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:290::9];domain=AS8PR08MB6263.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3f9f908b-8465-4179-4081-08dd1a184e11
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|14060799003|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlYrb09NeTlPQ3R3OCtZa3psT3RWMXROekxROUpONXBYaEdVS0N1MnBLUjk4?=
 =?utf-8?B?REFBOEtBaGhNdUJCUkNnK2RkTXZCdEVNaVZRTFBmVmFuaEtqUW1Bd3I3eTZV?=
 =?utf-8?B?VWxpZEhZV3V4b0xLSjdQN3IwZXhxdFV5YlFFR3NzREFXSUVpbGhDMGtKN1A2?=
 =?utf-8?B?dWxJQVJSSmk3QmNIdjBnRk5zM1JlQjJNemFYUEk0UnQvRWl6TEQ1NkFKMVpI?=
 =?utf-8?B?b05NeWJpWG83M0xCUzFmejhMYUZCZlhNaThRRGkwRGk5bzM5SkZWKzJXbW54?=
 =?utf-8?B?Z1piUGk4RlJxbWpNZk1URVoxcnE2SmpjTktUbzhGY1dXTS91dGFUNDlWRWUr?=
 =?utf-8?B?b1h4UlBZckVNeE9zVTVXUVJhNHBoSWNOK2ZBQktWYm1DcHFPZnk4ZnlJSDZB?=
 =?utf-8?B?dktkR0YwaGorTVNxMTVOOS9YaUZoalFrOWIvSWhGeENuWjAxY2YyY1p2RWc1?=
 =?utf-8?B?cXZ3SjNWQVVhQmVxNkR2WDJrZXpqeUFNNzh5MmlVcXpleUZhR0lXbTgzbVJw?=
 =?utf-8?B?WVgwSFoyRE1qMkFoZzBScmhSb1ZlbitiQno5SnBMOElicTl5TUFWd25pTUF3?=
 =?utf-8?B?cW5vTVBuZVVKQjBTWmN6L0hPdGorbTA0QVg5YVp2MU0vMFc1ZUNKOCtqakEv?=
 =?utf-8?B?bTV1bFpLclRMb0dpNTU3amFieVVQclN3NDRRbEs5N05QYm1zbGlWMnlqNG5R?=
 =?utf-8?B?Nk1YbE9JZTNzTE4zSExRaUVFTWpvZXRCc3lEdzVxMkZkRFlpKzdyWWppcVRa?=
 =?utf-8?B?Qzg2ZkppZEEvcWxIbS9KSnlhald6Tk1JUVJveTh4Z08yeVhqclJ1Nm96Y2xj?=
 =?utf-8?B?bXFYTHRNWGNaQkJDMnE4VGJIN1E1akVMOEh1a2pmNU15WDJMTnh5aWxZeXJP?=
 =?utf-8?B?UVd6cVVYYWV5ditNRE5yd1FXRzd1YVVld1diRFBkVkJGM01LL2JiZ2sveXR6?=
 =?utf-8?B?OU1JMytqQ2hrTEdsZmpRcUpxdXdQNXZYSnVnV05jNVVJai9jSkhIWE8wSjI4?=
 =?utf-8?B?LzVnY0RHQjlEMjVsWitRQmtoZHRKb3pTUGxRRGhEY0NaMno0OFFUODloNWg4?=
 =?utf-8?B?eXVUOHl2TGdWVlg1QmNNKzdQajdhN1JDaHNQWm0xOUQ1NkkyNElpSWIrSzBR?=
 =?utf-8?B?K3h6S2pseU1LUWpsajR6U1V3MzgvbG92MVY3OXJaTnJPUm0rS043SE1ncEti?=
 =?utf-8?B?MnV6K01ieEl3YlhPNWR6YnlZdW1qTmNZbHEzSmZWTHhyd1dqTHRaNlVJWmNI?=
 =?utf-8?B?OUphNTlpUU5YMWFJNnR1WGp6VnFCZ1ZRdFhHNXp4dHA3Y0ZpMS9oSlhYODJ2?=
 =?utf-8?B?bStQOXRiR0FKWjlYdlJrWUc4YWR6UFFzUld4bVJMTkFlMGtveXBXU3Nuekt4?=
 =?utf-8?B?SFJPbjhjU281UjE3SjlLTVdZQlBFaWdUQ25QQUZsYTI3RkF0NCt4bTlqVlpl?=
 =?utf-8?B?QkVTa0Q3eDNrbFFsbDlLT3MweW1GUHRrckora0pHbkF3YVdyQ0dROEtubWtB?=
 =?utf-8?B?RjJQem9WWFBzWldmdjgyQlo3bWMwSmNWTGRyZDhqWllwcDBESVZQMWtUQnBD?=
 =?utf-8?B?QkoxMDlRTWpLb29qRjhndko1UExaZDdVVGRLVVlZS0dScEVJWmtFQTlOTk1l?=
 =?utf-8?B?WUhONDdOMHlxZFRSM1NpSFFuTlRFbFppY0ppSWxxMmlkRWc3NlN3WG4wQ1Z1?=
 =?utf-8?B?UXJ2QlU5em1ZYTg4M0pibzVhU3BDaE9YQUFGY0NvRWV4RG56d2FVWGhTWGgy?=
 =?utf-8?B?VGQyZUR0b2wxeDA3STZyUHJqZUttOERwbEhMcys4dkpNRTB5V3R3YkFtc1ZW?=
 =?utf-8?B?VDg1Q1hPZkxqOTREZjh6YTVudEl3M01GeVF5RjFDVXErMkpTQ21jU04waXZJ?=
 =?utf-8?B?M0lBd0VzYmllV3lzTW81encwMmRDQzVWd0NWOSt6UTNGdnZXYWVhaUR5RTZH?=
 =?utf-8?B?ZXQ3ZEhUSU9zYlkwV2xyMmlrVnZtaS9pVmxoZVUyNVFjUFB6YktHSE5ZODJX?=
 =?utf-8?B?V0RIZ0NOaXBBPT0=?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(14060799003)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 19:16:35.5856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b8ed3c-7033-4fdd-102c-08dd1a18548c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5893



On 11/12/2024 17:02, Adrián Larumbe wrote:
> Hi Mihail,
> 
> On 11.12.2024 16:40, Mihail Atanassov wrote:
>> Hi Adrián,
>>
>> On 11/12/2024 16:34, Adrián Larumbe wrote:
>>> A previous commit enabled display of driver-internal kernel BO sizes
>>> through the device file's fdinfo interface.
>>>
>>> Expand the description of the relevant driver-specific key:value pairs
>>> with the definitions of the new drm-*-internal ones.
>>>
>>> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
>>> ---
>>>    Documentation/gpu/panthor.rst | 14 ++++++++++++++
>>>    1 file changed, 14 insertions(+)
>>>
>>> diff --git a/Documentation/gpu/panthor.rst b/Documentation/gpu/panthor.rst
>>> index 3f8979fa2b86..c6d8236e3665 100644
>>> --- a/Documentation/gpu/panthor.rst
>>> +++ b/Documentation/gpu/panthor.rst
>>> @@ -26,6 +26,10 @@ the currently possible format options:
>>>         drm-cycles-panthor:     94439687187
>>>         drm-maxfreq-panthor:    1000000000 Hz
>>>         drm-curfreq-panthor:    1000000000 Hz
>>> +     drm-total-internal:     10396 KiB
>>> +     drm-shared-internal:    0
>>
>> You give an example of `drm-shared-internal`...
>>
>>> +     drm-active-internal:    10396 KiB
>>> +     drm-resident-internal:  10396 KiB
>>>         drm-total-memory:       16480 KiB
>>>         drm-shared-memory:      0
>>>         drm-active-memory:      16200 KiB
>>> @@ -44,3 +48,13 @@ driver by writing into the appropriate sysfs node::
>>>    Where `N` is a bit mask where cycle and timestamp sampling are respectively
>>>    enabled by the first and second bits.
>>> +
>>> +Possible `drm-*-internal` key names are: `total`, `active` and `resident`.
>>
>> ... but don't list it as a valid key name here.
> 
> I do mention slightly further below that that key:value pair is at the time being unused,
> but I've thought of a possible interpretation that could be part of another commit.

Understood, it just looks weird reading the paragraph after the context 
above. Seeing as `drm_print_memory_stats` will always emit it, it stands 
to reason it's a valid key name, just with no assigned meaning to it 
(yet). I'm being nit-picky :). Feel free to add my R-b with or without 
the extra key in the list.

> 
>>> +These values convey the sizes of the internal driver-owned shmem BO's that
>>> +aren't exposed to user-space through a DRM handle, like queue ring buffers,
>>> +sync object arrays and heap chunks. Because they are all allocated and pinned
>>> +at creation time, `drm-resident-internal` and `drm-total-internal` should always
>>> +be equal. `drm-active-internal` shows the size of kernel BO's associated with
>>> +VM's and groups currently being scheduled for execution by the GPU.
>>> +`drm-shared-memory` is unused at present, but in the future it might stand for
>>> +the size of the Firmware regions, since they do not belong to an open file context.
>>
>> -- 
>> Mihail Atanassov <mihail.atanassov@arm.com>
> 
> Adrian Larumbe

-- 
Mihail Atanassov <mihail.atanassov@arm.com>


