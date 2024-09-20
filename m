Return-Path: <linux-kernel+bounces-334135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4560297D2F9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3141F24C2E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1D413C80C;
	Fri, 20 Sep 2024 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mFh82EOy"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2056.outbound.protection.outlook.com [40.107.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA60513BC0C;
	Fri, 20 Sep 2024 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726821942; cv=fail; b=N4iHpDdtqNmiDEuZnXX7YmlsPBtLIBHMxiIAq7n8Y0XRAuK5JjubNQC0qWbtSo4uuOy9VRmfcaJtrZeEocJ7rsE5DOFQL8BzczqwNYhcqXc73+Yn8KDuLK7G8umweHthcJrLk6oU1DAz0eaoeLrSmw5dUOOnO//1PRbDFB0/KGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726821942; c=relaxed/simple;
	bh=X1K32EimHAVnTC2ODs+CrvHoaSPoplW+DLX28iP9rXA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bZPW6RD/ESplnPzVwUfiwEOrKSg5wfTT2mwQojPHFnztwRUkDfjYdH4tfQZeYZaHfmLwov9Np4I+11ASmc22HcWRo25fooc0iNbdvEwlsEC/ekaO934JCMGed+ujEdDc+fzrsmhwQlNTrzJhgO7Yi5MCIz9R5gnvY7zEO5oJtPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mFh82EOy; arc=fail smtp.client-ip=40.107.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzXAPg4iu4WuTyrS+YMXo/tQbmBugaqiDkeauwDLEEfJtTiUQACH0X8QiZ37C2yPLUyLfsHkl2pJE9HNyRzPxAOypVBcwW7fv/2Au2EVEX0+lAf6j9extfDsy5UaGqs762Ey537I6/qA03GCoZva21m4zWji25S7nh1DMyrbpiIgoAsCbTon+AoqYQiuxE5reDcVKgME/9Szo0RNJ04G4mGKRzTo5DdjuAlzGCUe7cEusYZiMpVQUo7HyH7GRxrXc3SgSNOYiGS0eahjvS3wHbHLsUOzc14bG3xzULyoo6BmYB/3LEiyOSnGBQyY8EG3WUjDY3S5zogZX08VD64Wag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MboKSzgGk6AJ901e0vhMqshKxikNQu03vaA4EA+qlj0=;
 b=wTbCPZSDhBaRQLu5c33a64M8wr3kwdHZcvc3QHdFw9FEpyLfePrksdZ+O0aPmZ6hbCSJJv8J2YlGpA7yr9nhysAzjfzcRRZy9dDbkXr9aqVM70a+r9Y4eByMTO1Tx4VoTbxMEgC0a7sHWuf830l7X/8KTe5ZIK4YuZzMSEBIXZ60NOVuEpLcPbCDNlfnXfq90uogmkKtH0DjHFWLRYvVf8JjzOxj/bmOltcYuK4w6TBgGpET49Txrt3dBH2oWHdrpuTWOE5DVTimhpAg/J7zp0Eyn02+auLDBdXp2dO8fQlqLHPDDaEaTjWcQjU9uPCS8yrAIXhESS/TFdsNf39X4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MboKSzgGk6AJ901e0vhMqshKxikNQu03vaA4EA+qlj0=;
 b=mFh82EOyQQ27/Sy58tW3G/EdjAN/Y2qaE4YwF5mUV4fiKOWGrKBJipbZNLBrwqqgUxbfdMb9mqUg9GHg/YGk1OrukapZNZgAbxrqWZpCmE/B91CGl3ZAEd5e5rgoOEoiXKIxTrvyBLCnxXagMwaRFA7GINqLF1dgTHorMZjZ9he9rVCvQ5sKRvH6aeEfNTdbxXnItlFuLRKepbnqV/k7M1PK+rTi1td8rRFkkdzu3dFHoc55JovT/HtFo6joBcs2F9TF5LEnb/6pdpNs0N6Rl2uR88rrBpdNISGNLy5H6QRBcAwXLOPLu41hb23ZScmu3YA/Fv4UW4Z11NQOEzrd5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10613.eurprd04.prod.outlook.com (2603:10a6:800:25f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Fri, 20 Sep
 2024 08:45:37 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 08:45:37 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 20 Sep 2024 16:54:08 +0800
Subject: [PATCH 3/3] arm64: dts: imx93-11x11-evk: add overlays for flexspi
 flash
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-spi-v1-3-97f220c2e10c@nxp.com>
References: <20240920-spi-v1-0-97f220c2e10c@nxp.com>
In-Reply-To: <20240920-spi-v1-0-97f220c2e10c@nxp.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726822454; l=4277;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=ZqvguUiQsUfx/RBcd1BVPDtrroCvCtLF7yJnubT2Mz4=;
 b=vH9oqOJk7x2eJzLiJyJ2hTQPTBn8JCu8JXJxPfarMUmkZeRexKph0F3qt5aM9v9tC0dPFxCZs
 2J+pgi6GtG5BfpUp3UihUXxpHnaI0CD9gtuQrrcjVGdKF/1RzCm5kN9
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10613:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a0ab242-5c12-49be-342c-08dcd950996e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3d3TFZXbFVjUTgwKzl1UHFQaHpYai9RNzZZdWNhVm1xUHQ2ZWptcFM3Nm4w?=
 =?utf-8?B?OWpPM0FVaC90RkdLRU9qbzBncDd0MjMxaHZHZXdmWUpUbVNZVUlqTk1UcTRa?=
 =?utf-8?B?dDhLeWtVTzFmNWlBSkZ3MWxvd0wxT1FjMEwwcHUxbDZuNE5oOGlSSzB3OU5s?=
 =?utf-8?B?eEd6dFZiSGxTaG5nNUplNTA3KzBPTGpOcXZDUUJPbG1TSnp0U2cySUN1WFRM?=
 =?utf-8?B?QUl3VVlSaGQ0VWF3eENsQlVKS2hDSm9tTzV1RTFLWXg0Zk9xL01Ic1JjV2Fq?=
 =?utf-8?B?S1pQbVB4cy8xY1A2NEoyaTJxaDZMcWl1akRaTGhER2E2d3FiK1B1U0IvN1Z1?=
 =?utf-8?B?Y2xBU0tZS05BTVgwTnpOUGZXRmhHUHRjVDlqc3k4VU9mS29IZSttRjEydGZD?=
 =?utf-8?B?MW1nRWNOZVAvTGRQbExkUDFJKytRNWZXZHJPcTZjSjV1ejRZYzN6QTVYYzJO?=
 =?utf-8?B?RFkzRmVjazhwS2YwM2tlQVBXVWlyT3pUdUJzemR0dm5FRHRhY2M0bUNRaXdI?=
 =?utf-8?B?cGtiYlBSR01CSWR0R2trUUh3eDRUVjVJTUpLa2V1QUZTaWV0bk5nTkNId0Va?=
 =?utf-8?B?d296R0k4NWR2WTVrOGF6ZS9kY1NSN2pSVldpdzhLZE90VGNjWDBtK2tGLzFN?=
 =?utf-8?B?aDNPU1NaTHhQVUtYaFpSWFJTbGpPbWN5QUtiS09xYUtFcDNEVTBpd3czdXky?=
 =?utf-8?B?SGZhenMybjAzekx1V0JxWDJKYmQxNy9BcGo4SWFkckg0SW0ySkUvZzNBMkpP?=
 =?utf-8?B?OGZYa0xZbHVuL0sxdk1KTWc2emdyQ3hsYVBWUjJ0Z3FYdGlOK2pqTXZ1bGZx?=
 =?utf-8?B?Q2d6ZWR3YmdTckprODBjYVJOaDBybnQ3b2lDekx2aytLc2wzYytMenlNRUJp?=
 =?utf-8?B?T3lBMmtwUzN5ZS9ZWXc5cmNaWWR2MDNMVnVybHpORCtieHMvN3NJRm5kRnUv?=
 =?utf-8?B?MlJRcnhrTXI1UUhZdDZFazdsSWVIRDA1UFQ0TVMyWnVKRW5MZk5aN3dnb2c1?=
 =?utf-8?B?aTlmdEZ5RHBXMHkzczdGWnR4UHpzODNQbm9lWW9QZEZ5Y2FCQW5QeGQwTDFt?=
 =?utf-8?B?VlJodUwwakZjNGxlRXN2KzFBK0pUVFh0Z1l6TmdIaTFTN080R3lJb2lCejBS?=
 =?utf-8?B?akZOc3dHd2R5a0pUNkFYeE55blJzRFJON2dReVRoQkVzOWdsOGM4NWMyMGV0?=
 =?utf-8?B?a0ZNcnJqZEtIcWN4Zjk3MSsvY1N4YTdXelBnWHlSMUlmVW1mVmVxZUNKcFZT?=
 =?utf-8?B?WEdLcFJoaWZvZXJBYi9LYTBqZEZ3MFpvOUpjKzVGQzg2RXo0RUdBUmg3ZXRy?=
 =?utf-8?B?c0xhZG10OHVPWHlpOHRZL2ltRGFQYVF5ZlQzcjdQd2N3NUJPaHl5a09xbFZu?=
 =?utf-8?B?S1kyRFo4aHJadloxVGlQUmZNR1VWc2h1MTZNUzRkUE04MlpuTVdQaXNPbnR4?=
 =?utf-8?B?Q2tJaDRMRng0VDBpTzdXdml5TFY4NTdNRXliaVV2bkdFamEya0d6amFDSnZN?=
 =?utf-8?B?Z1M2Y0tTNHNCdGFMMW5iVGUzcm9NZXNKNHg3OUdoanREMndMWDZLdEVFUzdD?=
 =?utf-8?B?aHV5WUp2M1g2cGxQMEhNWjhBbmN4SThSNE5LY3RLZXNwb2xWSDhuYkxaZTJW?=
 =?utf-8?B?cGo0R3ROTjJ5ZEw5REdXYlJ2dUpSQkJMUWNmQW94VFhWZW9mVnllb251WUdk?=
 =?utf-8?B?VGFBS3ZiU01kTUcxRXUyVmpjQ1NSa05RT3VGNm9zbU9yMFhzUzVEdFNtVzdl?=
 =?utf-8?B?Wi8wUnZQaENFdEpJVUZiSFl3c0QyUWdVdEF2YjdhM1ZOSWpKaHQ0Z3hyR2o3?=
 =?utf-8?B?RS9Qb3ZLVFppU2lYZW92YnFTYXIyK1JRMVRXUkIwRGNmQ2VBSUZzK3ZZSnky?=
 =?utf-8?B?VDIxZWZnelZLOEVtWm1CR3hwTWlsTnhiZndPaTl0SzUxdTJPaTFtN2E0Z1Bs?=
 =?utf-8?Q?f9QxUSIZCXk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHJrVjV0N0xzNzBLaXh0SmFUdmpZdzY0SkpjTXI5bEp4a0h0UmtnaXQwbUw3?=
 =?utf-8?B?VGdpTXRKSXFjbndPbVMvWVRGR0hrQXRpQUlReDlMaW9SVVYzZlNQSUlrdGh4?=
 =?utf-8?B?WUc2N3FTQmo5Z2RiK25HK1JCVDhjZjMwSDlBSk1TbUU2WXd0UHNZY3dJRVJU?=
 =?utf-8?B?eDdLQmlYWGs5U1ZUYzBpQXljVmlBaDJnY3lvb3lneFF0Q3dXWndwY29FWGlC?=
 =?utf-8?B?K1ZaTC94dmdUM3pCYmI3aVk1TkFjV0VyaEltNG1yQ0l5TGZ5ZC9DSW9lQ2J0?=
 =?utf-8?B?a2p6UHRyRmhTZUxaMnpzYTFXV2dEV0FKYllGRWZScDUxQm9NTUE4T1h4ci81?=
 =?utf-8?B?UTg0VEJidFp5Z2hsOS9Jbk0ybUg2UnZ4VEdXdmw0RHBPL2s5ZzRMenZMRG9a?=
 =?utf-8?B?dlQ3TldmVzNkNDVEZ01lZGl4dDExeVpWQzNQZUpPeEg4L1hMdGlqT20yQXB2?=
 =?utf-8?B?Z0lpaXBOMkgrRGtZRWdJT2JYdkhpQkt6VW9TWHh2a1hocFhXNFJZZHdiTUFV?=
 =?utf-8?B?ejE4d1hPVEJzVHc0Q3k2Qmh1SkluanM4aXNTei9BNFhXRkVmelBZbjRGYld5?=
 =?utf-8?B?ZHpsaThuSSt1OHVBUjJmWitUTWxzZS9jR2J4VjNhejJEa05TakN5TGlTTXhq?=
 =?utf-8?B?ajdYRVFGNW83NmdNSHF6UlJ0dWpqVENPSXpKVmlETmFoQlN0czQ1SDczamhC?=
 =?utf-8?B?Tld6MlhvTUZEVHRvVEpPRnNJaTRBSFlxNmw2WXpEeHY3aGxhYkZoL3lXL0RD?=
 =?utf-8?B?UUdxRmJhUll1RHZZUWJWR2I2NTlndXNYODBMNWFGMEpvNXY0ZFdGRm5SdVFp?=
 =?utf-8?B?TXFvVndmdWJ0YzJ1djZJdDVEVUNHalgzOUs0ZkF0aUp0NTlxejNYTytjc2hL?=
 =?utf-8?B?L1VDbnZBazRPSkYvK2U0TVBUVktjSVo0NlRYMTFXKzh5djA2TjNCemdDTllT?=
 =?utf-8?B?VmNrK1JRblA3ZVZ1QjBiMU5EYXVsQnRDdjBqQWkvNG9mdGNIMTZYSE13Q1o3?=
 =?utf-8?B?SUFHYVBFVHAzZzlSekxpRHV6L20yeUJBaitGTWp2NURjMThZOGJac2NqV0F0?=
 =?utf-8?B?UVhXR3N0VVRNYWU2enRJZFdVQjQ3czJhNWlLZmhzQUg0eXlKMzV3eVkxajJy?=
 =?utf-8?B?bDJZaGZYWmIxR1JwQ1c4cGJ6eU5PRXhVdE40ZzBSWDYrVktwb0lSWUdBTDlW?=
 =?utf-8?B?K2tiVkhrZm5jcCtGemt6dzFuSWRTM1VNbnprcUpTWmVscXJnRVhYV0tYRnpD?=
 =?utf-8?B?N1F5QVBOUnNLaWVhaFIzWmVQYXY0eXlDa0NJUUhRLzcvOTZZNmgySFFJdGZG?=
 =?utf-8?B?ZWpkUjhKb0ptOHFBb1VTRHhicC9vR3NVWWIzcjVxNDZMWndUR2hPdnZwZy9O?=
 =?utf-8?B?Y3BKVUJrV1o1elpwK1l0Uld4SzNLYjVzTlpyQ2xiSVF4b2h3c3RhR3dYa2FW?=
 =?utf-8?B?WmhnTkgvdVpocTNPUWlHek5MYnVqNXZMNHZvRWYvc3hpalk4bXB3WE9FWnAx?=
 =?utf-8?B?dDNqcmtSbEg4THhraysyWHRQZGZGMnM0dTVSMjF4Tk50ekYwNlZzNFdDWG1F?=
 =?utf-8?B?ZUhoeUlXYXVibVhZY3Myd01QSzdGaTBoTFgybFpiNk5jWlNhcTdFYUJDT01y?=
 =?utf-8?B?THdadkEvOGNwSHUzcWUzMGIzNXBPZ0g5S1BtQUl0c25iUFlZdG1QbXE3TjNJ?=
 =?utf-8?B?dUNBN3pLYml2UEFNQjRVTSt3clZ2eU9hWUUxSi9kR3VOS0RKdGxZbVB3WGpj?=
 =?utf-8?B?ZkgzY0lvUGYvL0ttcWl6ZnJxM01TVXFHSTRBM0Q5MTJzc3ZBZWtDRFo3TUFq?=
 =?utf-8?B?QWdpNTArbS81V1plYjZ6NUdRc21zUGxWcGloOER3S3B6U0pRdXJ5K0Y1THFK?=
 =?utf-8?B?VmdoVlVSK3FrUGl1cDFaak81SVRPajdzbGNSM0k5TkNwdCtsZnVqRHZVdVpS?=
 =?utf-8?B?WXdNTWRqQVpOV2w4R2R2OG9kVGhCakI3bm45ckJOK0RScVpKZDc0V0tGNXJs?=
 =?utf-8?B?STZ0WCt5elVEMUxjMmtWZkJVU3lyV0tER0VJRDNmOElOb0tRa280UEZsOUpO?=
 =?utf-8?B?a1o3WTVXTnMyMlFyMXZtMy9hRkRoeDRORXg4NnVnNlJ4Q29NMDhiTmR0ckhR?=
 =?utf-8?Q?BQdl8kO5sMfguB4EgrOC3LXTe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0ab242-5c12-49be-342c-08dcd950996e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 08:45:37.5540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJ3r1IC7brNChQs/76KleQiejcXTM5p7Lkfl1zCzI3lKmGNUgELGLD+NehKcuqoT7XYnekVfIJ5pTrFDGKXjXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10613

From: Peng Fan <peng.fan@nxp.com>

Add overlays for the flexspi flash connected using M.2 interface.
The M.2 interface could be connected with M.2 flash card.
The M.2 interface needs PCIE power to work properly, the flash card
needs 1.8V voltage to work properly.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile             |  3 ++
 .../dts/freescale/imx93-11x11-evk-flexspi-m2.dtso  | 59 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts  | 10 ++++
 3 files changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 9d3df8b218a2..8f82aae85fe0 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -241,6 +241,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqp-mba8xx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk-flexspi-m2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-14x14-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-kontron-bl-osm-s.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
@@ -249,6 +250,8 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
 
+imx93-11x11-evk-flexspi-m2-dtbs	:= imx93-11x11-evk.dtb imx93-11x11-evk-flexspi-m2.dtbo
+
 imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-imx219.dtbo
 imx8mm-venice-gw72xx-0x-rpidsi-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rpidsi.dtbo
 imx8mm-venice-gw72xx-0x-rs232-rts-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rs232-rts.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk-flexspi-m2.dtso b/arch/arm64/boot/dts/freescale/imx93-11x11-evk-flexspi-m2.dtso
new file mode 100644
index 000000000000..f307789546a2
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk-flexspi-m2.dtso
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "imx93-pinfunc.h"
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	reg_spinor_vcc: regulator-spinor {
+		compatible = "regulator-fixed";
+		regulator-name = "SPINOR";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&reg_m2_pwr>;
+		gpio = <&pcal6524 20 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <2000>;
+		enable-active-high;
+	};
+};
+
+&usdhc3 {
+	status = "disabled";
+};
+
+&flexspi1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi1>;
+	status = "okay";
+
+	mt25qu512abb8e12: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		vcc-supply = <&reg_spinor_vcc>;
+		reset-gpios = <&pcal6524 12 GPIO_ACTIVE_LOW>;
+		spi-max-frequency = <133000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
+&iomuxc {
+	pinctrl_flexspi1: flexspi1grp {
+		fsl,pins = <
+			MX93_PAD_SD3_CLK__FLEXSPI1_A_SCLK	0x3fe
+			MX93_PAD_SD3_CMD__FLEXSPI1_A_SS0_B	0x3fe
+			MX93_PAD_SD3_DATA0__FLEXSPI1_A_DATA00	0x3fe
+			MX93_PAD_SD3_DATA1__FLEXSPI1_A_DATA01	0x3fe
+			MX93_PAD_SD3_DATA2__FLEXSPI1_A_DATA02	0x3fe
+			MX93_PAD_SD3_DATA3__FLEXSPI1_A_DATA03	0x3fe
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 8d036b3962e9..2eefa65fbfa8 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -78,6 +78,16 @@ reg_vref_1v8: regulator-adc-vref {
 		regulator-max-microvolt = <1800000>;
 	};
 
+	reg_m2_pwr: regulator-m2-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "M.2-power";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pcal6524 13 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <2000>;
+		enable-active-high;
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";

-- 
2.37.1


