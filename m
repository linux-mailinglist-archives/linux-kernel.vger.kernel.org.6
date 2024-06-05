Return-Path: <linux-kernel+bounces-201640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502FF8FC129
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 03:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73DC21C226E6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAE217996;
	Wed,  5 Jun 2024 01:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Kve2s2i3"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE0E8F44;
	Wed,  5 Jun 2024 01:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717550031; cv=fail; b=PDdDKcBhDanpyodDAY5TLNBCOvgFA/JYssReUt298nLEbf7qHu6NK/gZ3VKOJKcp2nUCJjEvz3Dna3k+PNfjmHb2a1im36m7/Zg+JIBFiFwxTATHwTzlMiEW1yaXqQQkgi0hTPTz2coSQMC6JoJ4e2P5zgfyQo2v2mYkktZ7yI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717550031; c=relaxed/simple;
	bh=xDHthho3clLMwVkgJtffn/O2I4fbcl26gyOATRJQtI4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=a+Ej6NO/+o79Q3D3OAh+g/sXOnLAuYfgrv8fh4qxLVq8rc/rsbVaDnAs7jIB4C21S3c4PIWkpM2mFSvpuxswNKp1uUpNlk1+1QLTKKIYhe9mT8nHGZl/yyKXZi5uQc+KmtAxM2KMuW3U2emfB8bHY8EpGQDrLfrpOcd8Q1PxvMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Kve2s2i3; arc=fail smtp.client-ip=40.107.105.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZtUxY+ZeXx135ZJfu37Qq6G6b0YZopjUhkQypFOkkP/WDn8SexaFw4nGEKLd6LKJo8FGDy5xLOx1Owty8gVB7wiikYShDE2ihnL8HapqC6gROi8JgolamGVm382ixCMijsOb6+1PMjkcYeSnxBY5qm60SCD+C2m5tYJdZVEAFetHYXmnXymGnXnIzn2o+txBbHaMT3z8iwonyU/1MTHkvqC187e1lPnZUUYBK2GYwYIU+UNeZ/MiAj415penDFWliWORrLHdmMxsx7/KKHleWyY214wTQYSVzyD5JDkqC/0lDWkvzFEWEYjq/tm04Ryii6cF8JhTcyv2QWhSeYStQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3LuyELaiSC0sVNX2XPvkzFPVBktsV4F8YpUGnJ4zDs=;
 b=TYpsr1repY72zPZdO3mHI7gJxKhM5XuJ9023EZKVEdCeaL6pzTC/Du3vnI8UxbyUbs6td+SxNggKW97cTTAO2WkE57czCSCm3OFk4oKMBQ3MonZIVIX4c5Oq5woRG56w17zOQBO1RW6R7ocwQTxGMKZUpTs9h/kzdoL0ytH1nQbKe0OZPlvAXYNva5EJAvqxeQ0EyDpGt1NDgEuntzdaEwaVbmC7+oBzp4TZ8n4iH08M2FZmE3cZ5N7LgtpqLEMY2WQ9CrBinzB9i/fGtlMXQEv6HogZ4qwnuXrRNrgEHn/J4b7bh8qUVgdeLqjigiqHH72jUgq5HY6JXUhXM8bSCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3LuyELaiSC0sVNX2XPvkzFPVBktsV4F8YpUGnJ4zDs=;
 b=Kve2s2i3flIVAmMnsavnMSX0rwa1ygxEkl8Jt/uetXmw/CjEkdMeQFtYnsfd5ruzKc07u/LvDSCSauLj4Eqh/Qy5Ka1XhMYKUzgmOgq5GW1ooTNblHh841n9ZTcZYxF/C3ttiK0hEOLE20m4L04S/ikvxbGwhaDKCm3AYwVdQSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9668.eurprd04.prod.outlook.com (2603:10a6:102:243::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Wed, 5 Jun
 2024 01:13:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c%7]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 01:13:46 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 05 Jun 2024 09:22:48 +0800
Subject: [PATCH v6 1/3] dt-bindings: arm: fsl: add i.MX95 19x19 EVK board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-imx95-dts-v3-v6-1-2ce275ed0e80@nxp.com>
References: <20240605-imx95-dts-v3-v6-0-2ce275ed0e80@nxp.com>
In-Reply-To: <20240605-imx95-dts-v3-v6-0-2ce275ed0e80@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Peng Fan <peng.fan@nxp.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717550578; l=938;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=hxkVlQeaJgJhLHSlZ83jW3veqMTWVj/bEjw+HMyTvrY=;
 b=czB6H2SSMtLXyWhIro1Gsp2bqjM7hdprdD++2n4jXXx2SbfgDtIn4gm/T5L3qIZPaSjEQA8sU
 1whwQM/lnstCzMJwprVs5vj9OzAew9S+vTx/3YofvTCfFJ4TzToJjfl
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: 0792e31c-44f6-40ea-f2f5-08dc84fcbfcc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|52116005|1800799015|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnBGTlUvNTVRWFBoYlNjVWRWNmdIa0JVNEsrQkZ6VThBNjNsWHBFUjRqSS8v?=
 =?utf-8?B?d1JHS3l1dzUvdmJ3OVNUYVh0dmc1dWNXcHpvMDN6ZEJPbWgyaUtFcFNuVmw2?=
 =?utf-8?B?MmFXQStXNUFubGwvclhIMm5ZSWxrOTZDSU12TXFKZndVam1wMUU3UjRGVnQ4?=
 =?utf-8?B?NSszMDcvR08vdDMrRW91RVpEaUduZzgrSjBrZTlhR2xEQ05KUncxMnNxVjE3?=
 =?utf-8?B?ek1pWkh3NlJOeGtUOFNkQjBnQnBsbjV6bXluQmdKdDJIVTVMNXI4YXVzWjM3?=
 =?utf-8?B?RHBWSGl4emw3VWxxeURkNjJwRld0MHcrSHJaVHcvR2VVWUc1c3ROVkJRc0x0?=
 =?utf-8?B?d3pBWGkwYTN4N1lvRXBNa0UwMGRDamozeXRhRzQ3SUJaY2JwbUk5ZVZERk5w?=
 =?utf-8?B?Q2RDOFFFby9SMFZHY0tQR0hEdGxHQWJyVHlZYm45NEJ3N2ljU2N2dm10L0lt?=
 =?utf-8?B?OFA5dUgzYVRhNHFTNXpUbEJHWi9kQnd4QUU2SGlHWUdObkdsZ2VmZXIvbGp5?=
 =?utf-8?B?cm93akJaNC8wNVNrcUlBZHNxVmpTNFhFaWJhRC9LQ2ZBeGhlaG0veEVmZjlO?=
 =?utf-8?B?aHZVRCtIMnRoNmFkVFlaM3d6K0IrcHVaYnNSS2FiYWsvZmxrOUQzbTVRcWts?=
 =?utf-8?B?RFY5cjFuQm1xaDB3bStqY1hRaS9tNFVuNWxkOFl5TG1jRnlBL2ZnR0x5Vkgw?=
 =?utf-8?B?aGl2aDM4M09MWWNZQmNMeGphT05XbDJHWjhXV2NBc0dNMCtmaS9zZDg3a0h5?=
 =?utf-8?B?Vm9pUVlnYk5Odll3dEZNNmdMSnFkMnBGcGhjejFrVThxNktrNWtqdy9VRHAy?=
 =?utf-8?B?WGZjMjh1eVI1Vk14cklCem9jUmpDR3V0UldLeUxpWGpkSVZrdmNocGZYSHNW?=
 =?utf-8?B?RkM2K0FCbGw5OTFrV0drU2lYNkJkUEhvR1hLV3pEUm9SNURWQUg5L3hsWTk0?=
 =?utf-8?B?VmlWdG1hbW9OZmZDemhzVTJrWWxTUzNiWllGRnVWcXpXeHk0dDlUK1EzNDJC?=
 =?utf-8?B?d0xHQUg0RFoyTERDS21DZ3Z6Wlp6clZKSURtNS9vSitqUkFyT0lhb1B2RjRj?=
 =?utf-8?B?SDhxTzZtUGJTR2xTUWR0ZVRjSXl4UEFLb2t6OXpXZVJQNFY2Q1pwZ3ZtS0lS?=
 =?utf-8?B?Z3gvMXVQTXZyUjJoa1ZQV1NiOGFKNERJOSswa2tuR2hZUmYveEpyTEQ2WkRs?=
 =?utf-8?B?UkIyV01HaytCTVA1MWR4TlNlaThzUUI0Uld3dUFtQkFMS1AxOEV6RGkrTUlr?=
 =?utf-8?B?ZE5PR0RVNk9KbmF2YjFmRFc0Y1g0Q3dZRjRkcUpSUitBeDJIQVRtcktYRGhQ?=
 =?utf-8?B?NUJXcFZUSXhwT0NHaytsYXJSMVU3RlBSNEVJM2VCc1QyL1FMb2Q2UWxHOTJa?=
 =?utf-8?B?UU9yNXFnNWU1ejZoM1pzVksrWnFqTzlNUWRtWWZaVnJTZ1Z6SFhZUDFDM0x0?=
 =?utf-8?B?T2xoN1FsUjVyVWhrL2tVNTI3VGhYTHU3Ri9wK3lIaEl0cWhaOHNrazZJQVNs?=
 =?utf-8?B?UmkzcTNnZUF2S3FWbVNmMjhaZUVRUDU4ZUdSSHhKRzJwZm90NEpRVlFpYXhh?=
 =?utf-8?B?VXJMaWxGeFlKdzQwSElvZmt0QWZkOHRUV3NEYndoMWRnRThDZWZpYnF5MWZ0?=
 =?utf-8?B?ZnRKcm5zMWpkM3VkdEdKbnRlbUlIZW1qNFg2WFk3V2NtUlUyaEw0a3ZNZWlZ?=
 =?utf-8?B?YTFUSjhERkltU2lVWDZ5TWlWV1lnSnA1N1J3cXozdUpPUkQxZTZMRncwcFN2?=
 =?utf-8?B?OU9weWx0RFozNEV1YlpQdnkyYWJ5akJ6ZlBkYjZzOU53akpCdEgxVzV1MkYz?=
 =?utf-8?B?R3VPOHQvcWRsdWMxWG5NUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MERpUlpzTVdyYTl4cEt4dnZKL3B5U3NvYjYyb25ETFg0NWhYSUQ0L0RPcjJ1?=
 =?utf-8?B?NjRubjBoOHVENitJOHk2YklHV0N0MGZjNDBZY3dML1lTZnNhOE82TEdjWVFj?=
 =?utf-8?B?Mm1HaytQM21kK1hQRmk0YXkvS2hscUVQSHk2R2VEOEYvTG5ZTmU1czdhQ0Zz?=
 =?utf-8?B?ZzZnbldBLzFmTDNUKzgvWFJ4SmlkMUl4cXRROWxLYWJWUi84RzM5ZExpN2V0?=
 =?utf-8?B?MnJtNDMrMFI4UDZ4VDFBMUhyS3BySzZEUUVUSDVaQ1M0RVN4QXE4WUEzOVY3?=
 =?utf-8?B?MUtvZGViSzF3VHZ4OFZDbzRhOVNZUGJFQ08yeEQ5a3FUaExNZHZNN0ZWaXE1?=
 =?utf-8?B?STVvM2tUdHRqUEdJY0VUeGNkYnRuZStzbHB3OU9NNEV6dTVpd0lHNW1KaHVl?=
 =?utf-8?B?WlZMWi85OEVUbGtIZ0RCR3NXbzB5ZzdaL0NkTG9DZG1zUnloRWtsankzWSti?=
 =?utf-8?B?UFpocUtHU3hjcW5tUjJIKzNxUWcvYnowbUIvK0dXK3l4Y01KUjhHamdXMmhN?=
 =?utf-8?B?L0lha1hBSU1WdU5GUDdVclNicXlHSitoWkpNRlpVOW9IV3hSaVM1QkdLUGYv?=
 =?utf-8?B?ZGljWk1MTTQ4eTlEWlJMbVBQT2VhT29yNlFrNlRzVmdYRU50SlJZWkJLeXpx?=
 =?utf-8?B?VE1Tbm9hYW9JZHA2TGZQOWdvY0psVjlDSldPSG5wZXBtTHJSbFRZZERoeEFK?=
 =?utf-8?B?aklLQjZsM1hBMjBoSUYwQVl6YzFscjZuZ3UrWHdQaGdjRU9RdGJSeURFeHNN?=
 =?utf-8?B?ZUhWRFhCWDBhQzlRZmFkQ0pmWnB5cm82OEg4U0d5cnN4QjFjRGJmWnByNE12?=
 =?utf-8?B?TmhKTVhlQjlZbjJzTWQwVXIwOWhiTkZKTngzVGdOaU5EaWtCc3VTa3I2bGlx?=
 =?utf-8?B?SThLOXBzZFNJUFZmV2RqbGs4WVNNcUJzMjlvUUNwU3p6dmRBMHNVdTZuVE9y?=
 =?utf-8?B?SGJzUUlMRHNjcFlPR2UwVGJPRmtaRkNlN1hncndVWU5DQS8vK2cvRm80LzBV?=
 =?utf-8?B?SWdMeUdBYmp3eTIwa2dxZVhhVHJyTjRlSFViVDIvVUdxVDhKdHpSVHpaWXpL?=
 =?utf-8?B?a0lKV0kxNHpHUGxMRHNYTTV5RDBrTFVFb3pKQlVnTTF4aEE2WWNXZEswVUQ0?=
 =?utf-8?B?NGxZSWJKaXM5aE85cW9tWG5haG9oWlkyanIva0hvVldXRklmWTBNL3BHcnMr?=
 =?utf-8?B?YlBUQlM2NFB4aUtVbEk4M1RxOXdvMlNzMFlpMStZckpvOEJUWlQzQy8wQW9j?=
 =?utf-8?B?UXYra2tUeU5zSW9UMWxvWW85Z2JFdjZNczA5dk5pSXBkK2F2SkU2NXpZTUt6?=
 =?utf-8?B?UzdxNjdsWm83Znc0Uk5oSkdFTjlldTkwRzFtVUxSZDNLTDZSekZXaFlVWmt6?=
 =?utf-8?B?ZFI4MmZwWlN2bUVjazZhcHRHcWtFRC9yMERKSnlpbjJLOEtxRFVoS0xKbjFQ?=
 =?utf-8?B?RmRrVFR3MU9va1FUVlF2ZmMyUnY2THJoQ01IZjJJYzVMMEYzR1FoajlwcjhZ?=
 =?utf-8?B?RVBReGJWNWxQb1YwQTg1blRlazVBeDY0UnJyWFArRkhNcEFyNlRoQWQ2ZElS?=
 =?utf-8?B?ZUl6SjhrMW5rSHlVWnFXbEdwdUE5NnRFZ1pUdE5RenZCblVVRTVYNTRYTUs5?=
 =?utf-8?B?T3dHYmN4aFZ2bGtpbjJVWmpqemZyQWNtdGQ2aDIvVnowdTR2L2VkRW9SbnV4?=
 =?utf-8?B?eERNZWVrM29sc25aMDV1WjhoYWw5OThLTUdDYXliMnpkQUplbmVON2pmbzY0?=
 =?utf-8?B?VUVEdWU0RWx6bGJUeE93cERvc0RVMEM5M1lYWWRBZXFQb3FrYlF5di9WSVNt?=
 =?utf-8?B?T2IvNk84blhOaFJST3FtVk5Yd2Y0MjNOeGhkU256OGt1RHo1ZUpUMCtJNVVi?=
 =?utf-8?B?TzQ3QWFjYVN1RzhCMHplV2dHK2VJUklNd0t2WUlHb1VuMGJFUGVsaVVJQnY1?=
 =?utf-8?B?bUNnSkFrdFlCZnBuQUhCVjh6MmtIRHBZZThTSkdpTUhwNDVGTFhTa1ArMERG?=
 =?utf-8?B?YWN5Y1A2bC9XakFYSjVQZTNEMTFCci9tVTdpVnVETlBzbHp0TFlwOWFGVk85?=
 =?utf-8?B?eE1vbGtadlp6c3lTQWY0VndJY1lMUDJXZHY5NWFyeGUzSTVrUndjdTNhV09x?=
 =?utf-8?Q?rqgTsR56mvL1wUWPJqVcTcQ+3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0792e31c-44f6-40ea-f2f5-08dc84fcbfcc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 01:13:46.4973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZL21ukvXOof5r+OK8xT52mZAMFSNSbzIhoEUet6gq5yGKQoSTn2ywfAdOCr7FGSxytz85KjhVCapr2HpDJaLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9668

From: Peng Fan <peng.fan@nxp.com>

Add DT compatible string for NXP i.MX95 19x19 EVK board.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 6d185d09cb6a..5c9014087c17 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1275,6 +1275,12 @@ properties:
               - fsl,imx93-11x11-evk       # i.MX93 11x11 EVK Board
           - const: fsl,imx93
 
+      - description: i.MX95 based Boards
+        items:
+          - enum:
+              - fsl,imx95-19x19-evk       # i.MX95 19x19 EVK Board
+          - const: fsl,imx95
+
       - description: i.MXRT1050 based Boards
         items:
           - enum:

-- 
2.37.1


