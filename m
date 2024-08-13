Return-Path: <linux-kernel+bounces-284101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D1994FCE7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A586E1F21D08
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482332C87A;
	Tue, 13 Aug 2024 04:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HU6jtbaB"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A0323741;
	Tue, 13 Aug 2024 04:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523766; cv=fail; b=JkmYGRjUmPvGX4uyELgb19VeZIUXg1po46a7oNpX0Z8rz9osCSzLiNz6Z0fVj+ZOKfwpju+cGLzjdHh72WWt53AdjQNY8x04QwInDtvSv/DmjfYMLP8xsNDN8EN4vAXSxh80GfflPkspBNu2j2U0AE7hUct/u9C9Mtb/uyFFw/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523766; c=relaxed/simple;
	bh=DFnzYZQ2LpxQhM+wUU0IN6vzE+9cHON6yMRUQw212GQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=LcobwBrDq4NY5JHHzBBN2YetOyS6oxEtYOOLEKmWAu7ACWLXx1hLfB5WeFrnhZ4ycIPKQsGOk40uDEwcygzGUdq7uKaWMHvUWBMldUu3hFBptEv4LPB9aktC9dWmDD06VP36+ftnVZGJxHIzmCZepDxHp8pp0RQHhssVbJoPPQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HU6jtbaB; arc=fail smtp.client-ip=40.107.104.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evMI3HWL9RyXKBvtBS4w0ol6ftI1z7AvE/LAUrb1suoxMACc1wNdukd8sO2QeCWj9ogduhr6D+ZOSDTQlrt8exKV+GohgBrcP/1rKtrxPmpF1wcLj6o7RTDUseb9MZwKpvBt1LHSAzEwQRo0Zq4MWKJHOXmhCW4X9n9JilBf/nvZ6b/2zM/IPLUOpdsl1Ve8UVJgr/po6jwh6wzxzcTkib0hC369lZ2mpalDqzSKBhV/cjcclbQ2B92pG3OaEN78/3Is5yFzt0VURShV36UssHpuF/9fol24I2VNrc3DhAJUNopcAKRvRORcjJsVS9wlX44AcJKGDIWls4dcq3NofA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0afN2LPICL18TrWBB9UPgYL9/sbs4IALA3OVU540ew=;
 b=TQI1nrHGT21NH0dQAdaJQixTAjlhnv/W0hmTRFx0wyULLFhzGIxxKEJ8yLcK8nAl8m314A/wfe75ZtA1VpW+wuHElLRLbHQz9q7PR8Ak2xF/8qDNgAbzplcX98gixswkLdr2hCX9P/1vOFUew4WcovgVO7OVGI87yfksqWcTapeYecnzu0fRxhJ7SqNnINeI+ihZFXjn5dZXLaN7f7fVa3+SEeo29oCy4605SRVpPzD9Dqd37c3CPhIZfQ9SzVYzLGRVTMVZEkTh0j9sjknakEaMmA+svO4Y2TzsUzqTylRubr08RyA5smWoKrnD49tyla1TsEhc8FM75uQU1hhksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0afN2LPICL18TrWBB9UPgYL9/sbs4IALA3OVU540ew=;
 b=HU6jtbaBv2n/4ZIFphXoyJP1utk10v0qfqP05wagU4W7HNadG/Vm7noI73XnTPL0VBLoeq/y82s3Fb0LWQwyJiDoE/2xOyUVAsb0ZZRRefFbS93K9EXbntRy5FTp5YgqNCw3O25npmBaNckMPq19rZ7/GHuX4r8QWSCUeauCkIHR0uKRjlYv1zx6kUq2Aa41dptfEyIKDadM8zCuKtiu+y2knE8zu41ehY8h/1IUVx3I5mGwZrYYVfETPpDCDwC44dG81ftfLRiGX+BZ+LMPjbm2+5/NW4jH4e+NIxaTgQLf3bW5pi/mXacnf/0meOhzKyH/Vt05vS1EXIIRGkWPtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB10066.eurprd04.prod.outlook.com (2603:10a6:10:4c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 04:36:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 04:36:01 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Aug 2024 00:35:09 -0400
Subject: [PATCH 14/17] arm64: dts: s32v234: remove fallback compatible
 string arm,cortex-a9-gic
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-imx_warning-v1-14-3494426aea09@nxp.com>
References: <20240813-imx_warning-v1-0-3494426aea09@nxp.com>
In-Reply-To: <20240813-imx_warning-v1-0-3494426aea09@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux@ew.tq-group.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723523705; l=1495;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=DFnzYZQ2LpxQhM+wUU0IN6vzE+9cHON6yMRUQw212GQ=;
 b=ESAHbveOL9iEcj/Oe3nduy6ib/FJq394/LC5wSvtlKeaCwq3ma0CBcAAmaMz+c55WgjZ49gvS
 YlzXcwPGPyYDtlruDtmaKvw1hr0UcXdMAkdO9VjQqS+XiqAhtKfO+67
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:217::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB10066:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c4fd2e7-1124-4696-e000-08dcbb516f6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVNQRHNCWUN2Z09nZFNucUx4cWYxVGNGV0sxSnVhS1ZERWRWb1p6akZJcGkx?=
 =?utf-8?B?ckhxNXFHaGxGQmsxbUkyV1QvZWpvLzYxYjM2cWR5VTVjNXZWMXBudENDeDMy?=
 =?utf-8?B?M0tMeTVSNXl4TjFnN3k0MnBQR0JlOUhWeDNHbVNoMmwwckZubVprd2lNSnFl?=
 =?utf-8?B?S1VjcldTbGdzcFlucE9FU0l0MFJCWTZ2TlR5WXk2Z2NNc0l0ZXZoakdFS0lJ?=
 =?utf-8?B?RDQyK1VraTdkYTZobm9reElSWnIycVdoZWd6K3lCQjZodDlQM1J4ZjU4NFpM?=
 =?utf-8?B?MllIc2FkVysza25pTUtMWE9uUmtIOWpQNCt0VGUvUFB3YVhZWjBLWThiMU0x?=
 =?utf-8?B?Sis3U0o5QTBpQ3BOTHk3ekJwZE1DMjdrQnU2U1laWWVtOEw4NElndEVmN0pj?=
 =?utf-8?B?cEsvdExFSk1zb2Z1bk4yUFFRaEErN0VDbXF6NFFMRVo0QmNXdzQyZmhCQWoz?=
 =?utf-8?B?WXVJb2hoaE1SYmFpbmxmYmh2di85aFdXZHI2VENvdmxnVThPQllYMGkxbDZV?=
 =?utf-8?B?dU91NGtGOXl3VzNPdHlTcHVVVDFJUEFFQU9DZWZZZVR5djkvTXZubjd5OXJr?=
 =?utf-8?B?ekkzcndBOThMOTdKVUpsQUN0L0dVR0dTTkJaZVRTSDdBZVF0Zzh4S1NtOTUr?=
 =?utf-8?B?b2RsVTF1VlMvM2FVaUc0K1hwOWVlOFRmekc4bTdKclhweSsvTkxmSldVVU1h?=
 =?utf-8?B?NnhlY081aGl1SkZFeTUvZzE5MlRXL2VqZmkvcm1nVExVenA2RVlKZDVJMkFM?=
 =?utf-8?B?OE4yejFXZVcxaDhiTUgrUjg1QUhKOXBsOE54VElxanRvZ05rZERycjZ1WWxv?=
 =?utf-8?B?RklNaVIvRjBPbklGOCttTGI1T2RGU1h3R1NYUmcrSEpQc2dDY3pUd3pFMElQ?=
 =?utf-8?B?dlJPeDhyblhXVXBEYjVyOWZqTG5xRUVDR2l5ak5wcUxuajl6bWJHM3dtcTFW?=
 =?utf-8?B?S0l5UWx0a2Z0WkF6dFh2azNiWmhrZTkzTjRMdmhXVm0wUld6R0pLT1BCMkFS?=
 =?utf-8?B?R2pzSTR1eXpOZFRqNHNRUnpyUVUxSk1XMVpEUDBLTUtNMVVNcDdBeHliYXdr?=
 =?utf-8?B?MnhPMGZoRHdSL0RRQ2Exa1c0NUlVYlJPOHdrSzZNZDI1dnNQdXJpVWF4Vjkr?=
 =?utf-8?B?Qk5JZiszQlU3akhPSEh1RndkY2pCbk11VGR6SXVrcGY2K3R1NlhjMkxLa09V?=
 =?utf-8?B?MW9MSm9ienlNY0JyK0M3NDJDV01ZMkFFbmJTb0krOGdjenh0Tkx2ZXpQYTRl?=
 =?utf-8?B?VmY1YTJqOEpLbVNvdUJEQ1dUdHBRS2I3ZkZXckJRdWtlbUJDWVEza2dxbTEy?=
 =?utf-8?B?cGtkamhJVHdBYnBHN1BjY2MwdS8zRC9INmU5ZTNnOUpQeUo0TjZMSXR5THht?=
 =?utf-8?B?TE1sT1NZb2RxSXg5R1VKcDJmRzNuVDN3Z2VEeFN2MzJyRGpJdXFCajRaQVhp?=
 =?utf-8?B?Q2pSTXhZLzVRTlVkQzFXc1NRNXB5UlpPSkkwR1N5T1VEcnFIVDErQ2ZyWEU5?=
 =?utf-8?B?TzRBZldJZFdUbGVxb0xnbmx1KzhncTh6ckd6Y0dsRFJHejFoNkxxd3BuN2Yz?=
 =?utf-8?B?UDFVMDVXc0xObjV6YWtCUWxUZjJud00xdlNSWStxcWR5akFtbXVqbWFWNmJV?=
 =?utf-8?B?QmsxOFByK3JmMCszMmtIZjc0WGZzZjlzSy9zRFhKYVJ5ajVWSHlUN3VTaEF6?=
 =?utf-8?B?TWZjNUdtanFKY2pGd0E3Y01pNk9CWXBFSEVaMHNuY24rbEpSWTJ3cG5pNVJq?=
 =?utf-8?B?azR4ajE2WFU2azVGQ0dVa0o0ZFhKMXk5dTIzd2twcGJZU3ROTytXNXZkak9k?=
 =?utf-8?B?SWlPaUNJU0VUNTZuZ0x6UVpLamJCRkJsRE5EUjJPVVM2UHFVUlE0K21kOW1v?=
 =?utf-8?B?Z3pEeDFOYXl1a2VCVytEd0FMZzJrcC9FeFBKOFI3NnI0R2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3hkMVNLU3FUaUhnV0JHV1Y0YjA3dEVGUHZXbzRYUnB0cEVCUzRlUkR0WDAw?=
 =?utf-8?B?UzB5YjZuaWl5Z3k0OUNJbHpVeDg4bjJwSXA3TkMwMlJBMUVzb2tyWWpab1RV?=
 =?utf-8?B?QUlScVBPSHJqalFDSUMzZEFUdEJPNDBzU2NRSEFvZHo0Z083S3FUMThURldM?=
 =?utf-8?B?OW1rcEpNcEp3c3plbUJVbHpONElNeW10b2J0L1FZVmJwUGRqcmhXOEQ3cC90?=
 =?utf-8?B?N3daQkZmWnpuV0R1VTU0Qk4waUhhTTNVbHR2OFc3N0xVUzNtUHJpaFY5Nnkv?=
 =?utf-8?B?cXdPMzJuTzJKa0VSN1ZxL3ZjYit3ZUxaSWFaRVR4bWR2R3hWNTRITW9FTk5i?=
 =?utf-8?B?cGNwN1VicHNDSlFHVmk4aDBqUTRNS0d6RU9JS1VzSm40Z0oyQ0tkdHNKSktE?=
 =?utf-8?B?WTV5MFNNejZ1QnFMYVRXc3pQSlNHWEt0OGJTdkNDZi95QnNBaUdjZmg0UEcy?=
 =?utf-8?B?V3F2K0NTMm1MNDZUVzFJMFdNVS9hb3JXMG9OMHAzK0FGNDZGVHM1MWlaa0Nr?=
 =?utf-8?B?WVd1Tm40Tm95Qkl3TEhXVFo5QllpTnIvU210ekY2eFIvbXFEOVZKRERUT3B4?=
 =?utf-8?B?djVEcjBQUXlaVENBM3Q4RXQyclZENmovQnJ1ZHZoVWo2ZE8yOTBCM1E5bVZu?=
 =?utf-8?B?SGszRlBpMXVoT0pQQ0FVS3RBNDZJNnhiTXNza1VFZzhhMFlZZ0NpZlM3MU5s?=
 =?utf-8?B?Ui8yKy80VGpaYmtQWUR2VUt5Mld3dGpBNTVqWUJSN1dacGdRWFMrMWFTTHVX?=
 =?utf-8?B?MWgrUmNOTm15T2REVlI4ekkrdkhDZU5Mc3NYMmhiTnZzdkZZRW80N0YzN1Qv?=
 =?utf-8?B?MkZiY3pKTDU4OXdjV1FuTlJUU2tIR0YrMXlzSVpKbU05aXIyNXhvZGdKRTly?=
 =?utf-8?B?TEJrdUM3UTE0Vyttb3NmWWV6WTNGSUltSDhUZlcvMFBoS0RoaVR1dkZNYnJm?=
 =?utf-8?B?dG5QUFFHM1BEMFlNMk91K3hnMlpBd1Y4L3pHYVZrRzZUTHFIM2tIdHl5eFkw?=
 =?utf-8?B?bzFGLzhiNi9BTzdYbG1tYkg5cFBuSXBhNXNWTUY0NGo5cTZHQXVLWkxIVGlQ?=
 =?utf-8?B?U1FwclFQbjVFakhTUDFYelQwZXVmUWxTZHd5N2RiaDRyT1ZmY3dJYjBBSUUr?=
 =?utf-8?B?dGUremJhbDRwKzB1QzQwZHlWUzNidG41b3BpV2NJL25aTDRBaS9qNktjcXNZ?=
 =?utf-8?B?NTB3c094aVpVaWxxeXBTZjFmMUtIazFHeXdJdzRKYU9zSGlHc0ttNm1rZ2Jp?=
 =?utf-8?B?VFFYSXNYcFM2dzd2cVcvVG9mZllyMktyVUpqZ0pyM3gzMWZ4Z2VZQnYrcW1T?=
 =?utf-8?B?ZnIzU2tPanp0VCtKa2lpeWNuZ2NoSjZXVHJnY2tBU2xEa2FRczhIckpjWnVI?=
 =?utf-8?B?SEFUR3kvOUE1UTlLMUY0clJyNS9pc1pwcUJzVW5BQzgvbUR3ZHFrZmFaTzJG?=
 =?utf-8?B?T2NKZmFHWFVOMEEzZWttTm5KK29qbkhYRlorbjJsRnJWNmVRcmlUeSt3REhD?=
 =?utf-8?B?MUk0ZHAxMXhQSGxaa04xM01Idm9ERlk0S0cxTnJCeHVwWndOMlBBMGtUenFx?=
 =?utf-8?B?NVB0dEEyUFVBK3k5a0VlbHhzbllmc3dnZnpWdWVMc1RIdmV2Mi93SnhtdXJr?=
 =?utf-8?B?RnNUcjFIL3BTOTBxK0h3ZmRKenZpRDAzV0RPeWtHTmFVOTJXT2lYVWxmSTZP?=
 =?utf-8?B?dDBZNFBLMUdRM21iRGs5Y3hsN1ZpSWJ4R0xvV1RMdzY1a2RzLzV4U1VLRmhQ?=
 =?utf-8?B?Uk9yZDFhSXZXZXp5R0kzdEtDV2tVb3UzRjBqajEyRnNOb1N2NmRtUXBicnhw?=
 =?utf-8?B?bWxDbUdldkQ1R2ZkaG80clVBamFrOFp1b1MwY012RnhnWnVuZE85WVVBNW9n?=
 =?utf-8?B?SDZMZ1pRenZ0Yjdhek1LdmpZUXVYcm4xWUsvSEFFVitKdUVUUVQ5RGE5QzNx?=
 =?utf-8?B?VS8yVUF4YVpJc3FzcXk0dHVrWEJUcHZoMnRZS1RCc2x6T2dVVE5KdWFKNHp1?=
 =?utf-8?B?bjJ5VmQwRGZjTHg2WDNEYlRyVlBRVDZQOWZlZW5Pc0sxbE9rNmd4M21Mcm5I?=
 =?utf-8?B?eXI2WjdaUDFyS2xpeVp2aUxnRTNxV0JDUWg1bnNhSjFwSytRZkN5Z2ZESFhV?=
 =?utf-8?Q?0uoPmzAYZVLx8sDcNbasBiIMm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4fd2e7-1124-4696-e000-08dcbb516f6d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 04:36:01.6851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GaycihHNnsHv7hLurfsZHQprkl0eZcFLaqW3DhAl+cDpaWW2+G5aU4zvsJfX8KG0wZFHkJF7gOtsPd02AxgPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10066

Remove fallback comaptible string arm,cortex-a9-gic to fix below warning:

/home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/s32v234-evb.dtb: interrupt-controller@7d001000: compatible: 'oneOf' conditional failed, one must be fixed:
            ['arm,cortex-a15-gic', 'arm,cortex-a9-gic'] is too long
            /home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/s32v234-evb.dtb: interrupt-controller@7d001000: compatible: 'oneOf' conditional failed, one must be fixed:
                    ['arm,cortex-a15-gic', 'arm,cortex-a9-gic'] is too long
                    'nvidia,tegra210-agic' was expected
                    'arm,cortex-a15-gic' is not one of ['nvidia,tegra186-agic', 'nvidia,tegra194-agic', 'nvidia,tegra234-agic']
            'arm,gic-400' was expected

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/s32v234.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/s32v234.dtsi b/arch/arm64/boot/dts/freescale/s32v234.dtsi
index 42409ec567925..bf608ded5dda6 100644
--- a/arch/arm64/boot/dts/freescale/s32v234.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32v234.dtsi
@@ -89,7 +89,7 @@ IRQ_TYPE_LEVEL_LOW)>,
 	};
 
 	gic: interrupt-controller@7d001000 {
-		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
+		compatible = "arm,cortex-a15-gic";
 		#interrupt-cells = <3>;
 		#address-cells = <0>;
 		interrupt-controller;

-- 
2.34.1


