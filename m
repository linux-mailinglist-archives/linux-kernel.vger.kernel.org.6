Return-Path: <linux-kernel+bounces-171693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6A98BE765
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671D21F235FF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2915A165FDE;
	Tue,  7 May 2024 15:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hzn94hTs"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDC01635BD;
	Tue,  7 May 2024 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715095631; cv=fail; b=mw8pBSUobtbn7V12nZAG2sb5zm+Fg5p4TxR8Yn5JGoaw6jloijk5pjSjcBhhT08RjjfaMz68uxgcm57iCsa6tNX+5csxNjJux7F0DO0RjTqzmosRheJGQ2QQ7/PzmOoZmGKPjadEdRKNycbd4DLsTrreoby3JC2FMOERrF7xwKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715095631; c=relaxed/simple;
	bh=Se/QtYFyGUXIP2ClMf1v2IXTHQJRK+EKqEVHx/+sKTE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aMREaGtgYprfb/Ff6f0aJP4lK97UfXHD6tF+poP1uc2TJ3Y56Te907SQERyzUGwEx7GnySyKZYg2SFBse5oV2dkgy2/lODbSuXfDERIsDqoVmByMfGIaoj8FJwPD0yy11JRbZRP34QiisYmS86q32vhTPR/D/SqUvCoEvT6LMH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hzn94hTs; arc=fail smtp.client-ip=40.107.7.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2H69TVf6nI0n/D7PaG3y9YuTc2NCC08X+k7OHiCMZHk0d4MJjZD1DJ2HS/Vqt63+mMfCsa3Bg098we8M0PFebt4Fmk87GITZqVnRejK1uW5EfNz9XK+SeVsG+Y4PPzuV9AbKJhxPYyk32u6MdnBzmMZfRvYpYL5mMAcinj1B/7KHaDbk4HsL5zc7P+ja1JaLhgsLCB/CNvsY08H1Dp8kl6BkgoWCKf2WzAq8AJI4+xLMV5OQpMVVoSUl9/Plq+kEuy9M4P6h7nvI+8IzmaZmuN6WGB5qGgGkhi3TDHEWEXCf93CCKxu2fOZIRPsLCqyGtlNtM7V3gf2kh+XIvyicw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAp3vkdMcBldGCIqTt43Rw1xzhFks1J3RCl94yeS5MQ=;
 b=SNjq1Rr7GHU2gUnO00+xtZ9Dho4tMQRZc3CW2tpqWDmIIrYHpemTs8GYS1C3S8FpUU2eJHrBTyuzI+B4Ypkq7BBZ2QFcPw+uhh3gxJlAGVLdtzrPLiuHGvbH+zhVDoEYTDs+YvKsMgdDNGhjpMPnWF1d7v6y+o/hw74F/1vvl43mCC6lTlXwSGE78Q9sImKdDFUqg9rEPFsdopQhk5W8TzjV5o3mCD5YjHrqtswdZJ04oDZ1dK+rSYZEGJrMeTDpIc85UT0/1QJVXh5BnKcdsNsU+UTarV+jOiCK6+V+qIEtw2j5NdGPIfMCge2AlmkbgcEto2IcgS45V1GxX/3H9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAp3vkdMcBldGCIqTt43Rw1xzhFks1J3RCl94yeS5MQ=;
 b=hzn94hTsGd9N20shwrnw2zaIBtSMPpxaidsWHmmMb9+3tWkkDakHjZRj84VMMl2gL58uKIlalL/utqDP7ZkTLxZEZs48Gq8mQExnVJzkn9CY0P82CGL7dIR6uRprQHo15cNo/kfjSd7TYAtdHvKMIelRbR4zoP7oxusCQHy0k/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB9014.eurprd04.prod.outlook.com (2603:10a6:20b:430::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 15:27:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 15:27:05 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 07 May 2024 23:35:00 +0800
Subject: [PATCH 1/2] dt-bindings: firmware: arm,scmi: Support notification
 completion channel
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-scmi-notify-v1-1-1fdefc984d53@nxp.com>
References: <20240507-scmi-notify-v1-0-1fdefc984d53@nxp.com>
In-Reply-To: <20240507-scmi-notify-v1-0-1fdefc984d53@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715096110; l=2485;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=ZD6kTC1LKyAdyC7MdJ92p2toAQCDTFJKKmtOf1wMmI8=;
 b=FEhFyMWsu5SbxyF05GBwh5OLzi5juPjF+FYtq7IIz2QtB0IfMeyl10bV4EBRPb+3PqCx+nict
 E5HHep4yw7ZB3UAjMlvX1ilrZDiex7tlie8C9FJMY/KHUUR9vZXcGz7
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB9014:EE_
X-MS-Office365-Filtering-Correlation-Id: 305786df-0d4a-40af-fa32-08dc6eaa26c0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2lKclA1aUxJbzJNSmlucGJQYWJVUmZTSnp6NXliWDJtZWUzUjNGRjZDNDY1?=
 =?utf-8?B?RzZycjV0ZU42STUzTTRJQkhmcUdzc00waHJVY1VoNHJWZTBSeTZyVlZaVllo?=
 =?utf-8?B?VlF1R2ZQZjRyUjZjOEZxNWMya0EwTzJ3cXdSZTAyVkdhRnZ6WjFqY0NOL0tJ?=
 =?utf-8?B?bEtlRE83VHNjNUtJSnl2SGdMckVnK3lxU2U4Rk9MK3REQVRuaUdsUDAvUUNC?=
 =?utf-8?B?eDJXSWZWRHFHYVRrbFNKUm1YRUl4MjdTdkd6a1Q5V3ZtSFVrVzYzWmUvVHFt?=
 =?utf-8?B?VnZyclpUMzZhU3JlWnVSMUkycHU5Nm96QnVXZUJMaVM5aU44RlUwN1kxWm9F?=
 =?utf-8?B?MlNoUTZ6a1l1S0lxTDR4aFhSWHhSQ3ZlMW9TT2pGVVFKcUtOT0liT0g1NEMz?=
 =?utf-8?B?RnAvMEZVbWlEa0JpZ2gxMlMyKzZmd09rTko3eFR2V2U0YXRFV2JEd3ZmUnR6?=
 =?utf-8?B?Z1VJb3VGdTRGZWxyeHh3b0Q3NUY4bTRiNnVzLzhma1ZnTjNYckJOekszQ3d5?=
 =?utf-8?B?aGh6YjVTOVNqWXRxUDg2WEFpV1hRSUprYVRVSkZhVnNWN1ZZbXRzTGFSR2Ir?=
 =?utf-8?B?eEJod1VQR0JOT3Mrdno5VEdxV3l3MHZxcE42Q2VNNUV6UURUME5iL3FpMith?=
 =?utf-8?B?WWJNUDlabWZMNTJ6WmkwMnhwa2czTUNmU3ArS2tqMEZaZlMxR2kvOGZEY2oy?=
 =?utf-8?B?OVZLTWRyUFhvakJpUjhzVkV5TU9ka0V3dHlLb3pYbGwzcjl3TXhNQVJmYlBC?=
 =?utf-8?B?b3piblVZZEh4RmJ1MU8rQnpNZ0NnUnJaV3NmT0FjY1VRb1pOaFVYUitlNEpH?=
 =?utf-8?B?ekNlby9pSExQRjh6MTQzQWU4QUtLbEhjbGZKLzZzQUNnNGJDVHVmaUxtc3lM?=
 =?utf-8?B?aVJ1bnhFZ1ZwYnRTNEdZaWlUT2lNZkpVZE53c1NrbldnQy9uMENaVjFFVTBh?=
 =?utf-8?B?Qm0yVHVkRWxVOSt0d3VGc0VhZmEyK2RFWm9hcWZHVDlxYXBaczRJUW04T2VX?=
 =?utf-8?B?V3R0c0VuZG9NSHRsMXVwZ1FvNFRseXp5QnZtdzc0T0h4MG44dmRVaHlsWDh5?=
 =?utf-8?B?U24rNzJqRXZGd1BxbjF2VE1ITE9PdVB6L2d1cTQ3L2R3MUNWdVVCL0ZqSmJY?=
 =?utf-8?B?dzRxTDBWdmpuaWF6ZUJSTlkzNU4welFaNDhGSjNLQ1MyT1pwT09HL09jOUFu?=
 =?utf-8?B?Y29tVUJSc3VsZUpOTGllYWxnR3B5TUQxT3RJRGRXdk84YVRWQVg1dXR1S2Zh?=
 =?utf-8?B?TVhZL3dJb1FTNUM4c2VsTXlVOUlyZUp1TXpDUUt5NG5lR3FIdi9BdDhtU0Ru?=
 =?utf-8?B?TkNsSXdBdmUyK3hqNzZwS0hQeklOblF0Rm1VVGw4ak82SGNQcnFEdWFqaDFk?=
 =?utf-8?B?c0w1TnkxbkpvemdpN1hURmRWTWxITjFGVjVIbmwxVHBnb0xkMSttR3JVd2tI?=
 =?utf-8?B?Z215aGk4cnR5ZktvTWdka0RZRlMwSXUrNzVwU2E3THVTbGZwQ2hsZVluRkpE?=
 =?utf-8?B?WEpwb0p5OXhxMlYyMkFEVzNzSjBXck1VNVF6T3dwTGltSDhPNWY4MGdZR0py?=
 =?utf-8?B?d2VEbWVJTnJQVm9DRi9CZzhEdVJKTEZOa29YenROWXpFQjBlaWR0Y0tKWFFr?=
 =?utf-8?B?U0JhK29UUGtMYmUwN2FINDlmOXV3cVVNSW1BcGkwRHI3L1JjQ3V4QmZkK0g0?=
 =?utf-8?B?T3p4MlBOVUcvc3R0ZVYvYTQyOXN4VHdybGVxaUJ0Z29VL3g2WjhpUFNiMDhF?=
 =?utf-8?B?NVJrZjB5bzJIVy90L1VLeWNySXNKODlyQlhZMUoxMkdOMGR5S0VscG9oejJN?=
 =?utf-8?B?Z1Rac3o4ektDV29IelZhdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bW45ZVJJVHk1Wi9JcFVOc1ZOd2xaN0FsQTZIcW1nWjExZWlZZ002Qkt6SlU2?=
 =?utf-8?B?a0Q5MndDbDB3RE9NbE9VckxkVGJjM25JL29yeXlTLzBabm9qZDNtVEcybm8v?=
 =?utf-8?B?ckh5SjI3Y3QrdWQ0bytYMUtsaFdySjZxMmwxcHlrZi9sckw1d1VEcWdUSS9U?=
 =?utf-8?B?Q2VLL0JZWmR6dlVzN2wxMXRXUXpVa1RuQ0hxQ1ZlbXQ3SFdyRUwvZDVYTWZI?=
 =?utf-8?B?cWR0c1dJL1dIUG5rcUpMb2c3ZU9LY0RZUzRjaEZKbW1BS1JkT2FoMjlJaHJm?=
 =?utf-8?B?ZXd3VWwxdktOR0ZjQms2c0dsdXhQZGYwSnQ4NWNCSGwvSFhtM09pTEUwZHht?=
 =?utf-8?B?SFhuYlRlQ2UxWFpuLzJqUW0yV3BzTFRuT2taYXlHbGJMeHdFYXdyWWx0K3FF?=
 =?utf-8?B?M2RkczJZMSs0UFV1UGZvbDI1MXQ4Z28xK1VCTEFSUWFxb0dlODZUaGZSUjdZ?=
 =?utf-8?B?eHR4RDBqNGl5MzFVa1FIaFhxZkxMY1pZa0JMT2ZPelRoSG00ZzJ5ZWFTVFVK?=
 =?utf-8?B?cGdIdWdNNTkzenRGWmVFbzlvWmdqU1pXWFF0WW45a2RnL0NCalZPZVFkbytS?=
 =?utf-8?B?MTlycmZoRFMvSmNtRjBXVjhQM3dGVmFTVkdvc1VDaGQwdHZkQ3hGRmpYRVJQ?=
 =?utf-8?B?WnZId0NsYTJadkFLZ2xZUmthUm5wUUsycXErdndJM1B4bnVpWkw5TUpLeGNk?=
 =?utf-8?B?ZWllMjZrTS9xV25DUkF0c1phancyd0xvN253QUhDV09Ca0paOFVBZXZBYzA3?=
 =?utf-8?B?SWpGd2JIY0VPdm00eE8rOWluakxDdUVob0xDZTVJWnEzY2haQkt6N2JUY21Q?=
 =?utf-8?B?RHNpRnVOZkdmMEVUU1A5R3kyZ2Fma1JLTDVEVHA0QVJRd3RzWUFlZ1FxSXhz?=
 =?utf-8?B?UkU3ZDhaZ3BlZTRpSXVwbUtvdElyU3FEZ2FKQW05ZElna0V2d0lmVTFvV0RK?=
 =?utf-8?B?aWRDKytJeTlNUW8wRWN1b01maWRFOURlMmo0NDhhZlFUSklhZnpoWW96bnRX?=
 =?utf-8?B?RGFHUkFBZEFyZ21HTXpIWG5uL09XTVRSUTlFdUFpZFN3MjZJNXNWblAyWFR4?=
 =?utf-8?B?QXVQdzFtZi9aZDdsbEhTRE1VeUJoOXJsc2pGMnI0Y0lRM2F6TW1Ecmg5QlZy?=
 =?utf-8?B?SE5vUi9vT0JKQ0pIc3R4Wi94RmJiOENMcGdoekJocmxFbnp0Nm9XVC9OeTNV?=
 =?utf-8?B?K3VWUFhuREs1d1lsdHFSNmE0YTZnNEpZY1diMDk2WEVFbEdSNUlBZ3hublBC?=
 =?utf-8?B?RFZWM0RjNFhGUjZVNHFCcHkzOFE2OTdnNi95b2lRRGtsa3h1UGhLaTRQREJH?=
 =?utf-8?B?ZUJoTTdmMGVrbFYzdjVEb1VsTmk0d2N3Ukc2RDYvMFBkWFlEU0FuREtRU0Nn?=
 =?utf-8?B?dk4vaVV0ZS9kS1pvbG5FejRKbHNjV3k2aG9DeHAzQXFMemRtYjlVRmE5aDgz?=
 =?utf-8?B?ZGkxR2IzNVp6OHNvNXpXMVRYclFvcGFGWHZWODZXbHlzWC9BQnZkS0gyVGUx?=
 =?utf-8?B?bmRoeklIK3Yyb3F0c2gxV0VHYTZiYnpYU2JkV2NwRm5GajkwR1E1WGc5TTJj?=
 =?utf-8?B?bUJCMXdqOG9EbkNSMTdPL1J1SlJCUitBSXVTdTNhZWhNRmp4OU9lNW5nWFA1?=
 =?utf-8?B?aHRrS2NaTFNyb0Z6TGJvcnJKWWgzcmZIT3pFY09uajBQd2tJQjZQalF6WFE5?=
 =?utf-8?B?MjcwV3NsUUJwbnNTeUM2MkpaRk9NdWxBaUVnSEJUNENvbTFHNHJXYkJqekY2?=
 =?utf-8?B?Yk9xSHhOcXh3a0lWczVCMGJmaFVVRE54WTVWSjJ2LzBhbllzempGeSt1WjJx?=
 =?utf-8?B?eXEzeTlRcGZHbjNVZGY3aXFKK0xpMTFXL1dscngyQmwrbHNaZk4yWTkxbHJH?=
 =?utf-8?B?Z1o2blM0RjNQUTZTQ1FrcXBjdzV5WjEzTUV0Um1Ec2VTS3dzdlE2YS9YVVVq?=
 =?utf-8?B?dUYvaE0wb09SdGxVQ3ZQaGpGNE9aL3gvSkdqdTFZcWQ3ODRxM1c5MzlRVkp0?=
 =?utf-8?B?eE9VMWdSQWV3TVRmS05jVm9BZVU2MHZHdzh3enRlNWNZQ29IL2N3K29yM09h?=
 =?utf-8?B?RXlCQnJWbEpFQWkrUEs3ODhNVTFCRGQvRjY3V2N0cTZlV1VFTGwzNTBVY3BF?=
 =?utf-8?Q?35AYNXBYYQtZUh2HXZ3RhqHMo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305786df-0d4a-40af-fa32-08dc6eaa26c0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 15:27:05.4947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwyR6QyGJKyaDwMsFcc7m3fkI1Fie+uZXEDuuWm/McebDxO0jrUQ96QUDDEu4GOk1tm07V1yDcSITijX9fZOjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9014

From: Peng Fan <peng.fan@nxp.com>

Per System Control Management Interface specification:
" Completion interrupts:This transport supports polling or interrupt driven
  modes of communication. In interrupt mode, when the callee completes
  processing a message, it raises an interrupt to the caller. Hardware
  support for completion interrupts is optional."
So add an optional mailbox channel for notification completion interrupts.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 7de2c29606e5..308af58180d1 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -72,14 +72,17 @@ properties:
           - const: tx
           - const: tx_reply
           - const: rx
+          - const: rx_reply
         minItems: 2
 
   mboxes:
     description:
       List of phandle and mailbox channel specifiers. It should contain
-      exactly one, two or three mailboxes; the first one or two for transmitting
-      messages ("tx") and another optional ("rx") for receiving notifications
-      and delayed responses, if supported by the platform.
+      exactly one, two, three or four mailboxes; the first one or two for
+      transmitting messages ("tx") and another optional ("rx") for receiving
+      notifications and delayed responses, if supported by the platform.
+      The optional ("rx_reply") is for notifications completion interrupt,
+      if supported by the platform.
       The number of mailboxes needed for transmitting messages depends on the
       type of channels exposed by the specific underlying mailbox controller;
       one single channel descriptor is enough if such channel is bidirectional,
@@ -92,9 +95,10 @@ properties:
        2 mbox / 2 shmem => SCMI TX and RX over 2 mailbox bidirectional channels
        2 mbox / 1 shmem => SCMI TX over 2 mailbox unidirectional channels
        3 mbox / 2 shmem => SCMI TX and RX over 3 mailbox unidirectional channels
+       4 mbox / 2 shmem => SCMI TX and RX over 4 mailbox unidirectional channels
       Any other combination of mboxes and shmem is invalid.
     minItems: 1
-    maxItems: 3
+    maxItems: 4
 
   shmem:
     description:

-- 
2.37.1


