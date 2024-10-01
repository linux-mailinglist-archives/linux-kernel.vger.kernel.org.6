Return-Path: <linux-kernel+bounces-346272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E39698C221
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947451F25684
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB4B1CB506;
	Tue,  1 Oct 2024 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XBkEGIAB"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013043.outbound.protection.outlook.com [52.101.67.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7821CB338
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798622; cv=fail; b=mETGpae1LoXwn7a+BbEQdI0URQ+kewBhR+pCVc7rSPjnpYHsKgLFw/MzWFw/YXaozvnbeEOfYdo4x/Us6im4rlYCrGortW1ohYCGAGSp4zydvo8UznMkxsBwafkASgE7UHbEYE4ulunM/qRCV6bPDMhNwWMShrRFuJlI2sw3TG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798622; c=relaxed/simple;
	bh=XB6tbTYcSb/KrBY6OzX8Biv1p+7xsISlJpb4CG6h5aE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=liNjL2mqqRnaAhSJaXMLqxpqmXq0FB0xnNCXqu39lgLN6MfdbCW/f/Z64lJutZzw+yC+KIIaaU/hwwe0cPAMqVzH25G+iLtHexau7nYSCIjE8NuV5J2Ofrg9RlXxGB19yqJIhiO/V1MJqVf8oMWqLfRQILFG5s6+RhEfU96Bq78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XBkEGIAB; arc=fail smtp.client-ip=52.101.67.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rr/JenvCBZei6fdb7r6n3NHcnfJO5DT2KvHXUBPFC6uA6roNYG1TBGxVblQ8Io8VaJNjb872LZuTgmb4Ph/NkiXgZEjE9hQlWMrMwu5zJfnvTvLANsmxeK27cfU5OmtVkKNnNXgkZUjqxAm1v8dDYledmEphAlECYjFmn4E8sBBKOwcXvOWk7jqCdeogJdXtrDxe+sdXbJJcGhnb/KHkCxN+nOx26Jr9PKRzL6tr1MY3QqlOSb4z7C1lg1nyTqM/Fyd5c+OLSY1OGR5rPdxTsip3+6HJW79+nDnD5jL0dBu5LflIfzmkNfGDlgANWDzzJ88AS8Qz50TCuVqL5s6CtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7csOdTlPABbux1sT29PbmMTe7/81sXGNwUnWOPIM3d0=;
 b=Z9E1lbC4yNjMb+KLHPjKFhkF+JO24E9GKeEwf0xqVr4tQNui5czPnj042G+//vNjWUbhIUxRI4WHmqiPYD4Jri28TyL6Xl5oZhERAgL+MYRMVtoFrCKvZnA4kW4ImM+i+U8N7ljs4dOr7RMllplA+D9aBAkIki5zGOTKwqay1SNeR29Mz6DFAEKoOS1JF6eyAZLM1G3Ptx6D3tU9ximvtjaFbI/D+ztcv6f3+fwjggiM2D2/IUg1+8+HO+jZERt7KmrN3/3z6mw3Ms5mZ2xudtKuSdnCpshkW2nwq87l3UXtRlGozd1mCT/XN/qO7b2Af3EHCxcQDYBCSKtbyZpPLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7csOdTlPABbux1sT29PbmMTe7/81sXGNwUnWOPIM3d0=;
 b=XBkEGIABqT5Q8jlHFmP0P2PNCfjU7IcQ4Dd1lR/d7Y+iz4Di8WuS2hrKnR937ZTY7umortC0Kpzk8ZIRuy3XwxfrLKv/WXW0SwlgzDqJW130hknv3FvIWNjPyYxMarokMPlodYwzNsxoqoGQDPEZLJ4/mUMFGM1Zbexy6vzK+dVRwLBI2Fbs+tFbXGFi98hqV3htrOsPwJ6SsDJTK0Yca1kg8ZC3IUX27nXCX3cxJkxsio06IsJXlLRMcERX1PGWeaIGZTDNaUHSKmiSQ6yckTiKt0zkaM8L5PY4RwgJG4J7yHqosAJ8kkf1nz10mrOBIhvfLMw+gTUfISs3FoyvxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7879.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 16:03:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 16:03:38 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 0/6] I3C: master: svc: collect all patches to improve
 hotjoin stability
Date: Tue, 01 Oct 2024 12:02:49 -0400
Message-Id: <20241001-svc-i3c-hj-v5-0-480ab8aed849@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACkd/GYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAwND3eKyZN1M42TdjCzdpKTEpEQzi+Q0w9REJaCGgqLUtMwKsGHRsbW
 1ABkxU+9cAAAA
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, stable@kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727798616; l=1268;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=XB6tbTYcSb/KrBY6OzX8Biv1p+7xsISlJpb4CG6h5aE=;
 b=pMq/ft4GW4SG7p/S37j8boaCwrf0RvXxZ3cclpFCpp6misFSXpdMLcf7kSPO0bZFkX9zuk99Q
 Dd83M+YzUMjBOMduxkOjcWIQb2Yz3D5SJbkxy32DcUXQEdFrFKKqFh5
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0045.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: a85a658f-9190-4497-26f2-08dce2329c78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWlaTTBDVHdndTl2UGgra3IrNkJEb0NPeC8vNWpHU0p2SnZqemR4TXlzZlQy?=
 =?utf-8?B?bGFCQmMvUEJseGliQU96NWJPOW9oaVAySVFpU0dLeTJSdlZVUnpKOEdlUmkw?=
 =?utf-8?B?WWNIcjllaWVSQWhaOWZPUTNQRGZxZjl1bjNrcnk4SUl6L2pGT2JjbHowL2tU?=
 =?utf-8?B?enRVYnFkd3RYTUx1NTNRblZBRVhKeFdjUzhqOFZycnpNZG13clpTTHQwZTlP?=
 =?utf-8?B?dFRZU2h6NndFQmNzbnlTZDRWN3J3bUZrQnBCcVBXa0c5WHBuYXprZE9JclUz?=
 =?utf-8?B?OXFneVk0RU1MQ0pCMTJMeDJWb1NUNmtMbFU5RU5BREpVYm9Sb3FtbEFhOVF3?=
 =?utf-8?B?QUVHUHExdVlObnFlbDZUN1p2VWt6a0NDdVZ3QkdQdkpmVktHVDlLN2NRQ1hI?=
 =?utf-8?B?blQ3TjY1OTFPcDdwMS9JZ2pDU1BVSWtCYllpWjJIZnVUcGhuTVd0R0tkUEw4?=
 =?utf-8?B?RDRsc2ZrcmpVYjBIOXByZis4MUZFTVMvdE52UTIzVEZ5bHdzY1h3bEFGK0t4?=
 =?utf-8?B?RXM4aGN6V2dtRU1PbmNub0ljdHdGZno2Yml0TlBKMXpvekVzZWdYNHVnQlE3?=
 =?utf-8?B?RHRmaHZCMnV6ZExNRE14b2kvWnl0LzRXWHBRYkRldHJuejkvbGcySGxOdE1X?=
 =?utf-8?B?cHlsZWdKa3BUQXFNZTNyUGRyS3lNT3FIRXBTS004NWZwUHNZQzV4UHNDTmVF?=
 =?utf-8?B?TDBhdVVYNjJ5ekJMc3dFTldLTDZiYTZZNHIrL3c1ZXUrQTcwWGlYaGxFQm42?=
 =?utf-8?B?aTRvbFVxcDUycEdkVFNWaEFmdzNnL2laSHVqVzdqTHdFWWhwcklsSlRiRWpn?=
 =?utf-8?B?VlU1WnZqRGVHQlFOV2JxbG1YQ3VURDg2ZEp6d1IyUzlqY2JuQWoyWFVtVzhv?=
 =?utf-8?B?dlJWU0tUcC8rUDRDbVpRd0taZ3JYNllZVjdpaDFGakVSckQ5ZUtwUGpSUXA4?=
 =?utf-8?B?Nm16UmE5RDF5RGlPY1dFaU5SMUJPaWJMd0Vnd3pVUHlrNDBHK3B5Q081aHRE?=
 =?utf-8?B?YmVmMzJuZ0VUL0xEaS94SW5sYUp6TlB6aDNjWTNvOGVZVitGenVIcDgwdzlY?=
 =?utf-8?B?Q05CMC9yQmpuZG44Z3d5ZWdtWW1GQWVYZm80ekFwMFlBRTFnZnJ0Y05vdEtm?=
 =?utf-8?B?emV2U2VvMWExZ2hRWFh2N0d5YmJvNWpwL2krVTR5THh6dC9reTZTNTNlRmxk?=
 =?utf-8?B?WWNoZXQvSWpxaEVnZThiUzZONm0rQjBuTlphMzZTTm9WTC9hNDBzUVpuMnFI?=
 =?utf-8?B?Z0Z5S1Nhc3k5V1QzalhkWXhWUEdjTzFkYW85ZE01TVNpNUFzSFUxMnNTYy9N?=
 =?utf-8?B?MWVUVlEyc0tvcmpoaVFkckUrMis3VWJLNjdlN0JDbDFOa2FTU3hyQkQzbWtm?=
 =?utf-8?B?dTBzVDc3VGIxZ09yd0NTbmxnKzQ3c3JnRFFMUDdoRDdxR2FGS3JHdkxIUmZw?=
 =?utf-8?B?aXhNYVhGdGQ4RGkrcXM3b1NqYjdFVDloVkNBVTBIcjlCTnNQak5wT21JakJi?=
 =?utf-8?B?a2VGMXhxdlBqM3NXT0J6Y2JjWTJBNkpaT1NKcThlUHRMbUFFeTZlRTJkYm5x?=
 =?utf-8?B?ZGJXcisycVVzTFBFKzVDZGFDbU1MbWFYR3p1OE1NNzA4M0JsUnU4ckplNmxt?=
 =?utf-8?B?YW5RRlNuTzJUdXRCc0dBditjMS92aHVLb1pydXMyTUlTTUFtVkFMcjBGQy9H?=
 =?utf-8?B?UUlBMXVlTXR0Umh1RTdhZ3VmOE9CM1pYQm96bS9ZRDlYZnV3dmxsZkNHdUVE?=
 =?utf-8?B?cnM0MzhtZjlvRDRPaURzaXFmaTdSNDZFS3dwSWYyczBOZVMxVmZEYmJXNVV2?=
 =?utf-8?B?UFpIbUlIVTBQTUc0MDdLQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDlyZGxEWUl4bDRNbWMyNzd1REE5V3pxZGsxRFkzdEVBRkFUbHd2S1RiQWJw?=
 =?utf-8?B?Uml6ams4anVkNS85RThSN3hzdDk1dVF2RzVjM3AwWlRFbTZMUnBGYmppMXYw?=
 =?utf-8?B?K01KbHYrV2dieVNLNXYzcGUyd3JiTGlRejJ4QmtTaVB5aGxCbko4aHJOYzVX?=
 =?utf-8?B?b3FqbnN0SWlET04yekhuSzllcG0va1lHS1Y5NEhJZjN2ODhGaGs0RmE0U3lZ?=
 =?utf-8?B?clNKa0ZnTnN2RFNFcWp3aVB5dE1UV3VrMnVhODArSTZpcHJNZzdmYzAydXZn?=
 =?utf-8?B?amRBZHY2UlR6QitnK292NUlxUFkyWE5QT1ZBSzZpRGdnaERielFiYjRvMFhO?=
 =?utf-8?B?aDdDcEZnM3Vzc2E1Zi9acEQvUUJha1hqQm8rUGwxVHdNcCtyT1orM09iSms0?=
 =?utf-8?B?VDUxSE9iQVIxTVFuWnFYZDREMUc3a1ViVlNJS2V4ZVluaTlHRTJ0MXJNMWth?=
 =?utf-8?B?djRBZGN5ZnBWK3cwTnVGeGRMQkp4WCtkVHRieWJxdXdrMk8zZ2FTQmZ0Wmhh?=
 =?utf-8?B?U0VsczdrVDdVTmdJZVp5UElMMlhXeGxzRGU4N01QK1BoSm9FT3FseDBzWE0w?=
 =?utf-8?B?Y2dqSExqTUlZckxYekFPeGFoY2hJTmFVTlUxMXJ0VzE1alZndTBlVE1Md3NO?=
 =?utf-8?B?WUdpbDZMNEV4cTB4ajgza1VlbEhjb0ZoRzNldXJHZ2FzWTQxUHN0Zks3SU9p?=
 =?utf-8?B?MTNjMFZZRGlZeHR3NzJIUnd5YS94YnFTZjVpQWF5cWU3NlVjNnVyMjVsY0tJ?=
 =?utf-8?B?UnNNU0NhMDJZUU9MelRmbDJOT010OVVXdzBpaHJzaGpZcTVwUnhKSEwxZXJZ?=
 =?utf-8?B?cWxFbjZEVEJTSFVvUUpFR2hnR2ZFc0ZVeFNNWk1OYlFaMUhNeit0RVd4b0pW?=
 =?utf-8?B?ZFc5QzU2ZDgyeEkyaWJ5Y3lmSXA1OWM0eEErRXNjQm9nc0h0SmlqNlpjS3U3?=
 =?utf-8?B?SkhGRG5FZGtBYUVTclMzU05mUEt2SXNhb0krNm9qQ1RzWUJkZEJoZ3ZMSHoz?=
 =?utf-8?B?TVlobE5DVHRoS2s2QTVVdGR2ckVLdTBSd1p6NElmaTZKMlp5WWRCeTNSdzRj?=
 =?utf-8?B?c1JsUlhVYXhsaXdvWWE2ZHVQSUNJRThqdm1sZTRObVFXczAwQ3BnSXM5djkv?=
 =?utf-8?B?dXdRZk9OY2R6TVFqOHRjc2kzRUxpeENKNmUzYlZhblVPN1pPR2l1YkJRQjQy?=
 =?utf-8?B?d1BhWFNodEo2SjZ2WWhEUHZQM0ZCSzZVWlFYbEo3ZXBSWDJmaGN2czVMWEcr?=
 =?utf-8?B?S29DK1VyRzFXRk9ZQzM2d0tsMmpCZ2pVeXY1eXJhaFk0SUZ6UW9yME5HUkdO?=
 =?utf-8?B?VnRFaWtxMjd2SUNpUzc5cjVUOEVHUTNVUTdXR0VhaGVscG8xcEUwbHhEMkg1?=
 =?utf-8?B?bDBKeWdwTytWWmZsam9Td1FBWU9STytMMzVObmZKUnRWQWI4cWw5QitqclM0?=
 =?utf-8?B?ajJTVWpBL1RsTUZSQ1BySTkzSHQyM2hrQWVFRXFrT1Q4cWMwQmhKQjY2Sng5?=
 =?utf-8?B?Sk5kbC9iNks0aDRrbTk1MzZDVEhuWVlZbTNVMUJXWi9lRnhxVFREUEVBWDY3?=
 =?utf-8?B?UTM4cjZEbEpqMjFMekNqVTVFWmJna1lPczZxMFNES3M1YjJhenRscEJQQjli?=
 =?utf-8?B?dDNjY1dXVUY3dXB4TlgyMS9FKzhlcHJIQTdCNk0ranJHMldEZDR2d1hQcThz?=
 =?utf-8?B?dC9nN2FTT2l1WUdUcUpwMkpxR3ZieTQzODgxY3FibUx4dUUxTDQ0QXo3VVdj?=
 =?utf-8?B?WWM2MVJrb1RvSkEyTUlNVVZrWk1PSFVmWWJvNXVqZngwUmdGVHhtY3BFOEhJ?=
 =?utf-8?B?Nk13QTVBSzF6ekNQWDJvZ1pSbUVXall4S09XUksreThBZExpdzMrcEhHVmFM?=
 =?utf-8?B?TEliekxMQ2dQbEY0SUJEMVJMQ3c1UVpoNVdkTlV1NXdHd1YrczVuVkg2ZlRk?=
 =?utf-8?B?cXNXNjhQMCtsRG5qWVRzcjNYaUNvK25KRzJmWU9kS0F0dTcxbEdrd0ljZWsr?=
 =?utf-8?B?YTY0M0JYRmJJTVB3Q3Iwa1d1Z2JPMFhYcnloZHlNYlo3M0NlMmc3bDVWVHBu?=
 =?utf-8?B?Njlzb3g2UFVTU1NuWEtLZHBSR3JaT2FGZXQ2VDFSdk5YS0RMWUNybzAxNUFS?=
 =?utf-8?Q?Oyis=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a85a658f-9190-4497-26f2-08dce2329c78
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 16:03:38.1955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnFTKzf3mbf1lZxP7j+2oI02d76aevZxFDCZknsr+2NCOV5aFAdjIUf76k7zk84j7ntdFY2G8JyY7b1XlTZAJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7879

This patches is splited from
https://lore.kernel.org/linux-i3c/ZvrAuOBLgi+HtrPD@lizhi-Precision-Tower-5810/T/#t

It needs more discussion about dt assign address issue about i3c framework.

This series is svc driver improvement and bug fixes for hotjoin. It fixes
all kinds hotjoin problem when 2 devices random hotjoin and A normal data
transfer is on going.

This patch version start from v5, which exact the same as old series's v4.

See each patches for detail issue.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (6):
      i3c: master: svc: use repeat start when IBI WIN happens
      i3c: master: svc: manually emit NACK/ACK for hotjoin
      i3c: master: svc: need check IBIWON for dynamtica address assign
      i3c: master: svc: use spin_lock_irqsave at svc_i3c_master_ibi_work()
      i3c: master: svc: wait for Manual ACK/NACK Done before next step
      i3c: master: svc: fix possible assignment of the same address to two devices

 drivers/i3c/master/svc-i3c-master.c | 122 +++++++++++++++++++++++++++---------
 1 file changed, 93 insertions(+), 29 deletions(-)
---
base-commit: 77df9e4bb2224d8ffbddec04c333a9d7965dad6c
change-id: 20241001-svc-i3c-hj-bbaba68cf1ea

Best regards,
---
Frank Li <Frank.Li@nxp.com>


