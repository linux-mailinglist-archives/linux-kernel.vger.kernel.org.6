Return-Path: <linux-kernel+bounces-307970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6A79655B5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 05:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D702827B5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 03:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7B3135417;
	Fri, 30 Aug 2024 03:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="MuCKXQej"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2052.outbound.protection.outlook.com [40.107.215.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5A536B0D
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724988855; cv=fail; b=CAt+IWwFz68I0AT3h2zPEEgnL0alP0ZGoW/yNTkVfDPqzWqHHjxJYmq88ZL568BsqbRH7AzdURdxvWklp76vB6L1Iri/spaWi2WXH+HNBYR0mbwugjyIFWbbfu0NVtxo3iHfWUdJ9935U+DdbdOMeusAtpWxCPplmhA2aQstqTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724988855; c=relaxed/simple;
	bh=+1r3vvMe0gZyH71S+kdJxvclAa67/XspZHZZ+8sO5Kw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PGYRyG5bfA4r+piO7f+WG+zPRYczl/S2nQcCxmOagiMW5mHoY5oZXVfA9NBNot1r5hVmfWGoAjgJtoAPs+FLPrYFjyaVfgrJrURgQQC0fXeDvbTjvNNEV4y+HkDoHyAs08pnugj9oI4Rm5hsqkcM54BvGTgFdvW68J5+sO9Bk1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=MuCKXQej; arc=fail smtp.client-ip=40.107.215.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddJEqN1q6nXeEDY22X3z+CWSSrBJ3CylIbhIC8MwXm3fXcSUb4DGyEMteM70ejwuUSU0zBA7RdKE49BlEpA1nc2DdeFx0YK0B8E6AKVAOKL1EKyk2HsUBQ0MFs+QxsnVf7hAZ7OHOKIk1jEPPwXqlwT6Qt8MC0QizXY0auM/xlTCO1zUsKnyTPx/Fmi5QzfM4lH/AwOO66/IvV24zhCnUtQIqc85Ms7SaqOp3kcB9oLF22uVa/qKkHf5xfMfvI5AnTyLCRPg/q6aaws75y9NFyWc47uc7N+k8t0DzlXqc515bC3LJez5X7QELB3nFjKwzs8L6vG6uMyXstZfCoJE3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrI6+MBIe20lW3rM1fJav7ZCn1xnHSLAPkWrHSMvqXM=;
 b=vKiTbVMt6Q5h00qkqdVjvHns9nc4FHDsXw9sr1/LEd9TlcEocVR+0snTRZY84PgUeGt70vQfyEdP9aLJQa4+cXlA+oyD/htdu8aM6AaBtcw5jEzz4tk8Phs/Ny1CQEwHNlo+1q5sMeW13ZJE9/4sN9f+Qytg8fPj3wNQjzr4t0Wzx2uUKngyyu71QWxJFaEow6xxir/6Ldf0Cd6gDcjvcNxQ3c9HViW7q4Y0hcxeptwL1roKTZQZCKZB7uKsN4X1uYDojLemoI97fAda53iMvQcqy/id4wnDRVBdYsN6bfqFMiyyFa3Jv45wXAOoW/nwBHiQSQK1Vpo7asLzEmA0qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrI6+MBIe20lW3rM1fJav7ZCn1xnHSLAPkWrHSMvqXM=;
 b=MuCKXQejuJckuz1o3u9nfGC+hNXXY6ExfhuXhKc20StMZTztqmxXU8z94TWtnI795LmBFdGK7Yb5Tt9yuYBsv6FlsODhtHSr2rOvHA0eNVQZf3hsR+aJT4w+7H19OIrK/y5xFSqG88mDqPrLCTwB4NiPc3u0/rmFphhzrotStl/ZdY3TPMp012LI2Erwb+syCtfa652m/AkpUHABxogNwNrl4KgoDzapi5ksa5EziDcn0zVy8UNs7p+8vW5w9gzaKCj+gif1O7yTFeTB/A7G4Xk+eMRFpU7T7IoDmjAB9/9JsKKlqIOm3rZY7fvgz9aFTZowcIIFugsk3uV1dA8dbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com (2603:1096:400:283::14)
 by KL1PR06MB6348.apcprd06.prod.outlook.com (2603:1096:820:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Fri, 30 Aug
 2024 03:34:08 +0000
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a]) by TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a%4]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 03:34:08 +0000
From: Yuesong Li <liyuesong@vivo.com>
To: p.zabel@pengutronix.de
Cc: linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yuesong Li <liyuesong@vivo.com>
Subject: [PATCH RFC] reset: Provide new devm_reset helpers for get and deassert reset control
Date: Fri, 30 Aug 2024 11:33:51 +0800
Message-Id: <20240830033351.233263-1-liyuesong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0174.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::15) To TYZPR06MB5709.apcprd06.prod.outlook.com
 (2603:1096:400:283::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5709:EE_|KL1PR06MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: 0574e0a6-7ba0-456f-4a20-08dcc8a49afd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bniao4HcXgUcH7rPzQTHxrMAPtLhGaQdpEiF5Bfxs9Di7+1Dm9WQ2fvOaM+2?=
 =?us-ascii?Q?30a+CaIvy+u3HRxrbaIVVQPs9cW7qvbNcGTSxQiReu7K+CIYBrlYVjjGutw3?=
 =?us-ascii?Q?KtQYNZYDfSMU+Zmy5dAF95XJmzXd2xoELY01dbzssH4YQ790vt8igH2Ft7SY?=
 =?us-ascii?Q?87h+19FG5xJpvhMIYSmaqeMiuPPoT0ECQlIXDNkzcNXijY4NH+wofL79L4Bi?=
 =?us-ascii?Q?xA664q0miYTqgkr4a7ho3C3mwSnTgYQ+Du9tQrBT5/fvxXG6PT0Pm+EUDKbr?=
 =?us-ascii?Q?hoU9RjWB7CQWDBcsrQc2jsImdoOyELXHgRwcs+JlR1nCkGHTuLat+O1+XWi0?=
 =?us-ascii?Q?vu9f52/gd1rnJi/JylgDi0k9AylfopejcSCkPBo0JbwTpWSztpcSCjWGFywS?=
 =?us-ascii?Q?/C9yrV+trIIHPw9MTvI88FrBmJo2++6VxWwPm+pN37mEh72+qA1V28mIaNhr?=
 =?us-ascii?Q?i4c48IFj9UKZRNLXDj6ueJZ3B/OkImYzoLTt6vfmKChcbnOzrz70Xm01FRQN?=
 =?us-ascii?Q?JFEGTlnM4rYQr9QZBv3hP26XhsdVHhlgktiIAUodYkyDtuOsc5mEJ8YlvY0s?=
 =?us-ascii?Q?pI+Wj0FLAa75MGS8moqy5x1Ege9T75o4/C5jfYqjRr+jP4u1FTgJeJ4Oynf/?=
 =?us-ascii?Q?9IGwlSbAVcxm8O5D6J3hh8fDd+kEb+GW7MauQTfAEpMR1/GJPqscfDaz4/wl?=
 =?us-ascii?Q?zI2W+Rft0SHhQbAAzYvOU5LCqzuc8QcTM8ZS4CiKfIIk5FEMho1E0faCdNOA?=
 =?us-ascii?Q?P7oXtFk2xSns77GOnn1zexiA+/gidMFJFJyX7QlOf/N6DjcnqwWH0NYohqRl?=
 =?us-ascii?Q?E7sWJsbc6831r1pkBTaJ7xqZ7d/jfRwhxjp9cfnUMSCaVEKOk4VOCsTaUluq?=
 =?us-ascii?Q?ddYFaoezJN/O3UsJSt4Kiv33Z1xoIP/XU0PII0rjsLM/tjdWWbZZNukrLonA?=
 =?us-ascii?Q?MMseuVlK+gbBSFEf22pOT5tG1ClxkzWdjTK8O2J0kepIYy5AqlcLsHdxBmCA?=
 =?us-ascii?Q?JCLNZI6NDj6LVCwmseDpdIzxRxDUTFhF6C1o4Vv1QSq00YqxTb7srotL7Jr4?=
 =?us-ascii?Q?nZgDBT3ijV9r9yDKbZQoAzWpWL6jH5D01me7bDhyIzoXHKrsWp9airhDTvE1?=
 =?us-ascii?Q?iW4el18eYGsAs6/vVNPx/Om3pFXpGmEicXH6nPc6q9EBB1e/WPe7k1px0m5L?=
 =?us-ascii?Q?kzbsP9fiQug7x6EkDbGrY2C8oRMaoD8aHignHPrKVRU6JC/0DA3onNo52tYo?=
 =?us-ascii?Q?9CdKMf1t2d9kVEhJOL3ApOCZczYcINarJdmEO/1Pf7mlhcL5ZG31oeE+fWs6?=
 =?us-ascii?Q?chPlnk2N+8f5si/tN2nBgPZ6mMU1BPiiMI2JTE0SiTbK8yJ/0bPFB3sOD5FH?=
 =?us-ascii?Q?phurOQ/hjW/f8HFTG1aBv0fA+bCdBBbJH3Dvaje4aiJCtUXKiQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5709.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PjuI99L2x8031PVnFIemVADOsh+w08bRKnGHkMmCmwbsClvKM9e/IPsbUPGx?=
 =?us-ascii?Q?pzrU9ZaWGgCnPA+z9gVCmlIdwD3lWaemW46ONkrhalGYJNvA76+mmJ2E/MW/?=
 =?us-ascii?Q?8UoaLWSITSqS7L058b6wW4cPWTUf68G+Xvnw1deKyqOBqZ+kn3+HLPmy/siw?=
 =?us-ascii?Q?w8IlGayDfdrCyK/8ONlqFnSVMu8RNLIadKP8xjOX31gITDuZWD7W7+/wDI/Y?=
 =?us-ascii?Q?3ea9z0Ey9LRQQw603Tt3Vv6uUAh1qcWznEs+sYJBjHac0yIzk4FMpZ0G1Xfx?=
 =?us-ascii?Q?9Iam45miopk+Hkb3B8ja612ICmbCaEEqaMiYDSdelrBLNlGIwLX2/eN4Jazl?=
 =?us-ascii?Q?GY/JZcOex2qYCwF/K2LQpewiS7BynntKe2McjM9S2Kns5flaBh+k4qgubTL1?=
 =?us-ascii?Q?7O/MMgSl+f+AZAv3WjJ5oVNTYRr/TvLjawg3hGWremWTZA0iSqunvts6ITNQ?=
 =?us-ascii?Q?zaArbf1JkcrwxwZJ4Bez+G+quiqddtZimv6eTXjIcuRLa+MwbKaUD7fC3sOK?=
 =?us-ascii?Q?rETOf6XEX73RGDESVMMg2UdNgHJMIRfytlYa/Q9G/laz/yBJYqFMZEXvEkcy?=
 =?us-ascii?Q?uZ0WFyH3TYLgOmKYlm0ZseQTeXF2FQeFAznRmIpGtj91wHEkjp6A2BKFtG5x?=
 =?us-ascii?Q?7Llb+7IKsWPmWAYwBpy2KySRLttQF7NZr091OnELbC2mvR6G+BphkTDdh6zy?=
 =?us-ascii?Q?kEQafys4Q10rs3EOKCcbW+2U98B1Heh5oSW7VM+h9qgqnVvCA7yywULK90Zg?=
 =?us-ascii?Q?Fi+MTmJDry9K72EgmI6oLApBY0NDQo0ncuXKWKlJjjbALAXOb9D8b312eGFY?=
 =?us-ascii?Q?IIT1uikE4WaexklzpyTUvS3mVx00XfghyEUsae+CcvSEWF5JZonbl2PiYhwd?=
 =?us-ascii?Q?sY2ytI2tv/PClaP98di4uiBcmvnc938lvR0SPFkfy5fp1gsemVrPp9uJ4fJ+?=
 =?us-ascii?Q?v/JQltOixTH17evWDgdhUrzEjeZE7AMamfvQ5wIazh2PU7GQOWeqEywF4SNN?=
 =?us-ascii?Q?dMkpL8Bc25SYxbtioMYbWzTWYaLzV3DSytsfmACCL6a3FZGwA6X9sGb08Kss?=
 =?us-ascii?Q?Dg/+/lJY1QT4a4MtcDsPEr/gJiQap79Js5SnW9nPCvuUCBdTjmKivKkKWOIG?=
 =?us-ascii?Q?aqwW2hOGyYVWt6AIhIMkJCwL4LWPtiobEnNfmJfvzOkxrz318HW/8ziJl7dx?=
 =?us-ascii?Q?pDljUbOgppaoavLPwIR76GVf6HtyfZjsi8o+zol9nEImnq20XrEsz729qi2E?=
 =?us-ascii?Q?O3+aL0jm1zS+AhDjhiP2mB2kqZYtGs8ub7VChM4ePaHe9eibi9C51HkGPAq0?=
 =?us-ascii?Q?0gpAsBVmiemI036D4WnCugJwefX9SS//B3zIhXFT30mOGVu7Z84DsxhN40Pl?=
 =?us-ascii?Q?LPaFkZZ1GbZ1Zakw0qOXyca74vQI7ZC8tWG7TlL5JsWhYcR+ZNcJR0wCMLV/?=
 =?us-ascii?Q?e84yjLbEcoK2iXo5dEczo7Fda8f8kiZ3fltZXPj0u+IiJbhG7dKNK5R5ktFV?=
 =?us-ascii?Q?C6BLE3WMePKZdqLnWi8xd4LUf+wQUTQvFg5VNjptxFQ9v2B2iVIh+GtcBxfb?=
 =?us-ascii?Q?mNxNLsaFYuUc5M2T8xk53V0UexiL6AmETHfCFK0D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0574e0a6-7ba0-456f-4a20-08dcc8a49afd
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5709.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 03:34:08.1990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uxkwkgUDcKR2rjWW5qAuxVSJSpraGNvRRyEhfOY13kTABLKHYPIEnxEF+r0JNNmKH2uYf3UbQNZ315LyzMbP9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6348

When a driver wants to get reset control and deassert it,this
helper will handle the return value of these function, also it
will register a devres so that when the device been detached, the
reset control will be assert.

Signed-off-by: Yuesong Li <liyuesong@vivo.com>
---
 include/linux/reset.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/reset.h b/include/linux/reset.h
index 514ddf003efc..d7e02968b63b 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -806,6 +806,35 @@ devm_reset_control_get_shared_by_index(struct device *dev, int index)
 	return __devm_reset_control_get(dev, NULL, index, true, false, false);
 }
 
+/**
+ * devm_reset_control_get_deassert - resource managed
+ * @dev: device to be reset by the controller
+ * @index: index of the reset controller
+ *
+ * A helper function to automatically handle return value of
+ * devm_reset_control_get_exclusive() and reset_control_deassert().
+ */
+static struct reset_control *devm_reset_control_get_deassert(
+			  struct device *dev, const char *id)
+{
+	int ret;
+	struct reset_control *reset;
+
+	reset = devm_reset_control_get_exclusive(dev, id);
+	if (IS_ERR(reset))
+		return reset;
+
+	ret = reset_control_deassert(reset);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = devm_add_action_or_reset(dev, (void *)reset_control_assert, (void *)reset);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return reset;
+}
+
 /*
  * TEMPORARY calls to use during transition:
  *
-- 
2.34.1


