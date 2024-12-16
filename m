Return-Path: <linux-kernel+bounces-448049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C12F99F3A65
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0179F16AD27
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCB61D1F57;
	Mon, 16 Dec 2024 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="itfHJmmc"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2041.outbound.protection.outlook.com [40.107.104.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D048155A25;
	Mon, 16 Dec 2024 20:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734379402; cv=fail; b=tfq77QNT2jnDji9zJD0QyIoAu7cPxAVDHHlmLZjV9of/ueLj8PEKQamFIiqueUWSTfTDorOL0U8yL2SCDnqLv8onXHub7ts/OaoXet9dy9PPjJ6KJgL07d0lFytYhi9+QyQl3ef4ZAq6wmkDXSk8QbMOlNFQxlfic0Yp3JJ4K00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734379402; c=relaxed/simple;
	bh=V7LDZEgCBJnJn/v0q5/IfFeQdKlo4Kr5NHBseTrsKsA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tgWgP8FItyAlUPJzMx5tmVCFNHiDcbzog+Iv2aQ2y+jGgMSBboAJ8xFvq4GY7I/ZUJVuRtoYI9h56CiFPC3/m+C3/bApt7hvSqA9RTMMwwC0+BvpWCJJyoomD7cDOxKZoVenWmGHep7XajXCB95Ybj0wXEi7Nqo7empNKfKLzck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=itfHJmmc; arc=fail smtp.client-ip=40.107.104.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S077DUW9gYMwS1uGWXbD72T9dXn4SahEUO+4E1jxjHe+YxB9rciZTFdtAURnVugDXWmsRhgyIXxTT/p3a5aM/H4Wm80FA9rU4KIffyZP3jaxYJOFaXyQLNH2+YXer7qXDzWgi306vzjXq+xoiFg0UHZ1Aw7ksyBbCtep3PD5Rtr3Yl4RE1+2WKQkC8TMhANoRRYahBswq1ui6AYYrLU/57lzLHLpFGsMcY9B1w8VjlRUjEZqkI701FXXHBtW3uZRGy6dIJaMZaVNrJCwfZ3i1abW9wXal2jQYtYTthLFz0UCynTzs2r38o9XWf8mtwvshMCw/Cdjz5+NVzXsS1YxYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjeXgHd4zzElrMCDLKEPe3PFcwcGt8BvtxsO+JJv0JQ=;
 b=WPf9o/ifqTSu6EhZ0eH2JWBepDWb/JzkkE9utYC7ldKLCN0gOpARTBrTBxQdb7cvghdY43jFFhyuZcPowl7rs4cqgN5WZmd9ItFKOCSkf9PlmC3INRsq/4qNmiBkzA3w2oNwFM9R9i0CkMWxTkjPBpk3jgMAatlqgsWwuQW7teRFvdW1LAPkQKnrVRHeA2J0yjeu1PyxST7POtp9UMBPWwOmxCQpDKKFQ3ZQYOjbgTwH6GsGt4Is88DuVhWZM4DJF5WCd4WQrnIQuJTeojAvHXo3hkZfkHfuJitzgnI+GvMQIf9vhXbDxgRMGgeoZyqbmqh4QlC5am8FzHp/m8fU1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjeXgHd4zzElrMCDLKEPe3PFcwcGt8BvtxsO+JJv0JQ=;
 b=itfHJmmcT+PYuogBt8VJoV058XQzzIapa0cInuQMuChYe7WZIA1vEeY+iEuQ7aVj9eUcjb7Hq38HpJ8hEBzJV1xyIv+OwMm0IBQMaijkk1/Mqa8f3drxASWel6Vh8usMx4LzAKaCoRqi2ea7rPy5F25B42xOp14W0o8yfUKvKFmF3Qvr35BJXd+zmlFHdZ4cACEra3vRRgjuRRb+hcen7GIceZyjougtrKvljHanSTcpGw9m2B5T5UnCzWNbM1XVjWZn96ZluBez61iu0jtUIspLBRWk0T3rja8bjowXo/w+NkeVAqXTEvHr6TXPh5+XhhxHnYnWTbkMgBBnZPKC0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7501.eurprd04.prod.outlook.com (2603:10a6:102:ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 20:03:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8251.008; Mon, 16 Dec 2024
 20:03:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 16 Dec 2024 15:03:05 -0500
Subject: [PATCH v4 1/2] regulator: dt-bindings: pca9450: Add nxp,pf9453
 compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-pf9453-v4-1-a9fc8f0a0098@nxp.com>
References: <20241216-pf9453-v4-0-a9fc8f0a0098@nxp.com>
In-Reply-To: <20241216-pf9453-v4-0-a9fc8f0a0098@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734379392; l=2225;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=V7LDZEgCBJnJn/v0q5/IfFeQdKlo4Kr5NHBseTrsKsA=;
 b=PaJT0a0U5I6xB/1YjaDGTYSk8P8NAvu5edVfnrAG8amphJipmvnpSTfb6+aospxwdPxQaSg2A
 fhPEssQakcIDHRxaJgq+a0i598pSYgEyFhQm6X6LkF6B/YAcBpIMfLs
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:a03:254::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dfd3734-2e8d-48a3-e48c-08dd1e0caf11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXQ1MStGK283WFdoTmpueE5HQXJXRUlUazJIczd1YVpEdE5DWkhhbDlGRmJY?=
 =?utf-8?B?TGhmMHFuVjhDM3U3ZW9GSURqd1R4YXhLRkczWndNYVJVZXc1MGEvdVhNaDlR?=
 =?utf-8?B?NDUrMkxMNzVzbWxSUFh1MXNLb1cwQ3hBL3h3SXUzU3Z4Mk5WUXVSUjJpTGRR?=
 =?utf-8?B?aEluT25ybkx2cWlQWmFFZHFEeXpOcUJCeUxFTkZNQmkwbklUaTVSRThRS0xV?=
 =?utf-8?B?U3NVOGI0SzdOcHZUQU5VcXpTdHIvVUlkdzEwWGtoTmZDeUl6L1NaOWs4Qndy?=
 =?utf-8?B?T0tqVVMyU04rUlpZNHFIWWc2ZWJNWmd6SXd3SnhZS0hlbGM5QjhETU82Nm5F?=
 =?utf-8?B?Y1k5bm4vQzNpQnhraC82aExueUJqdTBKTlBuZjJGdlpyS3podkJVbXRYMGtk?=
 =?utf-8?B?M3N0N2RLK056bmltRDVVb3BwUUlJTXVyZkNLQXl6N3ZzdS9UM3R4dHV3WDFI?=
 =?utf-8?B?OUdiaTNyaHdleHllYUNHY25pcFFmMHRnanY1dDRXUUYrUHlCUEJTREp2REM0?=
 =?utf-8?B?bkRaMEM3WkJvRFlhbWFGa29CY0dRTEhHUnFUNFNMdmFBdkdYNkY1V1NjMnhX?=
 =?utf-8?B?Y3NVZ1hiV2d4Zlp3dDVkWGZncTNSa1RaNFA3QVFuMFhEN2oySkt4dWtnQTJx?=
 =?utf-8?B?ajg2Y08zbitCNUNxNy9yUW1yWmlHZWZMbFpJQzBHTlQyRHRmbDBOVi9NU3Rj?=
 =?utf-8?B?d2xCOTBaSGFQK1ZLZDRIblNPR25RUmM3b0I0aUVyZWZmMFB6TVN5L0c4M2Fq?=
 =?utf-8?B?OHJEbnhKdFV4QXdYTUwvUzFJR1QwOVMvclFveFZUQ3VQTDRta0Z2MkRuVmta?=
 =?utf-8?B?TFRaNHFWMnRYQkJOdVVqc2lQSXpReDRRMmRNTDNJWFNZa0I1bmpQd0V1WTBS?=
 =?utf-8?B?QkVKY1ZiYTZQSWtvZTV3cGQ0RXFESE1xN29mak81cTltTFljVXFhYWltZzNr?=
 =?utf-8?B?ditJdUE1RXczZ05kVUFiZDY4T2xsazRNSmNvL3daYnJIWThudHNyNjgwV1pw?=
 =?utf-8?B?azJJaVRrNVFwQXkwbTF5czkzc1AvTzBQMi9YemszS1k5a2kyMExVOVJjSWps?=
 =?utf-8?B?VlFMRFAzRE1BRVQyNU0wL3ZsTUJvVjB5MXNrTjVYcFVWelpPMWtrRk5GQlF4?=
 =?utf-8?B?NE9lSE5KT1ZUV0tzZytGTWpsMXJJL29EQW5FS054a0tRMHM4MEJvckJ1ME5k?=
 =?utf-8?B?SDd3VmJoejcycnM1cERVNytZVjNabTV2OENwOC94U2lVZG1BT3kwcmJENkFM?=
 =?utf-8?B?aFlad292WWNYM1VpOFN3RlNtZFhWT09DM3VYZGVUNTRUdDBsVWoxMlZUNFRn?=
 =?utf-8?B?d0Y5SUhPV3ZEZUZYNXpmMUROeTVROTFUWTR1UUNMYytraGdyK3k5NzJqa0FT?=
 =?utf-8?B?QVhxT2tJNE9LTE5UeXR3anBHSlVuVVVqbWQycnM0ai9udWRyTmlXSXdjdDlC?=
 =?utf-8?B?ckRQQ1dQV2RuUCtXTEtVQnpxZjRjTjlkMW1vS2Q0R2w4QVc5eVlNeHFGOVc2?=
 =?utf-8?B?QjFnNTVXMTdmU3A4YU1GQkJYWjNjNDBnZHdBOGNFVjRJQVk1bXN4ZmxqMGhv?=
 =?utf-8?B?VWRhVGZ1enlGRzJJQTBXdUZXb3FDaEViN2owTWJ2RndkQ05Vd3l0SjY1dXk0?=
 =?utf-8?B?a1h6MGEwbnNlUjc0OHpjUHNsdEZWS2dFTk5UZFdHbzQ3WFlxa0lteTJIbFgw?=
 =?utf-8?B?SkN1TWpBTkREcGJ6QVUwOWUvT3ROWkhVRG5saUVmanE2T2NqQmRFNVNSYVFK?=
 =?utf-8?B?b1ljZC8rOE9qWkUwMnR5b0NTVHJaaHMrUFA4a01GK2tad2YvYnBzMGNWNmY2?=
 =?utf-8?B?RjZhT3ZrZk1qTXJKeTBGSm9ONGhSZkRZZm1MMGt5aURNMWxYbG4zWjR4V2Jw?=
 =?utf-8?B?K0t4eWRMclZqWGpEeTJ0cFNJeFVuVmZlUXlWWjExUnlCWFNmSnlVcW1acU5E?=
 =?utf-8?B?Y25BY2IyMkFXaC8xTXhIT0ZoQWlZZnowYklBZ1phcUY5R3VoeE1TK2g2eHFE?=
 =?utf-8?B?MlB1dXNFa3F3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2MvcWZxdnk2L2FINVBsWHNPWFhpeU1lWk9oL01ySXRxaXAwMmR6bXc5SktM?=
 =?utf-8?B?aDF0UnNzOEo3d1VsejZGdnllai9ZeDZNUXpuMDEzVVZsOHVOUU1BSFNZdHVz?=
 =?utf-8?B?ejNXMzN3WFR1dEcrTHcvZnh5ZEVQNjhCd3l2Uy9lWmtTNTNsWDEyVGhMUWp5?=
 =?utf-8?B?VXpEOXpDUEc1bFdkd0RiMkZtN0o4b1gxRS9OY3JadEpFQVNDdWVJUmg3UUR0?=
 =?utf-8?B?SExHdmE3RE04Uk01ZTJwZzlFeHZiTkFXQ1Rzdkg2MG9YaVB4LzcrZkk4aENv?=
 =?utf-8?B?WU5ITUlOWUdTQlZ1YUpVVCt0TXBCemY4ZlNYMFkwY29OUDlySW5rQnZUazJX?=
 =?utf-8?B?SHdkOFlBY0l3T0wyVTUybENmcXNMcDdsV2g3c3Q2NEJWZGJ6SVFRTzRXOGJt?=
 =?utf-8?B?eUF4Y2xtbFl2QUJlWEZoNVcwaFJxWnk2ZjI5NnpRTW9NdTNEK2VJei9PVW5C?=
 =?utf-8?B?WEFMRmNSODlxQ095ZDZDYzBDUit2clNMTVNnTGMyaHNaUldRYXZWVmhDd002?=
 =?utf-8?B?dG9CVlNrQWswUGFucURDVlFtcGRaendreHZjUGxaQnJoNTl5QitnSDFxT3Iy?=
 =?utf-8?B?bU9ScjBSYkdjMzFuSXhRY2FlbnFpbW92L3V4NjFxbDg4L0NZUFFjNU94a0sx?=
 =?utf-8?B?K245ME8rc2JsVDNmbWMrZGhMQzRuUkxza1liVWlsOWJsTEIrY1NmeVdyQ1Zt?=
 =?utf-8?B?V1FCa0dFRHIrRG1NVnJ6OFlyTFozRXdHbXVZdEZ2UWZwaWVodTJHM3gwNFJr?=
 =?utf-8?B?bHQrMnJqQUwyeElKY2JVVGpLTk1LekgyQk1pMitmWDVBVXlkR1hrV1JqMFBM?=
 =?utf-8?B?ZGVZME9MekRCSldjNGVQUXQ0MkJqeDdLY1RvRUZOVndBTm1OZG5hN1JOeEx6?=
 =?utf-8?B?UEluS2JROEc1eTd6REFYL0lNcGJMN3hEbUhJMVI1WnZlTmZhR0hIVklWZVgy?=
 =?utf-8?B?SUtvZzB3N0UrZDlReXdJMXE5QTZvVHZrdEd2Rm5yZHVkLzJBd3grODRBLzY5?=
 =?utf-8?B?U1piaGtKaVVJSnJ2cUFWRkZTNzhIVGlKNWhtV1pPaUxIb2E0cTlJa0Q0SVJZ?=
 =?utf-8?B?WU9Qd1dlSytzS0NsUlRIb0ZwRlBNenllOEZ2aWFmdWoyVi9xQkordjZjZzFu?=
 =?utf-8?B?VGFjZ2JxcDVJNVVVZnFSc1pITUpMUkphTUQ2My9NQlA2N1F3NVBMQ2NhMnBj?=
 =?utf-8?B?M0lqaWhkaFBSSWptN1pYNnZpRU02QjBWM21VOTl5KzVPNEdnbkhMQ3hyVFpl?=
 =?utf-8?B?YnVBdWhBTG1lTjhhKytPWFZyTHVhYjVjdUZPem1rU3NOekJmZkJoVGZGNi9s?=
 =?utf-8?B?YnBUUnM0SmhmcE44eGpodzBCNXo3QzJpZWlHSFZVY3ZVSExVWGFLeElaSTZa?=
 =?utf-8?B?NWhkNGZoMm1uaEtwM3YwM3ByUGdCSVhwTXlaRWoyeGd1SUp5bjhqYUpyMS8y?=
 =?utf-8?B?RHdWeFZnZWcxVFZ5ZVFUQm5MTVUxdmpDMVV2aWExZXBycmhNZUJkdVFNME9h?=
 =?utf-8?B?bjBwcHVFcVFhaWVSWm5iaGxrU0gyRTJBWWNiU29ldVNYUFNGajArdEtMSE5j?=
 =?utf-8?B?aXh4aURFaFlxblZqWGlNdHBobzhCYytuWWF0UG51ODIrT3JJOTNabHBJcTd1?=
 =?utf-8?B?ZURMR25CeVpaQTRlL0loV1dxZUgvU2pyNTgxcHd1TDM5b3BvWFhuRHFYU3Ja?=
 =?utf-8?B?aDVlTlNlbUtyNWcyS2c4azRZY2FCVFhPT0J3L2xGb2lGbFdUN2N2My90eG40?=
 =?utf-8?B?R0ZDV241ZEcxQ09SU3FadTdVcnJRNSt6WEk3ZmFDancrNitYaWhUdWZuN21E?=
 =?utf-8?B?SHhFUTlDQ0VpV3hQNVpHSmxKOHhJN3VYRXIydGhHeXhFTW1UR3BNQXNPZGlz?=
 =?utf-8?B?VFJEcU83Mlo3NFd0Qm5vTmN6VzlXNlplUk9hNkhaOWx6RTlBOEhkcmpGTG0w?=
 =?utf-8?B?ZHd5Z1lnRytnQUhyMlJ5UExqRFo5cUZJWjU0RkZVTjRaeFVFRTZHT3NWUlBq?=
 =?utf-8?B?NVBGMGp3dzhFMzhBZ1JvTm9RRVl4cDNzVDAwanFiU283MnM3emZIL0VaRHB0?=
 =?utf-8?B?QkV5d2toYm9WS2VNSUdrdW9RNDZCdUtHYlo4N3JXYVd2SGZ6cGpuZ1FnMHhT?=
 =?utf-8?Q?6bOA0P2V8ABB36ty70f0cEo2o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dfd3734-2e8d-48a3-e48c-08dd1e0caf11
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 20:03:18.3036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jG395MkiAh5e5yg8jgdih80lm16m1KXLpvDay6m8lwCMQRPjogK+r7F2s/+/mMNxMU2YXlLMXcI9kWV2Th0x3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7501

Add the compatible string "nxp,pf9453" for the PF9453 regulator. The PF9453
is similar to the PCA9460 but supports only LDO1, LDO2, LDO_SVNS, and
BUCK[1-4].

Restrict LDO and BUCK numbers for nxp,pf9453 and keep the same restriction
for other compatible strings.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v2 to v3
- LDO_SNVS to LDO-SNVS
---
 .../bindings/regulator/nxp,pca9450-regulator.yaml  | 24 +++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index f8057bba747a5..a5466bece4cf7 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -17,6 +17,9 @@ description: |
   Datasheet is available at
   https://www.nxp.com/docs/en/data-sheet/PCA9450DS.pdf
 
+  Support PF9453, Datasheet is available at
+  https://www.nxp.com/docs/en/data-sheet/PF9453_SDS.pdf
+
 # The valid names for PCA9450 regulator nodes are:
 # BUCK1, BUCK2, BUCK3, BUCK4, BUCK5, BUCK6,
 # LDO1, LDO2, LDO3, LDO4, LDO5
@@ -29,6 +32,7 @@ properties:
       - nxp,pca9450b
       - nxp,pca9450c
       - nxp,pca9451a
+      - nxp,pf9453
 
   reg:
     maxItems: 1
@@ -42,7 +46,7 @@ properties:
       list of regulators provided by this controller
 
     patternProperties:
-      "^LDO[1-5]$":
+      "^LDO([1-5]|-SNVS)$":
         type: object
         $ref: regulator.yaml#
         description:
@@ -100,6 +104,24 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,pf9453
+    then:
+      properties:
+        regulators:
+          patternProperties:
+            "^LDO[3-5]$": false
+            "^BUCK[5-6]$": false
+    else:
+      properties:
+        regulators:
+          properties:
+            LDO-SNVS: false
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>

-- 
2.34.1


