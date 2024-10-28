Return-Path: <linux-kernel+bounces-384219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBB99B2883
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5CED1F21829
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350551991C3;
	Mon, 28 Oct 2024 07:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="vBTJCu4I"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64468190055;
	Mon, 28 Oct 2024 07:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730099498; cv=fail; b=kAeC4BzFMRUrNQD2p1fPxH0e5IrL13boMDRWxnh91RkOEHGJRTMGt+sQrdvptvHmzXoyaIS7QmCvqXAR1ED9woKXdtlz1GTl2TG8LIXDkyeIbH3DDjE3cwPSDT5wY2srCGkNmvw8r3IKleQsBShh/jjaTgrGd1vsUoA5KtllkgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730099498; c=relaxed/simple;
	bh=/TL3jOU9OdOAwlRQ/VUhOlozHuywOJydFYnPGqKCwBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T3ol7mWDZCSh9V/eRUHaACuv/UlYZMLq6nwx6ZnW4AEp2S3oxHekmHWbF/2Md9DP7gYI35vOy0zVKsoiW0CdwF6nG1ZyRD44opsHMPeAc++whvDsZJr4ckHbS4eRMFucjLn4Xi1+5K311vYN13sXCm48c5x34WGm0rQXmmcx078=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=vBTJCu4I; arc=fail smtp.client-ip=40.107.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCAhdEnbnlOoqKHP4obb2tmivrb7r7RJuiKgifXv2kzpgP2um25SF+ilmGxjIyBAw4UKdlRdORNakQ1s/L+qc9n31s30+qIQsKHN5szI9vJE23gCZBShU67hAxZ+zFW9VX3WL76QMwaIrz9GdAIfYBqiUKZAwzuYHETJVTJ/LQky/APqwvjIuu7g7rt0gxGVeRRQYHBIq9z19mYo5OLJqe/oLl8+/bttiE8q8DgCnA1FhIokoq0WD5xNGltbFWRv7Cj6Im4/ySWr3yy2435ENKmgPxW6dQqa20VcabS/uH2dJN8K1YJVRaCfqeWJZTS+Z5LpNRI2ds4fhT2qX8cGMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Sxzptn975Fi4Bcz9M7DVdTyGmkJ00blFoigKJuuv5k=;
 b=dnHbJcpjD3O1hUOmaPoTVlJL+kqoIS9N3oaybg0J8wCS+W1yHAaPCtni5O7gQHxBA09Hcp66cgv0px0foPRLaLFtMfWdMYDFSNOUm4bpXA12CvI9SyYaj1ILPJBYvDus+H4ZhQUsNljyAEv+WR5AiAzjjlG3po2i3JtnOYSjQya5l5A4g3NeDeIaSSZtDYfmcYVplOdmiDdZ8fJklNKon2KmqAM8LVZjDHrtkglDI7tO6Xr0mHk0+RzrrKIidp/1ibUEwHar9sTRJ79cta5yeWr7CGNADji6fDlC6A1p/sZ8Xmbg7g0jc+1V9s3t5TwNgHTLWgHf82RLzEbkPuBowg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Sxzptn975Fi4Bcz9M7DVdTyGmkJ00blFoigKJuuv5k=;
 b=vBTJCu4ITw9wIC1z14QIZzO/wuuX2UB8pdqiEW9jkvvWbrW1db4XQ3CoNV7Ok9AIcG83hAIqUlC5VksqnbXCI44VX6dpTL68mwX9wqj0Vif9Ekn2nmLfm85fBU8+XKiI8gaV2RTkHiRhyJ1oLCtRbRIMZ/ZcYkrF6PJ+G2+6m0zvTnvzVZJraGq0xnaU3EiS3mh1VyatEOtrZeuWVnkDwA/rLqCverAUdAMOYcBGyCygZXOIIWGlx/vShjolSbA4z6vteEi3wYV63XPwDoxa6e0DbhP9db8gCvS6xCrG8pekLENXBym4qQG5wLrEd1KArhTAqYj/JvZVP7gcshHb6g==
Received: from DU7P251CA0004.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::28)
 by AM7PR10MB3954.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:176::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.13; Mon, 28 Oct
 2024 07:11:30 +0000
Received: from DU2PEPF00028D01.eurprd03.prod.outlook.com
 (2603:10a6:10:551:cafe::31) by DU7P251CA0004.outlook.office365.com
 (2603:10a6:10:551::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23 via Frontend
 Transport; Mon, 28 Oct 2024 07:11:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 DU2PEPF00028D01.mail.protection.outlook.com (10.167.242.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 28 Oct 2024 07:11:29 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 28 Oct
 2024 08:11:17 +0100
Received: from [10.34.219.93] (10.139.217.196) by SI-EXCAS2000.de.bosch.com
 (10.139.217.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 28 Oct
 2024 08:11:16 +0100
Message-ID: <48315bce-e55b-4462-b7d0-7f4db3223be2@de.bosch.com>
Date: Mon, 28 Oct 2024 08:11:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] Initial rust bindings for device property reads
To: "Rob Herring (Arm)" <robh@kernel.org>, Saravana Kannan
	<saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Dirk Behme
	<dirk.behme@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>
References: <20241025-rust-platform-dev-v1-0-0df8dcf7c20b@kernel.org>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20241025-rust-platform-dev-v1-0-0df8dcf7c20b@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D01:EE_|AM7PR10MB3954:EE_
X-MS-Office365-Filtering-Correlation-Id: 980b1b0a-5070-4ed1-ab01-08dcf71fbe7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDBicitPWWVQT2pjOWZyZmM1bldCMWxVbXFwOXZSSi9sbDhmVWdOaWRvVmoy?=
 =?utf-8?B?YVBKYlIrYWxXMHp6T3NDaGVMOTFkNnk4aVBaQlZadGczQ2xORzZsNjJlZDVV?=
 =?utf-8?B?bVJhZ3RvdzRGZ3Q4Qmh4SUUyS1JtWCtyNFJvUHQxVmFYQ0lmaVJSbGZUaHND?=
 =?utf-8?B?cDEzQi9MeFg0M0QzQnZhNE10RmNuQmxvdVZERkhLc0dPQnFpN2FSMzJGT3hl?=
 =?utf-8?B?aW9wNlJDY0krKyt1dzI2SXE1Ny9BRHl3WE8rRDRlckRDcHhpdnpYUzRqYURj?=
 =?utf-8?B?T0MrZk1IWnh3aDZZTHcxSVI1cFUrOGRER0dOVUVKdUIvZEJsSUxQZW9xUzIy?=
 =?utf-8?B?bFNEOXVDN21qdmVIb3JCZnp3RXpZeUJyNXY1dXZyMHA1T092UjJ0UFRZL0pG?=
 =?utf-8?B?R3JVbE5YdkNqeFRDVERIbmxJc09uUUtyZmlUQStKcE05TXlsemlyZnZtK1hO?=
 =?utf-8?B?VXF2dE5WSzV6Z21EaUEzYlplWm9VdWZLV2NSRXNoczk5M05nb0pTUDBhdk9C?=
 =?utf-8?B?Y1RTWTNidDFSc01QbndPTHRxZHdzNjF3N0FUMEJBcWJCSHdrWGJ1SWxKR24x?=
 =?utf-8?B?UFdTV2V2UDlOV1EzSjZsUGxoS0htbGxWMklGWVoyNVVkTUxWejJFUUxhZERk?=
 =?utf-8?B?ZjJzaXBJRjM0eHk5ZG5kQ1JNTWttblA2aWVjakNNNTUzUm1pUmlQQ1M2RGY0?=
 =?utf-8?B?ck5ucFJscXlOQ3VOdWFEaXRFOWJ0STBQUnBVNXRJaUhRK0hKR1N1NlZHelpr?=
 =?utf-8?B?OEZ1cm1jd0kvVG5Rem1Xa2hvOHR3UkpVN0JLb1NXT3NSTm5pczZkNml1bmtY?=
 =?utf-8?B?QjB4dVVyN21uN1JMOUw0TmNQZGtwVXEyNnl3OWZFY09FS1ZVQ1NpVU8xN3h4?=
 =?utf-8?B?UDk3U3Q4Q3JGbnF1ZGNnNEc0bXJEdk1VU0tyNmRtWEpJN1kwTEpwbTFLcFFZ?=
 =?utf-8?B?NW9lWnovSnBZakNDbDhKOHk0NXJlVlljVTl5djlOdjZCancrWDZQdmpFcm9I?=
 =?utf-8?B?U1ZqS3pVQ2JqMnA5bUVrd1RDS2R2Z3ZHQUdXV29KZjEvM2p6MHAremh2L1lo?=
 =?utf-8?B?SE9ZK3IwUUgwWHJ3NVVmZVBJWHNEck9rc2Y1SVhodmN3UzVNdSsxRm01MzdX?=
 =?utf-8?B?cUVyNk9TUTlBVk5SL3E2OTdVSXVab1BvbmZhQlU3ckFNc2NBUUI2U09QN0lG?=
 =?utf-8?B?TWJJK0NJazdhaVVYZFE3WHpJVkpsemtOREtSMkNhNVV6OXNRaHpSRi83SzhM?=
 =?utf-8?B?UUNJUmJrNTlzUkNLa2dxdFE0cm1MSG90RXZzdVBaVkZZN2lXeWtocFA4SUFn?=
 =?utf-8?B?eXNUL2JKNmdSUWhMYWo2UzhjRnZyVE5GS2JNL041MElCaUYyL0NNSkM2ZStr?=
 =?utf-8?B?OTVoZjJnUXZoWmtUUklEN1V5UW11RlNldE5QdFZVTWNwbEJLQzZXbytnSzhF?=
 =?utf-8?B?VktLeEpLS0dhL0xOWlgyZmFVdXNZTTg5cHUrdGFwa1NWb2xNdFRoWlBiSVlL?=
 =?utf-8?B?eWRmd3lSd3hGQWFhVGpDSjM2MTY3RWFPVEZLUHZZQ0xoT0V2Q040bUNCUDBk?=
 =?utf-8?B?czlydGV3WXhTWlRDUUpGWlRnVkV0UFhiR3g4aEx3WE1UaTIwUzhXclcvTTgv?=
 =?utf-8?B?M3NiTjBEczRsVGhtWnVYakdMNWcxQXMxY25yZTJzazBhNkxvU3RWekNHWnVk?=
 =?utf-8?B?YWdLYlFUWmR3a3RVb2UvWlVjMjN0Q0g4WXZBSjA5QVFxQ0k4dVp3OU9NVWJK?=
 =?utf-8?B?VkFqZWw3bUVuSHl3d2hrUjlUR0t2WmRNQ21XdXdrVnBoeTluS003REd6MjRG?=
 =?utf-8?B?TzNoQUxoZ1lQTXRDUk92c1ZTeDBGYVhUVHZ2MXFOUEVSTktNUnN4MXJlVGps?=
 =?utf-8?B?bkpEdGNwdkFNS0FTMmFCTHcwYnpUQlNoSWw2eForSG5XazVwOVlPN0JFRlFO?=
 =?utf-8?Q?udgGAVZvqgM=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 07:11:29.0849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 980b1b0a-5070-4ed1-ab01-08dcf71fbe7e
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3954

On 25.10.2024 23:05, Rob Herring (Arm) wrote:
> I got asked about upstreaming DT rust bindings, so I decided to take a
> stab at it.

Many thanks for this!

> This series adds rust bindings for the device property API
> which is a firmware agnostic interface for reading firmware properties.
> There are "DT rust bindings" patches floating around, but for many
> drivers they don't need to know any DT specifics nor deal with struct
> device_node (and its refcounts). And reading firmware properties are
> simple enough for my feeble rust abilities.
> 
> This series is based on top of Danilo's PCI and platform device
> series[1], though that's really only for the sample driver.


On x86 having CONFIG_OF_UNITTESTS enabled I get

rust_driver_platform testcase-data:platform-tests:test-device@2: Probed 
by OF compatible match: 'test,rust-device' with info: '42'.
rust_driver_platform testcase-data:platform-tests:test-device@2: matched 
compatible string idx = 0
rust_driver_platform testcase-data:platform-tests:test-device@2: bool 
prop is false
rust_driver_platform testcase-data:platform-tests:test-device@2: 
'test,u32-prop' is 0xdeadbeef
rust_driver_platform testcase-data:platform-tests:test-device@2: 
'test,i16-array' is [1, 2, -3, -4]
rust_driver_platform testcase-data:platform-tests:test-device@2: 
'test,i16-array' length is 4

with this. Looks good :)

I'm not sure if it makes sense for an RFC patch series but in case it helps:

Tested-by: Dirk Behme <dirk.behme@de.bosch.com>

Some comments will follow in the individual patches.

Best regards

Dirk


> Please tell me how my rust code sucks before I spend more time beating
> my head against the wall^W^W^W^W^W^W learning rust.
> 
> Rob
> 
> [1] https://lore.kernel.org/all/20241022213221.2383-1-dakr@kernel.org/
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> Rob Herring (Arm) (3):
>        of: unittest: Add a platform device node for rust platform driver sample
>        rust: Add bindings for device properties
>        samples: rust: platform: Add property read examples
> 
>   drivers/of/unittest-data/tests-platform.dtsi |   8 ++
>   rust/bindings/bindings_helper.h              |   1 +
>   rust/kernel/device.rs                        | 145 ++++++++++++++++++++++++++-
>   samples/rust/rust_driver_platform.rs         |  24 ++++-
>   4 files changed, 176 insertions(+), 2 deletions(-)
> ---
> base-commit: eeb31b3e7e9e1b485763ecc66ece8afba1416b2a
> change-id: 20241025-rust-platform-dev-0e89debcbba5
> 
> Best regards,


