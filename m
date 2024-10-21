Return-Path: <linux-kernel+bounces-373908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD2F9A5EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3C941F22566
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD301E231A;
	Mon, 21 Oct 2024 08:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="nFXWN16N"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022126.outbound.protection.outlook.com [40.107.200.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032941E2308;
	Mon, 21 Oct 2024 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729499861; cv=fail; b=QMi1h1YmhCkQXYmgPFFgx4+WnLT07ZisB5QZFi1R21RbFUruWb2MOHJZAa6mzI4M0YHg8XhnamANcWwL6B44mPCcaEmVpA8ibAlnPW3PaUgCOgJMOOzYR2MHvb0PW7XgbddxjHTPCaXgZqwyoWM1ZdeeRyxJU3HYrdG0T4+Pnnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729499861; c=relaxed/simple;
	bh=s9DYgY+ne9m4p5lGbcSORO/8I8asfFMtgCnhlepJwiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RiLMa4TkoJOBvSiyaQDjhR/M5ZJsEATKN53GVfz/fn6echW7cErB0tDzbDjRzDTkyoTkopYiov1EWcNcaMZaTleMY/Q43lUHqfg2h6r+jJOql5IT5gJd5g8XgAQsqVkFMtc6nCYNYioIvIe8HiDZy0xNhRLvpVU65dXdl5ospJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=nFXWN16N; arc=fail smtp.client-ip=40.107.200.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dE//4tnpilMZ+1JMuyHd1FT5s/GtEiZ3KaNArbeKAlUcezcNnlOMwl2RRNoo7GpSE4yo5FIHY8h+6iVlfRMLnzdYyreJWP89qeW3oKDjLLmbzXvYKKweM9brp5iymsZlgZQ9J2UziS0f9E2tqr0SjNndJPMUsv1yrJvZMRr1Q5bWx1rEWn48IHdzY3FYpvj192JOl2IAai8NJb1a/stTAM7exC84h+kFhhLbcHfllOfNKrV0rukvk9AtyWnmj60Fh++GtIFcB4sPtpOjRYIsCajpiJ73pkP8uLGbRv8lS0peHJCodMkmB73t7S0N7/xkWyRZM2NdPJMlubNudwEJMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0U8dp6df4kZBYYBsXzREG/5mXubnxqXc7SLQOI9djc=;
 b=hXk9qnzb6AfYami8A8/ECSpweDBDejJD4E/b73QGBRxGYvK8wTiPtqdB0ZEaw6t9Rp9446iVC0vy2VCGFklI8r0MTSV4HAUY0ABuIuWGn/8AUJX0oAJNb4VSzZxw3KbYm/+D2yTRnb4n/b4iyEjNFQygsZKvssLEGQnZkim5jfVgEiVjDdZ7lnbxacN8TecK7BqA0NxEPeW+exFVf80hXalAgIGmEtVcpWTRBqVMB2stZTxznDAPuipLIeaKNFPCdr/tzHF9oM/scH5bBp0pmsp/2D8ji0Udd+M1Dvnze2MaEsUOVUJS2AhrfHRl9xZsG5beHcLanbprQN2JkC7Q7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0U8dp6df4kZBYYBsXzREG/5mXubnxqXc7SLQOI9djc=;
 b=nFXWN16NWcQyKpACl+2sPn9KzTw/DF+LVzZGQ5SsZ+DkS024QjmLlGtDk/03ccIgOOuoN8lc5NFJJN1oOf0UwV3WSbI4Wgtg99nwv1rZVLp+nB/iy7q4+oGVxpfxmZkPz0eqiaoALT7JdU5X9CwYXV7ndSM6QhQZd63En8BYV9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BL3PR01MB7057.prod.exchangelabs.com (2603:10b6:208:35c::16) by
 SJ2PR01MB8049.prod.exchangelabs.com (2603:10b6:a03:4ce::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.20; Mon, 21 Oct 2024 08:37:36 +0000
Received: from BL3PR01MB7057.prod.exchangelabs.com
 ([fe80::b69e:5684:ed7c:4d09]) by BL3PR01MB7057.prod.exchangelabs.com
 ([fe80::b69e:5684:ed7c:4d09%4]) with mapi id 15.20.7982.033; Mon, 21 Oct 2024
 08:37:36 +0000
From: Chanh Nguyen <chanh@os.amperecomputing.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	OpenBMC Maillist <openbmc@lists.ozlabs.org>,
	Open Source Submission <patches@amperecomputing.com>
Cc: Phong Vo <phong@os.amperecomputing.com>,
	Thang Nguyen <thang@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Khanh Pham <khpham@amperecomputing.com>,
	Chanh Nguyen <chanh@os.amperecomputing.com>
Subject: [PATCH v2 1/2] dt-bindings: arm: aspeed: add Mt. Jefferson board
Date: Mon, 21 Oct 2024 08:37:01 +0000
Message-ID: <20241021083702.9734-2-chanh@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021083702.9734-1-chanh@os.amperecomputing.com>
References: <20241021083702.9734-1-chanh@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0181.apcprd06.prod.outlook.com (2603:1096:4:1::13)
 To BL3PR01MB7057.prod.exchangelabs.com (2603:10b6:208:35c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR01MB7057:EE_|SJ2PR01MB8049:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db63af8-a2ae-41c1-f59a-08dcf1ab9d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zAJn1Vd9ZEUZgvZeV5TTymiJ2aN0EOfEvb99tnLbcEL0OQ3QznVW807w4gop?=
 =?us-ascii?Q?xbV7xAOjHy4YdUvPkgSvYDzx+HkBRyj7vsJX5/OHfwfOXU7ayPBUblbxOltQ?=
 =?us-ascii?Q?DP/x5eltfEG13JIMYCf/k30lRsEIQ+PyIkoijrK9Iubf6ZgRDRirLqnORYuH?=
 =?us-ascii?Q?eAqSY2QmEANQm98S6N+jOwwKmP1w3TwNQYPxr0ybhKU2qq9Okm/mAQWBUZVt?=
 =?us-ascii?Q?TUJZVFTDBFqJqZoGmqlA9FGW/TVQ9YFME3lzMlQJJPiq+qfC9uvPkaKAOMmo?=
 =?us-ascii?Q?SeyzxVQgS6hqjwBgTFHDWnkcs5CcLEUE+83z2JG/vZhmvCuuGcAS9/ym6aTf?=
 =?us-ascii?Q?JpJuvGoe3cXo6ztNjz1WvzPt7XEWaTg1O5JYI8ZXemE3l+HJgTRy1SMjnm4h?=
 =?us-ascii?Q?rxNWiQyCIf17X1kiZjikIxroK4FDr0rSdJeP/AnvHxZekfPXlmrRt9ejyNvb?=
 =?us-ascii?Q?NHwCJtDxprq5Xhkn5Rl6Ka9HCxQ5FfAM/QiVUqujjAwnODn2ZMJA8guGk5ib?=
 =?us-ascii?Q?7xMxwXcrjew2WWLWD5XnajDqdL/74lM6guh4qdgiJkJHtWpRX+Anwh49rUjF?=
 =?us-ascii?Q?/TLfL8cXFEmGgjVylH45kT1ptxKHD2D/naPTEBJ+UmmtmJi6o/3J+M5dvxA/?=
 =?us-ascii?Q?GSpyNZ6D+1VD6EHg6SMlL56ysY0Ao4YbLts1XheLH+vPJgScG0FR+UhRYe5E?=
 =?us-ascii?Q?L/sZF3peGelqc6L3uk17dBjNbj47DFfEEN54zboEVFCAjaKqnyhf8KvUGlkz?=
 =?us-ascii?Q?sk4Uxnw0uBLi/N/mvD+iBE9AeTPBibHcG2djquqNDuf2HuEUjSlOeE6t/9V+?=
 =?us-ascii?Q?I2IK67WWnpKTt+U+ruL1ZDUyTJad767tqd0uAHrJvgjdXbb+EmjMVSRt9KH1?=
 =?us-ascii?Q?JWDCTGV37H6TtrBFge401WCfCZeke8wk/WlOlH8xAz99uza/Ex+khqkh2G9k?=
 =?us-ascii?Q?NwcAP5PkNjrTxRYs7bzyxhHjjraDVCZPiygIRT1zkVgbPih0bOq0VP74hXN4?=
 =?us-ascii?Q?VOaGxhXFDHq9zaTIr6iHu1dA3DwhuPkQTnDwJv+eR+uVNGIiTE3Iui4WrGXN?=
 =?us-ascii?Q?mgaj8CrjKcb4iWDIEzOJmfM2B8LjrWyF5lltUWBJr8Pc1tSol5Jz8BYpzsg4?=
 =?us-ascii?Q?7ClqX1QbKFEJsvbNOYu0ztoBXQ4JiH2HKhlG07tQffxkdHWMDtWN1r0caUrJ?=
 =?us-ascii?Q?v3qw5vA702Z2zz4/xz7OuI9/vAwHk5DPCk4vA7yjMdpX1AopzyL2DNpDccmb?=
 =?us-ascii?Q?+/mf8lZNPH6dOYXp8CH5t0cPil7hhG2ef8HfA2wqs2oW914VcuU/eu+Ptrmx?=
 =?us-ascii?Q?yySQ9+V4KhVU+ZuhjTuQnOJ7NvlgbWRcw+QEA5R97CBP/V6rTolQJyhiaVlm?=
 =?us-ascii?Q?JNI7cUz0wSdDYGCjWhiXdydkyKGN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR01MB7057.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GBsFoVm7/MwHIJBNMKM7uowJ5gAME8eYQ1ULBiukd/UCHiaEEOASsW/6WsXN?=
 =?us-ascii?Q?V370w3iFslId5VhHlSVafSRMcT654Uuus7U1pbiCDXAPpJJpFDtcSzmbIzFb?=
 =?us-ascii?Q?ufS7NAKJF6CdicRWptcb2zymr6PaoHjqQkz0FtlfTiUsnU9zDjwsbLJ0m0nG?=
 =?us-ascii?Q?llx3dkAjTxylsAU6Ass4bpD50I/ndZ9sT7LsFzX6Z642VHs26Qc9Fb/IyLta?=
 =?us-ascii?Q?lCmBWguoBs1yMJAW1jM3kxTA0Xk/UNPCzpbLGLoyhiaPK+BQKP82ek0MY5Lx?=
 =?us-ascii?Q?Mcbvtt9xuTUlAQ51WYwwciiSXr3sUw34f/q4y9SEKRdHvbD8m5E+43Si1+dg?=
 =?us-ascii?Q?NtpMdL86PmahRJDyQfhYIPUhjyi/wAjtHqpal9oAg0nZMvW4GwPuqKYB8teI?=
 =?us-ascii?Q?kcolL8Pl6uJ/KBS90bnDtnXCGG9Flw2fEE38AweKl8hkb8vhlaBKM4mtmTGi?=
 =?us-ascii?Q?/W7+Y8OpXsrnCF6MDSdZkPi7KFBE+UtIOpsEo4hUGVlVVpg+4VIXY9KooLxK?=
 =?us-ascii?Q?NA5bq51wfdOTckW4RSIqrLRf81Ov5is7lXkuQQNmkUHNXl5O4y6BALZ/eCaf?=
 =?us-ascii?Q?bgQgTZGJmU29wKZMY/O2rhT+0G/8h7NDduUYikyVdIOpTVFoy5tA3cTgrRQk?=
 =?us-ascii?Q?7OfMLVM1VCHL9OKsdpe6OsHtTrR0PEwg4mWBZcM+SWG1UC1/tEBjvFMS2fCl?=
 =?us-ascii?Q?fOpeU1/75OLXfSkFjJJbe2ryzgKyyw/ZMtaUhvjNfwwt0v1ruiP2qfMKnBP5?=
 =?us-ascii?Q?0Mcwtnhq4kZTnS3YCcujeUqjEJ7NxMU+rYgWk7TmBaAPKbZ+DsGkkCTrfJLD?=
 =?us-ascii?Q?2NwfPW1PhZGEwYj3Ug/Cn5C2Rz56Oa34sH258EqOwpHD+R17s2h7E000smJZ?=
 =?us-ascii?Q?+I6v2UQgINNJWfNWsDmSu4b/QgUFRaK/NJdnr4j1P9uaAS8TvP9azBETGK9j?=
 =?us-ascii?Q?V/6ym24olgBh4cddMygHsf6dMdOY5NZ48ZxdNHTTXBeD41mgtWanI26Wyr05?=
 =?us-ascii?Q?Icp1xU56pN/SxjO2dOaIGc0HXd8Plqlfkua3iVGKSgt3HMqrkgvjtXVkeBq1?=
 =?us-ascii?Q?3yaAhQrYhqF0RA4YKGq2zZxXGd7o54BZuc3n+Jpwu2WbgbZAIedKjJnU82uq?=
 =?us-ascii?Q?JLTalkKFcErr/7DW1BYYjiEqotOFM5DX3e+rP5xG1N9MlxVQVX3F6lZTXp9f?=
 =?us-ascii?Q?hfWhcI8vkzIOF2106ku054PSP0eFV9FZbyqMtbixURGEzdx1JoKjkqI0wgIO?=
 =?us-ascii?Q?VkShK5w9up47NjilQVvYSSligM3U0g/UZqVqv3cQsPoQQw1XbrpFD9IcNaR2?=
 =?us-ascii?Q?ZJTGl4+fdk3hiPziM2OKgAt+PkTLTf/99BT0GwOogAg47NHyfW1wjWLu2nxN?=
 =?us-ascii?Q?3bNKpd3yC0MstcHgcBZQhjzlGNgLzRl8DZXcfMXkBWz5PDbn0C/hZaxf+tlH?=
 =?us-ascii?Q?3UtOxB1J2soMVHjKAaMbhmsJM2+TzsVOiFBsOAt1QN2mfHT0FmU6yhlYVncc?=
 =?us-ascii?Q?74WwbfnOCDph+sVhzQa09uPkJAYilZw/dVqvv4QzroXeVwOq5oJGaqUprRjd?=
 =?us-ascii?Q?s+PcdSdeJ8SKj6PWxiMYazlTMHGyq8XCgP2uOk4Xq4vcQRbXc8cQBhSUvGmU?=
 =?us-ascii?Q?I2uT3CKULPfEVqeoW6P3WuQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db63af8-a2ae-41c1-f59a-08dcf1ab9d67
X-MS-Exchange-CrossTenant-AuthSource: BL3PR01MB7057.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 08:37:36.6727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bk2v+SgPV35JYOjbXGe5gAi4DdVhQ2aOc/otbDorTrrB2GvNpjXtBwXtiOBcs0kErW0QHByYXnkYiGDGTbODNyOg88JSpFCewC02xX77xNCJCEBgcQIn5dHxAUeeOyVr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8049

Document Ampere's Mt. Jefferson BMC board compatible.

Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
---
Changes in v2:
  - Document Mt. Jefferson board compatible                   [Krzysztof]
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 2f92b8ab08fa..65bf8a161348 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -74,6 +74,7 @@ properties:
       - description: AST2600 based boards
         items:
           - enum:
+              - ampere,mtjefferson-bmc
               - ampere,mtmitchell-bmc
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
-- 
2.43.0


