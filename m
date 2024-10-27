Return-Path: <linux-kernel+bounces-383583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DFF9B1D99
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 13:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 557D3B2116D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 12:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB194166307;
	Sun, 27 Oct 2024 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VXOo9iz4"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2062.outbound.protection.outlook.com [40.107.249.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6AB153803;
	Sun, 27 Oct 2024 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730030765; cv=fail; b=tU0if6bWzGxRjGDpJLTCKXDrSPjK8G5j5wEeWAQ/vYTiEGIMsF+48cZqX88OwIXjh0kHvzVfpBA+gLFntX8LlP7HFPWu0RF49ehug8PEMXdXAtxZMTeCGaUgS8NNP2SRfRR+EJ0CiD9d9MTJgsvet0buX8o2xawz2p9lv51ahMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730030765; c=relaxed/simple;
	bh=Ap12Zt/850f7lfVfuhkHPzaSbsmg7Cde84ICuobAgdE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=e/NFBijqKGdkGkYUL5Htkv0hk0UD1pNbbSXAkgsFE3UpG2veNmSSG8sM1rdEUTZylyMHshUF/LwZAAAdJRxgcmnRyjsYv8CrvuRBJePUNFisDmjVZPvXVUQMiARkB4jLoC/x3YVBdw1URQ1tWv55DlPEBFDnbmCFCSCHxfBYwQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VXOo9iz4; arc=fail smtp.client-ip=40.107.249.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d41Jpp2AqeWkxl7KJdBqOCld0z25d03wJ/0DD9JhWwm0bBRs64vXqsScE0/JmFnMWeSOImzv4zxx1oipzCXj86zsd7TTAoFXQCf9myy5+/CDx0bv/Ad0FZ4M0zeuIWB3mh/Jii77yMu5TrInt/Qp/x9e0OF3aQn8krzlNHbfNKx9CeAKJPOSGXODU5qwGfbh4XHfUWLKc7VKsgdPmVG/3R1fS47WrlZkBcoOD3Y92a5DHUT1wZmN2qLhCIb5Zdxypb8LGe4YuhNbnOB0kAr4125z2rEvbKtCNnMyU7MLGw1BG/z5rdPLXL0zCx3uFpjYEqA4SzaoAgsqURsb6vu1MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcYjvNv59wcTyr29nYn4O2TU0tt/uXHgn2zMmuXt2TM=;
 b=siE2ogVELsJoeJ4vIhvmfPqLQmY6h748/pbvI3X8cdy9Mhnnw82r45fSsCytkiBkw2JEWf9sm5RKzenpVAPNo503hPzHn2dwcR9GJfB9tTpDo4VFF6crCq4MNVpq9e3j0t97tl129OD7q8LHLcvqZu7q47ZzNfS30fKCpq7j1R6uR3QGJ5E5CxKNrnP19T8Fu+e8kYCIg71Ps0NPxJJaf1cr7Kamu8ekSNFStYob840SGNYXP9CvM9bKPQnodIq6rkLY9HHTFqHUQ0hWEOpmajcFUpQQivJvfeyMkxQ2ZvgdAV5AzRXEihVF3qvegsPyGSQKOWx+sZ2BQYlhUEtqBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcYjvNv59wcTyr29nYn4O2TU0tt/uXHgn2zMmuXt2TM=;
 b=VXOo9iz45VwPjZ0KUF+rcg0VRniI56snOEM4wfn6lWQJX2imBmq1FzTR2ex4tRsiHfaenolhixjX+qV/AKtau7P4OgQlnqpq3lKRodnJjPK/Uy+CuhAPszRdKk8AAzDM6rwdj4JbagGa/OFxY/rQJVATMwr6jR/W69A+/ZtQe5c6zcBlCyCiC6d/evTm0fZAEZkHRzsevUH/2ZXEUpZskW1BGEfDhGQl7EeZ0FKoQSn8NPDu4GUJrNtuSXk4aOV4m+KAeZPDY0xq8uNT42ZPENv9LgLwN3n+1/AitjC9uX4Hu7Nk0BGf60JH7FvWfy7n1IK/QFDS1/NcwT95pj/2vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by PAXPR04MB9596.eurprd04.prod.outlook.com (2603:10a6:102:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Sun, 27 Oct
 2024 12:06:00 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.8069.016; Sun, 27 Oct 2024
 12:06:00 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 27 Oct 2024 20:16:00 +0800
Subject: [PATCH v3 2/2] mtd: spi-nor: support vcc-supply regulator
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241027-spi-v3-2-42e81723bbcc@nxp.com>
References: <20241027-spi-v3-0-42e81723bbcc@nxp.com>
In-Reply-To: <20241027-spi-v3-0-42e81723bbcc@nxp.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730031369; l=1052;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=B0/5kvxZgm3DkhWR/RXzyopxQTI9vKG34FKEVuZdaig=;
 b=fMBDTlB5qIiTduibkshHTKB4XYptIyFaD1YYf8I1AfZNLvWDIdTzOo1igjElBomPwFAs10S/X
 RjcE/XMUk9+C2I18hojmk70G7Go0IXXvJP4tVnGQgI/gmIbvp4XHhSL
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:4:91::20) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|PAXPR04MB9596:EE_
X-MS-Office365-Filtering-Correlation-Id: 8859e14b-e0c8-43d3-d15b-08dcf67fb898
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUpDbUwzazVZblNkbGhrS3V6cWQzK1dMYzBVd0tqZnBqYi9xYUh0Ui9namI3?=
 =?utf-8?B?QnZucUJxaTdqMHpkOURSNldrcjFHdGhRbjFRSlBqZWtDdUsrb1l6OXB2bkE4?=
 =?utf-8?B?aUZHQmp3ZldocGJ5d0M3bk1LVkdzbFRyKzAzdXNGVG5jRklmZlJIK0c1R210?=
 =?utf-8?B?SHhtQkpTdGc1MDFzMWJTVit4UU10S2VmQko4K0laR1luU2t3M3ZPMkZVOU1L?=
 =?utf-8?B?NEoweGtDTXZjYnMza09wSVFtTzBOYlN1c1VtTWpRNTZUakdXb2laL2JPNzlQ?=
 =?utf-8?B?UDE0YXo2QW1aTzFFaWhaK0plRGMwUGRVU0dyeUpvZXBvazdsd0UweHRrVHZ4?=
 =?utf-8?B?WlJyTVpWVS84RktmVUZaM1RaWGVQd0tnZ2xpTkxwbU42S3Rya1VFTjROTjhU?=
 =?utf-8?B?dDdnM1Q1NVdFYW5pZkZwUmp0WmFKT3dVQll0L0NGdFpNZ1JGZkRlbnQzc2Vy?=
 =?utf-8?B?dlpMODhlSEt2M25VbXpiUSsrVkVwdjN6Tk9aZ0tNOWJoaWRJQ1RYRjZWMEZw?=
 =?utf-8?B?Q0xIQTlpUDNSZTQ5anJsUCszdHVvYWxIa0s3T2V5djM1ck0vbHNPVEEwNHpa?=
 =?utf-8?B?cUF2UTR3YUlkTVRzL0FQWkRBVUgyUzVTaTdqMWlzU0dnc1dQYmtRUVRDNzh0?=
 =?utf-8?B?NmVzRi8xQ2lLTmR4bTdjK1h1Qjhab0haZC9QZGo3MzMraVFzVjhWQUZTR2Vu?=
 =?utf-8?B?blBPWlNJdUtOTUlQZWkvcEdpeElrbmF2NHNBa1M0QnVvamJvMmpxS2dVRzlO?=
 =?utf-8?B?ODhyOVBaM3lnQWZXRTBEVXhqUG50OHFZcU1ReFY3UG5heEdHVFRMM3hDT1VB?=
 =?utf-8?B?MzVtOStvWkV1VzRlM05mbFVieFFYdGV1eVA1a0VkMDFlZWVaNGhmajJ6NmNH?=
 =?utf-8?B?QVIxcS9aUG4rQmRTbnNZTzRZVlhIdmsyNnB5a0RPbEd0N09YYUkrZWYwNnNF?=
 =?utf-8?B?VEY4a3dLNmZWTGtZM2pSblZaQjV0Q3ZneUVGdTBYZGI2TDEzY0ZIeDJmdGti?=
 =?utf-8?B?endSRzZ4c1lIWndidkVNN0dab3lwV0J4Mkg3alhKMWo2OWtYL3h4NDVkRG9J?=
 =?utf-8?B?N1dtM0NDLysrL2lacnJ2dlJMOUhhYzJaZnhVcXNQWU03TFJLOWJCSkFZbkFn?=
 =?utf-8?B?Mm1vNHd3Mm1mT2x3dnF4UVNnU0pWalIvTFZoOFQrYnAxeDdjNk1aaTFsVVFZ?=
 =?utf-8?B?YVJWNzRnWmdQa0cra0taNE04TVc3Z21VQWQ1VFZMMlFWSHJNaUUvUEpwQ0tK?=
 =?utf-8?B?dGNCRDhUTDhseGl5YUN3ZXk0dXNmWGE3dXlkNG5OS0kwb3YySkxRaW1ZRnhw?=
 =?utf-8?B?RG5OQkExcXhVbG05L1pWNENaQUpGdlgrcFFGdUh3S2VtMk5JNUFSaXdkaGZH?=
 =?utf-8?B?ZDR5c3ZBbFE0MFphTWlIT1MxQWtLU1RwQy9HNWs5dWdVNlQxTU01UUhhQktw?=
 =?utf-8?B?MlN3dlpQbzNoM2xCRzhQckYzODlGVmdVU3NjaVVqNGNmVmdIZnZLR2RFT0h0?=
 =?utf-8?B?Nkt6Z1kvem1qMGd0SXBEcUJJcVM5ckl2blI0cW82N2xxeTB6ZERWQmx3K3ho?=
 =?utf-8?B?dVplVmJTZGhCNXN6cCtRNzR6MmtuRzRLdFNReERIbVFHRm5KUVdZK0I4MW9a?=
 =?utf-8?B?Z0JwQ1MyVTdWVkdqN2xiRmZUa1hpek9OdWxBYVUrdGhuclliUkh5UkNLcHZl?=
 =?utf-8?B?VFNsd1orc2cybEFaaVdQQ25zS2ExZjZkVHVGRlV5V1I0QVN0Wkh3eWtzdW5E?=
 =?utf-8?B?eWkvNytjS0tZS1VTb1VHa1lwMHVGaFQvb3NYdVJsb2tkT2YzbVJWMXBzdlJR?=
 =?utf-8?B?c25tZE92RE9wcWNJcndHL1RpbCtyMFRtZFhZaHRjYlNwRWtTZGk4TWg0czFr?=
 =?utf-8?Q?Q+KEl62cjfZws?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWVMWXA4d29pc1FsUFN3bytOVkluYkdXd25rbXd2Uk1yczJFVnYyak9PM05B?=
 =?utf-8?B?cVErYTNZS3pXWXJZSnlOQ011UjlsMzQxVGR3Rit3Q3FrdWZhWEZNZjFucTkv?=
 =?utf-8?B?c2h1eGpYcWozMGR2alRWZFpDOGV0M1JFcm5TRHNzQ0I1VEc3U1JuRHovbzAr?=
 =?utf-8?B?TEFEYnIxM3g4NlFwMGpqTWszMkh2MXkyckxuUjVnZzM5Qk1aZGlLUWRSelU3?=
 =?utf-8?B?cXdQcmxnRURpSFZRSzM1aVppTDMwaUFLYmhkSzNrQ1hPRmNJeFNTeDFhU3pO?=
 =?utf-8?B?OVh2Rit5eFU1NFR5YnIxYzQ0aVFZVFRZTXdvTU41WW1rdjhjUW5nUHJCNVht?=
 =?utf-8?B?aGdCOXlEaExjQk1Idi92ZUJsZXBzU2pubE9PQ1BCdFdoZTcrd1dXdXo0SWNw?=
 =?utf-8?B?NjNjamphWGpZeEEvZEtpUWpTbU00VGpuZ0wzQUdNMmdZQWRVZzlRdVJsVDRV?=
 =?utf-8?B?U3IxM0s2dGxIVGZYamtJMGxiT0xxaENsaHNCVVhKcWx1Yzc4eFlyVzVLZlI4?=
 =?utf-8?B?KytDaDhDcVlleUxidGxWSnFqVXRUWkJNZHNQY2t6SGNyVzhOUHdNVzZ2aVU0?=
 =?utf-8?B?SDdPSUQwOTRObHI3RFNna3hrMTF5MmZIVkRkWWN2d0crZTU5ay9uTjUxT2hj?=
 =?utf-8?B?NzRWVktBbmMvWEZPSXpJZk9zaXExR0xjQjBESEZpTytucHdKVjNNQWZzNitn?=
 =?utf-8?B?RUJKMVZIZklYNVpuU1YwV096TnFTR0hkSDlMZ09aOUJwUDFMZ2ZjcDVtUlNW?=
 =?utf-8?B?U21pN003bFlWTk5JUDNYb0tSdEhUcFAvdUtmMGM5SWxlL2F2enI4RVZldHpv?=
 =?utf-8?B?UUhweTBobTZpckVtWTVSd1czSWNPN3VFT1JlRk94SDBLcWMvb3JwRW5tanJJ?=
 =?utf-8?B?b0tjZVJDTEFzVWllTjRKMTQ0cEh2QzBwNDE0MmUrVC9RYkdTMnBaWTlZeUtL?=
 =?utf-8?B?TVBGdDVSK3pCRVZKNG1ONnprSjhxTVpZRy9xYWRrYlFoRFQ1VjV3bjZicGUz?=
 =?utf-8?B?UENYNmRrbTdpREJFNzBNMU1FeUdHTjZFYlFtZ3RRQkkrZXU5UURLMXpxM3BQ?=
 =?utf-8?B?a05NYndRVVFlSUFvSkxKVzBnSzdKaitoZHZuNjlzOUNvMjRsMEhRR0RNd0JX?=
 =?utf-8?B?TWo0YlNIajdPV1NKelhyaGZXbDN3c0diaFl2aExPeTk0LzlrTWpGc2JQNDVu?=
 =?utf-8?B?Q0FJSklnVytuVTlXWW1DQ0kxeE80ckFUNUIrNXdmWSs5K0JHTlBTbmVtcFlD?=
 =?utf-8?B?WFppVkhZK2QwTW9MVi82U0wxSlZhUzFpZm1sMHE4MVBvb1dZSjUvb2R0UUl6?=
 =?utf-8?B?a1N4MFlacmhZTE50OEFlSVBjdzkrZEFINVRRVUxxOVJjcERUWDc3QzFGNENh?=
 =?utf-8?B?MlcyaStGcEtLcTBDK3Q4QWpkcEZqREE5ODd1L3FOZzFJYkUzQkhFOE5YQnVv?=
 =?utf-8?B?aml1djBUczg2T2M2bCtiN3FEc3VmaXc0bnNRY3R0NlVVaFg0WWtzRWhWYTEr?=
 =?utf-8?B?VEhXWGxrODd0dE03VjZkUzI0cjJoa3VabHVMczN6cTlocXFQUHVXQ3I3NFlL?=
 =?utf-8?B?UTFnNjZzTEhLcWZ2UWNuaFp4YmNCakdLOTYxZVJPOTFKcFg2VmtZbWx1bk9S?=
 =?utf-8?B?YTFUOXprRUVTa0thMzB6NVBWMTk5c2xFWE44blVSQ3didmNvT2tJQkpUZjdS?=
 =?utf-8?B?ZUtVWEFmV1VmQ0tqTEdPZlYwdDF0Zzh2ZHd1d1VSd3JtRVJUUGVEdStGbVh2?=
 =?utf-8?B?NWJzZlFIQVd1NWRSTmEwTy8yZG9wVUJWVlhlakU1WC9xTGZoVVlyTGZvN1By?=
 =?utf-8?B?bGV4bVIwVGZadXQrWVBRdDNPaDdaWkV5QWFxbUkvZ1hVeVJpK08vb3oza1N1?=
 =?utf-8?B?Z1daWTRrVkJzZHlhNXhBcHFMNDdhOGF3WVdMOEZ6SWRoUVBUR3ZZeVpEU2dt?=
 =?utf-8?B?VEN3VC9iM0xHTWdCKzJEdnYvMUNzRDIzVS9YRlhTYXcvQytaRWVacEcrUGxU?=
 =?utf-8?B?d2VMdTNMeG84WXdQRUk4U2xsVi9ZajR5WFhUdUpYbUJoWHViUHp3eS90WWww?=
 =?utf-8?B?QUlJN3ZYMVl2TjFRS21qS3pzOS9oTGtxaUp2eXd6VVcwWURJUEh1R09FUVZr?=
 =?utf-8?Q?wyIoRBncwev+r1GhDXdXZHhb8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8859e14b-e0c8-43d3-d15b-08dcf67fb898
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2024 12:05:59.9590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2iXPVQqACmw+AqaIW16Z6b0nnoTCPbOP3NPIVp0ceNJAkRwtmFarhxX52v8pRpHDgmGFwWkc+xeQzMPzskUDpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9596

From: Peng Fan <peng.fan@nxp.com>

SPI NOR flashes needs power supply to work properly. The power supply
maybe software controllable per board design. So add the support
for an vcc-supply regulator.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mtd/spi-nor/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index b6f374ded390a0c0429a61dd0579204e0e98bfa1..d95427c4f4d0839c5df348eeddea59582ef99d9d 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -17,6 +17,7 @@
 #include <linux/mtd/spi-nor.h>
 #include <linux/mutex.h>
 #include <linux/of_platform.h>
+#include <linux/regulator/consumer.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -3465,6 +3466,10 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	if (!nor->bouncebuf)
 		return -ENOMEM;
 
+	ret = devm_regulator_get_enable(dev, "vcc");
+	if (ret)
+		return ret;
+
 	ret = spi_nor_hw_reset(nor);
 	if (ret)
 		return ret;

-- 
2.37.1


