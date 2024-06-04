Return-Path: <linux-kernel+bounces-201561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB328FC003
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700E91F24721
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D217A14D446;
	Tue,  4 Jun 2024 23:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="MjOlA5XT"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2093.outbound.protection.outlook.com [40.107.93.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4482114E2CD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717544333; cv=fail; b=pz9CjMZU68HULKFb7GF1dePKmDQhFF9+YuI+sYCnLzEvNaKdfRa8c3H/ZNFuoTvTvSplKKJeDrSSugSc10z1+VVIFx5mPZyvDNGsyqUE7TkQHB3mI1jzuk/H5MWI/My8c1sO2q3X2oNmKRTpUrDDI/ysG/hRojWnukV1+Ue0HC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717544333; c=relaxed/simple;
	bh=+8bUpDyxA3JF99k0J+vxr6/tIBYyhePovtznGqMz0rQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uxunIFhoAOEOpJ5A1QioaOUP36jEG+o1KlLUNZHFu22GQeC5U79JGYSkRjhQAF4A12O92QS+0l/U8mRf72c+edh49PXKD+VIraJAey4yAyllDFsYtIIeXRTi7ocww4UGVYzsI09dkHr0W5pHX1Gk8I990eEb8Z7l8pUCTynSids=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=MjOlA5XT; arc=fail smtp.client-ip=40.107.93.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Egh9RtpeumfeN7CaF/dOfZH3JFfWre1dmqcR9btZ7wdySJrc+DZL3yoTiKV0xsS6ehcin2CtyYyZel9eLNnK4hTEZ6VMeDutsVc+QfAAi5XvBxIc8M0At7/Y6ARjJkno16q7L0PSYkhF69CG27GAhC7VHb5zZIq/FLmzciUoArFa9IUGtK5xcIpkUGrumi1ajc4KKNXyYusIAp3je1Nk3nxCkVTdRsnkaMLfRNt14JSqP6e5h65Tct2CxMmraHJnSDaGftnbZZl6mjxJr/erXHmNchQsGJ4qI6Y0OBbw2GYfM9NY+njAUUnCLbz1jOgKd6WA36XRd5yiaS6Jm/UnSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uD3/gnieQVO0L0cqnZApKgnqUPotgHuuoVTq4SV428A=;
 b=UK2t7cOvkZeIpEuY9E0Af9zaplTNJ+RUuGPmY/t2Bnnu69B/qpFik03ZbtCbKHzBT1CIMyD2+EDVq//8hSjmkTtRkOPZcDmMHm/7UKihq7OvIUiIDxMZigh8HC2scilhC3P3dP2MGD2FHSTnWQI5yr/Sgw4y8owF1zaYcsfr69B/yy4pcaAQqKokFCVCCO+6vb/N3SWUmxt0bUKk1GzgcMjwFFikyY/5CB+Ir81CkHHppMF1xjYAFD+koceHpDXCeJaElsaocEnsUBuIQQygJ9hx8fzcXTj2d+TFf2kiq/HyII2Ntj9/+O3At1NcQltTsEeowyYmC9n6rH+DGOKNpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uD3/gnieQVO0L0cqnZApKgnqUPotgHuuoVTq4SV428A=;
 b=MjOlA5XThKRNhodGP20nEe7YML3g/qV8rwnB9rigSWO3bkIEcRZmVkDjRe/KA8xT+Juu9ypjt9NLxj+29ac2SooF/4Qk6VHk0ZUQDzz00JiGtjyGm/SJtsZ1AztwIm2SXROrtzURg+ENnQ4T1aUFdCZIoHind4+glLJMNJwZjCw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by LV3PR22MB5146.namprd22.prod.outlook.com (2603:10b6:408:1d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Tue, 4 Jun
 2024 23:38:48 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%3]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 23:38:48 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	quic_bjorande@quicinc.com,
	krzysztof.kozlowski@linaro.org,
	geert+renesas@glider.be,
	konrad.dybcio@linaro.org,
	shawnguo@kernel.org,
	neil.armstrong@linaro.org,
	arnd@arndb.de,
	m.szyprowski@samsung.com,
	nfraprado@collabora.com,
	u-kumar1@ti.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH] arm64: defconfig: Enable TI LP873X PMIC
Date: Tue,  4 Jun 2024 16:38:36 -0700
Message-Id: <20240604233836.3628063-1-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR19CA0007.namprd19.prod.outlook.com
 (2603:10b6:610:4d::17) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|LV3PR22MB5146:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cbc09d6-d140-44a9-4600-08dc84ef7b2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|7416005|366007|1800799015|376005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YUXaMREGgxS7yd4eYiymVgF3fLllDnti2lKvrDeiBtwmnE3tjPHvrrUePg0R?=
 =?us-ascii?Q?s8uoZzhOIKqdxAkk9sx5yfIKdAidVDsxtELJOHT3JMztpk51hOy7JN1XmTep?=
 =?us-ascii?Q?hwxlgcjAtfndSer0tzULrkTComQrrvNxp2AQpUfFPNNu7mbHucxmguog5Ucj?=
 =?us-ascii?Q?eTzreVUKQpOaE1fdixTETeXggSfqLZMtY+w87USfiqtGTgM7yW+nRoH7fKfe?=
 =?us-ascii?Q?dEY7fAtyy0yCdCAq9PNYF62oQyI/PvpFsYrAICHfQTSlejoIkNh0VU1bPQNB?=
 =?us-ascii?Q?bBx2xGrQw7twrOox6aQYi1NCA4ZEjngCTyhZlOTmk2VjXtTO8ysJBbhrcrnl?=
 =?us-ascii?Q?qxpCUiBtWviJtj96HdoW77nfn+g8SJDP5sdNxPj2QoZn09xKM8oRkJq2tv7x?=
 =?us-ascii?Q?olSRwFm5M1H4u7LSjPuCBhq12YDzZHvvv9ux2SKEg2MT1QmMDQvLN5l+y/co?=
 =?us-ascii?Q?PiLKyHFnxIEZLtGZkb7WmAZ2eGESThLFfDar0U0z2g52sxBOmRUV0fhkKr4b?=
 =?us-ascii?Q?p/Y+YFP5TEXziv7SYClCiN2FGSyeYRnEO7gpvKMYz57A2ufHRH4fclQGVOZp?=
 =?us-ascii?Q?85Ej3IwKS1vrLXBYRhFQi5BgDllZAtsXVdstukVeJeDSGuFkLDOehXwYuiTO?=
 =?us-ascii?Q?XCEAdKnWHK/xu57lb9ELlXLztZ7B9zy0+REff/A01h6ruzsWUiJx+F0LPOlq?=
 =?us-ascii?Q?IBt4w7212UQ75ibPNRwsRaFXemj8Y4agvK0ViJy2QMMyei0wEePAKz5xQEr0?=
 =?us-ascii?Q?4QbbTvK9BrXmD8X+V9/KNDLJTjMgcxlsUO/2t19gRZd2dgmiDiQeA2vkIJp3?=
 =?us-ascii?Q?2KxEoQTGmJNZetkdJwRxUCOEwIoollE02+y48TOfvQmPKjlIGClkveWdSIeP?=
 =?us-ascii?Q?4FXzIUfC8hdRg0C9h3jcjgNku30TR4oz2pV02sXoYaHYt/gN2s7WqGEYlQQd?=
 =?us-ascii?Q?3za3HJ2im8CM6cWkhUNulBze6V3jtCxnAAM9JfWkB09skim4xbQNHo760P8N?=
 =?us-ascii?Q?G6h4TdSkiQYa6fCy0YPYAp3KaLSesbS09NmL2K/uN11/p0QmY2nn4TkTz2D3?=
 =?us-ascii?Q?tHJYxEAX0kbefPMdpmcNV/IplW5aqki+tXUEBTLwwHupy/DR0EXBpnv7A9Cx?=
 =?us-ascii?Q?hv0ysTHcfLjBMS/V9wGOElQLiIm1/RIK2gThot0b7NR+KwgvbmuEphZhWvLM?=
 =?us-ascii?Q?JROP0IG/VzVoLBHyOZOM4unG1iZRD4/dTh3qzupunQc1vxzaPn40fhlFOMk1?=
 =?us-ascii?Q?LrBHKoaGHEfb8pb1JATPlEqxpC8yt+FImWcxz0BKEVKKMqj8tJVX2HVqQtRK?=
 =?us-ascii?Q?5t1YNCERMg3PiSjIlftuna4pWZ2+BVvXsfd5hU48HBzS+3KbXJe0s5eI1ftU?=
 =?us-ascii?Q?tdCoIrg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(366007)(1800799015)(376005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O9DGgx+i7oFpRhlsZuXoiq2LBlyimp0HiIdcO198oJEkqAvGoARx/79V8J6q?=
 =?us-ascii?Q?sM/VP5nePl+sM0iuIYsh3G407Di8GU9/lX9Dd6KhvA3R2MMd6DPSOw3ZzWRX?=
 =?us-ascii?Q?1ewAGZWGgynzuezElYY80n9O78dLsjQcCF2PI7rej+AfON/o1M3f3DveSp6Q?=
 =?us-ascii?Q?bpp4fMn7rZT+OaIxObEDA/TEB0qqp+FozKthzktUAY2i2ryKtxJRooZIewDu?=
 =?us-ascii?Q?bFNGfZyXowG9mfXSLyfOvOpdOWyKipiIcjV/f2V/JW9ALfCkIz0g9kne5fp7?=
 =?us-ascii?Q?OMg/gmyM43XjnMAdU7JqQxsx+jK758ltxE79VTZaLdGKSYk+Phvd1Dqd5867?=
 =?us-ascii?Q?4GLXxN/Lo61VEHPl2DZFjos5AA2/jwvSlyHfLAzIGMV63ggo5KGITovSgeQG?=
 =?us-ascii?Q?aTaMl84DUEE9J07zaUxosWbXidePw1424t0eui18fbMJyS/yTVIXej+YcifH?=
 =?us-ascii?Q?aRlsXDVqMnqwr6v2IyEkDia2uyc4oG6LFFJPEwb4B+c4SyRvYjNFFB8f9NVp?=
 =?us-ascii?Q?CpWLkoD/4/jM0VZX3vDEZORD6YD1BalZ+kMIaHn4XzsGCBIH69FgzkM7Xp2D?=
 =?us-ascii?Q?bt38QlA6Tng0ayWi/x/S7EkUxfpLFyUK/wA07dGDUkH3djGckIjNLdQ63xJJ?=
 =?us-ascii?Q?FHHnUzEIxN1W11PyCf0eGofD6f8B61Upl3buQlCCzNCneShekfUD2b17+ZaW?=
 =?us-ascii?Q?6qafg08LQTRg00AC6oBDLxQYkVsEbof9y/E0RRpoTtTemfDZrwxvhgZzFtA2?=
 =?us-ascii?Q?OmMqS77ppR1wZ4LE9nxMD5YgVXRFpyaPPaeC18AERh+DKlJXaiBs3/vFSBCa?=
 =?us-ascii?Q?UnE7W2utXV5r1vwywyv+YmIYMIuIf4VTXPH/qXGcSvXSjEUjyg9NoV0zvBf2?=
 =?us-ascii?Q?CeDQmYbHXsgzWHtzcKyZ9VwRJFuNNonamvjtE34A6X0vB66CqsBqHvJHYXHl?=
 =?us-ascii?Q?Q9yPn7OCW3zMRmNSj+BrI0yYdLLDJphCb6K4dKSQFxcLGt5P2lk+Jla1FGSl?=
 =?us-ascii?Q?O53o4W0GyxoooGWV9EwciHQ8vyqCx/yqw/1F1VkwyvSUdYzXXTZG2dNz3xyA?=
 =?us-ascii?Q?muDYOVzzNyb2iSgNYzfn1pAEhS89XBvd4w1P5XdvyOKX66YqtwAiZSVNTpQY?=
 =?us-ascii?Q?8DtjX+kQYfKpiOo+IadrwwPMYyj8P3v4CLt06XjYRaLvtjCQ0yNlI7I8tdRd?=
 =?us-ascii?Q?42kHY8c5zw50cnnM9Gji8vuRs84i0BBA5FonhQYADaLIB5mFuz4FeL5oiZm5?=
 =?us-ascii?Q?lq33Ah31RGJNO3cy5FUOfIAKJyzJflvxSGDDUriJ5vdZNcD8vbNC7y9cdedY?=
 =?us-ascii?Q?7+LBS93sshNe4qsH2/TTpRlxeX0bkCfJPw+SsfpNZx9Sh+Xtbe2xPwo2ox+5?=
 =?us-ascii?Q?JiELCh1yrUuGmu3ZFHcbsQD+yD1secXCh4Wix0Lm1uyrsrXvqI9Pks7R2w/B?=
 =?us-ascii?Q?JN1XYFtZ8V1TEFA6QtC5Hk1TX5QbU/7DgryJSLawXsowI3XZhDV8g0NkH9xP?=
 =?us-ascii?Q?14Sa6pU/3YTI9i4LKuAz6ZOTQwWWjzuIFmG5YdOL+v2cHrGYnBYVR3FFv8iw?=
 =?us-ascii?Q?hwM53MD8ERiBWTR7AmyzOBsN1vvaRIj2QNroIa7u?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cbc09d6-d140-44a9-4600-08dc84ef7b2d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 23:38:47.9951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qx+KrbVWsTlS+kOjvT3U5F2LTjKzDywXFdm1I7r1Annele1e2oPMvzitkELSaKwzpknl6Ao+ciyUDScOQ0nRyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR22MB5146

Enable the TI LP873X PMIC configs.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 57a9abe78ee4..24ea62a8fdbf 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -745,6 +745,7 @@ CONFIG_MFD_SEC_CORE=y
 CONFIG_MFD_SL28CPLD=y
 CONFIG_RZ_MTU3=y
 CONFIG_MFD_TI_AM335X_TSCADC=m
+CONFIG_MFD_TI_LP873X=y
 CONFIG_MFD_TPS65219=y
 CONFIG_MFD_TPS6594_I2C=m
 CONFIG_MFD_ROHM_BD718XX=y
@@ -760,6 +761,7 @@ CONFIG_REGULATOR_FAN53555=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_HI6421V530=y
 CONFIG_REGULATOR_HI655X=y
+CONFIG_REGULATOR_LP873X=y
 CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_MAX8973=y
 CONFIG_REGULATOR_MAX20411=m
-- 
2.25.1


