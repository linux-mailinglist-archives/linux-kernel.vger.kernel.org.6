Return-Path: <linux-kernel+bounces-548677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6372AA547E2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9BE18916C4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DD92045B6;
	Thu,  6 Mar 2025 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="H2OTzfW6";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="H2OTzfW6"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2989418A6B5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.56
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257332; cv=fail; b=X81oMDh/UXFx6qU8yKE7OcRNMJBqNJFAY3JOtbMvlvMZpq2sHMG9UHHQqG0WPHXVZ1+V3PGKwmJcx99Zrz27ihAL7VM+5qBoPerK6IspMIEE3/v+RY1G4NcfKOugbINVIbn3YwvREWrJA55pmtzrATf6AXCZbsbFHKKaMIjpZxI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257332; c=relaxed/simple;
	bh=2cVQcEt4CeeQA/E63ZOtbO9VPEKyh+OHYUbfahS81bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YQHKx9NhvEjpcxw3AsCwarqjU1dc7q2BaJFAsyi7ivuCH9FZS1REWofRgTEzZU9yOY4zvfGCvDOFE6XqVGxvyYMuQophjI52wXW/J3MJSUzINxs6eQoJFZNXM5N07NDvl5lZsS9cJ7bVHR0hFRjTtkMiM8YqjDCEjW+Ft6D5oC0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=H2OTzfW6; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=H2OTzfW6; arc=fail smtp.client-ip=40.107.104.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=BwzUKZ1aeqdAk8bZPuMhetzlR3Ym5koH3ME9HM7DemEdBB5r8uHV7zU3wjOPZqMSPOILEBNwhjLi+PTPJPWYIgJnLijBJl2faM/Cf+lG6hrJIWJ1ZnyI/l6lNvuV9peBSDBCjXvIAbR/lzIISPlwTX7jeI7yUXLFVqKwfo0lISm6BZ3m6e1M2SZ8l+h6ftut1EjeBCQDMyp8aQ1rXE0maz1CSBnj3MO8aJradS5bQ0VSjkTv0Kw87WPxTTRU6r+yeG/KVCOpmekB5Y+/x4lO+frhRZGIfQNe+wIg/i7NL791mjRDAePnWkX98XT38UlpbxAllUOZleV5uVFjm7ej+g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPJe6Osq95MOVshmgOKz9XrDLWuhm1aRSwm/8kZ5cRo=;
 b=urBm0W1PSEVJLH9zp5TTpFStuC9TBMWs5OHNmCHNdGQO7y3102xqSFImvpJTwRsJ+EpARb1MOfQelRBQSxMMX2ji1hdkCsH6KHjyQrPs28vbkkFWDNs1Ligo2z57eAsRNNT2ZrfMV0p4vkg7GD5xh/xdA0IIpULcGO87ZrFKqedU1bv5X8yeWt8yUyx+Y2EQmT71pcinI2CajXBomhySSmzw79Xo8x/YR0ROm6a14nUDUD9LI+3lvs4TrTdZaZJOVxgl8z7CJI5hZPl2s/nGYPm2Fen3M0SAF+nZps7jhb6mgrDfhveRpZVmqNAjBEjSphgvWgT9/1l/vmJoZoT84g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPJe6Osq95MOVshmgOKz9XrDLWuhm1aRSwm/8kZ5cRo=;
 b=H2OTzfW6Yy/Yq70LYzZA0VbVDZI2p1Ay30O28KLnEloYDXEhakM7zLGDNQ3uYhQJf33DGe+hlMw5vPrcU4FfP4GHBWBXjLc2CT/8O/qhzaD+yfVwNW36p2l/f2yFT6/LtrSp/2Bx+pURoiGRt61BshNUPIdpYpJslc4WCqUu8V0=
Received: from DUZPR01CA0047.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::16) by PA4PR08MB5998.eurprd08.prod.outlook.com
 (2603:10a6:102:e9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 10:35:25 +0000
Received: from DB5PEPF00014B9E.eurprd02.prod.outlook.com
 (2603:10a6:10:469:cafe::17) by DUZPR01CA0047.outlook.office365.com
 (2603:10a6:10:469::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.29 via Frontend Transport; Thu,
 6 Mar 2025 10:35:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B9E.mail.protection.outlook.com (10.167.8.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Thu, 6 Mar 2025 10:35:24 +0000
Received: ("Tessian outbound c3a902884497:v585"); Thu, 06 Mar 2025 10:35:24 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 52d7d0d3841115ae
X-TessianGatewayMetadata: FsjKr7BPJiUQdKOU8popGwcomoCvZt4anOO+WP/7wDcmjUwsaW6UG8AP3PkKwu+a2JDEV+U/kQdBRhxYh4P4vAFNGk6w2JtN0nps9GcTEdH3CfLy9B0C+slEqCbHYngrTCQF5HQO8vzgE29zv0fcrg==
X-CR-MTA-TID: 64aa7808
Received: from Le1a992173cb8.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 24FDB75F-50D2-464D-8208-2B8554DB5D2F.1;
	Thu, 06 Mar 2025 10:35:13 +0000
Received: from DU2PR03CU002.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Le1a992173cb8.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 06 Mar 2025 10:35:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCmtMxrkolc45Ahf9V2v0BBREEOzy7TZBA0Dz6yoRhLHJDskrLBIzT0MM9NIs18y9tkFSHCtAFTEpf/7kGqt0MFH7lx4+auq4J5hCIOOXpW81tZFXvUONLZlvwR/HSnqeQ2vqrT4DZ1+uCPiWOCa8esfYbhoe535aRXP3YwyKPwaUW2qE8ojC/2vJq1KhnAkALLBf7JO35qaGdX9pEBGSyDHzntmvdugzu2ZTCVLmaZ80aIEic8Sp+nXNXDnWQ2HmYbGHSjzY0Z1Kfdqyc6FeHtGX+H2ull9dNSNysFvMR3vlBPywsZ3UKeKUx2n6zXBSlFZuB883CDWRt+rGza8lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPJe6Osq95MOVshmgOKz9XrDLWuhm1aRSwm/8kZ5cRo=;
 b=vGwChTAjhPTDPvKx6i5zj87t2Dh0GaoM38D9o0v7bJ3vtp3OPL7f8O/oSqpF3kCjvra4x3R5//v/dLUVxJI1ehclmou18ZXMCZPl4b+BGIUNYZ0n9XgMY5r69b3fenrQem4Oz+YMiRkgjTsW+ft5VeHsXIIbX6WyBz+hPX4V8Pqdxngvi5LGvkxoS5RtuWvvFVBUyR6ajOXQYFRH2y/jshmJmSncgtrBcdS0NspIvJzWO+P7H/gWMsBUCa4KKsstscXgt41DxiMmdwy3rWZS6xNMlvgb7UgazE2viGKZb5r+LlRAOdb9893e8SIorHp6ALVw85PQKOCbwh1qOBGr/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPJe6Osq95MOVshmgOKz9XrDLWuhm1aRSwm/8kZ5cRo=;
 b=H2OTzfW6Yy/Yq70LYzZA0VbVDZI2p1Ay30O28KLnEloYDXEhakM7zLGDNQ3uYhQJf33DGe+hlMw5vPrcU4FfP4GHBWBXjLc2CT/8O/qhzaD+yfVwNW36p2l/f2yFT6/LtrSp/2Bx+pURoiGRt61BshNUPIdpYpJslc4WCqUu8V0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB7944.eurprd08.prod.outlook.com
 (2603:10a6:20b:541::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Thu, 6 Mar
 2025 10:35:10 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%6]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 10:35:09 +0000
Date: Thu, 6 Mar 2025 10:35:07 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: mike.leach@linaro.org, james.clark@linaro.org,
	alexander.shishkin@linux.intel.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v5 8/9] coresight-tmc: change tmc_drvdata spinlock's type
 to raw_spinlock_t
Message-ID: <Z8l6W8KtWkA5kS0s@e129823.arm.com>
References: <20250306094800.1082950-1-yeoreum.yun@arm.com>
 <20250306094800.1082950-9-yeoreum.yun@arm.com>
 <c7a142ee-d34f-494a-b4f9-921d739aeb59@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7a142ee-d34f-494a-b4f9-921d739aeb59@arm.com>
X-ClientProxiedBy: LO2P123CA0072.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::36) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS8PR08MB7944:EE_|DB5PEPF00014B9E:EE_|PA4PR08MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: d2b267a2-1367-42d1-5945-08dd5c9a9a99
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?K3JncWswb2xoRkNpaW1EdVdraW5HTHRiNFZ2YWUyeUVOOEt0NVRZbTFRdEZO?=
 =?utf-8?B?bGxjV1JFZTZtVEhYbTRaRHdUdWZtM3U3NnU5b2MwZm4xdEVTWmhXdjR1VEZx?=
 =?utf-8?B?bFVYUitPWW9weUNSbjlYNDFESFFSeElBdFpub25LNXZ0RlVRby9FcmxiRGxI?=
 =?utf-8?B?N0pWSGRjaFlxdDA4Q0hSRHBtRk1zM1FzWFN5K1VEV1M2TlZEd1J1dGcvRVh6?=
 =?utf-8?B?TzlvYkhEOHdDcnRLTEM5cXU1K3dmeGVyUVErNkQ5SmFRQnRPRVRienUzcXFR?=
 =?utf-8?B?cTY3cU5SQWU4c2pBM1NoSFd5THRBS1Uzd20vVS90dERBMGdleUVuYit5UHlG?=
 =?utf-8?B?U1hBMkFoeXgwVlBDMkNaSlpNSjBiUVk2dDBsTENKRlcxT2FwVkRKSlV4SEw0?=
 =?utf-8?B?ZGkwTUxVRFZKWVRtQUdwaFE0QUtwR1FtTFVnei9CODlTWWJqNkVZNUh1K3Rq?=
 =?utf-8?B?K1VESGVVWlRNem53NnZMaHByZlEwR3YxVEh4dll1RnNXTWRqdDdBSDIwV2Jm?=
 =?utf-8?B?NnZCbmlaSE54a2RBZnJwOGZIVVNDTmRmbjUyWjUyYklPK0pjSFhER3RWT0xC?=
 =?utf-8?B?WHkxMFBhclNiSG54MkZuU0ZCcmZzRnhpTDJ5a0s2aUF3THlyb0NBOWkxZlFn?=
 =?utf-8?B?Q2lhbm1hOXlpL21JQm00ZndpSTB1L0N4Rys2RmZuQWxsUE5LdU9OZXdnVlEz?=
 =?utf-8?B?UWNyMDRPMGpYOVFHcnBGWHVkRXNPTk5vb3hWM2hMa0tzTEt4Z2NLNDlBZ0lD?=
 =?utf-8?B?ekgzK1l3bEtHbVB2Zkg5bDVwczVnMEY0eDVaL0U0K1FCaW9DKzhONFB4d0Za?=
 =?utf-8?B?anVmQ25FVXNMRXlST2k0SDI0SXRDWkZEamNUUWwxdHAyOVVyeStNZm5JYXdK?=
 =?utf-8?B?MnBxUzZsRDhEYlliRFRMa3RhSGtaQW8yNEVPTDRtOWVtdzN1NTFLSDk3eVJl?=
 =?utf-8?B?Q0NxcEhsZ2FCWi9nVStEaldKbDRrc2dDWTZHWXFzT05neUJNa0Y0K29HV1pZ?=
 =?utf-8?B?R1BnRkpoQzM1ZWo4Vkh2UXAraVgyUXJsZTVvL3A5RHpObW1BU29IejFrTVN6?=
 =?utf-8?B?TU1Nbjkwa3ViY0t5K09GSlhKZHljS0ZpWG52amhHMVlkM2lWUmFvREMrUU5h?=
 =?utf-8?B?cC9yZFpOT2djRHRTUjN1UytaZCt0RlBTWERNNEttd09mK0ZMcGxpUzNIS0pm?=
 =?utf-8?B?Y3VrUnVXOHJwb0pDdHZvbFZYaUNhNnM3aDgwNU1Ya3A1cjV0cXFYRzROSGsx?=
 =?utf-8?B?UGxlSzZLcEcvMGNDZC8xczYvcEJXWkk4eUlyUG8zR0QzbzQ5YVRPMXNjNEd4?=
 =?utf-8?B?WE9BMFNiSWpJSCtzZlZxVHhhOXRZMFRjNGh1b05SdElHTzRNSVdyTjFnT2Q3?=
 =?utf-8?B?ZUYxMWNsUk5yM1E0WVRBa1J5WCtMSjVnMUJUMjJwNG5lT1VTbjMyRE40VUlF?=
 =?utf-8?B?NkxmK3daOVdYV0pNQXZyYndtMHFMVi8vR0VZck5PeHpocGdmdFl1UDlrSUpP?=
 =?utf-8?B?bi9XWTdRdDNPSExWaVdhNGxiY3lwYWxiVXU3OXpnMlVaSFZNNXk1ZVdlQzEx?=
 =?utf-8?B?OG1SVE5rbmNtdVMrZzloajhjSkZEQnljRXh4MkFnMGpscmxJN1VWT29SWG1L?=
 =?utf-8?B?Z3M4LzRRYTM0SEpGUTBBVGM3YkU2bWEyVjErYkUyZk5IZGRzM0NFTHBETG93?=
 =?utf-8?B?bUprdGg5bldyMjBoVm4wN2VpWVJUMG4rUXAvTC9SRllBZ21FNDJZL0poanYv?=
 =?utf-8?B?SDlWeVVUa2d0cTJDSWV0OE1UR0NZd1dnQWdXRXNDZ2hTRDUrR0dHMmZncnNh?=
 =?utf-8?B?SXp6VFg3aVR0Vml6K0VLcytDUWZRZEl2ZmpzTnc0RXRkVEFYZFQ4WTdUNlNE?=
 =?utf-8?Q?LFg8Em8k5XsDd?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7944
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1ff5f264-ece9-466e-3155-08dd5c9a91c7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|376014|82310400026|14060799003|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1NyTEVBN1FqL25FVndYZTZ2MzR2VEZkUXBCTitNeVQ4aENQOS81OTRQbVdz?=
 =?utf-8?B?OEJ0Sm8wazM4L0wzNndJODFwRE1aOTIzU0RXOWpuMG92cEd5cFUvdFV2N0dP?=
 =?utf-8?B?RldNdUExWTl0NVV4dDZmeTZrSjlrWUJ2bThZMkJKbHdTT0gzR3JNT1ZISG9I?=
 =?utf-8?B?MmxhNy9KZitnM0RiNk9VWjEyQ2ZzdldyMnhlZ3pkYVZDanN6ZUI2eGxlUHRD?=
 =?utf-8?B?NXNFME4rbjlaQ1hOZGRMSUs3cjFpdG5pUlhBd0hZNDRBK2huV3EyMTJmMU95?=
 =?utf-8?B?dHpuRm5VaFpSZG9FYU5jQzZRTnkyUlNHMjdWU1hxK1NzSEZlTmVocCtGamdn?=
 =?utf-8?B?YU5GTG5NWEg1TjB4bmJzUmd3dW5YY0ZzbTE3V1N2c0VZL2FrdVZrYUNnWlNX?=
 =?utf-8?B?QjNmRmQ3V0JaSEdEQkZ4QWxCQUxrS0p0WnUvUXlFVFhobzE2eUxJUzI2SDI0?=
 =?utf-8?B?Q0dndnBEN29wQVlmUVNENUtkK21tenNwckh4Sy9yQjlmWWhQOG1IRjFzWUZ1?=
 =?utf-8?B?dlZRQnJhRUpHUWxUcjd5RzBIeDZKQkNOK2FnQlZ4SGtBY3p2Rm1YZHhkd2ta?=
 =?utf-8?B?SjR2Si9hMjg5cDByRVRHWkpKb0hyZ2FMVUhhTXlod3Y0VitKRUhjb2VZeGdF?=
 =?utf-8?B?Y2Y5RzFXd1NlVno4b3VUMXBKQXcyY1h6MW9BQllMN00rWGFjN0p4amV2eDVu?=
 =?utf-8?B?RDFuYjNJSGRHQnFYR1QrYnY4S3JpTS8yYmFXbmVwTVg0S3QxWHo0NHR6VjBs?=
 =?utf-8?B?a3dSNi9XWld0dVNmb0VBV3o0bjc0M0JFNWQ2WHNEVWdPQStwRXY5SnJxOGxw?=
 =?utf-8?B?Rk9nV0hqZEtLL0dyZktBS0pCZWJJRjQ3cWpVa3BtRS9sUWJpRFFIUWdsYkNx?=
 =?utf-8?B?cTgxc1dKd3FGRS9uamZMNEJRcnAvQ1JkSTY3a2JENUkzenllaGMxdDYraFlL?=
 =?utf-8?B?ZmxFK1RRNmJqczh3ZmRtYmlJVm9LTVFlaDJsUG1DWk04cHhTSHNxYmw0U0dX?=
 =?utf-8?B?d2k3aWd4OCtUc05EaHo4b0RJZ1drclVHTWNNblREL1cyWVN1aXBrMmYxbTBa?=
 =?utf-8?B?azZ3ZVgwb1Z4K1lCcnRaeWcrVlpML21rT0dabEpjK3ZqUGRjR2VGdG5yUkpw?=
 =?utf-8?B?WStTSGFLK2Y0SE8vdHpHRVBnbGJjNzN5M2w2clUzZ0RMT2V4cGlYUVFSamxT?=
 =?utf-8?B?cDhMK0l6dDBEalVnQTBkT3hxVTMvWmprdHh4YmR2UUtza0F2K1YvWEhwcVJO?=
 =?utf-8?B?R1dRc1lmKzFQUUpTQjk1MmNCU05IdHQxY2NseWVNeHRXb01HNW11WEZ1ZXU5?=
 =?utf-8?B?TVZtNnFrNDVHM1M5KzdwTW91UVd6aGRueGFXSXo5dEFGWldmNG1Sb0RWcncz?=
 =?utf-8?B?YkwvR2x6UFRCTnBCNGJqSjJkK1NHem9INDBQUEE5M2JnVmR2ZUZwVmxZOTJH?=
 =?utf-8?B?aElJeSswTEloNXo5TU15ZkxKOE1leWxaQ3lpSUtITnVzVklJejNPbzV4eHNj?=
 =?utf-8?B?WWVxekV3cnVlYkJRL0g1STJHUHlEb1hDb05hTkpzeVZrYnIyRmw3Q3lBc0Vq?=
 =?utf-8?B?V2pFaHRvZFNxbDZSRHRZa1l4MXVPZy9rN1k3UkZ1SE94aU95S1o1S3NTM0NL?=
 =?utf-8?B?NkxQWElEeHBHTmFUVmNiRHpEKzZNVXhxQkxuL3JvRXd5QzBBeE1Gbi90TENC?=
 =?utf-8?B?MmRONFZZWEJidktISGc4SDZkUG1JbFdBam1aOTlDR25BeXBwWnk1RzZvQUhX?=
 =?utf-8?B?QnZNWkpnNGNDTUZjWVBYcS9YcXExL0tJbFU3aml4SWkweUEyeVIxaHpiT1Nk?=
 =?utf-8?B?K1k3WnBWSEZWb1pOZ0ppWjBWdkZ1anNKWE11aVZnbHJlZmRYRjdoWFlMWkVS?=
 =?utf-8?B?UHg1dEd5Q21WTy9WeVV6WWV0U01jeHIxZVhQZTVFZTY3WmhzRnFSN2l5UU1P?=
 =?utf-8?B?ajJ2RVZOcEJpOUY4R3VZWHlBZzNIYTAzMGhaMXU5emk0UVhDeGt4bnZQZGVX?=
 =?utf-8?Q?LA5wtfhc6rNs9coWYk2THi4TEkcqiY=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(35042699022)(376014)(82310400026)(14060799003)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 10:35:24.4626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b267a2-1367-42d1-5945-08dd5c9a9a99
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5998

Hi, Suzuki

> Unfortunately, this still doesn't cover the current coresight next branch. I
> get build errors as below :
>
> "[PATCH] coresight-tmc: change tmc_drvdata spinlock's type to" has style
> problems, please review. This is because, we merged the coresight panic
> trace support in the coresight next, on 21st Feb.
>
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>   CALL    scripts/checksyscalls.sh
>   CC [M]  drivers/hwtracing/coresight/coresight-tmc-core.o
>   CC [M]  drivers/hwtracing/coresight/coresight-tmc-etf.o
>   CC [M]  drivers/hwtracing/coresight/coresight-tmc-etr.o
>   CC [M]  drivers/hwtracing/coresight/coresight-catu.o
> In file included from ./include/linux/mmzone.h:8,
>                  from ./include/linux/gfp.h:7,
>                  from ./include/linux/slab.h:16,
>                  from ./include/linux/resource_ext.h:11,
>                  from ./include/linux/acpi.h:13,
>                  from drivers/hwtracing/coresight/coresight-tmc-core.c:7:
> drivers/hwtracing/coresight/coresight-tmc-core.c: In function
> ‘tmc_crashdata_open’:
> drivers/hwtracing/coresight/coresight-tmc-core.c:361:20: error: passing
> argument 1 of ‘spinlock_check’ from incompatible pointer type
> [-Werror=incompatible-pointer-types]
>   361 |  spin_lock_irqsave(&drvdata->spinlock, flags);
>       |                    ^~~~~~~~~~~~~~~~~~
>       |                    |
>       |                    raw_spinlock_t * {aka struct raw_spinlock *}
> ./include/linux/spinlock.h:244:34: note: in definition of macro
> ‘raw_spin_lock_irqsave’
>   244 |   flags = _raw_spin_lock_irqsave(lock); \
>       |                                  ^~~~
> drivers/hwtracing/coresight/coresight-tmc-core.c:361:2: note: in expansion
> of macro ‘spin_lock_irqsave’
>   361 |  spin_lock_irqsave(&drvdata->spinlock, flags);
>       |  ^~~~~~~~~~~~~~~~~
> In file included from ./include/linux/mmzone.h:8,
>                  from ./include/linux/gfp.h:7,
>                  from ./include/linux/slab.h:16,
>                  from ./include/linux/resource_ext.h:11,
>                  from ./include/linux/acpi.h:13,
>                  from drivers/hwtracing/coresight/coresight-tmc-core.c:7:
> ./include/linux/spinlock.h:324:67: note: expected ‘spinlock_t *’ {aka
> ‘struct spinlock *’} but argument is of type ‘raw_spinlock_t *’ {aka ‘struct
> raw_spinlock *’}
>   324 | static __always_inline raw_spinlock_t *spinlock_check(spinlock_t
> *lock)

Sorry! I'll rework again for this. thanks!


