Return-Path: <linux-kernel+bounces-233253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F05E91B4DA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 04:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF741F21D28
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F2517565;
	Fri, 28 Jun 2024 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="P27wlGCe"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2063.outbound.protection.outlook.com [40.107.241.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF6F23A8;
	Fri, 28 Jun 2024 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719540034; cv=fail; b=Chd3WQ3tKO/eYiNcMElUN3JmUSBjrCoijv7u/b8c2Zdpdnv0gfeMtrpqEFCGA/8xKL61wFsaEBnOSzc6xbh/VF/P9E3Zc0cgJJuy5JszuuWyZHSfx9utB5jbRvxuxI9oqvZ2ycxiZaVCl5fw+h7DdqeN2QGiaZ+e3+Dm2BVmBQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719540034; c=relaxed/simple;
	bh=DGBRAJZo3H/rK0SUc6tQAbIBC43H7m/MsxaahCOD6zs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nEsiqHv0uAWwl+Zo+Y8XWFiJhv3ioFvYECX01u1QuUdUFYYMBQFLjsJlgrmBCisqQUBHq1SDqKKx25PBD0wSAF9C3NQkzwa1J8Dxhopui3nE+3/kCGBzRHyUdiTAGlInsijXQiCbYo+WrwnHXY+KiZSoE3x7sV6nI9arPGKaJAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=P27wlGCe; arc=fail smtp.client-ip=40.107.241.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5Ctej0uqysIYP01I0tpr7I6GaCfv/pHtE+xblMccPQ2Qd5cQmm7GPcBjpTlXCXxpxi1xO6/gtRxXKDPvW9S4PkQFFQPXXKeNVy6aEz00K+nYChHl3PKsbU3+iKN6iLlV/1CvTie09xFfQnLOSbbBMJGikNELseCzNrEe6wyTwXe/rJGfGf/2vAXeIJJ4IOkfvNs3HSuyEOw5ySrZp6ZlAMOxS4KPrvtvbFlRjW3SFSmhQBrJxSCs5UixZ64gmL+2220LMU5bhLDk1Ke0K80nQUzVO6bVuu8jVtG87aC0c7G5muEavlLAOS077dn5hK69NVVoleWpl11kJ+DhwRVfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcBmpoiskpzFCiTWl2xFgsLRPshbIG8f3BoCTCm6cmc=;
 b=OKZiVyrv+kAT34hgKjcdVupBGKZM2p4VmMz8MY2c6EBg77bJCewTcYKPNdExKCbBi3RhtjdC/vb7j7ttEIAR338vuEfIqQcTvTpju6vX66XJ7QefdoVunsJc8gfXQKWfJl7+TGicACFYCNUygwYcHUklUsmyvqKsJSSi9W8Dy4TrkIXRfMJG6V/YEwuf5AxrYGN65X7K2ladYGNeDf161I6vwRc+HGsDMv7Ok9bN+WQNPkBUSQ40ui0hyeupxXKhFQ3+xF+6Dgc/9y9id3XArHBP2IISKEqTMBCK+yOYaGPOFIuC424RziNCC09ZFr1yUxRV4r9MmSb+Hj6sx0sF6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcBmpoiskpzFCiTWl2xFgsLRPshbIG8f3BoCTCm6cmc=;
 b=P27wlGCeerk1eAcqDgPUSRJ9FKF1acDaq5iuvb0Eto2RmUROvsAM7lDPjl3APZcBajet6eEJSsjbcnaHyPg7ElLrDh6gq0wV58JHKzLl7HIsGnU5QANuRxjR4/ZroEmrwZBcGfsaDsPoUgGFJa3/1BXfbmiFcYJhmDGZDownC90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by VI2PR04MB10618.eurprd04.prod.outlook.com (2603:10a6:800:27d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Fri, 28 Jun
 2024 02:00:27 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 02:00:26 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] arm64: dts: imx95: add p2a reply channel
Date: Fri, 28 Jun 2024 10:09:21 +0800
Message-Id: <20240628020921.1108888-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30)
 To AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|VI2PR04MB10618:EE_
X-MS-Office365-Filtering-Correlation-Id: 465d20ae-691e-4ac1-cfe4-08dc97161442
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MwTUaI/FuUq6Dsv4S8vOWjR7FxAMzcfxzcvEArOUXnxjMFQOXnLOfJqKTFtl?=
 =?us-ascii?Q?GFQ07SMk0Hi3eAqBvJD3HzQ/lUWv4zVKuRtMG/XUO3Wo6uULIZeyNTQe2lv2?=
 =?us-ascii?Q?8WLIT39abdZHFGMvj968DqTW+7kp8Z3BoJpKw+PE8MxaN7+FcDqmrrb7VITQ?=
 =?us-ascii?Q?eJMdeQOVpX7eMKBIaAQYg6uMg9s6POT63nVd3bqV2U2WOHHESOveiai2EClV?=
 =?us-ascii?Q?LOMrkgr2fdDPPuI+eJ6P1xUgNI/TgevNRND+p+K9qg8l3zL/Hps3oxyfBUkY?=
 =?us-ascii?Q?OoSowvMmDVf8ycaPjFO32FMoioL/TkXWPZFYzreHWav44jul8WoxECYcL6LC?=
 =?us-ascii?Q?MDt0wlrOx2lM8XxPmU3723QjPT6IpE9tGtkJRUtTPKMtngf+36gL7fUT/+nZ?=
 =?us-ascii?Q?R508L/nsfzhyD8YSGboUSKCiyc4bjVLL/Nv3MdEcmqS9hv8Wz1ZKlBhnSN10?=
 =?us-ascii?Q?gm1bXIkD3kuIg1d+Q4MiJ+SdnU76C/BBZMNgwoHBHTr8ABpSojxPKhBn7fHc?=
 =?us-ascii?Q?FpWbd1nWhmNYMYuBvg63Ls3Dzp39S3Xv5ham/W2YyvKCUBv1Wcy9umYCHblO?=
 =?us-ascii?Q?ZDBqnAuJvlDwPbIbfjGU9gQmd+7Qh8l7zeTr0RkTUcWzgPa7X34o0uyazgb+?=
 =?us-ascii?Q?eUA58MSh9C6t/fd/LHMAWM4CCoPcZAclLb7PVRZ8skAij4XWP29ZdTYRBiWX?=
 =?us-ascii?Q?hPSdWqE7NMdGge1B5/n7zYSZ3nzj+j5Dvg132nxMSvqk3W31E/KvjX9Acqnd?=
 =?us-ascii?Q?V8nI0vM8yVy4KS/arf3vy7QciqfFWrPwnkAqyipU9fxN+rWbtiVO+ctwF8+d?=
 =?us-ascii?Q?i1a722Q9CYrtAoAAFJP6rKEFS93e/0MRlFgLWDgWjSNW/0y+fNcsGMmwEdbC?=
 =?us-ascii?Q?EUE/GjzLJ7kvvudXp+v4QC00ItZIfS+vvhHGmiHYeLw4Te7K7ZKB+Th0bfZO?=
 =?us-ascii?Q?X0yLfEz22dow9bUYn8SzQWvsLoEUl5rpANs9iCYKaBSYx7V4MqHV+AkIUS/h?=
 =?us-ascii?Q?095YMcq7JiswH8oRYJOL0W/E5U9lkuqdep/YvlCo0vHiFpAehqZhN93TYovm?=
 =?us-ascii?Q?HkNKdNFnwubrJ11nVn8Heq+S92QwPOjXwrdcxwnT4pS0AHLUC/3c+465eabs?=
 =?us-ascii?Q?t+/BPyX7beslK8nrvVTZyOL8PpXkdpJ4a/jBKTxj7ILqoYOotnkDkDPg9TIx?=
 =?us-ascii?Q?HTCh/5Zdrn9krutGEqdYUSwfR3iJXxlAKh4esHEUhA7jmYe3WcZ99E4YNWLs?=
 =?us-ascii?Q?t8s3uFIG2rcBeHgK56rY+fY6q0O8z5srfZ6MCoRbqBjfpx70YavTGxUVGzve?=
 =?us-ascii?Q?zEDeZyBR6eI4rPWhQL22BJhqyo6DcB4yS12YNwn07DQ8McURGPJ8VAZ7ktbS?=
 =?us-ascii?Q?yEr3QnrI4mM+/YfJc4u3S5A0AQ8JXtcOXuDSsmSkwUgGat7VMA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iDPk+tUzOmullGkTg57CXIqntygT4aKB9ZahigIKY0iQHeDKKOfYi6kWHbsx?=
 =?us-ascii?Q?eRQBTuvyKDbnsXQKoMnOiio/ChL7nxFOUIYFR12Xz/V++Lji5tBwQqHQhhSd?=
 =?us-ascii?Q?wsdSEMA0zFBsK6u8jEV44P45RicvnKiXZEZo/fQ0tqw2mQAZ5d0yVaz7pip4?=
 =?us-ascii?Q?kgxoXXUXP2gQDXd7OdPG52o3oRunHx5LxJ5e3Xg+FMq++dOKqCCqn4U3suO5?=
 =?us-ascii?Q?PMv+eRMwooJY5s/7p4xmcrStfUvpNNT8/YSh/4MSrsmsYlW+LR1Co5ujP1S+?=
 =?us-ascii?Q?UXZ5XzhPt2H3xT8XAnXg7dV8Lh55byABXAV8mMu0f79nNZHAe0fvDa3uQ7o0?=
 =?us-ascii?Q?68ZwrcxJ4sW4SelowDHZyVn19J/MKBy/dNbXwJ0AjI+dr3bDaZ4RCRnnUhu4?=
 =?us-ascii?Q?8OJdDE6/NJgEb0HC6+YNCe2tT93Rlu4FkYAI94qor9I1PjK6/xQ/gIVcnucT?=
 =?us-ascii?Q?OePJsd95aKtk7a1IjxlgUD577VnK3ddQyuLUu+9nLBALzozuA7/aY8hQ3Voi?=
 =?us-ascii?Q?1qjONmf39uwTrDE9Nq088bqKi/73TkFFHFYL9tvOAmEmHRaC+FhRZ06foh3C?=
 =?us-ascii?Q?HHafeGw2HMXHCZU2XsxPSWdvwLZEKKFQoMqGMVI6sBFegA4MY1Bk5WyobnoD?=
 =?us-ascii?Q?OPrzQwx1nyq7yirZpxwT614/RSeKsjCh5qEwEuqZtYJKjlkzFvKlXaRtHNLJ?=
 =?us-ascii?Q?0Jypxr8ob9sIZbcERhctvPjl/bm1hngDYyS6U177pSVMgiSsuVvfGBydI25G?=
 =?us-ascii?Q?uqNrh4/lcuqzFawlx+wyUaVUP8m3W+cbmCqwjk4KZKgzTsIcr6tYypDRvCNb?=
 =?us-ascii?Q?ywvtAXlAPBgbVgcMC8iu1yGyH0smhDnVmJkq5CUzkXVTqqBxOSRYz2NbS18F?=
 =?us-ascii?Q?OVOGzku7y13dAZJbqSEsLiXyn87QbYbq6+KPDga0o4jT3IxmwqAHl0MA51Yh?=
 =?us-ascii?Q?AORBI4YUt+dJiNf5ha5y/LacT5/Lvs4Iv7xOXuDmr4uV2C4M1Jvuethwguzf?=
 =?us-ascii?Q?jXNT38xLbIQouMvjaGd/t1MM9UYv3uodBCU9Mjn3rsNA8rehrrcdRsrtImhC?=
 =?us-ascii?Q?mlTksiK0b2LYwpHXFNsmMUVKXCosjnyIxhG4vY5Qu6h6i/plJIqSjjns1v1E?=
 =?us-ascii?Q?A1WuEuc7RCe/a1JBrHr4V90qz9SV0ELO3OZsJcg1OWGnRw23zcjm3Wqm6hSy?=
 =?us-ascii?Q?z3z9ZxLUGCnh71Ehjf/6GWpC/AwSCaa/PfbIonW3SsMigdHOIYiUVL4k+0he?=
 =?us-ascii?Q?a9eg27aVTOQ7iBy9/MxWZFfigcdDtkJDdgth4mpNpk4BdlbSS/1bA/Saac6Z?=
 =?us-ascii?Q?viWn2+GySD2hR8oEeixJzSM8rlg05cfAquV0NwShZ/qw8Pz3pUVBmlNCOM+U?=
 =?us-ascii?Q?uVfYzjGILwaCL0K3Sx+YvyqEj3Vrsxyo9hLfBAsxU+KZ3SslssDpCYsxZAOB?=
 =?us-ascii?Q?Dk/Xc2rHTPhZpONEL+2N5Q0BhAOlXml3TcATDZJOVaAVqn2qb7nJ3lTF5LBl?=
 =?us-ascii?Q?SEVEF1DFaH4s3JSPSv/nGZB0w8WJltKHzE+EXsDVCdbc3sIOLIFCnDlKc06D?=
 =?us-ascii?Q?uw9AuKMLocCIbRsVyEk5uANA9p/cnuEiK6qfAl2I?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465d20ae-691e-4ac1-cfe4-08dc97161442
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 02:00:26.9337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5SxCKHott1fMhNbkE7S4+XxO9umXoRfhHh5d8sAqzwHmfJy8tHFs6O+JvubQATbk5IVhnLV2fgWacN4ThzenWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10618

From: Peng Fan <peng.fan@nxp.com>

For Platform to Agent(p2a) notification, i.MX95 System Manager(SM)
firmware requires a reply communication. So add mailbox channel for
p2a reply communication.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

v2:
 Just resend with maillist included

 arch/arm64/boot/dts/freescale/imx95.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index f98cec944eee..8127ed2beb1f 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -281,7 +281,7 @@ sram1: sram@204c0000 {
 	firmware {
 		scmi {
 			compatible = "arm,scmi";
-			mboxes = <&mu2 5 0>, <&mu2 3 0>, <&mu2 3 1>;
+			mboxes = <&mu2 5 0>, <&mu2 3 0>, <&mu2 3 1>, <&mu2 5 1>;
 			shmem = <&scmi_buf0>, <&scmi_buf1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.37.1


