Return-Path: <linux-kernel+bounces-374766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E0C9A6F9C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 523A9285842
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7281EABD0;
	Mon, 21 Oct 2024 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R6u/goaE"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2086.outbound.protection.outlook.com [40.107.104.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEC41E7C1E;
	Mon, 21 Oct 2024 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528506; cv=fail; b=QIEg05PV3hXfdaDX0pL1qj4tRn3YClqD6K6m0rGWCEMDT9h/YapgpaQIlrDQIbKLkB6HHOPPy8mrAiIP6Z+R7TWmcar1DsvgUSHUtZBkYVLuVBdBZsjx4WTL2JNhrMtUPrQAFc6EE+Ckau+sgH+4CSOGhVS2wHquC/TwTeUTLaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528506; c=relaxed/simple;
	bh=gsJXqTRS5joA/AN721XKP7xRG28mVIkt1HN5w9l3QFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TIFMXsZoIEbUPtaq0NX1GEHVtQgfDSKc6YM4cy+cdocgk8xupBlIOq5oE61/kmWipBTF7z6wbOZteMjWguy7mRVXOgA4xaGTKpshF+QjAEe5KtN7mhEBrlV22MpA8Ehg+31pzjTrXPYhl5GFB42EB3MqLgd/MszrhUdyyO4jMoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R6u/goaE; arc=fail smtp.client-ip=40.107.104.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hny35BqYa83JjeJ2P1dtACoG7LlbyV+xdvGA+Kh1WPrxFV5Q063r/Ay+KlwRA2Qzl3btyWC8V77LiNeUI5R6OjmCUUIDTR1At5B+La55HSVAWoJLMcH1PlJrfHMOpROmA5u5rfvAv5Ck8FkdQ2xs3mhVxjgfbUlxX3QnN937HhxBGEYp+L8INwT+7tqbH5Vn+enS8/Y9RSOQ+Ik0lwsX0i6ReP7AGQjS7PgwnC0vTQNFerHfyBpDrmMoTKXjYnmlw7BP9fPPgpssDW/P0spUJgQvrlz9ccHnvQKCtatvK+ygQKCZjjovqy1ZU2Dp0YuX7qDSIRFJIMfvW89+YNIQzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUqqOP3dLaoTkq6lz794GvCmMPnzCL170OT74JIhH/k=;
 b=cyZTsoUZIyeluDj2fxB+nUpNaoN3AUNUO30Nti9U8fj3XaWw1n7nAsYiFn57y5LAVZU0GP6w/D5idtpK3S3YJGmFztsbj+NFAkyfcmlWQ/6KV3DtyEkGD62hdYhQPgKKsNeViAz+nZuntqojCRl+WPHXGDu3Edl9SO3jILc1im+d5m3hhTeJf2UnscSUhPbhHT5+Nt5VGzYP2c0eraP7mhwS9+smrUjvZ1aPivdDa1/7MB1N4KBNd27uE47IZlum75M0eBD4DkpxVqBKLzfKSZaa2OvHPQ+tZZI1v8yMS1VqX+EhRpDG82s2MtOFd40KA1LxqMvoO0oZnxHlS1blTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUqqOP3dLaoTkq6lz794GvCmMPnzCL170OT74JIhH/k=;
 b=R6u/goaEsSV8I1+fH/K9U+kh71tsUeJPEe3GL5balzJbOSAAzknk5f5OXWRo3VLbT2qJtx47eMznBw08C8fIH1N4gx7P1aaC+nmKIClp3/YvK/Lz/bCg/uRq37alREFL1qVxiWS33nNcRVvIxaDxoPyC3Iuu9+hLsXv/ysWdNhUtuk5wNp3YTqZ1/ROhj5tdMtzywb3tfAho9uofgom+UDO3SdToc45ttQ3KsEIfF8IVVLMAUZVPrBAYPeyQ4VH6tpQqDzCyv27cTOKd+kYKLHT7bhzdAfSAgbejbgfgx8fUZ1WA+wgxB96szNT1ho6TPIsAZprWWaYZ/MAxlFaLTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9684.eurprd04.prod.outlook.com (2603:10a6:20b:474::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 16:35:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 16:35:01 +0000
From: Frank Li <Frank.Li@nxp.com>
To: shawnguo2@yeah.net
Cc: Frank.Li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v2 3/6] arm64: dts: imx8qxp-mek: enable jpeg encode and decode
Date: Mon, 21 Oct 2024 12:34:34 -0400
Message-Id: <20241021163437.1007507-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021163437.1007507-1-Frank.Li@nxp.com>
References: <20241021163437.1007507-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:a03:180::18) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9684:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa69209-02cb-4a69-418d-08dcf1ee4ee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F8mj/8SoTl7fjKIIL7J7xT8B9f47qf3EOLLTgt1sQXmtMQcP5SVIOSFIgruT?=
 =?us-ascii?Q?iwzMb6KVP1s+XhDfKb78pTeU03MwWlTC2q8hmHWSYkg8mBayD6rB7YynMhJn?=
 =?us-ascii?Q?Ni1BYdSj6jbFF/2llrUP3/ccJ3rr1/wXwR1h0l4RzrPQEtvyWDFQfq5ovKpF?=
 =?us-ascii?Q?ckdUlQU0b+FynD3RNUoeGaGRNhUVMbs7ytl5sXoU4yNFy/AM+ZQfgL32zFUw?=
 =?us-ascii?Q?AtTVuOLAhJuF50dw321ChUa6JtJ1xc3tQcNaAJyFliL6PmxVgK1WHwwgtfO6?=
 =?us-ascii?Q?Q0hZpZ0zK4cPHlD+ol/0GCf6bBYz1HI/LULZckStad1oQQtrgfAmwkI3FSJ4?=
 =?us-ascii?Q?VT9BvLAumYxuVCoYjdGuXNQsBvCpYWz9YvTOx/5LHRbO0ejXUp1VPlR7RDua?=
 =?us-ascii?Q?I37x6DHcDM6mZFN+o1MMgq5oa84hdtC1Eos6vLZz/EnFxS+I0mBCUspaKlqz?=
 =?us-ascii?Q?sI5Hc8bLowNE1eE6Zt3XbK4+13IjW+2Wu/VDIe0wJY7h+fv81hpYgVTUvtQd?=
 =?us-ascii?Q?hvco0lwgfuXjFALSRVLJ8pjO7y1d9yIFMLM9n6HY8AAJQhOv3OuRq2vWRFZu?=
 =?us-ascii?Q?+KPCKpJPG2ZuI0PL9UXDpC6GF74jvEuFbXuwCZGBXCopY5sQpDgpRCvu7OIe?=
 =?us-ascii?Q?7HVqGOtmdDzhJm+KFGZjrCiTpzZ5A1yfFoAAfPDU7cKFlrKVh2hxpaOsDiw0?=
 =?us-ascii?Q?WNKGSAY5UO6qDIOuGBN3idxac0fABmt4vjAkPcmlCL1znJMfGIqtguTYQHx9?=
 =?us-ascii?Q?AKsd1Whv3rT6rPIlsNWEUplcQPEOMCwvj4IRtO6cyGNvXAkTGXfuExl/Jhaq?=
 =?us-ascii?Q?xMVHwNiveas+xeUpeZGW4157VogDUu81NRBPzFJ82eiRoN7ecK5OfkbyclFW?=
 =?us-ascii?Q?pQAbElOLuj99bTSEyx+RV5vJSmDKniPXIwNICB8l3GbCc/Vw9W3EcYsx6Ngo?=
 =?us-ascii?Q?187uLvqM5rs/0jpPxSybYL1mvIrxxZlOY1K2EsklKxc/Lduv5aNMdS3rdv2S?=
 =?us-ascii?Q?ToJ8SXzjT1UG6GPcuyBY4N6nM9dELO0mRjq8XFo8VsfX96PCREx6kGr2THOh?=
 =?us-ascii?Q?KAxiJWSmhNz7aqHl/+6XRoAzVdIeqgIvpU3uhofFAaesLQ9JKpdEy6z2s7l9?=
 =?us-ascii?Q?4tCDKsMeh4he8FrHP06gctjMYsFsW8W9JCwHzO7Pfspa5pMmIQnLWAESktMM?=
 =?us-ascii?Q?sEBxBokyP+TCITUMs1BhBSQVC1f7u+T1s68gIlVEIP/TZsDMsRuhIt3aRaBM?=
 =?us-ascii?Q?QuYbr+xVVXTHcuqUKx+4YIQgVps1bzhJK/6nkNVRJwVaRazA/YZIEUZvfya5?=
 =?us-ascii?Q?ByTKSPxphSpARHlTkNMak58M7knJULUfYkOdP5otACigpJP5foo3epYNSTvq?=
 =?us-ascii?Q?1950etw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ScFrnep4bL0/3oAjP5KHY0oqyKMYzKjh5XuJattCkXHRTZ9b65y4ZvwPPFTk?=
 =?us-ascii?Q?pry6oN4g1LzQYzRR5c8+6GNiJRwgpUKv7pUz3yDxWYcVlpShzGVKRcZN633k?=
 =?us-ascii?Q?KrOMcPzyWxZhQG88obcTKkFNpGb/PYot+ULJsusRffcOfYnRNBvaLi7HyE47?=
 =?us-ascii?Q?ZLpQWfFVoMPt7+oq9OnjkuWgmVLavFZoMcFmkjSI7aPE0LxpzYqXyGhRKBXO?=
 =?us-ascii?Q?78BM046YmKGW1c0pQwAxz0EZU0NsfFptxbbxNaFiWpcnQuqH8EciP64nTRxI?=
 =?us-ascii?Q?gFz9idrsNPpmfhqZ53OvAeN64SRu399OAJ3rCpK/6igQKezmMl2NIDwbUklW?=
 =?us-ascii?Q?gcyQUMqEKTJSm6Pit2HK5Cun97CFZGCLhUphmm4v/dqP55jAEzLfFROqDKQZ?=
 =?us-ascii?Q?CJv7gMhYfAB6ZvA/b0QsQwAMts2rEnJg0drHUcMUmln9uZ1WQGpSzFSGVC52?=
 =?us-ascii?Q?fKZjtWAji2DrP2S4ozDb3Pfb3xhjx7ICeaxEhE89UokuNSF7RkmTpKhFSKaA?=
 =?us-ascii?Q?1p6XdAtWWjIuofe+c262VcuSpuwHqsk0gr4dp4NZGUQh5yfR3VDWS9GOl1Ow?=
 =?us-ascii?Q?QFD6QfoTFeEHumJVwl3l/srtW0OxW6ThkK4XfGf8H17qRPFP4/NDTsOLv0H0?=
 =?us-ascii?Q?uPCN9MkhJ71kl3qb1VY5E5FDUgn9jpclt5p9xDp3WZJwdBQ7oy5DCVM+Il2k?=
 =?us-ascii?Q?D0XJzEJqoYWXf7YqxTKDwjX8FjT8YCi09dIV8kxEHAdgMv99wJUl+G4QkrG8?=
 =?us-ascii?Q?TnppnbSpQh/3MUk372iM2Z50rLY5eMlW16ytka1Y2M89nifmF1vf1igi/nMd?=
 =?us-ascii?Q?+V28LSIuRcvSf7ALTNm4b0qu9v9bhx1nMJzFRd1iIVLkTkvEI0/BnLLAV48T?=
 =?us-ascii?Q?WTNklbWqVBLVAGNodoofyA6doL2hz+rvyn3F+F4q+W3su8g9YPHlrxbG+B1d?=
 =?us-ascii?Q?8k6vK9e389orpAz2g2sIa2jP70kYTuYBqlosL35AnbDQapv7JNPUvSNVptdS?=
 =?us-ascii?Q?0VFFn6uOT7xoQhCK+33m+CUOStmqN7uz5KRJj4yx6C2TXYVtj05n9TnaeMPz?=
 =?us-ascii?Q?BQXeuvvd2qfUkwnk2f6GADzSREAB9FBF5wLt65LXpaFOrSjgWJUS4KnOqMje?=
 =?us-ascii?Q?B57cp1uyVYG/HLRs8iLM5ACuiuDyGqtILEVqNEjHlrIxuCB6L2hQfhYeyocv?=
 =?us-ascii?Q?lgk+AeE1PoreHB2YCXxLcKDjqGLpKVmHEvhaCyo3j4mqXRhZ3hmcuZtoepQR?=
 =?us-ascii?Q?NOssUg9Zs40FA1lSYTnpihvT5lyyHtO7E+kj8gpO9FRScWrSYSYY5NJ55SP0?=
 =?us-ascii?Q?6sHsogKO6GmaZafZtFcpJx+bEoaO6fmeHyA+l9HsiKcjZ1FiivUssVCzI0kb?=
 =?us-ascii?Q?eqJVfK8fPJXOz8lfQiS1bqu6sTC8SmNjvJRePNXnTWkwe+3zNwzRaUOw084B?=
 =?us-ascii?Q?3A9fycBSERlkT2TAWB/R2QazpTVZ/G9LSDFmUS06K/a9J40Wn1thnnvhQW/i?=
 =?us-ascii?Q?FIxq+pO+4NV9xSgQN6IacaQiFObyuqLdehCGajvsW3jj4CL8yL7Twxul5pjW?=
 =?us-ascii?Q?KK6AvV821x9t4B90pBqnIGsgKusbh4V254E7O4pi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa69209-02cb-4a69-418d-08dcf1ee4ee6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 16:35:01.3440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Eigd8YfZ0SWduWXxZ4mwecUhBeP/rdraDdoMmrxGOfl6xWPIHwqaZeN26yNGvbBn4y6roIwF6fO8B2Ixh1kwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9684

Enable jpeg encode and decode.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v1 to v2
- fix typo deconde
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index da8ceffdc7212..0d14b0def19d4 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -337,6 +337,14 @@ &cm40_intmux {
 	status = "okay";
 };
 
+&jpegdec {
+	status = "okay";
+};
+
+&jpegenc {
+	status = "okay";
+};
+
 &lpuart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart0>;
-- 
2.34.1


