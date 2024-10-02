Return-Path: <linux-kernel+bounces-347744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2A698DE16
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44E37B27B98
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429651D1F6E;
	Wed,  2 Oct 2024 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L0G+Cpc5"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473DF63CB
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880675; cv=fail; b=VnRFfMEvoMQ/KD9VqK74AKN+9kfDS4djlQvHD5rugnIsTiC6Uk9imxrLFx6rVjYdbfd6a1fZJ1VU37kT7inyJlolIg0PrKSWEuETINV8W1eX3YY4Gzcs1NyRqDj9Xsm8RAJyJcZKeOvLWdmF7pp3+4HB5rqGILw7eOeDKGIzrpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880675; c=relaxed/simple;
	bh=mTP2BQfrL2ajg1eLnU3vD3yNZnTqEe/2FbB25MGO4Kg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EGfAjx7NJMoy8+0luKGJiQdXzVKpeVtSgagHgMEjY7mKHWZGMAtPzijpLKqIXUVGCIWyMpAOYcImWGeCnKd2a4d0jIC+itDgJVs7yg7W62OgXyd7re+lNfPeuKg91Gl1lxxZfgQPx1ar6ex6h69r90/lTpbAntv7JIR1CF+cECA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L0G+Cpc5; arc=fail smtp.client-ip=40.107.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDpFlRKOfqscIwMUlv7EmR0JPzXfERhf5kzhGgvzgfuglacLItBOphybdR2wGm9qnLTqQBF+WaWDEN76TAUhVmpKyWj7KRRnwWGtFUZ/ZsQLaD4FF2i2/REGYQVziBEb5VSAavARVHM96xq4E7Zb6KoEPugMYQsNVMjYNiFjFUOUHeBLurd+A6Jr+LdpYYffnMaQDO33Kmnc8K8L0VSNMyE6gDvVDQTAo0iK8HAsitvwFqt4EtlkQxWX5Cm37+hJeS346FTXlbejNeSeRPs0BeJQOONJvZ8QfXIB4dBiQfzNasknDfLGGrfhhopALeKtmwAZadeNtUH/cZri1x/Evw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pG/i8HsPY7XlHxdpjxt1xiQs79KpN78+7TFWBBmUyn4=;
 b=jxEEVW8MphB3BXTuBR8FpkTTR+mWupxlrp3fQri/sBjRbd1Ks/IWJay7FkFRKf/dN/++Rtnoxf3usMfkGKhFbhFN0GgcBtrpQAmJuJMTk4+RoH/Y+QeLNzI1A9DybRwgDbfIwV67ccA3tNbPf0OUdDhuNiWjhtTjrLygrbXcGdr9znxYlEhLlrD1T0VavfUR7b70A5c5B8V4pP9qv/je2zi4AUVOPw1mGVp3FN8528Oi/96roDzmO4TyHjhJ/1+7gjE0Tkx5UeLfGxGH9jfmb3AanHoMYYPvzc+HgiPI+hJhJYwKsKsUuHvvisqFew7v16VmMaKOgzECH7zmCUpo5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pG/i8HsPY7XlHxdpjxt1xiQs79KpN78+7TFWBBmUyn4=;
 b=L0G+Cpc5QKvJ7BH2Kn8+2DTYUrWO731v3SHmSCgxqZw9gliH8iSJhwJNad0x208PGFvIOWJvH8rMLEPuwZWdm40/0aqIK6+UgAle03nAx+BTN/GM0abssWPlHvcqvEqmW6Xw8hkQeiY/T+VvLEvZ5Xu712au3YIclXRgtxEKObLUDd6OOx+60PNgjZpttXlT3C0eS8H4m+Y8+mrPB0OzL4GhSQMhVqXWhBIy76te5XmvOC/o+04Cx9h9/2FV7M6wh2nn/bA4JH5twsFAFvehVsHzItIlsj0GNIwNGEjAXpagvdXhaf1a7w22+sy6yxLyVJrcJhMtoddS6ZAuMT2jkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9699.eurprd04.prod.outlook.com (2603:10a6:20b:482::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Wed, 2 Oct
 2024 14:51:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Wed, 2 Oct 2024
 14:51:06 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 02 Oct 2024 10:50:38 -0400
Subject: [PATCH v6 6/6] i3c: master: svc: fix possible assignment of the
 same address to two devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-svc-i3c-hj-v6-6-7e6e1d3569ae@nxp.com>
References: <20241002-svc-i3c-hj-v6-0-7e6e1d3569ae@nxp.com>
In-Reply-To: <20241002-svc-i3c-hj-v6-0-7e6e1d3569ae@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, stable@kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727880649; l=3214;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=mTP2BQfrL2ajg1eLnU3vD3yNZnTqEe/2FbB25MGO4Kg=;
 b=/j4Z1kpOPNXOtRhpr8OSpnJ12IrkyS73HdhZikRFyEIZYibXeJA60RWSmusqukin5vvXGJLfy
 O4s91/3DMDaDl4843Cf4eMchhEJFNT4Zbg9ubDnITeTjYzQ9qwBkgQC
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0177.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9699:EE_
X-MS-Office365-Filtering-Correlation-Id: 4417582f-8a88-49e5-3935-08dce2f1a4a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rmp1YkdVR2kzdUpPZXBXVDNyQzQ2UEhVbUlDSXFNU0pRNS9rYVF0SnBGUmpS?=
 =?utf-8?B?SjM2eHZDYnhLTU1FK2g0VHVqRThaWlU2bjAramJYaVM3UmpQNkM5Y3Q3enRE?=
 =?utf-8?B?b1NONTZKU1YwRWZ0ZnpsNjVmNStUZnRkN2VWUCtobm45RmN1THl5SUpwcEV1?=
 =?utf-8?B?WmtTRmlhU2lFQ1NxQWxnOW5oNDNQVjh0Q2tRMmZxT2sxN1BMNHdJd0RWMHAy?=
 =?utf-8?B?R2VuOGNJRjBNYnhVa2JIUDBPVzA2Y2cxV2JPSUpqaU1GR3dUR0NwVmM1MEMy?=
 =?utf-8?B?c2tTa0V2V0xlRFU3S2hlR0JxSXF6OG4xd0Z4RlFFOW0yZWpTMDBMMVg0RStL?=
 =?utf-8?B?VG9aRHZUbmpSK0xPT2NLZVl0SURzUDUzaUo4TDl3RGRSdS9NV1JRb0xYMEF2?=
 =?utf-8?B?emEzbms2QXpkUE93KzlmRFJuQ0RFOHJrME1OblVoRmdaNzFadXNKSzYzY01E?=
 =?utf-8?B?SjdBcWY1cUVBckJlUEhIczRHNkNqVEE3MmtZTWFzdS9lQWlYUVVONnB3ajl6?=
 =?utf-8?B?UGNGck1FSEVHY1M4Vll0M2tzVmdvZS9lajRHS0dZd3R0RUUvK3dvUWxwUUhj?=
 =?utf-8?B?cFJDUHhjT1JVK0JxaU5CZFdacURGSjEwYmN3TDRkR3N6cFVWKy9WT1N5SzhC?=
 =?utf-8?B?anMwcDdvZnVlUFUvTXFZTVRFRkNzajJ4SzhsOGMydkJNSGN6d3FNUE5UZStt?=
 =?utf-8?B?VzVsUkZkT2xBOXRXV3UxeTlHTThSZXdOdWJ6ZEpSbHZjMmMzVEs2ZTNYeXM3?=
 =?utf-8?B?akJRRW9MclRiV0hkaThHakdyUFlkaHJ1cFFwWUV6T3ljYVJZWFVnKzF3aUZj?=
 =?utf-8?B?bFcrRUZ6Nis4cFBobE9SeStzelk0MW9Ub2FyNU0xNWtmWldMSnBjVFBMa3VR?=
 =?utf-8?B?NE1ManpQOGZKcDZVQzh2Sm1IeHppbGhVdm5tM0tDUTV6cDNwWitEaElDeDJN?=
 =?utf-8?B?STdJTlErREtTaGZvS3Y1N29vUVEzSnFXNFBHSHVkSW1nRnp2cHlGd2R6TVZS?=
 =?utf-8?B?NG9aWDNDa1d5M1BpclhwUFFSMEtpWG9BNWVXNHM4TjI3MlhVS1VqcnB1QmhU?=
 =?utf-8?B?UEJKb1g4bGFkb2tYeXp3dldXZkFzbFM1OFg3cnlSUUtHNVJRKzVmL1lacXAz?=
 =?utf-8?B?WVNsNm5nMVhoRmtXckM2RnRhQTlsTm9DYlhQZ1kvRlFUTVJ0RXJZZVBaSUJZ?=
 =?utf-8?B?VEhFaHErS2pKTlFxaUM5S0xZK1ZmWWNjMHJtQnBQMlhCd3NQUG8rejFzWFpW?=
 =?utf-8?B?WmRFckhiUzEwOVVnWS9yYmxxQTEvUm1kQkM3a09iZ0MxaXpacDFQbTJ3Qnd4?=
 =?utf-8?B?RktTMW9qZHNzc1ZOMEFPQ1lTelFCS1RMSCtsN3hIQnhWKzAzTTcxcUhMU3JB?=
 =?utf-8?B?SE5oL3ZMNHc3cW0wUWllTUozTU5ZR2ZKM2JFcGx0dm1pUHFTeFBXeWtIU3pE?=
 =?utf-8?B?bU83NUZpSjdCV255ZFEyYS9MSExmZENKNUtlcGxKZ1RMVFdqMlBlTTRXRXA4?=
 =?utf-8?B?dFRENTRpMUEvZWFIRTVXQkNPUlpweGQ5Y3BVNTEzWnJhQWdJTnhRQkVKVUlx?=
 =?utf-8?B?aGhrQ1E1VFBTQVdlOEM2eVhZMnhyYWdBRFYyeDFlcGlCYXVVaGx3bG02THgx?=
 =?utf-8?B?RDJlU3hXVE5NNEdVYi9Ycmp6UlJQS3JWd0V1Y0RTNkNBWmdXeHM1bHVDUWJQ?=
 =?utf-8?B?NXA2NnhKdUZ1cHdyMnd6VWYwSUdKMFJ0Y2s0dW5VcWZHVURVL05PcjFxdTBz?=
 =?utf-8?B?aDhYWHRKZTFmRjkvNTA4N2tiYTdiNjVkRUZIQ2R1M1cvZVRpVWc0cEM4eDRm?=
 =?utf-8?B?bWh6SkFrVmdLYjVYVnFadz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVpRVTZjUDI0Q1VWVUJoZ2lkTDFQdzBhQTBqOWdDZTlFMDArZVJNMjkxZDBv?=
 =?utf-8?B?SFhZcG8vaDl0NmFkTVMzRFpESTQwa21sbWNScU9nWjh5TktXdlh1a1YvdkFY?=
 =?utf-8?B?NXBOK2lSTVNXTmZEUUNnamxzdjBZOS9aL2gwZFpPb2huSlVXNm4yT0NTdE4z?=
 =?utf-8?B?VmxiNWVqeHV5b2o5Z3lkK0JQSTJYN1dRR2tVQng3WnJoMFR2MFdOMFJxTEVa?=
 =?utf-8?B?aXZqUkd4VUkzd29teU4zNkhzUkNkcWp4OW1hbG9SaUVCVUY3TlZlM3Q1b1c1?=
 =?utf-8?B?bWk5cnZwWURnTm5LOEVaM1cwRUFibE9DYnZ3bkdRZ29xUmtWMWVQNzZwTFdN?=
 =?utf-8?B?TXNLYWFncERQYTFtZnpJZUFETHlzbitiWUszWW1EYjhvN24zWm9uZ3E1TUxl?=
 =?utf-8?B?ZGIwV0FQeUptRmZTa0lIaklHSGFRekJYZ3VNTWxaUm5GbDhwSmg0YWJKdVRo?=
 =?utf-8?B?K1ZjQ3dEUDk5YjA5N1pQSGxubGVGMmxSVFVsZ1RnRkYwRUlUczdka3IrSzVT?=
 =?utf-8?B?RCtuZzFjTW5NcldZbXQ2cHRVVHVDVmVSN3V1VnlObmwxQVJwdXA4Q21rK0J6?=
 =?utf-8?B?RzNYcW5SdnlaeVoxQ3RvU2pEL0ZBTUQwVlBDYWZsTHA5VWFkRk5mNUZZeFVL?=
 =?utf-8?B?RXNjb1NRck5xcnl3WEhyZUYyUEcyZ2pVK3JONDdYTGR2MktoUnZKVXFiZVFZ?=
 =?utf-8?B?SkprSzA4WGlFVTFhWHEzQlcreW1jR1o3empVTW5rOHBNWVR6djUxRnZrZ3RR?=
 =?utf-8?B?L09kcnJxTEVMUmxXZzhwcGdRVkVrajlmS01lTVZNdWtuWGFISU5SVkwrcnly?=
 =?utf-8?B?Rkd5V1ROaWR5YjNmQ2E4TWhjaXdxVlp5SEt4Y3BFSmpYRUhObzRaZS9MK2tZ?=
 =?utf-8?B?RUpGcVYvK21aSTFZMW5BdnlnNmErL0RwV2NyQW4rS0Q5V2dXMTZxWGhWaXpl?=
 =?utf-8?B?cS9sUHo5a2ErVFdXVkFNVXJGVFI3djNVMkU5eXdTMjc4dlFmR2hObzN3L2Yx?=
 =?utf-8?B?YzRoQ1FDQXZKVXh5MExlRHE5ZVlrYkZ1VFgzd0tQQ2Y3L1RRUCsvdkEyTEtl?=
 =?utf-8?B?bXJaY2NFUlluS0FwWnFUa0phcUs3cS9yWU03ZnlReWtVdnppaWUrNkZjZ25n?=
 =?utf-8?B?aDk0QlFNTG9NWVNkUEhwQmRlZlM0VHg2ZjNpdkJNcmRvMXhaU3RJNTdjTU5X?=
 =?utf-8?B?T2FySXRoVS9ic1ROMXErMkxja082RHVGSkFCWWQvWnc5MGxlOGwyYTYvVjRN?=
 =?utf-8?B?bUdHMGRKbzUvbW0wZ2o2NzI0MjF1S0Mwa1UxMGhhZmxtNWZvOUtXbWpORHQz?=
 =?utf-8?B?MkRidnRKTzZHMVhEbFFLMnlNcUcrWm1QNmtMK01QdEV4SWFxVUN0bldHcHlL?=
 =?utf-8?B?S2wzVkQwc1hja3lST09iRkdldkgvakN5VXE1KzJla1NXTGsyeGZoTHpEMEVj?=
 =?utf-8?B?SDFrWU05eHhKclBtcDM5aUV0Y1VyeXJScjI3dEZzbXlsWUFsYlZjNHdac3Ry?=
 =?utf-8?B?cmJ0U1lMbjVOOVBtSlVrRi9jU3RFa3pwN1crUmNTa0RVY1c3QzZDLzlOSzhx?=
 =?utf-8?B?VTVldU5HT1d1MXNSSEFjTm44R3dXTUZRSzQ1c3lhMkhVWm03UmFaMkExcC9u?=
 =?utf-8?B?OGlYV0ZNME9LdmEreXJEbWhuOEcxZTIvVGF6TmVnYzhRdGNZdkl2UFViMk5I?=
 =?utf-8?B?T0EyODV3bTJSTWFvQ2o2VXk2MHJoTUkyelpqUDdpMG50eVRHN25SNmNkdDcw?=
 =?utf-8?B?YWFSMjVQbk1RcTE4dHNIKzlob1lUOVk3T1VQdklBY3ptTzdHd3p5dHhMZENN?=
 =?utf-8?B?dXV1d0IrS2phT1JCYmltb3pSUlM5dVJLK2d0TWxCUytsMUlqSFJvYVp2OFdl?=
 =?utf-8?B?RlEwS0EyR2dvOWRadEhjV204S0IzVHpKbFVSbzE3dXpMVTFmang4U2dYZWhU?=
 =?utf-8?B?SGRMZityRTh2b2hueE1jNm9hRGtQdy9QdEcwdlRwOUZjTFpKR25CV0oyRFkv?=
 =?utf-8?B?SWpmWGVsTHo4dlVMOXJOOUFtcUI5TDYvclJLbTIxQXNTV2pZVEo2amR4MHdM?=
 =?utf-8?B?YWdUY1dXVTVleGNXZUFOTXMyZ1RsQWJmVjNMaHJ5VWpmUDl3SlVDa1g3Z3VS?=
 =?utf-8?Q?5jmbObwqv9MWjy52iTudqCP9n?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4417582f-8a88-49e5-3935-08dce2f1a4a1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 14:51:05.7505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUUt7pytChGHV8EOUenVS2yxr5bhQsjm5AXpNcVWdH0WiuzfH80YMGHg4NyqFa7R4lqd9wJPSD/XjOytB84qgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9699

svc_i3c_master_do_daa() {
    ...
    for (i = 0; i < dev_nb; i++) {
        ret = i3c_master_add_i3c_dev_locked(m, addrs[i]);
        if (ret)
            goto rpm_out;
    }
}

If two devices (A and B) are detected in DAA and address 0xa is assigned to
device A and 0xb to device B, a failure in i3c_master_add_i3c_dev_locked()
for device A (addr: 0xa) could prevent device B (addr: 0xb) from being
registered on the bus. The I3C stack might still consider 0xb a free
address. If a subsequent Hotjoin occurs, 0xb might be assigned to Device A,
causing both devices A and B to use the same address 0xb, violating the I3C
specification.

The return value for i3c_master_add_i3c_dev_locked() should not be checked
because subsequent steps will scan the entire I3C bus, independent of
whether i3c_master_add_i3c_dev_locked() returns success.

If device A registration fails, there is still a chance to register device
B. i3c_master_add_i3c_dev_locked() can reset DAA if a failure occurs while
retrieving device information.

Cc: stable@kernel.org
Fixes: 317bacf960a4 ("i3c: master: add enable(disable) hot join in sys entry")
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v4 to v6
- none
change from v3 to v4
- add comments about not check return value
- add miquel's review tag
---
 drivers/i3c/master/svc-i3c-master.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 7ef7e50b4b916..e9c8e340d861b 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1103,12 +1103,27 @@ static int svc_i3c_master_do_daa(struct i3c_master_controller *m)
 	if (ret)
 		goto rpm_out;
 
-	/* Register all devices who participated to the core */
-	for (i = 0; i < dev_nb; i++) {
-		ret = i3c_master_add_i3c_dev_locked(m, addrs[i]);
-		if (ret)
-			goto rpm_out;
-	}
+	/*
+	 * Register all devices who participated to the core
+	 *
+	 * If two devices (A and B) are detected in DAA and address 0xa is assigned to
+	 * device A and 0xb to device B, a failure in i3c_master_add_i3c_dev_locked()
+	 * for device A (addr: 0xa) could prevent device B (addr: 0xb) from being
+	 * registered on the bus. The I3C stack might still consider 0xb a free
+	 * address. If a subsequent Hotjoin occurs, 0xb might be assigned to Device A,
+	 * causing both devices A and B to use the same address 0xb, violating the I3C
+	 * specification.
+	 *
+	 * The return value for i3c_master_add_i3c_dev_locked() should not be checked
+	 * because subsequent steps will scan the entire I3C bus, independent of
+	 * whether i3c_master_add_i3c_dev_locked() returns success.
+	 *
+	 * If device A registration fails, there is still a chance to register device
+	 * B. i3c_master_add_i3c_dev_locked() can reset DAA if a failure occurs while
+	 * retrieving device information.
+	 */
+	for (i = 0; i < dev_nb; i++)
+		i3c_master_add_i3c_dev_locked(m, addrs[i]);
 
 	/* Configure IBI auto-rules */
 	ret = svc_i3c_update_ibirules(master);

-- 
2.34.1


