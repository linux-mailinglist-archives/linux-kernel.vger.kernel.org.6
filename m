Return-Path: <linux-kernel+bounces-296720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CF195AE38
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF479281278
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D5C166F29;
	Thu, 22 Aug 2024 06:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="fKF6zbyG"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2040.outbound.protection.outlook.com [40.107.117.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030A9165F10
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724309718; cv=fail; b=tVTlSJNY9WVFe3F7cdgjnkM+u3j4Gzv9JgaGPQElzGrT4ad29c92Zei1rD4ZHFQtbOBBSDlFcaZ6TMT/Kk/E11M+743t8KA4dJbcuXztukXapLoPIohd0XGMLdFm+1n5rFubrYp6JekEcxcNG6RLRuK/FjAS8HDGg5gwrB02zvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724309718; c=relaxed/simple;
	bh=35spBJUt5DeCgSAVWlbjWIBx2zduK97xR5CtexQ5pfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZqWLbvcpUdjO/fzfx3A/EkkuN4DpMrzJSTJlLbpUSoBpd+ygR43tdvBptO9iQyQLCbyo8a/5WLh7512UPrlACG/hDMDbcz2PCZSDyGlYWG+ZoXcHpiKaa5j9tnNRE52i+s4wzLEtbW6kIzGOtlvP4uhhzmAMaoIv603KfGY/4LM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=fKF6zbyG; arc=fail smtp.client-ip=40.107.117.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/kINyrt7h9XBEqfij7sZeJTp7ErmXFBDNNmLUtwXsaswDqiMiSALnGc6IJOUaSQmHsfgjemJ7pXyRcYbl62iAQOSzgCRxu55T6BfnyGa6buGCS6QIMYApcqTXGn596XDP2A3uwMP84ECmT/3wowiMnAFr1P4nyycHzQhjhvoqf576lGuWhkgASsasZtaR4iN3cwP1MZrGuugo8AC/3ARxng/S09hsNJj+K8+7CTHM8+sSGJwC7gsNTdIZzTxq8e6sh9boNks51vABJUPh+sH6QUsUuoaQdo+xgfn9wReQfLEb8XJpuM4IWZUsTXs3zfaM64w4ajpITrAwzNe6babw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPHFiCX2D8HefJU2ksWv8ccMuI1S9KxOQ2E/bdwcOTg=;
 b=t/9sw+UlzsI+kRuDpvGWl1F8im/MBTfAnMkRcKMz6qBfyyH2W1I9Uvrym26SE2PUgN40gsPWpUtTChsafqX/EtgT0KcT+tmRWt+xGIgSxeFnqwrCZn7oFMdPs1RvH+LzSnQk5C8muNaOXLHlZCndOHl5WAtpPn8BP2wy8nU8F4KQGnBvmrDJP1ABcNvtKfMQc6Ej4u0t28P08PdD7IYTP1a9IVegbV19M68oaelCGQYhelIMQQZBpNK6RYUYPyo54EuaCw0pZwzNXF9jH+R3mGnRJYZh9uqZgHhq7Ai3+SQBX7HFUVG1Zaac6zNLwEtC/zlhLm1dxAV8YU/sMD7vXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPHFiCX2D8HefJU2ksWv8ccMuI1S9KxOQ2E/bdwcOTg=;
 b=fKF6zbyGq3B4GSXOouOfyB+lD+RDl5kWLzsC8PllOcLq/hSzQhfTI/16Fslqek88/z+RaPOKFuvpHH9hcPp08ixqLZaqImC0LhTPNuXt1uWhAP4m5Nzk43mDEHQ1WzQrhSqIMfgFRMVVSVCK5AA36rhuxrcc99pRTgQ9E1bHjcLR89Fojw4iuvvoaz01Vccj3FJX+M7VeB/BedrSEvdXFfstsorAlvWz0KBN61DZkyd+Oec+Fftsjcwqk/q+uASsxabY/51f5x42i1cBkJHE3euMCMbxQ3SVLnLcmLnNYIU//lYVP3XyQp5Wt8wKuO53E3n9d2Q3H2gqSp0RGF905g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by PUZPR06MB5982.apcprd06.prod.outlook.com (2603:1096:301:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 06:55:14 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%7]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 06:55:14 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Leo Li <sunpeng.li@amd.com>,
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
Subject: [PATCH v1 3/6] drm/amd/display: Use max/min macro
Date: Thu, 22 Aug 2024 14:54:44 +0800
Message-Id: <20240822065447.1333390-4-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822065447.1333390-1-yujiaoliang@vivo.com>
References: <20240822065447.1333390-1-yujiaoliang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0094.apcprd02.prod.outlook.com
 (2603:1096:4:90::34) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|PUZPR06MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 767fe392-d1f8-4669-8a05-08dcc2775f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bOinFU7tmkzzMIqaEQ95OfADBZrRB4d0iIshmTapctUq78Fw0/Ya4HqfDs3A?=
 =?us-ascii?Q?z4Dn8QdM64A/P2BUOnl7AbPNDbP0GCFcTa/u8ppgwY/f+SN5fv7q6Xi3to62?=
 =?us-ascii?Q?hr+KDjCCfgcQ2mMVhVbfxQzHNzlkMRlIcOF7IwWibspIZhc3j/GnBhV6bLeS?=
 =?us-ascii?Q?tTWwJhw+J5FrOT3+1eF+O7c1mp/qhkbmoJbTi0AYfErHsWQCFReawYiTGPVH?=
 =?us-ascii?Q?vUtG1eIM4gOuMP0iJnbSr1shFCkVfieoyn9xVxvq2djB11HONBZqQ7mJ0ksp?=
 =?us-ascii?Q?yjq5vXgB6TJpEo0f06e/UIMpCWwW7f3Jro25fPlmV9neaFT1VZ7NHJ1c6zxa?=
 =?us-ascii?Q?UP1eMeXpUvYfU4dtae7eqeYhN5az7FxrIUwO1mbYOKFzc7ycTyqND1jsTI9i?=
 =?us-ascii?Q?Y0d6MBVEblQ9B4+XqG6z72kTnASABg19SYN3/pD4rAU4gN0cWr+NvdqOJdYX?=
 =?us-ascii?Q?e5KrU30QP54d6lwdtm3L57s7JDgQuAIZ4sgOf8KKBWCmc05B09KEDc+mDbVj?=
 =?us-ascii?Q?8fzSOT/9eH/ueA9Uecesr98W6aZQbSrsU+RGtpPP0sgPr63czJoz5QC/VtT8?=
 =?us-ascii?Q?9zcJdfb/aoUGx4bhYSqEhy+HkChV+MVZlHBllBVxyixv8QxoMi2gbGi2Peg5?=
 =?us-ascii?Q?l9QV+8EkCNcgB/Wp3vkqOfRZIrghfJS0cEjdg4dw+wXrzAzk6UhZtwVwjCWd?=
 =?us-ascii?Q?8NAqtmbUkouRECO7EsEVFnfUuCGL5mEZoC5rXojOKPkh2PNXr3QW3YfaeLzf?=
 =?us-ascii?Q?8B7KASOCOKAhxlpUuIpjScTwGVe8mWzUxN4LF7cYlhbO21bkV3kmdbw1TGvk?=
 =?us-ascii?Q?cFzDPqXO3z9h/EdI/d07t/8Bpx5AqNYzPVBVcH2CPZlWGuPUnUTKgQs58lr4?=
 =?us-ascii?Q?RIQwGIuw5b7Jmn+gShX3ovWmOhDkmzPA03olcPVgJ/yWlShUuXNhsXwouqf5?=
 =?us-ascii?Q?pYhrpAVTOFnkgrh2htV8TA2kRnIKjZhxp6L7RGWGGOM/21hliiGACE3Tjrq8?=
 =?us-ascii?Q?x2b4Ty3XM3yLjGKZQtuyTLvkMvMyPNb7Sw3LAByaJupNsuenWy7d4nWZSz9K?=
 =?us-ascii?Q?OteRQhJdxL1PGznp4hmpPXbXzQrwpoOYooQMx6exGHeUDYqcbMrss8NY9F7e?=
 =?us-ascii?Q?WKo7Jm9DJU336APb7pmukq/wJ0mb4wQCv+StbpDvI9+OaXsJSG5EYeLTjmJV?=
 =?us-ascii?Q?CpIg8f/CzqRDAqZ91RVoyaDQz8VNfSHieCCwlu2SVHDWqIL6JzAWzyLareMj?=
 =?us-ascii?Q?JG5gad2pVS7OVR01jMUbA6PZLb4TuIXga8mJjJIKX0qaQ9kP+uQMqzBQ1moc?=
 =?us-ascii?Q?O2OJRVXfTMphZ8xTpDz5HsTcwetaDF3SVA9ETFpx88ioQ2a+A/Q7D2mt4qMh?=
 =?us-ascii?Q?2RVq4G2T/waIJ5tWfORxbBKLxmxI3yXKKnIOMRE/SN/6j6UY7T87FHwt5LOu?=
 =?us-ascii?Q?DO1dlGCR8Cg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S0YAj15mDkMLKsM+w+JZxWyvXaefIp7j5B3i0VzjMitobhr8RUPKOIzH3R+s?=
 =?us-ascii?Q?Ndp6x2YjfLKzHt65lXaPR0AGrlqGutJOwtAiy8Mcx0IF1VXVG8rL5Nt6ElXc?=
 =?us-ascii?Q?U0I4uBhNVGw7ultLvqR42uPt7wATKxQRX3q1qCQ12UlOBBv+dEj16F8HgXI1?=
 =?us-ascii?Q?6XlraXSw5tIwpzG9erqtMomvBen2Dmm13bLOzTOoZG+KzZWXQOnjzapy9mqQ?=
 =?us-ascii?Q?IDkOFrUxfmFsaICkWNdv7eYcoelkR9oXTjT09XKLxsmFPtu1RXesoTS6KiAE?=
 =?us-ascii?Q?NMYMrNxpsxoXuUpokl+WBoRxlbn9MKNIpxQpeXkxWmOWryvEFQ/jdoCZaZL4?=
 =?us-ascii?Q?ClBmd07V2TopuUVJZGikPbsic/cvNXa2HhtJQiIlmHhSA4ZHCHFnPh5lUCos?=
 =?us-ascii?Q?4q86Ll2bIusLezF0t5xB+FYTus64II83va2pYkWZCZ3zGK6Yd2ptD7XcCKoH?=
 =?us-ascii?Q?nmvn269SRIPhJvxM6GWGeuW+GiKa10OwZTeGdoGg1eQ0jClw09gAD/lUtHgy?=
 =?us-ascii?Q?k1yYIXxfMMl2FeN+8nUCdSb33CnI4D5gEmGGIy8+/mq/TfnxwhV7eaRdP/E+?=
 =?us-ascii?Q?JcuNBeeOoql/V1E3YLyY35eaJK8iWsSZFWMW0n8StbPeu29EBLqQqVkJM8CI?=
 =?us-ascii?Q?FL6h5GAmgTgkZ1kmotMf+MI7EXqK3IROlLLLSr8jCqatdMAl5W9b6gQTWp2i?=
 =?us-ascii?Q?d43tz5tOubzAiKwl2kCO23f8Ik+sak6eVEinGjcSe+guoxrF97tdN/we/XXf?=
 =?us-ascii?Q?4is0IHQaG2EQOuf8KcB0REDK2xaXWL2XQRqP/0IIIPDSw01/gx/sCTGn5tfY?=
 =?us-ascii?Q?9kRJvGbZqmqeepLEwkVeTlUTlzNhknUeElVgjaqQHhncqEM+uXQxexTGLIYR?=
 =?us-ascii?Q?yuQUMw/wXOGszCkJTX5yoEPUmpnFsFIIcDi9A3PkkUJIKwvTnwfC1IECmzTX?=
 =?us-ascii?Q?kVSsZZhRAvTRt4lC30GGJUOrbXiInpkDolm3d7rUAyLBaEP1XaNVbamW7TbW?=
 =?us-ascii?Q?BbQ3zYvfKCAeMXTul6OLRqyCahNp6iawBdHrqhy5alJM72mUh0h9csgtFjOI?=
 =?us-ascii?Q?JoLl8JmD1JR79xWGaQ1NbcWyvzojDb3EoOIX2/uOg68gFkViipyyTiVFn/B7?=
 =?us-ascii?Q?3UPSilvC3CukQhgCaJAfrUzT6N3R+CrXNHdmNRfCYVAdi6dbV6mcMw24DpYO?=
 =?us-ascii?Q?1jv6ArePctbWomNHpyg+XcmX8Jndp7qbTYgDf8U4ez81NQkeDLtQVzmPctUF?=
 =?us-ascii?Q?LJLSg0gx4afNujn03iUJy3/Hkes8PXIcn2KKR+Ppbyon9zllu1YUBCv3Uym4?=
 =?us-ascii?Q?fy+Cr6uH4asvaV2a5kzcB3HNzNH+Laqyh7mpmY988PyB0Z9U1bHL2BQFX1IU?=
 =?us-ascii?Q?j0BB0izWG9NaFcn66kewqJNdx1wMoVy5LuxJDIpOaoVTwU5wSPzuykqZuSq4?=
 =?us-ascii?Q?BIdPq3tUM9E7SRvj7A8bycnQMsO9O3PAYVP9v3+YHoyIOwsUwvxv244YMj6w?=
 =?us-ascii?Q?e7b8MPO0n3KK9e50p9oByBpVxxzniLs0HPvmMTiOQhsZ11x++Yzx8QRcgFrh?=
 =?us-ascii?Q?eqa8v44tQNPpoceawDPct478D9oJVrPCDBFfEBgv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 767fe392-d1f8-4669-8a05-08dcc2775f96
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 06:55:14.2230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HlZqhHZsapGHI5o+41kr5BEco66fTsapWe47ZJcYMJdNpvAX6uNTKa33Yjir22g5kFCHWsidGEm8hRT0eEMrFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5982

 Use the macro instead of ternary operator.

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index b38340c690c6..5d40f61261ad 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -797,9 +797,9 @@ static struct rect intersect_rec(const struct rect *r0, const struct rect *r1)
 	int r0_y_end = r0->y + r0->height;
 	int r1_y_end = r1->y + r1->height;
 
-	rec.x = r0->x > r1->x ? r0->x : r1->x;
+	rec.x = max(r0->x, r1->x);
 	rec.width = r0_x_end > r1_x_end ? r1_x_end - rec.x : r0_x_end - rec.x;
-	rec.y = r0->y > r1->y ? r0->y : r1->y;
+	rec.y = max(r0->y, r1->y);
 	rec.height = r0_y_end > r1_y_end ? r1_y_end - rec.y : r0_y_end - rec.y;
 
 	/* in case that there is no intersection */
-- 
2.34.1


