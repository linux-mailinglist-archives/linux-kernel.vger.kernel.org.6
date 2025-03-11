Return-Path: <linux-kernel+bounces-555863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA44A5BD8F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 608303A660B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD67236428;
	Tue, 11 Mar 2025 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xp3WtuSp"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6F323370B;
	Tue, 11 Mar 2025 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741688220; cv=fail; b=V6/9TLhcD80h6j4t3rBOV/O5EPg7XKXCAuxNGxup2ZmM6DSrZWh4OJao/sT/cJEyCPrKA0RXPs9Lon4pEZfQPjDUe6IhyuwpeShmsWa7ojecNYi1BGhtoR6nzaWL51UAcTbQe0SVMVVUkxvrczPgJrA2U6G8nofRwYDOGtbt+Wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741688220; c=relaxed/simple;
	bh=d0DtLMQ1jhoIoFnMbjugcXva5LUcbXwG8rjuGE9xY3w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UzCD52IXTPH3lRbTwS49WHbZONzwmrt44oC43tCPakX0zdjhpTZAmeILdahC5/M3v/5YjsFRZw2NltJGF8bzWK0XRNHGK8XVTTCYW6zJp5BS4DcqybGLfT2BLRo745Eb8RSRF6wvXQI1SUecvJjzP2A3O0r3rAgwwZPKoj63Onc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xp3WtuSp; arc=fail smtp.client-ip=40.107.22.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CvJTUX0aeDubxsDypWLh/ShW8y7cwyxMhF669c2Lz54ZgqxXELt+GGt0D5FexPH5jeC3cdknwFTL9MvjxM7WeIVGYIU/gvAlRdo1HSPWm9dfaeDxHa/zjNSC+6q82nexlAl77LuT9s5/3JQi2BH3I2OYnn7gRy88xUJPGbKr9QIzVH9SV4jhcfynAQ9zMKdzAVjwUseF0wL8jcLt7F384Nx3uaswXBx08k5raD7571KV7nEMI67Hc3E/kKnP/wWdliLSzDM1uaUqC88pC9Wa09YTDZiI/1PF2LJjR8C158m/f9JBXTyEuh+tc4DlwTJ1ep39w3zO5BnTkFeMeIJhsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkwZUojH0edcDIfUp/PYeHRPTaDt61ZEVAzihoDrGcQ=;
 b=u/yC5C7zEeTp18DWP82m2agc0//wDPvSOvUN1h0bJ6LapqrkaI0EfhPTfRUQJ0RWlhduk+DqOkB6BCThKic5JxtBSy2NDM+PKyd0kXD1/geCqsHRcO55WfQEJzAa+t5NQCbvBISLvwzrp3Yl5uq0xJU520tgNdNfs4xHxDQyEyad/uNX0zSp56JC8ih0EmgEiw4ocFrIdAz3oBjVSsP9pTGGD8h44YQaRwmPL7SPJqEVXgJtgl0cpwTRURX2GR2N8GoGANXG5ImVn2rlo5XBXT203mu0kkw6KvhEPcbZ68nFqQXdlFCJi+oXLYlpKhi1qYrVa3u6wy02geGaUMUgnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkwZUojH0edcDIfUp/PYeHRPTaDt61ZEVAzihoDrGcQ=;
 b=Xp3WtuSpVld3xibvD8zR6DYnSfVMoQ1cWyASt1Ac9xoDvIdUG/mMBpeTO+mDzMQG5ODt/r4u4fftDn7PoCre5hRJwXs34FgyyrMT3I6+QLXfNqjDY3yPMwLFobqWKdqrYXUQUQrUnr4hDsAIf+hTvkIpunTa/XoQkXByjV0YWoOHG4R9uLadXhnNoDBSlP79LYKtHEHbrNukQhknplAT6JpD+lYIubEHMo/ANxZ1ge0lUujnE3ot6C2nNb+q8EjG3Qky3VbVQGjbnzliPLMNpGwF+oNd+3ZAZ1q7CqJF7yegnv4DQt1O9Ih6xEuk4Qmoo7FiMd9nPJiEorBLZx+Qig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AS8PR04MB8449.eurprd04.prod.outlook.com (2603:10a6:20b:407::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 10:16:50 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 10:16:49 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Tue, 11 Mar 2025 21:09:36 +0530
Subject: [PATCH v13 5/5] firmware: drivers: imx: adds miscdev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-imx-se-if-v13-5-9cc6d8fd6d1c@nxp.com>
References: <20250311-imx-se-if-v13-0-9cc6d8fd6d1c@nxp.com>
In-Reply-To: <20250311-imx-se-if-v13-0-9cc6d8fd6d1c@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741707617; l=39609;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=d0DtLMQ1jhoIoFnMbjugcXva5LUcbXwG8rjuGE9xY3w=;
 b=rG899Rxl+SwrpzMHlSPcPM5jt/LDCOtRUOxduX2gqSYq9lhvA7qsUKNeRux5o3JBbbHcruWZt
 vAfPVTV6C/ABYLG22bmwd/oMD6zM776ml6Df9p5k8ODkL9DLdEWJmgk
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2PR02CA0094.apcprd02.prod.outlook.com
 (2603:1096:4:90::34) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|AS8PR04MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 9891c4ae-c067-4e8d-6fc2-08dd6085d639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmFvWVVnSVNyVHdnV2hZRXRrWDdnMkdBV3VHeDZEOVhpOWMrL0pyeVZvWHFZ?=
 =?utf-8?B?dHhNRGN5QS91N0hRbHpzcExCS2FXRFFkMGdMRFhBUG5LQ09Ub1V6cUZDOURG?=
 =?utf-8?B?Nm9pUzhPUnFRbUZkdVJka0VaUFQyNWQ3cmN2UDNMaHBpQUhsNlJuNDE4RW5l?=
 =?utf-8?B?SVlpQkFuazByeFVFbmNtMEczdXM1UFExWXZvUWJJVUNQMnN4emY1Z2JTc1ZR?=
 =?utf-8?B?SlhmQWhTNzZKeGRkeWZOZjZCaHhQWkk1NE16dkNUaWhmbmozUmxoVEIvU0tY?=
 =?utf-8?B?cEZWVmZpaU1Wa3FqM041dTR1VHNFemNmZG12U0o2NFpIUWNnTVEvZzZxZUxU?=
 =?utf-8?B?L2Y3RkQrWDEwM01TUTNMeXh4MTFxRkY3cEt4RU9Ta1JCYnY2M1drZ2lpbHBD?=
 =?utf-8?B?aENiR3NjSWppZGU5MEFIaUJLUy9OOTU4OFl1NjZveEd1dFJPV0FmSEpLMjNu?=
 =?utf-8?B?RS9SU1R4Ym05ZHZObEQvLzF1N2hEZ1JKYWMrQ2U0Mm5GNFZRVDBuaEpUUUtK?=
 =?utf-8?B?Um5jV0Yvb1lnbUJDYnIxRVVMa0VhMEI0RHZLMDBQQXEyOVFtV1V2WjZ5UFpt?=
 =?utf-8?B?MTBmSnNuenB0YXNKR3V6WHVBc3JLWHQrWWV2eGQzOXdLajZhclNhTFZ6OW9n?=
 =?utf-8?B?K0xMM2M2bktYMm1Xek9wZkg0K3pLYmtxSnpkL0Z4QkJIVjlmQXBoQ2dEbXlj?=
 =?utf-8?B?VFd0QmpWY1FObWdBVHVrR1Uxa2dZNmNKeTdENlk1a0tvY3E0ZGpKSE93blJG?=
 =?utf-8?B?Y3pjZTMxcFhncUhlcVE4dSsrak9YWmRvYThDWWpva2owQkpUUzFXZlpPT3ht?=
 =?utf-8?B?UXA2LzJmUU92T0hKK3haVHdEZzhqUDIvNzR3ekdXOTRuTDlkNFhzMmtDeUpZ?=
 =?utf-8?B?UVlTTEwwZEt0VWZwU2NEcGFvdndzeGpQZVV6ME1LSmlYejJtU2p3SE4vY0wz?=
 =?utf-8?B?QzM0ZlRvM0pvZGp6SXMrejFXay9ncEhwelM1RmZYZGxkeXZxeWxndkN0N3Nl?=
 =?utf-8?B?RnJ4NlMwNHlkdGUwSENNcmFjRTVlWVMxZkRCRnh4OXRyUHJvNFpRelhWU2x5?=
 =?utf-8?B?VFRTMGgzRnR5bm9LdHhoNUJYTEZyVWUxb0NsY2dVS3J3czZnVFhBbCs4Y0Qx?=
 =?utf-8?B?UXpsVTV2NVhzSlRvVHdiTUErdTErb3FnWjdkTHkxUENzUjRLUXgySTlIQVRx?=
 =?utf-8?B?MjUzRW5KdXVjRENCajR3MWtRWkJOanQ5eDZXWWRteFV0bEtreUxTNWhaVmdS?=
 =?utf-8?B?ZTM2bzVXSUhZK0RoQ3BDdU9ES3JxbFdsWTg0NmFCRXFYRktmUFVvYStwb250?=
 =?utf-8?B?aE9qRXdFVWZPNzJ4ZmNPUktlVHUxVlZjWTVDd0haZlNadnZSN0ZvRVpJcGFD?=
 =?utf-8?B?Z0Z3eG5jc0lyQ2FERnZZZFhlNTE1dDdZdGJrZ1JMYlgzZWRYZFVBQnlpcTA2?=
 =?utf-8?B?eXArajMrVGVUWUhDMnM4eXVheUlRL04vdnJSOWZjOTdQYklLdG9rdFIraTdi?=
 =?utf-8?B?NlRyb3k5NGhzTHNvNFBCNC92RHZKeFpiVkp4bkVZVS9ZU0puaVhodURQUmVY?=
 =?utf-8?B?alJaaVc1VlhZSkVQRUtMZjlEajU2cnlMNkxGbmQzWjJ6ckpUeFRSQWdKMUFm?=
 =?utf-8?B?V054aXJJZVJFU1Y2NXo0UDNnTGVWUWczQ2ZmUVozdUZORlM2VW1HVjhPKzAw?=
 =?utf-8?B?MGw4T240Zm1ROHV1ejF3Qm14aUJqbFZCVTFPdVdKT1JYYWhKYTRhK2dmTGsw?=
 =?utf-8?B?TVR4M3dFSnhBcHNERnRwSE1uNUgrbEJzS1IyUEx4U2IrMjJQNUxkSnZZME42?=
 =?utf-8?B?SW44WlRYYjVTRStGZmtRRW5QTHpEWXNUSXdRN1MwaWorQzcvYTh1aWoxQ0Jx?=
 =?utf-8?B?aTZ4OVF6aXplWXFaQ0dHVS9yQ1FIZklqTVZBS3BpbzljQ0JNbUllOC9QZXgy?=
 =?utf-8?Q?s70h/zKy+lHfeTuHEz7bhdvFPaZ1upHV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHF3cUxZTkRFY0hnRXRoTldPTkEyWHAxWXBEMnErN1JENi9xckJaR1VZVlhi?=
 =?utf-8?B?QVdvYUtGeDhMdVZMRldYd21IS0Z3MlArNkt6Tkcwb1djbmx0SDBDSi8zL3FR?=
 =?utf-8?B?a1FrdVVZNFVScGxMdVBiVCtNY1VDRm1GaG1wOFdmU2hPdmtjOTFKTmVSSm5K?=
 =?utf-8?B?aHpBQVJLdFhjNGxsY25YVHJhOUNLVkNZMys5dWl3SmxIalZrciszMEt3dFRw?=
 =?utf-8?B?MVQ2M1oyMUhhUm1RWGt3NGl1bmovdzg0OE1xQ3RoTmxJc1llL1hDak14endh?=
 =?utf-8?B?WUExNUdUVWI0eXZGNEo5RjF5OEM5Q2E1WG5SbkltZHMwbUxCQnJKa3g0em9H?=
 =?utf-8?B?TkMzVHBURTh2cEdIZXdsM2NFcjk5bGNDUDFMSVZQbWhUVGdFYWZrZVZPellQ?=
 =?utf-8?B?dlNGaVgwVkg4ZFhGTXl5ZHg2MGRtWkpvSjRtQ0kzdmIrY2w2SW1yeU1wMDJv?=
 =?utf-8?B?cGxQY2lJZkFsblVxOWVyVGpBczRhTlZ0amRjTFJHTGE1TmhCSGhnVGVDTXRD?=
 =?utf-8?B?dXRWSFNCQW5JQVhLM0pTSUM4Kzk0TFUwL3pQbjdKOElUMnFzaTh3VjJ5S1ZT?=
 =?utf-8?B?Q0cvMW1OeWl6MU13Qy9tRmhrR2RqME9xbi82UHcrWFpuQWkwci9QWkx0a2Rl?=
 =?utf-8?B?Q3dtcmEyU0FXdmhZNXg0bVduYjRGTDZvUFRMMXVYWUEvdVhUZzBZTllkSzJB?=
 =?utf-8?B?bWdxeEVBc3RDR3hKVkZ1Y2ZFMHYwM0NodTNuYUljR2pZaDl1VHE5MUh4NndP?=
 =?utf-8?B?SU1xNnRzZlNUNENwTmtZc0dXS0ljRlBVUmF5TmN5b0srMFpPUSsxaGJMY0dC?=
 =?utf-8?B?MmdENXVpVFNaemU0ZWt1WDZyejgrZEJ5bFZvdTJPUXBrUnBBTTlmaTFJc29y?=
 =?utf-8?B?SVd2RElBdFowbTgwelpPcnVCMU42d0JrSG5rSEM0VEVXMVFGcUtVSWQyUmdQ?=
 =?utf-8?B?a0o1VVhUZVhDdnNna0J4NWw3Um41cjZQbCtOUk1kcVFwdlNOOVFjSlI1WS85?=
 =?utf-8?B?UkNFT2thSUdRcGhlVy8xZWdLTE9vRytwS1FBZHA5anQzT3Z4K0ZYNzlteHJ2?=
 =?utf-8?B?L3R6M0xqQ04rWTN4TWJ5TzJwcTVGckVhT256eGpWTkZsT3RUcEU4aDdzMk1m?=
 =?utf-8?B?K1QyMnE2K0dZZjJQWE1FTUdnNHVwNldrNEt1QmpVSjNXRzZuLzZJaHZCQ3o1?=
 =?utf-8?B?NGFqdWc5ZEpWaTBkTWFVY3pqYVhOZTZDQjdhZGUxR2hFY3hVZWlaUWV1aDVk?=
 =?utf-8?B?VmdwVGYvMEgzVWwxaExDTkJJVm01TVlzOFZ2V2F4NmpqSVAzK1NCNHMwUjhF?=
 =?utf-8?B?Y0tHUEo0bCs1V0cya3IrQ3pMbkdKSUdNSWl4VFJRWUUxdXZ5WHgrb0l1dXV5?=
 =?utf-8?B?UXVJaEhraE9BVERhRmRNblc5K1RaRng2YXBCVHJCTlordWtCNWpJcWd6d044?=
 =?utf-8?B?TVZsYW83OFljRzV5S1pKM1Z1VE5NNGxBcVFNZXhaeDA2cmlrU1JPT3hGMzRG?=
 =?utf-8?B?WjV1NmZ0NDdsc3kxL3Y4aWdzQ2EyR293Sm1aTTJvUmpHVENJVS9BYnJmalhx?=
 =?utf-8?B?UG1oN0ZxRFNVUldrVnFqUnBxeXZqSHVnVlRwY2YyYUx1czJLUjVuVFAxaW95?=
 =?utf-8?B?SnM2Y0JRQ2FQNkdBbzcvNVNyZy8xSE1hTnZORXBCdjlpTENnb0pJZDByTUh4?=
 =?utf-8?B?SThZOWh5ZktJRTFtSXVHaFl4QUZ3cW94UzFJMXRzNUYzdVAwQmZmamRVV3M2?=
 =?utf-8?B?TjhDVStyWlhQbm9yQWZFenFnVTExSzBDbnhOZmhGNTk4VkhaK2I3N0RZbjcx?=
 =?utf-8?B?WkUxR0JSOHZ2SW5zZlpxLzZmeVFucWZHNUptK1lWdGRnQlNkZ25XbWgxa3lm?=
 =?utf-8?B?d25mN1k5RnRqTVVhaFlMYXA2UmV2Rkh6ckRNMzlVQ21aNjBYUHEyZGY5Kzl0?=
 =?utf-8?B?TEtjVGlWL0cwOU5vaHBIZzlrcmNNbVpkYng0VkM2a0xCVmhac0VKdGp6UUpy?=
 =?utf-8?B?dWozQ2FoSUJZK2VPNFZiM1ROMFhJL0FTOEJYVDZvM2VPU1ErQ2hFbWk3ZjIx?=
 =?utf-8?B?MzR2Und1QWFINEdRYU5vdVEzdnJsYXNhTTVMb09lR2U0VEJSU25yVHJ5azlB?=
 =?utf-8?Q?qJxszOAGo7Aa3JxHMY8O5my/U?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9891c4ae-c067-4e8d-6fc2-08dd6085d639
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 10:16:49.9262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: taPhUOnpbfO5RfR9AK4Kp3yMP+rmU9qN+wMPaiir7O5o0CsDQyyI2NGhs23yYCnvXpbcRUSZZbbrCoToREM1lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8449

Adds the driver for communication interface to secure-enclave,
for exchanging messages with NXP secure enclave HW IP(s) like
EdgeLock Enclave from:
- User-Space Applications via character driver.

ABI documentation for the NXP secure-enclave driver.

User-space library using this driver:
- i.MX Secure Enclave library:
  -- URL: https://github.com/nxp-imx/imx-secure-enclave.git,
- i.MX Secure Middle-Ware:
  -- URL: https://github.com/nxp-imx/imx-smw.git

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 Documentation/ABI/testing/se-cdev   |  43 ++
 drivers/firmware/imx/ele_base_msg.c |  11 +-
 drivers/firmware/imx/ele_common.c   |  77 +++-
 drivers/firmware/imx/ele_common.h   |  10 +-
 drivers/firmware/imx/se_ctrl.c      | 775 +++++++++++++++++++++++++++++++++++-
 drivers/firmware/imx/se_ctrl.h      |  43 ++
 include/uapi/linux/se_ioctl.h       | 101 +++++
 7 files changed, 1029 insertions(+), 31 deletions(-)

diff --git a/Documentation/ABI/testing/se-cdev b/Documentation/ABI/testing/se-cdev
new file mode 100644
index 000000000000..dad39ffd245a
--- /dev/null
+++ b/Documentation/ABI/testing/se-cdev
@@ -0,0 +1,43 @@
+What:		/dev/<se>_mu[0-9]+_ch[0-9]+
+Date:		Mar 2025
+KernelVersion:	6.8
+Contact:	linux-imx@nxp.com, pankaj.gupta@nxp.com
+Description:
+		NXP offers multiple hardware IP(s) for secure enclaves like EdgeLock-
+		Enclave(ELE), SECO. The character device file descriptors
+		/dev/<se>_mu*_ch* are the interface between userspace NXP's secure-
+		enclave shared library and the kernel driver.
+
+		The ioctl(2)-based ABI is defined and documented in
+		[include]<linux/firmware/imx/ele_mu_ioctl.h>.
+		ioctl(s) are used primarily for:
+			- shared memory management
+			- allocation of I/O buffers
+			- getting mu info
+			- setting a dev-ctx as receiver to receive all the commands from FW
+			- getting SoC info
+			- send command and receive command response
+
+		The following file operations are supported:
+
+		open(2)
+		  Currently the only useful flags are O_RDWR.
+
+		read(2)
+		  Every read() from the opened character device context is waiting on
+		  wait_event_interruptible, that gets set by the registered mailbox callback
+		  function, indicating a message received from the firmware on message-
+		  unit.
+
+		write(2)
+		  Every write() to the opened character device context needs to acquire
+		  mailbox_lock before sending message on to the message unit.
+
+		close(2)
+		  Stops and frees up the I/O contexts that were associated
+		  with the file descriptor.
+
+Users:		https://github.com/nxp-imx/imx-secure-enclave.git,
+		https://github.com/nxp-imx/imx-smw.git
+		crypto/skcipher,
+		drivers/nvmem/imx-ocotp-ele.c
diff --git a/drivers/firmware/imx/ele_base_msg.c b/drivers/firmware/imx/ele_base_msg.c
index eea86f50d276..ed70728f5418 100644
--- a/drivers/firmware/imx/ele_base_msg.c
+++ b/drivers/firmware/imx/ele_base_msg.c
@@ -62,7 +62,7 @@ int ele_get_info(struct se_if_priv *priv, struct ele_dev_info *s_info)
 	tx_msg->data[0] = upper_32_bits(get_info_addr);
 	tx_msg->data[1] = lower_32_bits(get_info_addr);
 	tx_msg->data[2] = sizeof(*s_info);
-	ret = ele_msg_send_rcv(priv,
+	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
 			       tx_msg,
 			       ELE_GET_INFO_REQ_MSG_SZ,
 			       rx_msg,
@@ -128,7 +128,7 @@ int ele_ping(struct se_if_priv *priv)
 		return ret;
 	}
 
-	ret = ele_msg_send_rcv(priv,
+	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
 			       tx_msg,
 			       ELE_PING_REQ_SZ,
 			       rx_msg,
@@ -177,7 +177,8 @@ int ele_service_swap(struct se_if_priv *priv,
 	tx_msg->data[3] = lower_32_bits(addr);
 	tx_msg->data[4] = se_add_msg_crc((uint32_t *)&tx_msg[0],
 					 ELE_SERVICE_SWAP_REQ_MSG_SZ);
-	ret = ele_msg_send_rcv(priv,
+
+	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
 			       tx_msg,
 			       ELE_SERVICE_SWAP_REQ_MSG_SZ,
 			       rx_msg,
@@ -230,7 +231,7 @@ int ele_fw_authenticate(struct se_if_priv *priv, phys_addr_t addr)
 	tx_msg->data[0] = lower_32_bits(addr);
 	tx_msg->data[2] = addr;
 
-	ret = ele_msg_send_rcv(priv,
+	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
 			       tx_msg,
 			       ELE_FW_AUTH_REQ_SZ,
 			       rx_msg,
@@ -284,7 +285,7 @@ int ele_debug_dump(struct se_if_priv *priv)
 		fmt_str_idx = 0;
 		memset(rx_msg, 0xCC, ELE_DEBUG_DUMP_RSP_SZ);
 
-		ret = ele_msg_send_rcv(priv,
+		ret = ele_msg_send_rcv(priv->priv_dev_ctx,
 				       tx_msg,
 				       ELE_DEBUG_DUMP_REQ_SZ,
 				       rx_msg,
diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
index 3fa8182b302f..d63346239936 100644
--- a/drivers/firmware/imx/ele_common.c
+++ b/drivers/firmware/imx/ele_common.c
@@ -6,6 +6,8 @@
 #include "ele_base_msg.h"
 #include "ele_common.h"
 
+u32 se_rcv_msg_timeout = SE_RCV_MSG_DEFAULT_TIMEOUT;
+
 u32 se_add_msg_crc(u32 *msg, u32 msg_len)
 {
 	u32 nb_words = msg_len / (u32)sizeof(u32);
@@ -18,33 +20,57 @@ u32 se_add_msg_crc(u32 *msg, u32 msg_len)
 	return crc;
 }
 
-int ele_msg_rcv(struct se_if_priv *priv,
+void set_se_rcv_msg_timeout(u32 val)
+{
+	se_rcv_msg_timeout = val;
+}
+
+int ele_msg_rcv(struct se_if_device_ctx *dev_ctx,
 		struct se_clbk_handle *se_clbk_hdl)
 {
-	int err = 0;
+	struct se_if_priv *priv = dev_ctx->priv;
+	bool wait_timeout_enabled = true;
+	unsigned int wait;
+	int err;
 
 	do {
-		err = wait_for_completion_interruptible(&se_clbk_hdl->done);
+		if (priv->cmd_receiver_clbk_hdl.dev_ctx == dev_ctx) {
+			/* NVM-D, SE-FW slave waits indefinitly. */
+			wait_timeout_enabled = false;
+			err = wait_for_completion_interruptible(&se_clbk_hdl->done);
+		} else {
+			/* FW must send message-response in a finite time. */
+			wait = msecs_to_jiffies(se_rcv_msg_timeout);
+			err = wait_for_completion_interruptible_timeout(&se_clbk_hdl->done, wait);
+		}
 		if (err == -ERESTARTSYS) {
-			if (priv->waiting_rsp_clbk_hdl.rx_msg) {
+			if (priv->waiting_rsp_clbk_hdl.dev_ctx) {
 				priv->waiting_rsp_clbk_hdl.signal_rcvd = true;
 				continue;
 			}
-			dev_err(priv->dev,
-				"Err[0x%x]:Interrupted by signal.\n",
-				err);
 			err = -EINTR;
 			break;
 		}
-	} while (err != 0);
+		if (err == 0) {
+			if (wait_timeout_enabled) {
+				err = -ETIMEDOUT;
+				dev_err(priv->dev,
+					"Fatal Error: SE interface: %s%d, hangs indefinitely.\n",
+					get_se_if_name(priv->if_defs->se_if_type),
+					priv->if_defs->se_instance_id);
+			}
+			break;
+		}
+	} while (err < 0);
 
-	return err ? err : se_clbk_hdl->rx_msg_sz;
+	return (err >= 0) ? se_clbk_hdl->rx_msg_sz : err;
 }
 
-int ele_msg_send(struct se_if_priv *priv,
+int ele_msg_send(struct se_if_device_ctx *dev_ctx,
 		 void *tx_msg,
 		 int tx_msg_sz)
 {
+	struct se_if_priv *priv = dev_ctx->priv;
 	struct se_msg_hdr *header;
 	int err;
 
@@ -56,7 +82,8 @@ int ele_msg_send(struct se_if_priv *priv,
 	 */
 	if (header->size << 2 != tx_msg_sz) {
 		dev_err(priv->dev,
-			"User buf hdr: 0x%x, sz mismatced with input-sz (%d != %d).",
+			"%s: User buf hdr: 0x%x, sz mismatced with input-sz (%d != %d).",
+			dev_ctx->devname,
 			*(u32 *)header,
 			header->size << 2, tx_msg_sz);
 		return -EINVAL;
@@ -64,7 +91,9 @@ int ele_msg_send(struct se_if_priv *priv,
 
 	err = mbox_send_message(priv->tx_chan, tx_msg);
 	if (err < 0) {
-		dev_err(priv->dev, "Error: mbox_send_message failure.\n");
+		dev_err(priv->dev,
+			"%s: Error: mbox_send_message failure.",
+			dev_ctx->devname);
 		return err;
 	}
 	err = tx_msg_sz;
@@ -73,32 +102,36 @@ int ele_msg_send(struct se_if_priv *priv,
 }
 
 /* API used for send/receive blocking call. */
-int ele_msg_send_rcv(struct se_if_priv *priv,
+int ele_msg_send_rcv(struct se_if_device_ctx *dev_ctx,
 		     void *tx_msg,
 		     int tx_msg_sz,
 		     void *rx_msg,
 		     int exp_rx_msg_sz)
 {
 	int err;
+	struct se_if_priv *priv = dev_ctx->priv;
 
 	guard(mutex)(&priv->se_if_cmd_lock);
 
+	priv->waiting_rsp_clbk_hdl.dev_ctx = dev_ctx;
 	priv->waiting_rsp_clbk_hdl.rx_msg_sz = exp_rx_msg_sz;
 	priv->waiting_rsp_clbk_hdl.rx_msg = rx_msg;
 
-	err = ele_msg_send(priv, tx_msg, tx_msg_sz);
+	err = ele_msg_send(dev_ctx, tx_msg, tx_msg_sz);
 	if (err < 0)
 		return err;
 
-	err = ele_msg_rcv(priv, &priv->waiting_rsp_clbk_hdl);
+	err = ele_msg_rcv(dev_ctx, &priv->waiting_rsp_clbk_hdl);
 
 	if (priv->waiting_rsp_clbk_hdl.signal_rcvd) {
 		err = -EINTR;
 		priv->waiting_rsp_clbk_hdl.signal_rcvd = false;
 		dev_err(priv->dev,
-			"Err[0x%x]:Interrupted by signal.\n",
+			"%s: Err[0x%x]:Interrupted by signal.\n",
+			dev_ctx->devname,
 			err);
 	}
+	priv->waiting_rsp_clbk_hdl.dev_ctx = NULL;
 
 	return err;
 }
@@ -144,7 +177,8 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
 	if (header->tag == priv->if_defs->cmd_tag) {
 		se_clbk_hdl = &priv->cmd_receiver_clbk_hdl;
 		dev_dbg(dev,
-			"Selecting cmd receiver for mesg header:0x%x.",
+			"Selecting cmd receiver:%s for mesg header:0x%x.",
+			se_clbk_hdl->dev_ctx->devname,
 			*(u32 *)header);
 
 		/* Pre-allocated buffer of MAX_NVM_MSG_LEN
@@ -153,7 +187,8 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
 		 */
 		if (rx_msg_sz > MAX_NVM_MSG_LEN) {
 			dev_err(dev,
-				"CMD-RCVER NVM: hdr(0x%x) with different sz(%d != %d).\n",
+				"%s: CMD-RCVER NVM: hdr(0x%x) with different sz(%d != %d).\n",
+				se_clbk_hdl->dev_ctx->devname,
 				*(u32 *)header,
 				rx_msg_sz, se_clbk_hdl->rx_msg_sz);
 
@@ -164,13 +199,15 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
 	} else if (header->tag == priv->if_defs->rsp_tag) {
 		se_clbk_hdl = &priv->waiting_rsp_clbk_hdl;
 		dev_dbg(dev,
-			"Selecting resp waiter for mesg header:0x%x.",
+			"Selecting resp waiter:%s for mesg header:0x%x.",
+			se_clbk_hdl->dev_ctx->devname,
 			*(u32 *)header);
 
 		if (rx_msg_sz != se_clbk_hdl->rx_msg_sz &&
 		    !exception_for_size(priv, header)) {
 			dev_err(dev,
-				"Rsp to CMD: hdr(0x%x) with different sz(%d != %d).\n",
+				"%s: Rsp to CMD: hdr(0x%x) with different sz(%d != %d).\n",
+				se_clbk_hdl->dev_ctx->devname,
 				*(u32 *)header,
 				rx_msg_sz, se_clbk_hdl->rx_msg_sz);
 
diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele_common.h
index aceb8c891ae6..3cf124f41487 100644
--- a/drivers/firmware/imx/ele_common.h
+++ b/drivers/firmware/imx/ele_common.h
@@ -12,13 +12,17 @@
 
 #define IMX_ELE_FW_DIR                 "imx/ele/"
 
+#define SE_RCV_MSG_DEFAULT_TIMEOUT	5000
+#define SE_RCV_MSG_LONG_TIMEOUT		5000000
+void set_se_rcv_msg_timeout(u32 val);
+
 u32 se_add_msg_crc(u32 *msg, u32 msg_len);
-int ele_msg_rcv(struct se_if_priv *priv,
+int ele_msg_rcv(struct se_if_device_ctx *dev_ctx,
 		struct se_clbk_handle *se_clbk_hdl);
-int ele_msg_send(struct se_if_priv *priv,
+int ele_msg_send(struct se_if_device_ctx *dev_ctx,
 		 void *tx_msg,
 		 int tx_msg_sz);
-int ele_msg_send_rcv(struct se_if_priv *priv,
+int ele_msg_send_rcv(struct se_if_device_ctx *dev_ctx,
 		     void *tx_msg,
 		     int tx_msg_sz,
 		     void *rx_msg,
diff --git a/drivers/firmware/imx/se_ctrl.c b/drivers/firmware/imx/se_ctrl.c
index 12a1ceb87866..f31d97045b89 100644
--- a/drivers/firmware/imx/se_ctrl.c
+++ b/drivers/firmware/imx/se_ctrl.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/sys_soc.h>
+#include <uapi/linux/se_ioctl.h>
 
 #include "ele_base_msg.h"
 #include "ele_common.h"
@@ -31,8 +32,6 @@
 #define MAX_SOC_INFO_DATA_SZ		256
 #define MBOX_TX_NAME			"tx"
 #define MBOX_RX_NAME			"rx"
-#define SE_TYPE_STR_HSM			"hsm"
-#define SE_TYPE_ID_HSM			0x2
 
 struct se_fw_img_name {
 	const u8 *prim_fw_nm_in_rfs;
@@ -140,6 +139,24 @@ static const struct of_device_id se_match[] = {
 	{},
 };
 
+char *get_se_if_name(u8 se_if_id)
+{
+	switch (se_if_id) {
+	case SE_TYPE_ID_DBG: return SE_TYPE_STR_DBG;
+	case SE_TYPE_ID_HSM: return SE_TYPE_STR_HSM;
+	}
+
+	return NULL;
+}
+
+static uint32_t get_se_soc_id(struct se_if_priv *priv)
+{
+	const struct se_soc_info *se_info =
+				device_get_match_data(priv->dev);
+
+	return se_info->soc_id;
+}
+
 static struct se_fw_load_info *get_load_fw_instance(struct se_if_priv *priv)
 {
 	return &var_se_info.load_fw;
@@ -286,6 +303,742 @@ static int se_load_firmware(struct se_if_priv *priv)
 	return ret;
 }
 
+static int init_se_shared_mem(struct se_if_device_ctx *dev_ctx)
+{
+	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
+	struct se_if_priv *priv = dev_ctx->priv;
+
+	INIT_LIST_HEAD(&se_shared_mem_mgmt->pending_out);
+	INIT_LIST_HEAD(&se_shared_mem_mgmt->pending_in);
+
+	/*
+	 * Allocate some memory for data exchanges with S40x.
+	 * This will be used for data not requiring secure memory.
+	 */
+	se_shared_mem_mgmt->non_secure_mem.ptr =
+			dma_alloc_coherent(priv->dev,
+					   MAX_DATA_SIZE_PER_USER,
+					   &se_shared_mem_mgmt->non_secure_mem.dma_addr,
+					   GFP_KERNEL);
+	if (!se_shared_mem_mgmt->non_secure_mem.ptr)
+		return -ENOMEM;
+
+	se_shared_mem_mgmt->non_secure_mem.size = MAX_DATA_SIZE_PER_USER;
+	se_shared_mem_mgmt->non_secure_mem.pos = 0;
+
+	return 0;
+}
+
+static void cleanup_se_shared_mem(struct se_if_device_ctx *dev_ctx)
+{
+	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
+	struct se_if_priv *priv = dev_ctx->priv;
+
+	/* Unmap secure memory shared buffer. */
+	if (se_shared_mem_mgmt->secure_mem.ptr)
+		devm_iounmap(priv->dev,
+			     (void __iomem *)se_shared_mem_mgmt->secure_mem.ptr);
+
+	se_shared_mem_mgmt->secure_mem.ptr = NULL;
+	se_shared_mem_mgmt->secure_mem.dma_addr = 0;
+	se_shared_mem_mgmt->secure_mem.size = 0;
+	se_shared_mem_mgmt->secure_mem.pos = 0;
+
+	/* Free non-secure shared buffer. */
+	dma_free_coherent(priv->dev, MAX_DATA_SIZE_PER_USER,
+			  se_shared_mem_mgmt->non_secure_mem.ptr,
+			  se_shared_mem_mgmt->non_secure_mem.dma_addr);
+
+	se_shared_mem_mgmt->non_secure_mem.ptr = NULL;
+	se_shared_mem_mgmt->non_secure_mem.dma_addr = 0;
+	se_shared_mem_mgmt->non_secure_mem.size = 0;
+	se_shared_mem_mgmt->non_secure_mem.pos = 0;
+}
+
+/* Need to copy the output data to user-device context.
+ */
+static int se_dev_ctx_cpy_out_data(struct se_if_device_ctx *dev_ctx)
+{
+	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
+	struct se_if_priv *priv = dev_ctx->priv;
+	struct se_buf_desc *b_desc, *temp;
+	bool do_cpy = true;
+
+	list_for_each_entry_safe(b_desc, temp, &se_shared_mem_mgmt->pending_out, link) {
+		if (b_desc->usr_buf_ptr && b_desc->shared_buf_ptr && do_cpy) {
+			dev_dbg(priv->dev,
+				"Copying output data to user.");
+			if (do_cpy && copy_to_user(b_desc->usr_buf_ptr,
+						   b_desc->shared_buf_ptr,
+						   b_desc->size)) {
+				dev_err(priv->dev,
+					"Failure copying output data to user.");
+				do_cpy = false;
+			}
+		}
+
+		if (b_desc->shared_buf_ptr)
+			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
+
+		list_del(&b_desc->link);
+		kfree(b_desc);
+	}
+
+	return do_cpy ? 0 : -EFAULT;
+}
+
+/*
+ * Clean the used Shared Memory space,
+ * whether its Input Data copied from user buffers, or
+ * Data received from FW.
+ */
+static void se_dev_ctx_shared_mem_cleanup(struct se_if_device_ctx *dev_ctx)
+{
+	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
+	struct list_head *pending_lists[] = {&se_shared_mem_mgmt->pending_in,
+						&se_shared_mem_mgmt->pending_out};
+	struct se_buf_desc *b_desc, *temp;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		list_for_each_entry_safe(b_desc, temp,
+					 pending_lists[i], link) {
+			if (b_desc->shared_buf_ptr)
+				memset(b_desc->shared_buf_ptr, 0, b_desc->size);
+
+			list_del(&b_desc->link);
+			kfree(b_desc);
+		}
+	}
+	se_shared_mem_mgmt->secure_mem.pos = 0;
+	se_shared_mem_mgmt->non_secure_mem.pos = 0;
+}
+
+static int add_b_desc_to_pending_list(void *shared_ptr_with_pos,
+				      struct se_ioctl_setup_iobuf *io,
+				      struct se_if_device_ctx *dev_ctx)
+{
+	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
+	struct se_buf_desc *b_desc = NULL;
+
+	b_desc = kzalloc(sizeof(*b_desc), GFP_KERNEL);
+	if (!b_desc)
+		return -ENOMEM;
+
+	b_desc->shared_buf_ptr = shared_ptr_with_pos;
+	b_desc->usr_buf_ptr = io->user_buf;
+	b_desc->size = io->length;
+
+	if (io->flags & SE_IO_BUF_FLAGS_IS_INPUT) {
+		/*
+		 * buffer is input:
+		 * add an entry in the "pending input buffers" list so
+		 * that copied data can be cleaned from shared memory
+		 * later.
+		 */
+		list_add_tail(&b_desc->link, &se_shared_mem_mgmt->pending_in);
+	} else {
+		/*
+		 * buffer is output:
+		 * add an entry in the "pending out buffers" list so data
+		 * can be copied to user space when receiving Secure-Enclave
+		 * response.
+		 */
+		list_add_tail(&b_desc->link, &se_shared_mem_mgmt->pending_out);
+	}
+
+	return 0;
+}
+
+/* interface for managed res to unregister a character device */
+static void if_misc_deregister(void *miscdevice)
+{
+	misc_deregister(miscdevice);
+}
+
+static int init_device_context(struct se_if_priv *priv, int ch_id,
+			       struct se_if_device_ctx **new_dev_ctx,
+			       const struct file_operations *se_if_fops)
+{
+	struct se_if_device_ctx *dev_ctx;
+	int ret = 0;
+
+	if (ch_id)
+		dev_ctx = kzalloc(sizeof(*dev_ctx), GFP_KERNEL);
+	else
+		dev_ctx = devm_kzalloc(priv->dev, sizeof(*dev_ctx), GFP_KERNEL);
+
+	if (!dev_ctx)
+		return -ENOMEM;
+
+	dev_ctx->priv = priv;
+
+	if (ch_id)
+		dev_ctx->devname = kasprintf(GFP_KERNEL, "%s%d_ch%d",
+					     get_se_if_name(priv->if_defs->se_if_type),
+					     priv->if_defs->se_instance_id,
+					     ch_id);
+	else
+		dev_ctx->devname = devm_kasprintf(priv->dev, GFP_KERNEL, "%s%d_ch%d",
+						  get_se_if_name(priv->if_defs->se_if_type),
+						  priv->if_defs->se_instance_id,
+						  ch_id);
+	if (!dev_ctx->devname) {
+		if (ch_id)
+			kfree(dev_ctx);
+
+		return -ENOMEM;
+	}
+
+	mutex_init(&dev_ctx->fops_lock);
+
+	*new_dev_ctx = dev_ctx;
+
+	if (ch_id) {
+		list_add_tail(&dev_ctx->link, &priv->dev_ctx_list);
+		priv->active_devctx_count++;
+
+		ret = init_se_shared_mem(dev_ctx);
+		if (ret < 0) {
+			kfree(dev_ctx->devname);
+			kfree(dev_ctx);
+			*new_dev_ctx = NULL;
+			return ret;
+		}
+
+		return ret;
+	}
+
+	/* Only for ch_id = 0:
+	 * - register the misc device.
+	 * - add action
+	 */
+	dev_ctx->miscdev = devm_kzalloc(priv->dev, sizeof(*dev_ctx->miscdev), GFP_KERNEL);
+	if (!dev_ctx->miscdev) {
+		*new_dev_ctx = NULL;
+		return -ENOMEM;
+	}
+
+	dev_ctx->miscdev->name = dev_ctx->devname;
+	dev_ctx->miscdev->minor = MISC_DYNAMIC_MINOR;
+	dev_ctx->miscdev->fops = se_if_fops;
+	dev_ctx->miscdev->parent = priv->dev;
+	ret = misc_register(dev_ctx->miscdev);
+	if (ret) {
+		dev_err(priv->dev, "failed to register misc device %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = devm_add_action(priv->dev, if_misc_deregister,
+			      dev_ctx->miscdev);
+	if (ret) {
+		dev_err(priv->dev,
+			"failed[%d] to add action to the misc-dev\n",
+			ret);
+		misc_deregister(dev_ctx->miscdev);
+	}
+
+	return ret;
+}
+
+static int se_ioctl_cmd_snd_rcv_rsp_handler(struct se_if_device_ctx *dev_ctx,
+					    u64 arg)
+{
+	struct se_ioctl_cmd_snd_rcv_rsp_info cmd_snd_rcv_rsp_info = {0};
+	struct se_if_priv *priv = dev_ctx->priv;
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_api_msg *rx_msg __free(kfree) = NULL;
+	int err = 0;
+
+	if (copy_from_user(&cmd_snd_rcv_rsp_info, (u8 __user *)arg,
+			   sizeof(cmd_snd_rcv_rsp_info))) {
+		dev_err(priv->dev,
+			"%s: Failed to copy cmd_snd_rcv_rsp_info from user\n",
+			dev_ctx->devname);
+		err = -EFAULT;
+		goto exit;
+	}
+
+	if (cmd_snd_rcv_rsp_info.tx_buf_sz < SE_MU_HDR_SZ) {
+		dev_err(priv->dev,
+			"%s: User buffer too small(%d < %d)\n",
+			dev_ctx->devname,
+			cmd_snd_rcv_rsp_info.tx_buf_sz,
+			SE_MU_HDR_SZ);
+		err = -ENOSPC;
+		goto exit;
+	}
+
+	rx_msg = kzalloc(cmd_snd_rcv_rsp_info.rx_buf_sz, GFP_KERNEL);
+	if (!rx_msg) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	tx_msg = memdup_user(cmd_snd_rcv_rsp_info.tx_buf,
+			     cmd_snd_rcv_rsp_info.tx_buf_sz);
+	if (IS_ERR(tx_msg)) {
+		err = PTR_ERR(tx_msg);
+		goto exit;
+	}
+
+	if (tx_msg->header.tag != priv->if_defs->cmd_tag) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	if (tx_msg->header.ver == priv->if_defs->fw_api_ver &&
+	    !get_load_fw_instance(priv)->is_fw_loaded) {
+		err = se_load_firmware(priv);
+		if (err) {
+			dev_err(priv->dev, "Could not send the message as FW is not loaded.");
+			err = -EPERM;
+			goto exit;
+		}
+	}
+	set_se_rcv_msg_timeout(SE_RCV_MSG_LONG_TIMEOUT);
+
+	err = ele_msg_send_rcv(dev_ctx,
+			       tx_msg,
+			       cmd_snd_rcv_rsp_info.tx_buf_sz,
+			       rx_msg,
+			       cmd_snd_rcv_rsp_info.rx_buf_sz);
+	if (err < 0)
+		goto exit;
+
+	dev_dbg(priv->dev,
+		"%s: %s %s\n",
+		dev_ctx->devname,
+		__func__,
+		"message received, start transmit to user");
+
+	/* We may need to copy the output data to user before
+	 * delivering the completion message.
+	 */
+	err = se_dev_ctx_cpy_out_data(dev_ctx);
+	if (err < 0)
+		goto exit;
+
+	/* Copy data from the buffer */
+	print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
+			     rx_msg,
+			     cmd_snd_rcv_rsp_info.rx_buf_sz, false);
+
+	if (copy_to_user(cmd_snd_rcv_rsp_info.rx_buf, rx_msg,
+			 cmd_snd_rcv_rsp_info.rx_buf_sz)) {
+		dev_err(priv->dev,
+			"%s: Failed to copy to user\n",
+			dev_ctx->devname);
+		err = -EFAULT;
+	}
+
+exit:
+
+	/* shared memory is allocated before this IOCTL */
+	se_dev_ctx_shared_mem_cleanup(dev_ctx);
+
+	if (copy_to_user((void __user *)arg, &cmd_snd_rcv_rsp_info,
+			 sizeof(cmd_snd_rcv_rsp_info))) {
+		dev_err(priv->dev,
+			"%s: Failed to copy cmd_snd_rcv_rsp_info from user\n",
+			dev_ctx->devname);
+		err = -EFAULT;
+	}
+
+	return err;
+}
+
+static int se_ioctl_get_mu_info(struct se_if_device_ctx *dev_ctx,
+				u64 arg)
+{
+	struct se_if_priv *priv = dev_ctx->priv;
+	struct se_if_node *if_node;
+	struct se_ioctl_get_if_info if_info;
+	int err = 0;
+
+	if_node = container_of(priv->if_defs, typeof(*if_node), if_defs);
+
+	if_info.se_if_id = 0;
+	if_info.interrupt_idx = 0;
+	if_info.tz = 0;
+	if_info.did = if_node->se_if_did;
+	if_info.cmd_tag = priv->if_defs->cmd_tag;
+	if_info.rsp_tag = priv->if_defs->rsp_tag;
+	if_info.success_tag = priv->if_defs->success_tag;
+	if_info.base_api_ver = priv->if_defs->base_api_ver;
+	if_info.fw_api_ver = priv->if_defs->fw_api_ver;
+
+	dev_dbg(priv->dev,
+		"%s: info [se_if_id: %d, irq_idx: %d, tz: 0x%x, did: 0x%x]\n",
+		dev_ctx->devname,
+		if_info.se_if_id, if_info.interrupt_idx,
+		if_info.tz, if_info.did);
+
+	if (copy_to_user((u8 __user *)arg, &if_info, sizeof(if_info))) {
+		dev_err(priv->dev,
+			"%s: Failed to copy mu info to user\n",
+			dev_ctx->devname);
+		err = -EFAULT;
+	}
+
+	return err;
+}
+
+/*
+ * Copy a buffer of data to/from the user and return the address to use in
+ * messages
+ */
+static int se_ioctl_setup_iobuf_handler(struct se_if_device_ctx *dev_ctx,
+					u64 arg)
+{
+	struct se_shared_mem *shared_mem = NULL;
+	struct se_ioctl_setup_iobuf io = {0};
+	int err = 0;
+	u32 pos;
+
+	if (copy_from_user(&io, (u8 __user *)arg, sizeof(io))) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed copy iobuf config from user\n",
+			dev_ctx->devname);
+		return -EFAULT;
+	}
+
+	dev_dbg(dev_ctx->priv->dev,
+		"%s: io [buf: %p(%d) flag: %x]\n",
+		dev_ctx->devname,
+		io.user_buf, io.length, io.flags);
+
+	if (io.length == 0 || !io.user_buf) {
+		/*
+		 * Accept NULL pointers since some buffers are optional
+		 * in FW commands. In this case we should return 0 as
+		 * pointer to be embedded into the message.
+		 * Skip all data copy part of code below.
+		 */
+		io.ele_addr = 0;
+		goto copy;
+	}
+
+	/* No specific requirement for this buffer. */
+	shared_mem = &dev_ctx->se_shared_mem_mgmt.non_secure_mem;
+
+	/* Check there is enough space in the shared memory. */
+	dev_dbg(dev_ctx->priv->dev,
+		"%s: req_size = %d, max_size= %d, curr_pos = %d",
+		dev_ctx->devname,
+		round_up(io.length, 8u),
+		shared_mem->size, shared_mem->pos);
+
+	if (shared_mem->size < shared_mem->pos ||
+	    round_up(io.length, 8u) > (shared_mem->size - shared_mem->pos)) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Not enough space in shared memory\n",
+			dev_ctx->devname);
+		return -ENOMEM;
+	}
+
+	/* Allocate space in shared memory. 8 bytes aligned. */
+	pos = shared_mem->pos;
+	shared_mem->pos += round_up(io.length, 8u);
+	io.ele_addr = (u64)shared_mem->dma_addr + pos;
+
+	memset(shared_mem->ptr + pos, 0, io.length);
+	if ((io.flags & SE_IO_BUF_FLAGS_IS_INPUT) ||
+	    (io.flags & SE_IO_BUF_FLAGS_IS_IN_OUT)) {
+		/*
+		 * buffer is input:
+		 * copy data from user space to this allocated buffer.
+		 */
+		if (copy_from_user(shared_mem->ptr + pos, io.user_buf,
+				   io.length)) {
+			dev_err(dev_ctx->priv->dev,
+				"%s: Failed copy data to shared memory\n",
+				dev_ctx->devname);
+			return -EFAULT;
+		}
+	}
+
+	err = add_b_desc_to_pending_list(shared_mem->ptr + pos,
+					 &io,
+					 dev_ctx);
+	if (err < 0)
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to allocate/link b_desc.",
+			dev_ctx->devname);
+
+copy:
+	/* Provide the EdgeLock Enclave address to user space only if success.*/
+	if (copy_to_user((u8 __user *)arg, &io, sizeof(io))) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to copy iobuff setup to user.",
+			dev_ctx->devname);
+		err = -EFAULT;
+	}
+
+	return err;
+}
+
+/* IOCTL to provide SoC information */
+static int se_ioctl_get_se_soc_info_handler(struct se_if_device_ctx *dev_ctx,
+					    u64 arg)
+{
+	struct se_ioctl_get_soc_info soc_info;
+	int err = -EINVAL;
+
+	soc_info.soc_id = get_se_soc_id(dev_ctx->priv);
+	soc_info.soc_rev = var_se_info.soc_rev;
+
+	err = (int)copy_to_user((u8 __user *)arg, (u8 *)(&soc_info), sizeof(soc_info));
+	if (err) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to copy soc info to user\n",
+			dev_ctx->devname);
+		err = -EFAULT;
+	}
+
+	return err;
+}
+
+/*
+ * File operations for user-space
+ */
+
+/* Write a message to the MU. */
+static ssize_t se_if_fops_write(struct file *fp, const char __user *buf,
+				size_t size, loff_t *ppos)
+{
+	struct se_if_device_ctx *dev_ctx = fp->private_data;
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_if_priv *priv = dev_ctx->priv;
+	int err;
+
+	dev_dbg(priv->dev,
+		"%s: write from buf (%p)%zu, ppos=%lld\n",
+		dev_ctx->devname,
+		buf, size, ((ppos) ? *ppos : 0));
+
+	if (mutex_lock_interruptible(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	if (dev_ctx != priv->cmd_receiver_clbk_hdl.dev_ctx) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	if (size < SE_MU_HDR_SZ) {
+		dev_err(priv->dev,
+			"%s: User buffer too small(%zu < %d)\n",
+			dev_ctx->devname,
+			size, SE_MU_HDR_SZ);
+		err = -ENOSPC;
+		goto exit;
+	}
+
+	tx_msg = memdup_user(buf, size);
+	if (IS_ERR(tx_msg)) {
+		err = PTR_ERR(tx_msg);
+		goto exit;
+	}
+
+	print_hex_dump_debug("from user ", DUMP_PREFIX_OFFSET, 4, 4,
+			     tx_msg, size, false);
+
+	err = ele_msg_send(dev_ctx, tx_msg, size);
+
+exit:
+	mutex_unlock(&dev_ctx->fops_lock);
+	return err;
+}
+
+/*
+ * Read a message from the MU.
+ * Blocking until a message is available.
+ */
+static ssize_t se_if_fops_read(struct file *fp, char __user *buf,
+			       size_t size, loff_t *ppos)
+{
+	struct se_if_device_ctx *dev_ctx = fp->private_data;
+	struct se_if_priv *priv = dev_ctx->priv;
+	int err;
+
+	dev_dbg(priv->dev,
+		"%s: read to buf %p(%zu), ppos=%lld\n",
+		dev_ctx->devname,
+		buf, size, ((ppos) ? *ppos : 0));
+
+	if (mutex_lock_interruptible(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	if (dev_ctx != priv->cmd_receiver_clbk_hdl.dev_ctx) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	err = ele_msg_rcv(dev_ctx, &priv->cmd_receiver_clbk_hdl);
+	if (err < 0) {
+		dev_err(priv->dev,
+			"%s: Err[0x%x]:Interrupted by signal.\n",
+			dev_ctx->devname, err);
+		dev_dbg(priv->dev,
+			"Current active dev-ctx count = %d.\n",
+			dev_ctx->priv->active_devctx_count);
+		goto exit;
+	}
+
+	/* We may need to copy the output data to user before
+	 * delivering the completion message.
+	 */
+	err = se_dev_ctx_cpy_out_data(dev_ctx);
+	if (err < 0)
+		goto exit;
+
+	/* Copy data from the buffer */
+	print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
+			     priv->cmd_receiver_clbk_hdl.rx_msg,
+			     priv->cmd_receiver_clbk_hdl.rx_msg_sz,
+			     false);
+
+	if (copy_to_user(buf, priv->cmd_receiver_clbk_hdl.rx_msg,
+			 priv->cmd_receiver_clbk_hdl.rx_msg_sz)) {
+		dev_err(priv->dev,
+			"%s: Failed to copy to user\n",
+			dev_ctx->devname);
+		err = -EFAULT;
+	}
+	err = priv->cmd_receiver_clbk_hdl.rx_msg_sz;
+exit:
+	priv->cmd_receiver_clbk_hdl.rx_msg_sz = 0;
+
+	se_dev_ctx_shared_mem_cleanup(dev_ctx);
+
+	mutex_unlock(&dev_ctx->fops_lock);
+	return err;
+}
+
+/* Open a character device. */
+static int se_if_fops_open(struct inode *nd, struct file *fp)
+{
+	struct miscdevice *miscdev = fp->private_data;
+	struct se_if_priv *priv = dev_get_drvdata(miscdev->parent);
+	struct se_if_device_ctx *misc_dev_ctx = priv->priv_dev_ctx;
+	struct se_if_device_ctx *dev_ctx;
+	int err = 0;
+
+	if (mutex_lock_interruptible(&misc_dev_ctx->fops_lock))
+		return -EBUSY;
+
+	priv->dev_ctx_mono_count++;
+	err = init_device_context(priv,
+				  priv->dev_ctx_mono_count ?
+					priv->dev_ctx_mono_count
+					: priv->dev_ctx_mono_count++,
+				  &dev_ctx, NULL);
+	if (err)
+		dev_err(priv->dev,
+			"Failed[0x%x] to create device contexts.\n",
+			err);
+	else
+		fp->private_data = dev_ctx;
+
+	mutex_unlock(&misc_dev_ctx->fops_lock);
+	return err;
+}
+
+/* Close a character device. */
+static int se_if_fops_close(struct inode *nd, struct file *fp)
+{
+	struct se_if_device_ctx *dev_ctx = fp->private_data;
+	struct se_if_priv *priv = dev_ctx->priv;
+
+	if (mutex_lock_interruptible(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	/* check if this device was registered as command receiver. */
+	if (priv->cmd_receiver_clbk_hdl.dev_ctx == dev_ctx) {
+		priv->cmd_receiver_clbk_hdl.dev_ctx = NULL;
+		kfree(priv->cmd_receiver_clbk_hdl.rx_msg);
+		priv->cmd_receiver_clbk_hdl.rx_msg = NULL;
+	}
+
+	se_dev_ctx_shared_mem_cleanup(dev_ctx);
+	cleanup_se_shared_mem(dev_ctx);
+
+	priv->active_devctx_count--;
+	list_del(&dev_ctx->link);
+
+	mutex_unlock(&dev_ctx->fops_lock);
+	kfree(dev_ctx->devname);
+	kfree(dev_ctx);
+
+	return 0;
+}
+
+/* IOCTL entry point of a character device */
+static long se_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
+{
+	struct se_if_device_ctx *dev_ctx = fp->private_data;
+	struct se_if_priv *priv = dev_ctx->priv;
+	int err;
+
+	/* Prevent race during change of device context */
+	if (mutex_lock_interruptible(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	switch (cmd) {
+	case SE_IOCTL_ENABLE_CMD_RCV:
+		if (!priv->cmd_receiver_clbk_hdl.dev_ctx) {
+			if (!priv->cmd_receiver_clbk_hdl.rx_msg) {
+				priv->cmd_receiver_clbk_hdl.rx_msg =
+						kzalloc(MAX_NVM_MSG_LEN,
+							GFP_KERNEL);
+				if (!priv->cmd_receiver_clbk_hdl.rx_msg) {
+					err = -ENOMEM;
+					break;
+				}
+			}
+			priv->cmd_receiver_clbk_hdl.rx_msg_sz = MAX_NVM_MSG_LEN;
+			priv->cmd_receiver_clbk_hdl.dev_ctx = dev_ctx;
+			err = 0;
+		} else {
+			err = -EBUSY;
+		}
+		break;
+	case SE_IOCTL_GET_MU_INFO:
+		err = se_ioctl_get_mu_info(dev_ctx, arg);
+		break;
+	case SE_IOCTL_SETUP_IOBUF:
+		err = se_ioctl_setup_iobuf_handler(dev_ctx, arg);
+		break;
+	case SE_IOCTL_GET_SOC_INFO:
+		err = se_ioctl_get_se_soc_info_handler(dev_ctx, arg);
+		break;
+	case SE_IOCTL_CMD_SEND_RCV_RSP:
+		err = se_ioctl_cmd_snd_rcv_rsp_handler(dev_ctx, arg);
+		break;
+	default:
+		err = -EINVAL;
+		dev_dbg(priv->dev,
+			"%s: IOCTL %.8x not supported\n",
+			dev_ctx->devname,
+			cmd);
+	}
+
+	mutex_unlock(&dev_ctx->fops_lock);
+
+	return (long)err;
+}
+
+/* Char driver setup */
+static const struct file_operations se_if_fops = {
+	.open		= se_if_fops_open,
+	.owner		= THIS_MODULE,
+	.release	= se_if_fops_close,
+	.unlocked_ioctl = se_ioctl,
+	.read		= se_if_fops_read,
+	.write		= se_if_fops_write,
+};
+
 /* interface for managed res to free a mailbox channel */
 static void if_mbox_free_channel(void *mbox_chan)
 {
@@ -321,6 +1074,7 @@ static int se_if_request_channel(struct device *dev,
 
 static void se_if_probe_cleanup(void *plat_dev)
 {
+	struct se_if_device_ctx *dev_ctx, *t_dev_ctx;
 	struct platform_device *pdev = plat_dev;
 	struct device *dev = &pdev->dev;
 	struct se_fw_load_info *load_fw;
@@ -345,6 +1099,13 @@ static void se_if_probe_cleanup(void *plat_dev)
 		load_fw->imem.buf = NULL;
 	}
 
+	if (priv->dev_ctx_mono_count) {
+		list_for_each_entry_safe(dev_ctx, t_dev_ctx, &priv->dev_ctx_list, link) {
+			list_del(&dev_ctx->link);
+			priv->active_devctx_count--;
+		}
+	}
+
 	/* No need to check, if reserved memory is allocated
 	 * before calling for its release. Or clearing the
 	 * un-set bit.
@@ -410,6 +1171,7 @@ static int se_if_probe(struct platform_device *pdev)
 					     "Unable to get sram pool = %s.",
 					     if_node->pool_name);
 	}
+	INIT_LIST_HEAD(&priv->dev_ctx_list);
 
 	if (if_node->reserved_dma_ranges) {
 		ret = of_reserved_mem_device_init(dev);
@@ -418,6 +1180,12 @@ static int se_if_probe(struct platform_device *pdev)
 					    "Failed to init reserved memory region.");
 	}
 
+	ret = init_device_context(priv, 0, &priv->priv_dev_ctx, &se_if_fops);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed[0x%x] to create device contexts.",
+				     ret);
+
 	if (if_node->if_defs.se_if_type == SE_TYPE_ID_HSM) {
 		ret = get_se_soc_info(priv, se_info);
 		if (ret)
@@ -444,7 +1212,7 @@ static int se_if_probe(struct platform_device *pdev)
 		}
 	}
 	dev_info(dev, "i.MX secure-enclave: %s%d interface to firmware, configured.",
-		 SE_TYPE_STR_HSM,
+		 get_se_if_name(priv->if_defs->se_if_type),
 		 priv->if_defs->se_instance_id);
 
 	return ret;
@@ -461,6 +1229,7 @@ static int se_suspend(struct device *dev)
 	struct se_fw_load_info *load_fw;
 	int ret = 0;
 
+	set_se_rcv_msg_timeout(SE_RCV_MSG_DEFAULT_TIMEOUT);
 	load_fw = get_load_fw_instance(priv);
 
 	if (load_fw->imem_mgmt)
diff --git a/drivers/firmware/imx/se_ctrl.h b/drivers/firmware/imx/se_ctrl.h
index 32547bc97ca3..c103563091d5 100644
--- a/drivers/firmware/imx/se_ctrl.h
+++ b/drivers/firmware/imx/se_ctrl.h
@@ -13,6 +13,7 @@
 #define MAX_FW_LOAD_RETRIES		50
 
 #define RES_STATUS(x)			FIELD_GET(0x000000ff, x)
+#define MAX_DATA_SIZE_PER_USER		(65 * 1024)
 #define MAX_NVM_MSG_LEN			(256)
 #define MESSAGING_VERSION_6		0x6
 #define MESSAGING_VERSION_7		0x7
@@ -20,6 +21,7 @@
 struct se_clbk_handle {
 	struct completion done;
 	bool signal_rcvd;
+	struct se_if_device_ctx *dev_ctx;
 	u32 rx_msg_sz;
 	/* Assignment of the rx_msg buffer to held till the
 	 * received content as part callback function, is copied.
@@ -34,6 +36,41 @@ struct se_imem_buf {
 	u32 state;
 };
 
+struct se_buf_desc {
+	u8 *shared_buf_ptr;
+	void __user *usr_buf_ptr;
+	u32 size;
+	struct list_head link;
+};
+
+struct se_shared_mem {
+	dma_addr_t dma_addr;
+	u32 size;
+	u32 pos;
+	u8 *ptr;
+};
+
+struct se_shared_mem_mgmt_info {
+	struct list_head pending_in;
+	struct list_head pending_out;
+
+	struct se_shared_mem secure_mem;
+	struct se_shared_mem non_secure_mem;
+};
+
+/* Private struct for each char device instance. */
+struct se_if_device_ctx {
+	struct se_if_priv *priv;
+	struct miscdevice *miscdev;
+	const char *devname;
+
+	/* process one file operation at a time. */
+	struct mutex fops_lock;
+
+	struct se_shared_mem_mgmt_info se_shared_mem_mgmt;
+	struct list_head link;
+};
+
 /* Header of the messages exchange with the EdgeLock Enclave */
 struct se_msg_hdr {
 	u8 ver;
@@ -78,6 +115,12 @@ struct se_if_priv {
 
 	struct gen_pool *mem_pool;
 	const struct se_if_defines *if_defs;
+
+	struct se_if_device_ctx *priv_dev_ctx;
+	struct list_head dev_ctx_list;
+	u32 active_devctx_count;
+	u32 dev_ctx_mono_count;
 };
 
+char *get_se_if_name(u8 se_if_id);
 #endif
diff --git a/include/uapi/linux/se_ioctl.h b/include/uapi/linux/se_ioctl.h
new file mode 100644
index 000000000000..29a9b1ec5ec3
--- /dev/null
+++ b/include/uapi/linux/se_ioctl.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause*/
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef SE_IOCTL_H
+#define SE_IOCTL_H
+
+#include <linux/types.h>
+
+#define SE_TYPE_STR_DBG			"dbg"
+#define SE_TYPE_STR_HSM			"hsm"
+#define SE_TYPE_ID_UNKWN		0x0
+#define SE_TYPE_ID_DBG			0x1
+#define SE_TYPE_ID_HSM			0x2
+/* IOCTL definitions. */
+
+struct se_ioctl_setup_iobuf {
+	void __user *user_buf;
+	__u32 length;
+	__u32 flags;
+	__u64 ele_addr;
+};
+
+struct se_ioctl_shared_mem_cfg {
+	__u32 base_offset;
+	__u32 size;
+};
+
+struct se_ioctl_get_if_info {
+	__u8 se_if_id;
+	__u8 interrupt_idx;
+	__u8 tz;
+	__u8 did;
+	__u8 cmd_tag;
+	__u8 rsp_tag;
+	__u8 success_tag;
+	__u8 base_api_ver;
+	__u8 fw_api_ver;
+};
+
+struct se_ioctl_cmd_snd_rcv_rsp_info {
+	__u32 __user *tx_buf;
+	int tx_buf_sz;
+	__u32 __user *rx_buf;
+	int rx_buf_sz;
+};
+
+struct se_ioctl_get_soc_info {
+	__u16 soc_id;
+	__u16 soc_rev;
+};
+
+/* IO Buffer Flags */
+#define SE_IO_BUF_FLAGS_IS_OUTPUT	(0x00u)
+#define SE_IO_BUF_FLAGS_IS_INPUT	(0x01u)
+#define SE_IO_BUF_FLAGS_USE_SEC_MEM	(0x02u)
+#define SE_IO_BUF_FLAGS_USE_SHORT_ADDR	(0x04u)
+#define SE_IO_BUF_FLAGS_IS_IN_OUT	(0x10u)
+
+/* IOCTLS */
+#define SE_IOCTL			0x0A /* like MISC_MAJOR. */
+
+/*
+ * ioctl to designated the current fd as logical-reciever.
+ * This is ioctl is send when the nvm-daemon, a slave to the
+ * firmware is started by the user.
+ */
+#define SE_IOCTL_ENABLE_CMD_RCV	_IO(SE_IOCTL, 0x01)
+
+/*
+ * ioctl to get the buffer allocated from the memory, which is shared
+ * between kernel and FW.
+ * Post allocation, the kernel tagged the allocated memory with:
+ *  Output
+ *  Input
+ *  Input-Output
+ *  Short address
+ *  Secure-memory
+ */
+#define SE_IOCTL_SETUP_IOBUF	_IOWR(SE_IOCTL, 0x03, \
+					struct se_ioctl_setup_iobuf)
+
+/*
+ * ioctl to get the mu information, that is used to exchange message
+ * with FW, from user-spaced.
+ */
+#define SE_IOCTL_GET_MU_INFO	_IOR(SE_IOCTL, 0x04, \
+					struct se_ioctl_get_if_info)
+/*
+ * ioctl to get SoC Info from user-space.
+ */
+#define SE_IOCTL_GET_SOC_INFO      _IOR(SE_IOCTL, 0x06, \
+					struct se_ioctl_get_soc_info)
+
+/*
+ * ioctl to send command and receive response from user-space.
+ */
+#define SE_IOCTL_CMD_SEND_RCV_RSP _IOWR(SE_IOCTL, 0x07, \
+					struct se_ioctl_cmd_snd_rcv_rsp_info)
+#endif

-- 
2.43.0


