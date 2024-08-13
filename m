Return-Path: <linux-kernel+bounces-284103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8869C94FCEB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A5F2823C0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159DD33987;
	Tue, 13 Aug 2024 04:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z9zpFMLM"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13352249F9;
	Tue, 13 Aug 2024 04:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523773; cv=fail; b=GFhdYK7jtcpEq9i4OeJ+a6tjVMPhZkpVsYHd2B2sjU9bXy15O9FZHZWQ7UaULXmDWRizdaLpBRiHhYNnUMkal44E0XF6/1s405HUyjY6Z+q4jk/QYGUka2NfX+9lx+QuvGGu8n6GYW1OZ0bMnZ9DblCiWSjV/OeqkcIQkiq7eaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523773; c=relaxed/simple;
	bh=ntv8+a0b0cCJDPSd4QFjKGTB36LdRaVFWXIvK3931a4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tpPneFQqSyYV2UtlL84fs4oWI7EU141WAVFzbqWn6mM7PzZptWBV9U8Xmg8kAzTU4fx43BXRxES2fwmKkIyLq6ykvvipWWKj7UaNIWwF+UqHvCDDPr+zFCUEcWozXQykkD44iAnMLn9N9V9inUxx4vFM/9S5YyHhf4yJ9CV4niY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z9zpFMLM; arc=fail smtp.client-ip=40.107.22.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxFCO2sdvoUzyTv6s71RVsiBBSZwsviWlzD+pgqvYZy6CgU2Pvd01l8l0WZFLx8f1nXKLv6WISa05ZFh7U4HrHTer3wpDOy8/muIBIO/Lgbvn5FXRqMDuv8d4hxIOwvpNYZgBmCOS1vLVST/wwiuwgmZL5sz31A7rz0RfO8xLJM7ohYHlV4dZTlgKeSRWYmpCexOx9y+81V1mcNyWZX8RPtYJCa+cVr7D69j784WF4gmIjPS4gIZzgm4eiQpVZecXMIi+IHgrx7ccU+fWKkrPksRkJXKw3tWBvyPOsWdg9jy/gANuhJfKshwTGU8xOmEN4tvzwDcdYGJKJP0E0rNRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8F/1ziFftUEOisf15A05tXH9s9Hk5S22oJbdvXMiP0=;
 b=ZrEerbrikgiD2zLjwenrSzo03seR23pQzecfjVC103GOcBD7kmo2uU1C4LUKnKaaJl3ymcex/0lzUkwBDI6Dc5RfMzwrhKcCcoOcBfaQY6JBK4Tjc3ruyugbxR/F9ulbWTTvHOfu6TuKpUJ2T/rLKGgCxVM8LXchtmt1g07N+D/kKZtZTSpZlVhsXk8KemBb8ZWQmfcLH0x7oOdcd9cuG1IQue/CATh9KCp6fNlEyetgEizCwvRIQcEVXp9ezeQMqNUE6I+9ohBuKFRZBY87DckWNmV6A3Nu+kk60EhiJJhYB8svWp8Tnv5PL9aaWo5WZOqD9V4IQgBX+9wFY5zPAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8F/1ziFftUEOisf15A05tXH9s9Hk5S22oJbdvXMiP0=;
 b=Z9zpFMLMhyo5mxGYspaGfjKlrtikUSvJSyuK0s1i2aGLkobMTuQk1/hGOZqsRTaDbD5E7SHt/jnIr+rXSvw5qTSmQTb4xsXazZB0VE9h8ngW4hY8hg23AlAqzTZr0c5kpvlsbDh19sqY73l6CeFNPsqHMr+jex4aXoejKhgnesTmcPLaHG56QtK1H535ZwrrXFdrVhhvgc3zFVyJDUvn2P3GKAzkweOafLVGKE3iUgvsv4L7gWCtFH9JWkHkykODkwgzM9r6iYRbyN9dkY9BDLXuDa0ESpcQE15Ncbbgqj7l30A4gYoD+fg0Q10DydIlHmSMeDvMh9lov98uWH8Qqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB10066.eurprd04.prod.outlook.com (2603:10a6:10:4c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 04:36:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 04:36:09 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Aug 2024 00:35:11 -0400
Subject: [PATCH 16/17] arm64: dts: imx8mm-beacon-kit: add DVDD-supply and
 DOVDD-supply
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-imx_warning-v1-16-3494426aea09@nxp.com>
References: <20240813-imx_warning-v1-0-3494426aea09@nxp.com>
In-Reply-To: <20240813-imx_warning-v1-0-3494426aea09@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux@ew.tq-group.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723523705; l=2855;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ntv8+a0b0cCJDPSd4QFjKGTB36LdRaVFWXIvK3931a4=;
 b=sW+QM5zsCggkqJnQCiNNSd5pXeSJtbSPjSM4sI1yzJIgNN64HzGMkjKQn/dHTeDWIxdf3gIrQ
 YUx598e2WFCCbeOLe8FxktANkPS1usZ796afWyBRitTBgFGfOc6hRRB
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:217::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB10066:EE_
X-MS-Office365-Filtering-Correlation-Id: 37613c91-a8f9-4a86-53e5-08dcbb5173f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cW1RdVVsVjVjbjBodWFVWW9RZUVlWFdVR3gyU2g0R212ZXliTVdacytPb1cz?=
 =?utf-8?B?LzdFejFrcUhaY2laTDZMeEhJM1ZieEN5UVFoY0UyOEwvUGVYUEh4enFReHNs?=
 =?utf-8?B?c2NnVmNYLy81SE9TRGdXbUpqeFJUTG1PN2p5M3kyYnFGQXBqdUdKUXU1djZU?=
 =?utf-8?B?TXU2dHo1NWlXaHNQZXZsUCtTbTZhMXJ5c2JXMGdlaXp3cXhSdFg0Y09DcTNj?=
 =?utf-8?B?OWkwd05Yc3piUnY3K0NBY2dRdVhpTUdCWUdlY1RsMWxLazN4MFZPVGJuZTlS?=
 =?utf-8?B?MTRLbER3dFpEZmhnTmNvdnViTVdIV3BFc28yZ3pSVGZoNVNHdEhjWDdzV2ph?=
 =?utf-8?B?WHVrYjNRZVk1dk5qb2hEOU5oWlBRaEFRTTJoby9CNG5ma0JpTEw1TU4wbXpu?=
 =?utf-8?B?d1pOVis4dStKT3NTSkdWSklscHhaa242QVlWdVhUZDg1cDJmZUpHT2FPM0lL?=
 =?utf-8?B?Y0FiTFNjdm9WVk96UVZqak1abThEbGRTS1NKUkxaMUhFK0xBbFFqMmUxUHRy?=
 =?utf-8?B?WW5IdTZHZ081SHVDM3ZZSGZCMllHcjVVeDFLYWNsSXM4dnA1OTBIVkREMlBi?=
 =?utf-8?B?L05Dbzgwck5Xb0p1UEcrWmUxZTYxSlpjMXZxNWJVdE1icHlIb0hieE5lclJ2?=
 =?utf-8?B?ZHpHcVZVRXcrNUZSTUhXSEFIdlgvUmJKaHczWVh2WDRNODlKWGVwVGQrZ3RX?=
 =?utf-8?B?NE1Hc2dURWFRanE5SFE0SHV0OXF6akpZQ0ZCWm0xMFhHY084eUdETHpjNUNa?=
 =?utf-8?B?VTdCSEI3S2M1dk9xM292a2FIVlMwdHZSQ1VsOGREeWpaVlRpSEZjb1J0WUdC?=
 =?utf-8?B?WHBuK09zcWtVZDkzV0VrV1VDdlhVWFkxTGJNTlRpN28yTUV0b2U4YU45eGJN?=
 =?utf-8?B?VjY2ZmpGcTNlVGpSdmtQY2VDOHZiMGhrdzJGVG9VbHBJSUp2K25oQ0ZpdFdG?=
 =?utf-8?B?NEt0dXZmbE10NHNDZkZCaC9vZEkzOGp2QjB5WXUyT2NMem9CN2JzeDFOVjBM?=
 =?utf-8?B?a0s5VDBlQUtISUNuUElBOEFmMFlNOElhcitwNkcwTWE1eGQ3bm1pVHJ0eUlP?=
 =?utf-8?B?RThIMmdJVXhHR1g5Zk1UaXIrVjFjUC9BMWtqWjZieERqNWxWOHE5bnFpd1U0?=
 =?utf-8?B?ZzJ6NVFTcElXT2NaS0VBaGZlajdRY3czSlZDNlFiYnJHY1cwd01DWmphNm83?=
 =?utf-8?B?TDBLWHFtREFxMVFERVdkTTBBcy96VUR6S1NNOXZOb3I5TEZvak9GOWpjNVZJ?=
 =?utf-8?B?OGFEM2hiellTaDJVaXphUzZhdDVxNCs5Vy9ENm10Uy9hRFhoaVVEWjdNTTNx?=
 =?utf-8?B?cUV5emxVanJQa28rbFpXZkVpL0VSYnp3N25NL2d6UGtzN0FFZ2w0a24rQmNU?=
 =?utf-8?B?ZnRSSTVmN1VJVmNaclZHTjlBdW1TcEpzelhWS0VuUFpxY0NJZmZBZmJ4RXRy?=
 =?utf-8?B?bzA5Q3Y2WGFhUlJMTHEvbS8vZ3JXYXVwMW12b1ljc3JqQkZUL0xpQzVnTkdI?=
 =?utf-8?B?WlVMQTNGby9IMkpRMGZpU3FTeEhXK1VDeEdKZmhyNlppcTBBYnlzbVlqKzdU?=
 =?utf-8?B?WE0yWUcwMDZzbmlqKzJyNTJaUTBSYU00Zmw0bm1ubXlNbXpzSzJCUmlNNVBn?=
 =?utf-8?B?ditrRnBtb1NOSzdBRXZ1RHhVSjd5YXdqcWdFT1pyYW9JazA4eHFxK3JIdk1h?=
 =?utf-8?B?RWNSVGFjV2tTZmJpdUg1RkwveTRzNHoxTHZuV1BvazdoVkIwV3JZQ0FheEJo?=
 =?utf-8?B?NkFQNU90Um5TcEZqeXMwZmZVd0RKdWlGY2k3UmwwYUh2U21GaE5Sa3dGMTc4?=
 =?utf-8?B?OVM0WDBNakFzdmJYeldQYjIvRTcrUTRVSWlocGswN1lkbjF1TzFlM011dXZW?=
 =?utf-8?B?THlPZXBrd0pHR1h1b21aSVhXK3krbWYzVjRPZ1JHTGthcnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHRuTHp6Qmtwakl4TnBDbENQb2lOdGNFUHY5S3FUOGF2WFlCMWhHQy9ENXFh?=
 =?utf-8?B?WGo0RzRUMjYrcVJ3RFBlUjdDaU1kL29YSXNOaDNHV1phUVV5UWJHcmRGeXhi?=
 =?utf-8?B?eEtqUzZYNDRIOVV1RTJ5ekUwUjhvYXdvUFpjcmQ4VE9TSlhDMW9QV3NOcGhw?=
 =?utf-8?B?WEk2WmVsNXBxTCtOM1U5TUg3MkxrWElMdFdVakQwTnhUL2NLakxGdkpXRDlS?=
 =?utf-8?B?SVFNZGFycTVXelBjTW5JRHpyalBnTDFMcEhyVHVxdUNzazgwRUY1eEJMS1JC?=
 =?utf-8?B?c21WU1NTNkVQZi9Nb3FaRDZ2eENTVDRzRFNjbnpzMktLcU9HVi9laWNVNmti?=
 =?utf-8?B?VHpBMytsRGo4MHoxQkc5TmVwSWRHWnJmQUF2OXhIQy9sb1NDRXVEeGtCeWtr?=
 =?utf-8?B?UnV3TnVESER2MGhNRXh6ZTJwbTVYUGZ3d1U0aVk0bTNhd2dZdXc0WHdSNjFU?=
 =?utf-8?B?dE5Sd0QxQ01OYi9jd1FtUktLMGd4QlA4TlI1WE9Zc2RXNHpydG1OUThicFp4?=
 =?utf-8?B?MHJVSVBrMW9aNFZwMjVJck82WVM2L09RQlYyd0NyWFFObWRKYVZwcDU3SVVs?=
 =?utf-8?B?WmpBWEE1K2dRbFA4Vm9UV21zUlhIbjZ2OXZMT2dkQ1pWVVg1a2djOUdEZzJx?=
 =?utf-8?B?TTh5M0pyejFVRm9YYmRuUk01YmhKZ2hsUnA1bzcweXFSaUV0Vy9acEc0bzF4?=
 =?utf-8?B?SlZKZ1YwMURad3lZSStVd1dlb2FjNTZpN2pnOE0wMHRhTDJTbzFhRGRzMmNp?=
 =?utf-8?B?djcwMlhENm95N0xoUVpWY2pKODRMMk5uR0ZVK0t4LzlRVCtDZE1FYmYweXd2?=
 =?utf-8?B?czRzNktrc0RuM3JEZ01OYzZKN0QrQXg1K3A5N1JpQTdaYS9LN1N3Vm5HZVlV?=
 =?utf-8?B?K0hYdWs2dEVYTTVrRVdLKzdhTmd2Szk2UzdKaEh2L3ZVNGNpQzIwY1NmaWxx?=
 =?utf-8?B?RWhoeHFWWE53QnpsZytRcEU1eFF5SklYczB5cWtYU1cyaEg5Rm5McWU1bWRs?=
 =?utf-8?B?MlBZYXBNZUdram53Tlk1UHVoRkt1N3pJZExrWG4wbWdtMzR0WWJZYkgwajBn?=
 =?utf-8?B?ZWtKT1ZQdzd6TlZUb0svTjhYMGVzaGhIWTZmcFloZGR1djMyYnVpVVBYczBK?=
 =?utf-8?B?b2FnMWJmYVpTc0FRWnNlMnA0dS95akFJWVhITkdjemZIY1hTb0FlaW5ucTFW?=
 =?utf-8?B?K0JpcjFkc0ZxRENGSFF1T3UrcVFmVHFGSi8zWlVWek5EbmtzeS9xKzlaamI3?=
 =?utf-8?B?SDZHUXlkMnljMU9kcEtPWmlBaFoxNWdSZFVwY1NDYkpiWjRoZktMbndqd0tZ?=
 =?utf-8?B?V3B3cUlXWHFMNHNvVGNjV1NOYzRKdFVycW0wWno5ZkVoSXlQNjVTUlJURW91?=
 =?utf-8?B?c040VlYwQmFsa3JOTVdHZnc4dXRldy9rdy9zSXFscDlENG9Jc0x4OFFQbVFG?=
 =?utf-8?B?UVhFaFJ3bkVZcVBIUmdyZDV0blluVDFidStoeCtuOXFGeE9jNkFZaWU5STdC?=
 =?utf-8?B?ZWtKWDlydHBncktiRVcray8wN3NWSVZtQjJPUWNqdW4vL3ZKd2NxTytQbnB1?=
 =?utf-8?B?SUF3VzRJN0tYR2dTaGp5RTNtOHQxMldSakM4SFdka2RRaDdjUE9hZEhxMVR5?=
 =?utf-8?B?bm1FUkpLV2pJNXZqYTRmMm0wTnZwQXVYckYwQ284LzN4aUptYjBVRE9QS2hO?=
 =?utf-8?B?M3BFcWVaNmwvbCt6L2s1WHlWeEFtMzN3UU93V1V3bXB0TENhRmQwUXAxcTFE?=
 =?utf-8?B?d2tkdVNVb25DNFNDV1BYVkxkNUNZaDNrdjh6cHVhUnZXbVpYZUh5OGVCN1l5?=
 =?utf-8?B?ZnZqTkxNSjBwSzJwa3pnVnVPdVl3VXQxSnE4VjlFSGZqV1lKMW1TQTIzblhk?=
 =?utf-8?B?RGxCc25ST2tlbnhBeDcvRHdXbFpCYkwzNUhCT1FscmMyS3d1eVdCc3ZwS0gy?=
 =?utf-8?B?dXlaTGMyQ2lleWdpam1kYnY0Ty9xUVQrSEovbEs3KzByK211aUxud3d0anpU?=
 =?utf-8?B?T2JCZnE1dHV5TnZRQnpMbVRWUXptdmpwMkZFSUUzUng0eGJtSCs1V0oyamdX?=
 =?utf-8?B?QnQ4WXJzdjlsVjN5dWJzb1RDam5WRHZQUkYvWXpUc1FaQUZBRytsaWdWOC9C?=
 =?utf-8?Q?4p+J+ZsQjiJPbF/8csXOTsRRo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37613c91-a8f9-4a86-53e5-08dcbb5173f1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 04:36:09.2545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzoF1WdoblZfVCqI35uExp8DyTygCw3fma8VFjh2sFoNstk+o70F4RBGwlxjU+zt2my6tXNy0oB6VaEWU+2h7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10066

According to binding doc, DVDD-supply and DOVDD-supply is required
properties. Add these to fix below warning:
arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb: camera@10: 'DVDD-supply' is a required proper

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../boot/dts/freescale/imx8mm-beacon-baseboard.dtsi      | 16 ++++++++++++++++
 .../boot/dts/freescale/imx8mn-beacon-baseboard.dtsi      | 16 ++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
index 6086dae2e5fbe..ea1d5b9c6bae0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
@@ -56,6 +56,20 @@ pcie0_refclk_gated:  pcie0-refclk-gated {
 		enable-gpios = <&pca6416_1 2 GPIO_ACTIVE_LOW>;
 	};
 
+	reg_1v5: regulator-1v5 {
+		compatible = "regulator-fixed";
+		regulator-name = "1V5";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+	};
+
+	reg_1v8: regulator-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
 	reg_audio: regulator-audio {
 		compatible = "regulator-fixed";
 		regulator-name = "3v3_aud";
@@ -187,6 +201,8 @@ camera@10 {
 		assigned-clock-parents = <&clk IMX8MM_CLK_24M>;
 		assigned-clock-rates = <24000000>;
 		AVDD-supply = <&reg_camera>;  /* 2.8v */
+		DVDD-supply = <&reg_1v5>;
+		DOVDD-supply = <&reg_1v8>;
 		powerdown-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
 		reset-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
index 20018ee2c803e..77d14ea459e57 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
@@ -40,6 +40,20 @@ led-3 {
 		};
 	};
 
+	reg_1v5: regulator-1v5 {
+		compatible = "regulator-fixed";
+		regulator-name = "1V5";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+	};
+
+	reg_1v8: regulator-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
 	reg_audio: regulator-audio {
 		compatible = "regulator-fixed";
 		regulator-name = "3v3_aud";
@@ -158,6 +172,8 @@ camera@10 {
 		assigned-clock-parents = <&clk IMX8MN_CLK_24M>;
 		assigned-clock-rates = <24000000>;
 		AVDD-supply = <&reg_camera>;  /* 2.8v */
+		DVDD-supply = <&reg_1v5>;
+		DOVDD-supply = <&reg_1v8>;
 		powerdown-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
 		reset-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
 

-- 
2.34.1


