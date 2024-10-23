Return-Path: <linux-kernel+bounces-377238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8B89ABBD1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 04:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84EEB1C20B69
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 02:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5989213665A;
	Wed, 23 Oct 2024 02:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TlbwYwLi"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2069.outbound.protection.outlook.com [40.107.105.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7A3132132;
	Wed, 23 Oct 2024 02:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729651651; cv=fail; b=A1TdVwrU5q1PP+y6R6rRQsJxYNPzfDrgD3QYZkMbT+XKfGJc6mn8ODkyL6hBFUy0WwIf4dVNHPtSYNo6rlvnlforYW/b5aq5F9e9czsDOufLejTrXUO6gZfgNfb8r7liEHmafUWM08pA7b2Jf6qWL38olhj37hWdNfGKmZ1PlsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729651651; c=relaxed/simple;
	bh=kox4S0U50cg+oceZbn73PPi7fpT//cYbkBaA5hfu9nU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M4uWoQJ1ql7Bqea6lCGT3fRbEMVxR7FZYmjc44qnRLRuHuHIBWL+JRS0nVP/YtPA45zjd7lf9rsU9vMcVHW5nAKrmqAVZW1LEcWE4JxR5Ynl6WCoOV5uw0+0Nx8SxIStW7lm+9/ymXGhFGaguGta7ddVSGd0GAtZJI8tBDRMu7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TlbwYwLi; arc=fail smtp.client-ip=40.107.105.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7YWoYyqcczTaMu7g2qArSqZBvV1Ry290kF7vF9A3g0XYUmEpcsFpxW3PJKh7mJ9XHhA6m1LiVbJMn76Y2TXonbhlCbsa9pR0lNJxHkt/3E6jjU2q9mOmYKy9pGXi2Zx77fcLw8BnDLIOMFfr7qdOc9eR6RgtV47po5f2dtDIB67ZTPCtkb5TKTxY53puunQezM44iYt/XP03rhmvFDC7HcToJ9gRC+tEJawbePTkRTAQG8PjkO4UFtpoGp+wBM1jBMhr5qWM42btLNNknJ4RF2t2p93rTEEzo7VnYYfLawv0+01+vmMcCI6y1QVHdmgrZbiVa8CMM4Bul+nthqqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGOreLL6v3FxwLAj80VblzRDR94u9mUNZuVBNQCURjA=;
 b=h4rPXU93lEpBV8ZopEgJUNNrqf6KcJkg2TXbPJPoipTBNRZtlImwmZE8lGGeAhMJBMDQ9tQZ3NqbIYox9jJgWH1SAMFwIJHdV+i+ejTtprtmV4JmXQ0u3keHt7JYVBkabLnlDuf4j3sDUbZmp0bcqg4lscTs1ESlgxAv23CeYCAV+dGRpTeeL0u8Jgc21KxUuQ1ntj8rz5V5TDQtB1U/nCT6AlksYrW+ZKzsOPRzx5zsByb57tlLMOyvRI9cRax7/Sx3n0qYZduksCoVcLhSBfnmTH8lffwC2SDoJSymf4V+Jo2eUxstBsB+peDZ2kAf1miS2kPGRJs45tPdWxdBtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGOreLL6v3FxwLAj80VblzRDR94u9mUNZuVBNQCURjA=;
 b=TlbwYwLiJ35klQwwAa14TM46m987OAVx1dERVjuhcjSYheb9hqMc7kDFJ5dG4CilTo8ZWxEEdl9VFBiv6KkqLTRC6x8luvxPnaJJS+duUVy2unJPyDvQaztN+Xg376eQHbViSTHFQZNQLBHcUCNnhvtdD9KZBR17An0bDntyQBMsCU/5N45Lyrflfg+LPWGgke2XaBNdTUwhLi5yN+p94rZynAjsJb5dcpovd1ek8yd80kY5svY979QookPkdRHHovMzpNkm3pwT1elFbH6h1T3hbO5e4RMR41Bp10ptEtvuwZyx4kwC5wytCb4n5lWYfn37jQLwayJ2ULUG5wXYCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by GV1PR04MB9216.eurprd04.prod.outlook.com (2603:10a6:150:2b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 23 Oct
 2024 02:47:27 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%6]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 02:47:27 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: krzk+dt@kernel.org,
	robh@kernel.org,
	abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	peng.fan@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/4] dt-bindings: clock: imx93: Drop IMX93_CLK_END macro definition
Date: Wed, 23 Oct 2024 11:46:48 -0700
Message-Id: <20241023184651.381265-3-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023184651.381265-1-pengfei.li_1@nxp.com>
References: <20241023184651.381265-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0118.apcprd03.prod.outlook.com
 (2603:1096:4:91::22) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|GV1PR04MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: 1240707e-3f78-486d-7e61-08dcf30d078b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GMPDKcAVwJtMhj9UZmICx/k8GCMRY3w4tmZ++Gr+BMJqlK9X1QbzfYfVzdO1?=
 =?us-ascii?Q?hiSOXgSwHkZEELkWsiaVHdUI3b+3bHkjUG/kXUNKCGZG/h09XbtokiYyDAKa?=
 =?us-ascii?Q?OKLW8hGfUxBjaUeQ5OBMTBpKNPf1J+srjO1KuNW6ZWPPF9fvKlqbNc6bK89o?=
 =?us-ascii?Q?D8HYw4cpcLmZs25uP7xOwGO/i9SqRbj36UJyTlHwEYksmWYRH/fa4mvkI0H4?=
 =?us-ascii?Q?aY3+P9tRC0c96p3XAWAKqMucAdNDtCZRm/cD8SUi1Z3Ac6L4yWxhLr9pb982?=
 =?us-ascii?Q?zRXBinlaevGiv+7Cv6NdP1VmRoybuDDSjENmTL2awaHOCH7NlpEEZxulN3w+?=
 =?us-ascii?Q?Gtz2g2/FdMbkImCKJQkqgdcp4lo9lFxXxnhmv0Zq6hBThL8bNEfwfn95hlFr?=
 =?us-ascii?Q?Df27eGwMinyqVoUF6oyReCZSXlG4Y+jKwQEa8w+Y8RFpq3kHaWB84e+nJS1v?=
 =?us-ascii?Q?PAgiIiCIouIw3hGv/ETpHoWkka6YS3mPtgY+9WAlFrAFDauWviRoHg+kLcg1?=
 =?us-ascii?Q?sloEQtn1SB+6DodZti1Wq157d1FX24DUIy/ebWq9gc9h/QqLNyl6IRBDeL72?=
 =?us-ascii?Q?J35HzFViDG8Lup3mgnVXTjPNeqt2pNYfxQRPf1nA2DMhAjg21Rr2sza9dbb7?=
 =?us-ascii?Q?OjIggVBhdvblXwNwBzVw5nckNho8eqc7qqcY5RYR1ypferg7S8hyzvWJlN9/?=
 =?us-ascii?Q?AAyJYoIuFudKdKDCXWBD8DcfxaDDD7+HfBpvJpK5+UQRNd8QXc+CEqY2G3uP?=
 =?us-ascii?Q?UxZl/cB8uDIY97VIYfX59vVoBt8l6T62ggd2noUpK5DQ8VaQfuW8SlBjE4oD?=
 =?us-ascii?Q?DN2v2O8vbec7A2tgYakC77vcYSc80jvjev1BSgD4aLXRRf7FwNhl5ZobGFgW?=
 =?us-ascii?Q?q74Y2dg1kGSfIMT633a/T2qSXUQaFW5leXi66cXv8CHIskFxv6F4zt1d13y5?=
 =?us-ascii?Q?VEo5fDq+wL2UsByhO46GkC70/yiNh9RgMroMbQkbQhe5zvwdRKnjHo32BCS0?=
 =?us-ascii?Q?pZ0lOfYizyPcfqiCrzXSJbBQiYOOYF4vwf6/5y4wHSO8I+ddNhg1+Xaa1zKw?=
 =?us-ascii?Q?l+hrApLrw91xs5mSw4ihc3+PS3AknzEesgWJ2+X2ny82K0vmXJRrU5KqOZcy?=
 =?us-ascii?Q?IY6yPN3VxIK/qejpOPy6kh7PgUhkYcUM2ve7kgoEAHYoBDq+ykl/FEsnVMlu?=
 =?us-ascii?Q?wiU3SnZsOkmjJOFsTyG/2touNNxkfUGQzTNaC/WRY6c3fkahEIpLGDz9amg0?=
 =?us-ascii?Q?rpqVU6LoUUbUyersYCaun3N/+nAXGCtdygbAwduI32fQO+fwLNN3PIrpaEPI?=
 =?us-ascii?Q?pG0Y7hwifwgKLejlG6dGO49m2oM95JyQfInGeSDLQJNSPeZZmgnHqFPIIs8K?=
 =?us-ascii?Q?2vUpX/Id3ShAHXIORujN2h4fsmmx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nxWZRkyZeuXLoj/OPZc8VXP2EuntUoSqKFHQ9D9yXlMIgvD4P5ilDhkBNqXu?=
 =?us-ascii?Q?mCmrGzhDRbnv3Edcdtx6+lHW2kkf2ofK+fz7pO4EAwT2GYGDeH6me4gb1EEr?=
 =?us-ascii?Q?Pco3aIAGJh7Swl8+YAZH6laPoGdrcEUDQ1F7gZnubHpp00UnSo2qnxS8J0Ve?=
 =?us-ascii?Q?k2BWyRXVg8u//5QVIelhE+l3GE5K7T4QRk0Vjgt31vnmjxHQu0VY4uDPlxF8?=
 =?us-ascii?Q?0QH3vlA1D2s+cw18nY+h9bzt542lcXQ6MxqZuofrxxEhXkBuSQNnd0IMRJuy?=
 =?us-ascii?Q?RBCz4mPZe9Hu5c9fA9wxP6VwMb5QSkqXq8NqPtDZXXtXbv+lR/ylyRbnORhh?=
 =?us-ascii?Q?TXFINwGZTb9i1YDWVQP0JKfKBNL54HhOvmiD8rlMjTh5ZiHTAY0oF8yhx2P+?=
 =?us-ascii?Q?Ky0zxYiEuB3sspf2jXTs8EeKAsq97ZhkRSIyjRyXcD7DLNd8HEA/VAIcFIoR?=
 =?us-ascii?Q?ISs2zHz2K4JrYuM0dtHtc1XtCB1qIvx4RCv+iDreesebU0URkMdIfPArFkx6?=
 =?us-ascii?Q?g7pv8sjjXY7AOs8HRuORqCt+Vf2nQhiy5iW9Owh0mbXKmZB8HE82xv8hVVBp?=
 =?us-ascii?Q?Ris0TZBxWRZJLTtEH+MyzzN63ApPMiYm0GeM9hyLiBxehU2Ze3Tq7HdwP/tB?=
 =?us-ascii?Q?LpRXDAN/zG7gvIrPuCDDWKUEYJTmexeNgDb8RrtC8tMURyeqCZBSyxdgqQk+?=
 =?us-ascii?Q?6IlqbyoLpFoMw27SrYWMcswyVtEaUpO1fKdgPvlrhYEvk2NUOjfrB7W4f9sK?=
 =?us-ascii?Q?ICP3ZslmqHLWOl+bURCxaa2IQrWgCQkuwdld139Jfc7xM4+iUq0nNDBeSKYd?=
 =?us-ascii?Q?499xstw0OuaXV6f2go2dV2UhWjFeAXPIdqeg4MHNsLfzP8YDAAEcD7nXz+rw?=
 =?us-ascii?Q?b3L41OUP/evTzvXrTekzYAt3cshMH2QFHfG0vHKkfMO3iszLxEmevaDrT5EG?=
 =?us-ascii?Q?eFNGEa2NT3r9sQS6R7K497MV2UExgCZ8o+StVkKrwJDXGWRd79twdeHjJ+y1?=
 =?us-ascii?Q?/+c1+YfP0JcUfytINV6cvh0dpyr6PiqFMDZIEbqo1Icv3EDE8AlR44X/02U9?=
 =?us-ascii?Q?idpxmskTpB3C7u5FMdijT+IYVdNHwQGdx0p3PdDmgGAsoUnc6eL8vq81vQQk?=
 =?us-ascii?Q?kNlhnyF+yVaqlYKr4iyQcEYUbmIGMCPJ3Idxf27nzPMFX7L5hxSK7vcPFBmQ?=
 =?us-ascii?Q?+17An51S7x+DHpDHWMkuH0a69q4suit7PT3+qMI2Vfv5kW61CXG25C21epWk?=
 =?us-ascii?Q?pf1YiDMN8HeFtNWxcF7e8QhirorLW3vKCKAUtcPFXio6la+Pds8xWBAt3Gp1?=
 =?us-ascii?Q?F4yd4oVlOSx+exqTjCcjE24KIL9NaDaZ+CmpVWSzZealSk0W28ckmwkiJCh4?=
 =?us-ascii?Q?LL/R6r1C4s+La32N3y0HwqSnsvFGl3fXXcsQDWEus9ih06otQR4lBVy5lgSF?=
 =?us-ascii?Q?Zbor2zGShbNPYTqNOSfakfKrf/2h4ToVOaq20SnmSuKb0lCJStvREWvFMZ/U?=
 =?us-ascii?Q?jP823GW8ZPDHJURurbNgXODEfxAW/rHwjHjgW0A9PBJT8OVNo0+wSmdc9P7N?=
 =?us-ascii?Q?KT3hk773D+AItTz/4cskUaWVrfl3aKflNrSdsTfU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1240707e-3f78-486d-7e61-08dcf30d078b
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 02:47:26.9483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixUADuck+//zxeQHrD5s2L8lfxDFEtCZFxCueZYEUaV2pveK/FmFCCwRKulC9Gn5U9seyUkCnPIszuNv2KmOMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9216

IMX93_CLK_END should be dropped as it is not part of the ABI.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/dt-bindings/clock/imx93-clock.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
index 787c9e74dc96..a1d0b326bb6b 100644
--- a/include/dt-bindings/clock/imx93-clock.h
+++ b/include/dt-bindings/clock/imx93-clock.h
@@ -204,6 +204,5 @@
 #define IMX93_CLK_A55_SEL		199
 #define IMX93_CLK_A55_CORE		200
 #define IMX93_CLK_PDM_IPG		201
-#define IMX93_CLK_END			202
 
 #endif
-- 
2.34.1


