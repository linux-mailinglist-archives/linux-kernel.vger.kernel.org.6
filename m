Return-Path: <linux-kernel+bounces-314811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C41296B95B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3D401F284D2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C141CF7C1;
	Wed,  4 Sep 2024 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kNc3+kk8"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011035.outbound.protection.outlook.com [52.101.70.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C74613AD22;
	Wed,  4 Sep 2024 10:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447334; cv=fail; b=dslQwKYx4L+C8+Et7fB6zpkrAYSbDMh3llvgPoHGSwGbFqccKVvOytmVBirN+MPHtKHstJdQm6DFnCJCPFy/xRbmuwiCBnlh+TwHoQathzCXGylOclWw47SC4xDIIxdBj0xtR2WzV44pcx+fPR7d5PH1o7lCrotYcfCCnsPjIxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447334; c=relaxed/simple;
	bh=qMJBWa/3Y2OPDnFfNddesZ1BmE3fUgQdIu4mDXcGvk0=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=WNUcTzZqnTgb2Ap63MAK989PxhXi1oeQwLyeTM9TcvMi6egVGJr8F4oBW/pb9yPpdX+dY5Kuh4v/C2AZOi4QR2Tflnq9BgkwQh3rdru8EzR5M2Cxdv58PlOd6EiH9H5ZPNAfzeMcSeuFaa33It1VEVbHduqDDApFKE3kExseZtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kNc3+kk8; arc=fail smtp.client-ip=52.101.70.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euZqoaHW+QP6cR+jtWO+dMJUZc+eITF8iSI8ytFXtH6bmO/1BOeQEu1Ib0/lq8IeaJg7Ea01ch1ZtYUQ1LT/MkOZtl9PtdJtHV6K7fVcgzGReUv2CmEs99K9RiPjY2S90FpOKA7RxphjaR/sECbNGhgDaaCKosuN2XjvhD2Zzw6iIagJZDXQUTMGV9+5mjA0qFtfZbOnHqo11Je1BuBQabd/3h/FMY+qiNNv3VQbRF1lwmAfu+p5YFjn6iuMSxmfg1hMGs2vLQZpzWT7mMLoeBQ0z7lNZvdY80VwmzAqIhXkW4xmQ2EA6hgmscOAefHyiBmLuNzluI+4ZA1Crw9LPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiT9GBF3g/EfUiErUSLV+MQ0IjN+AMhpJZhIGEbpvDM=;
 b=hFpHE/okvSDPZ2z3uIxdCbYjsFEuaneyx5ajMexxc2hIVuR4pRha7lzc7mhnBzIe0TqdBhwB0I3pWCUgJf8FzBOrTOA3Cf1mzxc61tktrL2uMqd1fj/hsWtecu7HqX5xE9A4N9u99OyepRyN1iUuSIHHc9I0/f5O4DfaU4zRC+VcjyEJ5AckVV3c5Z1kmQrMYnx54iapRLdg7ZZ2zJ2Gnm6b7MEM3c6gplBpIdISK06QArmhxtefhnSOInfLzkKwP9Em0RjW2B6JVVM3cRowmpq2DNTVt+RxBG4siJOLbBD610Hnq2oHyzxgwkHmPKm0F43AlAWEbOfXwk88DTmD7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiT9GBF3g/EfUiErUSLV+MQ0IjN+AMhpJZhIGEbpvDM=;
 b=kNc3+kk8lb1BD8u7QFXqpFxrAnmbs8r5Fawz/On8D1WIfANQxt+y5J+KepKQMtlRX36Pmh2cMj7qw+5LpMmW6qqMU7Eqrc6bGYuQRdta3DbRBDvbe0MqM0tRcHiyqOhFRUnthTJP/OJP7/55mmUly1FV6Xv3eM0z1awFMWXSGnDXdiT269TUj1w4n1AJev0FwS/DJzolR6rGl3KHpi9+5oN6tgo9YK1eVNyQC9k4o/bdldw7vHExbt0v74z29PtCigdbtdId06yvgciLBo4WRRGmxDOOCnZGZGq7i6WkXvfWQ+xxFGUeGExtqFL+8EKbXlIminpzbBtezbDJc0rrJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DU2PR04MB8583.eurprd04.prod.outlook.com (2603:10a6:10:2da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 10:55:27 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 10:55:27 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v7 0/5] Changes in v7:
Date: Wed, 04 Sep 2024 16:21:16 +0530
Message-Id: <20240904-imx-se-if-v7-0-5afd2ab74264@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKQ72GYC/13OTW7DIBAF4KtErEs1DH8mq96j6mIKuGEROzIVc
 hX57h1HlYK7fCO+x7uLmpeSqzif7mLJrdQyTxz8y0nEC01fWZbEWSCgAQtelusqK19HSQbAWgg
 6RSf4/W3JY1kfXe8fnC+lfs/Lz6O6qf3616Kga2lKgkQfLTlvgnLpbVpvr3G+ir2jYedQ9w7ZM
 RqTGgJZHY5OP51T/eqm2ZFPOKRMNho6OvN0HmzvzP4fJgDIaiD1b6ftnMLeWXbOkQ8BNA0ej85
 1Dg/OscsZHZvPAfud27b9AtaRhu64AQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725447104; l=17825;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=qMJBWa/3Y2OPDnFfNddesZ1BmE3fUgQdIu4mDXcGvk0=;
 b=07Q+mmZgZQavowXisBjN0B4pTj1SkOuc+GALYmM0lKw8tTdqHpCx/pIJgT4TW+iFYeM7f7cq8
 xQ/a7R44y+nAfp0VbZW+voOCxEHWjap/CxYovx1KZiMHCeAPmkQQ1PA
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DU2PR04MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: a6fd9417-7331-49c4-5966-08dcccd015c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qi91YTlwY2ZJZStTYVFQUTFyam4rWW93Znp3V3U4VjBGdXY1amo3bmU4VDFl?=
 =?utf-8?B?dVIySXdicFNaRVV1MmJWaDFseUQwMVkxRFNlenQ1bGJ3Z3o1MW51UHNFRnpv?=
 =?utf-8?B?MThWK21nYUlwWHJWUTMzL1oxU2NiZkFuZEkxTHhZYmdIdW1lNStzWXVlWjhr?=
 =?utf-8?B?VCtpYVJEVXRuNlAyUEVTTWFoYlZRQ2pOVi9xYXVYVTMrQURxRC9GZW5WWDE5?=
 =?utf-8?B?OFE2SDZkbVhRRHN2TTFIL3VGV1B0WXJ2aVBqMTNBZ0xoVkhkZXZxUVlLSzhG?=
 =?utf-8?B?WlcvM0dxcStqRjFnT3JGdnQwVkFPblpjMHpveVN2ODZTNks2RW1uMjhXWkZw?=
 =?utf-8?B?aDZmdzkrem1GREx1KzNrZzBkTWVpYWlVZU95Q0pIZ0ZGNW1FRmk0YTlhT0Uy?=
 =?utf-8?B?bDdLa0hrVWN1M2gyU2F6bTlzU1RySmRoenF0blBHNFRneTlxL3R1aHBOajJQ?=
 =?utf-8?B?bHlzNVIvLzIvV2NZblVJS0crb3lZMDY4TVZMd2hXTk1BMm5RbTc2azlIcU00?=
 =?utf-8?B?amRJazdzOGFEdjlwUTBWODFDL1V2bGdOSjFLMHNuL1ZXbjlQVlh3OUl5L09a?=
 =?utf-8?B?VlZ2dWdIWndvS1ZRS1JqUElMcFZkZ3NnVWFpV1NFWHVITm5hMitqcWdZWWI2?=
 =?utf-8?B?eS8xK0VNY2hwYktZczN6R0g5R2c3eXlBdHVHTVpITzUxTm5NWnBPSXM5S2N1?=
 =?utf-8?B?czRHQ1BUSFVUSmJnR0NCdEtnVDVrNFdXbzJoTmdqcGk0blppemVzMi91MURO?=
 =?utf-8?B?eERvRUZaamM3aXdFK0lOVjlmeGVRU1J1QnVhcXNDRkpuREhubTVSVDRqQ2ZF?=
 =?utf-8?B?YVZuaUZqUGpqTVlnekdycEdNSUtNRW9PamdhVFpXYnNCRUVPZnhiaU9wbHlj?=
 =?utf-8?B?K2ZYaXhsV2FhakJRL3RSdU5VSWR0OUtDdFI4alhHWDQ1ZHZKUWNURk1UWmxv?=
 =?utf-8?B?ankzTzJsU0wxSEluaFlvT2h0WTBFaFRreDFKZEU4dzAwWXpxTmIxYlNWaG9D?=
 =?utf-8?B?NGVYSTFFdlBqUkFDakN4T3VtWjRMc3ROYXdKL2oxOFN1WDA5Ny9HWHFicTZR?=
 =?utf-8?B?NFF3dkZUSnhKaHVtZXhQcFVnc1ZwTzdleXdxUGMyVjdHaWhuaWovRlo5ai8v?=
 =?utf-8?B?UWpqTDl4T2FTbWpQRkJMZ205aEdzWVRqK3J3YU5QU0dQYk1TQiszNTdIT01O?=
 =?utf-8?B?dnJ1QWYrQWthbXNQUC9BYVhzVEhCQjdESTQ5MFd4dlIyN1d0VitRcVVLZ3V6?=
 =?utf-8?B?OVIrc1dzd2srUkMvNmtFU0lXQTJ0RmFqbVZaYWNqUXhDemxlK0oyMTdEVE1o?=
 =?utf-8?B?YzVrYnZxSFY1aFh4WlMwblJCMHBtSkhhTUQvUFI4MEQwWlYrTjVnUTg2QU1P?=
 =?utf-8?B?a1VUZnJnR3N0aXFveVQ4eWVQVi9JdWI2dDdXdFVPTThzVlN1cnRTS2wvQ2tZ?=
 =?utf-8?B?SzdsTmNUa1VMajJNMjJYTDhJbjU4V014OGg2azdlZCtmTmdmdEJUNnYzTVVa?=
 =?utf-8?B?THdoaDdiOTJRSFJYS1BLcUxNaWs2dU9tMkN1VnVYY2YySFRtSnN6VU0yM1NJ?=
 =?utf-8?B?akNScjBWY01iOGs2ZEZsVm4xbEZTcEQvV0hwN1VYMFM1ZnowRmFXd25XQkVl?=
 =?utf-8?B?VUFoNEtIMXcyWFBTMFZXVm5uanhSSnVSNVVMRW5zc1F5QTZPd0ttMExoRG9K?=
 =?utf-8?B?UTBRWGRLb0dQTHhlS0RmaVovRUx3NFRRdXRjM1hHZGVrMUVZU0J4QU9DVnpN?=
 =?utf-8?B?cytyOXhsNzJvUDhkVmw3eXltZmtDWlduUy9JNmFxS3R2a09JRUhNTnppVUlq?=
 =?utf-8?B?U3pLb1lJNTIxS2xjaUNoQUJXTEtyaFR2NHVNK3lwSjlPVTZRM1FFeWdlZWdF?=
 =?utf-8?B?RWZVbGZxUFRRd0Vva1hNLzBiMDBWQkc0N1Mvc0NndVdPbkd2MGlvUk80Rng3?=
 =?utf-8?Q?Kb6OEG5QjGg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bStsNlB5cWxPcklsbDIzcW8zOFNMNzZaYmthcVZUSjJLYzJnQVVmWnJqQkla?=
 =?utf-8?B?RzBocjJCUlFFMGpEVEFaTFdFVUZZajJ4OXlyd2Z1K2h6U3JhYjZVYnRsVjVJ?=
 =?utf-8?B?cHpKN21QUHBubUc1a0lhVlR3NDFYcXI2QktzaVo0aVhvT3BqTWl2eklvS0Fp?=
 =?utf-8?B?eTNyZFJKSEo5NFVTWGxZeGRobEdlbkFzNXFONk55THI0eG1xdVZ2QXR5WkJX?=
 =?utf-8?B?RStzSkpSVStZd1VxOU5hRVJKcGJCTG5NcnBxL09Ic2tJdnUyUFN5Mm9tazdJ?=
 =?utf-8?B?MHdtTG5BOXNidkE3SE5vVldrcWt1cVFGa1pnYUNVa1Zkcy9SQ3Y2dGxsNy9r?=
 =?utf-8?B?L3FNTUJkdHJLdktqYlo3QTZrK3JFdWVhdXVGRnJEeVB5S3J1VkMrQ1ZuZTRp?=
 =?utf-8?B?T1JnVGRkcEIrekQrTUltajY4RlFhMmlMRkZwZng3N0thODNGeExDYXdXOC9P?=
 =?utf-8?B?NVRPRFJ4Zms5ekgzZG9kQktxODVya2tWL0JQTzJ6dDQvN05ZQ3BCMFdpdXd5?=
 =?utf-8?B?WXFiTHY5eUVhY0xicFVsVmQ4ZHdUR2tzaXRaUTBTN3Y3TjZSaDBxc2twR2ZU?=
 =?utf-8?B?cFRDSGtXSkZzUzl6V1BUSHBsVU9GdVRTZUNvK1JUNk1MK3RuT0hOUmVlK1FD?=
 =?utf-8?B?TkFFd08xeVhqbHNSMlV4ak9EL0pqVklodkNQSDVPQ0lFc05SczVvTGlyTHVV?=
 =?utf-8?B?UTE5Ym9zL2JabFpOaFhaamtGUHBlWmI4aDB2anduZGpLNDQwc2laUnJXK3pG?=
 =?utf-8?B?RTNNSUpabG5TMGxEdUx3S3R1Tk5HMW43UDlOdzJEcjdqcGtrYTF3bVF6bTFS?=
 =?utf-8?B?cmtWVnFyRjkwVjFwM3ZmeG9RUWFsbHVBL3R0RWxCazZHaU9CUEJyb3kxWGpn?=
 =?utf-8?B?Y0ZBVHoyZFBRNnRTSDlHUGczZklhK281dndFSnRrVmZqWGwwWkxseWtkdk05?=
 =?utf-8?B?Zk90OEZ2VnYyeVRZYjBDOXpwR0hVVGRzMjVlMTJGMHhOREJiY0hxcUxHU0VI?=
 =?utf-8?B?YzZ6YUNhbTArcjBFSEtDdWlxemJzdmJHLzE2bjFscDVnMDRCSm1kMnRLTjZy?=
 =?utf-8?B?TlFZc3NyRVgwZjE2NlNEendWbnBmZVlxQ0dBcjVwdjEzWDl1ZHZrcW8zOEZG?=
 =?utf-8?B?T0pZZmpXWEwxTUU2ZEs4YzVWODl3NVhVbDdsLzNKNUsvN2t0cnhEcUk3QkIz?=
 =?utf-8?B?c0g2Q0J3c0M4QWhWV1g0cDlNTEZuaE05R0ZRYXFjZ2xEVmM3a1gwcmd2VE5x?=
 =?utf-8?B?NnI1UXVLRzNvbSt0ZlM3WHhCWTlEMjlxYVlpbkZhVzl4SDlNUjZJVVU3Qkh3?=
 =?utf-8?B?MGZ2cGRtKzY4bW9QdWF0MUVMcTJUeXQwdU9sWmxnd1lXVmRtdGVlMXk4MFV6?=
 =?utf-8?B?aDJSYjl3dlBNb3oxMmFLSytzWjQzYzVnZFpyemduNEhOakh1SitKWlRpRGE2?=
 =?utf-8?B?Wm5hdHNLQkttTHNZODZyMlBqTldFWXVmQzhXU1hqS1Zpakk0QjI3eTcvOU1M?=
 =?utf-8?B?cWN2cWFmSkdCTmVOc3lOMTRpcGVDeXRndzFlaDFRZVhLMTFoSFFxbXJobkdn?=
 =?utf-8?B?Q1hoVVpWcEhueFVyV0xYaWZQRVArQXI0c29ObTR1SE5yYm5WUC83dyt2S0Q0?=
 =?utf-8?B?eEVsaVhrdk81L3hhdEQ2QXhzaWZLS2RCbFNjUEthZkVJd2NEUlpKQ1VlVEFp?=
 =?utf-8?B?Z2dHS1p5cHVMRTg2dTZKUU8zVExKdnAvS01kMUJwUVJTckR4NG4zaDhmeWJr?=
 =?utf-8?B?YjlKa2ppNXQ3TjN4SnBBWVg4bDdTQ2x3ZXZsTDlLa2VJRnZvSm8yQ1JsTmcv?=
 =?utf-8?B?NHBqY2xKOUgxcnhnUmdwdXNpRVRHb1A0eDdnS1FOWUd0eVNrdDJFWjI1bTRQ?=
 =?utf-8?B?eHMwRzBMaTkrN0JpanhtbE5TSCtvRm04RC9ybTI5RVhTcmo3cVhsNCtGbWRr?=
 =?utf-8?B?dHpGVVhxTUpTV0dZTnlkd0xPWmR1YkpvTHQ1ZlQxMitKRzlTNllrQjJrNUNo?=
 =?utf-8?B?VW43MHhqZDNtZTFCQlAzSmZreHJzdzBoUWEyZC9LZDNGc05nanZRaExsMUtp?=
 =?utf-8?B?MmppekJlUTBqNUpNYTFOVUdaTFJsTVRTbXdHTWlTeDZjSWQ3SVJtK0dMdmNh?=
 =?utf-8?Q?e1/piRlKAk5DDepWqSSCj3dTu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fd9417-7331-49c4-5966-08dcccd015c3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 10:55:27.1936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p867K19aq5VzqLx9Vfuw9IUvvVbj/ForsDutMjMk5XZ2kW/jsAYSTP10SmEOQKsW60ruJlZ82bwVPEdvrBHZ+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8583

5/5
- struct se_clbk_handle, is added with a member struct se_if_device_ctx *dev_ctx.
- func call to ele_miscdev_msg_rcv() & ele_miscdev_msg_send(), are removed.
- func se_ioctl_cmd_snd_rcv_rsp_handler(), is modified to remove the func call to ele_miscdev_msg_rcv() & ele_miscdev_msg_send()
- func se_ioctl_cmd_snd_rcv_rsp_handler is callig func ele_msg_send_rcv(), instead.
- Mutext "se_cmd_if_lock", handling is removed from this patch.
- func ele_miscdev_msg_send() is replaced with func ele_msg_send(), in fops_write.
- func ele_miscdev_msg_rcv() is replaced with func ele_msg_rcv(), in fops_read.
- fops_open is modified to create the new dev_ctx instance (using func init_device_context()), which is not registered as miscdev.
- Only one dev_ctx is registered as miscdev and its reference is stored in the struct se_if_priv, as priv_dev_ctx.
- Separate func cleanup_se_shared_mem() & func init_se_shared_mem(), for shared memory handling part of struct dev_ctx.
- Input param for func(s) ele_msg_rcv(), ele_msg_send() & ele_msg_send_rcv(), is replaced from struct se_if_priv to struct se_if_device_ctx.

4/5
- A new structure is defined name struct "se_clbk_handle", to contain members processed in mailbox call-back function.
- "struct se_if_priv" is modified to contain the two structures of "se_clbk_handle" - waiting_rsp_clbk_hdl & cmd_receiver_clbk_hdl.
- func ele_msg_rcv() is modified to take a new additional input reference param "struct se_clbk_handle *se_clbk_hdl".
- func ele_msg_send() is modified to take a new additional input tx_msg_sz.
- func ele_msg_send_rcv(), is modified to take 2 more inputs - tx_msg_sz & exp_rx_msg_sz.
- func se_val_rsp_hdr_n_status(), is modified to take input of rx_msg buffer, instead of header value, as input param.
- each caller of the func ele_msg_send_rcv(), is sending these two additional input params.
- func se_if_callback(), is modified to work on two structures of "se_clbk_handle" - waiting_rsp_clbk_hdl & cmd_receiver_clbk_hdl.
- Variable "max_dev_ctx", is removed from info & priv struture, as well its usage.
- New member variable "se_img_file_to_load", is added to structure "priv".
- Other member variables - rx_msg(ptr), rx_msg_sz, completion done & list of dev_ctxs, is removed from priv struture, along with their usage.
- func se_resume(), updated to wakeup the two "wq", part of "struct se_clbk_handle": priv->waiting_rsp_clbk_hdl & priv->cmd_receiver_clbk_hdl.

3/5
- Node name is changed from senclave-firmware@0 to "secure-enclave"

2/5
- Node name is changed to "secure-enclave".

- Link to v6: https://lore.kernel.org/r/20240722-imx-se-if-v6-0-ee26a87b824a@nxp.com

v6: firmware: imx: driver for NXP secure-enclave

5/5
- replaced scope_gaurd with gaurd.

4/5
- replaced scope_gaurd with gaurd.
- remove reading the regs property from dtb.
- Added NULL check for priv data fetched from device, as a sanity check, for ele_base_msg apis)

3/5
- replace firmware with senclave-firmware.

2/5
- replace firmware with senclave-firmware.
- drop description for mbox
- Replaced "items:" with maxItems:1 for "memory-region"
- Replaced "items:" with maxItems:1 for "sram"
- remove regs property.
- remove "$nodename"

- Link to v5: https://lore.kernel.org/r/20240712-imx-se-if-v5-0-66a79903a872@nxp.com

Changes in v5:

2/5
- updated the description of mboxes
- updated the description & items for mbox-names.
- updated the description of memory-region
- move "additional properties: false" after allOf block.
- removed other example except one.

4/5
- Corrected the indentation in Kconfig.
- info members:mbox_tx_name & mbox_rx_name, are replaced with macros.

5/5
- Replaced "for  secure enclaves", with "for secure enclaves"
- Replaced "user space" with "userspace".
- End the line "[include]<linux/firmware/imx/ele_mu_ioctl.h>" with a period.

- Link to v4: https://lore.kernel.org/r/20240705-imx-se-if-v4-0-52d000e18a1d@nxp.com

Changes in v4:

1/5
a. Removed - from EdgeLock Enclave.
 
b. Removed , after "Each of the above feature,"

c. replace "can exists" with "can exist".
 
d. 
-messaging units(MU) per SE. Each co-existing 'se' can have one or multiple exclusive
-MU(s), dedicated to itself. None of the MU is shared between two SEs.
+messaging units(MU) per SE. Each co-existing SE can have one or multiple exclusive
+MUs, dedicated to itself. None of the MU is shared between two SEs.
 Communication of the MU is realized using the Linux mailbox driver.

e. 
-All those SE interfaces 'se-if' that is/are dedicated to a particular SE, will be
-enumerated and provisioned under the very single 'SE' node.
+Although MU(s) is/are not shared between SE(s). But for SoC like i.MX95 which has
+multiple SE(s) like HSM, V2X-HSM, V2X-SHE; all the SE(s) and their interfaces 'se-if'
+that is/are dedicated to a particular SE will be enumerated and provisioned using the
+single compatible node("fsl,imx95-se").
 
f. Removed ",". Replaced for "Each 'se-if'," with "Each se-if'.

g. removed ","
-  This layer is responsible for ensuring the communication protocol, that is defined
+  This layer is responsible for ensuring the communication protocol that is defined

h. removed "-"
-  - FW can handle one command-message at a time.
+  - FW can handle one command message at a time.

i. 
-  Using these multiple device contexts, that are getting multiplexed over a single MU,
-  user-space application(s) can call fops like write/read to send the command-message,
-  and read back the command-response-message to/from Firmware.
-  fops like read & write uses the above defined service layer API(s) to communicate with
+  Using these multiple device contexts that are getting multiplexed over a single MU,
+  userspace application(s) can call fops like write/read to send the command message,
+  and read back the command response message to/from Firmware.
+  fops like read & write use the above defined service layer API(s) to communicate with
   Firmware.
 
j. Uppercase for word "Linux".

2/5
a. Rephrased the description to remove list of phandles.

b. Moved required before allOf: 
+required:
+  - compatible
+  - reg
+  - mboxes
+  - mbox-names
+
+additionalProperties: false
+
 allOf:

c. replaced not: required: with properties: <property-name>: false.
   # memory-region
-      not:
-        required:
-          - memory-region
+      properties:
+        memory-region: false

   # sram
-    else:
-      not:
-        required:
-          - sram

d. Reduced examples. keeping example of i.MX95.
e. node-name is changed to "firmware@<hex>"

3/5
- node name changed to "firmware@<hex>".

4/5
- used sizeof(*s_info)
- return early, rather than doing goto exit, in ele_get_info().
- Use upper_32_bits() and lower_32_bits() 
- use rx_msg here instead of priv->rx_msg
- Moved the status check to validate_rsp_hdr. Rename the function to "se_val_rsp_hdr_n_status"
- typecasting removed header = (struct se_msg_hdr *) msg;
- Converted the API name with prefix imx_ele_* or imx_se_*, to ele_* and se_*, respectively.
- Removed the functions definition & declaration for: free_phybuf_mem_pool() & get_phybuf_mem_pool()
- removed the mbox_free_channel() calls from clean-up.
- Flag "priv->flags" is removed.
- Converted the int se_if_probe_cleanup() to void se_if_probe_cleanup().
- Replaced NULL initialization of structure members: priv->cmd_receiver_dev & priv->waiting_rsp_dev , with comments.
- Removed the function's declaration get_phy_buf_mem_pool1

5/5
Changes to Documentation/ABI/testing/se-cdev.
a. Removed "-" from "secure-enclave" and "file-descriptor".

b. Removed "-" from "shared-library"
 
c. Replaced "get" with "getting".

d. Added description for the new IOCTL "send command and receive command response"

e. Replaced "wakeup_intruptible" with "wait_event_interruptible"

f. Removed ";"

g. Removd "," from "mailbox_lock," 
 
h. Replaced "free" with "frees"

i. In mailbox callback function, checking the buffer size before
copying.

- Link to v3: https://lore.kernel.org/r/20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com

Communication Interface to NXP secure-enclave HW IP like Edgelock Enclave

Hardware interface of the NXP Secure Enclave  HW IP(s) like EdgeLock Enclave,
V2X, SHE etc, is based on the Messaging Unit module that enables processing
elements like ARMv8 core, RISC V core, within the SoC to communicate and
coordinate by passing messages (e.g., data, status and control) through 
these interfaces.

The NXP i.MX secure enclaves hardware interface kernel driver, is specifically
targeted for use between application core and NXP secure-enclave(s) HW. It allows
to send/receive messages to/from the secure-enclave.

Patch-set adds the kernel driver for communication interface to secure-enclave,
for exchanging messages with NXP secure enclave HW IP(s) like EdgeLock Enclave,
both from:
- User-Space Applications via character driver.
- Kernel-space, used by kernel management layers like DM-Crypt.

To: Jonathan Corbet <corbet@lwn.net>
To: Rob Herring <robh+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>

Changes in v3:
5/5:
- Initialize tx_msg with NULL.
- memdup_user() returns an error pointer, not NULL. correct it by adding check for err_ptr.
- new IOCTL is added to send & recieve the message.
- replaced the while loop till list is empty, with list_for_each_entry.
- replaced __list_del_entry, with list_del.
- Removed the dev_err message from copy to user.
- Removed the casting of void *.
- corrected the typcasting in copy to user.
- removed un-necessary goto statement.
- Removed dead code for clean-up of memory.
- Removed un-mapping of secured memory
- Passing se_if_priv structure to init_device_context.
- Updated the below check to replace io.length with round_up(io.length).
	if (shared_mem->size < shared_mem->pos|| io.length >= shared_mem->size - shared_mem->pos)
- Created a function to cleanup the list of shared memory buffers.
- Used list_for_each_entry_safe(). created a separate functions: se_dev_ctx_cpy_out_data() & se_dev_ctx_shared_mem_cleanup()

4/5
- Changed the compatible string to replace "-ele", to "-se".
- Declaration of imx_se_node_info, is done as const in the whole file
- Remove the unused macros from ele_base_msg.h
- Remove the function declaration get_phy_buf_mem_pool1, from the header file.
- Replace the use of dmam_alloc_coherent to dma_alloc_coherent
- Check for function pointer, before calling the fucntion pointer in imx_fetch_se_soc_info
- Removed the unused flag for SE_MU_IO_FLAGS_USE_SEC_MEM.
-  Removed the unused macros WORD_SZ
- instead of struct device *dev, struct se_if_priv *priv, is used as argument to the funtions:se_save_imem_state, se_restore_imem_state, imx_fetch_se_soc_info
- Removed ret from validate_rsp_hdr.
- changed the prefix of the funtion: plat_add_msg_crc and plat_fill_cmd_msg_hdr.
- indentation correction for info structures.
- remove the check for priv not null from se_if_probe_cleanup
- Removed the casting of void *.
- se_load_firmware function is corrected for not freeing the buffer when allocation fails.
- Checking if get_imx_se_node_info() can return NULL, in se_if_probe()
- imem.size has type u32. return value from se_save_imem_state() will be assigned to imem.size in case of success only.
- removed the flag un-setting in case of failure. priv->flags &= (~RESERVED_DMA_POOL);
- removed the function call for devm_of_platform_populate(dev);
- Checking for not-NULL,  before calling the funtion pointer se_fetch_soc_info.
- Removed the checking for reserved memory flag, before freeing up the reserved memory, in se_probe_if_cleanup.

3/5
- Changed the compatible string to replace "-ele", to "-se".

2/5
- to fix the warning error, replaced the "-ele" & "-v2x" in compatible string, to "-se".
- Added an example for ele@0 for compatible string "fsl,imx95-se"

Changes in v2:

4/4
- Split this patch into two: 1. base driver & 2. Miscdev
- Initialize the return variable "err" as 0, before calling 'return err', in the file ele_common.c
- Fix the usage of un-iniitialized pointer variable, by initializing them with NULL, in ele_base_msg.c.
- Fix initializing the ret variable, to return the correct error code in case of issue.
- replaced dmam_alloc_coherent with dma_alloc_coherent.
- Replace the use of ELE_GET_INFO_READ_SZ, with sizeof(soc_info).
- Replaced -1 with -EPERM
- Removed the safety check on func-input param, in ele_get_info().
- fix the assigning data[1] with lower 32 address, rather than zero, for ele_fw_authenticate API.
- Correctly initializing the function's return error code, for file  ele_base_msg.c.
- replaced 'return' with 'goto'.
- Use length in bytes.
- Corrected the structure se_msg_hdr.
- Moved setting of rx_msg  to priv, into the function imx_ele_msg_send_rcv
- Will add lockdep_assert_held, to receive path, in v2.
- corrected the spacing at "ret  = validate_rsp_hdr"
- FIELD_GET() used for RES_STATUS
- Re-write the structure soc_info, matching the information provided in response to this api.
- The "|" goes to the end of the previous line. 
- Moved the locking and unlocking of the command lock to the caller of the function.
- removed the safety check for device private data.
- Structure memory reference, used to read message header.
- In the interrupt call back function, remove assigning waiting_rsp_dev to NULL, in case of response message rcv from FW.
- do while removed.
- replaced BIT(1) for RESERVED_DMA_POOL, to BIT(0)
- The backslash is removed while assigning the file name with absolute path to structure variable.fw_name_in_rfs =.
- Update the 'if' condition by removing "idx < 0".
- mbox_request_channel_byname() uses a "char" for the name not a u8. Corrected.
- devm managed resources, are not cleaned now, in function se_probe_if_cleanup
- Used dev_err_probe().
- Used %pe to print error string.
- remove "__maybe_unused" for "struct platform_device *enum_plat_dev __maybe_unused;"
- used FIELD_GET(), for  RES_STATUS. Removed the use of MSG_TAG, MSG_COMMAND, MSG_SIZE, MSG_VER.
- Depricated the used of member of struct se_if_priv, bool no_dev_ctx_used;
- Moved the text explaing the synchronization logic via mutexes, from patch 1/4 to se_ctrl.h.
- removed the type casting of info_list = (struct imx_se_node_info_list *) device_get_match_data(dev->parent);
- Used static variable priv->soc_rev in the se_ctrl.c, replaced the following condition: if (info_list->soc_rev) to if (priv->soc_rev) for checking if this flow is already executed or not.
- imx_fetch_soc_info will return failure if the get_info function fails.
- Removed devm_free from imx_fetch_soc_info too.

3/3
- Made changes to move all the properties to parent node, without any child node.

2/4
- Use Hex pattern string.
- Move the properties to parent node, with no child node.
- Add i.MX95-ele to compatible nodes to fix the warning "/example-2/v2x: failed to match any schema with compatible: ['fsl,imx95-v2x']"

1/1
- Corrected the spelling from creats to creates.
- drop the braces around the plural 's' for interfaces
- written se in upper case SE.
- Replace "multiple message(s)" with messages.
- Removed too much details about locks.

Testing
- make CHECK_DTBS=y freescale/imx8ulp-evk.dtb;
- make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,imx-se.yaml
- make C=1 CHECK=scripts/coccicheck drivers/firmware/imx/*.* W=1 > r.txt
- ./scripts/checkpatch.pl --git <>..HEAD
- Tested the Image and .dtb, on the i.MX8ULP.

Reference
- Link to v1: https://lore.kernel.org/r/20240510-imx-se-if-v1-0-27c5a674916d@nxp.com
- Link to v2: https://lore.kernel.org/r/20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com

---
Pankaj Gupta (5):
      Documentation/firmware: add imx/se to other_interfaces
      dt-bindings: arm: fsl: add imx-se-fw binding doc
      arm64: dts: imx8ulp-evk: add nxp secure enclave firmware
      firmware: imx: add driver for NXP EdgeLock Enclave
      firmware: imx: adds miscdev

 Documentation/ABI/testing/se-cdev                  |   43 +
 .../devicetree/bindings/firmware/fsl,imx-se.yaml   |   91 ++
 .../driver-api/firmware/other_interfaces.rst       |  121 ++
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts      |   17 +-
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi         |   13 +-
 drivers/firmware/imx/Kconfig                       |   12 +
 drivers/firmware/imx/Makefile                      |    2 +
 drivers/firmware/imx/ele_base_msg.c                |  286 +++++
 drivers/firmware/imx/ele_base_msg.h                |   95 ++
 drivers/firmware/imx/ele_common.c                  |  318 +++++
 drivers/firmware/imx/ele_common.h                  |   51 +
 drivers/firmware/imx/se_ctrl.c                     | 1305 ++++++++++++++++++++
 drivers/firmware/imx/se_ctrl.h                     |  151 +++
 include/linux/firmware/imx/se_api.h                |   14 +
 include/uapi/linux/se_ioctl.h                      |   94 ++
 15 files changed, 2610 insertions(+), 3 deletions(-)
---
base-commit: b63ff26648537a5600cf79bd62f916792c53e015
change-id: 20240507-imx-se-if-a40055093dc6

Best regards,
-- 
Pankaj Gupta <pankaj.gupta@nxp.com>


