Return-Path: <linux-kernel+bounces-365429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 401BC99E227
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3B51C230DF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4561A76A4;
	Tue, 15 Oct 2024 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g7rii587"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2040.outbound.protection.outlook.com [40.107.247.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C4417DFEC;
	Tue, 15 Oct 2024 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983138; cv=fail; b=JlIYHF4zvXdTiOP4E4F+ySM19eNhAmUjVP5xanxWvr8NIEO/rFjE2RFU2LdJnsZAJcEInT6tHscSgRS0/Pzf3PGFvshw89BfUDOyM2YuKJTSIG1o49It+0UwggCqcpokWTaUIb1QB74ul6M8zL256Dt53zvmlf10M0HrEZcG4gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983138; c=relaxed/simple;
	bh=/mpyoiygms3jP22xwWmnbnAPpljEzYqZqO3tjS14jnQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=ZAuaptnudkeSwKqzErerEOz1qkCKV+sFHyPuB7Nu6iVnSsUxojkpLffcooPdYw3BTBgxZoBl6BFmVT8i7m/5QpgaElLvHZzMY8PXOvFiFzimXZaupN7O/tu89Brc0EcPjiLkfqluRpsOf+lP5P267/t2va8uSyXZBGVgmE6fZAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g7rii587; arc=fail smtp.client-ip=40.107.247.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDTObjr7tIKfMWQJWNqVpAhma8ymHrD28QFpoyJHlmPutGs8H9Rhuwdi+Fs1woo9GL/rV7pik7+8hLMeDJ4KMWEOiUQkwqpqZVWF5CEBCrrWXh3sgHC6g9OG44ixyTjxopAZvThIYzKufkl93UgDXvgz4i+4u/BWOXoSL4Zsjm3xiaYWjBtcwiispfy1GU086pzzBS/NHJ+fPPVdUUmd3C5qfD7ITF9JIpmkudlX5eqXI96QnoKLn061GniWqpoZZn0BSWuNlpMczjsGo6SyHHCw2AjtNwNY0UWlRpVBsFgakUnvwc86QmkTODCGssuxDLJe7bXXeHN7odum/zC8/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cv90oPSkQ9YXESOMkEiMgTA3TWhbdQWkVFpFALNjqc4=;
 b=ytfXoCOex1p6bJDKAHKgaXbqsoGbvC+yJfhkvfEB3+gbH5Z7ualephijDpYewY+AGqhyHYUHQxd/24JafgHKpnp3Ogt5EwSX0C5O3HjfSuDdPzg6ZDCXVgUEG4lHnHXC2Bk0fpexUEfzsfv4fhoWe2VPm84RwWVUXIYBMfP3z4CBG4FXoW8ge7+ZKzq3YgctnMHbdJcj8lPsXTz158RTB2ArbOV1GwB7hgdpBEgqEMCH+tv06FAN6gCXYE/0Qb8xxEc4eIdmCK2isqz2uNEFvLGKbcOjEVKlekNXHd9qxF+r4FIHY7RRmTaSsqG8W/OOUOBj9PI6hAQnQtJq+1sHrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cv90oPSkQ9YXESOMkEiMgTA3TWhbdQWkVFpFALNjqc4=;
 b=g7rii5874qX9FlmpXNrRfOPebR2QD4sH6E4afIghe8QdW48diFXoJ6c0O4T0Di6zWjwpBveMKIfVWgntT7wz+9GA5cT3g0cs2CiV6YkRtbF5z0WOKseLu/9jziax0GUSALtz7Fr2m96tyKc3tZfvY81pkysHvQCPcdkxEU6x3d0h9R1wSdPFBQOHGu+VDM3rOoFmOiuDu2aUw9k6H14QsoRxI8gFcoyAdlYchMfyV4OygOfMpR+Ghc9yDA2jzSSL1clh4Ok/7hemyfOdaWY2kjveBj2hsdTWDRZxacwGcqqC3Hw3tiWFW5CcD1mh2rULYBUwdfQXTndY5KqSgizRhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by PA4PR04MB9223.eurprd04.prod.outlook.com (2603:10a6:102:2a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 09:05:30 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 09:05:30 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v8 0/5] v8: firmware: imx: driver for NXP secure-enclave
Date: Tue, 15 Oct 2024 14:30:58 +0530
Message-Id: <20241015-imx-se-if-v8-0-915438e267d3@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEsvDmcC/13QTWrDMBAF4KsErasyGv1n1XuELiaW3GgRO9jFO
 ATfvWNTsJzlDPqeHvMSYx5KHsX59BJDnspY+o6H8HESzY26nyxL4lkgoAELXpb7LEfetpIMgLU
 QdWqc4PePIbdl3rIu3zzfyvjbD88telLr9j9FQZUyKQkSfWPJeROVS1/d/Phs+rtYMyasHOraI
 TtGbVIhktXx6PTunKpbT5od+YQhZbKNoaMzu/Nga2fW/zABQFaB1FtPWzmFtbPsnCMfI2gKHo/
 OVQ4PzrHLGR2ba8D3nn53EUzt/HaXNiFdvUFndrcsyx9WPW5q8AEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728982877; l=20463;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=/mpyoiygms3jP22xwWmnbnAPpljEzYqZqO3tjS14jnQ=;
 b=G4mjbbxjMJC0HkIP/d7SKWqRWKJo+N+9n8Yjz3ZiD8TxjKhA3rs0hrhykw1pFoNsTmLjoULLZ
 IxC8sWi72CaANMrN5XvUgwIvDKQzqB10FVi6TQsllKBzuqaCv5jtGyR
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6)
 To AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|PA4PR04MB9223:EE_
X-MS-Office365-Filtering-Correlation-Id: 77bd3565-05ec-4174-3744-08dcecf884d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkpmWkRvdm9nQVY5RW5ZdW82c3hEczBZUWNKS1YrWEFYY2Yxd1AzclB1OXZH?=
 =?utf-8?B?bjBSdVlOQWlhWGRGUVpCM3VBQ1dZSDR0RFFudUZwLy9haDZMMFIvU1ZXbUNq?=
 =?utf-8?B?ZjVPeUtIN29RQUJzWEdRWUlVeXFLQW9DVFVVN2pkTkNLaEI0dU5sOStHb2NS?=
 =?utf-8?B?WVludTBxL0gwR2g5cXhZS1l5TE5GUHlVSzFGMEUvSlhCKzBPRjZuNndkQ3RL?=
 =?utf-8?B?OVNxS2FKWStKRmFnTkNOOGF3bTJKUjFZNEx0dWZOQjYwSUlnRDhMdk1LT1Fj?=
 =?utf-8?B?WjlrekVjZ0M1RVVtZi9LdGJ6NmpYc01RdnZBZEYwdUpVaU5BSUtCc3BHZ2dV?=
 =?utf-8?B?NERUVk4xaU5XVjFCTmxjaFBhR3BRZnBrU1dTc3J5SzEvWW1aWC9HTE5LT0th?=
 =?utf-8?B?ZVk1cmpOUmZaQVcvaVE4VjhWT0NKaW1wOXhFNzkzdWp6eHkyS1VzcmtwUmx6?=
 =?utf-8?B?WWVqd1piZjBIaGZMZnBKQVBSbE41TGFtQzFiMXp6bWp5bGFRdXdtYkUwTVB1?=
 =?utf-8?B?OXg3ME45NDB6eWtvMm1xLzg5U1BlQm9Yd0U2Q1Z1L0gydVl4dlZnRzdaSGI4?=
 =?utf-8?B?S3NXd0Q0SUpaVlUxSmlEdGZkWE9rQ1JoenYvbnlMMVZoM21DdUpGV0tFbnRF?=
 =?utf-8?B?ekptSHdNUmVtTGtveFBQeXlNeENUZk5xb3RRMDVRbENiaS9hKzA4YytKWVZ6?=
 =?utf-8?B?WEgwWEh5cExUUC9ucTZvaGViQ2RUaXF4bWs1TmlxZHlRam16bFF5S0xFNWx2?=
 =?utf-8?B?Q0EwbHFNN3Y2WWo0dWhYc2dFbE9ySzIrTFAvc25TVVBXSEhQWDNpWmpWZFV6?=
 =?utf-8?B?S0RJempONGt1OWtJRVRudEEyWEtycTFCVkd4TXBqOE5JaEkrQXpRSlhWQ2ZU?=
 =?utf-8?B?Rld2UEI3VUZMVmFNc0JSaGJBcndLNHB5WWYrMUMzSEtNNGFCNDc3ajVFU1F2?=
 =?utf-8?B?emgxY0FtQVdwSEZvOVdoQ2N2UHpYT3BaVzJ1R1JaUXVlR3dRVmloa2pWTmZJ?=
 =?utf-8?B?blRwS1lSVytOY0VmNVFuZHRCdXoyTW5LM2lvQkdlcWNEQzRPR3F2Sm9rZzZO?=
 =?utf-8?B?OWhwVlZ6WlRlNWhnYzg1K3A2S2VqSm41cmZ3ZzJYS1ZOZk51cUlPbnExNVA3?=
 =?utf-8?B?LzFvOHM0Z0RmbUVnWHoray81RXU4c3NVZkVhbDlmOEF5eVNWT0hGYm5FTzE4?=
 =?utf-8?B?QngwZENzS25Yek0zR2FRRVlIbWJUL2JJdUZLQy9CRm5LUnNaT1BMbThWeGli?=
 =?utf-8?B?WUFOQlpPclRteThTbEhPQkJkS3Y3S0xQcXRIUDVlMjR5ZmVrM0VSTGpISVNj?=
 =?utf-8?B?MllGb1phbUlzVDg1aWttNHNPYXFiWUFuSXF3d2dxK0ZxWmk5dXNqOHdOUmJJ?=
 =?utf-8?B?eG5KV2U5T24xVmxjVnJvMlB0N2l1Z3JUb2JQMzhoc3Z0bWh5Rm9hYkF0eVRJ?=
 =?utf-8?B?UWNjbVk0Smo0U29hbUk2a2F5MlZobmdFUG5lYmNYMnBsbFJFZlZCTENua2dY?=
 =?utf-8?B?a0dwM1VoL2xTQWowd25vdEV0dS8xZzl1em1tb2FJMUd1NEJxVXVjVWxONUhC?=
 =?utf-8?B?U1BqUzBMK0paNnZQL2hFWFJQdWhUUVBLUWNJYVhDSFB5a0ZiYkFIYit0dTQv?=
 =?utf-8?B?QU4rVm9IMlllelpJMmhoRDBtTXBONFc0T3c3dlp2VUFGV29HWjJ6enpzdGJo?=
 =?utf-8?B?TWJwbVRrbEJNQnRiR0hlRnVpa0hFUGFHMVJnQWpPKytMM0xtV05GaFVwdHpT?=
 =?utf-8?B?NFYxTEtNT1VtUVZLd3hBaEhicGlncDFSSGFDaEJzeW9WZDhPS3hacFFqRFRJ?=
 =?utf-8?Q?G/ZN2Ne9vyqxD42X4nPANmIsQLieYmUwERN/Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ti9BQnNabE1DNUFaeWswc2FjWkxEOWNHMERyaURveDdManVmYnNmTlNNeVZu?=
 =?utf-8?B?ZzRwYmVaTlFpYVloeUJqZFZRdHhPWEdZTVRNRitkWU9HWWNWSHNDblhrM3BQ?=
 =?utf-8?B?Zmh3dGJmR00zZHlnb2lLOGUxdFFhSERYS0F5ekdFaGJxSnFPN2ZFQXpZS1ky?=
 =?utf-8?B?NDJhZ0NjV2hLcTY1Z0RZSU44d2oyczI3VXpIQkVjNnZZajJqaGlKL0NhV0Iv?=
 =?utf-8?B?WG91RldKOExYK1I5K0lXY2V1SFFYckpmWXV3RWdvTEtidG05aFczTmpra29I?=
 =?utf-8?B?cFYwS0lic3BaQm9xaTFiT0ZLL0p6dkU1SHltQmZVZldoM2FMdFJReVJwOStG?=
 =?utf-8?B?YU1pOFExbVV5dlppMkJoSDhlcVhEdDVUeGIrM2xHYkFXeVFZWmJuK0s2eU9B?=
 =?utf-8?B?b0RtcnFMVHR4V04rU1Q5b2cwblFNRC9zNDh6c3k0UVFtZEM1U0dvT0RDQnZk?=
 =?utf-8?B?SlVXQ3pzMXRKY1hSS05YL1Fucll6VmdHUGR2NUJvUmNXdVdKS0NtZDJHMzZi?=
 =?utf-8?B?N2hCTVdxU0pES0M4Vnc5Vjh2ZnNFRlRCYlpQd2FQTjRqbk8yMndjMU9jNXc1?=
 =?utf-8?B?dWttMVJlQUpvNTg3SGxFRnBhYVNBRG5JMHUrQ3pHcE0xMFUyelB4a1E5eWRu?=
 =?utf-8?B?c0hmK1Z1Mk5LY0pxc0VzMWJXUHpybk4wdlREcHpDWU12aTlrUDE2N0JSSTM3?=
 =?utf-8?B?bTk2SmZGT2V3ZTd6dVJuY2M2YU42d0xmQ3BPejB3RVhtNW1xcXFSdHJ0bGVH?=
 =?utf-8?B?VEk1cUdNYmcvWHUzSHFXRHVqQmsxMmU3NDFlbjYxT1dQbHg2bzg1QU4xam9W?=
 =?utf-8?B?N0lWOGJhVE5SbHRYbmppV25LdnZVSmsydUdVc3dnb3gwYXV1MDZoT2dnQ2d4?=
 =?utf-8?B?a3B2aUl0ZGdkdmRqNG10bzMwb0h6cUdLOE4wVXN0Tno2SWE2cU5zeWlOaVBJ?=
 =?utf-8?B?WURRSEdMbmZBb2hGQnhzVXYzL2lpOUNWNENRK0pVamVUU0QrWENKcnZFRW1t?=
 =?utf-8?B?dmwxV1E3a2ZDRGNyUnVaZG5GZHNZaVFGS2Y5L1o0cTJYUitndFRnemZ1QzQz?=
 =?utf-8?B?R2xXbHc4emJyYnJ6VUxOZDlDVHVVNU1nL1VXYlQ4RFpEVUwwMEhjQzVBV0dX?=
 =?utf-8?B?UklpTmlYMHNaVUx6TnJ3N1JYWHI4QzRKV25yd3JTV2JxL1FvSDhPTWhKdTdS?=
 =?utf-8?B?S2wxTXg1U28zbWptSGc0UTVWNnJwNVZZWmJnbUpab25ldytqK0kyRE9oS2pI?=
 =?utf-8?B?L292dFFSdDNzcFpHZjd6YnVFUGVncHczUGtPQVlwa09JVENaTmNUUFEyZEpD?=
 =?utf-8?B?NVJOVG1ibUpjak9CSjBGMVRkajNTNmlFT0lHVFJWV25WZjZGbHgvL0V1ZkN2?=
 =?utf-8?B?R3NWbnB4REZDendOZEFGZVA4Nm5jNjUyV0REMFNzbUlyOXlBd1pxeXZvRllh?=
 =?utf-8?B?a1VhUVZNbVhGWlRCUkJaNzNYa0s3elJvVzdqS0w4TnpydWNNMFdudWNOSVho?=
 =?utf-8?B?NVY5RmhFYWR2M0x4cGtvSk5pdG5ZcGFWdVJ1OTAxM1drVUtxRFlNZW5lYU5L?=
 =?utf-8?B?LytIeFkyMkJSTTNObzhMM1EvNWhYeC9FOTlONVVVdW50TXlSTzFYTU9PS2FR?=
 =?utf-8?B?V0sxallsRkNSZzEyWGJkV2FsMDZsZnUrSmkxdERVMTdxUmJaM0RnSE0zRDNR?=
 =?utf-8?B?a0lhcFNxNEJvRHQwQVJKSThQTld1R3IyS3NQemE5TTFhRVRlOWtYRHlFWDNN?=
 =?utf-8?B?REtzK0d0ZytaS1Z5c3RaMWVqb2M3aHdlWGVqVHd2dTNwMkZDSDdKVk83U2d1?=
 =?utf-8?B?N0pIejlVY0dNN2FxOElVSEpLUHcxeElHRWh2MHZmckRXNTlrUHZEeDEyZTNT?=
 =?utf-8?B?UEFjYU1nTWh2aXVGVjZuTldmUkYwc3JtMEVQc2MwamRkL05zU2p1eEhIMEFz?=
 =?utf-8?B?MUprSmE4clJITGhZMDd4aXhqU3p1ZFl5UGVYSnBGa29MM1I0SFJzMEp6dnFI?=
 =?utf-8?B?YkZvR3pKd2dJTEJEVjVDVmc4TDUxYWRpODRaR3BxN0o1Qlh4eTRmdWxWNDVN?=
 =?utf-8?B?aEYzOWpxRElyOCtmcmVpcGFPMW95V2d1MTJpMzljZEg0UENqWmgyb3BUanFq?=
 =?utf-8?Q?P1Lbshr/KOCKFiDVIomDKRy3T?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bd3565-05ec-4174-3744-08dcecf884d3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:05:30.7482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTOjbEJ7c//S07Ilpc6056OWfxGxpxhOjthKGj88WW/dIsQXfcAhGb+g7vY0IElwRlOhUhu2OiZsXd2zRpxwZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9223

5/5
- Remove the check for SE_IF_CTX_OPENED.
- replaced dev_ctx->priv-dev, priv->dev, whereever possible.
- func "if_misc_deregister" moved before func "init_device_context".
- func "init_device_context" before func "se_ioctl_cmd_snd_rcv_rsp_handler".
- func "se_if_fops_write" and "se_if_fops_read", are moved after func "se_ioctl_get_mu_info".
- non static functions "se_dev_ctx_cpy_out_data, se_dev_ctx_shared_mem_cleanup & init_device_context" are moved static and local scope.
- Removed back & forth between the two structs "struct se_if_device_ctx *dev_ctx" and "struct se_shared_mem_mgmt_info *se_shared_mem_mgmt"
- removed the NULL check for bdesc. 
- fops_open, is corrected for acquiring the fops_lock.
- Fops_close, mutex unlock is removed. Infact check for waiting_rsp_clbk_hdl.dev_ctx, is removed.
- sema_init(&dev_ctx->fops_lock, 1);, replaced with Mutex.
- structure member se_notify, is removed.

4/5
- removed initializing err to zero in func ele_fetch_soc_info(),
- replaced 'return 0', with 'goto exit', if the condition (!priv->mem_pool) is true.
- replaced "struct *dev" with "struct se_if_priv *priv", in base_message API(s) and others.
- Created a separate structure "struct se_if_defines" to maintain interface's fixed values like cmd_tag, rsp_tag, success_tag etc.
- removed the macros "WORD_SZ", "SOC_VER_MASK", "DEFAULT_IMX_SOC_VER", "RESERVED_DMA_POOL".
- Added handling for "ctrl+c", by postponing the interrupt, till the response to the "command in flight" is received. 
- Removed the mutext lock "se_if_lock".
- furnction prototype for "se_save_imem_state" and "se_restore_imem_state", is changed to pass "imem" by reference.
- Added a new structure "struct se_fw_load_info", dedicated to contain FW loading relevant info. It is a member of struct info_list.
- split "imem_mgmt_file_in_rfs" into two "prim_fw_nm_in_rfs" and "seco_fw_nm_in_rfs", to be part of "struct se_fw_load_info".
- moved the function "se_load_firmware" prior to func "if_mbox_free_channel".
- function "se_load_firmware" is updated to use "request_firmware", instead of "request_firmware_no_wait".
- function "se_load_firmware" is updated to load "primary" fw image, if the imem_state is not BAD. Then load the "secondary FW" image.
- Added a new mutex_lock in the function "se_load_firmware", for ensuring FW loading done once, when there are multiple application are in play.
- instead of "wait_queue_head_t wq", used "sruct completion".
- add devm_add_action with action as se_if_probe_cleanup.

- Link to v7: https://lore.kernel.org/r/20240904-imx-se-if-v7-0-5afd2ab74264@nxp.com

Changes in v7:

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
 drivers/firmware/imx/Kconfig                       |   13 +
 drivers/firmware/imx/Makefile                      |    2 +
 drivers/firmware/imx/ele_base_msg.c                |  279 ++++
 drivers/firmware/imx/ele_base_msg.h                |   94 ++
 drivers/firmware/imx/ele_common.c                  |  333 +++++
 drivers/firmware/imx/ele_common.h                  |   51 +
 drivers/firmware/imx/se_ctrl.c                     | 1329 ++++++++++++++++++++
 drivers/firmware/imx/se_ctrl.h                     |  134 ++
 include/linux/firmware/imx/se_api.h                |   14 +
 include/uapi/linux/se_ioctl.h                      |   94 ++
 15 files changed, 2625 insertions(+), 3 deletions(-)
---
base-commit: b63ff26648537a5600cf79bd62f916792c53e015
change-id: 20240507-imx-se-if-a40055093dc6

Best regards,
-- 
Pankaj Gupta <pankaj.gupta@nxp.com>


