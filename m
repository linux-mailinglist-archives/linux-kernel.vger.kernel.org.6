Return-Path: <linux-kernel+bounces-368418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 848729A0F95
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7C781C22A2F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BBF16BE39;
	Wed, 16 Oct 2024 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O2OWtURB"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2076.outbound.protection.outlook.com [40.107.104.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65852212F10;
	Wed, 16 Oct 2024 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729095821; cv=fail; b=bLmt3gy220GE4eR/LD3Jz/8K2UaUqYE+/25Xer4icnwtJb0NoSL8S/SNvkhx7QDT0cR8SWcFch0uyPvhKx4CR6i8+spYtTb9J1c9DxklBJg4FJ6uKbBzhmcMoJVsgGL6GVtunvn5l93y2M4eTrZoMc6XELntniQ5Bz4xObsBkv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729095821; c=relaxed/simple;
	bh=mAzNbzRWOh6wFu0SMI2UVtcJ4QuBAqfaQJrwAklpA20=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VJc7q+qeW2vO+23H82IJWk6HPt4dZkXu8LCpe5Cj+vW/INLKTX8OBtZoSzmo6kP9ZXzBYLG3w3WIHNljcOCKcaSGMTQviEPGQGF0Grz1jOOnu2tuXnSsbZi0rTv9bDCG9CiuUmYZ+G3Us7SupBCcPEuM4kE+LBZEcon6dyPfNfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O2OWtURB; arc=fail smtp.client-ip=40.107.104.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XI7BUKbmcKjDU3XQo5CfNAY4vODpey+khXOF9rzQDT5XaqfQwCptRcRRjDJouOiEDDOHYPyo0gRcb4kDnDsL/98cLFN1frCRbwZeAyhCXE47L3TVolKeqk3goQ7RRyo0IBaTAZTp3eubC3qfNvYcIuT/ygx19UJ+wNlzxnflwZEkBvTTTt9OB3h+4eZX24SW5S4y47mytrw9NPyb+dfPMElpiZdF9K9uiUTCykTmZxmM5PKrcrq8+rFqUZbwhaUfYj0MKo5K7bszIdRYzafvqTByhxITQSWQq2WXEawqwTN3h9QEo71nfyUzyST44VIhcmJwXIyPyZ/oxV9+9RkqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wK/QCHsvwxI5jajMDK5bmLW2wqApLKVfmMXXvNmjNTE=;
 b=k74SUytHIWZrvJlTxJC6B+uY+6B0DwR22wwBo1x2sNGV1Lt5MJog8OFhjLncwnOMoYM0lbdF7P93ugPS+a9Y8jRkjI719QFWKZXWZbkrucjg2gnakvV9sxthFxCL6cKsdO0dmwAe4BoZPDHKt5JBBXM5oqXOMPCbrDgcSpyV8mjfC9tEMLwhZphV897a66n8UCGXHOMISzxpRBLREdG3Zvco0eSD8lf5jX/ObeBxKHFTK6evXPQfn8HkbdXlnxYUTErvVdI6aMo6BtfHg0Aw372NGSUsBke7vLNogb2s5wKdbVPe0cMleQHc7sTSbhWeqDbDdYwKECGo6QQDZjQGuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wK/QCHsvwxI5jajMDK5bmLW2wqApLKVfmMXXvNmjNTE=;
 b=O2OWtURB3AMFQBNkBGr8QVXjzLsMEJIKKwkEfZ7tXSqHjaxCQhB8jvouQvdKIFLU+5DWxyqKXYmn2IW1d7E3T1gbom5NqBvF7OzHns6plAxHId33SJ200ij+Zor83jPcIgx6C9rQdqwNeT52Fk5Od/1duLLd50sT1TJhcTBusvqBKhR5T615hXmox3ez+MqAPbmRF1Vk+mWw6e88htfo9OiD3PSTkm8NwZqGooJMqMk1GiVF4uhDuOpr2xzKQ9ouUJhFQZ0aRjhqSkDp+PYE/enCFlavZienhMkOyujlx+p8ORH25IX5oKHLV5GxjFE7vjPrlRpTq8HfJYzcNOJkZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8599.eurprd04.prod.outlook.com (2603:10a6:10:2da::7)
 by AM0PR04MB6884.eurprd04.prod.outlook.com (2603:10a6:208:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 16:23:36 +0000
Received: from DU2PR04MB8599.eurprd04.prod.outlook.com
 ([fe80::763:eb3b:6607:1e72]) by DU2PR04MB8599.eurprd04.prod.outlook.com
 ([fe80::763:eb3b:6607:1e72%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 16:23:36 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Wed, 16 Oct 2024 21:49:00 +0530
Subject: [PATCH v9 3/5] arm64: dts: imx8ulp-evk: add nxp secure enclave
 firmware
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-imx-se-if-v9-3-fd8fa0c04eab@nxp.com>
References: <20241016-imx-se-if-v9-0-fd8fa0c04eab@nxp.com>
In-Reply-To: <20241016-imx-se-if-v9-0-fd8fa0c04eab@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729095547; l=2640;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=mAzNbzRWOh6wFu0SMI2UVtcJ4QuBAqfaQJrwAklpA20=;
 b=XikNrMjx4ba9m2jWXnH7XQggr85by1m8IpTAqNEHBkPeXvLvIJJjUIylRPKyTTRfdOvpB7xpj
 a4GpNKjoTpmA5cmfMFh05L/5BCewZI6iabxXbSZ6N8UPGllezrdkVGl
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:3:18::25) To DU2PR04MB8599.eurprd04.prod.outlook.com
 (2603:10a6:10:2da::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8599:EE_|AM0PR04MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: f04b428f-e1c5-4431-3618-08dcedfee2fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkdBdGVHdkNLb1R5NDduKzBPUWJ6VG1ZMzAvZ3lkM051ajMvVW03dzBwWWhX?=
 =?utf-8?B?UTFQR0lOSmp0M1FqaG02RThjWHFaQ0FMWkdyb2RDc2dqNnpaK0FzLzlXWThr?=
 =?utf-8?B?SU1wRFRnd3BvcGpVaWF4dXpUay91dlBFTDB5WjZvWW9WU0FrTDFuYUtwbjVq?=
 =?utf-8?B?VmRUODNha0dxRVh4c0Y5RHVMaUVQLzg3aGJmUm92NU8vUnhjbjNZbGt5eFI3?=
 =?utf-8?B?RUg0MTBXMEVlRi96alcwMEtMSHVYOVpybkNwV0NMUTNjVTVTcmZOS0djT2Vh?=
 =?utf-8?B?Syt3VE1MQjRSNmpoNWQvdUJwVTF4ajJZZHB3bkZ2aE9BTWJpeTBEcjc1QTNO?=
 =?utf-8?B?U1hzRlJtYVg3b1J2WVpEY09IYzlrNTFKS29pczIwUk9jNGRNNlE2eHMvUklk?=
 =?utf-8?B?aDRlRlRwTnY4SkpNbGhKZ1BBMC9nN1pGNmYzNkZvT0dHejNjRW5yM0JjVnd5?=
 =?utf-8?B?Yy9sM2tGMUVuQjE4NEdNVHREVVROWktGcmhMc1ZkQWwvTk1VZ0o1cXpHWG5E?=
 =?utf-8?B?VWgwSFExNGRvbk94R1BwYnBCVmtmOHVTd3JBRmtJUTZFZ1VuZWF1RDFwSTNL?=
 =?utf-8?B?KytraHNPUi81MTk3YmV2d09YU2lMaHZ6SmdvOG05VFRyYkpMK25QbnZlNER3?=
 =?utf-8?B?eGNRaUNZdW5GYi9sVVNFTFVsa3R6UzlLZWc5TkNWSXQyZ2lEZHN5a1pOMExY?=
 =?utf-8?B?V2UwbnE1dWRBSS83c0J6eGhXSUtvYXgzR2ZDTVN0cGJNNHVZL1pHMnZiVHdi?=
 =?utf-8?B?MXZ3cUcwWGtSUXNqbVZOWEI2a2w0UWlZNkhFamFoS3FYb2Fib0NrS1kxU1Fj?=
 =?utf-8?B?TEQ2N3VnL0dUYnRGUGl5MWFneE1kTzgxU2ZNQi9aSXhIRXdtby9PR0pWUmdU?=
 =?utf-8?B?ZUk4UnNqSlJKWHFRb3V6WVF0SWVRVy9uM25FaWhyVS9zais1WWZvUFJIVk9R?=
 =?utf-8?B?R2RSUXhWREgxZk1YTjg3VzhFdHVSeDBDbmc0dGlLWWNWNG1kNW84VlV2ODBr?=
 =?utf-8?B?MnBzeVNqUEhxNkxjT2xDNGFWK3dOOE16MURwTlNjSzdZL0U5cndXSXFwMFN3?=
 =?utf-8?B?a3JFL2NBL0JlRXU3YnNvZFBtT0NaTjlxdHZFSzhUbVIwZHBkZ0U0eXNUSDls?=
 =?utf-8?B?SHB0N3dKWkg4aTdjajdIOWlMZWZ6V0x4SHU0dlV5cGFUdXVOcjArdFlBTEhj?=
 =?utf-8?B?UFBSY3R3TzdNLzhGTUp5QTFSR0p4WEY0Q0FwTUxHaWt4ZXdDWmJwQnpqMGxh?=
 =?utf-8?B?eTFwenpkTEoyY0VxYkZJdUJPUVN1UTVObElGbzVtSU1oanMrSlVBWTc2K2tn?=
 =?utf-8?B?Zzc0UlRyV2hlckk5S3czRFN3M0lXemlLcyt5b2hKWElUU3lxTnVkMWVIdEJQ?=
 =?utf-8?B?blh1MXpFbEk5ZzRZRXZiYm1PRFdrTjB5QnRZOFJ6bHlkcFNKK3F5Wlpwektm?=
 =?utf-8?B?QlFXZ3BFY2xZRDhrMk5VaURiUkUzVmdzMU9NZUJvVWpPR2NFRXBBZGpxbUIx?=
 =?utf-8?B?Ri8vbjJGMXdFMzFMeHZCbFBBbVhmS0hvWjNYQ2JmYUZSTkZJVFVyNFZmSmVu?=
 =?utf-8?B?UzR3TDVOS1pXa2JhSklOSG5nc2NxZTVJRkpLS1BFRVUzVEREY1pPM3RrMDVD?=
 =?utf-8?B?QXdDTjVua1gyOEl0VUhvSlpVR0dHMTdnUHdlM3d3V2tNSnZkQThBOURJUGZQ?=
 =?utf-8?B?ZnBKVlBGOXNzRVlEVDMxcU80VXpHdUpleWYxQkVMenZEUXd1ZVVITktoelFR?=
 =?utf-8?B?ZU4zWmdEVHNJYlVrZmRiRVZmWXBhc0dXUWxXSmg5Rmo5QWhZbkJpTERuNkFW?=
 =?utf-8?B?dXY0bWF4RFArdnBveVJMdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8599.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1Y2M2djc1ZlRFVtK0x6RnIzRmIxSjZWbWhDc2NVek92djZXYXpYVjBzUjRS?=
 =?utf-8?B?a093M1crU2UxMWJMYkc0SzJRWHMvUm8zNXozaGJpRFlQbW14VTNzeCtYNVZN?=
 =?utf-8?B?NUxyWkNSVG8zWHErQWxHQjhkVUhRdHd1SHNHcmpVZnpjUmJFay9uRnJJUUhj?=
 =?utf-8?B?RWtrSExUVVFkUlE3ZHgrdkplbUlTOGNhMDVNVnV2RUh4MEhsVWxSSVRiVjdz?=
 =?utf-8?B?YnREZkVWSmtqS0w3N21oUURsb0hXWFRrTWRnMHdEalVndUhOSjFjeTY0dENM?=
 =?utf-8?B?cTZjUWJwRU9iVFUvT3lFN3hhaDgzc1o4T3pVWnNvZDdwYXJVK3NPSmFpcDBh?=
 =?utf-8?B?SnloL2lBMFAzQktMYkxSemwyMnozS2dYK2wzOE1xNDYyenpiY09BNkxNTVVi?=
 =?utf-8?B?RUpkaHkzeHU0UmpnbTRGWHlFRmxsUCttUm95ZmU5Qi9KNlk5RG05bUJsdUM4?=
 =?utf-8?B?dmoyaUdsNWIxc3F3Z09lVzFyK201NjlON01DM1JtVExRSVY3VmN5TXZNM0Ur?=
 =?utf-8?B?VWZXdGNSL3JtNGRrRHV2NW1yUWp2QVJVaVg2T0E2RVRVMmc2ajA1L3BDNWdr?=
 =?utf-8?B?eXlBczlFZmhKMzRYa0RwdEdpWHhybWVqalRmWDJMRXR2bWx2emhQS2tpdi96?=
 =?utf-8?B?UWVkeWlmbmRxNkdMK2FVYnFNa0o0ZWRTeWtFc0htTzliL0tmSmJ5WW5XZlJW?=
 =?utf-8?B?R3dXSFcyRUgrRGpZTTBsS2pJUjM0bjRqK0xhTUlERDBvNlQzSjMvSmpMSHd0?=
 =?utf-8?B?SXdaSmJ5UjdHUjBzS2NNY3J3V3dTYTZGSHltOFR1Y0ZmWFRpc2N1VjVTQjN2?=
 =?utf-8?B?VHhpdWZ2TitHbnRydjBpMjNWenEyV1YxczJrSENTaE51NmR1ZVFiTW1ZTktJ?=
 =?utf-8?B?SnBlc0RGM1BPby8rdFBFOTdVRkFoTUxWRFBBem9UWXJOVFhwWFRsczhCa3kx?=
 =?utf-8?B?aXY1cTlsNS84TU9MQXhMbmdGODllSTdrSWRpM2dabnZSQWs1R05Gb1FRK05R?=
 =?utf-8?B?YVRTREppMEptNXZZM0daZUJ2S3lKbGxHTE5uMy8xaFJ6UEwvOHlGRUVMNGY1?=
 =?utf-8?B?YlkvWG5NZ3ZaMi9PeS9FKzlZV21OalhGSzhnbzdYbExpN3gyN3hkRTVHdTln?=
 =?utf-8?B?RUhPTmVqb054em5lQ203azM1RG5aUXpha3JtejRlNDlHVzZCWGxYUzlVVjR4?=
 =?utf-8?B?K0hyaXNIWUNMRmtVTElJR0d6UUVoQ2ZiMG55em1LVEpnKzBuQXEzc0greWJC?=
 =?utf-8?B?K1kxVlhldTNuTTgwRmFBRFptSE90cGgrWVl0QlErb1FqWnBOMTZmTm5jTTVl?=
 =?utf-8?B?OXdRY3IrUWE4NHk4dkZQTXQ3cDhVVFRxaFoxQlllSWp6WHZ6OWNYUTNyRHpY?=
 =?utf-8?B?RCtzTXR2R3ZVNDBLMEtIMGF3V1V5S0FKc3JpTnJGdWxoYWpzZWo3MnVFcjVy?=
 =?utf-8?B?UVBpU0xxb01jMGExdS9JbzNRTHlCTTVzemU1d3JFT3JoWEhZMm1PbFlMR0JN?=
 =?utf-8?B?UUpIa0pCVm5ab0J4c0wrYkxoR25KZ0xpOEp4cWlaL0NCU1puSGY0NS9mbzJs?=
 =?utf-8?B?Rmp6ejBDNVliYWpicDlFVU1OanlWNDZiTFdlOE82U1Y0ZzM2OVlLMGMxdU9F?=
 =?utf-8?B?bU5PTGVwbkRJUUE0R2VSSUpEellHTW14b3NzaUYwTzJ2WHlwTEhVYVNCdzky?=
 =?utf-8?B?WHM2WFpIZFc0YmhIRyszZENsaG1TaVdXaTNqb0RNZWtZaCtzdjVucGFqTlFH?=
 =?utf-8?B?L0NQeUxldGtEU2ZuRWRSSUk0dDhhalk0QW9vQi9jNkI1SkNLQk5PWndXUE1M?=
 =?utf-8?B?TTk3aExISnJFQWFCQy9xc0dqT0FlNjdIdGtVQ3AwQXVvYU1ZY1NzcXBkbkxp?=
 =?utf-8?B?K1NmWTU3ekp4UTR0dUlGVEd5cG43MDJpUFlKM3B4SGlBWFYyRkxPYkFjZkZ5?=
 =?utf-8?B?WWcraFhpU01tRlAyU0l0ZXNRem9Yc3FWUCtYMUc1b1dCQXhLeEZzVkZFNUcv?=
 =?utf-8?B?ZHZuYmgrSGNaWVJJeWMxaGpqMU5Xd2tmcXIvZHAxMVREa0liSmpucFVDQ1Jr?=
 =?utf-8?B?VkVNdXNuMllzQUFocEJaUFQvcGdwaFl3YnAvWXFWMkhaLzYxSzV2T3ZERC96?=
 =?utf-8?Q?XnqSCWjK+kpsOjqHFlfzIBBxZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f04b428f-e1c5-4431-3618-08dcedfee2fb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8599.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 16:23:36.6488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6AH+CQnqBYKvyk9u2b6FBb+InMbU/uiVSVe8opbmffUANrLZzKC1jdgc/pSJsNh1MIzvmw40UsjayieSh1YSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6884

Add support for NXP secure enclave called EdgeLock Enclave
firmware (se-fw) for imx8ulp-evk.

EdgeLock Enclave has a hardware limitation of restricted access to DDR
address: 0x80000000 to 0xAFFFFFFF, so reserve 1MB of DDR memory region
from 0x80000000.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 17 ++++++++++++++++-
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    | 13 +++++++++++--
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index e937e5f8fa8b..f5963f4043c4 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2021 NXP
+ * Copyright 2021, 2024 NXP
  */
 
 /dts-v1/;
@@ -19,6 +19,17 @@ memory@80000000 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0 0x80000000>;
 	};
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ele_reserved: ele-reserved@90000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x90000000 0 0x100000>;
+			no-map;
+		};
+	};
 
 	reserved-memory {
 		#address-cells = <2>;
@@ -204,6 +215,10 @@ &usdhc0 {
 	status = "okay";
 };
 
+&ele_if0 {
+	memory-region = <&ele_reserved>;
+};
+
 &fec {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&pinctrl_enet>;
diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index e32d5afcf4a9..f98629b7f4cc 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2021 NXP
+ * Copyright 2021, 2024 NXP
  */
 
 #include <dt-bindings/clock/imx8ulp-clock.h>
@@ -152,7 +152,7 @@ sosc: clock-sosc {
 		#clock-cells = <0>;
 	};
 
-	sram@2201f000 {
+	sram0: sram@2201f000 {
 		compatible = "mmio-sram";
 		reg = <0x0 0x2201f000 0x0 0x1000>;
 
@@ -167,6 +167,8 @@ scmi_buf: scmi-sram-section@0 {
 	};
 
 	firmware {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		scmi {
 			compatible = "arm,scmi-smc";
 			arm,smc-id = <0xc20000fe>;
@@ -184,6 +186,13 @@ scmi_sensor: protocol@15 {
 				#thermal-sensor-cells = <1>;
 			};
 		};
+
+		ele_if0: secure-enclave {
+			 compatible = "fsl,imx8ulp-se";
+			 mbox-names = "tx", "rx";
+			 mboxes = <&s4muap 0 0>, <&s4muap 1 0>;
+			 sram = <&sram0>;
+		 };
 	};
 
 	cm33: remoteproc-cm33 {

-- 
2.34.1


