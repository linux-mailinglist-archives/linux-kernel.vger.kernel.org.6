Return-Path: <linux-kernel+bounces-294848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B63D4959353
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 05:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EDB7285C24
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 03:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE1615572D;
	Wed, 21 Aug 2024 03:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="P3Faved7"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2055.outbound.protection.outlook.com [40.107.255.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D0D3FD4
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 03:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724210774; cv=fail; b=B7Ga8ulawqaFswJ+o81sgHAwjKc6Eabl9Mzcejd/Wm42mefcHDQEoAaWu7wfY0Ia7OUaKhTcNbv4wVh/uh5eb6wVdmGPEgLJfS3IP7NJEZHRkeG/pwPiJzMZgaFhchWd/j8mwylj1ALYJ9L4zYXwYWmAMWLN9ejEzasQNdi5mew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724210774; c=relaxed/simple;
	bh=/9QYQ14Hi4qv/Kijo3lmdNwKscfn7IYVEKGRAJvMQug=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ne4EzEltV+glxsHOeMAD1mPOLs0fzKfeegiJOTGzpbSAyzDhsnlm2zXH5WiCHnf2b3NQuMRXnuplZurJn1LRZsV390XmqPHAosZv0H7ftTTQ3G6YfAenjiofr6AsE4nuG2Phg2/5eN50woei5Lfw6z/JQAVoQmsVGE1Ugsqzz80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=P3Faved7; arc=fail smtp.client-ip=40.107.255.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWKDWWhspHlXIO/kwnPJNghpd5vyYZtRMjb4Tkid1Pj/o6FudwcZ3+cLnPlcJlO42bgylgYM+XHoSBnhLtRIyud60Q4TLZP7AUVzR1NVkkL7N6rouUP0ec9C0PSLwEhpl8W10Vx8cc6KDwJ9za3sArs9+OHkTKTf62OS5tmB5Cb3KvNfy1y3IJtavX0VcfJKX/JIfbFcuIrB+T4DzMizSkwl0JZbsEOQVtSaYndH9Y0JFkaaNBYr4lvxPH5G8iaku/L41oErK4n94ot6GTyo/jssbse97TT8oiw5/M/05RzEYeWjfdlMT1Ri0vVmHQtp8nG8Hk/sBNgkevhcyeB+8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvzD31dw3AB/vn89/L7KWDNEv58BtWPz9s7g3AZ20ho=;
 b=fL2JkyORoYXEQObTcjroftO5KwKX2nK9dFj7UcBE96TI2kEWL+T4MM4SPxHp9YeqfyUa5JwpfYqoggxweSKVZznygxoQ43tYKNuKsgPNcb5htr21eG56gqfCEMeT4HWqRef2EWHLRBABGttq5/NY96nZ3R2rsLVmWJX29BuFFUMP2q8xhJygL/6bCSSLy7TwklzcDo2UCZxGQYQOk4MntBZgWyRxc+nbIlsDazXndFlbWknetSJ4DzM8uBBSshz8mYC0AIx3aeEUcHO7qgfrTKAdgH/eMxKq/r3BOQe31c5og8uqAVRR2EE5L34u01nHpXZS7Uer9i0l2XAINYiECg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvzD31dw3AB/vn89/L7KWDNEv58BtWPz9s7g3AZ20ho=;
 b=P3Faved7VHFudWndfUiOBAUgo/FOP34FxGbKuZjqHQ92Z7vRfmQh/iOf9z4VAQ8995cF2B+286X8Da5mb0/N7UwMZEBlae37/4vcAmir2tVD3CRJbu1KfWVTeZlwHk9Bj2lJ9CcWl7z90dLX4A3vBjoQpfJ3zLNidpoqbB1srOUiFgsp9DbpDtBGCf+qH6rrJXj7Kzokowry/gzuYxW45mrXNx91fJURKCJzaqW5NNpKoZenwGWVtxzcz/AEloEoDI54Z2TyJAmvyfQWwGWtrOwOS+upKeRvuM0GlwE2MN20QhXVcvFZudAdv1+y0qiDoyF2Exq6W52m4szxo6CKWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB6618.apcprd06.prod.outlook.com (2603:1096:400:462::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 03:26:09 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%6]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 03:26:09 +0000
From: Rong Qianfeng <rongqianfeng@vivo.com>
To: Yong Wu <yong.wu@mediatek.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Honghui Zhang <honghui.zhang@mediatek.com>,
	Joerg Roedel <jroedel@suse.de>,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: opensource.kernel@vivo.com,
	Rong Qianfeng <rongqianfeng@vivo.com>
Subject: [PATCH v2] memory: mtk-smi: Use devm_clk_get_enabled()
Date: Wed, 21 Aug 2024 11:25:57 +0800
Message-Id: <20240821032558.43052-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0011.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::14) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYZPR06MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 9948e6d9-fcb2-4c42-ad80-08dcc1910012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pe43iyAts2u8zi0wCfGRoNAe/O723ZnvuUFt4zZl0Ay+Cpyff4RRu55rsjAo?=
 =?us-ascii?Q?Wuo1YWGzk5S2/Qu3AQ9oZjbw39VK7KxnhwCBaecFot+Cu5elUe7qFVF8rS8c?=
 =?us-ascii?Q?tuT6LEHt/lfjumBeUv5TmBDV5Ya4hlWqENrLWOi9kjH091jpzxeu7RwTM4jt?=
 =?us-ascii?Q?Q1JGr5jPRIQzGzaL6L3gsTdRCb1IyWp6FZel0HN+QlSrqkCwMKFI1EhzlQmn?=
 =?us-ascii?Q?QhW942iQrVp5mtxXGPncio8u796Xki0Oy+3gruFgeHRkaOSspcZlR4fBltES?=
 =?us-ascii?Q?ZDGiDG2hkJHu6OgJhbsh8p/vzN4Pin9VzQMugQs3Dwme9AYGtsjwrLsWGFDE?=
 =?us-ascii?Q?V4xYSiCXuwdmZ2wDODyim0hGrCs3unrwG6vlegEjGRC9qCqjPbIAcnmyXEyB?=
 =?us-ascii?Q?HcpNnyIFG7JuJc7yOcmTRfAPejv0ZkNWt03vrHWWFLY57wTCG7s9kJnfUT/e?=
 =?us-ascii?Q?uFnc4PynKQYvVE+PjsQczdv/misqgjDfPtExMyhCyskkxm3WOZCzteiXb+uN?=
 =?us-ascii?Q?hJyjlkIieynsnU1LJMw2wxdlslfQU/dIQaoi/cPymHlaczoQUUuzPGoV9db/?=
 =?us-ascii?Q?NuLVf/S3bS1sIvbCw5k8ja8fqBr2X1qZmjuBeLGBsv9mo2ULijpTKU9W84Rh?=
 =?us-ascii?Q?B6oZ6sxlbBCfRcq50XPf9ZyBFx4PogcDA3vrus0RBoDC6elreY41rLTNjjfZ?=
 =?us-ascii?Q?tm/k43ZL6MIHGqM/EasFzDvUu5Zd2Keg89TgOI8cRkQN9vj2bfGV+igQ8AWd?=
 =?us-ascii?Q?170U3D34SD+NQ+z2+BwLtC92r3Z4Yzb3novEhvRFAr3RvcUWhlQUjLNym7F/?=
 =?us-ascii?Q?r0n/gTEA2ApGV/DC0Vvsza2ttKslU0I5hsMF9ocfYJoO5FkOJehuTUp41clm?=
 =?us-ascii?Q?QiOEcYNWT8ezEM63706gII+BJrgwdXX16nkKFrvAXqtyzLpirBBFo6AW4zuL?=
 =?us-ascii?Q?fYDwCLaJBLnx1ZDYmoB/UtSYkkx3G1gKu9Sy1jw8DS43rP4tDj5s4lwBBwlW?=
 =?us-ascii?Q?gFONkuDljXVOrF1AlcXk+8/20xI7nHwvXevt9z6Z59WxcGnyE1tZ/zpJoaB3?=
 =?us-ascii?Q?AaoaVpHg4muAQ081mEi8vXd47uk9x/AUWCnVcL/d+y5TM6D5IHLyT6riR+ES?=
 =?us-ascii?Q?Apbjic8FLNA1DRMa6nH0e088rf2RZ7ocVQfCut1Hj1vT7u1Pfq4NAfhhhiFx?=
 =?us-ascii?Q?DqcFU/ICGVgQPBz5FimrSSbQWwEJXNUD2N2+Vtyjc+FZkX/ExfH+pxH+H0V2?=
 =?us-ascii?Q?uKkB+iXafl+tKmpHOkLoV7vuQIEzL/LfnwTCDDpQShfOrDG/IL/rS36iucYn?=
 =?us-ascii?Q?gMk2V66yyRjd0c6lhxY/bVXiMhnygAxdcjPl1iBSk7P9RMs9xmA0ZoGJd0Yt?=
 =?us-ascii?Q?b2dmAiTdl5jX3yrUVLqeyR9GYBnCG1HqxJO4/MzBW+87xvc0TA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UaeoULaLHuh14EkNX/fR3K68hBFWpNnPlm8EmAfAgdyN1rYKZdlaJpc+VkFB?=
 =?us-ascii?Q?Zkvn1IPMnIbuZM9IYawPJ3x96ns26SwZMXwPk4BeZQmDZba992HlSBAGy78C?=
 =?us-ascii?Q?kPkDBP00WFXlopg8eB+nEDbJkNxDcTW7LQxEkDLREP526xL5hwApL34/viGh?=
 =?us-ascii?Q?mdIH6C9KS5KLNIuwOEz5SfIs2JuBcElsxvga4jRHq+9TmtM91uU7D12pAX3R?=
 =?us-ascii?Q?4/Z70dPwyGUoY6LzWrIjp+QFZKut2X5KG6z7HeSyE6R3mnXCsYZesFF06pTW?=
 =?us-ascii?Q?B2yanSpfxR41DW8B9r/lR7DZLVzE8cKeNV8xUYSXZ/LXbk207pKcCaddqNv2?=
 =?us-ascii?Q?OjJbep3aLWQlrPTusZIj6Ij9VsqxjqnEf6YaeHUt/bhPDqzemxXHcq0QroO4?=
 =?us-ascii?Q?QNzMwZEu5f6fsYZ5j2GmEItOURp1h5yGDniuOf7Vnu+gYRUNqW6LaiZkKhEU?=
 =?us-ascii?Q?yz6/de2wi8phR5XNxAvUuhdGKp/vpTqgpn0GSkTobDilZB9pXXw7uArrr6ue?=
 =?us-ascii?Q?W7mSHZORdFsGf94aIgJ2fSrops1VXSvhZnMPq9QC28lFb822IIm0vV88n/0N?=
 =?us-ascii?Q?ttitREhZZ7Fm4dj8tc+5irzwZapWRRsYlylW4366OewWrOzMb6Uhs9RbkgbO?=
 =?us-ascii?Q?TZnpHVDC/PLFcmya1IL6SeY4M8TLM1OpsG99e5IP8o7Gb4v2mXYev6b3NWlZ?=
 =?us-ascii?Q?9ZJuyfvu2Nygu+gRaH8spmrki9GT9wWuujg7e3EOJT0MolN5+pmAPAUJ3SUh?=
 =?us-ascii?Q?uPoPniwe6AT3aRozn87sYVOHzA0o/psw9DnOZtTUQqxyLhLpTy+FesWga3w+?=
 =?us-ascii?Q?djOcAeASZdvdZ7Ylos3M0ufftBxMdh8h/YcIT5jFxYVaWA7mh7A9ADQKYypm?=
 =?us-ascii?Q?DHyqYslYz6/4RMp7r5/PgRKQlF8fwHtUIeOajJT2t4S+bXNMb1BZB67p1GZ+?=
 =?us-ascii?Q?bG2tviIdpvJIqo/7AOR8lO8aszRIxBbqVOmb3Tm5gL4tuwWT5u0qgTt6/MZv?=
 =?us-ascii?Q?IOqaUHae8a0KoOBM71suOlkMti02o0KtSpSpEehYqGUAcyNYsC06AMT0fNW3?=
 =?us-ascii?Q?QeLG+jQKXSDjDBTFNHwJUDxEIpqZE7PEbpVLZmPVR+jCKoAJX8nq75Y2TSE6?=
 =?us-ascii?Q?Abg2EfLzfaKCuan7QOMhZgwMJoU5HRsHEZCsRrSbXr0X23p6vDzwj3WwONun?=
 =?us-ascii?Q?/dZHWauBk0KoHFA3bVDEqeNt4Jk9bcJdzqt1I9TfWDzT9T5NL+ORqOPZYev0?=
 =?us-ascii?Q?Wuz0kKYc5K9tb7KUg5ncNL+vJGyYsDQ7Wz1/Kjnx4D9UtAhHVuPH9Qaqe5aO?=
 =?us-ascii?Q?EcmgwCEP3tnTWGwiHPVHfrrLauhZXZgsNHSgbC3jYr1RyzqC+IDRQhNUVgvF?=
 =?us-ascii?Q?I0vxwsWfF09sEWVZtkDlLMBcTtitZSaQ6GSIOemxcNFxH47q+lBIb9X0V+E4?=
 =?us-ascii?Q?RMv+hSiEFjgLDwV+CwPBaSXffwCW703l2yAXDkP5O/qEwGOsc/Ddd0jI9XDo?=
 =?us-ascii?Q?T1Xdiqs3b6jmcsoO35aMA9LR+r+no/a0Rct0KzZUe3fU9MNbPQGr0xLTMHmP?=
 =?us-ascii?Q?Uy/C+uL94oswz0KzU2+upOf3TO/pbRhUOSIhBtUr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9948e6d9-fcb2-4c42-ad80-08dcc1910012
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 03:26:09.7421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFCCRrFGboN7zHtso18rpe6ryhyGyE+g+bwBX6wldVsIK0HJjEf5vZXpPrwzd5+bGyKuzVRTejOqxFq0pqyXig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6618

Replace devm_clk_get() and clk_prepare_enable() with=0D
devm_clk_get_enabled() in .probe().=0D
=0D
Fix the bug of missing clk_disable_unprepare() in .remove() by =0D
using devm_clk_get_enabled() that can disables and unprepares =0D
it automatically on driver detach.=0D

Fixes: 3c8f4ad85c4b ("memory/mediatek: add support for mt2701")=0D
Cc: honghui.zhang@mediatek.com=0D
Signed-off-by: Rong Qianfeng <rongqianfeng@vivo.com>
---=0D
Version 2 changes:=0D
1. Modified the patch description as suggested by Krzysztof.=0D

 drivers/memory/mtk-smi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index fbe52ecc0eca..2bc034dff691 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -771,13 +771,9 @@ static int mtk_smi_common_probe(struct platform_device=
 *pdev)
 		if (IS_ERR(common->smi_ao_base))
 			return PTR_ERR(common->smi_ao_base);
=20
-		common->clk_async =3D devm_clk_get(dev, "async");
+		common->clk_async =3D devm_clk_get_enabled(dev, "async");
 		if (IS_ERR(common->clk_async))
 			return PTR_ERR(common->clk_async);
-
-		ret =3D clk_prepare_enable(common->clk_async);
-		if (ret)
-			return ret;
 	} else {
 		common->base =3D devm_platform_ioremap_resource(pdev, 0);
 		if (IS_ERR(common->base))
--=20
2.39.0


