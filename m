Return-Path: <linux-kernel+bounces-304214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18672961BE3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 04:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212D9282603
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 02:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AF145957;
	Wed, 28 Aug 2024 02:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="cL2jEEpj"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2104.outbound.protection.outlook.com [40.107.255.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC804962B
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724811080; cv=fail; b=jH2hNYeDXeCxzxZzEV+rmQkpV48uvO78oNvwtr4qspMDwPnTVcsoD+JdKoPWuFszRGucL78Yq9NbmGNwB2sHJiow6qcIWAVtx7rxd8T715oeDQ6HR6mSZMR3M86TibKjhRP1OoAW+2gFO94+9NfpXuf5Qoy4jAdrEHD6C/N3aaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724811080; c=relaxed/simple;
	bh=gmVkUuhN3am7wI+NdbP8CjCx9ohSx+bWmYNxNOwhoSE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ekU/uvcCl85XaffriMEYACMQoyCUmzs0ieJd/fu02FJUACM5S12GyFwoAanpI3Xzt14f0j+xscDqvokjxbwzCY6TaBiveEeXW6gWUTxy3QLkNz4CEvbTleldVcNVOBzhqRWC/fOf/kLGDNYUPxG8NpRkJ/0JKLA9fOtaEJ6bqKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=cL2jEEpj; arc=fail smtp.client-ip=40.107.255.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pM0+UcVPsSLzHipaHjD8OveswFuAgM0RheSPT13ZLDnJJr+oIjVLGrt+jyvVIbGMkKok8it5fjxAwb6rMgCyxOO7KDVHvQ/n7Ya1jd4bHOtufRw2OPvG79s8uKxb4KjOYpnqpRYO9Ie5YaEs8XE7htrZ/TLIoRhFoK5Sv6Ht48Gh/xPcr0aPpNHDgveyuMpSsTt5tWlA41q0SGvVf/NuWdTGQeVBl6rWU/Uy64q6YMXW12bhv+kympY4vCMeDuNtjTgsWSEmlbJe/MZp0sCwFV75wPiot/hTOgkY4EloyhEcDdDdU0HfvDh+u+FI3XoLipma3yGbyzDC/Sh5mbIyYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmVkUuhN3am7wI+NdbP8CjCx9ohSx+bWmYNxNOwhoSE=;
 b=D42EsQQ6YpUtGEQp/bk6tUHIRN4KamjFJPT82POQT17c6hBIfvHP3JjYBvq6z1ixEjoh846HP7g8f/aT6Xq2hxQn1fNwxDV/fQcyM4z9ymxD7D9gP1yEgvufwkSEahySIj6IbTtbbPL6nEPsMqtcCftky/icFyU9ZcGS6/3dpN6OvQHPgvfXD67LcmCGtyZGJDACT4iucoURStM6b2BE0rW/GClyU1PcztXb7cxcMcxy1ue/buqVmk/bxyfGLP2UTcF3CatuIWcXq6wovk+ipDMRoSP5euABWuCUSd6fOnTk423mfDqIubU3YuqMCLPefArWAWE9hhvtkt+6AJLQeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmVkUuhN3am7wI+NdbP8CjCx9ohSx+bWmYNxNOwhoSE=;
 b=cL2jEEpjMWeLXBSE+xQQBY5Sc+hL9fyVuCDBA0+4ihqYvO1MMgfE5PL+3MHk6c0QQoVDvDh14hNmX4hh3exVqoQ5bD908Hf06AGeJUxpJdz5HqDsbvj2nwqBnDrZZKMCfVTCSIPOWnUECTEjLASfosFcTW6V1LYQJt5HXMogkM1RJCheWvlWLAMo34ky28R/Gso82imbZC3aYmmRfsjl5RowmmKuc7RUn1aJNtqiYvqkXdWikRsFyi7doWCBPDgoIDHwrRhdhUY2YhQZWQk+xJZvS9U9xdezIMJWFKEiRoGrnVH9rmRjJPqZ3ts8dL9CSdyAdnqTfNcKL5Dimj48IQ==
Received: from TY0PR06MB4984.apcprd06.prod.outlook.com (2603:1096:400:1ac::13)
 by TYZPR06MB6788.apcprd06.prod.outlook.com (2603:1096:400:44f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Wed, 28 Aug
 2024 02:11:11 +0000
Received: from TY0PR06MB4984.apcprd06.prod.outlook.com
 ([fe80::d3ad:fd6a:a537:55a4]) by TY0PR06MB4984.apcprd06.prod.outlook.com
 ([fe80::d3ad:fd6a:a537:55a4%5]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 02:11:10 +0000
From: Angus Chen <angus.chen@jaguarmicro.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "rafael@kernel.org" <rafael@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers: core: Add more print info for bus remove and
 driver remove
Thread-Topic: [PATCH] drivers: core: Add more print info for bus remove and
 driver remove
Thread-Index: AQHa+IAB0trZjZ94BEaR5yecC1hRmLI7Fk6AgADQ7eA=
Date: Wed, 28 Aug 2024 02:11:10 +0000
Message-ID:
 <TY0PR06MB49846789A7ED4370E825BB0F85952@TY0PR06MB4984.apcprd06.prod.outlook.com>
References: <20240827125244.1747-1-angus.chen@jaguarmicro.com>
 <2024082705-decoy-disk-6461@gregkh>
In-Reply-To: <2024082705-decoy-disk-6461@gregkh>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR06MB4984:EE_|TYZPR06MB6788:EE_
x-ms-office365-filtering-correlation-id: 72c89128-2e2f-42ec-e848-08dcc706af6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SUE0QjF2blc1bzRnVzAvYXpuc3VkeERzcEptL0JpZXRWOEo3eld6U0tZTzQ1?=
 =?utf-8?B?SzFQeWMyVXNHRFVCSXcvc3RkYWxQOFRxckphL3BqbmVkUHpCcHNSeW5nRmV4?=
 =?utf-8?B?dU94R3d3ZW9BWnUzc3gySHpKRU5Fa21qb3NITE5Vdk1FVXhqTHpQMFE5VUtY?=
 =?utf-8?B?eFR3WTEvak0vMGtkSTRhNG55NkR6MVQrZlBWN29vdTBXSUMzOWx5Vk1tKzlE?=
 =?utf-8?B?V0ttNDZpNGN5bUp5WGppNmRNc21LS3lNYjRFTnBDdWIrM2RpY3A1WlhJa2lZ?=
 =?utf-8?B?NU5Pc3hLeXNlVlNPblJmWEJXSVk0Wk40SFcweWJKelFLWGExb3BVYmhPV0tP?=
 =?utf-8?B?ZVE3cGlKZHlmSElXZmFqWGRyeE8xL0pLYjkzOTd2YnhHYk1keS9maXBIaU1o?=
 =?utf-8?B?UjE1ci9ObHhKSGxOQllUZm1nYktqT3EvQVZwazBuRWxlVjZhRFdmNG9OcVFH?=
 =?utf-8?B?T2pkWDh4R29sZlRwTC9sQXF5ZEFGS0R1clFaUzc1MzVKTVB5V1h1U0xBMjNJ?=
 =?utf-8?B?UHNGWHJsc0QzRlVKcm9VNEdqd0FvZmlaZUZhNnVrcTVxWEE5SEN6Qzl1QUk3?=
 =?utf-8?B?QTEyTmpNQllSL2k0R08wK3hDVGxSa0swN0NkSXBDVUpEUkY4OU5aOGlaSEtY?=
 =?utf-8?B?M1VHdlYrQzNMRmo0OVJ2ZDF2RXBDTGtiTG5UYnRtRG0zM1pqUU1uckxoV2pw?=
 =?utf-8?B?ZkgvY2c0OFVTcDNuUTJFTUJROGZJbWVsUUVRUFdnbjYrdUdsaWppcnFlTjNZ?=
 =?utf-8?B?SFhCRG1XbDZYeWhiaFFCRERRWHViQnNDeFBOekgxTmZlR3ExL2duZXZ6TVE4?=
 =?utf-8?B?UE5sZEZLK0thc3Y0elhZRlA2MlVuTy94Yjh0Y3JpdlVGYkQxbmZoeENqTWhr?=
 =?utf-8?B?aEttLzVzU2pjOTdWeHU4bU1DVjBpdVBmOGlpZmExS0VlWG9mVzNlQzJxRjdQ?=
 =?utf-8?B?dGY1aTg4NnYwVVBpRllEZ0ZpZTVMLzFxdkF2U1JSQ3h6M3VZa09mdHozRitN?=
 =?utf-8?B?NGJUNWVvVEx0Vi9WeEJLT2R3SG1CUE83UFBSVXo4M0RzODAwMFlJbC8yemEz?=
 =?utf-8?B?VzdjRnJYNE1KanRSdGpsVzJEMys3VUFiWHM2UkxEMkVYWnJWRWtUQ2tockp2?=
 =?utf-8?B?R3lJY2hOZFNIK0p3aUp6OHFtTU5VdHV1NDcwOXRIandLZWM4d3JJN2FLMEhw?=
 =?utf-8?B?NUpGSWY5dlF4UW50M3o5SzgrR2RJRStQVGVFZDZ4dXhDcW9uZWw1Y2M5dWxR?=
 =?utf-8?B?RkVDU2JtM3lVa1hlOWRvc0wxRy9lR01yNEFHWmJIdnEzLzcyclF2czNWNDZO?=
 =?utf-8?B?Wjh0RUE4VFlzRHRBc01OdXR5Zkl0dFZiUU1WWnRHeEt0TWx5Mk1LQjBOZnpU?=
 =?utf-8?B?WkVlL1dLVHRYKzRtY3VGWk5DYkxrUTZuRDQ3cEtyYU9TSUF1MXNHVHpZYmY3?=
 =?utf-8?B?NE1uNHdYTEI4UTRuMXR6a2hJSUpBZzNyYlZueDhtcHRrcWNNMngveGQ2dTNn?=
 =?utf-8?B?RDk1K3VQYU9SVFBzbXNkNklLQzZCTkdndXpyWERJUm9Uak05R2Y2OFV5R2tY?=
 =?utf-8?B?TVIrUlBDQTYrNHNLSU5jaXIxa1ZEL1N5bGphWEFCeUlmOVNQejJSU3RPZTVP?=
 =?utf-8?B?SFg2MWwydWNja2Fpd0gzb0ovSjBGTU5Rb2QxLzMrR29aeG96M0xadkllUzdB?=
 =?utf-8?B?bHd2RldZY3J4S1hYSlVLbGpCQWEzeFdwYm10MjdKQVhYbytYRjJxbUpCTVdG?=
 =?utf-8?B?a3NTRkIyRnBxbytQOVpadHc2K05TNEdvYm5id3d2bWFNWVlMbisvWHhuQnN0?=
 =?utf-8?B?bmRvVlYzZ0tFeGxQS0hldUxZS3krcytEMG81Vi9KQThKNEJjdjdWQmY4dEwy?=
 =?utf-8?B?ZmF0NEZkb3I4K3FiS3VVSkZPOTZhT1lMcEVXVmtDZnZ0b3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB4984.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TDd1T2ZFd04rRE9XWDJySkVmRG45UjloejFTSzdnWTlESFYvVkdYYkVybnFF?=
 =?utf-8?B?enZKKzdjMllPVndtckNZMnJqUklObDJQVVF2b2V3YUpnTnRrSk1YOC9VazJJ?=
 =?utf-8?B?Ui9FUDdBTitVb3NMQ1BaT0sramZCejkxcUV3UkJTKzhqTE9ZOW9NKzl4SjZa?=
 =?utf-8?B?WHRITFVtaTMzVzhjcWpBMEdjWEZnaGJmZzZDbi95WVcvMDZqNVR3UUNhdzVi?=
 =?utf-8?B?TE90d1lqUUU1emp0QjhLOTRubzBOYnFvbDJ2aFBiRTRYTmF6YVhlckVoMERt?=
 =?utf-8?B?bnhPKzVnbmtBSVlFbUFDTUtmTkhUdVE3V09MUUtYNmZrSXZMMXcwdHlxZDhT?=
 =?utf-8?B?ODNZLzhKdGh6dHIrVWk1SWVYaWJvZDQ5MDJsYVVEd1VDN1R6am1yaWFlOHZz?=
 =?utf-8?B?VEVVOXRYc3ZRQVZydTlVSnRCbkYva2lZNW1EL0pOMlRUa1F6TXFESUVOTGJH?=
 =?utf-8?B?bE10S2IvcXBReTBOS0NjRk5yaUxXY0h2d0hVSzFnUFRNZHFLZ3RFdk1VSmlu?=
 =?utf-8?B?bllYalZrcVhrMklyekwyYmJBR3dBV0U1cjhBNjA2NVh1cnByNk9pVWlZbU1Q?=
 =?utf-8?B?bStZdkF0TXpZSEtsTVBTdFlkQUljWFVDdkMyU1BmanpDb3Y4Uk5uUW43aHM5?=
 =?utf-8?B?blVpTFNkSldxNWtaS3VMQWx5Nzh3d0VwUmUvN3ZMNjBPS2s1M0lpU1lwU2Vi?=
 =?utf-8?B?TkJnbEw1ZXZBZzVsM3F3UC8vaDJHSzVRR2pWemY2NmtwMmV4RXBnRitPM3c0?=
 =?utf-8?B?c1N4dTJxTU5XQk9iRmxucWYyeCtVK28wYTk2OUhzTFU1WVE4dGFsNGUreXZR?=
 =?utf-8?B?UmtlM05nSnM5bzhEVTZ2SE8xUW5mZzFNRmpINXp0TWtVYnFIRE1lU2hlb3I4?=
 =?utf-8?B?dGl4OVJZWUgyTlhzVnJkOXI0ZzVqdVNaWFd2TUN4VytHazY3K0szcGtnbWZX?=
 =?utf-8?B?cXdsRWFHNGI5ZFVsL1pkenF2cHhJOE9pWkNNL1NLcVpxcExoT093Uml0NHdY?=
 =?utf-8?B?RlFseTlJVHROWklsakZOeEFIbm43T2lUcUpzS0dKL1JRblAzV25lRTZlRGJT?=
 =?utf-8?B?MUU1amdZZ0UrMmRZMnE2R08wSmFSSmtWZGNCUWxOb0wwdHdvekVZbTRmN1Fl?=
 =?utf-8?B?M3BlUXlWVWVqNEdnZENMYTFHaGZkdVlxVkJrZXFQcTFXZXVGZEJsY3VlVCtY?=
 =?utf-8?B?TTJrOWtMTnUzMGxQV3pncXNPSHlTRDBqdEprQWFWT0h0ODlSSmR5ZnRUZzkv?=
 =?utf-8?B?cDJMMFUvdzUwYmVNdTRxN3k3MDArWkNQUWNONTB3UnRHOHRQSzdtbC9BYnJl?=
 =?utf-8?B?NXN5VTF0TkpUTlVyclVBK0t6SkpWYW92UE5TT3AzaWhGc0dMaG82WEZsV2xP?=
 =?utf-8?B?T1k2TTZ1Tmg2MXM5SmtnQlhPaDcraGZHYmQ3bkFUSWxOTk5DeUF6Nit5SDdx?=
 =?utf-8?B?cUM0WVo1L0tvRzArZXQxVExuN2VMYmdTaEIvVTh1b3pHamZZRHZreGNOT2Z2?=
 =?utf-8?B?aDRVbkxKYklTd3ZnRGs3TGVDQ0g5a1UwS2g4RUJZeFBMVzYwQ2ZmMlhrb3J3?=
 =?utf-8?B?VnE1NTUyZVNmcno1YkRFT1BuVnNpZGgzMGk0aHVJVkVZZUZ6aEVXYzdYYWs0?=
 =?utf-8?B?b3BVcFR5QVIvT0FabFArM1AyYkcycDZacGdTKzZCZVFsQlhrQWxuVGY0TTlC?=
 =?utf-8?B?YUdvQTd6QkNDc1JuMWM3SW5PZ3p2ZndxeGcyaTlOb3U5SG9jenBDQjZrVU5S?=
 =?utf-8?B?L0Y5dDlFcDlqUnV4ZXlyNlVsVG1IaGhISWtzUzBLRmNzNGt6VW8ydlNwWDRi?=
 =?utf-8?B?TzVaR3lMSkt3Z29wNGlORUs5RjV1cDZRRHZhRjBtaVRmeTlZSkFRdE9pNHpK?=
 =?utf-8?B?NFRYWm9lSFRScTliWjFmVXhyNnpScWxsRW1jcVZVcnJVR2ZvT295NHJlTllU?=
 =?utf-8?B?MDZvNWVTOFBFNzZOQWl4c3RSbHcwZmVycFR3R1Nyb1FwRlpZWCs0ZUFQUjFY?=
 =?utf-8?B?Nk5IaS9SQzlWVCtncXYxdWljaEo3R1pSYk4yNDFGSXNIdi9mSU0xaFV2OGRB?=
 =?utf-8?B?enhJVU5HaGpJM2I3TnhKRTZ4L25XTzBDSWVMb281dWZBQWJNZW9wdmxvY2Zq?=
 =?utf-8?Q?jarrPMgOz9JnNx+n3cSrgKALk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB4984.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c89128-2e2f-42ec-e848-08dcc706af6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 02:11:10.6736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ThlKOKyz12xvoLXFD6LkJiuRyUR4qex5dvhL+td25wykjmoAuOC9tzG7tNS5DAQOXjhajrHgWjElAG/KhKM6n34ZuF3lxP0BsAlfMovuIrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6788

SGnvvIxncmVna2guDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3Jl
ZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3Vz
dCAyNywgMjAyNCA5OjE5IFBNDQo+IFRvOiBBbmd1cyBDaGVuIDxhbmd1cy5jaGVuQGphZ3Vhcm1p
Y3JvLmNvbT4NCj4gQ2M6IHJhZmFlbEBrZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRyaXZlcnM6IGNvcmU6IEFkZCBtb3JlIHBy
aW50IGluZm8gZm9yIGJ1cyByZW1vdmUgYW5kIGRyaXZlcg0KPiByZW1vdmUNCj4gDQo+IE9uIFR1
ZSwgQXVnIDI3LCAyMDI0IGF0IDA4OjUyOjQ0UE0gKzA4MDAsIEFuZ3VzIENoZW4gd3JvdGU6DQo+
ID4gV2hlbiBlbmFibGUgaW5pdGNhbGxfZGVidWcsc29tZSBkZXZpY2VzIGNhbGwgYnVzIHJlbW92
ZSwNCj4gPiBTb21lIGRldmljZXMgY2FsbCBkcml2ZXIgcmVtb3ZlLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+DQo+ID4gLS0t
DQo+ID4gIGRyaXZlcnMvYmFzZS9jb3JlLmMgfCA0ICsrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2Jhc2UvY29yZS5jIGIvZHJpdmVycy9iYXNlL2NvcmUuYw0KPiA+IGluZGV4IDhjMDcz
M2QzYWFkOC4uZmY5NjVjZDUxYmNmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYmFzZS9jb3Jl
LmMNCj4gPiArKysgYi9kcml2ZXJzL2Jhc2UvY29yZS5jDQo+ID4gQEAgLTQ4MzMsMTEgKzQ4MzMs
MTEgQEAgdm9pZCBkZXZpY2Vfc2h1dGRvd24odm9pZCkNCj4gPiAgCQl9DQo+ID4gIAkJaWYgKGRl
di0+YnVzICYmIGRldi0+YnVzLT5zaHV0ZG93bikgew0KPiA+ICAJCQlpZiAoaW5pdGNhbGxfZGVi
dWcpDQo+ID4gLQkJCQlkZXZfaW5mbyhkZXYsICJzaHV0ZG93blxuIik7DQo+ID4gKwkJCQlkZXZf
aW5mbyhkZXYsICJjYWxsIGJ1cyBzaHV0ZG93blxuIik7DQo+ID4gIAkJCWRldi0+YnVzLT5zaHV0
ZG93bihkZXYpOw0KPiA+ICAJCX0gZWxzZSBpZiAoZGV2LT5kcml2ZXIgJiYgZGV2LT5kcml2ZXIt
PnNodXRkb3duKSB7DQo+ID4gIAkJCWlmIChpbml0Y2FsbF9kZWJ1ZykNCj4gPiAtCQkJCWRldl9p
bmZvKGRldiwgInNodXRkb3duXG4iKTsNCj4gPiArCQkJCWRldl9pbmZvKGRldiwgImNhbGwgZHJp
dmVyIHNodXRkb3duXG4iKTsNCj4gDQo+IEkgZG8gbm90IHVuZGVyc3RhbmQsIHdoeSBpcyB0aGlz
IG5lZWRlZD8gIFdobyBuZWVkcyBpdCBhbmQgd2hhdCBpcyBnb2luZw0KPiB0byByZWx5IG9uIGl0
Pw0KVGhhbmsgeW91IGZvciB5b3VyIHJlcGx5Lg0KV2hpbGUgSSdtIHRyb3VibGVzaG9vdGluZyB0
aGUgc2h1dGRvd24gc2VxdWVuY2Ugb2YgbXkgb3duIGJ1cywgSSBnZXQgdGhlIHNhbWUgcHJpbnQg
b2YgdGhlDQpEaWZmZXJlbnQgZGV2aWNlcy4gQmVjYXVzZSBzb21lIGJ1cy0+c2h1dGRvd24gY2Fs
bCB0aGUgZHJ2LT5zaHV0ZG93biBmaXJzdCwgc28gSSB3YW50IHRvDQpNYWtlIGRpZmZlcmVudCBw
cmludCBpbmZvIHRvIGRpZmZlcmVudGlhdGUgaXQuDQo+IA0KPiBSZWFsbHksIHRoaXMgc2hvdWxk
IGJlIG1vdmVkIHRvIGRldl9kYmcoKSBpbnN0ZWFkLCByaWdodD8NCllvdSBhcmUgcmlnaHQsIGRl
dl9kYmcgbG9va3MgbW9yZSBiZXR0ZXIgLiBzaG91bGQgSSB0YWtlIHRoaXMgcGF0Y2ggdG9nZXRo
ZXIgb3IganVzdCBjaGFuZ2UgaXQNClRvIGRldl9kYmc/DQo+IA0KPiB0aGFua3MsDQo+IA0KPiBn
cmVnIGstaA0K

