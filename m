Return-Path: <linux-kernel+bounces-365431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D1799E22D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88D0AB265DC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151491DD86F;
	Tue, 15 Oct 2024 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eEFYkm0C"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2071.outbound.protection.outlook.com [40.107.247.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043851DD524;
	Tue, 15 Oct 2024 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983145; cv=fail; b=TFZWbOK3WjBGZ+3xQEWnuqSsZapwWglsYAvLwoPyyV22Tq+T4xzzJ+R6kiVEKuKMCxsEvWvItSFeYNDfq7692FwEYC2aQJVy+eeIW2TO6vRPWow6ugXqFEXMD+PSVR/DGbJNbwbJsyxgo9r+cFQPi5Orx/DNSG2ajbCtayOinl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983145; c=relaxed/simple;
	bh=c2GJVCidrhX1BXyQTcNgVT1gDrIReiQzjgNl9ktmYns=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XIlBpMARM0itrfJZb401P2AmHKptje9lTIJyXQxnJ4THqEgmtknbHMB3y55sd3DKzc3BeeHoZMkeBzgh7AHz8Ltczbx2fF2fnMEAkdNXgZBlqeLHwZYvUXke5Yxm+bjLwCbfLEKS8psJEKpBEvWep8EqpElGr57h0J1xhNk2Vzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eEFYkm0C; arc=fail smtp.client-ip=40.107.247.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crB7WX7UTD/EIIO2AtYwFXQcKzJqI8rlZc9U9EdTrmwQlQIaIStNUVbiWidGeYWpMiBirycN2K75iqGs26EdntQWO3dXNN1RYJIk5EO60kWRpP5bPAKqFqwXJBi/bFMrIFNxpdWQP2B0n/CfWfxP6jTUZU8yHYw0inph9xtaMVl9Cp+2gq+R7HRYplW8O18IxWT81dez3VTgswW9uFhesrv5SRapI/CEQ3FmHYiDgiAPB/zNV+Che3kE/H7kDIVv1i1scM2a+ROE0wpQR4ACK8epTfoxLovb694kRU/UUDB1qJwCIl/4KjD/UZbe3UFS1VHNexnYUVynM1WxHJaBbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TTFyAP5yb7hZ8l7L5ej7ELeEVEO7+opRsZB4H7s0/A=;
 b=dPZWPCC/ycD4g1QvZvBvwecAv4fzpxXXPQvLdmap0qILh1yZ+R713o72m9vvnwypjF5itNKKiHrGorBL2Ii1n8OIYK+/1GIjhE+NKlIFsmmiVWw08hQudwqdA0HVFV5lnsLymn7mG8/0Lj1cQuKWXxaCr7Aq8h3MUuG7NRxR1OvRq4rSQq6sgp3sldK3E2GhwKR0zpfUcI8fU8rpUsoul7zFrGk/QmJ29uxlV+lMNlU868k5jTfoew476hlVDY8m6BQ5TyKkddUws9W6Opp7TS7rY7kbjJTW/GKg3wlBhpAMZplpWcjuiByKbsa40Yik02QyAxZue+rrR7haMGEFPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TTFyAP5yb7hZ8l7L5ej7ELeEVEO7+opRsZB4H7s0/A=;
 b=eEFYkm0CUk9UneIVFaPO5tJOpxWwktxoJxJTRbGGJnjYS0uBREODvFDD4GFcg63wuBlwOTLN4W7aEpTY2h8nE+wFSW6QC2384NX3Yz+zjsBOpF0umv5VLBvFQTgtI5akYMRXEQpu3BYeCyMpYOffuzjxuKTeQzZT494gLV8grbgHDwt+wedb+rk8yqps6XShqTxWhmvjII49pHzdftCYWX9KUljpJmI6veeYAwjOwy7qnCLCWeqMh+vlkAHOxzzcz68olINnIkTEBOZfTpocys2Wt9u5MlxXuQifv4ezVXBvt8v6TibXwnB5RyKvmiLtCrUcRy8Vdp0/uEdS8xxRfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by PA4PR04MB9223.eurprd04.prod.outlook.com (2603:10a6:102:2a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 09:05:39 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 09:05:39 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Tue, 15 Oct 2024 14:31:00 +0530
Subject: [PATCH v8 2/5] dt-bindings: arm: fsl: add imx-se-fw binding doc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-imx-se-if-v8-2-915438e267d3@nxp.com>
References: <20241015-imx-se-if-v8-0-915438e267d3@nxp.com>
In-Reply-To: <20241015-imx-se-if-v8-0-915438e267d3@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, 
 Rob Herring <robh+dt@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728982877; l=3095;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=c2GJVCidrhX1BXyQTcNgVT1gDrIReiQzjgNl9ktmYns=;
 b=fMaL1hE8jLyU6WagFEBf5u7tBddMCZSKutvVg/m9oM1cAaswb209ns9SKfcImzGB1CwPtxc0T
 z2eShZwHKGdDRKzFNU4uhLrSIDPBCjELV9/HPky+Eu6Znlf/Ugz6gr5
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6)
 To AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|PA4PR04MB9223:EE_
X-MS-Office365-Filtering-Correlation-Id: d1153ced-a434-435e-97c4-08dcecf88a15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnhJaWJOU1FpYk00Q3FUYUp2bVJMeHpQRG9DMlBySkRaRU1lalRWRkpNcjc5?=
 =?utf-8?B?bmptTEdFTlI4TUMrN3FDbzl4QW16cE1JWlQ0c05henVnM29nRnQwSkZSZHJu?=
 =?utf-8?B?RnprM1VRNC84cnlEakNzUGI3ZjcwVFUrZHVEZVQrM0J0U2tjTWtCMXIweVJP?=
 =?utf-8?B?MUV3b0cwR2tOQnRvTWZubVFFNFZsS3ZyVFhJc0psOHJVSEtrN24xMDAvdDQ0?=
 =?utf-8?B?THdqL2NCUktvc2hTMHoxUGhIZGJVb0tMaHZkVnpubytya1VPTUwxY09zNnA1?=
 =?utf-8?B?TlRlVlJXQzY2VWIycWxVM1FQSUNnQTcxT0ZaTUtPd1NNaHUvWlh2L2wvcCtk?=
 =?utf-8?B?akVrc1BiYVhvRFFvYk5Gdkxpd0RRQ21HeDM2QXJUUzJJS21VK3lBR3A4aTQw?=
 =?utf-8?B?TmU2Q1ZwOTc2VGNUQ3picnFkdG0vSDRsWkZLRkVVaThkR3grMkQ4ZVVtcUlR?=
 =?utf-8?B?YVZSdmFWRE8xUy8wUEZ3aE8wRFJmbHgzT09WZ3BBY1lIdDdEMkpwbWpsRjlt?=
 =?utf-8?B?eFFEaitUMldWU2w3N2hzMFdQZjB2TTk3RFkyVUllRjRKQ0RqVFMvcDVPbUs2?=
 =?utf-8?B?b2d0enhpRXdxUG16NHNZQm5rWmlkd0lwdm1LbkxxVmpuT1FYMEt1OEFTMjEz?=
 =?utf-8?B?RGNiZWp5Z3d4TmQrSW1qVVFKVGF6b29td0E2VHkrTnFIZXRMNVZxWDV0aVRy?=
 =?utf-8?B?QXJPLzVGaThYNjBjV3phemt4UHhnQlVvcXNGcEc2R05rRFpySVFqamw3bDVl?=
 =?utf-8?B?cnh6ZzhjRzNlZURmNU90amxQN3lFa1piaVhaRjRBMDd1OU1LWkcxTUN6bDRi?=
 =?utf-8?B?cUhNRm55N3RpUU9NUTNUUmx0ZEs0SHpQUlc4TExWRDFUUUM1b2dCWjlJTThE?=
 =?utf-8?B?cURyQUlmMTJoMWI5Y2F5OVRZTkxGblUzd1QxdEJLbTBncXhWWmR3MG5XY3F2?=
 =?utf-8?B?WmlSSmIyQ1A2UWRoZXpqYUN6RmFkWnJUeXdtdTB4TmpQaE5SeHZ2dWZuVkk2?=
 =?utf-8?B?RU9OWFovQ1Y2MUVDTU1SNEo4UTBIQVFvdm9nTG41SlNiTnJNN3V2d2ZoWi9q?=
 =?utf-8?B?bUswSWNwbzg3WFgxaWVzcksxU2YyQWpQZkpTTFhyS05jL2lSbXY5QVR2cFVt?=
 =?utf-8?B?YStpMXFnRDdVNk56aEU0VGpEREdHeWhTL29YbkswVjF2MVhHbkJ3MkltY0Uy?=
 =?utf-8?B?TVYvMGl1dTdKVzZOdEZPUlZwUHBOZmZORThvRDh1TVpLeTVKVUNFQURiV2ds?=
 =?utf-8?B?UDNzT3ZyTkNNWmxHZWx4U09rWCtDTVVXNEhzdGVtU2xzRDBIWWxjTW9reTdJ?=
 =?utf-8?B?em45VzJnNkEwYmlaS1haUVlCcSsrVjRJWWp1TWVzVWxOUEJZTXlOR3I3Z0Y5?=
 =?utf-8?B?ZlI2d3BPT0VJVHlmQjd4T2NqWkk3K1NIZ2M1SXBOd1M1eGhJemxzR1RvaGZJ?=
 =?utf-8?B?Y3hlZmN6UzdmYlU3RmhvLzhoaFVKSDRTcnZTYjdHVENOUktEY3pUZFRvUzJV?=
 =?utf-8?B?ZDBwNGtkZ04xZHpJR0pqWjBTMzRIT0VhSmRaVGRqNzJqL3BaOW9DVzR2YzYv?=
 =?utf-8?B?K2hBckJlVHU5UkNRemR3WUFTZ0lpZjZ6cS9SNE5rWjRPRXJ2WndQZEhJT01x?=
 =?utf-8?B?amRNNlVoeEVDNGFDcWRQNldRV21iTWNZbFptdEFkelhQZ1djSzZXY3p2dFhm?=
 =?utf-8?B?d3pjcjdxMkNRemMxUkpaeUVjWGVDdlkxWWxJQlEvK2dnbUxqQnloUlM1TDc0?=
 =?utf-8?Q?BKm9QOknsW/WA3lZKU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjVacmdRMnlnWG9jSHNJMURtNnZKRCtqRGs4TkhnUFZVV2xvWVYyN0hQTjVn?=
 =?utf-8?B?TFFxUDRQemhiZEJpcllKZDIrbDNMKzdLVGNodm56K2VYYVg2enZNcFVRSGg4?=
 =?utf-8?B?SVB4Qk5ZeEt6MjBGOHpGa0NnaDcxdzRKSjhCSzgrOVVqZUliWllNVDV0N3Jp?=
 =?utf-8?B?VjZZNXhYb2hxdUtuMnNadWovV3dYRkl3V0ZqbEZMY2o1V3dFVUtQRXhRcVZx?=
 =?utf-8?B?QTRTSTBEZWhqTnJQcWtadytJWnkxZHRYczM5MGo5WEsvcEFhYTlrc1NqdVBq?=
 =?utf-8?B?N1liZ2poVTlPTkVjZDhEbE5NUWFRUkN4NkRod0R4M25uTGQ2UUVEQUdYUmZ0?=
 =?utf-8?B?NUpsVjNyWEdzVFNPY3NzenN3aEZUbkV6dWRaRkRUVDhCc0t1enl2WFJiZkYz?=
 =?utf-8?B?R0FSemlKRlVsc2xJcG1aL25ENi92b0taT2lXM0ZFNTBmNlpNaWNzU3NjSytW?=
 =?utf-8?B?UHZXWjZoMi94ZWVETWkwcDhFQXlFSHVtTFVySTJzV1VxdHJuWStqYWR0WGZo?=
 =?utf-8?B?QmFUcEtMbStZRjRGbU5XQUlwWDFtMmt5ZEUrekllRUFoeGVvYzZhdFRMQUR1?=
 =?utf-8?B?YW1FcloyZkZWb2ZCRzhycGc2Rjk3WGpKbEtIU283ME9MNFBHekNNays2WW1V?=
 =?utf-8?B?ai9JVkMzOUxlUEMrOTRYcXpHbEo1WnVMV3Bad29vd1h4NE5UaW5SSDMxK1hM?=
 =?utf-8?B?bUFaSWpxRHp0OFdOOEpVMkFISEhUOWFGZEhXbkM3d0hTS3VqYi93ODVuWmlD?=
 =?utf-8?B?cXRRR29KUFhsN05xU1FRc2E0QWZQVURXMnlQVEIyYnVJK0k1N3dLT2xJamVx?=
 =?utf-8?B?OGphaHBPaFpEVUUrQjRvT3J0dFJaMGNvV3Z1azZ0bjJMbWlXd1Jvc3FaSzJa?=
 =?utf-8?B?cjQ4SlV2R3pZbTB5RnRRRXVwZTNISnp0aEdmOXdNZFUrMmpUUzEyL0tjaGsr?=
 =?utf-8?B?QktjSjRwQkNpZnN3c2RhWnZlNXVWUWh1cU5OSzBNdnpSYU5jYk95aVY4MWlY?=
 =?utf-8?B?N0JzcDNlVTdyd2xTS1pBSStCRzNFQm9kV2hLTVg5cUF2MTVFUHp0eWd5bGQv?=
 =?utf-8?B?dk9STE5hdERSTFZpaWVNeHM2MkhudklGZUVVYVdsSTkwNjV3T0hNSU93eVdF?=
 =?utf-8?B?aEFBMW51NlRWcGJHRUxUY2FCQ1ZmYzZtTGJiZVp2L3VIUFZWb2syNFVWRkh3?=
 =?utf-8?B?MGdMUHdTVk9vQnJjVlo0Q2VVZVFzaDJsaGlBQ0UxTjFmQWVJdFh4Rzd5bWJh?=
 =?utf-8?B?N1c1Mm9WWnFxdmkvTDYyTHd2em5jNkltZ3V2NmMyUGhnT0Fha01udXdLL3N1?=
 =?utf-8?B?UHBINk8xR2Y4aElBekg2aUE4RFdsN2dTbDdjeFdLdHhzNUFUZUJHWTduZVVT?=
 =?utf-8?B?VGZWUHJndDF1RC9wUVhYc09jemJUemlhNWRMQ0Z2bHVPNStyeXo4eW9hWmJP?=
 =?utf-8?B?R29ldFFHd3hpY0pFNzZzNXZnOTlBOGh5WTI4c1gwREMxWFUxcVdWeG9HbkRC?=
 =?utf-8?B?SW1hakJQS2ZwRDJOeTZBUXRnNk03R0RXWDVLZHl1RFZ2dU1yMnpJRkdCRDky?=
 =?utf-8?B?d3puUTB4clRDa2Q2bk5BTGZFNTNCcU9JM0NpMVhXNGk1SDNGZ1ROUDlaMkw4?=
 =?utf-8?B?MlZuRFpzSUtoYkU0N1U3dHpYdjdDaFhFYzJ2dzVRTnRWWDRBdDJHME9jWUY2?=
 =?utf-8?B?WUdCMEdXUk1JSEMza2pxM1lMTGZHTGJ5MTlkZlcwZW53Myt1YzVxWTA4dGVa?=
 =?utf-8?B?OFhzMmt0WGJ0cHM0c2xMMVdGcWlqZ2JEYkJvU1VzVnpaVlJSS25BV09LOG9m?=
 =?utf-8?B?WU1odnFpcVhKd3RvU2s5Vlk2V1JPSzAxaStLYkhndkpidDRDdEg0U29nVVdv?=
 =?utf-8?B?aktmMDBlZVBCMU1SS2h1UFdiTHpjK3ZWWEdwNUVJN0p2dTFQV0dYVGFMckJ4?=
 =?utf-8?B?a0oxTEhjSGRtQ3h0cDkvN3VUczN3Zm0yVisvZXRzZlBCeENEVnZYc2I1Y0E2?=
 =?utf-8?B?Rmd2YWdyNENpSmNxNnQwajM5U1pydC9tMzM5OWVyYVpDN21MejgvZDdUNyth?=
 =?utf-8?B?aURtRG4zVVJYL3hINnA0U0ZjWVhibTFucHFLOUw0UU4xVlg0b3VkcHoySnh1?=
 =?utf-8?Q?DofhOblPVk3tJvZRGJQGlq+Lh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1153ced-a434-435e-97c4-08dcecf88a15
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:05:39.4005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRPOpKVWp/5GgtSMZjON4+YlMqwNYbV3IO0RYJSzfOz9g5MYM4VO4pnhwHsC0D0msnYOd8+H1L5xEfBDmasNjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9223

The NXP security hardware IP(s) like: i.MX EdgeLock Enclave, V2X etc.,
creates an embedded secure enclave within the SoC boundary to enable
features like:
- HSM
- SHE
- V2X

Secure-Enclave(s) communication interface are typically via message
unit, i.e., based on mailbox linux kernel driver. This driver enables
communication ensuring well defined message sequence protocol between
Application Core and enclave's firmware.

Driver configures multiple misc-device on the MU, for multiple
user-space applications, to be able to communicate over single MU.

It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 91 ++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
new file mode 100644
index 000000000000..0b617f61640f
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX HW Secure Enclave(s) EdgeLock Enclave
+
+maintainers:
+  - Pankaj Gupta <pankaj.gupta@nxp.com>
+
+description: |
+  NXP's SoC may contain one or multiple embedded secure-enclave HW
+  IP(s) like i.MX EdgeLock Enclave, V2X etc. These NXP's HW IP(s)
+  enables features like
+    - Hardware Security Module (HSM),
+    - Security Hardware Extension (SHE), and
+    - Vehicular to Anything (V2X)
+
+  Communication interface to the secure-enclaves(se) is based on the
+  messaging unit(s).
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8ulp-se
+      - fsl,imx93-se
+      - fsl,imx95-se
+
+  mboxes:
+    items:
+      - description: mailbox phandle to send message to se firmware
+      - description: mailbox phandle to receive message from se firmware
+
+  mbox-names:
+    items:
+      - const: tx
+      - const: rx
+
+  memory-region:
+    maxItems: 1
+
+  sram:
+    maxItems: 1
+
+required:
+  - compatible
+  - mboxes
+  - mbox-names
+
+allOf:
+  # memory-region
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8ulp-se
+              - fsl,imx93-se
+    then:
+      required:
+        - memory-region
+    else:
+      properties:
+        memory-region: false
+
+  # sram
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8ulp-se
+    then:
+      required:
+        - sram
+
+    else:
+      properties:
+        sram: false
+
+additionalProperties: false
+
+examples:
+  - |
+    secure-enclave {
+      compatible = "fsl,imx95-se";
+      mboxes = <&ele_mu0 0 0>, <&ele_mu0 1 0>;
+      mbox-names = "tx", "rx";
+    };
+...

-- 
2.34.1


