Return-Path: <linux-kernel+bounces-237788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B887923E20
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204AD2835A1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF3716B3B4;
	Tue,  2 Jul 2024 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Eofy/W6c";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Eofy/W6c"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2047.outbound.protection.outlook.com [40.107.104.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FBC158DC8;
	Tue,  2 Jul 2024 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.47
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719924633; cv=fail; b=KhiDyzWz2lCrVobwZrhr3lIFUog/H5B/gzWfSIfJZOpxmGSqNfnOVt2oCQup9d8yIxNbdnfDGwF0Q44xda061rF17w/CMFtC6zmIcLv6lovi0R3OWuLP7JwwEYwEw/liozQztfRe1UYSGNQtHplziMOJE65rhyLw/LYkg1XjCOE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719924633; c=relaxed/simple;
	bh=tUhtO+MwFmjLQAi9hjOsNWIY9ssxf4xQPyoL7z9B1/E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RQDej1izWvz3pLPXL6LER527GpxOlbuJFKfNVslJ/hQ+S3Pln/fhbIrBl8zef+PvrfuznocSIzy1NeiD0TBDumo9W4iCFnShCFaHRW3A90Jojcn/EaYodncSNFmgOcfcgI1PLmh9XIMFyiUtlMqmpDSDwCRVbqlNUiaVlG8iLHc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Eofy/W6c; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Eofy/W6c; arc=fail smtp.client-ip=40.107.104.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Lp79U9kAECy9OYUSf6CjMA4g8f5EkBPev0PDiU3Q6vuCNYzE4ygoiXCTPMvt0qtDNIW4wj8kI5Ny+lCEMeVfcNz2ZiXRX0tQjW/l7hie9xTl+iFM8IkuezMj8abIpfw/I+fuiZIqmxM3Q2sXbkg0Q7s5nU59+Bsjk5kOA//x0dSxZUnZKWzp1E47VSNgv0U8+2wCLZwZkU24GHkFt8U+qzN0e6LMDdLmG6LWqc17h59eNgmZhJgFz+b6xPkZf/aFRh9z/uHrTS3A9Es4qUUwkpz8lCFcX26ni9F5ZJKcebpp2mH00sq5+VYkG3iPhJAjpIC0NyJnoyTTAKs/ypXZig==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14+c+GAFBEeax4OFoKirH2vJUORZLtnKCfXXmX7xGY0=;
 b=Qr1rNr0bKx7HWeajjvhizNwKAtYv3Bs9G6qxEBn8oc8V7r4p0n2YDiwQU92M0UoT51BQAF4BSdEFDlsfCEdoDXyyRD+cij9wp94/uqjeNiIiYVP4N90KUhciCL/hh8ThoMtrmEuGXsoHy/C+Mxn6oNB+97HODWLL1xTeaFmE8HubcQ7nkNA661AooAhlxOdjkDBCVImN19xTexvY2DB7JN03YWfXrUZvsDOY6kVE33PYAC9VhWhv3PWRuKLzVY3fOP011f6MDWkxfhQubOZ3uh8ZMNM9u0tXEQmT+ivqhoB/iYBlMfKtTuQ77GflXyjnhoYoEPV5IzcdbbQ/49OLNg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14+c+GAFBEeax4OFoKirH2vJUORZLtnKCfXXmX7xGY0=;
 b=Eofy/W6cVhJm3VGjx+kwH01HETymkyg2kj+wP+HKLrOIsaekreOSjQwITfXWocQvZ8Sl7KkZHqe7CHW6OXoO5Y1odQtv9I+R6M4abYtolLP5/dbvjBR1h2OSqHd05qr/Kgy4DF1JX4DN6mx5DPPXOM32gOJUTkNq2EvCuqkhCXk=
Received: from AS4P251CA0008.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d2::16)
 by DU0PR08MB8663.eurprd08.prod.outlook.com (2603:10a6:10:401::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 12:50:26 +0000
Received: from AM2PEPF0001C713.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d2:cafe::1c) by AS4P251CA0008.outlook.office365.com
 (2603:10a6:20b:5d2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34 via Frontend
 Transport; Tue, 2 Jul 2024 12:50:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM2PEPF0001C713.mail.protection.outlook.com (10.167.16.183) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7741.18
 via Frontend Transport; Tue, 2 Jul 2024 12:50:26 +0000
Received: ("Tessian outbound 3a274c9b26ce:v357"); Tue, 02 Jul 2024 12:50:25 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 46fc4fa3bb593851
X-CR-MTA-TID: 64aa7808
Received: from 9774f3dd5cae.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 70394DB3-ACE2-48CA-B490-7931B201077B.1;
	Tue, 02 Jul 2024 12:50:19 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9774f3dd5cae.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 02 Jul 2024 12:50:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtgsipR8+0XMNkab2M0Ga8CULTMvgpgDEe6uDHICWtqrgaRDkge4iCNvaeQlTZbp5C+QFYuILP31Q2TtB49e96zKcuB/znDskyCWG+jFQjTgHcJses8SahIZFwUF4miz+D1sZvBaw2vbGgETGfencdk0fVdN0idbvwF+tSApyHXy+JBJlJ+vf9FhTDbOP/q2VY2RZ36mBF+snHJHiImS6S4NC4orBs2Te+qD/TNNV/4P65+0md7tgPTdg6tOvPgxrsa3ea/FQzxhBzFR875d5Ilz7ywqJzEuMLXLZ2UvdlFEHsg5rDy7h8G6xJWcdFuQpbWp+6c5c14h+2NZfvvJww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14+c+GAFBEeax4OFoKirH2vJUORZLtnKCfXXmX7xGY0=;
 b=JLd5k8COAFn2FAWraqhHugmEEIWrcbw0SDwjW48vEDhfiPtnp6NqZepakCETYxZT/DR7DROJAHVghkI1W+Gpv63qFkuWFKnd6aeOiSj1CB2P+8lToZ9KZL8BmEYXNSQPIhuWBlcmHLVS0Di96mlzT3rOG4+6t8wcpEya0jref4xjijoLIKBO6QvWGrXeq+tbmJkucaiUqI6Wt4aA20X6GUySNHC9SCiutN3FEYXwk1iDVEwXW8ECBrK1+RxKJOjWjsPlYJHRrBaFS4jRhgW3hJh6iS1CilbXQo2SCXj11TxS+vxRoqAf7SFdkFDZtj//hphtvOFLVP0XD/5bgeIJ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14+c+GAFBEeax4OFoKirH2vJUORZLtnKCfXXmX7xGY0=;
 b=Eofy/W6cVhJm3VGjx+kwH01HETymkyg2kj+wP+HKLrOIsaekreOSjQwITfXWocQvZ8Sl7KkZHqe7CHW6OXoO5Y1odQtv9I+R6M4abYtolLP5/dbvjBR1h2OSqHd05qr/Kgy4DF1JX4DN6mx5DPPXOM32gOJUTkNq2EvCuqkhCXk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU0PR08MB8639.eurprd08.prod.outlook.com (2603:10a6:10:401::11)
 by FRZPR08MB11046.eurprd08.prod.outlook.com (2603:10a6:d10:135::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 12:50:16 +0000
Received: from DU0PR08MB8639.eurprd08.prod.outlook.com
 ([fe80::253c:bc53:f4b8:3c7a]) by DU0PR08MB8639.eurprd08.prod.outlook.com
 ([fe80::253c:bc53:f4b8:3c7a%5]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 12:50:16 +0000
Message-ID: <f966bd1a-bbce-4ce0-9a67-c1423cc9cb2f@arm.com>
Date: Tue, 2 Jul 2024 13:50:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] Track basic SCMI statistics
Content-Language: en-GB
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>
References: <20240701142851.1448515-1-luke.parkin@arm.com>
 <20240701142851.1448515-3-luke.parkin@arm.com> <ZoLWH9-JPFQB4YSu@pluto>
 <490bb053-f2dd-4c6a-a976-c8d21d66eb4c@arm.com> <ZoPgHRl8FUo9-Xvz@pluto>
From: Luke Parkin <luke.parkin@arm.com>
In-Reply-To: <ZoPgHRl8FUo9-Xvz@pluto>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0260.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::32) To DU0PR08MB8639.eurprd08.prod.outlook.com
 (2603:10a6:10:401::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DU0PR08MB8639:EE_|FRZPR08MB11046:EE_|AM2PEPF0001C713:EE_|DU0PR08MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: 00757295-d7ea-49cb-aa8b-08dc9a958b8f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?TkQ2UllhOVVHTUVyb3MxWkljV3Y0aVhFV0F6S0pxK2YzbEd2V0tnSkxGdGJ0?=
 =?utf-8?B?ZlNtNnNmTTNiaDY3RUtWWk9JWE1Td3hYeXNIaU8zWUk1Y21meXI5RGJDRGZo?=
 =?utf-8?B?V09IVmt2SXBIRmk3QmVzTUhoQ2xtSnJwNWxXYUdtU0k0Y2ZLeWh3cWNRa3BH?=
 =?utf-8?B?NU1SMnk2WUFuL0d5SE93L0ZkRmlORldIcVM4RHFJTzlsT0k0WDdrc0ZhR3gy?=
 =?utf-8?B?ajVzS1ZCdUIvdjVzTytjeitOQys5WnZTcmJoZ2VZbXRtaUZrSkxDOXM2ZmV6?=
 =?utf-8?B?UDhaZkwwNHBVdlBBbnVDTG81UmJ5Z2cya2wra1pGRVNuVnE0bHdJbU5zMi9P?=
 =?utf-8?B?NW5RTUlhKzVJbDAvZ0NmV1pqREVZZDVvMWxBOGdOQjlKYVFrb1FwbWk3OWp4?=
 =?utf-8?B?YzN1RkR2M2dteC93MS85YW4wTGJLTm0yM2lTY2MzMnNqRmVOS2x5QktBMEpQ?=
 =?utf-8?B?czY5Zi9wQ0FDUWVvWTVTVGpKb2N4NzR6ZEVVUHg4OUx6dFBPTDRITU84WUtl?=
 =?utf-8?B?R3RMdER5UFhZR05Ma2RnVGZQMzAxUElLV2xaZ1N6VVppZjV1b1hFdE04enZF?=
 =?utf-8?B?VlFsQWNqR2VmZlRBbU1aYmY5b1IxazR2c0ZscW5tY0IrYkVKcjc1NUVnNS9M?=
 =?utf-8?B?OVNKbENYQy9odjBWMHJxQVpnUHBqVnNkemt0SENLL09ROExIdGkrSVBod2tR?=
 =?utf-8?B?S2JEcUpBUGQwVlY1RVVzdXBvY0xnMzFmWFdINStFamZ2ajFjUkxhRUtLcFdh?=
 =?utf-8?B?TWpLUUNlc2dvOS8zRVVSaFVwY0xpcWxiMXdGZUpDM0dmQ1dGZVBwSHVFaHNK?=
 =?utf-8?B?ZzhHblN4YloyQ1ZlcmpZd1JDVEhtdVBFZE91OFZRdDdmSHkrMFZGOERMbU1Y?=
 =?utf-8?B?QW9OVGpUbU5pU2J4MGlkWEpXQ0huUG12WFVFMHRITDZXKzRIUmN5VmNPQzls?=
 =?utf-8?B?V1MvUmtmaUtac0hJM0lVYmdINEozQk9mK0FMcDFrbXk2L01QUjFZVkNBdXZP?=
 =?utf-8?B?bkFodTJNNUxBUEFiN1RXL0p2Nm1aRVB4N3lrQnZHLzdJSTZBNHJud2JxcEp2?=
 =?utf-8?B?cXZBT0hMY2pzY3JPVUIzRStLTE5OMjFUMkRHeHVKeGZLQmlnR2c1cGh3REVM?=
 =?utf-8?B?U3BwTVFLdU5OSXIwSjFFWGJZTTZTbG1LZms1REkvKzY1WHYyMW9ENDFENzN6?=
 =?utf-8?B?NFhWS0prR2F2WGxmL1JBSW9lRmRPVVlyV045UW4yWnVid0laWDNRRFM4b0RT?=
 =?utf-8?B?NUl5N1dMWTY5Wis3YnRnUk0wVDI2WWFkQlIxUGcwZFVyTlM1UmM2NE5JSDNF?=
 =?utf-8?B?TDQvS3JuQkVKV3hqaUxrZ1VSdHVhRXF3QXIzN3Q1QkR2N1o5Q2thekFHaXVH?=
 =?utf-8?B?M05yNDJFSGZiRlNWUDJUOWtLWHRPVzhSb0xKd3puOUJBLyt6cHhQdDZ5czhT?=
 =?utf-8?B?THoyV2pXRm0xekpnZVgwOWwyald1YmdWdjdGbThrZ1NsM3NuRzRXaUczMTVw?=
 =?utf-8?B?ckFPY2FWbFFzOW1qMkVGU0Q2eW1tRGtwRUp0SmE3VXpPZHJHeUROZGZZczhl?=
 =?utf-8?B?M0ZISndXZEZGN0lXVVhPZXEzUlVSM1FOUUF5L1ViSXViWDVCeEZTZmdObDdv?=
 =?utf-8?B?eTlaYWdmcFU4QmdyL1VTQlFWa0grb1ZIRUw0TXVZZGhHUXVYQkFoRzc2RUJi?=
 =?utf-8?B?aWM2UlBhazZaVGNUVXdKbW5iTE9sMUp0cHl6VW1RQng1dFZkZmhsNDhlaXhZ?=
 =?utf-8?B?Sm5nUjZGMTdYUzRPRTBKbU5nK3FucHp3SktqdWFYRnp3TmlXWkdzT2VDM2px?=
 =?utf-8?B?RlFwUndkdlBqMVhaamxsQT09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB8639.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11046
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d890e67f-390f-427e-87ff-08dc9a9585ea
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHlqd3ZkcEFJYlAxUm1HbThtUXZtSENNZEtXQmNxT1lkTmx6cDhMOGJXYml2?=
 =?utf-8?B?Z0RiUlVrdEEwR0FNYmU2TXdjWGlCMmhadWVKZWZ2NlRkRGxzOW40TElVN3Ew?=
 =?utf-8?B?WFV5ZGhkclRIRkphTHNRcXVTWlp0V296OWpDeUh2VFFJeFNUQS9OSlk1UXFX?=
 =?utf-8?B?Qy9jbEJvZFkydkhlSmM5QmUxMGlxSGdBWG5HL0xCR0VIcFo3OUxZWHN3RlpF?=
 =?utf-8?B?UVE3cEY2ZkhiNm1EN08rNk5IZjNLT3c0ckNJTWRpZ2dwcVlhK2VoMzNnUlIy?=
 =?utf-8?B?aXlRWTk0aDE0Y0MrUlYwM0RKNnlzbEpIRlNYYU9JS0ZSdmtKM0kxZkViRDBp?=
 =?utf-8?B?OFFlUWVCS1hlZW5TQVc0bHZXdGQ5cnJ2VUZJZGlObjMzbkhRRVNKSGgvVmsw?=
 =?utf-8?B?NklCOThyR1VNYVRPT09vR1B3VGNwWjdQTzkxWHI0bDdnc1dPU0hKaEY5azMv?=
 =?utf-8?B?aUVrZDJ3NzdpOUZJM25HdFlTNklwSEJ5ek5nOFlBaFFTeDg4c2NqaGNoSG9F?=
 =?utf-8?B?cW42T1RiSmVKVjVjTjdCMXlpZDF1ZHp5ZzJnWjBLajJNc2NkOXZEdXY2NjBQ?=
 =?utf-8?B?Q21qcytvc0JGbTRZa2hsd05XbkJPSFcvWWQvSmNFM0FDM01kRUREWjRHUkVh?=
 =?utf-8?B?dm5KcVFlR1pkbmRYaXZRMEpwMnpBbFJ1UWVNMVZaSVJkT0FGTUdFai9qaWtF?=
 =?utf-8?B?a0lHeTJvMUNJbDJ5NVZSUTB0SzJzQlJWbTQ4NGcyU2VzV1ZkTUpDWTMvYVJ6?=
 =?utf-8?B?N052SmJicHBJQkxBRk5FWTZybkd6a29RT29oT2hFbzd4Zk84ZTZ0UGE3ZU1O?=
 =?utf-8?B?TWJadks1amJCZW1kTUkwSksyNnhKb2hqQ2dEdmhpM3paS0RISEhNOWUxTS82?=
 =?utf-8?B?dzNPQjJla3JoWFUyOUI3dU1va3NnVy80TFJJV0xSVzA5enR0UG5XcGwxVEZY?=
 =?utf-8?B?dnU1WnJuNnJzY2RXeDhPaVpubkpHaTBWbHNhYUN3TDlMQlpjcnVFQzVYOHY2?=
 =?utf-8?B?ZmF5QjNnWmRXRThxMUhpR3NvaTRnSFNlUFRkRG1OZUZLNXdmZTQ1anErbFVY?=
 =?utf-8?B?WGRRbjY1c3ErY2hZMFdEMTJoTWt3WVBJbWtvVGhwazJ4eGE1K0VGcHRmY1Ri?=
 =?utf-8?B?RlFVQ1FmOXFtRjc4cW51UHB5eUgyTTl5SEtiT3ZZS0p1MWFnUi9rcmhzZXdW?=
 =?utf-8?B?NW1YcTBqTDRhT29BV3RQUjlUQkU2TGNYekdzWGdiMzliZkE3SU9jYlZ0RU5T?=
 =?utf-8?B?TVlFQkFtRDdBTHBURzlCS1VwSFRmbk5KSVI1ZXdYZHRhdGlEWXh1QXhObEg3?=
 =?utf-8?B?SHJPWkRURStCQ2tYV1BPM0dJVzlOS3ZaYTBkd0owMnFRT1FrQW5PZ3NvMXFH?=
 =?utf-8?B?WHhKQk5xeXpXaWQvUXV4c0xCcy9nVVMweUNhRzJwWkNYQk0wVFdIWkFEZnpw?=
 =?utf-8?B?b3QvcEQwM3BnUHhlNHdwZnRDaWR3MVljWHUzS0J5L1VkK1ExN2pDWktlZDRV?=
 =?utf-8?B?NFNUd0hyK3A3OUdIWGhXa2g1bmdnMUxNTUY0SXdmZmlUczdyR1E5dHQvSGJ4?=
 =?utf-8?B?UFFLcVV2QVlONkY2Sk1vaE5KK25ianVmUlV4QytkUFFhRVREVDhId1h2V2s2?=
 =?utf-8?B?T3pQYm82TmdLMHNlYnR4TUtzVC9QSWROU2N1TnFjN0Y1d1dieGZRTHVSVGxO?=
 =?utf-8?B?bGdOWkl0Q0xWOXZvNlg5Ukh6SkUzaEZweGR6ZE9GQm5RbG0vZnN5ZnRoSUE2?=
 =?utf-8?B?dFd4VWIrOXFtTU5YMG1lYnpSRWJWZk9vV25waW9aRzVRUVJWRFFIOVk5Ymtu?=
 =?utf-8?B?Ulc5K09CS0VueVQ2Nnh2dSs0VkxDSUJSa1MvdTg3dFFwaGJjMTlxOXlGVi9H?=
 =?utf-8?B?WjRwbG9iTjB1MFVQamRGTEVlQU1EdUJyNkhZRkNZdHkwU1BhbzlZRE0wTG4x?=
 =?utf-8?Q?aa6ko0T9Uvp9bWAnIiAY0RDP0rAesaJL?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 12:50:26.1083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00757295-d7ea-49cb-aa8b-08dc9a958b8f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8663

> #ifdef CONFIG_ARM_SCMI_DEBUG_STATISTICS
> static inline void scmi_log_stats(atomic_t *cnt)
> {
> 	atomic_inc(cnt);
> }
> #else
> static inline void scmi_log_stats(atomic_t *cnt) { }
> #endif
> but those calls can be split and placed alone where that some condition is
> already check normally as in as an example in scmi_handle_response():
>
> 	if (xfer->hdr.type == MSG_TYPE_DELAYED_RESP) {
>                 scmi_clear_channel(info, cinfo);
>                 complete(xfer->async_done);
> +		scmi_log_stats(&info->stats.dlyd_response_ok);
> 	} else {
>                 complete(&xfer->done);
> +		scmi_log_stats(&info->stats.response_ok);
>         }
>
> ...what do you think, am I missing something else ?

Ah yeah, that looks better to me. I'll use that.

Thanks!
Luke


On 02/07/2024 12:10, Cristian Marussi wrote:
> On Tue, Jul 02, 2024 at 10:57:23AM +0100, Luke Parkin wrote:
>>> Ok, so IMO, this is the main core thing to rework in this series: the
>>> "counting" operation/block should be defined as a macro so that it can
>>> be fully compiled out when STATS=n, because these are counters
>>> incremented on the hot path for each message, not just once in a while,
>>> so the above if(IS_ENABELD()) now will be there and evaluated even when
>>> STATS=n.
>>>
>>> Something like:
>>>
>>> 	#ifdef CONFIG_ARM_SCMI_DEBUG_STATISTICS
>>> 	#define SCMI_LOG_STATS(counter)			\
>>> 		<your magic here> 			\
>>> 	#else
>>> 	#define SCMI_LOG_STATS(counter)
>>> 	#endif
>>>
>>> .... I have not thought it through eh...so it could be radically
>>> different...the point is ... the counting machinery should just
>>> disappear at compile time when STATS=n
>>
>> Hey Cristian, Unless I've missed something, It looks like IS_ENABLED() does do
>> what you ask for.
>> In Documentation/process/coding-style.rst:1168 it reccomends using IS_ENABLED
>> for conditional compilation over #if and #ifdef, saying that the compiler will
>> constant-fold the conditional away.
> 
> Yes indeed, it will be compiled out anyway, forgot that despite having
> it used myself a few lines below :D .... but from the readability standpoint,
> given that we will sprinkle this all over the code, wont be much clearer to
> conditionally define once for all an inline function (like mentioned at the
> start of that coding-style.rst paragraph) or a macro in a header (like common.h)
> to wrap the atomic_inc
> 
> #ifdef CONFIG_ARM_SCMI_DEBUG_STATISTICS
> static inline void scmi_log_stats(atomic_t *cnt)
> {
> 	atomic_inc(cnt);
> }
> #else
> static inline void scmi_log_stats(atomic_t *cnt) { }
> #endif
> 
> and then just call it plainly wherever it needs, knowing that the compiler
> will equally compile it out all-over when STATS=n.
> 
> ifdeffery is discouraged in the code flow but it is acceptable to define
> alternative nop fucntions in a header.
> 
> Also because in some of the callsite you handle 2 stats with some ifcond
> (conditional on the IS_ENABLED that is good) and that could be a problem,
> but those calls can be split and placed alone where that some condition is
> already check normally as in as an example in scmi_handle_response():
> 
> 	if (xfer->hdr.type == MSG_TYPE_DELAYED_RESP) {                           
>                 scmi_clear_channel(info, cinfo);
>                 complete(xfer->async_done);
> +		scmi_log_stats(&info->stats.dlyd_response_ok);
> 	} else {                                                                 
>                 complete(&xfer->done);                                           
> +		scmi_log_stats(&info->stats.response_ok);
>         }                                    
> 
> ...what do you think, am I missing something else ?
> 
> Thanks,
> Cristian

