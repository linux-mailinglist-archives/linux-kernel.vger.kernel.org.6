Return-Path: <linux-kernel+bounces-519996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2D7A3A47B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381651752AA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C33F270ED9;
	Tue, 18 Feb 2025 17:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M1Ef3ybV"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013024.outbound.protection.outlook.com [52.101.67.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CF2270EA9;
	Tue, 18 Feb 2025 17:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739900347; cv=fail; b=erxBk5f2JtomhLK/W21jsm3VeYnXeBpp8CfLs/3GMWis6iKQvmf85O7tLvl1xITJko5NeG1v9RHck03/V45oqpQjPCYCe4AWk6ztkY4XxAiUUxAG2f9IJ89jgqumSFKuKoawPSO8vUZ2ECH35MDvqggSXk9HYgmemGsr5EowifI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739900347; c=relaxed/simple;
	bh=QVWkJ+1VaelOfMcj7f1HTsLdsgzQpNiFBMk1wCBIBAY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XMhWv1sheZio1Wx92y4UmEbD6Z4R923Q108ustifN3NeY6eSdNGsM8VUkOQkveVRm7bmZ4Fx+fsZExt4RKUBf6huNu5w30cISvnFgJZdZ88PEVxNy+L0UuOsYfQ9Xp6IKCKO2wc6amLUjUPcu35cn5xwGmhtNv9CC2XgGvMvYgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M1Ef3ybV; arc=fail smtp.client-ip=52.101.67.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqFtO+LbBnWVKE6PHwMc/MOp0CAtAQjlButdWkRf84oKn4rpEkxQLts5d2EXbaP1KAf2xAg9cXbPIgCNVllID5QaCh4n44tF1USBGLQ1IeuO+PgGwsziViLOigCV/03xq6GfzMt0KczuS427FxhQ0ipPGnBurffgCzD2AMob7J9P1FEnt+6c7TGC39n+WVQaSyeneaLs1V4oLiWJq4K4iuVJN0WD/7oqA2JODJfeu1Gs2R9Pimh8T62EGqZ+9/MeG74cU9NML30Fwh/OnR1DVNlLMz19WRTW6tmhdyYxR+pt9fFyK99b6i6RIDYSOM4neNpCHw/Co0goJbtnMd7D0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ajQCMyACPgXG0K6J4inKJJeLM/orrc4E5tWyMR/iQg=;
 b=Is5sGYKpcykFD1TfGtWJMcQZ+duMIYMeejRoUTK9au3HqKkLHFxk0UWiQRWx05n4oTgvDz3NUr0AaENeR1DBfCQwG04qMItmRXFJD5VyWWn5KbYXZqm/Bb0e98LX7dZGZ1uXuGncYcL19agm7Q/84kLlozuGM87sAILbUKio1O1yfPk7Dt4cb+mP/e+0yrAtA8B0NZ4aT84EUXfbMF9HYg1MpgYRUJBtsBUh/4Rwss4JI4S9FKiaLDid0xGpixXyLlQ90vJL2o60fVSH0IT97NL4qMNsfBR+Mmy/tEPWO6YzZ5XJsWGn3KA40FOBAodizwrZf7RJXjYF9JMs+sy9yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ajQCMyACPgXG0K6J4inKJJeLM/orrc4E5tWyMR/iQg=;
 b=M1Ef3ybVilWAJnWz2BFPsNAWfKklLt2x7IJThKYgIQ4Cyi+W7qlnU28v0XOgPDJOUO1Ex8RqOdHS0n4n9gIHxewxNDgg1EC2scKnlOeAzojFtocrsfe2UIO4tZ5XiM/2/UhNk1Vr4Je75aT5l5fMZ5dcQdz7Vrl+UNInaqhLVmzkZ8TcFR3mjHyUhK/KeIE6OgElo6Q+lGvvhFYRf/ziZwRJFlaCPO+cKysmFG7MyQ3fbeMjRdVq+DI1PnJN8HbtrOHrGGRQGdmw42EP65hoMdCz4dlqOUmqiGfRy2HHI/vproAvIwRQLXlx+M79+556apmmNErmPcyuPGKuotFBbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10241.eurprd04.prod.outlook.com (2603:10a6:150:1a4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 17:39:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 17:39:03 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 18 Feb 2025 12:38:40 -0500
Subject: [PATCH RESEND v4 2/2] regulator: pf9453: add PMIC PF9453 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-pf9453-v4-2-ddfd34e02da0@nxp.com>
References: <20250218-pf9453-v4-0-ddfd34e02da0@nxp.com>
In-Reply-To: <20250218-pf9453-v4-0-ddfd34e02da0@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739900333; l=27805;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1gV5jQRL1V15KauOyqWRLmnaARonWTxQPskouQ9QYOs=;
 b=f4320LOWVJptUi+Td2+jjBmQ4rlAK0H0JbS1+4s/RlZnPEO5T0sNY3zPJv88TAr42/G0X5g1t
 s643HUf9ZC8B+55igXpnYEcrvPds3Cf/DD5cJdJTIWh1RakOgxgkhtV
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10241:EE_
X-MS-Office365-Filtering-Correlation-Id: 113ae46a-2672-4737-27bf-08dd5043227f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlZqRU9hS3Jtd0FpTTRjUm9zRzdjeE44QWYzbnNsWEY5bnZzNWd4b2FLcTlQ?=
 =?utf-8?B?UXB5bEYyVnVuSnlZTllMTE5yN0daNndEQmYvR0pZeEFZbkxyR1RJanUxS1Bh?=
 =?utf-8?B?cXNaZjVCK3ArTUNXR0xyZ0xGTnBzRFkrK0xjOW52WUxGcElndmRUMWhabFJq?=
 =?utf-8?B?dlNreTVFMGFjNlRUUS9TYkNoci9KcTRkZVZLNzJ1dkNBTEl0elNqeVkyRzQy?=
 =?utf-8?B?R0d6azljcG5uWndkcHNwUW5YaWdpWkdJSzlPK3BGOUMvRmlOUm4vWEJ5d2I2?=
 =?utf-8?B?RmpQQkxOQXZxSnVYTHE0R29yNFVUYmRVUDFPd1BuejFidHR4UHJiOTB4R3A2?=
 =?utf-8?B?Y2I2Yll0T1FZQzZDOEs3ZU9TOTZ4b1FYV05oR3M5QXJuS3AwYzJFNTVhOFk5?=
 =?utf-8?B?cGp2VXB2aFRheXVkakVnNCtxNVdaUjF2TEozd3ZpalVoNnlOalRMTm1TbXcw?=
 =?utf-8?B?MVBzbURZaU13SXNUM0tYdFB2OGlRbXhvMjZMeGdnNEZjUmxSOWNQK2dIMVVK?=
 =?utf-8?B?SllMYVRraWorcXhTMkJXMDVMSnJ4WlA5YWo2TFcvL0RIUGUxaFk3WUNLdVZ2?=
 =?utf-8?B?TmNyWkxTTjF4SldNSmFMZW5maENaaGRCZjZ5RE9GMmJMNjIyVGxhR1RJOElj?=
 =?utf-8?B?bDdHbVQ4UkxRcCtnT1BaR3NmenllOXllQm5jTEJ4RjBPeG5aZU05eVJXYWsv?=
 =?utf-8?B?MEx0VXFHbEVsc2E1ZmJTdHd4MlEvVzNRTVlyVlFVcTJydERhWGk5aW5CUGdM?=
 =?utf-8?B?QXFYMVREcFN2cXJNK3U0d3ZMTXNDYldEU1paMVNVWlRxNTJSMkEzbll1VWtX?=
 =?utf-8?B?QVJOUmlKa2ZVdnp6Q0xaOXlMeFdlS3d6dVFpK1hKemE3TmxON3lPZTROa0k2?=
 =?utf-8?B?S09ucEVPOWQwMmZDbk9ac2h3alpYSTkvbm9zRndsRWdPZ0Y0V3hsOEJ0ZFg0?=
 =?utf-8?B?RUxNd3VrRXlhQWlnLy9BMkhQMC9ndkx6VU9iU05qVmo1bGNQOUFyenZ1cmdP?=
 =?utf-8?B?Q3ZJY0pWUlR0WDFoVUdoYnZIakpGLzNWeWFMWTNSRGp6N2xueHlhaGdRTjk5?=
 =?utf-8?B?T25MckhCUnZKTkpBWUd6dmROZ0xPWVc4cmd0b0k1cnVIbytiUXY0VVUxODBi?=
 =?utf-8?B?aWRmblh3L1U2L1RBSWhVVE13VEFUWVYrVzdNWGR6NU8wM0d6Z1FOSnBEcmNH?=
 =?utf-8?B?QmgzVmlwNDJiK2tKUEx1N1ZqYTFEMUtodUlBU1ZrdnlOQzRrVVJiakljeVNO?=
 =?utf-8?B?T3FTSHlZSlFsakg3UjZFcStjbTZ1eEJnanc5TnJqdTVwWHU4VTNLdEQ2M2ZJ?=
 =?utf-8?B?TWc2Rk1jeThjKzkweXpzZWk3eFpmY2lzMTVOWnd6SE5jOTRXaTVIZ2hNKzNM?=
 =?utf-8?B?bWk0cENoR09QRHVWUnpHYzcraFpqWTR5Nk91L0FPRmNjK29vTm13bnIwdE4v?=
 =?utf-8?B?bHJYbjJtaTdBTURnMXg2NGdxNVFjRkFnbFJHcnh6ZDNXa2MrMU1lRXhyMFFV?=
 =?utf-8?B?OW02QU9NY2ZyU3Blck4wUWJtVG40SjhWZXY2QzI3SzJ5TFFJUkVOUzBXWjhs?=
 =?utf-8?B?TGgzTmRtWmRtbHpIVzhwbW9UWVR1M2hRRkFzNGpoTkxRR1lLSnZkL1FQeExO?=
 =?utf-8?B?aVBlOG9IS2hpOSt4WThDMmpHbXp2YUhhQnFlNk03ZlNJRGJuV1A2QmtoaFpu?=
 =?utf-8?B?NFVQQTJvV003VlBDR2xZcU9jRjJoWktNVWtQWEszR3RhTkd2bHNldGlPdVY5?=
 =?utf-8?B?aHJ2UFROeVhhejlPQkRhWi95aWFLWXRhdFYwbmhUaFlQU1pKejNZN2JLSEJa?=
 =?utf-8?B?NS9CalRseGVvOU9VSlZXY3BpR3Flb0MyKzJyVXMvaGNFbmVSc1dNVG9FcmFF?=
 =?utf-8?B?cGFMMG10a2VLWVZ2YTZvdE9PTEVuMGVIUTE5bUwwdHNJQkkxczVmUDUzdTVC?=
 =?utf-8?Q?EZ4oXPBWt7t0LfTOE0hUFvbsEoDfEbyk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmNkUFNycm5Day9ERHZ6b0ZLNFQvcUw2MjVjaHI3dUhyOG5ieDRpMWtlU3ZF?=
 =?utf-8?B?ejRKV0pRVUpNRG02cDBnVXYvQWZZU2ZlaWtrVkg1S09lcklFVkhDRFpKc0xz?=
 =?utf-8?B?ZWpTdUJ1YWtnMUFXeDZBMlhzUEc4RWphbVVYa2FCMm9qSFJJL2RqV0QxL05k?=
 =?utf-8?B?YVkwVDBmYW1GcDg5WkZteFJmY1dGTUdhaHBacWxENEx4bkNyNnQ0UDFVVXJR?=
 =?utf-8?B?RU5ZMVR0OWJEaW03SjRmRHdlVVpGVEVpTDFxRTBDV1dwNENiUVNDajRGRnRn?=
 =?utf-8?B?NXg5UTdGaFNtaVRuTWZYRjVYeDVBZU5EWm9XaUtFL1lpekVQSk05VGhwdW1o?=
 =?utf-8?B?Y1J1SmxtQXc1eHRITi9Xb1ZyZDRLSm95MUVUU2c3Wmc3bUwvS1VvMGtLVW00?=
 =?utf-8?B?NEFLZkZQVmQ5elU0aEdwazN4b0N2YjBhYVBHNEdkOU9jZHppVzdYMHp6SFYz?=
 =?utf-8?B?RVQwb2tqSTlVWDZQUnVjWHp6RkxHYndiMmtUdWxFVm94SXphWXNFUlNKVnlK?=
 =?utf-8?B?RzQ0MzhHVmhKOUlhSHd6eWU2RWVyUHZrWDg1Rk5FKzF1ZFZlNEpZcUxFN0d3?=
 =?utf-8?B?RlpEOVkzZVdRamRRbkU4R2dCQzE2ekFlVG1xMTU3VU1EMENNVUM2TWRmVUpp?=
 =?utf-8?B?Uzgvc3AvRHU1amI3b0t2blIwV1lEUytqNzRjTEpodTgxZGZDeTBpOGpPSEZ4?=
 =?utf-8?B?T3lEV0Ntb1Q5QWN3VCtQOXAwUUszU00vUHgvUXlkbVJVQnQ3YnQ5WWl4QTFa?=
 =?utf-8?B?RXNac3hMTDNHY2FPdEpuQTNRN0xUejN5d1ZuaWpiYTVFRllPU3VxZUVaZlRP?=
 =?utf-8?B?ZVBmNk9aTkVMa1JtMUd0Sy9EMGI4RFhTZUJoTEp0c1ZqZXNiRDZQNjBSN3M0?=
 =?utf-8?B?NU1HV3VXTzQ5eGs1ZUs1b1ZVdXNuTEJ2YTQ4MHNKR0t0VjFtZ3EvZmxTQUhT?=
 =?utf-8?B?R2hLNlhFT25OTjExY3h2U2FQVTlUNjRWU3hJQUd0OHNBanAzVXFIYTkxR1FU?=
 =?utf-8?B?OERvTXBxbUpjVFpGUWM0QWVIUWVuRGZWY3E4ZTFMeXp1aHBlYzZlczlHZnRH?=
 =?utf-8?B?ZGRITnAzNVJRZ1lINXBJOVZTMU8raEhPVlpoZzMwUmsvdW5zRjhiMTM5aEdh?=
 =?utf-8?B?cjdiQlFPQ0YvQ3dzYUxOK1FDVS9yK3ZmV3h6K2dHdlE3Nkl3UHdoZVg4T3Vn?=
 =?utf-8?B?VWJINlg1eTBpUklTMjllMlVpdmxySFN0MlplTmUyeXdqVVIvZ0JkMCs1V1VR?=
 =?utf-8?B?Z2pjSWlZR25MeDBEZjVSVHM1aml6elJ6SFZNZGd3Q2JML2VUUk40dys3M2lS?=
 =?utf-8?B?dnFzUmFoSE5PbnRnVkI1TFZ2Y1NUeE1NQTNld2VPUjlkSEtQZ0VpQTJrWmRR?=
 =?utf-8?B?cWs2elRiUUNOV2E2emx5QlFiL290MXlVQ2RsS0FsRERXeUtxMWlDbGdZbDBn?=
 =?utf-8?B?MUxMclI5eGxBMDRneTR4TlhiSVhxQkEwdTZKU1liTENkT1MxNUFSaHJYbkxO?=
 =?utf-8?B?WGZITnE3MW55OFVmYVpFNkYzSkpZNGMrakkvMnpya2NxazF6VGdiT0dWUXlC?=
 =?utf-8?B?WEF4SDJxZUEycVRZL3JBbHBFTUZMRHdpRy9ySzRQZmxiTDFSVTRtNDFSNnNY?=
 =?utf-8?B?WEtMeEJVRkl1TnFCbGxVdjNXZXlnL0hPblJVc0NkaTRqTGxuNm9TZGsxNzBR?=
 =?utf-8?B?Q0lXZUROSW1ackVMOHd4ZW1aNGRRMGQ2b0d0S3JyZG1wNFhvUUlJejdjOUJn?=
 =?utf-8?B?UVJDUVV6RVYwdDYzK1k4Qllmd1Y1dXZIQnpYL3ByanJvdGl6WVVuM3EyWkhB?=
 =?utf-8?B?NGVQM25KOFhjTmUvMmFIMGE0RVlGaWZqNlcrUnF5STd0eGxIb0NpNFBwczJI?=
 =?utf-8?B?ZlRxU1hSNVhCSVM5R1Z1RjBBYjV4YktKS3JhK0pobUdQSHN6QzhlR0JBOGxv?=
 =?utf-8?B?Q1ZRZFJjaENsRmswSkh5YlJKZU93MDJGdjRQMWtXTDJ5WXRuYWZoS2F2VjY3?=
 =?utf-8?B?UnpnaU9ZTE9jMWNzZytPc3c0SGJMcGNja3RvQUFpUFM4b045bXc3eXBVVEtk?=
 =?utf-8?B?VjhpU0lydUQ4aVY0Qk51a2o2VHk2QVBaemYyNENWeC9NMDBveUx1eVBxeFBT?=
 =?utf-8?Q?csUhR5XRj3KHraHgQzBZIEo/+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113ae46a-2672-4737-27bf-08dd5043227f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 17:39:03.1106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MR+pga2kxcf5Ypq3MTQZjnx7Q9zsjfzQ3D1zEanbnZFo4IVw5jOoWSPeLNoZIpDlTak9XzbnhT87er1G7cao5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10241

From: Joy Zou <joy.zou@nxp.com>

Support new PMIC PF9453, which is totally difference with PCA9450. So
create new file for it.

The PF9453 is a single chip Power Management IC (PMIC) specifically
designed for i.MX 91 processor. It provides power supply solutions for IoT
(Internet of Things), smart appliance, and portable applications where size
and efficiency are critical. The device provides four high efficiency
step-down regulators, three LDOs, one 400 mA load switch and 32.768 kHz
crystal oscillator driver.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v4
- fix GENMASK(7, 4), should be GENMASK(7, 6)

change from v2 to v3
- remove pf9453.h
- remove double space
- use low case hex value
- remove , after terminate
- use GEMASK
- change to LDO-SNVS
---
 drivers/regulator/Kconfig            |   7 +
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/pf9453-regulator.c | 879 +++++++++++++++++++++++++++++++++++
 3 files changed, 887 insertions(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 39297f7d81771..74d11ca2d9bee 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -981,6 +981,13 @@ config REGULATOR_PCA9450
 	  Say y here to support the NXP PCA9450A/PCA9450B/PCA9450C PMIC
 	  regulator driver.
 
+config REGULATOR_PF9453
+	tristate "NXP PF9453 regulator driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say y here to support the NXP PF9453 PMIC regulator driver.
+
 config REGULATOR_PCAP
 	tristate "Motorola PCAP2 regulator driver"
 	depends on EZX_PCAP
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 3d5a803dce8a0..5192f24796636 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -123,6 +123,7 @@ obj-$(CONFIG_REGULATOR_QCOM_SPMI) += qcom_spmi-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_USB_VBUS) += qcom_usb_vbus-regulator.o
 obj-$(CONFIG_REGULATOR_PALMAS) += palmas-regulator.o
 obj-$(CONFIG_REGULATOR_PCA9450) += pca9450-regulator.o
+obj-$(CONFIG_REGULATOR_PF9453) += pf9453-regulator.o
 obj-$(CONFIG_REGULATOR_PF8X00) += pf8x00-regulator.o
 obj-$(CONFIG_REGULATOR_PFUZE100) += pfuze100-regulator.o
 obj-$(CONFIG_REGULATOR_PV88060) += pv88060-regulator.o
diff --git a/drivers/regulator/pf9453-regulator.c b/drivers/regulator/pf9453-regulator.c
new file mode 100644
index 0000000000000..ed6bf0f6c4fe2
--- /dev/null
+++ b/drivers/regulator/pf9453-regulator.c
@@ -0,0 +1,879 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2024 NXP.
+ * NXP PF9453 pmic driver
+ */
+
+#include <linux/bits.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+
+struct pf9453_dvs_config {
+	unsigned int run_reg; /* dvs0 */
+	unsigned int run_mask;
+	unsigned int standby_reg; /* dvs1 */
+	unsigned int standby_mask;
+};
+
+struct pf9453_regulator_desc {
+	struct regulator_desc desc;
+	const struct pf9453_dvs_config dvs;
+};
+
+struct pf9453 {
+	struct device *dev;
+	struct regmap *regmap;
+	struct gpio_desc *sd_vsel_gpio;
+	int irq;
+};
+
+enum {
+	PF9453_BUCK1 = 0,
+	PF9453_BUCK2,
+	PF9453_BUCK3,
+	PF9453_BUCK4,
+	PF9453_LDO1,
+	PF9453_LDO2,
+	PF9453_LDOSNVS,
+	PF9453_REGULATOR_CNT
+};
+
+enum {
+	PF9453_DVS_LEVEL_RUN = 0,
+	PF9453_DVS_LEVEL_STANDBY,
+	PF9453_DVS_LEVEL_DPSTANDBY,
+	PF9453_DVS_LEVEL_MAX
+};
+
+#define PF9453_BUCK1_VOLTAGE_NUM	0x80
+#define PF9453_BUCK2_VOLTAGE_NUM	0x80
+#define PF9453_BUCK3_VOLTAGE_NUM	0x80
+#define PF9453_BUCK4_VOLTAGE_NUM	0x80
+
+#define PF9453_LDO1_VOLTAGE_NUM		0x65
+#define PF9453_LDO2_VOLTAGE_NUM		0x3b
+#define PF9453_LDOSNVS_VOLTAGE_NUM	0x59
+
+enum {
+	PF9453_REG_DEV_ID		= 0x00,
+	PF9453_REG_OTP_VER		= 0x01,
+	PF9453_REG_INT1			= 0x02,
+	PF9453_REG_INT1_MASK		= 0x03,
+	PF9453_REG_INT1_STATUS		= 0x04,
+	PF9453_REG_VRFLT1_INT		= 0x05,
+	PF9453_REG_VRFLT1_MASK		= 0x06,
+	PF9453_REG_PWRON_STAT		= 0x07,
+	PF9453_REG_RESET_CTRL		= 0x08,
+	PF9453_REG_SW_RST		= 0x09,
+	PF9453_REG_PWR_CTRL		= 0x0a,
+	PF9453_REG_CONFIG1		= 0x0b,
+	PF9453_REG_CONFIG2		= 0x0c,
+	PF9453_REG_32K_CONFIG		= 0x0d,
+	PF9453_REG_BUCK1CTRL		= 0x10,
+	PF9453_REG_BUCK1OUT		= 0x11,
+	PF9453_REG_BUCK2CTRL		= 0x14,
+	PF9453_REG_BUCK2OUT		= 0x15,
+	PF9453_REG_BUCK2OUT_STBY	= 0x1d,
+	PF9453_REG_BUCK2OUT_MAX_LIMIT	= 0x1f,
+	PF9453_REG_BUCK2OUT_MIN_LIMIT	= 0x20,
+	PF9453_REG_BUCK3CTRL		= 0x21,
+	PF9453_REG_BUCK3OUT		= 0x22,
+	PF9453_REG_BUCK4CTRL		= 0x2e,
+	PF9453_REG_BUCK4OUT		= 0x2f,
+	PF9453_REG_LDO1OUT_L		= 0x36,
+	PF9453_REG_LDO1CFG		= 0x37,
+	PF9453_REG_LDO1OUT_H		= 0x38,
+	PF9453_REG_LDOSNVS_CFG1		= 0x39,
+	PF9453_REG_LDOSNVS_CFG2		= 0x3a,
+	PF9453_REG_LDO2CFG		= 0x3b,
+	PF9453_REG_LDO2OUT		= 0x3c,
+	PF9453_REG_BUCK_POK		= 0x3d,
+	PF9453_REG_LSW_CTRL1		= 0x40,
+	PF9453_REG_LSW_CTRL2		= 0x41,
+	PF9453_REG_LOCK			= 0x4e,
+	PF9453_MAX_REG
+};
+
+#define PF9453_UNLOCK_KEY		0x5c
+#define PF9453_LOCK_KEY			0x0
+
+/* PF9453 BUCK ENMODE bits */
+#define BUCK_ENMODE_OFF			0x00
+#define BUCK_ENMODE_ONREQ		0x01
+#define BUCK_ENMODE_ONREQ_STBY		0x02
+#define BUCK_ENMODE_ONREQ_STBY_DPSTBY	0x03
+
+/* PF9453 BUCK ENMODE bits */
+#define LDO_ENMODE_OFF			0x00
+#define LDO_ENMODE_ONREQ		0x01
+#define LDO_ENMODE_ONREQ_STBY		0x02
+#define LDO_ENMODE_ONREQ_STBY_DPSTBY	0x03
+
+/* PF9453_REG_BUCK1_CTRL bits */
+#define BUCK1_LPMODE			0x30
+#define BUCK1_AD			0x08
+#define BUCK1_FPWM			0x04
+#define BUCK1_ENMODE_MASK		GENMASK(1, 0)
+
+/* PF9453_REG_BUCK2_CTRL bits */
+#define BUCK2_RAMP_MASK			GENMASK(7, 6)
+#define BUCK2_RAMP_25MV			0x0
+#define BUCK2_RAMP_12P5MV		0x1
+#define BUCK2_RAMP_6P25MV		0x2
+#define BUCK2_RAMP_3P125MV		0x3
+#define BUCK2_LPMODE			0x30
+#define BUCK2_AD			0x08
+#define BUCK2_FPWM			0x04
+#define BUCK2_ENMODE_MASK		GENMASK(1, 0)
+
+/* PF9453_REG_BUCK3_CTRL bits */
+#define BUCK3_LPMODE			0x30
+#define BUCK3_AD			0x08
+#define BUCK3_FPWM			0x04
+#define BUCK3_ENMODE_MASK		GENMASK(1, 0)
+
+/* PF9453_REG_BUCK4_CTRL bits */
+#define BUCK4_LPMODE			0x30
+#define BUCK4_AD			0x08
+#define BUCK4_FPWM			0x04
+#define BUCK4_ENMODE_MASK		GENMASK(1, 0)
+
+/* PF9453_REG_BUCK123_PRESET_EN bit */
+#define BUCK123_PRESET_EN		0x80
+
+/* PF9453_BUCK1OUT bits */
+#define BUCK1OUT_MASK			GENMASK(6, 0)
+
+/* PF9453_BUCK2OUT bits */
+#define BUCK2OUT_MASK			GENMASK(6, 0)
+#define BUCK2OUT_STBY_MASK		GENMASK(6, 0)
+
+/* PF9453_REG_BUCK3OUT bits */
+#define BUCK3OUT_MASK			GENMASK(6, 0)
+
+/* PF9453_REG_BUCK4OUT bits */
+#define BUCK4OUT_MASK			GENMASK(6, 0)
+
+/* PF9453_REG_LDO1_VOLT bits */
+#define LDO1_EN_MASK			GENMASK(1, 0)
+#define LDO1OUT_MASK			GENMASK(6, 0)
+
+/* PF9453_REG_LDO2_VOLT bits */
+#define LDO2_EN_MASK			GENMASK(1, 0)
+#define LDO2OUT_MASK			GENMASK(6, 0)
+
+/* PF9453_REG_LDOSNVS_VOLT bits */
+#define LDOSNVS_EN_MASK			GENMASK(0, 0)
+#define LDOSNVSCFG1_MASK		GENMASK(6, 0)
+
+/* PF9453_REG_IRQ bits */
+#define IRQ_RSVD			0x80
+#define IRQ_RSTB			0x40
+#define IRQ_ONKEY			0x20
+#define IRQ_RESETKEY			0x10
+#define IRQ_VR_FLT1			0x08
+#define IRQ_LOWVSYS			0x04
+#define IRQ_THERM_100			0x02
+#define IRQ_THERM_80			0x01
+
+/* PF9453_REG_RESET_CTRL bits */
+#define WDOG_B_CFG_MASK			GENMASK(7, 6)
+#define WDOG_B_CFG_NONE			0x00
+#define WDOG_B_CFG_WARM			0x40
+#define WDOG_B_CFG_COLD			0x80
+
+/* PF9453_REG_CONFIG2 bits */
+#define I2C_LT_MASK			GENMASK(1, 0)
+#define I2C_LT_FORCE_DISABLE		0x00
+#define I2C_LT_ON_STANDBY_RUN		0x01
+#define I2C_LT_ON_RUN			0x02
+#define I2C_LT_FORCE_ENABLE		0x03
+
+static const struct regmap_range pf9453_status_range = {
+	.range_min = PF9453_REG_INT1,
+	.range_max = PF9453_REG_PWRON_STAT,
+};
+
+static const struct regmap_access_table pf9453_volatile_regs = {
+	.yes_ranges = &pf9453_status_range,
+	.n_yes_ranges = 1,
+};
+
+static const struct regmap_config pf9453_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.volatile_table = &pf9453_volatile_regs,
+	.max_register = PF9453_MAX_REG - 1,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+/*
+ * BUCK2
+ * BUCK2RAM[1:0] BUCK2 DVS ramp rate setting
+ * 00: 25mV/1usec
+ * 01: 25mV/2usec
+ * 10: 25mV/4usec
+ * 11: 25mV/8usec
+ */
+static const unsigned int pf9453_dvs_buck_ramp_table[] = {
+	25000, 12500, 6250, 3125
+};
+
+static bool is_reg_protect(uint reg)
+{
+	switch (reg) {
+	case PF9453_REG_BUCK1OUT:
+	case PF9453_REG_BUCK2OUT:
+	case PF9453_REG_BUCK3OUT:
+	case PF9453_REG_BUCK4OUT:
+	case PF9453_REG_LDO1OUT_L:
+	case PF9453_REG_LDO1OUT_H:
+	case PF9453_REG_LDO2OUT:
+	case PF9453_REG_LDOSNVS_CFG1:
+	case PF9453_REG_BUCK2OUT_MAX_LIMIT:
+	case PF9453_REG_BUCK2OUT_MIN_LIMIT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int pf9453_pmic_write(struct pf9453 *pf9453, unsigned int reg, u8 mask, unsigned int val)
+{
+	int ret = -EINVAL;
+	u8 data, key;
+	u32 rxBuf;
+
+	/* If not updating entire register, perform a read-mod-write */
+	data = val;
+	key = PF9453_UNLOCK_KEY;
+
+	if (mask != 0xffU) {
+		/* Read data */
+		ret = regmap_read(pf9453->regmap, reg, &rxBuf);
+		if (ret) {
+			dev_err(pf9453->dev, "Read reg=%0x error!\n", reg);
+			return ret;
+		}
+		data = (val & mask) | (rxBuf & (~mask));
+	}
+
+	if (reg < PF9453_MAX_REG) {
+		if (is_reg_protect(reg)) {
+			ret = regmap_raw_write(pf9453->regmap, PF9453_REG_LOCK, &key, 1U);
+			if (ret) {
+				dev_err(pf9453->dev, "Write reg=%0x error!\n", reg);
+				return ret;
+			}
+
+			ret = regmap_raw_write(pf9453->regmap, reg, &data, 1U);
+			if (ret) {
+				dev_err(pf9453->dev, "Write reg=%0x error!\n", reg);
+				return ret;
+			}
+
+			key = PF9453_LOCK_KEY;
+			ret = regmap_raw_write(pf9453->regmap, PF9453_REG_LOCK, &key, 1U);
+			if (ret) {
+				dev_err(pf9453->dev, "Write reg=%0x error!\n", reg);
+				return ret;
+			}
+		} else {
+			ret = regmap_raw_write(pf9453->regmap, reg, &data, 1U);
+			if (ret) {
+				dev_err(pf9453->dev, "Write reg=%0x error!\n", reg);
+				return ret;
+			}
+		}
+	}
+
+	return ret;
+}
+
+/**
+ * pf9453_regulator_enable_regmap for regmap users
+ *
+ * @rdev: regulator to operate on
+ *
+ * Regulators that use regmap for their register I/O can set the
+ * enable_reg and enable_mask fields in their descriptor and then use
+ * this as their enable() operation, saving some code.
+ */
+static int pf9453_regulator_enable_regmap(struct regulator_dev *rdev)
+{
+	struct pf9453 *pf9453 = dev_get_drvdata(rdev->dev.parent);
+	unsigned int val;
+
+	if (rdev->desc->enable_is_inverted) {
+		val = rdev->desc->disable_val;
+	} else {
+		val = rdev->desc->enable_val;
+		if (!val)
+			val = rdev->desc->enable_mask;
+	}
+
+	return pf9453_pmic_write(pf9453, rdev->desc->enable_reg, rdev->desc->enable_mask, val);
+}
+
+/**
+ * pf9453_regulator_disable_regmap for regmap users
+ *
+ * @rdev: regulator to operate on
+ *
+ * Regulators that use regmap for their register I/O can set the
+ * enable_reg and enable_mask fields in their descriptor and then use
+ * this as their disable() operation, saving some code.
+ */
+static int pf9453_regulator_disable_regmap(struct regulator_dev *rdev)
+{
+	struct pf9453 *pf9453 = dev_get_drvdata(rdev->dev.parent);
+	unsigned int val;
+
+	if (rdev->desc->enable_is_inverted) {
+		val = rdev->desc->enable_val;
+		if (!val)
+			val = rdev->desc->enable_mask;
+	} else {
+		val = rdev->desc->disable_val;
+	}
+
+	return pf9453_pmic_write(pf9453, rdev->desc->enable_reg, rdev->desc->enable_mask, val);
+}
+
+/**
+ * pf9453_regulator_set_voltage_sel_regmap for regmap users
+ *
+ * @rdev: regulator to operate on
+ * @sel: Selector to set
+ *
+ * Regulators that use regmap for their register I/O can set the
+ * vsel_reg and vsel_mask fields in their descriptor and then use this
+ * as their set_voltage_vsel operation, saving some code.
+ */
+static int pf9453_regulator_set_voltage_sel_regmap(struct regulator_dev *rdev, unsigned int sel)
+{
+	struct pf9453 *pf9453 = dev_get_drvdata(rdev->dev.parent);
+	int ret;
+
+	sel <<= ffs(rdev->desc->vsel_mask) - 1;
+	ret = pf9453_pmic_write(pf9453, rdev->desc->vsel_reg, rdev->desc->vsel_mask, sel);
+	if (ret)
+		return ret;
+
+	if (rdev->desc->apply_bit)
+		ret = pf9453_pmic_write(pf9453, rdev->desc->apply_reg,
+					rdev->desc->apply_bit, rdev->desc->apply_bit);
+	return ret;
+}
+
+static int find_closest_bigger(unsigned int target, const unsigned int *table,
+			       unsigned int num_sel, unsigned int *sel)
+{
+	unsigned int s, tmp, max, maxsel = 0;
+	bool found = false;
+
+	max = table[0];
+
+	for (s = 0; s < num_sel; s++) {
+		if (table[s] > max) {
+			max = table[s];
+			maxsel = s;
+		}
+		if (table[s] >= target) {
+			if (!found || table[s] - target < tmp - target) {
+				tmp = table[s];
+				*sel = s;
+				found = true;
+				if (tmp == target)
+					break;
+			}
+		}
+	}
+
+	if (!found) {
+		*sel = maxsel;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * pf9453_regulator_set_ramp_delay_regmap
+ *
+ * @rdev: regulator to operate on
+ *
+ * Regulators that use regmap for their register I/O can set the ramp_reg
+ * and ramp_mask fields in their descriptor and then use this as their
+ * set_ramp_delay operation, saving some code.
+ */
+static int pf9453_regulator_set_ramp_delay_regmap(struct regulator_dev *rdev, int ramp_delay)
+{
+	struct pf9453 *pf9453 = dev_get_drvdata(rdev->dev.parent);
+	unsigned int sel;
+	int ret;
+
+	if (WARN_ON(!rdev->desc->n_ramp_values || !rdev->desc->ramp_delay_table))
+		return -EINVAL;
+
+	ret = find_closest_bigger(ramp_delay, rdev->desc->ramp_delay_table,
+				  rdev->desc->n_ramp_values, &sel);
+
+	if (ret) {
+		dev_warn(rdev_get_dev(rdev),
+			 "Can't set ramp-delay %u, setting %u\n", ramp_delay,
+			 rdev->desc->ramp_delay_table[sel]);
+	}
+
+	sel <<= ffs(rdev->desc->ramp_mask) - 1;
+
+	return pf9453_pmic_write(pf9453, rdev->desc->ramp_reg,
+				 rdev->desc->ramp_mask, sel);
+}
+
+static const struct regulator_ops pf9453_dvs_buck_regulator_ops = {
+	.enable = pf9453_regulator_enable_regmap,
+	.disable = pf9453_regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = pf9453_regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.set_ramp_delay	= pf9453_regulator_set_ramp_delay_regmap,
+};
+
+static const struct regulator_ops pf9453_buck_regulator_ops = {
+	.enable = pf9453_regulator_enable_regmap,
+	.disable = pf9453_regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = pf9453_regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+};
+
+static const struct regulator_ops pf9453_ldo_regulator_ops = {
+	.enable = pf9453_regulator_enable_regmap,
+	.disable = pf9453_regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = pf9453_regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+};
+
+/*
+ * BUCK1/3/4
+ * 0.60 to 3.775V (25mV step)
+ */
+static const struct linear_range pf9453_buck134_volts[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0x00, 0x7F, 25000),
+};
+
+/*
+ * BUCK2
+ * 0.60 to 2.1875V (12.5mV step)
+ */
+static const struct linear_range pf9453_buck2_volts[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0x00, 0x7F, 12500),
+};
+
+/*
+ * LDO1
+ * 0.8 to 3.3V (25mV step)
+ */
+static const struct linear_range pf9453_ldo1_volts[] = {
+	REGULATOR_LINEAR_RANGE(800000, 0x00, 0x64, 25000),
+};
+
+/*
+ * LDO2
+ * 0.5 to 1.95V (25mV step)
+ */
+static const struct linear_range pf9453_ldo2_volts[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0x00, 0x3A, 25000),
+};
+
+/*
+ * LDOSNVS
+ * 1.2 to 3.4V (25mV step)
+ */
+static const struct linear_range pf9453_ldosnvs_volts[] = {
+	REGULATOR_LINEAR_RANGE(1200000, 0x00, 0x58, 25000),
+};
+
+static int buck_set_dvs(const struct regulator_desc *desc,
+			struct device_node *np, struct pf9453 *pf9453,
+			char *prop, unsigned int reg, unsigned int mask)
+{
+	int ret, i;
+	u32 uv;
+
+	ret = of_property_read_u32(np, prop, &uv);
+	if (ret == -EINVAL)
+		return 0;
+	else if (ret)
+		return ret;
+
+	for (i = 0; i < desc->n_voltages; i++) {
+		ret = regulator_desc_list_voltage_linear_range(desc, i);
+		if (ret < 0)
+			continue;
+		if (ret == uv) {
+			i <<= ffs(desc->vsel_mask) - 1;
+			ret = pf9453_pmic_write(pf9453, reg, mask, i);
+			break;
+		}
+	}
+
+	if (ret == 0) {
+		struct pf9453_regulator_desc *regulator = container_of(desc,
+					struct pf9453_regulator_desc, desc);
+
+		/* Enable DVS control through PMIC_STBY_REQ for this BUCK */
+		ret = pf9453_pmic_write(pf9453, regulator->desc.enable_reg,
+					BUCK2_LPMODE, BUCK2_LPMODE);
+	}
+	return ret;
+}
+
+static int pf9453_set_dvs_levels(struct device_node *np, const struct regulator_desc *desc,
+				 struct regulator_config *cfg)
+{
+	struct pf9453_regulator_desc *data = container_of(desc, struct pf9453_regulator_desc, desc);
+	struct pf9453 *pf9453 = dev_get_drvdata(cfg->dev);
+	const struct pf9453_dvs_config *dvs = &data->dvs;
+	unsigned int reg, mask;
+	int i, ret = 0;
+	char *prop;
+
+	for (i = 0; i < PF9453_DVS_LEVEL_MAX; i++) {
+		switch (i) {
+		case PF9453_DVS_LEVEL_RUN:
+			prop = "nxp,dvs-run-voltage";
+			reg = dvs->run_reg;
+			mask = dvs->run_mask;
+			break;
+		case PF9453_DVS_LEVEL_DPSTANDBY:
+		case PF9453_DVS_LEVEL_STANDBY:
+			prop = "nxp,dvs-standby-voltage";
+			reg = dvs->standby_reg;
+			mask = dvs->standby_mask;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		ret = buck_set_dvs(desc, np, pf9453, prop, reg, mask);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static const struct pf9453_regulator_desc pf9453_regulators[] = {
+	{
+		.desc = {
+			.name = "buck1",
+			.of_match = of_match_ptr("BUCK1"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_BUCK1,
+			.ops = &pf9453_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_BUCK1_VOLTAGE_NUM,
+			.linear_ranges = pf9453_buck134_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_buck134_volts),
+			.vsel_reg = PF9453_REG_BUCK1OUT,
+			.vsel_mask = BUCK1OUT_MASK,
+			.enable_reg = PF9453_REG_BUCK1CTRL,
+			.enable_mask = BUCK1_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck2",
+			.of_match = of_match_ptr("BUCK2"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_BUCK2,
+			.ops = &pf9453_dvs_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_BUCK2_VOLTAGE_NUM,
+			.linear_ranges = pf9453_buck2_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_buck2_volts),
+			.vsel_reg = PF9453_REG_BUCK2OUT,
+			.vsel_mask = BUCK2OUT_MASK,
+			.enable_reg = PF9453_REG_BUCK2CTRL,
+			.enable_mask = BUCK2_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.ramp_reg = PF9453_REG_BUCK2CTRL,
+			.ramp_mask = BUCK2_RAMP_MASK,
+			.ramp_delay_table = pf9453_dvs_buck_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pf9453_dvs_buck_ramp_table),
+			.owner = THIS_MODULE,
+			.of_parse_cb = pf9453_set_dvs_levels,
+		},
+		.dvs = {
+			.run_reg = PF9453_REG_BUCK2OUT,
+			.run_mask = BUCK2OUT_MASK,
+			.standby_reg = PF9453_REG_BUCK2OUT_STBY,
+			.standby_mask = BUCK2OUT_STBY_MASK,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck3",
+			.of_match = of_match_ptr("BUCK3"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_BUCK3,
+			.ops = &pf9453_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_BUCK3_VOLTAGE_NUM,
+			.linear_ranges = pf9453_buck134_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_buck134_volts),
+			.vsel_reg = PF9453_REG_BUCK3OUT,
+			.vsel_mask = BUCK3OUT_MASK,
+			.enable_reg = PF9453_REG_BUCK3CTRL,
+			.enable_mask = BUCK3_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck4",
+			.of_match = of_match_ptr("BUCK4"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_BUCK4,
+			.ops = &pf9453_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_BUCK4_VOLTAGE_NUM,
+			.linear_ranges = pf9453_buck134_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_buck134_volts),
+			.vsel_reg = PF9453_REG_BUCK4OUT,
+			.vsel_mask = BUCK4OUT_MASK,
+			.enable_reg = PF9453_REG_BUCK4CTRL,
+			.enable_mask = BUCK4_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo1",
+			.of_match = of_match_ptr("LDO1"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_LDO1,
+			.ops = &pf9453_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_LDO1_VOLTAGE_NUM,
+			.linear_ranges = pf9453_ldo1_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_ldo1_volts),
+			.vsel_reg = PF9453_REG_LDO1OUT_H,
+			.vsel_mask = LDO1OUT_MASK,
+			.enable_reg = PF9453_REG_LDO1CFG,
+			.enable_mask = LDO1_EN_MASK,
+			.enable_val = LDO_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo2",
+			.of_match = of_match_ptr("LDO2"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_LDO2,
+			.ops = &pf9453_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_LDO2_VOLTAGE_NUM,
+			.linear_ranges = pf9453_ldo2_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_ldo2_volts),
+			.vsel_reg = PF9453_REG_LDO2OUT,
+			.vsel_mask = LDO2OUT_MASK,
+			.enable_reg = PF9453_REG_LDO2CFG,
+			.enable_mask = LDO2_EN_MASK,
+			.enable_val = LDO_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldosnvs",
+			.of_match = of_match_ptr("LDO-SNVS"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_LDOSNVS,
+			.ops = &pf9453_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_LDOSNVS_VOLTAGE_NUM,
+			.linear_ranges = pf9453_ldosnvs_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_ldosnvs_volts),
+			.vsel_reg = PF9453_REG_LDOSNVS_CFG1,
+			.vsel_mask = LDOSNVSCFG1_MASK,
+			.enable_reg = PF9453_REG_LDOSNVS_CFG2,
+			.enable_mask = LDOSNVS_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{ }
+};
+
+static irqreturn_t pf9453_irq_handler(int irq, void *data)
+{
+	struct pf9453 *pf9453 = data;
+	struct regmap *regmap = pf9453->regmap;
+	unsigned int status;
+	int ret;
+
+	ret = regmap_read(regmap, PF9453_REG_INT1, &status);
+	if (ret < 0) {
+		dev_err(pf9453->dev, "Failed to read INT1(%d)\n", ret);
+		return IRQ_NONE;
+	}
+
+	if (status & IRQ_RSTB)
+		dev_warn(pf9453->dev, "IRQ_RSTB interrupt.\n");
+
+	if (status & IRQ_ONKEY)
+		dev_warn(pf9453->dev, "IRQ_ONKEY interrupt.\n");
+
+	if (status & IRQ_VR_FLT1)
+		dev_warn(pf9453->dev, "VRFLT1 interrupt.\n");
+
+	if (status & IRQ_RESETKEY)
+		dev_warn(pf9453->dev, "IRQ_RESETKEY interrupt.\n");
+
+	if (status & IRQ_LOWVSYS)
+		dev_warn(pf9453->dev, "LOWVSYS interrupt.\n");
+
+	if (status & IRQ_THERM_100)
+		dev_warn(pf9453->dev, "IRQ_THERM_100 interrupt.\n");
+
+	if (status & IRQ_THERM_80)
+		dev_warn(pf9453->dev, "IRQ_THERM_80 interrupt.\n");
+
+	return IRQ_HANDLED;
+}
+
+static int pf9453_i2c_probe(struct i2c_client *i2c)
+{
+	const struct pf9453_regulator_desc *regulator_desc = of_device_get_match_data(&i2c->dev);
+	struct regulator_config config = { };
+	unsigned int reset_ctrl;
+	unsigned int device_id;
+	struct pf9453 *pf9453;
+	int ret;
+
+	if (!i2c->irq)
+		return dev_err_probe(&i2c->dev, -EINVAL, "No IRQ configured?\n");
+
+	pf9453 = devm_kzalloc(&i2c->dev, sizeof(struct pf9453), GFP_KERNEL);
+	if (!pf9453)
+		return -ENOMEM;
+
+	pf9453->regmap = devm_regmap_init_i2c(i2c, &pf9453_regmap_config);
+	if (IS_ERR(pf9453->regmap))
+		return dev_err_probe(&i2c->dev, PTR_ERR(pf9453->regmap),
+				     "regmap initialization failed\n");
+
+	pf9453->irq = i2c->irq;
+	pf9453->dev = &i2c->dev;
+
+	dev_set_drvdata(&i2c->dev, pf9453);
+
+	ret = regmap_read(pf9453->regmap, PF9453_REG_DEV_ID, &device_id);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Read device id error\n");
+
+	/* Check your board and dts for match the right pmic */
+	if ((device_id >> 4) != 0xb)
+		return dev_err_probe(&i2c->dev, -EINVAL, "Device id(%x) mismatched\n",
+				     device_id >> 4);
+
+	while (regulator_desc->desc.name) {
+		const struct regulator_desc *desc;
+		struct regulator_dev *rdev;
+
+		desc = &regulator_desc->desc;
+
+		config.regmap = pf9453->regmap;
+		config.dev = pf9453->dev;
+
+		rdev = devm_regulator_register(pf9453->dev, desc, &config);
+		if (IS_ERR(rdev))
+			return dev_err_probe(pf9453->dev, PTR_ERR(rdev),
+					     "Failed to register regulator(%s)\n", desc->name);
+
+		regulator_desc++;
+	}
+
+	ret = devm_request_threaded_irq(pf9453->dev, pf9453->irq, NULL, pf9453_irq_handler,
+					(IRQF_TRIGGER_FALLING | IRQF_ONESHOT),
+					"pf9453-irq", pf9453);
+	if (ret)
+		return dev_err_probe(pf9453->dev, ret, "Failed to request IRQ: %d\n", pf9453->irq);
+
+	/* Unmask all interrupt except PWRON/WDOG/RSVD */
+	ret = pf9453_pmic_write(pf9453, PF9453_REG_INT1_MASK,
+				IRQ_ONKEY | IRQ_RESETKEY | IRQ_RSTB | IRQ_VR_FLT1
+				| IRQ_LOWVSYS | IRQ_THERM_100 | IRQ_THERM_80, IRQ_RSVD);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Unmask irq error\n");
+
+	if (of_property_read_bool(i2c->dev.of_node, "nxp,wdog_b-warm-reset"))
+		reset_ctrl = WDOG_B_CFG_WARM;
+	else
+		reset_ctrl = WDOG_B_CFG_COLD;
+
+	/* Set reset behavior on assertion of WDOG_B signal */
+	ret = pf9453_pmic_write(pf9453, PF9453_REG_RESET_CTRL, WDOG_B_CFG_MASK, reset_ctrl);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Failed to set WDOG_B reset behavior\n");
+
+	/*
+	 * The driver uses the LDO1OUT_H register to control the LDO1 regulator.
+	 * This is only valid if the SD_VSEL input of the PMIC is high. Let's
+	 * check if the pin is available as GPIO and set it to high.
+	 */
+	pf9453->sd_vsel_gpio = gpiod_get_optional(pf9453->dev, "sd-vsel", GPIOD_OUT_HIGH);
+
+	if (IS_ERR(pf9453->sd_vsel_gpio))
+		return dev_err_probe(&i2c->dev, PTR_ERR(pf9453->sd_vsel_gpio),
+				     "Failed to get SD_VSEL GPIO\n");
+
+	return 0;
+}
+
+static const struct of_device_id pf9453_of_match[] = {
+	{
+		.compatible = "nxp,pf9453",
+		.data = pf9453_regulators,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pf9453_of_match);
+
+static struct i2c_driver pf9453_i2c_driver = {
+	.driver = {
+		.name = "nxp-pf9453",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.of_match_table = pf9453_of_match,
+	},
+	.probe = pf9453_i2c_probe,
+};
+
+module_i2c_driver(pf9453_i2c_driver);
+
+MODULE_AUTHOR("Joy Zou <joy.zou@nxp.com>");
+MODULE_DESCRIPTION("NXP PF9453 Power Management IC driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


