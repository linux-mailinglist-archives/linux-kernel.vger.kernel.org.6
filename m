Return-Path: <linux-kernel+bounces-374690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7119A6E8F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA129B233FC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BAE1C5796;
	Mon, 21 Oct 2024 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OROyzr2D"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9D8199FAF
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525532; cv=fail; b=JsB6H60VYnV/aZbsnvgsrA+TkLW0DQPYPk1zqB0TPz+3zBDRUj134hg0ZQmpRgoXqOBu25F59boocHGyg5Cx+/vCvHoyZMXsynMIl2gYv/wKS/C+Ck9XQHbfvkHh7KPPRo6bZzpys6wi1pDQlTg6HzO/vgQi4F1Lt1dGJ/jRwKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525532; c=relaxed/simple;
	bh=RF+K6k5hNWi6XLW985uClu+rYjI9LQWRNm31Nm82054=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FKEedEKJxJpx3Nj4ZMBf2s/aDfeCwgdPAK90FC08LApa6cZ8YrxvJfSUDAqXlYbbgIftgLvigdJ2eFjHjme5zKUcYPNHT5yt8jx6fM0RSW+spnxdF1VWlShFr+8NihRktUcjtndQZjhI+S8sTB0A2tCLvYASdCcDFIgpfoiCWs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OROyzr2D; arc=fail smtp.client-ip=40.107.21.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NMvHCILlRHLfrCswfDoV5fVIYGAX3vzTrCsmCnf/4F+MQe1x/ZXIRmr1r1Z0j1ruqDwtGlpQa6KdlebHmTIF5NxUpUnLACRDq1rys8YALMafYWdeMs0VcIdY7EMv7wDfFMByUbPtK6y+qBjqT+FANrWCufik0TduwcAlZA2O56ID3WmpF+6m2GM/HCIB8toBPUrbgYC/nZm6alPSOeJBhYG+xMQcEyrlsBiG1j+/74GA1hCpAZmRsRN/wieq2bD2/DO7sdawyZWG4QUImWXqLCp4y7cQrUr+Lh0gBsYSSVCTwSXgGuAjO9qg/PknZ/jw8ZCu3pvIe8pcBpxtG8fzag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eZFESgy2A7HhzoaZNK6yCDosWtkgT9dE8V/zsOlrEI=;
 b=N+OaA9WZ6mTTErHb5pV6JO2hmpjNLOHBRqIXDkHWwOP4HqWZo89cpuCJy/Hq6Zws8bGRU7WlZwGVu0avEYKh+RGJKaN/A848YQnMdfBXNNsdfzevSHRfMZ5OzB7HQgvZbO3rqCi1eqFh+16DEqScbsMgMe7RS1JEfu0ewNwc9gSYKi55c4edo+I1HeD7LI/V93gIebCDQYysV/VFq2lYGVUhFC9FcxuQuEHEXkIR6cYVHnZFCBqstRELiqZ7KBDBOIuFzTHa0u2r9J8+XBdopcR1nXaciX1Mg+QSivwMJnXtz52twkQmv9WzKOFpgTO8xkKTQTMe2D0W6vbCGgtFVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eZFESgy2A7HhzoaZNK6yCDosWtkgT9dE8V/zsOlrEI=;
 b=OROyzr2Dc5uOjVlcIg8dvyBMxM67HEU+lJ7E0DJ0x93xiyWCPsfBKbb0ixuivUSfpij9R9th7qAcGzNyjVZPuo2ttgtoWCCoNnQWhgl/XseoPwwwYBtcSZc88J0CpeIHF3awuwC1Y+8KGSGlk/9stVoitKu21UWcjgD2jcjglPrBMi3fjk4Az39MSK+AcBtigle6evFn3zUaidvkz2j9GLiQvQ4Y1jkpzT9/uDBOJCy3BjU5RnQEfBur4lIQ+1ybK4U9pqJ9Qo3rZidMnozWVBcaHI1+NLRupeMxIZS5lps14yte49TPUcjwpkelA3hYhS47kyjXFB63r3b0ttc+Sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PAXPR04MB9058.eurprd04.prod.outlook.com (2603:10a6:102:231::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Mon, 21 Oct
 2024 15:45:26 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8069.018; Mon, 21 Oct 2024
 15:45:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 21 Oct 2024 11:45:06 -0400
Subject: [PATCH v8 1/3] i3c: master: Replace hard code 2 with macro
 I3C_ADDR_SLOT_STATUS_BITS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-i3c_dts_assign-v8-1-4098b8bde01e@nxp.com>
References: <20241021-i3c_dts_assign-v8-0-4098b8bde01e@nxp.com>
In-Reply-To: <20241021-i3c_dts_assign-v8-0-4098b8bde01e@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 arnd@arndb.de, bbrezillon@kernel.org, boris.brezillon@collabora.com, 
 conor.culhane@silvaco.com, gregkh@linuxfoundation.org, imx@lists.linux.dev, 
 miquel.raynal@bootlin.com, pthombar@cadence.com, 
 ravindra.yashvant.shinde@nxp.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729525518; l=2178;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=RF+K6k5hNWi6XLW985uClu+rYjI9LQWRNm31Nm82054=;
 b=CSxhsJyAOUE6ysMbYthQdcJruajKe3LuFbt9atMnCijWsJwGhdWDPW4SMM0DHjqyFeUZbl1u3
 8vfBTnve4OKAnNCYpzAsJykbEx5joma9gYfqOWnTRw/AHkIvPm2F2db
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0006.namprd08.prod.outlook.com
 (2603:10b6:a03:100::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PAXPR04MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a644a80-8d54-45fb-3a85-08dcf1e761c8
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bzV6SGduTXl3aVdDaWlUdU1iV0c5a3NRRXQ0bFV3L25nNzdNM0oveVRTdWRS?=
 =?utf-8?B?enRFRFpQYzVHQnpNWGp3SU9NejgvTHdPVXZCa2JncllZaUtpSk5ISXlITDgz?=
 =?utf-8?B?SXE0RmhZdnViRWp5eUZOeXdtZWVWMUhNSG56SnJmczlVVmhlaloyT3FoTDZC?=
 =?utf-8?B?L21GUFc4T1NUWlA4dHcyM1RiNVdOVXI4cTF5b2M3S2VVYVRnN3YwN1Y1Ym1Z?=
 =?utf-8?B?NFJ4MTZMNlRldlNLUmVYQjIrYXQvSG9majhLWThUcm9qdUdhdmI2ZWZhdWlK?=
 =?utf-8?B?U1dMNDMrN1hqZ01NYmtNaFNtend3aEd0K3psVzNGTGZUdzlXZ2VPdWFmTjRW?=
 =?utf-8?B?VDNDVVQwSzB5NlhMUklSc3RHdTNPelBhVVhRZ2U1QWlodHlpWmlnWXRXK3A5?=
 =?utf-8?B?U1ZLSlBEalNRR2ZCWWtpZ3pIa1lWS2RJVzRiSEZzcUlXMkZWTURlK1dNS3Mv?=
 =?utf-8?B?ZFZxZlE0RFNhcE8yeGRxaEpvelZNNnZBeGxiSEpUKzRBb0hZWVRhdmkyT2ky?=
 =?utf-8?B?YmZZTmdrZkRIa2VzWk1EWVNpVENBOWpOVnV6eVVGeXBUTEdFSEY5YngrTURK?=
 =?utf-8?B?d3VLV0c2cmFhSW5BLzdwS2VhMTlwdkxUQkpYYzJyOTRrSU1aZ0c0SFgvZHZX?=
 =?utf-8?B?RThBdXA3QkZhMytDMllTZWRIMDAwbnhKb2F4Z081a1ZQa0wvTXlHeFJ2VE1t?=
 =?utf-8?B?OFV4L3lLV2dlWE9KRW5IblJnSG8ybFU0WS9oanhKSmd1VzhreHVRMmgwc1lo?=
 =?utf-8?B?aENHU2E1TnJ1MGxULzA1NmlaV3NmSkk3bkgzWkhVSXRDRlJyVVR6VXV1dVpt?=
 =?utf-8?B?ZjdIWVVKQkxXRGlNcjJqMVpwTmR5TTd1a1V5bDVzTC9XTktnR2w2b0NLd2Zi?=
 =?utf-8?B?YmRVOUxVVm5UODlNRStYWEs3Tkk0dnczdEFnQ1piUlByTG9odGM3a0pIb0xu?=
 =?utf-8?B?Q1J3WitrUWJBQzRjKy90UG5kdmNPdVlmVUk0TWNVakJSbUUwYkFzamlPY2Qx?=
 =?utf-8?B?Q04vMW1FRkI0THY0OVRoRGNnMWJvVWJYYWF1L2ptdmlrVnZDU2w2QXdhcS9h?=
 =?utf-8?B?WGpyVWJhWllaRGFZSXozUHMrdWVGa2txRmQ3V2JVcEJNb0ZsbFUycWFGRENj?=
 =?utf-8?B?TWJHTmpVd0hVc1JHMG5NNHJrNUxZSDh4TjlPS1luRWZmeVR0QnhMTHdQVzhH?=
 =?utf-8?B?Ukw2K3FrTW1MU2dKcDlVaFJUTytGTitTYmRFZGlWNVFDWFpzV1BsWjR3bjR1?=
 =?utf-8?B?ZXpacDNVMytFcDh3MXJHT2tMYUtpRXF3dEtPRGd3SmpDbzZaalR0MWVtQ1Nj?=
 =?utf-8?B?bDRic1hFL3JSTGp1RzJySEVVSnN1QWFQN3diMEFkZHJNaCtLS3NmZS9Bc3Br?=
 =?utf-8?B?Nzc1MDFrT1gwNE9obkx2eUZqaWlFNDhoU1dneW1jNWFJd1JLS1dxeXF3MHYv?=
 =?utf-8?B?dkpoMzk1VHpMei9oR1d4MUJsaDhoSXpzemtaa1Z3cmo3VGVGMWhYaFBZVTNE?=
 =?utf-8?B?L1FWVzZnK2xmQ2FlMjBTcktOWnVGb2NQZHhHN3Jka0w5WTRFMHU5dGRtNjFG?=
 =?utf-8?B?TkZ4TmdYcDNFaklNS0YxWFUrc0VVQVdBYUJsWG9XVDV2WWNtdmVKK2NNS2F5?=
 =?utf-8?B?a0Evd2Y2Ynk3UUxBbTBuTEMydUtSNllNMDRPc21DUG05Z1lUYXp0YzFKaTRu?=
 =?utf-8?B?L0dXNnU4VmJBZXJxN2pMc09lbjhFQUZiblVmRVQ1RDk5Z0kzY3VHdXNwQjEy?=
 =?utf-8?B?YnR0Wm9BemFTZ2Y0Rk1jby9sa2pRWVFCQlVhM3owN2JRVXVlSGRHR05Uandl?=
 =?utf-8?Q?RjTQKyYGXd5hsqGOHdRhD91XW5NPyCj8/QeiA=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RkJ6bEFGVEhHVkxkdEZReXM3aTYwczRLMUI5dFdrMG9oY2lTSGtFR3d3bFBp?=
 =?utf-8?B?dWYvQk9hcTZzRTBraHUrTE91QXI3Nmk1bG9EODlDUTZINmd2aVFGdDZzbStt?=
 =?utf-8?B?cW83QWV6UFVlSXJqakV2aXJ5cm1CekRaMmRtMzJ2amFFZmZ2WVZ6VkluVTBz?=
 =?utf-8?B?YlFrWjlNaysxak9WdVJoc2tuTkVmcEFWOHVUZ1YyZ3B4eGh5OGNubWUzY2l5?=
 =?utf-8?B?MVdNZmN4djRLTDArWklwWkZYOHRDQlZGdnBzRTRoOFIzQ3QrUUloYmRxVnRl?=
 =?utf-8?B?ejBoamNEVkJHelZtQ05KOFNUQmNuTTR2d00rb3pQaVNPdlpnTXNpd0EvanhL?=
 =?utf-8?B?cDg3TmNYU3kreXhBSHpBZlVMUGpqNnk5ZmRlbWdXcWpzWk9VQ1JxTTZ4MmRM?=
 =?utf-8?B?MEVIRXF6dzdCaVRTeXJHOC81TWNRdnNIVy9ZbEZPWVc3b0xVZTNrRkpFY3ov?=
 =?utf-8?B?dUlrMEwvR1puMHI4NjVRNndpdHdqS2QxZEZpbTJ3cEZkRnNPNWp5dlRPck9O?=
 =?utf-8?B?dTBVZmVJRmdPRHR6K2R6cmV1bXZualRmOVBKbjg0ZitidTN5b0dkZFhFbUxl?=
 =?utf-8?B?T1J2QWlOL2IyZTUxVHNpWXhSd0FJcEdTWUFiS1ExY3FYRmNTdE9NR3hlanR0?=
 =?utf-8?B?UytHRW5CVVNVaHhCN2crUHR3SzdTZXd0RkdqMytCRkhtQVJxWmluY3REQm5W?=
 =?utf-8?B?R2hCQkIzSk5xcEtTbVhRMDd0MGlENE1ER1hRUE81VUwzSEJaaDRsN2pmZXBK?=
 =?utf-8?B?ZHJ5OFNUNUxvaGJWMTl2RTdFdmFFV0RPeHQrZmpoclVJdDlhYnFuc3B4ZUYz?=
 =?utf-8?B?ZVBFWUlNd3lQSkpYSEhBMFVOMDIvVjZMTHVmcXVTMGpuOTBBWExrWG5VbzJ1?=
 =?utf-8?B?MDM0aE9GdUFFSXd4VFgwbDE1OE1SUmxHN1dUVkdNUFMwNFVQdnUyazV0dU1j?=
 =?utf-8?B?ZTlvZkgyYlFYZ0tLMUZ5WEx5SWtFWTV2NlRWbHJLSzlaa1hhSEszanU2SlpJ?=
 =?utf-8?B?d3AyWTY2eDBBNlVsS01pb291N0ZTM0FvbWNRSG5QcDJjRzFGRjNQZWVxbmov?=
 =?utf-8?B?bUNKS3NUOGJra3ozN0M3ZVp4TGtIZ0wzWXBQRkovSjhLc0pDSWZzOFJYVm9l?=
 =?utf-8?B?QmVhVnpwQTlTWEQ4cTMvRHQxSmFEbzUxYXRoRStTUXRpQVBGUFlWT29jcFY5?=
 =?utf-8?B?QW9lM1ZJMkJYZEg3VkNpSmNKL2JGZ05TRlNpd2NNWEIwREZTWSt3M1orYXdS?=
 =?utf-8?B?bmJGQmx0eHdSUTV4TW9mUi84RXBlMFNPSVF3Rk5ad0VYekNscmpQTTdJV0Nn?=
 =?utf-8?B?RUliSGpDK0FXTUIzTjJZWTIzT3YyZ2ZLekJCUkgxZkg2dmNoa1ZsNWhSNUw1?=
 =?utf-8?B?cC9CelZsY2NMN3ByeE9VSkRZR3Z2b2c0RGtBaEtTbTlKOGc5Y1BLUEVELzdV?=
 =?utf-8?B?eERxMURCR1o3ZkVrRVUwRm1pek93VUxtMUlKUXJmZUUra2dWbHU5OGttS3Y3?=
 =?utf-8?B?T3NRTjZuYmhScjBtV1J0a3JtMFRaNUFjRnIvTkVnVW5jTDVFNlFIaWdhWU9y?=
 =?utf-8?B?bTNiaitGVmtVTnhMMzlES2hlbHJwS0tRdUpGY0J5bnlsWWtpTUZWc0w4S3BL?=
 =?utf-8?B?T3BVVEM5Zk14L28xa0FHVUNyR09iS1pDSWVLVGRWVlBndG0vQnNXaytHUzRj?=
 =?utf-8?B?dTBySCtaL2dIVDhwWmgrT1o1YkZVOFh4Nzk3Sk1yZzBkcjgyY2NoUUUxdmtG?=
 =?utf-8?B?RXl1ZnRvRjZRUzJxOU03SWZFT2l3bE9rU2lrVmtrZWdtbTh2QVhac0h6SE1z?=
 =?utf-8?B?b2hZVGo1ZXdPTzYyZ1FiRXFOdWRtRndyOUlLNzNzYis1Q2t5TWZRajJ2cUVo?=
 =?utf-8?B?NVlYY2NMWkFldnlrTVRJcS84bExmWkFCdlFobFNLcHorSzdPNVYwbUZVbWZq?=
 =?utf-8?B?cVNlMlpmbWw5Q0xiYWdJaGNhbVhlbXlGY3VtNmhZa3dXVlRyNC83UUt2dzdK?=
 =?utf-8?B?bVVhTWZnTzlrMHloVXNmd2cxTG5mUlpobmlDWXBUKzQzSUt4ejBYVFppQWZu?=
 =?utf-8?B?REZka2E1a3pGOG9rR09OZWNjRWZjaE85YjlWVWRmdElsZGlzOFludEpqWGVI?=
 =?utf-8?Q?DOzR+qDxQfTkEteHuzcCsvEKE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a644a80-8d54-45fb-3a85-08dcf1e761c8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 15:45:26.2442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ChLOMTjXIkXrKNYuYVUuQ/6YYVRq8Z92E6rr/ZaTPeg28yF+f/CLYla+beBOHtBxfv+gCvyyCF43gx7nQDShpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9058

Replace the hardcoded value 2, which indicates 2 bits for I3C address
status, with the predefined macro I3C_ADDR_SLOT_STATUS_BITS.

Improve maintainability and extensibility of the code.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v6 to v8
- none

Change from v5 to v6
- fix version, should start from v5
- add Miquel's review tag

Change from v3 to v4
- rename to I3C_ADDR_SLOT_STATUS_BITS
---
 drivers/i3c/master.c       | 4 ++--
 include/linux/i3c/master.h | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 6f3eb710a75d6..dcf8d23c5941a 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -348,7 +348,7 @@ static enum i3c_addr_slot_status
 i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
 {
 	unsigned long status;
-	int bitpos = addr * 2;
+	int bitpos = addr * I3C_ADDR_SLOT_STATUS_BITS;
 
 	if (addr > I2C_MAX_ADDR)
 		return I3C_ADDR_SLOT_RSVD;
@@ -362,7 +362,7 @@ i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
 static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
 					 enum i3c_addr_slot_status status)
 {
-	int bitpos = addr * 2;
+	int bitpos = addr * I3C_ADDR_SLOT_STATUS_BITS;
 	unsigned long *ptr;
 
 	if (addr > I2C_MAX_ADDR)
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 2a1ed05d5782a..2100547b2d8d2 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -313,6 +313,8 @@ enum i3c_addr_slot_status {
 	I3C_ADDR_SLOT_STATUS_MASK = 3,
 };
 
+#define I3C_ADDR_SLOT_STATUS_BITS 2
+
 /**
  * struct i3c_bus - I3C bus object
  * @cur_master: I3C master currently driving the bus. Since I3C is multi-master
@@ -354,7 +356,7 @@ enum i3c_addr_slot_status {
 struct i3c_bus {
 	struct i3c_dev_desc *cur_master;
 	int id;
-	unsigned long addrslots[((I2C_MAX_ADDR + 1) * 2) / BITS_PER_LONG];
+	unsigned long addrslots[((I2C_MAX_ADDR + 1) * I3C_ADDR_SLOT_STATUS_BITS) / BITS_PER_LONG];
 	enum i3c_bus_mode mode;
 	struct {
 		unsigned long i3c;

-- 
2.34.1


