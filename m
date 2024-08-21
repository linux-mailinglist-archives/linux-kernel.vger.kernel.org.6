Return-Path: <linux-kernel+bounces-295893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89D795A2A5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE27E1C20BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A9B18E353;
	Wed, 21 Aug 2024 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ggEKUW9r"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2064.outbound.protection.outlook.com [40.107.103.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B57154448;
	Wed, 21 Aug 2024 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257193; cv=fail; b=rQgyMl7VDeOo05buuU6T1m73v3ewapSXw5/TnZUxIvKYOwI+bkPz+VhOokRxfEvRGf2827L2Kzi26xYAG4tnG7HtTL8UJSyK7/fi0BvsH2ZvIkiz/pH4s6hY9bXkvkYvGc9ciFdhMrFPYQacQF2dt8FmYYnvcMXGFO8Y4B9/tmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257193; c=relaxed/simple;
	bh=OPMEgo/PPVAH3sDsMsvf6tFyCZJh0Wh9SpXjFlyjVQQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=F2oA1F+LBf4yIUEZZzm6FpRNiPBIGwMmDdBRF3q/8S9DuH7Wlj8akOXHLg6oghUzhYY3W/DmXZkriaXUPiOl27HVTMkXhCo84VfhyByGmoXBUFYS39MRhIxKFmQ4uJZux3OPmpMHnEiWGU/SLjWQS9iKWwWbKbozp2rNU5ajwZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ggEKUW9r; arc=fail smtp.client-ip=40.107.103.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/bSyYjQOw3F7ugv2fsB3Je9vHKckd3wuOnEpvGEYZvwVO9P+R78G3QCo7pthx0BBa5oY6KAk/rT/ZuAbWeAMXCUyacRRhfLUfIHFKJfKxfwaK/NHwbG98Wkl/HJIGtimgkevIpb5vLUCOS8Xwu8NccxbFyXwysLK431eQIg3ZzEE3urxLtkKPM6xAzYZG9FBZgpcFa4n5peVdt4h0+QaFOQHs7toudEeyqHq2jS1m1DHcwYgkDXrleIa4K3/yEzZwoMFsZakAoESESSQh27zvFOa6XXuGjacc7wFc/6Hj80K2qfsAH7clSQPFtDQq5xyQKNnADrfeRoxk4ra0+zkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FGgaU9IlyBHq49XF9k5+aS5ZI1cv/6PvMPvqC36+xQ=;
 b=gF0b9ki8rogLA0yFdITLTV+hrAhOchtJq4A10IVIo3aRh9o15BNb3PosKQUVrJZ3AvMKR0Lo7TD9Y+jmRuQp+Toh14C2B/UoXbMxmhSkyOND3jczOIVm6OhWM5XwiA61VZ3JIyjbE13yyyIaucvLWUmgtYcDD4wQWSfa+iclL8YJiTJFVgaUvlFZa+9uwnXXxNTxL3iO9LVzwJAuIR7iKoZzryqBMjf9kf+/SDrIrxe+yqcFCc9mPFfVFUKxZKs9F99Ntotd2NosRQGo3RH93Sv/GPqK/wsRmhRzPlUb1ciY6Hon8qGu/oqpFJcVwrFb8Avo55lKJ2qhq3r+wvZXeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FGgaU9IlyBHq49XF9k5+aS5ZI1cv/6PvMPvqC36+xQ=;
 b=ggEKUW9r+7eWYa5uMZ7ICKPgiiw+ehLIDVo8v9AbDejz7x0zytmBd+X43mJWT9zPRIIC7cKPlDPs8YRVQJPZToTYni2Qk+7EnsgB3P0NeC6dYtL1sgVIRGgrTSqO6DsiivkcPedXzGZ0aTRQXZyeYr+3BHhZ9iiraObJYowvUt0voziM5hVZTzFNxSfwU6X6LomEA4pUjj/bKqkqW9XgIqNEqTDB+W20J1/rwbwnetJFJ5iGy6we7Zmso1WurYsBhMGZClmDMKZxqGps+NAn3HgF6+beT9UaqtDnOsQw86mG5DT16Djn7CFScegmQbW/LqDWeSU6IQajgGvXE89Zxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7817.eurprd04.prod.outlook.com (2603:10a6:10:1ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 16:19:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 16:19:47 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 21 Aug 2024 12:19:06 -0400
Subject: [PATCH v2 1/3] usb: host: xhci-plat: Parse xhci-missing_cas_quirk
 and apply quirk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-dwc-mp-v2-1-2a29b6a5c2f4@nxp.com>
References: <20240821-dwc-mp-v2-0-2a29b6a5c2f4@nxp.com>
In-Reply-To: <20240821-dwc-mp-v2-0-2a29b6a5c2f4@nxp.com>
To: Mathias Nyman <mathias.nyman@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, jun.li@nxp.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724257180; l=1035;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=OPMEgo/PPVAH3sDsMsvf6tFyCZJh0Wh9SpXjFlyjVQQ=;
 b=U/RIjK5IEkCCwOPuwn+ywxACeFcbVon65zQ/AxPGLsaRlOI7Jut9qdCMlbq5o573ig88TaACv
 nL7p5+lOWoEBxhzo8709ijoD8uGS9TVKhtjc9ZvafBwEB0JJZ4meQsa
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0056.namprd08.prod.outlook.com
 (2603:10b6:a03:117::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c643d6-c646-4ba1-9c97-08dcc1fd1337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXVGVnVaNWh0bmFWZHoyTm5tZWRDOFZ1R2RNaitocXJDbUoybnZrM04wMjE5?=
 =?utf-8?B?RkpJQ0o0RkV2YjNZTU8wUlBWTmNJejJzL0oydTl5TVI0RHF5Y21BeDlxalVS?=
 =?utf-8?B?dkZNUDl2SHM3R1RoWklUSmZmdTloNEZ3Y1FUK2NPNUg4Vnovam05WkI4UXc0?=
 =?utf-8?B?cUNJYWFoTDRjYzBxdWx2R0ROZ2UwaWtsRmJrbGFqMmpqYkd5NUZ5S1RFSHRq?=
 =?utf-8?B?RVZ2bTJCc3pSVU0rNzgzdStKMnlaaWxINlVyNkQwMnFlZjF5eDk5c1J2N1pp?=
 =?utf-8?B?NXFsY1hTKzk5ajRIdTFDS1d3cjlNZXRHSEtIY0lvTHNhOTNZY2tyZXZHRWdO?=
 =?utf-8?B?cnBCeVlEWU1Ib3JjRW4zR3A5bE1aaW56bzVLamh4Um1lbmVvbHIxY2c5bkVD?=
 =?utf-8?B?RkJYbDNkSnUvQ3FyMTkySzE5eTVnLzRENzUrQitQSitRSFpyVlIyL2FDWEl2?=
 =?utf-8?B?UW9PN1dTRlMxY3BmNHRTMVRHOVErYkF4VHZyWXhOSnA4QUJxNkhZbzNOekYr?=
 =?utf-8?B?bWg2cHBaODlXVHo2eHVSaFNrN0Y4Mm1HdmdPUlJQQXlISGJNVXA5TnZWK1k1?=
 =?utf-8?B?SlIxQS9BNStIdS9IN21sb2JIVTkzdWl0bTBPL21ETjRDOHF4ZGxMSXlMOXJS?=
 =?utf-8?B?YXlzV0xCVGl3TktkTExLNXlRd2FvdUxNTVhmMlBqd2N4aUI4S21XS0twK2s3?=
 =?utf-8?B?bGdhQmNubytiWE1XY0lwT3RXK3I0c09SajdzczVKUXNnc0FJZW5nMXc3VWxI?=
 =?utf-8?B?WlMwMkkyWDJNMzhnQ2R1eUkrK01DSnhySW1RVU5KNHkrK29WVHdybm1lNXFY?=
 =?utf-8?B?M2hpZnRzVDVMVkI5UGNqczFYTlY0WnltbjVVZFU0U21SSkxNa2hnVlJSdUdM?=
 =?utf-8?B?bHdaZlBoNk5TSm0xL2V1WVdwWXN4Y1pMaHpSTllTNC9RN2VpYUZIYmFPQkpv?=
 =?utf-8?B?MkxOYTAwZHBUWWxtSzBMMisrM2tCRGJ2bjVtT2RWTUhyN3ltVGIxUlRPS2hm?=
 =?utf-8?B?Vzlwa0lYVUlWYnYzdWZsc2JocGtUQjRxVU16MlR0Y1BvNS9UNGlvVGV1aU5P?=
 =?utf-8?B?dWpWdW9FdExsYTYyajFJQmpUYkJENGVtYVpDMis4Z0xCS1huZnIxYWQxdzBs?=
 =?utf-8?B?NklPZnB0a3R2T1FJKzhXUzlxOHR1Z1ZrTU9haE1JT04vVFV2SUE3L0xVQzJK?=
 =?utf-8?B?K0ltVXpodkJUVEx4YmFHQW9XYzV6QjUxWnFodTd6L0NMSStrQ0dyZXVGOGla?=
 =?utf-8?B?UUpkMUNYa1V6Y0VOOHR4THhiSGNwR1dDOFhyNHFtZnUzVm9ncVFaMHp2cG13?=
 =?utf-8?B?SHJnYWdFNVRKYnJQNGROV1J0TkdST3ZIcFFadGtWOGtEUnV1VDF6NkdvcW5k?=
 =?utf-8?B?LzlPdy9tOGFmakZXa1p2a2c0c1krazM3Nmwzd05iS1Y2NDJxcDVQdVB3ZjZS?=
 =?utf-8?B?dU5ncmFRSUVnSFloWXdnRW5QUFNBYWEwWEVnWEpsYjBYeEEwQVlRS1BwY1N1?=
 =?utf-8?B?czh6Q3MwU0NNZzRHUDRhd0ZiMVZnemY4a3NhZlJJbDRlWnlScEdaaFhVblZS?=
 =?utf-8?B?YUllYkhmVVVqbWJuQzY4SVVYT21qelhXNzBDNG8zWjZUL0Ixc1gybjlRTzRN?=
 =?utf-8?B?TjlwNVJ4Qm9RSGp6dHJxdGRuYkIzRTlWSmthVjByWUx3dnlvOGcyZVRBRXd3?=
 =?utf-8?B?cEt2d2tBMU5tdFV3dFAzT2Q1a0hLZWY2bkgvYWVsOXlLOXJld1VXNXJOVUVv?=
 =?utf-8?B?SDMvMkZVY2YxTXBhcVNaOXB5c1p6ZjRRaytWNEQ1R0UyRXgxc3ZsNWtlZGVk?=
 =?utf-8?B?Wlk3WVdiQTJWbnRWOGhpOUFDME5ZY1JWVTlCU2hMQ1Y2dkRGRzRKa0pIR21P?=
 =?utf-8?B?cCtPS0xlNGtNaW1Ob1YyWERnNU5UOEpkUnppUkdOOUNFRFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UU44dUhndDl3QTA5bGYyTEF4RHdNM1RRRzZYQlVnUjhZREVDV3pLcDMwYmZ2?=
 =?utf-8?B?QVVKTVdtYUZTcFJMZ0xUQ0pndTZOa3pPMzVnNVFpRjZ1ZkxQUUZTMGdLMkcr?=
 =?utf-8?B?YXlYK21JNTFjZjBpYnZFOUtwaVNlVUdtSHByd3B4Um1RQnFLV1VRbit5aFB2?=
 =?utf-8?B?WnNxaTJjWVh6MWppOEtXa0tsWWU3bHh3TE5mQi9TMEluZlpVZGRIWjR4MEl3?=
 =?utf-8?B?dWxtWGFrL3g1WVkrY1Q2SFlyL1doUlJ3YXEwRU9xK3JGV2lnKytZWGdNT3NI?=
 =?utf-8?B?QStRMEtzekxySFlXMzVkMTFKMzh1dndObjBBbzZFYmdUUnZjQU9qSG41b2Na?=
 =?utf-8?B?OFV5a1F4WTgzT0I1M3c2VkFXdExDV0hrM3Vlb3NtQXBoYzk1eHdVY1JVTG1C?=
 =?utf-8?B?NWsraWRQNzdMVTF6emRSenowTGpzVnJNWnh2TE1SYzB5aDAyS3hUeEQ1V2FT?=
 =?utf-8?B?djJpaXdEczk5dlRaanU0M2x1UEJlVFVldWxmS0Y1MjlueWZQZnRybW9FQjM5?=
 =?utf-8?B?dU9tS2M1Z2crRGVwSS96d21zUlVucjRBak8vbjZVbWo5anliNWxuQ3I0dm9V?=
 =?utf-8?B?S1UxS3N6Tm9rdGxxS0IrdTN4Y29sQm9adVRlenV0TXhEaHV4TDRqUE1uRXZu?=
 =?utf-8?B?Vi8yVEx5aDdCYkk5alc4RDBWVDFGWDd6NXJoWGhNSUZxRXByUHFENHdXQ25i?=
 =?utf-8?B?VW5MalRFd0dqczF1Z3dVOTFVNHN5Y3VZSnhtMCt3NDdGK3F6S0VPRmI0bUtY?=
 =?utf-8?B?R0RWQmw0M1JWNlUvZHJtU3BFSWk5ckZHamo0ZWVsQWp4VzFRMlhUTGFzSTht?=
 =?utf-8?B?OG9SVS9EMDNaQnRobkJuZWtOWGZuOTZGMjNJSkJSYVNXYWJqQUoxNEdmeXp1?=
 =?utf-8?B?eWJQNEhVUUxqdHA4TlJMblJIRnNHa05jU1pGa1htNWlrMGJYaTdtZzFwRDZu?=
 =?utf-8?B?clZoRHZDdjhNdzRjd1Z0VzNvT0w4UWtETUJxTHdwTk9hWWZDUzNvNjVYQVBx?=
 =?utf-8?B?K0hoZXJxdzc1RGtWeVVTWmtscEtxSG45RVhycThZekpEOUJ6aE5FMEliNlA3?=
 =?utf-8?B?OHVPbWNFRjNvVnp4MjJCWlRzUUc1SjVFUnhqWERxV0J6MTFxNXJZL3VQZStM?=
 =?utf-8?B?UjhVOHY3NCtMcTFZQ1VvWGZoemtEZlIxekRIN0dvNy9obXBwVXc0cVA3bWh2?=
 =?utf-8?B?TmpwcUZGVW14eDZWb2Y0TkpPWXkweklURksvVGpvcWtjYWpJTzlVUmJQWjZp?=
 =?utf-8?B?SWY5WFlJcUxwekRwMC8xN2d0OEFkZWQ5K1RtNFJNOEthQ1BrbUIxTzN6SGdv?=
 =?utf-8?B?bm1VbSthd2I1cU5LWEx6UW1qeE9DNlA0TGFwd2xjYjRDRzI3akV1L29STGxB?=
 =?utf-8?B?K01sb2RXdHU0VklTYWdjSCtpTnp5U3JkQUtFaUtMTjBsTXM1Q1ptWDl5bDdC?=
 =?utf-8?B?K0wzOXNoSWpvb2E0WXJnWVpkK0xwRTJJZnp1d1BBbFd5d0F6RGwyQU5sUExj?=
 =?utf-8?B?djlQWWlLVFlQcVZDazN3SjlycGdhbEZRSXUzeG1EWlYxcVZ2RGRYRWg1Vkxt?=
 =?utf-8?B?QUc2bjVxRnp3U0tQcmFOSDVhbWdvTTBvampFdlByZzU3S2JnR052Zm9UT3Nh?=
 =?utf-8?B?ek0wMGt0Z0YzZm10ZXYwMWpiTHJ2aXNjT1ljU0xQbk1IUS9zR29icGlEQ1RZ?=
 =?utf-8?B?WjVXSXNLek9PSlFzcXZwb1Y3eWYzcmsrSzJGNkpSNHNFbTdUdUJGVE9sRmwv?=
 =?utf-8?B?TFFhYWN5djdqWjJ1ZHJ1T282UFBOdUpJWDY2V05TQ0lMN0FQM1czaDJuWUpl?=
 =?utf-8?B?ZVJicC9LZUpHeEYxK285MnBkME5Bak8wMTMzYi9yR2tJTU9IQVM2aGdJaTQ2?=
 =?utf-8?B?SkJmaUhWT3lhWlMrL2gzOHNjYnZXWU1wODY2R2I3RE8yQjF4cnRENHpYRGxl?=
 =?utf-8?B?Q2U5VW9nZTQzRm92ZGdWNE4xSUVLcTdiU1hmdGpqdEpsZndvUjlkTnNIVEpp?=
 =?utf-8?B?bStISTJsV3hqS1l5VUpDMkJWSG1VWnk2S2kyRGpyZUtzRW5DcFg5TDU1U2xR?=
 =?utf-8?B?dXVpZVZhc01YL1E2cDdtYk9sZHFkaFMvaUdINHVTdVhMcXdMTzNHK25zZm0y?=
 =?utf-8?Q?rtPI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c643d6-c646-4ba1-9c97-08dcc1fd1337
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 16:19:47.4290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZUQ0kosiwZva2MEJqOg7gcmiwT10WT1Rd6W3zGin/LBy+k1Tf050z6juugbIX10cZVuqH2V/MnAIiUcTn0qkEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7817

Parse software managed property 'xhci-skip-phy-init-quirk' and
'xhci-skip-phy-init-quirk' to apply related quirk. It allows usb glue layer
driver apply these quirk.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/host/xhci-plat.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 31bdfa52eeb25..ecaa75718e592 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -259,6 +259,12 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 		if (device_property_read_bool(tmpdev, "write-64-hi-lo-quirk"))
 			xhci->quirks |= XHCI_WRITE_64_HI_LO;
 
+		if (device_property_read_bool(tmpdev, "xhci-missing-cas-quirk"))
+			xhci->quirks |= XHCI_MISSING_CAS;
+
+		if (device_property_read_bool(tmpdev, "xhci-skip-phy-init-quirk"))
+			xhci->quirks |= XHCI_SKIP_PHY_INIT;
+
 		device_property_read_u32(tmpdev, "imod-interval-ns",
 					 &xhci->imod_interval);
 	}

-- 
2.34.1


