Return-Path: <linux-kernel+bounces-278087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D6E94AAB0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21C21C2114C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091D38120D;
	Wed,  7 Aug 2024 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QbDyKlxE"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012011.outbound.protection.outlook.com [52.101.66.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AB285270;
	Wed,  7 Aug 2024 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723042354; cv=fail; b=lLZbiAhkg47OJxeCvkCassNZNDrhcKQsRAQupG7wxXNCYCqrHswtGZ7/ZYAnZHh3ZoIiHh3d03uZqYVgxj3UfcqblJndLkbH6s7WaTS8He0ZFv98GtzIgVBYo1zaTyZHgmya4tC86btOvMxt1BSHs/SH1BngcSYhtLrgZ0k95LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723042354; c=relaxed/simple;
	bh=hT0OWCJA6JL0xCBifx9HxcQ7HPBi4gGgZ4apa2j4fpU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jtgD9aCMvfkxI9v3td0qGY+6VUAE8RXeT8NYkqVGLPAxC5ICvqI5Gyt9ICBm5U6lKtsd98gSpmUBtN6WIeXEeQ88Ael5vdZVEOz09MOWw4qT+XgRErXLFaKHXfR/v3NXfVnpo4ozFcLtaZZMwgAD6gzrYEgxl7L6F06lvmjZaIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QbDyKlxE; arc=fail smtp.client-ip=52.101.66.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxHpvnyy8YimaJ/i6YsFLKFUI5g566iHHEDxEv9YVUwjfn5eXjuYRlrrZNlvbuuKapvqUuEHYpKF1yovebg9yvmARup2NmtRDxHLRL4OAK31iFroTGFxaw6pZu4JNqoICgXGsm36/o/LngzU8Y6qdsKjytbCYoDxIyoMLYoxIuZcKfJ2F5H5s1F7H2QWZ+lvDHDs0kVH17UfO4i0Y1mnPHcAJ9Tc5ZQGUSM141WCRXxElHbq/jvVdfHBeHUEiW3dza+KSwHTCsaWUJgGS4vSxCbbqSSVOKDkUNswPGrgxxBAhmFUXLDnRsCj+P+1WVPLUXe6Chv2Dc5MwWAgrUpkvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rt1NNvyDVw8E1p3/A0XVIr+NswrmXJdp3OWjzLeb8MY=;
 b=XpRGlFaIisbk04ySOxi10TdDmbuSA2rReTQT3kuOHC3Vjlo1/CJIH30kctF4Ys1Pgyy6GIBMD5wUmaeCvZPp4wBnIFJefeycCgF4r6XEAG6VfdNO+FtcUcmwkGYcP0Ci/AJI7rZh9n8hUkFrZdnKAPtgG+ZqXRYVUCp9Pi+MlIvqMZUYozrWoaoCX+/8KGikCnv9Odtrtz9c8TYGBs/2NWkRdOimobjWKHBWtReBc5ShKXbgYiUFulvwrYdezi24pDp9iYDoPegROS/kIGULwQYkwaYKbng60re+s0/8qD4w5VzUsBLFaJzW93Dq8CG+5Zz9xoozGaHugeDEYqhVBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rt1NNvyDVw8E1p3/A0XVIr+NswrmXJdp3OWjzLeb8MY=;
 b=QbDyKlxETvCRSpTSOnBh1uT85aBxT7ngZUhakdTyR/0Al5lagEQ4Ogj05SIuKRtV0l1jmmsSjiGHtzEprLFDRkmzmti4uUypTxVOJT7R6K8LtjYaW+kiLVo74DTX8fakdIZ1G22j9tJMO9bdXB1IhWayUAzqqK20hkzdjOb7XnIdeDom+S7teYKMU6JqLQe8MZfkCwHpOUZJGjFtzP3BUmeUKAoXTeVrKbCZJgfKF9+Ir26yNnO4e9LDakmnMb2ALt6qM+93chwwUch2LAyaYmSfuL9esGjMa5jP72SpUYOjyZ/yns2OUGBWWw+1mQniHXc2yYdtrv6lGbbgkghKXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10786.eurprd04.prod.outlook.com (2603:10a6:800:274::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Wed, 7 Aug
 2024 14:52:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 14:52:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 07 Aug 2024 10:52:07 -0400
Subject: [PATCH v2 4/6] arm64: dts: imx8mp-data-modul-edm-sbc: remove
 #clock-cells for sai3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-fsl_dts_warning-v2-4-89e08c38831a@nxp.com>
References: <20240807-fsl_dts_warning-v2-0-89e08c38831a@nxp.com>
In-Reply-To: <20240807-fsl_dts_warning-v2-0-89e08c38831a@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723042332; l=919;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=hT0OWCJA6JL0xCBifx9HxcQ7HPBi4gGgZ4apa2j4fpU=;
 b=mu2zzlKKQ+TDi7k5XiUi9m02B3lWJ9xWUE7fspSvP8ndwQtVPcByYiph+91Q1kit/tw3r9vLM
 a4MBB0u9/qSBwt9NimQrZyNKJHGsinzx27Bhmq/PidBaoMKEOl3YtB/
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10786:EE_
X-MS-Office365-Filtering-Correlation-Id: fd68387f-1dd0-4434-c29d-08dcb6f08e2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVFiUUJVSHk2b2UrNzhvNEhmMTh4TzJOZTRYZUhSbVRnOVA5emtXN24xNTNq?=
 =?utf-8?B?TURRdDJEb29zSXdwMEo1dG14TTRkaVhIVWpwZ01LVTVYZ0JDSUJPa2p1OWJT?=
 =?utf-8?B?aCt2L0dMTnNxRXl0cWVZSWc2WmhETXM2YjlMcFMxenRzaEMvZWFPdXFSRSs0?=
 =?utf-8?B?akl6MXNSN3Y1Q21hbEx4UVcvd1NoOEY2TVNQSU5XYVlDWFNWTm9sSlgzeGc3?=
 =?utf-8?B?OEEva09EYW4rODcwYjdLVGM5N1RxdXdpUkdVU0tjWHpsUHA5WjhkekhCSHVB?=
 =?utf-8?B?ZnZTcW54d2F4M0Y5NGdKUEd2ejYxQUx0YzYzTHR3SWwvWWZyaTF5MXRMTEFl?=
 =?utf-8?B?SHBoa1R2NGZOY0lRTktBblZXdldhS3RySkp5WHFxZDZjc3pnK3BtczU2Q0xF?=
 =?utf-8?B?dTdLMGlrMWhOL0p3QUxRd2lGZmhzZHdMYWJXaWJueEVTMWNBWW1NYXZaaDZD?=
 =?utf-8?B?MWMrRm5zWGlSSmJLN0RlOEMycXJ3TlVGU29vaHhVK2d4U2N0a0pPaWNTL0tZ?=
 =?utf-8?B?ck0wU0t2S3dZQVNUUXNmdlVkaWg3K2ZwSU5kaTNGZW84UEJmSzQ0VUFGeEI1?=
 =?utf-8?B?cFd2WmNzR0E2ditwZzlsdFNvYTk4K096bXlRWjlhRlNlSmVzMWpLU2hTWjVl?=
 =?utf-8?B?bGY3VmdXcDBWd05BTEZCenY3RUJ6SlhzV1ByMUJRTVhCTHN0ODVEZVJPbDFL?=
 =?utf-8?B?dHFEREJKTlBDcllLVHhOVVExZG5wMEtORXBkTVhHclNsNmZSRVU1QWg1eTZj?=
 =?utf-8?B?TkNPd05TdUZGRzl4RUhOQmwxNkVjc0pqQXJsOGl6V0hqZ2k5VVN0UUNuUC9W?=
 =?utf-8?B?WDRXVWp2aVBMdzFpUENzREtsR1A5TEZ2eTZadC9uQXVHRVplSGRPVzBKUmlj?=
 =?utf-8?B?K3JCaDNyOWJsbUpyd3grQnBsVUxPSUN6NGdJbmR5MFRCb0lSTFNaSGZweTBG?=
 =?utf-8?B?anE4dVp3UUNZKzg1aWJyWDdqeHNrZVBqYW9zaFRzK2tSbG9vdmp0UTdBc0Fl?=
 =?utf-8?B?Y2tWNjlLWktqcitnNk5zclZZNFhXZVV2dUZmaUthSFRIaFd5Yks0TGxZV1ln?=
 =?utf-8?B?NVYxaklrVXExUWE4MW5zKzlTZUpYZEMxMjhxY2MvKzlrZEVXOGNaMlROd0Q1?=
 =?utf-8?B?UWtVcFUzVkhlS1l2ZHRmMHlBMTFlQk5zblNJNTJaRlZ4VnhYYWVQa2xoVi9t?=
 =?utf-8?B?UHh0WE10OHpkN2FsVyszd3oycUdNL1ZQVWhKZXRvK0NyRUdUVlc3cU9qaHN3?=
 =?utf-8?B?ZERDblN3ellVeEpzVU1qK2hIQTV2b3pZTGJCRHpHUmk4WkJhYVllSEQ5cjRk?=
 =?utf-8?B?VnE0ZWthWjMwaVJmOVByMHMzM3F6bUJlWVBYU1A0Q3RnQjVFYXhUcHRiL2pZ?=
 =?utf-8?B?ZDlDRm8xNHJGUFQ5NnNuUUZiQjVmM05Zc0RWampQSU5ISU5GTlJxN1ZYUFdw?=
 =?utf-8?B?N3RHS3BibDdCeGowaU9vNzlFRDlvMDFuMFd4MkRsSkZhZzJjZVZtMXJSanhU?=
 =?utf-8?B?UzJjNTR5STFwM2ZkTll4RzA0aWtRaU5WbUFJNW83MFVrbEZZUFJSN1dYdlN2?=
 =?utf-8?B?eE02aEV2YjV3Q3hQMzN4MlhHR0tNaTI1dExzclBUQ1Q2QUVpNVc1dXRhcFgy?=
 =?utf-8?B?eFVBLzFiTUdzY1I1UmdnVGt3eFY1UVRJTkE0bWpROUdXQTNMaWE4ZnJPN096?=
 =?utf-8?B?RXdtTytFaHh2K25GWkZGUndnWWdKVkZ5QWNJTWNsOGJlVVgza25kbmVnOE9L?=
 =?utf-8?B?clhKQzFXbHg0dGJjMXNhQk90SDlOTGdtU3ZkMllseFkwazI5MGdWOS9wVW43?=
 =?utf-8?B?Wk4yVWxjTFN1TTAzeVZZVkdwa1pycjI1RTRIMklwbWxSSnllSWJ5dThHV2l4?=
 =?utf-8?B?ZVNHUWduaE12TEQ5YU52cFhOcmsydmdWeUlYdlNjaS9Iamc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2tTYnE5eS9laHhwa2NnR3EydXA0OVk5NFpRWWZrZFZRSEFhMmFWOElIa0Yx?=
 =?utf-8?B?Smh1RlltTVpDeXBZcGZjRjk1VEJ3bU1kQUxQU0FhaXhPcTI5di9VMGJhdEo1?=
 =?utf-8?B?Z1huZWtBa2oyTDNDU3lpdVZIeVpyczJVWkNUSEhsMlQvQ0VkcEh1OERzNjhp?=
 =?utf-8?B?T0dQeE0zNmtSd29MMnZFbW5SSngvbnJ0ZktEYkdTTEIzYVRTY2hpTWNFQ0lQ?=
 =?utf-8?B?azJBeGRidVdTYVVIdE5GdlcxTG55UWxPeUNqc2l4Z3c0Q0JaSXlEQXBvbEN4?=
 =?utf-8?B?L015Q1k0WnJpdndqVkt4TnBZeldRVnpMVzBxM25SZjFKOWNCZmJtdkJoUHdm?=
 =?utf-8?B?bEU3SFIyb003M3A1ai9BT1ZEbXNjLzQ4c0VwcFd2SHljaE8wa0pCSGFHOUw4?=
 =?utf-8?B?a3hvNnlnbndBL3JDY1VZZjcrQWFFQ1VWazVYNU1uQmxnN1V5eDZjTzV0SXJN?=
 =?utf-8?B?akxYR28wcTZuWVNzajBYUkFCcXEvVVo3QzdnRVNqZFYyM1o1VUM2cEVaazRo?=
 =?utf-8?B?aFZzVWRNdWNYa0xBMXFQNFRDMnhpZ2lYVXJZSnBZUG9qWU5HZVNYd0RKVk45?=
 =?utf-8?B?TzhmL1FuNTdseWN3a0FTVTQwVStVaDNDWkZXdEVKbzNORFB5VFBwb0ZUL0hN?=
 =?utf-8?B?d3AwcmtVd3B3ektVSmhaRFdBaVRyM1NlQU9LTUxDZ0xGdUNNL2tLcitMUjVu?=
 =?utf-8?B?S0RBQVlUY0RRdW5YV1pGZHlCNjlXb1BEK2JWVHdPL040N0E0WGRadjhRcFVO?=
 =?utf-8?B?Z1d3RTdsMGVBd2ljYlRpYVZDTEpxeUpzOGlTSGNueXcrQmZycXBQR2NUOFhK?=
 =?utf-8?B?U1p2dktaMTdDUkZXOTJDMkdLNEkrbjhMNGxYTnVKUkZDa3dOK3RaV2JYNkQ4?=
 =?utf-8?B?eHQ1TzdOUWwrM1F6bFJTZ1k1elBjam5BakpnL2hMaGs2aDdSWE1QZzd0eU5W?=
 =?utf-8?B?QmU3N0x2Q3hmT2o4T0FjSW5jdnhDRkNycnQ4T253K3JwN0htOTR5QkxaRXhu?=
 =?utf-8?B?WXoxekVrMDVHNXFYbk42NXRYQ2taRHFHZzhDOFNHRVJZcSttNnFMV3pmdUdS?=
 =?utf-8?B?TnRtZjFlUHNtL2s3T2R0cWhtdHZNSUtZWTc1eS9XZlg5UC94QlhOWDJWS01M?=
 =?utf-8?B?cnI4RFVNYWx5cXpDWEd4TEZhYU4wS21Ic1FKOXZib2FndGJyWG12Q3VRVEZh?=
 =?utf-8?B?WTRxaHExNitNTkM4cVR2TTFtUkFmbjZsckFRb0FwRmQwdDVYanNCZlJSWERa?=
 =?utf-8?B?M2hDZ3ViQ1JJQzdpeXpDVkswWURrNkVIb3BwTEM0dkwrVXdnT0RSU3psN0FI?=
 =?utf-8?B?TFRUdmJwbjBmdUpHMHRqd2dZSHJhNDNVWTZ4OGEvRUpTNWh0eXFzU3FIaHcx?=
 =?utf-8?B?cU1CdkJIUEY5NDQ2QVZNS2piREsvRk9EZTlYa29KUzcwaVFnWUUwSDY5Ynhw?=
 =?utf-8?B?L0Y4USs3NGJmSWx4NC9zcnJPbFVvTkQ4eWVqck9HRXhuRU0vbFlTUUpwNU1i?=
 =?utf-8?B?cDR1TWo0Z1NxeWpreENhK3V1NW1VR3pQN3VURENPUHJtN3lEN0Y1NHkzVDBk?=
 =?utf-8?B?YkdqY0RPL24vL200N0RhR2tyWEJlczExVXpsdVlYZkhRUjZEMnBZYmdqa0ZY?=
 =?utf-8?B?SEUzdEhzblJJMWtIM3NHVnptYmtOUERJWlhkV3hzNE42REJ0V0J1SnhuNFhz?=
 =?utf-8?B?UDlpR2dzMGt5TUM5UVhIalByaHNTSUh4b0s4bnZmQytPUmtzc0tqUHVKL1Fa?=
 =?utf-8?B?T3ByMENKS0RWK3FuMmYvZTZFTk5EQzBYQVUzSFBpK0oyTmljTGlpR0F0TzBj?=
 =?utf-8?B?aW4yUnRoYVYyYUswT0p0NFJac2dNRFFvTDZMYjJ4bDh6MzMrTHpzQXRGWWdv?=
 =?utf-8?B?UzlnUkhESG1seDREcnhzMUpwTDlpc2VmSURkdXk0Mk4zTEJxcjF4cktNTjZi?=
 =?utf-8?B?Z2h6RFRtUnNROGdBYmowVlM3dGNXSFpCcGhuZEN2VGZ0TmZKMDMwa0d3UXhG?=
 =?utf-8?B?OUJzb3lhOUZ5MC94ek85ZjBZWDg1TTlqcGdsY2djQUQxcEF2cHdrR0Voellp?=
 =?utf-8?B?V2xsSkM4KzFCQ1dJdWxwRlNIRk5xejVCM2FoSGttTjZTSkpJdWl1M3dSYzk3?=
 =?utf-8?Q?Z2no=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd68387f-1dd0-4434-c29d-08dcb6f08e2f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 14:52:27.4544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSiDhn3jMXztwqwEnoWJitGRg9cPzmgvOgaNu+XLgVgAoo2feLBIA6nCuihwwJqS5cZfV9o/YI6RpDC5I4WW/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10786

Remove #clock-cells for sai3 because sai3 is not clock controller to fix
below warning:
/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dtb: sai@30c30000: Unevaluated properties are not allowed ('#clock-cells' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts b/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
index 7e1b58dbe23a7..837ea79741e8d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
@@ -499,7 +499,6 @@ &pwm4 {
 };
 
 &sai3 {
-	#clock-cells = <0>;
 	#sound-dai-cells = <0>;
 	assigned-clocks = <&clk IMX8MP_CLK_SAI3>;
 	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;

-- 
2.34.1


