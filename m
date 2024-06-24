Return-Path: <linux-kernel+bounces-226546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE4D914030
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 03:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7142D282BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 01:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112264400;
	Mon, 24 Jun 2024 01:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HMszfwON"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2060.outbound.protection.outlook.com [40.107.6.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BB02F25
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 01:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719193652; cv=fail; b=jXEPk4j8ZfRa1/Q4p3iaNSLCn/Ge1ivqAXvL1GDFGtOerPNOJH+WggQwKKtuQHUfhBOcvDVpxoqDk9mGmFeOMrdjO9X9/w5eGUhUTBnOyd/rR/h+iY+Cbxcjy4FCS0UUPnw+rztpo1dsAFCHCDsnhRRyHnMnuBRrUbMyGrmI9Z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719193652; c=relaxed/simple;
	bh=LoMnpMzsCMhKWYqi2L4N3L9IO9rCknjHWElppIW1Sxk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Fg2iUaYx6WMYSj4q+x1NJYVPOCcLbshKQVu3VFRaJa16FIRiENpMBn4YUTu1IEp6S3lfRZ5WaCSMlvnk8Vj52g4xK2Ui2VCcly7yz60YsMKFL9T0vDKXel0IOOlnGxcQp+G9AJpmXhQM/f0etmKaEmMxFwqEzRwxbRxx/ouTYZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HMszfwON; arc=fail smtp.client-ip=40.107.6.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rbu0kD4s4A4znpo6qVJDrvzBThKE1na1D08AxZ+pm1Nu5DSMiDvvq0MzQUx8Sb1/bPKX1Ynj5TKIWnr51aRjiQz/NZCGeB3hH1hz7Lp5dLcOO8Zs7MU+LG5nVkYUSx76eYFvA3yKjZmK+8a3/2qgxJPdgu07V90r5zBzDSVgt8vwf+JG+l6DmYlAacgG5by7Z8CtNZ68gp2SO8T3Xq5uOrbMTLx1jPlWnFmFR+YuyIXcuonii33Bu7GCKaRJpFdcGdn5mCra+sdt9t2f/M+6ASD1du1dkZCjdDYA4adJPFCDZEPb6ym2qZaDANh6HCA7L7sYTGSPJFlV0/xW+91WwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/m3kbDM0SftEBYlDMuh6fVq6HAP7p3lG4KKL9izN73E=;
 b=QcqaaNmWd7/k+i4MGuzCfqQOw46Z2PXbwGqVpzUl2mZXuBb5EvbS7/M3DBnKX+mN9S8YXb5xb7bgVbrl4E2yRp5CRN6op9vgQyeD7mXbFRsyf8dJFbasqIx5KUN4OurFeHsTaCagOTJF98PYk1u50kDTcyPUSD3ql3Z8phKrupvSFKnOxVP656iJePEWkt9nFDdFDR4PTzNtK6X42GzU1WWwprPdyWIBPHxFsuvsrGx7ULj72r7fIkEBDH7j1ZqHS5CVg83RkXNnDPum+e+16DBXcGD5DUKsXycLxSkj5YtKsT9OM4JHeC62fqVO4la6uvkY8nBcqmrEGZZF6nXwjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/m3kbDM0SftEBYlDMuh6fVq6HAP7p3lG4KKL9izN73E=;
 b=HMszfwONslGrE47Pzos13Qk0iYxE/UMXkMMYeAZruzJNM10g4MW/TDeyHUHEv9bbvrotZTqI/ioVmnmue6rhwp6+QLl7ELaNGOeJWQwyt/4iNpNljabYT7qLrMEk+xTdJQyANVJJFp9yAihCSzPNhHqXfpNZlB8wm2LYCAzEBhE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DU2PR04MB9100.eurprd04.prod.outlook.com (2603:10a6:10:2f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 01:47:27 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 01:47:27 +0000
From: Liu Ying <victor.liu@nxp.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	sam@ravnborg.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	victor.liu@nxp.com,
	emil.l.velikov@gmail.com
Subject: [PATCH RESEND] drm/panel: simple: Add missing display timing flags for KOE TX26D202VM0BWA
Date: Mon, 24 Jun 2024 09:56:12 +0800
Message-Id: <20240624015612.341983-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DU2PR04MB9100:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cdaf40b-4952-4ad7-96de-08dc93ef99be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|366013|1800799021|52116011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WqzPUoRRbmABqi2alhAdsjs/7L9dKKH5DxU5Rlq5f12TGgW8/6ghJIXG4MZc?=
 =?us-ascii?Q?H4dndLIVTmWF4nNMNfeEioImZdJHaybZHujerX38FYdgbLbFp19MbbUK0Mm7?=
 =?us-ascii?Q?YodovW2B09iZ8Byt6P+Xt72KoJmylkeVxn1lckpz+dswXRqvQU5f+KR7xsHg?=
 =?us-ascii?Q?4K4wgmCFABEzsSBotM5+HXP/RmmBOEs8aofuVtTszjA+II4dlXInvixctNDv?=
 =?us-ascii?Q?AEmhElARlw4nfjIBkrNNiQvmoh08x7tdsW6mT0jsm4AkzYDf+CPZXLOe+zWl?=
 =?us-ascii?Q?dihOIYIUHKYngo1I3RixrcWNGYzOueZpeGWfdH0LIxyoPKER+1qaO+rcnRLa?=
 =?us-ascii?Q?1rSetMb0CEF3q+wotnEHa5aCFDi+cZ0Thw1VGlx5MhGCseqAGPmrclBO44X4?=
 =?us-ascii?Q?Q33dbplBSyh0KWWWiNAbKFCmBeQORtrpAUqPqZN4KLHCrh+/eryH18tosWF4?=
 =?us-ascii?Q?zRiM6kziCFCS5/wcToTcXtpTJgXe0BKfFWG7IB91nYlEDB4BAMa3AWYCdUo4?=
 =?us-ascii?Q?LJKSRrJExaHGqAkzbfvWnsZal8+nhCTVERXq+soRDEUoJY+kURiH2vgDdm9P?=
 =?us-ascii?Q?r1CujqOOf9Om6M40hytt1SsfaWwlkPwYevUXeRBRsJ7nXnXHMCOiJp8lSbNk?=
 =?us-ascii?Q?bVGHhqgOzRuXJl5Y8a3/x0/lV03nK84XpWjmk2xbjG/sTP+x6kAJCwN/ABYg?=
 =?us-ascii?Q?W1+GE5Zx+B8R9Srzokq1a1RcwYpR2jkyJyVe6uGuU/0/VonNSf4QW1nrUneF?=
 =?us-ascii?Q?xvFoTKTaCS8NqScusk4LMHQpQ+I/0dAvh7zkPk5RIJ583dXuI9JLgyTbyLbw?=
 =?us-ascii?Q?wckCHdFNbHOUIt3O2GH26/3okQzckJpXaieB/oqizS688FB2020GXNhhDpig?=
 =?us-ascii?Q?hTF4GZKXCER+NmP8o9bp4wAxspyhnlDKE5gv4ZG8lz2s+/I8QDQ3ll3EGCRq?=
 =?us-ascii?Q?e5oAtxTo5sHUAEo/jdsRne4brjN6PwLbB11DKobDJE4N4EtR4zvBLQ/olXBC?=
 =?us-ascii?Q?bdLS4wE6cxYi6GY6Xg+oYPuLW+UwVO9pQEf5vRAVmcPHiugxyExB6f0tX9De?=
 =?us-ascii?Q?YLEQ3VoCl29jXXeIbhDknOxldhicTs2x1FuyQRheNw4mZ0uyZnqovRph8B5N?=
 =?us-ascii?Q?YaEtnMLQtCayHiiOZCFhdQ+aiUu1spzhrgU/jrGlZOR74Q8EUV+vhAg9uryM?=
 =?us-ascii?Q?MyLeAnft1dc3KzB8k1kkZfjMWcOWZDZHc5BCHBM+wgiuvn1Tl0SYBV3vFVj5?=
 =?us-ascii?Q?hI0QGjrLV2G9dxgl0CNW6nzY70OJpCC6GsRJKlWnQPiQMZF8ZF70JFrq9S+o?=
 =?us-ascii?Q?wraVKoSLy54g6jEOenD60jDrcRJ2qKJzitw9qyZLX4DeCdtH+5HLHLqrxqrx?=
 =?us-ascii?Q?Z2O1L5E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(366013)(1800799021)(52116011)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jTlIvSEKGnfMg1cD+GwzczIg2/oRroxOMzbwy+Hx/IebOUcKf55j6v0JxwYT?=
 =?us-ascii?Q?5f5/RghY/EmvYSkw2+qHQgW9we90G5aAyIwrJtPcsh+EUxxYOM1Cbi6eAece?=
 =?us-ascii?Q?132kuigwOB5Jyr9L0C0Ya1SonMzHTGTYFXa0mXHpufCzoAOU0xhCyuxdr6ec?=
 =?us-ascii?Q?pHzTda2JZuTEpV0Bo3SpFhjJIa4HtdbOb9dQj/3fUUnUhwkOgBLu6/YM4qSc?=
 =?us-ascii?Q?4DzphBzn/yWLTZV6L9h/SVsUaPS2svWpOgHEoC8h+Hsa+Wk0S2awHKkclNIB?=
 =?us-ascii?Q?O0u/BL0cBzjdAklOFDSE93WSvsk5Ts4qFyPak+YDKApj6EAbDDgzJLWTa3Hq?=
 =?us-ascii?Q?et9UeLKLmSPVRwEM+2Jf0+9H+qYIvnaA4ioNujM3u4htWHeGT4DwB/BgzgXy?=
 =?us-ascii?Q?mIjNAomdMOF3EEjrXUT1n5diByLDnZ0G5zwIhpaViwL7GtWOl/WMnhyAOcCP?=
 =?us-ascii?Q?xae2vp3+U4x16/0uvRcXMr2YFqRNff+B/tDGB4UqLXT2kZ93MbqgByGIV6Rs?=
 =?us-ascii?Q?hRdlA4tHY5kHfYuU5x9jnaidXA4YNbyT24E+FoNKCNcB5mzwGPiSSq1GvA0F?=
 =?us-ascii?Q?kC3zNoWpIbq8q9RhVpJPJNeoxg0XE79wUg/HDta9FmJnmyLASfjNRXFsY3cV?=
 =?us-ascii?Q?jBexWdXq6sfA1natXA2YOJSw+PVu8dpkbiMvhVntadY3LxmvblPEIj1tBmEY?=
 =?us-ascii?Q?n5ycfmRpgHwFO2dYWK/+3om7+ID8dedCtJ3hwU9dj6qRhACXisZyMNbRd+Sw?=
 =?us-ascii?Q?OgkTmWVo58k/fDvv/ACwWVxTjTABwCTcYG9myv4rhfTtCjhi0/R45oVcDKC3?=
 =?us-ascii?Q?IpwfgpaFZ88UwzJ/wkAsodXPdrOHUD/+JtvAbDIClWibabXYliRzJOuQNpfj?=
 =?us-ascii?Q?o5zI63dL89uf2Cc7DifWkerG49MJgAIAEVGJzXZi5hFpnnylgu3B/uY5uPPN?=
 =?us-ascii?Q?Q1vkq9ajs2NZzUSyr08gx6nigBpvZFKT5nRVJFy3kVlXDh07AaaLtL5MdTlh?=
 =?us-ascii?Q?KUJtAqyzpkrNeCl5asrKj4l1xhuwt5MOTPnBU2AbTRG7QjDu99RVc1BxmHgD?=
 =?us-ascii?Q?Tg0a21JDk9Yg2ny4s8GxoDbThjtfwlpoRW92NoUdjg7/BhgJjELzVF5Bcwfs?=
 =?us-ascii?Q?ovw+1EVE3/9JhKcV6t6exnsFmpHwONMPlrv48BvdggRM5MRiPaBSfRzoCGma?=
 =?us-ascii?Q?26goXEPlpIz38NXNDrfh3XA0z2GnSBgPZ5QuM7ZNhocx+Nb9WjXPtu3ir54G?=
 =?us-ascii?Q?PsteigZ5YIOih+dXecni4wlciqmIJR2fZmbvsludGP1N7uUVFOokIRXwLkyt?=
 =?us-ascii?Q?KhZKlYU7RtPYth8QJL8I5U48j4FdaepmZkdCJAGh4t67m35iGdBYOHFdI+xw?=
 =?us-ascii?Q?J/wHsQ5da5nSAmz4LbeyM91hl1dgtXASROERvKGOI8uQ0zLCQb46ZY2+kR5r?=
 =?us-ascii?Q?ACy1qwQMXl1ElHHEYfh0mfo0cmFuW05eKMPcftu5xvCVSG8C1lm/mZbuDJm1?=
 =?us-ascii?Q?VQxtFxpbV1CBVf5WJAo5HFkOveOn/UASrBQi0ZsQjdq7T7KbLlZdvQKZLcIC?=
 =?us-ascii?Q?G9xdUOqddwder79SfdIQGYHJWfFgFud35Mjv/mzV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cdaf40b-4952-4ad7-96de-08dc93ef99be
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 01:47:26.9747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NYLiHzkx/dcKhUKIseuDz1iMefdbxsCA3wDgwjv9hg4HPPK6qfqQ+kx0vB8OuMp1+Q4L3qRTqDMfwjDgyroX6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9100

KOE TX26D202VM0BWA panel spec indicates the DE signal is active high in
timing chart, so add DISPLAY_FLAGS_DE_HIGH flag in display timing flags.
This aligns display_timing with panel_desc.

Fixes: 8a07052440c2 ("drm/panel: simple: Add support for KOE TX26D202VM0BWA panel")
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 20e3df1c59d4..7b70606e5760 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2704,6 +2704,7 @@ static const struct display_timing koe_tx26d202vm0bwa_timing = {
 	.vfront_porch = { 3, 5, 10 },
 	.vback_porch = { 2, 5, 10 },
 	.vsync_len = { 5, 5, 5 },
+	.flags = DISPLAY_FLAGS_DE_HIGH,
 };
 
 static const struct panel_desc koe_tx26d202vm0bwa = {
-- 
2.34.1


