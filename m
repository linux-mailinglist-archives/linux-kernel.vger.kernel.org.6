Return-Path: <linux-kernel+bounces-240334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE34926C4E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D5CDB20E8B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6D9194A61;
	Wed,  3 Jul 2024 23:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cij+S9sq"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB58A194C90;
	Wed,  3 Jul 2024 23:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720048041; cv=fail; b=CtcabuHEw8/4OUgGMKoY8q3pZCGinolhcf9ujplkpEGyt82wD8CHna3QgRttOfINeUS7nPSpA/Sm49chEFeCU6moaqR7DJqhxTxqHANv4sY1O4M8bVlkILxZqUtDdZjTBsv8Yr98SU1mNuqqLLRhtdtXyaQANQbVkr8G50TO7Os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720048041; c=relaxed/simple;
	bh=OZhH5vHJIz49Z5w7shnQv9wME/LUgQEwzh9BwGAMQns=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=L33ZWM2sohu8/yY1iWq4AhOVRocO/NXpEn0hgId1LaZjN6mXr0Ey+QKHAkJbMAbs6n9o3fowd605mtvUZMnJOkPbaMYLxy+M1PznbE1+qYXMzBIfq6+wJJLgciyaGEhqK4SNGZNY+k8t12RFbu5jmFq2w/BzIzoI6vzZkMkkZX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cij+S9sq; arc=fail smtp.client-ip=40.107.22.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbjO2Fv+cyoYnvGfFmKSrz5l/cwQhDOroqBhRAkKY909EL8QAieIiEUtrtJ8X01bpeaQ0lskx+WBUsKdNO5yG+ThanM93rKoszoj6r9W759ZktdbLe2Ms278D2e3uMpOIlzE+V/GR7nbHWfltB3kNIzWSZBI04dFh+BL+ZNsyesSWXNwMTP9+9d//ayN9Il4rRTI+cf8ak2vtD/iytaRkOCSNNEDaeg+3DXO+/uP3C5cDnhWecJ7Cx1qYN+bH2qP6AMXaVb8hpJqDAqRuVlnMC1FAaC7v68GeWi5aWzIccytdMlJQvT20yYAGxUfE4ISrpATduuGVvZj80WsiRIZ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/VekO1EEL3W9tfsm6MZEvDygKk+VT7CpmUCoBkZ1fI=;
 b=J3Xq8Ryq74Rl6Jl309LtbtqQbOsrisuVzUseVqCh8+5cgbcCvGfKV9V1RK0k7VA4tI7c/DRrpZYVcFrsKqbNzn5u5pqEOgwM9NH0R0svsVGcE8kxP1DPYaeuh4JjzQe2EFK4lAK7ohmuYAuB7XziOefB0/SBCgLyLwNAbuTOgQDwfn8QeMum1jAbUQ0g0iJhGypN/ayRLyoyWZQ0bYc0Br5/DtfCt3xiKQHflaWDTMNMDRS3S5NQtCBWqUSLSeC/7w8CXzx4sN5Q7BC5jjj0sdRAWF1gMObgoevnId6wJq2oz+55XA/xTF9k2yrUDnt9D1sA5TdG/Hr8m73Z4aRfuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/VekO1EEL3W9tfsm6MZEvDygKk+VT7CpmUCoBkZ1fI=;
 b=cij+S9sqI8yaHUiXEgHNn45TmqTFngjhLiWl4UyxR0ox+cAWdIOCWsf4R+dkr3sjyQ8tSWpd5KbRpiaYSGbNPApLVWD8t4xarXXVrG+Z2LT/iY8+4iWjttARh6QF5hnXSah5m61dgjE5KGCAZFS9kIAQFlXHXMysYedZ65nSbU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7242.eurprd04.prod.outlook.com (2603:10a6:102:91::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Wed, 3 Jul
 2024 23:07:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 23:07:16 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 03 Jul 2024 19:06:55 -0400
Subject: [PATCH 2/2] usb: dwc3: Set cache type to 'snoop' for freescale
 layerscape chip
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-dwc-v1-2-9cbc93d49180@nxp.com>
References: <20240703-dwc-v1-0-9cbc93d49180@nxp.com>
In-Reply-To: <20240703-dwc-v1-0-9cbc93d49180@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Ran Wang <ran.wang_1@nxp.com>, 
 Jun Li <jun.li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720048027; l=3085;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Gipda9mkYcJ/iFuJC+SVswlU2hwFtDUoHjvW/BiuvmM=;
 b=JNo0CAT5OZoPJ9r9Da6LTltChMsb+W7nbiHC8HjxAejl2Qiqf89VAZ5cEC4QMdx8RIopRMFUh
 djpfzkxgtpLDC0d/UVkhDIJEqgpRu5GAtgPNqIJmT66VSwfdwpDxBrm
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:a03:331::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a18687-3887-42e8-f2f1-08dc9bb4e20e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmpLaVh2ODVsajBOVkVpV0RzRkR6OERkS0lJUks2NGU0Y2U0a0o0MWxHMnkr?=
 =?utf-8?B?eFhBMVhVN3MvNG8vZ2lIaFJkOUxBYkdyQ2JZTHJlNHF1ZUZVeGpSaGJrNVlT?=
 =?utf-8?B?WWFhU0cwYTZTemJEbGpic2owMjgzZ2NIdXdiQk1PUUNkTUhPcjhteXBKZmZq?=
 =?utf-8?B?V3BvZnhOYXBzVngvVGROMUJNak1zdWc5ZWJPcUhwMWg1eUtZTnp3WmRzcy9X?=
 =?utf-8?B?R2lUK0NMdHZEWmdnZDZvZ0dxdUQzMW9zdzg0ZHRKNHV5alpGRjR5ZnYyTUtX?=
 =?utf-8?B?a0ticG9hTDl5WnVHUHFXTW43M0Nad00yT2pUTjMwU0xXTXpZdktZVUVleEhG?=
 =?utf-8?B?WmVHV1lqUzdOK214SkZ0cGs5elczc0FZZkhTSFZEWG5QcUJES3hXYmcxb3I1?=
 =?utf-8?B?QnR6Wm9zVGhLeUdTbE1KRThVTlJEc3BjM3B1aVFYTytkZ3Qvcy96U2daYnRB?=
 =?utf-8?B?R2RMTmpHaUNKSzdnbnR5RUJ3WGxhUmhEc2QxUkhlWHZLQ1ZUalZ5TEtvMW9D?=
 =?utf-8?B?QThGTS9ERU9vVEtmOEo3YU9NNUx2TzR0ak9LQ3NFd0dIeVB1OEtRMHZFMU9Z?=
 =?utf-8?B?RDJSTkE3dCtSenZOaWtyS0FPV1NvZjJ2UE40YzBaWGNITkxOdEk5ZWdlWGpH?=
 =?utf-8?B?RzdoRDFhZXpZNEZYQVJFM2xUNHZPU2ErVmE4Vk5GVE5JZ3BuYW5zRFZteTB0?=
 =?utf-8?B?MzlXS1JDU05NZlJVcHFHOHdyQTFJWjhKbFY5clk0ZmxCaDFZRUg1akpFbURl?=
 =?utf-8?B?U0F6STNJNU83WjF6czdxZThMT0N5bVFMMkMvcms1Y25MOXYvQ2R0RnhKaFZO?=
 =?utf-8?B?MFlvNFA5WFdCMWVrY2pVVUhBOFQvOFVwQXNkWkJwTHgzd2pxNk9TTVhEMVUx?=
 =?utf-8?B?RDJUeGVBdm1FUDZxS2RxLy9QbXVLNUJNelVNSVRYRlJQNURpcWtCcVJCTmVw?=
 =?utf-8?B?bkpKUWdqRHdHTWlVWnFweGxDSHd5N2wyOGcwTG1vSkFmc1RUZHllN2hJMW1z?=
 =?utf-8?B?ZjlBL0JwQUp5RGNvNjcyaS9MUElhbDZ4YVZ2cEpKNWdYaWlWczUzYzV1ZEdH?=
 =?utf-8?B?bmx5UnpiZ3ZHL2t0Rnk2cFUzYkRVMnNtdzdUYXJsVDIvL1ZCRjh5VkRpaGVZ?=
 =?utf-8?B?dVdVVFNQNXpEbksrQ2h3ZkRZOEk0UEpHa3k3Vlp4NklxUlVFdEt0NTF4MGha?=
 =?utf-8?B?MnUyc1FzMElhdEMrNS9BYUx1blg1OWl4YlR3allnRVR5a1ZRTDRLaDUySGJr?=
 =?utf-8?B?QVJmOVMxQS9TTEFsUzRsd2RlYWtnenFXVlIxeGJDenQ0M3o2S3Bzelk5MS9T?=
 =?utf-8?B?cGMwN3JyelVWSkJQQ09KQ0x1ZE9yeUlTbUw5S2d3M0dwOFpoL1pRYWtkNEMw?=
 =?utf-8?B?UTBnRUFGTEFjL2l3V3JKS2p1bTF3bUk1Sm44dVpiY0N5ekxRS1BzK3NCWWgz?=
 =?utf-8?B?YVVTb21oTTZmd0U4dURxSjYzVHo4NUowMUNZN0syd0xIUG44YU5sSjVIcWFD?=
 =?utf-8?B?UU1hcm5MK3RoSkxTMUpwaHcvRFNDcmNxSmM3bGNrUGlGdTc4cFVVNEp6SHZD?=
 =?utf-8?B?S3pvVDhUdjBnTW5TL2dFQitPbERtRTFhMmp2aFVvRzZuOXJKb1lFdGhheEUx?=
 =?utf-8?B?QWNHTEgrY09GRlVvM0N0UWoyelRuaWFqUG9CdGw0MEhLekhrSml4Qzl5Um9v?=
 =?utf-8?B?a2x5OE90aDZlalNuV0VpMkFSR3BseWNKSnhHVzJtNG1PRDZVWmVBOE1GR1JN?=
 =?utf-8?B?enFhMXVKNGhWejZSQ1FmQUdhNURQcE10c0k3UCtZTDZGMGxwQTdhWjlrN050?=
 =?utf-8?B?U3pZb200ZnlmcENuOG1xQkc0ZTJTM0VIVlBYQlhUTUxQNTM1dmhzL1JZa0dz?=
 =?utf-8?B?WmpkQnF1UVU2S0c0YnRFRzRvV2NUcWx4MVZ0U1VhL2s2RHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2R0RU9Lc1JuWS9ybXpDSWF5T0FyNXRObVFuT1ZoU09HK1B0K0NMTmorcmNC?=
 =?utf-8?B?d0daRnpOVGR2NTl4UWNNZktIZEh0eGZQV0F1MDljZ3VxMlM1T0V5Zjg4WGlw?=
 =?utf-8?B?eDZ3Mk5lRGV1d2pyWnMzSm9HK29ZME9STTBsNUJqWnJCVS9Fc203RytVeFBT?=
 =?utf-8?B?eGIrWEZYREFkaGRnTEVLaW1DdHlFTjh3MFFWTGVqTW1vQXI4U3JiZ3oxVXgz?=
 =?utf-8?B?QTdwUCs5V21rRDliMDgwQzdrSUZqVUt4R3kyS2R1cFpPTHpmQVVkSHhWa3hG?=
 =?utf-8?B?ZjFTb0Z2dXRrYk9qLzNzeFhhaStTb1BYRlhuZXAzYk1MWTFHSU9BbCtBYzAy?=
 =?utf-8?B?UDkzdTgxWUFUTVpSbkRIWXNmYWdjV3dGSDBjcGIyNUVwakFkZE5aNVRQL2ty?=
 =?utf-8?B?TjI2OW1iK21GL1Uzd2kzMCt5MG9WR0EvSHUzdWN5aThtQU9qMVhjNUtZUjRr?=
 =?utf-8?B?OXMwQW5nS3B5WGtnSnJ2eVNJbUVWNFhqNUtHZEFtL0lEblVrdkgrWjZLQVNo?=
 =?utf-8?B?biszY3JrMndCK3JjNmdXREwycWZLa0QyMFAySkJCQnIvWDF6a2RjQThRUjE5?=
 =?utf-8?B?b1BiRjNUZkZMR3NaTUNVQUk0WTRSdzJkMEI3S0I1emZhNVUvaVlVNWZleDYz?=
 =?utf-8?B?bGd1YmVUNGRzRXdGZ1FmZjd4b2pnUTBCb0gvemlNdDNZbW9tZnBIR2phUXdC?=
 =?utf-8?B?eVp2cGVsU0diZjRwMy93SzRpNzlDZCtIYS9wVTErY05pK0VYTmhzS2JyNjFG?=
 =?utf-8?B?TGVUSE1wYmt0VGxYeDU2bnlvUC9rQnY3VytLWVQvTzFzRWdBKzNoT2c3V0N1?=
 =?utf-8?B?MndZblFEYjBWRUt6TGdvY2ZtTDNFd2w3MHhkTUF5S0UrbHJlc2pZQkVlZEVR?=
 =?utf-8?B?UE1aM2FtQmJIcFNBZHRPakg3TU1KSGNiaGtSNXRUTG5xcUkrQWM3WDI0R0or?=
 =?utf-8?B?eCt0S0hKNHgxQXZZeTl5U3ZYVXJkaEJmNXdsbGsvNCt5WlAzYWE4d25mV3p5?=
 =?utf-8?B?SGZ5ZHdxWThQV2h1QVVTaUI5U2ZxYVJ3ZlpDZkJqUlVadm5PNVBtaWNGR3RX?=
 =?utf-8?B?Vm9mM0NHc1RWdVErTjBmZWFpN2o4bXpra3FrTkdkeXNhT0NvbHh5S2xUOXU0?=
 =?utf-8?B?ZXhjUVdJTktmeVBlRlVqeVpwejBpd281RHhNUlB6UVRYQlZzeWlxRzZ6dDNM?=
 =?utf-8?B?M0VNU2t6V2pqempEcDY3S285VTVaa2tmQnd2RVRycFdWTE90aldVQ0dYZ3RR?=
 =?utf-8?B?YUR3OXN6cE8rcXI5dGliZWFsWEcwcDVBc0tLNTRudEVMMzdiY1psQkIrTnNU?=
 =?utf-8?B?VnV0bmdOU3dnYnVjRzFhb05zYkdVWXZHcnl2YmJEdC9iY0lqYmQ4S29OQ3Ux?=
 =?utf-8?B?cEtOaXIyTEdDalROWUU5OXlIWnRldUFIb2czemFLNUUwejdRc0U0bzJNU2pH?=
 =?utf-8?B?ejV6ckNyblJZKzJUbHZMb1dhLzFNWlBjYjNCaE5SY1JoQTk1aWNMcUlsNzZv?=
 =?utf-8?B?V0pPY3RGU25CT1dGeWRKdmNkb2hLT0pXUnQvSlFCMzBrQUJVMlBoOE5kN3Vm?=
 =?utf-8?B?a3NsbHc2ZjdxTS9ZS2RGc2xZT0R1d3hLdjkwNURnRDFzSnh5TkxMMHA1SEo4?=
 =?utf-8?B?YWtscFc5ZGVGZThtcUt1b2ZLV0FwVjRHeWhpM012bGljUVZHOXg3c21PK2VG?=
 =?utf-8?B?VzJ1RjdhNEVEeVRRYkJJYVk0N1QzUlZ5QVBXR09GN0k1SXM1Um1wM3pyenZi?=
 =?utf-8?B?QVllT2FaK1Z1aGpqeVE0WlJzSmRKUldNdmgwU0xDZkpRcGl3MHB2WGNyY3Z2?=
 =?utf-8?B?aWVXY0ZmTEdodkVVdkZwSnhtUXNIZlRNT1pObGVtVVUxWlM4cGJpQzBmdHg3?=
 =?utf-8?B?ZXJ5YzBvZVN0WTJDakk5T3A0MWxnN04vU3BySnNZUWZCQTI3R3p0QjVnL0Jp?=
 =?utf-8?B?eHFhWDJJWTdHU2R5YmlyakpjRkRGdFFjTEhPc3lraWNISU9QaVFBK2tRTlBr?=
 =?utf-8?B?ZVU1RHNTOVVSeEZTNXVOYzltZVVUR0ZiM21kT29WMlpxc21pQnRWOFpYb3lo?=
 =?utf-8?B?cWRqMEUxK08vVzZSeStSaWpoTlByTnJjRklRViswVkl3c3hMaU1FbXdnc1Vj?=
 =?utf-8?Q?W+ISenVPtGlID3d0dtPpyPIFm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a18687-3887-42e8-f2f1-08dc9bb4e20e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 23:07:16.9628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1+P/XKlmcG+89s0sOwEAFhiK+FXKu7McHzwb7X95qbAsTh/4yBmKybm9ogzm2fZFYB4UUtM48oQXFP8qXA+nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7242

From: Ran Wang <ran.wang_1@nxp.com>

dwc3 have 4 different transfer types: Data Read, Desc Read, Data Write and
Desc write. For each transfer type, controller has a 4-bit register field
to enable different cache type.

Quoted from DWC3 data book Table 6-5 Cache Type Bit Assignments:
----------------------------------------------------------------
MBUS_TYPE| bit[3]       |bit[2]       |bit[1]     |bit[0]
----------------------------------------------------------------
AHB      |Cacheable     |Bufferable   |Privilegge |Data
AXI3     |Write Allocate|Read Allocate|Cacheable  |Bufferable
AXI4     |Allocate Other|Allocate     |Modifiable |Bufferable
AXI4     |Other Allocate|Allocate     |Modifiable |Bufferable
Native   |Same as AXI   |Same as AXI  |Same as AXI|Same as AXI
----------------------------------------------------------------
Note: The AHB, AXI3, AXI4, and PCIe busses use different names for certain
signals, which have the same meaning:
  Bufferable = Posted
  Cacheable = Modifiable = Snoop (negation of No Snoop)

In most cases, driver work well with default value. But USB device detect
failure sometime on Layerscape platforms if bit[1] not set and enable
dma-coherent.

Set bit[1] "Snoop" for Data Read, Desc Read, Data Write and Desc write if
compatible string contain fsl,ls-dwc3.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/dwc3/core.c | 12 ++++++++++++
 drivers/usb/dwc3/core.h |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index cb82557678ddd..2b474de83b783 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1061,6 +1061,18 @@ static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
 
 	cfg = dwc3_readl(dwc->regs, DWC3_GSBUSCFG0);
 
+	if (of_device_is_compatible(dev->of_node, "fsl,ls-dwc3")) {
+
+		cfg &= ~(DWC3_GSBUSCFG0_DATARD | DWC3_GSBUSCFG0_DESCRD |
+			 DWC3_GSBUSCFG0_DATAWR | DWC3_GSBUSCFG0_DESCWR);
+		cfg |= FIELD_PREP(DWC3_GSBUSCFG0_DATARD, 2) |
+		       FIELD_PREP(DWC3_GSBUSCFG0_DESCRD, 2) |
+		       FIELD_PREP(DWC3_GSBUSCFG0_DATAWR, 2) |
+		       FIELD_PREP(DWC3_GSBUSCFG0_DESCWR, 2);
+
+		dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, cfg);
+	}
+
 	/*
 	 * Handle property "snps,incr-burst-type-adjustment".
 	 * Get the number of value from this property:
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 3781c736c1a17..99edfabd89673 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -184,6 +184,10 @@
 /* Bit fields */
 
 /* Global SoC Bus Configuration INCRx Register 0 */
+#define DWC3_GSBUSCFG0_DATARD		GENMASK(31, 28)
+#define DWC3_GSBUSCFG0_DESCRD		GENMASK(27, 24)
+#define DWC3_GSBUSCFG0_DATAWR		GENMASK(23, 20)
+#define DWC3_GSBUSCFG0_DESCWR		GENMASK(19, 16)
 #define DWC3_GSBUSCFG0_INCR256BRSTENA	(1 << 7) /* INCR256 burst */
 #define DWC3_GSBUSCFG0_INCR128BRSTENA	(1 << 6) /* INCR128 burst */
 #define DWC3_GSBUSCFG0_INCR64BRSTENA	(1 << 5) /* INCR64 burst */

-- 
2.34.1


