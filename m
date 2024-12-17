Return-Path: <linux-kernel+bounces-448840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2229F464D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC74516BC6E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5B21DDA21;
	Tue, 17 Dec 2024 08:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BgJzU8W+"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A792842AA1;
	Tue, 17 Dec 2024 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425051; cv=fail; b=E3awfhsKmW8AleDk09qjxqhbnYMeLOYreihC1anTBCKMxRMnI4CoIeKqmURGTVFiUsaeG9j6p+MzKMOZW/NUkKYRFBF6LWWwe45H5ernox7KGRjASLLGj3BXVha3SadPMHaLhcJsvaC6BZCatGEdteEajyBfL+GtINXY96Hr2jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425051; c=relaxed/simple;
	bh=xOeObexZiq2L0BioifYbNzNyx8BBXR1C21SApHfttWM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=TlnO1sopHuqHXC1ie+z8/Dbfwn7qZMWodIysK5ppE24wa8U2CxM0Br6Q1K1SF/aE7v4NDenZqdLvfx53WSgEth02HuaFvCJUo9fv8aAlgxLXocT5pLUcRfsLYMbeUQbSOnb67ThIPSWdz+ACYIn0UktGOoqlHdCfU0aOfWA9vZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BgJzU8W+; arc=fail smtp.client-ip=40.107.21.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1Wz6OPFBbc1unRqA2iGoEkO9a4wvlQ55F5JJilakdyBG/jSGGa6KNh91Sdqi5w9ipHRLS9fWXXIjH9EIvlSzyfuJkygjQhyf3bouur590/CyQNe6MBs5XgtV7UphulQFFa1Vhm6hJFon46dI8R8o63yVNNUmLcZNxAzM59qeX6ii13jZZfp7fsCGZS0A8OL3p4rCk23sbefWqEPdQYFcaO2Hz0PXgmMg+Bl3kX8lFYWhmeuoH4+LMtYraEyGV+peyXTEMcu031qX1HG5QE/kKCZEqysjIzzQmyLM7qR59UVU2eI7gPCFu0ORGRordRkfKijzRyXSSf+M/G2wys5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQk5B3qgmwvPgezO5g9YOx8GgZGniQwM4ZQE3x9P1Uc=;
 b=viSr9cJUJ4itdwFddXjnH+MQAk7B/+Tq1okTfxxdKzN2jHmv2u/do/syTMYDexK2+FNZxQiWx9DSJHKjCrfHp1/DprZ05UbiTqJsDBwGfCZuplvKrFBLpFmhPGI/m7QPbSATWfxhqsFXxKR8slyGqO3WAvrjBl6b+4KSr9GoAS9IchURPa5aHMEkK7QHCsxBN5wu6bMZ1e0R71S1kUGWnnG92KZSdV8PZLPh3NG2iYETD28JkZn0pmX69myXxP7s5EFgV3QhOfOIwJ/XyGNCD2CcOFLhNKoIpjZmCpL0n1D+au+/GqZ9N7a2f3kLcT5MCbTXFDpRn1Lo1PRM3hcAIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQk5B3qgmwvPgezO5g9YOx8GgZGniQwM4ZQE3x9P1Uc=;
 b=BgJzU8W+VHU1cNbuNG5m0LKBl4A8hjuc76CaITZTxGmuo+t+oRmNqUAekR+Ygm441F2wueCZ5phf0EGOIbyrVxlCpEFL3tWFRPk2/P+yaXmNGXuWOZYZce7VM95pE7dH28Mr4dDInwX04QbiZTQw5B6TDDKktKTVb74rt6Re11aJ43Y2OIKS+LVE6X46CmKoCWX3sYEQp9feJ4HyCgAEdNeTVdavSR+ydAciYqErPuaDfKVlKgq19vp7blF7iXXO9dvzCagiw6HEEPIspOon/RnBY8VuEBgWsTbEhLscdZLg3VQkXsbeBTPshTkuMUwvPRFnNg5XuyLXj2r4oNBeJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB11054.eurprd04.prod.outlook.com (2603:10a6:10:581::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 08:44:06 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 08:44:05 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/2] Make i.MX9 OCOTP work as accessing controller
Date: Tue, 17 Dec 2024 16:43:35 +0800
Message-Id: <20241217-imx-ocotp-v2-0-3faa6cbff41b@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALc5YWcC/23MQQ7CIBCF4as0sxbDIJrqqvcwXQCCnUWBQEMwD
 XcXu3b5v7x8O2SbyGZ4DDskWyhT8D3EaQCzKP+2jF69QXAhUaBgtFYWTNgiM9q6C5coubtC/8d
 kHdXDes69F8pbSJ+DLvhb/ykFGWd4H7Xmyo03xSdf49mEFebW2hds1M0VoAAAAA==
X-Change-ID: 20241212-imx-ocotp-cbef304140f5
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734425027; l=1840;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=xOeObexZiq2L0BioifYbNzNyx8BBXR1C21SApHfttWM=;
 b=jrfUuin5rfBkfCKGiVomkLZdJ8mcgMKFDewcelV9SH66BmA0SUHQQ6aFZTBnIag8/Z/v07/NH
 038BcsTV6lxDsPExq/MQlBHuW2uPmsPw3m+Pde0KvGsZp6chnUI09PG
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0101.apcprd02.prod.outlook.com
 (2603:1096:4:92::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB11054:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a50ae8-6c93-4112-2ee5-08dd1e76f6f4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnlIYk94U0lENEVwczhpWFd5Smp1T0pyeVhoc3cvbjA3SFhJQnhCVlZtWVhz?=
 =?utf-8?B?U2xhWUV4Rjg5dm4rR2RjZ21Xa3NtL1B0RjVyQVB0MmwwWXEvMEZQMVp2WEs1?=
 =?utf-8?B?NjFQQ242QVFXd24vNW9JYzlkSGdPaTc5L2EwVHhWRFJsdnBxcXlQT2VydzR6?=
 =?utf-8?B?MGZDTDZlN2NPcUg0a0Zpa1l0OTUyL1NNYjVobXdtTlpiajBHK3JUWEN2Rktj?=
 =?utf-8?B?QksyVXBiK1NCMmgyOHhpTkR1WUFpZTg0Z2dGR2ZPTVU4ZEtIcTM0MWtWakc1?=
 =?utf-8?B?VzMyU3FlZTlMNEw4cEYwU01DSURWc25QL3U0QUxGUFJRWWpTN2hDL3pmblEz?=
 =?utf-8?B?ZTNWMVIzd0NHN2NLTlRuRVVnWlJKOVllK2I1L3hXYlJacFpxUDJ2TDcrN09j?=
 =?utf-8?B?ekJtRGJJVDU2Y28wSU15OE1DNERQMmFOZ2xoS0F3SUpZMC9UTWFtM2U3WnpJ?=
 =?utf-8?B?bzI3VjYrclZ5OEtZSVZUQzg2cUJLaCtzMDFCRHVZclJNOVd0NWZ6NHRLRVJY?=
 =?utf-8?B?UkFTK1hNaVdab0N2TGcyNzFMVFJDV2ZPSVVzdSttdGtQNWFLbHVDYTJqdUtx?=
 =?utf-8?B?SkdGWnhkOGR2eGJwQ3BzcmJjV1dQKzZFVkd5Vlc1SlpUMmtob0dVeUFGbjFu?=
 =?utf-8?B?ZnVtdVN4RDJVeWE5dFY0NU13MjlaenhGMFBNM1diTTZzUjU2aGxJUGlCNWFr?=
 =?utf-8?B?cExGZmlTMDduL29ncG5DU25aK2EwMGZRRjBuZ1NHV0dNcG43NjJxOE1QYlJ1?=
 =?utf-8?B?dHA0OU4xM3Y2TkhGSllWL1NRZ2NxM0Evb2J0ZW5oaktNSldpTUpMSEJBcG9w?=
 =?utf-8?B?V3RqMG93Nlpza0RFNThjWnRqbXd2bnVPUnZSSU42MnZuNGhpeHdsZks5MTlz?=
 =?utf-8?B?aDFsTjA3ZFVHOUhXWnpsSGl5QlluQ0RCTWxqTFBDWnhyRHZNR2FTRmM3WU5t?=
 =?utf-8?B?T1MrUGpVTkg1ZzJMTkpnSDdUZEV3Q2NWdFhwZjlEclZ4MUZVN3dlYjVkT0VE?=
 =?utf-8?B?eU5uV2F3OGt6NnlSTnZxbVk0aG1kUDhOSUJVOG5SQ0VwWkNKck9zVFJpNVpw?=
 =?utf-8?B?OXpIejJKRzdSZlhXeEdxcURndUN6aFduTmlIUlZUY2FRSG9aREtlaEdQdmNN?=
 =?utf-8?B?RWtXMXdrWFl2cnBGWUYyTEdGdWh3Lyt0Z21hUk14VmV3dHVwU29VaFFweUJj?=
 =?utf-8?B?T2UrTGJWSkpiSjdEYzV6Nm9FVU8rUlJlSjNWdkNCMUJDdndHNW9kMGVpVWk0?=
 =?utf-8?B?YllhVmxmb2w4cG9zUXJ6VHNENWYyR0lPQzlGTllBSCt6R3RsOWpSaHFEUmx4?=
 =?utf-8?B?a2FBeUNnTExGTmFlU2xxc1pwMUgzQWhudFc5N3FyczNVRS91OGt2Z1NIeWRU?=
 =?utf-8?B?VTdDM2IyVUFTQzFDS1RYcDB3RVZ2MU43UzdnaldyaHA0dGtUdUw1QmdiV25I?=
 =?utf-8?B?TjNwQVlEUVpPOXBVaEEwS2NiRGhwUjEwNUQwQ2ZGSVYyR3F6WnV4UDBtUUFX?=
 =?utf-8?B?ZkprRmdZeGsrdVZiWU5za08xRkRZNnp3SVdyNnJiY0gvaGhkZ3E1WWxRRytq?=
 =?utf-8?B?SjdlMWE5MWtYYy9KRHZUWWlramJTMUNQZVF3VC9GQng3MHdMa0l6ejJ5TG5n?=
 =?utf-8?B?UzZJNEdMRmNHa25UQ05aanFOSVdaSTdQTS8rSHNSVi9JVm1yK09xQzVGUlBR?=
 =?utf-8?B?ZnQ3VWgxTmtEWWg3RE9PU0xaeFU2bFVMK3owUVR4SDJhNFBJUGlTZlgyY3oy?=
 =?utf-8?B?eUh2eWg1NThmUjlMejNVbld5b2Vma0xLMnFiTnRRMnhTT2F5NzBVdVJ6MnY1?=
 =?utf-8?B?L3MyN3dtYllFYkhVTG5UeXlQaVdUM0xQejR4Qk85T1M2OHBzcUo4R3ZqVnR3?=
 =?utf-8?B?YWp0TzdoWkFGOUFoQ3c5WjVKMTMrZnpvWkYzaENGM0huTHBoTGJlcUt4Kzg0?=
 =?utf-8?Q?PP/epG9PpCAXYfS3tS27EoGL8WlwYz1r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MENKNzJXWEpFRWpBQWF4MmJuQVFwM25pLzVQVW8zUWlKVlNyZDE5d2JBNy8v?=
 =?utf-8?B?QjcyTzFYcWFPVVpXa1daYkZicUhTdmxxZkFNZjI3M1pyY1R0QitHb0pObThk?=
 =?utf-8?B?azZSKzdTQW93Y1JOZDFIYndOQWZ6bTNycDJLdktYZVJmaVFCRk9FN044eUJU?=
 =?utf-8?B?TStPbGRVbTFtMTYvYk9icWhlSHZidmVyek5teWxCK3FCRE0rSERmTmFPaVY5?=
 =?utf-8?B?VzNLeVJZTTNIOXczZXdWamJQMmJVdFpvT3NaUy8zTnBuSVpCbTZVL0VNVTcx?=
 =?utf-8?B?Skk4eEpYNld4TFpEeTU3akVXOGhQd3ZkeGluQ3pFYUlCblBxazdGL2hBWGxF?=
 =?utf-8?B?ODVIb2MzMWZKM0d3MTZuOFNHL2JRSDJ1T3p4NE12dmVVbytLZUNHWUI1RUxV?=
 =?utf-8?B?UTVLcFgraC9FV3J0N3daaFFBeG1zNnU1U1hjUTdIVUtRYkE0TnV2eDZPb0Rn?=
 =?utf-8?B?WGVuUlYzUVJEb2EyM2pnb0RXTnh4U2QyUmpOYkVkV2k5Z1BTaHpFTythdFVR?=
 =?utf-8?B?ZDdtekVtaVhyLzRIYWhPdmJOTDVNcjVRNFEzWmpJUnpFcTFqZkREdUJKVisv?=
 =?utf-8?B?UWZCdDB4U09uMnA5aHdyVnZXTVZ0TW9nYVJFaExoZkpUN2g1cVJ3QVFWYXVp?=
 =?utf-8?B?aEpHM1FDM0t4S29iaS9yNFl0L2ptMENtVjJ2Q2xFNy8yeUt6UkVnM2VSMTQ4?=
 =?utf-8?B?UW0wb2UwN0VUWXJuK2hFbzRKY2hLK2pQZXdhZURsTm12VVF4WkNlNVNPdmth?=
 =?utf-8?B?Mm5Fdkg5MW5xMkFEK2FOeFA2SEtFMkMrbkRNWHN6bUVrYWgxRmxubkdEVUl4?=
 =?utf-8?B?MGZTanR1Zk5tOGZ6VE0yaUJUblEyU1B1MnhLaHZsd3h6TXJoNnQvL2oxWnRT?=
 =?utf-8?B?WSt2L1pveXhUVnFjdzZUdEpjL0oxT1dZeThUZisxdGVmaEtzQThPaWhnZ3Y3?=
 =?utf-8?B?dnRibW80ODJ6YkNsNVB3MzBIcHNDVnVvSjZRM1NBUTVRWHJSdHJxazF6dHE1?=
 =?utf-8?B?MUxLNDhXMXprbTd5bHVwdlpjZkRqb1gwdmlkWU5xSGJmZlJVb1V1MHIrWUJS?=
 =?utf-8?B?YjJQZkRJUEViamhBWHFnMXdIcmtkNDBhVFN6WFdMMXB4azMrb2FZaTE0d0Ur?=
 =?utf-8?B?a1l4N2xxZE55cnNYYVhnTEtHM2NkMUFsSlE5cktML28zenJWY3NZSW5MTDl5?=
 =?utf-8?B?SGEycmczUHF4RU1TbUpLcU4vMUJ1NTl6N24yTTN4eUZBSE1DemlyZG9JaTcz?=
 =?utf-8?B?c0Q3OVJBemdML0MrZ3VMRUMyZWdkYXZBYmIvNU5zeExKVUdjU2Zxa0xidmRy?=
 =?utf-8?B?ckhuYllYclJ0OHJuRnBJaDBqc0hxZ01XWFptSW9RT3NTYW52K0hVS3hjd0tZ?=
 =?utf-8?B?bFRKNmRRL3BCOHdScXMwTTUwSmxyWEtPZnBsWWxTd1h4bUQwcjBFWFRoOVpC?=
 =?utf-8?B?cUMvY1dlQmk3Q2RnRzMrSlRvZFo3Lzd2S2o5aUQwM0FoWGp6M1lwcHEreHEw?=
 =?utf-8?B?aG8renlON0c5aFo0cmhaZVJDNFVlTUZLZWNudDVlaEF1aVRvM0pWdTZjRmhu?=
 =?utf-8?B?RFBwcGFpUUErWHBiNlJDbzBNcDYvL2FTeGF3c0NEVDJvZDlIUWl6d3BhRUdH?=
 =?utf-8?B?WDFSaTI2bExLZHZ6WEVNVVpZV0RrMFJTVDZxaTJrR1RKNkJjUkc4aCtHREZE?=
 =?utf-8?B?MUFXZElkMGxuRzh4RzVDVWVOM0I1dUMxNmE4UVEyNVp0VmtuUDN3anduTndB?=
 =?utf-8?B?OS9QWW5Yb0FMei8wREltVW45YUFCRjA2K1lHSWJSb2dpVzlpRnlPMlpqTkhw?=
 =?utf-8?B?MEpZNmRId1NocVpqUXJHRmIrMnpXRm5GNGgrV1hnTzZYdWJoWXZZcko4VWVV?=
 =?utf-8?B?YVQvdnZmNlRYQ0t0ZUN0cWR0b0hVeU5QRHNwdXBVaVdxUjVWZlpXQWRJRkxv?=
 =?utf-8?B?Y05wVnEyVkI0WlErbWhQYXg3Q2NoUnlQb0JibFBBaDVKQUljcG1OWHJuYU9P?=
 =?utf-8?B?c2pxUmtpT284RDJsVVBQWWNFNm43VE9jWnNHV3Q3dTF1V05ta1o1OG91ZG1O?=
 =?utf-8?B?UU84TkJ0M05iV0RSeVZVVkFmT21ub2hHT2ZnT2lveEgwazFwK1F1Q2o4aEYw?=
 =?utf-8?Q?hrCAIqpVDGVstJvg0wox6h5Ix?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a50ae8-6c93-4112-2ee5-08dd1e76f6f4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 08:44:05.6173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6jo/GYhYAJqM5YHuD6j/6cEgcZZ+AjxIwZLBFzW/EOztRzNZgPE0XSby87ywS4yx+QiLXb8uPclf3algoYZGNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11054

Previously there was discussion on using "feature-controller" or
adding a specific node to group the fuse information for U-Boot to
parse and update node. But rejected by DT maintainer(Rob).

Since the STM32 engineers added access controller concept and landed
the support in Linux Kernel, reuse the concept for i.MX.

i.MX OCOTP eFuse has some bits to indicate a specific periphral or
function is avaiable for current chip, for example i.MX93 has variants
that not have NPU. So introduce '#access-controller-cells' for OCOTP,
and add "#access-controllers = <&ocotp [gate_index]>" for periphrals
that needs accessing control checking.

In OCOTP driver, the nodes under "/" will be iterated, and checked
if property "#access-controllers" exsits. If not allow access, detach
the node.

In the end, cpu nodes should still be handled by bootloader.
And I may also update i.MX8M to use same method to support variants
if this patchset is good.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Add R-b for patch 1
- Use '/' root node instead of '/soc' or '/soc@0' for patch 2
- Link to v1: https://lore.kernel.org/r/20241212-imx-ocotp-v1-0-198bb0af86a0@nxp.com

---
Peng Fan (2):
      dt-bindings: nvmem: imx-ocotp: Introduce #access-controller-cells
      nvmem: imx-ocotp-ele: Support accessing controller for i.MX9

 .../devicetree/bindings/nvmem/imx-ocotp.yaml       |   5 +
 drivers/nvmem/imx-ocotp-ele.c                      | 184 ++++++++++++++++++++-
 include/dt-bindings/nvmem/fsl,imx93-ocotp.h        |  24 +++
 include/dt-bindings/nvmem/fsl,imx95-ocotp.h        |  43 +++++
 4 files changed, 255 insertions(+), 1 deletion(-)
---
base-commit: d49bc7ced87506bedbcce1ca7782ff942b309f2d
change-id: 20241212-imx-ocotp-cbef304140f5

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


