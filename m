Return-Path: <linux-kernel+bounces-248370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D59692DC42
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331DE2827DD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CED154448;
	Wed, 10 Jul 2024 23:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="igMXdhAu"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010051.outbound.protection.outlook.com [52.101.69.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F388914D428;
	Wed, 10 Jul 2024 23:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720652571; cv=fail; b=JeHT+/oyp8/g4nZwe/OeXsvVlulpMCDYa3ju70eTWSi0ZqsTVFX+uQoIkDsMaCKlGEP/f9x5AXsX6SuDmeevGm0Wgby7CMexmmtXrdlNo5QT9J5cePcMI/4BwA8xBIy3pEooVgTq4oNrEimxQijo0jeS3TNIPpC78UM0aIOgHRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720652571; c=relaxed/simple;
	bh=Xe2ZsA6XK2+7YHKlgNVGziXAOnQGAXiVcvdtt6S8VN8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fjMwHgNYykj+pwCY132TW/9dBzQUSL2C2OgONjR05wBqju4P+sEF5NKYhRLkVlY7MCTeTQe7WizETCctsRmd977ZyvGIHTjdE8yhn5WTQc0KoBYpepvF94QvlwYxgEa+m7hwzzwvjhYWkF1xKf2/5tLnggM9EmrI2H7ahWX7j0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=igMXdhAu; arc=fail smtp.client-ip=52.101.69.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3Ve9FYkF2x49sp0wcvrj2ch2jDXt+5CM8P4CunwjCnnGPlni9eyt5YLHUzu1/fxE8Sw8hQRgjX8jTdpwPmYAHpcMR6xyi4EFt9R5hCaSdncWzWmQcmdmwlzRW2m7rxIFb9NAtvtef1CVgjf8J6sCFB/qhIaFRiw5p6GbQCb/qzsfs4tsjwAOqzLCWpGwRLQibO1BQofmqfbtz1nRFdHPM8EIwvVBNgznlAFkQ41v4xrxxc0dVImyM60TlQdrbQwj1Sb8YyR3w/e8+6rSZjSQz9MKBRVOyPQDj6IjDbDXTKjVUQ0QTtbxULYxHcSSJ9dPZFUmUxat2Q6Gw9m6MYuyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0umDDp7ZyWLee9OpwSny26aNghX5q4cQ9wHdzMIqTA=;
 b=O0Nh1Gd45cN5KzIU6AN+Q1N7HaymKQdzvKF7+6kq5hQBVLoZttSXO6bFQT9FglB4eUVsahdIUcZXliKNULcmc4LXE3z5dAfXeegj8IGEYm7SV1vLTRIlUWv+NcDCKOC56c1cXdmPH0Sa3ejdkNpEIj9jJNcyTHIJrbdFfiI78vFi2iHNkzmSHFYyHmc6OG+uDLRmnUYBcJ1VGDSnzi7l/TWr3OS1LKOOjRD0VyjIKryPdmWuIvPFIn18wiDzY6rC8+/nmMq8+twjwRlEnzxfk3YUVB4/yw79idjnqpkaGI5jdBtlOYG2A7NbdNEcsm+66vLJPTJgpxX6l8A3lDPUgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0umDDp7ZyWLee9OpwSny26aNghX5q4cQ9wHdzMIqTA=;
 b=igMXdhAuezrb8s7cf1X7auxPmABMSbULQ4K9aTCQQukrhcuW7XGWo6RzJGxrkVrB71vxARDQtPOFEdoadc3E0vi83L12mZCWJ30iZL0pvW5xHusDPrOd/VqX5Jk5TKQd9jpIlzCh8OwVlzTecyXP90gMjYGmpBfipXtFTKdqInk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10751.eurprd04.prod.outlook.com (2603:10a6:150:20d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 23:02:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 23:02:46 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 10 Jul 2024 19:02:22 -0400
Subject: [PATCH 1/3] dt-bindings: usb: Add fsl,ls-dwc3.yaml for layerscape
 usb3 glue layer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-ls-dwc-v1-1-62f8cbed31d7@nxp.com>
References: <20240710-ls-dwc-v1-0-62f8cbed31d7@nxp.com>
In-Reply-To: <20240710-ls-dwc-v1-0-62f8cbed31d7@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720652559; l=1725;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Xe2ZsA6XK2+7YHKlgNVGziXAOnQGAXiVcvdtt6S8VN8=;
 b=EMLRO1MKUzLkrbtygNsRoQcPq984goe0RbTnYa/SVZ6VZiI7ngfkv6fwZaM6WFmICbJXSq8nE
 qwjuWG53hzABYnty+eYiYiyb8RTIXWYP4aCqX+rKV2C3VXI/vveAycd
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0092.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10751:EE_
X-MS-Office365-Filtering-Correlation-Id: 25a8eb69-0457-413c-0b89-08dca1346999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVRPR3BCNm9Way9mbGNJSmlJSVVrV3NDRnIxQWhKRG1Jd09leW5Uck9WaHlI?=
 =?utf-8?B?K09VOUVQV0hOTU1xaXliYWJmVXl2UFFvKzNudndQclFsVStPTmNpaVQ3SC83?=
 =?utf-8?B?SmdqTFJibWRHZkZkT3hMZGRCVS8wUFBOZDRiWmhLT2FRbWhIWkIrVnY4cXpt?=
 =?utf-8?B?ckp5WGllb2k2alVHaHdXaFFKR2cxRjhrMzF4STNqNERHZHJzV004QVdnempl?=
 =?utf-8?B?N3YyR3JaNXNDdlQ0T3lZZXpPRUVKTHdQTmNXdmFEaVRYRngwSGV6ZWU4YkhW?=
 =?utf-8?B?N05UL0RUSllwRzJBTUgxU0ErV2c5Q2VYTEZLWUJZK3ZWVkZvL0xHUTA3SEpI?=
 =?utf-8?B?MTYzQVdodUNhbnhCQUxKUUQzMjBaeXJ0ZlZNQUN2VnBKSng4ODc1bm05OW1q?=
 =?utf-8?B?ZFZzeWZCc1AyRlE3aFgxY0ZhN3ErTW9XWTJUeHEvakV6VXdyZVZrSGIyOXc3?=
 =?utf-8?B?bEZkRFk2VFRJTG91dkkwd1ZISEwxazdLUlVEODR4dkZ2a0Y1ZjlnaGRhUFQ1?=
 =?utf-8?B?NXBQQ3VZQVdaT2Zlb3Z1VE9LMGczSkhrN2VNd1VsODNnN293RjFsSlcyVFNs?=
 =?utf-8?B?enR2MThiY3VCNW8ybk5RdERPd1pxaWRhWVdpUHg3Sjc4eGtwdzk3Z3k4YURh?=
 =?utf-8?B?TUg1L0FaRDNjRi90anE4VUE3MTFnSHFBV0dGdGJmaVc5eW11WlRBaFdRc1dr?=
 =?utf-8?B?UjhNS0IxNzN4amMvMXIwQTFqSEg1dXhGaFV2bStHdm1PU3NXaDMxTDBYMXJ6?=
 =?utf-8?B?bmYwbWx4SzdURE1iS2t2UWdPTjVvTm45TlZHdGdHQXd2bFk5b2J4MHpqRXVP?=
 =?utf-8?B?RURaQmp0dkJTQU5lSkU5c3VZa1hWeDBpNFA5bDZqRWJISmYzNldUcUlLWW1N?=
 =?utf-8?B?YlRQNzluL1A3R210MnZsQXdCYjZJT0ZUUWdVQklZVWRKZ3R2SVhsSXBtNWt5?=
 =?utf-8?B?eHhSOHFqRjk2b3JkWEJQN2lHQ2VnSjc4L2UvdGk3WXA1a3dTbGlVUDM4RDZN?=
 =?utf-8?B?SjdwbUFkdDRabDcvNlQ1bTA4WGQ3QS9vcUcwUlgybzVMT05QWWRWdjhxdXNq?=
 =?utf-8?B?cWVuODZHUTRKU1pRN1V6M2NZcnBTUWJLK2dDRFEzcFo1UVYyVFk1TEVrQ3JL?=
 =?utf-8?B?bjVJNExJN0ZRYlhWRFcydlU2cVN5TldQS09ZTkwxTkJ4dE9wMGNlQnovLzFP?=
 =?utf-8?B?VTIwUjNaYzFGTFlXbHU0QUN5MFRVdzl1ajVBWEY0dUI1TXQ4emxaU2t0U0VS?=
 =?utf-8?B?M3hVZmZRaWtZczZ1S2JzUWlSSWFyN0w4eVdNbHZlV25PWmxRZnM1VDM1ckpK?=
 =?utf-8?B?R1lMK3BmeEZISDNmN1MrbXNKai9QZVgzYk5NYUpySmtqeVI2UjdrZ1liZ1Fm?=
 =?utf-8?B?bDE2bmJJS21kVDJ5MWxBa05UblpiZ25SR0FvdEdBbFc5QXZEaVBxSXlTNUpJ?=
 =?utf-8?B?aDBka3BucWJtZStkdnNXMnlNRjdiVGFSR0lFYWlBNG0wUUxzVkdWZEFFQVBC?=
 =?utf-8?B?dG9FQmVmeHcydkN5Z0JRbWhHTXNTWlJsQ1dNeFBHQW50dkpHRFlkREg3ME44?=
 =?utf-8?B?bmZMMzNLMUNjeE5FWlBPOHNxT1dOTnlBNzFaT0R2dnovL0ZpcFhkV0JqdmJ3?=
 =?utf-8?B?WnlQRm1NY3RxN2pNNERzeTZZbGIxQ3cvRC9ETExrN0lWbkdEOXFsTjVpeEph?=
 =?utf-8?B?Rkc1MXdJSGc5b1lEeHpMYVJVaXJ6SVliUCtCTEt3M2o5Q3UxMW5HNCs1WmlR?=
 =?utf-8?B?VXAzRkxZQ2wwNVZhc3NGQnNqaVpTenZ5SE42VUphMVdQU2JCUitkNlFkMy9C?=
 =?utf-8?Q?xy9GFbV+AZSXd+4eTUcZD9e0MBTf4M8mgQT8Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aS96OG5Wb1BkZGZhWFFKbVRYSHQ0OWk5amVnemZnM3JwY0lpeUJHMlBlbHJ1?=
 =?utf-8?B?eVBUMlJVdkc2NTNGRENZMXlaZEpIajNIUFphcHNmWk4xS1h4dGRnOG9XeFlo?=
 =?utf-8?B?bGVCQ094TlVDbHZZeXNLWCtEMm14Z3l6b1JyNXA5cEw1OVNFUXFtRjBUMmxX?=
 =?utf-8?B?TFNzSjB5dE1BVHp4MVoyYmZmWjhGTnBTUmNwSy93Uis1RC9jelhxOEZQRWdG?=
 =?utf-8?B?ak5LOWRmOXd5bk1Pc0dNNy9kakVGcWtrRFJtWWRxakFqaU5yUkxYUTROczM0?=
 =?utf-8?B?OUYzYkFnTGFtZ2hkc2tIUWlCblU4NmNYcEZpWWtWOEFJMTZQOWlOL05Qd2lh?=
 =?utf-8?B?cVU4amhPaVdtMzRqWW5jT2VaVXB2bDFncmc4N01TTm5sT1VMU1F5OC9FN0ZF?=
 =?utf-8?B?K2M1QzU3emJrdjY4QWtFNkFBOEJ4ZnorR2xGWFZPWjVjNGQyMDcyUXllYS8r?=
 =?utf-8?B?RU9GVVBycUh4elNkejVGaXBvdTdWNzNQalliWkc4ZHRocFdKYkg2bHBXblBZ?=
 =?utf-8?B?UU1Hc3NSVWNnS0J0WXBnVUFSQTdKSVovS2xZbHU2bjlLTWVsNTVuUE43bVhQ?=
 =?utf-8?B?bkFIcnJ2dVh4TzlxZ1NKYmh6b3dscVNtZDBrTEcyaG5ZTHpoT292bDF4RUh2?=
 =?utf-8?B?c2o0dnhLOUI1RVhSbk8zZVN0UjdFTmlZVTBpS2EyYUVlR1V4NjNmd3VmYTls?=
 =?utf-8?B?U0tjeFZTcitzNXNiWkpaZ0hjejZsU0M4ZFJzc2ZWOVkrbXdHZWo2eXFjQVB1?=
 =?utf-8?B?SnRHc1ZxZ1hZWHJJS0JIYVVjYnk5S2pTRU94TmM5UDBFbHFsdTRJQm9tcGUr?=
 =?utf-8?B?ajY5d000cTdaZXZnNVJJRTNpaUg1Ri9SSnVNVXJ5STdxRkhQVjlsOUgzU0d5?=
 =?utf-8?B?b1REaGpjcUYvNUkwZDFVYkJjYXBvUWtQZGJTS0pZbkw5UUNXRjJjcmxBdEti?=
 =?utf-8?B?SnRvc0dEdTRqaWFSRGk4ZS83S3VDQlk1L2U3anRpbERLdk96T1RueTJmMWNy?=
 =?utf-8?B?NzNoOFRHZlBYS0t3aFcyamFaUG0wT1JjODBqYWNadEQvajVQcWdpSmh6Ty9J?=
 =?utf-8?B?bWZ2Wi9KSDNMVjBIMUZXSWxTQzVqeVNPZWl2ZkhWb0lsVEZ5ZkFPQlRadDYx?=
 =?utf-8?B?TFlTVnZIVGNZUnlRYjZLbFQ4U3VDQ1duQmEwc1ZXSU13S2MzcUk2QXphRHpo?=
 =?utf-8?B?QnJhaVBKNVpMWVRJRCtVV05GZiszaTBsWTBKenBrYXQzMmpPSzhqeTFJb0U1?=
 =?utf-8?B?TWdJQ0UrT2xscDdRZEdRSmNPcTZjeXROK2lpUWtaTW1EemFRcHdUYlFxUGtw?=
 =?utf-8?B?S3FtMUZQNFFMQlR3allJNDRsUkZBYzA3ZGdnRk1qVTlVRXJGdVhTZDI5NGpP?=
 =?utf-8?B?T3lVNm1kRzdYUEtPczd6NzBtRnRWaUpLeUhpWHA5NDBWeTJXT0E2VTBmaW1C?=
 =?utf-8?B?SytLR29SUTFXclZRQ1pydzRNOWZrVWlpUFNoblBMM1hMT0k2MnExYkp0ZlZz?=
 =?utf-8?B?Y2tnRHVJWnY0YVJXbFpXcFRNNzVtblVVaHI4UlhSSk1oK3VoWVdXSklzMU1R?=
 =?utf-8?B?bm1jeDQ3eEdnVGRHS0ZxUDVjbndLaFlNMDh4dFhxdnZWalpoWmdxVi96ZHU4?=
 =?utf-8?B?L295VEl2eHl1dFd5RW9oRUU2MWpER25pYmV0a1dkcStuUWZ4bHhVclJLYnJy?=
 =?utf-8?B?UU1tak94NTBPWFh4QjdQVnRJSmQrVzVXRHVuYTVaVlNJVHVJOHhTdVVFZ011?=
 =?utf-8?B?eitRSUdpTHRVdFJEM0FURS8rNXR3ZnhUbzFZWmZzZmhRaDhEMzF3R3ovRGxE?=
 =?utf-8?B?RXVBZTdhMzNkUnZGV09zNFpWcndCNURza214RU05b1l2clBtK2ZpWVBjLy90?=
 =?utf-8?B?MTNMVDRHM1p2MHRUTXFiUkdRQXBrTXV2RXpxaDV3OGhVZ1BYOVIvTUZsWHpP?=
 =?utf-8?B?MlhhQmVTWkZEWlBxVGV1bkh0YUVKaGlqeXA1dldacmRsYjl4RVFwZTNSak5Z?=
 =?utf-8?B?K2g2T0NDM250aEg0eVQ4ZGFEOVNtQm1CNlJZNVRaU1AwVjQ4T3c3cDRTSEpp?=
 =?utf-8?B?dE5rV0hxV3FaWDZKOVVmUHUzTkJDUTdtWWJjbVJwYmYzZ2VMOUhjK3lDYldm?=
 =?utf-8?Q?0opEOJzcoRVptQ5/LrR3YVfyM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a8eb69-0457-413c-0b89-08dca1346999
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 23:02:46.2480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eB7vQqsdJcQh5qGFyVKjRkUw41XO4YCsBtLuOD5ROQS55zJN/3ah3saGN81MMMcDF/dRR7dtVJno7mJ+uSEXdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10751

Add fsl,ls-dwc3.yaml for layerscape usb3 glue layer.

Layerscape supports DMA coherent bus fabric. It needs to pass down a
software-managed property to the DWC3 core.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/usb/fsl,ls-dwc3.yaml       | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/fsl,ls-dwc3.yaml b/Documentation/devicetree/bindings/usb/fsl,ls-dwc3.yaml
new file mode 100644
index 0000000000000..e79416122d12b
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/fsl,ls-dwc3.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/fsl,ls-dwc3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale layerscape DWC3 USB controller
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    const: fsl,ls1028a-dwc3
+
+  ranges: true
+
+  '#address-cells':
+    enum: [ 1, 2 ]
+
+  '#size-cells':
+    enum: [ 1, 2 ]
+
+# Required child node:
+
+patternProperties:
+  "^usb@[0-9a-f]+$":
+    $ref: snps,dwc3.yaml#
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    usb {
+        compatible = "fsl,ls1028a-dwc3";
+        ranges;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        usb@31000000 {
+             compatible = "snps,dwc3";
+             reg = <0x31000000 0x10000>;
+             interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+             dr_mode = "peripheral";
+        };
+    };

-- 
2.34.1


