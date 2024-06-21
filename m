Return-Path: <linux-kernel+bounces-225111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED84912BE5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9361428C0EA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE59E17B400;
	Fri, 21 Jun 2024 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p7lBTVUC"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2068.outbound.protection.outlook.com [40.107.103.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0BE179972;
	Fri, 21 Jun 2024 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988744; cv=fail; b=cV7mQpF1ImJp+l1FE6Gcn+Kd9o0WPzv1AWGoyJvK67rgDPbBX1NVOU//+TgkbMdq2+zEoOq1xR+Zb4MVzrpO93ac0nUQZTOJ/rRRHER58L3qnzbEIgWoBMOjavOVihOMwRRUPGz2O1BaKGW1DArEBcg93JfXeiEIV2D4ihHy9KM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988744; c=relaxed/simple;
	bh=gQx6uOKzzKS0Bll7jaAdB0ziR+MGyleGJaCiGybqzR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cNyuFTZsZrDlrjKuBF3YdgfyZyxYV7lZu3tZMJtDhCheugcuM6N2TEqc5FFKS5lPoWzLXA+moWpo+vXrzogzlTXyV5oKiVW1i9tz1nS/0f3aq+w83SN5FyxzYUpkKWh+rynQqjSK8k+Frd5tvczfKN5FgdUTxRgYNXgkHikWmmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=p7lBTVUC; arc=fail smtp.client-ip=40.107.103.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCC+uBGycdX4S4+RPkhN/LJmwo0cchZgzzIsWxJXCRRIXfgf8KTiHcSf1uPr9C54VbmVTQJqwlzyxkFveiPHTuzaMcmBwMWa5KTPkcVdKcI4hqFfCYsBoUKI/CFajsy6gW7kIof30HcqhGF5QMVtF6JueJ7C5YPBQZN8lGhHo9M5XZmhiyS+qH7SyrMST85iSUk3V25dcpgKMdWb1IukW2Yk6DOLqt/gmy5r7lBNr7BdB8Nly3MrpGA49e6k2+qO8SS+eh4Kvlbny11gl9y0w+0/etQpRs7vfXwdBaleg8YO6waP508e9l6QQQjWeX6Vd0338l38iuGqvYLCj4tggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qaOxvWcbSXooGjoZ0TzegtRWy2YIfbXYTnfjOw+GaA=;
 b=cFfGBl8FSTRqdoPGz43h2VvnKtla3TJUc3vWMSup6V8FQQK1b4L007qO8Xc9wcRxKAdljRyxVISdWAcYZOec+dedTb0og2TxcP1yMkFDPFsX+KoM9zPvUuuuMmMNhjhgEAKbfM6Rz2bFqczc+SCtihCoKzkZe/loJy+7aliZLAePoRTm5TRtsIKAvDF5paW8DIWClxDjUeMG5SiNeNbH+by8wnt8b4IaqNaiHisvVGoiwgwywg34pAzH87OhngJfKsiudJLTQkInDFRQwQMGqgwWYDFgoLjs+Toat4Z9Wd7xJ+IBpQygRQQHFs5eZbbj9ePNaLVCHE8pcIahO6DWgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qaOxvWcbSXooGjoZ0TzegtRWy2YIfbXYTnfjOw+GaA=;
 b=p7lBTVUCyMB8ZF6qKrkdacUPtossHNDxJwGYYLjkOaWZSv2agJxlg7fVkmkM3ECsfx4+vlB3oni7gSR1qgGS9JPrI/reJuq50xQ7QAgSnYhh91rjOzmN2uGKrprdeshbqWHIFEU5l80q20aprgYFzUfttPbewnEPpB31LB8T1X4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7937.eurprd04.prod.outlook.com (2603:10a6:20b:248::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 16:52:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 16:52:21 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 6/6] arm64: dts: layerscape: remove compatible string 'fsl,fman-xmdio' for fman3
Date: Fri, 21 Jun 2024 12:51:49 -0400
Message-Id: <20240621165149.2275794-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621165149.2275794-1-Frank.Li@nxp.com>
References: <20240621165149.2275794-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:74::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: 7419c542-b1a1-45e8-56ca-08dc921284ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|52116011|376011|1800799021|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a5/B1EtR9d/EL48EDlhABPFhGZyzlfJBO9U6RRPrrl0Di9BnfsZqufDF4Ii0?=
 =?us-ascii?Q?XsLFcg8wiJjkaouEYO8ulC6z44E8+zkBxQI9TVQzFKUv9Z2biQjnBWx45nU7?=
 =?us-ascii?Q?ZOquhP2Almo4An77y/gqnsgFnCEA1484RXbm/dBltkPxG4Tn1aRG2nQDZ5Ov?=
 =?us-ascii?Q?biAgWZloLz+Z4J4B8lkanJR+sUhB5UxXunsATFwnQTbCbO95G64twTjuMcY9?=
 =?us-ascii?Q?rIwkgy0M+/dpHovLxulzT4JahudagBGhwRNQrx1YTAGb5ZxX+Y9sWdI6k81c?=
 =?us-ascii?Q?RAOtCkZ87FD+7+dZ3JlxewHGnmAuS2hoVip5+0z7Xm4AA5YuBN1UR8mf1cee?=
 =?us-ascii?Q?14GhzWNLniFsEUNQjCn3GFUqYKYeShSlcgGpQxzXTR7hL9y/Nubs0fk8N08z?=
 =?us-ascii?Q?SCVRE3zj24HUWeDjf0EToVZ81+UcaBdCFA2jsy1h8JCOW7OpcwHBbiuNHNFp?=
 =?us-ascii?Q?78I2iU/fmXlwERLpHlAknYNqM3q/5nGnQEtaNp3uWTTyokLTt7BpkZ0NlcU7?=
 =?us-ascii?Q?jcHEUNQjwjUVzFrq3t2XZ3nXm5cD+ENu0LBOb4/WnBCkDtEZ0sI5FQ45xKMY?=
 =?us-ascii?Q?J8LSotErCe+oFAOZ4Zve4d4mVLMr15cRR3Of1+L6oAERR+n0tvZwrrIg/mr1?=
 =?us-ascii?Q?vwvv6LhEN+bn4+OmjR0twLzSBv9y7T91sVXUVW8FBVkQi8Q6mk4fq21OCbR/?=
 =?us-ascii?Q?4wx/0mAfiLCuSs43N1CbZEzNTnmwtYW0f9TTr3NmRRmnD0jfFsP7gsRC3cs0?=
 =?us-ascii?Q?K69yStCk5z0hHpl3EgBoXk+9bpNdyJGfta0B7p2Z6DudhNU3LDrE9UCowqSk?=
 =?us-ascii?Q?ZjWJ4Wz8CEMUfDplx/KMRMUIR5YM/6GqyqA7yy5GhM44ftyq4fMcXMaJj741?=
 =?us-ascii?Q?nszM1mBpTRYjuqBVGE8yuG2Xb8ETUI4vO8OzKZcwCoB2NsNxlmY5/04kXywR?=
 =?us-ascii?Q?k8e5PjMgyXO0rx5zFiMwJl7vmtFJlMuSEGpY7AsCFGyqzUHnb1e0qlK6qYpP?=
 =?us-ascii?Q?n+PxgSHjcE4bP9KtbNkO80KzMLICUyKvhs2uRi1IfEWNS9a50iL8geGVKlSx?=
 =?us-ascii?Q?0z2kpUsDR7fmSMGa/GkFA5QLP735xtmSEbI8AIz28grGE5K19XZpwNDhubfM?=
 =?us-ascii?Q?j4oUoIMkH7vDwRqtxBMzT5mf8mLv3wdvr0/DITFHrCi802NEmcGzwihv7bvp?=
 =?us-ascii?Q?rT5HkR1XB5Wr4An2pAKuauIZeuPNKtrkrPkk6Y7jgTUtpejoW46bQz8E3qoa?=
 =?us-ascii?Q?2gdXvxlV77BxkZEASyU/TTo2l2SIgguUtnOdJE6q3zWgzChHmbv0I8jOV4OA?=
 =?us-ascii?Q?Y/tayyopDV/K+fTfUP5R7mGrMd8lZ4gbqgeye9BVDMEUuQQyseIeHY45fvPV?=
 =?us-ascii?Q?f6p4J38=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(376011)(1800799021)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0lA4ZKz8zqfL9RnXqteUkgtlUUzTIQOI45Hp11KfTMnYggBk44preE8dShCH?=
 =?us-ascii?Q?8lx6Rpb/nMP4wIgXmEIAHLByUhG5K9j+feuAzuwhcoxXXwU3muqNB1e6N2uO?=
 =?us-ascii?Q?DMeI3dAeTZ6ybbasqFikf4H9aNNl64f14dNGnQ3aERxci4/RxA2E95pUYlHm?=
 =?us-ascii?Q?ReW4dnvCt2b33o4keAMbgz0xDfHws4bCBsIjeW6sb0ZVvyV7DDt5wg2OWp0j?=
 =?us-ascii?Q?6ZJ8SdJx9mSvmaya8UVWjzpGHFPVuiRa/hQdJfjtK2OOvrgsga87aSZFNk2P?=
 =?us-ascii?Q?+CKM/6Nj8zQil0Q8w8xE1MaqCFM7UztnlZum16acmTlPr24U2aWyzsZcfq3+?=
 =?us-ascii?Q?WChtwdZPIf2UOCn8UrrJuz7auo5/Ak/Dv9ZxNoBtGhvgLLAJDxlfVued0z/M?=
 =?us-ascii?Q?6eBS7w09QE7RwNQsM4l+33DCzdYs4wbd90GMx8X1gprVUiigdTirXfiSp3Gf?=
 =?us-ascii?Q?hG041UVDEU3eq4WvZiTzuSAM7lcKf41vMeB5+dNckR+NlGYH70gyAmJnwMYe?=
 =?us-ascii?Q?oK9G1+DplQJoivO0TJ6FghESyMFycA4JQv55QNkSagIN6kXrxG+QZ2eptJaM?=
 =?us-ascii?Q?23J/jgGq8gkzjag6TvPBT7Vwb91VC/Zdea6mGZJUYhCLnpuWil1zDlGwZ9Er?=
 =?us-ascii?Q?0XubgjkCTokcOS1tJbkiL4c8q6QvR5esgYlKhynoveQcfErTmi0cGGhrEHIJ?=
 =?us-ascii?Q?aQGCas/4dXP2vf+1kpbvk4z8bvlK3tDnLb2d5g8GEX0cfVNYHa9avwbErri/?=
 =?us-ascii?Q?+6oHVGf86loeC5SHBhq+2N9RUuyF7qmS9LrJpAv3yaqFIlpl0aGGGllzKSb3?=
 =?us-ascii?Q?iEsABsnzpoKvejhOxQ4atU2I4idLvDDhqBPlIcs33Ar0EHBF9EQGd3dvkkqo?=
 =?us-ascii?Q?uFbSSeKMGIiMoadVxdHGLmD/Epx3B6xVa7d8Hk/1zpMr5wzZe5KVFV51hBgu?=
 =?us-ascii?Q?U+4zMuR2taT4IhkIiC7W6y0sTzjGuWI/naycDht+58GJHtSmCgP5SBONCgU+?=
 =?us-ascii?Q?NweTqusLSRGYZLMmPxqq7cWo5mnAzdfNGLtgmpoLTtE70edK3VkTg0b4Lxtd?=
 =?us-ascii?Q?jycUhANijYOoXAY5t+sH9XFj5EngfM+jGBeNOSE8wMvdLFAi6muVEHFLQiAH?=
 =?us-ascii?Q?M5P7fhPI0XWZBZqH/C2XxYigYu6hRe7+9v7AvodeIjjE8fp6uHBRzhYCbHde?=
 =?us-ascii?Q?I4FBvBP81MvmTEjy8SOeMvahrgG9URddQ9fzDo2Y7hnMsnAvVlbjOc3vsmwb?=
 =?us-ascii?Q?4tS//jc/1WQE2B9peMGxN4zbLtefPNw7j2zf6lSRDoz0ivGYcIHIjWvDrWsF?=
 =?us-ascii?Q?psGYJBKr86hbjVomNhgLniAwHYAf1n4F9q10FCVufqp9gHf41YtWeMOXR8YJ?=
 =?us-ascii?Q?IOGYMyjvLL82MmVsen7/yPCExaKIwr/F1xzks5MJlwXe4S5BE5u7bwoobACA?=
 =?us-ascii?Q?DEMMztFBAPydMRGYBdgpZ1fhTvlpHtxHFnAuzjfx8Oiy+KTTBgnbfSDp+fX1?=
 =?us-ascii?Q?3b14pesmPyXjQP0Yo83Geq3sDtBdgAv4YMRfkjrFwNqguhHtcU59zfnP+/ao?=
 =?us-ascii?Q?OWwB1xa721XunkmpJNUksLuEshh4hVvcCIsOuo1o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7419c542-b1a1-45e8-56ca-08dc921284ad
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 16:52:21.4277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6X4/00yMz+SFbkjzNvxomN4tQEC0stQZQlH9gJ8EDxTIGMQGIvSM9GGM07ziKNhX8M61p0Y8L03k9NqO1i75Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7937

Fman3 should use 'fsl,fman-memac-mdio'. 'fsl,fman-xmdio' is for fman2.
Fix below CHECK_DTBS warning.
fman@1a00000: mdio@eb000:compatible: ['fsl,fman-memac-mdio', 'fsl,fman-xmdio'] is too long

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi  | 2 +-
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi  | 2 +-
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi  | 2 +-
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi  | 2 +-
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi  | 2 +-
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi  | 2 +-
 arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi       | 4 ++--
 9 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
index dbd2fc3ba790e..65f7b5a50eb51 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
@@ -32,7 +32,7 @@ ethernet@f0000 {
 	mdio@f1000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		compatible = "fsl,fman-memac-mdio";
 		reg = <0xf1000 0x1000>;
 
 		pcsphy6: ethernet-phy@0 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
index 6fc5d25600571..3f70482c98c30 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
@@ -32,7 +32,7 @@ ethernet@f2000 {
 	mdio@f3000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		compatible = "fsl,fman-memac-mdio";
 		reg = <0xf3000 0x1000>;
 
 		pcsphy7: ethernet-phy@0 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
index 4e02276fcf993..78841c1f32527 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
@@ -31,7 +31,7 @@ ethernet@e0000 {
 	mdio@e1000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		compatible = "fsl,fman-memac-mdio";
 		reg = <0xe1000 0x1000>;
 
 		pcsphy0: ethernet-phy@0 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
index 0312fa43fa777..1f43fa6662221 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
@@ -31,7 +31,7 @@ ethernet@e2000 {
 	mdio@e3000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		compatible = "fsl,fman-memac-mdio";
 		reg = <0xe3000 0x1000>;
 
 		pcsphy1: ethernet-phy@0 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
index af2df07971dd9..de0aa017701dd 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
@@ -31,7 +31,7 @@ ethernet@e4000 {
 	mdio@e5000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		compatible = "fsl,fman-memac-mdio";
 		reg = <0xe5000 0x1000>;
 
 		pcsphy2: ethernet-phy@0 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
index 4ac98dc8b2279..6904aa5d8e547 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
@@ -31,7 +31,7 @@ ethernet@e6000 {
 	mdio@e7000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		compatible = "fsl,fman-memac-mdio";
 		reg = <0xe7000 0x1000>;
 
 		pcsphy3: ethernet-phy@0 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
index bd932d8b0160b..a3d29d470297e 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
@@ -31,7 +31,7 @@ ethernet@e8000 {
 	mdio@e9000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		compatible = "fsl,fman-memac-mdio";
 		reg = <0xe9000 0x1000>;
 
 		pcsphy4: ethernet-phy@0 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi
index 7de1c5203f3e2..01b78c0463a74 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi
@@ -31,7 +31,7 @@ ethernet@ea000 {
 	mdio@eb000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		compatible = "fsl,fman-memac-mdio";
 		reg = <0xeb000 0x1000>;
 
 		pcsphy5: ethernet-phy@0 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
index ae1c2abaaf362..b0390b711fef4 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
@@ -67,14 +67,14 @@ fman0_oh_0x7: port@87000 {
 	mdio0: mdio@fc000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		compatible = "fsl,fman-memac-mdio";
 		reg = <0xfc000 0x1000>;
 	};
 
 	xmdio0: mdio@fd000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		compatible = "fsl,fman-memac-mdio";
 		reg = <0xfd000 0x1000>;
 	};
 };
-- 
2.34.1


