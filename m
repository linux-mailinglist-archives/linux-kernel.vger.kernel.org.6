Return-Path: <linux-kernel+bounces-333914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFB697CFD4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 04:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E141F24E97
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 02:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA16AD5B;
	Fri, 20 Sep 2024 02:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="DCxNxbA4"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2066.outbound.protection.outlook.com [40.107.255.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2416910F2
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 02:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726798391; cv=fail; b=JFHAn1a0kkXWgJES55Cl9AuJcmEjsFJwnlQMxQPGe8CUedrdVv2rh0mzLTIlTav9RzmjRtrz3b1wPFKs4JY9MowM82GioK4NSy9Llh8oA+uLzxwHM7+iJL1Vm3+fcp/DJNKWTWKE1/dUQ1pcq9o0/S2qlXMwdj61zVOPA/onEag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726798391; c=relaxed/simple;
	bh=s8eLMDfWfyphL9fZ8qn+qTI+jemd3E/xe622d5y951E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uV4hu8fWE6FA4j4I+pOQ8Zr1iUOEmVCYZjfQE4sMUUa2iA84AenIEqXu4ObrVzBKZcGgeR+1DQbZqkx9Xc/cB+uEsimAwi6eLp8fGkdVoP63HMSkqxPTdp8P+d/fgUa8MTJh4MedznUAuvZTpxUJqzTV24Wxr2Y58hO0NzIbyWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=DCxNxbA4; arc=fail smtp.client-ip=40.107.255.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKsccMY59bZBV8hnV2Sd12IgOSCzq9P24mj3qLVP4zOA5CMVwBVNQ+IqU2AzgeWFYiQVdSDaAJtf1Nv9ePQX1rs3HdwONVy5fH8S/g1bu/xj7UG5M+GDlH9Y/rVxgOq09vM4hpbrOxJBq4PvpE7IOSx+6Yz5LMYbDAsKAuuwNOZgro7YX4guHWiAZctjxvFNCefx+2ehEwBucSCr8TTl4UQ15qwnvmPwOQPb8SMZRjAwyEajF1KWK+oPcz2ebcGizOAWuNYN32aYb8seKyXXLMhsplwiqpkH4dmimVlQr3SVnHQfUu2ejZHvrEJivmfBKkGL/9wTs7Hyjycytor32g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6IY/qlMxSFV7CLBBJC9yoVpLRxWAsaxsUyRDNlXZAg=;
 b=dQl0xf42JzJRAynVB09L6Go++5WN0nUKYA9TMk7knWbl7gGWDXnpjYrX189h/V4SYV+vkZ+rNo2065BmeEDL1ZIeriA6krV6uYXJHZH5uN8MVImeyfkIUOTqgrxlG86lBQdvMpwbRHa3vM+pmXHvdt40iujiSGUTZlVzp26dNI/4ep3KJYV1mZ9EcaV/3LWzv4/eSp+skS6klnWAMLo4v5rKoF/ROe8MrGrd9yapoS5ljT630Jm0OOx3K4hwMUDF00C8wX9aOKTNyfoiXFECoDQ9R2wGipDaF1IMqQ2nqk+kB45h8mHFeSQDLn9Nb/NmA5bxlLqx1e+mLk7c3uFeVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6IY/qlMxSFV7CLBBJC9yoVpLRxWAsaxsUyRDNlXZAg=;
 b=DCxNxbA4Y5qoB6YYwvi+VJ2mthr8PXsSHCWyACR++J9MwI3wIXHldlthkVpVvNnnhN0g9tcF9nzTXfcTZXRYBoTyDabHFU7mvuNsdtPJmdkPzLKhKcEyD6M0++Kah4hd+NKgZGPkyXv1MB2BMQsXaOBnpyTxBzVKDXbRF3GKbrvuPNgRbOoTuYiK+uj25zbaskZJeTRu+owisYlHMu9Psu/6lDg/xfX+jHw+Ph/nlk+/1Ed0oSO3gSCbxe3nTKhpf8TIO6IqaxnwS/SNgNhOPCnfPRoy5q4MblvbCHvpELy/PZz8RuUIlglyLn8umOsMovUblKOozq+eKBX9cl+0JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by KL1PR0601MB5863.apcprd06.prod.outlook.com (2603:1096:820:9c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.18; Fri, 20 Sep
 2024 02:13:03 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 02:13:03 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: srinivas.kandagatla@linaro.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] nvmem: imx-iim: Convert comma to semicolon
Date: Fri, 20 Sep 2024 10:12:50 +0800
Message-Id: <20240920021250.4758-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|KL1PR0601MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce015e1-d8bc-4b16-a480-08dcd919c1ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EPXyefz0perijaiLtu3fgFWjeBARTQTD3B/I6T0QqmvN36M7fQKQJ4tbfK27?=
 =?us-ascii?Q?cKRn4Rrs3Zg+mbhEnNKmV4OpLgJwA0iUJszt6pUmGH/N+sovK0rvbXwE7s5D?=
 =?us-ascii?Q?n0fvJmC1kjzO7zQJJRzvcuhtuNxEqlZ89pICh2l/VgLXQcgScrz0wHkiPjw5?=
 =?us-ascii?Q?hUPO11uQpREosBoCSUsENOGyQX0jzjKzM2d7wQXTC1zHlL61DockW3uNmh20?=
 =?us-ascii?Q?NuQCwOIQSNU3ke6NzUhIZYwp1vV9PEwXLGzEXczrnVcmrklghNkEaeIIqGfF?=
 =?us-ascii?Q?yUjBGU3+CvIaHMpQ8TpJ0lYCGciQ80SL2jF4x6Rn9D0v5PuBiOS9+tZbvGzU?=
 =?us-ascii?Q?199rPKcirxJyqY+eASAb3D/RymW5Kpadhd8up6+N+c+Ms9c7l2CcQaBxfbzB?=
 =?us-ascii?Q?Zbw2NR2/Zwialf83lqbxqRrued9Gqg/CuwREiHw/M6q/5b6k5sdwEb7LQd6/?=
 =?us-ascii?Q?HKeEV7cB34fpE+B65I8x8Yw7fGNKTtxOqxsciR1cmKhEG1X96UtuAXkhKArc?=
 =?us-ascii?Q?S6P9ylvhawdnQmkqOjunz6HVsGgqf2d9Zz/Deg+OyVaj7mVWjKXV8RhyGNNC?=
 =?us-ascii?Q?Ur90mhRjE5EBohlYreCBX8U+dYVXHmxAqTkDFTmw7ZtFw2QMbd8yGYRm6zvj?=
 =?us-ascii?Q?i65PAZqUy6pkyS1Jq7gsHuj/hoHja//5ZP4lZUHOIOQwdQvUuTqSulupahkW?=
 =?us-ascii?Q?gqQycxWo40WRf+el9iXEA0E3SadRLnTUmtsASPTZrxxUq1dOtUIYvlCWXOjb?=
 =?us-ascii?Q?a3Yv5HsfXtmgZ6pXOi6zv+hkscNsM2y4THJihbRLkIy9zRJfNImRBCBaC+pj?=
 =?us-ascii?Q?UcUlyGgiRdbrhlw8kaNAy/8fk+My04dDC3Fzr7cKM/BB8LFi6pyShlLJXV8w?=
 =?us-ascii?Q?uUuz0/1fx2otLJ/Ra+9hvUGJ5gsv3llOnXLr17mas/rq+SwCWK1yuoe8V5k1?=
 =?us-ascii?Q?HofBAV0HFBorKNZ1/mc/RBBvS4XYjCMOQWNiAa5wJ7EF2eh5PeYf3n7GdrLW?=
 =?us-ascii?Q?B0JC+JTwCFdbMWuqfERZFM80MAK8RElTH8GCTF5vhOxhiCZBHCF1M1ohMs+E?=
 =?us-ascii?Q?aI/66Xrn+CqFioldGtgBSufBCZKpCTJncjXRNbfG6yXzUuDdC8oecS80lMmb?=
 =?us-ascii?Q?N0MnNLA8k2FYDitYUqATAux6eQZ/SEoIt3+TS5atOqeObAiJka3ZX3cNKR6k?=
 =?us-ascii?Q?L9pkvN1JcsSjO/nWEznc0E/CXqKmG0krHOf57hXjrF09DwANe2nzt0rbecmt?=
 =?us-ascii?Q?bLu51nVKdTZyTJqIQbufe04ZC0gczio3kwmeEXEf3QTmmqT0cCy3v2J06msf?=
 =?us-ascii?Q?P51/UKO7y6CCFzDREZ2+FLTJEppt00Odvj9tbdl+CnBaUahnWxJvx5u4xLD8?=
 =?us-ascii?Q?FDSFq7pupZKLQ2QvJbMNOUO5TkLYJC/obN23sZb3KLFhf87DxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qDCu+yyqa9w6G9JyhdUrDFs0mhxQMv+LsOQe6vZjnoeuCbPtPGhURUYYsmWp?=
 =?us-ascii?Q?nnHUgzQQt/mUbtrjbb8hzQ+9ECPrQbLuv0q7c6vWzsOASLuFsAHp5pn0icGR?=
 =?us-ascii?Q?0IhmRhsrhv1M1W7/f3JNiOpr9Emnk6x6AshnTulDoj/Irw4CpiQkWNxpDsNB?=
 =?us-ascii?Q?EMiRD6oNAuk1EGcESmbhRrHDPTGg8yLATk4PJfOADX/arGt9mtZfTP8xLy3P?=
 =?us-ascii?Q?5GcsA2N6tyP2dA/vKWeCJbX93QaAfy8dXWaSGYPgYTXR9eYHBamOeHXoOYFl?=
 =?us-ascii?Q?sunozxInUYBZrpk2L1ZLr1bTeStTRcp1yACZvFVXLgR+FWuUeT0BzpZiWLDN?=
 =?us-ascii?Q?M+/Wfvf+beJ1g3fwlN6xdtLbBdJDY1aJOASNmOvxC96Q7+IeneCB31JTtzR7?=
 =?us-ascii?Q?EZ/F9q9Llid1tSL6oOiqQezTn8VRPzSnA729dtzKHHggW/bAk7raJ6BRsMK+?=
 =?us-ascii?Q?tz6B4f6OJ+1sWZXVMy7QicG1L8HO1/wgtyMRFsi6ZhofVRXTlctHgUPGAZFV?=
 =?us-ascii?Q?3W/elPmoYhr1UGpmGdBs8QbuNngydJUwhlEYhpt6eUHMZN26+5ALedHbv+4F?=
 =?us-ascii?Q?ZXH5Uo0MOaFcWlr8B/V8weJeJkRqQBekf+QjiAgG0ysuwvuG0YY5S9TDZMzo?=
 =?us-ascii?Q?SoERvmIclY1eXhy4dI6HBNBaPWCdaA2iE9vXjNJqCiqKE/p3YMgZb5EGtRF0?=
 =?us-ascii?Q?NwXo7D+uXLJOwqJJckcB44kZj6bB4TvY+YYucMLRpAKktHpA8f/9aRdWlMRO?=
 =?us-ascii?Q?S0jo3O5ewh/oixD1ExNtIDDJnT/eEilUPnLu2BBV9aM6gTksiRSDmwFA2saX?=
 =?us-ascii?Q?8cbHib7pgaMZRFeT+rDwxXJeFeziKMAHRWOcUU9F+CqSHy6rozHqzyXSwq9e?=
 =?us-ascii?Q?XRq+RyyA4QT8edr0ZxLgLGx3jNGslszmDAJfCRESQ3Jb+j9ee04pMacrdpEE?=
 =?us-ascii?Q?KWtA60YZ/FD9QJ0yuVJZ1LKHKvEotzdFK6UmvOa7+/DHb0QrvvkfSGwDJ4kw?=
 =?us-ascii?Q?V0x9FnYG63AGTD7q6q+Pp9xZ9Hdh5mEdGaRTC/6IeRFQM2fyTtCozwS1vRLf?=
 =?us-ascii?Q?wyWXx3Cbkwb7+G3c/l0ln0ChuDFcIA3BAwX4Yee0+50GP7WPMKAdCUL9iS7j?=
 =?us-ascii?Q?wmwMD1PGT28NPHC6nWzK5bHbKAOATspCmqMdXjGUVSPI92rdd/YRAedDIFiK?=
 =?us-ascii?Q?5w5JcWVQUgfc7vNVnPRZsUXbQXwwKXX1A84V2soz6lU3ePs10nzWjYY5gH0X?=
 =?us-ascii?Q?L0PmmAqHw7hbsznf3w7WkXFZGBRZpKn/dNnz8GOMv1rT7Fyj3SWlHHZESIfS?=
 =?us-ascii?Q?h3o/eL7pLyPxHHRLR4XxtQ1+MULVMTD5VX87gmHsg3qil7hTSwLn8o52KiIF?=
 =?us-ascii?Q?72SAbqm5HlcqiZGDT0DlC3C4PpWhgKxYheHwmvjySvjTkwX9ccWKq/OlD8Qa?=
 =?us-ascii?Q?v4P5nYwIYd45kAIf0P/QIYhHAgyHgIcLjFT09XleOkkeQiE84o6tdOC9xhKK?=
 =?us-ascii?Q?DMkdGeAu27YqXsZJvdg48vzuOf7VS3qRy5oUzWxUbywExvN7+iR9WII1mirn?=
 =?us-ascii?Q?rYKvSxabyxsC/I3F0LLpAao/LcFJTfKpvVMt5rgh?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce015e1-d8bc-4b16-a480-08dcd919c1ab
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 02:13:02.9533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1PP30LXQFZ8gJcW4eg43+3p3yGcoXl7P2R9saH/zxagyk2UsPrmwi3rlVpl9png7RGkgJAKWom3YEMS06qRIsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5863

To ensure code clarity and prevent potential errors, it's advisable
to employ the ';' as a statement separator, except when ',' are
intentionally used for specific purposes.

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 drivers/nvmem/imx-iim.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvmem/imx-iim.c b/drivers/nvmem/imx-iim.c
index f13bbd164086..8cfbe55a56cb 100644
--- a/drivers/nvmem/imx-iim.c
+++ b/drivers/nvmem/imx-iim.c
@@ -115,11 +115,11 @@ static int imx_iim_probe(struct platform_device *pdev)
 	if (IS_ERR(iim->clk))
 		return PTR_ERR(iim->clk);
 
-	cfg.name = "imx-iim",
-	cfg.read_only = true,
-	cfg.word_size = 1,
-	cfg.stride = 1,
-	cfg.reg_read = imx_iim_read,
+	cfg.name = "imx-iim";
+	cfg.read_only = true;
+	cfg.word_size = 1;
+	cfg.stride = 1;
+	cfg.reg_read = imx_iim_read;
 	cfg.dev = dev;
 	cfg.size = drvdata->nregs;
 	cfg.priv = iim;
-- 
2.17.1


