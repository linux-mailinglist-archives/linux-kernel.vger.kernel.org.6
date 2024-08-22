Return-Path: <linux-kernel+bounces-296706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE7495AE11
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0781C22B51
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9D613DDBA;
	Thu, 22 Aug 2024 06:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="RfNHTCb8"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2067.outbound.protection.outlook.com [40.107.255.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB35A13C807
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724309535; cv=fail; b=MTavWnO0aqHXThCQ4ufZP51cV3kBf7rIp8NbTDqeJH578+5wNqr3cqTyQdoZHTkiR9kgzu1mIFrZpZtFKdpIT4R+gPs6xAwZH+JpUDtL3AsinYeSHE8ZfTBlfYx/Is/toRWKI4YMCB8Folu+ddhMvyVR1E0+DSR0+Zc45JhjKMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724309535; c=relaxed/simple;
	bh=+KhRbbpPLcKSWJ6HAX/NWIVQexesDXnBFIqq8ymjUK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gqnABW5g3WInMA8nja3vj+u+pYF4ZqVnzmkiOTlEfcxLE4HZwc6ATH1Oaesz1gDDVOa39F//HkaiBEL9g4258fjdXctZrQzs7WQTbpUsONk3m92hO5askAqNmcyx2oMLVxHiuw8Tr1K05wNIhrEazMMreqsQCYS7ytPAG4BOfsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=RfNHTCb8; arc=fail smtp.client-ip=40.107.255.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/KAbHte7sIO4A/9MoXs3Y0Jz8baGt6OfOlKzXTpgGhIrLohirGWGYbVoF6NiOAU1WJrGNDZfhXjEIYHlZezaVmwO1pQYDE4Owv+ccDcEhU6odCVFNbSqpoW3zCG/8x9ZJHHGnVf/UaQl54Ij9TsGvnXJQG3InMpQlDOu0iMECoD9xzinMAzXusjOnfLMjTH91s6QoaCZWpj9woGHY6zSGXFUKtRJRQ/1+eZs1pQWXTJ912LNx5muIkb4bsvPcCqNwpJl7ImgGACDwb2ECff7/Zv4k6Y35xjLg/Wn3pWh5SGSsdKg1+eUhArpcBkMG2CvC/OwDvbWXQumSGBaqgx4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDzZO710rFLkj1elfDytM9c007FIqcUXwciJ5i4GCmw=;
 b=IvGaieaIbb/df9IOWfIsjvx4BZ2EZuEINdrykrX0SKL/16WbwiwbuXJYyIV3fEd5TPJE4dzAXMyE2/Ysa7jhAJweCIAAdTHlIsN4pVPegS54xXH8xHrjPcedCRvGL9afMd3DRYiSqGtqJS7x+1ZYayP0ah0OdECPtsTo0Y2O0prVrfrRZ7jUey3Ow8gVgatNqvGedeNb/3jtHNt2LXOtQyqEbxBpJK3Axx5dSNRjKaGFX9+GpOCUpWOHoBirBr4wPIazpfllAu71J/qcZ67r+4wNj9cFYbehzJ95tbYeQuyyTJpFfanq5EHV1qIN6UZvI46v+aca3NVJ8hnAB+MP1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDzZO710rFLkj1elfDytM9c007FIqcUXwciJ5i4GCmw=;
 b=RfNHTCb8UrNiSCG94PFvIoBsP20ESIR1jHYOfYB31waTSwhB/k4s+jY85hjJcQHSZy4/3jNlaKxWONgzATquzOJhhMha9tAPepT6u6Bcdlsj/APmgjjCr+z3psfB4AtIO8pV+EldpVenszht5QQ2DW8tFU/+v3W+xC/7F6tX1BIU9RWF+8a2DBlS7T1Sga2QwJBY6HSqs+OJx/BykEuw3aoQLlayu271fl9H/b9jJddU7dqHy6epro7PH6A3t8K4qVyoD5cfdE1F/sKDZd9nkDRcDzTuysZKkDZyaqn1uLYIisGqdKBGiWEXuWpJ9INCvwz+H1JJD5qqN6NF0tr9mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by TYZPR06MB5417.apcprd06.prod.outlook.com (2603:1096:400:203::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 06:52:11 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%7]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 06:52:11 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Hersen Wu <hersenxs.wu@amd.com>,
	Dillon Varone <dillon.varone@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1 2/6] drm/amd/display: Use max/min macro
Date: Thu, 22 Aug 2024 14:51:33 +0800
Message-Id: <20240822065137.1331172-3-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822065137.1331172-1-yujiaoliang@vivo.com>
References: <20240822065137.1331172-1-yujiaoliang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0168.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::24) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|TYZPR06MB5417:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bda7a50-438e-4184-9f7b-08dcc276f2a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jgDYjRGoW3pfWWMEXU5KpI7+Ou6JVnLYtCSai6YsKO0q2tEOHFysZ1NxD+RF?=
 =?us-ascii?Q?Wwpq2et2xusL10fSIj4q9D+m+TwbMyY96InqpEdLTCHqUnSXDo40e6Ue64qj?=
 =?us-ascii?Q?ewWZxxx43vM5bwPzn0AMY43PXThQ4KTxJNJMrwwmjWW909+pmhSDQhh4A/eo?=
 =?us-ascii?Q?sM8Gzv4io0Qy288yl412wtcUOAeT0SFm8DC6fCqWygwzPCqeBypLYXoHcBU3?=
 =?us-ascii?Q?izFuNItG3nIln23eSpiudDJMn+WyCKisdpmQFxaXXXjWgJcdIKwTkOPOAIR1?=
 =?us-ascii?Q?cJ+lBMsS7CDVYvoiGDnNBqyfzTNa/ushI3oTDJEjev/0IsMUNbwwZE8ReaaG?=
 =?us-ascii?Q?8/K5gftEf7Nz+lrZdT95kdByTUgZCPh22tsQuf045GQv9ahK1OE3HQS+ZwRW?=
 =?us-ascii?Q?uboX9yOf5yX5LU+cXq1yA7NqqstKs528Nx8JBk0cBGtn6ukBfn1ORw29/du0?=
 =?us-ascii?Q?+ZvHHq4ZHSQ0S9aRxtwKQsqHaOELK02L0/f99J8xNKW/9QsfUws6hwhXIy6m?=
 =?us-ascii?Q?U14t5uJF4cZ6N1MrIU5WOiVpzgNFGlB5asMriDO3J2l9u7yyXMBG4kQlEkgc?=
 =?us-ascii?Q?bodg25Hp7pYx7iPA7HPFGs1CD2j7OO98j5VfsStolrkKe8BtxzRQWFq9u9C2?=
 =?us-ascii?Q?/qQnu0B4OGWWVxJDSElf65M9dYAe/mAvYQ2AO409FugDpRCrMhnGUrmf0+3t?=
 =?us-ascii?Q?cKyajWaj3QeXi6YrQvZqDMVo72++lsbDQqPj8Z87OVc+Yefl0mMdPsaImY1F?=
 =?us-ascii?Q?LgEXqXA+C3GdPYIRmWBXzSeyfmtfcWJsjudJa0tDGlJp69OXn4LwfLr1ysUn?=
 =?us-ascii?Q?pTXO3u+throkXrTIKzZo0zwFylnET2V0MKoMV8g+kVFZfzgWr93Wc5QS4FSl?=
 =?us-ascii?Q?7E/j8DIsKwzWbVfuIOz3Q+/0csNUo9Acj+FR3wfUqvojLxTCYhZ5aWtqiPRg?=
 =?us-ascii?Q?ZOedZtn8zpR434UlGDLSecPtFlr79N4cEzKZ+aXejS8pzrFhfrufzSTsve1K?=
 =?us-ascii?Q?JeeblBrHSp9Uas947ha/TR2/hRGhrp8k4peVT5rddA2vaMi0D5b49n3KiNEB?=
 =?us-ascii?Q?3AcWx8QuJXx54bgP+xKN8Mjq59f8JelX7WCMes1D1mRzc6HoB1EiiVr9x7Wl?=
 =?us-ascii?Q?xRITQyr5dAF1ermJdP44/4ziN8jjOKsVxbN7qUqFEv6eT7fVF6VJdxqjnJd8?=
 =?us-ascii?Q?bkV2wLsZ1KrmHs8GBv3FlB8xZB2OuBm64ET3szbLMAKpUIc7RQcE39TjY6bc?=
 =?us-ascii?Q?grucFUr20HPgvXFfzbsRDOB9ExFFGSDmVxvgP/Q1u+RDRnFROoOwrGDs1V8w?=
 =?us-ascii?Q?wKc22QRsAJgpm/JirIBTrEvSx7/uLsXnNf0Wh62c4h1hmcMDTVwIoqblqf6P?=
 =?us-ascii?Q?yfhepGYRxe8CbAexRbC0KpmXQAClnt/Eup+X7vQ1G2C9r8Y5UGPTrb2MTXFm?=
 =?us-ascii?Q?/UtmqfW0NAs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5QEgGp4pGeKP5GHPQNIB8Hr4i+HN95KKiJLyLLOiaZnlq5LNkery2bSTFkCe?=
 =?us-ascii?Q?blgBrBYD0z+tsKO6EM58hgGhEdpIogieA0P0H5IIpCUokY4qWUvQ7xasoNWI?=
 =?us-ascii?Q?8aEBU43BLHNffZF4ATaWENPqbCpCmRjNCh9jWOR1cGMZcI7KbugS/x3eKHWb?=
 =?us-ascii?Q?ewYJd4dbHZSx5ycQG18malIkotEy3D04uNPwiCoWVQwwqWCJqiCm1emknWY/?=
 =?us-ascii?Q?X+FEtqIOeQf6T6BwZv5UYW/be5QzmLQY3gcw/FMv2WAS1CceapqwK95wUjIm?=
 =?us-ascii?Q?8H13zlChut0GFW4yX1TebcL0UkRVXC7c+pT6hK1hmhF1Nj13llTsqFL9GDsL?=
 =?us-ascii?Q?TsFYH90Kjup+7OBjO4fBlPud3EgmWNmS6HAjYDPpSJ0Exwm9lwNiv8768PNA?=
 =?us-ascii?Q?z2ViZ5S2+17tX2DWWpU33qVBx9FN9PXV7DNRiOIt2FFBjtF/6hw61VbL4wLW?=
 =?us-ascii?Q?YbC8MpnIReXsKQVBPdU5mdA/FGPwRzj1DJmivzujVXvcCzZ6xORDldGmhebT?=
 =?us-ascii?Q?Spy1ZvfiPOZ0SOH1CkjVys/FyZv135UQDYvymXjtKpjoxjHBwV+bj0h8o6ju?=
 =?us-ascii?Q?Qm0aKlk5ehlgXrz+37+HJBqwxxJHgDfn4gIDW1QT5UutkqocpKSLzFPg64yG?=
 =?us-ascii?Q?LZznggfkcay9AKXNNJBvCojDZwfzKyWjdy5gNshNfysnJPcs/te4h24HjhE/?=
 =?us-ascii?Q?9oPMLIca+U7ZyKB8cJDZdiPwhmDJkFAZzyGWhfy4iKPeo+E/1y9yHKmeRhQf?=
 =?us-ascii?Q?JccZuxsITlwRkxTtrociIgt9UJEw902Y7L3zcmiXJ012hnXdK96QD4oYgU+8?=
 =?us-ascii?Q?lTic7xvQUr1vlLqA3qKFGS+31+OV0kAaPGPAr92CvTkx2N8nVslo3DSXtqQN?=
 =?us-ascii?Q?fmz4eGZsnlil+lIRpqJ5hqdYeoij8RRIMjKnx734xCXaI4PLeDWTD0UNrPPK?=
 =?us-ascii?Q?6tSKogriT3Z5dxdX9IlkxsjGdLaAVxZJhPff40O4jfqFXBWNVPoAOF6oeHid?=
 =?us-ascii?Q?ZE7cxjxw30hsbOY5u7pCYYYlDAgBQ448/3jQkeBAgLefU57MYHqSYVixH4cX?=
 =?us-ascii?Q?XP2tDy/IzDytV7FFdGk6reTTJtgnICBUQDwJgfsUCR1+NVGeSgaei3NJfZZ3?=
 =?us-ascii?Q?ltcVg9nU+L3Eb4I2VzCdhfWEbjXKiUjWChbL62L+1p6kWtZWd5ChiqOFkFGZ?=
 =?us-ascii?Q?jaTc2lBAcalUfgWO41SXK1dvP1HDp/kaelDWXRzVu/3Yow8QjfDNE1b7UxOs?=
 =?us-ascii?Q?3awWPsxXcNKXV2gmlTlkpIKKfJGaiugc6wWbrjHMW3xDlsPEvRLTAxgTaJjN?=
 =?us-ascii?Q?nlaLvNObGolTKUO8jei+zxjUwRxYRVYOAS6qEyfB/zde3yP1+KutHpBjkg7T?=
 =?us-ascii?Q?Cz02VxVRLPOR8aSXn2iirm3MK8cKCC9BuqphREuBU3DKrFHQGOQMC11tGSsh?=
 =?us-ascii?Q?1CbfzzPhXU1IgdeR33j/Eef4iYCqsvhUmNbiRwquExiqADFrc+HGKUnMwdfc?=
 =?us-ascii?Q?S4G/3D4x1W85dXzDMY+767nmwe3664o7DSrF2w3v4qxzrn0+Wi+G2T/fLJHr?=
 =?us-ascii?Q?nTdWiHr+F0CBTMAU8d9fqhZtrLkndonKdcrCgkfT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bda7a50-438e-4184-9f7b-08dcc276f2a0
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 06:52:11.4256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/7ZU8okN6m19AOCYVozJRlLy7DwfdvxL2soA5mImPOIA9NA7tBPNWSizOxJ73tq5WI5cA4pM9isCBFZoTwv4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5417

Use the macro instead of ternary operator.

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index bb4f3bd7532e..4975d47b66d8 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -311,7 +311,9 @@ void dcn2_update_clocks(struct clk_mgr *clk_mgr_base,
 		new_clocks->disp_dpp_voltage_level_khz = new_clocks->dppclk_khz;
 
 		if (update_dispclk)
-			new_clocks->disp_dpp_voltage_level_khz = new_clocks->dispclk_khz > new_clocks->dppclk_khz ? new_clocks->dispclk_khz : new_clocks->dppclk_khz;
+			new_clocks->disp_dpp_voltage_level_khz =
+				max(new_clocks->dispclk_khz,
+				    new_clocks->dppclk_khz);
 
 		clk_mgr_base->clks.disp_dpp_voltage_level_khz = new_clocks->disp_dpp_voltage_level_khz;
 		if (pp_smu && pp_smu->set_voltage_by_freq)
-- 
2.34.1


