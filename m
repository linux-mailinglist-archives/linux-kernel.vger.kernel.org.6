Return-Path: <linux-kernel+bounces-293774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0258F95846B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EACD81C240C5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001AE18CC0E;
	Tue, 20 Aug 2024 10:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="Mr/ybt4x"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D627118C90E;
	Tue, 20 Aug 2024 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149605; cv=fail; b=ENTsSSIuNVWE3eGyNJRXCQ7P5cN30oixIA17BKppJzUEPwg9LSfWaXkxRIFRKWUU8M9WF13hLLnvuzdegtaF8Lo6zv5PxPTE5kgvbZRHa6Ugpy+6fEo5foytO/f4PN/JpiP45Tmrj5aYo6qVmNPKAj9cbx/Ln9O9CafcyIZCXXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149605; c=relaxed/simple;
	bh=tdx5ekwX4vfbIuyQYvpWRwatc+oZVPPaVYOf2gWYpqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BxwLrLVbiZ/O4Y575yeJ2w9WfiC96LdeDKY9k49Iqjj4QgWWUHrCBj3UwFTE4xCUWfwXI/3Yg0kgrX8x0bJLOknxoM2onQjy8AlgPrw8PlvtpTEdPJh4vc3aTKiRbDl5pOW3QHC8hJ3tZxr5c8F6VRoAQM42Q6n+SJWrSbFaR3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=Mr/ybt4x; arc=fail smtp.client-ip=40.107.22.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=On5hoE5YAv3x6UPBtlA6wKWy2Gq70zGeGryzNmAcca0KU42x3BGTA8px2vCpsUHF3PevOUkoVVoSPtg6C2p7d7Rwtj82vA61uYOkksFD+5Z/GRCf9RJdCjIc10c8dzYS2g2TCBsZyDqOEec4LS+ZrRzHkog5G/L+3/I6KCqIIzTo8qBdTANJYBZZLuQrML1DgDW1mjiXbOvLfV8B4BFrfrl+azvBHc7qV/fkMwHgQOziGHgtW+zf5OYbOYJXX3snsHuLnSmecPf6UdH+XgJaPxnk1hB9yn3AWDBT2p4Sf63AAEW+DDMU5HwT1f95ICbxrBl8WYuULAao1U3qKgzkxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDOto6/wnOEbX2zhgCuTuAmYQ/9yKgSZCmbShQtA6Sk=;
 b=o3FWVLxYhGm/dclelx0ImKHkDnRPSpzyHjug6KYJpmCdtnQf+f0PYwEszv62+bDqN0+a57HQxLuYTZt5jzEZZCRoQ25o9Iu1E5azRIhKLobMk1aI7asOo4o/aO2TVReSxlkGvLTrzPW2R+O3ZtfYp/7HlSJWU9/aKD7LdwMaGLcFI9d4j/OqFFQ8pFpf8wuwfbOBgGLNeTukfedd7eXFUomLA8q14KE+snvQRSikrueOTs+wPUejzBwfBmkytT42Qcf8wAcWuq7mdxdkgXsSVD618KscVlBlk8idQhILSlHyCpKlzcGHynrjOXVKXR/fhshfL27VODLJYZl3DcdElA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=redhat.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDOto6/wnOEbX2zhgCuTuAmYQ/9yKgSZCmbShQtA6Sk=;
 b=Mr/ybt4x792r1xcknBS6Sc2FycConb/XOMSK/2jeZSxvvavYph/nRyCKoRzE+UL1TJs3lYqz0MT8DGwOJ9Ph20sPRYDXjtEx3eXlWhkM4jt0R8tH86f47T7qevTG2D9yBZ7dhQX6sFD7fgrwaGnhxk16FopaGg1p/eDrY1TqLwc43GJSwG9F33GVAPKbZeZd/Qw+HV8U96HG/kNYyUm4pX0BLCI7lbbMimGjVFxf+tPCON+kJDgQXk08i9edKkTE96rCPA06Bu9NqkwWQXGCi7S6nxtlXy737IUDyhBrL7tC4x/TpoeibGiKvHlnKW3XTpsVXE0EKOOalAqN3GYMdA==
Received: from DB8PR06CA0040.eurprd06.prod.outlook.com (2603:10a6:10:120::14)
 by DBAPR10MB4012.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1b4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 10:26:38 +0000
Received: from DB5PEPF00014B92.eurprd02.prod.outlook.com
 (2603:10a6:10:120:cafe::fb) by DB8PR06CA0040.outlook.office365.com
 (2603:10a6:10:120::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13 via Frontend
 Transport; Tue, 20 Aug 2024 10:26:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 DB5PEPF00014B92.mail.protection.outlook.com (10.167.8.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Tue, 20 Aug 2024 10:26:37 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 20 Aug
 2024 12:26:21 +0200
Received: from [10.34.219.93] (10.139.217.196) by FE-EXCAS2000.de.bosch.com
 (10.139.217.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 20 Aug
 2024 12:26:20 +0200
Message-ID: <ea1c6b87-238d-455c-bb30-3c4a51b4cf4c@de.bosch.com>
Date: Tue, 20 Aug 2024 12:26:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] rust: sync: Introduce lock::Backend::Context
To: Lyude Paul <lyude@redhat.com>, <rust-for-linux@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Danilo Krummrich <dakr@redhat.com>, <airlied@redhat.com>, Ingo Molnar
	<mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long
	<longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho
	<wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
	<gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, "Andreas
 Hindborg" <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>,
	"Martin Rodriguez Reboredo" <yakoyoku@gmail.com>, Valentin Obst
	<kernel@valentinobst.de>, Trevor Gross <tmgross@umich.edu>, Ben Gooding
	<ben.gooding.dev@gmail.com>
References: <20240802001452.464985-1-lyude@redhat.com>
 <20240802001452.464985-3-lyude@redhat.com>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20240802001452.464985-3-lyude@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B92:EE_|DBAPR10MB4012:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c092156-6f8d-47cd-261f-08dcc1029302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TElVOW5jMlJsdlFpNFBEYkxOb3FDQ2Q4U25OU25PcmlpS2ZMMUN4a0dIYUZa?=
 =?utf-8?B?TzJ2aVVkVTVKdGY5aGZKRXR3MmlVZk15b21TN2VoU1NTYzJWdkRpMWkwS3Rq?=
 =?utf-8?B?aDZHMWYrV0h0bUsza2FNYmp3SHdXNWFVWXlEVzZQSlE1ZVJrcU9ORnFrRkZH?=
 =?utf-8?B?Sk5oWFJOWUtLRGhnTUxGckh1TEtHWUovcEdxdnJhQ014b2tVWVBodHVmMDU5?=
 =?utf-8?B?Y3JHb2tOQ1FVTC9NT2VSd0hTWWkwQWtQTXlUNlpvby9yS3pManRqOXV4bTlJ?=
 =?utf-8?B?TllKY000YkhPVVFveWk5ZHFpb3FkTEJhTE5BUDRTYXVjNXNhcTFXbTEvUjFp?=
 =?utf-8?B?cUIvWkk3ZEZRMmtwaTduOXQ0NXhhZEkzSUNWZ2ZXTE1aczVOZ2cxYmJ1cVVj?=
 =?utf-8?B?blFmV1FSZll1akFIUkdxN1VxaVNmTG1XMjI3WmlnYTR4aDUyTitxd0hsUjJw?=
 =?utf-8?B?S2UyYmxaZXhCU05Hc1FyTzR6dFQ1RWl0Q01ObVJUS1JjaGVNTFhUZmsrM3JE?=
 =?utf-8?B?RjAzSHhRaDBXdlpOWnRXaGhXSGQ2U3ozclBVSVdySVFidUdLcDBRamV6MVBn?=
 =?utf-8?B?RGlMR2wwNVlweE1JMkV5d3Vuc0NzMExMYVNSRnNJVGd1VXJMRjJxcllBM3Zh?=
 =?utf-8?B?M040ZWhHTVAxZ3ZrNFpEcFdSUWdsRUZCYmNsM3BVRUErV3pMNi9GalRZTlp6?=
 =?utf-8?B?OTU5TzA2bTdXYzZicGJLMlp3bWFqSWlTdlRPeEg3QUVYc01lNDFNaGpVUDRx?=
 =?utf-8?B?QUk2WXVITGZJRDB6NVNiTnV2R3h5dVdLd0RaT0pXdVFkWXRXcEhIV2pXMjJS?=
 =?utf-8?B?dDBjTHpUb1NJTEk2TVdnZEZGSVZHZE1xckorZjl2Y1JaalNHV2k5dVZ3bHVo?=
 =?utf-8?B?bGNlZ3loTiswelpyc3ZCd2d5aUFtcDdNc0Nod1ZuWEIwVDBKaVdYMmFKeDIr?=
 =?utf-8?B?dHdmZWE1aUQzTzZiVFZJTVFLcU5aVkw2T3hKMnU2MXJuSmI4bGwzdEZrR1p6?=
 =?utf-8?B?VllUbzBuV0ZxNFpHTFV0WTZ5S1NRaXBGMWhzRUoxLzd3bW5ITFE4MDRxdXc3?=
 =?utf-8?B?Q25uRjJBbHJCK3VkZ3BQTVY3R3prSW9RNUkvMDJnUERENjByMk8yR3J1YWV1?=
 =?utf-8?B?VG04eWRpbGsxMytSNXJ2SHhqWmE5Y0h1N2VkWTRXc0ZTVHYrcUc0TGl3emgr?=
 =?utf-8?B?M1pacmxjRGhzYnRQQVV5Z1BVVlZ1ZVB3WGlnN25BWkV2RFdQWmtMWlVzRjdP?=
 =?utf-8?B?dHZ2SG9KdjZiblAzbUUzUGdvRXoyUG9lMkQyelV0NTZaOTdJaU54QndpNnJZ?=
 =?utf-8?B?Sm00WlVSNHpYcmVMNUdOV1A5UDk5Y05LcWV4Y2EyN0oxdHd1ckp5K1A1SWZP?=
 =?utf-8?B?R1pYKzdvVTN2bkc4TTFCQyszYW04TzdLMHNpd09vb0tUYzdkeDV0QXN3K1RU?=
 =?utf-8?B?UTBsUFlmSDVJeXZINTU5bWxqcjk3NjIzUC9jTVFJZWJHWVJUdU56TjBTTjRM?=
 =?utf-8?B?MGF3aFV3UHVBSHV4cC8ramJmK2cxcU9tY093RTVZVDhvMGwzKzRKVE1kbnhK?=
 =?utf-8?B?YnpoUzdoQndHZEhiN2k5aVVQNlN4MCtGVVAwb0FjSnBHZHprMndWaGJaY2I5?=
 =?utf-8?B?SlU1U2svWnB6SGdkczZjb2RGbnFaYW1nMkRRMndDMExPOFFkQjYyVmx2aVpq?=
 =?utf-8?B?OWcwYnR3YUJ6RW5Hbks5NlNRZ2l3V1RCdGh1a3V1M3RJcURGSXdvK0s0R20w?=
 =?utf-8?B?QUFOMlJSWmQxYzJrbzZyaFZtODNLdGZ2dnczdDVoNm1UYnhpUTRSUyt4OEg0?=
 =?utf-8?B?SlpzUk9xeHpVNm9wQkp1NnpYQ0tob2RQQm5pUHRPZDRNQmxaQWxkWnBGN2VT?=
 =?utf-8?B?b2RjZXR4cmErRloyQXdDN3c0RFVOUmZzU2pKc0xzbU1NUnRkMTlWMkdLOG53?=
 =?utf-8?Q?3X+sKJsbfL/LsmTjE4jPHwpt5LkkjyKP?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 10:26:37.9161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c092156-6f8d-47cd-261f-08dcc1029302
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B92.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4012

On 02.08.2024 02:10, Lyude Paul wrote:
...
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index f6c34ca4d819f..0c72677233946 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -38,6 +38,9 @@ pub unsafe trait Backend {
>       /// [`unlock`]: Backend::unlock
>       type GuardState;
>   
> +    /// The context which much be provided to acquire the lock.

Looks like a typo? much -> must

Best regards

Dirk


