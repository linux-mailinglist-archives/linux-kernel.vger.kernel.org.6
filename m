Return-Path: <linux-kernel+bounces-347702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 873C398DBC0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17EF01F22C89
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51301D0E2E;
	Wed,  2 Oct 2024 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wkV9hxXt"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4F41D1312
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879344; cv=fail; b=U64veB8Vi102KspslUvNZd4do9vCH2HRRb0Pwx3A9TDlK3Nyve6hFAX6N0Ya/JsqaFF4GFTzhEtuHuuthC6O+C5BB5EMz/pzqhVA5halwQk1IOit4d0zNTyounCV/oRdrPZTGzLAxvGxclt5ZLUwpSCovVa42B5W69hByKnpYLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879344; c=relaxed/simple;
	bh=nfI9StO9fMy8pTiTZ6TJlq5ddkfIkoBwRhwtaqIUCiQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZKnI29i2kpexQicdej5jyl1inrnD4YF5jgDwckdIlDknj9xrwLxtkozGbV0X01UgFNZ40yQeKaMMG+md4JV/ybVqZky4noqUSu5schihhuWIVXWDRPyyF4N/puYOVpPnCmx+Y3f4eqPyR8TBcXeYtMZrDe0+0zn904hnG2IjmuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wkV9hxXt; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCnF4Uzjc7zChTVNYNtfjHy/2op9p+4iZhen2VyyOdvZLibGMbSR9rfhkpRLsVC6UlnKKZNI1xbqH94CYbwzAhhx3PMyq1CD/mj0CPFa43WNQRBhyvd/ThHHU1I3zv4Ce+67o2O3n8xjxuYYHMnnVOucym63ag/0s0qWYXnIE9B9MbPu6EQ3u47oNTN90xJHf2Lz9qTwBmvVlJ3woBrzw2AQhnaErzi6y2wZ/b72h7CVMYVmkC3zGZZmgwViCopUp6afTeKj6uWbh4cpSHhB4+h4sShzvpYC3klM2dPFKv8ZVcZS/bddBEyTUxQzwu1UCDqpW+YDi/XPer9g2YOOgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfI9StO9fMy8pTiTZ6TJlq5ddkfIkoBwRhwtaqIUCiQ=;
 b=O5CT6RBrPhc8Ud3fGAtp/rZTJ+NG7SGfu7iLuhVNZRQM7c+y2hVF8FcXc/ZbYb2RCuB5PIjnD+FbdRWuXr8fcZ8BLBV09Jbb8KvLOadPOS3fjl9wmKHuMFc0hscSOa4Q9t6HGxlLw/u9OWynYg45c2d4dHNbGPob4Tdhd55luOOhlM3hn/67LSffPkkQVt0OPtBxf+HehV3y8i4vvwjRXVY0+Q3zkghargvCPUBdfaN9Cyx29SE0+SfX13O3FwjYA0kAOa5gmlZ1OgIG3wX5N0vgmEElTDL6EJbFQDvskpyRL6TcR6BFY7Nf5FRqwthmKxaiZ7OyXSgnk6t/GRRQPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfI9StO9fMy8pTiTZ6TJlq5ddkfIkoBwRhwtaqIUCiQ=;
 b=wkV9hxXtpEzlIK8POEKz5MHYJ1vjiVJb8pC6aR8rQDfvT9mVPoFm9IkyLQq5DC52Tjdn06S1xpGt7YMBBw5HtR3AO3Ujy9Kyim7NrfAlh/aCh9O0VxRG+sIxHeB7HhsmtRitM6PFlriBt2BUG5aZ1GCJfo8ig691CG+r13WVFrs=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by LV3PR12MB9213.namprd12.prod.outlook.com (2603:10b6:408:1a6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Wed, 2 Oct
 2024 14:28:58 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8005.024; Wed, 2 Oct 2024
 14:28:58 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: "Manwaring, Derek" <derekmn@amazon.com>
CC: "bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [RFC PATCH 21/34] x86/bugs: Add attack vector controls for mds
Thread-Topic: [RFC PATCH 21/34] x86/bugs: Add attack vector controls for mds
Thread-Index: AQHbE5vjP+P7SIr340akC9fyjBzcW7JxIhhwgAFbm4CAAPwREA==
Date: Wed, 2 Oct 2024 14:28:58 +0000
Message-ID:
 <LV3PR12MB9265C353BEB73FA98A75681794702@LV3PR12MB9265.namprd12.prod.outlook.com>
References:
 <LV3PR12MB9265292F9654D9FF76D6B63494772@LV3PR12MB9265.namprd12.prod.outlook.com>
 <1c27be68-8365-4ddb-9368-e8e740feaf13@amazon.com>
In-Reply-To: <1c27be68-8365-4ddb-9368-e8e740feaf13@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=759bd50f-4285-4e5d-8e69-51c0143b99eb;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-02T13:39:23Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|LV3PR12MB9213:EE_
x-ms-office365-filtering-correlation-id: 52e5662e-1311-4f87-c383-08dce2ee8d91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RjdqaFBMelJLRkkvWURmTWpyMlh0M2UzMGZ5TlBIdmlNVG1lOWJEQjNtbEZU?=
 =?utf-8?B?VjM4UDJRczR1amJibkIvZ25FRDQwSmVKM1hrRWdmNzJjU3lmaFVPdTBtbmJr?=
 =?utf-8?B?T2Z4dEtwaEZQMGl4VVlNNlBnb3IxYmwwZ1k0OXBmM1pRUDk4VmQ5azliOUYw?=
 =?utf-8?B?MlNvLzFRR2o4YndIZkpvcFU0eE5yMVhHMVRmS3JkcUhuNHo0RDlWYWJFZlBq?=
 =?utf-8?B?b2k2eEQ1LzFMT1FjVDRjOEpyMjZLazRLcjZHSjZDUkdFek5jcUZxbTVmcUFk?=
 =?utf-8?B?Y2d1N1BENmtUWDNBU1dMM0MvN3RRanIvWnRrOTRxRitPdUZQVWw2bzVtNDFl?=
 =?utf-8?B?OWlqOG9zdGQybktRWENobFN2aEtyRjZWaTFPa3JDdXM4SHlRNUxDQ0p2SjZK?=
 =?utf-8?B?MS9PS1FGeXdFeVFMLzBSeUFyajk1Mk93bzJ4TE1EQkxXUWljWmw1VmR0Szhi?=
 =?utf-8?B?aUVmYmtKL3luUW5KdHBWajlVYlFGb0g3bmp6OGYyamVOZFMrbVVMbGlqWkFU?=
 =?utf-8?B?dlhkRXNBNHNjWXRiNWoxeStzSmtTSVUwM0dqZ3psbFpyTXM0amt0d052NXlz?=
 =?utf-8?B?eisvd0pJeS9sWnVFVFNwL3BZYlNldmc5TU1GQ0lLNVRsNU0wUGFvSGNsbkpO?=
 =?utf-8?B?L1NaUmZhWStZOC9ubmFWMFYySUdSc1kxS0IzQTJvYzROQTZOQ0hhNVdNWnlM?=
 =?utf-8?B?SXBhV2c4Vm1YOW9NQmdQUWNsTnlKMkxvdWljRXpidzE2djE1SW5QQXI2N0E0?=
 =?utf-8?B?RCtPaW12VjhlNDVQSmIrTzJXWTBnL2Z4ZVJXVWw0SlNXZk5DS3g3NjJWTWtD?=
 =?utf-8?B?Q3E0VzVVak9PVnJBSTNIYWZub1EzZ1l6dWhhOHFpTUFMSmUzbHZvcmtETWNB?=
 =?utf-8?B?ZTlNM0ZNMGtXMUF5b3JTdGNSa2NXWmx4Vmc1Y1psS2grVmVHOFpUNG5UaWZy?=
 =?utf-8?B?Z2xXMHp4U2JISEltb3NxOUdmcmtidmwzU2M5MDdvZjg0SVFnTkpweCtzdkNE?=
 =?utf-8?B?T2cxM3ZPUU5yRWNVYjJ0QXhiOHZnTXlzdEpUUllUZTFwUklUcnBjVndqMmVx?=
 =?utf-8?B?YndWOWI5NFB0WHBTd216R003TDZzeURnZytLYjlPQ1BiNnRGTlo5MmROVzdt?=
 =?utf-8?B?RHl1dHJkdzFpMWFyODZIdTRuaDc0WUhHNXl0NUh4VzV4Y09IcE1PZU9JLyt5?=
 =?utf-8?B?SVVXQUtRRTBVYnFjc3k4OGRWL2loZ0lUdGZ1UHM2dFFYU0RwVTNTcm5FVmdB?=
 =?utf-8?B?c2VGOWxZc0l4YlJlNnp6Z21lQ0xaYjZ0KytGR2dqWG1HcGxSVkRoVGdoaDRm?=
 =?utf-8?B?c3ZURnJqcE9rMlgxTDFhZFNwbDk5cHQwVk9HMW9TNmlKY2VtTWZxdWpJSW9N?=
 =?utf-8?B?akdOSTVSZVgrdi92cjVGWG1RTW5oa1F4ZEpJMXlYZ2pkYVhEd2pRa2tRc09l?=
 =?utf-8?B?ZWRsamFjVjRHRmgrZE9wb0dVa1p4dVFvSWdkaVp0VnpwMXRLRDZ6UEZiVFVM?=
 =?utf-8?B?S0JkaTV1dXd3eWIzY2pKSEJieFhlTklFZTJIdGp3SVpMUnVJalZPQWJvQ1gz?=
 =?utf-8?B?Y0VmaFpqbDBySHZIQStUME45VnFubnF5eHZvM2l2N2p5b0lzbzlZQWIyN1VR?=
 =?utf-8?B?OGpEeW9lNTBSSmg5b01PaktKZEc0Rnk2cU9vMEQ5Vk5KTU9FTFZOZ2NZbjRw?=
 =?utf-8?B?SFZObFp2UWw4VmI2a2FnUzBEYkV1eVZNZkhNL3BMcXlwNmdMa2lwVTBLaTU5?=
 =?utf-8?B?V1pGYmJGRG9jRGsxbk1tWnJrRlhjTGszMExGd1FSMk0zd3hqUjdNbmNmNVpC?=
 =?utf-8?B?a3IrZHB4WjBIUXkrNTVadz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c2E1TXpjcWtRT2JiT0RXN2tSVHNMNkZVT25wdm16ZzRMZFc5ODlyZ3JwdjFL?=
 =?utf-8?B?VkE2RlA0ZkR2OU92WlZKWDg1U1o4K2FXZzJ1cmVHcldRK0w1NFZhVGZCMysy?=
 =?utf-8?B?MVlRNW1WZEhFWHdlWHg0eXBMTGlZWkhLeXRNcEFsanZQRldtaTdtSXJVUCtO?=
 =?utf-8?B?amhWbnNyeW0ySlJIV1dQbHkrQVNlelM5WFBxdG9pK1g2Z1JXaVJPcDl6THhr?=
 =?utf-8?B?SW9NZCtJSzlwL0ZoRjhwYWo0SkwxcHIxL0VSUDFwQWlrZ0tVRnVZYUpNQ2NJ?=
 =?utf-8?B?ZEhtaitSejU0blA5Ry9zQVRDWUtDOHlOY01YSjJLWWJUMmVrbXcxd3hpZW5T?=
 =?utf-8?B?WS9HZ1MvcVlJQkEyVFNqVU5sWER5Rms1dHFTeUQ3SEFwTzUvbXNEb0FoQlk1?=
 =?utf-8?B?eWc5bUN1dDlNWUd3NC9xdkJRL01GT2dIZm9DdG92dXNTdXc2eHAveWZJY0ZF?=
 =?utf-8?B?cnl3TGY2RTRhRDl6V2ovbXdUUXJVL216cmV2RXpockdEOVJGNWVIdy9nWldX?=
 =?utf-8?B?eFJzM2NMS0ROWGZCREFSRXUzQnV5NEE4bkRJS0xOQmo4UWxZQW8rOUl5eGll?=
 =?utf-8?B?SnlFZ0NTSkoyTlVqVDNZRkl6bUhyQjZqUk9helFxVU5zK3hrdE5FUk9YRHpS?=
 =?utf-8?B?QTJqUlVtVEhtWjJhOVFMbnU0NE14SUsvZVZscHJ4N2ZOa3lzTU1Ca0xxREdu?=
 =?utf-8?B?WjNxcGRlT2FPNURqVzFnRExheUhWZ0MrcTl1WmVKRkFqSEk0UUZmdkdhZlVj?=
 =?utf-8?B?cWhpWVEyLzN3N28zRWVyQyt3NnJPTDlvOWhMcmxoSjB1czdMY0E1LytWWlNq?=
 =?utf-8?B?YzhpQWFyYXZlaW9MTkRqT0QxMWhjNFc0K1AreXhESmF5YWx4RFlpcHVsR1FR?=
 =?utf-8?B?T0tJYlNhQmkwK2JxSXBMZHh6ZkdOZDRGaXViZzBGMVBtZStMZVpzMHNxUytV?=
 =?utf-8?B?aUhTb1BEVnVpK2pvMWdJeEZVZVRIME05V0ZBMks5NEhNRHBpR1dRRlkvUU8x?=
 =?utf-8?B?cGphZFBQRllXQ2h5RVhMdktSMW1NcUpFSUlhc3N5ejNqTXkzYSt1SEg2ekRu?=
 =?utf-8?B?YW5yU0Fwc2NIZTBpUUNkNEFmYUF4b3A2OVVjMFpkRTA1bTlSOU54SFdibkov?=
 =?utf-8?B?Ukg5REpBNmxHd0s5T0NOU3ZVaUYvMVpqOHN2T3l3RVZqT1JXeTJ1SElzU0N5?=
 =?utf-8?B?cTYyUVpuWC8xNlRFejd0eXlQSEY5N1hzMmVEVTN2Z1NBUi9VY3IzR2pqUGl1?=
 =?utf-8?B?M3RnUEU0K05Ua2hCbkkxSG9HdE4zRDhUaHhabUpCY2xNaWFkMzRscHBiQm90?=
 =?utf-8?B?eG55ZUxEY3F3aXQ4UHBUTTNGc3dYZXdjWnJzYkhmWWdJZHRrV2JUR2ViWm1l?=
 =?utf-8?B?aEpLa2t5NHFseityS0pEQnFZUDRBdlVMNlErMlowbjNORDBVVlpkZGk0YmVO?=
 =?utf-8?B?R3pyV0wyc2daaEhEVDJkYWtOMmdXcUptb0JLUmVHeFV6YjZmM3I0MzRoVUZP?=
 =?utf-8?B?MUl0SUxSRi8rN2xHeXdBUUdjT1ptUXlYS1RZNHQvWkM4N2pvSXlsZzNVVTFi?=
 =?utf-8?B?Vk5qY2xCeXFmc01BRGF1REYrOHpjVkFLc3hZRnJEQThaNDRJMDNOcWNHc1pm?=
 =?utf-8?B?QWo3R21wckd2UDdlUERGUENtb1NvOE45cW5sdkFHYzJyWUM2VHJNR1NFemEw?=
 =?utf-8?B?UDRQSU1yVDN2TDBsR2FjZEhVOUFZbmtieW5TcnJZODJVc1hwN0FjSUF1YTZZ?=
 =?utf-8?B?VFgyNzloSGVvMHVsTC9WYmNzazVJQmpoMmMxZjdzZ0x2RXlDOVg1WU44bGo2?=
 =?utf-8?B?YThPRGNwWjhiUlZhYjZNeFl2dmhwZnVCdUtFNXcwbStUN3FsNTAxd2VJSzJj?=
 =?utf-8?B?N3NYaGJGWXdEaXdPeklmMXprQVgrSnhnZ0pxdGd1Nmh5L1lSK1V6RUlLRVJU?=
 =?utf-8?B?ZFVjZkNtYndyNzY5bUdOdStNeUpRUlJZVUEzeEcrU21uVHFFcm96UVkrQ0tN?=
 =?utf-8?B?MUYva3JWNEtLNVd1dnVWRDRlZHhMeW9wWVgwdTVGcTRCc1cvL0l3NDJybEJY?=
 =?utf-8?B?Q3ZUUEhzdGc0VHFyNGsrNlV3R0RxVGI2dTRWSDZIV3Q2MnBpRlBMM1lVSW9j?=
 =?utf-8?Q?2M3k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e5662e-1311-4f87-c383-08dce2ee8d91
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2024 14:28:58.4552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0cJDSRYPw8Z5YAEq2DDyWyrG6E848oJ9qcvXFDoXUbeHmvQxIVFq2khrv44jH81H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9213

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW53YXJpbmcsIERlcmVr
IDxkZXJla21uQGFtYXpvbi5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMSwgMjAyNCA1
OjM3IFBNDQo+IFRvOiBLYXBsYW4sIERhdmlkIDxEYXZpZC5LYXBsYW5AYW1kLmNvbT4NCj4gQ2M6
IGJwQGFsaWVuOC5kZTsgZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tOyBkZXJla21uQGFtYXpv
bi5jb207DQo+IGhwYUB6eXRvci5jb207IGpwb2ltYm9lQGtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7DQo+IG1pbmdvQHJlZGhhdC5jb207IHBhd2FuLmt1bWFyLmd1cHRh
QGxpbnV4LmludGVsLmNvbTsgcGV0ZXJ6QGluZnJhZGVhZC5vcmc7DQo+IHRnbHhAbGludXRyb25p
eC5kZTsgeDg2QGtlcm5lbC5vcmcNCj4gU3ViamVjdDogUkU6IFtSRkMgUEFUQ0ggMjEvMzRdIHg4
Ni9idWdzOiBBZGQgYXR0YWNrIHZlY3RvciBjb250cm9scyBmb3IgbWRzDQo+DQo+IENhdXRpb246
IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJv
cGVyIGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywg
b3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gMjAyNC0xMC0wMSAwMTo1NiswMDAwIERhdmlkIEth
cGxhbiB3cm90ZToNCj4gPiBPbiAyMDI0LTA5LTMwIDE3OjUwLTA3MDAgRGVyZWsgTWFud2FyaW5n
IHdyb3RlOg0KPiA+ID4gTWF5YmUgSSdtIG1pc3Npbmcgc29tZXRoaW5nIGhlcmUgLSBpZiB5b3Ug
Y2FyZSBhYm91dCB1c2VyL3VzZXIsIHdoeQ0KPiA+ID4gd291bGQgeW91IG5vdCBjYXJlIGFib3V0
IGNyb3NzLXRocmVhZD8gSXQgc2VlbXMgdG8gbWUgU01UIHNob3VsZCBiZQ0KPiA+ID4gdHVybmVk
IG9mZiBmb3IgYWxsIG9mIHRoZSB2ZWN0b3JzLg0KPiA+DQo+ID4gSSBicm9rZSBvdXQgY3Jvc3Mt
dGhyZWFkIHNlcGFyYXRlbHkgdG8gbWFpbnRhaW4gdGhlIGV4aXN0aW5nIGtlcm5lbA0KPiA+IGRl
ZmF1bHRzLCB3aGljaCBkb2VzIG5vdCBkaXNhYmxlIFNNVCBieSBkZWZhdWx0IGV2ZW4gaWYgZnVs
bA0KPiA+IG1pdGlnYXRpb24gcmVxdWlyZXMgaXQuDQo+DQo+IE9rIHRoYXQgbWFrZXMgYSBsb3Qg
b2Ygc2Vuc2UuIE15IGJpYXMgd291bGQgYmUgdG8gdXNlIHRoZSB2ZWN0b3IgcGFyYW1ldGVycyBh
cyBhbg0KPiBvcHBvcnR1bml0eSB0byBtYWtlIHRoZSBTTVQgc3RhbmNlIG1vcmUgb2J2aW91cy4g
U28ga2VybmVsJ3MgcG9zaXRpb24gYmVjb21lcw0KPiBtb3JlIG9mICJJIGRpc2FibGVkIFNNVCBi
ZWNhdXNlIHlvdSBhc2tlZCBmb3IgcHJvdGVjdGlvbiB3aXRoIG1pdGlnYXRlX3VzZXJfdXNlciIN
Cj4gKG9yIGFueSBvdGhlciB2ZWN0b3IpLiBJZiBubyB2ZWN0b3IgcGFyYW1ldGVycyBhcmUgc3Bl
Y2lmaWVkLCBTTVQgZGVmYXVsdCB3b3VsZCBiZQ0KPiBtYWludGFpbmVkLiBXaGF0IGFyZSB5b3Vy
IHRob3VnaHRzIG9uIGRpc2FibGluZyBTTVQgaWYgYSB2ZWN0b3IgcGFyYW1ldGVyIGlzDQo+IGV4
cGxpY2l0bHkgc3VwcGxpZWQ/DQoNCkhtbSwgSSdtIG5vdCBxdWl0ZSBzdXJlIGhvdyB0byBkbyB0
aGF0IGJlY2F1c2UgbWl0aWdhdGVfdXNlcl91c2VyIGRlZmF1bHRzIHRvICdvbicgKGFnYWluLCB0
byBtYWludGFpbiB0aGUgZXhpc3Rpbmcga2VybmVsIGRlZmF1bHRzKS4gIEl0IHNlZW1zIG9kZCB0
byBtZSB0aGF0IGV4cGxpY2l0bHkgc3BlY2lmeWluZyAnbWl0aWdhdGVfdXNlcl91c2VyPW9uJyB3
b3VsZCByZXN1bHQgaW4gZGlmZmVyZW50IGJlaGF2aW9yLiAgQW5kIEkgdGhpbmsgbWFueSB2dWxu
ZXJhYmlsaXRpZXMgdGhhdCByZXF1aXJlIFNNVCBkaXNhYmxlZCB3aWxsIGFscmVhZHkgcHJpbnQg
b3V0IGEgd2FybmluZyBpZiBtaXRpZ2F0aW9uIGlzIHJlcXVlc3RlZCBhbmQgU01UIGlzIGVuYWJs
ZWQuICBPcGVuIHRvIGlkZWFzIGhlcmUuLi4NCg0KPg0KPiA+IEluIHRoZW9yeSwgY3Jvc3MtdGhy
ZWFkIHByb3RlY3Rpb24gaXMgb25seSByZXF1aXJlZCBpZiB0aGVyZSBpcyBhIHJpc2sNCj4gPiB0
aGF0IHVudHJ1c3RlZCB3b3JrbG9hZHMgbWlnaHQgcnVuIGFzIHNpYmxpbmdzLiAgSWYgdGVjaG5p
cXVlcyBsaWtlDQo+ID4gY29yZSBzY2hlZHVsaW5nIGFyZSB1c2VkLCB0aGlzIG1pZ2h0IGJlIGFi
bGUgdG8gYmUgcHJldmVudGVkIEkgc3VwcG9zZS4NCj4NCj4gVHJ1ZSwgdGhvdWdoIEkgdGhpbmsg
aXQncyB3b3J0aCBtYWtpbmcgY2xlYXIgdGhhdCBkb2luZyBjb3JlIHNjaGVkdWxpbmcgY29ycmVj
dGx5IGlzDQo+IHRoZSB1c2VyJ3MgcmVzcG9uc2liaWxpdHksIGFuZCB0aGUgdmVjdG9yIHByb3Rl
Y3Rpb24gdGhleSBhc2tlZCBmb3IgbWF5IGJlIGluY29tcGxldGUNCj4gaWYgdGhlcmUgYXJlIG1p
c3Rha2VzIGluIGhvdyB0aGV5IG1hbmFnZSBwcm9jZXNzIGNvb2tpZXMuIEp1c3QgYW4gaWRlYSwg
YnV0IHdoYXQgaWYNCj4gdXNlcnMgaGFkIHRvIGFzayBmb3IgU01UIHRvIHJlbWFpbiBlbmFibGVk
IGlmIHRoZXkgaGFkIGFsc28gYXNrZWQgZm9yIHByb3RlY3Rpb24NCj4gZnJvbSBvbmUgb2YgdGhl
c2UgdmVjdG9ycz8NCj4NCj4gRGVyZWsNCg0KSSB0aGluayB0aGUgZmFjdCB0aGF0IHNvbWUgbWl0
aWdhdGlvbnMgd2lsbCBwcmludCB3YXJuaW5ncyBpZiBTTVQgaXMgZW5hYmxlZCBtaWdodCBiZSBz
dWZmaWNpZW50IGhlcmUuICBJIGNhbiBhbHNvIGFkZCBzb21ldGhpbmcgbW9yZSBhYm91dCBjb3Jl
IHNjaGVkdWxpbmcgaW4gdGhlIGRvY3VtZW50YXRpb24gZmlsZS4NCg0KLS1EYXZpZCBLYXBsYW4N
Cg==

