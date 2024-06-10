Return-Path: <linux-kernel+bounces-208874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C368902A1F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9091F24862
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A32A14F9F0;
	Mon, 10 Jun 2024 20:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PPrOvMkW"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157B614F9EC;
	Mon, 10 Jun 2024 20:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052421; cv=fail; b=gBjz+H9vwrWwGmfKiPWk98yUGjXbCjDEh3Hpb8SV7HzOYFgHMCR2dJ9YW/SnM5m//zrDJEhrm7VgpAWesMN8ekEuuSdnsl3G1u4IG+7eygd05hjGnacSBWP30NkhnX1MPRYIv1BLThvdby9AXNYsq13TC968dE/afBVaURhbZ9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052421; c=relaxed/simple;
	bh=CtkKNHUAo2fAzwGqCbTf9SwseCYd1w8VFFilR35ifTc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oJLHamwbPeZde09Gbi5ktWqvVMPcTcdanKrk0ch4oqmflymbKm+CK/Nz+aNATwU1kcaViWjoPpCmDexnqJ8RKrpI3zBhk27RRS0eKXq2eJRz23vG90GfO+8iwdKiOsjW+K85Rs+cejd4cyfDTS3It7vQQGKwQhUWOsLBGg/AWOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PPrOvMkW; arc=fail smtp.client-ip=40.107.22.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFKKSSCttb0FK9Ek53mHsqsaQ4zoJdLu/sy7qsfuUDVwIUSej+woyCVfb1eXSIbfEhwVkS98BPCH5sJ95KCz4MYSdwGsluVugaJuKO97ZbMED2PgZBh7UmednTF4K7fcGzOgPa2AH4H0WmKc2IxNV5aq8N00i5RISzLt4Ap8TSmcDJskwsj1zmIKlr/GX+4vGAZ1sIE4gJ3NnJBPfmxfnPFqOZ52sLzTJDcyg4hycxoMCFtLpvcdujH/VDNiRmKzrbGssKpayiP2lNa2YcYsiRVJIXtfSGrf2cVI4lXqggLuGoyU47i3dwmZR1H7My1Zi5c25vEFeVfIfZ/mpbTVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KELo4iICDdoq75xZlnxNbKYIHquYeUyms8sM9HSKKKs=;
 b=WbNXYOmM7fmpU6IcmuaQ8LES1RtyThc57lOnzveE9xfrIW/eu1acz1nHNerz3w3FKgtMWEFaesNMauutBHRlWgQFHnOG4Y2P5wri1bqqQre93KEeYCTX9jnV3fqqeOIqmKE7cl2MOdZK3tZb/jasQfUa3WOpVRFMUCN93l6gUh+/f+3Iq83dT/JdMU88OmoSdCvlH6vn9GHaUUM8QcddvUVZVkdPsrAk7lXJoVtmDzHpGu0wzjIqSTB3uBAL3+1R/CwOy0upTWY0v+hEmm1PUafKDL3VR8ac3C6OSzaslU6/DQVGVkzdOVfLjfOjxrSBauEnOCITIP0TxdKMddaTfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KELo4iICDdoq75xZlnxNbKYIHquYeUyms8sM9HSKKKs=;
 b=PPrOvMkW2+HtGR9kCvKDh74R2pbY8/CFsecd+PpG/jgObN/tZYHYSpOCOLzb8b8mtFsFELETxtUAOn3I75pRCbDqmalfZofwPcqI7oHgLNkVg9utdPHaTUUef8VDkpzK/6P1T68cxLL6Lw/EZlAgOj4/JFxw236+HhgtXvyNKmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9376.eurprd04.prod.outlook.com (2603:10a6:102:2b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 20:46:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 20:46:55 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 10 Jun 2024 16:46:23 -0400
Subject: [PATCH v2 6/9] arm64: dts: imx8qm-mek: add pwm and i2c in lvds
 subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-imx8qm-dts-usb-v2-6-788417116fb1@nxp.com>
References: <20240610-imx8qm-dts-usb-v2-0-788417116fb1@nxp.com>
In-Reply-To: <20240610-imx8qm-dts-usb-v2-0-788417116fb1@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718052391; l=2711;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=CtkKNHUAo2fAzwGqCbTf9SwseCYd1w8VFFilR35ifTc=;
 b=YqPFi70GU+jIChl7P1uqQM0qNddAZs8wDg3lVTUdW6wNASEhiuQASp9rtmLF7hCZs+VxkZxqb
 sDlFolW/1F3ACtmGOvxIrB26e5WrplHwqFjdr35OErmLYXJLzAJ+uRZ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR06CA0059.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9376:EE_
X-MS-Office365-Filtering-Correlation-Id: 30e1a6b0-821f-4732-d6d9-08dc898e76ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|1800799015|52116005|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVRhZ0xkSVpYMnE2YnBXVThSaXozeU5hTjNZTVE1dGRSeXpoMVdwbCtVeFM1?=
 =?utf-8?B?QVpHbEhtelpSQ2FDRyt0bmVjV3JEVEVjL2ZhdkNMdi80ci83TnBZZ1hvblJq?=
 =?utf-8?B?Y1VXVStPWUdSaCtkWG9mSnZJeGFCbTdFckJKV3ordTJoalZvVjRLNWtpZVBY?=
 =?utf-8?B?ZWg0MlhrUEFreWZuekgzTXZ4dk40TWZOV1dwTmFYYnRTRGU1UmhiY2wyMVFM?=
 =?utf-8?B?b1E1REt1SENzOHplYk9ZT1dSVis5VGlBL05peXh3bStMU0JVYU1GSGtQNzJa?=
 =?utf-8?B?OE9CRUZEMklIdjhzbFcwTmVnNWVhYkhqNmN5YndEYVFmNTA0OGUvR1kxSkNS?=
 =?utf-8?B?Y1UyTEp0U1d1OFpRaTJ4Q1FjbWpxVGpEeVlNUHo0UDVzVlRjTDQ1QmJ3Vy9G?=
 =?utf-8?B?U0lPNXpiMXVwenJmLzI5T0xnM2tXTWMrVU13R2xZMElRbmdaOHNoZE8vNnZ0?=
 =?utf-8?B?TUxkQU13TU1mOS85RWZ5enY2cGhadGZEbzZHYVYvNVNoM25GZ2duTHgwbitU?=
 =?utf-8?B?WWhPU1V1dnkxeklBcmtBWGIrMDFrNWZDMWRpVjRWWCtNR2ZJb2xZZzlrejhR?=
 =?utf-8?B?dXk4VFIxS1FhZlVRU2F3dGhtWGkrN2ZXQWFzbnVmSEZMTDMrVDc0bVBtYVFX?=
 =?utf-8?B?WGgzZ3RpN2ZCYTR0UEZ3czdiRi9iV1VvN0VJZFU1UVRLYTJlQURtbk9jNWRT?=
 =?utf-8?B?TXlkR1lmTzJEeXF3K3pwU2xBV3RkbnpTa2JtZnk5TzRQby9JUDdPak1CYVQ3?=
 =?utf-8?B?ejdhUXR0SyttYUNwU1R5WFM3aGVpRFlwMGtmeTByTGpKMFR6WnhuTTJMMjh2?=
 =?utf-8?B?c3hCN2c5bHNmd1V2VTNORGRRdzY1d2hUK3lxeTcvdXVndHF1U2ZUK2VEV3kw?=
 =?utf-8?B?U2diUGhnN21yTFRtNnhGVXJGa2RHSmhjaUtlZ0RKMFRvYk9jekpMYUJMbXQv?=
 =?utf-8?B?dFRKYzk2RkZ0aTZhaDZrTzcvWk5pYmdDaittSHBRRzdDYkZvTHhjaFdtYVh1?=
 =?utf-8?B?bDIrU2pKVmFPVnVqcENxWml1bGM1NmpKMW5tbzVuN0VVa2J3a3liMWxYT0NC?=
 =?utf-8?B?WXJZS2dWNXB6a1RaL1ZkQytQSWdhbGVwaENDNlg5UHFxTFlYeThEMmlPdGFj?=
 =?utf-8?B?MGJVVG9RNmJuKzVVRnp0eGJjZnhKQ2dOY2d1LzFzc3d1T2NqY2ozNmszVjZo?=
 =?utf-8?B?TWJaeTM1NEtlenp5THBHdHFxbHN1S0thVytMT2lwc0w3eFlUVmE2RThyTzNE?=
 =?utf-8?B?SGhjMlFYc3JsblJmV1V1OVFoUGdtNlUrOGVYaGpZUEVWRDM3YjRaWmtEbjYw?=
 =?utf-8?B?YW1SeExLc1JoME9Gdk9qRDFqOWNWa3AydENTOG9JY1RDbXVWR1lwT3YzUTNi?=
 =?utf-8?B?UkhSV2J4bGNoSjBjTlYwSTRVMUFxL3RtSnAwVEYxSzhyWGxmUTV0ZVpUUG1z?=
 =?utf-8?B?MFFVa0NDdHBSK05SWXBUUlNjdjE3bTRocjh2c3BhanBvMXlpNG9mOG5XWFZO?=
 =?utf-8?B?blFpYzVzM2UwK2NPVUg4amxMU0ZIdzJZYWtmSzZDclpDVmJid1VRb3lLbE5n?=
 =?utf-8?B?S3JuRVpBelNJamZFUHprVUxVNElDa0VBSWg2bDQzVDVtTGNwTVF2dk5FQnZv?=
 =?utf-8?B?TW5yVGg2T255NzlOQ0VLaDFHWG1kVDVLNXYyK2ZXdTZhcmdTNU9PYVAvZnRl?=
 =?utf-8?B?TFlZaVI4cHl3YXBLU3BSVTJzNk1QR2RzRm5wWnRGZytGTXBkZUgxVnJiVnYv?=
 =?utf-8?B?ZzE1ekV1Y0NvWnhWZXJGRnUrRzd4K2ZUWEFTV3JZcUNIQjdZYTRWQ0VYZkRI?=
 =?utf-8?Q?9rQ029OHkBCU09erEOOz4UB/iwGUc0b/jzuk8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlRBNTZnSWpmWUtjcThHM3pGRkxMTXAydS9kQ1gxT3ozZFdRM2tJYXVSRFVI?=
 =?utf-8?B?SXVQTWFIemg5bTExRjlYUVhYb0Q5aWxUOFQ0L3NTekdiZWwzNHZneGdpRDVX?=
 =?utf-8?B?ZUl3eXdtYnU4clZmSlJEa3d5cm9USDJZMnR0ME1sWTdaNkRTcy9hZFN3V0tU?=
 =?utf-8?B?aWttNXZ5MVJreWVLNzFncy93NjRYK0Rpd3hveCsrcUNhcGdQcE5pSmdUV1dx?=
 =?utf-8?B?OUMvdktKYVNOZEEyR1RDRm9DVE9jWmdTNFY5Ti9HTjVzeS82MlE1cWw2Nitm?=
 =?utf-8?B?dXRIWnJHckVpVHc2bEtnQTlDTWpsalhFbVIrcWdWNlBtV2VKVUEvMG85dGpQ?=
 =?utf-8?B?cFQwUGVRN3g0N2UvL2dOb2sxcTU5RGxvcjZaZE1SRFRkSTBzcDM3QzNwMTF5?=
 =?utf-8?B?VC8vaFFGUm1GMllwR3lYLzE0ZUtmcExQWUdvOUxOUXc4d3hTdUlBN3p6cFNm?=
 =?utf-8?B?WVYyd2VYTktUOVV4ekM2MU5EdFhPYjgvNzUzVmhnTnRSZnhjU3RaWGw3R3ds?=
 =?utf-8?B?d1gxRTBYVEhTQWIxSjBlelZraEhQUWtSZStGeEMrWlFXSXdoQ09sdUQrLzBh?=
 =?utf-8?B?TFNGakNwdWY3dXo1aERsMHphd01LVDNYN1VwbjJDU3BYL1hVeE0rMHIrQ0NG?=
 =?utf-8?B?N3JGYTFhZkd6elVNaWNKNWVpeG9Velc5RzhZTExFZkQ1d0wxUitrS200RnFx?=
 =?utf-8?B?VmJSR3hvL08rcS92VitqcjJRSUNGZXRDcGRNaGx6SzdLTU45eFhrcnJQWE1u?=
 =?utf-8?B?N1puOEZiNFdPU0Nxa2xtT1FDazlUbVBoRjVRN3pIR0V3cnBaODlRQ0Z4SXJS?=
 =?utf-8?B?QWg3bmxjRnRNMVkyRk9tb0hVajNWOFB0cllqblBzQkp0TERmcmJUOVVqdk9Z?=
 =?utf-8?B?TVh1T2s3anJ5dVBIOEtGbUZIMndEOEkxOENNTVVIU24vSXk3d0ZvMmxiYXhh?=
 =?utf-8?B?aENBZ0ZobkhuMWR1WDc1dDdKVDlvNWpPT2VjcE50eXRiMWR3ZHhRcHVESVdp?=
 =?utf-8?B?azh1c1FnRy9zVmxmZlhrWTdHVkFGc0EyTEIzVzBOeFcvdjljUUF5d1FLKzNG?=
 =?utf-8?B?VWdaa24rcDJwQ3p4NjRWU0FYaXc5aks5WjhFQ2k3Q2ZYbUlVb3Jqck1RVHFy?=
 =?utf-8?B?UFdUb09yZlhZM2tqTEJKV3g2Q015QXJFY3RCaXMwRzhmeFYvVzFSK3NJd2VD?=
 =?utf-8?B?UlB2U2xhYTE1Lzk3L3RlNzN2Y2NTYlZEckM2eXZWZUpqZENZTnI4djdwTFhB?=
 =?utf-8?B?T3RnMzZKa00zVEZiVHF6QlRBcmYvTHppd1RYMWFZcDdKWWROVk04WWpRNVBO?=
 =?utf-8?B?dlAySmpNaFYrMkdlOGZnREozekxmcmlhSUs0dGVycnF2U2FzRi93TE5nWC9u?=
 =?utf-8?B?dVlxYTdZam9tUENpcDI1NGR2WDhnQkMrQmY2WjA0VWl6eWFGSENGNW1BdkVh?=
 =?utf-8?B?RUJZWW1uSGFjK3B5SmRXMHhPald2Z1dESEJDUmxNL01BSWpYb1dqbXFuSU8r?=
 =?utf-8?B?VWNwN0x0dGRsVlhlNXgvTFA4Yy9rcVUrTHplVE1CQjNVTy92OU5nVTJjMzlN?=
 =?utf-8?B?Ym4wTldVMzZNNjFKaW9pZ0hQR2ZUc0hKTEZENHB4L29KZTd5OWFLQk13ek9w?=
 =?utf-8?B?ejNPZmlaWUZaaEFsbzhLU2xOcW5HUmJYWFFKWW9jN2NiQUQxcXFtYmtuU2li?=
 =?utf-8?B?N3JzVEtCMzJtV080NE5rUTVyWThPTUJDaXdYUHMwQUU2OW5uY2lySkxaOGYz?=
 =?utf-8?B?T0NLengyMGJYVk82N0wvTElwdUlmTmgyWFd3L040eUNuVk5DUnVxT3JGa3FN?=
 =?utf-8?B?U0ExZFl5b3VNeHpEV3gvd05nRldKWk8wcTJGTUpHS3AxSzBITlF4SmltUUtS?=
 =?utf-8?B?a2NjdFc1TVJGTld6dHJiV3IvbmZRK1BLVG9iTEhtRzN2QWkvWk51WXJ1Nnkz?=
 =?utf-8?B?cDMxZHZ3U2NDWW04K0cza3pZYmxCVjRuQWxadDY2ZHk5ZStleEVObHRTNFBN?=
 =?utf-8?B?M3dlS2k2ZU9XNWY1MUhadC9ncUpPaHhwMTRuNGh2SDRXNFVSbEpoVzZMcDhu?=
 =?utf-8?B?WkFVZ1MycS94M0ZWNmVCb2Z6RXJCZEdVdWpzVjlIYkozaHByWU5HempnRHhX?=
 =?utf-8?Q?ON1o=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e1a6b0-821f-4732-d6d9-08dc898e76ef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 20:46:55.4267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5hETZfgLrMnyo/4FDrl2FNZiwKBmRdMaJW/L0Vf2xEP0IOggWk1ZDjQqE8wRsxVU3Lborg/+4cbxQuqMIGdZbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9376

Add pwm[0,1] and i2c[0,1] in lvds subsystem.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 68 ++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index dbd478af2e474..3cf39c868e752 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -93,6 +93,22 @@ rsc_table1: memory@901ff000 {
 		};
 	};
 
+	lvds_backlight0: backlight-lvds0 {
+		compatible = "pwm-backlight";
+		pwms = <&qm_pwm_lvds0 0 100000 0>;
+		brightness-levels = <0 100>;
+		num-interpolated-steps = <100>;
+		default-brightness-level = <80>;
+	};
+
+	lvds_backlight1: backlight-lvds1 {
+		compatible = "pwm-backlight";
+		pwms = <&pwm_lvds1 0 100000 0>;
+		brightness-levels = <0 100>;
+		num-interpolated-steps = <100>;
+		default-brightness-level = <80>;
+	};
+
 	reg_usdhc2_vmmc: usdhc2-vmmc {
 		compatible = "regulator-fixed";
 		regulator-name = "SD1_SPWR";
@@ -334,6 +350,20 @@ wm8960: audio-codec@1a {
 	};
 };
 
+&i2c1_lvds0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lvds0_lpi2c1>;
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
+&i2c1_lvds1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lvds1_lpi2c1>;
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
 &flexcan1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan1>;
@@ -449,6 +479,18 @@ &fec2 {
 	status = "okay";
 };
 
+&qm_pwm_lvds0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm_lvds0>;
+	status = "okay";
+};
+
+&pwm_lvds1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm_lvds1>;
+	status = "okay";
+};
+
 &usdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1>;
@@ -675,6 +717,32 @@ IMX8QM_M41_GPIO0_01_DMA_UART3_TX			0x06000020
 		>;
 	};
 
+	pinctrl_lvds0_lpi2c1: lvds0lpi2c1grp {
+		fsl,pins = <
+			IMX8QM_LVDS0_I2C1_SCL_LVDS0_I2C1_SCL	0xc600004c
+			IMX8QM_LVDS0_I2C1_SDA_LVDS0_I2C1_SDA	0xc600004c
+		>;
+	};
+
+	pinctrl_lvds1_lpi2c1: lvds1lpi2c1grp {
+		fsl,pins = <
+			IMX8QM_LVDS1_I2C1_SCL_LVDS1_I2C1_SCL	0xc600004c
+			IMX8QM_LVDS1_I2C1_SDA_LVDS1_I2C1_SDA	0xc600004c
+		>;
+	};
+
+	pinctrl_pwm_lvds0: pwmlvds0grp {
+		fsl,pins = <
+			IMX8QM_LVDS0_GPIO00_LVDS0_PWM0_OUT		0x00000020
+		>;
+	};
+
+	pinctrl_pwm_lvds1: pwmlvds1grp {
+		fsl,pins = <
+			IMX8QM_LVDS1_GPIO00_LVDS1_PWM0_OUT		0x00000020
+		>;
+	};
+
 	pinctrl_sai0: sai0grp {
 		fsl,pins = <
 			IMX8QM_SPI0_CS1_AUD_SAI0_TXC				0x0600004c

-- 
2.34.1


