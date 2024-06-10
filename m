Return-Path: <linux-kernel+bounces-208869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F3C902A15
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C28631F21A10
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C38757888;
	Mon, 10 Jun 2024 20:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BJw/o2Tx"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E0F17545;
	Mon, 10 Jun 2024 20:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052403; cv=fail; b=KoGpMzUYrCApZkfBAYGYYUeccLL7yoRv62XwgkP413zwXhoYKevsag9KnHDOznRYvNugRgq5OSvRkX75PSrMTpQmKTQYeHhT+arg34pL4L3UNPYb+IWtZDyBA9wWOzrZOPowRZE3XBTczHJHuev5UtGyNevFpQoTh64wgJOWxno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052403; c=relaxed/simple;
	bh=fdZ0UttgOfRQUjL4ounI39RHpJEK6Tmo8bhsYsc0nhM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Bnrcke53kY58EBJiicYf/uWi6b+6LPR9gKtKsFjUNAB2lCrl88EMkpCofdOIjYb65TgsXEGWPlvF+urQ8EBgOVrMNfcWaixZDByjImXUpi47VFJyzw3NLJu9lPEkqavTsfRuEYGkCDhsze/0uoCHW84z26ZUvwXjBtlKpm0eEhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BJw/o2Tx; arc=fail smtp.client-ip=40.107.22.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChDh1OMN3RKcUps8GKxtKCuqCJl0hckbdxuzX0PiDAc5WvOj8XjpYqODJIPkeFwzFQOoE9L/j0y9LQrnUHfC5BTaBpkQlAXkVDSm+dUAb+C5b1rQI0ri1sJDYNWjxS67Ca3/c6IVVqJCalgR20pu+YvNcaBOxr5JQ8QzBIyqGOYj8AfniZKmPn7v/CCop+ZmCg3lgrkoke5cgL0DWR7VqzkSU1iCyU83wbOB17N3eiqGOqqrlw5ZNs6BcvJI/MptylK7KIsXjb0TDlfomMbNpymRq6/TgyDEBkHXjcNj7YtE22kB+lx8GPI77EPTJo4anJyQPlZkvhkyE9nYfW5xZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30B1mjX6R/UkFcJMJiUUIpIonuejDtwEFI3Rs1LI+dc=;
 b=jRZnpr65m5uYueTyu0B8+8D/OP/6kvTswoRX5By8DawEVsn2Oo4rbL/UGChv873bBExfXejJ8Ev21ufjYStt1dOlpdZp9xWDKiUS9bj2HYxrrPySmxCkv30r8pieU2pRNXFxTmMrJH9aUgEw+55D/m5bI1rZBqEPKNb3xTBN1TXrmyhM6xk/K5vKJ0guyz/DVgo8x+uD1yVo3I7GjZrCVRsDV5lgqnaBaOknYrwXGJRAE+ezq+qKn8eOPmbE4Th6mN3XaXqU5Uaa2wqJSXxepCgU1FwVSaoO8PjJxYX/SpDmfKupQeM0pqYBjWvhKo3pSrIxet3KdfcL6kQhMYGRpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30B1mjX6R/UkFcJMJiUUIpIonuejDtwEFI3Rs1LI+dc=;
 b=BJw/o2TxQVgANKL97W35lNNXy9kz4HCdXNT/vas/hN7BkUXASD59qdqcgco+ZLl5YHcZ5850pH9YrWUcPVtEFuvc9R/Zw7SxoLf5UyADNULCm5TSKUgJjeVZWoOv+hh/5t6mNS+Q9CaDhDlS2w01GDWK9tl1WlUsy4iLMyQ4VW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8463.eurprd04.prod.outlook.com (2603:10a6:10:2c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 20:46:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 20:46:38 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 10 Jun 2024 16:46:18 -0400
Subject: [PATCH v2 1/9] arm64: dts: imx8: add basic lvds and lvds2
 subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-imx8qm-dts-usb-v2-1-788417116fb1@nxp.com>
References: <20240610-imx8qm-dts-usb-v2-0-788417116fb1@nxp.com>
In-Reply-To: <20240610-imx8qm-dts-usb-v2-0-788417116fb1@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718052391; l=6534;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=fdZ0UttgOfRQUjL4ounI39RHpJEK6Tmo8bhsYsc0nhM=;
 b=Bf2dx0MbvrHesjmkSwBoIF/dbAYUJ5PO4xS0SmMeySM4AAy1xgTm6oDLFInZm/RkrQOPz+rOV
 b7qJTlPyF7MBw3VBEY/eCbinchopEiGdl4nrlXBcVTHluushqdYb3E4
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR06CA0059.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: 13675bfb-cc50-4b52-e14b-08dc898e6cf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|7416005|376005|366007|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEMyUTk4S1htcjZ0UkJidVZUcHYrdHpMN1ZvOEJMN3lpdnBEZHAySW9DQjZZ?=
 =?utf-8?B?VlU0c0ZYRkFENnNRaVdiSXJIa2VwMFAyRGFUMzVIMmRDa01KVzk0WWprQ2NI?=
 =?utf-8?B?c2hXbGZYM0VubUNnQU4vdEpLdVFYd2Z0bUsrVmk3a3haOGlFbG5EczZBTW1R?=
 =?utf-8?B?ZTdrdFRWZTdCZ2JKeHp6OTc2eGtsS2pEVVNIM09BalBNdWpkYTBRbGdRK2Zz?=
 =?utf-8?B?bWc3WVZkTTd3SlFmYkNPVUd0K0hMTzBTMHNselNJS0thVXRpWHFHR3NNamhB?=
 =?utf-8?B?dUVuVXhiQWJBVTA2K3NjYU9OM1BpRkVRMURjaXpJaFJqbkNrWGtOOEJpSVE2?=
 =?utf-8?B?bW96em9BKzFsY3VUU2hZcWl6STUxbGhLcEJsYVYydFhKT2tmVm81SFdUQkVi?=
 =?utf-8?B?SEpER1FBMlhoeGFjc1NHOEJ2TjFCMU1zcENQUUlRdE9HRHVpZ1BlUlpiSnhG?=
 =?utf-8?B?cVNaL0pOR0hndWJZNGlPYmZVUmsyWTFjeUdxMndYRU9jczVTU1g5QW94VDVS?=
 =?utf-8?B?VFZhOVNaNk41cXV5SThsbVp2UzQ1a3JqUW5JMWszcWJhREcxK1VqRDBuYklJ?=
 =?utf-8?B?eVZPQW5jcEJLRVluMlJBS0l0M0REMXJOQ0s5SW5YT01PcWduMy9QeEdiWEZl?=
 =?utf-8?B?a2IrWXFkcmxYaytYKzMzVzJQWHdUSFFQQUpCbGxXSG4wWnRuNVB1QWhzQ3Ay?=
 =?utf-8?B?TURRQytnUnJLMzNKdzhvU2p5elpENUE1bU8rcWQ0SXE1TTliL1I0ZkpxTkN0?=
 =?utf-8?B?YlM2VkY3YUNZMXRqak1VM3pXTlh5NDBka253ZXpHci81ZXlMWWhzV1lraXBH?=
 =?utf-8?B?SjN5aS94WWh4YVVXMlVJamRMbEY3OG1nU3d5dWgrNkE1WEhWby9VakV0bHA2?=
 =?utf-8?B?MVRrODVJMjVNSGMyNnJUWkphc2FGdEdjRnlXdWc2U3BLMFNvaWdzRFkyazNV?=
 =?utf-8?B?TWJ0K3hraXpISHorR1p3RXNicDJ3K0MxYXlndmRVazI0TzdWVDFYYXE2RW8z?=
 =?utf-8?B?SlhRdnUrQWRCR3FYczRGUUNPcEZ2bWlUOW1zY2RHcTk5eXVNU3o3NE9GRThn?=
 =?utf-8?B?Mm1EVFdYZE9NdnVCSHZIZG9iaWNrWHhqUFZ5UkpGOG01YkFERnNGMG82VHpZ?=
 =?utf-8?B?WTRSWDlxWlhjdnJoanVPNDRLS1dkakFoSEtJWUZxTXZ2UTlwSTlRckRaNy9i?=
 =?utf-8?B?UEt2UkhnemJwZkxsWVlDcWh6V1NONVMyZXdqeVhOSFpzNG5YdDlBbUFjbHNt?=
 =?utf-8?B?NGFsOVJRSFIwS1ZkNVo4NUVXRWRnYkdLQUlFR0lMMHhqb1VTUEkyS3RlSTU5?=
 =?utf-8?B?d2VEQ2w1andqVkZyeXptaDkvdy9NaC91Y0pjVmVTa1RER253RVJDekl3SGdq?=
 =?utf-8?B?NlA0b1BnUHJwSzhIY2wrZ2FaeHJQNUZSWjljbWdjb0Q1Y01ZRDJSL2piQkt4?=
 =?utf-8?B?dXdSUnFXdkhSbDVnQUYyNVhkb1h0dkxIUGtNZDBtc29CelZELzJpRXM1SVc0?=
 =?utf-8?B?RDVZc04yclZlN2dpSVZnZnArK2IyNVFvSWVYN0c3ZlpBMk81QXhxcDBGaTc1?=
 =?utf-8?B?MGQrUjJKS3ptbncvbFNaZlpIVUdIMnJTU3RBMjBSeXQzYkhQbEZGcWltQjJU?=
 =?utf-8?B?NEJndThFOHlrTFpYS3ZCZjEydFNxN0ZLZ1NYQW5KVC9pNjE5cUpQVGNVTFhB?=
 =?utf-8?B?bFFpVEVzR1VpOWtBOE1RanpXendtVGpaOFZBUGxZUzVrN05SSDNwa2YvQUtu?=
 =?utf-8?B?TXdWU0FvNm9zL3hNRjdaVDFGbkE5cjZMWHQvd2E1QzBkMHg2amlXSXAyVDI5?=
 =?utf-8?Q?a0HH6jaBDhMlmOTVKuGDWJZOm5DY49TnfIyLo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(376005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzhUS3pNMUc1YkdERGpQd1F0SjlHL2NZMFlFRURXQVEzS0wwMjgzUjF6V202?=
 =?utf-8?B?Ky9SVjBoNkx2eGR5MDNTaTlZU1R0bzl4TndWZ2FZSHJIdzcvQ0xsWGk4UGhT?=
 =?utf-8?B?RU04N0RHM3AzVnlaYlVTL3BBczlZTStobHFqRXh2TmxqdVdVZFVTb3dPL2lR?=
 =?utf-8?B?dWNCbnRJazBJcm51cDFvUHR5WjExdXZEL0ZJVGE4R09OV2ZIbzE4U3Z5dlR4?=
 =?utf-8?B?aWFHS21yZ1VPbkErclVlTHpGUmxBZC83dTMza1dERE9taVpDcUZQUjgyWFdl?=
 =?utf-8?B?dGh1VXFaaEVFVUExTXBFQTlOM0w5TFNuUGM4QkZHUm82NUk0UnRtWmplaUc0?=
 =?utf-8?B?Ym1ENWZoWGtOd3lndGJlOWFkYjRTR1YrN2dzUTdqVm9aRkVCaVdZYndPd3Ry?=
 =?utf-8?B?cFdhZzNTdEozd0ltcTk4QW5UeUVUSUFLTUNsdFBSalE0dWd6bUgxcDJ4OWR1?=
 =?utf-8?B?SXU1NkVCaTl2M0JuTS9BRTZROUttWlJ3UkhKY2RBY1czZjdmNGhWOTRXdUMy?=
 =?utf-8?B?d1RjbDZ3NC8vSkNJM2tTQ3BmcXh2NDBxYzUya0I5U3oxQkJBejVMUGlKQXpN?=
 =?utf-8?B?QkhsVDdQbWFXRHhLMm1tQzdWNEhlTTJOdjFxekt4N3hrQ2k1MkNYaERTZitj?=
 =?utf-8?B?Nmd3TjhMSm94TllrRlRjek8vWkIzZlN1SU5seEs5WjdhWXc0ZCttemN6TGN4?=
 =?utf-8?B?UTBrWXRKK3VFR3UvUVh3dTFSSlF0b1E1TW96Tjg4WnhENFA0Q1NyejBlSzQ4?=
 =?utf-8?B?SWE2K3JqU2FMcmk5YlVYUTlGRVVuOHFXdXpEaUpnYmtjOWhHaStFK1dLSllx?=
 =?utf-8?B?a3hVR3ZGZlQ0cTRZbU9jNnFoTzRsNGtFWDRUSmY3VWtRbjlCbWhIVWJlR2Ra?=
 =?utf-8?B?aG05Ym0zcEoxTnNuNCtaeWJFQ2JDT2dvandLODFMYi9pQ2Q0bkFIRHlFcWpH?=
 =?utf-8?B?bk5NTXFxbGYwcUFDMk9Fclh2NFZzaHp1dEhOTTdQUkZCSzRzSHdCTzIzcCtj?=
 =?utf-8?B?UHRnY0U4dmw0MzR4OG9uWXpOY1Jvdlp5cVptSVh4dVhMZ3poTWQyZHpDdThn?=
 =?utf-8?B?U2JiQ3ppcStYUkZxVTk5ZlA2NlNBcVZCcndyd0dYQnRxZEpjTGV5cThkNUJr?=
 =?utf-8?B?L3gzRS9PbjFIbGpsQTFiZU5ueWRoMUtLOUdGM2pRazFZMkk0WVAxakNWK3Ji?=
 =?utf-8?B?OHFrSWpuWXBsTDNzNWFrMFhXb0ljay9LZWJyOG9sb2RRTXpvRWdQUzRDNndW?=
 =?utf-8?B?Q0hjNG05WDZCMFpvYXB4UkQwRnVWWVE5a1ViRVJ5U0QyMVNGaGdMN1hNejZ4?=
 =?utf-8?B?U3Y2Wm5PNVdBcWNQd2NJQk9TdjJOdlBZekdXMmVMY0E0WHViL2dYV1BRNDAv?=
 =?utf-8?B?UGoyN0s5VFh2d3JLWmROQmtqUGY4RDNLZ3dUbVVtcmRtUnZjK2FLYm43VWpD?=
 =?utf-8?B?ZVdaOW8reWhUcmhlZ04vL1ZsSWF5akQ5eHFDMEQ1S1ZuWW8wZTBpU3AwMWpY?=
 =?utf-8?B?aGhScU5nemFFVDJYMGZiL2xOQnorUmJPZ1hzRVJZYm9lVXNPM2JaNStYMXh3?=
 =?utf-8?B?UEZLNkVENjNFaGsxdjRRVDN5T3hkQWxkZ2MyTjlORzdITVFPdmlOVndGLy8v?=
 =?utf-8?B?aU5HbXAveTIvaWxzZ2FWMW1sNXFpQUU3anExb0F4SGliVFBBeFBiZng1aTZs?=
 =?utf-8?B?aDRoV01WV0FadmI3Qm9rTVdTVFdOZWZMcURBVERwcWZnbmdacDJuNkMxeEpr?=
 =?utf-8?B?K1NWbHJZSzNqRzkyaE9xMXNDaElUNDlmeUJtTm1HblZGcUowVGxrZVoycHp2?=
 =?utf-8?B?UlNMV3VUZ3ROVzQ4RHhaUlJEQXp1dHo1YzI3cEphWXVCRzFxaWdxMVdzcHJx?=
 =?utf-8?B?T0hpdW9LWjJMWTZtK3pVNGNaMkFHU3FKNGV5N1JldHU0bnpGcFIxVDgzSzJz?=
 =?utf-8?B?SnVHSXNiQnl5RkFFejBWMnc3SVNONWE1a2hnQzV1QzVvcE5PWXNmYnd5aXlF?=
 =?utf-8?B?LzZUTEF1K3ZoQzc2NzZscVJWK1dUVS84enV5RmFWZVhwWTU3NVIwTUdiVkUv?=
 =?utf-8?B?TzF4S1hTVmlRK1d6UW1yeUFvdVBKYWcxTDlwWUVsM1ZlNURkVjdxSldaRGZ0?=
 =?utf-8?Q?TDbg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13675bfb-cc50-4b52-e14b-08dc898e6cf6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 20:46:38.6858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+cZtcLBKRdBFhpOznqKKtqLDnP7oWL5JN/iZbailVVAuqG/t+qTCrQi11XYiNsCi8G7U+mJzyBvJdpeP3XkvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8463

Add basic lvds and lvds2 subsystem for imx8qm an imx8qxp.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi |  63 +++++++++++++
 arch/arm64/boot/dts/freescale/imx8-ss-lvds1.dtsi | 114 +++++++++++++++++++++++
 2 files changed, 177 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi
new file mode 100644
index 0000000000000..55fd60446ad21
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-only and MIT
+
+/*
+ * Copyright 2024 NXP
+ */
+
+lvds0_subsys: bus@56240000 {
+	compatible = "simple-bus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x56240000 0x0 0x56240000 0x10000>;
+
+	qm_lvds0_lis_lpcg: qxp_mipi1_lis_lpcg: clock-controller@56243000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x56243000 0x4>;
+		#clock-cells = <1>;
+		clock-output-names = "mipi1_lis_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1>;
+	};
+
+	qm_lvds0_pwm_lpcg: qxp_mipi1_pwm_lpcg: clock-controller@5624300c {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5624300c 0x4>;
+		#clock-cells = <1>;
+		clock-output-names = "mipi1_pwm_lpcg_clk",
+				     "mipi1_pwm_lpcg_ipg_clk",
+				     "mipi1_pwm_lpcg_32k_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1_PWM_0>;
+	};
+
+	qm_lvds0_i2c0_lpcg: qxp_mipi1_i2c0_lpcg: clock-controller@56243010 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x56243010 0x4>;
+		#clock-cells = <1>;
+		clock-output-names = "mipi1_i2c0_lpcg_clk",
+				     "mipi1_i2c0_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
+	};
+
+	qm_pwm_lvds0: qxp_pwm_mipi_lvds1: pwm@56244000 {
+		compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
+		reg = <0x56244000 0x1000>;
+		clock-names = "ipg", "per";
+		assigned-clocks = <&clk IMX_SC_R_MIPI_1_I2C_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		#pwm-cells = <3>;
+		power-domains = <&pd IMX_SC_R_MIPI_1_PWM_0>;
+		status = "disabled";
+	};
+
+	qm_i2c0_lvds0: qxp_i2c0_mipi_lvds1: i2c@56246000 {
+		compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
+		reg = <0x56246000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <8>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&clk IMX_SC_R_MIPI_1_I2C_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
+		status = "disabled";
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lvds1.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-lvds1.dtsi
new file mode 100644
index 0000000000000..12ae4f48e1e1c
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-lvds1.dtsi
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-only and MIT
+
+/*
+ * Copyright 2024 NXP
+ */
+
+lvds1_subsys: bus@57240000 {
+	compatible = "simple-bus";
+	interrupt-parent = <&irqsteer_lvds1>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x57240000 0x0 0x57240000 0x10000>;
+
+	irqsteer_lvds1: interrupt-controller@57240000 {
+		compatible = "fsl,imx8qm-irqsteer", "fsl,imx-irqsteer";
+		reg = <0x57240000 0x1000>;
+		interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		interrupt-parent = <&gic>;
+		#interrupt-cells = <1>;
+		clocks = <&lvds1_lis_lpcg IMX_LPCG_CLK_4>;
+		clock-names = "ipg";
+		power-domains = <&pd IMX_SC_R_LVDS_1>;
+		fsl,channel = <0>;
+		fsl,num-irqs = <32>;
+	};
+
+	lvds1_lis_lpcg: clock-controller@57243000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x57243000 0x4>;
+		#clock-cells = <1>;
+		clocks = <&lvds_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>;
+		clock-output-names = "lvds1_lis_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_LVDS_1>;
+	};
+
+	lvds1_pwm_lpcg: clock-controller@5724300c {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5724300c 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_LVDS_1_PWM_0 IMX_SC_PM_CLK_PER>,
+			 <&lvds_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "lvds1_pwm_lpcg_clk",
+				     "lvds1_pwm_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_LVDS_1_PWM_0>;
+	};
+
+	lvds1_i2c0_lpcg: clock-controller@57243010 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x57243010 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_LVDS_1_I2C_0 IMX_SC_PM_CLK_PER>,
+			 <&lvds_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "lvds1_i2c0_lpcg_clk",
+				     "lvds1_i2c0_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_LVDS_1_I2C_0>;
+	};
+
+	lvds1_i2c1_lpcg: clock-controller@57243014 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x57243014 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_LVDS_1_I2C_0 IMX_SC_PM_CLK_PER>,
+			 <&lvds_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "lvds1_i2c1_lpcg_clk",
+				     "lvds1_i2c1_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_LVDS_1_I2C_0>;
+	};
+
+	pwm_lvds1: pwm@57244000 {
+		compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
+		reg = <0x57244000 0x1000>;
+		clocks = <&lvds1_pwm_lpcg IMX_LPCG_CLK_4>,
+			 <&lvds1_pwm_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "ipg", "per";
+		assigned-clocks = <&clk IMX_SC_R_LVDS_1_PWM_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		#pwm-cells = <3>;
+		power-domains = <&pd IMX_SC_R_LVDS_1_PWM_0>;
+		status = "disabled";
+	};
+
+	i2c0_lvds1: i2c@57246000 {
+		compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+		reg = <0x57246000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <8>;
+		clocks = <&lvds1_i2c0_lpcg IMX_LPCG_CLK_0>,
+			 <&lvds1_i2c0_lpcg IMX_LPCG_CLK_4>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&clk IMX_SC_R_LVDS_1_I2C_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_LVDS_1_I2C_0>;
+		status = "disabled";
+	};
+
+	i2c1_lvds1: i2c@57247000 {
+		compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+		reg = <0x57247000 0x1000>;
+		interrupts = <9>;
+		clocks = <&lvds1_i2c1_lpcg IMX_LPCG_CLK_0>,
+			 <&lvds1_i2c1_lpcg IMX_LPCG_CLK_4>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&clk IMX_SC_R_LVDS_1_I2C_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_LVDS_1_I2C_0>;
+		status = "disabled";
+	};
+};

-- 
2.34.1


