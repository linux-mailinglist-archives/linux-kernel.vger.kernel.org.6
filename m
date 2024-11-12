Return-Path: <linux-kernel+bounces-405204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 280819C4E4D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 06:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DA86B21AC2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 05:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102EB207A3E;
	Tue, 12 Nov 2024 05:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="IgCRbKvh"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2043.outbound.protection.outlook.com [40.107.241.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211A25234;
	Tue, 12 Nov 2024 05:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731389735; cv=fail; b=ug19M060H9vEv+6HJOEY92fAagfwhxYlKO5wG5GG9VBkP/h/pZ/zMRGVVvcS9vhSMToIOQRRNSr15hmdtqaFp7tkniQNaz/39pTf7rL/IWwBx0dlAik8EewYdrbfsD3xCrhUzmVJBshHP85CQkpCrvePS3awNrpoZmDYdcqxLmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731389735; c=relaxed/simple;
	bh=Yl8XSdIZ+55B5uDueEJWP/OwPmAvK8Ho0PnQcbJ+MNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rRVvpl1Spzkt4docCaLL8HXjrDguqqm6GACKv5QVo+e8m/dFOnFbNdAAle5JYlOWvxmjApJ3GPSBfC+5mPOhaq39pqBCHoMFtGcwtByP7ssmh1Zn/bSefYXhTLdPXTERuxeqztlysj/P0NDf+uZv+vSmGS+diutwIAjk9EkFjaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=IgCRbKvh; arc=fail smtp.client-ip=40.107.241.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTGDh/Z4NF3yGg7NWobsINFl7GSQHluWusreDtkcJJHV9pvwPZ9/kpks67VVloPluKmALTnU28c0QHwJ+WaIYMk0teHFUeuAQbB6Zv1QOgOy+tNkogLjzoajRcUK1J/7UOfFHUzbpJWkjfF61Vo9rkXmM5erUa9epaPAobD+zapbZBopRm9r09EknnoU2ierB/GihwlxofT+Cx+d17yv279CN0JmfYTfKjl57EvMruxo+LeQ+k5or1PPvOENda96ZA308dqa4VB4O727e2mVsnLtlyk/0zeJgmXJ+BqJIYku2v0AuDTioDUTuqKCDqdFkjwdqg/05/SOm+WxRVG4Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbvxHvoZ1NFwbQnurLqzU9jJ63X65704hWawsgWcVDo=;
 b=CNmFPqAQpO+K2iCCHU3J3fKDepzzh/CLGE3q3lsa3Vry0GQswcdwciyF8X5DoxSYZqtDA9RH4ko7Z/xEYQuiSgEpbRXtkzaE2OFppki+VFI2cVnae7gz1Eu7cUn+IAfKMB9+D7+f4tmmvcc16rgwJ9fJhWRFEpBg82DClsjnbInX9yxHC0z6S3dkTYtUc25JczMVkUx7LrxjWoIzBQpjhNLW+Lsy5UuFCfuF7M6/LRqLm0sfXVkfSIfhkdt77/QrRd1eUJGmylJiOzESfzTWek0YYW6O83LNXC0cdPjOlOXA+MoBaqc2TTiUaIqxSx9VxFGWID3NIqZ2XXk/8friWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbvxHvoZ1NFwbQnurLqzU9jJ63X65704hWawsgWcVDo=;
 b=IgCRbKvhnZwgPwKeY1yXkcw69U3PltcKJ0EEwJyLkKSfF1Rvydz0HOMx5KmCZxbVqv9faGVJNbcr35TNUDrB+da2fuyqNGWgFQNI3/f7smehe0nP4hJeBsVPgOiBN7Ib06BvH9MHezIOhoKjjxagTTIenplwW5M6qXgt/NYv5POEHTj5t7NF6vlyeBK51YbQbAp0rJhkFgPJCQk46tXQLVpgzYHlw5P0gYpLFIpua7CffMmfO0sQfbP3LkWtS+so/Cu29/p/GdjQhBGEyuUXpHc/hg0vEqboxaqtM9bXD5ZJXUvFs2TAa07i3uPowDkhAzhWtZIeuRhH1YAyoFXVxw==
Received: from AS4P195CA0009.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5e2::17)
 by DU4PR10MB8997.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Tue, 12 Nov
 2024 05:35:26 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e2:cafe::21) by AS4P195CA0009.outlook.office365.com
 (2603:10a6:20b:5e2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Tue, 12 Nov 2024 05:35:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 05:35:26 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 12 Nov
 2024 06:35:26 +0100
Received: from [10.34.219.93] (10.139.217.196) by SI-EXCAS2000.de.bosch.com
 (10.139.217.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 12 Nov
 2024 06:35:25 +0100
Message-ID: <2c8f1d58-e90e-4ba1-92e3-44e24040ac92@de.bosch.com>
Date: Tue, 12 Nov 2024 06:35:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] rust: bindings: Auto-generate inline static
 functions
To: Andreas Hindborg <a.hindborg@kernel.org>
CC: Alistair Francis <alistair@alistair23.me>, <linux-kernel@vger.kernel.org>,
	<boqun.feng@gmail.com>, <me@kloenk.dev>, <benno.lossin@proton.me>,
	<tmgross@umich.edu>, <aliceryhl@google.com>, <gary@garyguo.net>,
	<ojeda@kernel.org>, <rust-for-linux@vger.kernel.org>,
	<alex.gaynor@gmail.com>, <alistair.francis@wdc.com>,
	<bjorn3_gh@protonmail.com>, <alistair23@gmail.com>
References: <20241111112615.179133-1-alistair@alistair23.me>
 <bR_L15e11CHC0AS4d41vkbo-whYRfTKoU_htcjK8F_inG0Y5HQslqOWHOLBeNTCYqsgSqOtHXeoOj4ifT5ndJA==@protonmail.internalid>
 <9369b621-47d1-4967-8a68-874bb602deeb@de.bosch.com>
 <87msi5swsj.fsf@kernel.org>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <87msi5swsj.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|DU4PR10MB8997:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d8363b-b7fe-4d3c-b86e-08dd02dbd003
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2ttNEJmcXBsNGFJclZtM0xuS0VXODR0cVpkYk9rT0txck5GR3ZaRGlIZUlh?=
 =?utf-8?B?bTRrYjhRMGFaRW1OK253SjhDaDhuNDdVUGVYSmtoaEkydkV4ZUNWYmVXQlVL?=
 =?utf-8?B?MG5KYVZPWC9ETWV6VDZGcTVHVmc2MCtpRy9ab0NxUnNaeUxsclI2K2dyRXVx?=
 =?utf-8?B?YXJlRkpTc1F2MGFrc0NBbmNwN0gwclNVNUV0SEpoWkJ3cGxIQmM3R09abkZm?=
 =?utf-8?B?QlhoNTEzSzB4blJQNFpubEs4YXRNa1RJaWo2UW5JZkgwVEJKYWtjVFcrbmNa?=
 =?utf-8?B?djBCVk1xc016OGdNcXVqMGc4U3pHL1ZEYTBFRGtGRzNmNEkra2ZZelY1Vk5a?=
 =?utf-8?B?dVk2NFFtQTBaYXNIQ0QxZ08vcnRFU1NwNmYrS2FoOE8wK0gyYnpjbjlLV2Rn?=
 =?utf-8?B?TTNyU0RUNWJqSTJ5Z0NyNk9YMG9HZEplY1NMUXNha09uT1VzT1hjbzY2ekUv?=
 =?utf-8?B?YmRTVkdWbkxPZ0VsK2tOMmtWdFljZUF5amhzTFN1aHRvMWNHV3pwSFBFTzhF?=
 =?utf-8?B?YnNrY1JMbzVGU3kwS0ovTEUxYmM5dEtvZXlaUU1GMCtSQmV4dFYxUGRMeHdj?=
 =?utf-8?B?bmxoRGJhckpJZmdzZEYySTZKZ1grMm9Wem8yeUlPQ1RRM1NLWlh0NmdpeWxk?=
 =?utf-8?B?dG13V1NRZWFZR2xSL1RpVEcwRzlramQ0WWpnaWVRQktGbEYxckQ2YmZvelNh?=
 =?utf-8?B?OTBzb1FOSXlGa0tIc1lDemE3MDZPNkdJZDFKRlp2SkpMa1dpUndvUEpmWEs3?=
 =?utf-8?B?TjJkMk5STElnc3BqNmk5YUZpYytJS3V0SjdsdVBUbG0vT09wNEdBTUxRN2hw?=
 =?utf-8?B?T0M5SFloRm9uZE5hV1ZnbEFNMVpKcDFTN0lRTmRaRWxIK0d2RkxmOENiUU1V?=
 =?utf-8?B?N3J5dCtOK2lqTHh4ZmJwWjdmRmpXdGFpRTl1MEVjZHM5TE5YVzhJMGc2MVdv?=
 =?utf-8?B?dFVvR0J4TGNyM0F6em1uTWFrSzIrMTZRV1dNRWFFS3V0a3pFRmhVaFRCRUN6?=
 =?utf-8?B?UzFDbk4zMUhZS2N5MStFb3ZvMU5ZeS9rN0ZpbktMWnlQOTNSMG1ZbU5MVFhW?=
 =?utf-8?B?NWJvbmlVUEQ0eWNaTXFYYS9oM05xaURLTm9GdGdpTlBsOEltZFpkNHdaTTQ0?=
 =?utf-8?B?NmJGWXM0aGk2c2JJRnNpQjZYaGFzS2FmS0xvbXFuU3BSd0NIb1ozV09hZm10?=
 =?utf-8?B?VHFjVnRoaWdVTXBhNXo4b0NUSXZPbHBqRk9IcUJFODVjWW9KTUppdDNIZTlV?=
 =?utf-8?B?RllQM3dZaWJrOS9yTGRvbGMzT1RDZ003L3RzQks4SmJJSkhQSDdDZEV2SEdM?=
 =?utf-8?B?SjczSGx2clVLL3pBa09FMlA3MzgxWW9NR1E2TUF5T2x4bEMvRVJNZTJBNmlW?=
 =?utf-8?B?bi80cDM5SFluK0l3L0VQcHpneGZoUlRCV1cvd2ppOUJmeWxIRDUzMnU0anMw?=
 =?utf-8?B?SldJNzh2VUVGUVNhMWNTSzduMnpVY1hBdG9nKzZxV3FsSlkzRkNhMzV3Z0Z6?=
 =?utf-8?B?N1E3WkJsOUI2WVB4RXNjaWY0bHcrdmF6UHRiR2FiU3NJOTFlcTVsV1d4Y0RV?=
 =?utf-8?B?aHNRMmlHTm1ucnh1WVpaNXF3bEpUV0tTTThkTDBRY3RVTitUYTlFVk9NRlQx?=
 =?utf-8?B?UEsvNGRWUm5IUWw2K09nY0N5bHJuV05qVExBanIvNmdlNGJPZndBQTBBYk5I?=
 =?utf-8?B?WW1mV2Fjc3hJQysrTkdHbkNrMEFaTE1sdUFib3BhTVIycFIrMUExYjNwUEZs?=
 =?utf-8?B?ZlNVcThhbzJVMjl4cHViVjdoRW9jd3BKMnhFZUY0Q29kR2FodDc1dzlTL2Nq?=
 =?utf-8?B?cTdSc2xUalJaYndZT09xcERMU0E1NDdrT0xTOTZtSkFPc2RPQkZZY2pidXR3?=
 =?utf-8?B?Zzh6a2todXZIQUx6MWZwYTd0bDI3eFM0WE41NXArSnZFckE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 05:35:26.6695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d8363b-b7fe-4d3c-b86e-08dd02dbd003
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8997

Hi Andreas,

On 11.11.2024 14:51, Andreas Hindborg wrote:
> "Dirk Behme" <dirk.behme@de.bosch.com> writes:
> 
>>
>> It builds for me now and the htmldocs were built as well.
>>
>> Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
> 
> Does it build for you if you have a clean tree?


Yes, it builds fine on top of recent rust-next [1] [2].


> I think there is a
> dependency issue in the makefile, as indicated in another email.


Please have a look to Alistair's explanation:

https://lore.kernel.org/rust-for-linux/CAKmqyKNjjELzVbWgBHaHr8N1XnOJHk-U6RfLyb-FbTJ7h9jPoA@mail.gmail.com/

Best regards

Dirk


[1]

795e3d43d83a5 rust: helpers: Remove uaccess helpers
0071ccb890a3f rust: helpers: Remove some task helpers
9881077429443 rust: helpers: Remove some spinlock helpers
495b561ce78b9 rust: helpers: Remove signal helper
48107d1e5cc61 rust: helpers: Remove some refcount helpers
621903d5c46eb rust: helpers: Remove rbtree helper
d1484aaea0fcd rust: helpers: Remove some page helpers
941df485c6631 rust: helpers: Remove kunit helper
f62ea696e0114 rust: helpers: Remove err helper
6f59d029873ac rust: helpers: Remove blk helper
c093c35fb693a rust: bindings: Support some inline static functions
74949fc30c7a0 x86/defconfig: Enable Rust
d072acda4862f (rust-next) rust: use custom FFI integer types
...

[2]

/ # uname -a
Linux (none) 6.12.0-rc2-00090-g795e3d43d83a #3 SMP PREEMPT_DYNAMIC Tue 
Nov 12 06:28:23 CET 2024 x86_64 GNU/Linux


