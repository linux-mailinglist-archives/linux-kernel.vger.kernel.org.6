Return-Path: <linux-kernel+bounces-385711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A24B69B3ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62BA128252C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAE81DFE02;
	Mon, 28 Oct 2024 19:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KgsnzDNP"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BF61DE2AF;
	Mon, 28 Oct 2024 19:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730144994; cv=fail; b=QLB2zEHEj5Bp9zpBsWgPGiayeHevDjdCxa77t3pKplawR1rsQ6UViUgOHL57xDwy/asscmUoTjWsIG1BvFCT83AGGKN3oHxS46jS2qBwIDqucI+adgqad0GrthxvJvd/XemYPjUpXRABO4fURYqxMcMxmncKb34bW0tqCCJX2kY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730144994; c=relaxed/simple;
	bh=yCgUpcTptYn8/I02IUW2ejSVGGyjK8Eyb8I0szewqD0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pJdI3g3hoxBpKkj6vfNrUgdZO7b4wpBM+4o8CYJRBEEf2+f8RUTUuphsRUk9vUyvrAy5BYhanoFkIZ0g13PGthIFgS59+l1mZazyW2kLUgpHs5MCR6XqdfxewiTBirrrjq/h3HYBzVFDZQGHLmOs1Zg6iSFEXkcwmPYGd4rzwG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KgsnzDNP; arc=fail smtp.client-ip=40.107.22.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9ibd0fW4yk67chCpGpF9PTXiZUjLJ3S4qso/ln/YuOToRys4Ssg2MWdBhP9YdugWDVigM02wzgnfsOcKCRyAmkRdCiBCeZ6DqQvv7L99V/5k3/JPN8sfu1V/08QxFhXWREiv2SgD7yTtIDau3vYdrHbne5HRrO8NVaQdvZ5auG0HO88JpvagVMATOg+28s1gLWmXjK9LTTvGgrlQtlkjAuNhU7alfhLVpp/hRsJI1NtdlXYHQDIiDSVVIX7jQdLXfGqPS5kDQ2ZdVRB0dItybm+yYAKM7M4LhTzUehOq48WxLzVzQ3oErO02r12QhSfwYEOgoFeWbr1lYn1WqOhYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdSs/+Vm66np0apb3QUbCBf05LztHsVmYan4CPF6ZEY=;
 b=XxIykLpUZ7I/wwCYizW8S+w2BAYyk7/g/LfdOvvbZtZeAhGggyn5ygpQqKNF5jZNmGlz4KG5sdx5mm2nOuYfwgYrnxM+Br9K6pnrsPJUmA7RLH7D1zVHCAn8UjIYV2z6cMHgYMKB+LHXTJd17I5oWWpOaKy3D2kte0CALVUC28yr4oAZ6C6zWdqGG3UkX8ozXJGklE3bq+UcjtwY8LkofUjfQ53U+SQsVA3bn8jKV1ifyhjPoNGZUavzD9Eeou7QqXIs8bT7opxJjm/1y9TGwxgxkEw5EAQRyeSIAgfnAv5eNDMOFQBUwSd8S9kus5alSkTYUMCAiwSk/Ge/wgP+Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdSs/+Vm66np0apb3QUbCBf05LztHsVmYan4CPF6ZEY=;
 b=KgsnzDNPCoM5EVGKzW0PGN0A3zjl0x8+TaJqt53mslIo15gcgCjKwBTHmaQ+apAFxvG7nONVtFCLEXsJOX0sc24p0/SPui9ySYUTzooMALkZLcQfGAyPIbvFP076M4k0Ttyj748lBRtFj7lCuI5hyWMt8rK8u/wt+JfuYJlNXQjWxTYsLP4bHIj5vVHoCWf13C6+7dBJaj+64ouR7bOECsuOW23UFTWWNWQsjXV5WRt6fine/7BajyHVtMD+P3o+xi2JjopuwIc4xkLlJE8qNjOx8LCiDlEkbU8iy0CTo0XH0lUfsEMud2amOU+nNPrKtDYKOFjQQ5jF5FbpWVb0lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9332.eurprd04.prod.outlook.com (2603:10a6:10:36c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Mon, 28 Oct
 2024 19:49:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 19:49:50 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 28 Oct 2024 15:49:31 -0400
Subject: [PATCH 1/2] ASoC: dt-bindings: fsl-esai: allow fsl,imx8qm-esai
 fallback to fsl,imx6ull-esai
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-esai_fix-v1-1-3c1432a5613c@nxp.com>
References: <20241028-esai_fix-v1-0-3c1432a5613c@nxp.com>
In-Reply-To: <20241028-esai_fix-v1-0-3c1432a5613c@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730144982; l=1024;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=yCgUpcTptYn8/I02IUW2ejSVGGyjK8Eyb8I0szewqD0=;
 b=YEPWe6tWpAM3gVKU+EYcg9PsVIgM13/GwsuUzuPHUHp5UC/Z4FBSQeBkWhIe4S4ZdAUV/sepU
 HdMGDJlUgqgCDZ+RKBa3Fahul0RnDgBpiuyOlB8p4uaSsimynCBahfM
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0043.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c37081-bae7-4aca-03c5-08dcf789af43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2dwV0pzcHpRcFp4VmRlOXJibHRoQWE1Um9sM0JOZVFvMWhqc3lyNXBkdWh4?=
 =?utf-8?B?WUdJTmh5TFlMZ2tqVTdWWVdUZ1ZkSlpVZGFvQVFUMk40cnN6b0hCbFVmOUVN?=
 =?utf-8?B?Z0YyQ054bThMVlFmS2RLeTkvLzQ5bFB3M2JxSDBkZ0FiUmZHYkZ1dXk1cXpM?=
 =?utf-8?B?UFdpNTlzSDJFRUJ5S2NKR3puL2xJeVJwbG44TUJUY1RTdlp0c2s0TG9Xa3Ns?=
 =?utf-8?B?VDJVejkvVHdCTDVtelZqVUh1SDBzNHNDQk1xbFEvMXdSSTIrM04vZVhJMThE?=
 =?utf-8?B?MHZNQVBHK3hZbUpySnBTZHpZSjlHTUxad292VU5nRnJVUFFSNG8xM0tiY0NM?=
 =?utf-8?B?SnhrZ3VOQUs1QTlDMmM2YnVMUTBFd1JRZTgxS2NGbHhaWVIxZjloOFVrTEZq?=
 =?utf-8?B?SklMUElFR0xUT3lkaTBNZmlodGZ4TCtWWjNEZWUraUsvRVdyOHRrM1BCWHdn?=
 =?utf-8?B?RmNDT1pzVHBpTmdBZnlwcTQyL0I4QjRISkFrek9HY3Vsa1Bna0FTRm9ybWJa?=
 =?utf-8?B?T1NTS2Z4TWZoZ1FyMW96bWZOalJLRXJJQk5kYWgxWXYrc3FaUUd2OXl1T1cv?=
 =?utf-8?B?V2JmK3lET0w5R2ZwQ2h6WXBlajhUcUFwNVlWR05Gc3J6ZEZndVVsbTQvYVV4?=
 =?utf-8?B?eElaRVdnRExLSkJSdi9saXFKa1ljckxyTmNIeUFDOFYxOUw1ZmxHSWw0NGpV?=
 =?utf-8?B?YXR3azF6amdOWFBjVmx5b2ZjVlplMjVkand6VUh5MEtacnlTK0NjUG9aS1lF?=
 =?utf-8?B?WWp1SGVvWUlFUVhZZk1rZHBzMWZTZ3VLcE1PQmRXc2FDeTF3bFRIcENXMVBM?=
 =?utf-8?B?UXpzZWZ0QVFJWnVJRlU0ZjFtKzVzWk02dVAxN2JYQlprbUdhNExPeEsvWDU4?=
 =?utf-8?B?TFdrNDlOSDVKWjdUZnZYSmFJWDFRMmZaTG0xUDRaVEJnSVhqSm9CaE5CaWd1?=
 =?utf-8?B?NXRhNndpRGxOajVvcDBmUXZLUGwyYy9IUkVCMkoxKzNKemdHT2NIdEsxN2Fy?=
 =?utf-8?B?UWJHcDNGMFE4bXI2MCtzT1Ryc251RUM0TXJhODBUSU9PZlAwUFltTVhncUpL?=
 =?utf-8?B?YnpwL3A1Q1gvOG56eEkrbHBrVkJjU0JCQXBBc2V6M3FRWEpxQmFvTld2dVVy?=
 =?utf-8?B?cnNqZTJ0S09Da2VCOFFwSXNTL0VZYlhGUTAwcHZDZ1UrcDUwdjVEaVV0cVBm?=
 =?utf-8?B?TFAzVzRxNjYxckMwUkJLdnlLMVcyV1NydmFFajdQcWNXc2pJaEt3NHE3QmMy?=
 =?utf-8?B?NzRrTTBxSFdhbzRBblZnZlhESDAyS2pJZStLMk9tOGZKV1N6WG96MjZTZjhW?=
 =?utf-8?B?OW9oR2JUT3EzbjVQTk1UT1U5Y3piOEdncUZEZ2xDSEszeDBSR0FaWlhpRDFl?=
 =?utf-8?B?ZEg4WUtoRFg3UU1DVVQ1d1FtMy9ISFRuNXBnQ1lKQVN0Y0tCS0lEYVlSUjFS?=
 =?utf-8?B?QUJnR3ZzTDRFNWdqTWpHcWFaWkRja3A4elZPWTkwQ2llUEZjSG95WVVlZGdI?=
 =?utf-8?B?RXlHUXBDU05FUDhDT2ZJVXhRUno1T3ljZlppUERsanl5eDQrbDFxd2VCYXdP?=
 =?utf-8?B?QmN0SWk0cTNtaitvd0kwY05NRHUwSUg1Rld2UVgxRjlTK3VVMHFCMUcyU1NZ?=
 =?utf-8?B?bTJ6dGp4UWUvK044d2RIVmNWZkwwVC8rNnRnOHhtanpyck5JcjFIQUo3U3pK?=
 =?utf-8?B?UEwycHI0WTIrNlBVbTZHWmdDaVR0QUU5dEMzN0hKajBVTWhXR3lvV2prekll?=
 =?utf-8?B?T1FyU1UrcnQ4K1ZTOTd3MFJ6RnFYWGpqUjRmMmlGYjluQ2FyRGI1OUsyeHJv?=
 =?utf-8?B?RGJyWEpRQVRVditrSWlyQjIxRlYyRDdUZFRSZGR5MmpkMGlFaU4vRWJ2a3Rm?=
 =?utf-8?Q?ez7Hh6TkkEpU9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emN0Tk5RTGNLdDczdDVKNnQyZXd0K2FoYzZCUUs2QlMxcTJaRlB6azhIS092?=
 =?utf-8?B?L1hBQmRMR0NxUU1Hd1BQQUFhcGRCUEpxWFlvVEVLNnFQR3l5YlVBaGdXaGRM?=
 =?utf-8?B?T0VDTHA2dTlZb0N3bGxtWkZ2Mm94bU5KSDdCeVdGNXdDOGFsL21IWWN0UzFi?=
 =?utf-8?B?cGRmeXZjcnBwZVhyemJzT2VtVjNRWGpjQnVZcHR2ZE5LWjVMZS9qb004c2JH?=
 =?utf-8?B?Z3lLZ3ZGNlBHMmlUNG5qYlgrOEVwSzB1cG9HN2JzS0lWTFRIc1pCUW5HQldB?=
 =?utf-8?B?bzliUmRERTJFdEZ0UmhiM3FJSFNmUXI4OG1tQW1sQmNjdkNyWHhWR2NKSWNj?=
 =?utf-8?B?QWZUR01jQkpROGl2WkM4c2xaL3dFTm15NG41Mld4UEFJaGE0WFdXT0RCUUN3?=
 =?utf-8?B?RHZoZXZaV3dDOTMvS2gvdWt1K0lKWmo1SldXTTNCR0tCQ2QzTXMyZjVFNms1?=
 =?utf-8?B?b3NwQjc2OG54S2JUVlU5UHdJamJVWEc0ck1HNGs5Z0ZJUHpyVUJvNEt6bEtL?=
 =?utf-8?B?Zmg4Z0FXUVpTcGxVMGpjNFRjWnk3VjRrWWdCUHhhT1pDbkFnUGQyajNQQ09q?=
 =?utf-8?B?NXJjUmJqb0hTaVpUd1hISzVWcnVHMDNmTTFVSERZWTVscS9NaDRSR3RLVWha?=
 =?utf-8?B?VUtaZUs0QlFWN3NSWU1ZcEJlOGo2M2tVZFdyZFZNU0dQTkREdlQzUVY0cFAx?=
 =?utf-8?B?TkFycXN3ajdPbThGaGJzRHNyQjM0UGdYaDlZbWMzZDVwWmxSeGl4NDVSelJG?=
 =?utf-8?B?dlp5MXVwZWxQME9hc1RuNXVuQXpnamtieTBKaklwemNlc0lVUWxZdFZwVi9a?=
 =?utf-8?B?TWx6akU0ZWtZQm5BcURQQVl4TU1kNnpqa2NEdlMvQzVGTmt0QktEWjdobDBy?=
 =?utf-8?B?U0dnT2tsTGJwR3N6SUVzOFFuTDdNR3Z0SXpIcHVCNGtQVFI4NFFZelRrUDFR?=
 =?utf-8?B?ZkcxMFJIcXFqUnhVVWZyREpOY29SUUd4dnRPNUIxZ1ZFV083a3M2Z0tqN0x6?=
 =?utf-8?B?MUFJWjVCeFFpTUdMVHZMeTF2YkVqSmlRbHJjeTlCQk9RQnJLNjFTVjNFOXdw?=
 =?utf-8?B?MlJmTWdKSk0vYjNjTmtuVGdVdWpJNXY2YmhuY0xJVldDWExpdEZSVmNMSW9F?=
 =?utf-8?B?eHdXcGRJZ3dZQ2IwallNYVdpYXRRZlhwNmltZSticFREK012ZmJzT0pFZ1Z4?=
 =?utf-8?B?RE93RkMxUkJhbnkyRGhJMkcwRGVBQWcwcFNjdmhqU2pqanVwa1JKZExSUndR?=
 =?utf-8?B?YzdRaWpiNW9pU1hBOHowNlNmcXZBa05wenMwVjdJVlVZYjVGT2hoK09ISUo4?=
 =?utf-8?B?ZzBaNXlNbFRiZitBVWw0aWRVRzRzUmF2SmhRYjIxekIyNU4zVnpRTmRlNUhp?=
 =?utf-8?B?VmxQUnpKODhlU0RKWlFlUUVkSWlaTytWRmZweDRwMDh0Y2dHejR1d3pWTEpi?=
 =?utf-8?B?MUpIRmZ3UnpOeWFuNG1wVHhNNWlRc2dKNW1OSzdhTWpSME9heFFmTWIvK0ZF?=
 =?utf-8?B?WE0vS1N2ekZMbjlIQzQ0UC83aVRNb3MxcGk0SVRYZm9rdVhtTmRRUnJ4Yi91?=
 =?utf-8?B?T3ZaK2h6a29rakdLTCs4UUJjKzNGd2hQYjhIS3YwbmVZMEE2RVNRQi9Kdy9v?=
 =?utf-8?B?M0ZWVlc4TkRFdE4rWnhpb0pDUVkzVDFucFJYWk1nTi9xMG5xQklkMGFkTGVG?=
 =?utf-8?B?TTB5cEZ3cUNnSmZqb2RjZkV6TXRzb3ZCeHRxYzVrYW0yeGt1QWlNc2wvUWZx?=
 =?utf-8?B?SDVpVUp2Y1MreVkvRk1rU3lrMS9HbEZKbzc0bDlITnNpTURQV2Q5SmhqRmpP?=
 =?utf-8?B?SklUaGV2V3N6Rk93bkplOW1wTS83eU8wNDAyUUJaeWlKN0g0bnVNSWhkVVFZ?=
 =?utf-8?B?aWVXYUlsZ3ZrdmN1bWtpQ3dSY1U5Q2pFbG9rd0tHUk8rY1hqNER4azJuOUs1?=
 =?utf-8?B?S3JjckExbjBJdzNVZzV5Tm4rUFBhSGFiOTdjSUphM0M2Y0U1NHlsTm82UStx?=
 =?utf-8?B?S2Zhd3pJVVpzQ3RDZ2JLd2dRNGg4dzByamV3S2xNVFNQU1ZYUzdtUjhNd2I0?=
 =?utf-8?B?MDdLYVF6UlQ3Tnh2ZlZmbVlCY05YcG1zZkVvYXRRTWpCdmxwRTZGK045Wmtu?=
 =?utf-8?Q?UG6gGW1hL74gzcRoCiuasyjpp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c37081-bae7-4aca-03c5-08dcf789af43
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 19:49:50.3927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9DFSzjPdASjjj8Qkm4vfljg+A2Up3PpcHgq18tQPT9JDDI+G09pqVQQA/uRHnh1BTaC1ueZtM+sdypZRNeOfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9332

The ESAI of i.MX8QM is the same as i.MX6ULL. So allow fsl,imx8qm-esai
fallback to fsl,imx6ull-esai.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,esai.yaml | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.yaml b/Documentation/devicetree/bindings/sound/fsl,esai.yaml
index d1b4e23f1c95f..27c34ce4c2e22 100644
--- a/Documentation/devicetree/bindings/sound/fsl,esai.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,esai.yaml
@@ -18,11 +18,15 @@ description:
 
 properties:
   compatible:
-    enum:
-      - fsl,imx35-esai
-      - fsl,imx6ull-esai
-      - fsl,imx8qm-esai
-      - fsl,vf610-esai
+    oneOf:
+      - enum:
+          - fsl,imx35-esai
+          - fsl,imx6ull-esai
+          - fsl,vf610-esai
+      - items:
+          - enum:
+              - fsl,imx8qm-esai
+          - const: fsl,imx6ull-esai
 
   reg:
     maxItems: 1

-- 
2.34.1


