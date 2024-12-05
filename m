Return-Path: <linux-kernel+bounces-433721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFAF9E5C2F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1466F18873BB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA3122578C;
	Thu,  5 Dec 2024 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y0DbU26S"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE007225775;
	Thu,  5 Dec 2024 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417490; cv=fail; b=D72UrNmNqv7fRsYbGvEHo2O3kt7yk7L9QB4ETi/DiFg3Y4efocgkM04HVNEH3TfKuTruF+nRD4rhS4TxtO5g9eWwaYStL3qdsEvYNVCUNGIg7tv7/zlKLRXcWIcDxHzQi1vCHMSlJvRXI8JwPD++G41jT4pTA319/Ll23QEbXGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417490; c=relaxed/simple;
	bh=UbR0Ks4nySsWjDkCG6oODOWxi7E9bZFZ8pC9aQ8yGcM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=pRmCTmsVMcGVWlU0rU5u5pi/GP2ZeG2wr2X5jnLYnxKoIuxwJkLtFEHd14jdjkKmQjxAdD4SYo/mDSls3xX0b2BILAq0oh0Y9h5MsXUyfmVQX3iDshulK18VGt3ELIOpHLT9t4VV2LE2YAUH8mBkh8fX9a3Kq9wqpQU6Zh2i0n0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y0DbU26S; arc=fail smtp.client-ip=40.107.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cL2NEzobZjb2H2DiS5DciISZ2hoeVhYeoSiftDMk8bAWH4o+JgFv3S/yT/rOtNXfXnhp1hNNg7mv4aoD7i6uo9zq1u/D9khWxgUbYqns8oEPSmhGkKU2AJVzhBffkbTV/NWtFWEiHHeMPBbBVZp6b6+2iekZKHRU75sLaeQkljlzeDkaGAvoWBxZk3HCu5hAueFJbfrwgrBnqcjBiDr2TTTEd9kZFXJooX/EeM8vt2tQV0OZ5lfNt1oRHsfrHQhYx85uKEnrBUS3UlVS7q7gatgEP2G9vy2X/Ao05On2MR4n66fxfjuITOtS4Tw2oo+F5Vb+uZPjJmZd4eKKiIo+tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2hQWCTjQZ4VO7zgLbKfeY2VriRFO5rzNEyNWErdOqk=;
 b=iYhgr1zEWxLxyLQ6JxNiOihPee7cuukE7VPGHeQ1T5+pRB1AB1/PxvkM+V6FfcGRZBMLfjg93dKyMT6DjM36/iJXcQdPoN9hR5enY+rOlRBaN8BwfTn6FsfjiLWZDboa54p+TKcvwGiBFY3KCx2V5Cem1fYYB1ctZT0ZBEO4lVTppGnhYl7ZnEF0JsogSij310jWPJ7md3UkbgweZzkEfy5QxZfRH42aCCf7ALdtaIW97yG1lNzKvF/k9xxaQ3t3Hs2daKlT9ntNK5rKiknrqSAxW7Q/iGQBomBAbtkO5C8W790n8RNmgCvChZnyovJMg2C8n1FdhlN+8tGmmDaMzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2hQWCTjQZ4VO7zgLbKfeY2VriRFO5rzNEyNWErdOqk=;
 b=Y0DbU26SDEiVDz9FkHoYI6fSZCu6eh8MFoBry/VsuRYfEvd3/DL7S25uSnKXvArEDM3w30HJ7VEQHvCxIvuZAfxoIX016FuRd9Xvkd2lv4VUC9o4FIdDy8hRixXWnzX6ywf4AFqq2FISbksLCMpXdGj0clqpY9oJ+m468pxOunP4fsPrOVhTqRR+xTKHYbAzHdfGp88a8SPTxsg/BvrKpt6I43fl0Ut+5VglvuWgDKwEMZ8u86LLgS30UnH/vHt2NU10Abxg5E8/Hzo0U5FVGgPUNQSUvKz0vVLmmMNQL06gts9my6YCDZMz/Ju/YhiRble8zvBliLhu8ZN7d6gX6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.13; Thu, 5 Dec
 2024 16:51:25 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 16:51:25 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/5] regulator: pca9450: collect some improvement patches
Date: Thu, 05 Dec 2024 11:51:08 -0500
Message-Id: <20241205-pca9450-v1-0-aab448b74e78@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPzZUWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyND3YLkREsTUwNdc6Nk4zRzU/NEgyQDJaDqgqLUtMwKsEnRsbW1AIT
 YQ11ZAAAA
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robin Gong <yibin.gong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, joy.zou@nxp.com, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733417480; l=965;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=UbR0Ks4nySsWjDkCG6oODOWxi7E9bZFZ8pC9aQ8yGcM=;
 b=ehC2RxKM+AhaRMhpdI0wc9oIeYdj5PLc6LI3p8Xy5vIdySLDTTmMJf0LUv0Is+eIIE3uMgoMU
 oEVsGLFRH/VD7yi81lorukbH6tNnzI4gtOwF77vgMFBn5kGbAZyBpQE
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::42) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca65b23-53bc-4d16-1374-08dd154d0dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzNoelRwTE11dzM5SkNjam9sYzRQZ2xjVVlQVHNJOW9GdXRiSURQOForQnRi?=
 =?utf-8?B?cGtCUVhCVlpUVkcyRXdhNTlaYnFZTG9YQlEzcHFWL05MUThEc1lKMDRITTNn?=
 =?utf-8?B?L1ZpRFFuQm1Ib3BaeE9ocnNxcFZwd3FDYWwxcjRzbUQvS05WVS9RRTFXKzJh?=
 =?utf-8?B?bzdacWw5cVpSVHoxYklFeUdUcHBxZjZwaXlDQmdvWmMzSEtUeXlJbFFQbXlI?=
 =?utf-8?B?TFpTSDhZVUIwWWFHajBseWVnSWx2ZEttM3lYWmhSSU1DbG5uTFhHd2lCVU1l?=
 =?utf-8?B?dnovYzNxUmhvaHU4L1BFRE1va0Y3M3ZFdUtEYWxCM2cvWkJlS1p0S3NjNmRM?=
 =?utf-8?B?UlNyeE5ZaStCWnNzZ3I5akIzWVoxNTN1ekg3NVBEdFBteThhQU9FOUVlUmRx?=
 =?utf-8?B?MXFwOWM2eVdHdU1pcVlyR3FqbzgxMXp2K0FZVit4NEo2WXhOd1RwM2w2T3JW?=
 =?utf-8?B?Z0labW80Uk5JdWlacXdWcmVrZ042V1dlSDlxTmVxUGkyRHdmWWR4TkZHcUNY?=
 =?utf-8?B?YVNJYnp0WWlFaUJLRzMwWWhOZFNkbGRyTm84TkJ0ZGxKcGY2TEc4Tm16VFo3?=
 =?utf-8?B?dzRIRjRWTitNdzVPVmloNTZ6dGxvZENKMEw5ZEtiUTNLWklKMmZ3aGVSQita?=
 =?utf-8?B?QzJuNDNpajVLc1c4eG9zM2pOYW16dXFBR1I4MkZXVVZwcm9Rc2lXYXNUS2tV?=
 =?utf-8?B?d0RQa0R1eU5JWTRTZjBvU01JemxmZ2FDWk8vbkk5MnNUWlRxS1ZzazI2dGJX?=
 =?utf-8?B?bDVWY2huWTg0T3VtVmxWZEc3cGNTMEtmalgrVDArZ2JSeHBWbXB1ZnpCNmRZ?=
 =?utf-8?B?d2RnWDJoNHJnZ0thWW5lODM3eS9lMGNwRE5YQk12bVJsT29lM1lXMzJONnRI?=
 =?utf-8?B?YlVxYXZhMnBvaE9QK2FXYURBK2U0UUt3N2dZOUZQRXJiOGtzbzk4TlpiK2lO?=
 =?utf-8?B?T2VHN01PblpEMVd6ZjlGRzRXMVgzeldmS0VEODZMMHIzcUJ0UWlWL3BFQ010?=
 =?utf-8?B?VWpqeExvSXJ2WkVCOTFRalZ1aGZtWWtZckJ2SFdTV1EvNDY1Q204RjR0NklE?=
 =?utf-8?B?UGEvWVFKRTFFUUJlNWNCWEJKU0w1UW1jQTBQR3lCa25rUU1PZkZ4MDVsS3dB?=
 =?utf-8?B?eXRsc2QrWXRVazllOS8wRHpkNFZxbzZaYmtCU2dzZitaNERjYkRwZkxKYlM5?=
 =?utf-8?B?aWJxYzBkeWgxNWlmSEcxWmRyM2o1ZzR5cXBGQVo1UjVlais4Sk1OTTYxNTFu?=
 =?utf-8?B?QnBURGozMUhPblEyY042ZzdUbDVvc2hzalkyTi9qdzJWWWkyZE9YVHJXWmVH?=
 =?utf-8?B?d1pmaDRoa3VmcWVPN1BZTkd5R3pGaFUwV0g3alltREhsOXhaYm5WT1BCSDJl?=
 =?utf-8?B?MFlYQy91bWl6aVZUd0xQdTBIR2pqMFBBNHZIVmg4MWx4MWpybklvM0MwRlNk?=
 =?utf-8?B?UnZ6UzUyQUFNQjRFell1eVVtNHEwOFl6U3gzVTE0eFZ1OTA3V3NuTTZTMnNa?=
 =?utf-8?B?Z0FZOVVoOW1mT1loOEFVNGcwRERvNUJQcFNDdnZKczdDSC93bjRHU0YxcWdl?=
 =?utf-8?B?L2tIcWcvOS9HSEd0WnFGNHNwM1BzN3JKN0Q2cEhTM0JJZy9KTlJoaERPRW5m?=
 =?utf-8?B?b21LY2E0N1BFZEFzcGQvdlMzVnlJaFQrQ2VZY1M5RGtxdVljd2RRYWU5R0gw?=
 =?utf-8?B?bUlsQWhwSUsvR2p0S2creGhudE1JOGVYMTYvN2dxdTVjOENJWWxwT1czQUhC?=
 =?utf-8?B?dVYwQjVOZHNvbmJ4NkVMemR2RnY4Yk0zdkdieTE2S3ZoeGtncEZwYkR3RXQ0?=
 =?utf-8?B?YWczNFBIQ0RhbHhhSXhXbmlzRXRIaW9kUEZHd1BrbjFkYUJnc3U2NllTWklm?=
 =?utf-8?B?aENPcWVERU1qa1pNL09zZ0xINUwxU3QwZ242MWlFVGNJTiszNXI0S1BLZGNs?=
 =?utf-8?Q?+1M3PvqAc54=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0E0RDRjQ2dzYlc1RDAzNW1OQjJkclVnTW14WG9FRUR1RVoybk9WRlZycUkr?=
 =?utf-8?B?b0wyYWd6aE5DTzZrcDFlSzJMVTJ0cVNYdk12aHhqMmJKZ0dJanpyRHVXSExE?=
 =?utf-8?B?MzdmL2x3M21FeEM1V3ZUYmRSZnY2UnhNVXBsVDlrV2xjeFU1ZXU0K04ySU55?=
 =?utf-8?B?aVhocEx3Q0RzNnJUOFZHVnZQYnNWb2dNa0E2UmNmNDdRYVRLWFVkN2Z4VUc2?=
 =?utf-8?B?RVV4bFlTeDBoVlJ1cWt5YWwvaW55aTZYbnN3bGd0U21qc3I4ZGZPZzgxbmo1?=
 =?utf-8?B?eCtFQ24zRUFsbkVNc2o2b2taMkRpWUw1bURFRDNLZmRJMlM4ZS9Da0dNUitQ?=
 =?utf-8?B?TlNKdzJoeFJpRzk5bGJxNEw1aktHMHpjUkdBTEI4cUV1RDFIaXBxVk5aaFB5?=
 =?utf-8?B?c0o2b1FMam9GcWZRekVXSkpkYWd3NTZLWjVQTjRRVnF1VHNDWE4xc2IyUHlm?=
 =?utf-8?B?bEQzV2VQbkpQb2pXdEZjMGpPU0JFbHlSWmY3dlJXbVhxeERidW9tSnU2eUdp?=
 =?utf-8?B?cFJhUURJNVQxem9OcmtXUER3SGtOTnFMaUNrSG9KMFR2VEIxUlNVZnl3eWkw?=
 =?utf-8?B?andkb21Tek5qeHA3YzFCMEFNdmRVeXZrZEgxUFlhOG9yeUdCRU0ycVFEcEd5?=
 =?utf-8?B?MEg5WDF3d1dUV3VLaHh5cHpzSG91eU8zSUp3S3NiSUhvWDdHdElKMlpsT0pH?=
 =?utf-8?B?MkFFekV2M1hyQUt2MGFWdlhrTTI1S2laOFVFMStVMGd2NlJqdWEydkNtTVBI?=
 =?utf-8?B?SUFaeEliUm1GRkZRNktOUlVWWHVoVnBEeUhybTlTc1VWK29NdnovbzNncjA5?=
 =?utf-8?B?UlNjRmc4RktiV25lN2srRStSaVBKaVcwdlQ1WXAxUjB2RlJNdmk1Nkx3R21w?=
 =?utf-8?B?bUJFMyt3TEtJQnprYkphYUFFOUlUQW90S0RmZ1o4V1lUeWR2azNZclI4Y25I?=
 =?utf-8?B?cHo0ZThaMGJqNmhLMGVrVXBsUUZGYlk4TFlMUVErTWZydVI0WGxJNGtHQU9Z?=
 =?utf-8?B?QnQvcWdXVHpmZlEyZ0Z6RzJaY1JIL3Q0THgwRWdqSkhUZ1ZwMS9xa0NjUnZL?=
 =?utf-8?B?WGxROFJkRFZXUmtCb3c0dSsyL28wUFpRTnhnbmsxQUVsMStqOFluOHl4WTBL?=
 =?utf-8?B?MzFtNSttb1NFUlg5dTBnZVdMRzMyTzNrOVVCZ1pBV3d6VmVUOERkeWxkazRi?=
 =?utf-8?B?cXNoNVBaREJ4azFQS2ZlQ1Y0L1Fab1haNVdxRFdlN3pOZURMcDhzN0VqTEZ5?=
 =?utf-8?B?a1N5b3lnd0tUeGV6MmtId0pWakRsQnkzUkRMZmVLRjh1Z1hMZE1FRExZOXd6?=
 =?utf-8?B?VFRiNUxWTVRxcERqLzlHNm0vN1VYZUZIZWJSU2dvS1JpUGkzTnI2UlRoWFNx?=
 =?utf-8?B?RmRUdjlFZ3pNSktIdWVKWEJpNWt0a256NU5vLzRUK0JJU21tWXVQTldpdzMv?=
 =?utf-8?B?TUEwczd6VGJIYlFYcUhKeGg0by9JVG1qMTZKVHVua1V4WHM2cUdxdnB1RDg3?=
 =?utf-8?B?bC9peDErSFJZaWJzU245K0srdHNaNEMyYWdjelVOM3YzaWZubmNSZEhJRnhx?=
 =?utf-8?B?aHQ5V2ZvMFJiWVRBM1lsdi9QTmhDcXd6SFB6cUovUUJ4bnlWTEtIaUh3dUUw?=
 =?utf-8?B?Z1lFSStqNFlpY1BsSlI4b0xpUll3cnVKSTM3WUMxRkdYKzlRZzhMUS9kWnZs?=
 =?utf-8?B?ZHJlc0tDbFRLNVpNK20wUittcXQ3Q1dXekpOWWFNYk13U25OeGE1NXIrMW5o?=
 =?utf-8?B?TjZFcU5UeWMvUkJ5QlNuMWJIaVU1d1ZFVW0xUW10Rm1NdGxTNEp2MVFrZUs0?=
 =?utf-8?B?M2RGYk9wMGdRVGNTNERObmMzWm5KL1hXb2ZmNjIxUURZLzJSSUlMT3dlOWY4?=
 =?utf-8?B?dXZFcUo1VjFLVTZNcGV1eC9DMVZaeEp3S0ErcjFFNUR1dTg2K2VTTWdnaGhr?=
 =?utf-8?B?UDBSbkViVmptZys5emlkT1RlYTBTcGxuby9sZTc2UHpudXAyREloZ2g1d1pj?=
 =?utf-8?B?aHJiOEJmYmZxdnV4NVNMMUNFVFh0OTV0ZmJ5aHFYK1dWaWt1ODF2eVpQVEor?=
 =?utf-8?B?OFBwRXprSWcrdEVQQlZVUWozc3VoaTZTbGNzMWExTnphS1NSc0g5bTdhcU9G?=
 =?utf-8?Q?rJg0Jo5P0B6bg1kT4dUwlnbCE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca65b23-53bc-4d16-1374-08dd154d0dea
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 16:51:25.0150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wctKf5FbplnDECXIaMp1m3neK8G2RvBB53prg4GHzrStMCyMgfGgYApTGqXB5lFr9o7B+AJiu5gx/4yR+edkFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7511

Add pca9452 support
Use dev_err_probe() to simple code
add pca9452 support in imx93-14x14 dts

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (1):
      regulator: pca9450: Use dev_err_probe() to simplify code

Joy Zou (3):
      regulator: dt-bindings: pca9450: Add pca9452 support
      regulator: pca9450: Add PMIC pca9452 support
      arm64: dts: imx93: add pca9452 support

Robin Gong (1):
      regulator: pca9450: add enable_value for all bucks

 .../bindings/regulator/nxp,pca9450-regulator.yaml  |   1 +
 arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts  |  83 +++++++++++++++
 drivers/regulator/pca9450-regulator.c              | 111 ++++++++++++---------
 include/linux/regulator/pca9450.h                  |   1 +
 4 files changed, 150 insertions(+), 46 deletions(-)
---
base-commit: af2ea8ab7a546b430726183458da0a173d331272
change-id: 20241121-pca9450-72c3f757a0b0

Best regards,
---
Frank Li <Frank.Li@nxp.com>


